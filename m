Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>, Ram Pai <linuxram@us.ibm.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH v3 14/27] PCI: Use for_each_pci_resource() in pci_assign_resource
Date: Wed, 13 Mar 2013 16:28:09 -0700
Message-Id: <1363217302-14383-15-git-send-email-yinghai@kernel.org>
In-Reply-To: <1363217302-14383-1-git-send-email-yinghai@kernel.org>
References: <1363217302-14383-1-git-send-email-yinghai@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Also replace dev->resource[n] with pci_dev_resource_n().

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 drivers/pci/setup-res.c |   14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
index 81b88bd..94ef232 100644
--- a/drivers/pci/setup-res.c
+++ b/drivers/pci/setup-res.c
@@ -110,7 +110,7 @@ void pci_update_resource(struct pci_dev *dev, int resno)
 
 int pci_claim_resource(struct pci_dev *dev, int resource)
 {
-	struct resource *res = &dev->resource[resource];
+	struct resource *res = pci_dev_resource_n(dev, resource);
 	struct resource *root, *conflict;
 
 	root = pci_find_parent_resource(dev, res);
@@ -200,7 +200,7 @@ static int pci_revert_fw_address(struct resource *res, struct pci_dev *dev,
 static int __pci_assign_resource(struct pci_bus *bus, struct pci_dev *dev,
 		int resno, resource_size_t size, resource_size_t align)
 {
-	struct resource *res = dev->resource + resno;
+	struct resource *res = pci_dev_resource_n(dev, resno);
 	resource_size_t min;
 	int ret;
 
@@ -227,7 +227,7 @@ static int __pci_assign_resource(struct pci_bus *bus, struct pci_dev *dev,
 static int _pci_assign_resource(struct pci_dev *dev, int resno,
 				resource_size_t size, resource_size_t min_align)
 {
-	struct resource *res = dev->resource + resno;
+	struct resource *res = pci_dev_resource_n(dev, resno);
 	struct pci_bus *bus;
 	int ret;
 	char *type;
@@ -259,7 +259,7 @@ static int _pci_assign_resource(struct pci_dev *dev, int resno,
 
 int pci_assign_resource(struct pci_dev *dev, int resno)
 {
-	struct resource *res = dev->resource + resno;
+	struct resource *res = pci_dev_resource_n(dev, resno);
 	resource_size_t align, size;
 	struct pci_bus *bus;
 	int ret;
@@ -295,7 +295,7 @@ int pci_assign_resource(struct pci_dev *dev, int resno)
 int pci_reassign_resource(struct pci_dev *dev, int resno, resource_size_t addsize,
 			resource_size_t min_align)
 {
-	struct resource *res = dev->resource + resno;
+	struct resource *res = pci_dev_resource_n(dev, resno);
 	resource_size_t new_size;
 	int ret;
 
@@ -326,12 +326,10 @@ int pci_enable_resources(struct pci_dev *dev, int mask)
 	pci_read_config_word(dev, PCI_COMMAND, &cmd);
 	old_cmd = cmd;
 
-	for (i = 0; i < PCI_NUM_RESOURCES; i++) {
+	for_each_pci_resource(dev, r, i, PCI_ALL_RES) {
 		if (!(mask & (1 << i)))
 			continue;
 
-		r = &dev->resource[i];
-
 		if (!(r->flags & (IORESOURCE_IO | IORESOURCE_MEM)))
 			continue;
 		if ((i == PCI_ROM_RESOURCE) &&
-- 
1.7.10.4

