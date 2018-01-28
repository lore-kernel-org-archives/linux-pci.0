Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from 5.mo68.mail-out.ovh.net ([46.105.62.179]:41306 "EHLO
        5.mo68.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752092AbeA1UxF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 28 Jan 2018 15:53:05 -0500
Received: from player776.ha.ovh.net (b7.ovh.net [213.186.33.57])
        by mo68.mail-out.ovh.net (Postfix) with ESMTP id 49560B85F1
        for <linux-pci@vger.kernel.org>; Sun, 28 Jan 2018 21:43:16 +0100 (CET)
From: Cyrille Pitchen <cyrille.pitchen@free-electrons.com>
To: bhelgaas@google.com, kishon@ti.com, lorenzo.pieralisi@arm.com,
        linux-pci@vger.kernel.org
Cc: adouglas@cadence.com, stelford@cadence.com, dgary@cadence.com,
        kgopi@cadence.com, eandrews@cadence.com,
        thomas.petazzoni@free-electrons.com, sureshp@cadence.com,
        nsekhar@ti.com, linux-kernel@vger.kernel.org, robh@kernel.org,
        devicetree@vger.kernel.org,
        Cyrille Pitchen <cyrille.pitchen@free-electrons.com>
Subject: [PATCH v5 09/11] PCI: endpoint: Fix EPF device name to support multi-function devices
Date: Sun, 28 Jan 2018 21:40:23 +0100
Message-Id: <0c9ae7445f9900f96c62f78e91810dd906bab14f.1517170521.git.cyrille.pitchen@free-electrons.com>
In-Reply-To: <cover.1517170521.git.cyrille.pitchen@free-electrons.com>
References: <cover.1517170521.git.cyrille.pitchen@free-electrons.com>
In-Reply-To: <cover.1517170521.git.cyrille.pitchen@free-electrons.com>
References: <cover.1517170521.git.cyrille.pitchen@free-electrons.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Fix the pci_epf_make() function so it can now bind many EPF devices to the
same EPF driver.

Signed-off-by: Cyrille Pitchen <cyrille.pitchen@free-electrons.com>
---
 drivers/pci/endpoint/pci-ep-cfs.c | 46 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 44 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/endpoint/pci-ep-cfs.c b/drivers/pci/endpoint/pci-ep-cfs.c
index c9a2fb9dd49d..9ec28be1e378 100644
--- a/drivers/pci/endpoint/pci-ep-cfs.c
+++ b/drivers/pci/endpoint/pci-ep-cfs.c
@@ -18,18 +18,22 @@
  */
 
 #include <linux/module.h>
+#include <linux/idr.h>
 #include <linux/slab.h>
 
 #include <linux/pci-epc.h>
 #include <linux/pci-epf.h>
 #include <linux/pci-ep-cfs.h>
 
+static DEFINE_IDR(functions_idr);
+static DEFINE_MUTEX(functions_mutex);
 static struct config_group *functions_group;
 static struct config_group *controllers_group;
 
 struct pci_epf_group {
 	struct config_group group;
 	struct pci_epf *epf;
+	int index;
 };
 
 struct pci_epc_group {
@@ -354,6 +358,9 @@ static void pci_epf_release(struct config_item *item)
 {
 	struct pci_epf_group *epf_group = to_pci_epf_group(item);
 
+	mutex_lock(&functions_mutex);
+	idr_remove(&functions_idr, epf_group->index);
+	mutex_unlock(&functions_mutex);
 	pci_epf_destroy(epf_group->epf);
 	kfree(epf_group);
 }
@@ -373,22 +380,57 @@ static struct config_group *pci_epf_make(struct config_group *group,
 {
 	struct pci_epf_group *epf_group;
 	struct pci_epf *epf;
+	char *epf_name;
+	int index, err;
 
 	epf_group = kzalloc(sizeof(*epf_group), GFP_KERNEL);
 	if (!epf_group)
 		return ERR_PTR(-ENOMEM);
 
+	mutex_lock(&functions_mutex);
+	index = idr_alloc(&functions_idr, epf_group, 0, 0, GFP_KERNEL);
+	mutex_unlock(&functions_mutex);
+	if (index < 0) {
+		err = index;
+		goto free_group;
+	}
+
+	epf_group->index = index;
+
 	config_group_init_type_name(&epf_group->group, name, &pci_epf_type);
 
-	epf = pci_epf_create(group->cg_item.ci_name);
+	epf_name = kasprintf(GFP_KERNEL, "%s.%d",
+			     group->cg_item.ci_name, epf_group->index);
+	if (!epf_name) {
+		err = -ENOMEM;
+		goto remove_idr;
+	}
+
+	epf = pci_epf_create(epf_name);
 	if (IS_ERR(epf)) {
 		pr_err("failed to create endpoint function device\n");
-		return ERR_PTR(-EINVAL);
+		err = -EINVAL;
+		goto free_name;
 	}
 
 	epf_group->epf = epf;
 
+	kfree(epf_name);
+
 	return &epf_group->group;
+
+free_name:
+	kfree(epf_name);
+
+remove_idr:
+	mutex_lock(&functions_mutex);
+	idr_remove(&functions_idr, epf_group->index);
+	mutex_unlock(&functions_mutex);
+
+free_group:
+	kfree(epf_group);
+
+	return ERR_PTR(err);
 }
 
 static void pci_epf_drop(struct config_group *group, struct config_item *item)
-- 
2.11.0
