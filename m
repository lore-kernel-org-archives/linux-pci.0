Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:51808 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932242AbcFFXHK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 6 Jun 2016 19:07:10 -0400
Subject: [PATCH v1 19/25] PCI: rcar Gen2: Request host bridge window
 resources
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Rob Herring <robh@kernel.org>,
	Jason Cooper <jason@lakedaemon.net>,
	Scott Branden <sbranden@broadcom.com>,
	Jon Mason <jonmason@broadcom.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Pratyush Anand <pratyush.anand@gmail.com>,
	linux-kernel@vger.kernel.org, rfi@lists.rocketboards.org,
	linux-renesas-soc@vger.kernel.org,
	Simon Horman <horms@verge.net.au>,
	Thierry Reding <thierry.reding@gmail.com>,
	Tanmay Inamdar <tinamdar@apm.com>, Ray Jui <rjui@broadcom.com>,
	linux-tegra@vger.kernel.org, Ley Foon Tan <lftan@altera.com>,
	Michal Simek <michal.simek@xilinx.com>,
	=?utf-8?b?U8O2cmVu?= Brinkmann <soren.brinkmann@xilinx.com>,
	linux-arm-kernel@lists.infradead.org
Date: Mon, 06 Jun 2016 18:07:06 -0500
Message-ID: <20160606230706.20936.13086.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20160606225630.20936.77349.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20160606225630.20936.77349.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Request host bridge window resources so they appear in ioport_resource and
iomem_resource and are reflected in /proc/ioports and /proc/iomem.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pci-rcar-gen2.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/host/pci-rcar-gen2.c b/drivers/pci/host/pci-rcar-gen2.c
index 9980a4b..617a6b2 100644
--- a/drivers/pci/host/pci-rcar-gen2.c
+++ b/drivers/pci/host/pci-rcar-gen2.c
@@ -194,6 +194,7 @@ static int rcar_pci_setup(int nr, struct pci_sys_data *sys)
 	struct rcar_pci_priv *priv = sys->private_data;
 	void __iomem *reg = priv->reg;
 	u32 val;
+	int ret;
 
 	pm_runtime_enable(priv->dev);
 	pm_runtime_get_sync(priv->dev);
@@ -275,6 +276,9 @@ static int rcar_pci_setup(int nr, struct pci_sys_data *sys)
 	/* Add PCI resources */
 	pci_add_resource(&sys->resources, &priv->io_res);
 	pci_add_resource(&sys->resources, &priv->mem_res);
+	ret = devm_request_pci_bus_resources(priv->dev, &sys->resources);
+	if (ret < 0)
+		return ret;
 
 	/* Setup bus number based on platform device id / of bus-range */
 	sys->busnr = priv->busnr;

