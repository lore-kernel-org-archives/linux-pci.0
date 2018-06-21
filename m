Return-Path: <SRS0=XZs8=JH=flex--rajatja.bounces.google.com=3XDksWwcKB18O7G7QG7DLLDIB.9LJEBID77PHBOKBI.LOD@kernel.org>
Return-Path: <SRS0=XZs8=JH=flex--rajatja.bounces.google.com=3XDksWwcKB18O7G7QG7DLLDIB.9LJEBID77PHBOKBI.LOD@kernel.org>
MIME-Version: 1.0
Date: Thu, 21 Jun 2018 16:48:27 -0700
In-Reply-To: <20180621234829.224566-1-rajatja@google.com>
Message-Id: <20180621234829.224566-3-rajatja@google.com>
References: <20180621234829.224566-1-rajatja@google.com>
Subject: [PATCH 2/4] PCI/AER: Define and allocate aer_stats structure for AER
 capable devices
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

Define a structure to hold the AER statistics. There are 2 groups
of statistics: dev_* counters that are to be collected for all AER
capable devices and rootport_* counters that are collected for all
(AER capable) rootports only. Allocate and free this structure when
device is added or released (thus counters survive the lifetime of the
device).

Signed-off-by: Rajat Jain <rajatja@google.com>
---
 drivers/pci/pci.h      |  2 ++
 drivers/pci/pcie/aer.c | 53 ++++++++++++++++++++++++++++++++++++++++--
 drivers/pci/probe.c    |  1 +
 include/linux/pci.h    |  1 +
 4 files changed, 55 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 9a1af85aca77..0759a7be9ef2 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -455,9 +455,11 @@ static inline int devm_of_pci_get_host_bridge_resources(struct device *dev,
 #ifdef CONFIG_PCIEAER
 void pci_no_aer(void);
 void pci_aer_init(struct pci_dev *dev);
+void pci_aer_exit(struct pci_dev *dev);
 #else
 static inline void pci_no_aer(void) { }
 static inline int pci_aer_init(struct pci_dev *d) { return -ENODEV; }
+static inline void pci_aer_exit(struct pci_dev *d) { }
 #endif
 
 #endif /* DRIVERS_PCI_H */
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 11482669b93b..6aa5284d5805 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -33,6 +33,9 @@
 #define AER_ERROR_SOURCES_MAX		100
 #define AER_MAX_MULTI_ERR_DEVICES	5	/* Not likely to have more */
 
+#define AER_MAX_TYPEOF_COR_ERRS		16	/* as per PCI_ERR_COR_STATUS */
+#define AER_MAX_TYPEOF_UNCOR_ERRS	26	/* as per PCI_ERR_UNCOR_STATUS*/
+
 struct aer_err_info {
 	struct pci_dev *dev[AER_MAX_MULTI_ERR_DEVICES];
 	int error_dev_num;
@@ -76,6 +79,42 @@ struct aer_rpc {
 					 */
 };
 
+/* AER stats for the device */
+struct aer_stats {
+
+	/*
+	 * Fields for all AER capable devices. They indicate the errors
+	 * "as seen by this device". Note that this may mean that if an
+	 * end point is causing problems, the AER counters may increment
+	 * at its link partner (e.g. root port) because the errors will be
+	 * "seen" by the link partner and not the the problematic end point
+	 * itself (which may report all counters as 0 as it never saw any
+	 * problems).
+	 */
+	/* Counters for different type of correctable errors */
+	u64 dev_cor_errs[AER_MAX_TYPEOF_COR_ERRS];
+	/* Counters for different type of fatal uncorrectable errors */
+	u64 dev_fatal_errs[AER_MAX_TYPEOF_UNCOR_ERRS];
+	/* Counters for different type of nonfatal uncorrectable errors */
+	u64 dev_nonfatal_errs[AER_MAX_TYPEOF_UNCOR_ERRS];
+	/* Total number of ERR_COR sent by this device */
+	u64 dev_total_cor_errs;
+	/* Total number of ERR_FATAL sent by this device */
+	u64 dev_total_fatal_errs;
+	/* Total number of ERR_NONFATAL sent by this device */
+	u64 dev_total_nonfatal_errs;
+
+	/*
+	 * Fields for Root ports  & root complex event collectors only, these
+	 * indicate the total number of ERR_COR, ERR_FATAL, and ERR_NONFATAL
+	 * messages received by the root port / event collector, INCLUDING the
+	 * ones that are generated internally (by the rootport itself)
+	 */
+	u64 rootport_total_cor_errs;
+	u64 rootport_total_fatal_errs;
+	u64 rootport_total_nonfatal_errs;
+};
+
 #define AER_LOG_TLP_MASKS		(PCI_ERR_UNC_POISON_TLP|	\
 					PCI_ERR_UNC_ECRC|		\
 					PCI_ERR_UNC_UNSUP|		\
@@ -405,9 +444,19 @@ int pci_cleanup_aer_error_status_regs(struct pci_dev *dev)
 void pci_aer_init(struct pci_dev *dev)
 {
 	dev->aer_cap = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ERR);
+
+	if (dev->aer_cap)
+		dev->aer_stats = kzalloc(sizeof(struct aer_stats), GFP_KERNEL);
+
 	pci_cleanup_aer_error_status_regs(dev);
 }
 
+void pci_aer_exit(struct pci_dev *dev)
+{
+	kfree(dev->aer_stats);
+	dev->aer_stats = NULL;
+}
+
 #define AER_AGENT_RECEIVER		0
 #define AER_AGENT_REQUESTER		1
 #define AER_AGENT_COMPLETER		2
@@ -458,7 +507,7 @@ static const char *aer_error_layer[] = {
 	"Transaction Layer"
 };
 
-static const char *aer_correctable_error_string[] = {
+static const char *aer_correctable_error_string[AER_MAX_TYPEOF_COR_ERRS] = {
 	"Receiver Error",		/* Bit Position 0	*/
 	NULL,
 	NULL,
@@ -477,7 +526,7 @@ static const char *aer_correctable_error_string[] = {
 	"Header Log Overflow",		/* Bit Position 15	*/
 };
 
-static const char *aer_uncorrectable_error_string[] = {
+static const char *aer_uncorrectable_error_string[AER_MAX_TYPEOF_UNCOR_ERRS] = {
 	"Undefined",			/* Bit Position 0	*/
 	NULL,
 	NULL,
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index ac876e32de4b..48edd0c9e4bc 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2064,6 +2064,7 @@ static void pci_configure_device(struct pci_dev *dev)
 
 static void pci_release_capabilities(struct pci_dev *dev)
 {
+	pci_aer_exit(dev);
 	pci_vpd_release(dev);
 	pci_iov_release(dev);
 	pci_free_cap_save_buffers(dev);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index b4ffea05c999..6bc0aa0fc33f 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -299,6 +299,7 @@ struct pci_dev {
 	u8		hdr_type;	/* PCI header type (`multi' flag masked out) */
 #ifdef CONFIG_PCIEAER
 	u16		aer_cap;	/* AER capability offset */
+	struct aer_stats *aer_stats;	/* AER stats for this device */
 #endif
 	u8		pcie_cap;	/* PCIe capability offset */
 	u8		msi_cap;	/* MSI capability offset */
-- 
2.18.0.rc2.346.g013aa6912e-goog
