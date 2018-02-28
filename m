Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Rolf Evers-Fischer <embedded24@evers-fischer.de>
To: kishon@ti.com
Cc: lorenzo.pieralisi@arm.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        andy.shevchenko@gmail.com,
        Rolf Evers-Fischer <rolf.evers.fischer@aptiv.com>
Subject: [PATCH v4 2/3] PCI: endpoint: Fix kernel panic after put_device()
Date: Wed, 28 Feb 2018 14:07:18 +0100
Message-Id: <20180228130719.31218-3-embedded24@evers-fischer.de>
In-Reply-To: <20180228130719.31218-1-embedded24@evers-fischer.de>
References: <20180228130719.31218-1-embedded24@evers-fischer.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Rolf Evers-Fischer <rolf.evers.fischer@aptiv.com>

'put_device()' calls the relase function 'pci_epf_dev_release()',
which already frees 'epf->name' and 'epf'.

Therefore we must not free them again after 'put_device()'.

Fixes: 5e8cb4033807 ("PCI: endpoint: Add EP core layer to enable EP controller and EP functions")

Signed-off-by: Rolf Evers-Fischer <rolf.evers.fischer@aptiv.com>
---
 drivers/pci/endpoint/pci-epf-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
index 1f2506f32bb9..1878a6776519 100644
--- a/drivers/pci/endpoint/pci-epf-core.c
+++ b/drivers/pci/endpoint/pci-epf-core.c
@@ -232,7 +232,7 @@ struct pci_epf *pci_epf_create(const char *name)
 
 put_dev:
 	put_device(dev);
-	kfree(epf->name);
+	return ERR_PTR(ret);
 
 free_epf:
 	kfree(epf);
-- 
2.16.2
