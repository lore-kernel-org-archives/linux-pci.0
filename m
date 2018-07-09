Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ale.deltatee.com ([207.54.116.67]:47944 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754018AbeGIW2O (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 9 Jul 2018 18:28:14 -0400
To: Alex Williamson <alex.williamson@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-doc@vger.kernel.org, Stephen Bates <sbates@raithlin.com>,
        Christoph Hellwig <hch@lst.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Matthew Wilcox <willy@infradead.org>
References: <20180627174650.27433-1-logang@deltatee.com>
 <20180627174650.27433-4-logang@deltatee.com>
 <20180706165655.62306b6f@t450s.home>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <01dfc5ba-43cb-fbea-93e6-4963c411c750@deltatee.com>
Date: Mon, 9 Jul 2018 16:27:40 -0600
MIME-Version: 1.0
In-Reply-To: <20180706165655.62306b6f@t450s.home>
Content-Type: text/plain; charset=utf-8
Subject: Re: [PATCH v5 3/3] PCI: Introduce the disable_acs_redir parameter
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hey Alex,

On 06/07/18 04:56 PM, Alex Williamson wrote:
> Maybe we track if we enabled ACS via a device specific quirk and
> minimally print an incompatibility error if it's also specified for
> disable_acs_redir?  Thanks,

Ok, I dug into this a bit and I think tracking if we enabled via a
device specific quirk does not work. If 'pci_acs_enable' is not set, we
wouldn't know if we used a device specific quirk and still try to
disable a quirked device the standard way.

Instead, I've looked at adding a device specific disable_acs_redir
function next to enable_acs. In this way, the device specific quirks can
override the operation. See the diff below.

Implementing the Intel SPT PCH version is pretty trivial, so I've done
that. The Intel PCH variant I've just left as unsupported and printed a
warning.

If this sounds good to you, I'll fold it into my patchset and resubmit a v6.

Thanks,

Logan

--

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 079f7c911e09..54001b307496 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3028,6 +3028,9 @@ static void pci_disable_acs_redir(struct pci_dev *dev)
 	if (!pos)
 		return;

+	if (!pci_dev_specific_disable_acs_redir(dev))
+		return;
+
 	pci_read_config_word(dev, pos + PCI_ACS_CTRL, &ctrl);

 	/* P2P Request & Completion Redirect */
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index f439de848658..c976a025ae92 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -4526,6 +4526,16 @@ static int pci_quirk_enable_intel_pch_acs(struct
pci_dev *dev)
 	return 0;
 }

+static int pci_quirk_disable_intel_pch_acs_redir(struct pci_dev *dev)
+{
+	if (!pci_quirk_intel_pch_acs_match(dev))
+		return -ENOTTY;
+
+	pci_warn(dev, "Disabling ACS redirect on the Intel PCH root port is
not supported\n");
+
+	return 0;
+}
+
 static int pci_quirk_enable_intel_spt_pch_acs(struct pci_dev *dev)
 {
 	int pos;
@@ -4553,22 +4563,53 @@ static int
pci_quirk_enable_intel_spt_pch_acs(struct pci_dev *dev)
 	return 0;
 }

-static const struct pci_dev_enable_acs {
+static int pci_quirk_disable_intel_spt_pch_acs_redir(struct pci_dev *dev)
+{
+	int pos;
+	u32 cap, ctrl;
+
+	if (!pci_quirk_intel_spt_pch_acs_match(dev))
+		return -ENOTTY;
+
+	pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ACS);
+	if (!pos)
+		return -ENOTTY;
+
+	pci_read_config_dword(dev, pos + PCI_ACS_CAP, &cap);
+	pci_read_config_dword(dev, pos + INTEL_SPT_ACS_CTRL, &ctrl);
+
+	ctrl &= ~(PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_EC);
+
+	pci_write_config_dword(dev, pos + INTEL_SPT_ACS_CTRL, ctrl);
+
+	pci_info(dev, "Intel SPT PCH root port workaround: disabled ACS
redirect\n");
+
+	return 0;
+}
+
+static const struct pci_dev_acs_ops {
 	u16 vendor;
 	u16 device;
 	int (*enable_acs)(struct pci_dev *dev);
-} pci_dev_enable_acs[] = {
-	{ PCI_VENDOR_ID_INTEL, PCI_ANY_ID, pci_quirk_enable_intel_pch_acs },
-	{ PCI_VENDOR_ID_INTEL, PCI_ANY_ID, pci_quirk_enable_intel_spt_pch_acs },
+	int (*disable_acs_redir)(struct pci_dev *dev);
+} pci_dev_acs_ops[] = {
+	{ PCI_VENDOR_ID_INTEL, PCI_ANY_ID,
+	  .enable_acs = pci_quirk_enable_intel_pch_acs,
+	  .disable_acs_redir = pci_quirk_disable_intel_pch_acs_redir,
+	},
+	{ PCI_VENDOR_ID_INTEL, PCI_ANY_ID,
+	  .enable_acs = pci_quirk_enable_intel_spt_pch_acs,
+	  .disable_acs_redir = pci_quirk_disable_intel_spt_pch_acs_redir
+	},
 	{ 0 }
 };

 int pci_dev_specific_enable_acs(struct pci_dev *dev)
 {
-	const struct pci_dev_enable_acs *i;
+	const struct pci_dev_acs_ops *i;
 	int ret;

-	for (i = pci_dev_enable_acs; i->enable_acs; i++) {
+	for (i = pci_dev_acs_ops; i->enable_acs; i++) {
 		if ((i->vendor == dev->vendor ||
 		     i->vendor == (u16)PCI_ANY_ID) &&
 		    (i->device == dev->device ||
@@ -4582,6 +4623,25 @@ int pci_dev_specific_enable_acs(struct pci_dev *dev)
 	return -ENOTTY;
 }

+int pci_dev_specific_disable_acs_redir(struct pci_dev *dev)
+{
+	const struct pci_dev_acs_ops *i;
+	int ret;
+
+	for (i = pci_dev_acs_ops; i->enable_acs; i++) {
+		if ((i->vendor == dev->vendor ||
+		     i->vendor == (u16)PCI_ANY_ID) &&
+		    (i->device == dev->device ||
+		     i->device == (u16)PCI_ANY_ID)) {
+			ret = i->disable_acs_redir(dev);
+			if (ret >= 0)
+				return ret;
+		}
+	}
+
+	return -ENOTTY;
+}
+
 /*
  * The PCI capabilities list for Intel DH895xCC VFs (device ID 0x0443) with
  * QuickAssist Technology (QAT) is prematurely terminated in hardware.  The
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 340029b2fb38..7ee208aa1a31 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1878,6 +1878,7 @@ enum pci_fixup_pass {
 void pci_fixup_device(enum pci_fixup_pass pass, struct pci_dev *dev);
 int pci_dev_specific_acs_enabled(struct pci_dev *dev, u16 acs_flags);
 int pci_dev_specific_enable_acs(struct pci_dev *dev);
+int pci_dev_specific_disable_acs_redir(struct pci_dev *dev);
 #else
 static inline void pci_fixup_device(enum pci_fixup_pass pass,
 				    struct pci_dev *dev) { }
