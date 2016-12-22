Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Zhou Wang <wangzhou1@hisilicon.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Tomasz Nowicki <tn@semihalf.com>,
        Jayachandran C <jchandra@broadcom.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        jorn Helgaas <bhelgaas@google.com>
CC: <liudongdong3@huawei.com>, <gabriele.paoloni@huawei.com>,
        <linux-acpi@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Zhou Wang <wangzhou1@hisilicon.com>
Subject: [RFC PATCH] ACPI/PCI: Fix bus range comparation in pci_mcfg_lookup
Date: Thu, 22 Dec 2016 17:07:43 +0800
Message-ID: <1482397663-98715-1-git-send-email-wangzhou1@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Multiple PCIe host bridges may exists in one PCIe segment. So bus range for each
host bridge should be in the coverage of bus range of related PCIe segment.

This patch will support this kind of scenario:

MCFG:
	bus range: 0x00~0xff.
	segment: 0.
DSDT:
	host bridge 1:
		bus range: 0x00~0x1f.
		segment: 0.
	host bridge 2:
		bus range: 0x20~0x4f.
		segment: 0.

Signed-off-by: Zhou Wang <wangzhou1@hisilicon.com>
---
 drivers/acpi/pci_mcfg.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/pci_mcfg.c b/drivers/acpi/pci_mcfg.c
index b5b376e..46a3e32 100644
--- a/drivers/acpi/pci_mcfg.c
+++ b/drivers/acpi/pci_mcfg.c
@@ -40,11 +40,10 @@ phys_addr_t pci_mcfg_lookup(u16 seg, struct resource *bus_res)
 	struct mcfg_entry *e;
 
 	/*
-	 * We expect exact match, unless MCFG entry end bus covers more than
-	 * specified by caller.
+	 * We expect the range in bus_res in the coverage of MCFG bus range.
 	 */
 	list_for_each_entry(e, &pci_mcfg_list, list) {
-		if (e->segment == seg && e->bus_start == bus_res->start &&
+		if (e->segment == seg && e->bus_start <= bus_res->start &&
 		    e->bus_end >= bus_res->end)
 			return e->addr;
 	}
-- 
1.9.1

