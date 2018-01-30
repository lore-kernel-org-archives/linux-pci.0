Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from 5.mo179.mail-out.ovh.net ([46.105.43.140]:43796 "EHLO
        5.mo179.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753247AbeA3VFJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 30 Jan 2018 16:05:09 -0500
Received: from player168.ha.ovh.net (b7.ovh.net [213.186.33.57])
        by mo179.mail-out.ovh.net (Postfix) with ESMTP id 9A1D79A673
        for <linux-pci@vger.kernel.org>; Tue, 30 Jan 2018 21:58:08 +0100 (CET)
From: Cyrille Pitchen <cyrille.pitchen@free-electrons.com>
To: bhelgaas@google.com, kishon@ti.com, lorenzo.pieralisi@arm.com,
        linux-pci@vger.kernel.org
Cc: adouglas@cadence.com, stelford@cadence.com, dgary@cadence.com,
        kgopi@cadence.com, eandrews@cadence.com,
        thomas.petazzoni@free-electrons.com, sureshp@cadence.com,
        nsekhar@ti.com, linux-kernel@vger.kernel.org, robh@kernel.org,
        devicetree@vger.kernel.org,
        Cyrille Pitchen <cyrille.pitchen@free-electrons.com>
Subject: [PATCH v6 03/11] PCI: generic: fix missing call of pci_free_resource_list()
Date: Tue, 30 Jan 2018 21:56:51 +0100
Message-Id: <19fc2c448cf8f19c47225450a375af657bd2c61a.1517343502.git.cyrille.pitchen@free-electrons.com>
In-Reply-To: <cover.1517343502.git.cyrille.pitchen@free-electrons.com>
References: <cover.1517343502.git.cyrille.pitchen@free-electrons.com>
In-Reply-To: <cover.1517343502.git.cyrille.pitchen@free-electrons.com>
References: <cover.1517343502.git.cyrille.pitchen@free-electrons.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Call pci_free_resource_list() from pci_host_common_probe() when probing
fails, as done inside gen_pci_init() when this later function fails.

Signed-off-by: Cyrille Pitchen <cyrille.pitchen@free-electrons.com>
---
 drivers/pci/host/pci-host-common.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/host/pci-host-common.c b/drivers/pci/host/pci-host-common.c
index efd904d93562..10e3f5b39499 100644
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
