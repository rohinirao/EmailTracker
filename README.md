# EmailTracker

EmailTracker is a microservice built with Ruby on Rails that provides email tracking functionality through pixel tracking. It allows you to track email opens by generating unique tracking URLs that can be embedded in emails.

## Technology Stack

- Ruby 3.3.3
- Rails 8.0.1
- SQLite (default Rails database)

## Installation

1. Clone the repository:
```bash
git clone git@github.com:rohinirao/EmailTracker.git
cd email_tracker
```

2. Install dependencies:
```bash
bundle install
```

3. Set up the database:
```bash
rake db:migrate
```

4. Start the server:
```bash
rails server -p 3000
```

## API Endpoints

### Create Tracking URL
```
POST /api/v1/email_trackings
```
Creates a tracking URL for a given email message ID.

**Request Body:**
```json
"email_tracking": {
  "message_id": "unique-email-message-id"
}
```

**Response:**
```json
{
  "uuid": "generated-uuid",
  "tracking_url": "http://localhost:3000/api/v1/email_trackings/{uuid}/download_hits/track"
}
```

### Track Email Open
```
GET /api/v1/email_trackings/{email_tracking_uuid}/download_hits/track
```
Records an email open event when the tracking pixel is loaded. Returns a 1x1 transparent GIF image.

### Get Tracking Statistics
```
GET /api/v1/email_trackings/stats
```
Retrieves statistics for all tracking URLs.

**Response:**
```json
{
  "tracking_stats": [
    {
      "message_id": "email-message-id",
      "tracking_url": "tracking-url",
      "hits_count": 5
    }
  ]
}
```

## API Documentation

Swagger documentation is available at `http://localhost:3000/api-docs/index.html` when the server is running.

You can also find the OpenAPI specification in `swagger/v1/swagger.yaml`.

## Development

The application uses SQLite as its database, which comes bundled with Rails. No additional database setup is required.

## Testing

To run the test suite:
```bash
bundle exec rspec
```

## License

MIT License
