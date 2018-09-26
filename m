Return-Path: <SRS0=XSei=MI=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AEF3C43382
	for <linux-pci@archiver.kernel.org>; Wed, 26 Sep 2018 22:23:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A86B921566
	for <linux-pci@archiver.kernel.org>; Wed, 26 Sep 2018 22:23:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="qsQZJBZ4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A86B921566
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726192AbeI0Eic (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 27 Sep 2018 00:38:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:52722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726098AbeI0Eib (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 27 Sep 2018 00:38:31 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 26D202154B;
        Wed, 26 Sep 2018 22:23:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538000604;
        bh=X7qkjEwP7BOTZakDcYCEWTQ0QopV9gugx0KpKUMMevo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qsQZJBZ4qGpsJuqPGph5PcVwOx1jpEIJuppAaBYuagoMw3ORSsjVYfUKuz0qS4gDA
         28BWurpV1p/f0/9y0o7DeP1D9oocGWVlh9yTb8HhngAgR78UUUz594T9cS/iofFb2c
         JmRhOZqKSutM6thcVZX/XyDNcimLs3LMy378VYmY=
Date:   Wed, 26 Sep 2018 17:23:22 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jon Derrick <jonathan.derrick@intel.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sinan Kaya <okaya@kernel.org>, Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v3] PCI: Equalize hotplug memory and io for non/occupied
 slots
Message-ID: <20180926222322.GL28024@bhelgaas-glaptop.roam.corp.google.com>
References: <1537900746-3043-1-git-send-email-jonathan.derrick@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1537900746-3043-1-git-send-email-jonathan.derrick@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Sep 25, 2018 at 12:39:06PM -0600, Jon Derrick wrote:
> Currently, a hotplug bridge will be given hpmemsize additional memory
> and hpiosize additional io if available, in order to satisfy any future
> hotplug allocation requirements.
> 
> These calculations don't consider the current memory/io size of the
> hotplug bridge/slot, so hotplug bridges/slots which have downstream
> devices will be allocated their current allocation in addition to the
> hpmemsize value.
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
> hpmemsize/hpiosize parameters to make the reservations predictable for
> the mix of unoccupied and occupied slots:
> 
> 02:03.0 PCI bridge: <-- Occupied
> 	Memory behind bridge: d6200000-d63fffff [size=2M]
> 02:04.0 PCI bridge: <-- Unoccupied
> 	Memory behind bridge: d6400000-d65fffff [size=2M]
> 
> Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>

Applied to pci/hotplug for v4.20, thanks!

> ---
> v2->v3: Made the IO and mem size calculations nearly equivalent
> 
>  drivers/pci/setup-bus.c | 28 +++++++++++++++-------------
>  1 file changed, 15 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> index 79b1824..ed96043 100644
> --- a/drivers/pci/setup-bus.c
> +++ b/drivers/pci/setup-bus.c
> @@ -811,6 +811,8 @@ static struct resource *find_free_bus_resource(struct pci_bus *bus,
>  static resource_size_t calculate_iosize(resource_size_t size,
>  		resource_size_t min_size,
>  		resource_size_t size1,
> +		resource_size_t add_size,
> +		resource_size_t children_add_size,
>  		resource_size_t old_size,
>  		resource_size_t align)
>  {
> @@ -823,15 +825,18 @@ static resource_size_t calculate_iosize(resource_size_t size,
>  #if defined(CONFIG_ISA) || defined(CONFIG_EISA)
>  	size = (size & 0xff) + ((size & ~0xffUL) << 2);
>  #endif
> -	size = ALIGN(size + size1, align);
> +	size = size + size1;
>  	if (size < old_size)
>  		size = old_size;
> +
> +	size = ALIGN(max(size, add_size) + children_add_size, align);
>  	return size;
>  }
>  
>  static resource_size_t calculate_memsize(resource_size_t size,
>  		resource_size_t min_size,
> -		resource_size_t size1,
> +		resource_size_t add_size,
> +		resource_size_t children_add_size,
>  		resource_size_t old_size,
>  		resource_size_t align)
>  {
> @@ -841,7 +846,8 @@ static resource_size_t calculate_memsize(resource_size_t size,
>  		old_size = 0;
>  	if (size < old_size)
>  		size = old_size;
> -	size = ALIGN(size + size1, align);
> +
> +	size = ALIGN(max(size, add_size) + children_add_size, align);
>  	return size;
>  }
>  
> @@ -930,12 +936,10 @@ static void pbus_size_io(struct pci_bus *bus, resource_size_t min_size,
>  		}
>  	}
>  
> -	size0 = calculate_iosize(size, min_size, size1,
> +	size0 = calculate_iosize(size, min_size, size1, 0, 0,
>  			resource_size(b_res), min_align);
> -	if (children_add_size > add_size)
> -		add_size = children_add_size;
> -	size1 = (!realloc_head || (realloc_head && !add_size)) ? size0 :
> -		calculate_iosize(size, min_size, add_size + size1,
> +	size1 = (!realloc_head || (realloc_head && !add_size && !children_add_size)) ? size0 :
> +		calculate_iosize(size, min_size, size1, add_size, children_add_size,
>  			resource_size(b_res), min_align);
>  	if (!size0 && !size1) {
>  		if (b_res->start || b_res->end)
> @@ -1079,12 +1083,10 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
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
