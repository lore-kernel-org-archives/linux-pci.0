Return-Path: <tn@semihalf.com>
Return-Path: <tn@semihalf.com>
From: Tomasz Nowicki <tn@semihalf.com>
To: helgaas@kernel.org,
	arnd@arndb.de,
	will.deacon@arm.com,
	catalin.marinas@arm.com,
	rafael@kernel.org,
	hanjun.guo@linaro.org,
	Lorenzo.Pieralisi@arm.com,
	okaya@codeaurora.org,
	jchandra@broadcom.com
Cc: robert.richter@caviumnetworks.com,
	mw@semihalf.com,
	Liviu.Dudau@arm.com,
	ddaney@caviumnetworks.com,
	wangyijing@huawei.com,
	Suravee.Suthikulpanit@amd.com,
	msalter@redhat.com,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linaro-acpi@lists.linaro.org,
	jcm@redhat.com,
	andrea.gallo@linaro.org,
	dhdang@apm.com,
	jeremy.linton@arm.com,
	liudongdong3@huawei.com,
	cov@codeaurora.org,
	Tomasz Nowicki <tn@semihalf.com>
Subject: [PATCH V9 06/11] PCI: Refactor generic bus domain assignment
Date: Fri, 10 Jun 2016 21:55:14 +0200
Message-Id: <1465588519-11334-7-git-send-email-tn@semihalf.com>
In-Reply-To: <1465588519-11334-1-git-send-email-tn@semihalf.com>
References: <1465588519-11334-1-git-send-email-tn@semihalf.com>
List-ID: <linux-pci.vger.kernel.org>

Change the way PCI bus domain number is assigned and improve function
name to reflect what function does. No functional changes.

Instead of assigning bus domain number inside of pci_bus_assign_domain_nr()
simply return domain number and let pci_create_root_bus() do assignment.
This way pci_create_root_bus() setups bus structure data in the consistent
way. Since pci_bus_assign_domain_nr() now does not assign but retrieves
domain number instead, rename it to pci_bus_find_domain_nr().

Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
---
 drivers/pci/pci.c   | 4 ++--
 drivers/pci/probe.c | 4 +++-
 include/linux/pci.h | 7 +------
 3 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index eb431b5..b9a7833 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4941,7 +4941,7 @@ int pci_get_new_domain_nr(void)
 }
 
 #ifdef CONFIG_PCI_DOMAINS_GENERIC
-void pci_bus_assign_domain_nr(struct pci_bus *bus, struct device *parent)
+int pci_bus_find_domain_nr(struct pci_bus *bus, struct device *parent)
 {
 	static int use_dt_domains = -1;
 	int domain = -1;
@@ -4985,7 +4985,7 @@ void pci_bus_assign_domain_nr(struct pci_bus *bus, struct device *parent)
 		domain = -1;
 	}
 
-	bus->domain_nr = domain;
+	return domain;
 }
 #endif
 #endif
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 8e3ef72..380d46d 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2127,7 +2127,9 @@ struct pci_bus *pci_create_root_bus(struct device *parent, int bus,
 	b->sysdata = sysdata;
 	b->ops = ops;
 	b->number = b->busn_res.start = bus;
-	pci_bus_assign_domain_nr(b, parent);
+#ifdef CONFIG_PCI_DOMAINS_GENERIC
+	b->domain_nr = pci_bus_find_domain_nr(b, parent);
+#endif
 	b2 = pci_find_bus(pci_domain_nr(b), bus);
 	if (b2) {
 		/* If we already got to this bus through a different bridge, ignore it */
diff --git a/include/linux/pci.h b/include/linux/pci.h
index ce03d65..48839e8 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1390,12 +1390,7 @@ static inline int pci_domain_nr(struct pci_bus *bus)
 {
 	return bus->domain_nr;
 }
-void pci_bus_assign_domain_nr(struct pci_bus *bus, struct device *parent);
-#else
-static inline void pci_bus_assign_domain_nr(struct pci_bus *bus,
-					struct device *parent)
-{
-}
+int pci_bus_find_domain_nr(struct pci_bus *bus, struct device *parent);
 #endif
 
 /* some architectures require additional setup to direct VGA traffic */
-- 
1.9.1
