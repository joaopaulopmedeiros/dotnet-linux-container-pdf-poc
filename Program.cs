using iText.Html2pdf;
using System;
using System.IO;

namespace PdfGenerator
{
    internal class Program
    {
        static void Main(string[] args)
        {
            using (FileStream htmlSource = File.Open("files/input.html", FileMode.Open))
            using (FileStream pdfDest = File.Open("files/output.pdf", FileMode.OpenOrCreate))
            {
                ConverterProperties converterProperties = new ConverterProperties();
                HtmlConverter.ConvertToPdf(htmlSource, pdfDest, converterProperties);
            }
            Console.WriteLine("Awesome PDF just got created.");
        }
    }
}
