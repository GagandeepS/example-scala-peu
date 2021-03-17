FROM adoptopenjdk/maven-openjdk8 AS build
RUN mkdir -p /workspace
WORKDIR /workspace
COPY pom.xml /workspace
COPY src /workspace/src
RUN mvn -B package --file pom.xml -DskipTests

FROM flink:1.12.1
RUN mkdir -p $FLINK_HOME/usrlib
COPY --from=build /workspace/target/examples-scala_2.12-1.0.jar $FLINK_HOME/usrlib/peu-job.jar