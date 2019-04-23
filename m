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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C893C282DD
	for <linux-pci@archiver.kernel.org>; Tue, 23 Apr 2019 16:39:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C73EB20645
	for <linux-pci@archiver.kernel.org>; Tue, 23 Apr 2019 16:39:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P+gYd8bU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729516AbfDWQih (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 23 Apr 2019 12:38:37 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41469 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728972AbfDWQih (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 23 Apr 2019 12:38:37 -0400
Received: by mail-pf1-f193.google.com with SMTP id 188so7762630pfd.8;
        Tue, 23 Apr 2019 09:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=j70G0amKcQXuPLeLIbM+m355FLoVLcQ+hAcLiiC/LxY=;
        b=P+gYd8bURGDxOzt66FfFiqD7ZCxs41XrIGFn/Pez46j/Q5lj4mwTqyMXXetbGWHP0U
         Zn1x6xz3oYIuH8U5++1TOmhyWTHjAkLlURx5CQlWPT7Zmm55kEUP8m/HLnJhWy5Di3Pa
         IWc6K6cC+x/S+5sD3pSdFydwm0XnINaaRtkpKs/Z4qlKSoW1r4TvZpV0QNsiKnUqOMAw
         juqvDMRfdTIOOvuLi3uXmUb5LiXueIy3MKKmZNbC0nFNjBYVkHR/Co79wgIFqvcewdaS
         wduNrtHoUorc9G0JgOpCy3+PmFCJknsEmcrdVzM2ivodoPo8+ESxbR+YQkp8C0tkuZjT
         RVpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j70G0amKcQXuPLeLIbM+m355FLoVLcQ+hAcLiiC/LxY=;
        b=Y780F6NqQValMwBSTzyqw1bZeip99ArTbmMkm/dEco+9LSKEs1KZwgAvXjYe5p7XZL
         FvAByrQJbJBOj8CjfDcJFBZzRPmNxMOUPFoq+orRN+H3LJ+KxIMQp9HYKd8VllgmIN69
         xENFNgl+79Nsp/4GnXvXboy/BIyC3/8PjjjBlGHqi7AjWSieMJKJ18K0q2SzloP834cF
         mMKpoupTbay5mc5LeNCAZMo8wOFVidH0dfuE6rCrl0PZq/Op3mEQaoMq7Luf7m+oZLV+
         Pod6yxvXPXPefGgtMMpxCxHDemRa3RBehkeQp4Qp2lp2t3HA8/w06GN9wBtoUKdoEWvZ
         i+WQ==
X-Gm-Message-State: APjAAAXPfCdYrADb3ASMNPrVokmvZRxilpW3OPiMEUzvU4htOqKojd+R
        aks+aRedjc+vtkrTCA68Rr3yGVdB
X-Google-Smtp-Source: APXvYqwTF+pJKqW6guT+W2qnSkjS5yj5xKQ51OL23k9fsqvZGy93L08hKqKjmjQws5cUu1UqjxDaHw==
X-Received: by 2002:a63:2c06:: with SMTP id s6mr25690634pgs.245.1556037516314;
        Tue, 23 Apr 2019 09:38:36 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id v1sm24364801pff.81.2019.04.23.09.38.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Apr 2019 09:38:35 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, rjw@rjwysocki.net,
        linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        x86@kernel.org, fenghua.yu@intel.com,
        linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org,
        linux-gpio@vger.kernel.org, mchehab+samsung@kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v4 54/63] Documentation: x86: convert orc-unwinder.txt to reST
Date:   Wed, 24 Apr 2019 00:29:23 +0800
Message-Id: <20190423162932.21428-55-changbin.du@gmail.com>
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
 Documentation/x86/index.rst                   |  1 +
 .../{orc-unwinder.txt => orc-unwinder.rst}    | 27 ++++++++++---------
 2 files changed, 16 insertions(+), 12 deletions(-)
 rename Documentation/x86/{orc-unwinder.txt => orc-unwinder.rst} (93%)

diff --git a/Documentation/x86/index.rst b/Documentation/x86/index.rst
index 4e9fa2b046df..c41c17906b6d 100644
--- a/Documentation/x86/index.rst
+++ b/Documentation/x86/index.rst
@@ -14,6 +14,7 @@ Linux x86 Support
    kernel-stacks
    entry_64
    earlyprintk
+   orc-unwinder
    zero-page
    tlb
    mtrr
diff --git a/Documentation/x86/orc-unwinder.txt b/Documentation/x86/orc-unwinder.rst
similarity index 93%
rename from Documentation/x86/orc-unwinder.txt
rename to Documentation/x86/orc-unwinder.rst
index cd4b29be29af..d811576c1f3e 100644
--- a/Documentation/x86/orc-unwinder.txt
+++ b/Documentation/x86/orc-unwinder.rst
@@ -1,8 +1,11 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+============
 ORC unwinder
 ============
 
 Overview
---------
+========
 
 The kernel CONFIG_UNWINDER_ORC option enables the ORC unwinder, which is
 similar in concept to a DWARF unwinder.  The difference is that the
@@ -23,12 +26,12 @@ correlate instruction addresses with their stack states at run time.
 
 
 ORC vs frame pointers
----------------------
+=====================
 
 With frame pointers enabled, GCC adds instrumentation code to every
 function in the kernel.  The kernel's .text size increases by about
 3.2%, resulting in a broad kernel-wide slowdown.  Measurements by Mel
-Gorman [1] have shown a slowdown of 5-10% for some workloads.
+Gorman [1]_ have shown a slowdown of 5-10% for some workloads.
 
 In contrast, the ORC unwinder has no effect on text size or runtime
 performance, because the debuginfo is out of band.  So if you disable
@@ -55,7 +58,7 @@ depending on the kernel config.
 
 
 ORC vs DWARF
-------------
+============
 
 ORC debuginfo's advantage over DWARF itself is that it's much simpler.
 It gets rid of the complex DWARF CFI state machine and also gets rid of
@@ -65,7 +68,7 @@ mission critical oops code.
 
 The simpler debuginfo format also enables the unwinder to be much faster
 than DWARF, which is important for perf and lockdep.  In a basic
-performance test by Jiri Slaby [2], the ORC unwinder was about 20x
+performance test by Jiri Slaby [2]_, the ORC unwinder was about 20x
 faster than an out-of-tree DWARF unwinder.  (Note: That measurement was
 taken before some performance tweaks were added, which doubled
 performance, so the speedup over DWARF may be closer to 40x.)
@@ -85,7 +88,7 @@ still be able to control the format, e.g. no complex state machines.
 
 
 ORC unwind table generation
----------------------------
+===========================
 
 The ORC data is generated by objtool.  With the existing compile-time
 stack metadata validation feature, objtool already follows all code
@@ -133,7 +136,7 @@ objtool follows GCC code quite well.
 
 
 Unwinder implementation details
--------------------------------
+===============================
 
 Objtool generates the ORC data by integrating with the compile-time
 stack metadata validation feature, which is described in detail in
@@ -154,7 +157,7 @@ subset of the table needs to be searched.
 
 
 Etymology
----------
+=========
 
 Orcs, fearsome creatures of medieval folklore, are the Dwarves' natural
 enemies.  Similarly, the ORC unwinder was created in opposition to the
@@ -162,7 +165,7 @@ complexity and slowness of DWARF.
 
 "Although Orcs rarely consider multiple solutions to a problem, they do
 excel at getting things done because they are creatures of action, not
-thought." [3]  Similarly, unlike the esoteric DWARF unwinder, the
+thought." [3]_  Similarly, unlike the esoteric DWARF unwinder, the
 veracious ORC unwinder wastes no time or siloconic effort decoding
 variable-length zero-extended unsigned-integer byte-coded
 state-machine-based debug information entries.
@@ -174,6 +177,6 @@ brutal, unyielding efficiency.
 ORC stands for Oops Rewind Capability.
 
 
-[1] https://lkml.kernel.org/r/20170602104048.jkkzssljsompjdwy@suse.de
-[2] https://lkml.kernel.org/r/d2ca5435-6386-29b8-db87-7f227c2b713a@suse.cz
-[3] http://dustin.wikidot.com/half-orcs-and-orcs
+.. [1] https://lkml.kernel.org/r/20170602104048.jkkzssljsompjdwy@suse.de
+.. [2] https://lkml.kernel.org/r/d2ca5435-6386-29b8-db87-7f227c2b713a@suse.cz
+.. [3] http://dustin.wikidot.com/half-orcs-and-orcs
-- 
2.20.1

