Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from eu-smtp-delivery-143.mimecast.com ([146.101.78.143]:12204 "EHLO
	eu-smtp-delivery-143.mimecast.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S966044AbbDVQRE convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 22 Apr 2015 12:17:04 -0400
Date: Wed, 22 Apr 2015 17:17:01 +0100
From: Liviu Dudau <Liviu.Dudau@arm.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Zhichang Yuan <yuanzhichang@hisilicon.com>,
	"grant.likely@linaro.org" <grant.likely@linaro.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"gabriele.paoloni@huawei.com" <gabriele.paoloni@huawei.com>
Subject: Re: [[PATCH v1]] of/pci: fix a bug in function pci_pio_to_address
Message-ID: <20150422161701.GM932@e106497-lin.cambridge.arm.com>
References: <1429709759-79006-1-git-send-email-yuanzhichang@hisilicon.com>
 <20150422151111.GG20701@google.com>
MIME-Version: 1.0
In-Reply-To: <20150422151111.GG20701@google.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Apr 22, 2015 at 04:11:11PM +0100, Bjorn Helgaas wrote:
> On Wed, Apr 22, 2015 at 09:35:59PM +0800, Zhichang Yuan wrote:
> > In the patch whose commit id is 41f8bba7f5552d0, function pci_pio_to_address
> > was introduced to retieve the corresponding I/O port by CPU address. But the
> > convertion processing is not correct. It will return a wrong I/O port.
> > This patch will fix it.
> 
> Hmmm, this subject and changelog don't seem right.  41f8bba7f555 did add
> pci_pio_to_address(), but that converts an I/O port to a CPU address, and
> this patch doesn't touch that function.
> 
> This patch changes pci_address_to_pio(), which does return the I/O port
> corresponding to a CPU physical address.  This function was modified (but
> not added) by 41f8bba7f555.
> 
> Please add:
> 
> Fixes: 41f8bba7f555 ("of/pci: Add pci_register_io_range() and pci_pio_to_address()")
> CC: stable@vger.kernel.org	# v3.18+
> 
> > Signed-off-by: Zhichang Yuan <yuanzhichang@hisilicon.com>
> > ---
> >  drivers/of/address.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/of/address.c b/drivers/of/address.c
> > index 78a7dcb..6906a3f 100644
> > --- a/drivers/of/address.c
> > +++ b/drivers/of/address.c
> > @@ -765,7 +765,7 @@ unsigned long __weak pci_address_to_pio(phys_addr_t address)
> >  	spin_lock(&io_range_lock);
> >  	list_for_each_entry(res, &io_range_list, list) {
> >  		if (address >= res->start && address < res->start + res->size) {
> > -			addr = res->start - address + offset;
> > +			addr = address - res->start + offset;
> 
> This looks like it's been broken since v3.18, and it's used by many
> platforms.  I/O port space isn't as common as it used to be, but it's still
> surprising that nobody noticed until now.

Add to that the fact that the code is guarded by PCI_IOBASE and the resulting
number of affected architectures shrinks to 4: arm, arm64, microblaze and
unicore32. Microblaze gets struck off the list because it re-implements the
function, which leaves mainly ARM architectures.

Main user of this function now is of_pci_range_to_resource() which
was newly added and used by my generic parsing code. of_address_to_resource() also
uses pci_address_to_pio() but only microblaze would fall under all the right
conditions and that is protected due to re-implementation.

> 
> This change does look correct to me, but I want to double-check that we're
> actually going to *fix* a bunch of platforms rather than breaking them.

My guess is that Zhichang was the first to experience the issue unless there
are systems out there that have a host bridge with two IO ranges (or two
host bridges each one IO range) that are silently using the wrong IO port
addresses.

Fixing latest stable might be enough as there are no affected users of the earlier
code?

Best regards,
Liviu

> 
> >  			break;
> >  		}
> >  		offset += res->size;
> > -- 
> > 1.9.1
> > 
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯

