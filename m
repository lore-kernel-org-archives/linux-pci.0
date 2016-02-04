Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Tomasz Nowicki <tn@semihalf.com>
To: bhelgaas@google.com, arnd@arndb.de, will.deacon@arm.com,
	catalin.marinas@arm.com, rjw@rjwysocki.net, hanjun.guo@linaro.org,
	Lorenzo.Pieralisi@arm.com, okaya@codeaurora.org,
	jiang.liu@linux.intel.com, Stefano.Stabellini@eu.citrix.com
Cc: robert.richter@caviumnetworks.com, mw@semihalf.com,
	Liviu.Dudau@arm.com, ddaney@caviumnetworks.com,
	wangyijing@huawei.com, Suravee.Suthikulpanit@amd.com,
	msalter@redhat.com, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org,
	jchandra@broadcom.com, jcm@redhat.com,
	Tomasz Nowicki <tn@semihalf.com>,
	Tomasz Nowicki <tomasz.nowicki@linaro.org>
Subject: [PATCH V4 01/23] x86, pci: Reorder logic of pci_mmconfig_insert() function
Date: Thu,  4 Feb 2016 18:28:39 +0100
Message-Id: <1454606941-9523-2-git-send-email-tn@semihalf.com>
In-Reply-To: <1454606941-9523-1-git-send-email-tn@semihalf.com>
References: <1454606941-9523-1-git-send-email-tn@semihalf.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch is the first step for MMCONFIG refactoring process.

Code that uses pci_mmcfg_lock will be moved to common file and become
accessible for all architectures. pci_mmconfig_insert() cannot be moved
so easily since it is mixing generic mmconfig code with x86 specific logic
inside of mutual exclusive block guarded by pci_mmcfg_lock.

To get rid of that constraint, we reorder actions as follow:
1. sanity check for mmconfig region presence, if we already have such
region it doesn't make snese to alloc new mmconfig list entry
2. mmconfig entry allocation, no need to lock
3. insertion to iomem_resource has its own lock, no need to wrap it into mutex
4. insertion to mmconfig list can be done as the final step in separate
function (candidate for further refactoring) and needs another mmconfig
lookup to avoid race condition.

Signed-off-by: Tomasz Nowicki <tomasz.nowicki@linaro.org>
Tested-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Tested-by: Jeremy Linton <jeremy.linton@arm.com>
Tested-by: Duc Dang <dhdang@apm.com>
Tested-by: Dongdong Liu <liudongdong3@huawei.com>
Tested-by: Hanjun Guo <hanjun.guo@linaro.org>
Tested-by: Graeme Gregory <graeme.gregory@linaro.org>
Tested-by: Sinan Kaya <okaya@codeaurora.org>
---
 arch/x86/pci/mmconfig-shared.c | 101 +++++++++++++++++++++++------------------
 1 file changed, 58 insertions(+), 43 deletions(-)

diff --git a/arch/x86/pci/mmconfig-shared.c b/arch/x86/pci/mmconfig-shared.c
index dd30b7e..c8bb9b0 100644
--- a/arch/x86/pci/mmconfig-shared.c
+++ b/arch/x86/pci/mmconfig-shared.c
@@ -720,6 +720,38 @@ static int __init pci_mmcfg_late_insert_resources(void)
  */
 late_initcall(pci_mmcfg_late_insert_resources);
 
+static int pci_mmconfig_inject(struct pci_mmcfg_region *cfg)
+{
+	struct pci_mmcfg_region *cfg_conflict;
+	int err = 0;
+
+	mutex_lock(&pci_mmcfg_lock);
+	cfg_conflict = pci_mmconfig_lookup(cfg->segment, cfg->start_bus);
+	if (cfg_conflict) {
+		if (cfg_conflict->end_bus < cfg->end_bus)
+			pr_info(FW_INFO "MMCONFIG for "
+				"domain %04x [bus %02x-%02x] "
+				"only partially covers this bridge\n",
+				cfg_conflict->segment, cfg_conflict->start_bus,
+				cfg_conflict->end_bus);
+		err = -EEXIST;
+		goto out;
+	}
+
+	if (pci_mmcfg_arch_map(cfg)) {
+		pr_warn("fail to map MMCONFIG %pR.\n", &cfg->res);
+		err = -ENOMEM;
+		goto out;
+	} else {
+		list_add_sorted(cfg);
+		pr_info("MMCONFIG at %pR (base %#lx)\n",
+			&cfg->res, (unsigned long)cfg->address);
+	}
+out:
+	mutex_unlock(&pci_mmcfg_lock);
+	return err;
+}
+
 /* Add MMCFG information for host bridges */
 int pci_mmconfig_insert(struct device *dev, u16 seg, u8 start, u8 end,
 			phys_addr_t addr)
@@ -734,63 +766,46 @@ int pci_mmconfig_insert(struct device *dev, u16 seg, u8 start, u8 end,
 	if (start > end)
 		return -EINVAL;
 
-	mutex_lock(&pci_mmcfg_lock);
+	rcu_read_lock();
 	cfg = pci_mmconfig_lookup(seg, start);
-	if (cfg) {
-		if (cfg->end_bus < end)
-			dev_info(dev, FW_INFO
-				 "MMCONFIG for "
-				 "domain %04x [bus %02x-%02x] "
-				 "only partially covers this bridge\n",
-				  cfg->segment, cfg->start_bus, cfg->end_bus);
-		mutex_unlock(&pci_mmcfg_lock);
+	rcu_read_unlock();
+	if (cfg)
 		return -EEXIST;
-	}
 
-	if (!addr) {
-		mutex_unlock(&pci_mmcfg_lock);
+	if (!addr)
 		return -EINVAL;
-	}
 
-	rc = -EBUSY;
 	cfg = pci_mmconfig_alloc(seg, start, end, addr);
-	if (cfg == NULL) {
+	if (!cfg) {
 		dev_warn(dev, "fail to add MMCONFIG (out of memory)\n");
-		rc = -ENOMEM;
-	} else if (!pci_mmcfg_check_reserved(dev, cfg, 0)) {
+		return -ENOMEM;
+	}
+
+	rc = -EBUSY;
+	if (!pci_mmcfg_check_reserved(dev, cfg, 0)) {
 		dev_warn(dev, FW_BUG "MMCONFIG %pR isn't reserved\n",
 			 &cfg->res);
-	} else {
-		/* Insert resource if it's not in boot stage */
-		if (pci_mmcfg_running_state)
-			tmp = insert_resource_conflict(&iomem_resource,
-						       &cfg->res);
-
-		if (tmp) {
-			dev_warn(dev,
-				 "MMCONFIG %pR conflicts with "
-				 "%s %pR\n",
-				 &cfg->res, tmp->name, tmp);
-		} else if (pci_mmcfg_arch_map(cfg)) {
-			dev_warn(dev, "fail to map MMCONFIG %pR.\n",
-				 &cfg->res);
-		} else {
-			list_add_sorted(cfg);
-			dev_info(dev, "MMCONFIG at %pR (base %#lx)\n",
-				 &cfg->res, (unsigned long)addr);
-			cfg = NULL;
-			rc = 0;
-		}
+		goto error;
 	}
 
-	if (cfg) {
-		if (cfg->res.parent)
-			release_resource(&cfg->res);
-		kfree(cfg);
+	/* Insert resource if it's not in boot stage */
+	if (pci_mmcfg_running_state)
+		tmp = insert_resource_conflict(&iomem_resource, &cfg->res);
+
+	if (tmp) {
+		dev_warn(dev, "MMCONFIG %pR conflicts with %s %pR\n",
+			 &cfg->res, tmp->name, tmp);
+		goto error;
 	}
 
-	mutex_unlock(&pci_mmcfg_lock);
+	rc = pci_mmconfig_inject(cfg);
+	if (!rc)
+		return 0;
 
+error:
+	if (cfg->res.parent)
+		release_resource(&cfg->res);
+	kfree(cfg);
 	return rc;
 }
 
-- 
1.9.1

