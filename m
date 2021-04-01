Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FBDAC433ED
	for <linux-pci@archiver.kernel.org>; Thu,  1 Apr 2021 23:32:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CEE6610EA
	for <linux-pci@archiver.kernel.org>; Thu,  1 Apr 2021 23:32:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236256AbhDAXcr (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 1 Apr 2021 19:32:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236000AbhDAXc1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 1 Apr 2021 19:32:27 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4154EC0617A9
        for <linux-pci@vger.kernel.org>; Thu,  1 Apr 2021 16:32:27 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id x22so7444305ybi.1
        for <linux-pci@vger.kernel.org>; Thu, 01 Apr 2021 16:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=X7pKNQoykGsVEBpcKZlriYQJ1U+ZvEkb/I/sJpCEmoM=;
        b=BjeqB6czPiyblykb6PBqbuo0xYMJRyLf/oeNx84DE4R1fttODxk2bFz8ZBL75Fuvgw
         6F/tOm2Du9GhJn2mmq+CkjLQeGoCDGcqzKXhnGnQJQtJAyZ0HZhS6MkmhStYDbWSofMA
         68PW7Ihe35F8GXNvpgR24UJGY5/BeWu5RHMSwgkH8ITuRBjDaoNZjNQSTirk5hAXUmTp
         ZPjj5XXJCkZx73K1M8xMs4EZ67o5T3/A9AenBMN46C4kl1tYZt3s49w2u2H03hLXhD7j
         BsR61PVQf5F2iEv11ANBBbHx3c7rBoBvCxGY1fhbGX98hjjeSXxMbBi79tgKpmDn/EHg
         EaEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=X7pKNQoykGsVEBpcKZlriYQJ1U+ZvEkb/I/sJpCEmoM=;
        b=OXnWijE3DlMbX8d1k97x1IM6m+q+RAGjglKD3H6MmhJELQKS4H7mt8Ed18o5bimlI/
         o/nCuKAQTwGoiZLFHGbPWo5CqbPMyUDlIN+IUrcxu5us78JAgv3OVZdHGXwYXX4y7EKp
         L6pogNnZ8Cl9m3uxedbLHsJXYo/aXTfB5UdfSvv3/ugcOlrz9+34PzTThTNFFC5CRf3+
         XpXtX+8kph0AiWXeicuu7DUR3xDwAKdpbw4DAFRS1+oAAEKTlQ7KNophAg/DmexwAfXl
         inRKg/NApCYw5OufOvnfxBLYq+j7w4OuKLdnrnioZTtQTNdnj4QW6y/piG5gEnkkP+IO
         b+MA==
X-Gm-Message-State: AOAM531NFUL+TdwExfirhF8oQwHMX6byTi4rBC4nGooXvQm4QXF8OMRq
        9qYZmpUE2D7zcn1A+7Tl83egfeJXDdJe6TtkG1U=
X-Google-Smtp-Source: ABdhPJzdtiwlIR4zsNDFW5ioAx+wS4lt7L2o01q4Wrd2ySGr3BrZwRNBVOL+/rsGqUne1kRNRcwwzZrITvNNBaKI1jg=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:4cd1:da86:e91b:70b4])
 (user=samitolvanen job=sendgmr) by 2002:a25:25d7:: with SMTP id
 l206mr15429911ybl.43.1617319946420; Thu, 01 Apr 2021 16:32:26 -0700 (PDT)
Date:   Thu,  1 Apr 2021 16:32:02 -0700
In-Reply-To: <20210401233216.2540591-1-samitolvanen@google.com>
Message-Id: <20210401233216.2540591-5-samitolvanen@google.com>
Mime-Version: 1.0
References: <20210401233216.2540591-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.31.0.208.g409f899ff0-goog
Subject: [PATCH v5 04/18] module: ensure __cfi_check alignment
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>, Jessica Yu <jeyu@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Tejun Heo <tj@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>, bpf@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

CONFIG_CFI_CLANG_SHADOW assumes the __cfi_check() function is page
aligned and at the beginning of the .text section. While Clang would
normally align the function correctly, it fails to do so for modules
with no executable code.

This change ensures the correct __cfi_check() location and
alignment. It also discards the .eh_frame section, which Clang can
generate with certain sanitizers, such as CFI.

Link: https://bugs.llvm.org/show_bug.cgi?id=46293
Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Acked-by: Jessica Yu <jeyu@kernel.org>
---
 scripts/module.lds.S | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/scripts/module.lds.S b/scripts/module.lds.S
index 168cd27e6122..f8022b34e388 100644
--- a/scripts/module.lds.S
+++ b/scripts/module.lds.S
@@ -3,10 +3,20 @@
  * Archs are free to supply their own linker scripts.  ld will
  * combine them automatically.
  */
+#ifdef CONFIG_CFI_CLANG
+# include <asm/page.h>
+# define ALIGN_CFI 		ALIGN(PAGE_SIZE)
+# define SANITIZER_DISCARDS	*(.eh_frame)
+#else
+# define ALIGN_CFI
+# define SANITIZER_DISCARDS
+#endif
+
 SECTIONS {
 	/DISCARD/ : {
 		*(.discard)
 		*(.discard.*)
+		SANITIZER_DISCARDS
 	}
 
 	__ksymtab		0 : { *(SORT(___ksymtab+*)) }
@@ -40,7 +50,14 @@ SECTIONS {
 		*(.rodata..L*)
 	}
 
-	.text : { *(.text .text.[0-9a-zA-Z_]*) }
+	/*
+	 * With CONFIG_CFI_CLANG, we assume __cfi_check is at the beginning
+	 * of the .text section, and is aligned to PAGE_SIZE.
+	 */
+	.text : ALIGN_CFI {
+		*(.text.__cfi_check)
+		*(.text .text.[0-9a-zA-Z_]* .text..L.cfi*)
+	}
 }
 
 /* bring in arch-specific sections */
-- 
2.31.0.208.g409f899ff0-goog

