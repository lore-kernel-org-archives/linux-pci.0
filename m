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
Subject: [PATCHv2] perf/x86/intel/uncore: add support for Haswell ULT IMC uncore
Date: Mon, 20 Apr 2015 15:34:07 -0700
Message-Id: <1429569247-16697-1-git-send-email-sonnyrao@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This uncore is the same as the Haswell desktop part but uses a
different PCI ID.

Signed-off-by: Sonny Rao <sonnyrao@chromium.org>
---
 arch/x86/kernel/cpu/perf_event_intel_uncore_snb.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/x86/kernel/cpu/perf_event_intel_uncore_snb.c b/arch/x86/kernel/cpu/perf_event_intel_uncore_snb.c
index 3001015..ca75e70 100644
--- a/arch/x86/kernel/cpu/perf_event_intel_uncore_snb.c
+++ b/arch/x86/kernel/cpu/perf_event_intel_uncore_snb.c
@@ -1,6 +1,9 @@
 /* Nehalem/SandBridge/Haswell uncore support */
 #include "perf_event_intel_uncore.h"
 
+/* Uncore IMC PCI Id */
+#define PCI_DEVICE_ID_INTEL_HSW_U_IMC	0x0a04
+
 /* SNB event control */
 #define SNB_UNC_CTL_EV_SEL_MASK			0x000000ff
 #define SNB_UNC_CTL_UMASK_MASK			0x0000ff00
@@ -472,6 +475,10 @@ static const struct pci_device_id hsw_uncore_pci_ids[] = {
 		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_HSW_IMC),
 		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
 	},
+	{ /* IMC */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_HSW_U_IMC),
+		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
+	},
 	{ /* end: all zeroes */ },
 };
 
@@ -502,6 +509,7 @@ static const struct imc_uncore_pci_dev desktop_imc_pci_ids[] = {
 	IMC_DEV(IVB_IMC, &ivb_uncore_pci_driver),    /* 3rd Gen Core processor */
 	IMC_DEV(IVB_E3_IMC, &ivb_uncore_pci_driver), /* Xeon E3-1200 v2/3rd Gen Core processor */
 	IMC_DEV(HSW_IMC, &hsw_uncore_pci_driver),    /* 4th Gen Core Processor */
+	IMC_DEV(HSW_U_IMC, &hsw_uncore_pci_driver),  /* 4th Gen Core ULT Mobile Processor */
 	{  /* end marker */ }
 };
 
-- 
2.1.2

