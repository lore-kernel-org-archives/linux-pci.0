Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:44358 "EHLO
	szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759547Ab3HNJDR (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 14 Aug 2013 05:03:17 -0400
From: Yijing Wang <wangyijing@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: Jon Mason <jdmason@kudzu.us>, <linux-pci@vger.kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>, <jiang.liu@huawei.com>,
	Yijing Wang <wangyijing@huawei.com>,
	<stable@vger.kernel.org.#.3.4+>
Subject: [PATCH v4 1/2] PCI: fix the only slot identification in pcie_find_smpss()
Date: Wed, 14 Aug 2013 17:01:51 +0800
Message-ID: <1376470912-40264-2-git-send-email-wangyijing@huawei.com>
In-Reply-To: <1376470912-40264-1-git-send-email-wangyijing@huawei.com>
References: <1376470912-40264-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

We use list_is_singular() to identify the slot whether is
only slot directly connected to the root port in
pcie_find_smpss(). It's not correct, if we have only slot
connected to root port, and this slot has two function devices.
list_is_singular() return false. This patch introduces
pci_only_one_slot() to fix this issue. In addition, we should
pass subordinate bus devices list to list_is_singular(), not
its parent bus devices list.

-+-[0000:40]-+-00.0-[0000:41]--
    ......................
 |           +-07.0-[0000:46]--+-00.0  Intel Corporation 82576 Gigabit Network Connection
 |           |                 \-00.1  Intel Corporation 82576 Gigabit Network Connection

MPS configure after boot up, with boot command "pci=pcie_bus_safe"

linux-ha2:~ # lspci -vvv -s 40:07.0
40:07.0 PCI bridge: Intel Corporation 5520/5500/X58 I/O Hub PCI Express Root Port 7 (rev 22) (prog-if 00 [Normal decode])
	...............
	Capabilities: [90] Express (v2) Root Port (Slot+), MSI 00
		DevCap:	MaxPayload 256 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
			ExtTag+ RBE+ FLReset-
		DevCtl:	Report errors: Correctable+ Non-Fatal+ Fatal+ Unsupported+
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 256 bytes, MaxReadReq 128 bytes

linux-ha2:~ # lspci -vvv -s 46:00.0
46:00.0 Ethernet controller: Intel Corporation 82576 Gigabit Network Connection (rev 01)
	...............
	Capabilities: [a0] Express (v2) Endpoint, MSI 00
		DevCap:	MaxPayload 512 bytes, PhantFunc 0, Latency L0s <512ns, L1 <64us
			ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset+
		DevCtl:	Report errors: Correctable+ Non-Fatal+ Fatal+ Unsupported+
			RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+ FLReset-
			MaxPayload 256 bytes, MaxReadReq 512 bytes

linux-ha2:/sys/bus/pci/slots/7 # echo 0 > power     ------>power off slot
linux-ha2:/sys/bus/pci/slots/7 # echo 1 > power     ------>power on slot
linux-ha2:/sys/bus/pci/slots/7 # dmesg
................
pcieport 0000:40:07.0: PCI-E Max Payload Size set to  128/ 256 (was  256), Max Read Rq  128
pci 0000:46:00.0: PCI-E Max Payload Size set to  128/ 512 (was  128), Max Read Rq  512
pci 0000:46:00.1: PCI-E Max Payload Size set to  128/ 512 (was  128), Max Read Rq  512
pcieport 0000:40:07.0: PCI-E Max Payload Size set to  128/ 256 (was  128), Max Read Rq  128
pci 0000:46:00.0: PCI-E Max Payload Size set to  128/ 512 (was  128), Max Read Rq  512
pci 0000:46:00.1: PCI-E Max Payload Size set to  128/ 512 (was  128), Max Read Rq  512
.....

Because 46:00.0 and 46:00.1 function devices are directly connected to root port 40:07.0.
After slot hot plug, root port mps is 256, slot fun devices(46:00.0/1) mps is 128.
We should both change root port and slot mps to 256, but now kernel change mps to 128.


After applied this patch, dmesg after hot plug:
..............
pcieport 0000:40:07.0: PCI-E Max Payload Size set to  256/ 256 (was  256), Max Read Rq  128
pci 0000:46:00.0: PCI-E Max Payload Size set to  256/ 512 (was  128), Max Read Rq  512
pci 0000:46:00.1: PCI-E Max Payload Size set to  256/ 512 (was  128), Max Read Rq  512
pcieport 0000:40:07.0: PCI-E Max Payload Size set to  256/ 256 (was  256), Max Read Rq  128
pci 0000:46:00.0: PCI-E Max Payload Size set to  256/ 512 (was  256), Max Read Rq  512
pci 0000:46:00.1: PCI-E Max Payload Size set to  256/ 512 (was  256), Max Read Rq  512

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
Cc: Jon Mason <jdmason@kudzu.us>
Cc: stable@vger.kernel.org # 3.4+
---
 drivers/pci/probe.c |   20 +++++++++++++++++++-
 1 files changed, 19 insertions(+), 1 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index cf57fe7..0699ec0 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1484,6 +1484,24 @@ int pci_scan_slot(struct pci_bus *bus, int devfn)
 	return nr;
 }
 
+static bool pci_only_one_slot(struct pci_bus *pbus)
+{
+	u8 device;
+	struct pci_dev *pdev;
+
+	if (!pbus || list_empty(&pbus->devices))
+		return false;
+
+	pdev = list_entry(pbus->devices.next,
+			struct pci_dev, bus_list);
+	device = PCI_SLOT(pdev->devfn);
+	list_for_each_entry(pdev, &pbus->devices, bus_list)
+		if (PCI_SLOT(pdev->devfn) != device)
+			return false;
+
+	return true;
+}
+
 static int pcie_find_smpss(struct pci_dev *dev, void *data)
 {
 	u8 *smpss = data;
@@ -1506,7 +1524,7 @@ static int pcie_find_smpss(struct pci_dev *dev, void *data)
 	 * common case), then this is not an issue and MPS discovery
 	 * will occur as normal.
 	 */
-	if (dev->is_hotplug_bridge && (!list_is_singular(&dev->bus->devices) ||
+	if (dev->is_hotplug_bridge && (!pci_only_one_slot(dev->subordinate) ||
 	     (dev->bus->self &&
 	      pci_pcie_type(dev->bus->self) != PCI_EXP_TYPE_ROOT_PORT)))
 		*smpss = 0;
-- 
1.7.1


