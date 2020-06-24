Return-Path: <SRS0=JtJR=AF=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEF8AC433E0
	for <linux-pci@archiver.kernel.org>; Wed, 24 Jun 2020 20:33:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD0B72080C
	for <linux-pci@archiver.kernel.org>; Wed, 24 Jun 2020 20:33:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZOpDZdrG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406604AbgFXUdh (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 24 Jun 2020 16:33:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406599AbgFXUdg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 24 Jun 2020 16:33:36 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BE0EC061796
        for <linux-pci@vger.kernel.org>; Wed, 24 Jun 2020 13:33:35 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id x6so2453328qtq.1
        for <linux-pci@vger.kernel.org>; Wed, 24 Jun 2020 13:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=39oSk63TLcybcU14SgKvCDK3H6XzHtEtduXPCr/44ss=;
        b=ZOpDZdrGdHh1ZJonf0E/5dDbHERSe6TbCFmdB2U6jPIiwcNANMbLkyJvmpov2k2xOy
         UVWsqBFfeytL+Hgc/oR6FsAd9G11hUgAXJsCWawlND5MVBWd0mWD5Dc0EmC9ABVsRrwk
         SuNrnMuN7GhuqelKUl2otkPK4jEY0L0Bm6whau77q3fZbpcyNGO1mB7+EOqkQJEsefdW
         zLLLl7cpOUj8LxrFN5V51O7w7SPh0uXELCQRumvXzfHQsZ4xwEEn1hGOm5BLrbAhkADT
         mOeNJdhYt+ZgbwtN0PEW0MGrw4iretwo3Lq6tyaoaAFryjr8t8wGNBEOp88gmFSQ4dk6
         T0OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=39oSk63TLcybcU14SgKvCDK3H6XzHtEtduXPCr/44ss=;
        b=kXHxc9m7cHSPFc3KH3HWfV5zULe1GIxs6G+u3mqVYcO5bxF/vmn4yZduXo5ZfVclAT
         T12tNlIxOLcAixvBSwlhLx8KzJEcesx2a7zA20lBDYQCfiRmRQ6PRgNV1N5NH20o3ijE
         QG9jVFm3wqCT2Jd/9mTGN7U0X/ZtvOcxIAI+ikhD42D3eF16QLgDZGsEmrXi5RBYQmDR
         16wRN6eMk1yUOtLLu1GFGSGRLDLI3iEsZ4qlpo3rNbRTO3bYGdb+IyNQSdoWudeO6j0S
         tmRw/KUnjbFS1k1ZgSwRN7Cs0JuLtV8FOqI/FTKYKT3vBazJQk0Qy4nZeoiPuJtlrSz1
         E0DQ==
X-Gm-Message-State: AOAM530S+98ixdT6Y4p2VIFPogzCrGEaoelXZdELjNY4lCs9SHP2ZN3R
        LAkTFyczlzfg2B3a90ZKqc5fHngJopcTEsei0aY=
X-Google-Smtp-Source: ABdhPJzI2BesdcUkxRPNmsNayE+wa07nV1TDxi5hKxZeEiEV2jo0nWBCJ/1Nmj0kWHXA23yigO5wL2sAexNblZcBJws=
X-Received: by 2002:ad4:52e2:: with SMTP id p2mr33679309qvu.100.1593030814530;
 Wed, 24 Jun 2020 13:33:34 -0700 (PDT)
Date:   Wed, 24 Jun 2020 13:31:58 -0700
In-Reply-To: <20200624203200.78870-1-samitolvanen@google.com>
Message-Id: <20200624203200.78870-21-samitolvanen@google.com>
Mime-Version: 1.0
References: <20200624203200.78870-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
Subject: [PATCH 20/22] x86, ftrace: disable recordmcount for ftrace_make_nop
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

Ignore mcount relocations in ftrace_make_nop.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 arch/x86/kernel/ftrace.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kernel/ftrace.c b/arch/x86/kernel/ftrace.c
index 51504566b3a6..c3b28b81277b 100644
--- a/arch/x86/kernel/ftrace.c
+++ b/arch/x86/kernel/ftrace.c
@@ -121,6 +121,7 @@ ftrace_modify_code_direct(unsigned long ip, const char *old_code,
 	return 0;
 }
 
+__nomcount
 int ftrace_make_nop(struct module *mod, struct dyn_ftrace *rec, unsigned long addr)
 {
 	unsigned long ip = rec->ip;
-- 
2.27.0.212.ge8ba1cc988-goog

