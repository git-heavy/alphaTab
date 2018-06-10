package alphaTab.test.importer;

using system.HaxeExtensions;
@:testClass
class Gp3ImporterTest extends alphaTab.test.importer.GpImporterTestBase
{
    @:testMethod
    public function TestScoreInfo() : Void 
    {
        var reader : alphaTab.importer.Gp3To5Importer = PrepareImporterWithFile("GuitarPro3/Test01.gp3");
        var score : alphaTab.model.Score = reader.ReadScore();
        alphaTab.test.Assert.AreEqual_T1_T22("Title", score.Title);
        alphaTab.test.Assert.AreEqual_T1_T22("Subtitle", score.SubTitle);
        alphaTab.test.Assert.AreEqual_T1_T22("Artist", score.Artist);
        alphaTab.test.Assert.AreEqual_T1_T22("Album", score.Album);
        alphaTab.test.Assert.AreEqual_T1_T22("Music", score.Words);// no words in gp4

        alphaTab.test.Assert.AreEqual_T1_T22("Music", score.Music);
        alphaTab.test.Assert.AreEqual_T1_T22("Copyright", score.Copyright);
        alphaTab.test.Assert.AreEqual_T1_T22("Tab", score.Tab);
        alphaTab.test.Assert.AreEqual_T1_T22("Instructions", score.Instructions);
        alphaTab.test.Assert.AreEqual_T1_T22("Notice1\r\nNotice2", score.Notices);
        alphaTab.test.Assert.AreEqual_T1_T22(5, score.MasterBars.Count);
        alphaTab.test.Assert.AreEqual_T1_T22(1, score.Tracks.Count);
        alphaTab.test.Assert.AreEqual_T1_T22("Track 1", score.Tracks.get_Item(0).Name);
        Render(score, "D:\\Dev\\AlphaTab\\AlphaTab2\\Source\\AlphaTab.Test\\Importer\\Gp3ImporterTest.cs", "TestScoreInfo");
    }

    @:testMethod
    public function TestNotes() : Void 
    {
        var reader : alphaTab.importer.Gp3To5Importer = PrepareImporterWithFile("GuitarPro3/Test02.gp3");
        var score : alphaTab.model.Score = reader.ReadScore();
        CheckTest02Score(score);
        Render(score, "D:\\Dev\\AlphaTab\\AlphaTab2\\Source\\AlphaTab.Test\\Importer\\Gp3ImporterTest.cs", "TestNotes");
    }

    @:testMethod
    public function TestTimeSignatures() : Void 
    {
        var reader : alphaTab.importer.Gp3To5Importer = PrepareImporterWithFile("GuitarPro3/Test03.gp3");
        var score : alphaTab.model.Score = reader.ReadScore();
        CheckTest03Score(score);
        Render(score, "D:\\Dev\\AlphaTab\\AlphaTab2\\Source\\AlphaTab.Test\\Importer\\Gp3ImporterTest.cs", "TestTimeSignatures");
    }

    @:testMethod
    public function TestDead() : Void 
    {
        var reader : alphaTab.importer.Gp3To5Importer = PrepareImporterWithFile("GuitarPro3/TestDead.gp3");
        var score : alphaTab.model.Score = reader.ReadScore();
        CheckDead(score);
        Render(score, "D:\\Dev\\AlphaTab\\AlphaTab2\\Source\\AlphaTab.Test\\Importer\\Gp3ImporterTest.cs", "TestDead");
    }

    @:testMethod
    public function TestAccentuation() : Void 
    {
        var reader : alphaTab.importer.Gp3To5Importer = PrepareImporterWithFile("GuitarPro3/TestAccentuations.gp3");
        var score : alphaTab.model.Score = reader.ReadScore();
        alphaTab.test.Assert.IsTrue(score.Tracks.get_Item(0).Staves.get_Item(0).Bars.get_Item(0).Voices.get_Item(0).Beats.get_Item(0).Notes.get_Item(0).IsGhost);
        // it seems accentuation is handled as Forte Fortissimo
        alphaTab.test.Assert.AreEqual_T1_T22(alphaTab.model.DynamicValue.FFF, score.Tracks.get_Item(0).Staves.get_Item(0).Bars.get_Item(0).Voices.get_Item(0).Beats.get_Item(1).Notes.get_Item(0).Dynamic);
        alphaTab.test.Assert.IsTrue(score.Tracks.get_Item(0).Staves.get_Item(0).Bars.get_Item(0).Voices.get_Item(0).Beats.get_Item(3).Notes.get_Item(0).IsLetRing);
        Render(score, "D:\\Dev\\AlphaTab\\AlphaTab2\\Source\\AlphaTab.Test\\Importer\\Gp3ImporterTest.cs", "TestAccentuation");
    }

    @:testMethod
    public function TestGuitarPro3Harmonics() : Void 
    {
    }

    @:testMethod
    public function TestHammer() : Void 
    {
        var reader : alphaTab.importer.Gp3To5Importer = PrepareImporterWithFile("GuitarPro3/TestHammer.gp3");
        var score : alphaTab.model.Score = reader.ReadScore();
        CheckHammer(score);
        Render(score, "D:\\Dev\\AlphaTab\\AlphaTab2\\Source\\AlphaTab.Test\\Importer\\Gp3ImporterTest.cs", "TestHammer");
    }

    @:testMethod
    public function TestBend() : Void 
    {
        var reader : alphaTab.importer.Gp3To5Importer = PrepareImporterWithFile("GuitarPro3/TestBends.gp3");
        var score : alphaTab.model.Score = reader.ReadScore();
        CheckBend(score);
        Render(score, "D:\\Dev\\AlphaTab\\AlphaTab2\\Source\\AlphaTab.Test\\Importer\\Gp3ImporterTest.cs", "TestBend");
    }

    @:testMethod
    public function TestSlides() : Void 
    {
        var reader : alphaTab.importer.Gp3To5Importer = PrepareImporterWithFile("GuitarPro3/TestSlides.gp3");
        var score : alphaTab.model.Score = reader.ReadScore();
        alphaTab.test.Assert.AreEqual_T1_T22(alphaTab.model.SlideType.Shift, score.Tracks.get_Item(0).Staves.get_Item(0).Bars.get_Item(0).Voices.get_Item(0).Beats.get_Item(0).GetNoteOnString(5).SlideType);
        alphaTab.test.Assert.AreEqual_T1_T22(alphaTab.model.SlideType.Shift, score.Tracks.get_Item(0).Staves.get_Item(0).Bars.get_Item(0).Voices.get_Item(0).Beats.get_Item(2).GetNoteOnString(2).SlideType);
        Render(score, "D:\\Dev\\AlphaTab\\AlphaTab2\\Source\\AlphaTab.Test\\Importer\\Gp3ImporterTest.cs", "TestSlides");
    }

    @:testMethod
    public function TestGuitarPro3Vibrato() : Void 
    {
        // TODO: Check why this vibrato is not recognized
        var reader : alphaTab.importer.Gp3To5Importer = PrepareImporterWithFile("GuitarPro3/TestVibrato.gp3");
        var score : alphaTab.model.Score = reader.ReadScore();
        CheckVibrato(score, false);
        Render(score, "D:\\Dev\\AlphaTab\\AlphaTab2\\Source\\AlphaTab.Test\\Importer\\Gp3ImporterTest.cs", "TestGuitarPro3Vibrato");
    }

    @:testMethod
    public function TestOtherEffects() : Void 
    {
        var reader : alphaTab.importer.Gp3To5Importer = PrepareImporterWithFile("GuitarPro3/TestOtherEffects.gp3");
        var score : alphaTab.model.Score = reader.ReadScore();
        alphaTab.test.Assert.IsTrue(score.Tracks.get_Item(0).Staves.get_Item(0).Bars.get_Item(0).Voices.get_Item(0).Beats.get_Item(2).Tap);
        alphaTab.test.Assert.IsTrue(score.Tracks.get_Item(0).Staves.get_Item(0).Bars.get_Item(0).Voices.get_Item(0).Beats.get_Item(3).Slap);
        alphaTab.test.Assert.IsTrue(score.Tracks.get_Item(0).Staves.get_Item(0).Bars.get_Item(1).Voices.get_Item(0).Beats.get_Item(0).Pop);
        alphaTab.test.Assert.IsTrue(score.Tracks.get_Item(0).Staves.get_Item(0).Bars.get_Item(1).Voices.get_Item(0).Beats.get_Item(1).FadeIn);
        alphaTab.test.Assert.IsTrue(score.Tracks.get_Item(0).Staves.get_Item(0).Bars.get_Item(3).Voices.get_Item(0).Beats.get_Item(0).HasChord);
        alphaTab.test.Assert.AreEqual_T1_T22("C", score.Tracks.get_Item(0).Staves.get_Item(0).Bars.get_Item(3).Voices.get_Item(0).Beats.get_Item(0).Chord.Name);
        alphaTab.test.Assert.AreEqual_T1_T22("Text", score.Tracks.get_Item(0).Staves.get_Item(0).Bars.get_Item(3).Voices.get_Item(0).Beats.get_Item(1).Text);
        alphaTab.test.Assert.IsTrue(score.Tracks.get_Item(0).Staves.get_Item(0).Bars.get_Item(4).Voices.get_Item(0).Beats.get_Item(0).GetAutomation(alphaTab.model.AutomationType.Tempo) != null);
        alphaTab.test.Assert.AreEqual_T1_T22(120.0, score.Tracks.get_Item(0).Staves.get_Item(0).Bars.get_Item(4).Voices.get_Item(0).Beats.get_Item(0).GetAutomation(alphaTab.model.AutomationType.Tempo).Value);
        alphaTab.test.Assert.IsTrue(score.Tracks.get_Item(0).Staves.get_Item(0).Bars.get_Item(4).Voices.get_Item(0).Beats.get_Item(0).GetAutomation(alphaTab.model.AutomationType.Instrument) != null);
        alphaTab.test.Assert.AreEqual_T1_T22(25.0, score.Tracks.get_Item(0).Staves.get_Item(0).Bars.get_Item(4).Voices.get_Item(0).Beats.get_Item(0).GetAutomation(alphaTab.model.AutomationType.Instrument).Value);
        Render(score, "D:\\Dev\\AlphaTab\\AlphaTab2\\Source\\AlphaTab.Test\\Importer\\Gp3ImporterTest.cs", "TestOtherEffects");
    }

    @:testMethod
    public function TestStroke() : Void 
    {
        var reader : alphaTab.importer.Gp3To5Importer = PrepareImporterWithFile("GuitarPro3/TestStrokes.gp3");
        var score : alphaTab.model.Score = reader.ReadScore();
        alphaTab.test.Assert.AreEqual_T1_T22(alphaTab.model.BrushType.BrushDown, score.Tracks.get_Item(0).Staves.get_Item(0).Bars.get_Item(0).Voices.get_Item(0).Beats.get_Item(0).BrushType);
        alphaTab.test.Assert.AreEqual_T1_T22(alphaTab.model.BrushType.BrushUp, score.Tracks.get_Item(0).Staves.get_Item(0).Bars.get_Item(0).Voices.get_Item(0).Beats.get_Item(1).BrushType);
        Render(score, "D:\\Dev\\AlphaTab\\AlphaTab2\\Source\\AlphaTab.Test\\Importer\\Gp3ImporterTest.cs", "TestStroke");
    }

    @:testMethod
    public function TestTuplets() : Void 
    {
        var reader : alphaTab.importer.Gp3To5Importer = PrepareImporterWithFile("GuitarPro3/TestTuplets.gp3");
        var score : alphaTab.model.Score = reader.ReadScore();
        CheckTuplets(score);
        Render(score, "D:\\Dev\\AlphaTab\\AlphaTab2\\Source\\AlphaTab.Test\\Importer\\Gp3ImporterTest.cs", "TestTuplets");
    }

    @:testMethod
    public function TestRanges() : Void 
    {
        var reader : alphaTab.importer.Gp3To5Importer = PrepareImporterWithFile("GuitarPro3/TestRanges.gp3");
        var score : alphaTab.model.Score = reader.ReadScore();
        alphaTab.test.Assert.IsTrue(score.Tracks.get_Item(0).Staves.get_Item(0).Bars.get_Item(1).Voices.get_Item(0).Beats.get_Item(1).Notes.get_Item(0).IsLetRing);
        alphaTab.test.Assert.IsTrue(score.Tracks.get_Item(0).Staves.get_Item(0).Bars.get_Item(1).Voices.get_Item(0).Beats.get_Item(2).Notes.get_Item(0).IsLetRing);
        alphaTab.test.Assert.IsTrue(score.Tracks.get_Item(0).Staves.get_Item(0).Bars.get_Item(1).Voices.get_Item(0).Beats.get_Item(3).Notes.get_Item(0).IsLetRing);
        alphaTab.test.Assert.IsTrue(score.Tracks.get_Item(0).Staves.get_Item(0).Bars.get_Item(2).Voices.get_Item(0).Beats.get_Item(0).Notes.get_Item(0).IsLetRing);
        Render(score, "D:\\Dev\\AlphaTab\\AlphaTab2\\Source\\AlphaTab.Test\\Importer\\Gp3ImporterTest.cs", "TestRanges");
    }

    @:testMethod
    public function TestEffects() : Void 
    {
        var reader : alphaTab.importer.Gp3To5Importer = PrepareImporterWithFile("GuitarPro3/Effects.gp3");
        var score : alphaTab.model.Score = reader.ReadScore();
        CheckEffects(score);
        Render(score, "D:\\Dev\\AlphaTab\\AlphaTab2\\Source\\AlphaTab.Test\\Importer\\Gp3ImporterTest.cs", "TestEffects");
    }

    @:testMethod
    public function TestStrings() : Void 
    {
        var reader : alphaTab.importer.Gp3To5Importer = PrepareImporterWithFile("GuitarPro3/TestStrings.gp3");
        var score : alphaTab.model.Score = reader.ReadScore();
        CheckStrings(score);
        Render(score, "D:\\Dev\\AlphaTab\\AlphaTab2\\Source\\AlphaTab.Test\\Importer\\Gp3ImporterTest.cs", "TestStrings");
    }

    public function new() 
    {
        super();
    }

}