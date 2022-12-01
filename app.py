import streamlit as st
from streamlit_option_menu import option_menu
import pandas as pd
from custom_query import custom_query
from database import *
from PIL import Image
from bookticket import book_ticket
st.title("Movieflix")


def admin():
    menu = ["movie", "Customers", "Bookings", "About"]
    choice = st.sidebar.selectbox("Menu", menu)



    ## Movie
    if choice == "movie":

        menu = ["Add", "View", "Update", "Delete"]
        choice = st.sidebar.selectbox("Menu", menu)
        if choice == "Add":

            st.subheader("Add movies")

            col1, col2 = st.columns(2)

            with col1:
                movie_id = st.text_area("Enter the Movie ID")
                movie_name = st.text_area("Enter the Movie Name")
                language = st.text_area("Enter the Language")
                genre = st.text_area("Enter the Genre")
            with col2:
                duration = st.text_area("Enter the Duration")
                pg_rating = st.text_area("Enter the pg-rating")

            if st.button("Add movie"):
                movie_add_data(movie_id,movie_name,language,genre,duration,pg_rating)
                st.success("Successfully Added Data")
        if choice == "View":
            st.subheader("movie Details")
            movie_result = movie_view_all_data()
            #st.write(movie_result)
            with st.expander("View All movie Data"):
                movie_clean_df = pd.DataFrame(movie_result, columns=["Name", "Expiry Date", "Use", "Quantity", "ID"])
                st.dataframe(movie_clean_df)
            with st.expander("View movie Quantity"):
                movie_name_quantity_df = movie_clean_df[['Name','Quantity']]
                #movie_name_quantity_df = movie_name_quantity_df.reset_index()
                st.dataframe(movie_name_quantity_df)
        if choice == 'Update':
            st.subheader("Update movie Details")
            d_id = st.text_area("movie ID")
            d_use = st.text_area("movie Use")
            if st.button(label='Update'):
                movie_update(d_use,d_id)

        if choice == 'Delete':
            st.subheader("Delete movies")
            did = st.text_area("movie ID")
            if st.button(label="Delete"):
                movie_delete(did)

## CUSTOMERS
    elif choice == "Customers":

        menu = ["View", "Update", "Delete"]
        choice = st.sidebar.selectbox("Menu", menu)
        if choice == "View":
            st.subheader("Customer Details")
            cust_result = customer_view_all_data()
            #st.write(cust_result)
            with st.expander("View All User Data"):
                cust_clean_df = pd.DataFrame(cust_result, columns=["user_id", "Name","password" , "email-id","phone"])
                st.dataframe(cust_clean_df)

        if choice == 'Update':
            st.subheader("Update Customer Details")
            cust_email = st.text_area("Email")
            cust_number = st.text_area("Phone Number")
            if st.button(label='Update'):
                customer_update(cust_email,cust_number)

        if choice == 'Delete':
            st.subheader("Delete Customer")
            cust_email = st.text_area("Email")
            if st.button(label="Delete"):
                customer_delete(cust_email)
##Booking
    elif choice == "Bookings":

        menu = ["View"]
        choice = st.sidebar.selectbox("Menu", menu)
        if choice == "View":
            st.subheader("booking Details")
            booking_result = booking_view_all_data()
            #st.write(cust_result)
            with st.expander("View All booking Data"):
                booking_clean_df = pd.DataFrame(booking_result, columns=["Booking ID", "Show ID","Qty" ,"User-Id"])
                st.dataframe(booking_clean_df)
    elif choice == "About":
        st.subheader("DBMS Mini Project")
        st.subheader("By Aditi")


def getauthenicate(username, password):
    #print("Auth")
    c.execute('SELECT user_password FROM user WHERE user_name = %s', (username,))
    user_password = c.fetchall()
    #print(cust_password[0][0], "Outside password")
    #print(password, "Parameter password")
    if user_password[0][0] == password:
        #print("Inside password")
        return True
    else:
        return False


###################################################################

def customer(username, password):
    if getauthenicate(username, password):
       
        
        st.title("Welcome to movie booking")
        st.subheader("MENU")
        #menu =["Movie details", "Book a ticket", "Booking details"]
        #selected = st.selectbox("Choose what you want", menu )
        #if selected=="Movie details":

        movie_result = movie_view_all_data()
        with st.expander("View All movie Data"):
            movie_clean_df = pd.DataFrame(movie_result, columns=["movie_id",'movie_name',"language","genre","duration","pg_rating"])
            st.dataframe(movie_clean_df)

        
        
        #if selected == "Book a Ticket":
        st.subheader("Book your Tickets")
        user_id=st.text_input("user_id")
        book_ticket(user_id)  

        #elif selected == "Booking details":
        book_id=st.text_input("book_id")
        booking_result = booking_view_data(book_id)
        with st.expander("View All booking Data"):
            booking_clean_df = pd.DataFrame(booking_result, columns=["Booking_ID", "Show_ID", "Tickets", "ID"])
            st.dataframe(booking_clean_df) 
        

        



def main():
    with st.sidebar:
        selected=option_menu(
             menu_title = "MAIN",
             options = ["Login", "Signup", "Admin", "Custom Query"],)
    #TABLE_NAME = st.selectbox("Select a Table", ["Movie", "User", "Theatre", "Screening", "Ticket"])
    TABLE_NAME =  ["Movie", "User", "Theatre", "Screening", "Ticket"]
    ###################################################################
    

    if selected == "Custom Query":
        st.subheader("Custom Query")
        custom_query(TABLE_NAME)

    elif selected == "Login":
        img = Image.open('movie.png')
        st.image(img, width=800)
        st.subheader("WELCOME BACK")
        username = st.text_input("User Name")
        password = st.text_input("Password", type='password')
        if st.button(label="Login"):
            customer(username, password)

    elif selected == "Signup":
        st.subheader("Create New Account")
        user_id = st.text_input("Userid")
        user_name = st.text_input("Name")
        user_password = st.text_input("Password", type='password', key=1000)
        user_password1 = st.text_input("Confirm Password", type='password', key=1001)
        col1, col3 = st.columns(2)

        with col1:
            email_id = st.text_area("Email ID")
  
        with col3:
            phone = st.text_area("Phone Number")

        if st.button("Signup"):
            if (user_password == user_password1):
                customer_add_data(user_id,user_name,user_password,email_id,phone)
                st.success("Account Created!")
                st.info("Go to Login Menu to login")
            else:
                st.warning('Password dont match')

    elif selected == "Admin":
        username = st.sidebar.text_input("User Name")
        password = st.sidebar.text_input("Password", type='password')
        # if st.sidebar.button("Login"):
        if username == 'admin' and password == 'admin':
            admin()  

 
if __name__ == '__main__':
    main()