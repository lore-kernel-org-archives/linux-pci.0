Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:48260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727748AbeHHUVI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 8 Aug 2018 16:21:08 -0400
Date: Wed, 8 Aug 2018 13:00:19 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: AceLan Kao <acelan.kao@canonical.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: Fix calculation of bridge window's size
Message-ID: <20180808180019.GE49411@bhelgaas-glaptop.roam.corp.google.com>
References: <20180808054837.19717-1-acelan.kao@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180808054837.19717-1-acelan.kao@canonical.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Aug 08, 2018 at 01:48:37PM +0800, AceLan Kao wrote:
> There are some 0 resource size pci devices, and it leads to the
> accumulator fails to maintain the correct value.
> It results in a strange issue on my machine that xhci_hcd failed to init.
>    [    2.437278] xhci_hcd 0000:05:00.0: init 0000:05:00.0 fail, -16
>    [    2.437300] xhci_hcd: probe of 0000:05:00.0 failed with error -16

I don't think it's possible for a PCI device to have a BAR of zero
size.  Bits 0-3 of memory BARs are read-only, leading to a minimum BAR
size of 16 bytes; similarly, bits 0-1 of I/O BARs are read-only,
giving a minimum size of 4 ports.

My guess is that if you have a pci_dev with a resource that looks like
it's valid but has zero size, that resource came from OF or device
tree.  If that's the case, I'd say we should fix the OF or DT parsing
code to reject those resources.  If we do that, we shouldn't need the
patch below.

Can you open a bugzilla.kernel.org report and attach the complete
dmesg log leading up to this, as well as the "sudo lspci -vv" output
for this device?  It should have clues about how we got here.

> To fix this, check if the resource size equals to 0, doesn't increase size.
> 
> Fixes: c9c75143a596 ("PCI: Fix calculation of bridge window's size and alignment")
> CC: stable@vger.kernel.org # 4.14+
> 
> Signed-off-by: AceLan Kao <acelan.kao@canonical.com>
> ---
>  drivers/pci/setup-bus.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> index 79b1824e83b4..ae05dde8c6e3 100644
> --- a/drivers/pci/setup-bus.c
> +++ b/drivers/pci/setup-bus.c
> @@ -1061,7 +1061,8 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
>  				r->flags = 0;
>  				continue;
>  			}
> -			size += max(r_size, align);
> +			if (r_size != 0)
> +				size += max(r_size, align);
>  			/* Exclude ranges with size > align from
>  			   calculation of the alignment. */
>  			if (r_size <= align)
> -- 
> 2.17.1
> 
