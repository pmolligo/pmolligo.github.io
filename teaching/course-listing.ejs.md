```{=html}
<div class="course-list">
<% for (const item of items) { %>

  <article class="course-card">

    <div class="course-card-header">
      <% if (item.institution) { %>
        <span class="course-institution"><%- item.institution %></span>
      <% } %>

      <% if (item.term) { %>
        <span class="course-term"><%- item.term %></span>
      <% } %>
    </div>

    <h2 class="course-title">
      <a href="<%- item.path %>"><%- item.title %></a>
    </h2>

    <% if (item.role) { %>
      <p class="course-role"><%- item.role %></p>
    <% } %>

    <% if (item.description) { %>
      <p class="course-description"><%= item.description %></p>
    <% } %>

    <div class="course-links">
      <a class="course-button course-button-primary"
         href="<%- item.path %>">
        Course page
      </a>

      <% if (item.syllabus) { %>
        <a class="course-button"
           href="<%- item.syllabus %>"
           target="_blank"
           rel="noopener">
          Syllabus
        </a>
      <% } %>

      <% if (item.evaluations) { %>
        <a class="course-button"
           href="<%- item.evaluations %>"
           target="_blank"
           rel="noopener">
          Evaluations
        </a>
      <% } %>
    </div>

  </article>

<% } %>
</div>
```