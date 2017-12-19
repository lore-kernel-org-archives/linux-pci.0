Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Sinan Kaya <okaya@codeaurora.org>
To: linux-pci@vger.kernel.org,
	timur@codeaurora.org
Subject: [PATCH V4 16/26] PCI: ibmphp: deprecate pci_get_bus_and_slot()
Date: Tue, 19 Dec 2017 00:37:52 -0500
Message-Id: <1513661883-28662-17-git-send-email-okaya@codeaurora.org>
In-Reply-To: <1513661883-28662-1-git-send-email-okaya@codeaurora.org>
References: <1513661883-28662-1-git-send-email-okaya@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: linux-arm-msm@vger.kernel.org, open list <linux-kernel@vger.kernel.org>,
 Sinan Kaya <okaya@codeaurora.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Arvind Yadav <arvind.yadav.cs@gmail.com>, linux-arm-kernel@lists.infradead.org
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

Hard-coding the domain parameter as 0 since the code doesn't seem to be
ready for multiple domains.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/pci/hotplug/ibmphp_core.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/hotplug/ibmphp_core.c b/drivers/pci/hotplug/ibmphp_core.c
index 73cf846..92dd882 100644
--- a/drivers/pci/hotplug/ibmphp_core.c
+++ b/drivers/pci/hotplug/ibmphp_core.c
@@ -707,7 +707,8 @@ static void ibm_unconfigure_device(struct pci_func *func)
 	pci_lock_rescan_remove();
 
 	for (j = 0; j < 0x08; j++) {
-		temp = pci_get_bus_and_slot(func->busno, (func->device << 3) | j);
+		temp = pci_get_domain_bus_and_slot(0, func->busno,
+						   (func->device << 3) | j);
 		if (temp) {
 			pci_stop_and_remove_bus_device(temp);
 			pci_dev_put(temp);
@@ -780,7 +781,7 @@ static int ibm_configure_device(struct pci_func *func)
 	if (!(bus_structure_fixup(func->busno)))
 		flag = 1;
 	if (func->dev == NULL)
-		func->dev = pci_get_bus_and_slot(func->busno,
+		func->dev = pci_get_domain_bus_and_slot(0, func->busno,
 				PCI_DEVFN(func->device, func->function));
 
 	if (func->dev == NULL) {
@@ -793,7 +794,7 @@ static int ibm_configure_device(struct pci_func *func)
 		if (num)
 			pci_bus_add_devices(bus);
 
-		func->dev = pci_get_bus_and_slot(func->busno,
+		func->dev = pci_get_domain_bus_and_slot(0, func->busno,
 				PCI_DEVFN(func->device, func->function));
 		if (func->dev == NULL) {
 			err("ERROR... : pci_dev still NULL\n");
-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
