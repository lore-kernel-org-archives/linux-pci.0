Return-Path: <SRS0=JxJW=3P=suse.de=jroedel@kernel.org>
Return-Path: <SRS0=JxJW=3P=suse.de=jroedel@kernel.org>
Date: Fri, 7 Apr 2017 14:34:31 +0200
From: Joerg Roedel <jroedel@suse.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Joerg Roedel <joro@8bytes.org>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Daniel Drake <drake@endlessm.com>,
	Alexander Deucher <Alexander.Deucher@amd.com>
Subject: Re: [PATCH] PCI: Blacklist AMD Stoney GPU devices for ATS
Message-ID: <20170407123431.GC23944@suse.de>
References: <1490703404-4944-1-git-send-email-joro@8bytes.org>
 <20170404164311.GB27692@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170404164311.GB27692@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

On Tue, Apr 04, 2017 at 11:43:11AM -0500, Bjorn Helgaas wrote:
> > +static const struct pci_device_id broken_ats_tbl[] = {
> > +	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, 0x98e4) }, /* AMD Stoney GPU part */

Just found out that the affected GPU uses PCI_VENDOR_ID_ATI, fixed that
too.

> > +	{ 0 }
> > +};
> > +
> >  void pci_ats_init(struct pci_dev *dev)
> > 
> >  	int pos;
> >  
> > +	if (pci_match_id(broken_ats_tbl, dev))
> > +		return;
> 
> This is fine functionally, but from a stylistic point of view, I guess
> I would prefer to have it implemented in drivers/pci/quirks.c just to
> have some consistency in how we work around device defects.

Done, I send a new patch shortly.



	Joerg
