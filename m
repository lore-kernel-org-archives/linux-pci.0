Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:43610 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727075AbeHPBhV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 15 Aug 2018 21:37:21 -0400
Date: Wed, 15 Aug 2018 16:43:08 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: Add ACS quirk for Intel 300 series chipset
Message-ID: <20180815164308.6ad5dd39@t450s.home>
In-Reply-To: <20180815152139.4e469fd4@t450s.home>
References: <20180427104423.2203-1-mika.westerberg@linux.intel.com>
        <20180815152139.4e469fd4@t450s.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, 15 Aug 2018 15:21:39 -0600
Alex Williamson <alex.williamson@redhat.com> wrote:

> On Fri, 27 Apr 2018 13:44:23 +0300
> Mika Westerberg <mika.westerberg@linux.intel.com> wrote:
> 
> > Intel 300 series chipset still has the same ACS issue than the previous
> > generations so extend the ACS quirk to cover it as well.
> > 
> > Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > ---
> >  drivers/pci/quirks.c | 6 ++++++
> >  1 file changed, 6 insertions(+)  
> 
> There seems to be some suspicion whether this patch is correct, see
> link below[1].  The user lists a kernel "4.14.36-1-lts" where lspci
> shows the ACSCtl register with SV, RR, and CR enabled.  AIUI how
> previous Intel root ports were defective in this regard, a dword
> register was used for the ACS capability and control field rather than
> the spec defined word register, therefore the upper half of each
> mal-sized register was reserved.  I don't think lspci has gained any
> insight into this quirk, so showing those control values enabled
> suggests this hardware might actually not require the quirk.
> 
> The second listing for v4.17 (and I don't know if this is actually
> v4.17.10 which would include the stable backport of this patch or
> v4.17.0) shows the ACSCtl register as zero.  This is what we'd see if
> the hardware does have this errata OR if we applied the quirk to
> hardware that doesn't require it.  The existence of the first listing
> kind of suggests the latter.
> 
> Is there a datasheet available to support this quirk?  Thanks,
> 
> Alex
> 
> [1]https://www.reddit.com/r/VFIO/comments/97da1s/intel_c246_suspect_300_series_acs_quirk_breaks/

Sorry for the self follow-up, but another user pointed me to these:

https://www.intel.com/content/dam/www/public/us/en/documents/datasheets/300-series-chipset-pch-datasheet-vol-1.pdf
https://www.intel.com/content/dam/www/public/us/en/documents/specification-updates/300-series-c240-series-chipset-pch-spec-update.pdf

And the device IDs match and the errata is #3 in the second link, yet:

00:1c.0 PCI bridge [0604]: Intel Corporation Device [8086:a338] (rev f0) (prog-if 00 [Normal decode])
00:1c.2 PCI bridge [0604]: Intel Corporation Device [8086:a33a] (rev f0) (prog-if 00 [Normal decode])
	Capabilities: [140 v1] Access Control Services
		ACSCap:	SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ UpstreamFwd- EgressCtrl- DirectTrans-
		ACSCtl:	SrcValid+ TransBlk- ReqRedir+ CmpltRedir+ UpstreamFwd- EgressCtrl- DirectTrans-
00:1c.5 PCI bridge [0604]: Intel Corporation Device [8086:a33d] (rev f0) (prog-if 00 [Normal decode])
	Capabilities: [140 v1] Access Control Services
		ACSCap:	SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ UpstreamFwd- EgressCtrl- DirectTrans-
		ACSCtl:	SrcValid+ TransBlk- ReqRedir+ CmpltRedir+ UpstreamFwd- EgressCtrl- DirectTrans-
00:1c.6 PCI bridge [0604]: Intel Corporation Device [8086:a33e] (rev f0) (prog-if 00 [Normal decode])
	Capabilities: [140 v1] Access Control Services
		ACSCap:	SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ UpstreamFwd- EgressCtrl- DirectTrans-
		ACSCtl:	SrcValid+ TransBlk- ReqRedir+ CmpltRedir+ UpstreamFwd- EgressCtrl- DirectTrans-
00:1c.7 PCI bridge [0604]: Intel Corporation Device [8086:a33f] (rev f0) (prog-if 00 [Normal decode])
	Capabilities: [140 v1] Access Control Services
		ACSCap:	SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ UpstreamFwd- EgressCtrl- DirectTrans-
		ACSCtl:	SrcValid+ TransBlk- ReqRedir+ CmpltRedir+ UpstreamFwd- EgressCtrl- DirectTrans-

And the dump of config space is (1c.2):

140: 0d 00 01 15 0f 00 0d 00 00 00 00 00 00 00 00 00
                 ^^^^^ ^^^^^
                  Cap   Ctl

So it sure seems like the quirk shouldn't apply here.  Note that the
user calls this a C246 chipset, though this isn't a directly addressed
product SKU in either document.  The LPC device ID is a309, which also
is not directly addressed by the above datasheet.  Has Intel fixed this
in some SKUs, but not others, both using the same root port device
IDs?  Thanks,

Alex

> > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> > index 2990ad1e7c99..7a0f41176369 100644
> > --- a/drivers/pci/quirks.c
> > +++ b/drivers/pci/quirks.c
> > @@ -4230,6 +4230,11 @@ static int pci_quirk_qcom_rp_acs(struct pci_dev *dev, u16 acs_flags)
> >   * 0xa290-0xa29f PCI Express Root port #{0-16}
> >   * 0xa2e7-0xa2ee PCI Express Root port #{17-24}
> >   *
> > + * The 300 series chipset suffers from the same bug so include those root
> > + * ports here as well.
> > + *
> > + * 0xa32c-0xa343 PCI Express Root port #{0-24}
> > + *
> >   * [1] http://www.intel.com/content/www/us/en/chipsets/100-series-chipset-datasheet-vol-2.html
> >   * [2] http://www.intel.com/content/www/us/en/chipsets/100-series-chipset-datasheet-vol-1.html
> >   * [3] http://www.intel.com/content/www/us/en/chipsets/100-series-chipset-spec-update.html
> > @@ -4244,6 +4249,7 @@ static bool pci_quirk_intel_spt_pch_acs_match(struct pci_dev *dev)
> >  	switch (dev->device) {
> >  	case 0xa110 ... 0xa11f: case 0xa167 ... 0xa16a: /* Sunrise Point */
> >  	case 0xa290 ... 0xa29f: case 0xa2e7 ... 0xa2ee: /* Union Point */
> > +	case 0xa32c ... 0xa343:				/* 300 series */
> >  		return true;
> >  	}
> >    
> 
