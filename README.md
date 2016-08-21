# TextileCO

## Dev Interview

TextileCo is a company of textiles. This system try to emule the check in & check out of all their employees.
Also shown the days that each employee doesn't came to work & the days that he/she assist, diplaying is came late or left early.


### User section

After create an account, each user is stores as employee. To create an Admin user is neccesary to set as true the admin "field" of the Employee table in DB.

Follow the next steps:

```shs
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


### Schedule

On the table of the each user there are some information as the day, their check-in & check-out,
and if the user came late or left the office early.

If an Employee came to work after(>=) 9:30 AM the system shown that that user came late
and assuming the user have been in the office, and if he/she decide get out after 3:00(>=) PM or before(<=) 5:45PM
the system gonna show that the user left early.


### Features not completed

> Point 3 - Your customer’s employees are complaining that the reported hours for a given period
> are wrong, so your customer wants to give each of his employees the opportunity to
> review their current period working hours report 3 days before the paycheck day.

**Hugo!**
