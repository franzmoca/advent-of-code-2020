package it.fmoca.advent;

import lombok.Builder;
import lombok.Data;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.Stream;

public class AdventDayTwo {

    public static void main(String[] args) {
        try (Stream<String> stream = Files.lines(Paths.get("input.txt"))) {
            List<RulePasswordPair> pairs = stream.map((line) -> {
                String[] split = line.split("\\s+");
                String range = split[0];
                String[] rangeNumbers = range.split("-");
                Rule rule = Rule.builder()
                        .lowerbound(Integer.parseInt(rangeNumbers[0]))
                        .upperbound(Integer.parseInt(rangeNumbers[1]))
                        .letter(split[1].replace(":", "").charAt(0))
                        .build();
                RulePasswordPair pair = RulePasswordPair.builder()
                        .rule(rule)
                        .password(split[2])
                        .build();
                return pair;
            }).collect(Collectors.toList());

            long validPasswordsPt1 = pairs.stream().filter((rulePasswordPair -> {
                Rule rule = rulePasswordPair.getRule();
                long charCount = rulePasswordPair.getPassword().chars().filter(ch -> ch == rule.getLetter()).count();
                return charCount >= rule.getLowerbound() && charCount <= rule.getUpperbound();
            })).count();

            long validPasswordsPt2 = pairs.stream().filter((rulePasswordPair -> {
                Rule rule = rulePasswordPair.getRule();
                String password = rulePasswordPair.getPassword();
                Integer charCount = 0;

                if(password.charAt(rule.getLowerbound() - 1) == rule.getLetter()){
                    charCount++;
                }

                if(password.charAt(rule.getUpperbound() - 1) == rule.getLetter()){
                    charCount++;
                }
                System.out.println(rulePasswordPair.toString());
                return charCount.equals(1);
            })).count();

            System.out.println("Pt1: Valid password are: " + validPasswordsPt1);
            System.out.println("Pt2: Valid password are: " + validPasswordsPt2);


        } catch (IOException e) {
            e.printStackTrace();
        }

    }

    @Data
    @Builder
    static class Rule{
        private Character letter;
        private Integer  lowerbound;
        private Integer upperbound;
    }

    @Data
    @Builder
    static class RulePasswordPair{
        private Rule rule;
        private String password;
    }

}
