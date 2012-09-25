Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:35300 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751148Ab2IYRhc (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 25 Sep 2012 13:37:32 -0400
Received: by lbon3 with SMTP id n3so488150lbo.19
        for <linux-pci@vger.kernel.org>; Tue, 25 Sep 2012 10:37:31 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAE9FiQUu++bPNree995uY3bGURxJ6hSi8m77ah_8KK6S2aMUaQ@mail.gmail.com>
References: <1348561590-28067-1-git-send-email-yinghai@kernel.org>
 <CAErSpo5Arj=rh4mZJk3tEsaWKBFqxK6tAu1N5SKn2Cq=vTj+bw@mail.gmail.com> <CAE9FiQUu++bPNree995uY3bGURxJ6hSi8m77ah_8KK6S2aMUaQ@mail.gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 25 Sep 2012 11:37:11 -0600
Message-ID: <CAErSpo6NOhTV0HX1dw5-mRkUtfO7XH_iCGVwiddBPpQvPZL=7g@mail.gmail.com>
Subject: Re: [PATCH 00/29] PCI: use pci host bridge to loop pci root bus
To: Yinghai Lu <yinghai@kernel.org>
Cc: Len Brown <lenb@kernel.org>, linux-pci@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Sep 25, 2012 at 10:29 AM, Yinghai Lu <yinghai@kernel.org> wrote:
> On Tue, Sep 25, 2012 at 9:23 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>> On Tue, Sep 25, 2012 at 2:26 AM, Yinghai Lu <yinghai@kernel.org> wrote:
>>> could remove pci_root_buses list.
>>>
> ...
>>>   PCI: Add dummy bus_type for pci_host_bridge
> ...
>>>   PCI: Add for_each_pci_host_bridge() and pci_get_next_host_bridge
>>
>> I'm not thrilled about adding a new iterator for all host bridges.
>>
>> The iterator design pattern does not work for collections that can
>> change over time.  In this case, it looks like you're adding a safer
>> way to iterate through all host bridges we know about at this time.
>> But we still have the problem of the host bridge that's added
>> tomorrow.
>>
>> I'd prefer a design where the PCI core provides an interface that
>> means "call this function for every host bridge we know about now
>> *and* for every one that's added in the future."
>
> yes, that is the point to add pci_root_bridge_bus_type. We can register
> bus notifier on that.

I guess I missed your point.  In the patch below (20/29 from your
series), you're still iterating through all the host bridges, so there
would have to be something else to handle hot-added host bridges.

Are you saying you plan future patches to change this again to
something using a bus notifier?


--- a/arch/sparc/kernel/pci.c
+++ b/arch/sparc/kernel/pci.c
@@ -997,11 +997,13 @@ static void __devinit pci_bus_slot_names(struct
device_node *node,

 static int __init of_pci_slot_init(void)
 {
-       struct pci_bus *pbus = NULL;
+       struct pci_host_bridge *host_bridge = NULL;
+       struct pci_bus *pbus;

-       while ((pbus = pci_find_next_bus(pbus)) != NULL) {
+       for_each_pci_host_bridge(host_bridge) {
                struct device_node *node;

+               pbus = hot_bridge->bus;
                if (pbus->self) {
                        /* PCI->PCI bridge */
                        node = pbus->self->dev.of_node;
