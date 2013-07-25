Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oa0-f49.google.com ([209.85.219.49]:44904 "EHLO
	mail-oa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753048Ab3GYUfz (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 25 Jul 2013 16:35:55 -0400
Received: by mail-oa0-f49.google.com with SMTP id n12so5416971oag.8
        for <linux-pci@vger.kernel.org>; Thu, 25 Jul 2013 13:35:54 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1374759098-6746-1-git-send-email-yinghai@kernel.org>
References: <1374759098-6746-1-git-send-email-yinghai@kernel.org>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 25 Jul 2013 14:35:33 -0600
Message-ID: <CAErSpo79rJZuEkJB+W0XGq-sKUDwTgrG5SVzJbFBqobLY2+nGQ@mail.gmail.com>
Subject: Re: [PATCH v6] PCI: Don't let mmio fallback to must-only, if ioport
 fails with must+optional
To: Yinghai Lu <yinghai@kernel.org>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jul 25, 2013 at 7:31 AM, Yinghai Lu <yinghai@kernel.org> wrote:
> BenH reported that there are assign unassigned resource problems
> in powerpc.
>
> It turns out after
> | commit 0c5be0cb0edfe3b5c4b62eac68aa2aa15ec681af
> | Date:   Thu Feb 23 19:23:29 2012 -0800
> |
> |    PCI: Retry on IORESOURCE_IO type allocations
>
> even for root bus that does not have io port range, it will keep retrying
> to realloc with mmio after mmio allocation work in first try already.
>
> Current retry logic is : try with must+optional at first, and if
> it fails with any ioport or mmio, it will try must then try to extend
> must with optional. The reassign will put extended mmio or pref mmio
> in the middle of parent resource range.
> That will prevent other sibling resources from getting must-have resources
> or get extended properly.
>
> We can check fail type to see if can we need fall back to must-have
> for it only, that will keep others type to keep resource to have
> must+optional allocations.
>
> Separate three resource type checking if we need to release
> assigned resource after requested + add_size try.
> 1. if there is io port assign fail, will release assigned io port.
> 2. if there is pref mmio assign fail, release assigned pref mmio.
>    if assigned pref mmio's parent is non-pref mmio and there
>    is non-pref mmio assign fail, will release that assigned pref mmio.
> 3. if there is non-pref mmio assign fail or pref mmio assigned fail,
>    will release assigned non-pref mmio.
>
> This will be become more often when we have x86 8 sockets or 32 sockets
> system, and those systems will have one root bus per socket.
> They will have some root buses that do not have ioport range or 32bit mmio.
>
> -v2: need to remove assigned entries from optional list too.
> -v3: not just checking ioport related, requested by Bjorn.
>
> Reported-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

I forgot; is there a mailing list archive URL for this report?

And did you say this should go to stable for v3.10+?  If that's the
case, this should probably go in my for-linus branch for v3.11 instead
of waiting for v3.12, right?

> Tested-by: Gavin Shan <shangw@linux.vnet.ibm.com>
> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
>
> ---
>  drivers/pci/setup-bus.c |   70 +++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 69 insertions(+), 1 deletion(-)
>
> Index: linux-2.6/drivers/pci/setup-bus.c
> ===================================================================
> --- linux-2.6.orig/drivers/pci/setup-bus.c
> +++ linux-2.6/drivers/pci/setup-bus.c
> @@ -300,6 +300,48 @@ static void assign_requested_resources_s
>         }
>  }
>
> +static unsigned long pci_fail_res_type_mask(struct list_head *fail_head)
> +{
> +       struct pci_dev_resource *fail_res;
> +       unsigned long mask = 0;
> +
> +       /* check failed type */
> +       list_for_each_entry(fail_res, fail_head, list)
> +               mask |= fail_res->flags;
> +
> +       /*
> +        * one pref failed resource will set IORESOURCE_MEM,
> +        * as we can allocate pref in non-pref range.
> +        * Will release all asssigned non-pref sibling resources
> +        * according to that bit.
> +        */
> +       return mask & (IORESOURCE_IO | IORESOURCE_MEM | IORESOURCE_PREFETCH);
> +}
> +
> +static bool pci_need_to_release(unsigned long mask, struct resource *res)
> +{
> +       if (res->flags & IORESOURCE_IO)
> +               return !!(mask & IORESOURCE_IO);
> +
> +       /* check pref at first */
> +       if (res->flags & IORESOURCE_PREFETCH) {
> +               if (mask & IORESOURCE_PREFETCH)
> +                       return true;
> +               /* count pref if its parent is non-pref */
> +               else if ((mask & IORESOURCE_MEM) &&
> +                        !(res->parent->flags & IORESOURCE_PREFETCH))
> +                       return true;
> +               else
> +                       return false;
> +       }
> +
> +       if (res->flags & IORESOURCE_MEM)
> +               return !!(mask & IORESOURCE_MEM);
> +
> +       /* should not get here */
> +       return false;
> +}
> +
>  static void __assign_resources_sorted(struct list_head *head,
>                                  struct list_head *realloc_head,
>                                  struct list_head *fail_head)
> @@ -312,11 +354,24 @@ static void __assign_resources_sorted(st
>          *  if could do that, could get out early.
>          *  if could not do that, we still try to assign requested at first,
>          *    then try to reassign add_size for some resources.
> +        *
> +        * Separate three resource type checking if we need to release
> +        *  assigned resource after requested + add_size try.
> +        *      1. if there is io port assign fail, will release assigned
> +        *         io port.
> +        *      2. if there is pref mmio assign fail, release assigned
> +        *         pref mmio.
> +        *         if assigned pref mmio's parent is non-pref mmio and there
> +        *         is non-pref mmio assign fail, will release that assigned
> +        *         pref mmio.
> +        *      3. if there is non-pref mmio assign fail or pref mmio
> +        *         assigned fail, will release assigned non-pref mmio.
>          */
>         LIST_HEAD(save_head);
>         LIST_HEAD(local_fail_head);
>         struct pci_dev_resource *save_res;
> -       struct pci_dev_resource *dev_res;
> +       struct pci_dev_resource *dev_res, *tmp_res;
> +       unsigned long fail_type;
>
>         /* Check if optional add_size is there */
>         if (!realloc_head || list_empty(realloc_head))
> @@ -348,6 +403,19 @@ static void __assign_resources_sorted(st
>                 return;
>         }
>
> +       /* check failed type */
> +       fail_type = pci_fail_res_type_mask(&local_fail_head);
> +       /* remove not need to be released assigned res from head list etc */
> +       list_for_each_entry_safe(dev_res, tmp_res, head, list)
> +               if (dev_res->res->parent &&
> +                   !pci_need_to_release(fail_type, dev_res->res)) {
> +                       /* remove it from realloc_head list */
> +                       remove_from_list(realloc_head, dev_res->res);
> +                       remove_from_list(&save_head, dev_res->res);
> +                       list_del(&dev_res->list);
> +                       kfree(dev_res);
> +               }
> +
>         free_list(&local_fail_head);
>         /* Release assigned resource */
>         list_for_each_entry(dev_res, head, list)
