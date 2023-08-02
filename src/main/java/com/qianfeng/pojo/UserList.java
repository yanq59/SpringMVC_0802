package com.qianfeng.pojo;

import org.springframework.stereotype.Component;

import java.util.List;

@Component
public class UserList {
    private List<User> userList;

    @Override
    public String   toString() {
        return "UserList{" +
                "userList=" + userList +
                '}';
    }

    public List<User> getUserList() {
        return userList;
    }

    public void setUserList(List<User> userList) {
        this.userList = userList;
    }

}
