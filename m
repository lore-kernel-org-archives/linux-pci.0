Return-Path: <SRS0=AiiY=S3=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9077C43218
	for <linux-pci@archiver.kernel.org>; Thu, 25 Apr 2019 13:34:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DDF8206C0
	for <linux-pci@archiver.kernel.org>; Thu, 25 Apr 2019 13:34:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556199240;
	bh=dV9XlTbgLfc6l1Zn76HX5mbGVBC/wqWySpEVS9uzLzY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=OPVMfhNZc3J+MFuKuNrMmX6/ZOzz/jdYl0ZcYLE6DLl9ePgShclIj4+ec90dYJNlF
	 +x3pJV74reOkPCxfmsmRHM9xcRfI04emK0gSbsRz2zewdmNLomwXI+tpMOGVkT79wm
	 UNh4GbRIgvGcSFz87/f44mO+soXFqD2eebiyFQHc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726514AbfDYNeA (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 25 Apr 2019 09:34:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:42442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726613AbfDYNd7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 25 Apr 2019 09:33:59 -0400
Received: from localhost (173-25-63-173.client.mchsi.com [173.25.63.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C57ED206C0;
        Thu, 25 Apr 2019 13:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556199238;
        bh=dV9XlTbgLfc6l1Zn76HX5mbGVBC/wqWySpEVS9uzLzY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TxKQq1q6alRprReJRDcQULKZSjQgQHbPFr0nCQyrOqWwV4gD+mJhaimtA49Djcm8A
         LFCeWSVOiNpi+lG1MBCk6JC1guxgj7m957cu56k/lihFiQhZnV1NhQrBHVCevZ0c50
         +wzLXgTSa36WQWFBl37Ysn/5ZAQNcecf23pepHGY=
Date:   Thu, 25 Apr 2019 08:33:56 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>
Subject: Re: [PATCH v4 2/4] PCI: Fix serious bug when sizing bridges with
 additional size
Message-ID: <20190425133356.GB214428@google.com>
References: <20190417141610.6730-1-nicholas.johnson-opensource@outlook.com.au>
 <PS2P216MB0642D39B45E16723F74569A480250@PS2P216MB0642.KORP216.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PS2P216MB0642D39B45E16723F74569A480250@PS2P216MB0642.KORP216.PROD.OUTLOOK.COM>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Apr 17, 2019 at 02:16:50PM +0000, Nicholas Johnson wrote:
> Change find_free_bus_resource function to not skip assigned resources
> with non-null parent.
> 
> Add checks in pbus_size_io and pbus_size_mem to return success if
> resource returned from find_free_bus_resource is already allocated.
> 
> This avoids pbus_size_io and pbus_size_mem returning error code to
> __pci_bus_size_bridges when a resource has been successfully assigned in
> a previous pass. This fixes the existing behaviour where space for a
> resource could be reserved multiple times in different parent bridge
> windows. This also greatly reduces the number of failed BAR messages in
> dmesg when Linux assigns resources.

A concrete example for this would be helpful, e.g., a dmesg log
showing space for a single resource being reserved multiple times in
different windows.  This is probably too big for a commit log, so you
could open an issue at bugzilla.kernel.org, attach the complete dmesg
logs there, maybe include snippets here, and include the URL for more
details.

General comment: in English text, include "()" on function names as a
hint to the reader, e.g., you can write

  Change find_free_bus_resource() to not ...

instead of

  Change find_free_bus_resource function ...

> Signed-off-by: Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
> ---
>  drivers/pci/setup-bus.c | 28 +++++++++++++++++++---------
>  1 file changed, 19 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> index a1ca8a11f..5b9ee9945 100644
> --- a/drivers/pci/setup-bus.c
> +++ b/drivers/pci/setup-bus.c
> @@ -752,11 +752,17 @@ static void pci_bridge_check_ranges(struct pci_bus *bus)
>  	}
>  }
>  
> -/* Helper function for sizing routines: find first available
> -   bus resource of a given type. Note: we intentionally skip
> -   the bus resources which have already been assigned (that is,
> -   have non-NULL parent resource). */
> -static struct resource *find_free_bus_resource(struct pci_bus *bus,
> +/*
> + * Helper function for sizing routines: find first bus resource of a given
> + * type. Note: we do not skip the bus resources which have already been
> + * assigned (r->parent != NULL). This is because a resource that is already
> + * assigned (nothing more to be done) will be indistinguishable from one that
> + * failed due to lack of space if we skip assigned resources. If the caller
> + * function cannot tell the difference then it might try to place the
> + * resources in a different window, doubling up on resources or causing
> + * unforeseeable issues.
> + */
> +static struct resource *find_bus_resource_of_type(struct pci_bus *bus,
>  			 unsigned long type_mask, unsigned long type)
>  {
>  	int i;
> @@ -765,7 +771,7 @@ static struct resource *find_free_bus_resource(struct pci_bus *bus,
>  	pci_bus_for_each_resource(bus, r, i) {
>  		if (r == &ioport_resource || r == &iomem_resource)
>  			continue;
> -		if (r && (r->flags & type_mask) == type && !r->parent)
> +		if (r && (r->flags & type_mask) == type)
>  			return r;
>  	}
>  	return NULL;
> @@ -863,14 +869,16 @@ static void pbus_size_io(struct pci_bus *bus, resource_size_t min_size,
>  		resource_size_t add_size, struct list_head *realloc_head)
>  {
>  	struct pci_dev *dev;
> -	struct resource *b_res = find_free_bus_resource(bus, IORESOURCE_IO,
> -							IORESOURCE_IO);
> +	struct resource *b_res = find_bus_resource_of_type(bus, IORESOURCE_IO,
> +					IORESOURCE_IO);
>  	resource_size_t size = 0, size0 = 0, size1 = 0;
>  	resource_size_t children_add_size = 0;
>  	resource_size_t min_align, align;
>  
>  	if (!b_res)
>  		return;
> +	if (b_res->parent)
> +		return;
>  
>  	min_align = window_alignment(bus, IORESOURCE_IO);
>  	list_for_each_entry(dev, &bus->devices, bus_list) {
> @@ -975,7 +983,7 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
>  	resource_size_t min_align, align, size, size0, size1;
>  	resource_size_t aligns[18];	/* Alignments from 1Mb to 128Gb */
>  	int order, max_order;
> -	struct resource *b_res = find_free_bus_resource(bus,
> +	struct resource *b_res = find_bus_resource_of_type(bus,
>  					mask | IORESOURCE_PREFETCH, type);
>  	resource_size_t children_add_size = 0;
>  	resource_size_t children_add_align = 0;
> @@ -983,6 +991,8 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
>  
>  	if (!b_res)
>  		return -ENOSPC;
> +	if (b_res->parent)
> +		return 0;
>  
>  	memset(aligns, 0, sizeof(aligns));
>  	max_order = 0;
> -- 
> 2.20.1
> 
