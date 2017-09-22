Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
To: <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-pci@vger.kernel.org>, <bhelgaas@google.com>,
        <roy.zang@nxp.com>, <mingkai.hu@nxp.com>, <minghuan.lian@nxp.com>
CC: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Subject: [PATCH 1/2] PCI: Disable MSI for Freescale PCIe RC mode
Date: Fri, 22 Sep 2017 15:25:21 +0800
Message-ID: <20170922072522.36306-2-Zhiqiang.Hou@nxp.com>
In-Reply-To: <20170922072522.36306-1-Zhiqiang.Hou@nxp.com>
References: <20170922072522.36306-1-Zhiqiang.Hou@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

The Freescale PCIe controller advertises the MSI/MSI-X capability
in both RC and Endpoint mode, but in RC mode it doesn't support
MSI/MSI-X by it self, it can only transfer MSI/MSI-X from downstream
devices. So add this quirk to prevent use of MSI/MSI-X in RC mode.

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
---
 drivers/pci/quirks.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index a4d33619a7bb..c1063a420f0c 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -4799,3 +4799,11 @@ static void quirk_no_ats(struct pci_dev *pdev)
 /* AMD Stoney platform GPU */
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x98e4, quirk_no_ats);
 #endif /* CONFIG_PCI_ATS */
+
+/* Freescale PCIe doesn't support MSI in RC mode */
+static void quirk_fsl_no_msi(struct pci_dev *pdev)
+{
+	if (pci_pcie_type(pdev) == PCI_EXP_TYPE_ROOT_PORT)
+		pdev->no_msi = 1;
+}
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_FREESCALE, PCI_ANY_ID, quirk_fsl_no_msi);
-- 
2.14.1
