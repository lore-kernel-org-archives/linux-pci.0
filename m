Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-dm3nam03on0075.outbound.protection.outlook.com ([104.47.41.75]:10592
	"EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752308AbcHLDO7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 11 Aug 2016 23:14:59 -0400
From: Peter Chen <peter.chen@nxp.com>
To: <minghuan.Lian@freescale.com>, <mingkai.hu@freescale.com>,
	<tie-fei.zang@freescale.com>
CC: <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
	<linuxppc-dev@lists.ozlabs.org>, Peter Chen <peter.chen@nxp.com>
Subject: [PATCH 1/1] pci: host: pci-layerscape: add missing of_node_put after calling of_parse_phandle
Date: Fri, 12 Aug 2016 09:34:41 +0800
Message-ID: <1470965681-30496-1-git-send-email-peter.chen@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

of_node_put needs to be called when the device node which is got
from of_parse_phandle has finished using.

Cc: Minghuan Lian <minghuan.Lian@freescale.com>
Cc: Mingkai Hu <mingkai.hu@freescale.com>
Cc: Roy Zang <tie-fei.zang@freescale.com>
Signed-off-by: Peter Chen <peter.chen@nxp.com>
---
 drivers/pci/host/pci-layerscape.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/host/pci-layerscape.c b/drivers/pci/host/pci-layerscape.c
index 114ba81..573b996 100644
--- a/drivers/pci/host/pci-layerscape.c
+++ b/drivers/pci/host/pci-layerscape.c
@@ -173,6 +173,8 @@ static int ls_pcie_msi_host_init(struct pcie_port *pp,
 		return -EINVAL;
 	}
 
+	of_node_put(msi_node);
+
 	return 0;
 }
 
-- 
1.9.1

