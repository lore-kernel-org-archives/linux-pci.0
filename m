Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: [PATCH v1 4/4] PCI/ASPM: Add L1 Substates definitions
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: Rajat Jain <rajatja@google.com>, linux-kernel@vger.kernel.org,
        Vidya Sagar <vidyas@nvidia.com>
Date: Mon, 13 Nov 2017 17:12:16 -0600
Message-ID: <20171113231216.4120.36309.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20171113230937.4120.68038.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20171113230937.4120.68038.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Bjorn Helgaas <bhelgaas@google.com>

Add and use #defines for L1 Substate register fields instead of hard-coding
the masks.  Also update comments to use names from the spec.  No functional
change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pcie/aspm.c       |   34 ++++++++++++++++++++--------------
 include/uapi/linux/pci_regs.h |    6 ++++++
 2 files changed, 26 insertions(+), 14 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index a378dd9d2473..d240ffab24c1 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -450,24 +450,25 @@ static void aspm_calc_l1ss_info(struct pcie_link_state *link,
 	if (!(link->aspm_support & ASPM_STATE_L1_2_MASK))
 		return;
 
-	/* Choose the greater of the two T_cmn_mode_rstr_time */
-	val1 = (upreg->l1ss_cap >> 8) & 0xFF;
-	val2 = (dwreg->l1ss_cap >> 8) & 0xFF;
+	/* Choose the greater of the two Port Common_Mode_Restore_Times */
+	val1 = (upreg->l1ss_cap & PCI_L1SS_CAP_CM_RESTORE_TIME) >> 8;
+	val2 = (dwreg->l1ss_cap & PCI_L1SS_CAP_CM_RESTORE_TIME) >> 8;
 	if (val1 > val2)
 		link->l1ss.ctl1 |= val1 << 8;
 	else
 		link->l1ss.ctl1 |= val2 << 8;
+
 	/*
 	 * We currently use LTR L1.2 threshold to be fixed constant picked from
 	 * Intel's coreboot.
 	 */
 	link->l1ss.ctl1 |= LTR_L1_2_THRESHOLD_BITS;
 
-	/* Choose the greater of the two T_pwr_on */
-	val1 = (upreg->l1ss_cap >> 19) & 0x1F;
-	scale1 = (upreg->l1ss_cap >> 16) & 0x03;
-	val2 = (dwreg->l1ss_cap >> 19) & 0x1F;
-	scale2 = (dwreg->l1ss_cap >> 16) & 0x03;
+	/* Choose the greater of the two Port T_POWER_ON times */
+	val1   = (upreg->l1ss_cap & PCI_L1SS_CAP_P_PWR_ON_VALUE) >> 19;
+	scale1 = (upreg->l1ss_cap & PCI_L1SS_CAP_P_PWR_ON_SCALE) >> 16;
+	val2   = (dwreg->l1ss_cap & PCI_L1SS_CAP_P_PWR_ON_VALUE) >> 19;
+	scale2 = (dwreg->l1ss_cap & PCI_L1SS_CAP_P_PWR_ON_SCALE) >> 16;
 
 	if (calc_l1ss_pwron(link->pdev, scale1, val1) >
 	    calc_l1ss_pwron(link->downstream, scale2, val2))
@@ -646,21 +647,26 @@ static void pcie_config_aspm_l1ss(struct pcie_link_state *link, u32 state)
 
 	if (enable_req & ASPM_STATE_L1_2_MASK) {
 
-		/* Program T_pwr_on in both ports */
+		/* Program T_POWER_ON times in both ports */
 		pci_write_config_dword(parent, up_cap_ptr + PCI_L1SS_CTL2,
 				       link->l1ss.ctl2);
 		pci_write_config_dword(child, dw_cap_ptr + PCI_L1SS_CTL2,
 				       link->l1ss.ctl2);
 
-		/* Program T_cmn_mode in parent */
+		/* Program Common_Mode_Restore_Time in upstream device */
 		pci_clear_and_set_dword(parent, up_cap_ptr + PCI_L1SS_CTL1,
-					0xFF00, link->l1ss.ctl1);
+					PCI_L1SS_CTL1_CM_RESTORE_TIME,
+					link->l1ss.ctl1);
 
-		/* Program LTR L1.2 threshold in both ports */
+		/* Program LTR_L1.2_THRESHOLD time in both ports */
 		pci_clear_and_set_dword(parent,	up_cap_ptr + PCI_L1SS_CTL1,
-					0xE3FF0000, link->l1ss.ctl1);
+					PCI_L1SS_CTL1_LTR_L12_TH_VALUE |
+					PCI_L1SS_CTL1_LTR_L12_TH_SCALE,
+					link->l1ss.ctl1);
 		pci_clear_and_set_dword(child, dw_cap_ptr + PCI_L1SS_CTL1,
-					0xE3FF0000, link->l1ss.ctl1);
+					PCI_L1SS_CTL1_LTR_L12_TH_VALUE |
+					PCI_L1SS_CTL1_LTR_L12_TH_SCALE,
+					link->l1ss.ctl1);
 	}
 
 	val = 0;
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index 4150acb4cccb..85a4014de42e 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -1002,12 +1002,18 @@
 #define  PCI_L1SS_CAP_ASPM_L1_2		0x00000004  /* ASPM L1.2 Supported */
 #define  PCI_L1SS_CAP_ASPM_L1_1		0x00000008  /* ASPM L1.1 Supported */
 #define  PCI_L1SS_CAP_L1_PM_SS		0x00000010  /* L1 PM Substates Supported */
+#define  PCI_L1SS_CAP_CM_RESTORE_TIME	0x0000ff00  /* Port Common_Mode_Restore_Time */
+#define  PCI_L1SS_CAP_P_PWR_ON_SCALE	0x00030000  /* Port T_POWER_ON scale */
+#define  PCI_L1SS_CAP_P_PWR_ON_VALUE	0x00f80000  /* Port T_POWER_ON value */
 #define PCI_L1SS_CTL1		0x08	/* Control 1 Register */
 #define  PCI_L1SS_CTL1_PCIPM_L1_2	0x00000001  /* PCI-PM L1.2 Enable */
 #define  PCI_L1SS_CTL1_PCIPM_L1_1	0x00000002  /* PCI-PM L1.1 Enable */
 #define  PCI_L1SS_CTL1_ASPM_L1_2	0x00000004  /* ASPM L1.2 Enable */
 #define  PCI_L1SS_CTL1_ASPM_L1_1	0x00000008  /* ASPM L1.1 Enable */
 #define  PCI_L1SS_CTL1_L1SS_MASK	0x0000000f
+#define  PCI_L1SS_CTL1_CM_RESTORE_TIME	0x0000ff00  /* Common_Mode_Restore_Time */
+#define  PCI_L1SS_CTL1_LTR_L12_TH_VALUE	0x03ff0000  /* LTR_L1.2_THRESHOLD_Value */
+#define  PCI_L1SS_CTL1_LTR_L12_TH_SCALE	0xe0000000  /* LTR_L1.2_THRESHOLD_Scale */
 #define PCI_L1SS_CTL2		0x0c	/* Control 2 Register */
 
 #endif /* LINUX_PCI_REGS_H */
