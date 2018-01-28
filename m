Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from 7.mo68.mail-out.ovh.net ([46.105.63.230]:54481 "EHLO
        7.mo68.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751837AbeA1U6h (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 28 Jan 2018 15:58:37 -0500
Received: from player776.ha.ovh.net (b7.ovh.net [213.186.33.57])
        by mo68.mail-out.ovh.net (Postfix) with ESMTP id EDC22BC20D
        for <linux-pci@vger.kernel.org>; Sun, 28 Jan 2018 21:41:33 +0100 (CET)
From: Cyrille Pitchen <cyrille.pitchen@free-electrons.com>
To: bhelgaas@google.com, kishon@ti.com, lorenzo.pieralisi@arm.com,
        linux-pci@vger.kernel.org
Cc: adouglas@cadence.com, stelford@cadence.com, dgary@cadence.com,
        kgopi@cadence.com, eandrews@cadence.com,
        thomas.petazzoni@free-electrons.com, sureshp@cadence.com,
        nsekhar@ti.com, linux-kernel@vger.kernel.org, robh@kernel.org,
        devicetree@vger.kernel.org,
        Cyrille Pitchen <cyrille.pitchen@free-electrons.com>
Subject: [PATCH v5 03/11] PCI: generic: fix missing call of pci_free_resource_list()
Date: Sun, 28 Jan 2018 21:40:17 +0100
Message-Id: <de9098696bd2e9c1c78e5f3a6ffc20032f14d839.1517170521.git.cyrille.pitchen@free-electrons.com>
In-Reply-To: <cover.1517170521.git.cyrille.pitchen@free-electrons.com>
References: <cover.1517170521.git.cyrille.pitchen@free-electrons.com>
In-Reply-To: <cover.1517170521.git.cyrille.pitchen@free-electrons.com>
References: <cover.1517170521.git.cyrille.pitchen@free-electrons.com>
Sender: linux-pci-owner@vger.kernel.org
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
