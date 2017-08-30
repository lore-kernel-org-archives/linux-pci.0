Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:37842 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751683AbdH3OZK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 30 Aug 2017 10:25:10 -0400
From: Jan Glauber <jglauber@cavium.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
        Alex Williamson <alex.williamson@redhat.com>,
        linux-kernel@vger.kernel.org, david.daney@cavium.com,
        Jon Masters <jcm@redhat.com>,
        Robert Richter <robert.richter@cavium.com>,
        linux-arm-kernel@lists.infradead.org, kvm@vger.kernel.org,
        Jan Glauber <jglauber@cavium.com>
Subject: [PATCH v3 1/3] PCI: Allow PCI_DEV_FLAGS_NO_BUS_RESET to be used on bus device
Date: Wed, 30 Aug 2017 16:24:52 +0200
Message-Id: <20170830142454.10971-2-jglauber@cavium.com>
In-Reply-To: <20170830142454.10971-1-jglauber@cavium.com>
References: <20170830142454.10971-1-jglauber@cavium.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: David Daney <david.daney@cavium.com>

When checking to see if a PCI bus can safely be reset, we check to see
if any of the children have their PCI_DEV_FLAGS_NO_BUS_RESET flag set.
As these devices are known not to behave well after a bus reset.

Some PCIe root port bridges also do not behave well after a bus reset,
sometimes causing the devices behind the bridge to become unusable.

Add a check for the PCI_DEV_FLAGS_NO_BUS_RESET flag being set in the
bridge device to allow these bridges to be flagged, and prevent their
buses from being reset.

A follow on patch will add a quirk for this type of bridge.

Signed-off-by: David Daney <david.daney@cavium.com>
[jglauber@cavium.com: fixed typo]
Signed-off-by: Jan Glauber <jglauber@cavium.com>
---
 drivers/pci/pci.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index af0cc34..d9abbc9 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4290,6 +4290,10 @@ static bool pci_bus_resetable(struct pci_bus *bus)
 {
 	struct pci_dev *dev;
 
+
+	if (bus->self && (bus->self->dev_flags & PCI_DEV_FLAGS_NO_BUS_RESET))
+		return false;
+
 	list_for_each_entry(dev, &bus->devices, bus_list) {
 		if (dev->dev_flags & PCI_DEV_FLAGS_NO_BUS_RESET ||
 		    (dev->subordinate && !pci_bus_resetable(dev->subordinate)))
-- 
2.9.0.rc0.21.g7777322
