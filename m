Return-Path: <linux-kernel-owner@vger.kernel.org>
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
Subject: [PATCH V4 17/23] acpi, mcfg: Add default PCI config accessors implementation and initial support for related quirks.
Date: Thu,  4 Feb 2016 18:28:55 +0100
Message-Id: <1454606941-9523-18-git-send-email-tn@semihalf.com>
In-Reply-To: <1454606941-9523-1-git-send-email-tn@semihalf.com>
References: <1454606941-9523-1-git-send-email-tn@semihalf.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

We use generic accessors from access.c by default. However, we already
know platforms that need special handling while accessing to PCI config
space. These platforms will need different accessors set matched against
platform ID, domain, bus touple. Therefore we are going to add (in future)
DECLARE_ACPI_MCFG_FIXUP which will register platform specific custom
accessors. For now, we let pci_mcfg_get_ops to take acpi_pci_root structure
as an arguments and left some space for quirk matching algorithm.

Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
Tested-by: Duc Dang <dhdang@apm.com>
Tested-by: Dongdong Liu <liudongdong3@huawei.com>
Tested-by: Hanjun Guo <hanjun.guo@linaro.org>
Tested-by: Graeme Gregory <graeme.gregory@linaro.org>
Tested-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/acpi/mcfg.c      | 30 ++++++++++++++++++++++++++++++
 include/linux/pci-acpi.h |  8 ++++++++
 2 files changed, 38 insertions(+)

diff --git a/drivers/acpi/mcfg.c b/drivers/acpi/mcfg.c
index dca4c4e..dfc2d14 100644
--- a/drivers/acpi/mcfg.c
+++ b/drivers/acpi/mcfg.c
@@ -34,6 +34,36 @@ int __weak raw_pci_write(unsigned int domain, unsigned int bus,
 	return PCIBIOS_DEVICE_NOT_FOUND;
 }
 
+void __iomem *
+pci_mcfg_dev_base(struct pci_bus *bus, unsigned int devfn, int offset)
+{
+	struct pci_mmcfg_region *cfg;
+
+	cfg = pci_mmconfig_lookup(pci_domain_nr(bus), bus->number);
+	if (cfg && cfg->virt)
+		return cfg->virt +
+			(PCI_MMCFG_BUS_OFFSET(bus->number) | (devfn << 12)) +
+			offset;
+	return NULL;
+}
+
+/* Default generic PCI config accessors */
+static struct pci_ops default_pci_mcfg_ops = {
+	.map_bus = pci_mcfg_dev_base,
+	.read = pci_generic_config_read,
+	.write = pci_generic_config_write,
+};
+
+struct pci_ops *pci_mcfg_get_ops(struct acpi_pci_root *root)
+{
+	/*
+	 * TODO: Match against platform specific quirks and return
+	 * corresponding PCI config space accessor set.
+	 */
+
+	return &default_pci_mcfg_ops;
+}
+
 int __init acpi_parse_mcfg(struct acpi_table_header *header)
 {
 	struct acpi_table_mcfg *mcfg;
diff --git a/include/linux/pci-acpi.h b/include/linux/pci-acpi.h
index 65b91f3..c974586 100644
--- a/include/linux/pci-acpi.h
+++ b/include/linux/pci-acpi.h
@@ -83,10 +83,18 @@ void acpi_pci_remove_bus(struct pci_bus *bus);
 #ifdef	CONFIG_PCI_MMCONFIG
 int pci_mmcfg_setup_map(struct acpi_pci_root_info *ci);
 void pci_mmcfg_teardown_map(struct acpi_pci_root_info *ci);
+struct pci_ops *pci_mcfg_get_ops(struct acpi_pci_root *root);
+void __iomem *
+pci_mcfg_dev_base(struct pci_bus *bus, unsigned int devfn, int offset);
 #else
 static inline int pci_mmcfg_setup_map(struct acpi_pci_root_info *ci)
 { return 0; }
 static inline void pci_mmcfg_teardown_map(struct acpi_pci_root_info *ci) { }
+static inline struct pci_ops *pci_mcfg_get_ops(struct acpi_pci_root *root)
+{ return NULL; }
+static inline void __iomem *
+pci_mcfg_dev_base(struct pci_bus *bus, unsigned int devfn, int offset)
+{ return NULL; }
 #endif
 
 #ifdef	CONFIG_ACPI_PCI_SLOT
-- 
1.9.1
