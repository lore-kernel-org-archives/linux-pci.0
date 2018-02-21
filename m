Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Rolf Evers-Fischer <embedded24@evers-fischer.de>
To: kishon@ti.com
Cc: lorenzo.pieralisi@arm.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rolf Evers-Fischer <rolf.evers.fischer@aptiv.com>,
        Rolf Evers-Fischer <embedded24@evers-fischer.de>
Subject: [PATCH 1/2] pci: endpoint: Free func_name after last usage
Date: Wed, 21 Feb 2018 13:47:06 +0100
Message-Id: <20180221124707.26308-2-embedded24@evers-fischer.de>
In-Reply-To: <20180221124707.26308-1-embedded24@evers-fischer.de>
References: <20180221124707.26308-1-embedded24@evers-fischer.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Rolf Evers-Fischer <rolf.evers.fischer@aptiv.com>

This commit decreases the number of jump labels and ensures
that the next commit doesn't increase the number of occurrences
of 'kfree(func_name)'.

Change-Id: I0d1b6fd652395b85f82b11c43bf9b7db512854d1
Signed-off-by: Rolf Evers-Fischer <rolf.evers.fischer@aptiv.com>
Signed-off-by: Rolf Evers-Fischer <embedded24@evers-fischer.de>
---
 drivers/pci/endpoint/pci-epf-core.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
index 766ce1dca2ec..23d0e128d1a5 100644
--- a/drivers/pci/endpoint/pci-epf-core.c
+++ b/drivers/pci/endpoint/pci-epf-core.c
@@ -220,9 +220,10 @@ struct pci_epf *pci_epf_create(const char *name)
 	*buf = '\0';
 
 	epf->name = kstrdup(func_name, GFP_KERNEL);
+	kfree(func_name);
 	if (!epf->name) {
 		ret = -ENOMEM;
-		goto free_func_name;
+		goto free_epf;
 	}
 
 	dev = &epf->dev;
@@ -238,16 +239,12 @@ struct pci_epf *pci_epf_create(const char *name)
 	if (ret)
 		goto put_dev;
 
-	kfree(func_name);
 	return epf;
 
 put_dev:
 	put_device(dev);
 	kfree(epf->name);
 
-free_func_name:
-	kfree(func_name);
-
 free_epf:
 	kfree(epf);
 
-- 
2.16.2
