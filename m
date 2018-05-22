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
Subject: [PATCH 4/5] PCI/AER: Add sysfs attributes for rootport cumulative stats
Date: Tue, 22 May 2018 15:28:04 -0700
Message-Id: <20180522222805.80314-5-rajatja@google.com>
In-Reply-To: <20180522222805.80314-1-rajatja@google.com>
References: <20180522222805.80314-1-rajatja@google.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Add sysfs attributes for rootport statistics (that are cumulative
of all the ERR_* messages seen on this PCI hierarchy).

Signed-off-by: Rajat Jain <rajatja@google.com>
---
 drivers/pci/pcie/aer/aerdrv.h       |  2 ++
 drivers/pci/pcie/aer/aerdrv_core.c  |  2 ++
 drivers/pci/pcie/aer/aerdrv_stats.c | 31 +++++++++++++++++++++++++++++
 3 files changed, 35 insertions(+)

diff --git a/drivers/pci/pcie/aer/aerdrv.h b/drivers/pci/pcie/aer/aerdrv.h
index 048fbd7c9633..77d8355551d9 100644
--- a/drivers/pci/pcie/aer/aerdrv.h
+++ b/drivers/pci/pcie/aer/aerdrv.h
@@ -88,6 +88,8 @@ irqreturn_t aer_irq(int irq, void *context);
 int pci_aer_stats_init(struct pci_dev *pdev);
 void pci_aer_stats_exit(struct pci_dev *pdev);
 void pci_dev_aer_stats_incr(struct pci_dev *pdev, struct aer_err_info *info);
+void pci_rootport_aer_stats_incr(struct pci_dev *pdev,
+				 struct aer_err_source *e_src);
 
 extern const char
 *aer_correctable_error_string[AER_MAX_TYPEOF_CORRECTABLE_ERRS];
diff --git a/drivers/pci/pcie/aer/aerdrv_core.c b/drivers/pci/pcie/aer/aerdrv_core.c
index 42a6f913069a..0f70e22563f3 100644
--- a/drivers/pci/pcie/aer/aerdrv_core.c
+++ b/drivers/pci/pcie/aer/aerdrv_core.c
@@ -424,6 +424,8 @@ static void aer_isr_one_error(struct pcie_device *p_device,
 	struct aer_rpc *rpc = get_service_data(p_device);
 	struct aer_err_info *e_info = &rpc->e_info;
 
+	pci_rootport_aer_stats_incr(p_device->port, e_src);
+
 	/*
 	 * There is a possibility that both correctable error and
 	 * uncorrectable error being logged. Report correctable error first.
diff --git a/drivers/pci/pcie/aer/aerdrv_stats.c b/drivers/pci/pcie/aer/aerdrv_stats.c
index 5f0a6e144f56..a526e26c8683 100644
--- a/drivers/pci/pcie/aer/aerdrv_stats.c
+++ b/drivers/pci/pcie/aer/aerdrv_stats.c
@@ -60,6 +60,9 @@ static DEVICE_ATTR_RO(field)
 aer_stats_aggregate_attr(dev_total_cor_errs);
 aer_stats_aggregate_attr(dev_total_fatal_errs);
 aer_stats_aggregate_attr(dev_total_nonfatal_errs);
+aer_stats_aggregate_attr(rootport_total_cor_errs);
+aer_stats_aggregate_attr(rootport_total_fatal_errs);
+aer_stats_aggregate_attr(rootport_total_nonfatal_errs);
 
 #define aer_stats_breakdown_attr(field, stats_array, strings_array)            \
 	static ssize_t                                                         \
@@ -90,6 +93,9 @@ static struct attribute *aer_stats_attrs[] __ro_after_init = {
 	&dev_attr_dev_total_nonfatal_errs.attr,
 	&dev_attr_dev_breakdown_correctable.attr,
 	&dev_attr_dev_breakdown_uncorrectable.attr,
+	&dev_attr_rootport_total_cor_errs.attr,
+	&dev_attr_rootport_total_fatal_errs.attr,
+	&dev_attr_rootport_total_nonfatal_errs.attr,
 	NULL
 };
 
@@ -102,6 +108,12 @@ static umode_t aer_stats_attrs_are_visible(struct kobject *kobj,
 	if (!pdev->aer_stats)
 		return 0;
 
+	if ((a == &dev_attr_rootport_total_cor_errs.attr ||
+	     a == &dev_attr_rootport_total_fatal_errs.attr ||
+	     a == &dev_attr_rootport_total_nonfatal_errs.attr) &&
+	    pci_pcie_type(pdev) != PCI_EXP_TYPE_ROOT_PORT)
+		return 0;
+
 	return a->mode;
 }
 
@@ -144,6 +156,25 @@ void pci_dev_aer_stats_incr(struct pci_dev *pdev, struct aer_err_info *info)
 			counter[i]++;
 }
 
+void pci_rootport_aer_stats_incr(struct pci_dev *pdev,
+				 struct aer_err_source *e_src)
+{
+	struct aer_stats *aer_stats = pdev->aer_stats;
+
+	if (unlikely(!aer_stats))
+		return;
+
+	if (e_src->status & PCI_ERR_ROOT_COR_RCV)
+		aer_stats->rootport_total_cor_errs++;
+
+	if (e_src->status & PCI_ERR_ROOT_UNCOR_RCV) {
+		if (e_src->status & PCI_ERR_ROOT_FATAL_RCV)
+			aer_stats->rootport_total_fatal_errs++;
+		else
+			aer_stats->rootport_total_nonfatal_errs++;
+	}
+}
+
 int pci_aer_stats_init(struct pci_dev *pdev)
 {
 	pdev->aer_stats = kzalloc(sizeof(struct aer_stats), GFP_KERNEL);
-- 
2.17.0.441.gb46fe60e1d-goog
