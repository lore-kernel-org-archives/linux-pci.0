Return-Path: <SRS0=Emu/=SZ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A74DDC282DD
	for <linux-pci@archiver.kernel.org>; Tue, 23 Apr 2019 16:39:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 738F12183E
	for <linux-pci@archiver.kernel.org>; Tue, 23 Apr 2019 16:39:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="coyxeucB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729600AbfDWQi6 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 23 Apr 2019 12:38:58 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41948 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729310AbfDWQi5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 23 Apr 2019 12:38:57 -0400
Received: by mail-pg1-f193.google.com with SMTP id f6so7867085pgs.8;
        Tue, 23 Apr 2019 09:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EltilnvvP1BvvyVI1MTgDNOjtPuzRRDurGYU5XZhXEs=;
        b=coyxeucBNGGhBbnV73diQjJV3jm5TDF3tMdaPUePlSg6BotQ7xRr8M5n2zX6PrlHt1
         3Ae0DPUAGysP3kj8j1dKipqRw65axuiJEzzVVVZHbLK8gf1PKgfc4EqB768qZ9cVGBHs
         eVilF0ZRilDMPU71yj3vLg4GNbosiEDVmFer+K+BzLdHwQnbkJghdnynmefiPK10It7i
         nrtNvsl//0wL6yEFImn8U5zL186PDocy0ngOxfZSXvNuwPFVOjgYCV/rj52WucpIUUQA
         e8LA1nHjNRsWgN8odwwcnWuT6c212DPe71bDZLEESdQHv47y7wXMibOprMTz5r6asJij
         5wbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EltilnvvP1BvvyVI1MTgDNOjtPuzRRDurGYU5XZhXEs=;
        b=iRU92An6wOk1mvsBiAZamF5jufiB2DvmMVCuFbTo2qSny7o2EgN1+y8YYX6qJapr9F
         WcZntHQcKli4QMjVULm9R4RReYTsyMpAtc1cR3wdbq4UXPLitUzp9gge5cazomLkIqL2
         JbZrSDsA19ANKLosbyS3gDzLYXgq4LprwIGwculbjCUZHCES182AlXQzwIdcEnEb4tSd
         1lg/WqxgTQZ1V27R7AZFDZwRGHyzcxmL+Wt3p7NvzsFEoI9y9nGe/Zhz+dEraRsj30iY
         VHz8N0GqAC36/dZLLjYgZNP9zf0HFeF1ggklpSBBjCgwFNLNLIWynpbtfOa3GkHERYpS
         qrlA==
X-Gm-Message-State: APjAAAXMretK7McxFRxwWa4ATAyXLqFsCV7u/HEpRP20AYQdL6Q+CqCg
        rqm7QpyzW2eVTUKggJQ5xRI=
X-Google-Smtp-Source: APXvYqzkyH8ljChilcA9oqAwHnGb+wLCqzfGLkYCxxZLoHY2/GdaWRvJA+BlOeCdr9U8J7apOAleWQ==
X-Received: by 2002:a63:3287:: with SMTP id y129mr26124874pgy.9.1556037536417;
        Tue, 23 Apr 2019 09:38:56 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id v1sm24364801pff.81.2019.04.23.09.38.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Apr 2019 09:38:55 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, rjw@rjwysocki.net,
        linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        x86@kernel.org, fenghua.yu@intel.com,
        linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org,
        linux-gpio@vger.kernel.org, mchehab+samsung@kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v4 58/63] Documentation: x86: convert x86_64/uefi.txt to reST
Date:   Wed, 24 Apr 2019 00:29:27 +0800
Message-Id: <20190423162932.21428-59-changbin.du@gmail.com>
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
 Documentation/x86/x86_64/index.rst            |  1 +
 .../x86/x86_64/{uefi.txt => uefi.rst}         | 30 ++++++++++++++-----
 2 files changed, 24 insertions(+), 7 deletions(-)
 rename Documentation/x86/x86_64/{uefi.txt => uefi.rst} (79%)

diff --git a/Documentation/x86/x86_64/index.rst b/Documentation/x86/x86_64/index.rst
index a8cf7713cac9..ddfa1f9d4193 100644
--- a/Documentation/x86/x86_64/index.rst
+++ b/Documentation/x86/x86_64/index.rst
@@ -8,3 +8,4 @@ x86_64 Support
    :maxdepth: 2
 
    boot-options
+   uefi
diff --git a/Documentation/x86/x86_64/uefi.txt b/Documentation/x86/x86_64/uefi.rst
similarity index 79%
rename from Documentation/x86/x86_64/uefi.txt
rename to Documentation/x86/x86_64/uefi.rst
index a5e2b4fdb170..88c3ba32546f 100644
--- a/Documentation/x86/x86_64/uefi.txt
+++ b/Documentation/x86/x86_64/uefi.rst
@@ -1,5 +1,8 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=====================================
 General note on [U]EFI x86_64 support
--------------------------------------
+=====================================
 
 The nomenclature EFI and UEFI are used interchangeably in this document.
 
@@ -14,29 +17,42 @@ with EFI firmware and specifications are listed below.
 
 3. x86_64 platform with EFI/UEFI firmware.
 
-Mechanics:
+Mechanics
 ---------
-- Build the kernel with the following configuration.
+
+- Build the kernel with the following configuration::
+
 	CONFIG_FB_EFI=y
 	CONFIG_FRAMEBUFFER_CONSOLE=y
+
   If EFI runtime services are expected, the following configuration should
-  be selected.
+  be selected::
+
 	CONFIG_EFI=y
 	CONFIG_EFI_VARS=y or m		# optional
+
 - Create a VFAT partition on the disk
 - Copy the following to the VFAT partition:
+
 	elilo bootloader with x86_64 support, elilo configuration file,
 	kernel image built in first step and corresponding
 	initrd. Instructions on building elilo	and its dependencies
 	can be found in the elilo sourceforge project.
+
 - Boot to EFI shell and invoke elilo choosing the kernel image built
   in first step.
 - If some or all EFI runtime services don't work, you can try following
   kernel command line parameters to turn off some or all EFI runtime
   services.
-	noefi		turn off all EFI runtime services
-	reboot_type=k	turn off EFI reboot runtime service
+
+	noefi
+		turn off all EFI runtime services
+	reboot_type=k
+		turn off EFI reboot runtime service
+
 - If the EFI memory map has additional entries not in the E820 map,
   you can include those entries in the kernels memory map of available
   physical RAM by using the following kernel command line parameter.
-	add_efi_memmap	include EFI memory map of available physical RAM
+
+	add_efi_memmap
+		include EFI memory map of available physical RAM
-- 
2.20.1

