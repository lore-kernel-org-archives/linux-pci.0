Return-Path: <SRS0=U+kY=JH=flex--rajatja.bounces.google.com=3cjksWwcKB3UkTcTmcTZhhZeX.VhfaXeZTTldXkgXe.hkZ@kernel.org>
Return-Path: <SRS0=U+kY=JH=flex--rajatja.bounces.google.com=3cjksWwcKB3UkTcTmcTZhhZeX.VhfaXeZTTldXkgXe.hkZ@kernel.org>
MIME-Version: 1.0
Date: Thu, 21 Jun 2018 16:48:29 -0700
In-Reply-To: <20180621234829.224566-1-rajatja@google.com>
Message-Id: <20180621234829.224566-5-rajatja@google.com>
References: <20180621234829.224566-1-rajatja@google.com>
Subject: [PATCH 4/4] PCI/AER: Add sysfs attributes for rootport cumulative stats
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

Add sysfs attributes for rootport statistics (that are cumulative
of all the ERR_* messages seen on this PCI hierarchy).

Signed-off-by: Rajat Jain <rajatja@google.com>
---
 .../testing/sysfs-bus-pci-devices-aer_stats   | 28 +++++++++++
 drivers/pci/pcie/aer.c                        | 47 +++++++++++++++++++
 2 files changed, 75 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-pci-devices-aer_stats b/Documentation/ABI/testing/sysfs-bus-pci-devices-aer_stats
index 7dd54bdf910b..3fec94c8e6e2 100644
--- a/Documentation/ABI/testing/sysfs-bus-pci-devices-aer_stats
+++ b/Documentation/ABI/testing/sysfs-bus-pci-devices-aer_stats
@@ -92,3 +92,31 @@ AtomicOp Egress Blocked 0
 TLP Prefix Blocked Error 0
 TOTAL_ERR_NONFATAL 0
 -------------------------------------------------------------------------
+
+============================
+PCIe Rootport AER statistics
+============================
+These attributes show up under only the rootports (or root complex event
+collectors) that are AER capable. These indicate the number of error messages as
+"reported to" the rootport. Please note that the rootports also transmit
+(internally) the ERR_* messages for errors seen by the internal rootport PCI
+device, so these counters includes them and are thus cumulative of all the error
+messages on the PCI hierarchy originating at that root port.
+
+Where:		/sys/bus/pci/devices/<dev>/aer_stats/aer_rootport_total_err_cor
+Date:		July 2018
+Kernel Version: 4.19.0
+Contact:	linux-pci@vger.kernel.org, rajatja@google.com
+Description:	Total number of ERR_COR messages reported to rootport.
+
+Where:	    /sys/bus/pci/devices/<dev>/aer_stats/aer_rootport_total_err_fatal
+Date:		July 2018
+Kernel Version: 4.19.0
+Contact:	linux-pci@vger.kernel.org, rajatja@google.com
+Description:	Total number of ERR_FATAL messages reported to rootport.
+
+Where:	    /sys/bus/pci/devices/<dev>/aer_stats/aer_rootport_total_err_nonfatal
+Date:		July 2018
+Kernel Version: 4.19.0
+Contact:	linux-pci@vger.kernel.org, rajatja@google.com
+Description:	Total number of ERR_NONFATAL messages reported to rootport.
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 15c6ae4b9754..6801cde534d5 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -597,10 +597,30 @@ aer_stats_dev_attr(aer_dev_nonfatal, dev_nonfatal_errs,
 		   aer_uncorrectable_error_string, "ERR_NONFATAL",
 		   dev_total_nonfatal_errs);
 
+#define aer_stats_rootport_attr(name, field)				\
+	static ssize_t							\
+	name##_show(struct device *dev, struct device_attribute *attr,	\
+		     char *buf)						\
+{									\
+	struct pci_dev *pdev = to_pci_dev(dev);				\
+	return sprintf(buf, "%llu\n", pdev->aer_stats->field);		\
+}									\
+static DEVICE_ATTR_RO(name)
+
+aer_stats_rootport_attr(aer_rootport_total_err_cor,
+			 rootport_total_cor_errs);
+aer_stats_rootport_attr(aer_rootport_total_err_fatal,
+			 rootport_total_fatal_errs);
+aer_stats_rootport_attr(aer_rootport_total_err_nonfatal,
+			 rootport_total_nonfatal_errs);
+
 static struct attribute *aer_stats_attrs[] __ro_after_init = {
 	&dev_attr_aer_dev_correctable.attr,
 	&dev_attr_aer_dev_fatal.attr,
 	&dev_attr_aer_dev_nonfatal.attr,
+	&dev_attr_aer_rootport_total_err_cor.attr,
+	&dev_attr_aer_rootport_total_err_fatal.attr,
+	&dev_attr_aer_rootport_total_err_nonfatal.attr,
 	NULL
 };
 
@@ -613,6 +633,12 @@ static umode_t aer_stats_attrs_are_visible(struct kobject *kobj,
 	if (!pdev->aer_stats)
 		return 0;
 
+	if ((a == &dev_attr_aer_rootport_total_err_cor.attr ||
+	     a == &dev_attr_aer_rootport_total_err_fatal.attr ||
+	     a == &dev_attr_aer_rootport_total_err_nonfatal.attr) &&
+	    pci_pcie_type(pdev) != PCI_EXP_TYPE_ROOT_PORT)
+		return 0;
+
 	return a->mode;
 }
 
@@ -655,6 +681,25 @@ static void pci_dev_aer_stats_incr(struct pci_dev *pdev,
 			counter[i]++;
 }
 
+static void pci_rootport_aer_stats_incr(struct pci_dev *pdev,
+				 struct aer_err_source *e_src)
+{
+	struct aer_stats *aer_stats = pdev->aer_stats;
+
+	if (!aer_stats)
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
 static void __print_tlp_header(struct pci_dev *dev,
 			       struct aer_header_log_regs *t)
 {
@@ -1105,6 +1150,8 @@ static void aer_isr_one_error(struct aer_rpc *rpc,
 	struct pci_dev *pdev = rpc->rpd;
 	struct aer_err_info *e_info = &rpc->e_info;
 
+	pci_rootport_aer_stats_incr(pdev, e_src);
+
 	/*
 	 * There is a possibility that both correctable error and
 	 * uncorrectable error being logged. Report correctable error first.
-- 
2.18.0.rc2.346.g013aa6912e-goog
