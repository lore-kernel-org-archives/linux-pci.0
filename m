Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Tomasz Nowicki <tomasz.nowicki@linaro.org>
To: bhelgaas@google.com, wangyijing@huawei.com, arnd@arndb.de,
	hanjun.guo@linaro.org, Liviu.Dudau@arm.com, tglx@linutronix.de,
	mingo@redhat.com, hpa@zytor.com, rjw@rjwysocki.net,
	al.stone@linaro.org, lorenzo.pieralisi@arm.com
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	x86@kernel.org, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, linaro-acpi@lists.linaro.org,
	Tomasz Nowicki <tomasz.nowicki@linaro.org>
Subject: [PATCH v5 5/9] pci, acpi, mcfg: Provide generic implementation of MCFG code initialization.
Date: Fri, 17 Apr 2015 09:14:54 +0200
Message-Id: <1429254898-32743-6-git-send-email-tomasz.nowicki@linaro.org>
In-Reply-To: <1429254898-32743-1-git-send-email-tomasz.nowicki@linaro.org>
References: <1429254898-32743-1-git-send-email-tomasz.nowicki@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

First function acpi_mcfg_check_entry() does not apply any quirks by default.

Last two functions are required by ACPI subsystem to make PCI config
space accessible. Generic code assume to do nothing for early init call but
late init call does as follow:
- parse MCFG table and add regions to ECAM resource list
- map regions
- add regions to iomem_resource

Signed-off-by: Tomasz Nowicki <tomasz.nowicki@linaro.org>
---
 drivers/acpi/mcfg.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/acpi/mcfg.c b/drivers/acpi/mcfg.c
index a9338df9..787defe 100644
--- a/drivers/acpi/mcfg.c
+++ b/drivers/acpi/mcfg.c
@@ -55,3 +55,29 @@ int __init acpi_parse_mcfg(struct acpi_table_header *header)
 
 	return 0;
 }
+
+int __init __weak acpi_mcfg_check_entry(struct acpi_table_mcfg *mcfg,
+					struct acpi_mcfg_allocation *cfg)
+{
+	return 0;
+}
+
+void __init __weak pci_mmcfg_early_init(void)
+{
+
+}
+
+void __init __weak pci_mmcfg_late_init(void)
+{
+	struct pci_mmcfg_region *cfg;
+
+	acpi_table_parse(ACPI_SIG_MCFG, acpi_parse_mcfg);
+
+	if (list_empty(&pci_mmcfg_list))
+		return;
+	if (!pci_mmcfg_arch_init())
+		free_all_mmcfg();
+
+	list_for_each_entry(cfg, &pci_mmcfg_list, list)
+		insert_resource(&iomem_resource, &cfg->res);
+}
-- 
1.9.1

