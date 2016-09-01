Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
To: <bhelgaas@google.com>, <soren.brinkmann@xilinx.com>,
 <christophe.jaillet@wanadoo.fr>, <grygorii.strashko@ti.com>,
 <yinghai@kernel.org>, <lorenzo.pieralisi@arm.com>, <fengguang.wu@intel.com>,
 <michal.simek@xilinx.com>, <arnd@arndb.de>
Subject: [PATCH 5/6] PCI: Xilinx: Read more than one function per device.
Date: Thu, 1 Sep 2016 15:44:45 +0530
Message-ID: <1472724886-28301-5-git-send-email-bharatku@xilinx.com>
In-Reply-To: <1472724886-28301-1-git-send-email-bharatku@xilinx.com>
References: <1472724886-28301-1-git-send-email-bharatku@xilinx.com>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Bharat Kumar Gogada <bharatku@xilinx.com>, linux-pci@vger.kernel.org,
 rgummal@xilinx.com, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

AXI PCIe supports multifunciton device.
Removing unneccessary condition.

Signed-off-by: Bharat Kumar Gogada <bharatku@xilinx.com>
---
 drivers/pci/host/pcie-xilinx.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/pci/host/pcie-xilinx.c b/drivers/pci/host/pcie-xilinx.c
index a276fa6..58b7a13 100644
--- a/drivers/pci/host/pcie-xilinx.c
+++ b/drivers/pci/host/pcie-xilinx.c
@@ -170,13 +170,6 @@ static bool xilinx_pcie_valid_device(struct pci_bus *bus, unsigned int devfn)
 	if (bus->number == port->root_busno && devfn > 0)
 		return false;
 
-	/*
-	 * Do not read more than one device on the bus directly attached
-	 * to RC.
-	 */
-	if (bus->primary == port->root_busno && devfn > 0)
-		return false;
-
 	return true;
 }
 
-- 
2.1.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
