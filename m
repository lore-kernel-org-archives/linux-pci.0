Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:40600 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751538AbdLNMID (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 14 Dec 2017 07:08:03 -0500
Date: Thu, 14 Dec 2017 12:07:57 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Niklas Cassel <niklas.cassel@axis.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Niklas Cassel <niklass@axis.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/3] PCI: endpoint: Fix error handling in
 pci_epc_epf_link()
Message-ID: <20171214120757.GB27147@e107981-ln.cambridge.arm.com>
References: <20171212141634.5985-1-niklas.cassel@axis.com>
 <20171212141634.5985-3-niklas.cassel@axis.com>
 <691e3693-9f18-6546-29d0-4cb155ef5bf6@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <691e3693-9f18-6546-29d0-4cb155ef5bf6@ti.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Dec 14, 2017 at 04:37:22PM +0530, Kishon Vijay Abraham I wrote:
> Hi Niklas,
> 
> On Tuesday 12 December 2017 07:46 PM, Niklas Cassel wrote:
> > The error handling in pci_epc_epf_link() is broken,
> > since the clean up code for pci_epc_add_epf() calls clear_bit(),
> > even though the matching set_bit() is done after pci_epc_add_epf().
> > 
> > Also, clear_bit() should be done before pci_epc_remove_epf(),
> > since clean up code should normally do things in the reverse order.
> > 
> > Fixes: d74679911610 ("PCI: endpoint: Introduce configfs entry for configuring EP functions")
> > Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>
> > Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > ---
> >  drivers/pci/endpoint/pci-ep-cfs.c | 6 ++----
> >  1 file changed, 2 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/pci/endpoint/pci-ep-cfs.c b/drivers/pci/endpoint/pci-ep-cfs.c
> > index 4f74386c1ced..e1f5adc9e113 100644
> > --- a/drivers/pci/endpoint/pci-ep-cfs.c
> > +++ b/drivers/pci/endpoint/pci-ep-cfs.c
> > @@ -106,7 +106,7 @@ static int pci_epc_epf_link(struct config_item *epc_item,
> >  	epf = epf_group->epf;
> >  	ret = pci_epc_add_epf(epc, epf);
> >  	if (ret)
> > -		goto err_add_epf;
> > +		return ret;
> 
> Actually the func_no should be populated before invoking pci_epc_add_epf. Once
> that is done, the error handling should be fine.

Which means that current code works because pci_epc_add_epf() is called
with epf->func_no == 0 right ? I agree that the correct fix consists in
setting the epf->func_no before calling pci_epc_add_epf(), this means
that this patch and patch 3 need updating.

Thanks,
Lorenzo
