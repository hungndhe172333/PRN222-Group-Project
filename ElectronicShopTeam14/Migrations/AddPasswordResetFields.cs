using Microsoft.EntityFrameworkCore.Migrations;

public class AddPasswordResetFields : Migration
{
    protected override void Up(MigrationBuilder migrationBuilder)
    {
        migrationBuilder.AddColumn<string>(
            name: "ResetToken",
            table: "Users",
            nullable: true);

        migrationBuilder.AddColumn<DateTime>(
            name: "ResetTokenExpiry",
            table: "Users",
            nullable: true);
    }
}