FROM public.ecr.aws/aws-observability/aws-for-fluent-bit:init-2.29.0
COPY extra.conf /fluent-bit/etc/extra.conf
COPY parsers_json.conf /fluent-bit/etc/parsers_json.conf

# aws ecr get-login-password | docker login --username AWS --password-stdin https://{アカウントID}.dkr.ecr.ap-northeast-1.amazonaws.com
# docker build -t firelens-fluentbit .
# docker tag firelens-fluentbit {アカウントID}.dkr.ecr.ap-northeast-1.amazonaws.com/firelens-fluentbit:2.29.0
# docker push {アカウントID}.dkr.ecr.ap-northeast-1.amazonaws.com/firelens-fluentbit:2.29.0