Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
To: <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-pci@vger.kernel.org>, <bhelgaas@google.com>,
        <roy.zang@nxp.com>, <mingkai.hu@nxp.com>, <minghuan.lian@nxp.com>
CC: Minghuan Lian <Minghuan.Lian@nxp.com>,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Subject: [PATCHv2 2/2] pci/layerscape: change the default error response behavior
Date: Thu, 12 Oct 2017 17:44:48 +0800
Message-ID: <20171012094448.31217-3-Zhiqiang.Hou@nxp.com>
In-Reply-To: <20171012094448.31217-1-Zhiqiang.Hou@nxp.com>
References: <20171012094448.31217-1-Zhiqiang.Hou@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Minghuan Lian <Minghuan.Lian@nxp.com>

By default, when the PCIe controller experiences an erroneous
completion from an external completer for its outbound non-posted
request, it always sends an OKAY response to the device's internal
AXI slave system interface. However, such default system error
response behavior cannot be used for other types of outbound
non-posted requests. For example, the outbound memory read
transaction requires an actual ERROR response, like UR completion
or completion timeout. The patch is to fix it by forwarding
the error response of the non-posted request.

Signed-off-by: Minghuan Lian <Minghuan.Lian@nxp.com>
Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
---
V2:
 - Removed the parameter ls_pcie which is for debugging.

 drivers/pci/dwc/pci-layerscape.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/pci/dwc/pci-layerscape.c b/drivers/pci/dwc/pci-layerscape.c
index 87fa486bee2c..3a4277a5ab2c 100644
--- a/drivers/pci/dwc/pci-layerscape.c
+++ b/drivers/pci/dwc/pci-layerscape.c
@@ -33,6 +33,8 @@
 
 /* PEX Internal Configuration Registers */
 #define PCIE_STRFMR1		0x71c /* Symbol Timer & Filter Mask Register1 */
+#define PCIE_ABSERR		0x8d0 /* Bridge Slave Error Response Register */
+#define PCIE_ABSERR_SETTING	0x9401 /* Forward error of non-posted request */
 
 #define PCIE_IATU_NUM		6
 
@@ -124,6 +126,14 @@ static int ls_pcie_link_up(struct dw_pcie *pci)
 	return 1;
 }
 
+/* Forward error response of outbound non-posted requests */
+static void ls_pcie_fix_error_response(struct ls_pcie *pcie)
+{
+	struct dw_pcie *pci = pcie->pci;
+
+	iowrite32(PCIE_ABSERR_SETTING, pci->dbi_base + PCIE_ABSERR);
+}
+
 static int ls_pcie_host_init(struct pcie_port *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
@@ -135,6 +145,7 @@ static int ls_pcie_host_init(struct pcie_port *pp)
 	 * dw_pcie_setup_rc() will reconfigure the outbound windows.
 	 */
 	ls_pcie_disable_outbound_atus(pcie);
+	ls_pcie_fix_error_response(pcie);
 
 	dw_pcie_dbi_ro_wr_en(pci);
 	ls_pcie_clear_multifunction(pcie);
-- 
2.14.1
