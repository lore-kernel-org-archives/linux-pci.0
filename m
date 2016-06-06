Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: [PATCH v1 15/25] PCI: generic: Free resource list close to where
 it's allocated
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 06 Jun 2016 18:06:36 -0500
Message-ID: <20160606230636.20936.29083.stgit@bhelgaas-glaptop2.roam.corp.google.com>
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

Previously we allocated the PCI resource list in
gen_pci_parse_request_of_pci_ranges(), but if we had an error, we freed it
on error in gen_pci_init().

Reorder gen_pci_init() so we can take care of error path cleanup in
gen_pci_parse_request_of_pci_ranges() instead.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pci-host-common.c |   32 +++++++++++++++-----------------
 1 file changed, 15 insertions(+), 17 deletions(-)

diff --git a/drivers/pci/host/pci-host-common.c b/drivers/pci/host/pci-host-common.c
index 8cba7ab..16a4e61 100644
--- a/drivers/pci/host/pci-host-common.c
+++ b/drivers/pci/host/pci-host-common.c
@@ -73,6 +73,7 @@ static int gen_pci_parse_request_of_pci_ranges(struct device *dev,
 	return 0;
 
 out_release_res:
+	pci_free_resource_list(resources);
 	return err;
 }
 
@@ -89,33 +90,30 @@ static struct pci_config_window *gen_pci_init(struct device *dev,
 	struct resource *bus_range = NULL;
 	struct pci_config_window *cfg;
 
-	/* Parse our PCI ranges and request their resources */
-	err = gen_pci_parse_request_of_pci_ranges(dev, resources, &bus_range);
-	if (err)
-		goto err_out;
-
 	err = of_address_to_resource(dev->of_node, 0, &cfgres);
 	if (err) {
 		dev_err(dev, "missing \"reg\" property\n");
-		goto err_out;
+		return err;
 	}
 
 	cfg = pci_ecam_create(dev, &cfgres, bus_range, ops);
-	if (IS_ERR(cfg)) {
-		err = PTR_ERR(cfg);
-		goto err_out;
-	}
+	if (IS_ERR(cfg))
+		return PTR_ERR(cfg);
 
 	err = devm_add_action(dev, gen_pci_unmap_cfg, cfg);
-	if (err) {
-		gen_pci_unmap_cfg(cfg);
-		goto err_out;
-	}
+	if (err)
+		goto err_cfg;
+
+	/* Parse our PCI ranges and request their resources */
+	err = gen_pci_parse_request_of_pci_ranges(dev, resources, &bus_range);
+	if (err)
+		goto err_cfg;
+
 	return cfg;
 
-err_out:
-	pci_free_resource_list(resources);
-	return ERR_PTR(err);
+err_cfg:
+	gen_pci_unmap_cfg(cfg);
+	return err;
 }
 
 int pci_host_common_probe(struct platform_device *pdev,


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
