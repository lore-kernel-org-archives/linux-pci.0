Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:52964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725915AbeHNVFE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 14 Aug 2018 17:05:04 -0400
Date: Tue, 14 Aug 2018 13:16:34 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jon Derrick <jonathan.derrick@intel.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Keith Busch <keith.busch@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Sinan Kaya <okaya@codeaurora.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        Stephen Bates <sbates@raithlin.com>
Subject: Re: [PATCH] PCI: Equalize hotplug memory for non/occupied slots
Message-ID: <20180814181634.GQ113140@bhelgaas-glaptop.roam.corp.google.com>
References: <1532559779-3542-1-git-send-email-jonathan.derrick@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1532559779-3542-1-git-send-email-jonathan.derrick@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jul 25, 2018 at 05:02:59PM -0600, Jon Derrick wrote:
> Currently, a hotplug bridge will be given hpmemsize additional memory if
> available, in order to satisfy any future hotplug allocation
> requirements.
> 
> These calculations don't consider the current memory size of the hotplug
> bridge/slot, so hotplug bridges/slots which have downstream devices will
> get their current allocation in addition to the hpmemsize value.
> 
> This makes for possibly undesirable results with a mix of unoccupied and
> occupied slots (ex, with hpmemsize=2M):
> 
> 02:03.0 PCI bridge: <-- Occupied
> 	Memory behind bridge: d6200000-d64fffff [size=3M]
> 02:04.0 PCI bridge: <-- Unoccupied
> 	Memory behind bridge: d6500000-d66fffff [size=2M]
> 
> This change considers the current allocation size when using the
> hpmemsize parameter to make the reservations predictable for the mix of
> unoccupied and occupied slots:
> 
> 02:03.0 PCI bridge: <-- Occupied
> 	Memory behind bridge: d6200000-d63fffff [size=2M]
> 02:04.0 PCI bridge: <-- Unoccupied
> 	Memory behind bridge: d6400000-d65fffff [size=2M]

The I/O sizing code (pbus_size_io() and calculate_iosize()) is essentially
identical to the mem sizing code you're updating.  I assume the same
considerations would apply there?  If not, please include a note in the
changelog about why you changed the mem code but not the I/O code.

> Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
> ---
> Original RFC here:
> https://patchwork.ozlabs.org/patch/945374/
> 
> I split this bit out from the RFC while awaiting the pci string handling
> enhancements to handle per-device settings
> 
> Changed from RFC is a simpler algo
> 
>  drivers/pci/setup-bus.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> index 79b1824..5ae39e6 100644
> --- a/drivers/pci/setup-bus.c
> +++ b/drivers/pci/setup-bus.c
> @@ -831,7 +831,8 @@ static resource_size_t calculate_iosize(resource_size_t size,
>  
>  static resource_size_t calculate_memsize(resource_size_t size,
>  		resource_size_t min_size,
> -		resource_size_t size1,
> +		resource_size_t add_size,
> +		resource_size_t children_add_size,
>  		resource_size_t old_size,
>  		resource_size_t align)
>  {
> @@ -841,7 +842,7 @@ static resource_size_t calculate_memsize(resource_size_t size,
>  		old_size = 0;
>  	if (size < old_size)
>  		size = old_size;
> -	size = ALIGN(size + size1, align);
> +	size = ALIGN(max(size, add_size) + children_add_size, align);
>  	return size;
>  }
>  
> @@ -1079,12 +1080,10 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
>  
>  	min_align = calculate_mem_align(aligns, max_order);
>  	min_align = max(min_align, window_alignment(bus, b_res->flags));
> -	size0 = calculate_memsize(size, min_size, 0, resource_size(b_res), min_align);
> +	size0 = calculate_memsize(size, min_size, 0, 0, resource_size(b_res), min_align);
>  	add_align = max(min_align, add_align);
> -	if (children_add_size > add_size)
> -		add_size = children_add_size;
> -	size1 = (!realloc_head || (realloc_head && !add_size)) ? size0 :
> -		calculate_memsize(size, min_size, add_size,
> +	size1 = (!realloc_head || (realloc_head && !add_size && !children_add_size)) ? size0 :
> +		calculate_memsize(size, min_size, add_size, children_add_size,
>  				resource_size(b_res), add_align);
>  	if (!size0 && !size1) {
>  		if (b_res->start || b_res->end)
> -- 
> 1.8.3.1
> 
