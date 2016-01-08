Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:34882 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756058AbcAHSLc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 8 Jan 2016 13:11:32 -0500
Date: Fri, 8 Jan 2016 12:11:26 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Julia Lawall <Julia.Lawall@lip6.fr>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH] shpchp: constify hpc_ops structure
Message-ID: <20160108181126.GD5354@localhost>
References: <1450902935-20302-1-git-send-email-Julia.Lawall@lip6.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1450902935-20302-1-git-send-email-Julia.Lawall@lip6.fr>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Dec 23, 2015 at 09:35:35PM +0100, Julia Lawall wrote:
> The hpc_ops structure is never modified, so declare it as const.
> 
> Done with the help of Coccinelle.
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

Applied to pci/trivial for v4.5, thanks, Julia!

> ---
>  drivers/pci/hotplug/shpchp.h     |    4 ++--
>  drivers/pci/hotplug/shpchp_hpc.c |    2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/hotplug/shpchp.h b/drivers/pci/hotplug/shpchp.h
> index 5897d51..3059c34 100644
> --- a/drivers/pci/hotplug/shpchp.h
> +++ b/drivers/pci/hotplug/shpchp.h
> @@ -84,7 +84,7 @@ struct slot {
>  	u8 presence_save;
>  	u8 pwr_save;
>  	struct controller *ctrl;
> -	struct hpc_ops *hpc_ops;
> +	const struct hpc_ops *hpc_ops;
>  	struct hotplug_slot *hotplug_slot;
>  	struct list_head	slot_list;
>  	struct delayed_work work;	/* work for button event */
> @@ -106,7 +106,7 @@ struct controller {
>  	int slot_num_inc;		/* 1 or -1 */
>  	struct pci_dev *pci_dev;
>  	struct list_head slot_list;
> -	struct hpc_ops *hpc_ops;
> +	const struct hpc_ops *hpc_ops;
>  	wait_queue_head_t queue;	/* sleep & wake process */
>  	u8 slot_device_offset;
>  	u32 pcix_misc2_reg;	/* for amd pogo errata */
> diff --git a/drivers/pci/hotplug/shpchp_hpc.c b/drivers/pci/hotplug/shpchp_hpc.c
> index 7d223e9..43e7906 100644
> --- a/drivers/pci/hotplug/shpchp_hpc.c
> +++ b/drivers/pci/hotplug/shpchp_hpc.c
> @@ -910,7 +910,7 @@ static int shpc_get_max_bus_speed(struct controller *ctrl)
>  	return retval;
>  }
>  
> -static struct hpc_ops shpchp_hpc_ops = {
> +static const struct hpc_ops shpchp_hpc_ops = {
>  	.power_on_slot			= hpc_power_on_slot,
>  	.slot_enable			= hpc_slot_enable,
>  	.slot_disable			= hpc_slot_disable,
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
