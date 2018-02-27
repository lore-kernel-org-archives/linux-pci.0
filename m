Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([217.72.192.75]:48357 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751908AbeB0KC7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Feb 2018 05:02:59 -0500
From: Rolf Evers-Fischer <embedded24@evers-fischer.de>
To: kishon@ti.com
Cc: lorenzo.pieralisi@arm.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        andy.shevchenko@gmail.com,
        Rolf Evers-Fischer <rolf.evers.fischer@aptiv.com>
Subject: [PATCH v3 1/2] pci: endpoint: Simplify name allocation for epf device
Date: Tue, 27 Feb 2018 11:02:29 +0100
Message-Id: <20180227100231.22561-2-embedded24@evers-fischer.de>
In-Reply-To: <20180227100231.22561-1-embedded24@evers-fischer.de>
References: <20180227100231.22561-1-embedded24@evers-fischer.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Rolf Evers-Fischer <rolf.evers.fischer@aptiv.com>

This commit replaces allocating and freeing the intermediate
'buf'/'func_name' with a combination of 'kstrndup()' and 'len'.

'len' is the required length of 'epf->name'.
'epf->name' should be either the first part of 'name' preceding the '.'
or the complete 'name', if there is no '.' in the name.

Signed-off-by: Rolf Evers-Fischer <rolf.evers.fischer@aptiv.com>
---
 drivers/pci/endpoint/pci-epf-core.c | 22 ++++------------------
 1 file changed, 4 insertions(+), 18 deletions(-)

diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
index 766ce1dca2ec..1f2506f32bb9 100644
--- a/drivers/pci/endpoint/pci-epf-core.c
+++ b/drivers/pci/endpoint/pci-epf-core.c
@@ -200,8 +200,7 @@ struct pci_epf *pci_epf_create(const char *name)
 	int ret;
 	struct pci_epf *epf;
 	struct device *dev;
-	char *func_name;
-	char *buf;
+	int len;
 
 	epf = kzalloc(sizeof(*epf), GFP_KERNEL);
 	if (!epf) {
@@ -209,20 +208,11 @@ struct pci_epf *pci_epf_create(const char *name)
 		goto err_ret;
 	}
 
-	buf = kstrdup(name, GFP_KERNEL);
-	if (!buf) {
-		ret = -ENOMEM;
-		goto free_epf;
-	}
-
-	func_name = buf;
-	buf = strchrnul(buf, '.');
-	*buf = '\0';
-
-	epf->name = kstrdup(func_name, GFP_KERNEL);
+	len = strchrnul(name, '.') - name;
+	epf->name = kstrndup(name, len, GFP_KERNEL);
 	if (!epf->name) {
 		ret = -ENOMEM;
-		goto free_func_name;
+		goto free_epf;
 	}
 
 	dev = &epf->dev;
@@ -238,16 +228,12 @@ struct pci_epf *pci_epf_create(const char *name)
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
