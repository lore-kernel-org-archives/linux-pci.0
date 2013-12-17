Return-Path: <linux-kernel-owner@vger.kernel.org>
From: David Cohen <david.a.cohen@linux.intel.com>
To: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org
Cc: bhelgaas@google.com, david.a.cohen@linux.intel.com,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [PATCH v2.1 4/4] x86: intel-mid: remove deprecated X86_MDFLD and X86_WANT_INTEL_MID configs
Date: Mon, 16 Dec 2013 17:37:26 -0800
Message-Id: <1387244246-20714-1-git-send-email-david.a.cohen@linux.intel.com>
In-Reply-To: <1387224459-25746-1-git-send-email-david.a.cohen@linux.intel.com>
References: <1387224459-25746-1-git-send-email-david.a.cohen@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

We want to support all Intel Mid platforms with a single config
selection. This patch removes deprecated CONFIG_X86_MDFLD and
X86_WANT_INTEL_MID options in favor of having CONFIG_X86_INTEL_MID only.

Signed-off-by: David Cohen <david.a.cohen@linux.intel.com>
---
 arch/x86/Kconfig | 30 +++++++-----------------------
 1 file changed, 7 insertions(+), 23 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index e903c71f7e69..f998be2d2901 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -437,42 +437,26 @@ config X86_INTEL_CE
 	  This option compiles in support for the CE4100 SOC for settop
 	  boxes and media devices.
 
-config X86_WANT_INTEL_MID
+config X86_INTEL_MID
 	bool "Intel MID platform support"
 	depends on X86_32
 	depends on X86_EXTENDED_PLATFORM
-	---help---
-	  Select to build a kernel capable of supporting Intel MID platform
-	  systems which do not have the PCI legacy interfaces (Moorestown,
-	  Medfield). If you are building for a PC class system say N here.
-
-if X86_WANT_INTEL_MID
-
-config X86_INTEL_MID
-	bool
-
-config X86_MDFLD
-       bool "Medfield MID platform"
 	depends on PCI
 	depends on PCI_GOANY
 	depends on X86_IO_APIC
-	select X86_INTEL_MID
 	select SFI
+	select I2C
 	select DW_APB_TIMER
 	select APB_TIMER
-	select I2C
-	select SPI
 	select INTEL_SCU_IPC
-	select X86_PLATFORM_DEVICES
 	select MFD_INTEL_MSIC
 	---help---
-	  Medfield is Intel's Low Power Intel Architecture (LPIA) based Moblin
-	  Internet Device(MID) platform. 
-	  Unlike standard x86 PCs, Medfield does not have many legacy devices
-	  nor standard legacy replacement devices/features. e.g. Medfield does
-	  not contain i8259, i8254, HPET, legacy BIOS, most of the io ports.
+	  Select to build a kernel capable of supporting Intel MID (Mobile
+	  Internet Device) platform systems which do not have the PCI legacy
+	  interfaces. If you are building for a PC class system say N here.
 
-endif
+	  Intel MID platforms are based on an Intel processor and chipset which
+	  consume less power than most of the x86 derivatives.
 
 config X86_INTEL_LPSS
 	bool "Intel Low Power Subsystem Support"
-- 
1.8.4.2

