Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Sinan Kaya <okaya@codeaurora.org>
To: linux-pci@vger.kernel.org,
	timur@codeaurora.org
Subject: [PATCH V4 15/26] PCI: cpqhp: deprecate pci_get_bus_and_slot()
Date: Tue, 19 Dec 2017 00:37:51 -0500
Message-Id: <1513661883-28662-16-git-send-email-okaya@codeaurora.org>
In-Reply-To: <1513661883-28662-1-git-send-email-okaya@codeaurora.org>
References: <1513661883-28662-1-git-send-email-okaya@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Sinan Kaya <okaya@codeaurora.org>, linux-arm-msm@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, open list <linux-kernel@vger.kernel.org>,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

pci_get_bus_and_slot() is restrictive such that it assumes domain=0 as
where a PCI device is present. This restricts the device drivers to be
reused for other domain numbers.

Getting ready to remove pci_get_bus_and_slot() function in favor of
pci_get_domain_bus_and_slot().

Hard-coding the domain number as 0. The code doesn't seem to be ready
for multiple domains.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/pci/hotplug/cpqphp_pci.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/hotplug/cpqphp_pci.c b/drivers/pci/hotplug/cpqphp_pci.c
index e220d49..8897a77 100644
--- a/drivers/pci/hotplug/cpqphp_pci.c
+++ b/drivers/pci/hotplug/cpqphp_pci.c
@@ -89,7 +89,9 @@ int cpqhp_configure_device(struct controller *ctrl, struct pci_func *func)
 	pci_lock_rescan_remove();
 
 	if (func->pci_dev == NULL)
-		func->pci_dev = pci_get_bus_and_slot(func->bus, PCI_DEVFN(func->device, func->function));
+		func->pci_dev = pci_get_domain_bus_and_slot(0, func->bus,
+							PCI_DEVFN(func->device,
+							func->function));
 
 	/* No pci device, we need to create it then */
 	if (func->pci_dev == NULL) {
@@ -99,7 +101,9 @@ int cpqhp_configure_device(struct controller *ctrl, struct pci_func *func)
 		if (num)
 			pci_bus_add_devices(ctrl->pci_dev->bus);
 
-		func->pci_dev = pci_get_bus_and_slot(func->bus, PCI_DEVFN(func->device, func->function));
+		func->pci_dev = pci_get_domain_bus_and_slot(0, func->bus,
+							PCI_DEVFN(func->device,
+							func->function));
 		if (func->pci_dev == NULL) {
 			dbg("ERROR: pci_dev still null\n");
 			goto out;
@@ -129,7 +133,10 @@ int cpqhp_unconfigure_device(struct pci_func *func)
 
 	pci_lock_rescan_remove();
 	for (j = 0; j < 8 ; j++) {
-		struct pci_dev *temp = pci_get_bus_and_slot(func->bus, PCI_DEVFN(func->device, j));
+		struct pci_dev *temp = pci_get_domain_bus_and_slot(0,
+							func->bus,
+							PCI_DEVFN(func->device,
+							j));
 		if (temp) {
 			pci_dev_put(temp);
 			pci_stop_and_remove_bus_device(temp);
@@ -319,6 +326,7 @@ int cpqhp_save_config(struct controller *ctrl, int busnumber, int is_hot_plug)
 	int cloop = 0;
 	int stop_it;
 	int index;
+	u16 devfn;
 
 	/* Decide which slots are supported */
 
@@ -416,7 +424,9 @@ int cpqhp_save_config(struct controller *ctrl, int busnumber, int is_hot_plug)
 			new_slot->switch_save = 0x10;
 			/* In case of unsupported board */
 			new_slot->status = DevError;
-			new_slot->pci_dev = pci_get_bus_and_slot(new_slot->bus, (new_slot->device << 3) | new_slot->function);
+			devfn = (new_slot->device << 3) | new_slot->function;
+			new_slot->pci_dev = pci_get_domain_bus_and_slot(0,
+							new_slot->bus, devfn);
 
 			for (cloop = 0; cloop < 0x20; cloop++) {
 				rc = pci_bus_read_config_dword(ctrl->pci_bus, PCI_DEVFN(device, function), cloop << 2, (u32 *) &(new_slot->config_space[cloop]));
-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
