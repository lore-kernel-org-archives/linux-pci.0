Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: x86@kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        jailhouse-dev@googlegroups.com, linux-pci@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: [PATCH 5/6] x86/jailhouse: Allow to use PCI_MMCONFIG without ACPI
Date: Mon, 22 Jan 2018 07:12:49 +0100
Message-Id: <825040fe16c7d19b7fb48ed90c5e133412d55cc3.1516601570.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1516601570.git.jan.kiszka@siemens.com>
References: <cover.1516601570.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1516601570.git.jan.kiszka@siemens.com>
References: <cover.1516601570.git.jan.kiszka@siemens.com>
Sender: linux-kernel-owner@vger.kernel.org
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
index f2038417a590..77ba0eb0a258 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2597,7 +2597,7 @@ config PCI_DIRECT
 config PCI_MMCONFIG
 	bool "Support mmconfig PCI config space access" if X86_64
 	default y
-	depends on PCI && (ACPI || SFI) && (PCI_GOMMCONFIG || PCI_GOANY || X86_64)
+	depends on PCI && (ACPI || SFI || JAILHOUSE_GUEST) && (PCI_GOMMCONFIG || PCI_GOANY || X86_64)
 
 config PCI_OLPC
 	def_bool y
@@ -2612,6 +2612,10 @@ config PCI_DOMAINS
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
index aed9296dccd3..b2c9e230e2fe 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -143,6 +143,6 @@ ifeq ($(CONFIG_X86_64),y)
 	obj-$(CONFIG_GART_IOMMU)	+= amd_gart_64.o aperture_64.o
 	obj-$(CONFIG_CALGARY_IOMMU)	+= pci-calgary_64.o tce_64.o
 
-	obj-$(CONFIG_PCI_MMCONFIG)	+= mmconf-fam10h_64.o
+	obj-$(CONFIG_MMCONF_FAM10H)	+= mmconf-fam10h_64.o
 	obj-y				+= vsmp_64.o
 endif
diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index ea831c858195..47edf599f6fd 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -690,7 +690,7 @@ static void init_amd_k8(struct cpuinfo_x86 *c)
 
 static void init_amd_gh(struct cpuinfo_x86 *c)
 {
-#ifdef CONFIG_X86_64
+#ifdef CONFIG_MMCONF_FAM10H
 	/* do this for boot cpu */
 	if (c == &boot_cpu_data)
 		check_enable_amd_mmconf_dmi();
-- 
2.13.6
