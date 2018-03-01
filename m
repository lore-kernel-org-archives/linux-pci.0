Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from thoth.sbs.de ([192.35.17.2]:47581 "EHLO thoth.sbs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966071AbeCAFlK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 1 Mar 2018 00:41:10 -0500
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: x86@kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        jailhouse-dev@googlegroups.com, linux-pci@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v3 5/6] x86/jailhouse: Allow to use PCI_MMCONFIG without ACPI
Date: Thu,  1 Mar 2018 06:40:48 +0100
Message-Id: <8470cbcfae9adc01f86f7d519e219f5e798d0535.1519882849.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1519882849.git.jan.kiszka@siemens.com>
References: <cover.1519882849.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1519882849.git.jan.kiszka@siemens.com>
References: <cover.1519882849.git.jan.kiszka@siemens.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Jan Kiszka <jan.kiszka@siemens.com>

Jailhouse does not use ACPI, but it does support MMCONFIG. Make sure the
latter can be built without having to enable ACPI as well. Primarily, we
need to make the AMD mmconf-fam10h_64 depend upon MMCONFIG and ACPI,
instead of just the former.

Saves some bytes in the Jailhouse non-root kernel.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 arch/x86/Kconfig          | 6 +++++-
 arch/x86/kernel/Makefile  | 2 +-
 arch/x86/kernel/cpu/amd.c | 2 +-
 3 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index aef9d67ac186..b8e73e748acc 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2643,7 +2643,7 @@ config PCI_DIRECT
 config PCI_MMCONFIG
 	bool "Support mmconfig PCI config space access" if X86_64
 	default y
-	depends on PCI && (ACPI || SFI) && (X86_64 || (PCI_GOANY || PCI_GOMMCONFIG))
+	depends on PCI && (ACPI || SFI || JAILHOUSE_GUEST) && (X86_64 || (PCI_GOANY || PCI_GOMMCONFIG))
 
 config PCI_OLPC
 	def_bool y
@@ -2658,6 +2658,10 @@ config PCI_DOMAINS
 	def_bool y
 	depends on PCI
 
+config MMCONF_FAM10H
+	def_bool y
+	depends on PCI_MMCONFIG && ACPI
+
 config PCI_CNB20LE_QUIRK
 	bool "Read CNB20LE Host Bridge Windows" if EXPERT
 	depends on PCI
diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index 29786c87e864..73ccf80c09a2 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -146,6 +146,6 @@ ifeq ($(CONFIG_X86_64),y)
 	obj-$(CONFIG_GART_IOMMU)	+= amd_gart_64.o aperture_64.o
 	obj-$(CONFIG_CALGARY_IOMMU)	+= pci-calgary_64.o tce_64.o
 
-	obj-$(CONFIG_PCI_MMCONFIG)	+= mmconf-fam10h_64.o
+	obj-$(CONFIG_MMCONF_FAM10H)	+= mmconf-fam10h_64.o
 	obj-y				+= vsmp_64.o
 endif
diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index f0e6456ca7d3..12bc0a1139da 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -716,7 +716,7 @@ static void init_amd_k8(struct cpuinfo_x86 *c)
 
 static void init_amd_gh(struct cpuinfo_x86 *c)
 {
-#ifdef CONFIG_X86_64
+#ifdef CONFIG_MMCONF_FAM10H
 	/* do this for boot cpu */
 	if (c == &boot_cpu_data)
 		check_enable_amd_mmconf_dmi();
-- 
2.13.6
