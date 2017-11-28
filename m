Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:52444 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752963AbdK1MMo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 28 Nov 2017 07:12:44 -0500
Date: Tue, 28 Nov 2017 12:13:12 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: David Laight <David.Laight@ACULAB.COM>
Cc: 'Niklas Cassel' <niklas.cassel@axis.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Niklas Cassel <niklass@axis.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 3/3] PCI: endpoint: Fix find_first_zero_bit() usage
Message-ID: <20171128121312.GA15106@red-moon>
References: <20171127154955.22214-1-niklas.cassel@axis.com>
 <20171127154955.22214-4-niklas.cassel@axis.com>
 <227791f09ccd4aa8972ba334fd948f4e@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <227791f09ccd4aa8972ba334fd948f4e@AcuMS.aculab.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Nov 28, 2017 at 09:53:12AM +0000, David Laight wrote:
> From: Niklas Cassel
> > Sent: 27 November 2017 15:50
> > find_first_zero_bit()'s parameter 'size' is defined in bits,
> > not in bytes.
> > 
> > Calling find_first_zero_bit() with the wrong size unit
> > will lead to insidious bugs.
> > 
> > Fix this by calling find_first_zero_bit() with size
> > BITS_PER_LONG, rather than sizeof().
> > 
> > Also add proper error handling for find_first_zero_bit(),
> > since this was missing.
> > 
> > Fixes: d74679911610 ("PCI: endpoint: Introduce configfs entry for configuring EP functions")
> > Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>
> > ---
> >  drivers/pci/endpoint/pci-ep-cfs.c | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/pci/endpoint/pci-ep-cfs.c b/drivers/pci/endpoint/pci-ep-cfs.c
> > index e1f5adc9e113..0a22a7976580 100644
> > --- a/drivers/pci/endpoint/pci-ep-cfs.c
> > +++ b/drivers/pci/endpoint/pci-ep-cfs.c
> > @@ -109,7 +109,12 @@ static int pci_epc_epf_link(struct config_item *epc_item,
> >  		return ret;
> > 
> >  	func_no = find_first_zero_bit(&epc_group->function_num_map,
> > -				      sizeof(epc_group->function_num_map));
> > +				      BITS_PER_LONG);
> 
> Surely this should be either 8 * sizeof() or you should use ffz()
> that takes a numeric argument rather than the function designed
> for arbitrary size bitmaps.

Do you see a problem with this code ? It can be made a bitmap by
allocating it using epc->max_functions as bitmap number of bits
and that can be made on top of the code above that would go in
as a fix unless you strongly object to it, as Joe mentioned
both ffz+| and find_first_zero_bit()+set_bit() are ok with me as
long as we choose one and fix the issue.

Thanks,
Lorenzo
