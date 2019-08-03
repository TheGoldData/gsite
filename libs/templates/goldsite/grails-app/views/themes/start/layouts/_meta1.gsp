<g:each in="${$beforeMetaList}" var="item">
    ${raw('<'+'meta')} ${item.attrName}="${item.attrValue}" content="${item.content}" ${raw('/>')}
</g:each>