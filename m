Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Sinan Kaya <okaya@codeaurora.org>
To: linux-pci@vger.kernel.org,
	timur@codeaurora.org
Subject: [PATCH V4 10/26] Drivers: ide: deprecate pci_get_bus_and_slot()
Date: Tue, 19 Dec 2017 00:37:46 -0500
Message-Id: <1513661883-28662-11-git-send-email-okaya@codeaurora.org>
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
 Sinan Kaya <okaya@codeaurora.org>,
 "open list:IDE SUBSYSTEM" <linux-ide@vger.kernel.org>,
 "David S. Miller" <davem@davemloft.net>, linux-arm-kernel@lists.infradead.org
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

Replace pci_get_bus_and_slot() with pci_get_domain_bus_and_slot()
and extract the domain number from struct pci_dev.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/ide/sl82c105.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/ide/sl82c105.c b/drivers/ide/sl82c105.c
index 8755df3..3300dac 100644
--- a/drivers/ide/sl82c105.c
+++ b/drivers/ide/sl82c105.c
@@ -239,8 +239,9 @@ static u8 sl82c105_bridge_revision(struct pci_dev *dev)
 	/*
 	 * The bridge should be part of the same device, but function 0.
 	 */
-	bridge = pci_get_bus_and_slot(dev->bus->number,
-			       PCI_DEVFN(PCI_SLOT(dev->devfn), 0));
+	bridge = pci_get_domain_bus_and_slot(pci_domain_nr(dev->bus),
+					dev->bus->number,
+					PCI_DEVFN(PCI_SLOT(dev->devfn), 0));
 	if (!bridge)
 		return -1;
 
-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
