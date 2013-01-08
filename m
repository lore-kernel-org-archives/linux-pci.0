Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-la0-f52.google.com ([209.85.215.52]:33353 "EHLO
	mail-la0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754640Ab3AHATe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 7 Jan 2013 19:19:34 -0500
Received: by mail-la0-f52.google.com with SMTP id fq12so17350405lab.39
        for <linux-pci@vger.kernel.org>; Mon, 07 Jan 2013 16:19:33 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <50890028.8040604@huawei.com>
References: <1350020155-3782-1-git-send-email-jdmason@kudzu.us>
 <1350020155-3782-4-git-send-email-jdmason@kudzu.us> <507B75D6.201@huawei.com>
 <CAPoiz9xbiC5NKb5ZXGOLdMuWxnngO9HC3HfsFWX6pBwRnMbVJA@mail.gmail.com> <50890028.8040604@huawei.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 7 Jan 2013 17:19:12 -0700
Message-ID: <CAErSpo4YYW-wDyP3JzDFOpETc38dpVzvRYke=a4Czz0FkobAcA@mail.gmail.com>
Subject: Re: [PATCH 3/3] PCI: Add new default PCI-E MPS bus state
To: Jon Mason <jdmason@kudzu.us>
Cc: linux-pci@vger.kernel.org, Yijing Wang <wangyijing@huawei.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Jon,

Sorry for neglecting this until it's now ancient history, but you
mentioned earlier that "The print out shows a bug in the code (which I
will push in a second version of the patch shortly)."

I don't see a second version; did I miss it?  If we still need a fix
here, can you re-post the three patches in this series?

Bjorn

On Thu, Oct 25, 2012 at 3:02 AM, Yijing Wang <wangyijing@huawei.com> wrote:
> Hi Jon,
>    I think we can do a little more about inconsistent mps problem found in boot path(BIOS configure bug for mps)
> or after hotplug device.As shown in your comment on line 1451, it's unsafe to modifying the MPS on the running devices.
> Since bus child devices is not running when pcie_bus_configure_settings be called. So we can try to configure child device's
> mps according to the mps of bus.
> there are two situations:
> 1、now current running bus mps is larger than child devices mpss can support;
> 2、now cuurent running bus mps is smaller than child devices mpss can support;
>
> We cannot modifying the MPS for 1, it's not safe; but we can show message to user to add boot parameter pci=pcie_bus_safe.
> The second situation we can modify all child devices mps as the mps value of running bus, it's safe and can correct mps problem automatically
> for users.
>
> I wrote a draft patch about this solution, if there is some thing wrong with my understanding, let me know.
>
> Thanks very much!
> Yijing
>
>
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 5485883..59036a8 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -78,7 +78,7 @@ unsigned long pci_cardbus_mem_size = DEFAULT_CARDBUS_MEM_SIZE;
>  unsigned long pci_hotplug_io_size  = DEFAULT_HOTPLUG_IO_SIZE;
>  unsigned long pci_hotplug_mem_size = DEFAULT_HOTPLUG_MEM_SIZE;
>
> -enum pcie_bus_config_types pcie_bus_config = PCIE_BUS_TUNE_OFF;
> +enum pcie_bus_config_types pcie_bus_config = PCIE_BUS_AUTO;
>
>  /*
>   * The default CLS is used if arch didn't set CLS explicitly and not
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index e8b7d5e..6cbfbe1 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1467,6 +1467,19 @@ static int pcie_find_smpss(struct pci_dev *dev, void *data)
>         return 0;
>  }
>
> +static int pcie_find_min_mpss(struct pci_dev *dev, void *data)
> +{
> +       u8 *mpss = data;
> +
> +       if (!pci_is_pcie(dev))
> +               return 0;
> +
> +       if (*mpss > dev->pcie_mpss)
> +               *mpss = dev->pcie_mpss;
> +
> +       return 0;
> +}
> +
>  static void pcie_write_mps(struct pci_dev *dev, int mps)
>  {
>         int rc;
> @@ -1560,6 +1573,7 @@ static int pcie_bus_configure_set(struct pci_dev *dev, void *data)
>  void pcie_bus_configure_settings(struct pci_bus *bus, u8 mpss)
>  {
>         u8 smpss;
> +       u8 mps = pcie_get_mps(bus->self) >> 8;
>
>         if (!pci_is_pcie(bus->self))
>                 return;
> @@ -1581,7 +1595,19 @@ void pcie_bus_configure_settings(struct pci_bus *bus, u8 mpss)
>         case PCIE_BUS_PEER2PEER:
>                 smpss = 0;
>                 break;
> -
> +       case PCIE_BUS_AUTO:
> +               smpss = bus->self->pcie_mpss;
> +               pci_walk_bus(bus, pcie_find_min_mpss, &smpss);
> +               if (mps > smpss) {
> +                       dev_info(&bus->dev,
> +                               "Current mps %d used in bus 0x%02x is larger than children devices mpss %d support\n"
> +                               "Please use the pci=pcie_bus_safe boot parameter for safe\n",
> +                               128 << mpss, bus->number, 128 << smpss);
> +                       return;
> +               }
> +               else
> +                       pci_walk_bus(bus, pcie_bus_configure_set, &mps);
> +               return;
>         case PCIE_BUS_SAFE:
>                 smpss = mpss;
>
> @@ -1594,8 +1620,6 @@ void pcie_bus_configure_settings(struct pci_bus *bus, u8 mpss)
>                 return;
>         }
>
> -       }
> -
>         pcie_bus_configure_set(bus->self, &smpss);
>         pci_walk_bus(bus, pcie_bus_configure_set, &smpss);
>  }
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 7a451ff..539b7e4 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -2787,7 +2787,8 @@ static void __devinit quirk_intel_mc_errata(struct pci_dev *dev)
>         int err;
>         u16 rcc;
>
> -       if (pcie_bus_config == PCIE_BUS_TUNE_OFF)
> +       if (pcie_bus_config == PCIE_BUS_TUNE_OFF ||
> +               pcie_bus_config == PCIE_AUTO_AUTO)
>                 return;
>
>         /* Intel errata specifies bits to change but does not say what they are.
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index be1de01..84c4ab1 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -661,6 +661,7 @@ extern void pcie_bus_configure_settings(struct pci_bus *bus, u8 smpss);
>
>  enum pcie_bus_config_types {
>         PCIE_BUS_TUNE_OFF,
> +       PCIE_BUS_AUTO,
>         PCIE_BUS_SAFE,
>         PCIE_BUS_PERFORMANCE,
>         PCIE_BUS_PEER2PEER,
> --
> 1.7.1
>
>
> On 2012/10/24 6:57, Jon Mason wrote:
>>> pcieport 0000:47:09.0 device mps current is 256 and mpss is 1024;
>>> the newly hot added igb device 0000:4b:00.0 and 0000:4b:00.1 mps are 128 and mpss is 512;
>>> 1、"pci_bus 0000:4b: Non-optimal PCI-E Bus MPS value of 128 being used instead of 1024."  should ".......instead of 256(bridge mps)"？
>>
>> The print out shows a bug in the code (which I will push in a second
>> version of the patch shortly), but having 128 instead of 256 is a
>> separate issue.  That is an existing limitation due to the hotplug
>> slot not being connected to the root port.  See the comment on line
>> 1454.  Since PCIE_BUS_SAFE/PERFORMANCE is not being used, it is not
>> ratcheting down the MPS on the bus like it should (per the comment).
>>
>>> 2、“use the pci=pcie_bus_safe boot parameter for better performance”  should "....use pci=pcie_bus_safe for safe"?
>>
>> The reason for the user to add the boot parameter is to get better
>> performance than they would by default.  For theoretically best
>> performance, they would want to use "pcie_bus_performance".  With this
>> in mind, I believe "better" is the correct language.
>>
>>> 3、above logs is  duplicate.
>>
>> The duplicate log would only be caused by pcie_bus_configure_settings
>> being called twice.  Is this only being seen on hotplug devices or on
>> every device?
>>
>>>
>>> igb 0000:4b:00.0: enabling device (0100 -> 0102)
>>> igb 0000:4b:00.0: Intel(R) Gigabit Ethernet Network Connection
>>> igb 0000:4b:00.0: eth4: (PCIe:2.5Gb/s:Width x4) 00:0e:0c:ff:ff:ff
>>> igb 0000:4b:00.0: eth4: PBA No: FFFFFF-0FF
>>> igb 0000:4b:00.0: Using MSI-X interrupts. 8 rx queue(s), 8 tx queue(s)
>>> igb 0000:4b:00.1: enabling device (0100 -> 0102)
>>> GSI 63 (level, low) -> CPU 27 (0x3300) vector 137
>>> igb 0000:4b:00.1: Intel(R) Gigabit Ethernet Network Connection
>>> igb 0000:4b:00.1: eth4: (PCIe:2.5Gb/s:Width x4) 00:0e:0c:ff:ff:fe
>>> igb 0000:4b:00.1: eth4: PBA No: FFFFFF-0FF
>>> igb 0000:4b:00.1: Using MSI-X interrupts. 8 rx queue(s), 8 tx queue(s)
>>>
>>>
>>> Thanks!
>>> Yijing
>>>
>>>
>>>> +             return;
>>>>       }
>>>>
>>>>       pcie_bus_configure_set(bus->self, &smpss);
>>>> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
>>>> index 5155317..e4eede0 100644
>>>> --- a/drivers/pci/quirks.c
>>>> +++ b/drivers/pci/quirks.c
>>>> @@ -2787,7 +2787,8 @@ static void __devinit quirk_intel_mc_errata(struct pci_dev *dev)
>>>>       int err;
>>>>       u16 rcc;
>>>>
>>>> -     if (pcie_bus_config == PCIE_BUS_TUNE_OFF)
>>>> +     if (pcie_bus_config == PCIE_BUS_TUNE_OFF ||
>>>> +         pcie_bus_config == PCIE_BUS_WARN)
>>>>               return;
>>>>
>>>>       /* Intel errata specifies bits to change but does not say what they are.
>>>> diff --git a/include/linux/pci.h b/include/linux/pci.h
>>>> index 5faa831..410eaf9 100644
>>>> --- a/include/linux/pci.h
>>>> +++ b/include/linux/pci.h
>>>> @@ -662,6 +662,7 @@ extern void pcie_bus_configure_settings(struct pci_bus *bus, u8 smpss);
>>>>
>>>>  enum pcie_bus_config_types {
>>>>       PCIE_BUS_TUNE_OFF,
>>>> +     PCIE_BUS_WARN,
>>>>       PCIE_BUS_SAFE,
>>>>       PCIE_BUS_PERFORMANCE,
>>>>       PCIE_BUS_PEER2PEER,
>>>>
>>>
>>>
>>> --
>>> Thanks!
>>> Yijing
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>> .
>>
>
>
> --
> Thanks!
> Yijing
>
