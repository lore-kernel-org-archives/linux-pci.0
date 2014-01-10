Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f175.google.com ([209.85.223.175]:37146 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751343AbaAJVeG (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 10 Jan 2014 16:34:06 -0500
Received: by mail-ie0-f175.google.com with SMTP id x13so5843298ief.34
        for <linux-pci@vger.kernel.org>; Fri, 10 Jan 2014 13:34:05 -0800 (PST)
Date: Fri, 10 Jan 2014 14:34:02 -0700
From: Bjorn Helgaas <bhelgaas@google.com>
To: linux-pci@vger.kernel.org, Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: David Airlie <airlied@linux.ie>, Yinghai Lu <yinghai@kernel.org>,
	Guo Chao <yan@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 00/15] PCI: Allocate 64-bit BARs above 4G when possible
Message-ID: <20140110213402.GB25635@google.com>
References: <20140107005003.10786.85164.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140107005003.10786.85164.stgit@bhelgaas-glaptop.roam.corp.google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jan 06, 2014 at 05:55:12PM -0700, Bjorn Helgaas wrote:
> This is basically v7 of Yinghai's patch series:
> http://lkml.kernel.org/r/1387485843-17403-1-git-send-email-yinghai@kernel.org
> 
> The goal is to try to put 64-bit BARs above 4G so we can preserve the
> 32-bit bus address space for 32-bit BARs.

I added Daniel's Reviewed-by to the AGP patches (except the trivial
PCI_COMMAND change in ati_configure()).

I added the incremental patch below to fix these warnings found by
Fengguang's autobuilder in the original b1e0e392f5dd commit:

  drivers/char/agp/amd-k7-agp.c:115:38: warning: 'addr' may be used uninitialized in this function [-Wmaybe-uninitialized]
  drivers/pci/bus.c:105:5: warning: large integer implicitly truncated to unsigned type [-Woverflow]

Finally, I merged the pci/resource branch with these changes into my "next"
branch, so it should appear in v3.14-rc1.

Dave, let me know if you have any issue with these AGP changes going
through my tree.

Bjorn


diff --git a/drivers/char/agp/amd-k7-agp.c b/drivers/char/agp/amd-k7-agp.c
index e8c2e9167e89..3661a51e93e2 100644
--- a/drivers/char/agp/amd-k7-agp.c
+++ b/drivers/char/agp/amd-k7-agp.c
@@ -148,8 +148,8 @@ static int amd_create_gatt_table(struct agp_bridge_data *bridge)
 	 * used to program the agp master not the cpu
 	 */
 
-	agp_bridge->gart_bus_addr = pci_bus_address(agp_bridge->dev,
-						    AGP_APERTURE_BAR);
+	addr = pci_bus_address(agp_bridge->dev, AGP_APERTURE_BAR);
+	agp_bridge->gart_bus_addr = addr;
 
 	/* Calculate the agp offset */
 	for (i = 0; i < value->num_entries / 1024; i++, addr += 0x00400000) {
diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
index 107ad9a5b8aa..86fb8ec5e448 100644
--- a/drivers/pci/bus.c
+++ b/drivers/pci/bus.c
@@ -99,10 +99,12 @@ void pci_bus_remove_resources(struct pci_bus *bus)
 }
 
 static struct pci_bus_region pci_32_bit = {0, 0xffffffffULL};
+#ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
 static struct pci_bus_region pci_64_bit = {0,
-				(resource_size_t) 0xffffffffffffffffULL};
-static struct pci_bus_region pci_high = {(resource_size_t) 0x100000000ULL,
-				(resource_size_t) 0xffffffffffffffffULL};
+				(dma_addr_t) 0xffffffffffffffffULL};
+static struct pci_bus_region pci_high = {(dma_addr_t) 0x100000000ULL,
+				(dma_addr_t) 0xffffffffffffffffULL};
+#endif
 
 /*
  * @res contains CPU addresses.  Clip it so the corresponding bus addresses
@@ -207,6 +209,7 @@ int pci_bus_alloc_resource(struct pci_bus *bus, struct resource *res,
 					  resource_size_t),
 		void *alignf_data)
 {
+#ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
 	int rc;
 
 	if (res->flags & IORESOURCE_MEM_64) {
@@ -220,6 +223,7 @@ int pci_bus_alloc_resource(struct pci_bus *bus, struct resource *res,
 						 type_mask, alignf, alignf_data,
 						 &pci_64_bit);
 	}
+#endif
 
 	return pci_bus_alloc_from_region(bus, res, size, align, min,
 					 type_mask, alignf, alignf_data,
