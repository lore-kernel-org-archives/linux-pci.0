Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Minghuan Lian <Minghuan.Lian@nxp.com>
To: <linux-pci@vger.kernel.org>
Subject: [PATCH 2/2] pci/layerscape: fix error response behavior
Date: Thu, 8 Sep 2016 14:25:50 +0800
Message-ID: <1473315950-6396-2-git-send-email-Minghuan.Lian@nxp.com>
In-Reply-To: <1473315950-6396-1-git-send-email-Minghuan.Lian@nxp.com>
References: <1473315950-6396-1-git-send-email-Minghuan.Lian@nxp.com>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Roy Zang <roy.zang@nxp.com>, Arnd Bergmann <arnd@arndb.de>,
 Jingoo Han <jg1.han@samsung.com>, Stuart Yoder <stuart.yoder@nxp.com>,
 Yang-Leo Li <leoyang.li@nxp.com>, Minghuan
 Lian <Minghuan.Lian@nxp.com>, linux-arm-kernel@lists.infradead.org, Bjorn
 Helgaas <bhelgaas@google.com>, Mingkai Hu <mingkai.hu@nxp.com>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

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
---
 drivers/pci/host/pci-layerscape.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/pci/host/pci-layerscape.c b/drivers/pci/host/pci-layerscape.c
index cf783ad..873447a 100644
--- a/drivers/pci/host/pci-layerscape.c
+++ b/drivers/pci/host/pci-layerscape.c
@@ -34,6 +34,8 @@
 /* PEX Internal Configuration Registers */
 #define PCIE_STRFMR1		0x71c /* Symbol Timer & Filter Mask Register1 */
 #define PCIE_DBI_RO_WR_EN	0x8bc /* DBI Read-Only Write Enable Register */
+#define PCIE_ABSERR		0x8d0 /* Bridge Slave Error Response Register */
+#define PCIE_ABSERR_SETTING	0x9401 /* Forward error of non-posted request */
 
 /* PEX LUT registers */
 #define PCIE_LUT_DBG		0x7FC /* PEX LUT Debug Register */
@@ -99,6 +101,12 @@ static void ls_pcie_disable_outbound_atus(struct ls_pcie *pcie)
 		dw_pcie_disable_outbound_atu(&pcie->pp, i);
 }
 
+/* Forward error response of outbound non-posted requests */
+static void ls_pcie_fix_error_response(struct ls_pcie *pcie)
+{
+	iowrite32(PCIE_ABSERR_SETTING, pcie->dbi + PCIE_ABSERR);
+}
+
 static int ls1021_pcie_link_up(struct pcie_port *pp)
 {
 	u32 state;
@@ -166,6 +174,7 @@ static void ls_pcie_host_init(struct pcie_port *pp)
 	iowrite32(0, pcie->dbi + PCIE_DBI_RO_WR_EN);
 
 	ls_pcie_disable_outbound_atus(pcie);
+	ls_pcie_fix_error_response(pcie);
 }
 
 static int ls_pcie_msi_host_init(struct pcie_port *pp,
-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
