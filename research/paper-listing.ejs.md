```{=html}
<div class="paper-list">
<% for (const item of items) { %>

  <article class="paper-card">

    <div class="paper-card-header">
      <% if (item.status) { %>
        <span class="paper-status"><%- item.status %></span>
      <% } %>

      <% if (item.year) { %>
        <span class="paper-year"><%- item.year %></span>
      <% } %>
    </div>

    <h2 class="paper-title">
      <a href="<%- item.path %>"><%- item.title %></a>
    </h2>

    <% if (item.coauthors) { %>
      <p class="paper-coauthors">
        With <%= item.coauthors %>
      </p>
    <% } %>

    <% if (item.venue) { %>
      <p class="paper-venue"><%= item.venue %></p>
    <% } %>

    <% if (item.description) { %>
      <p class="paper-description"><%= item.description %></p>
    <% } %>

    <div class="paper-links">

      <a class="paper-button paper-button-primary"
         href="<%- item.path %>">
        Details
      </a>

      <% if (item.pdf) { %>
        <a class="paper-button"
           href="<%- item.pdf %>"
           target="_blank"
           rel="noopener">
          PDF
        </a>
      <% } %>

      <% if (item.slides) { %>
        <a class="paper-button"
           href="<%- item.slides %>"
           target="_blank"
           rel="noopener">
          Slides
        </a>
      <% } %>

      <% if (item.appendix) { %>
        <a class="paper-button"
           href="<%- item.appendix %>"
           target="_blank"
           rel="noopener">
          Appendix
        </a>
      <% } %>

      <% if (item.code) { %>
        <a class="paper-button"
           href="<%- item.code %>"
           target="_blank"
           rel="noopener">
          Code
        </a>
      <% } %>

    </div>

    <% if (item.categories && item.categories.length > 0) { %>
      <div class="paper-topics">
        <% for (const category of item.categories) { %>
          <span class="paper-topic"><%- category %></span>
        <% } %>
      </div>
    <% } %>

  </article>

<% } %>
</div>
```