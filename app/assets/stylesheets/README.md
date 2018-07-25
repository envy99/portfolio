# Portfolio front-end style guide

## Table of contents:
1. [Folder structure](#folder-structure)
1. [Main files](#main-files)
1. [Code styling](#code-styling)
1. [Naming conventions](#naming-conventions)

## Folder structure:
Carefully planned & well-thought folder structure streamlines our workflow and improves readability of the styles. That is why, it is very important to adhere to these established concepts.
* `base/` - here we put the fundamental styles, that will affect every page on our website
* `bulma-overrides/` - this folder contains files named exactly the same as in the Bulma framework so that we can easily determine what we have overridden/modified
* `components/` - this folder consists of components - self-contained elements, which should be easily reusable in other projects
* `layout/` - here are located fundamental elements of the website layout (i.e. navbar, footer)
* `pages/` - here shall be placed files with styles specific to each page if needed
* `utilities/` - this folder contains utilities such as: functions, mixins, helpers, etc.

## Main files:
* `application.scss` - here we define a list of all the other files that we want to include in our project
* `variables.scss` - in this file we can customise the Bulma framework by modifying its variables. Also here we declare our own global variables

## Code styling:
* Use 2 spaces instead of tabs
* Put one additional new line without any spaces at the end of each class & file
* Empty lines should always have no indentation
* Avoid unnecessary spaces at the end of a line
* Put the opening curly bracket with one space in front in the same line as the selector. The closing curly bracket should be in a separate line at the end of the code block
  ``` css
  .card {
  }
  ```
* Put a space in attributes only after `:`
  ``` css
  .is-primary {
    background-color: $primary;
  }
  ```
* Separate words using `-` not `_`
  ``` css
  .has-text-black {
  }
  ```
* Avoid IDs
  ``` css
  #menu .image { // Bad
  }
  ```
* Try to avoid `!important` as much as possible. If you use `!important` then it is almost certain that you are doing something wrong. The only exception is when you define helpers or modifiers
  ``` css
  .box {
    text-align: center !important; // Bad
  }
  ```
* Put each selector in a new line
  ``` css
  input,
  select,
  textarea {
  }
  ```
* Avoid DOM elements in front of selectors
  ``` css
  div.box { // Bad
  }
  ```
* Put responsive mixins at the end of the styled element
  ``` css
  .footer-items {
    text-align: center;

    @include from($tablet) {
      text-align: right;
    }
  }
  ```
* Do not use classes with `js-` prefix. They are intended for binding DOM elements with JavaScript not styling
  ``` css
  .js-nested-fields { // Bad
  }
  ```

## Naming conventions:
In Portfolio project we have decided to adapt Bulma framework naming scheme.

### Bulma naming scheme:
``` css
.navbar {        // Component
  &-brand {      // Element
  }

  &.is-primary { // Modifier
  }
}
```

### Modifiers syntax:
All modifiers should start either with **is-** or **has-**.
Here are some valid modifier names: `is-primary`, `is-large`, `has-text-black`, `has-content-centered`.

### Practical example:
Let's assume that we want to create a card.
The card component will consist of the following elements: `header`, `content` and `footer`.
The component can also have custom modifiers, for instance: `is-highlight` and `has-content-centered`.

1. We could create that component that way:
	``` css
	.card {
	  &-header {
	  }
		
	  &-content {
	  }
	
	  &-footer {
	  }
	
	  &.is-highlight {
	  }
	
	  &.has-content-centered {
	  }
	}
	```

1. Another way to create this component:
	``` css
	.card {
	  &.is-highlight {
	  }
	
	  &.has-content-centered {
	  }
	}
	
	.card-header {
	}
	
	.card-content {
	}
	
	.card-footer {
	}
	```

Note that both examples will generate the same CSS code. However, if your component becomes massive, you should preferably use the second method, since it will be more readable.
