Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Jan Glauber <jglauber@cavium.com>
To: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 Alex Williamson <alex.williamson@redhat.com>
Subject: [PATCH v2 1/3] PCI: Allow PCI_DEV_FLAGS_NO_BUS_RESET to be used on
 bus device
Date: Thu, 17 Aug 2017 10:14:21 +0200
Message-Id: <1502957663-5527-2-git-send-email-jglauber@cavium.com>
In-Reply-To: <1502957663-5527-1-git-send-email-jglauber@cavium.com>
References: <1502957663-5527-1-git-send-email-jglauber@cavium.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: kvm@vger.kernel.org, david.daney@cavium.com, Jon Masters <jcm@redhat.com>,
 linux-kernel@vger.kernel.org, Robert Richter <robert.richter@cavium.com>,
 Jan Glauber <jglauber@cavium.com>, linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
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


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
