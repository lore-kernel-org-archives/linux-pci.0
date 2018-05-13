Return-Path: <SRS0=s88r=IA=siemens.com=jan.kiszka@kernel.org>
Return-Path: <SRS0=s88r=IA=siemens.com=jan.kiszka@kernel.org>
Subject: [PATCH] PCI: Fix error cleanup paths in
 devm_of_pci_get_host_bridge_resources()
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Julia Lawall <julia.lawall@lip6.fr>, linux-pci@vger.kernel.org,
        kbuild-all@01.org
References: <alpine.DEB.2.20.1805110706001.3191@hadrien>
 <3b005d1f-ee86-722b-d5ba-d543c044a941@siemens.com>
 <4720dc4c-9055-2616-c58b-d40895b9477c@siemens.com>
 <20180511222750.GA211882@bhelgaas-glaptop.roam.corp.google.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <294ff38c-f8df-f89b-3bac-604e79fe6cfe@siemens.com>
Date: Sun, 13 May 2018 20:22:05 +0200
MIME-Version: 1.0
In-Reply-To: <20180511222750.GA211882@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-pci.vger.kernel.org>

Fallouts from the conversion to devm_kzalloc: In case the function
fails, we no longer need to clean up managed allocations. In fact, we
must not. Only one case requires explicit freeing, and that is when
of_pci_range_to_resource() fails and we simply skip over the related
resource entry.

Reported-by: Julia Lawall <julia.lawall@lip6.fr>
Fixes: 07adab611304 ("PCI: Add dev parameter to __of_pci_get_host_bridge_resources()")
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 drivers/pci/of.c | 22 +++++-----------------
 1 file changed, 5 insertions(+), 17 deletions(-)

diff --git a/drivers/pci/of.c b/drivers/pci/of.c
index 38469ffd1d7e..ad8cc1d677f3 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -266,7 +266,6 @@ int devm_of_pci_get_host_bridge_resources(struct device *dev,
 			struct list_head *resources, resource_size_t *io_base)
 {
 	struct device_node *dev_node = dev->of_node;
-	struct resource_entry *window;
 	struct resource *res;
 	struct resource *bus_range;
 	struct of_pci_range range;
@@ -299,7 +298,7 @@ int devm_of_pci_get_host_bridge_resources(struct device *dev,
 	/* Check for ranges property */
 	err = of_pci_range_parser_init(&parser, dev_node);
 	if (err)
-		goto parse_failed;
+		return err;
 
 	dev_dbg(dev, "Parsing ranges property...\n");
 	for_each_of_pci_range(&parser, &range) {
@@ -322,14 +321,12 @@ int devm_of_pci_get_host_bridge_resources(struct device *dev,
 			continue;
 
 		res = devm_kzalloc(dev, sizeof(struct resource), GFP_KERNEL);
-		if (!res) {
-			err = -ENOMEM;
-			goto parse_failed;
-		}
+		if (!res)
+			return -ENOMEM;
 
 		err = of_pci_range_to_resource(&range, dev_node, res);
 		if (err) {
-			kfree(res);
+			devm_kfree(dev, res);
 			continue;
 		}
 
@@ -338,8 +335,7 @@ int devm_of_pci_get_host_bridge_resources(struct device *dev,
 				dev_err(dev,
 					"I/O range found for %pOF. Please provide an io_base pointer to save CPU base address\n",
 					dev_node);
-				err = -EINVAL;
-				goto conversion_failed;
+				return -EINVAL;
 			}
 			if (*io_base != (resource_size_t)OF_BAD_ADDR)
 				dev_warn(dev,
@@ -352,14 +348,6 @@ int devm_of_pci_get_host_bridge_resources(struct device *dev,
 	}
 
 	return 0;
-
-conversion_failed:
-	kfree(res);
-parse_failed:
-	resource_list_for_each_entry(window, resources)
-		kfree(window->res);
-	pci_free_resource_list(resources);
-	return err;
 }
 EXPORT_SYMBOL_GPL(devm_of_pci_get_host_bridge_resources);
 #endif /* CONFIG_OF_ADDRESS */
-- 
2.13.6
