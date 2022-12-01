import streamlit as st
from database import movie_view_name,show_view_id,get_available_seats,get_shows,add_ticket
import random as rand

def book_ticket(user_id):
    list_of_movies = [i[0] for i in movie_view_name('movie')]
    list_of_shows = [i[0] for i in show_view_id('show')]
    list_of_seats = [str(i+1) for i in range(200)]
    st.text(user_id)

    selected_movie = st.selectbox("Select a Movie", list_of_movies)
    list_of_shows = [i[0] for i in get_shows(selected_movie)]
    selected_screening = st.selectbox("Select a Show", list_of_shows)
    occupied_seats = [i[0] for i in get_available_seats(selected_screening)]
    for seat in list_of_seats:
        if seat in occupied_seats:
            list_of_seats.remove(seat)
    selected_seat = st.selectbox("Seat Number", list_of_seats)
    ticket_id= "T" + str(rand.randint(100, 1000))
    booking_id = "B" + str(rand.randint(100, 1000))
    total_price = rand.random() * 500
    list =['premium','classic','recliner']
    type = str(rand.choice(list))
    if st.button("Book Ticket"):
        add_ticket("Ticket", [ticket_id ,booking_id ,type ,total_price])
        st.success("Successfully booked ticket::")