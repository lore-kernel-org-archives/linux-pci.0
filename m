Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.130]:36011 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932236AbeB1RdN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 28 Feb 2018 12:33:13 -0500
From: Rolf Evers-Fischer <embedded24@evers-fischer.de>
To: kishon@ti.com
Cc: lorenzo.pieralisi@arm.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        andy.shevchenko@gmail.com,
        Rolf Evers-Fischer <rolf.evers.fischer@aptiv.com>
Subject: [PATCH v5 3/3] PCI: endpoint: pci_epf_create: remove goto labels
Date: Wed, 28 Feb 2018 18:32:20 +0100
Message-Id: <20180228173220.544-4-embedded24@evers-fischer.de>
In-Reply-To: <20180228173220.544-1-embedded24@evers-fischer.de>
References: <20180228173220.544-1-embedded24@evers-fischer.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Rolf Evers-Fischer <rolf.evers.fischer@aptiv.com>

Removes the goto labels completely, handles the errors at the
respective call site and just returns instead of jumping around.

Signed-off-by: Rolf Evers-Fischer <rolf.evers.fischer@aptiv.com>
---
 drivers/pci/endpoint/pci-epf-core.c | 32 ++++++++++++--------------------
 1 file changed, 12 insertions(+), 20 deletions(-)

diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
index 1878a6776519..59ed29e550e9 100644
--- a/drivers/pci/endpoint/pci-epf-core.c
+++ b/drivers/pci/endpoint/pci-epf-core.c
@@ -203,16 +203,14 @@ struct pci_epf *pci_epf_create(const char *name)
 	int len;
 
 	epf = kzalloc(sizeof(*epf), GFP_KERNEL);
-	if (!epf) {
-		ret = -ENOMEM;
-		goto err_ret;
-	}
+	if (!epf)
+		return ERR_PTR(-ENOMEM);
 
 	len = strchrnul(name, '.') - name;
 	epf->name = kstrndup(name, len, GFP_KERNEL);
 	if (!epf->name) {
-		ret = -ENOMEM;
-		goto free_epf;
+		kfree(epf);
+		return ERR_PTR(-ENOMEM);
 	}
 
 	dev = &epf->dev;
@@ -221,24 +219,18 @@ struct pci_epf *pci_epf_create(const char *name)
 	dev->type = &pci_epf_type;
 
 	ret = dev_set_name(dev, "%s", name);
-	if (ret)
-		goto put_dev;
+	if (ret) {
+		put_device(dev);
+		return ERR_PTR(ret);
+	}
 
 	ret = device_add(dev);
-	if (ret)
-		goto put_dev;
+	if (ret) {
+		put_device(dev);
+		return ERR_PTR(ret);
+	}
 
 	return epf;
-
-put_dev:
-	put_device(dev);
-	return ERR_PTR(ret);
-
-free_epf:
-	kfree(epf);
-
-err_ret:
-	return ERR_PTR(ret);
 }
 EXPORT_SYMBOL_GPL(pci_epf_create);
 
-- 
2.16.2
