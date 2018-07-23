Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:47302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728370AbeGWWCr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 23 Jul 2018 18:02:47 -0400
Subject: [PATCH] vxge: Remove unnecessary include of <linux/pci_hotplug.h>
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jon Mason <jdmason@kudzu.us>
Cc: "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 23 Jul 2018 15:59:46 -0500
Message-ID: <153237958637.172194.6734539971240967379.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Bjorn Helgaas <bhelgaas@google.com>

The vxge driver doesn't need anything provided by pci_hotplug.h, so remove
the unnecessary include of it.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/net/ethernet/neterion/vxge/vxge-config.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/neterion/vxge/vxge-config.c b/drivers/net/ethernet/neterion/vxge/vxge-config.c
index 358ed6118881..a2c0a93ca8b6 100644
--- a/drivers/net/ethernet/neterion/vxge/vxge-config.c
+++ b/drivers/net/ethernet/neterion/vxge/vxge-config.c
@@ -14,7 +14,6 @@
 #include <linux/vmalloc.h>
 #include <linux/etherdevice.h>
 #include <linux/pci.h>
-#include <linux/pci_hotplug.h>
 #include <linux/slab.h>
 
 #include "vxge-traffic.h"
