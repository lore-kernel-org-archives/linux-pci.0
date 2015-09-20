Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-vk0-f53.google.com ([209.85.213.53]:36667 "EHLO
	mail-vk0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750955AbbITGTo (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 20 Sep 2015 02:19:44 -0400
Received: by vkfp126 with SMTP id p126so49602742vkf.3
        for <linux-pci@vger.kernel.org>; Sat, 19 Sep 2015 23:19:43 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAErSpo5Mdn9CLzW-6LOPbsdHWpdUL9ogzajuS39PZXqRVyip7Q@mail.gmail.com>
References: <66c9da3f76f74ee5a81473d35777a59b@XCGVAG27.northgrum.com>
	<CAE9FiQWbL+WLfV7enKpJttYo6xyOMX5NR9zbNL9he2qfVt5UeQ@mail.gmail.com>
	<CAErSpo5Mdn9CLzW-6LOPbsdHWpdUL9ogzajuS39PZXqRVyip7Q@mail.gmail.com>
Date: Sat, 19 Sep 2015 23:19:43 -0700
Message-ID: <CAE9FiQUXgjz_C_+8U2UDCec00Ghsnuk0B48F3hBOUbgLS6RjcQ@mail.gmail.com>
Subject: Re: [PATCH v1 3/7] PCI: Let kcmdline reserve bus numbers for hotplug bridges
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "Tang, Jason (ES)" <Jason.Tang2@ngc.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Sep 19, 2015 at 7:11 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> On Sat, Sep 19, 2015 at 3:58 PM, Yinghai Lu <yinghai@kernel.org> wrote:
>> On Thu, Sep 17, 2015 at 2:11 PM, Tang, Jason (ES) <Jason.Tang2@ngc.com> wrote:
>>> This introduces a new kernel command line parameter, "hpbuses", that
>>> allows the user to set how many bus numbers to reserve for hotplug
>>> bridges.  The default value is 0, which means do not reserve any bus
>>> numbers for bridges that are hot-added after enumeration completes.
>>>
>>> During device probing, increment a hotplug bridge's subordinate bus
>>> number by the amount set by "hpbuses".  This way, bridges that are
>>> hot-added after enumeration can have buses reserved for them.
>>
>>> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
>>> index 58ae892..553b345 100644
>>> --- a/drivers/pci/probe.c
>>> +++ b/drivers/pci/probe.c
>>> @@ -930,6 +930,8 @@ int pci_scan_bridge(struct pci_bus *bus, struct pci_dev *dev, int max, int pass)
>>>                 /*
>>>                  * Set the subordinate bus number to its real value.
>>>                  */
>>> +               if (child->self->is_hotplug_bridge)
>>> +                       max += pci_hotplug_buses;
>>>                 child->subordinate = max;
>>>                 pci_bus_update_busn_res_end(child, child->subordinate);
>>>                 pci_write_config_byte(dev, PCI_SUBORDINATE_BUS,
>>
>> No, you can not increase the max blindly.
>
> It would be really useful if you could explain *why* this doesn't
> work.  Then Jason might be able to rework it so it would work.

from bus [old_max, old_max+pci_hotplug_buses) could be used by other bridges,
and other bridges could even get probed yet.
Also it could even cross the boundary to other peer root bus range.
