Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Vadim Lomovtsev <Vadim.Lomovtsev@caviumnetworks.com>
To: bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, alex.williamson@redhat.com
Cc: Wilson.Snyder@cavium.com, robert.richter@cavium.com,
        david.daney@cavium.com, mjaggi@caviumnetworks.com,
        Vadim Lomovtsev <Vadim.Lomovtsev@cavium.com>
Subject: [PATCH v7 2/2] PCI: quirks: Apply Cavium ThunderX ACS quirk only to Root Ports
Date: Tue, 17 Oct 2017 05:47:39 -0700
Message-Id: <1508244459-2615-3-git-send-email-Vadim.Lomovtsev@caviumnetworks.com>
In-Reply-To: <1508244459-2615-1-git-send-email-Vadim.Lomovtsev@caviumnetworks.com>
References: <1506536439-29318-1-git-send-email-Vadim.Lomovtsev@caviumnetworks.com>
 <1508244459-2615-1-git-send-email-Vadim.Lomovtsev@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Vadim Lomovtsev <Vadim.Lomovtsev@cavium.com>

This commit changes the Cavium PCI ACS quirk appliance only to
Cavium CN8xxx PICe Root Ports.

Current quirk implementation doesn't take into account PCIe Root Ports
which needs to be quirked. So the pci device id check mask is updated
accordingly to CN8xxx device identification scheme and check of device
ID moved into separate function.

Signed-off-by: Vadim Lomovtsev <Vadim.Lomovtsev@cavium.com>
---
 drivers/pci/quirks.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 5e0e83304fda..cfefb2431348 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -4211,6 +4211,19 @@ static int pci_quirk_amd_sb_acs(struct pci_dev *dev, u16 acs_flags)
 #endif
 }
 
+static bool pci_quirk_cavium_acs_match(struct pci_dev *dev)
+{
+	/*
+	 * Effectively selects all downstream ports for whole ThunderX 1 
+	 * family by 0xf800 mask (which represents 8 SoCs), while the lower
+	 * bits of device ID are used to indicate which subdevice is used 
+	 * within the SoC.
+	 */
+	return (pci_is_pcie(dev) &&
+		(pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT) &&
+		((dev->device & 0xf800) == 0xa000));
+}
+
 static int pci_quirk_cavium_acs(struct pci_dev *dev, u16 acs_flags)
 {
 	/*
@@ -4222,7 +4235,7 @@ static int pci_quirk_cavium_acs(struct pci_dev *dev, u16 acs_flags)
 	 */
 	acs_flags &= ~(PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_SV | PCI_ACS_UF);
 
-	if (!((dev->device >= 0xa000) && (dev->device <= 0xa0ff)))
+	if (!pci_quirk_cavium_acs_match(dev))
 		return -ENOTTY;
 
 	return acs_flags ? 0 : 1;
-- 
2.13.6
