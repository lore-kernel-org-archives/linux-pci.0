Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ee0-f74.google.com ([74.125.83.74]:45935 "EHLO
	mail-ee0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756255Ab2ARAlu (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 17 Jan 2012 19:41:50 -0500
Received: by eekb15 with SMTP id b15so103668eek.1
        for <linux-pci@vger.kernel.org>; Tue, 17 Jan 2012 16:41:49 -0800 (PST)
Subject: [PATCH 4/4] x86/PCI: use pci_create_host_bridge() so PCI core knows
	subordinate buses
To: Jesse Barnes <jbarnes@virtuousgeek.org>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Date: Tue, 17 Jan 2012 17:35:17 -0700
Message-ID: <20120118003517.467.80646.stgit@bhelgaas.mtv.corp.google.com>
In-Reply-To: <20120118003335.467.71863.stgit@bhelgaas.mtv.corp.google.com>
References: <20120118003335.467.71863.stgit@bhelgaas.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

If the PCI core knows the entire subordinate bus range (not just the
root bus number), it can restrict enumeration to just those buses.
If we enumerate devices under the wrong host bridge, we'll use the
wrong resources for those devices.

Reference: https://bugzilla.novell.com/show_bug.cgi?id=735909
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 arch/x86/pci/acpi.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/pci/acpi.c b/arch/x86/pci/acpi.c
index a312e76..0a45d1c 100644
--- a/arch/x86/pci/acpi.c
+++ b/arch/x86/pci/acpi.c
@@ -349,6 +349,7 @@ struct pci_bus * __devinit pci_acpi_scan_root(struct acpi_pci_root *root)
 	int domain = root->segment;
 	int busnum = root->secondary.start;
 	LIST_HEAD(resources);
+	struct pci_host_bridge *bridge;
 	struct pci_bus *bus;
 	struct pci_sysdata *sd;
 	int node;
@@ -406,8 +407,9 @@ struct pci_bus * __devinit pci_acpi_scan_root(struct acpi_pci_root *root)
 		get_current_resources(device, busnum, domain, &resources);
 		if (list_empty(&resources))
 			x86_pci_root_bus_resources(busnum, &resources);
-		bus = pci_create_root_bus(NULL, busnum, &pci_root_ops, sd,
-					  &resources);
+		bridge = pci_create_host_bridge(NULL, domain, &root->secondary,
+						&resources, &pci_root_ops, sd);
+		bus = bridge ? bridge->bus : NULL;
 		if (bus)
 			bus->subordinate = pci_scan_child_bus(bus);
 		else

