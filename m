Return-Path: <SRS0=JtJR=AF=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BEFCC433E3
	for <linux-pci@archiver.kernel.org>; Wed, 24 Jun 2020 20:34:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0D212081A
	for <linux-pci@archiver.kernel.org>; Wed, 24 Jun 2020 20:34:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="egWHIaow"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406520AbgFXUdV (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 24 Jun 2020 16:33:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406495AbgFXUdR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 24 Jun 2020 16:33:17 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 190A2C061799
        for <linux-pci@vger.kernel.org>; Wed, 24 Jun 2020 13:33:17 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id c3so3518384ybp.8
        for <linux-pci@vger.kernel.org>; Wed, 24 Jun 2020 13:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=edIkT6p07lpLePHQP+aYqsXpIzZ2+6woe9Vgp5gIJI4=;
        b=egWHIaowycA2j4XZam7KmKMW2pQ89pwKSamnnESmMZjXlGrpDiBMEKX0ymsIpEUG5Q
         Q/5jq7wq9EUsrGut0D7nH0OzX+X6PmQ4BsvV+OFdyIwItO18fwnnqRcjLL/etsokICn2
         kJA/eOpcLnRws54bEMudJOUeKnPBfutms4HPc2YVoU7pUuEXirkoHEo/+ZivIPBIpcjm
         QAZkoUB6YhA3LjQHac3tKT7W83SDE0ybUBlgAkHod3lCaXJMmDghQ2Hjaer2BjebhMdJ
         6tJB8nkEwUWILUX4LAlqgG6pcwYlTLpv3LHaWpmgIRcC8eGvhD6AT800VKeaZEkZUUaI
         CVRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=edIkT6p07lpLePHQP+aYqsXpIzZ2+6woe9Vgp5gIJI4=;
        b=K1VwlK5WwuHdUqrNUXJ5UhiCoE6wE4PDtiUoAVgAkA175onLrq5aJSbSIunJegiz9r
         8YAXMy50b9tSqdlsu9kZiIc2Qy6IN1nKoPPVtQYL4pN9En0Zfzq98r92Kn+alK8Z9U4f
         MkO0xzQc0CR63H/lJ/G9ybvz2A5Jy66APVfUaAJGpXkU67wz1Zk6NqyOFbVZlgF+k727
         2NJvf8UNRjHBMlnFJKA0ilLiEFxsLNMT96KOPD6RVj4SGYc/wcImUOWH7dnJEMYmp+Aq
         e6Gu6+rIoc5UuAdqDy1AcPyl4rh/HzD2fCFy5E+mJQ8Ti5qD4vq/lxYrTnGdz1s454Lm
         KrKg==
X-Gm-Message-State: AOAM530GCaCYPJ/DppVqZLBmvuzhrpiwMmnim6hqZta9nWydJW9FnWgF
        ntfP5RBkjC0+ooB14mDUBMTospYaO3l4gPzWIP8=
X-Google-Smtp-Source: ABdhPJydy+dzRZtnkDF9CbEhIOBTVruIEpnrPFlxeYrxbEJR+QigE4MSYlaU55SmzK1okb/YgyaF3Z/PviJDUt9UdRg=
X-Received: by 2002:a25:2fc5:: with SMTP id v188mr45630243ybv.130.1593030796295;
 Wed, 24 Jun 2020 13:33:16 -0700 (PDT)
Date:   Wed, 24 Jun 2020 13:31:48 -0700
In-Reply-To: <20200624203200.78870-1-samitolvanen@google.com>
Message-Id: <20200624203200.78870-11-samitolvanen@google.com>
Mime-Version: 1.0
References: <20200624203200.78870-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
Subject: [PATCH 10/22] init: lto: fix PREL32 relocations
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        kernel-hardening@lists.openwall.com, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        x86@kernel.org, Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

With LTO, the compiler can rename static functions to avoid global
naming collisions. As initcall functions are typically static,
renaming can break references to them in inline assembly. This
change adds a global stub with a stable name for each initcall to
fix the issue when PREL32 relocations are used.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 include/linux/init.h | 30 ++++++++++++++++++++++++++----
 1 file changed, 26 insertions(+), 4 deletions(-)

diff --git a/include/linux/init.h b/include/linux/init.h
index af638cd6dd52..5b4bdc5a8399 100644
--- a/include/linux/init.h
+++ b/include/linux/init.h
@@ -209,26 +209,48 @@ extern bool initcall_debug;
  */
 #define __initcall_section(__sec, __iid)			\
 	#__sec ".init.." #__iid
+
+/*
+ * With LTO, the compiler can rename static functions to avoid
+ * global naming collisions. We use a global stub function for
+ * initcalls to create a stable symbol name whose address can be
+ * taken in inline assembly when PREL32 relocations are used.
+ */
+#define __initcall_stub(fn, __iid, id)				\
+	__initcall_name(initstub, __iid, id)
+
+#define __define_initcall_stub(__stub, fn)			\
+	int __init __stub(void)					\
+	{ 							\
+		return fn();					\
+	}							\
+	__ADDRESSABLE(__stub)
 #else
 #define __initcall_section(__sec, __iid)			\
 	#__sec ".init"
+
+#define __initcall_stub(fn, __iid, id)	fn
+
+#define __define_initcall_stub(__stub, fn)			\
+	__ADDRESSABLE(fn)
 #endif
 
 #ifdef CONFIG_HAVE_ARCH_PREL32_RELOCATIONS
-#define ____define_initcall(fn, __name, __sec)			\
-	__ADDRESSABLE(fn)					\
+#define ____define_initcall(fn, __stub, __name, __sec)		\
+	__define_initcall_stub(__stub, fn)			\
 	asm(".section	\"" __sec "\", \"a\"		\n"	\
 	    __stringify(__name) ":			\n"	\
-	    ".long	" #fn " - .			\n"	\
+	    ".long	" __stringify(__stub) " - .	\n"	\
 	    ".previous					\n");
 #else
-#define ____define_initcall(fn, __name, __sec)			\
+#define ____define_initcall(fn, __unused, __name, __sec)	\
 	static initcall_t __name __used 			\
 		__attribute__((__section__(__sec))) = fn;
 #endif
 
 #define __unique_initcall(fn, id, __sec, __iid)			\
 	____define_initcall(fn,					\
+		__initcall_stub(fn, __iid, id),			\
 		__initcall_name(initcall, __iid, id),		\
 		__initcall_section(__sec, __iid))
 
-- 
2.27.0.212.ge8ba1cc988-goog

