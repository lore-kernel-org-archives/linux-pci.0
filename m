Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Jayachandran C <jchandra@broadcom.com>
To: <linux-pci@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	<linux-acpi@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	<linux-arm-kernel@lists.infradead.org>
CC: Jayachandran C <jchandra@broadcom.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Tomasz Nowicki <tn@semihalf.com>
Subject: [RFC PATCH v3 3/5] PCI: Handle NULL parent in pci_bus_assign_domain_nr
Date: Wed, 16 Dec 2015 18:12:33 +0530
Message-ID: <1450269755-21420-4-git-send-email-jchandra@broadcom.com>
In-Reply-To: <1450269755-21420-1-git-send-email-jchandra@broadcom.com>
References: <1450269755-21420-1-git-send-email-jchandra@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-acpi-owner@vger.kernel.org
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

