package controller;

import framework.AppConfig;
import framework.DataBaseConnections;
import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;
import logtrack.ExceptionLogTrack;

@WebListener
public class ContextListener implements ServletContextListener {

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        ServletContext ctx = sce.getServletContext();

        try {
            AppConfig appConfig = AppConfig.getInstance();
            ExceptionLogTrack logTrack = ExceptionLogTrack.getInstance();
            DataBaseConnections dbConns = DataBaseConnections.getInstance();

            System.out.println("=== ContextListener: aplicação iniciando ===");
            System.out.println("AppConfig: " + appConfig);
            System.out.println("ExceptionLogTrack: " + logTrack);
            System.out.println("DataBaseConnections: " + dbConns);

            ctx.setAttribute("appConfig", appConfig);

        } catch (Exception ex) {
            System.out.println("❌ Erro ao inicializar ContextListener: " + ex.getMessage());
            ex.printStackTrace();
            ExceptionLogTrack.getInstance().addLog(ex);
        }
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        System.out.println("=== ContextListener: aplicação sendo finalizada ===");
        try {
            DataBaseConnections dbConns = DataBaseConnections.getInstance();
            dbConns.closeAllConnections();
            System.out.println("Conexões fechadas com sucesso.");
        } catch (Exception ex) {
            System.out.println("❌ Erro ao fechar conexões: " + ex.getMessage());
            ex.printStackTrace();
            ExceptionLogTrack.getInstance().addLog(ex);
        }
    }
}
