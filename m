Return-Path: <SRS0=Emu/=SZ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 627DDC282DD
	for <linux-pci@archiver.kernel.org>; Tue, 23 Apr 2019 16:40:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 317E820645
	for <linux-pci@archiver.kernel.org>; Tue, 23 Apr 2019 16:40:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tZM1unYF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729281AbfDWQiZ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 23 Apr 2019 12:38:25 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:32848 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729458AbfDWQiV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 23 Apr 2019 12:38:21 -0400
Received: by mail-pl1-f196.google.com with SMTP id t16so7813088plo.0;
        Tue, 23 Apr 2019 09:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BwOUj6DWdN3iA6cgbfDcU43ryEgaCKSsuoVnmmfiYvA=;
        b=tZM1unYFIvpmzxfXqjgBWrIpWgbO8x5mlykfx+g4MiugNXXuijOBS+GqTikW1jKISg
         NqobuFafddCTQ+JIalIIwlL/53URcdBC7xTCiDmpjINgapHqmNCJzE2JcD/hic8MCXjs
         J7lRe1dsM3gh7O9yeZ92LWe0HTlO5TB/UXku2jJCSQB0Aiftz843llCpdJMI0FHRhIau
         yfF0XOKkDQxNqQF8AsjcMHZhvC7sTZfCyOGsEgyMqcGF5CQA0n6LRL4NueQXTNRXaLXB
         iMex/UtWgt+ezQ5BcIFCg/bJRpA/3VavSiTIc41ALjvbX41Vpnr3z+6BR/x5j3xWLkpQ
         0zQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BwOUj6DWdN3iA6cgbfDcU43ryEgaCKSsuoVnmmfiYvA=;
        b=AQwMkdajK4P/HBKL1htaev/OW4mueobm3uXN1dYU4s0vilNovliDmXGjCD/RogWT8n
         JJ0BhJa4vupLejtv/glQ1cygoI9f3MwBq5JwClx9v5bpThfAHT0vXWWu0613pXFB5Tq3
         XHwBZVgWa/JoF1aCJmn4HfoVQn4x/Qg55YUEXlcbcveqgxmVqWiO8s9dvNbJoj5t/DT0
         u+m5LPh33gro9LlODnxZR/ShR/dJkCpQ9cUi9dC7SLtyZf425Txmr5LxwVwhieDbvVKM
         CDDdUMpYdPgXBbVRGs2uCJQ+gvF+Wfc+JbHNF9Vq2y04QOJT1NJatiM+lDvE1xd0byDH
         sd4Q==
X-Gm-Message-State: APjAAAUGyrJdnWPBhra+spRXYjOTxdYkmNKOXQA9btZOwSFI44t4SiiN
        LG72yqjGu2+iEdLKH9zkTWA=
X-Google-Smtp-Source: APXvYqxfrRmUBhbHmsyN9wfFEdmN2iUGu9aAXAAk0gi4wFiCEZM64Aodt63M+ExKCVyPBtCEBGcXlA==
X-Received: by 2002:a17:902:9686:: with SMTP id n6mr27708241plp.282.1556037500432;
        Tue, 23 Apr 2019 09:38:20 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id v1sm24364801pff.81.2019.04.23.09.38.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Apr 2019 09:38:19 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, rjw@rjwysocki.net,
        linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        x86@kernel.org, fenghua.yu@intel.com,
        linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org,
        linux-gpio@vger.kernel.org, mchehab+samsung@kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v4 51/63] Documentation: x86: convert pti.txt to reST
Date:   Wed, 24 Apr 2019 00:29:20 +0800
Message-Id: <20190423162932.21428-52-changbin.du@gmail.com>
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
 Documentation/x86/index.rst            |  1 +
 Documentation/x86/{pti.txt => pti.rst} | 19 ++++++++++++++-----
 2 files changed, 15 insertions(+), 5 deletions(-)
 rename Documentation/x86/{pti.txt => pti.rst} (95%)

diff --git a/Documentation/x86/index.rst b/Documentation/x86/index.rst
index a0426ab156bd..1c675cef14d7 100644
--- a/Documentation/x86/index.rst
+++ b/Documentation/x86/index.rst
@@ -21,3 +21,4 @@ Linux x86 Support
    protection-keys
    intel_mpx
    amd-memory-encryption
+   pti
diff --git a/Documentation/x86/pti.txt b/Documentation/x86/pti.rst
similarity index 95%
rename from Documentation/x86/pti.txt
rename to Documentation/x86/pti.rst
index 5cd58439ad2d..44b98f99ca8a 100644
--- a/Documentation/x86/pti.txt
+++ b/Documentation/x86/pti.rst
@@ -1,9 +1,15 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+==========================
+Page Table Isolation (PTI)
+==========================
+
 Overview
 ========
 
-Page Table Isolation (pti, previously known as KAISER[1]) is a
+Page Table Isolation (pti, previously known as KAISER [1]_) is a
 countermeasure against attacks on the shared user/kernel address
-space such as the "Meltdown" approach[2].
+space such as the "Meltdown" approach [2]_.
 
 To mitigate this class of attacks, we create an independent set of
 page tables for use only when running userspace applications.  When
@@ -60,6 +66,7 @@ Protection against side-channel attacks is important.  But,
 this protection comes at a cost:
 
 1. Increased Memory Use
+
   a. Each process now needs an order-1 PGD instead of order-0.
      (Consumes an additional 4k per process).
   b. The 'cpu_entry_area' structure must be 2MB in size and 2MB
@@ -68,6 +75,7 @@ this protection comes at a cost:
      is decompressed, but no space in the kernel image itself.
 
 2. Runtime Cost
+
   a. CR3 manipulation to switch between the page table copies
      must be done at interrupt, syscall, and exception entry
      and exit (it can be skipped when the kernel is interrupted,
@@ -142,8 +150,9 @@ ideally doing all of these in parallel:
    interrupted, including nested NMIs.  Using "-c" boosts the rate of
    NMIs, and using two -c with separate counters encourages nested NMIs
    and less deterministic behavior.
+   ::
 
-	while true; do perf record -c 10000 -e instructions,cycles -a sleep 10; done
+      while true; do perf record -c 10000 -e instructions,cycles -a sleep 10; done
 
 4. Launch a KVM virtual machine.
 5. Run 32-bit binaries on systems supporting the SYSCALL instruction.
@@ -182,5 +191,5 @@ that are worth noting here.
    tended to be TLB invalidation issues.  Usually invalidating
    the wrong PCID, or otherwise missing an invalidation.
 
-1. https://gruss.cc/files/kaiser.pdf
-2. https://meltdownattack.com/meltdown.pdf
+.. [1] https://gruss.cc/files/kaiser.pdf
+.. [2] https://meltdownattack.com/meltdown.pdf
-- 
2.20.1

