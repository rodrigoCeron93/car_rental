

from sqlalchemy import create_engine
import pandas as pd

my_conn = create_engine('mysql://{0}:{1}@{2}:{3}/{4}'.format("root", "admin", "localhost", "3306","carrental"))


def rental():
    query = "select user_id,rental_date,delivery_date,branch_office,payment_method_id,fare,damage_fee,car_id,number from rental"
    rental_data = pd.read_sql(query,my_conn)
  
    return rental_data

def car():
    query = "select car_id,car_type_id,year,model,expedition,capacity,branch_office_id from car"
    car_data = pd.read_sql(query,my_conn)
    
    return car_data

def car_type():
    query = "select car_type_id,description_us,description_es from lu_car_type"
    car_type_data = pd.read_sql(query,my_conn)
    
    return car_type_data

def branch_office():
    query = "select branch_office_id,code,name,address_1,address_2,cp,city,state from branch_office"
    branch_office_info=pd.read_sql(query,my_conn)
    return branch_office_info   


if __name__ == "__main__":
    #extraction
    rental_info = rental()
    car_info =car()
    car_type_info =car_type()
    branch_office_info=branch_office()
    
    #transformation
    branch_office_info["address_complete_1"]=branch_office_info["name"]+" "+branch_office_info["address_1"]+" "+branch_office_info["cp"].astype("str")+" "+branch_office_info["city"]+" "+branch_office_info["state"]
    branch_office_info["address_complete_2"]=branch_office_info["name"]+" "+branch_office_info["address_1"]+" "+branch_office_info["cp"].astype("str")+" "+branch_office_info["city"]+" "+branch_office_info["state"]
    rental_info["rental_time"] = (rental_info["delivery_date"]-rental_info["rental_date"]).dt.days.astype('int16')
    
    most_rental_car = rental_info.groupby(["car_id"])["car_id","rental_time","fare","damage_fee"].agg(["count","mean"]).reset_index()
    most_rental_car.columns= most_rental_car.columns.get_level_values(0) + '_' +  most_rental_car.columns.get_level_values(1)
    most_rental_car=most_rental_car.drop(['rental_time_count', 'car_id_mean',"fare_count","damage_fee_count"], axis=1)
    most_rental_car.rename(columns = {'car_id_':'car_id'}, inplace = True)
    
    rental_car_info=most_rental_car.merge(car_info, on="car_id", how='left')
    rental_car_type_info=rental_car_info.merge(car_type_info, on='car_type_id', how='left')
    branch_office_rental_car_type_info=rental_car_type_info.merge(branch_office_info, on='branch_office_id', how='left')
    branch_office_rental_car_type_info=branch_office_rental_car_type_info.drop(['car_type_id', 'branch_office_id'], axis=1)
    
    #load
    branch_office_rental_car_type_info.to_sql(con=my_conn, name='car_rental', index=False, if_exists='replace')
    

