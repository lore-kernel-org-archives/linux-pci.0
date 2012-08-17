Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:48536 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752463Ab2HQCez (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 16 Aug 2012 22:34:55 -0400
Received: by lbbgj3 with SMTP id gj3so1867941lbb.19
        for <linux-pci@vger.kernel.org>; Thu, 16 Aug 2012 19:34:53 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <502D9724.2030307@huawei.com>
References: <1345119142-5896-1-git-send-email-wangyijing@huawei.com>
 <1345119142-5896-3-git-send-email-wangyijing@huawei.com> <502D9724.2030307@huawei.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 16 Aug 2012 20:34:33 -0600
Message-ID: <CAErSpo7P7VtXBhZ2FTM8ozriyfjpRFp0V4HAVrqaiyMhhQpFTw@mail.gmail.com>
Subject: Re: [PATCH 3/3] PCI, acpiphp: Use res->flags to determine whether the
 resouce is valid
To: Yijing Wang <wangyijing@huawei.com>
Cc: linux-pci@vger.kernel.org, Hanjun Guo <guohanjun@huawei.com>,
	Jiang Liu <jiang.liu@huawei.com>,
	Yinghai Lu <yinghai@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Aug 16, 2012 at 6:58 PM, Yijing Wang <wangyijing@huawei.com> wrote:
> Hi Bjorn,
>    Please ignore these three patches, I'm very sorry I still have some confusion about allocating resources
> to pci devices.So this patch is not appropriate. I will provide new version patches when I find a better
> solution for this problem.

We don't have a uniform way of detecting unassigned BARs and handling
resource allocation failures yet.  When we make that all consistent, I
think it will make it more obvious how to do these patches.

I think patch 2/3 (the list_for_each_safe() one) is probably still a
good bug fix, so with your permission, I'll keep that one.

>> When we hot plug pci devices, system will allocate resources to these new add
>> devices, pci_bus_assign_resources() will be called.If the pci devices was assigned
>> resource fail, the resource struct will reset to zero.So I think use res->flags here
>> to determine whether the resource is valid is reliable.
>>
>> Signed-off-by: Yijing Wang <wangyijing@huawei.com>
>> ---
>>  drivers/pci/hotplug/acpiphp_glue.c |    4 +---
>>  1 files changed, 1 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/hotplug/acpiphp_glue.c
>> index 7bbd6bf..2161902 100644
>> --- a/drivers/pci/hotplug/acpiphp_glue.c
>> +++ b/drivers/pci/hotplug/acpiphp_glue.c
>> @@ -1084,13 +1084,11 @@ static void acpiphp_sanitize_bus(struct pci_bus *bus)
>>  {
>>       struct pci_dev *dev, *tmp;
>>       int i;
>> -     unsigned long type_mask = IORESOURCE_IO | IORESOURCE_MEM;
>>
>>       list_for_each_entry_safe(dev, tmp, &bus->devices, bus_list) {
>>               for (i=0; i<PCI_BRIDGE_RESOURCES; i++) {
>>                       struct resource *res = &dev->resource[i];
>> -                     if ((res->flags & type_mask) && !res->start &&
>> -                                     res->end) {
>> +                     if (!res->flags) {
>>                               /* Could not assign a required resources
>>                                * for this device, remove it */
>>                               pci_stop_and_remove_bus_device(dev);
>>
>
>
> --
> Thanks!
> Yijing
>
