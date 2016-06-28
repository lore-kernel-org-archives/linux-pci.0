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
	gabriele.paoloni@huawei.com,
	jhugo@codeaurora.org,
	Tomasz Nowicki <tn@semihalf.com>
Subject: [RFC PATCH v4 1/5] PCI: Embed pci_ecam_ops in pci_config_window structure
Date: Tue, 28 Jun 2016 09:53:58 +0200
Message-Id: <1467100442-28078-2-git-send-email-tn@semihalf.com>
In-Reply-To: <1467100442-28078-1-git-send-email-tn@semihalf.com>
References: <1467100442-28078-1-git-send-email-tn@semihalf.com>
List-ID: <linux-pci.vger.kernel.org>

pci_config_window keeps pointer to pci_ecam_ops and every time
we want to deallocate pci_config_window (pci_ecam_free()) we need to make
sure to free pci_ecam_ops in case it was dynamically allocated prior to
pci_ecam_create() call.

To avoid that extra effort, embed pci_ecam_ops in pci_config_window,
instead of just a pointer.

Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
To: Jayachandran C <jchandra@broadcom.com>
---
 arch/arm64/kernel/pci.c  | 2 +-
 drivers/pci/ecam.c       | 6 +++---
 include/linux/pci-ecam.h | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/kernel/pci.c b/arch/arm64/kernel/pci.c
index 94cd43c..cb4dee7 100644
--- a/arch/arm64/kernel/pci.c
+++ b/arch/arm64/kernel/pci.c
@@ -196,7 +196,7 @@ struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
 		return NULL;
 	}
 
-	acpi_pci_root_ops.pci_ops = &ri->cfg->ops->pci_ops;
+	acpi_pci_root_ops.pci_ops = &ri->cfg->ops.pci_ops;
 	bus = acpi_pci_root_create(root, &acpi_pci_root_ops, &ri->common,
 				   ri->cfg);
 	if (!bus)
diff --git a/drivers/pci/ecam.c b/drivers/pci/ecam.c
index 43ed08d..24242f0 100644
--- a/drivers/pci/ecam.c
+++ b/drivers/pci/ecam.c
@@ -52,7 +52,7 @@ struct pci_config_window *pci_ecam_create(struct device *dev,
 		return ERR_PTR(-ENOMEM);
 
 	cfg->parent = dev;
-	cfg->ops = ops;
+	cfg->ops = *ops;
 	cfg->busr.start = busr->start;
 	cfg->busr.end = busr->end;
 	cfg->busr.flags = IORESOURCE_BUS;
@@ -138,7 +138,7 @@ void __iomem *pci_ecam_map_bus(struct pci_bus *bus, unsigned int devfn,
 			       int where)
 {
 	struct pci_config_window *cfg = bus->sysdata;
-	unsigned int devfn_shift = cfg->ops->bus_shift - 8;
+	unsigned int devfn_shift = cfg->ops.bus_shift - 8;
 	unsigned int busn = bus->number;
 	void __iomem *base;
 
@@ -149,7 +149,7 @@ void __iomem *pci_ecam_map_bus(struct pci_bus *bus, unsigned int devfn,
 	if (per_bus_mapping)
 		base = cfg->winp[busn];
 	else
-		base = cfg->win + (busn << cfg->ops->bus_shift);
+		base = cfg->win + (busn << cfg->ops.bus_shift);
 	return base + (devfn << devfn_shift) + where;
 }
 
diff --git a/include/linux/pci-ecam.h b/include/linux/pci-ecam.h
index 7adad20..0ce2920 100644
--- a/include/linux/pci-ecam.h
+++ b/include/linux/pci-ecam.h
@@ -39,7 +39,7 @@ struct pci_config_window {
 	struct resource			res;
 	struct resource			busr;
 	void				*priv;
-	struct pci_ecam_ops		*ops;
+	struct pci_ecam_ops		ops;
 	union {
 		void __iomem		*win;	/* 64-bit single mapping */
 		void __iomem		**winp; /* 32-bit per-bus mapping */
-- 
1.9.1
