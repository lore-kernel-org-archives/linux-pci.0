Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Cyrille Pitchen <cyrille.pitchen@free-electrons.com>
To: bhelgaas@google.com, kishon@ti.com, lorenzo.pieralisi@arm.com,
        linux-pci@vger.kernel.org
Cc: adouglas@cadence.com, stelford@cadence.com, dgary@cadence.com,
        kgopi@cadence.com, eandrews@cadence.com,
        thomas.petazzoni@free-electrons.com, sureshp@cadence.com,
        nsekhar@ti.com, linux-kernel@vger.kernel.org, robh@kernel.org,
        devicetree@vger.kernel.org,
        Cyrille Pitchen <cyrille.pitchen@free-electrons.com>
Subject: [PATCH v4 3/7] PCI: generic: fix missing call of pci_free_resource_list()
Date: Thu, 18 Jan 2018 23:52:48 +0100
Message-Id: <f8de1b2931f0f1f03f7e5230bb8438a2622a607c.1516314953.git.cyrille.pitchen@free-electrons.com>
In-Reply-To: <cover.1516314953.git.cyrille.pitchen@free-electrons.com>
References: <cover.1516314953.git.cyrille.pitchen@free-electrons.com>
In-Reply-To: <cover.1516314953.git.cyrille.pitchen@free-electrons.com>
References: <cover.1516314953.git.cyrille.pitchen@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Call pci_free_resource_list() from pci_host_common_probe() when probing
fails, as done inside gen_pci_init() when this later function fails.

Signed-off-by: Cyrille Pitchen <cyrille.pitchen@free-electrons.com>
---
 drivers/pci/host/pci-host-common.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/host/pci-host-common.c b/drivers/pci/host/pci-host-common.c
index a613ea310e76..9f27e90f578c 100644
--- a/drivers/pci/host/pci-host-common.c
+++ b/drivers/pci/host/pci-host-common.c
@@ -110,6 +110,7 @@ int pci_host_common_probe(struct platform_device *pdev,
 	ret = pci_scan_root_bus_bridge(bridge);
 	if (ret < 0) {
 		dev_err(dev, "Scanning root bridge failed");
+		pci_free_resource_list(&resources);
 		return ret;
 	}
 
-- 
2.11.0
