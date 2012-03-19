Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Yinghai Lu <yinghai@kernel.org>
To: Jesse Barnes <jbarnes@virtuousgeek.org>, x86 <x86@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH -v3 11/11] x86, PCI: Merge root info printing for not using _CRS path
Date: Sun, 18 Mar 2012 22:40:24 -0700
Message-Id: <1332135624-13528-12-git-send-email-yinghai@kernel.org>
In-Reply-To: <1332135624-13528-1-git-send-email-yinghai@kernel.org>
References: <1332135624-13528-1-git-send-email-yinghai@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 arch/x86/pci/amd_bus.c      |   12 +-----------
 arch/x86/pci/broadcom_bus.c |    9 +--------
 arch/x86/pci/bus_numa.c     |   17 +++++++++++++++++
 arch/x86/pci/bus_numa.h     |    1 +
 4 files changed, 20 insertions(+), 19 deletions(-)

diff --git a/arch/x86/pci/amd_bus.c b/arch/x86/pci/amd_bus.c
index 459a731..0b6abbe 100644
--- a/arch/x86/pci/amd_bus.c
+++ b/arch/x86/pci/amd_bus.c
@@ -291,17 +291,7 @@ static int __init early_fill_mp_bus_info(void)
 		}
 	}
 
-	list_for_each_entry(info, &pci_root_infos, list) {
-		int busnum;
-		struct pci_root_res *root_res;
-
-		busnum = info->bus_min;
-		printk(KERN_DEBUG "bus: [%02x, %02x] on node %x link %x\n",
-		       info->bus_min, info->bus_max, info->node, info->link);
-		list_for_each_entry(root_res, &info->resources, list)
-			printk(KERN_DEBUG "bus: %02x %pR\n",
-				       busnum, &root_res->res);
-	}
+	print_pci_root_info(info, "bus:", true);
 
 	return 0;
 }
diff --git a/arch/x86/pci/broadcom_bus.c b/arch/x86/pci/broadcom_bus.c
index 614392c..a03a14a 100644
--- a/arch/x86/pci/broadcom_bus.c
+++ b/arch/x86/pci/broadcom_bus.c
@@ -76,14 +76,7 @@ static void __init cnb20le_res(u8 bus, u8 slot, u8 func)
 		update_res(info, res.start, res.end, res.flags, 0);
 	}
 
-	/* print information about this host bridge */
-	res.start = fbus;
-	res.end   = lbus;
-	res.flags = IORESOURCE_BUS;
-	printk(KERN_INFO "CNB20LE PCI Host Bridge (domain 0000 %pR)\n", &res);
-
-	list_for_each_entry(root_res, &info->resources, list)
-		printk(KERN_INFO "host bridge window %pR\n", &root_res->res);
+	print_pci_root_info(info, "host bridge windows: ", false);
 }
 
 static int __init broadcom_postcore_init(void)
diff --git a/arch/x86/pci/bus_numa.c b/arch/x86/pci/bus_numa.c
index 306579f..7251011 100644
--- a/arch/x86/pci/bus_numa.c
+++ b/arch/x86/pci/bus_numa.c
@@ -77,6 +77,23 @@ struct pci_root_info __init *alloc_pci_root_info(int bus_min, int bus_max,
 	return info;
 }
 
+void print_pci_root_info(struct pci_root_info *info, char *name, bool nodelink)
+{
+	struct pci_root_res *root_res;
+	int busnum = info->bus_min;
+
+	if (!nodelink)
+		printk(KERN_DEBUG "%s: [%02x, %02x]\n", name,
+				info->bus_min, info->bus_max);
+	else
+		printk(KERN_DEBUG "%s: [%02x, %02x] on node %x link %x\n", name,
+			info->bus_min, info->bus_max, info->node, info->link);
+
+	list_for_each_entry(root_res, &info->resources, list)
+		printk(KERN_DEBUG "%s: %02x %pR\n", name, busnum,
+				 &root_res->res);
+}
+
 void __devinit update_res(struct pci_root_info *info, resource_size_t start,
 			  resource_size_t end, unsigned long flags, int merge)
 {
diff --git a/arch/x86/pci/bus_numa.h b/arch/x86/pci/bus_numa.h
index 226a466..d19ac93 100644
--- a/arch/x86/pci/bus_numa.h
+++ b/arch/x86/pci/bus_numa.h
@@ -22,6 +22,7 @@ struct pci_root_info {
 extern struct list_head pci_root_infos;
 struct pci_root_info *alloc_pci_root_info(int bus_min, int bus_max,
 						int node, int link);
+void print_pci_root_info(struct pci_root_info *info, char *name, bool nodelink);
 extern void update_res(struct pci_root_info *info, resource_size_t start,
 		      resource_size_t end, unsigned long flags, int merge);
 #endif
-- 
1.7.7

