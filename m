Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ale.deltatee.com ([207.54.116.67]:39916 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S969460AbeEXVss (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 24 May 2018 17:48:48 -0400
From: Logan Gunthorpe <logang@deltatee.com>
To: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-doc@vger.kernel.org
Cc: Stephen Bates <sbates@raithlin.com>,
        Christoph Hellwig <hch@lst.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Christoffer Dall <cdall@linaro.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Logan Gunthorpe <logang@deltatee.com>
Date: Thu, 24 May 2018 15:48:16 -0600
Message-Id: <20180524214816.14485-4-logang@deltatee.com>
In-Reply-To: <20180524214816.14485-1-logang@deltatee.com>
References: <20180524214816.14485-1-logang@deltatee.com>
Subject: [PATCH 3/3] PCI: Introduce the disable_acs_redir parameter
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

In order to support P2P traffic on a segment of the PCI hierarchy,
we must be able to disable the ACS redirect bits for select
PCI bridges. The bridges must be selected before the devices are
discovered by the kernel and the IOMMU groups created. Therefore,
a kernel command line parameter is created to specify devices
which must have their ACS bits disabled.

The new parameter takes a list of devices separated by a semicolon.
Each device specified will have it's ACS redirect bits disabled.
This is similar to the existing 'resource_alignment' parameter and just
like it we also create a sysfs bus attribute which can be used to
read the parameter. Writing the parameter is not supported
as it would require forcibly hot plugging the affected device as
well as all devices whose IOMMU groups might change.

The ACS Request P2P Request Redirect, P2P Completion Redirect and P2P
Egress Control bits are disabled which is sufficient to always allow
passing P2P traffic uninterrupted. The bits are set after the kernel
(optionally) enables the ACS bits itself. It is also done regardless of
whether the kernel sets the bits or not seeing some BIOS firmware is known
to set the bits on boot.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Reviewed-by: Stephen Bates <sbates@raithlin.com>
---
 Documentation/admin-guide/kernel-parameters.txt |   9 +++
 drivers/pci/pci.c                               | 103 +++++++++++++++++++++++-
 2 files changed, 110 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 519ab95bb418..215285c4772d 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3176,6 +3176,15 @@
 				Adding the window is slightly risky (it may
 				conflict with unreported devices), so this
 				taints the kernel.
+		disable_acs_redir=<pci_dev>[; ...]
+				Specify one or more PCI devices (in the format
+				specified above) separated by semicolons.
+				Each device specified will have the PCI ACS
+				redirect capabilities forced off which will
+				allow P2P traffic between devices through
+				bridges without forcing it upstream. Note:
+				this removes isolation between devices and
+				will make the IOMMU groups less granular.
 
 	pcie_aspm=	[PCIE] Forcibly enable or disable PCIe Active State Power
 			Management.
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 53ea0d7b02ce..3465895a55ab 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -2998,6 +2998,92 @@ void pci_request_acs(void)
 	pci_acs_enable = 1;
 }
 
+#define DISABLE_ACS_REDIR_PARAM_SIZE COMMAND_LINE_SIZE
+static char disable_acs_redir_param[DISABLE_ACS_REDIR_PARAM_SIZE] = {0};
+static DEFINE_SPINLOCK(disable_acs_redir_lock);
+
+static ssize_t pci_set_disable_acs_redir_param(const char *buf, size_t count)
+{
+	if (count > DISABLE_ACS_REDIR_PARAM_SIZE - 1)
+		count = DISABLE_ACS_REDIR_PARAM_SIZE - 1;
+	spin_lock(&disable_acs_redir_lock);
+	strncpy(disable_acs_redir_param, buf, count);
+	disable_acs_redir_param[count] = '\0';
+	spin_unlock(&disable_acs_redir_lock);
+	return count;
+}
+
+static ssize_t pci_disable_acs_redir_show(struct bus_type *bus, char *buf)
+{
+	size_t count;
+
+	spin_lock(&disable_acs_redir_lock);
+	count = snprintf(buf, PAGE_SIZE, "%s\n", disable_acs_redir_param);
+	spin_unlock(&disable_acs_redir_lock);
+	return count;
+}
+
+static BUS_ATTR(disable_acs_redir, 0444, pci_disable_acs_redir_show, NULL);
+
+static int __init pci_disable_acs_redir_sysfs_init(void)
+{
+	return bus_create_file(&pci_bus_type, &bus_attr_disable_acs_redir);
+}
+late_initcall(pci_disable_acs_redir_sysfs_init);
+
+/**
+ * pci_disable_acs_redir - disable ACS redirect capabilities
+ * @dev: the PCI device
+ *
+ * For only devices specified in the disable_acs_redir parameter.
+ */
+static void pci_disable_acs_redir(struct pci_dev *dev)
+{
+	int ret = 0;
+	const char *p;
+	int pos;
+	u16 ctrl;
+
+	spin_lock(&disable_acs_redir_lock);
+
+	p = disable_acs_redir_param;
+	while (*p) {
+		ret = pci_dev_str_match(dev, p, &p);
+		if (ret < 0) {
+			pr_info_once("PCI: Can't parse disable_acs_redir parameter: %s\n",
+				     disable_acs_redir_param);
+
+			break;
+		} else if (ret == 1) {
+			/* Found a match */
+			break;
+		}
+
+		if (*p != ';' && *p != ',') {
+			/* End of param or invalid format */
+			break;
+		}
+		p++;
+	}
+	spin_unlock(&disable_acs_redir_lock);
+
+	if (ret != 1)
+		return;
+
+	pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ACS);
+	if (!pos)
+		return;
+
+	pci_read_config_word(dev, pos + PCI_ACS_CTRL, &ctrl);
+
+	/* P2P Request & Completion Redirect */
+	ctrl &= ~(PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_EC);
+
+	pci_write_config_word(dev, pos + PCI_ACS_CTRL, ctrl);
+
+	pci_info(dev, "disabled ACS redirect\n");
+}
+
 /**
  * pci_std_enable_acs - enable ACS on devices using standard ACS capabilites
  * @dev: the PCI device
@@ -3037,12 +3123,22 @@ static void pci_std_enable_acs(struct pci_dev *dev)
 void pci_enable_acs(struct pci_dev *dev)
 {
 	if (!pci_acs_enable)
-		return;
+		goto disable_acs_redir;
 
 	if (!pci_dev_specific_enable_acs(dev))
-		return;
+		goto disable_acs_redir;
 
 	pci_std_enable_acs(dev);
+
+disable_acs_redir:
+	/*
+	 * Note: pci_disable_acs_redir() must be called even if
+	 * ACS is not enabled by the kernel because the firmware
+	 * may have unexpectedly set the flags. So if we are told
+	 * to disable it, we should always disable it after setting
+	 * the kernel's default preferences.
+	 */
+	pci_disable_acs_redir(dev);
 }
 
 static bool pci_acs_flags_enabled(struct pci_dev *pdev, u16 acs_flags)
@@ -5995,6 +6091,9 @@ static int __init pci_setup(char *str)
 				pcie_bus_config = PCIE_BUS_PEER2PEER;
 			} else if (!strncmp(str, "pcie_scan_all", 13)) {
 				pci_add_flags(PCI_SCAN_ALL_PCIE_DEVS);
+			} else if (!strncmp(str, "disable_acs_redir=", 18)) {
+				pci_set_disable_acs_redir_param(str + 18,
+					strlen(str + 18));
 			} else {
 				printk(KERN_ERR "PCI: Unknown option `%s'\n",
 						str);
-- 
2.11.0
