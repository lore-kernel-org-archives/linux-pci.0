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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 814A7C10F03
	for <linux-pci@archiver.kernel.org>; Tue, 23 Apr 2019 16:38:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46C21217D9
	for <linux-pci@archiver.kernel.org>; Tue, 23 Apr 2019 16:38:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MIC1W7V4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729479AbfDWQi2 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 23 Apr 2019 12:38:28 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44832 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729458AbfDWQi1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 23 Apr 2019 12:38:27 -0400
Received: by mail-pg1-f194.google.com with SMTP id z16so3263966pgv.11;
        Tue, 23 Apr 2019 09:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=M5KABm6EWunEuSYDlARfNVDUJGi2Z+Db+WyKxb2YpS0=;
        b=MIC1W7V4oqaHi9qx/imsH76gPXMC5JsNZ1l+vThmmZNo3G+tjyxctNnPRUbmrlXYSw
         3IU2bSaUtXsycKBGzPaKIiz3bKss27RIo5Ew06/lv5MnZmQR9R2UjhLcbgYMUdLaI2j0
         IRWL4rbtaYNQVuzaDIUx9Ber+8JuWjTSxP/RjUan9NFcHNw8QucX+3cVbJvsticBAAym
         e5+LQ1CcInHRta24ZoEeQqudMweri8cWQtvIgPEBTJytM79PABdQekoeFklXyeJwNK+H
         AuYVZctowepbpLB+8OYz0ecCNOOWJ3Qi0rtxbqSXzg0NKajtwlkzTgjCV+Q1mHkCMEDK
         2M1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M5KABm6EWunEuSYDlARfNVDUJGi2Z+Db+WyKxb2YpS0=;
        b=s6nKbwjFBPJdMwVD4Lds5R6cfs9NWV5RbjiELlrZkG1SAYfMH9CG89f5BdKAfxBcmf
         Vq9vgbIbnrqVCthu+IhBb+N/wuneCNQWNdW5VXj2mYPUfv5Nqw87U3xFqUfhxrKAesdT
         +bJE0NqMCCY/ChT6nuBlWGFWol5vjAfmQcp3zoiU7x9BBH4LUo7Gl/yD/M/7Xkb2x4vy
         A7XDa5QzPYCldtMwpMb3RZDf4zewI/b3DMCvHS+OOkIpnLX4dn7ACntR3DD5X31N3Vnn
         41lGHV1rigoTfEI8r21kFoLGwfYvjEzYhPodoGxhLc8NjF4OJnpjmEGQPXfHXihAa/u5
         q6Vw==
X-Gm-Message-State: APjAAAX5pZ9tZKYxZ5shtJTWbyPhbtxQdlWc6NO5mo3IwjWoOvngbv51
        xBo9VVmZn+TSY1z1mu/Fas0=
X-Google-Smtp-Source: APXvYqz70jp6FXe3puVeOfu4fgk/Nk2UKqXacyVtJ+1fbm6MiUKu7WFG6pN2PcojvwXM1Lek4/H62w==
X-Received: by 2002:a65:5343:: with SMTP id w3mr24190831pgr.232.1556037506123;
        Tue, 23 Apr 2019 09:38:26 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id v1sm24364801pff.81.2019.04.23.09.38.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Apr 2019 09:38:25 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, rjw@rjwysocki.net,
        linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        x86@kernel.org, fenghua.yu@intel.com,
        linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org,
        linux-gpio@vger.kernel.org, mchehab+samsung@kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v4 52/63] Documentation: x86: convert microcode.txt to reST
Date:   Wed, 24 Apr 2019 00:29:21 +0800
Message-Id: <20190423162932.21428-53-changbin.du@gmail.com>
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
 .../x86/{microcode.txt => microcode.rst}      | 62 ++++++++++---------
 2 files changed, 35 insertions(+), 28 deletions(-)
 rename Documentation/x86/{microcode.txt => microcode.rst} (81%)

diff --git a/Documentation/x86/index.rst b/Documentation/x86/index.rst
index 1c675cef14d7..2fcd10f29b87 100644
--- a/Documentation/x86/index.rst
+++ b/Documentation/x86/index.rst
@@ -22,3 +22,4 @@ Linux x86 Support
    intel_mpx
    amd-memory-encryption
    pti
+   microcode
diff --git a/Documentation/x86/microcode.txt b/Documentation/x86/microcode.rst
similarity index 81%
rename from Documentation/x86/microcode.txt
rename to Documentation/x86/microcode.rst
index 79fdb4a8148a..a320d37982ed 100644
--- a/Documentation/x86/microcode.txt
+++ b/Documentation/x86/microcode.rst
@@ -1,7 +1,11 @@
-	The Linux Microcode Loader
+.. SPDX-License-Identifier: GPL-2.0
 
-Authors: Fenghua Yu <fenghua.yu@intel.com>
-	 Borislav Petkov <bp@suse.de>
+==========================
+The Linux Microcode Loader
+==========================
+
+:Authors: - Fenghua Yu <fenghua.yu@intel.com>
+          - Borislav Petkov <bp@suse.de>
 
 The kernel has a x86 microcode loading facility which is supposed to
 provide microcode loading methods in the OS. Potential use cases are
@@ -10,8 +14,8 @@ and updating the microcode on long-running systems without rebooting.
 
 The loader supports three loading methods:
 
-1. Early load microcode
-=======================
+Early load microcode
+====================
 
 The kernel can update microcode very early during boot. Loading
 microcode early can fix CPU issues before they are observed during
@@ -26,8 +30,10 @@ loader parses the combined initrd image during boot.
 
 The microcode files in cpio name space are:
 
-on Intel: kernel/x86/microcode/GenuineIntel.bin
-on AMD  : kernel/x86/microcode/AuthenticAMD.bin
+on Intel:
+  kernel/x86/microcode/GenuineIntel.bin
+on AMD  :
+  kernel/x86/microcode/AuthenticAMD.bin
 
 During BSP (BootStrapping Processor) boot (pre-SMP), the kernel
 scans the microcode file in the initrd. If microcode matching the
@@ -42,8 +48,8 @@ Here's a crude example how to prepare an initrd with microcode (this is
 normally done automatically by the distribution, when recreating the
 initrd, so you don't really have to do it yourself. It is documented
 here for future reference only).
+::
 
----
   #!/bin/bash
 
   if [ -z "$1" ]; then
@@ -76,15 +82,15 @@ here for future reference only).
   cat ucode.cpio $INITRD.orig > $INITRD
 
   rm -rf $TMPDIR
----
+
 
 The system needs to have the microcode packages installed into
 /lib/firmware or you need to fixup the paths above if yours are
 somewhere else and/or you've downloaded them directly from the processor
 vendor's site.
 
-2. Late loading
-===============
+Late loading
+============
 
 There are two legacy user space interfaces to load microcode, either through
 /dev/cpu/microcode or through /sys/devices/system/cpu/microcode/reload file
@@ -94,9 +100,9 @@ The /dev/cpu/microcode method is deprecated because it needs a special
 userspace tool for that.
 
 The easier method is simply installing the microcode packages your distro
-supplies and running:
+supplies and running::
 
-# echo 1 > /sys/devices/system/cpu/microcode/reload
+  # echo 1 > /sys/devices/system/cpu/microcode/reload
 
 as root.
 
@@ -104,29 +110,29 @@ The loading mechanism looks for microcode blobs in
 /lib/firmware/{intel-ucode,amd-ucode}. The default distro installation
 packages already put them there.
 
-3. Builtin microcode
-====================
+Builtin microcode
+=================
 
 The loader supports also loading of a builtin microcode supplied through
 the regular builtin firmware method CONFIG_EXTRA_FIRMWARE. Only 64-bit is
 currently supported.
 
-Here's an example:
+Here's an example::
 
-CONFIG_EXTRA_FIRMWARE="intel-ucode/06-3a-09 amd-ucode/microcode_amd_fam15h.bin"
-CONFIG_EXTRA_FIRMWARE_DIR="/lib/firmware"
+  CONFIG_EXTRA_FIRMWARE="intel-ucode/06-3a-09 amd-ucode/microcode_amd_fam15h.bin"
+  CONFIG_EXTRA_FIRMWARE_DIR="/lib/firmware"
 
-This basically means, you have the following tree structure locally:
+This basically means, you have the following tree structure locally::
 
-/lib/firmware/
-|-- amd-ucode
-...
-|   |-- microcode_amd_fam15h.bin
-...
-|-- intel-ucode
-...
-|   |-- 06-3a-09
-...
+  /lib/firmware/
+  |-- amd-ucode
+  ...
+  |   |-- microcode_amd_fam15h.bin
+  ...
+  |-- intel-ucode
+  ...
+  |   |-- 06-3a-09
+  ...
 
 so that the build system can find those files and integrate them into
 the final kernel image. The early loader finds them and applies them.
-- 
2.20.1

