namespace UniversityAPI.Models
{
    public class StudentDto
    {
        public int Id { get; set; }
        public string Nume { get; set; } = string.Empty;

        public string Prenume { get; set; } = string.Empty;

        public string Grupa { get; set; } = string.Empty;

        public string Oras { get; set; } = string.Empty;
    }
}
