Return-Path: <SRS0=Emu/=SZ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90451C10F03
	for <linux-pci@archiver.kernel.org>; Tue, 23 Apr 2019 16:37:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 576F620643
	for <linux-pci@archiver.kernel.org>; Tue, 23 Apr 2019 16:37:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W9aNWgTM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729104AbfDWQhq (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 23 Apr 2019 12:37:46 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:39022 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728560AbfDWQhp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 23 Apr 2019 12:37:45 -0400
Received: by mail-pl1-f196.google.com with SMTP id e92so6007725plb.6;
        Tue, 23 Apr 2019 09:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=G+5WsbuuHSwf0oNxPHkpZsl8HtDzIrn5jcvXnz9HzZI=;
        b=W9aNWgTM8EbN+mC6b34M7J0nnY27HqdhHi7nZRkn7BjXXLahzO2l5wEhrmsjSQn7k/
         Yxsa6sdPKpEMYBS1yMJ0rWKGWzt8vBcW/7enYQ63n4LNQRKRuN5IBEM3aCxtvwwY7dLG
         ZDaEyV8CX9w1zNClkWW3jaMw5+E0CEDzQz4n/WRSrOlXua4KTH0y3QrJ+k8n8auyIJCY
         MaiLjGf/SvRc5Pn83A6pvkqlyhIYJFTK5l0J0noF3FfizqPm1nnAEIhL4hmk2MVZnmyD
         79bpzgo5UrYzLf4tGv9Af1GWzTLJHp75Vi+uap9jM+nCzhhyT8UdyeEHkhCCeCJt4wud
         YYFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=G+5WsbuuHSwf0oNxPHkpZsl8HtDzIrn5jcvXnz9HzZI=;
        b=QoQ10R2lTmwrTHIbDE6lnHMUvxVpK1hNZsR57ise0sLQR00hjsgsHdDzxHeLZ/Ws6I
         B0zWA+gCwWv9SiuqLxGnOFnqm4Bwm0GYqljyZrsugEL8QNi0M1HTqP8/RYwLngkMGgSf
         HJJbQ5ruwtWGSY5UMFRrVjlMNYlGea6IbYETOj6UoyoE8PVZkqR/MqP0y65XB0OW81MP
         5Egf4nOW3+cDdAn0glrjVdUhFOMjoiKKisgm/rmW52buQyGbGi5BDQslz2tKhvGybl5d
         3i5ohsTL/PaWVXGSQONJWk2BqTtLCx4X42fQc+JZuJBfCBrOdK8y2hZBAY80Z4rTop+H
         bn/w==
X-Gm-Message-State: APjAAAWcKGWHXKCIHhAJuxQa8x2nY270h6GscmBhfsRMQODzAG3zE57h
        lDkXrIMetRcYJKbdbnTr3HM=
X-Google-Smtp-Source: APXvYqyDAYH7RKDhGTJRRH30tHOaxD9N9waBQO86dyj+4f4wEhsTTWbXAFeIVvpfM0LsQGX1daL5kQ==
X-Received: by 2002:a17:902:7294:: with SMTP id d20mr19674924pll.300.1556037464729;
        Tue, 23 Apr 2019 09:37:44 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id v1sm24364801pff.81.2019.04.23.09.37.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Apr 2019 09:37:43 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, rjw@rjwysocki.net,
        linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        x86@kernel.org, fenghua.yu@intel.com,
        linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org,
        linux-gpio@vger.kernel.org, mchehab+samsung@kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v4 45/63] Documentation: x86: convert tlb.txt to reST
Date:   Wed, 24 Apr 2019 00:29:14 +0800
Message-Id: <20190423162932.21428-46-changbin.du@gmail.com>
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
 Documentation/x86/{tlb.txt => tlb.rst} | 30 ++++++++++++++++----------
 2 files changed, 20 insertions(+), 11 deletions(-)
 rename Documentation/x86/{tlb.txt => tlb.rst} (81%)

diff --git a/Documentation/x86/index.rst b/Documentation/x86/index.rst
index 9a0b5f38ef6b..fd54b859db9b 100644
--- a/Documentation/x86/index.rst
+++ b/Documentation/x86/index.rst
@@ -15,3 +15,4 @@ Linux x86 Support
    entry_64
    earlyprintk
    zero-page
+   tlb
diff --git a/Documentation/x86/tlb.txt b/Documentation/x86/tlb.rst
similarity index 81%
rename from Documentation/x86/tlb.txt
rename to Documentation/x86/tlb.rst
index 6a0607b99ed8..82ec58ae63a8 100644
--- a/Documentation/x86/tlb.txt
+++ b/Documentation/x86/tlb.rst
@@ -1,5 +1,12 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=======
+The TLB
+=======
+
 When the kernel unmaps or modified the attributes of a range of
 memory, it has two choices:
+
  1. Flush the entire TLB with a two-instruction sequence.  This is
     a quick operation, but it causes collateral damage: TLB entries
     from areas other than the one we are trying to flush will be
@@ -10,6 +17,7 @@ memory, it has two choices:
     damage to other TLB entries.
 
 Which method to do depends on a few things:
+
  1. The size of the flush being performed.  A flush of the entire
     address space is obviously better performed by flushing the
     entire TLB than doing 2^48/PAGE_SIZE individual flushes.
@@ -33,7 +41,7 @@ well.  There is essentially no "right" point to choose.
 You may be doing too many individual invalidations if you see the
 invlpg instruction (or instructions _near_ it) show up high in
 profiles.  If you believe that individual invalidations being
-called too often, you can lower the tunable:
+called too often, you can lower the tunable::
 
 	/sys/kernel/debug/x86/tlb_single_page_flush_ceiling
 
@@ -43,7 +51,7 @@ Setting it to 1 is a very conservative setting and it should
 never need to be 0 under normal circumstances.
 
 Despite the fact that a single individual flush on x86 is
-guaranteed to flush a full 2MB [1], hugetlbfs always uses the full
+guaranteed to flush a full 2MB [1]_, hugetlbfs always uses the full
 flushes.  THP is treated exactly the same as normal memory.
 
 You might see invlpg inside of flush_tlb_mm_range() show up in
@@ -54,15 +62,15 @@ Essentially, you are balancing the cycles you spend doing invlpg
 with the cycles that you spend refilling the TLB later.
 
 You can measure how expensive TLB refills are by using
-performance counters and 'perf stat', like this:
+performance counters and 'perf stat', like this::
 
-perf stat -e
-	cpu/event=0x8,umask=0x84,name=dtlb_load_misses_walk_duration/,
-	cpu/event=0x8,umask=0x82,name=dtlb_load_misses_walk_completed/,
-	cpu/event=0x49,umask=0x4,name=dtlb_store_misses_walk_duration/,
-	cpu/event=0x49,umask=0x2,name=dtlb_store_misses_walk_completed/,
-	cpu/event=0x85,umask=0x4,name=itlb_misses_walk_duration/,
-	cpu/event=0x85,umask=0x2,name=itlb_misses_walk_completed/
+  perf stat -e
+    cpu/event=0x8,umask=0x84,name=dtlb_load_misses_walk_duration/,
+    cpu/event=0x8,umask=0x82,name=dtlb_load_misses_walk_completed/,
+    cpu/event=0x49,umask=0x4,name=dtlb_store_misses_walk_duration/,
+    cpu/event=0x49,umask=0x2,name=dtlb_store_misses_walk_completed/,
+    cpu/event=0x85,umask=0x4,name=itlb_misses_walk_duration/,
+    cpu/event=0x85,umask=0x2,name=itlb_misses_walk_completed/
 
 That works on an IvyBridge-era CPU (i5-3320M).  Different CPUs
 may have differently-named counters, but they should at least
@@ -70,6 +78,6 @@ be there in some form.  You can use pmu-tools 'ocperf list'
 (https://github.com/andikleen/pmu-tools) to find the right
 counters for a given CPU.
 
-1. A footnote in Intel's SDM "4.10.4.2 Recommended Invalidation"
+.. [1] A footnote in Intel's SDM "4.10.4.2 Recommended Invalidation"
    says: "One execution of INVLPG is sufficient even for a page
    with size greater than 4 KBytes."
-- 
2.20.1

