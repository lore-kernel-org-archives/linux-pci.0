Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25C51C433E0
	for <linux-pci@archiver.kernel.org>; Thu, 18 Mar 2021 18:51:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E086F64F1F
	for <linux-pci@archiver.kernel.org>; Thu, 18 Mar 2021 18:51:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232544AbhCRSuq (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 18 Mar 2021 14:50:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231590AbhCRSuO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 18 Mar 2021 14:50:14 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16F45C06175F
        for <linux-pci@vger.kernel.org>; Thu, 18 Mar 2021 11:50:14 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id a1so8846637ljp.2
        for <linux-pci@vger.kernel.org>; Thu, 18 Mar 2021 11:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Fbc9sU+W6vKEWiVuzKDAzNw80eLikWEk6fODgolKFf4=;
        b=gV9qbJJbak0NwyikP8/6txEAmG7g7SLhIJX+Fba6IeRHX5IoxW3jDRmclVA8qlMsfU
         kBomGiglv5B7gIvKdwq5SGwJtUllfBgQLIHwNh/WVAb97ZqgqeJTyXusK0PW1Wj+fYOv
         rl0s1N7K+FNq2o56hIXTtivX0CxG7t7dEc5d97ivUIvX37ZqHrzNwlcrq9j4CB6QD5AZ
         FeHFP2afJV+FdE2b5evL+4dEfkVW7uNreiqLUlcby8ZsFQAMpnQJcSvrJu2jiTgww+aJ
         381Y3D1oh2tZ8y5qgSnmZEVEwtk5rESCQTRFKxxhKk5x/kGAlFPIcPsl06+uQd4ls14G
         ZbQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Fbc9sU+W6vKEWiVuzKDAzNw80eLikWEk6fODgolKFf4=;
        b=VZIrPoQljKfYB4H0AM63g2AXd5Hf4RNZi6dgbLcxl4hCnkzWnknJG220ROtaiQpkIg
         tV1NnwEpws+RH6JPYxm2xPsnCr/WwhdO8/tn++fbL9y3MaHqxIxCoFbqEXuEaUAcv9AE
         BgUBF6yJFUCZoIBrXyCKAE6k/1IMHFelTeDkj35hCLXl9RuLqyVis8XygQheOCObvt9T
         WmOZYGqTUemNKQo/ripb3yo+vV+vwd5+FSBJpL0D1tQbuiYCEd6EtgwQO/Y/d9qJseEH
         7qj5nMcbf9EXv6F1ejCp6T6WzpeAm4VpCM61k5tNlqn+t54xNzk+2oeTBy5xJ7kXRr8A
         1afA==
X-Gm-Message-State: AOAM531J+H7YFFkvxqdICOx1eb0BTg8+EHyDXCeJ6V0s9ZE2WWVfLRQZ
        NQCkIT853mc6pU0EW4uYB+PoE+gl8QsmJWBP/2yNdg==
X-Google-Smtp-Source: ABdhPJyac78CV6QxdSD/anwHq7ZKXrz96rfsGARqrb7ZO61dgR01Qx1cNIoMLgd8++IChAjKUBiov3LjVFDjuzYsR2s=
X-Received: by 2002:a2e:b88b:: with SMTP id r11mr6028781ljp.495.1616093412369;
 Thu, 18 Mar 2021 11:50:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210318171111.706303-1-samitolvanen@google.com> <20210318171111.706303-6-samitolvanen@google.com>
In-Reply-To: <20210318171111.706303-6-samitolvanen@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 18 Mar 2021 11:50:00 -0700
Message-ID: <CAKwvOd=fWs6g2Bf2a_bA58_-uoWtVmNQnvrPxNhio4R5qGjcMQ@mail.gmail.com>
Subject: Re: [PATCH v2 05/17] workqueue: use WARN_ON_FUNCTION_MISMATCH
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>, Jessica Yu <jeyu@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Tejun Heo <tj@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        bpf <bpf@vger.kernel.org>, linux-hardening@vger.kernel.org,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        PCI <linux-pci@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Mar 18, 2021 at 10:11 AM Sami Tolvanen <samitolvanen@google.com> wrote:
>
> With CONFIG_CFI_CLANG, a callback function passed to
> __queue_delayed_work from a module points to a jump table entry
> defined in the module instead of the one used in the core kernel,
> which breaks function address equality in this check:
>
>   WARN_ON_ONCE(timer->function != delayed_work_timer_fn);
>
> Use WARN_ON_FUNCTION_MISMATCH() instead to disable the warning
> when CFI and modules are both enabled.

Does __cficanonical help with such comparisons? Or would that be a
very invasive change, if the concern was to try to keep these checks
in place for CONFIG_CFI_CLANG?

>
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> ---
>  kernel/workqueue.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/workqueue.c b/kernel/workqueue.c
> index 0d150da252e8..03fe07d2f39f 100644
> --- a/kernel/workqueue.c
> +++ b/kernel/workqueue.c
> @@ -1630,7 +1630,7 @@ static void __queue_delayed_work(int cpu, struct workqueue_struct *wq,
>         struct work_struct *work = &dwork->work;
>
>         WARN_ON_ONCE(!wq);
> -       WARN_ON_ONCE(timer->function != delayed_work_timer_fn);
> +       WARN_ON_FUNCTION_MISMATCH(timer->function, delayed_work_timer_fn);
>         WARN_ON_ONCE(timer_pending(timer));
>         WARN_ON_ONCE(!list_empty(&work->entry));
>
> --
> 2.31.0.291.g576ba9dcdaf-goog
>


--
Thanks,
~Nick Desaulniers
