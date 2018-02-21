Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.10]:59443 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752035AbeBUMs6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 21 Feb 2018 07:48:58 -0500
From: Rolf Evers-Fischer <embedded24@evers-fischer.de>
To: kishon@ti.com
Cc: lorenzo.pieralisi@arm.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rolf Evers-Fischer <rolf.evers.fischer@aptiv.com>,
        Rolf Evers-Fischer <embedded24@evers-fischer.de>
Subject: [PATCH 2/2] pci: endpoint: Fix kernel panic after put_device()
Date: Wed, 21 Feb 2018 13:47:07 +0100
Message-Id: <20180221124707.26308-3-embedded24@evers-fischer.de>
In-Reply-To: <20180221124707.26308-1-embedded24@evers-fischer.de>
References: <20180221124707.26308-1-embedded24@evers-fischer.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Rolf Evers-Fischer <rolf.evers.fischer@aptiv.com>

'put_device()' calls the relase function 'pci_epf_dev_release()',
which already frees 'epf->name' and 'epf'.

Therefore we must not free them again after 'put_device()'.

Change-Id: I14ca19f96abfbbb489dd1f4d489e085329d7112e
Signed-off-by: Rolf Evers-Fischer <rolf.evers.fischer@aptiv.com>
Signed-off-by: Rolf Evers-Fischer <embedded24@evers-fischer.de>
---
 drivers/pci/endpoint/pci-epf-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
index 23d0e128d1a5..3718b4c5814a 100644
--- a/drivers/pci/endpoint/pci-epf-core.c
+++ b/drivers/pci/endpoint/pci-epf-core.c
@@ -243,7 +243,7 @@ struct pci_epf *pci_epf_create(const char *name)
 
 put_dev:
 	put_device(dev);
-	kfree(epf->name);
+	return ERR_PTR(ret);
 
 free_epf:
 	kfree(epf);
-- 
2.16.2
