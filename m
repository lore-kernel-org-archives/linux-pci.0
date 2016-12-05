Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:39544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751427AbcLEXZi (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 5 Dec 2016 18:25:38 -0500
Subject: [PATCH v11 02/15] x86/PCI: Use acpi_resource_consumer() to search
 ACPI namespace for MMCFG
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Gabriele Paoloni <gabriele.paoloni@huawei.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Tomasz Nowicki <tn@semihalf.com>, Duc Dang <dhdang@apm.com>,
        Sinan Kaya <okaya@codeaurora.org>,
        Christopher Covington <cov@codeaurora.org>,
        Dongdong Liu <liudongdong3@huawei.com>
Date: Mon, 05 Dec 2016 17:25:34 -0600
Message-ID: <20161205232534.3957.36884.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20161205232117.3957.50546.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20161205232117.3957.50546.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Bjorn Helgaas <bhelgaas@google.com>

The static MCFG table tells us the base of MMCFG space, but it does not
reserve the space -- the reservation should be done via a device in the
ACPI namespace whose _CRS includes the MMCFG region.

Replace find_mboard_resource(), which already searches for such a device,
with the new acpi_resource_consumer() interface that does essentially the
same thing.

acpi_resource_consumer() is not as strict as find_mboard_resource() was:
find_mboard_resource() only looks at PNP0C01 and PNP0C02 devices and the
following _CRS descriptor types:

  ACPI_RESOURCE_TYPE_FIXED_MEMORY32
  ACPI_RESOURCE_TYPE_ADDRESS32
  ACPI_RESOURCE_TYPE_ADDRESS64

but acpi_resource_consumer() looks at *all* devices in the namespace and
the following descriptor types:

  ACPI_RESOURCE_TYPE_MEMORY24
  ACPI_RESOURCE_TYPE_MEMORY32
  ACPI_RESOURCE_TYPE_FIXED_MEMORY32
  ACPI_RESOURCE_TYPE_ADDRESS16
  ACPI_RESOURCE_TYPE_ADDRESS32
  ACPI_RESOURCE_TYPE_ADDRESS64
  ACPI_RESOURCE_TYPE_EXTENDED_ADDRESS64

I think it is correct to accept the larger set of descriptor types.

Note 2 to Table 4-2 of the PCI Firmware spec r3.2 does suggest that the
MMCFG region should be declared by a PNP0C02 device.  I don't know why it
calls out PNP0C02 specifically, unless it's related to the fact that the
Consumer/Producer issues make it hard to use the PNP0A03 device itself.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 arch/x86/pci/mmconfig-shared.c |   69 +++++-----------------------------------
 1 file changed, 9 insertions(+), 60 deletions(-)

diff --git a/arch/x86/pci/mmconfig-shared.c b/arch/x86/pci/mmconfig-shared.c
index dd30b7e..f62ffe7 100644
--- a/arch/x86/pci/mmconfig-shared.c
+++ b/arch/x86/pci/mmconfig-shared.c
@@ -373,71 +373,20 @@ static int __init pci_mmcfg_check_hostbridge(void)
 	return !list_empty(&pci_mmcfg_list);
 }
 
-static acpi_status check_mcfg_resource(struct acpi_resource *res, void *data)
-{
-	struct resource *mcfg_res = data;
-	struct acpi_resource_address64 address;
-	acpi_status status;
-
-	if (res->type == ACPI_RESOURCE_TYPE_FIXED_MEMORY32) {
-		struct acpi_resource_fixed_memory32 *fixmem32 =
-			&res->data.fixed_memory32;
-		if (!fixmem32)
-			return AE_OK;
-		if ((mcfg_res->start >= fixmem32->address) &&
-		    (mcfg_res->end < (fixmem32->address +
-				      fixmem32->address_length))) {
-			mcfg_res->flags = 1;
-			return AE_CTRL_TERMINATE;
-		}
-	}
-	if ((res->type != ACPI_RESOURCE_TYPE_ADDRESS32) &&
-	    (res->type != ACPI_RESOURCE_TYPE_ADDRESS64))
-		return AE_OK;
-
-	status = acpi_resource_to_address64(res, &address);
-	if (ACPI_FAILURE(status) ||
-	   (address.address.address_length <= 0) ||
-	   (address.resource_type != ACPI_MEMORY_RANGE))
-		return AE_OK;
-
-	if ((mcfg_res->start >= address.address.minimum) &&
-	    (mcfg_res->end < (address.address.minimum + address.address.address_length))) {
-		mcfg_res->flags = 1;
-		return AE_CTRL_TERMINATE;
-	}
-	return AE_OK;
-}
-
-static acpi_status find_mboard_resource(acpi_handle handle, u32 lvl,
-					void *context, void **rv)
-{
-	struct resource *mcfg_res = context;
-
-	acpi_walk_resources(handle, METHOD_NAME__CRS,
-			    check_mcfg_resource, context);
-
-	if (mcfg_res->flags)
-		return AE_CTRL_TERMINATE;
-
-	return AE_OK;
-}
-
 static int is_acpi_reserved(u64 start, u64 end, unsigned not_used)
 {
 	struct resource mcfg_res;
+	struct acpi_device *adev;
 
 	mcfg_res.start = start;
 	mcfg_res.end = end - 1;
-	mcfg_res.flags = 0;
+	mcfg_res.flags = IORESOURCE_MEM;
 
-	acpi_get_devices("PNP0C01", find_mboard_resource, &mcfg_res, NULL);
-
-	if (!mcfg_res.flags)
-		acpi_get_devices("PNP0C02", find_mboard_resource, &mcfg_res,
-				 NULL);
+	adev = acpi_resource_consumer(&mcfg_res);
+	if (adev)
+		return 1;
 
-	return mcfg_res.flags;
+	return 0;
 }
 
 typedef int (*check_reserved_t)(u64 start, u64 end, unsigned type);
@@ -450,7 +399,7 @@ static int __ref is_mmconf_reserved(check_reserved_t is_reserved,
 	u64 size = resource_size(&cfg->res);
 	u64 old_size = size;
 	int num_buses;
-	char *method = with_e820 ? "E820" : "ACPI motherboard resources";
+	char *method = with_e820 ? "E820" : "ACPI namespace";
 
 	while (!is_reserved(addr, addr + size, E820_RESERVED)) {
 		size >>= 1;
@@ -504,12 +453,12 @@ static int __ref pci_mmcfg_check_reserved(struct device *dev,
 		if (dev)
 			dev_info(dev, FW_INFO
 				 "MMCONFIG at %pR not reserved in "
-				 "ACPI motherboard resources\n",
+				 "ACPI namespace\n",
 				 &cfg->res);
 		else
 			pr_info(FW_INFO PREFIX
 			       "MMCONFIG at %pR not reserved in "
-			       "ACPI motherboard resources\n",
+			       "ACPI namespace\n",
 			       &cfg->res);
 	}
 

