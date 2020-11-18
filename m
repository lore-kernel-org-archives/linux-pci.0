Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9EEBC8300F
	for <linux-pci@archiver.kernel.org>; Wed, 18 Nov 2020 22:08:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70BCC2054F
	for <linux-pci@archiver.kernel.org>; Wed, 18 Nov 2020 22:08:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bQOrgmvm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726815AbgKRWIH (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 18 Nov 2020 17:08:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727497AbgKRWIG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 18 Nov 2020 17:08:06 -0500
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F645C0613D6
        for <linux-pci@vger.kernel.org>; Wed, 18 Nov 2020 14:08:06 -0800 (PST)
Received: by mail-qt1-x84a.google.com with SMTP id z8so2637526qti.17
        for <linux-pci@vger.kernel.org>; Wed, 18 Nov 2020 14:08:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=sjtbZ3xOlxTCeGDsc49y7blbydcHA97ATmZyW4gNXi8=;
        b=bQOrgmvmWPVazHRiU7Sq4QuzywMs/XRdYpwqWAsr3kHc03SbDyK5DTQWLtd8FK91y3
         MW3u4WbsCuRU0vzooO+H4s9QpGHpW389VzEmQRcj4VcXdnUgwjt45eFo8ZBzXnE4fKeD
         r0bhLti12UpA9An41fbHwFUR8/vhwYOYVyPxJIh/IPwza3kbBFdHqpR6/KeizFCtTGWX
         6/8rBV+yRiy2gN2o7bFZ9jXivGRW7HEGEIIsWwtKVPHuDHa6XLj84LP/w+Xd2MEQ2bks
         50uwuy6B0tkC4/TW0Wy9OY8x1oFS6B2Qj3ExbMLuC+o5odwx/ZCNGDq1GT0ZZq/1Fcim
         a9Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=sjtbZ3xOlxTCeGDsc49y7blbydcHA97ATmZyW4gNXi8=;
        b=ia6lJBMJNWjGplgjMgTJOJOOasFb6J5IlRnyQKqR7aIEDlFbkKZt4pTCklmed2iSdS
         IcJlSzG+Gxq4hiCXk4tzoskWaePOMaTVSxm+FH4FRla+tB9ePWkyh4Ikua89wMFTwbFG
         O06If3IO3iZixyl4+7hmFnu9aB7EXYcXY4XJpw5/OHljaasPDCmG7oNzRadRy31S2tVU
         2eYKCzMOnb661j1g7pdEWYARzHfbxH3j+e2esH/R/3CWF7HGj55BU8QkrBsnU2pu+wOI
         IsDZ1udf5bIuZk5/eYPIjCzbDjSOK+ZMI/F0P2Mo/NEfpfEx6g0pwAqVtMQfFPy49yJR
         L58Q==
X-Gm-Message-State: AOAM532hmOPgePVpqnUU2io/cNi4w3+iLpEJjwMaGM6TTecT+ROz5klC
        jA9JSuBiXyUGuwnPukZJE3fIrVszUpgjwAtIZzg=
X-Google-Smtp-Source: ABdhPJwxDtudTv+lhKifrPzdR3GIyaaL24pwI7bpI9IrG2vb633hmg0Jt18S95SjawSbFeAc/hQylLYmz77E0BMzIoQ=
Sender: "samitolvanen via sendgmr" 
        <samitolvanen@samitolvanen1.mtv.corp.google.com>
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:f693:9fff:fef4:1b6d])
 (user=samitolvanen job=sendgmr) by 2002:a05:6214:c8e:: with SMTP id
 r14mr7292366qvr.21.1605737285331; Wed, 18 Nov 2020 14:08:05 -0800 (PST)
Date:   Wed, 18 Nov 2020 14:07:28 -0800
In-Reply-To: <20201118220731.925424-1-samitolvanen@google.com>
Message-Id: <20201118220731.925424-15-samitolvanen@google.com>
Mime-Version: 1.0
References: <20201118220731.925424-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH v7 14/17] arm64: vdso: disable LTO
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Will Deacon <will@kernel.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        kernel-hardening@lists.openwall.com, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Disable LTO for the vDSO by filtering out CC_FLAGS_LTO, as there's no
point in using link-time optimization for the small about of C code.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 arch/arm64/kernel/vdso/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/vdso/Makefile b/arch/arm64/kernel/vdso/Makefile
index d65f52264aba..50fe49fb4d95 100644
--- a/arch/arm64/kernel/vdso/Makefile
+++ b/arch/arm64/kernel/vdso/Makefile
@@ -30,7 +30,8 @@ ldflags-y := -shared -nostdlib -soname=linux-vdso.so.1 --hash-style=sysv	\
 ccflags-y := -fno-common -fno-builtin -fno-stack-protector -ffixed-x18
 ccflags-y += -DDISABLE_BRANCH_PROFILING
 
-CFLAGS_REMOVE_vgettimeofday.o = $(CC_FLAGS_FTRACE) -Os $(CC_FLAGS_SCS) $(GCC_PLUGINS_CFLAGS)
+CFLAGS_REMOVE_vgettimeofday.o = $(CC_FLAGS_FTRACE) -Os $(CC_FLAGS_SCS) $(GCC_PLUGINS_CFLAGS) \
+				$(CC_FLAGS_LTO)
 KASAN_SANITIZE			:= n
 UBSAN_SANITIZE			:= n
 OBJECT_FILES_NON_STANDARD	:= y
-- 
2.29.2.299.gdc1121823c-goog

