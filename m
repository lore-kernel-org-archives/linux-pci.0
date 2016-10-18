Return-Path: <linux-kernel-owner@vger.kernel.org>
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
        Eric Auger <eric.auger@redhat.com>,
        Sinan Kaya <okaya@codeaurora.org>,
        Nate Watterson <nwatters@codeaurora.org>,
        Prem Mallappa <prem.mallappa@broadcom.com>,
        Dennis Chen <dennis.chen@arm.com>, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v6 02/16] drivers: acpi: iort: introduce linker section for IORT entries probing
Date: Tue, 18 Oct 2016 17:04:00 +0100
Message-Id: <20161018160414.1228-3-lorenzo.pieralisi@arm.com>
In-Reply-To: <20161018160414.1228-1-lorenzo.pieralisi@arm.com>
References: <20161018160414.1228-1-lorenzo.pieralisi@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
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
Reviewed-by: Hanjun Guo <hanjun.guo@linaro.org>
Cc: Tomasz Nowicki <tn@semihalf.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/acpi/arm64/iort.c         | 3 +++
 include/asm-generic/vmlinux.lds.h | 1 +
 include/linux/acpi_iort.h         | 3 +++
 3 files changed, 7 insertions(+)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index 6b81746..6b51ca7 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -364,5 +364,8 @@ void __init acpi_iort_init(void)
 	if (ACPI_FAILURE(status) && status != AE_NOT_FOUND) {
 		const char *msg = acpi_format_exception(status);
 		pr_err("Failed to get table, %s\n", msg);
+		return;
 	}
+
+	acpi_probe_device_table(iort);
 }
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 3074796..f9c9f3c 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -563,6 +563,7 @@
 	IRQCHIP_OF_MATCH_TABLE()					\
 	ACPI_PROBE_TABLE(irqchip)					\
 	ACPI_PROBE_TABLE(clksrc)					\
+	ACPI_PROBE_TABLE(iort)						\
 	EARLYCON_TABLE()
 
 #define INIT_TEXT							\
diff --git a/include/linux/acpi_iort.h b/include/linux/acpi_iort.h
index 0e32dac..d16fdda 100644
--- a/include/linux/acpi_iort.h
+++ b/include/linux/acpi_iort.h
@@ -39,4 +39,7 @@ static inline struct irq_domain *iort_get_device_domain(struct device *dev,
 { return NULL; }
 #endif
 
+#define IORT_ACPI_DECLARE(name, table_id, fn)		\
+	ACPI_DECLARE_PROBE_ENTRY(iort, name, table_id, 0, NULL, 0, fn)
+
 #endif /* __ACPI_IORT_H__ */
-- 
2.10.0
