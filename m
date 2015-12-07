Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-gw3-out.broadcom.com ([216.31.210.64]:35402 "EHLO
	mail-gw3-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756195AbbLGQ7a (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 7 Dec 2015 11:59:30 -0500
From: Jayachandran C <jchandra@broadcom.com>
To: <linux-pci@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	<linux-acpi@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	<linux-arm-kernel@lists.infradead.org>
CC: Jayachandran C <jchandra@broadcom.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Tomasz Nowicki <tn@semihalf.com>
Subject: [RFC PATCH v2 2/4] PCI: Handle NULL parent in pci_bus_assign_domain_nr
Date: Mon, 7 Dec 2015 22:50:27 +0530
Message-ID: <1449508829-10797-3-git-send-email-jchandra@broadcom.com>
In-Reply-To: <1449508829-10797-1-git-send-email-jchandra@broadcom.com>
References: <1449508829-10797-1-git-send-email-jchandra@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

pci_create_root_bus is called with NULL as parent in ACPI. On arm64
this ends up calling pci_bus_assign_domain_nr, which crashes when
dereferencing parent.

To fix this, update pci_bus_assign_domain_nr to return if parent is
NULL. Setting up the domain number will be handled from
pcibios_root_bridge_prepare on arm64 when booted with ACPI.

Signed-off-by: Jayachandran C <jchandra@broadcom.com>
---
 drivers/pci/pci.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 314db8c..a96c356 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4772,8 +4772,13 @@ int pci_get_new_domain_nr(void)
 void pci_bus_assign_domain_nr(struct pci_bus *bus, struct device *parent)
 {
 	static int use_dt_domains = -1;
-	int domain = of_get_pci_domain_nr(parent->of_node);
+	int domain;
 
+	/* in case of ACPI, parent is NULL */
+	if (parent == NULL)
+		return;
+
+	domain = of_get_pci_domain_nr(parent->of_node);
 	/*
 	 * Check DT domain and use_dt_domains values.
 	 *
-- 
1.9.1

