Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pl0-f68.google.com ([209.85.160.68]:33655 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753298AbeEVW2Y (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 22 May 2018 18:28:24 -0400
Received: by mail-pl0-f68.google.com with SMTP id n10-v6so11741616plp.0
        for <linux-pci@vger.kernel.org>; Tue, 22 May 2018 15:28:24 -0700 (PDT)
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
Cc: rajatxjain@gmail.com, Rajat Jain <rajatj@google.com>
Subject: [PATCH 3/5] PCP/AER: Add sysfs attributes to provide breakdown of AERs
Date: Tue, 22 May 2018 15:28:03 -0700
Message-Id: <20180522222805.80314-4-rajatja@google.com>
In-Reply-To: <20180522222805.80314-1-rajatja@google.com>
References: <20180522222805.80314-1-rajatja@google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Add sysfs attributes to provide breakdown of the AERs seen,
into different type of correctable or uncorrectable errors:

dev_breakdown_correctable
dev_breakdown_uncorrectable

Signed-off-by: Rajat Jain <rajatj@google.com>
---
 drivers/pci/pcie/aer/aerdrv.h          |  6 ++++++
 drivers/pci/pcie/aer/aerdrv_errprint.c |  6 ++++--
 drivers/pci/pcie/aer/aerdrv_stats.c    | 25 +++++++++++++++++++++++++
 3 files changed, 35 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pcie/aer/aerdrv.h b/drivers/pci/pcie/aer/aerdrv.h
index b5d5ad6f2c03..048fbd7c9633 100644
--- a/drivers/pci/pcie/aer/aerdrv.h
+++ b/drivers/pci/pcie/aer/aerdrv.h
@@ -89,6 +89,12 @@ int pci_aer_stats_init(struct pci_dev *pdev);
 void pci_aer_stats_exit(struct pci_dev *pdev);
 void pci_dev_aer_stats_incr(struct pci_dev *pdev, struct aer_err_info *info);
 
+extern const char
+*aer_correctable_error_string[AER_MAX_TYPEOF_CORRECTABLE_ERRS];
+
+extern const char
+*aer_uncorrectable_error_string[AER_MAX_TYPEOF_UNCORRECTABLE_ERRS];
+
 #ifdef CONFIG_ACPI_APEI
 int pcie_aer_get_firmware_first(struct pci_dev *pci_dev);
 #else
diff --git a/drivers/pci/pcie/aer/aerdrv_errprint.c b/drivers/pci/pcie/aer/aerdrv_errprint.c
index 5e8b98deda08..5585f309f1a8 100644
--- a/drivers/pci/pcie/aer/aerdrv_errprint.c
+++ b/drivers/pci/pcie/aer/aerdrv_errprint.c
@@ -68,7 +68,8 @@ static const char *aer_error_layer[] = {
 	"Transaction Layer"
 };
 
-static const char *aer_correctable_error_string[] = {
+const char
+*aer_correctable_error_string[AER_MAX_TYPEOF_CORRECTABLE_ERRS] = {
 	"Receiver Error",		/* Bit Position 0	*/
 	NULL,
 	NULL,
@@ -87,7 +88,8 @@ static const char *aer_correctable_error_string[] = {
 	"Header Log Overflow",		/* Bit Position 15	*/
 };
 
-static const char *aer_uncorrectable_error_string[] = {
+const char
+*aer_uncorrectable_error_string[AER_MAX_TYPEOF_UNCORRECTABLE_ERRS] = {
 	"Undefined",			/* Bit Position 0	*/
 	NULL,
 	NULL,
diff --git a/drivers/pci/pcie/aer/aerdrv_stats.c b/drivers/pci/pcie/aer/aerdrv_stats.c
index 87b7119d0a86..5f0a6e144f56 100644
--- a/drivers/pci/pcie/aer/aerdrv_stats.c
+++ b/drivers/pci/pcie/aer/aerdrv_stats.c
@@ -61,10 +61,35 @@ aer_stats_aggregate_attr(dev_total_cor_errs);
 aer_stats_aggregate_attr(dev_total_fatal_errs);
 aer_stats_aggregate_attr(dev_total_nonfatal_errs);
 
+#define aer_stats_breakdown_attr(field, stats_array, strings_array)            \
+	static ssize_t                                                         \
+	field##_show(struct device *dev, struct device_attribute *attr,        \
+		     char *buf)                                                \
+{                                                                              \
+	unsigned int i;                                                        \
+	char *str = buf;                                                       \
+	struct pci_dev *pdev = to_pci_dev(dev);                                \
+	u64 *stats = pdev->aer_stats->stats_array;                             \
+	for (i = 0; i < ARRAY_SIZE(strings_array); i++) {                      \
+		if (strings_array[i])                                          \
+			str += sprintf(str, "%s = 0x%llx\n",                   \
+				       strings_array[i], stats[i]);            \
+	}                                                                      \
+	return str-buf;                                                        \
+}                                                                              \
+static DEVICE_ATTR_RO(field)
+
+aer_stats_breakdown_attr(dev_breakdown_correctable, dev_cor_errs,
+			 aer_correctable_error_string);
+aer_stats_breakdown_attr(dev_breakdown_uncorrectable, dev_uncor_errs,
+			 aer_uncorrectable_error_string);
+
 static struct attribute *aer_stats_attrs[] __ro_after_init = {
 	&dev_attr_dev_total_cor_errs.attr,
 	&dev_attr_dev_total_fatal_errs.attr,
 	&dev_attr_dev_total_nonfatal_errs.attr,
+	&dev_attr_dev_breakdown_correctable.attr,
+	&dev_attr_dev_breakdown_uncorrectable.attr,
 	NULL
 };
 
-- 
2.17.0.441.gb46fe60e1d-goog
