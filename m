Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-we0-f169.google.com ([74.125.82.169]:49105 "EHLO
	mail-we0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933329AbaHYV1M (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 25 Aug 2014 17:27:12 -0400
Received: by mail-we0-f169.google.com with SMTP id u56so13813660wes.14
        for <linux-pci@vger.kernel.org>; Mon, 25 Aug 2014 14:27:11 -0700 (PDT)
From: Mathias Krause <minipli@googlemail.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, Mathias Krause <minipli@googlemail.com>
Subject: [PATCH 3/5] x86/PCI: Mark constants of pci_mmcfg_nvidia_mcp55() as __initconst
Date: Mon, 25 Aug 2014 23:26:37 +0200
Message-Id: <1409001999-23161-4-git-send-email-minipli@googlemail.com>
In-Reply-To: <1409001999-23161-1-git-send-email-minipli@googlemail.com>
References: <1409001999-23161-1-git-send-email-minipli@googlemail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The constants in pci_mmcfg_nvidia_mcp55() need to be marked as
__initconst or they will remain in memory after init memory was
released.

Signed-off-by: Mathias Krause <minipli@googlemail.com>
---
 arch/x86/pci/mmconfig-shared.c |   24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/arch/x86/pci/mmconfig-shared.c b/arch/x86/pci/mmconfig-shared.c
index 163ef6bf16..63fc0d4d58 100644
--- a/arch/x86/pci/mmconfig-shared.c
+++ b/arch/x86/pci/mmconfig-shared.c
@@ -240,16 +240,20 @@ static const char *__init pci_mmcfg_nvidia_mcp55(void)
 	int bus;
 	int mcp55_mmconf_found = 0;
 
-	static const u32 extcfg_regnum		= 0x90;
-	static const u32 extcfg_regsize		= 4;
-	static const u32 extcfg_enable_mask	= 1<<31;
-	static const u32 extcfg_start_mask	= 0xff<<16;
-	static const int extcfg_start_shift	= 16;
-	static const u32 extcfg_size_mask	= 0x3<<28;
-	static const int extcfg_size_shift	= 28;
-	static const int extcfg_sizebus[]	= {0x100, 0x80, 0x40, 0x20};
-	static const u32 extcfg_base_mask[]	= {0x7ff8, 0x7ffc, 0x7ffe, 0x7fff};
-	static const int extcfg_base_lshift	= 25;
+	static const u32 extcfg_regnum __initconst	= 0x90;
+	static const u32 extcfg_regsize __initconst	= 4;
+	static const u32 extcfg_enable_mask __initconst	= 1 << 31;
+	static const u32 extcfg_start_mask __initconst	= 0xff << 16;
+	static const int extcfg_start_shift __initconst	= 16;
+	static const u32 extcfg_size_mask __initconst	= 0x3 << 28;
+	static const int extcfg_size_shift __initconst	= 28;
+	static const int extcfg_sizebus[] __initconst	= {
+		0x100, 0x80, 0x40, 0x20
+	};
+	static const u32 extcfg_base_mask[] __initconst	= {
+		0x7ff8, 0x7ffc, 0x7ffe, 0x7fff
+	};
+	static const int extcfg_base_lshift __initconst	= 25;
 
 	/*
 	 * do check if amd fam10h already took over
-- 
1.7.10.4

