<template>
    <div>
        <h1>{{message}}</h1>
        <img src="../../error.svg" alt="">
    </div>
</template>

<style scoped>
    * {
        user-select: none;
    }
    div {
        width: 100%;
        text-align: center;
    }
    img {
        -webkit-user-drag: none;
    }
    h1::before {
        margin-top: 2px;
        text-decoration: underline 1px red;
    }
    h1 {
        font-size: 54px;
    }
</style>

<script>
    module.exports = {
            data: function () {
                return {
                    
                }
            },
            props: ['message']
        }
</script>