Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:37472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934324AbeB1UhY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 28 Feb 2018 15:37:24 -0500
Date: Wed, 28 Feb 2018 14:37:22 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: cpqphp: Fix possible NULL pointer dereference
Message-ID: <20180228203722.GK127842@bhelgaas-glaptop.roam.corp.google.com>
References: <1519524102-121438-1-git-send-email-shawn.lin@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1519524102-121438-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, Feb 25, 2018 at 10:01:42AM +0800, Shawn Lin wrote:
> io_node is used before verify whether it's null pointer,
> so move the check of null pointer immediately after.
> 
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

Applied to pci/hotplug for v4.17, thanks!

> ---
> 
>  drivers/pci/hotplug/cpqphp_ctrl.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/pci/hotplug/cpqphp_ctrl.c b/drivers/pci/hotplug/cpqphp_ctrl.c
> index b1b6e45..616df44 100644
> --- a/drivers/pci/hotplug/cpqphp_ctrl.c
> +++ b/drivers/pci/hotplug/cpqphp_ctrl.c
> @@ -2812,18 +2812,16 @@ static int configure_new_function(struct controller *ctrl, struct pci_func *func
>  
>  					dbg("CND:      length = 0x%x\n", base);
>  					io_node = get_io_resource(&(resources->io_head), base);
> +					if (!io_node)
> +						return -ENOMEM;
>  					dbg("Got io_node start = %8.8x, length = %8.8x next (%p)\n",
>  					    io_node->base, io_node->length, io_node->next);
>  					dbg("func (%p) io_head (%p)\n", func, func->io_head);
>  
>  					/* allocate the resource to the board */
> -					if (io_node) {
> -						base = io_node->base;
> -
> -						io_node->next = func->io_head;
> -						func->io_head = io_node;
> -					} else
> -						return -ENOMEM;
> +					base = io_node->base;
> +					io_node->next = func->io_head;
> +					func->io_head = io_node;
>  				} else if ((temp_register & 0x0BL) == 0x08) {
>  					/* Map prefetchable memory */
>  					base = temp_register & 0xFFFFFFF0;
> -- 
> 1.9.1
> 
> 
