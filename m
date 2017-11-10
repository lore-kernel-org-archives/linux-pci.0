Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Bao Xiaowei <xiaowei.bao@nxp.com>
To: <robh+dt@kernel.org>, <mark.rutland@arm.com>, <catalin.marinas@arm.com>,
 <will.deacon@arm.com>, <bhelgaas@google.com>, <shawnguo@kernel.org>,
 <madalin.bucur@nxp.com>, <sumit.garg@nxp.com>, <yangbo.lu@nxp.com>,
 <hongtao.jia@nxp.com>, <Yuantian.Tang@nxp.com>, <leoyang.li@nxp.com>,
 <kishon@ti.com>, <jingoohan1@gmail.com>, <pbrobinson@gmail.com>,
 <songxiaowei@hisilicon.com>, <devicetree@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
 <Zhiqiang.Hou@nxp.com>, <mingkai.hu@nxp.com>, <Minghuan.Lian@nxp.com>
Subject: [PATCHv3 3/3] ARMv8: pcie: make the DWC EP driver support for
 layerscape
Date: Fri, 10 Nov 2017 10:49:26 +0800
Message-ID: <20171110024926.39700-4-xiaowei.bao@nxp.com>
In-Reply-To: <20171110024926.39700-1-xiaowei.bao@nxp.com>
References: <20171110024926.39700-1-xiaowei.bao@nxp.com>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Bao Xiaowei <xiaowei.bao@nxp.com>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Layerscape pcie controllers support RC or EP mode, Add the EP mode
support in Kconfig, the driver will support both RC and EP mode, and
the driver is able to judge the pcie controllers work on RC or EP mode.

Signed-off-by: Bao Xiaowei <xiaowei.bao@nxp.com>
Acked-by: Minghuan Lian <minghuan.Lian@nxp.com>
---
 v2:
 no change
 v3:
 no change

 drivers/pci/dwc/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/dwc/Kconfig b/drivers/pci/dwc/Kconfig
index 22ec82fcdea2..b5f507795779 100644
--- a/drivers/pci/dwc/Kconfig
+++ b/drivers/pci/dwc/Kconfig
@@ -108,6 +108,7 @@ config PCI_LAYERSCAPE
 	depends on PCI_MSI_IRQ_DOMAIN
 	select MFD_SYSCON
 	select PCIE_DW_HOST
+	select PCIE_DW_EP
 	help
 	  Say Y here if you want PCIe controller support on Layerscape SoCs.
 
-- 
2.14.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
