Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-la0-f49.google.com ([209.85.215.49]:38168 "EHLO
	mail-la0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751124AbbCKOMf (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 11 Mar 2015 10:12:35 -0400
Received: by labhs14 with SMTP id hs14so8564261lab.5
        for <linux-pci@vger.kernel.org>; Wed, 11 Mar 2015 07:12:34 -0700 (PDT)
From: Tomasz Nowicki <tomasz.nowicki@linaro.org>
To: bhelgaas@google.com, wangyijing@huawei.com, arnd@arndb.de,
	hanjun.guo@linaro.org, Liviu.Dudau@arm.com, tglx@linutronix.de,
	mingo@redhat.com, hpa@zytor.com, rjw@rjwysocki.net,
	al.stone@linaro.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	x86@kernel.org, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, linaro-acpi@lists.linaro.org,
	Tomasz Nowicki <tomasz.nowicki@linaro.org>
Subject: [PATCH v4 1/9] x86, pci: Clean up comment about buggy MMIO config space access for AMD Fam10h CPUs.
Date: Wed, 11 Mar 2015 15:12:41 +0100
Message-Id: <1426083169-8698-2-git-send-email-tomasz.nowicki@linaro.org>
In-Reply-To: <1426083169-8698-1-git-send-email-tomasz.nowicki@linaro.org>
References: <1426083169-8698-1-git-send-email-tomasz.nowicki@linaro.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

- fix typo
- improve explanation
- add reference to the related document

Signed-off-by: Tomasz Nowicki <tomasz.nowicki@linaro.org>
---
 arch/x86/include/asm/pci_x86.h | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/pci_x86.h b/arch/x86/include/asm/pci_x86.h
index fa1195d..d024f4d 100644
--- a/arch/x86/include/asm/pci_x86.h
+++ b/arch/x86/include/asm/pci_x86.h
@@ -152,10 +152,13 @@ extern struct list_head pci_mmcfg_list;
 
 /*
  * AMD Fam10h CPUs are buggy, and cannot access MMIO config space
- * on their northbrige except through the * %eax register. As such, you MUST
- * NOT use normal IOMEM accesses, you need to only use the magic mmio-config
+ * on their northbridge except through the * %eax register. As such, you MUST
+ * NOT use normal IOMEM accesses, you need to only use the magic mmio_config_*
  * accessor functions.
- * In fact just use pci_config_*, nothing else please.
+ *
+ * Please refer to the following doc:
+ * "BIOS and Kernel Developer's Guide (BKDG) For AMD Family 10h Processors",
+ * rev. 3.48, sec 2.11.1, "MMIO Configuration Coding Requirements".
  */
 static inline unsigned char mmio_config_readb(void __iomem *pos)
 {
-- 
1.9.1

