package org.hamcrest.text;

import org.hamcrest.Formatting;
import org.hamcrest.Matcher;

public abstract class SubstringMatcher implements Matcher {
    protected final String substring;

    protected SubstringMatcher(final String substring) {
        this.substring = substring;
    }

    public boolean match(Object o) {
        return o instanceof String && evalSubstringOf((String) o);
    }

    public void describeTo(StringBuffer buffer) {
        buffer.append("a string ")
                .append(relationship())
                .append(" ")
                .append(Formatting.toReadableString(substring));
    }

    protected abstract boolean evalSubstringOf(String string);

    protected abstract String relationship();
}