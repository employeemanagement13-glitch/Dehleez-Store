# Missing Package Fix

The `clsx` package is used in utils.ts but not in package.json. Here's the fix:

## Add to package.json dependencies:

```json
"clsx": "^2.1.0"
```

## Or run:
```bash
npm install clsx
```

This package is used for className merging in the `cn()` utility function.
