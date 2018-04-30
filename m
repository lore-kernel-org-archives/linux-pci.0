Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from thoth.sbs.de ([192.35.17.2]:41328 "EHLO thoth.sbs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751569AbeD3FtM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 30 Apr 2018 01:49:12 -0400
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 02/10] PCI: Fix memory leak of devm_pci_alloc_host_bridge()
Date: Mon, 30 Apr 2018 07:48:36 +0200
Message-Id: <5c8b17b2995234c13eb9abd7d27c9a020984ae9e.1525067324.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1525067324.git.jan.kiszka@siemens.com>
References: <cover.1525067324.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1525067324.git.jan.kiszka@siemens.com>
References: <cover.1525067324.git.jan.kiszka@siemens.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Jan Kiszka <jan.kiszka@siemens.com>

devm_pci_release_host_bridge_dev() failed to release the resource list.

Fixes: 5c3f18cce083 ("PCI: Add devm_pci_alloc_host_bridge() interface")
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 drivers/pci/probe.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index ac91b6fd0bcd..eccf204c9160 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -526,12 +526,14 @@ static void devm_pci_release_host_bridge_dev(struct device *dev)
 
 	if (bridge->release_fn)
 		bridge->release_fn(bridge);
+
+	pci_free_resource_list(&bridge->windows);
 }
 
 static void pci_release_host_bridge_dev(struct device *dev)
 {
 	devm_pci_release_host_bridge_dev(dev);
-	pci_free_host_bridge(to_pci_host_bridge(dev));
+	kfree(to_pci_host_bridge(dev));
 }
 
 struct pci_host_bridge *pci_alloc_host_bridge(size_t priv)
-- 
2.13.6
