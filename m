Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:34238 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751465AbaGHWYr (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 8 Jul 2014 18:24:47 -0400
Received: by mail-pa0-f53.google.com with SMTP id ey11so8027085pad.40
        for <linux-pci@vger.kernel.org>; Tue, 08 Jul 2014 15:24:47 -0700 (PDT)
Date: Tue, 8 Jul 2014 16:24:42 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Guo Chao <yan@linux.vnet.ibm.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v4 1/3] PCI: Fix bus align checking to support more than
 8G
Message-ID: <20140708222442.GA13700@google.com>
References: <1404420379-20983-1-git-send-email-yinghai@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1404420379-20983-1-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jul 03, 2014 at 01:46:17PM -0700, Yinghai Lu wrote:
> Use 128G instead.
> 
> Signed-off-by: Yinghai Lu <yinghai@kernel.org>

I applied this one to pci/resource for v3.17, thanks!

I didn't apply [2/3] or [3/3] because the questions I raised earlier
haven't been resolved.

> ---
>  drivers/pci/setup-bus.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Index: linux-2.6/drivers/pci/setup-bus.c
> ===================================================================
> --- linux-2.6.orig/drivers/pci/setup-bus.c
> +++ linux-2.6/drivers/pci/setup-bus.c
> @@ -925,7 +925,7 @@ static int pbus_size_mem(struct pci_bus
>  {
>  	struct pci_dev *dev;
>  	resource_size_t min_align, align, size, size0, size1;
> -	resource_size_t aligns[14];	/* Alignments from 1Mb to 8Gb */
> +	resource_size_t aligns[18];	/* Alignments from 1Mb to 128Gb */
>  	int order, max_order;
>  	struct resource *b_res = find_free_bus_resource(bus,
>  					mask | IORESOURCE_PREFETCH, type);
