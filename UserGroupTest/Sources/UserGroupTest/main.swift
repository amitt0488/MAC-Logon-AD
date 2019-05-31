import PerfectLDAP
import Foundation
import PerfectICONV
import OpenLDAP

let ldapUrl = "ldap://rootDSE"//"ldap://americas.ad.celestica.com"//"ldap://RootDSE"//"ldap://americas.ad.celestica.com"
let username = "alice"
let password = "Password1!"
let distinguishedName = "CN=Users,DC=Americas,DC=ad,DC=celestica,DC=com"
let userDistinguishedName = "CN=alice,CN=Users,DC=Americas,DC=ad,DC=celestica,DC=com"
let dnwithoutUser = "DC=Americas,DC=ad,DC=celestica,DC=com"
let builtinDname = "CN=Builtin,DC=Americas,DC=ad,DC=celestica,DC=com"
let securityDname = "OU=security,DC=Americas,DC=ad,DC=celestica,DC=com"
let testCPG: Iconv.CodePage = .UTF8

func GetUserGroups(){
    
    do {
        let cred = LDAP.Login(binddn: userDistinguishedName, password: password)
        //let cred = LDAP.Login(binddn: userDistinguishedName, password: password)
        
        //let ldap = try LDAP(url: ldapUrl)
        let ldap = try LDAP(url: ldapUrl, loginData: cred, codePage: testCPG)
        
        // "(objectclass=group)"  - to get all the groups
        let completeDataFilter = "(objectclass=group)"
        let sAMAccountNameFilter = "sAMAccountName=*"
        let res = try ldap.search(base: distinguishedName, filter: completeDataFilter, scope:.SUBTREE, attributes: ["sAMAccountName", "distinguishedName","memberof", "primaryGroupID"])
        
        /*
         let res = try ldap.search(base: distinguishedName, filter: sAMAccountNameFilter, scope:.SUBTREE, attributes: ["sAMAccountName", "distinguishedName","memberof", "primaryGroupID"])
         */
        
        print(res)
    }
    catch (let err) {
        print(err)
    }
    
    
}

func GetADUsers(){
    
    do {
        let cred = LDAP.Login(binddn: userDistinguishedName, password: password)
    
        let connection = try LDAP(url: ldapUrl)
        let loginResponse = try connection.login(info: cred)
    
        print(loginResponse)
    }
    catch (let err) {
        print(err)
    }
    
    
}

func SearchADGSSAPI(){
    
    do {
        let cred = LDAP.Login(user: "alice", mechanism: .SIMPLE)
        
        let ldap = try LDAP(url: ldapUrl, loginData: cred)
        //ldap.timeout = 10
        
        //let ldap = try LDAP(url: ldapUrl, loginData: cred, codePage: testCPG)
        let completeDataFilter = "(objectclass=*)"
        let sAMAccountNameFilter = "sAMAccountName=" + username
        let res = try ldap.search(base: distinguishedName, filter: sAMAccountNameFilter, scope:.SUBTREE, attributes: ["sAMAccountName", "distinguishedName"])
        
        print(res)
    }
    catch (let err) {
        print(err)
    }
    
    
}

func SearchAD(){
    
    do {
        //let cred = LDAP.Login(binddn: userDistinguishedName, password: password)
        
        let ldap = try LDAP(url: ldapUrl)
        //ldap.timeout = 10
        
        //let ldap = try LDAP(url: ldapUrl, loginData: cred, codePage: testCPG)
        let completeDataFilter = "(objectclass=*)"
        let sAMAccountNameFilter = "sAMAccountName=" + username
        
        let res = try ldap.search(base: distinguishedName, filter: sAMAccountNameFilter, scope:.SUBTREE, attributes: ["sAMAccountName", "distinguishedName"])
        
        
        print(res)
    }
    catch (let err) {
        print(err)
    }
    
    
}

func IsUserInDomainGroups(uname : String, groupNameStr : String) -> Bool {
    
    do {
        // establish connection via alice user and its password
        let cred = LDAP.Login(binddn: userDistinguishedName, password: password)
        
        //let ldap = try LDAP(url: ldapUrl) // not working
        // hardcoded distinguishedname
        let ldap = try LDAP(url: ldapUrl, loginData: cred, codePage: testCPG)
        
        //let completeDataFilter = "(objectclass=*)"
        let sAMAccountNameFilter = "sAMAccountName=" + uname
        let res = try ldap.search(base: distinguishedName, filter: sAMAccountNameFilter, scope:.SUBTREE, attributes: ["sAMAccountName", "distinguishedName","memberof", "primaryGroupID"])
        
        print(res)
    }
    catch (let err) {
        print(err)
    }
    
    return true
}




func SearchADWorking(){
    
    do {
        let cred = LDAP.Login(binddn: userDistinguishedName, password: password)
        
        //let ldap = try LDAP(url: ldapUrl)
        let ldap = try LDAP(url: ldapUrl, loginData: cred, codePage: testCPG)
        
       
        //let completeDataFilter = "(objectclass=*)"
        let sAMAccountNameFilter = "sAMAccountName=" + "alice"
        let res = try ldap.search(base: distinguishedName, filter: sAMAccountNameFilter, scope:.SUBTREE, attributes: ["sAMAccountName", "distinguishedName"])
        
        print(res)
    }
    catch (let err) {
        print(err)
    }
    
    
}

//print(GetADUsers())
print(GetUserGroups())


