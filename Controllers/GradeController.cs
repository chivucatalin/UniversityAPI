using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using System.Data.SqlClient;
using System.Text.Json;
using UniversityAPI.Models;

namespace UniversityAPI.Controllers
{
    [ApiController]
    [Route("[controller]")]
    [Authorize(AuthenticationSchemes = "Authentication")]
    public class GradeController : Controller
    {
        private readonly IConfiguration _configuration;
        private readonly SqlConnection _connection;

        public GradeController(IConfiguration configuration)
        {
            _configuration = configuration;
            _connection = new SqlConnection(_configuration.GetConnectionString("MyDatabase"));
        }

        [HttpGet("{studentId}")]
        public IActionResult GetGradesSubjects(int studentId)
        {
            _connection.Open();
            using SqlCommand command = new SqlCommand
                (string.Format("SELECT * FROM Note WHERE StudentId={0}", studentId), _connection);
            using SqlDataReader reader = command.ExecuteReader();
            List<GradeDto> model = new List<GradeDto>();

            while (reader.Read())
            {
                model.Add(new GradeDto()
                {
                    Id = reader.GetInt32(0),
                    StudentId = reader.GetInt32(1),
                    MaterieDenumire = reader.GetString(2),
                    NotaObtinuta = (float)reader.GetDouble(3)
                });
            }

            var SubjectGrade = model.Select(x => new { x.MaterieDenumire, x.NotaObtinuta });

            string json = JsonSerializer.Serialize(SubjectGrade);

            return Ok(json);

        }

        [HttpGet("medie/{studentId}")]

        public IActionResult GetAverage(int studentId)
        {
            _connection.Open();
            using SqlCommand command = new SqlCommand
                (string.Format("SELECT NotaObtinuta FROM ultimeleNote({0}) ", studentId), _connection);
            using SqlDataReader reader = command.ExecuteReader();
            List<float> model = new List<float>();

            while (reader.Read())
            {
                model.Add(reader.GetInt32(0));
            }

            var average = model.Average();

            return Ok(average);

        }

    }
}
