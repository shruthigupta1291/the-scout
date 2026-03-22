// ==========================================
// THE SCOUT — Google Apps Script
// Dashboard API
// ==========================================
// Deploy this as a Web App in Google Apps Script
// Execute as: Me
// Who has access: Anyone
// ==========================================

const SHEET_ID = 'YOUR_GOOGLE_SHEET_ID'; // Replace with your Sheet ID
const SHEET_NAME = 'Job Tracker';

function doGet(e) {
  const sheet = SpreadsheetApp
    .openById(SHEET_ID)
    .getSheetByName(SHEET_NAME);

  const rows = sheet.getDataRange().getValues();

  // Skip header row, filter empty rows
  const data = rows.slice(1)
    .filter(r => r[1]) // Must have company name
    .map(r => ({
      date: r[0] ? r[0].toString() : '',
      company: r[1] ? r[1].toString() : '',
      jobTitle: r[2] ? r[2].toString() : '',
      jobUrl: r[3] ? r[3].toString() : '',
      posterName: r[4] ? r[4].toString() : '',
      contact: r[5] ? r[5].toString() : '',
      method: r[6] ? r[6].toString() : '',
      message: r[7] ? r[7].toString() : '',
      status: r[8] ? r[8].toString() : '',
      notes: r[9] ? r[9].toString() : ''
    }));

  const json = JSON.stringify(data);

  // Support JSONP for cross-origin requests
  const callback = e.parameter.callback;
  if (callback) {
    return ContentService
      .createTextOutput(callback + '(' + json + ')')
      .setMimeType(ContentService.MimeType.JAVASCRIPT);
  }

  return ContentService
    .createTextOutput(json)
    .setMimeType(ContentService.MimeType.JSON);
}
