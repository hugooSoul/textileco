# TextileCO

## Dev Interview

TextileCo is a company of textiles. This system try to emule the check in & check out of all their employees.
Also shown the days that each employee doesn't came to work & the days that he/she assist, diplaying is came late or left early.


### User section

After create an account, each user is stores as employee. To create an Admin user is neccesary to set as true the admin "field" of the Employee table in DB.

Follow the next steps:

```sh
$ rails c
$ @user = Employee.first or Employee.last or Employee.find('id_of_user_to_set_as_Admin')
$ @user.admin = true
$ @user.save
```

Each user can do different things, as:

- Employee
    -   Can do check-in & check-out
- Admin
    - Can see a list of each employee
    - Can shown that days doesn't came to work & that days came late or left early.


**Hugo!**
