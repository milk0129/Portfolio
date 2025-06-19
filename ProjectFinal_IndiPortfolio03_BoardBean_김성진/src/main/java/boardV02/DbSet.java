package boardV02;

import java.sql.Connection;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class DbSet {
    private static DataSource ds;

    static {
        try {
            Context init = new InitialContext();
            ds = (DataSource) init.lookup("java:/comp/env/jdbc/OracleDB");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static Connection getConnection() throws Exception {
        return ds.getConnection();
    }
}
