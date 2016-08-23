Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Po Liu <po.liu@nxp.com>
To: <linux-pci@vger.kernel.org>
Subject: [PATCH v1] arm64:pci: fix the IOV device enabled crash issue in
 designware
Date: Tue, 23 Aug 2016 14:01:12 +0800
Message-ID: <1471932072-6980-1-git-send-email-po.liu@nxp.com>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Roy Zang <roy.zang@nxp.com>, Arnd Bergmann <arnd@arndb.de>,
 Po Liu <po.liu@nxp.com>, Stuart Yoder <stuart.yoder@nxp.com>,
 Yang-Leo Li <leoyang.li@nxp.com>, linux-arm-kernel@lists.infradead.org, Bjorn
 Helgaas <bhelgaas@google.com>, Mingkai Hu <mingkai.hu@nxp.com>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

When echo a number to /sys/bus/pci/devices/xxx/sriov_numvfs to enable the
VF devices. A crash log occurred. This found to be access the IOV devices
config space failure issue.

The read/write config space from host would judge the pcie device plugin
or not by:

if (bus->primary == pp->root_bus_nr && dev > 0)
    return 0;

Although all pcie devices for dev(coming from the device and function
number) is zero. But the dev is not zero for VF. So remove the
condition.

Signed-off-by: Po Liu <po.liu@nxp.com>
---
 drivers/pci/host/pcie-designware.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
index 12afce1..dd20eb2 100644
--- a/drivers/pci/host/pcie-designware.c
+++ b/drivers/pci/host/pcie-designware.c
@@ -670,13 +670,6 @@ static int dw_pcie_valid_config(struct pcie_port *pp,
 	if (bus->number == pp->root_bus_nr && dev > 0)
 		return 0;
 
-	/*
-	 * do not read more than one device on the bus directly attached
-	 * to RC's (Virtual Bridge's) DS side.
-	 */
-	if (bus->primary == pp->root_bus_nr && dev > 0)
-		return 0;
-
 	return 1;
 }
 
-- 
2.1.0.27.g96db324


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
