Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oa0-f53.google.com ([209.85.219.53]:46337 "EHLO
	mail-oa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752706AbaBLTLQ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 12 Feb 2014 14:11:16 -0500
Received: by mail-oa0-f53.google.com with SMTP id m1so11549448oag.12
        for <linux-pci@vger.kernel.org>; Wed, 12 Feb 2014 11:11:15 -0800 (PST)
Received: from localhost ([172.16.48.185])
        by mx.google.com with ESMTPSA id m7sm55039033obo.7.2014.02.12.11.11.12
        for <linux-pci@vger.kernel.org>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 12 Feb 2014 11:11:14 -0800 (PST)
Subject: [PATCH 3/4] x86/PCI: Reword comments
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 12 Feb 2014 12:11:07 -0700
Message-ID: <20140212191107.5459.69509.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20140212190949.5459.46330.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20140212190949.5459.46330.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Reword comments so they make sense.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 arch/x86/pci/acpi.c |    9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/x86/pci/acpi.c b/arch/x86/pci/acpi.c
index ef7e92068eb1..0073348b2960 100644
--- a/arch/x86/pci/acpi.c
+++ b/arch/x86/pci/acpi.c
@@ -519,15 +519,12 @@ struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
 	sd->domain = domain;
 	sd->node = node;
 	sd->companion = device;
-	/*
-	 * Maybe the desired pci bus has been already scanned. In such case
-	 * it is unnecessary to scan the pci bus with the given domain,busnum.
-	 */
+
 	bus = pci_find_bus(domain, busnum);
 	if (bus) {
 		/*
-		 * If the desired bus exits, the content of bus->sysdata will
-		 * be replaced by sd.
+		 * If the desired bus has been scanned already, replace
+		 * its bus->sysdata.
 		 */
 		memcpy(bus->sysdata, sd, sizeof(*sd));
 		kfree(info);

