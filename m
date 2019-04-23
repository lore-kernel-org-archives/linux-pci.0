Return-Path: <SRS0=Emu/=SZ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E695AC10F03
	for <linux-pci@archiver.kernel.org>; Tue, 23 Apr 2019 16:40:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7C42217D9
	for <linux-pci@archiver.kernel.org>; Tue, 23 Apr 2019 16:40:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HzviB74J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729132AbfDWQiG (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 23 Apr 2019 12:38:06 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38663 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728728AbfDWQiF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 23 Apr 2019 12:38:05 -0400
Received: by mail-pf1-f193.google.com with SMTP id 10so7765833pfo.5;
        Tue, 23 Apr 2019 09:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jhUgUnVwH131/xczA7BMawqjAt3u+4QIhEzyPGkH5gg=;
        b=HzviB74JmbYw4skjyutI99dOjVNQZ8cJdPk1BTUuTO7PwftqG5b5ywHSiIZj+PtZsy
         yoB7w8iO9cVhdOkS4ChxZHhkWwnhgvQEW5M6jc6Lw1CG7Y5sbcwKPZzqGzJlT3vFZtxD
         5km8ASE8y0sG3GQU2fqK0AGrfPXWVVQFnCicJB9pWu8N/WNv748rHuC4QL4xPTYBTjmy
         ccatj4UYXr0Ld9Em4eoK2thGWXOWSEV5MM7kxWxUD7Oa/eNiRMdnVn4QjStLE5oeJfCJ
         8bjRHvLUGwY+tMfJWCIRvqLahak94BiJ1L8yEJT1FuzsThDUHSIPxf7LsRo5OnXEA2ns
         R7rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jhUgUnVwH131/xczA7BMawqjAt3u+4QIhEzyPGkH5gg=;
        b=PaqyPpH6tVLKh8nFoI/teK6dkwB0xoayoU9n/Lvcbszr7MppmxQD9BtG16jvM4j7Iq
         zOeW3K7WElhCmJNd85ih4RTcRlT1tqe6NTwvBttm9/+tzsIfL0PalIwxfDiDqqtovcmG
         p9eQboiaigE1op6I1iybLId3XcbnhDlzKPa2Sc6WjK6nJS1jO5QALPCqA1P8RoN8AdkB
         tv4TAwbXldawTarGHIZMmF4xyztLukHt/xA+VYZUYJ8Zzmz9AIQPLYqkCZG08WQhFr8m
         jnVae0BpKNN2+Z+b6WcqrIjaZrYU+nZGAxhF6jE/xv0hmn5oTzwBv9iJOtrRrxJEaO+R
         TnrQ==
X-Gm-Message-State: APjAAAW/ZNQvaCFfkEnY6aZSFyOfS5xGS2bhCH7HLsgGqUtcV7BMT2NR
        Ko0nCPUsMu1KhSdv8phE5ic=
X-Google-Smtp-Source: APXvYqzHIquS1VBTfLSG3etu+O7g2qe7tFWGQ/pqVW94swIbeu4SxlEJz+w328wbLPNv4VZH/q111w==
X-Received: by 2002:a63:6907:: with SMTP id e7mr24917603pgc.209.1556037484653;
        Tue, 23 Apr 2019 09:38:04 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id v1sm24364801pff.81.2019.04.23.09.37.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Apr 2019 09:38:03 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, rjw@rjwysocki.net,
        linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        x86@kernel.org, fenghua.yu@intel.com,
        linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org,
        linux-gpio@vger.kernel.org, mchehab+samsung@kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v4 48/63] Documentation: x86: convert protection-keys.txt to reST
Date:   Wed, 24 Apr 2019 00:29:17 +0800
Message-Id: <20190423162932.21428-49-changbin.du@gmail.com>
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
 ...rotection-keys.txt => protection-keys.rst} | 33 ++++++++++++-------
 2 files changed, 22 insertions(+), 12 deletions(-)
 rename Documentation/x86/{protection-keys.txt => protection-keys.rst} (83%)

diff --git a/Documentation/x86/index.rst b/Documentation/x86/index.rst
index e06b5c0ea883..576628b121cc 100644
--- a/Documentation/x86/index.rst
+++ b/Documentation/x86/index.rst
@@ -18,3 +18,4 @@ Linux x86 Support
    tlb
    mtrr
    pat
+   protection-keys
diff --git a/Documentation/x86/protection-keys.txt b/Documentation/x86/protection-keys.rst
similarity index 83%
rename from Documentation/x86/protection-keys.txt
rename to Documentation/x86/protection-keys.rst
index ecb0d2dadfb7..49d9833af871 100644
--- a/Documentation/x86/protection-keys.txt
+++ b/Documentation/x86/protection-keys.rst
@@ -1,3 +1,9 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+======================
+Memory Protection Keys
+======================
+
 Memory Protection Keys for Userspace (PKU aka PKEYs) is a feature
 which is found on Intel's Skylake "Scalable Processor" Server CPUs.
 It will be avalable in future non-server parts.
@@ -23,9 +29,10 @@ even though there is theoretically space in the PAE PTEs.  These
 permissions are enforced on data access only and have no effect on
 instruction fetches.
 
-=========================== Syscalls ===========================
+Syscalls
+========
 
-There are 3 system calls which directly interact with pkeys:
+There are 3 system calls which directly interact with pkeys::
 
 	int pkey_alloc(unsigned long flags, unsigned long init_access_rights)
 	int pkey_free(int pkey);
@@ -37,6 +44,7 @@ pkey_alloc().  An application calls the WRPKRU instruction
 directly in order to change access permissions to memory covered
 with a key.  In this example WRPKRU is wrapped by a C function
 called pkey_set().
+::
 
 	int real_prot = PROT_READ|PROT_WRITE;
 	pkey = pkey_alloc(0, PKEY_DISABLE_WRITE);
@@ -45,43 +53,44 @@ called pkey_set().
 	... application runs here
 
 Now, if the application needs to update the data at 'ptr', it can
-gain access, do the update, then remove its write access:
+gain access, do the update, then remove its write access::
 
 	pkey_set(pkey, 0); // clear PKEY_DISABLE_WRITE
 	*ptr = foo; // assign something
 	pkey_set(pkey, PKEY_DISABLE_WRITE); // set PKEY_DISABLE_WRITE again
 
 Now when it frees the memory, it will also free the pkey since it
-is no longer in use:
+is no longer in use::
 
 	munmap(ptr, PAGE_SIZE);
 	pkey_free(pkey);
 
-(Note: pkey_set() is a wrapper for the RDPKRU and WRPKRU instructions.
- An example implementation can be found in
- tools/testing/selftests/x86/protection_keys.c)
+.. note:: pkey_set() is a wrapper for the RDPKRU and WRPKRU instructions.
+          An example implementation can be found in
+          tools/testing/selftests/x86/protection_keys.c.
 
-=========================== Behavior ===========================
+Behavior
+========
 
 The kernel attempts to make protection keys consistent with the
-behavior of a plain mprotect().  For instance if you do this:
+behavior of a plain mprotect().  For instance if you do this::
 
 	mprotect(ptr, size, PROT_NONE);
 	something(ptr);
 
-you can expect the same effects with protection keys when doing this:
+you can expect the same effects with protection keys when doing this::
 
 	pkey = pkey_alloc(0, PKEY_DISABLE_WRITE | PKEY_DISABLE_READ);
 	pkey_mprotect(ptr, size, PROT_READ|PROT_WRITE, pkey);
 	something(ptr);
 
 That should be true whether something() is a direct access to 'ptr'
-like:
+like::
 
 	*ptr = foo;
 
 or when the kernel does the access on the application's behalf like
-with a read():
+with a read()::
 
 	read(fd, ptr, 1);
 
-- 
2.20.1

