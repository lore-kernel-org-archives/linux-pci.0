Return-Path: <linux-arch-owner@vger.kernel.org>
From: Yinghai Lu <yinghai@kernel.org>
To: Jesse Barnes <jbarnes@virtuousgeek.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Tony Luck <tony.luck@intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH 01/13] PCI: Add iobusn_resource
Date: Fri, 27 Jan 2012 18:49:19 -0800
Message-Id: <1327718971-9598-2-git-send-email-yinghai@kernel.org>
In-Reply-To: <1327718971-9598-1-git-send-email-yinghai@kernel.org>
References: <1327718971-9598-1-git-send-email-yinghai@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

also add busn_res into struct pci_bus.

will use them to have bus number resource tree.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 include/linux/ioport.h |    1 +
 include/linux/pci.h    |    1 +
 kernel/resource.c      |    8 ++++++++
 3 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/include/linux/ioport.h b/include/linux/ioport.h
index e885ba2..6fe9e19 100644
--- a/include/linux/ioport.h
+++ b/include/linux/ioport.h
@@ -136,6 +136,7 @@ struct resource {
 /* PC/ISA/whatever - the normal PC address spaces: IO and memory */
 extern struct resource ioport_resource;
 extern struct resource iomem_resource;
+extern struct resource iobusn_resource;
 
 extern struct resource *request_resource_conflict(struct resource *root, struct resource *new);
 extern int request_resource(struct resource *root, struct resource *new);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index f8caaab..94ad468 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -419,6 +419,7 @@ struct pci_bus {
 	struct list_head slots;		/* list of slots on this bus */
 	struct resource *resource[PCI_BRIDGE_RESOURCE_NUM];
 	struct list_head resources;	/* address space routed to this bus */
+	struct resource busn_res;	/* track registered bus num range */
 
 	struct pci_ops	*ops;		/* configuration access functions */
 	void		*sysdata;	/* hook for sys-specific extension */
diff --git a/kernel/resource.c b/kernel/resource.c
index 7640b3a..53b42f0 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -38,6 +38,14 @@ struct resource iomem_resource = {
 };
 EXPORT_SYMBOL(iomem_resource);
 
+struct resource iobusn_resource = {
+	.name	= "PCI busn",
+	.start	= 0,
+	.end	= 0xffffff,
+	.flags	= IORESOURCE_BUS,
+};
+EXPORT_SYMBOL(iobusn_resource);
+
 /* constraints to be met while allocating resources */
 struct resource_constraint {
 	resource_size_t min, max, align;
-- 
1.7.7

