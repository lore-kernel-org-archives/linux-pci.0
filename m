Return-Path: <SRS0=Emu/=SZ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96170C282DD
	for <linux-pci@archiver.kernel.org>; Tue, 23 Apr 2019 16:37:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5791A217D9
	for <linux-pci@archiver.kernel.org>; Tue, 23 Apr 2019 16:37:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZCR8Yh0G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729333AbfDWQhk (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 23 Apr 2019 12:37:40 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33123 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728560AbfDWQhj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 23 Apr 2019 12:37:39 -0400
Received: by mail-pg1-f194.google.com with SMTP id k19so7885970pgh.0;
        Tue, 23 Apr 2019 09:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o4nkW5qMBlJfhXU2XzdZiHmjUQAE2qfxhJ8o3/2mt0U=;
        b=ZCR8Yh0G0S9MhzPKcA0kaKJiCZNVsrjniYh3f7+M87mqND/kJ3K3EoZmRwPn0MZ5ZK
         PmWxHrvWcLryZ2VQBNbeH8+ZTyZ5tw1kwriR0leIEA8dcl+44zhDPon6srqvHpU1MRm5
         cMI6O+ut+omWKMcIi8H4MHja1/f1wbJZSPahTGJMTyJtSbuY7cU0Xpewq5YCpma5div9
         NPzvdJrv1yDWzDtPZiLeSukB7SJbfqxRic1TTD260Uh0cGc/TrLHrjRPMonjShkEBdYL
         b+mtBChn94Geop0jPrDxawLmoWjKhGu/oTm8hS56sZDZTQ7OW9bi0Cqf9uWwcGAP6J4d
         scTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o4nkW5qMBlJfhXU2XzdZiHmjUQAE2qfxhJ8o3/2mt0U=;
        b=PJ67Hh70XqiceX7DyzChLg1h9CpP44XOgw5sVi/2j67MLhsM8Yp+oAICXf8cYwbOwD
         EEAxohCk1ePzQnC4m1NS35jZge9GjN6pN1AyGAteFoutYEBaPa9djQvV1cxETjCeNuqX
         IhEe++4WcbVZwTyL3kW6w71E3x049RUUZ2Pl7l76Rngae9f+MKcRqixfCPoSE6SjkCaL
         j22csEI/f3e6dkz+iNmwNj0UmYohACCQ6dydV3ukMQwyulZeNWrrY/H+6Vyf8n9bTlR3
         nNbIbq0YbFLhWe2a3vQcOYN1A4f+LRYiI+XUOcHJgk2C2vSIMwAr36BdGGWbx+ejGnCl
         VhQg==
X-Gm-Message-State: APjAAAWOk7AAvbIfFNHNfUG0Rxqa5oyQkV6YVlCr4NgTfG1eNAk5P7AB
        nqINp7lKHrjwysOzebqO0/4=
X-Google-Smtp-Source: APXvYqxrFa2o/lkJ3G96PqNTaEeM7wfvhL/FoS4hwRbeY2bEIv5FoVrZWHACnsr1tudYl838heCmdw==
X-Received: by 2002:a63:4a45:: with SMTP id j5mr26042107pgl.426.1556037458867;
        Tue, 23 Apr 2019 09:37:38 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id v1sm24364801pff.81.2019.04.23.09.37.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Apr 2019 09:37:38 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, rjw@rjwysocki.net,
        linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        x86@kernel.org, fenghua.yu@intel.com,
        linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org,
        linux-gpio@vger.kernel.org, mchehab+samsung@kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v4 44/63] Documentation: x86: convert zero-page.txt to reST
Date:   Wed, 24 Apr 2019 00:29:13 +0800
Message-Id: <20190423162932.21428-45-changbin.du@gmail.com>
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
 Documentation/x86/index.rst     |  1 +
 Documentation/x86/zero-page.rst | 47 +++++++++++++++++++++++++++++++++
 Documentation/x86/zero-page.txt | 40 ----------------------------
 3 files changed, 48 insertions(+), 40 deletions(-)
 create mode 100644 Documentation/x86/zero-page.rst
 delete mode 100644 Documentation/x86/zero-page.txt

diff --git a/Documentation/x86/index.rst b/Documentation/x86/index.rst
index 7b8388ebd43d..9a0b5f38ef6b 100644
--- a/Documentation/x86/index.rst
+++ b/Documentation/x86/index.rst
@@ -14,3 +14,4 @@ Linux x86 Support
    kernel-stacks
    entry_64
    earlyprintk
+   zero-page
diff --git a/Documentation/x86/zero-page.rst b/Documentation/x86/zero-page.rst
new file mode 100644
index 000000000000..deedbc84454d
--- /dev/null
+++ b/Documentation/x86/zero-page.rst
@@ -0,0 +1,47 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=========
+Zero Page
+=========
+
+The additional fields in struct boot_params as a part of 32-bit boot
+protocol of kernel. These should be filled by bootloader or 16-bit
+real-mode setup code of the kernel. References/settings to it mainly
+are in::
+
+  arch/x86/include/uapi/asm/bootparam.h
+
+::
+
+	Offset	Proto	Name		Meaning
+	/Size
+
+	000/040	ALL	screen_info	Text mode or frame buffer information
+					(struct screen_info)
+	040/014	ALL	apm_bios_info	APM BIOS information (struct apm_bios_info)
+	058/008	ALL	tboot_addr      Physical address of tboot shared page
+	060/010	ALL	ist_info	Intel SpeedStep (IST) BIOS support information
+					(struct ist_info)
+	080/010	ALL	hd0_info	hd0 disk parameter, OBSOLETE!!
+	090/010	ALL	hd1_info	hd1 disk parameter, OBSOLETE!!
+	0A0/010	ALL	sys_desc_table	System description table (struct sys_desc_table),
+					OBSOLETE!!
+	0B0/010	ALL	olpc_ofw_header	OLPC's OpenFirmware CIF and friends
+	0C0/004	ALL	ext_ramdisk_image ramdisk_image high 32bits
+	0C4/004	ALL	ext_ramdisk_size  ramdisk_size high 32bits
+	0C8/004	ALL	ext_cmd_line_ptr  cmd_line_ptr high 32bits
+	140/080	ALL	edid_info	Video mode setup (struct edid_info)
+	1C0/020	ALL	efi_info	EFI 32 information (struct efi_info)
+	1E0/004	ALL	alt_mem_k	Alternative mem check, in KB
+	1E4/004	ALL	scratch		Scratch field for the kernel setup code
+	1E8/001	ALL	e820_entries	Number of entries in e820_table (below)
+	1E9/001	ALL	eddbuf_entries	Number of entries in eddbuf (below)
+	1EA/001	ALL	edd_mbr_sig_buf_entries	Number of entries in edd_mbr_sig_buffer
+					(below)
+	1EB/001	ALL     kbd_status      Numlock is enabled
+	1EC/001	ALL     secure_boot	Secure boot is enabled in the firmware
+	1EF/001	ALL	sentinel	Used to detect broken bootloaders
+	290/040	ALL	edd_mbr_sig_buffer EDD MBR signatures
+	2D0/A00	ALL	e820_table	E820 memory map table
+					(array of struct e820_entry)
+	D00/1EC	ALL	eddbuf		EDD data (array of struct edd_info)
diff --git a/Documentation/x86/zero-page.txt b/Documentation/x86/zero-page.txt
deleted file mode 100644
index 68aed077f7b6..000000000000
--- a/Documentation/x86/zero-page.txt
+++ /dev/null
@@ -1,40 +0,0 @@
-The additional fields in struct boot_params as a part of 32-bit boot
-protocol of kernel. These should be filled by bootloader or 16-bit
-real-mode setup code of the kernel. References/settings to it mainly
-are in:
-
-  arch/x86/include/uapi/asm/bootparam.h
-
-
-Offset	Proto	Name		Meaning
-/Size
-
-000/040	ALL	screen_info	Text mode or frame buffer information
-				(struct screen_info)
-040/014	ALL	apm_bios_info	APM BIOS information (struct apm_bios_info)
-058/008	ALL	tboot_addr      Physical address of tboot shared page
-060/010	ALL	ist_info	Intel SpeedStep (IST) BIOS support information
-				(struct ist_info)
-080/010	ALL	hd0_info	hd0 disk parameter, OBSOLETE!!
-090/010	ALL	hd1_info	hd1 disk parameter, OBSOLETE!!
-0A0/010	ALL	sys_desc_table	System description table (struct sys_desc_table),
-				OBSOLETE!!
-0B0/010	ALL	olpc_ofw_header	OLPC's OpenFirmware CIF and friends
-0C0/004	ALL	ext_ramdisk_image ramdisk_image high 32bits
-0C4/004	ALL	ext_ramdisk_size  ramdisk_size high 32bits
-0C8/004	ALL	ext_cmd_line_ptr  cmd_line_ptr high 32bits
-140/080	ALL	edid_info	Video mode setup (struct edid_info)
-1C0/020	ALL	efi_info	EFI 32 information (struct efi_info)
-1E0/004	ALL	alt_mem_k	Alternative mem check, in KB
-1E4/004	ALL	scratch		Scratch field for the kernel setup code
-1E8/001	ALL	e820_entries	Number of entries in e820_table (below)
-1E9/001	ALL	eddbuf_entries	Number of entries in eddbuf (below)
-1EA/001	ALL	edd_mbr_sig_buf_entries	Number of entries in edd_mbr_sig_buffer
-				(below)
-1EB/001	ALL     kbd_status      Numlock is enabled
-1EC/001	ALL     secure_boot	Secure boot is enabled in the firmware
-1EF/001	ALL	sentinel	Used to detect broken bootloaders
-290/040	ALL	edd_mbr_sig_buffer EDD MBR signatures
-2D0/A00	ALL	e820_table	E820 memory map table
-				(array of struct e820_entry)
-D00/1EC	ALL	eddbuf		EDD data (array of struct edd_info)
-- 
2.20.1

