Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Sinan Kaya <okaya@codeaurora.org>
To: linux-pci@vger.kernel.org,
	timur@codeaurora.org
Subject: [PATCH 05/30] agp: nvidia: deprecate pci_get_bus_and_slot()
Date: Wed, 22 Nov 2017 00:30:50 -0500
Message-Id: <1511328675-21981-6-git-send-email-okaya@codeaurora.org>
In-Reply-To: <1511328675-21981-1-git-send-email-okaya@codeaurora.org>
References: <1511328675-21981-1-git-send-email-okaya@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Sinan Kaya <okaya@codeaurora.org>, linux-arm-msm@vger.kernel.org,
 David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

pci_get_bus_and_slot() is restrictive such that it assumes domain=0 as
where a PCI device is present. This restricts the device drivers to be
reused for other domain numbers.

Use pci_get_domain_bus_and_slot() with a domain number of 0 where we can't
extract the domain number. Other places, use the actual domain number from
the device.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/char/agp/nvidia-agp.c | 12 +++++++++---
 drivers/char/agp/sworks-agp.c |  3 ++-
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/char/agp/nvidia-agp.c b/drivers/char/agp/nvidia-agp.c
index 828b344..623205b 100644
--- a/drivers/char/agp/nvidia-agp.c
+++ b/drivers/char/agp/nvidia-agp.c
@@ -340,11 +340,17 @@ static int agp_nvidia_probe(struct pci_dev *pdev,
 	u8 cap_ptr;
 
 	nvidia_private.dev_1 =
-		pci_get_bus_and_slot((unsigned int)pdev->bus->number, PCI_DEVFN(0, 1));
+		pci_get_domain_bus_and_slot(pci_domain_nr(pdev->bus),
+					    (unsigned int)pdev->bus->number,
+					    PCI_DEVFN(0, 1));
 	nvidia_private.dev_2 =
-		pci_get_bus_and_slot((unsigned int)pdev->bus->number, PCI_DEVFN(0, 2));
+		pci_get_domain_bus_and_slot(pci_domain_nr(pdev->bus),
+					    (unsigned int)pdev->bus->number,
+					    PCI_DEVFN(0, 2));
 	nvidia_private.dev_3 =
-		pci_get_bus_and_slot((unsigned int)pdev->bus->number, PCI_DEVFN(30, 0));
+		pci_get_domain_bus_and_slot(pci_domain_nr(pdev->bus),
+					    (unsigned int)pdev->bus->number,
+					    PCI_DEVFN(30, 0));
 
 	if (!nvidia_private.dev_1 || !nvidia_private.dev_2 || !nvidia_private.dev_3) {
 		printk(KERN_INFO PFX "Detected an NVIDIA nForce/nForce2 "
diff --git a/drivers/char/agp/sworks-agp.c b/drivers/char/agp/sworks-agp.c
index 03be4ac..4dbdd3b 100644
--- a/drivers/char/agp/sworks-agp.c
+++ b/drivers/char/agp/sworks-agp.c
@@ -474,7 +474,8 @@ static int agp_serverworks_probe(struct pci_dev *pdev,
 	}
 
 	/* Everything is on func 1 here so we are hardcoding function one */
-	bridge_dev = pci_get_bus_and_slot((unsigned int)pdev->bus->number,
+	bridge_dev = pci_get_domain_bus_and_slot(pci_domain_nr(pdev->bus),
+			(unsigned int)pdev->bus->number,
 			PCI_DEVFN(0, 1));
 	if (!bridge_dev) {
 		dev_info(&pdev->dev, "can't find secondary device\n");
-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
