Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e28smtp03.in.ibm.com ([122.248.162.3]:33870 "EHLO
	e28smtp03.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751696Ab3GICi4 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 8 Jul 2013 22:38:56 -0400
Received: from /spool/local
	by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <weiyang@linux.vnet.ibm.com>;
	Tue, 9 Jul 2013 08:02:28 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
	by d28dlp03.in.ibm.com (Postfix) with ESMTP id 823AB1258043
	for <linux-pci@vger.kernel.org>; Tue,  9 Jul 2013 08:08:02 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
	by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id r692cj8Q24379578
	for <linux-pci@vger.kernel.org>; Tue, 9 Jul 2013 08:08:46 +0530
Received: from d28av02.in.ibm.com (loopback [127.0.0.1])
	by d28av02.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id r692clTC011847
	for <linux-pci@vger.kernel.org>; Tue, 9 Jul 2013 12:38:48 +1000
Date: Tue, 9 Jul 2013 10:38:46 +0800
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Ram Pai <linuxram@us.ibm.com>,
	Gavin Shan <shangw@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/4] PCI: optimize pci_bus_get_depth() by enumerating on
 pci bus hierachy
Message-ID: <20130709023846.GB7094@weiyang.vnet.ibm.com>
Reply-To: Wei Yang <weiyang@linux.vnet.ibm.com>
References: <1372691432-6440-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1372691432-6440-2-git-send-email-weiyang@linux.vnet.ibm.com>
 <CAErSpo4tejULHMTzSf31suh1jnU=9vx-u4PnV2EJfKBuWqeEkw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAErSpo4tejULHMTzSf31suh1jnU=9vx-u4PnV2EJfKBuWqeEkw@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jul 08, 2013 at 02:46:17PM -0600, Bjorn Helgaas wrote:
>On Mon, Jul 1, 2013 at 9:10 AM, Wei Yang <weiyang@linux.vnet.ibm.com> wrote:
>> Normally, on one pci bus there would be more devices than pci buses. When
>> calculating the depth of pci bus, it would be more time efficient by
>> enumerating through the child buses instead of the child devices.
>>
>> Also by doing so, the code seems more self explaining. Previously, it go
>> through the pci devices and check whether a bridge introduce a child bus or
>> not, which needs more background knowledge to understand it.
>>
>> This patch caculating the depth by enumerating on pci bus hierachy in an
>> iterative way.
>
>Your code does have the advantage of not being recursive, but the
>original code is significantly shorter and, in my opinion, much more
>readable.  This is not in a performance path, so I don't see any
>advantage in optimizing.

Thanks for your comments~

Yes, this doesn't benefit a lot on the performance.

The benefit of this code is not only the recursive approach, but on 
calculating the depth of pci bus tree by iterating on pci bus tree instead of
the pci device tree. 

In my mind, there is less pci bus structrue than the pci device structure, and 
hope the code would be more self explaining for the audience by going through 
the pci bus tree to calculate the pci bus tree depth.

My original code looks like below. Do you think this one is more friendly to
the audience?

@@ -1300,21 +1300,19 @@ static void pci_bus_dump_resources(struct pci_bus *bus)
 static int __init pci_bus_get_depth(struct pci_bus *bus)
 {
        int depth = 0;
-       struct pci_dev *dev;
+       struct pci_bus *child_bus;

-       list_for_each_entry(dev, &bus->devices, bus_list) {
+       list_for_each_entry(child_bus, &bus->children, node){
                int ret;
-               struct pci_bus *b = dev->subordinate;
-               if (!b)
-                       continue;

-               ret = pci_bus_get_depth(b);
+               ret = pci_bus_get_depth(child_bus);
                if (ret + 1 > depth)
                        depth = ret + 1;
        }

        return depth;
 }

And yes again, this change will not bring much improvement for the performance.
If this is not good, just ignore the code. :-)

>
>> Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
>> Reviewed-by: Gavin Shan <shangw@linux.vnet.ibm.com>
>> Reviewed-by: Ram Pai <linuxram@us.ibm.com>
>> Reviewed-by: Xiao Guangrong <xiaoguangrong@linux.vnet.ibm.com>
>> Reviewed-by: Mike Qiu <qiudayu@linux.vnet.ibm.com>
>> ---
>>  drivers/pci/setup-bus.c |   43 ++++++++++++++++++++++++++++++++-----------
>>  1 files changed, 32 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
>> index 16abaaa..b333f73 100644
>> --- a/drivers/pci/setup-bus.c
>> +++ b/drivers/pci/setup-bus.c
>> @@ -1299,22 +1299,43 @@ static void pci_bus_dump_resources(struct pci_bus *bus)
>>
>>  static int __init pci_bus_get_depth(struct pci_bus *bus)
>>  {
>> -       int depth = 0;
>> -       struct pci_dev *dev;
>> +       int max_depth, depth;
>> +       struct pci_bus *parent, *curr;
>> +       struct list_head *node;
>>
>> -       list_for_each_entry(dev, &bus->devices, bus_list) {
>> -               int ret;
>> -               struct pci_bus *b = dev->subordinate;
>> -               if (!b)
>> -                       continue;
>> +       /* no child? */
>> +       if (list_empty(&bus->children))
>> +               return 0;
>>
>> -               ret = pci_bus_get_depth(b);
>> -               if (ret + 1 > depth)
>> -                       depth = ret + 1;
>> +       node = bus->children.next;
>> +       parent = bus;
>> +       max_depth = depth = 1;
>> +
>> +       while (parent) {
>> +               /* hit the head, go back to parent level */
>> +               if (node == &parent->children) {
>> +                       node = parent->node.next;
>> +                       parent = parent->parent;
>> +                       depth--;
>> +                       continue;
>> +               }
>> +               curr = list_entry(node, struct pci_bus, node);
>> +               /* depth first */
>> +               if (!list_empty(&curr->children)) {
>> +                       node = curr->children.next;
>> +                       parent = curr;
>> +                       depth++;
>> +                       if (max_depth < depth)
>> +                               max_depth = depth;
>> +               }
>> +               /* no child, go to the sibling */
>> +               else
>> +                       node = curr->node.next;
>>         }
>>
>> -       return depth;
>> +       return max_depth;
>>  }
>> +
>>  static int __init pci_get_max_depth(void)
>>  {
>>         int depth = 0;
>> --
>> 1.7.5.4
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Richard Yang
Help you, Help me

