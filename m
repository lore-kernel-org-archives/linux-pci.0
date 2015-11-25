Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:58241 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751309AbbKYRsW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 25 Nov 2015 12:48:22 -0500
Date: Wed, 25 Nov 2015 11:48:18 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Rajat Jain <rajatxjain@gmail.com>
Subject: Re: [PATCH] PCI: pciehp: Always protect pciehp_disable_slot() with
 hotplug mutex
Message-ID: <20151125174818.GA8869@localhost>
References: <1446415120-14867-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1446415120-14867-1-git-send-email-linux@roeck-us.net>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, Nov 01, 2015 at 01:58:40PM -0800, Guenter Roeck wrote:
> When called from pciehp_sysfs_disable_slot(), the call to
> pciehp_disable_slot() was not protected by the hotplug mutex.
> 
> Cc: Rajat Jain <rajatxjain@gmail.com>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Applied with Rajat's Reviewed-by to pci/hotplug for v4.5, thanks!

> ---
>  drivers/pci/hotplug/pciehp_ctrl.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/pci/hotplug/pciehp_ctrl.c b/drivers/pci/hotplug/pciehp_ctrl.c
> index 4c8f4cde6854..880978b6d534 100644
> --- a/drivers/pci/hotplug/pciehp_ctrl.c
> +++ b/drivers/pci/hotplug/pciehp_ctrl.c
> @@ -511,7 +511,9 @@ int pciehp_sysfs_disable_slot(struct slot *p_slot)
>  	case STATIC_STATE:
>  		p_slot->state = POWEROFF_STATE;
>  		mutex_unlock(&p_slot->lock);
> +		mutex_lock(&p_slot->hotplug_lock);
>  		retval = pciehp_disable_slot(p_slot);
> +		mutex_unlock(&p_slot->hotplug_lock);
>  		mutex_lock(&p_slot->lock);
>  		p_slot->state = STATIC_STATE;
>  		break;
> -- 
> 2.1.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
