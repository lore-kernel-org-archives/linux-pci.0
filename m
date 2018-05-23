Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Rajat Jain <rajatja@google.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rajat Jain <rajatja@google.com>,
        Frederick Lawler <fred@fredlawl.com>,
        Oza Pawandeep <poza@codeaurora.org>,
        Keith Busch <keith.busch@intel.com>,
        Gabriele Paoloni <gabriele.paoloni@huawei.com>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        Thomas Tai <thomas.tai@oracle.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jes Sorensen <jsorensen@fb.com>,
        Kyle McMartin <jkkm@fb.com>
Cc: rajatxjain@gmail.com
Subject: [PATCH v2 2/5] PCI/AER: Add sysfs stats for AER capable devices
Date: Wed, 23 May 2018 10:58:05 -0700
Message-Id: <20180523175808.28030-3-rajatja@google.com>
In-Reply-To: <20180523175808.28030-1-rajatja@google.com>
References: <20180522222805.80314-1-rajatja@google.com>
 <20180523175808.28030-1-rajatja@google.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Add the following AER sysfs stats to represent the counters for each
kind of error as seen by the device:

dev_total_cor_errs
dev_total_fatal_errs
dev_total_nonfatal_errs

Signed-off-by: Rajat Jain <rajatja@google.com>
---
v2: Use tabs instead of spaces at the end of macro lines, and remove
    the use of unlikely() as per Greg's suggestion.

 drivers/pci/pci-sysfs.c                |  3 ++
 drivers/pci/pci.h                      |  4 +-
 drivers/pci/pcie/aer/aerdrv.h          |  1 +
 drivers/pci/pcie/aer/aerdrv_errprint.c |  1 +
 drivers/pci/pcie/aer/aerdrv_stats.c    | 72 ++++++++++++++++++++++++++
 5 files changed, 80 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 366d93af051d..730f985a3dc9 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -1743,6 +1743,9 @@ static const struct attribute_group *pci_dev_attr_groups[] = {
 #endif
 	&pci_bridge_attr_group,
 	&pcie_dev_attr_group,
+#ifdef CONFIG_PCIEAER
+	&aer_stats_attr_group,
+#endif
 	NULL,
 };
 
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index c358e7a07f3f..9a28ec600225 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -181,7 +181,9 @@ extern const struct attribute_group *pci_dev_groups[];
 extern const struct attribute_group *pcibus_groups[];
 extern const struct device_type pci_dev_type;
 extern const struct attribute_group *pci_bus_groups[];
-
+#ifdef CONFIG_PCIEAER
+extern const struct attribute_group aer_stats_attr_group;
+#endif
 
 /**
  * pci_match_one_device - Tell if a PCI device structure has a matching
diff --git a/drivers/pci/pcie/aer/aerdrv.h b/drivers/pci/pcie/aer/aerdrv.h
index d8b9fba536ed..b5d5ad6f2c03 100644
--- a/drivers/pci/pcie/aer/aerdrv.h
+++ b/drivers/pci/pcie/aer/aerdrv.h
@@ -87,6 +87,7 @@ void aer_print_port_info(struct pci_dev *dev, struct aer_err_info *info);
 irqreturn_t aer_irq(int irq, void *context);
 int pci_aer_stats_init(struct pci_dev *pdev);
 void pci_aer_stats_exit(struct pci_dev *pdev);
+void pci_dev_aer_stats_incr(struct pci_dev *pdev, struct aer_err_info *info);
 
 #ifdef CONFIG_ACPI_APEI
 int pcie_aer_get_firmware_first(struct pci_dev *pci_dev);
diff --git a/drivers/pci/pcie/aer/aerdrv_errprint.c b/drivers/pci/pcie/aer/aerdrv_errprint.c
index 21ca5e1b0ded..5e8b98deda08 100644
--- a/drivers/pci/pcie/aer/aerdrv_errprint.c
+++ b/drivers/pci/pcie/aer/aerdrv_errprint.c
@@ -155,6 +155,7 @@ static void __aer_print_error(struct pci_dev *dev,
 			pci_err(dev, "   [%2d] Unknown Error Bit%s\n",
 				i, info->first_error == i ? " (First)" : "");
 	}
+	pci_dev_aer_stats_incr(dev, info);
 }
 
 void aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
diff --git a/drivers/pci/pcie/aer/aerdrv_stats.c b/drivers/pci/pcie/aer/aerdrv_stats.c
index 2f48d6bc81f1..5555beffef2b 100644
--- a/drivers/pci/pcie/aer/aerdrv_stats.c
+++ b/drivers/pci/pcie/aer/aerdrv_stats.c
@@ -44,6 +44,78 @@ struct aer_stats {
 	u64 rootport_total_nonfatal_errs;
 };
 
+#define aer_stats_aggregate_attr(field)					\
+	static ssize_t							\
+	field##_show(struct device *dev, struct device_attribute *attr,	\
+		     char *buf)						\
+{									\
+	struct pci_dev *pdev = to_pci_dev(dev);				\
+	return sprintf(buf, "0x%llx\n", pdev->aer_stats->field);	\
+}									\
+static DEVICE_ATTR_RO(field)
+
+aer_stats_aggregate_attr(dev_total_cor_errs);
+aer_stats_aggregate_attr(dev_total_fatal_errs);
+aer_stats_aggregate_attr(dev_total_nonfatal_errs);
+
+static struct attribute *aer_stats_attrs[] __ro_after_init = {
+	&dev_attr_dev_total_cor_errs.attr,
+	&dev_attr_dev_total_fatal_errs.attr,
+	&dev_attr_dev_total_nonfatal_errs.attr,
+	NULL
+};
+
+static umode_t aer_stats_attrs_are_visible(struct kobject *kobj,
+					   struct attribute *a, int n)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct pci_dev *pdev = to_pci_dev(dev);
+
+	if (!pdev->aer_stats)
+		return 0;
+
+	return a->mode;
+}
+
+const struct attribute_group aer_stats_attr_group = {
+	.name  = "aer_stats",
+	.attrs  = aer_stats_attrs,
+	.is_visible = aer_stats_attrs_are_visible,
+};
+
+void pci_dev_aer_stats_incr(struct pci_dev *pdev, struct aer_err_info *info)
+{
+	int status, i, max = -1;
+	u64 *counter = NULL;
+	struct aer_stats *aer_stats = pdev->aer_stats;
+
+	if (!aer_stats)
+		return;
+
+	switch (info->severity) {
+	case AER_CORRECTABLE:
+		aer_stats->dev_total_cor_errs++;
+		counter = &aer_stats->dev_cor_errs[0];
+		max = AER_MAX_TYPEOF_CORRECTABLE_ERRS;
+		break;
+	case AER_NONFATAL:
+		aer_stats->dev_total_nonfatal_errs++;
+		counter = &aer_stats->dev_uncor_errs[0];
+		max = AER_MAX_TYPEOF_UNCORRECTABLE_ERRS;
+		break;
+	case AER_FATAL:
+		aer_stats->dev_total_fatal_errs++;
+		counter = &aer_stats->dev_uncor_errs[0];
+		max = AER_MAX_TYPEOF_UNCORRECTABLE_ERRS;
+		break;
+	}
+
+	status = (info->status & ~info->mask);
+	for (i = 0; i < max; i++)
+		if (status & (1 << i))
+			counter[i]++;
+}
+
 int pci_aer_stats_init(struct pci_dev *pdev)
 {
 	pdev->aer_stats = kzalloc(sizeof(struct aer_stats), GFP_KERNEL);
-- 
2.17.0.441.gb46fe60e1d-goog
