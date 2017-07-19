Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:33683 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751906AbdGSB3h (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 Jul 2017 21:29:37 -0400
Received: by mail-pg0-f66.google.com with SMTP id z1so4871363pgs.0
        for <linux-pci@vger.kernel.org>; Tue, 18 Jul 2017 18:29:36 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org
Cc: benh@kernel.crashing.org, z.liuxinliang@hisilicon.com,
        zourongrong@gmail.com, catalin.marinas@arm.com,
        will.deacon@arm.com, gabriele.paoloni@huawei.com,
        helgass@kernel.org, airlied@linux.ie, daniel.vetter@intel.com,
        alex.williamson@redhat.com, Daniel Axtens <dja@axtens.net>
Subject: [PATCH 2/3] vgaarb rework
Date: Wed, 19 Jul 2017 11:28:36 +1000
Message-Id: <20170719012839.20124-4-dja@axtens.net>
In-Reply-To: <20170719012839.20124-1-dja@axtens.net>
References: <20170719012839.20124-1-dja@axtens.net>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Signed-off-by: Daniel Axtens <dja@axtens.net>
---
 arch/powerpc/Kconfig             |  1 +
 arch/powerpc/kernel/pci-common.c |  2 ++
 drivers/gpu/vga/Kconfig          |  8 ++++++++
 drivers/gpu/vga/vgaarb.c         | 21 +++++++++++++++++++++
 4 files changed, 32 insertions(+)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 524f71104b75..f86e4c8a9cc6 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -83,6 +83,7 @@ config PPC
 	select BUILDTIME_EXTABLE_SORT
 	select ARCH_MIGHT_HAVE_PC_PARPORT
 	select ARCH_MIGHT_HAVE_PC_SERIO
+	select ARCH_WANT_VGA_ARB_FALLBACK
 	select BINFMT_ELF
 	select ARCH_HAS_ELF_RANDOMIZE
 	select OF
diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index 07f05a0f59a2..e0f29a594aa1 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -1740,6 +1740,7 @@ static void fixup_hide_host_resource_fsl(struct pci_dev *dev)
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MOTOROLA, PCI_ANY_ID, fixup_hide_host_resource_fsl);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_FREESCALE, PCI_ANY_ID, fixup_hide_host_resource_fsl);
 
+#if !defined(CONFIG_ARCH_WANT_VGA_ARB_FALLBACK)
 static void fixup_vga(struct pci_dev *pdev)
 {
 	u16 cmd;
@@ -1754,3 +1755,4 @@ static void fixup_vga(struct pci_dev *pdev)
 }
 DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_ANY_ID, PCI_ANY_ID,
 			      PCI_CLASS_DISPLAY_VGA, 8, fixup_vga);
+#endif
diff --git a/drivers/gpu/vga/Kconfig b/drivers/gpu/vga/Kconfig
index 29437eabe095..20f6c5a9a159 100644
--- a/drivers/gpu/vga/Kconfig
+++ b/drivers/gpu/vga/Kconfig
@@ -17,6 +17,14 @@ config VGA_ARB_MAX_GPUS
 	  Reserves space in the kernel to maintain resource locking for
 	  multiple GPUS.  The overhead for each GPU is very small.
 
+config ARCH_WANT_VGA_ARB_FALLBACK
+	bool
+	depends on !(X86 || IA64)
+	help
+	  Some architectures don't have a concept of "legacy" PCI addresses
+	  which the VGA arbiter relies on. Instead, they can fall back to
+	  selecting the first device that decodes memory and I/O.
+
 config VGA_SWITCHEROO
 	bool "Laptop Hybrid Graphics - GPU switching support"
 	depends on X86
diff --git a/drivers/gpu/vga/vgaarb.c b/drivers/gpu/vga/vgaarb.c
index 0f5b2dd24507..02424dc3a58d 100644
--- a/drivers/gpu/vga/vgaarb.c
+++ b/drivers/gpu/vga/vgaarb.c
@@ -1472,3 +1472,24 @@ static int __init vga_arb_device_init(void)
 	return rc;
 }
 subsys_initcall(vga_arb_device_init);
+
+#if defined(CONFIG_ARCH_WANT_VGA_ARB_FALLBACK)
+static void vga_arb_fallback_fixup(struct pci_dev *pdev)
+{
+	u16 cmd;
+
+	if (vga_default_device())
+		return;
+
+	pci_read_config_word(pdev, PCI_COMMAND, &cmd);
+	if (cmd & (PCI_COMMAND_IO | PCI_COMMAND_MEMORY)) {
+		vgaarb_info(&pdev->dev, "[fallback]"
+			    " setting as default device\n");
+		vga_set_default_device(pdev);
+	}
+
+}
+DECLARE_PCI_FIXUP_CLASS_ENABLE(PCI_ANY_ID, PCI_ANY_ID,
+			       PCI_CLASS_DISPLAY_VGA, 8,
+			       vga_arb_fallback_fixup);
+#endif
-- 
2.11.0
