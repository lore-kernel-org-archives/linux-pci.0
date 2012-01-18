Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-gx0-f202.google.com ([209.85.161.202]:49920 "EHLO
	mail-gx0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756126Ab2ARAlW (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 17 Jan 2012 19:41:22 -0500
Received: by ggnv2 with SMTP id v2so273702ggn.1
        for <linux-pci@vger.kernel.org>; Tue, 17 Jan 2012 16:41:22 -0800 (PST)
Subject: [PATCH] x86/PCI: don't fall back to defaults if _CRS has no apertures
To: Jesse Barnes <jbarnes@virtuousgeek.org>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>
Date: Tue, 17 Jan 2012 17:41:21 -0700
Message-ID: <20120118004121.1089.43631.stgit@bhelgaas.mtv.corp.google.com>
In-Reply-To: <20120118004027.1089.93781.stgit@bhelgaas.mtv.corp.google.com>
References: <20120118004027.1089.93781.stgit@bhelgaas.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Host bridges that lead to things like the Uncore need not have any
I/O port or MMIO apertures.  For example, in this case:

    ACPI: PCI Root Bridge [UNC1] (domain 0000 [bus ff])
    PCI: root bus ff: using default resources
    PCI host bridge to bus 0000:ff
    pci_bus 0000:ff: root bus resource [io  0x0000-0xffff]
    pci_bus 0000:ff: root bus resource [mem 0x00000000-0x3fffffffffff]

we should not pretend those default resources are available on bus ff.

CC: Yinghai Lu <yinghai@kernel.org>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 arch/x86/pci/acpi.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/arch/x86/pci/acpi.c b/arch/x86/pci/acpi.c
index 0a45d1c..67d9b49 100644
--- a/arch/x86/pci/acpi.c
+++ b/arch/x86/pci/acpi.c
@@ -405,7 +405,12 @@ struct pci_bus * __devinit pci_acpi_scan_root(struct acpi_pci_root *root)
 		kfree(sd);
 	} else {
 		get_current_resources(device, busnum, domain, &resources);
-		if (list_empty(&resources))
+
+		/*
+		 * _CRS with no apertures is normal, so only fall back to
+		 * defaults or native bridge info if we're ignoring _CRS.
+		 */
+		if (!pci_use_crs)
 			x86_pci_root_bus_resources(busnum, &resources);
 		bridge = pci_create_host_bridge(NULL, domain, &root->secondary,
 						&resources, &pci_root_ops, sd);

