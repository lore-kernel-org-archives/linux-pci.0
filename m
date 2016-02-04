Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f53.google.com ([74.125.82.53]:36906 "EHLO
	mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966176AbcBDR33 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 4 Feb 2016 12:29:29 -0500
Received: by mail-wm0-f53.google.com with SMTP id g62so15064913wme.0
        for <linux-pci@vger.kernel.org>; Thu, 04 Feb 2016 09:29:28 -0800 (PST)
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
Subject: [PATCH V4 15/23] acpi, mcfg: Implement two calls that might be used to inject/remove MCFG region.
Date: Thu,  4 Feb 2016 18:28:53 +0100
Message-Id: <1454606941-9523-16-git-send-email-tn@semihalf.com>
In-Reply-To: <1454606941-9523-1-git-send-email-tn@semihalf.com>
References: <1454606941-9523-1-git-send-email-tn@semihalf.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Lets abstract two calls which allow to inject and remove MCFG regions
which may come from DSDT table. These calls will be used for x86 and ARM64
PCI host bridge driver in the later patches.

Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
Tested-by: Duc Dang <dhdang@apm.com>
Tested-by: Dongdong Liu <liudongdong3@huawei.com>
Tested-by: Hanjun Guo <hanjun.guo@linaro.org>
Tested-by: Graeme Gregory <graeme.gregory@linaro.org>
Tested-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/acpi/mcfg.c      | 38 ++++++++++++++++++++++++++++++++++++++
 include/linux/pci-acpi.h |  9 +++++++++
 2 files changed, 47 insertions(+)

diff --git a/drivers/acpi/mcfg.c b/drivers/acpi/mcfg.c
index 3e1e7be..dca4c4e 100644
--- a/drivers/acpi/mcfg.c
+++ b/drivers/acpi/mcfg.c
@@ -10,6 +10,7 @@
 #include <linux/acpi.h>
 #include <linux/ecam.h>
 #include <linux/pci.h>
+#include <linux/pci-acpi.h>
 
 #define	PREFIX	"MCFG: "
 
@@ -77,6 +78,43 @@ int __init acpi_parse_mcfg(struct acpi_table_header *header)
 	return 0;
 }
 
+int pci_mmcfg_setup_map(struct acpi_pci_root_info *ci)
+{
+	struct pci_mmcfg_region *cfg;
+	struct acpi_pci_root *root;
+	int seg, start, end, err;
+
+	root = ci->root;
+	seg = root->segment;
+	start = root->secondary.start;
+	end = root->secondary.end;
+
+	cfg = pci_mmconfig_lookup(seg, start);
+	if (cfg)
+		return 0;
+
+	cfg = pci_mmconfig_alloc(seg, start, end, root->mcfg_addr);
+	if (!cfg)
+		return -ENOMEM;
+
+	err = pci_mmconfig_inject(cfg);
+	return err;
+}
+
+void pci_mmcfg_teardown_map(struct acpi_pci_root_info *ci)
+{
+	struct acpi_pci_root *root = ci->root;
+	struct pci_mmcfg_region *cfg;
+
+	cfg = pci_mmconfig_lookup(root->segment, root->secondary.start);
+	if (!cfg)
+		return;
+
+	if (cfg->hot_added)
+		pci_mmconfig_delete(root->segment, root->secondary.start,
+				    root->secondary.end);
+}
+
 int __init __weak acpi_mcfg_check_entry(struct acpi_table_mcfg *mcfg,
 					struct acpi_mcfg_allocation *cfg)
 {
diff --git a/include/linux/pci-acpi.h b/include/linux/pci-acpi.h
index a72e22d..65b91f3 100644
--- a/include/linux/pci-acpi.h
+++ b/include/linux/pci-acpi.h
@@ -80,6 +80,15 @@ extern struct pci_bus *acpi_pci_root_create(struct acpi_pci_root *root,
 void acpi_pci_add_bus(struct pci_bus *bus);
 void acpi_pci_remove_bus(struct pci_bus *bus);
 
+#ifdef	CONFIG_PCI_MMCONFIG
+int pci_mmcfg_setup_map(struct acpi_pci_root_info *ci);
+void pci_mmcfg_teardown_map(struct acpi_pci_root_info *ci);
+#else
+static inline int pci_mmcfg_setup_map(struct acpi_pci_root_info *ci)
+{ return 0; }
+static inline void pci_mmcfg_teardown_map(struct acpi_pci_root_info *ci) { }
+#endif
+
 #ifdef	CONFIG_ACPI_PCI_SLOT
 void acpi_pci_slot_init(void);
 void acpi_pci_slot_enumerate(struct pci_bus *bus);
-- 
1.9.1

