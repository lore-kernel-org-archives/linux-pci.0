Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: [PATCH v1 1/4] PCI/ASPM: Account for downstream device's Port
 Common_Mode_Restore_Time
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: Rajat Jain <rajatja@google.com>, linux-kernel@vger.kernel.org,
        Vidya Sagar <vidyas@nvidia.com>
Date: Mon, 13 Nov 2017 17:11:52 -0600
Message-ID: <20171113231152.4120.29379.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20171113230937.4120.68038.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20171113230937.4120.68038.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Bjorn Helgaas <bhelgaas@google.com>

Every Port that supports the L1.2 substate advertises its Port
Common_Mode_Restore_Time, i.e., the time the Port requires to re-establish
common mode when exiting L1.2 (see PCIe r3.1, sec 7.33.2).

Per sec 5.5.3.3.1, when exiting L1.2, the Downstream Port (the device at
the upstream end of the link) must send TS1 training sequences for at least
T(COMMONMODE) after it detects electrical idle exit on the Link.  We want
this to be long enough for both ends of the Link, so we should set it to
the maximum of the Port Common_Mode_Restore_Time for the upstream and
downstream components on the Link.

Previously we only looked at the Port Common_Mode_Restore_Time of the
upstream device, so if the downstream device required more time, we didn't
program the upstream device's T(COMMONMODE) correctly.

Fixes: f1f0366dd6be ("PCI/ASPM: Calculate and save the L1.2 timing parameters")
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Acked-by: Rajat Jain <rajatja@google.com>
CC: stable@vger.kernel.org	# v4.11+
---
 drivers/pci/pcie/aspm.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 0bea8498b5a5..46c59afb8355 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -452,7 +452,7 @@ static void aspm_calc_l1ss_info(struct pcie_link_state *link,
 
 	/* Choose the greater of the two T_cmn_mode_rstr_time */
 	val1 = (upreg->l1ss_cap >> 8) & 0xFF;
-	val2 = (upreg->l1ss_cap >> 8) & 0xFF;
+	val2 = (dwreg->l1ss_cap >> 8) & 0xFF;
 	if (val1 > val2)
 		link->l1ss.ctl1 |= val1 << 8;
 	else
