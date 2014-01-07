Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f177.google.com ([209.85.223.177]:59399 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757963AbaAGA5B (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 6 Jan 2014 19:57:01 -0500
Received: by mail-ie0-f177.google.com with SMTP id tp5so18620340ieb.8
        for <linux-pci@vger.kernel.org>; Mon, 06 Jan 2014 16:57:00 -0800 (PST)
Subject: [PATCH v7 15/15] PCI: Allocate 64-bit BARs above 4G when possible
To: linux-pci@vger.kernel.org, Daniel Vetter <daniel.vetter@ffwll.ch>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: David Airlie <airlied@linux.ie>, Yinghai Lu <yinghai@kernel.org>,
	Guo Chao <yan@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org
Date: Mon, 06 Jan 2014 17:56:58 -0700
Message-ID: <20140107005658.10786.98616.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20140107005003.10786.85164.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20140107005003.10786.85164.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Yinghai Lu <yinghai@kernel.org>

Try to allocate space for 64-bit BARs above 4G first, to preserve the space
below 4G for 32-bit BARs.  If there's no space above 4G available, fall
back to allocating anywhere.

[bhelgaas: reworked starting from http://lkml.kernel.org/r/1387485843-17403-2-git-send-email-yinghai@kernel.org]
Signed-off-by: Yinghai Lu <yinghai@kernel.org>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/bus.c |   16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
index 58beaaba50ee..107ad9a5b8aa 100644
--- a/drivers/pci/bus.c
+++ b/drivers/pci/bus.c
@@ -101,6 +101,8 @@ void pci_bus_remove_resources(struct pci_bus *bus)
 static struct pci_bus_region pci_32_bit = {0, 0xffffffffULL};
 static struct pci_bus_region pci_64_bit = {0,
 				(resource_size_t) 0xffffffffffffffffULL};
+static struct pci_bus_region pci_high = {(resource_size_t) 0x100000000ULL,
+				(resource_size_t) 0xffffffffffffffffULL};
 
 /*
  * @res contains CPU addresses.  Clip it so the corresponding bus addresses
@@ -196,8 +198,7 @@ static int pci_bus_alloc_from_region(struct pci_bus *bus, struct resource *res,
  * alignment and type, try to find an acceptable resource allocation
  * for a specific device resource.
  */
-int
-pci_bus_alloc_resource(struct pci_bus *bus, struct resource *res,
+int pci_bus_alloc_resource(struct pci_bus *bus, struct resource *res,
 		resource_size_t size, resource_size_t align,
 		resource_size_t min, unsigned int type_mask,
 		resource_size_t (*alignf)(void *,
@@ -206,10 +207,19 @@ pci_bus_alloc_resource(struct pci_bus *bus, struct resource *res,
 					  resource_size_t),
 		void *alignf_data)
 {
-	if (res->flags & IORESOURCE_MEM_64)
+	int rc;
+
+	if (res->flags & IORESOURCE_MEM_64) {
+		rc = pci_bus_alloc_from_region(bus, res, size, align, min,
+					       type_mask, alignf, alignf_data,
+					       &pci_high);
+		if (rc == 0)
+			return 0;
+
 		return pci_bus_alloc_from_region(bus, res, size, align, min,
 						 type_mask, alignf, alignf_data,
 						 &pci_64_bit);
+	}
 
 	return pci_bus_alloc_from_region(bus, res, size, align, min,
 					 type_mask, alignf, alignf_data,

