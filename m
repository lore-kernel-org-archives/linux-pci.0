Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([119.145.14.64]:15254 "EHLO
	szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751966Ab3HUC2D (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 20 Aug 2013 22:28:03 -0400
From: Yijing Wang <wangyijing@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: Jon Mason <jdmason@kudzu.us>, <linux-pci@vger.kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>, <jiang.liu@huawei.com>,
	Yijing Wang <wangyijing@huawei.com>
Subject: [PATCH v6 1/2] PCI: remove the unnecessary check in pcie_find_smpss()
Date: Wed, 21 Aug 2013 10:25:36 +0800
Message-ID: <1377051937-5712-2-git-send-email-wangyijing@huawei.com>
In-Reply-To: <1377051937-5712-1-git-send-email-wangyijing@huawei.com>
References: <1377051937-5712-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

In "pci=pcie_bus_safe" mode, if find a hotplug slot, we will set
all devices which in the path mps value to the minimum mps
support(128B). Unless the slot is directly connected to root port,
and there are not other devices on the fabric. In the latter case,
we will set root port and device mps to the minmum mpss support
for performace. Currently we use list_is_singular() to identify
whether slot is the only one connected to root port, it's not
necessary, because root port always connected to only one slot.

Following is test info:
-+-[0000:40]-+-00.0-[0000:41]--
	................
 |           +-05.0-[0000:45]--
 |           +-07.0-[0000:46]--+-00.0  Intel Corporation 82576 Gigabit Network Connection
 |           |                 \-00.1  Intel Corporation 82576 Gigabit Network Connection

root port (40:07.0 mps=256 mpss=256)
EndPoing deivce (46:00.0/1 mps=256 mpss=512)

linux-ha2:/sys/bus/pci/slots/7 # echo 0 > power
linux-ha2:/sys/bus/pci/slots/7 # echo 1 > power
linux-ha2:/sys/bus/pci/slots/7 # dmesg
...........................
pcieport 0000:40:07.0: PCI-E Max Payload Size set to  256/ 256 (was  256), Max Read Rq  128
pci 0000:46:00.0: PCI-E Max Payload Size set to  256/ 512 (was  128), Max Read Rq  512
pci 0000:46:00.1: PCI-E Max Payload Size set to  256/ 512 (was  128), Max Read Rq  512
pcieport 0000:40:07.0: PCI-E Max Payload Size set to  256/ 256 (was  256), Max Read Rq  128
pci 0000:46:00.0: PCI-E Max Payload Size set to  256/ 512 (was  256), Max Read Rq  512
pci 0000:46:00.1: PCI-E Max Payload Size set to  256/ 512 (was  256), Max Read Rq  512
...........................

result is good, root port and device mps were wrote to 256, original code wrote to 128

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
Cc: Jon Mason <jdmason@kudzu.us>
---
 drivers/pci/probe.c |   11 ++++-------
 1 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index cf57fe7..160ae38 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1501,14 +1501,11 @@ static int pcie_find_smpss(struct pci_dev *dev, void *data)
 	 * To work around this, the MPS for the entire fabric must be
 	 * set to the minimum size.  Any devices hotplugged into this
 	 * fabric will have the minimum MPS set.  If the PCI hotplug
-	 * slot is directly connected to the root port and there are not
-	 * other devices on the fabric (which seems to be the most
-	 * common case), then this is not an issue and MPS discovery
-	 * will occur as normal.
+	 * slot is directly connected to the root port, then this is
+	 * not an issue and MPS discovery will occur as normal.
 	 */
-	if (dev->is_hotplug_bridge && (!list_is_singular(&dev->bus->devices) ||
-	     (dev->bus->self &&
-	      pci_pcie_type(dev->bus->self) != PCI_EXP_TYPE_ROOT_PORT)))
+	if (dev->is_hotplug_bridge &&
+	      pci_pcie_type(dev) == PCI_EXP_TYPE_DOWNSTREAM)
 		*smpss = 0;
 
 	if (*smpss > dev->pcie_mpss)
-- 
1.7.1


