Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Kishon Vijay Abraham I <kishon@ti.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Joao Pinto <Joao.Pinto@synopsys.com>,
 <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-omap@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: [RESEND PATCH v3 1/7] PCI: dwc: designware: Add new *ops* for cpu
 addr fixup
Date: Thu, 9 Mar 2017 12:08:59 +0530
Message-ID: <1489041545-15730-2-git-send-email-kishon@ti.com>
In-Reply-To: <1489041545-15730-1-git-send-email-kishon@ti.com>
References: <1489041545-15730-1-git-send-email-kishon@ti.com>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: nsekhar@ti.com, kishon@ti.com
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Some platforms (like dra7xx) require only the least 28 bits of the
corresponding 32 bit CPU address to be programmed in the address
translation unit. This modified address is stored in io_base/mem_base/
cfg0_base/cfg1_base in dra7xx_pcie_host_init. While this is okay for
host mode where the address range is fixed, device mode requires
different addresses to be programmed based on the host buffer address.
Add a new ops to get the least 28 bits of the corresponding 32 bit
CPU address and invoke it before programming the address translation
unit.

Acked-by: Joao Pinto <jpinto@synopsys.com>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/dwc/pcie-designware.c |    3 +++
 drivers/pci/dwc/pcie-designware.h |    1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/pci/dwc/pcie-designware.c b/drivers/pci/dwc/pcie-designware.c
index 7e1fb7d..14ee7a3 100644
--- a/drivers/pci/dwc/pcie-designware.c
+++ b/drivers/pci/dwc/pcie-designware.c
@@ -97,6 +97,9 @@ void dw_pcie_prog_outbound_atu(struct dw_pcie *pci, int index, int type,
 {
 	u32 retries, val;
 
+	if (pp->ops->cpu_addr_fixup)
+		cpu_addr = pp->ops->cpu_addr_fixup(cpu_addr);
+
 	if (pci->iatu_unroll_enabled) {
 		dw_pcie_writel_unroll(pci, index, PCIE_ATU_UNR_LOWER_BASE,
 				      lower_32_bits(cpu_addr));
diff --git a/drivers/pci/dwc/pcie-designware.h b/drivers/pci/dwc/pcie-designware.h
index cd3b871..8f3dcb2 100644
--- a/drivers/pci/dwc/pcie-designware.h
+++ b/drivers/pci/dwc/pcie-designware.h
@@ -143,6 +143,7 @@ struct pcie_port {
 };
 
 struct dw_pcie_ops {
+	u64	(*cpu_addr_fixup)(u64 cpu_addr);
 	u32	(*readl_dbi)(struct dw_pcie *pcie, u32 reg);
 	void	(*writel_dbi)(struct dw_pcie *pcie, u32 reg, u32 val);
 	int	(*link_up)(struct dw_pcie *pcie);
-- 
1.7.9.5


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
