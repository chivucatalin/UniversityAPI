namespace UniversityAPI.Models
{
    public class GradeDto
    {

        public int Id { get; set; }

        public int StudentId { get; set; }
        public string MaterieDenumire { get; set; } = string.Empty;

        public float NotaObtinuta { get; set; }
    }
}
