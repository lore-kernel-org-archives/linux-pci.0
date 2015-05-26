Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Hanjun Guo <hanjun.guo@linaro.org>
To: Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will.deacon@arm.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Jiang Liu <jiang.liu@linux.intel.com>,
	Liviu Dudau <Liviu.Dudau@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Yijing Wang <wangyijing@huawei.com>,
	Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
	Tomasz Nowicki <tomasz.nowicki@linaro.org>,
	Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
	Mark Salter <msalter@redhat.com>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org,
	Hanjun Guo <hanjun.guo@linaro.org>
Subject: [PATCH 06/11] pci, acpi, mcfg: Provide generic implementation of MCFG code initialization.
Date: Tue, 26 May 2015 20:49:19 +0800
Message-Id: <1432644564-24746-7-git-send-email-hanjun.guo@linaro.org>
In-Reply-To: <1432644564-24746-1-git-send-email-hanjun.guo@linaro.org>
References: <1432644564-24746-1-git-send-email-hanjun.guo@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Tomasz Nowicki <tomasz.nowicki@linaro.org>

First function acpi_mcfg_check_entry() does not apply any quirks by default.

Last two functions are required by ACPI subsystem to make PCI config
space accessible. Generic code assume to do nothing for early init call but
late init call does as follow:
- parse MCFG table and add regions to ECAM resource list
- map regions
- add regions to iomem_resource

Signed-off-by: Tomasz Nowicki <tomasz.nowicki@linaro.org>
Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
Tested-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
---
 drivers/acpi/mcfg.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/acpi/mcfg.c b/drivers/acpi/mcfg.c
index 63775af..745b83e 100644
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

