Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:54058 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754308Ab2HTOrI (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 20 Aug 2012 10:47:08 -0400
Received: by lbbgj3 with SMTP id gj3so3338676lbb.19
        for <linux-pci@vger.kernel.org>; Mon, 20 Aug 2012 07:47:07 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAE9FiQXFObwPx50NprfnEUyO5PcppUdxqOKg_3eetf-W7a8+FA@mail.gmail.com>
References: <20120817233100.10973.59521.stgit@bhelgaas.mtv.corp.google.com>
 <20120817233600.10973.11841.stgit@bhelgaas.mtv.corp.google.com> <CAE9FiQXFObwPx50NprfnEUyO5PcppUdxqOKg_3eetf-W7a8+FA@mail.gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 20 Aug 2012 07:46:46 -0700
Message-ID: <CAErSpo40k-+pGGA9VTENr4=b2xo77CwYxvb2ire5E5zHLLf44w@mail.gmail.com>
Subject: Re: [PATCH v2 03/16] pcmcia: Use common pci_stop_and_remove_bus_device()
To: Yinghai Lu <yinghai@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-pcmcia@lists.infradead.org,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Aug 17, 2012 at 5:58 PM, Yinghai Lu <yinghai@kernel.org> wrote:
> On Fri, Aug 17, 2012 at 4:36 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>> Use pci_stop_and_remove_bus_device() like most other hotplug drivers
>> rather than the special-purpose "behind_bridge" variant.  This just
>> means we have to iterate through all the devices downstream of the
>> bridge ourselves, which is the same thing pci_stop_behind_bridge()
>> did.
>>
>> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>> ---
>>  drivers/pcmcia/cardbus.c |    7 +++++--
>>  1 files changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/pcmcia/cardbus.c b/drivers/pcmcia/cardbus.c
>> index 24caeaf..94f87b5 100644
>> --- a/drivers/pcmcia/cardbus.c
>> +++ b/drivers/pcmcia/cardbus.c
>> @@ -106,7 +106,10 @@ int __ref cb_alloc(struct pcmcia_socket *s)
>>  void cb_free(struct pcmcia_socket *s)
>>  {
>>         struct pci_dev *bridge = s->cb_dev;
>> +       struct pci_bus *bus = bridge->subordinate;
>> +       struct pci_dev *dev, *tmp;
>>
>> -       if (bridge)
>> -               pci_stop_and_remove_behind_bridge(bridge);
>> +       if (bus)
>> +               list_for_each_entry_safe(dev, tmp, &bus->devices, bus_list)
>> +                       pci_stop_and_remove_bus_device(dev);
>>  }
>>
>
> original looks like bridge could be NULL.

You're right, thanks!  I fixed that.
