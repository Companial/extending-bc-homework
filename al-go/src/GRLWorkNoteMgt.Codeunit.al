codeunit 50180 "GRL Work Note Mgt."
{
    Access = Public;

    /// <summary>
    /// Returns the number of work notes that are not done.
    /// </summary>
    procedure CountOpenNotes(): Integer
    var
        WorkNote: Record "GRL Work Note";
    begin
        WorkNote.SetRange(Done, false);
        exit(WorkNote.Count());
    end;
}
