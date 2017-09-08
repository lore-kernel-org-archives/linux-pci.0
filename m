Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Jan Glauber <jglauber@cavium.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v4 3/3] PCI: Avoid slot reset if bus reset is not possible
Date: Fri,  8 Sep 2017 10:10:33 +0200
Message-Id: <20170908081033.3025-4-jglauber@cavium.com>
In-Reply-To: <20170908081033.3025-1-jglauber@cavium.com>
References: <20170908081033.3025-1-jglauber@cavium.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: kvm@vger.kernel.org, david.daney@cavium.com, linux-pci@vger.kernel.org,
 Jan Glauber <jglauber@cavium.com>, Robert Richter <robert.richter@cavium.com>,
 linux-kernel@vger.kernel.org, Alex Williamson <alex.williamson@redhat.com>,
 Jon Masters <jcm@redhat.com>, linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

When checking to see if a PCI slot can safely be reset, we check to
see if any of the children have their PCI_DEV_FLAGS_NO_BUS_RESET flag
set.

Some PCIe root port bridges do not behave well after a slot reset,
and may cause the device in the slot to become unusable.

Add a check for the PCI_DEV_FLAGS_NO_BUS_RESET flag being set in the
bridge device to prevent the slot from being reset.

Signed-off-by: Jan Glauber <jglauber@cavium.com>
---
 drivers/pci/pci.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index b2a46ca7f133..45a086fc3592 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4393,6 +4393,10 @@ static bool pci_slot_resetable(struct pci_slot *slot)
 {
 	struct pci_dev *dev;
 
+	if (slot->bus->self &&
+	    (slot->bus->self->dev_flags & PCI_DEV_FLAGS_NO_BUS_RESET))
+		return false;
+
 	list_for_each_entry(dev, &slot->bus->devices, bus_list) {
 		if (!dev->slot || dev->slot != slot)
 			continue;
-- 
2.9.0.rc0.21.g7777322


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
