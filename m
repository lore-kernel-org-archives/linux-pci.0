Return-Path: <SRS0=DH7G=C6=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12211C4346E
	for <linux-pci@archiver.kernel.org>; Mon, 21 Sep 2020 18:58:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7CEF20C09
	for <linux-pci@archiver.kernel.org>; Mon, 21 Sep 2020 18:58:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VwM6SxPc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727363AbgIUS6c (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 21 Sep 2020 14:58:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726395AbgIUS6c (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Sep 2020 14:58:32 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0933C061755
        for <linux-pci@vger.kernel.org>; Mon, 21 Sep 2020 11:58:31 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id gx22so10213710ejb.5
        for <linux-pci@vger.kernel.org>; Mon, 21 Sep 2020 11:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rrEufNVuY5dCBzinzTyZLnRAK6NDit4k748EnZ9ZGyU=;
        b=VwM6SxPchzpHYvDq5MuGqptnfOCO+2u8UOZQsUHmvXP+yQTF+Z7wlraeVtjd/s9jlB
         wV193ZvJeoHSX0mG5NaEp1P+oe7FoNjVRmUSb2Z+JinKsMwFIqn+MpalsijQarctvj4U
         FH4y6mRhga1p9JKtJgLYS2O01gvN0JoRMzpIJ8sTPjHm+K3XvxLJoxyawOroxTt3ewXo
         2erVwwtPxW6qCdmd6A02Wa5wSMbzwpQ/xA7DOELk4+u1Yv0Dw6Gb0gPjk1AInJx+Npb8
         9g541oYiyMOVYQWN0p1s+dSK+qehJVoUb8ZcAzai39YkrQsAMRZIWHvBa3cE/5jkadoT
         Dtig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rrEufNVuY5dCBzinzTyZLnRAK6NDit4k748EnZ9ZGyU=;
        b=O0kL6OzHiv8/NVi68mkHys6oosDziKXQCm1IfZ1zvEXV9mFXN7XjWVg1S0NNbHITs0
         VdbIojPYboV0/k1uEJcxq+nWPeLxnPykisQt62k6Efmv/5Mq7eGN2Q3G/0WKxTjt6V/C
         5k9sUkyxGkbZ+sdM8j2FMwry4ePaWH4RPeyE0FqvMPMV+kD7QjeB0gJE0lGCsbe0uVKU
         GJWomUz+7A681O7WZs8w30Zvm12mqpAuwpPMe+Z5H5D4qQhaUCWJFSGxkZzsgfifQqwh
         s6RNcWQJ9bulnxD5c6/j5+LI5ZCr6dn0ONusRvtHTdJ76nF2DX9DSzAyi5KnCWpYDcDB
         fhHw==
X-Gm-Message-State: AOAM5302Cwx7dxuMmLvP+HtKG08HCzOwcHl/NRanSboqzFMcngbOvGDi
        8Ag/rYvIme+Xilih9duFgAQV4TjyIqpTUZ2EdZsVxw==
X-Google-Smtp-Source: ABdhPJwAs9ksH6re9qMXbI2fsKP5Ghj4mOoCzkBFQS+BQszgLy1pqKFO8fFSdMFWe7XQ/UpW1tcdUlWla4BBqoqymc8=
X-Received: by 2002:a17:906:ecf1:: with SMTP id qt17mr960026ejb.158.1600714709946;
 Mon, 21 Sep 2020 11:58:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200918201436.2932360-1-samitolvanen@google.com>
 <20200918201436.2932360-14-samitolvanen@google.com> <202009181427.86DE61B@keescook>
In-Reply-To: <202009181427.86DE61B@keescook>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Mon, 21 Sep 2020 11:58:19 -0700
Message-ID: <CABCJKuf5pKqEDaAKix5CaUmv92M5HOAB-psdNg=awF7BDZ+yvA@mail.gmail.com>
Subject: Re: [PATCH v3 13/30] kbuild: lto: postpone objtool
To:     Kees Cook <keescook@chromium.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kbuild <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org,
        X86 ML <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Nick and 0-day bot both let me know that there's a typo in this patch,
which I'll fix in v4:

diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index f7daa59ff14f..00d7baaf7949 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -223,7 +223,7 @@ dtc_cpp_flags  = -Wp,-MMD,$(depfile).pre.tmp
-nostdinc                    \
 objtool_args =                                                         \
        $(if $(CONFIG_UNWINDER_ORC),orc generate,check)                 \
        $(if $(part-of-module), --module,)                              \
-       $(if $(CONFIG_FRAME_POINTER), --no-fp,)                         \
+       $(if $(CONFIG_FRAME_POINTER),, --no-fp)                         \
        $(if $(CONFIG_GCOV_KERNEL), --no-unreachable,)                  \
        $(if $(CONFIG_RETPOLINE), --retpoline,)                         \
        $(if $(CONFIG_X86_SMAP), --uaccess,)                            \

Sami

On Fri, Sep 18, 2020 at 2:27 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Fri, Sep 18, 2020 at 01:14:19PM -0700, Sami Tolvanen wrote:
> > With LTO, LLVM bitcode won't be compiled into native code until
> > modpost_link, or modfinal for modules. This change postpones calls
> > to objtool until after these steps, and moves objtool_args to
> > Makefile.lib, so the arguments can be reused in Makefile.modfinal.
> >
> > Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
>
> Thanks for reorganizing this!
>
> Reviewed-by: Kees Cook <keescook@chromium.org>
>
> --
> Kees Cook
>
> --
> You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/202009181427.86DE61B%40keescook.
