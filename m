Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Sinan Kaya <okaya@codeaurora.org>
To: linux-pci@vger.kernel.org, timur@codeaurora.org
Cc: mayurkumar.patel@intel.com, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Sinan Kaya <okaya@codeaurora.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rajat Jain <rajatja@google.com>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        David Daney <david.daney@cavium.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V6 2/5] PCI/ASPM: split pci_aspm_init() into two
Date: Wed, 29 Mar 2017 19:04:24 -0400
Message-Id: <1490828667-30973-3-git-send-email-okaya@codeaurora.org>
In-Reply-To: <1490828667-30973-1-git-send-email-okaya@codeaurora.org>
References: <1490828667-30973-1-git-send-email-okaya@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Split pci_aspm_init() body into pci_aspm_init_upstream()
and pci_aspm_init_downstream() for bridge and endpoint
specific code behavior.

Fixes: https://bugzilla.kernel.org/show_bug.cgi?id=194895
Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/pci/pcie/aspm.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index dc36717..a80d64b 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -826,6 +826,16 @@ static struct pcie_link_state *alloc_pcie_link_state(struct pci_dev *pdev)
 	return link;
 }
 
+static int pci_aspm_init_downstream(struct pci_dev *pdev)
+{
+	return 0;
+}
+
+static int pci_aspm_init_upstream(struct pci_dev *pdev)
+{
+	return 0;
+}
+
 /*
  * pci_aspm_init: Initiate PCI express link state.
  * It is called from device_add for every single pci device.
@@ -833,7 +843,10 @@ static struct pcie_link_state *alloc_pcie_link_state(struct pci_dev *pdev)
  */
 int pci_aspm_init(struct pci_dev *pdev)
 {
-	return 0;
+	if (!pdev->has_secondary_link)
+		return pci_aspm_init_downstream(pdev);
+
+	return pci_aspm_init_upstream(pdev);
 }
 
 /*
-- 
1.9.1
