Return-Path: <SRS0=cWhH=CM=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC76CC2D0A8
	for <linux-pci@archiver.kernel.org>; Thu,  3 Sep 2020 20:35:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C26D220722
	for <linux-pci@archiver.kernel.org>; Thu,  3 Sep 2020 20:35:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="jsA0R90V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729232AbgICUfb (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 3 Sep 2020 16:35:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729558AbgICUcs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Sep 2020 16:32:48 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BCA0C0619EC
        for <linux-pci@vger.kernel.org>; Thu,  3 Sep 2020 13:31:35 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id r21so2490884pgv.6
        for <linux-pci@vger.kernel.org>; Thu, 03 Sep 2020 13:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=1wwsKOGiECV1D1KgEHVbv0B/BweA4F/I9dw72JmCR3Y=;
        b=jsA0R90VNx0CoNdYrwoyOulsyiH5eOY2B2rBuxLOroD3N8gF6y68Uc74RwL8AKswR5
         n5/cBj7T/lyKXDy+P6JEI3be0GGmxiSkgHJmFktuKctZm2r28JRNmXt3g4bRrATpRRJj
         AKOpxNPAVu2AFG1rMtyHbfAjRlhyxI5DXqho5Y5dgitaesdKWb1R2Xlfv4eCDShyWxYd
         M2olQjWDVjBt6grqHSaDbsq6b9joIjXKtUCXnqfaiFE3kVTOyDzHYaowglyC6rRbuC8n
         ZMsNaxWGpDQCuE51B+THxTbQeMBeUvq6W0Zdbe2AYAQZkL71Lk4+kzlFUo83wtb7N8s5
         fiJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=1wwsKOGiECV1D1KgEHVbv0B/BweA4F/I9dw72JmCR3Y=;
        b=RFjt5gGnCwluYsWmt+U18dAmo8e1njD6qVvYk13zVEiedD7+kiV1rGlWVOrwUkH20o
         fB/bs1HMijd52v1wueEP8ZG24wlarDVKFocYGtenRiKcLRJuFfkTeWwLeena4Lugc6wj
         DIZTgAuP7fGs9iP61nE/v0To/wLbDC9tPFW8COnoAKu7dS45lFYGgHmwTvFc26YUoAVq
         tDECRfrJ1/TawrWUBNMx4Tuh21vTBj5/fyHTyva/c24FWsvbYyOhhlwKQzfqopoKBqt5
         8FsWU0AF2PXRgAy1IpOT2OW4HRxQtINCLZrYK52hoC+xqdMkMLud5bgTgC6acGKw0wYv
         u2/g==
X-Gm-Message-State: AOAM5326K256rdP012rUSxnfe1e+VSUI/o1BsHUh+i9SV2ElrJx1QB3r
        sXz4TzW80uq83UkccjHnRjxG9HN5LNZhc3tmm8k=
X-Google-Smtp-Source: ABdhPJwEKrxzd5NrBrajDh1vcsnhdiTwGRM7+BFQV4hZChNnFjkX2yaVuQmX8BQu56ntgdFiR9mN2xnv8SJVdSGGSeE=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:f693:9fff:fef4:1b6d])
 (user=samitolvanen job=sendgmr) by 2002:a17:90b:384c:: with SMTP id
 nl12mr4502047pjb.205.1599165094662; Thu, 03 Sep 2020 13:31:34 -0700 (PDT)
Date:   Thu,  3 Sep 2020 13:30:44 -0700
In-Reply-To: <20200903203053.3411268-1-samitolvanen@google.com>
Message-Id: <20200903203053.3411268-20-samitolvanen@google.com>
Mime-Version: 1.0
References: <20200624203200.78870-1-samitolvanen@google.com> <20200903203053.3411268-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.28.0.526.ge36021eeef-goog
Subject: [PATCH v2 19/28] scripts/mod: disable LTO for empty.c
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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

With CONFIG_LTO_CLANG, clang generates LLVM IR instead of ELF object
files. As empty.o is used for probing target properties, disable LTO
for it to produce an object file instead.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 scripts/mod/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/mod/Makefile b/scripts/mod/Makefile
index 78071681d924..c9e38ad937fd 100644
--- a/scripts/mod/Makefile
+++ b/scripts/mod/Makefile
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 OBJECT_FILES_NON_STANDARD := y
+CFLAGS_REMOVE_empty.o += $(CC_FLAGS_LTO)
 
 hostprogs-always-y	+= modpost mk_elfconfig
 always-y		+= empty.o
-- 
2.28.0.402.g5ffc5be6b7-goog

