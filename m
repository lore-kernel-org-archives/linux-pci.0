Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:40224 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751765AbcDER7x (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 5 Apr 2016 13:59:53 -0400
Date: Tue, 5 Apr 2016 12:59:49 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jake Oshins <jakeo@microsoft.com>
Cc: linux-pci@vger.kernel.org, gregkh@linuxfoundation.org,
	kys@microsoft.com, linux-kernel@vger.kernel.org,
	devel@linuxdriverproject.org, olaf@aepfle.de, apw@canonical.com,
	vkuznets@redhat.com, haiyangz@microsoft.com, haddenh@microsoft.com
Subject: Re: [PATCH v4 3/7] drivers:hv: Use new vmbus_mmio_free() from client
 drivers.
Message-ID: <20160405175949.GA15353@localhost>
References: <y>
 <1459558067-1725-1-git-send-email-jakeo@microsoft.com>
 <1459558067-1725-4-git-send-email-jakeo@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1459558067-1725-4-git-send-email-jakeo@microsoft.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Jake,

On Fri, Apr 01, 2016 at 05:47:43PM -0700, Jake Oshins wrote:
> This patch modifies all the callers of vmbus_mmio_allocate()
> to call vmbus_mmio_free() instead of release_mem_region().

This changelog merely restates the C code.  Presumably there's some
important difference between release_mem_region() and
vmbus_mmio_free(), and we need a hint about what that is.

Oh, I see, there actually is no difference *yet*, but it's coming.
I'd combine this with patch 2.  Then the patch is obviously correct
all by itself, and the changelog for patch 2 makes clear what's
happening.

In changelogs, don't bother with "this patch does" or "this function
is introduced."  The context is obvious because the changelog is part
of the commit.  Write imperative sentences, e.g., "Call
vmbus_mmio_free() instead of release_mem_region()."

> Signed-off-by: Jake Oshins <jakeo@microsoft.com>

I think this is the only change that touches PCI, so I assume this
series will be merged by somebody else.

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  drivers/pci/host/pci-hyperv.c   | 14 +++++++-------
>  drivers/video/fbdev/hyperv_fb.c |  4 ++--
>  2 files changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/pci/host/pci-hyperv.c b/drivers/pci/host/pci-hyperv.c
> index ed651ba..f2559b6 100644
> --- a/drivers/pci/host/pci-hyperv.c
> +++ b/drivers/pci/host/pci-hyperv.c
> @@ -1795,14 +1795,14 @@ static void hv_pci_free_bridge_windows(struct hv_pcibus_device *hbus)
>  
>  	if (hbus->low_mmio_space && hbus->low_mmio_res) {
>  		hbus->low_mmio_res->flags |= IORESOURCE_BUSY;
> -		release_mem_region(hbus->low_mmio_res->start,
> -				   resource_size(hbus->low_mmio_res));
> +		vmbus_free_mmio(hbus->low_mmio_res->start,
> +				resource_size(hbus->low_mmio_res));
>  	}
>  
>  	if (hbus->high_mmio_space && hbus->high_mmio_res) {
>  		hbus->high_mmio_res->flags |= IORESOURCE_BUSY;
> -		release_mem_region(hbus->high_mmio_res->start,
> -				   resource_size(hbus->high_mmio_res));
> +		vmbus_free_mmio(hbus->high_mmio_res->start,
> +				resource_size(hbus->high_mmio_res));
>  	}
>  }
>  
> @@ -1880,8 +1880,8 @@ static int hv_pci_allocate_bridge_windows(struct hv_pcibus_device *hbus)
>  
>  release_low_mmio:
>  	if (hbus->low_mmio_res) {
> -		release_mem_region(hbus->low_mmio_res->start,
> -				   resource_size(hbus->low_mmio_res));
> +		vmbus_free_mmio(hbus->low_mmio_res->start,
> +				resource_size(hbus->low_mmio_res));
>  	}
>  
>  	return ret;
> @@ -1924,7 +1924,7 @@ static int hv_allocate_config_window(struct hv_pcibus_device *hbus)
>  
>  static void hv_free_config_window(struct hv_pcibus_device *hbus)
>  {
> -	release_mem_region(hbus->mem_config->start, PCI_CONFIG_MMIO_LENGTH);
> +	vmbus_free_mmio(hbus->mem_config->start, PCI_CONFIG_MMIO_LENGTH);
>  }
>  
>  /**
> diff --git a/drivers/video/fbdev/hyperv_fb.c b/drivers/video/fbdev/hyperv_fb.c
> index e2451bd..2fd49b2 100644
> --- a/drivers/video/fbdev/hyperv_fb.c
> +++ b/drivers/video/fbdev/hyperv_fb.c
> @@ -743,7 +743,7 @@ static int hvfb_getmem(struct hv_device *hdev, struct fb_info *info)
>  err3:
>  	iounmap(fb_virt);
>  err2:
> -	release_mem_region(par->mem->start, screen_fb_size);
> +	vmbus_free_mmio(par->mem->start, screen_fb_size);
>  	par->mem = NULL;
>  err1:
>  	if (!gen2vm)
> @@ -758,7 +758,7 @@ static void hvfb_putmem(struct fb_info *info)
>  	struct hvfb_par *par = info->par;
>  
>  	iounmap(info->screen_base);
> -	release_mem_region(par->mem->start, screen_fb_size);
> +	vmbus_free_mmio(par->mem->start, screen_fb_size);
>  	par->mem = NULL;
>  }
>  
> -- 
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
