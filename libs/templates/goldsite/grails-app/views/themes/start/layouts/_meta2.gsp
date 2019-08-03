<g:each in="${$afterMetaList}" var="item">
    ${raw('<'+'meta')} ${item.attrName}="${item.attrValue}" content="${item.content}" ${raw('/>')}
</g:each>