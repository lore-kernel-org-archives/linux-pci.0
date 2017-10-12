Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Pankaj Dubey <pankaj.dubey@samsung.com>
To: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Kishon Vijay Abraham I <kishon@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Pankaj Dubey <pankaj.dubey@samsung.com>
Subject: [PATCH] PCI: endpoint: handle probable NULL pointer access
Date: Thu, 12 Oct 2017 09:27:57 +0530
Message-id: <1507780677-7983-1-git-send-email-pankaj.dubey@samsung.com>
References: <CGME20171012035806epcas1p16df484a0565cfe780416253710464a8f@epcas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

controller_group allocation in pci_ep_cfs_init function can fail
so we should have a check while using it in pci_ep_cfs_add_epc_group
for registering group, else we will hit NULL pointer access.

This patch adds required check for the same and returns -EPROBE_DEFER,
so that endpoint controller driver probe can be reattempted later
in case controller_group is not allocated because pci_ep_cfs_init is
not yet called.

Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
---
 drivers/pci/endpoint/pci-ep-cfs.c   | 7 ++++++-
 drivers/pci/endpoint/pci-epc-core.c | 4 ++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/endpoint/pci-ep-cfs.c b/drivers/pci/endpoint/pci-ep-cfs.c
index 424fdd6..3cac818 100644
--- a/drivers/pci/endpoint/pci-ep-cfs.c
+++ b/drivers/pci/endpoint/pci-ep-cfs.c
@@ -172,7 +172,12 @@ struct config_group *pci_ep_cfs_add_epc_group(const char *name)
 	group = &epc_group->group;
 
 	config_group_init_type_name(group, name, &pci_epc_type);
-	ret = configfs_register_group(controllers_group, group);
+
+	if (controllers_group)
+		ret = configfs_register_group(controllers_group, group);
+	else
+		ret = -EPROBE_DEFER;
+
 	if (ret) {
 		pr_err("failed to register configfs group for %s\n", name);
 		goto err_register_group;
diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
index 42c2a11..d327a2a 100644
--- a/drivers/pci/endpoint/pci-epc-core.c
+++ b/drivers/pci/endpoint/pci-epc-core.c
@@ -518,6 +518,10 @@ __pci_epc_create(struct device *dev, const struct pci_epc_ops *ops,
 		goto put_dev;
 
 	epc->group = pci_ep_cfs_add_epc_group(dev_name(dev));
+	if (IS_ERR(epc->group)) {
+		ret = -EPROBE_DEFER;
+		goto put_dev;
+	}
 
 	return epc;
 
-- 
2.7.4
