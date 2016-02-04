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
	Tomasz Nowicki <tn@semihalf.com>
Subject: [PATCH V4 10/23] x86, pci: Cleanup platform specific MCFG data by using ECAM hot_added flag.
Date: Thu,  4 Feb 2016 18:28:48 +0100
Message-Id: <1454606941-9523-11-git-send-email-tn@semihalf.com>
In-Reply-To: <1454606941-9523-1-git-send-email-tn@semihalf.com>
References: <1454606941-9523-1-git-send-email-tn@semihalf.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Because of two facts:
1. MCFG region has hot_added flag
2. struct acpi_pci_root has topology info (domain, bus number)
we can get rid of arch specific mcfg data from x86 struct pci_root_info.

Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
Tested-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Tested-by: Duc Dang <dhdang@apm.com>
Tested-by: Dongdong Liu <liudongdong3@huawei.com>
Tested-by: Hanjun Guo <hanjun.guo@linaro.org>
Tested-by: Graeme Gregory <graeme.gregory@linaro.org>
Tested-by: Sinan Kaya <okaya@codeaurora.org>
---
 arch/x86/pci/acpi.c | 36 ++++++++++++++----------------------
 1 file changed, 14 insertions(+), 22 deletions(-)

diff --git a/arch/x86/pci/acpi.c b/arch/x86/pci/acpi.c
index a997d7c..8e89921 100644
--- a/arch/x86/pci/acpi.c
+++ b/arch/x86/pci/acpi.c
@@ -12,11 +12,6 @@
 struct pci_root_info {
 	struct acpi_pci_root_info common;
 	struct pci_sysdata sd;
-#ifdef	CONFIG_PCI_MMCONFIG
-	bool mcfg_added;
-	u8 start_bus;
-	u8 end_bus;
-#endif
 };
 
 static bool pci_use_crs = true;
@@ -180,16 +175,13 @@ static int check_segment(u16 seg, struct device *dev, char *estr)
 
 static int setup_mcfg_map(struct acpi_pci_root_info *ci)
 {
-	int result, seg;
-	struct pci_root_info *info;
+	int result, seg, start, end;
 	struct acpi_pci_root *root = ci->root;
 	struct device *dev = &ci->bridge->dev;
 
-	info = container_of(ci, struct pci_root_info, common);
-	info->start_bus = (u8)root->secondary.start;
-	info->end_bus = (u8)root->secondary.end;
-	info->mcfg_added = false;
-	seg = info->sd.domain;
+	seg = root->segment;
+	start = root->secondary.start;
+	end = root->secondary.end;
 
 	/* return success if MMCFG is not in use */
 	if (raw_pci_ext_ops && raw_pci_ext_ops != &pci_mmcfg)
@@ -198,13 +190,11 @@ static int setup_mcfg_map(struct acpi_pci_root_info *ci)
 	if (!(pci_probe & PCI_PROBE_MMCONF))
 		return check_segment(seg, dev, "MMCONFIG is disabled,");
 
-	result = pci_mmconfig_insert(dev, seg, info->start_bus, info->end_bus,
-				     root->mcfg_addr);
+	result = pci_mmconfig_insert(dev, seg, start, end, root->mcfg_addr);
 	if (result == 0) {
 		/* enable MMCFG if it hasn't been enabled yet */
 		if (raw_pci_ext_ops == NULL)
 			raw_pci_ext_ops = &pci_mmcfg;
-		info->mcfg_added = true;
 	} else if (result != -EEXIST)
 		return check_segment(seg, dev,
 			 "fail to add MMCONFIG information,");
@@ -214,14 +204,16 @@ static int setup_mcfg_map(struct acpi_pci_root_info *ci)
 
 static void teardown_mcfg_map(struct acpi_pci_root_info *ci)
 {
-	struct pci_root_info *info;
+	struct acpi_pci_root *root = ci->root;
+	struct pci_mmcfg_region *cfg;
 
-	info = container_of(ci, struct pci_root_info, common);
-	if (info->mcfg_added) {
-		pci_mmconfig_delete(info->sd.domain,
-				    info->start_bus, info->end_bus);
-		info->mcfg_added = false;
-	}
+	cfg = pci_mmconfig_lookup(root->segment, root->secondary.start);
+	if (!cfg)
+		return;
+
+	if (cfg->hot_added)
+		pci_mmconfig_delete(root->segment, root->secondary.start,
+				    root->secondary.end);
 }
 #else
 static int setup_mcfg_map(struct acpi_pci_root_info *ci)
-- 
1.9.1

