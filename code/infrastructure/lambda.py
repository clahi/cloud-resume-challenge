import json
import boto3
from decimal import Decimal
import uuid


client = boto3.client('dynamodb')
dynamodb = boto3.resource("dynamodb")
table = dynamodb.Table('counter-table')
tableName = 'counter-table'


def lambda_handler(event, context):
    # updating the counter at dynamodb table
    print('The requestID', event['requestContext'])
    res = table.update_item(
        Key={"id": "1"},
        UpdateExpression='ADD view_count :inc',
        ExpressionAttributeValues={":inc": 1},
        ReturnValues="UPDATED_NEW"
    )
    print("The response after incrementing", res)
   # Return the updated view count
    return {
        "statusCode": 200,
        "body": str(res['Attributes']['view_count']),
        "headers": {
            'Access-Control-Allow-Origin': '*',
        }
    }