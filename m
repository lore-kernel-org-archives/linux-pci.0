Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 31 Jan 2017 02:28:30 -0800
From: Vadim Lomovtsev <Vadim.Lomovtsev@caviumnetworks.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: <tn@semihalf.com>, <David.Daney@cavium.com>, <bhelgaas@google.com>,
        <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PCI: ACPI: Fix ThunderX PEM initialization
Message-ID: <20170131102830.GA13854@localhost.localdomain>
References: <1485793552-12614-1-git-send-email-Vadim.Lomovtsev@caviumnetworks.com>
 <20170130211236.GW20550@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <20170130211236.GW20550@bhelgaas-glaptop.roam.corp.google.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

On Mon, Jan 30, 2017 at 03:12:37PM -0600, Bjorn Helgaas wrote:
> Hi Vadim,
> 
> On Mon, Jan 30, 2017 at 08:25:52AM -0800, Vadim Lomovtsev wrote:
> > This patch is to address PEM initialization issue
> > which causes network issues.
> > 
> > It is necessary to search for _HID:PNP0A08 while requesting
> > PEM resources via ACPI instead of "THRX0002".
> > 
> > Signed-off-by: Vadim Lomovtsev <Vadim.Lomovtsev@caviumnetworks.com>
> > ---
> >  drivers/pci/host/pci-thunder-pem.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/pci/host/pci-thunder-pem.c b/drivers/pci/host/pci-thunder-pem.c
> > index af722eb..aec30b8 100644
> > --- a/drivers/pci/host/pci-thunder-pem.c
> > +++ b/drivers/pci/host/pci-thunder-pem.c
> > @@ -331,7 +331,7 @@ static int thunder_pem_acpi_init(struct pci_config_window *cfg)
> >  	if (!res_pem)
> >  		return -ENOMEM;
> >  
> > -	ret = acpi_get_rc_resources(dev, "THRX0002", root->segment, res_pem);
> > +	ret = acpi_get_rc_resources(dev, "PNP0A08", root->segment, res_pem);
> 
> This doesn't smell right: PNP0A08 is the generic ACPI ID.  There's no
> guarantee that if we find a PNP0A08 device, it is a ThunderX device.
> 
> I think the only way to call thunder_pem_acpi_init() is via an MCFG
> quirk that mentions thunder_pem_ecam_ops, which means we only call it
> if we find an MCFG with "CAVIUM" "THUNDERX" OEM and table IDs, so it's
> probably safe in that sense.

Agree, it is not the best solution.
We will implement such approach and send for review. 

> 
> But it's an abuse of the ACPI _HID model.  If you match a device using
> PNP0A08, all you can assume about it is that it uses the generic
> PNP0A08 programming model, and I don't think that includes "the first
> memory resource in _CRS contains ECAM space and MSI-X tables."
> 
> I expect this is a teething issue because you have firmware in the
> field that uses PNP0A08 and it's not feasible to update it.  If that's
> the case, the changelog should have details about it and we should
> have a comment in the code, because I don't think this is the model we
> want to end up with in future releases.

It could become so. However, for now I didn't get any reports on that,
(may be I miss something) except some internal emailings.
At my testing HW I was able to see some issues related to acpi-PEM stuff.

Thanks for feed-back, we will prepare another patch or patchset
implementing approach you've highlighted.

> >  	if (ret) {
> >  		dev_err(dev, "can't get rc base address\n");
> >  		return ret;
> > -- 
> > 2.4.11
> > 
> > 
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
