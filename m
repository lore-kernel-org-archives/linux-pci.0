Return-Path: <SRS0=ZA3X=JG=flex--rajatja.bounces.google.com=386kpWwcKB8w9s1sB1sy66y3w.u64zw3yssA2w95w3.69y@kernel.org>
Return-Path: <SRS0=ZA3X=JG=flex--rajatja.bounces.google.com=386kpWwcKB8w9s1sB1sy66y3w.u64zw3yssA2w95w3.69y@kernel.org>
MIME-Version: 1.0
Date: Tue, 19 Jun 2018 18:12:07 -0700
In-Reply-To: <20180620011210.254601-1-rajatja@google.com>
Message-Id: <20180620011210.254601-2-rajatja@google.com>
References: <20180619221651.GH33049@bhelgaas-glaptop.roam.corp.google.com> <20180620011210.254601-1-rajatja@google.com>
Subject: [PATCH v3 2/5] PCI/AER: Add sysfs stats for AER capable devices
From: Rajat Jain <rajatja@google.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Jonathan Corbet <corbet@lwn.net>,
	Philippe Ombredanne <pombredanne@nexb.com>, Kate Stewart <kstewart@linuxfoundation.org>,
	Thomas Gleixner <tglx@linutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Frederick Lawler <fred@fredlawl.com>, Oza Pawandeep <poza@codeaurora.org>,
	Keith Busch <keith.busch@intel.com>, Alexandru Gagniuc <mr.nuke.me@gmail.com>,
	Thomas Tai <thomas.tai@oracle.com>, "Steven Rostedt (VMware)" <rostedt@goodmis.org>, linux-pci@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jes Sorensen <jsorensen@fb.com>, Kyle McMartin <jkkm@fb.com>, rajatxjain@gmail.com, helgaas@kernel.org
Cc: Rajat Jain <rajatja@google.com>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-pci.vger.kernel.org>

Add the following AER sysfs stats to represent the counters for each
kind of error as seen by the device:

dev_total_cor_errs
dev_total_fatal_errs
dev_total_nonfatal_errs

Signed-off-by: Rajat Jain <rajatja@google.com>
---
v3: Merge everything in aer.c, use "%llu" in place of "%llx"

 drivers/pci/pci-sysfs.c |  3 ++
 drivers/pci/pci.h       |  4 ++-
 drivers/pci/pcie/aer.c  | 74 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 80 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 0c4653c1d2ce..9f1cb9051d7d 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -1746,6 +1746,9 @@ static const struct attribute_group *pci_dev_attr_groups[] = {
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
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index f9fa994b6c33..ce0d675d7bd3 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -573,6 +573,79 @@ static const char *aer_agent_string[] = {
 	"Transmitter ID"
 };
 
+#define aer_stats_aggregate_attr(field)					\
+	static ssize_t							\
+	field##_show(struct device *dev, struct device_attribute *attr,	\
+		     char *buf)						\
+{									\
+	struct pci_dev *pdev = to_pci_dev(dev);				\
+	return sprintf(buf, "%llu\n", pdev->aer_stats->field);		\
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
+static void pci_dev_aer_stats_incr(struct pci_dev *pdev,
+				   struct aer_err_info *info)
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
 static void __print_tlp_header(struct pci_dev *dev,
 			       struct aer_header_log_regs *t)
 {
@@ -605,6 +678,7 @@ static void __aer_print_error(struct pci_dev *dev,
 			pci_err(dev, "   [%2d] Unknown Error Bit%s\n",
 				i, info->first_error == i ? " (First)" : "");
 	}
+	pci_dev_aer_stats_incr(dev, info);
 }
 
 static void aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
-- 
2.18.0.rc1.244.gcf134e6275-goog
