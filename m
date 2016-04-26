Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:12106 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751848AbcDZUr6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 26 Apr 2016 16:47:58 -0400
From: Keith Busch <keith.busch@intel.com>
To: Martin Mares <mj@ucw.cz>, linux-pci@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Keith Busch <keith.busch@intel.com>
Subject: [PATCH] Add support for Downstream Port Containment
Date: Tue, 26 Apr 2016 14:47:53 -0600
Message-Id: <1461703673-29363-1-git-send-email-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The PCI SIG added the Downstream Port Containment capability. This patch
decodes this for lspci and defines the extended capability for setpci.

Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 lib/header.h | 26 ++++++++++++++++++++++++++
 ls-ecaps.c   | 34 ++++++++++++++++++++++++++++++++++
 setpci.c     |  1 +
 3 files changed, 61 insertions(+)

diff --git a/lib/header.h b/lib/header.h
index b8f7dc1..b7cbc9d 100644
--- a/lib/header.h
+++ b/lib/header.h
@@ -230,6 +230,7 @@
 #define PCI_EXT_CAP_ID_LTR	0x18	/* Latency Tolerance Reporting */
 #define PCI_EXT_CAP_ID_PASID	0x1b	/* Process Address Space ID */
 #define PCI_EXT_CAP_ID_L1PM	0x1e	/* L1 PM Substates */
+#define PCI_EXT_CAP_ID_DPC	0x1d	/* Downstream Port Containment */
 
 /*** Definitions of capabilities ***/
 
@@ -1090,6 +1091,31 @@
 #define  PCI_PASID_CTRL_ENABLE	0x01	/* Enable bit */
 #define  PCI_PASID_CTRL_EXEC	0x02	/* Exec permissions Enable */
 #define  PCI_PASID_CTRL_PRIV	0x04	/* Privilege Mode Enable */
+
+#define PCI_DPC_CAP		4	/* DPC Capability */
+#define  PCI_DPC_CAP_INT_MSG(x) ((x) & 0x1f)	/* DPC Interrupt Message Number */
+#define  PCI_DPC_CAP_RP_EXT	0x20		/* DPC Root Port Extentions */
+#define  PCI_DPC_CAP_TLP_BLOCK	0x40		/* DPC Poisoned TLP Egress Blocking */
+#define  PCI_DPC_CAP_SW_TRIGGER	0x80		/* DPC Software Trigger */
+#define  PCI_DPC_CAP_RP_LOG(x)	(((x) >> 8) & 0xf) /* DPC RP PIO Log Size */
+#define  PCI_DPC_CAP_DL_ACT_ERR	0x1000		/* DPC DL_Active ERR_COR Signal */
+#define PCI_DPC_CTL		6	/* DPC Control */
+#define  PCI_DPC_CTL_TRIGGER(x) ((x) & 0x3)	/* DPC Trigger Enable */
+#define  PCI_DPC_CTL_CMPL	0x4		/* DPC Completion Control */
+#define  PCI_DPC_CTL_INT	0x8		/* DPC Interrupt Enabled */
+#define  PCI_DPC_CTL_ERR_COR	0x10		/* DPC ERR_COR Enabled */
+#define  PCI_DPC_CTL_TLP	0x20		/* DPC Poisoned TLP Egress Blocking Enabled */
+#define  PCI_DPC_CTL_SW_TRIGGER	0x40		/* DPC Software Trigger */
+#define  PCI_DPC_CTL_DL_ACTIVE	0x80		/* DPC DL_Active ERR_COR Enable */
+#define PCI_DPC_STATUS		8	/* DPC STATUS */
+#define  PCI_DPC_STS_TRIGGER	0x01		/* DPC Trigger Status */
+#define  PCI_DPC_STS_REASON(x) (((x) >> 1) & 0x3) /* DPC Trigger Reason */
+#define  PCI_DPC_STS_INT	0x08		/* DPC Interrupt Status */
+#define  PCI_DPC_STS_RP_BUSY	0x10		/* DPC Root Port Busy */
+#define  PCI_DPC_STS_TRIGGER_EXT(x) (((x) >> 5) & 0x3) /* Trigger Reason Extention */
+#define  PCI_DPC_STS_PIO_FEP(x) (((x) >> 8) & 0x1f) /* DPC PIO First Error Pointer */
+#define PCI_DPC_SOURCE		10	/* DPC Source ID */
+
 /*
  * The PCI interface treats multi-function devices as independent
  * devices.  The slot/function address of each device is encoded
diff --git a/ls-ecaps.c b/ls-ecaps.c
index 8298435..e02c1be 100644
--- a/ls-ecaps.c
+++ b/ls-ecaps.c
@@ -137,6 +137,37 @@ cap_aer(struct device *d, int where)
 
 }
 
+static void cap_dpc(struct device *d, int where)
+{
+  u16 l;
+
+  printf("Downstream Port Containment\n");
+  if (verbose < 2)
+    return;
+
+  if (!config_fetch(d, where + PCI_DPC_CAP, 8))
+    return;
+
+  l = get_conf_word(d, where + PCI_DPC_CAP);
+  printf("\t\tDpcCap:\tINT Msg #%d, RPExt%c PoisonedTLP%c SwTrigger%c RP PIO Log %d, DL_ActiveErr%c\n",
+    PCI_DPC_CAP_INT_MSG(l), FLAG(l, PCI_DPC_CAP_RP_EXT), FLAG(l, PCI_DPC_CAP_TLP_BLOCK),
+    FLAG(l, PCI_DPC_CAP_SW_TRIGGER), PCI_DPC_CAP_RP_LOG(l), FLAG(l, PCI_DPC_CAP_DL_ACT_ERR));
+
+  l = get_conf_word(d, where + PCI_DPC_CTL);
+  printf("\t\tDpcCtl:\tTrigger:%x Cmpl%c INT%c ErrCor%c PoisonedTLP%c SwTrigger%c DL_ActiveErr%c\n",
+    PCI_DPC_CTL_TRIGGER(l), FLAG(l, PCI_DPC_CTL_CMPL), FLAG(l, PCI_DPC_CTL_INT),
+    FLAG(l, PCI_DPC_CTL_ERR_COR), FLAG(l, PCI_DPC_CTL_TLP), FLAG(l, PCI_DPC_CTL_SW_TRIGGER),
+    FLAG(l, PCI_DPC_CTL_DL_ACTIVE));
+
+  l = get_conf_word(d, where + PCI_DPC_STATUS);
+  printf("\t\tDpcSta:\tTrigger%c Reason:%02x INT%c RPBusy%c TriggerExt:%02x RP PIO ErrPtr:%02x\n",
+    FLAG(l, PCI_DPC_STS_TRIGGER), PCI_DPC_STS_REASON(l), FLAG(l, PCI_DPC_STS_INT),
+    FLAG(l, PCI_DPC_STS_RP_BUSY), PCI_DPC_STS_TRIGGER_EXT(l), PCI_DPC_STS_PIO_FEP(l));
+
+  l = get_conf_word(d, where + PCI_DPC_SOURCE);
+  printf("\t\tSource:\t%04x\n", l);
+}
+
 static void
 cap_acs(struct device *d, int where)
 {
@@ -580,6 +611,9 @@ show_ext_caps(struct device *d)
 	  case PCI_EXT_CAP_ID_AER:
 	    cap_aer(d, where);
 	    break;
+	  case PCI_EXT_CAP_ID_DPC:
+	    cap_dpc(d, where);
+	    break;
 	  case PCI_EXT_CAP_ID_VC:
 	  case PCI_EXT_CAP_ID_VC2:
 	    cap_vc(d, where);
diff --git a/setpci.c b/setpci.c
index acf7689..e77dc13 100644
--- a/setpci.c
+++ b/setpci.c
@@ -301,6 +301,7 @@ static const struct reg_name pci_reg_names[] = {
   { 0x2000e,	0, 0, "ECAP_ARI" },
   { 0x2000f,	0, 0, "ECAP_ATS" },
   { 0x20010,	0, 0, "ECAP_SRIOV" },
+  { 0x2001d,	0, 0, "ECAP_DPC" },
   {       0,    0, 0, NULL }
 };
 
-- 
2.7.2

