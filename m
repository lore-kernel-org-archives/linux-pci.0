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
Subject: [PATCH V3 03/21] pci, acpi, mcfg: Provide generic implementation of MCFG code initialization.
Date: Wed, 13 Jan 2016 14:20:49 +0100
Message-Id: <1452691267-32240-4-git-send-email-tn@semihalf.com>
In-Reply-To: <1452691267-32240-1-git-send-email-tn@semihalf.com>
References: <1452691267-32240-1-git-send-email-tn@semihalf.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

First function acpi_mcfg_check_entry() does not apply any quirks by default.

Last two functions are required by ACPI subsystem to make PCI config
space accessible. Generic code assume to do nothing for early init call but
late init call does as follow:
- parse MCFG table and add regions to ECAM resource list
- map regions
- add regions to iomem_resource

Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
Tested-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Tested-by: Jeremy Linton <jeremy.linton@arm.com>
---
 drivers/acpi/mcfg.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/acpi/mcfg.c b/drivers/acpi/mcfg.c
index 5ecef20..fad9917 100644
--- a/drivers/acpi/mcfg.c
+++ b/drivers/acpi/mcfg.c
@@ -57,3 +57,29 @@ int __init acpi_parse_mcfg(struct acpi_table_header *header)
 
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

