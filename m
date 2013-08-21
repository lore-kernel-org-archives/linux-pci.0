Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oa0-f52.google.com ([209.85.219.52]:48506 "EHLO
	mail-oa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752413Ab3HUXjr (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 21 Aug 2013 19:39:47 -0400
Received: by mail-oa0-f52.google.com with SMTP id f4so1185017oah.25
        for <linux-pci@vger.kernel.org>; Wed, 21 Aug 2013 16:39:46 -0700 (PDT)
Subject: [PATCH v7 5/5] PCI: Don't restrict MPS for slots below Root Ports
To: Yijing Wang <wangyijing@huawei.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, Jon Mason <jdmason@kudzu.us>,
	jiang.liu@huawei.com, Hanjun Guo <guohanjun@huawei.com>
Date: Wed, 21 Aug 2013 17:39:44 -0600
Message-ID: <20130821233944.2300.19147.stgit@bhelgaas-glaptop>
In-Reply-To: <20130821233722.2300.81773.stgit@bhelgaas-glaptop>
References: <20130821233722.2300.81773.stgit@bhelgaas-glaptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Yijing Wang <wangyijing@huawei.com>

When booting with "pci=pcie_bus_safe", we previously limited the
fabric MPS to 128 when we found:

  (1) A hotplug-capable Downstream Port ("dev->is_hotplug_bridge &&
      pci_pcie_type(dev) != PCI_EXP_TYPE_ROOT_PORT"), or

  (2) A hotplug-capable Root Port with a slot that was either empty or
      contained a multi-function device ("dev->is_hotplug_bridge &&
      !list_is_singular(&dev->bus->devices)")

Part (1) is valid, but part (2) is not.

After a hot-add in the slot below a Root Port, we can reconfigure all
MPS values in the fabric below the Root Port because the new device is
the only thing below the Root Port and there are no active drivers.
Therefore, there's no reason to limit the MPS for Root Ports, no
matter what's in the slot.

Test info:

    -+-[0000:40]-+-07.0-[0000:46]--+-00.0  Intel 82576 NIC
                                   \-00.1  Intel 82576 NIC

    0000:40:07.0 Root Port bridge to [bus 46] (MPS supported=256)
    0000:46:00.0 Endpoint                     (MPS supported=512)
    0000:46:00.1 Endpoint                     (MPS supported=512)

    # echo 0 > /sys/bus/pci/slots/7/power
    # echo 1 > /sys/bus/pci/slots/7/power
    # dmesg
    ...
    pcieport 0000:40:07.0: PCI-E Max Payload Size set to 256/ 256 (was 256)
    pci 0000:46:00.0:      PCI-E Max Payload Size set to 256/ 512 (was 128)
    pci 0000:46:00.1:      PCI-E Max Payload Size set to 256/ 512 (was 128)

Before this change, we set MPS to 128 for the Root Port and both NICs
because the slot contained a multi-function device and

    dev->is_hotplug_bridge && !list_is_singular(&dev->bus->devices)

was true.  After this change, we set it to 256.

[bhelgaas: changelog, comments, split out upstream bridge check]
Signed-off-by: Yijing Wang <wangyijing@huawei.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Cc: Jon Mason <jdmason@kudzu.us>
---
 drivers/pci/probe.c |   32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 0591b08..94b1d22 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1491,23 +1491,23 @@ static int pcie_find_smpss(struct pci_dev *dev, void *data)
 	if (!pci_is_pcie(dev))
 		return 0;
 
-	/* For PCIE hotplug enabled slots not connected directly to a
-	 * PCI-E root port, there can be problems when hotplugging
-	 * devices.  This is due to the possibility of hotplugging a
-	 * device into the fabric with a smaller MPS that the devices
-	 * currently running have configured.  Modifying the MPS on the
-	 * running devices could cause a fatal bus error due to an
-	 * incoming frame being larger than the newly configured MPS.
-	 * To work around this, the MPS for the entire fabric must be
-	 * set to the minimum size.  Any devices hotplugged into this
-	 * fabric will have the minimum MPS set.  If the PCI hotplug
-	 * slot is directly connected to the root port and there are not
-	 * other devices on the fabric (which seems to be the most
-	 * common case), then this is not an issue and MPS discovery
-	 * will occur as normal.
+	/*
+	 * We don't have a way to change MPS settings on devices that have
+	 * drivers attached.  A hot-added device might support only the minimum
+	 * MPS setting (MPS=128).  Therefore, if the fabric contains a bridge
+	 * where devices may be hot-added, we limit the fabric MPS to 128 so
+	 * hot-added devices will work correctly.
+	 *
+	 * However, if we hot-add a device to a slot directly below a Root
+	 * Port, it's impossible for there to be other existing devices below
+	 * the port.  We don't limit the MPS in this case because we can
+	 * reconfigure MPS on both the Root Port and the hot-added device,
+	 * and there are no other devices involved.
+	 *
+	 * Note that this PCIE_BUS_SAFE path assumes no peer-to-peer DMA.
 	 */
-	if (dev->is_hotplug_bridge && (!list_is_singular(&dev->bus->devices) ||
-	    pci_pcie_type(dev) != PCI_EXP_TYPE_ROOT_PORT))
+	if (dev->is_hotplug_bridge &&
+	    pci_pcie_type(dev) != PCI_EXP_TYPE_ROOT_PORT)
 		*smpss = 0;
 
 	if (*smpss > dev->pcie_mpss)

