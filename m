Return-Path: <SRS0=JtJR=AF=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 478C4C433DF
	for <linux-pci@archiver.kernel.org>; Wed, 24 Jun 2020 20:34:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B2EF21582
	for <linux-pci@archiver.kernel.org>; Wed, 24 Jun 2020 20:34:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EWRzLy7u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406683AbgFXUee (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 24 Jun 2020 16:34:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406429AbgFXUdO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 24 Jun 2020 16:33:14 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 802BEC061799
        for <linux-pci@vger.kernel.org>; Wed, 24 Jun 2020 13:33:13 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id e192so3479158ybf.17
        for <linux-pci@vger.kernel.org>; Wed, 24 Jun 2020 13:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=RZTReFFMdjgTHNlONDHd9zt1v7eMyKbgxXLu5A5pzj0=;
        b=EWRzLy7ubn55a8LmKy3CDH4ngbdy7XK7KBx2ndgKQ/3d1qkgK3E2e2e0LoML9LtpAP
         te8DFa082g+gVIfEAqVPkw42n2K5N8oZDQPqI2EE+tN42iDW7P8u4zkwFKaeUaEIL3oq
         RsZa2tBkB8ErLDOh0+LYJEGFNduXUPYCZZp6PS5HSeXJMWIblGduZ6jmagNoIsWizsER
         wasijgerBJQ81R7rPMfgWDc43sju3PnN23fU0SKh+4T9fa3wRlwROOUy5biDfDpraPBM
         LfcrqPMgzOl+e9NbqEnHTOdpcfO4/PQ3tkVTmfAbrRs5+l+SSnKRsruNnEenHpqLqPiQ
         nuGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=RZTReFFMdjgTHNlONDHd9zt1v7eMyKbgxXLu5A5pzj0=;
        b=sbAbTUm399ULK4cKlrEtTGL6mm9RCHP9b4uHtg8oNdcLgPuFY45luPA/K+tC6EgZBC
         kNG+UoSvAu/PkqsupixqT91Dl1h6l4grQkj15gTIOfDZgVlf8TS9HG/9A2dO8ZT/Z7xA
         9qYEMLThgqIt21E/QCPSbDlg7w82GjMpm5PeHiVpVqI8iTHuj+grBBhKI/+1zvD0XfOv
         qK+w6JmuKNRThWxgt+5c9X7IN2+g2FbuwcRYTK0j+ZO3swUeU+bvT9ZKYIgX8lWAKPeI
         Sg7HytQu3JghSkuz2kZnQJJmq/9RruV7cRFJ6qGmJq6kVBH07tQPn0BGbamW/HTO7D9L
         SxHg==
X-Gm-Message-State: AOAM533cM9VewrOgLHqSGzNZqvJppgBiDxOIIOxGY6bCjRrt5eTLQjRF
        n5t0+VZ4M4cAEubbecCxxh7Pfj2CU0wWLB75Okc=
X-Google-Smtp-Source: ABdhPJyU2t1AXfcgSNz/10D8PjugKl8rMw6I/kYhEGKclSW1I55A11LPtvbV37/K4/NXZ5XrSzlUdSrpZ+Ia6K6teRs=
X-Received: by 2002:a25:4e0a:: with SMTP id c10mr44794280ybb.346.1593030792698;
 Wed, 24 Jun 2020 13:33:12 -0700 (PDT)
Date:   Wed, 24 Jun 2020 13:31:46 -0700
In-Reply-To: <20200624203200.78870-1-samitolvanen@google.com>
Message-Id: <20200624203200.78870-9-samitolvanen@google.com>
Mime-Version: 1.0
References: <20200624203200.78870-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
Subject: [PATCH 08/22] kbuild: lto: remove duplicate dependencies from .mod files
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

With LTO, llvm-nm prints out symbols for each archive member
separately, which results in a lot of duplicate dependencies in the
.mod file when CONFIG_TRIM_UNUSED_SYMS is enabled. When a module
consists of several compilation units, the output can exceed the
default xargs command size limit and split the dependency list to
multiple lines, which results in used symbols getting trimmed.

This change removes duplicate dependencies, which will reduce the
probability of this happening and makes .mod files smaller and
easier to read.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 scripts/Makefile.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 82977350f5a6..82b465ce3ca0 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -291,7 +291,7 @@ endef
 
 # List module undefined symbols (or empty line if not enabled)
 ifdef CONFIG_TRIM_UNUSED_KSYMS
-cmd_undef_syms = $(NM) $< | sed -n 's/^  *U //p' | xargs echo
+cmd_undef_syms = $(NM) $< | sed -n 's/^  *U //p' | sort -u | xargs echo
 else
 cmd_undef_syms = echo
 endif
-- 
2.27.0.212.ge8ba1cc988-goog

