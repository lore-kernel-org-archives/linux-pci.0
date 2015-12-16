Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Tomasz Nowicki <tn@semihalf.com>
To: bhelgaas@google.com, arnd@arndb.de, will.deacon@arm.com,
	catalin.marinas@arm.com, rjw@rjwysocki.net, hanjun.guo@linaro.org,
	Lorenzo.Pieralisi@arm.com, okaya@codeaurora.org,
	jiang.liu@linux.intel.com, Stefano.Stabellini@eu.citrix.com
Cc: robert.richter@caviumnetworks.com, mw@semihalf.com,
	Liviu.Dudau@arm.com, ddaney@caviumnetworks.com, tglx@linutronix.de,
	wangyijing@huawei.com, Suravee.Suthikulpanit@amd.com,
	msalter@redhat.com, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org,
	jchandra@broadcom.com, jcm@redhat.com,
	Tomasz Nowicki <tn@semihalf.com>
Subject: [PATCH V2 18/23] x86, acpi, pci: Use equivalent function introduced in previous patch.
Date: Wed, 16 Dec 2015 16:16:28 +0100
Message-Id: <1450278993-12664-19-git-send-email-tn@semihalf.com>
In-Reply-To: <1450278993-12664-1-git-send-email-tn@semihalf.com>
References: <1450278993-12664-1-git-send-email-tn@semihalf.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
---
 arch/x86/pci/acpi.c | 20 +-------------------
 1 file changed, 1 insertion(+), 19 deletions(-)

diff --git a/arch/x86/pci/acpi.c b/arch/x86/pci/acpi.c
index 5f78595..33233a7 100644
--- a/arch/x86/pci/acpi.c
+++ b/arch/x86/pci/acpi.c
@@ -201,29 +201,11 @@ static int setup_mcfg_map(struct acpi_pci_root_info *ci)
 
 	return 0;
 }
-
-static void teardown_mcfg_map(struct acpi_pci_root_info *ci)
-{
-	struct acpi_pci_root *root = ci->root;
-	struct pci_mmcfg_region *cfg;
-
-	cfg = pci_mmconfig_lookup(root->segment, root->secondary.start);
-	if (!cfg)
-		return;
-
-	if (cfg->hot_added)
-		pci_mmconfig_delete(root->segment, root->secondary.start,
-				    root->secondary.end);
-}
 #else
 static int setup_mcfg_map(struct acpi_pci_root_info *ci)
 {
 	return 0;
 }
-
-static void teardown_mcfg_map(struct acpi_pci_root_info *ci)
-{
-}
 #endif
 
 static int pci_acpi_root_get_node(struct acpi_pci_root *root)
@@ -251,7 +233,7 @@ static int pci_acpi_root_init_info(struct acpi_pci_root_info *ci)
 
 static void pci_acpi_root_release_info(struct acpi_pci_root_info *ci)
 {
-	teardown_mcfg_map(ci);
+	pci_mmcfg_teardown_map(ci);
 	kfree(container_of(ci, struct pci_root_info, common));
 }
 
-- 
1.9.1

