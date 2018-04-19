Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:60428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753396AbeDSVFc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 19 Apr 2018 17:05:32 -0400
Subject: [PATCH v1 1/2] PCI/ASPM: Disable ASPM L1.2 Substate if we don't
 have LTR
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Sinan Kaya <okaya@codeaurora.org>,
        Rajat Jain <rajatja@google.com>,
        Srinath Mannam <srinath.mannam@broadcom.com>,
        Ray Jui <ray.jui@broadcom.com>,
        Keith Busch <keith.busch@intel.com>,
        linux-acpi@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org
Date: Thu, 19 Apr 2018 16:05:29 -0500
Message-ID: <152417192976.76853.5171081412139699180.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <152417080402.76853.4258398181136860884.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <152417080402.76853.4258398181136860884.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Bjorn Helgaas <bhelgaas@google.com>

When in the ASPM L1.0 state (but not the PCI-PM L1.0 state), the most
recent LTR value and the LTR_L1.2_THRESHOLD determines whether the link
enters the L1.2 substate.

If we don't have LTR enabled, prevent the use of ASPM L1.2.

PCI-PM L1.2 may still be used because it doesn't depend on
LTR_L1.2_THRESHOLD (see PCIe r4.0, sec 5.5.1).

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pcie/aspm.c |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index f76eb7704f64..c687c817b47d 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -400,6 +400,15 @@ static void pcie_get_aspm_reg(struct pci_dev *pdev,
 		info->l1ss_cap = 0;
 		return;
 	}
+
+	/*
+	 * If we don't have LTR for the entire path from the Root Complex
+	 * to this device, we can't use ASPM L1.2 because it relies on the
+	 * LTR_L1.2_THRESHOLD.  See PCIe r4.0, secs 5.5.4, 6.18.
+	 */
+	if (!pdev->ltr_path)
+		info->l1ss_cap &= ~PCI_L1SS_CAP_ASPM_L1_2;
+
 	pci_read_config_dword(pdev, info->l1ss_cap_ptr + PCI_L1SS_CTL1,
 			      &info->l1ss_ctl1);
 	pci_read_config_dword(pdev, info->l1ss_cap_ptr + PCI_L1SS_CTL2,
