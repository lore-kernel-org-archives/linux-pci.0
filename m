Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:34645 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751560AbdGSCQY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 Jul 2017 22:16:24 -0400
Received: by mail-pf0-f195.google.com with SMTP id o88so4674016pfk.1
        for <linux-pci@vger.kernel.org>; Tue, 18 Jul 2017 19:16:24 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org
Cc: benh@kernel.crashing.org, z.liuxinliang@hisilicon.com,
        zourongrong@gmail.com, catalin.marinas@arm.com,
        will.deacon@arm.com, gabriele.paoloni@huawei.com,
        bhelgaas@google.com, airlied@linux.ie, daniel.vetter@intel.com,
        alex.williamson@redhat.com, Daniel Axtens <dja@axtens.net>,
        Brian King <brking@linux.vnet.ibm.com>
Subject: [PATCH v2 3/4] powerpc: replace vga_fixup() with generic code
Date: Wed, 19 Jul 2017 12:15:15 +1000
Message-Id: <20170719021516.24718-4-dja@axtens.net>
In-Reply-To: <20170719021516.24718-1-dja@axtens.net>
References: <20170719021516.24718-1-dja@axtens.net>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Currently, we do a PCI fixup to mark a default card so that Xorg
autoconfiguration works.

There is a new generic method to do this sort of vga fixup.

Code-wise, it is identical, however instead of firing at the
FIXUP_FINAL stage it fires at the FIXUP_ENABLE stage. This means
a card will not be marked as default unless a driver enables it.

Cc: Brian King <brking@linux.vnet.ibm.com>
Signed-off-by: Daniel Axtens <dja@axtens.net>

---

Tested with xeyes on qemu TCG, which does use this code path.
---
 arch/powerpc/Kconfig             |  1 +
 arch/powerpc/kernel/pci-common.c | 15 ---------------
 2 files changed, 1 insertion(+), 15 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 36f858c37ca7..c28b8eb1dce1 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -140,6 +140,7 @@ config PPC
 	select ARCH_USE_BUILTIN_BSWAP
 	select ARCH_USE_CMPXCHG_LOCKREF		if PPC64
 	select ARCH_WANT_IPC_PARSE_VERSION
+	select ARCH_WANT_VGA_ARB_FALLBACK
 	select ARCH_WEAK_RELEASE_ACQUIRE
 	select BINFMT_ELF
 	select BUILDTIME_EXTABLE_SORT
diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index c95fdda3a2dc..7b093a4fa85d 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -1741,18 +1741,3 @@ static void fixup_hide_host_resource_fsl(struct pci_dev *dev)
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MOTOROLA, PCI_ANY_ID, fixup_hide_host_resource_fsl);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_FREESCALE, PCI_ANY_ID, fixup_hide_host_resource_fsl);
-
-static void fixup_vga(struct pci_dev *pdev)
-{
-	u16 cmd;
-
-	if (vga_default_device())
-		return;
-
-	pci_read_config_word(pdev, PCI_COMMAND, &cmd);
-	if (cmd & (PCI_COMMAND_IO | PCI_COMMAND_MEMORY))
-		vga_set_default_device(pdev);
-
-}
-DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_ANY_ID, PCI_ANY_ID,
-			      PCI_CLASS_DISPLAY_VGA, 8, fixup_vga);
-- 
2.11.0
