Return-Path: <SRS0=Jsdd=JG=flex--rajatja.bounces.google.com=3-KkpWwcKB9EEx6xG6x3BB381.zB94183xxF71EA18.BE3@kernel.org>
Return-Path: <SRS0=Jsdd=JG=flex--rajatja.bounces.google.com=3-KkpWwcKB9EEx6xG6x3BB381.zB94183xxF71EA18.BE3@kernel.org>
MIME-Version: 1.0
Date: Tue, 19 Jun 2018 18:12:08 -0700
In-Reply-To: <20180620011210.254601-1-rajatja@google.com>
Message-Id: <20180620011210.254601-3-rajatja@google.com>
References: <20180619221651.GH33049@bhelgaas-glaptop.roam.corp.google.com> <20180620011210.254601-1-rajatja@google.com>
Subject: [PATCH v3 3/5] PCI/AER: Add sysfs attributes to provide breakdown of AERs
From: Rajat Jain <rajatja@google.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Jonathan Corbet <corbet@lwn.net>,
	Philippe Ombredanne <pombredanne@nexb.com>, Kate Stewart <kstewart@linuxfoundation.org>,
	Thomas Gleixner <tglx@linutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Frederick Lawler <fred@fredlawl.com>, Oza Pawandeep <poza@codeaurora.org>,
	Keith Busch <keith.busch@intel.com>, Alexandru Gagniuc <mr.nuke.me@gmail.com>,
	Thomas Tai <thomas.tai@oracle.com>, "Steven Rostedt (VMware)" <rostedt@goodmis.org>, linux-pci@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jes Sorensen <jsorensen@fb.com>, Kyle McMartin <jkkm@fb.com>, rajatxjain@gmail.com, helgaas@kernel.org
Cc: Rajat Jain <rajatja@google.com>, Rajat Jain <rajatj@google.com>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-pci.vger.kernel.org>

Add sysfs attributes to provide breakdown of the AERs seen,
into different type of correctable or uncorrectable errors:

dev_breakdown_correctable
dev_breakdown_uncorrectable

Signed-off-by: Rajat Jain <rajatj@google.com>
---
v3: Merge everything in aer.c, use "%llu" in place of "%llx"

 drivers/pci/pcie/aer.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index ce0d675d7bd3..876f03799810 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -587,10 +587,38 @@ aer_stats_aggregate_attr(dev_total_cor_errs);
 aer_stats_aggregate_attr(dev_total_fatal_errs);
 aer_stats_aggregate_attr(dev_total_nonfatal_errs);
 
+#define aer_stats_breakdown_attr(field, stats_array, strings_array)	\
+	static ssize_t							\
+	field##_show(struct device *dev, struct device_attribute *attr,	\
+		     char *buf)						\
+{									\
+	unsigned int i;							\
+	char *str = buf;						\
+	struct pci_dev *pdev = to_pci_dev(dev);				\
+	u64 *stats = pdev->aer_stats->stats_array;			\
+	for (i = 0; i < ARRAY_SIZE(strings_array); i++) {		\
+		if (strings_array[i])					\
+			str += sprintf(str, "%s = 0x%llx\n",		\
+				       strings_array[i], stats[i]);	\
+		else if (stats[i])					\
+			str += sprintf(str, #stats_array "bit[%d] = 0x%llx\n",\
+				       i, stats[i]);			\
+	}								\
+	return str-buf;							\
+}									\
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
2.18.0.rc1.244.gcf134e6275-goog
