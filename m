Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-gw2-out.broadcom.com ([216.31.210.63]:56825 "EHLO
	mail-gw2-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756723AbbLBWDz (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 2 Dec 2015 17:03:55 -0500
From: Jayachandran C <jchandra@broadcom.com>
To: <linux-pci@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
CC: Jayachandran C <jchandra@broadcom.com>
Subject: [PATCH 2/3] pci: Handle NULL parent in pci_bus_assign_domain_nr
Date: Thu, 3 Dec 2015 03:54:45 +0530
Message-ID: <1449095086-5138-3-git-send-email-jchandra@broadcom.com>
In-Reply-To: <1449095086-5138-1-git-send-email-jchandra@broadcom.com>
References: <1449095086-5138-1-git-send-email-jchandra@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

pci_create_root_bus is called with NULL  parent from ACPI. On arm64,
this ends up calling pci_bus_assign_domain_nr, which crashes when
dereferencing parent.

To fix this, we update pci_bus_assign_domain_nr to return if parent
is NULL. Setting up the domain number will be handled from
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

