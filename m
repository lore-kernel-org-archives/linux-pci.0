Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga06-in.huawei.com ([45.249.212.32]:34837 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726640AbeILU1g (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 12 Sep 2018 16:27:36 -0400
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <bhelgaas@google.com>
CC: <lorenzo.pieralisi@arm.com>, <linux-pci@vger.kernel.org>,
        <linuxarm@huawei.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 1/1] pci: Pick up the acpi numa node value if it is specified at the device level.
Date: Wed, 12 Sep 2018 16:21:40 +0100
Message-ID: <20180912152140.3676-2-Jonathan.Cameron@huawei.com>
In-Reply-To: <20180912152140.3676-1-Jonathan.Cameron@huawei.com>
References: <20180912152140.3676-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The ACPI specification allows you to provide _PXM entries for devices based
on their location on a particular bus.  Let us use that if it is provided
rather than just assuming it makes sense to put the device into the proximity
domain of the root.

An example DSDT entry that will supply this is:

  Device (PCI2)
  {
    Name (_HID, "PNP0A08") // PCI Express Root Bridge
    Name (_CID, "PNP0A03") // Compatible PCI Root Bridge
    Name(_SEG, 2) // Segment of this Root complex
    Name(_BBN, 0xF8) // Base Bus Number
    Name(_CCA, 1)
    Method (_PXM, 0, NotSerialized) {
      Return(0x00)
    }

...
    Device (BRI0) {
      Name (_HID, "19E51610")
      Name (_ADR, 0)
      Name (_BBN, 0xF9)
      Device (CAR0) {
        Name (_HID, "97109912")
        Name (_ADR, 0)
        Method (_PXM, 0, NotSerialized) {
          Return(0x02)
        }
      }
    }
  }

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/pci/pci-acpi.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index 738e3546abb1..f2f5f0ddd60e 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -753,10 +753,15 @@ static void pci_acpi_setup(struct device *dev)
 {
 	struct pci_dev *pci_dev = to_pci_dev(dev);
 	struct acpi_device *adev = ACPI_COMPANION(dev);
+	int node;
 
 	if (!adev)
 		return;
 
+	node = acpi_get_node(adev->handle);
+	if (node != NUMA_NO_NODE)
+		set_dev_node(dev, node);
+	
 	pci_acpi_optimize_delay(pci_dev, adev->handle);
 
 	pci_acpi_add_pm_notifier(adev, pci_dev);
-- 
2.18.0
