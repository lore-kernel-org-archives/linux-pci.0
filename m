Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lpdvsmtp01.broadcom.com ([192.19.211.62]:51974 "EHLO
        relay.smtp.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933336AbdAFVgk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 6 Jan 2017 16:36:40 -0500
Received: from mail-irv-17.broadcom.com (mail-irv-17.broadcom.com [10.15.198.34])
        by relay.smtp.broadcom.com (Postfix) with ESMTP id 550EB2803EA
        for <linux-pci@vger.kernel.org>; Fri,  6 Jan 2017 13:35:59 -0800 (PST)
From: Andy Gospodarek <gospo@broadcom.com>
To: linux-pci@vger.kernel.org
Cc: Ray Jui <rjui@broadcom.com>, Andy Gospodarek <gospo@broadcom.com>
Subject: [PATCH next v2] PCI: iproc: Allow more than slot 0 on PAXC
Date: Fri,  6 Jan 2017 16:35:33 -0500
Message-Id: <1483738533-18300-1-git-send-email-gospo@broadcom.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The iproc host driver limits the number of slots that are available on
PAXC devices.  Enforcing this limit prevents VFs from being created
beyond the first port.  After this change it is possible to create VFs
associated with all four devices.

The first four devices below are the PFs and the next four are the newly
created VFs:

0008:01:00.0 Ethernet controller: Broadcom Limited Device 16cd
0008:01:00.1 Ethernet controller: Broadcom Limited Device 16cd
0008:01:00.2 Ethernet controller: Broadcom Limited Device 16cd
0008:01:00.3 Ethernet controller: Broadcom Limited Device 16cd
0008:01:00.4 Ethernet controller: Broadcom Limited BCM57304 NetXtreme-C Ethernet Virtual Function
0008:01:01.0 Ethernet controller: Broadcom Limited BCM57304 NetXtreme-C Ethernet Virtual Function
0008:01:01.4 Ethernet controller: Broadcom Limited BCM57304 NetXtreme-C Ethernet Virtual Function
0008:01:02.0 Ethernet controller: Broadcom Limited BCM57304 NetXtreme-C Ethernet Virtual Function

v2: Added check to only allow this on PAXCv1 hardware at the suggestion of Ray
Jui.

Signed-off-by: Andy Gospodarek <gospo@broadcom.com>
---
 drivers/pci/host/pcie-iproc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/host/pcie-iproc.c b/drivers/pci/host/pcie-iproc.c
index 3ebc025..ae101d6 100644
--- a/drivers/pci/host/pcie-iproc.c
+++ b/drivers/pci/host/pcie-iproc.c
@@ -478,11 +478,11 @@ static void __iomem *iproc_pcie_map_cfg_bus(struct pci_bus *bus,
 	}
 
 	/*
-	 * PAXC is connected to an internally emulated EP within the SoC.  It
-	 * allows only one device.
+	 * PAXC is connected to an internally emulated EP within the SoC.
+	 * Allow multiple slots only on PAXCv1 hardware.
 	 */
 	if (pcie->ep_is_internal)
-		if (slot > 0)
+		if (slot > 0 && pcie->type != IPROC_PCIE_PAXC)
 			return NULL;
 
 	/* EP device access */
-- 
2.1.0

