Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oa0-f42.google.com ([209.85.219.42]:62884 "EHLO
	mail-oa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752396Ab3GIT2D (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 9 Jul 2013 15:28:03 -0400
Received: by mail-oa0-f42.google.com with SMTP id j6so8605042oag.29
        for <linux-pci@vger.kernel.org>; Tue, 09 Jul 2013 12:28:02 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20130709023846.GB7094@weiyang.vnet.ibm.com>
References: <1372691432-6440-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1372691432-6440-2-git-send-email-weiyang@linux.vnet.ibm.com>
 <CAErSpo4tejULHMTzSf31suh1jnU=9vx-u4PnV2EJfKBuWqeEkw@mail.gmail.com> <20130709023846.GB7094@weiyang.vnet.ibm.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 9 Jul 2013 13:27:42 -0600
Message-ID: <CAErSpo4XqeY5XH3qpc2sKuec8BakUAQkjZKB9X3eKg2uFi6L6g@mail.gmail.com>
Subject: Re: [PATCH 1/4] PCI: optimize pci_bus_get_depth() by enumerating on
 pci bus hierachy
To: Wei Yang <weiyang@linux.vnet.ibm.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Ram Pai <linuxram@us.ibm.com>,
	Gavin Shan <shangw@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jul 8, 2013 at 8:38 PM, Wei Yang <weiyang@linux.vnet.ibm.com> wrote:
> On Mon, Jul 08, 2013 at 02:46:17PM -0600, Bjorn Helgaas wrote:
>>On Mon, Jul 1, 2013 at 9:10 AM, Wei Yang <weiyang@linux.vnet.ibm.com> wrote:
>>> Normally, on one pci bus there would be more devices than pci buses. When
>>> calculating the depth of pci bus, it would be more time efficient by
>>> enumerating through the child buses instead of the child devices.
>>>
>>> Also by doing so, the code seems more self explaining. Previously, it go
>>> through the pci devices and check whether a bridge introduce a child bus or
>>> not, which needs more background knowledge to understand it.
>>>
>>> This patch caculating the depth by enumerating on pci bus hierachy in an
>>> iterative way.
>>
>>Your code does have the advantage of not being recursive, but the
>>original code is significantly shorter and, in my opinion, much more
>>readable.  This is not in a performance path, so I don't see any
>>advantage in optimizing.
>
> Thanks for your comments~
>
> Yes, this doesn't benefit a lot on the performance.
>
> The benefit of this code is not only the recursive approach, but on
> calculating the depth of pci bus tree by iterating on pci bus tree instead of
> the pci device tree.
>
> In my mind, there is less pci bus structrue than the pci device structure, and
> hope the code would be more self explaining for the audience by going through
> the pci bus tree to calculate the pci bus tree depth.
>
> My original code looks like below. Do you think this one is more friendly to
> the audience?

Yes.

> @@ -1300,21 +1300,19 @@ static void pci_bus_dump_resources(struct pci_bus *bus)
>  static int __init pci_bus_get_depth(struct pci_bus *bus)
>  {
>         int depth = 0;
> -       struct pci_dev *dev;
> +       struct pci_bus *child_bus;
>
> -       list_for_each_entry(dev, &bus->devices, bus_list) {
> +       list_for_each_entry(child_bus, &bus->children, node){
>                 int ret;
> -               struct pci_bus *b = dev->subordinate;
> -               if (!b)
> -                       continue;
>
> -               ret = pci_bus_get_depth(b);
> +               ret = pci_bus_get_depth(child_bus);
>                 if (ret + 1 > depth)
>                         depth = ret + 1;
>         }
>
>         return depth;
>  }
>
> And yes again, this change will not bring much improvement for the performance.
> If this is not good, just ignore the code. :-)
>
>>
>>> Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
>>> Reviewed-by: Gavin Shan <shangw@linux.vnet.ibm.com>
>>> Reviewed-by: Ram Pai <linuxram@us.ibm.com>
>>> Reviewed-by: Xiao Guangrong <xiaoguangrong@linux.vnet.ibm.com>
>>> Reviewed-by: Mike Qiu <qiudayu@linux.vnet.ibm.com>
>>> ---
>>>  drivers/pci/setup-bus.c |   43 ++++++++++++++++++++++++++++++++-----------
>>>  1 files changed, 32 insertions(+), 11 deletions(-)
>>>
>>> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
>>> index 16abaaa..b333f73 100644
>>> --- a/drivers/pci/setup-bus.c
>>> +++ b/drivers/pci/setup-bus.c
>>> @@ -1299,22 +1299,43 @@ static void pci_bus_dump_resources(struct pci_bus *bus)
>>>
>>>  static int __init pci_bus_get_depth(struct pci_bus *bus)
>>>  {
>>> -       int depth = 0;
>>> -       struct pci_dev *dev;
>>> +       int max_depth, depth;
>>> +       struct pci_bus *parent, *curr;
>>> +       struct list_head *node;
>>>
>>> -       list_for_each_entry(dev, &bus->devices, bus_list) {
>>> -               int ret;
>>> -               struct pci_bus *b = dev->subordinate;
>>> -               if (!b)
>>> -                       continue;
>>> +       /* no child? */
>>> +       if (list_empty(&bus->children))
>>> +               return 0;
>>>
>>> -               ret = pci_bus_get_depth(b);
>>> -               if (ret + 1 > depth)
>>> -                       depth = ret + 1;
>>> +       node = bus->children.next;
>>> +       parent = bus;
>>> +       max_depth = depth = 1;
>>> +
>>> +       while (parent) {
>>> +               /* hit the head, go back to parent level */
>>> +               if (node == &parent->children) {
>>> +                       node = parent->node.next;
>>> +                       parent = parent->parent;
>>> +                       depth--;
>>> +                       continue;
>>> +               }
>>> +               curr = list_entry(node, struct pci_bus, node);
>>> +               /* depth first */
>>> +               if (!list_empty(&curr->children)) {
>>> +                       node = curr->children.next;
>>> +                       parent = curr;
>>> +                       depth++;
>>> +                       if (max_depth < depth)
>>> +                               max_depth = depth;
>>> +               }
>>> +               /* no child, go to the sibling */
>>> +               else
>>> +                       node = curr->node.next;
>>>         }
>>>
>>> -       return depth;
>>> +       return max_depth;
>>>  }
>>> +
>>>  static int __init pci_get_max_depth(void)
>>>  {
>>>         int depth = 0;
>>> --
>>> 1.7.5.4
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
> --
> Richard Yang
> Help you, Help me
>
