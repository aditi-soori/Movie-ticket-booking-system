import streamlit as st
import pandas as pd
from database import submit_query, return_df_columns

def custom_query(TABLE_NAME):
    query = st.text_area("Query")
    if st.button("Submit Query"):
        columns = return_df_columns(TABLE_NAME)
        result = submit_query(query)
        st.success("Query has been submitted successfully")
        try:
            df = pd.DataFrame(result, columns=columns) 
        except:
            df = pd.DataFrame(result)
        with st.expander("View all results"):
            st.dataframe(df)