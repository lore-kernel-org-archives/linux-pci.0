Return-Path: <andrew.donnellan@au1.ibm.com>
Return-Path: <andrew.donnellan@au1.ibm.com>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-pci@vger.kernel.org, helgaas@kernel.org, mauricfo@linux.vnet.ibm.com,
        gwshan@linux.vnet.ibm.com, ruscur@russell.cc,
        mrochs@linux.vnet.ibm.com, ukrishn@linux.vnet.ibm.com,
        imunsie@au1.ibm.com, fbarrat@linux.vnet.ibm.com,
        clombard@linux.vnet.ibm.com, felix@linux.vnet.ibm.com
Subject: [PATCH] cxl: use pcibios_free_controller_deferred() when removing vPHBs
Date: Thu, 18 Aug 2016 17:35:14 +1000
Message-Id: <1471505714-30049-1-git-send-email-andrew.donnellan@au1.ibm.com>
List-ID: <linux-pci.vger.kernel.org>

When cxl removes a vPHB, it's possible that the pci_controller may be freed
before all references to the devices on the vPHB have been released. This
in turn causes an invalid memory access when the devices are eventually
released, as pcibios_release_device() attempts to call the phb's
release_device hook.

In cxl_pci_vphb_remove(), remove the existing call to
pcibios_free_controller(). Instead, use
pcibios_free_controller_deferred() to free the pci_controller after all
devices have been released. Export pci_set_host_bridge_release() so we can
do this.

Cc: stable@vger.kernel.org
Signed-off-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

---

This patch requires http://patchwork.ozlabs.org/patch/658324/. It should go
through the powerpc tree.
---
 drivers/misc/cxl/vphb.c   | 10 +++++++++-
 drivers/pci/host-bridge.c |  1 +
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/cxl/vphb.c b/drivers/misc/cxl/vphb.c
index 7ada5f1..3519ace 100644
--- a/drivers/misc/cxl/vphb.c
+++ b/drivers/misc/cxl/vphb.c
@@ -230,6 +230,11 @@ int cxl_pci_vphb_add(struct cxl_afu *afu)
 	if (phb->bus == NULL)
 		return -ENXIO;
 
+	/* Set release hook on root bus */
+	pci_set_host_bridge_release(to_pci_host_bridge(phb->bus->bridge),
+				    pcibios_free_controller_deferred,
+				    (void *) phb);
+
 	/* Claim resources. This might need some rework as well depending
 	 * whether we are doing probe-only or not, like assigning unassigned
 	 * resources etc...
@@ -256,7 +261,10 @@ void cxl_pci_vphb_remove(struct cxl_afu *afu)
 	afu->phb = NULL;
 
 	pci_remove_root_bus(phb->bus);
-	pcibios_free_controller(phb);
+	/*
+	 * We don't free phb here - that's handled by
+	 * pcibios_free_controller_deferred()
+	 */
 }
 
 static bool _cxl_pci_is_vphb_device(struct pci_controller *phb)
diff --git a/drivers/pci/host-bridge.c b/drivers/pci/host-bridge.c
index 5f4a2e0..add6623 100644
--- a/drivers/pci/host-bridge.c
+++ b/drivers/pci/host-bridge.c
@@ -44,6 +44,7 @@ void pci_set_host_bridge_release(struct pci_host_bridge *bridge,
 	bridge->release_fn = release_fn;
 	bridge->release_data = release_data;
 }
+EXPORT_SYMBOL_GPL(pci_set_host_bridge_release);
 
 void pcibios_resource_to_bus(struct pci_bus *bus, struct pci_bus_region *region,
 			     struct resource *res)
-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
