Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Sinan Kaya <okaya@codeaurora.org>
To: linux-pci@vger.kernel.org
Subject: [PATCH V5 3/3] PCI: Mask and unmask hotplug interrupts during reset
Date: Mon,  2 Jul 2018 18:52:47 -0400
Message-Id: <1530571967-19099-4-git-send-email-okaya@codeaurora.org>
In-Reply-To: <1530571967-19099-1-git-send-email-okaya@codeaurora.org>
References: <1530571967-19099-1-git-send-email-okaya@codeaurora.org>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Keith Busch <keith.busch@intel.com>, Oza Pawandeep <poza@codeaurora.org>,
 linux-arm-msm@vger.kernel.org, open list <linux-kernel@vger.kernel.org>,
 Sinan Kaya <okaya@codeaurora.org>, Bjorn Helgaas <bhelgaas@google.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

If a bridge supports hotplug and observes a PCIe fatal error, the following
events happen:

1. AER driver removes the devices from PCI tree on fatal error
2. AER driver brings down the link by issuing a secondary bus reset waits
for the link to come up.
3. Hotplug driver observes a link down interrupt
4. Hotplug driver tries to remove the devices waiting for the rescan lock
but devices are already removed by the AER driver and AER driver is waiting
for the link to come back up.
5. AER driver tries to re-enumerate devices after polling for the link
state to go up.
6. Hotplug driver obtains the lock and tries to remove the devices again.

If a bridge is a hotplug capable bridge, mask hotplug interrupts before the
reset and unmask afterwards.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/pci/pcie/err.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
index ae72f88..5a2d410 100644
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -285,10 +285,12 @@ static pci_ers_result_t broadcast_error_message(struct pci_dev *dev,
  */
 void pcie_do_fatal_recovery(struct pci_dev *dev, u32 service)
 {
+	struct pcie_port_service_driver *hpsvc;
 	struct pci_dev *udev;
 	struct pci_bus *parent;
 	struct pci_dev *pdev, *temp;
 	pci_ers_result_t result;
+	struct device *hpdev;
 
 	if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE)
 		udev = dev;
@@ -308,8 +310,17 @@ void pcie_do_fatal_recovery(struct pci_dev *dev, u32 service)
 		pci_dev_put(pdev);
 	}
 
+	hpsvc = pcie_port_find_service(udev, PCIE_PORT_SERVICE_HP);
+	hpdev = pcie_port_find_device(udev, PCIE_PORT_SERVICE_HP);
+
+	if (hpdev && hpsvc)
+		hpsvc->mask_irq(to_pcie_device(hpdev));
+
 	result = reset_link(udev, service);
 
+	if (hpdev && hpsvc)
+		hpsvc->unmask_irq(to_pcie_device(hpdev));
+
 	if ((service == PCIE_PORT_SERVICE_AER) &&
 	    (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE)) {
 		/*
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
