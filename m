Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC170C4332E
	for <linux-pci@archiver.kernel.org>; Fri, 12 Mar 2021 00:50:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A07C564FA8
	for <linux-pci@archiver.kernel.org>; Fri, 12 Mar 2021 00:50:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231489AbhCLAuR (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 11 Mar 2021 19:50:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231398AbhCLAtv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 11 Mar 2021 19:49:51 -0500
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EFD3C061764
        for <linux-pci@vger.kernel.org>; Thu, 11 Mar 2021 16:49:50 -0800 (PST)
Received: by mail-qv1-xf49.google.com with SMTP id b15so16460044qvz.15
        for <linux-pci@vger.kernel.org>; Thu, 11 Mar 2021 16:49:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=x7nmddhtCAFSgIOj2697qGLSdd5adJgwaMu7EWSa7uE=;
        b=Xh/nq41/9MEWxm6t2iYy7IPJewLjv0iS/7KYlIJdOJ3bOfF46JUZMMZbt/Lbf7/LKe
         0C1tO2vPCIwQ5PGJSYXZJ039Dvi3EAoKQxVkFOcDDW/pgCQxSf5VfmNszsM1rX066DfV
         ABqN34EZoCufg1IuApfGtoKYh4hGj4odHN2v6D0PPbtcxnhTw5RJfO/aIZwlt02AZCo2
         HzHNQ6tS4vuStQQN4mpWyf+FUX+6L5uoIMBHOzFVAksdP/fKz3Mbmqp3eMuDvo3Z6d4F
         sEuuF7s32uR5mzuuW48zmaIsJUCAxpxJgvCXO0Q3ix21UAaACo2gUAOvee/rcFn3OFF1
         XAhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=x7nmddhtCAFSgIOj2697qGLSdd5adJgwaMu7EWSa7uE=;
        b=ccCzw9sBNXhlXd9Aewcw1DMU6J5yhL2V1ctH58nVKhyL9WDJvCW3Y9/+niPfpZ/YSx
         y3JBQrlZ9ZcUYy61L18w5dTj48lU1k8sbkda47uENmRj1zO+0nhu7XECyr/duEezpkVc
         ukEoiGL66pmAv+iQ7acRwHRgxlls5EYY0Vg6IJ4FEzucQgtH6mNuIGnlcS2ZuoXzk5aC
         wtuLaMHloM/NOoGH8MP54P9fpgyvZHtCiHVpFk5UzQIahmiJZvmR53vRmc/pvr+rB+F+
         l5/C/iE8+LZn8uXNs1lKtMNmKoScvhUWwcEI/7nmoiYOfCe7X/yAKeoSXiQmdrV8hU7i
         /fGg==
X-Gm-Message-State: AOAM531B5fuBT0kaz8ffoNdaYMR8RMf3ivR6dnangPymGscPTSk9HYGc
        LMudfj+LNo9CYwN34Hte4PURiXSetNgJXjUMaHw=
X-Google-Smtp-Source: ABdhPJwmptuqD0+7nMK5L7NKwSOAsdIsIjIk7X0BlSf+Uv+Hui3fWlJBQOKwQ25g86AaX73W7AVFnXUyawNQmB/PfgY=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:c86b:8269:af92:55a])
 (user=samitolvanen job=sendgmr) by 2002:ad4:4904:: with SMTP id
 bh4mr9878463qvb.53.1615510189517; Thu, 11 Mar 2021 16:49:49 -0800 (PST)
Date:   Thu, 11 Mar 2021 16:49:17 -0800
In-Reply-To: <20210312004919.669614-1-samitolvanen@google.com>
Message-Id: <20210312004919.669614-16-samitolvanen@google.com>
Mime-Version: 1.0
References: <20210312004919.669614-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
Subject: [PATCH 15/17] arm64: add __nocfi to __apply_alternatives
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>, Jessica Yu <jeyu@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Tejun Heo <tj@kernel.org>,
        bpf@vger.kernel.org, linux-hardening@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kbuild@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

__apply_alternatives makes indirect calls to functions whose address
is taken in assembly code using the alternative_cb macro. With
non-canonical CFI, the compiler won't replace these function
references with the jump table addresses, which trips CFI. Disable CFI
checking in the function to work around the issue.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 arch/arm64/kernel/alternative.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/alternative.c b/arch/arm64/kernel/alternative.c
index 1184c44ea2c7..abc84636af07 100644
--- a/arch/arm64/kernel/alternative.c
+++ b/arch/arm64/kernel/alternative.c
@@ -133,8 +133,8 @@ static void clean_dcache_range_nopatch(u64 start, u64 end)
 	} while (cur += d_size, cur < end);
 }
 
-static void __apply_alternatives(void *alt_region,  bool is_module,
-				 unsigned long *feature_mask)
+static void __nocfi __apply_alternatives(void *alt_region,  bool is_module,
+					 unsigned long *feature_mask)
 {
 	struct alt_instr *alt;
 	struct alt_region *region = alt_region;
-- 
2.31.0.rc2.261.g7f71774620-goog

