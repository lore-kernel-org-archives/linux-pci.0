Return-Path: <SRS0=Emu/=SZ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63D3DC10F03
	for <linux-pci@archiver.kernel.org>; Tue, 23 Apr 2019 16:39:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31D5F20645
	for <linux-pci@archiver.kernel.org>; Tue, 23 Apr 2019 16:39:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YFVbYWgi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729122AbfDWQjd (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 23 Apr 2019 12:39:33 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:42503 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729340AbfDWQjI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 23 Apr 2019 12:39:08 -0400
Received: by mail-pl1-f195.google.com with SMTP id x15so3443031pln.9;
        Tue, 23 Apr 2019 09:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lKxrWq0DPWG2/ldiM614YNjWwPB+5TI6uHMpmONkiyA=;
        b=YFVbYWginTf8h5S0SDoTIVMpULpvCv6OKgMCGQDqwtjfHm8OF/amq8OwLtdHLRayBO
         BCBf0R5V6HXNxNjhfmUM5Z8W06HJKkSxtFC9rcQDXItwQ7sd1GLz5KFJNjvtjDhcCNIH
         /RJgCoDHVfa38Ky54CEuElWSUFLSK24t+ehRe+DHGfbWNSN1iU/aWSdUg48jiuxGOvbj
         PO+h0uNSBBAa78wGa8VboKo+0yvcd/nLNWy6MN9Ac9C8Rb5MdAZOsqGBZ70yJUEdDhP/
         SXpMj7o4tL0x2dxs68n7Rjm7Q08Cs0yd7ZrASV1VvAeSQiWYwohAAtRwixx0GvD0zyRc
         HAyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lKxrWq0DPWG2/ldiM614YNjWwPB+5TI6uHMpmONkiyA=;
        b=VbNvtZeiJoEu/zwP2n9DdiB0xhLVMASq3iNZBkVQjxOcWdoZGsFF8Et57ZrXqHT2ap
         h69SlRsWxfu3uw2+Ysg7NqgE6kTZTWmFuYYlUwAc3larLh5PSMQJnGlG46Jjg3CdMe3G
         W0ZLVasUQe0UhDbwwIEw6dM345j/Hv0E89V7mBE/01hDKxamKk/fiz1zknVJ+pBgk+WI
         NFNNsJs5Rk0YEzZFAuqDpFDdFLM7rYKsoggt79nMvuizQ0HFAdAlkDibJhMqi+gh7Ay1
         i5EyOmG61RiKkG/HPmWGhEm+bpO/FshTlM6aF8kvS3XwoswVvX6P/b1fYbg1Zt+21gDn
         uRMw==
X-Gm-Message-State: APjAAAVka7yL4Pm2eUyoRGQB+px/FE2Sm6zf4tO7BgaZlPuDYrEbifGN
        6EfNFjXm5qdCMQNhNw4zGQM=
X-Google-Smtp-Source: APXvYqyyiuJdfDhtn9sySZr3o/D6USw7potnUz8aWY3bi/Zm3hnxy6EcWxCQcMDnbzEmguum4Hqo4Q==
X-Received: by 2002:a17:902:e490:: with SMTP id cj16mr27318962plb.156.1556037547194;
        Tue, 23 Apr 2019 09:39:07 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id v1sm24364801pff.81.2019.04.23.09.39.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Apr 2019 09:39:06 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, rjw@rjwysocki.net,
        linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        x86@kernel.org, fenghua.yu@intel.com,
        linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org,
        linux-gpio@vger.kernel.org, mchehab+samsung@kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v4 60/63] Documentation: x86: convert x86_64/5level-paging.txt to reST
Date:   Wed, 24 Apr 2019 00:29:29 +0800
Message-Id: <20190423162932.21428-61-changbin.du@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190423162932.21428-1-changbin.du@gmail.com>
References: <20190423162932.21428-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This converts the plain text documentation to reStructuredText format and
add it to Sphinx TOC tree. No essential content change.

Signed-off-by: Changbin Du <changbin.du@gmail.com>
---
 .../{5level-paging.txt => 5level-paging.rst}     | 16 +++++++++++-----
 Documentation/x86/x86_64/index.rst               |  1 +
 2 files changed, 12 insertions(+), 5 deletions(-)
 rename Documentation/x86/x86_64/{5level-paging.txt => 5level-paging.rst} (91%)

diff --git a/Documentation/x86/x86_64/5level-paging.txt b/Documentation/x86/x86_64/5level-paging.rst
similarity index 91%
rename from Documentation/x86/x86_64/5level-paging.txt
rename to Documentation/x86/x86_64/5level-paging.rst
index 2432a5ef86d9..ab88a4514163 100644
--- a/Documentation/x86/x86_64/5level-paging.txt
+++ b/Documentation/x86/x86_64/5level-paging.rst
@@ -1,5 +1,11 @@
-== Overview ==
+.. SPDX-License-Identifier: GPL-2.0
 
+==============
+5-level paging
+==============
+
+Overview
+========
 Original x86-64 was limited by 4-level paing to 256 TiB of virtual address
 space and 64 TiB of physical address space. We are already bumping into
 this limit: some vendors offers servers with 64 TiB of memory today.
@@ -16,16 +22,17 @@ QEMU 2.9 and later support 5-level paging.
 Virtual memory layout for 5-level paging is described in
 Documentation/x86/x86_64/mm.txt
 
-== Enabling 5-level paging ==
 
+Enabling 5-level paging
+=======================
 CONFIG_X86_5LEVEL=y enables the feature.
 
 Kernel with CONFIG_X86_5LEVEL=y still able to boot on 4-level hardware.
 In this case additional page table level -- p4d -- will be folded at
 runtime.
 
-== User-space and large virtual address space ==
-
+User-space and large virtual address space
+==========================================
 On x86, 5-level paging enables 56-bit userspace virtual address space.
 Not all user space is ready to handle wide addresses. It's known that
 at least some JIT compilers use higher bits in pointers to encode their
@@ -58,4 +65,3 @@ One important case we need to handle here is interaction with MPX.
 MPX (without MAWA extension) cannot handle addresses above 47-bit, so we
 need to make sure that MPX cannot be enabled we already have VMA above
 the boundary and forbid creating such VMAs once MPX is enabled.
-
diff --git a/Documentation/x86/x86_64/index.rst b/Documentation/x86/x86_64/index.rst
index 4b65d29ef459..7b8c82151358 100644
--- a/Documentation/x86/x86_64/index.rst
+++ b/Documentation/x86/x86_64/index.rst
@@ -10,3 +10,4 @@ x86_64 Support
    boot-options
    uefi
    mm
+   5level-paging
-- 
2.20.1

