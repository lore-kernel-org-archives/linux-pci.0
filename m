Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:55274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966488AbdIYXuD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 25 Sep 2017 19:50:03 -0400
Date: Mon, 25 Sep 2017 18:50:00 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Nicolai Stange <nstange@suse.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Adrian Salido <salidoa@google.com>,
        Sasha Levin <sasha.levin@oracle.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH 3/3] driver core: platform: Don't read past the end of
 "driver_override" buffer
Message-ID: <20170925235000.GI15970@bhelgaas-glaptop.roam.corp.google.com>
References: <20170911074542.16777-1-nstange@suse.de>
 <20170911074542.16777-4-nstange@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170911074542.16777-4-nstange@suse.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Greg, I assume you'll deal with this one?  Just let me know if I
should do something with it.

On Mon, Sep 11, 2017 at 09:45:42AM +0200, Nicolai Stange wrote:
> When printing the driver_override parameter when it is 4095 and 4094 bytes
> long, the printing code would access invalid memory because we need count+1
> bytes for printing.
> 
> Reject driver_override values of these lengths in driver_override_store().
> 
> This is in close analogy to commit 4efe874aace5 ("PCI: Don't read past the
> end of sysfs "driver_override" buffer") from Sasha Levin.
> 
> Fixes: 3d713e0e382e ("driver core: platform: add device binding path 'driver_override'")
> Cc: stable@vger.kernel.org	# v3.17+
> Signed-off-by: Nicolai Stange <nstange@suse.de>
> ---
>  drivers/base/platform.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> index d1bd99271066..9045c5f3734e 100644
> --- a/drivers/base/platform.c
> +++ b/drivers/base/platform.c
> @@ -868,7 +868,8 @@ static ssize_t driver_override_store(struct device *dev,
>  	struct platform_device *pdev = to_platform_device(dev);
>  	char *driver_override, *old, *cp;
>  
> -	if (count > PATH_MAX)
> +	/* We need to keep extra room for a newline */
> +	if (count >= (PAGE_SIZE - 1))
>  		return -EINVAL;
>  
>  	driver_override = kstrndup(buf, count, GFP_KERNEL);
> -- 
> 2.13.5
> 
