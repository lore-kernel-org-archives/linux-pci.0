Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f50.google.com ([74.125.82.50]:34704 "EHLO
	mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966507AbcBDR3b (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 4 Feb 2016 12:29:31 -0500
Received: by mail-wm0-f50.google.com with SMTP id 128so37643192wmz.1
        for <linux-pci@vger.kernel.org>; Thu, 04 Feb 2016 09:29:30 -0800 (PST)
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
Subject: [PATCH V4 16/23] x86, acpi, pci: Use equivalent function from mcfg.c driver.
Date: Thu,  4 Feb 2016 18:28:54 +0100
Message-Id: <1454606941-9523-17-git-send-email-tn@semihalf.com>
In-Reply-To: <1454606941-9523-1-git-send-email-tn@semihalf.com>
References: <1454606941-9523-1-git-send-email-tn@semihalf.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Since mcfg.c driver provides the same function lets use it and remove
code duplication.

Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
Tested-by: Duc Dang <dhdang@apm.com>
Tested-by: Dongdong Liu <liudongdong3@huawei.com>
Tested-by: Hanjun Guo <hanjun.guo@linaro.org>
Tested-by: Graeme Gregory <graeme.gregory@linaro.org>
Tested-by: Sinan Kaya <okaya@codeaurora.org>
---
 arch/x86/pci/acpi.c | 20 +-------------------
 1 file changed, 1 insertion(+), 19 deletions(-)

diff --git a/arch/x86/pci/acpi.c b/arch/x86/pci/acpi.c
index d5086d1..b4e72b5 100644
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

