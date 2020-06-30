Return-Path: <SRS0=b4XB=AL=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 871AAC433DF
	for <linux-pci@archiver.kernel.org>; Tue, 30 Jun 2020 08:02:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 591232067D
	for <linux-pci@archiver.kernel.org>; Tue, 30 Jun 2020 08:02:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593504151;
	bh=l9em1xuyarZs6WU6lGVQVTbwQfuLz7IEaQ69vwvjbR0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=L7JXhChloyVKuxUfQyAf2tM7SK1m6btt2jIG7X+yspnKkZISqghphu52oBEMTXC0a
	 dSlixS9FWBptSuCR0YLBzYUvIx+4J09F3hLFpE7XFcaFbe50tuFnp29mPlotlGbGv8
	 wcSXLlAEczQU37O+P781tv0/YWIt8E0/JKd8Ufrk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728126AbgF3IC2 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 30 Jun 2020 04:02:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:42410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726994AbgF3ICY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 30 Jun 2020 04:02:24 -0400
Received: from localhost (unknown [84.241.197.94])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D604B2067D;
        Tue, 30 Jun 2020 08:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593504143;
        bh=l9em1xuyarZs6WU6lGVQVTbwQfuLz7IEaQ69vwvjbR0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oKxVuVQjOlEV89XeGjZL+EsE+ssdpkUV5c1dxojW7lqFvXHdE3E11ratNJHAnBnMQ
         zeCuWnHl/2+If7Tp5g3qPlSHj8wOwKEjZeaSuNw82UTwMiTXYQ7SO8ce8ixj5l/2yI
         i/Qn7sOpT0LMWB/KPsX/pjQEeVZYwm82uqwScFWY=
Date:   Tue, 30 Jun 2020 10:02:20 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Rajat Jain <rajatja@google.com>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, Raj Ashok <ashok.raj@intel.com>,
        lalithambika.krishnakumar@intel.com,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Prashant Malani <pmalani@google.com>,
        Benson Leung <bleung@google.com>,
        Todd Broch <tbroch@google.com>,
        Alex Levin <levinale@google.com>,
        Mattias Nissler <mnissler@google.com>,
        Rajat Jain <rajatxjain@gmail.com>,
        Bernie Keany <bernie.keany@intel.com>,
        Aaron Durbin <adurbin@google.com>,
        Diego Rivas <diegorivas@google.com>,
        Duncan Laurie <dlaurie@google.com>,
        Furquan Shaikh <furquan@google.com>,
        Jesse Barnes <jsbarnes@google.com>,
        Christian Kellner <christian@kellner.me>,
        Alex Williamson <alex.williamson@redhat.com>, oohall@gmail.com,
        Saravana Kannan <saravanak@google.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH v2 4/7] PCI: Add device even if driver attach failed
Message-ID: <20200630080220.GC619174@kroah.com>
References: <20200630044943.3425049-1-rajatja@google.com>
 <20200630044943.3425049-5-rajatja@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200630044943.3425049-5-rajatja@google.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jun 29, 2020 at 09:49:40PM -0700, Rajat Jain wrote:
> device_attach() returning failure indicates a driver error while trying to
> probe the device. In such a scenario, the PCI device should still be added
> in the system and be visible to the user.
> 
> This patch partially reverts:
> commit ab1a187bba5c ("PCI: Check device_attach() return value always")
> 
> Signed-off-by: Rajat Jain <rajatja@google.com>
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
> v2: Cosmetic change in commit log.
>     Add Greg's "reviewed-by"
> 
>  drivers/pci/bus.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
> index 8e40b3e6da77d..3cef835b375fd 100644
> --- a/drivers/pci/bus.c
> +++ b/drivers/pci/bus.c
> @@ -322,12 +322,8 @@ void pci_bus_add_device(struct pci_dev *dev)
>  
>  	dev->match_driver = true;
>  	retval = device_attach(&dev->dev);
> -	if (retval < 0 && retval != -EPROBE_DEFER) {
> +	if (retval < 0 && retval != -EPROBE_DEFER)
>  		pci_warn(dev, "device attach failed (%d)\n", retval);
> -		pci_proc_detach_device(dev);
> -		pci_remove_sysfs_dev_files(dev);
> -		return;
> -	}
>  
>  	pci_dev_assign_added(dev, true);
>  }

This should go first in the series, and cc: stable and get merged now.
No need to tie it to this series at all.

Or just an independant patch, it doesn't have much to do with this
series, it's a bugfix.

thanks,

greg k-h
