package model;

import framework.DataAccessObject;
import java.security.MessageDigest;
import java.util.ArrayList;
import java.nio.charset.StandardCharsets;
import java.security.NoSuchAlgorithmException;

public class User extends DataAccessObject {

    private String user;
    private String name;
    private String email;
    private String password;

    public User() {
        super("users");
    }

    public String getUser() {
        return user;
    }

    public String getName() {
        return name;
    }

    public String getEmail() {
        return email;
    }

    public String getPassword() {
        return password;
    }

    public void setUser(String user) {
        this.user = user;
        addChange("user", this.user);
    }

    public void setName(String name) {
        this.name = name;
        addChange("name", this.name);
    }

    public void setEmail(String email) {
        this.email = email;
        addChange("email", getEmail());
    }

    public void setPassword(String password) {
        // Verifica se a senha recebida é diferente da armazenada (comparação eficiente)
        if (!password.equals(this.password)) {
            try {
                // "Salt": usa nome do usuário + senha + tamanho do usuário dividido por 2
                String salt = getUser() + password + (getUser().length() / 2);
                MessageDigest md = MessageDigest.getInstance("SHA-256");
                byte[] hashBytes = md.digest(salt.getBytes(StandardCharsets.UTF_8));

                // Converte os bytes para formato hexadecimal (zero padding garantido)
                StringBuilder sb = new StringBuilder();
                for (byte b : hashBytes) {
                    sb.append(String.format("%02x", b));
                }
                String hash = sb.toString();

                this.password = hash;
                addChange("password", this.password);
            } catch (NoSuchAlgorithmException e) {
                // Lança exceção apropriada ou faz tratamento
                e.printStackTrace();
                throw new RuntimeException("Erro ao criptografar a senha", e);
            }
        }
    }

    @Override
    protected String getWhereClauseForOneEntity() {
        return "user = " + getUser();
    }

    @Override
    protected DataAccessObject fill(ArrayList<Object> data) {
        user = (String) data.get(0); // coluna 1: User
        name = (String) data.get(1); // coluna 2: Name
        email = (String) data.get(2); // coluna 3: Email
        password = (String) data.get(3); // coluna 4: Senha

        return this;
    }

    @Override
    protected User copy() {
        User cp = new User();

        cp.setUser(getUser());
        cp.setName(getName());
        cp.setEmail(getEmail());
        cp.setPassword(getPassword());

        cp.setNovelEntity(false);

        return cp;
    }

    @Override
    public boolean equals(Object obj) {
        if (obj instanceof User) {
            User aux = (User) obj;
            return getUser().equals(aux.getUser());
        }
        return false;
    }

    @Override
    public String toString() {
        return "(" + getUser() + ", " + getName() + ", " + getEmail() + ", " + getPassword() + ")";
    }
}
