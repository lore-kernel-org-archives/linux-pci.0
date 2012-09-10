Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:61121 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753766Ab2IJWr6 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 10 Sep 2012 18:47:58 -0400
Received: by lagy9 with SMTP id y9so1492199lag.19
        for <linux-pci@vger.kernel.org>; Mon, 10 Sep 2012 15:47:57 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20120904143946.25201.77305.stgit@localhost.localdomain>
References: <20120904143946.25201.77305.stgit@localhost.localdomain>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 10 Sep 2012 16:47:36 -0600
Message-ID: <CAErSpo5c8y8mO7QAUr2tUn-SAMhzcbaC4secHzw1k--uUoK60A@mail.gmail.com>
Subject: Re: [PATCH] cpqphp_ctrl: remove unreachable path
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-pci@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Sep 4, 2012 at 8:39 AM, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> From: Alan Cox <alan@linux.intel.com>
>
> register & 0x0B == 0x04 is never true, the code will always take the
> (identical) 0x00 path anyway. Remove the dead code paths.
>
> Resolves-bug: https://bugzilla.kernel.org/show_bug.cgi?id=44151
> Signed-off-by: Alan Cox <alan@linux.intel.com>

Applied to my "pci/trivial" branch, thanks!

Bjorn

> ---
>
>  drivers/pci/hotplug/cpqphp_ctrl.c |   21 +--------------------
>  1 file changed, 1 insertion(+), 20 deletions(-)
>
> diff --git a/drivers/pci/hotplug/cpqphp_ctrl.c b/drivers/pci/hotplug/cpqphp_ctrl.c
> index e43908d..36112fe 100644
> --- a/drivers/pci/hotplug/cpqphp_ctrl.c
> +++ b/drivers/pci/hotplug/cpqphp_ctrl.c
> @@ -2890,27 +2890,8 @@ static int configure_new_function(struct controller *ctrl, struct pci_func *func
>                                                 func->mem_head = mem_node;
>                                         } else
>                                                 return -ENOMEM;
> -                               } else if ((temp_register & 0x0BL) == 0x04) {
> -                                       /* Map memory */
> -                                       base = temp_register & 0xFFFFFFF0;
> -                                       base = ~base + 1;
> -
> -                                       dbg("CND:      length = 0x%x\n", base);
> -                                       mem_node = get_resource(&(resources->mem_head), base);
> -
> -                                       /* allocate the resource to the board */
> -                                       if (mem_node) {
> -                                               base = mem_node->base;
> -
> -                                               mem_node->next = func->mem_head;
> -                                               func->mem_head = mem_node;
> -                                       } else
> -                                               return -ENOMEM;
> -                               } else if ((temp_register & 0x0BL) == 0x06) {
> -                                       /* Those bits are reserved, we can't handle this */
> -                                       return 1;
>                                 } else {
> -                                       /* Requesting space below 1M */
> +                                       /* Reserved bits or requesting space below 1M */
>                                         return NOT_ENOUGH_RESOURCES;
>                                 }
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
