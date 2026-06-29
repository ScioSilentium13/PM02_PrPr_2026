using Microsoft.EntityFrameworkCore;
using System.Configuration;
using CityAppealsApi.Models;

namespace CityAppealsApi.Data
{
    public class AppDbContext : DbContext
    {
        public DbSet<ApplicationUser> ApplicationUsers { get; set; }
        public DbSet<Appeal> Appeals { get; set; }
        public DbSet<Category> Categories { get; set; }
        public DbSet<Status> Statuses { get; set; }
        public DbSet<AppealHistory> AppealHistories { get; set; }
        public DbSet<Attachment> Attachments { get; set; }

        public AppDbContext() : base()
        {
        }

        public AppDbContext(DbContextOptions<AppDbContext> options) : base(options)
        {
        }

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            if (!optionsBuilder.IsConfigured)
            {
                var connStr = "Server=(localdb)\\MSSQLLocalDB;Database=PM11_FACTORY;Trusted_Connection=True;TrustServerCertificate=True;";
                optionsBuilder.UseSqlServer(connStr);
            }
        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<ApplicationUser>(entity =>
            {
                entity.ToTable("ApplicationUser");
                entity.HasKey(e => e.UserID);
                entity.Property(e => e.Login).IsRequired().HasMaxLength(50);
                entity.HasIndex(e => e.Login).IsUnique();
                entity.Property(e => e.PasswordHash).IsRequired().HasMaxLength(128);
                entity.Property(e => e.Role).IsRequired().HasMaxLength(20);
            });

            modelBuilder.Entity<Appeal>(entity =>
            {
                entity.ToTable("Appeal");
                entity.HasKey(e => e.AppealID);
                entity.HasOne(e => e.Author).WithMany(u => u.AuthoredAppeals).HasForeignKey(e => e.AuthorID);
                entity.HasOne(e => e.Category).WithMany(c => c.Appeals).HasForeignKey(e => e.CategoryID);
                entity.HasOne(e => e.Status).WithMany(s => s.Appeals).HasForeignKey(e => e.StatusID);
                entity.HasOne(e => e.AssignedTo).WithMany(u => u.AssignedAppeals).HasForeignKey(e => e.AssignedToID);
                entity.Property(e => e.Title).IsRequired().HasMaxLength(200);
            });

            modelBuilder.Entity<AppealHistory>(entity =>
            {
                entity.ToTable("AppealHistory");
                entity.HasKey(e => e.HistoryID);
                entity.HasOne(e => e.Appeal).WithMany(a => a.Histories).HasForeignKey(e => e.AppealID);
                entity.HasOne(e => e.User).WithMany(u => u.AppealHistories).HasForeignKey(e => e.UserID);
                entity.Property(e => e.Action).IsRequired().HasMaxLength(100);
            });

            modelBuilder.Entity<Category>(entity =>
            {
                entity.ToTable("Category");
                entity.HasKey(e => e.CategoryID);
                entity.Property(e => e.Name).IsRequired().HasMaxLength(100);
            });

            modelBuilder.Entity<Status>(entity =>
            {
                entity.ToTable("Status");
                entity.HasKey(e => e.StatusID);
                entity.Property(e => e.Name).IsRequired().HasMaxLength(50);
            });

            modelBuilder.Entity<Attachment>(entity =>
            {
                entity.ToTable("Attachment");
                entity.HasKey(e => e.AttachmentID);
                entity.HasOne(e => e.Appeal).WithMany(a => a.Attachments).HasForeignKey(e => e.AppealID);
                entity.Property(e => e.FileName).IsRequired().HasMaxLength(255);
                entity.Property(e => e.FilePath).IsRequired().HasMaxLength(500);
            });
        }
    }
}