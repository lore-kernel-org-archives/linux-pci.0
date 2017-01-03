Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pf0-f178.google.com ([209.85.192.178]:33511 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934531AbdACGej (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 Jan 2017 01:34:39 -0500
Received: by mail-pf0-f178.google.com with SMTP id d2so75695164pfd.0
        for <linux-pci@vger.kernel.org>; Mon, 02 Jan 2017 22:34:33 -0800 (PST)
From: Rajat Jain <rajatja@google.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Keith Busch <keith.busch@intel.com>,
        Andreas Ziegler <andreas.ziegler@fau.de>,
        Jonathan Yong <jonathan.yong@intel.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        David Daney <david.daney@cavium.com>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        Ram Amrani <Ram.Amrani@cavium.com>,
        Doug Ledford <dledford@redhat.com>,
        Wang Sheng-Hui <shhuiw@foxmail.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Rajat Jain <rajatja@google.com>, Rajat Jain <rajatxjain@gmail.com>,
        Brian Norris <briannorris@google.com>
Subject: [PATCH 2/6] PCI/ASPM: Introduce L1 substates and a Kconfig for it
Date: Mon,  2 Jan 2017 22:34:11 -0800
Message-Id: <1483425255-101923-3-git-send-email-rajatja@google.com>
In-Reply-To: <1483425255-101923-1-git-send-email-rajatja@google.com>
References: <1483425255-101923-1-git-send-email-rajatja@google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Introduce the L1 sub states. (For details about L1 substates,
please refer to:
https://pcisig.com/sites/default/files/specification_documents/ECN_L1_PM_Substates_with_CLKREQ_31_May_2013_Rev10a.pdf)

This patch adds macros for the 4 new L1 substates, and adds
a new ASPM "POWER_SUPERSAVE" policy that can be used to enable
L1 substates on a system if desired. The new policy is in a sense,
a super set of the existing POWERSAVE policy. The 4 policies are now:

DEFAULT: Reads and uses whatever ASPM states BIOS enabled
PERFORMANCE: Everything except L0 disabled.
POWERSAVE: L0s and L1 enabled (but not L1 substates)
POWER_SUPERSAVE: L0s + L1 + L1 substates also enabled.

Signed-off-by: Rajat Jain <rajatja@google.com>
---
 drivers/pci/pcie/Kconfig |  8 ++++++++
 drivers/pci/pcie/aspm.c  | 39 +++++++++++++++++++++++++++++----------
 2 files changed, 37 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/pcie/Kconfig b/drivers/pci/pcie/Kconfig
index 7ce7763..ac53edb 100644
--- a/drivers/pci/pcie/Kconfig
+++ b/drivers/pci/pcie/Kconfig
@@ -71,6 +71,14 @@ config PCIEASPM_POWERSAVE
 	  Enable PCI Express ASPM L0s and L1 where possible, even if the
 	  BIOS did not.
 
+config PCIEASPM_POWER_SUPERSAVE
+	bool "Power Supersave"
+	depends on PCIEASPM
+	help
+	  Same as PCIEASPM_POWERSAVE, except it also enables L1 substates where
+	  possible. This would result in higher power savings while staying in L1
+	  where the components support it.
+
 config PCIEASPM_PERFORMANCE
 	bool "Performance"
 	depends on PCIEASPM
diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 17ac1dc..402c229 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -30,8 +30,17 @@
 #define ASPM_STATE_L0S_UP	(1)	/* Upstream direction L0s state */
 #define ASPM_STATE_L0S_DW	(2)	/* Downstream direction L0s state */
 #define ASPM_STATE_L1		(4)	/* L1 state */
+#define ASPM_STATE_L1_1		(8)	/* ASPM L1.1 state */
+#define ASPM_STATE_L1_2		(0x10)	/* ASPM L1.2 state */
+#define ASPM_STATE_L1_1_PCIPM	(0x20)	/* PCI PM L1.1 state */
+#define ASPM_STATE_L1_2_PCIPM	(0x40)	/* PCI PM L1.2 state */
+#define ASPM_STATE_L1_SS_PCIPM	(ASPM_STATE_L1_1_PCIPM | ASPM_STATE_L1_2_PCIPM)
+#define ASPM_STATE_L1_2_MASK	(ASPM_STATE_L1_2 | ASPM_STATE_L1_2_PCIPM)
+#define ASPM_STATE_L1SS		(ASPM_STATE_L1_1 | ASPM_STATE_L1_1_PCIPM |\
+				 ASPM_STATE_L1_2_MASK)
 #define ASPM_STATE_L0S		(ASPM_STATE_L0S_UP | ASPM_STATE_L0S_DW)
-#define ASPM_STATE_ALL		(ASPM_STATE_L0S | ASPM_STATE_L1)
+#define ASPM_STATE_ALL		(ASPM_STATE_L0S | ASPM_STATE_L1 |	\
+				 ASPM_STATE_L1SS)
 
 struct aspm_latency {
 	u32 l0s;			/* L0s latency (nsec) */
@@ -47,11 +56,11 @@ struct pcie_link_state {
 	struct list_head link;		/* node in parent's children list */
 
 	/* ASPM state */
-	u32 aspm_support:3;		/* Supported ASPM state */
-	u32 aspm_enabled:3;		/* Enabled ASPM state */
-	u32 aspm_capable:3;		/* Capable ASPM state with latency */
-	u32 aspm_default:3;		/* Default ASPM state by BIOS */
-	u32 aspm_disable:3;		/* Disabled ASPM state */
+	u32 aspm_support:7;		/* Supported ASPM state */
+	u32 aspm_enabled:7;		/* Enabled ASPM state */
+	u32 aspm_capable:7;		/* Capable ASPM state with latency */
+	u32 aspm_default:7;		/* Default ASPM state by BIOS */
+	u32 aspm_disable:7;		/* Disabled ASPM state */
 
 	/* Clock PM state */
 	u32 clkpm_capable:1;		/* Clock PM capable? */
@@ -76,11 +85,14 @@ static LIST_HEAD(link_list);
 #define POLICY_DEFAULT 0	/* BIOS default setting */
 #define POLICY_PERFORMANCE 1	/* high performance */
 #define POLICY_POWERSAVE 2	/* high power saving */
+#define POLICY_POWER_SUPERSAVE 3 /* Possibly Even higher power saving */
 
 #ifdef CONFIG_PCIEASPM_PERFORMANCE
 static int aspm_policy = POLICY_PERFORMANCE;
 #elif defined CONFIG_PCIEASPM_POWERSAVE
 static int aspm_policy = POLICY_POWERSAVE;
+#elif defined CONFIG_PCIEASPM_POWER_SUPERSAVE
+static int aspm_policy = POLICY_POWER_SUPERSAVE;
 #else
 static int aspm_policy;
 #endif
@@ -88,7 +100,8 @@ static int aspm_policy;
 static const char *policy_str[] = {
 	[POLICY_DEFAULT] = "default",
 	[POLICY_PERFORMANCE] = "performance",
-	[POLICY_POWERSAVE] = "powersave"
+	[POLICY_POWERSAVE] = "powersave",
+	[POLICY_POWER_SUPERSAVE] = "powersupersave"
 };
 
 #define LINK_RETRAIN_TIMEOUT HZ
@@ -101,6 +114,9 @@ static int policy_to_aspm_state(struct pcie_link_state *link)
 		return 0;
 	case POLICY_POWERSAVE:
 		/* Enable ASPM L0s/L1 */
+		return (ASPM_STATE_L0S | ASPM_STATE_L1);
+	case POLICY_POWER_SUPERSAVE:
+		/* Enable Everything */
 		return ASPM_STATE_ALL;
 	case POLICY_DEFAULT:
 		return link->aspm_default;
@@ -115,7 +131,8 @@ static int policy_to_clkpm_state(struct pcie_link_state *link)
 		/* Disable ASPM and Clock PM */
 		return 0;
 	case POLICY_POWERSAVE:
-		/* Disable Clock PM */
+	case POLICY_POWER_SUPERSAVE:
+		/* Enable Clock PM */
 		return 1;
 	case POLICY_DEFAULT:
 		return link->clkpm_default;
@@ -612,7 +629,8 @@ void pcie_aspm_init_link_state(struct pci_dev *pdev)
 	 * the BIOS's expectation, we'll do so once pci_enable_device() is
 	 * called.
 	 */
-	if (aspm_policy != POLICY_POWERSAVE) {
+	if (aspm_policy != POLICY_POWERSAVE &&
+	    aspm_policy != POLICY_POWER_SUPERSAVE) {
 		pcie_config_aspm_path(link);
 		pcie_set_clkpm(link, policy_to_clkpm_state(link));
 	}
@@ -712,7 +730,8 @@ void pcie_aspm_powersave_config_link(struct pci_dev *pdev)
 	if (aspm_disabled || !link)
 		return;
 
-	if (aspm_policy != POLICY_POWERSAVE)
+	if (aspm_policy != POLICY_POWERSAVE &&
+	    aspm_policy != POLICY_POWER_SUPERSAVE)
 		return;
 
 	down_read(&pci_bus_sem);
-- 
2.8.0.rc3.226.g39d4020

