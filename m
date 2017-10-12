Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
To: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-pci@vger.kernel.org>, <bhelgaas@google.com>, <roy.zang@nxp.com>,
 <mingkai.hu@nxp.com>, <minghuan.lian@nxp.com>
Subject: [PATCHv2 1/2] PCI: Disable MSI for Freescale PCIe RC mode
Date: Thu, 12 Oct 2017 17:44:47 +0800
Message-ID: <20171012094448.31217-2-Zhiqiang.Hou@nxp.com>
In-Reply-To: <20171012094448.31217-1-Zhiqiang.Hou@nxp.com>
References: <20171012094448.31217-1-Zhiqiang.Hou@nxp.com>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

The Freescale PCIe controller advertises the MSI/MSI-X capability
in both RC and Endpoint mode, but in RC mode it doesn't support
MSI/MSI-X by itself, it can only transfer MSI/MSI-X from downstream
devices. So add this quirk to prevent use of MSI/MSI-X in RC mode.

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Acked-by: Minghuan Lian <minghuan.Lian@nxp.com>
---
V2:
 - Fixed a typo in the commit message.

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


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
