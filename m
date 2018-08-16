Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48422 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389539AbeHPSML (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 16 Aug 2018 14:12:11 -0400
Date: Thu, 16 Aug 2018 09:13:03 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: Add ACS quirk for Intel 300 series chipset
Message-ID: <20180816091303.69ce8e45@t450s.home>
In-Reply-To: <20180816061015.GD2343@lahna.fi.intel.com>
References: <20180427104423.2203-1-mika.westerberg@linux.intel.com>
        <20180815152139.4e469fd4@t450s.home>
        <20180815164308.6ad5dd39@t450s.home>
        <20180816061015.GD2343@lahna.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, 16 Aug 2018 09:10:15 +0300
Mika Westerberg <mika.westerberg@linux.intel.com> wrote:

> On Wed, Aug 15, 2018 at 04:43:08PM -0600, Alex Williamson wrote:
> > Sorry for the self follow-up, but another user pointed me to these:
> > 
> > https://www.intel.com/content/dam/www/public/us/en/documents/datasheets/300-series-chipset-pch-datasheet-vol-1.pdf
> > https://www.intel.com/content/dam/www/public/us/en/documents/specification-updates/300-series-c240-series-chipset-pch-spec-update.pdf
> > 
> > And the device IDs match and the errata is #3 in the second link, yet:
> > 
> > 00:1c.0 PCI bridge [0604]: Intel Corporation Device [8086:a338] (rev f0) (prog-if 00 [Normal decode])
> > 00:1c.2 PCI bridge [0604]: Intel Corporation Device [8086:a33a] (rev f0) (prog-if 00 [Normal decode])
> > 	Capabilities: [140 v1] Access Control Services
> > 		ACSCap:	SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ UpstreamFwd- EgressCtrl- DirectTrans-
> > 		ACSCtl:	SrcValid+ TransBlk- ReqRedir+ CmpltRedir+ UpstreamFwd- EgressCtrl- DirectTrans-
> > 00:1c.5 PCI bridge [0604]: Intel Corporation Device [8086:a33d] (rev f0) (prog-if 00 [Normal decode])
> > 	Capabilities: [140 v1] Access Control Services
> > 		ACSCap:	SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ UpstreamFwd- EgressCtrl- DirectTrans-
> > 		ACSCtl:	SrcValid+ TransBlk- ReqRedir+ CmpltRedir+ UpstreamFwd- EgressCtrl- DirectTrans-
> > 00:1c.6 PCI bridge [0604]: Intel Corporation Device [8086:a33e] (rev f0) (prog-if 00 [Normal decode])
> > 	Capabilities: [140 v1] Access Control Services
> > 		ACSCap:	SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ UpstreamFwd- EgressCtrl- DirectTrans-
> > 		ACSCtl:	SrcValid+ TransBlk- ReqRedir+ CmpltRedir+ UpstreamFwd- EgressCtrl- DirectTrans-
> > 00:1c.7 PCI bridge [0604]: Intel Corporation Device [8086:a33f] (rev f0) (prog-if 00 [Normal decode])
> > 	Capabilities: [140 v1] Access Control Services
> > 		ACSCap:	SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ UpstreamFwd- EgressCtrl- DirectTrans-
> > 		ACSCtl:	SrcValid+ TransBlk- ReqRedir+ CmpltRedir+ UpstreamFwd- EgressCtrl- DirectTrans-
> > 
> > And the dump of config space is (1c.2):
> > 
> > 140: 0d 00 01 15 0f 00 0d 00 00 00 00 00 00 00 00 00
> >                  ^^^^^ ^^^^^
> >                   Cap   Ctl  
> 
> It certainly looks like so.
> 
> > So it sure seems like the quirk shouldn't apply here.  Note that the
> > user calls this a C246 chipset, though this isn't a directly addressed
> > product SKU in either document.  The LPC device ID is a309, which also
> > is not directly addressed by the above datasheet.  Has Intel fixed this
> > in some SKUs, but not others, both using the same root port device
> > IDs?  Thanks,  
> 
> Let me ask around and see if someone here can explain this.

Untested, but I wonder if we need something like below to validate that
the standard control register is read-only, or in reality the upper half
of the dword register where all the bits are reserved on afflicted
devices.  Adding a test of the LPC device ID seems even messier.
Thanks,

Alex

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index e249676fbf04..b67d4789a4bb 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -4352,6 +4352,7 @@ static bool pci_quirk_intel_spt_pch_acs_match(struct pci_dev *dev)
 static int pci_quirk_intel_spt_pch_acs(struct pci_dev *dev, u16 acs_flags)
 {
 	int pos;
+	u16 std_ctrl;
 	u32 cap, ctrl;
 
 	if (!pci_quirk_intel_spt_pch_acs_match(dev))
@@ -4361,6 +4362,11 @@ static int pci_quirk_intel_spt_pch_acs(struct pci_dev *dev, u16 acs_flags)
 	if (!pos)
 		return -ENOTTY;
 
+	/* If the standard control bits are set, this is not our dev */
+	pci_read_config_word(dev, pos + PCI_ACS_CTRL, &std_ctrl);
+	if (std_ctrl)
+		return -ENOTTY;
+
 	/* see pci_acs_flags_enabled() */
 	pci_read_config_dword(dev, pos + PCI_ACS_CAP, &cap);
 	acs_flags &= (cap | PCI_ACS_EC);
@@ -4612,6 +4618,7 @@ static int pci_quirk_enable_intel_pch_acs(struct pci_dev *dev)
 static int pci_quirk_enable_intel_spt_pch_acs(struct pci_dev *dev)
 {
 	int pos;
+	u16 std_ctrl;
 	u32 cap, ctrl;
 
 	if (!pci_quirk_intel_spt_pch_acs_match(dev))
@@ -4621,6 +4628,18 @@ static int pci_quirk_enable_intel_spt_pch_acs(struct pci_dev *dev)
 	if (!pos)
 		return -ENOTTY;
 
+	/* If the std control word has bits set or is writable, do not quirk */
+	pci_read_config_word(dev, pos + PCI_ACS_CTRL, &std_ctrl);
+	if (std_ctrl)
+		return -ENOTTY;
+
+	pci_write_config_word(dev, pos + PCI_ACS_CTRL, 0xff);
+	pci_read_config_word(dev, pos + PCI_ACS_CTRL, &std_ctrl);
+	if (std_ctrl) {
+		pci_write_config_word(dev, pos + PCI_ACS_CTRL, 0);
+		return -ENOTTY;
+	}
+
 	pci_read_config_dword(dev, pos + PCI_ACS_CAP, &cap);
 	pci_read_config_dword(dev, pos + INTEL_SPT_ACS_CTRL, &ctrl);
 
