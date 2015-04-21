Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Sonny Rao <sonnyrao@chromium.org>
To: linux-kernel@vger.kernel.org
Cc: Stephane Eranian <eranian@google.com>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Paul Mackerras <paulus@samba.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	"H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Sonny Rao <sonnyrao@chromium.org>
Subject: [PATCH] perf/x86/intel/uncore: Move PCI IDs for IMC to uncore driver
Date: Tue, 21 Apr 2015 12:09:55 -0700
Message-Id: <1429643395-25411-1-git-send-email-sonnyrao@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This keeps all the related PCI IDs together in the driver where they
are used.

Signed-off-by: Sonny Rao <sonnyrao@chromium.org>
---
 arch/x86/kernel/cpu/perf_event_intel_uncore_snb.c | 6 +++++-
 include/linux/pci_ids.h                           | 4 ----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/cpu/perf_event_intel_uncore_snb.c b/arch/x86/kernel/cpu/perf_event_intel_uncore_snb.c
index ca75e70..02c1a13 100644
--- a/arch/x86/kernel/cpu/perf_event_intel_uncore_snb.c
+++ b/arch/x86/kernel/cpu/perf_event_intel_uncore_snb.c
@@ -1,7 +1,11 @@
 /* Nehalem/SandBridge/Haswell uncore support */
 #include "perf_event_intel_uncore.h"
 
-/* Uncore IMC PCI Id */
+/* Uncore IMC PCI Ids */
+#define PCI_DEVICE_ID_INTEL_SNB_IMC	0x0100
+#define PCI_DEVICE_ID_INTEL_IVB_IMC	0x0154
+#define PCI_DEVICE_ID_INTEL_IVB_E3_IMC	0x0150
+#define PCI_DEVICE_ID_INTEL_HSW_IMC	0x0c00
 #define PCI_DEVICE_ID_INTEL_HSW_U_IMC	0x0a04
 
 /* SNB event control */
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 38cff8f..2f7b9a4 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -2541,10 +2541,6 @@
 
 #define PCI_VENDOR_ID_INTEL		0x8086
 #define PCI_DEVICE_ID_INTEL_EESSC	0x0008
-#define PCI_DEVICE_ID_INTEL_SNB_IMC	0x0100
-#define PCI_DEVICE_ID_INTEL_IVB_IMC	0x0154
-#define PCI_DEVICE_ID_INTEL_IVB_E3_IMC	0x0150
-#define PCI_DEVICE_ID_INTEL_HSW_IMC	0x0c00
 #define PCI_DEVICE_ID_INTEL_PXHD_0	0x0320
 #define PCI_DEVICE_ID_INTEL_PXHD_1	0x0321
 #define PCI_DEVICE_ID_INTEL_PXH_0	0x0329
-- 
2.1.2

