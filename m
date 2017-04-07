Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 7 Apr 2017 14:58:59 +0200
From: Joerg Roedel <jroedel@suse.de>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Joerg Roedel <joro@8bytes.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Daniel Drake <drake@endlessm.com>,
        Alexander Deucher <Alexander.Deucher@amd.com>,
        Samuel Sieb <samuel@sieb.net>
Subject: Re: [PATCH] PCI: Add ATS-disable quirk for AMD Stoney GPUs
Message-ID: <20170407125859.GD23944@suse.de>
References: <1491568828-17146-1-git-send-email-joro@8bytes.org>
 <1491569585.6021.15.camel@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1491569585.6021.15.camel@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Apr 07, 2017 at 02:53:05PM +0200, David Woodhouse wrote:
> On Fri, 2017-04-07 at 14:40 +0200, Joerg Roedel wrote:
> > 
> > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> > index 6736836..3bc9856 100644
> > --- a/drivers/pci/quirks.c
> > +++ b/drivers/pci/quirks.c
> > @@ -4634,3 +4634,22 @@ static void quirk_no_aersid(struct pci_dev *pdev)
> >  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x2031, quirk_no_aersid);
> >  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x2032, quirk_no_aersid);
> >  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x2033, quirk_no_aersid);
> > +
> > +/*
> > + * Some devices have a broken ATS implementation causing IOMMU stalls.
> > + * Don't use ATS for those devices.
> > + */
> > +static void quirk_disable_ats(struct pci_dev *pdev)
> > +{
> > +#ifdef CONFIG_PCI_ATS
> > +       /*
> > +        * Set pdev->ats_cap = 0 to make pci_enable_ats() bail out
> > +        * early.
> > +        */
> > +       dev_info(&pdev->dev, "QUIRK: Disabling ATS");
> > +       pdev->ats_cap = 0;
> > +#endif
> > +}
> > +
> > +/* AMD Stoney platform GPU */
> > +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x98e4, quirk_disable_ats);
> 
> Why not put the #ifdef around *all* of the above?

Good point, I'll change that.
