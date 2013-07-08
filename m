Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oa0-f41.google.com ([209.85.219.41]:35090 "EHLO
	mail-oa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752833Ab3GHUqi (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 8 Jul 2013 16:46:38 -0400
Received: by mail-oa0-f41.google.com with SMTP id n10so6970920oag.0
        for <linux-pci@vger.kernel.org>; Mon, 08 Jul 2013 13:46:37 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1372691432-6440-2-git-send-email-weiyang@linux.vnet.ibm.com>
References: <1372691432-6440-1-git-send-email-weiyang@linux.vnet.ibm.com> <1372691432-6440-2-git-send-email-weiyang@linux.vnet.ibm.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 8 Jul 2013 14:46:17 -0600
Message-ID: <CAErSpo4tejULHMTzSf31suh1jnU=9vx-u4PnV2EJfKBuWqeEkw@mail.gmail.com>
Subject: Re: [PATCH 1/4] PCI: optimize pci_bus_get_depth() by enumerating on
 pci bus hierachy
To: Wei Yang <weiyang@linux.vnet.ibm.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Ram Pai <linuxram@us.ibm.com>,
	Gavin Shan <shangw@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jul 1, 2013 at 9:10 AM, Wei Yang <weiyang@linux.vnet.ibm.com> wrote:
> Normally, on one pci bus there would be more devices than pci buses. When
> calculating the depth of pci bus, it would be more time efficient by
> enumerating through the child buses instead of the child devices.
>
> Also by doing so, the code seems more self explaining. Previously, it go
> through the pci devices and check whether a bridge introduce a child bus or
> not, which needs more background knowledge to understand it.
>
> This patch caculating the depth by enumerating on pci bus hierachy in an
> iterative way.

Your code does have the advantage of not being recursive, but the
original code is significantly shorter and, in my opinion, much more
readable.  This is not in a performance path, so I don't see any
advantage in optimizing.

> Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
> Reviewed-by: Gavin Shan <shangw@linux.vnet.ibm.com>
> Reviewed-by: Ram Pai <linuxram@us.ibm.com>
> Reviewed-by: Xiao Guangrong <xiaoguangrong@linux.vnet.ibm.com>
> Reviewed-by: Mike Qiu <qiudayu@linux.vnet.ibm.com>
> ---
>  drivers/pci/setup-bus.c |   43 ++++++++++++++++++++++++++++++++-----------
>  1 files changed, 32 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> index 16abaaa..b333f73 100644
> --- a/drivers/pci/setup-bus.c
> +++ b/drivers/pci/setup-bus.c
> @@ -1299,22 +1299,43 @@ static void pci_bus_dump_resources(struct pci_bus *bus)
>
>  static int __init pci_bus_get_depth(struct pci_bus *bus)
>  {
> -       int depth = 0;
> -       struct pci_dev *dev;
> +       int max_depth, depth;
> +       struct pci_bus *parent, *curr;
> +       struct list_head *node;
>
> -       list_for_each_entry(dev, &bus->devices, bus_list) {
> -               int ret;
> -               struct pci_bus *b = dev->subordinate;
> -               if (!b)
> -                       continue;
> +       /* no child? */
> +       if (list_empty(&bus->children))
> +               return 0;
>
> -               ret = pci_bus_get_depth(b);
> -               if (ret + 1 > depth)
> -                       depth = ret + 1;
> +       node = bus->children.next;
> +       parent = bus;
> +       max_depth = depth = 1;
> +
> +       while (parent) {
> +               /* hit the head, go back to parent level */
> +               if (node == &parent->children) {
> +                       node = parent->node.next;
> +                       parent = parent->parent;
> +                       depth--;
> +                       continue;
> +               }
> +               curr = list_entry(node, struct pci_bus, node);
> +               /* depth first */
> +               if (!list_empty(&curr->children)) {
> +                       node = curr->children.next;
> +                       parent = curr;
> +                       depth++;
> +                       if (max_depth < depth)
> +                               max_depth = depth;
> +               }
> +               /* no child, go to the sibling */
> +               else
> +                       node = curr->node.next;
>         }
>
> -       return depth;
> +       return max_depth;
>  }
> +
>  static int __init pci_get_max_depth(void)
>  {
>         int depth = 0;
> --
> 1.7.5.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
