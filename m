Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:54199 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754089AbcAIBFu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 8 Jan 2016 20:05:50 -0500
Date: Fri, 8 Jan 2016 19:05:45 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jordan Hargrave <Jordan_Hargrave@dell.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, alexander.duyck@gmail.com,
	Babu Moger <babu.moger@oracle.com>,
	Hannes Reinecke <hare@suse.de>,
	Michal Kubecek <mkubecek@suse.com>,
	"Shane M. Seymour" <shane.seymour@hpe.com>,
	Myron Stowe <myron.stowe@gmail.com>,
	Venkat Duvvuru <VenkatKumar.Duvvuru@Emulex.com>
Subject: Re: [PATCH] Limit VPD length on Atheros wifi cards
Message-ID: <20160109010545.GA31085@localhost>
References: <1451427542-30482-1-git-send-email-Jordan_Hargrave@dell.com>
 <20160109005736.GP5354@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160109005736.GP5354@localhost>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Hannes, Michal, Shane, Myron, Venkat; sorry I missed you guys the
first time around]

On Fri, Jan 08, 2016 at 06:57:36PM -0600, Bjorn Helgaas wrote:
> [+cc Babu]
> 
> Hi Jordan, Babu, et al,
> 
> On Tue, Dec 29, 2015 at 04:19:02PM -0600, Jordan Hargrave wrote:
> > Attempt to read VPD on these cards causes kernel hang or delay
> > 
> > Signed-off-by: Jordan Hargrave <Jordan_Hargrave@dell.com>
> > ---
> >  drivers/pci/quirks.c |   10 ++++++++++
> >  1 files changed, 10 insertions(+), 0 deletions(-)
> > 
> > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> > index e6376f6..a72667f 100644
> > --- a/drivers/pci/quirks.c
> > +++ b/drivers/pci/quirks.c
> > @@ -2161,6 +2161,16 @@ static void quirk_brcm_570x_limit_vpd(struct pci_dev *dev)
> >  	}
> >  }
> >  
> > +static void quirk_atheros_vpd(struct pci_dev *dev)
> > +{
> > +	/* Atheros WiFi cards hang when reading VPD */
> > +	if (dev->vpd)
> > +		dev->vpd->len = 0;
> > +}
> > +
> > +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATHEROS, PCI_ANY_ID, quirk_atheros_vpd);
> > +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATTANSIC, PCI_ANY_ID, quirk_atheros_vpd);
> 
> We're accumulating several quirks like this, and they don't do
> anything device-specific, so we could probably use a single quirk for
> all of them, i.e., Babu's quirk_megaraid_sas_limit_vpd() and your
> quirk_atheros_vpd() are needlessly duplicated.
> 
> I'd really like to have more details about what the "kernel hang or
> delay" that happens when we try to read VPD.
> 
> Looking at pci_vpd_pci22_read(), it basically just does config
> accesses, so I only see two ways things could go wrong:
> 
>   1) If the device responds with data, but the PCI_VPD_ADDR_F flag
>   isn't set, we should be able to timeout gracefully.
> 
>   2) If the device doesn't respond at all, we could see machine
>   checks, master aborts, processor read timeouts, or similar hardware
>   problems.
> 
> If there are other failure modes, I'd like to learn what they are.
> 
> If we're seeing problems like (1), there must be something we can
> improve in the way we handle timeouts.
> 
> If we're seeing failures like (2), they're probably caused by a
> hardware or firmware problem on the device, and there's not much we
> can do in the kernel, so disabling VPD access completely is probably
> all we can do.
> 
> So if/when we add quirks like this, I'm looking for bugzilla entries
> that clearly show that the problem is (2).  I'd also like to log
> something in dmesg as a clue about why lspci or other utilities don't
> find any VPD data.
> 
> Bjorn
> 
> >  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_BROADCOM,
> >  			PCI_DEVICE_ID_NX2_5706,
> >  			quirk_brcm_570x_limit_vpd);
