using Microsoft.EntityFrameworkCore.Migrations;

public partial class AddPasswordResetColumns : Migration
{
    protected override void Up(MigrationBuilder migrationBuilder)
    {
        migrationBuilder.AddColumn<string>(
            name: "reset_token",
            table: "Users",
            type: "nvarchar(max)",
            nullable: true);

        migrationBuilder.AddColumn<DateTime>(
            name: "reset_token_expiry",
            table: "Users",
            type: "datetime2",
            nullable: true);
    }

    protected override void Down(MigrationBuilder migrationBuilder)
    {
        migrationBuilder.DropColumn(
            name: "reset_token",
            table: "Users");

        migrationBuilder.DropColumn(
            name: "reset_token_expiry",
            table: "Users");
    }
}