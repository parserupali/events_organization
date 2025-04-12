# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

    Software Used:
    •	Ruby: ruby 3.1.2p20
    •	Rails: Rails 7.1.5.1
    •	Redis: Installed via brew install redis
    •	PostgreSQL

Application Startup Steps and Commands:
1.	Start Redis:
      brew services start redis
2.	Install dependencies:
      bundle install
3.	Set up the database:
      rails db:create
      rails db:migrate
      rails db:seed
4.	Start Sidekiq:
      bundle exec sidekiq
5.	Start the Rails server:
      rails s
6.	Open Rails console
      rails c

API document is attached here -
https://links.getpostman.com/ls/click?upn=u001.F5oWY2bDM9VsP1yDsg8sV-2FFzG75a0TDhOImmQ4dmU-2BZsGDgzZn8gPli-2FvotPQiQ2aSxF0-2F-2Fd24M9xKGywxAlJFL4gyo-2FqyEAO6sKWoIQjH2yHayyWUPB3SOyKprNC-2BE2KxKE0TISRG-2BHmYpE8llJTYLFLzzeS-2FvPh8MuycDvlyaUP5YipVhVbOnxAsCqHktOaunjRsF9iFTkCfHnYlXEuQ5FZp9FFLNYI0Yiktdq3xM-3D7YoY_LDgqRvkPIWHZOhyqI7ajlGg4u4rTzY7wGQVqCB-2BT8Ap9Fc6mhW-2FxtXp-2BHqcEzUjqhCvnIxikNp6Rtm5UCdDW2293MN99-2Bdy6AoirRscjpPqsdeSq4-2Fqsti0y077w9LuYCfh6TWzgdFTPIbNlA4TVJTKkaHrHu9912NM1seNYPKd8uYPkDm2fA9sak3N87JQVBMk4h9jg5qcols7WtY9cfdx4DYNWaPJ8n487CYgo644kG8oPnB0KeHR-2Bjr92ebmJ-2Bnd19dK0iYsc7-2BAhfd1WMLGv28SJumC4cw3xmVAQ-2BPJV9Ne9YxPQt2zujIIaLKMTVvnshVVPAfe4Fmww3SvQjngr2ExnE1uX1MWXIpqqQcxkP7aup6vNppdWK08gRoT-2FjbweGEX2qazMWkV-2BfiFqSxT6nNtQbR8bi-2B1WD0-2Bksa6-2F54YYuHe6QO197K0gwCnS

Click on - View complete documentation
There we can see sample requests, by running on send we can check response but also adding here.

Sample responses - These are only responses
=======================================================================================================================

Request - http://localhost:3000/api/v1/signin
Type - POST

Request data - -

{"user":
  {
    "email": "admin@example.com",
    "password": "admin@123"
  }
}

Response -
{
    "token": "eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHAiOjE3NDQ1NjgyNjgsImp0aSI6ImNlZjk2MjFlLTU5YjktNGFkZS05YTJkLWE1NWE1NzUzOGFlYyJ9.yJJPZW9VfRjN4S79OhbvC6vUxR0HZVK7pv6qORGNzSQ",
    "user": {
        "id": 1,
        "email": "admin@example.com"
    }
}

=======================================================================================================================

Request - http://localhost:3000/api/v1/signup
Type - POST

Request data - -

{"user":
  {
    "first_name": "Customer2",
    "last_name": "Habibi",
    "email": "customer2@gmail.com",
    "password": "customer1@123",
    "password_confirmation": "customer1@123",
    "role": "customer"
  },
  "customer": {
        "phone_number": "+971-123456000"
    }
}


Response -

{
    "message": "customer created successfully",
    "user": {
        "id": 10,
        "first_name": "Customer2",
        "last_name": "Habibi",
        "email": "customer2@gmail.com",
        "created_at": "2025-04-12T18:23:03.794Z",
        "updated_at": "2025-04-12T18:23:03.794Z"
    }
}
=======================================================================================================================

Request - http://localhost:3000/api/v1/users
Type - POST
Bearer Token - <Token>

Request data - -
{
    "user": {
        "first_name": "Rupali1",
        "last_name": "Parse1",
        "email": "parserupali1@gmail.com",
        "password": "rupali@123",
        "password_confirmation": "rupali@123",
        "role": "event_organizer"
    },
    "event_organizer": {
        "company_name": "Rapid logisitics",
        "phone_number": "+971-123456789"
    }
}

Response -

{
    "id": 9,
    "first_name": "Rupali1",
    "last_name": "Parse1",
    "full_name": "Rupali1 Parse1",
    "email": "parserupali1@gmail.com"
}

=======================================================================================================================
Request - http://localhost:3000/api/v1/users
Type - POST
Bearer Token - <Token>

Request data - -
{
    "user": {
        "first_name": "Rupali1",
        "last_name": "Parse1",
        "email": "parserupali111@gmail.com",
        "password": "rupali@123",
        "password_confirmation": "rupali@123"

    }
}
Response -

{
    "error": "Role is required"
}

=======================================================================================================================
This API will just update User attributes,not Customer or event organizer they will get update via respective APIS
Request - http://localhost:3000/api/v1/users/3
Type - PATCH
Bearer Token - <Token>

Request data - -

{
    "user": {
        "last_name": "Habibi1"
    },
    "customer": {
        "phone_number": "+971-123456788"
    }
}

Response -

{
    "id": 3,
    "first_name": "Customer1",
    "last_name": "Habibi1",
    "full_name": "Customer1 Habibi1",
    "email": "customer1@gmail.com"
}

=======================================================================================================================
Request - http://localhost:3000/api/v1/signout
Type - DELETE
Bearer Token - <Token>

Response -
Message - Logged out successfully

If trying to revoke same token via signout getting error as its already revoked, even accessing other URLS by this giving same error.
ERROR: "Token has been revoked"

=======================================================================================================================
Request - http://localhost:3000/api/v1/users/10
Type - DELETE
Bearer Token - <Token>

Response -

{
    "message": "User deleted successfully"
}
=======================================================================================================================
Request - http://localhost:3000/api/v1/event_organizers
Type - GET
Bearer Token - <Token>

Response -
[
    {
        "id": 4,
        "company_name": "Rapid logisitics",
        "phone_number": "+971-123456789",
        "user": {
            "id": 8,
            "first_name": "Rupali",
            "last_name": "Parse",
            "full_name": "Rupali Parse",
            "email": "parserupali@gmail.com"
        }
    },
    {
        "id": 5,
        "company_name": "Rapid logisitics",
        "phone_number": "+971-123456789",
        "user": {
            "id": 9,
            "first_name": "Rupali1",
            "last_name": "Parse1",
            "full_name": "Rupali1 Parse1",
            "email": "parserupali1@gmail.com"
        }
    }
]

=======================================================================================================================
Request - http://localhost:3000/api/v1/event_organizers/4
Type - GET
Bearer Token - <Token>

Response -
{
    "id": 4,
    "company_name": "Rapid logisitics",
    "phone_number": "+971-123456789",
    "user": {
        "id": 8,
        "first_name": "Rupali",
        "last_name": "Parse",
        "full_name": "Rupali Parse",
        "email": "parserupali@gmail.com"
    }
}
=======================================================================================================================
Request - http://localhost:3000/api/v1/event_organizers/4
Type - PATCH
Bearer Token - <Token>

Request data - -
{
    "user": {
        "first_name": "Rupali1",
        "last_name": "Parsee1",
        "email": "parserupali@gmail.com",
        "role": "event_organizer"
    },
    "event_organizer": {
        "company_name": "Rapid logisiticss",
        "phone_number": "+971-123456780"
    }
}

Response - {
    "id": 4,
    "company_name": "Rapid logisiticss",
    "phone_number": "+971-123456780",
    "user": {
        "id": 8,
        "first_name": "Rupali1",
        "last_name": "Parsee1",
        "full_name": "Rupali1 Parsee1",
        "email": "parserupali@gmail.com"
    }
}
=======================================================================================================================

Request - http://localhost:3000/api/v1/event_organizers/1
Type - DELETE
Bearer Token - <Token>

Response -
{
    "message": "Event organizer deleted successfully."
}
=======================================================================================================================
Request - http://localhost:3000/api/v1/customers
Type - GET
Bearer Token - <Token>

Response -
[
    {
        "id": 1,
        "full_name": "Customer1 Habibi1",
        "email": "customer1@gmail.com",
        "phone_number": "+971-123456780"
    }
]
=======================================================================================================================
Request - http://localhost:3000/api/v1/customers/1
Type - GET
Bearer Token - <Token>

Response -
{
    "id": 1,
    "full_name": "Customer1 Habibi1",
    "email": "customer1@gmail.com",
    "phone_number": "+971-123456780"
}
=======================================================================================================================
Request - http://localhost:3000/api/v1/customers/1
Type - PATCH
Bearer Token - <Token>

Request data - -
{
    "user": {
        "first_name": "Customer11",
        "last_name": "Habibi",
        "email": "customer1@gmail.com"
    },
    "customer": {
        "phone_number": "+971-12348888"
    }
}

Response -
{
    "id": 1,
    "full_name": "Customer11 Habibi",
    "email": "customer1@gmail.com",
    "phone_number": "+971-12348888"
}
=======================================================================================================================
Request - http://localhost:3000/api/v1/customers/1
Type - DELETE
Bearer Token - <Token>

Response -
{
    "message": "Customer deleted successfully."
}
=======================================================================================================================
Request - http://localhost:3000/api/v1/events
Type - GET
Bearer Token - <Token>

Response -

[
    {
        "id": 3,
        "title": "Arjeet Live 2025",
        "description": "Music Festivals",
        "event_date": "2025-06-15T00:00:00.000Z",
        "venue": "Dubai coca cola arena",
        "event_organizer_id": 4,
        "event_organizer_name": "Rupali1 Parsee1",
        "tickets": [
            {
                "id": 5,
                "ticket_type": "Early Bird",
                "price": "40.0",
                "quantity": 100
            },
            {
                "id": 7,
                "ticket_type": "General Admission",
                "price": "50.0",
                "quantity": 100
            },
            {
                "id": 8,
                "ticket_type": "VIP",
                "price": "150.0",
                "quantity": 50
            }
        ],
        "created_at": "2025-04-12T11:19:34.708Z",
        "updated_at": "2025-04-12T15:06:05.715Z"
    }
]
=======================================================================================================================
Request - http://localhost:3000/api/v1/events/3
Type - GET

Bearer Token - <Token>

Response -
{
    "id": 3,
    "title": "Arjeet Live 2025",
    "description": "Music Festivals",
    "event_date": "2025-06-15T00:00:00.000Z",
    "venue": "Dubai coca cola arena",
    "event_organizer_id": 4,
    "event_organizer_name": "Rupali1 Parsee1",
    "tickets": [
        {
            "id": 5,
            "ticket_type": "Early Bird",
            "price": "40.0",
            "quantity": 100
        },
        {
            "id": 7,
            "ticket_type": "General Admission",
            "price": "50.0",
            "quantity": 100
        },
        {
            "id": 8,
            "ticket_type": "VIP",
            "price": "150.0",
            "quantity": 50
        }
    ],
    "created_at": "2025-04-12T11:19:34.708Z",
    "updated_at": "2025-04-12T15:06:05.715Z"
}
=======================================================================================================================
Request - http://localhost:3000/api/v1/events
Type - POST
Bearer Token - <Token>

Request data - -
{
  "event": {
    "title": "Atif Aslam Live 2025",
    "description" : "Music Festival",
    "event_date": "2025-06-20",
    "venue": "Dubai Arena",
    "tickets_attributes": [
      { "ticket_type": "General Admission", "price": 50, "quantity": 100 },
      { "ticket_type": "VIP", "price": 150, "quantity": 50 }
    ]
  }
}

Response -
{
    "id": 4,
    "title": "Atif Aslam Live 2025",
    "description": "Music Festival",
    "event_date": "2025-06-20T00:00:00.000Z",
    "venue": "Dubai Arena",
    "event_organizer_id": 4,
    "event_organizer_name": "Rupali1 Parsee1",
    "tickets": [
        {
            "id": 9,
            "ticket_type": "General Admission",
            "price": "50.0",
            "quantity": 100
        },
        {
            "id": 10,
            "ticket_type": "VIP",
            "price": "150.0",
            "quantity": 50
        }
    ],
    "created_at": "2025-04-12T19:03:30.182Z",
    "updated_at": "2025-04-12T19:03:30.182Z"
}
=======================================================================================================================
Request - http://localhost:3000/api/v1/events/4
Type - PATCH
Bearer Token - <Token>

Request data - -
{
  "event": {
    "title": "Atif Aslam Live 2025 - 1",
    "description" : "Music Festival",
    "event_date": "2025-06-20",
    "venue": "Dubai Arena",
    "tickets_attributes": [
      { "id": 9, "ticket_type": "General Admission", "price": 50, "quantity": 100 },
      { "id": 10,"ticket_type": "VIP", "price": 150, "quantity": 50 }
    ]
  }
}

Response -
{
    "id": 4,
    "title": "Atif Aslam Live 2025 - 1",
    "description": "Music Festival",
    "event_date": "2025-06-20T00:00:00.000Z",
    "venue": "Dubai Arena",
    "event_organizer_id": 4,
    "event_organizer_name": "Rupali1 Parsee1",
    "tickets": [
        {
            "id": 9,
            "ticket_type": "General Admission",
            "price": "50.0",
            "quantity": 100
        },
        {
            "id": 10,
            "ticket_type": "VIP",
            "price": "150.0",
            "quantity": 50
        }
    ],
    "created_at": "2025-04-12T19:03:30.182Z",
    "updated_at": "2025-04-12T19:06:31.693Z"
}
=======================================================================================================================
Request - http://localhost:3000/api/v1/events/1
Type - DELETE
Bearer Token - <Token>

Response -
{
    "message": 'Event deleted successfully.'
}
=======================================================================================================================
Request - http://localhost:3000/api/v1/events/3/bookings
Type - POST
Bearer Token - <Token>

Request data - -
{
  "booking": {
    "booking_tickets_attributes": [
      { "ticket_id": 5, "quantity": 2 }
    ]
  }
}

Response -
{
    "id": 13,
    "customer_id": 1,
    "event_id": 3,
    "total_price": "80.0",
    "status": "confirmed",
    "created_at": "2025-04-12T19:09:12.581Z",
    "updated_at": "2025-04-12T19:09:12.581Z"
}
=======================================================================================================================
Request - http://localhost:3000/api/v1/events/3/bookings
Type - GET
Bearer Token - <Token>

Response -
[
    {
        "id": 11,
        "customer_id": 1,
        "event_id": 3,
        "total_price": "80.0",
        "status": "confirmed",
        "created_at": "2025-04-12T14:35:18.719Z",
        "updated_at": "2025-04-12T14:35:18.719Z"
    },
    {
        "id": 12,
        "customer_id": 1,
        "event_id": 3,
        "total_price": "40.0",
        "status": "confirmed",
        "created_at": "2025-04-12T14:42:28.514Z",
        "updated_at": "2025-04-12T14:42:28.514Z"
    },
    {
        "id": 13,
        "customer_id": 1,
        "event_id": 3,
        "total_price": "80.0",
        "status": "confirmed",
        "created_at": "2025-04-12T19:09:12.581Z",
        "updated_at": "2025-04-12T19:09:12.581Z"
    }
]
=======================================================================================================================
Request - http://localhost:3000/api/v1/events/3/bookings/11
Type - GET
Bearer Token - <Token>

Response -
{
  "booking": {
    "booking_tickets_attributes": [
      { "ticket_id": 5, "quantity": 2 }
    ]
  }
}
=======================================================================================================================
Request - http://localhost:3000/api/v1/events/3/tickets
Type - GET
Bearer Token - <Token>

Response -
[
    {
        "id": 5,
        "event_title": "Arjeet Live 2025",
        "ticket_type": "Early Bird",
        "price": "40.0",
        "quantity": 100,
        "created_at": "2025-04-12T11:19:34.709Z",
        "updated_at": "2025-04-12T11:19:34.709Z"
    },
    {
        "id": 7,
        "event_title": "Arjeet Live 2025",
        "ticket_type": "General Admission",
        "price": "50.0",
        "quantity": 100,
        "created_at": "2025-04-12T15:03:09.268Z",
        "updated_at": "2025-04-12T15:03:09.268Z"
    },
    {
        "id": 8,
        "event_title": "Arjeet Live 2025",
        "ticket_type": "VIP",
        "price": "150.0",
        "quantity": 50,
        "created_at": "2025-04-12T15:03:09.271Z",
        "updated_at": "2025-04-12T15:03:09.271Z"
    }
]
=======================================================================================================================
Request - http://localhost:3000/api/v1/events/3/tickets/8
Type - GET
Bearer Token - <Token>

Response -
{
    "id": 8,
    "event_title": "Arjeet Live 2025",
    "ticket_type": "VIP",
    "price": "150.0",
    "quantity": 50,
    "created_at": "2025-04-12T15:03:09.271Z",
    "updated_at": "2025-04-12T15:03:09.271Z"
}
=======================================================================================================================
