Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:49676 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753145AbbDHDus (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 7 Apr 2015 23:50:48 -0400
Message-ID: <1428464944.4947.69.camel@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/PCI: Add IORESOURCE_MEM_64 for 64-bit resource
 in of parsing
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Paul Mackerras <paulus@samba.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Gavin Shan <gwshan@linux.vnet.ibm.com>,
	Yijing Wang <wangyijing@huawei.com>,
	Anton Blanchard <anton@samba.org>,
	linuxppc-dev@lists.ozlabs.org
Date: Wed, 08 Apr 2015 13:49:04 +1000
In-Reply-To: <1428452669-24824-1-git-send-email-yinghai@kernel.org>
References: <1428452669-24824-1-git-send-email-yinghai@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, 2015-04-07 at 17:24 -0700, Yinghai Lu wrote:
> For device resource PREF bit setting under bridge 64-bit pref resource,
> we need to make sure only set PREF for 64bit resource, so set IORESOUCE_MEM_64
> for 64bit resource during of device resource flags parsing.

> Link: https://bugzilla.kernel.org/show_bug.cgi?id=96261
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=96241

These patches (from the above BZ) aren't right for one thing: You
shouldn't set the IORESOURCE_PREFETCH in the resource itself. This
*will* break stuff.

You can put the resource in a prefetchable region indeed, if you
are on a PCIe-only path (though we should have some arch flag
to check that the host bridge indeed doesn't do any prefetch,
on powerpc we are good there).

But you can't set the "prefetch" bit on the resource because that would
be losing the indication that this resource has side effects. This bit
is used in some cases to enable store gathering when mmap'ing via sysfs
and can be used for similar uses by drivers.

It's one thing to say "you can put non-prefetch BARs in prefetch windows
on that path", it's another one to completely make the BAR looks like
it's prefetchable when it's not.

Cheers,
Ben.


> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>
> Cc: Yijing Wang <wangyijing@huawei.com>
> Cc: Anton Blanchard <anton@samba.org>
> Cc: linuxppc-dev@lists.ozlabs.org
> 
> ---
>  arch/powerpc/kernel/pci_of_scan.c |    4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> Index: linux-2.6/arch/powerpc/kernel/pci_of_scan.c
> ===================================================================
> --- linux-2.6.orig/arch/powerpc/kernel/pci_of_scan.c
> +++ linux-2.6/arch/powerpc/kernel/pci_of_scan.c
> @@ -44,8 +44,10 @@ static unsigned int pci_parse_of_flags(u
>  
>  	if (addr0 & 0x02000000) {
>  		flags = IORESOURCE_MEM | PCI_BASE_ADDRESS_SPACE_MEMORY;
> -		flags |= (addr0 >> 22) & PCI_BASE_ADDRESS_MEM_TYPE_64;
>  		flags |= (addr0 >> 28) & PCI_BASE_ADDRESS_MEM_TYPE_1M;
> +		if (addr0 & 0x01000000)
> +			flags |= IORESOURCE_MEM_64
> +				 | PCI_BASE_ADDRESS_MEM_TYPE_64;
>  		if (addr0 & 0x40000000)
>  			flags |= IORESOURCE_PREFETCH
>  				 | PCI_BASE_ADDRESS_MEM_PREFETCH;


