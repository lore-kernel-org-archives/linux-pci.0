Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oa0-f43.google.com ([209.85.219.43]:55331 "EHLO
	mail-oa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752706AbaBLTLX (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 12 Feb 2014 14:11:23 -0500
Received: by mail-oa0-f43.google.com with SMTP id h16so11476740oag.2
        for <linux-pci@vger.kernel.org>; Wed, 12 Feb 2014 11:11:22 -0800 (PST)
Received: from localhost ([172.16.48.185])
        by mx.google.com with ESMTPSA id o7sm141286469oed.3.2014.02.12.11.11.22
        for <linux-pci@vger.kernel.org>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 12 Feb 2014 11:11:22 -0800 (PST)
Subject: [PATCH 4/4] x86/PCI: Fix function definition whitespace
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 12 Feb 2014 12:11:21 -0700
Message-ID: <20140212191121.5459.10902.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20140212190949.5459.46330.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20140212190949.5459.46330.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Consistently put the function type, name, and parameters on one line,
wrapping only as necessary.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 arch/x86/pci/acpi.c |   17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/arch/x86/pci/acpi.c b/arch/x86/pci/acpi.c
index 0073348b2960..b0bc5920f5c6 100644
--- a/arch/x86/pci/acpi.c
+++ b/arch/x86/pci/acpi.c
@@ -218,9 +218,8 @@ static void teardown_mcfg_map(struct pci_root_info *info)
 }
 #endif
 
-static acpi_status
-resource_to_addr(struct acpi_resource *resource,
-			struct acpi_resource_address64 *addr)
+static acpi_status resource_to_addr(struct acpi_resource *resource,
+				    struct acpi_resource_address64 *addr)
 {
 	acpi_status status;
 	struct acpi_resource_memory24 *memory24;
@@ -265,8 +264,7 @@ resource_to_addr(struct acpi_resource *resource,
 	return AE_ERROR;
 }
 
-static acpi_status
-count_resource(struct acpi_resource *acpi_res, void *data)
+static acpi_status count_resource(struct acpi_resource *acpi_res, void *data)
 {
 	struct pci_root_info *info = data;
 	struct acpi_resource_address64 addr;
@@ -278,8 +276,7 @@ count_resource(struct acpi_resource *acpi_res, void *data)
 	return AE_OK;
 }
 
-static acpi_status
-setup_resource(struct acpi_resource *acpi_res, void *data)
+static acpi_status setup_resource(struct acpi_resource *acpi_res, void *data)
 {
 	struct pci_root_info *info = data;
 	struct resource *res;
@@ -435,9 +432,9 @@ static void release_pci_root_info(struct pci_host_bridge *bridge)
 	__release_pci_root_info(info);
 }
 
-static void
-probe_pci_root_info(struct pci_root_info *info, struct acpi_device *device,
-		    int busnum, int domain)
+static void probe_pci_root_info(struct pci_root_info *info,
+				struct acpi_device *device,
+				int busnum, int domain)
 {
 	size_t size;
 

