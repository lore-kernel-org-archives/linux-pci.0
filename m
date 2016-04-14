Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: iommu@lists.linux-foundation.org
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Tomasz Nowicki <tn@semihalf.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Will Deacon <will.deacon@arm.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	Hanjun Guo <hanjun.guo@linaro.org>,
	Jon Masters <jcm@redhat.com>,
	Sinan Kaya <okaya@codeaurora.org>, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [RFC PATCH 04/11] drivers: acpi: iort: introduce linker section for IORT entries probing
Date: Thu, 14 Apr 2016 18:25:36 +0100
Message-Id: <1460654743-7896-5-git-send-email-lorenzo.pieralisi@arm.com>
In-Reply-To: <1460654743-7896-1-git-send-email-lorenzo.pieralisi@arm.com>
References: <1460654743-7896-1-git-send-email-lorenzo.pieralisi@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Since commit e647b532275b ("ACPI: Add early device probing
infrastructure") the kernel has gained the infrastructure that allows
adding linker script section entries to execute ACPI driver callbacks
(ie probe routines) for all subsystems that register a table entry
in the respective kernel section (eg clocksource, irqchip).

Since ARM IOMMU devices data is described through IORT tables when
booting with ACPI, the ARM IOMMU drivers must be made able to hook ACPI
callback routines that are called to probe IORT entries and initialize
the respective IOMMU devices.

To avoid adding driver specific hooks into IORT table initialization
code (breaking therefore code modularity - ie ACPI IORT code must be made
aware of ARM SMMU drivers ACPI init callbacks), this patch adds code
that allows ARM SMMU drivers to take advantage of the ACPI early probing
infrastructure, so that they can add linker script section entries
containing drivers callback to be executed on IORT tables detection.

Since IORT nodes are differentiated by a type, the callback routines
can easily parse the IORT table entries, check the IORT nodes and
carry out some actions whenever the IORT node type associated with
the driver specific callback is matched.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Tomasz Nowicki <tn@semihalf.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/acpi/iort.c               | 2 ++
 include/asm-generic/vmlinux.lds.h | 1 +
 include/linux/iort.h              | 3 +++
 3 files changed, 6 insertions(+)

diff --git a/drivers/acpi/iort.c b/drivers/acpi/iort.c
index 98db580..080888a 100644
--- a/drivers/acpi/iort.c
+++ b/drivers/acpi/iort.c
@@ -372,6 +372,8 @@ static int __init iort_table_detect(void)
 		return -EINVAL;
 	}
 
+	acpi_probe_device_table(iort);
+
 	return 0;
 }
 arch_initcall(iort_table_detect);
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 339125b..0aae448 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -536,6 +536,7 @@
 	IRQCHIP_OF_MATCH_TABLE()					\
 	ACPI_PROBE_TABLE(irqchip)					\
 	ACPI_PROBE_TABLE(clksrc)					\
+	ACPI_PROBE_TABLE(iort)						\
 	EARLYCON_TABLE()
 
 #define INIT_TEXT							\
diff --git a/include/linux/iort.h b/include/linux/iort.h
index 148d9a1..766adda 100644
--- a/include/linux/iort.h
+++ b/include/linux/iort.h
@@ -31,4 +31,7 @@ struct fwnode_handle *iort_pci_get_domain(struct pci_dev *pdev, u32 req_id);
 int iort_iommu_set_node(struct iommu_ops *ops, struct acpi_iort_node *node,
 			struct fwnode_handle *fwnode);
 
+#define IORT_ACPI_DECLARE(name, table_id, fn)		\
+	ACPI_DECLARE_PROBE_ENTRY(iort, name, table_id, 0, NULL, 0, fn)
+
 #endif /* __IORT_H__ */
-- 
2.6.4

