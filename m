Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: [PATCH v1 21/25] PCI: rcar: Simplify host bridge window iteration
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 06 Jun 2016 18:07:21 -0500
Message-ID: <20160606230721.20936.25605.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20160606225630.20936.77349.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20160606225630.20936.77349.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
 Jason Cooper <jason@lakedaemon.net>, Scott Branden <sbranden@broadcom.com>,
 Jon Mason <jonmason@broadcom.com>, Jingoo Han <jingoohan1@gmail.com>,
 Pratyush Anand <pratyush.anand@gmail.com>, linux-kernel@vger.kernel.org,
 rfi@lists.rocketboards.org, linux-renesas-soc@vger.kernel.org,
 Simon Horman <horms@verge.net.au>, Thierry Reding <thierry.reding@gmail.com>,
 Tanmay Inamdar <tinamdar@apm.com>, Ray Jui <rjui@broadcom.com>,
 linux-tegra@vger.kernel.org, Ley Foon Tan <lftan@altera.com>,
 Michal Simek <michal.simek@xilinx.com>,
 =?utf-8?b?U8O2cmVu?= Brinkmann <soren.brinkmann@xilinx.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

The switch is the only statement in the resource_list_for_each_entry()
loop, so remove unnecessary cases and "continue" statements in the switch.
Inline rcar_pcie_release_of_pci_ranges(), which is only called once.

No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pcie-rcar.c |   21 +++------------------
 1 file changed, 3 insertions(+), 18 deletions(-)

diff --git a/drivers/pci/host/pcie-rcar.c b/drivers/pci/host/pcie-rcar.c
index ce096db..6546ca7 100644
--- a/drivers/pci/host/pcie-rcar.c
+++ b/drivers/pci/host/pcie-rcar.c
@@ -938,11 +938,6 @@ static const struct of_device_id rcar_pcie_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, rcar_pcie_of_match);
 
-static void rcar_pcie_release_of_pci_ranges(struct rcar_pcie *pci)
-{
-	pci_free_resource_list(&pci->resources);
-}
-
 static int rcar_pcie_parse_request_of_pci_ranges(struct rcar_pcie *pci)
 {
 	int err;
@@ -962,28 +957,18 @@ static int rcar_pcie_parse_request_of_pci_ranges(struct rcar_pcie *pci)
 	resource_list_for_each_entry(win, &pci->resources) {
 		struct resource *res = win->res;
 
-		switch (resource_type(res)) {
-		case IORESOURCE_IO:
+		if (resource_type(res) == IORESOURCE_IO) {
 			err = pci_remap_iospace(res, iobase);
-			if (err) {
+			if (err)
 				dev_warn(dev, "error %d: failed to map resource %pR\n",
 					 err, res);
-				continue;
-			}
-			break;
-		case IORESOURCE_MEM:
-			break;
-
-		case IORESOURCE_BUS:
-		default:
-			continue;
 		}
 	}
 
 	return 0;
 
 out_release_res:
-	rcar_pcie_release_of_pci_ranges(pci);
+	pci_free_resource_list(&pci->resources);
 	return err;
 }
 


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
