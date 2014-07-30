Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from AUSXIPPS310.us.dell.com ([143.166.148.211]:60235 "EHLO
	ausxipps310.us.dell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751336AbaG3Tpn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 30 Jul 2014 15:45:43 -0400
From: <Jordan_Hargrave@Dell.com>
To: <wangyijing@huawei.com>, <ethan.kernel@gmail.com>
CC: <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
	<keith.busch@intel.com>, <jdmason@kudzu.us>
Date: Wed, 30 Jul 2014 14:41:41 -0500
Subject: RE: [PATCH] PCI: update device mps when doing pci hotplug
Message-ID: <5B3AAEAF6B46EA4D955DF7AD46C2C48515F8318AB0@AUSX7MCPS303.AMER.DELL.COM>
References: <1406621877-12022-1-git-send-email-wangyijing@huawei.com>
	<CABawtvP1sviOZynf2N43ORDF-mPHX9PrcsXSmxKqv4_V9QpnsQ@mail.gmail.com>
	<53D89754.3010704@huawei.com>
	<CABawtvMg1gUpCr5rpFzKfUVD=Ai06Rpi4XVOvzARb2tYk+HXsw@mail.gmail.com>
	<53D8A942.80008@huawei.com>
 <CABawtvNkodcdxOJ-T=eV8W_AtVV8AMeOi+9016-6DN_hRfrbTA@mail.gmail.com>,<53D8B819.9020304@huawei.com>
In-Reply-To: <53D8B819.9020304@huawei.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

One concern with using _HPX is there doesn't appear to be a failure mechanism...
What happens if inserting a device where its maximum possible MPS is < the MPS of the parent device.

The _HPX AML would have to read the parent device MPS which would be pretty ugly.

--jordan hargrave
Dell Enterprise Linux Engineering
________________________________________
From: Yijing Wang [wangyijing@huawei.com]
Sent: Wednesday, July 30, 2014 4:17 AM
To: Ethan Zhao
Cc: Bjorn Helgaas; linux-pci; Hargrave, Jordan; <keith.busch@intel.com>; Jon Mason
Subject: Re: [PATCH] PCI: update device mps when doing pci hotplug

On 2014/7/30 16:38, Ethan Zhao wrote:
> On Wed, Jul 30, 2014 at 4:13 PM, Yijing Wang <wangyijing@huawei.com> wrote:
>>>> Yes, that issue is BIOS bug, the mps setting is wrong after system boot up.
>>>> But that issue is not same as this one, Keith and Jordan found the issue
>>>> after hot-plug. And my patch only modify the hotplug slot connected device.
>>>>
>>>> In my idea, make the device work is important, because these platforms with windows
>>>> can run happy, why linux leave this issue to BIOS.
>>>
>>>    That is a reason to make it works with Linux, but does your
>>> platform have _HPX from ACPI for those hot-added back devices ?  if it
>>> has, maybe windows could apply _HPX to configure those devices and
>>> work well.
>>>
>>
>> I checked DSDT table exported from my server, but no "_HPX" found.
>
> You might check the wrong place...
>
>> Further more, kernel use pciehp first to support pcie hotplug device. And in pciehp,
>> driver won't touch ACPI methods like "_HPX".
>
> That is not true, please read the code in pciehp_pci.c
>
>  pciehp_configure_device()
>     pci_configure_slot()
>        pci_get_hp_params()
>            acpi_run_hpx()
>                acpi_evaluate_object(handle, "_HPX",...)
>  ...
>

Sorry, I make a mistake. You are right, Use the _HPX can fix the issue from BIOS.
But what confused me is why linux fail to reconfigure mps after hotplug, but windows did it well.

Maybe we can cache the device mps into pci_dev, every time we call pcie_bus_configure_settings(),
if we find the device mps is not equal to the cached value, and the device is disabled, restore it.


/* PCI Express Setting Record (Type 2) */
struct hpp_type2 {
        u32 revision;
        u32 unc_err_mask_and;
        u32 unc_err_mask_or;
        u32 unc_err_sever_and;
        u32 unc_err_sever_or;
        u32 cor_err_mask_and;
        u32 cor_err_mask_or;
        u32 adv_err_cap_and;
        u32 adv_err_cap_or;
        u16 pci_exp_devctl_and;
        u16 pci_exp_devctl_or;
        u16 pci_exp_lnkctl_and;
        u16 pci_exp_lnkctl_or;
        u32 sec_unc_err_sever_and;
        u32 sec_unc_err_sever_or;
        u32 sec_unc_err_mask_and;
        u32 sec_unc_err_mask_or;
};

> Native pciehp also does acpi parameter importing ... ...
>
> Thank,s
> Ethan
>
>>
>> Thanks!
>> Yijing.
>>
>>>>
>>>>>
>>>>>> Reported-by: Keith Busch <keith.busch@intel.com>
>>>>>> Reported-by: Jordan_Hargrave@Dell.com
>>>>>> Reported-by: Yijing Wang <wangyijing@huawei.com>
>>>>>> Signed-off-by: Yijing Wang <wangyijing@huawei.com>
>>>>>> Cc: Jon Mason <jdmason@kudzu.us>
>>>>>> ---
>>>>>>  drivers/pci/probe.c |   39 +++++++++++++++++++++++++++++++++++++++
>>>>>>  1 files changed, 39 insertions(+), 0 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
>>>>>> index e3cf8a2..583ca52 100644
>>>>>> --- a/drivers/pci/probe.c
>>>>>> +++ b/drivers/pci/probe.c
>>>>>> @@ -1613,6 +1613,44 @@ static void pcie_write_mrrs(struct pci_dev *dev)
>>>>>>                 dev_err(&dev->dev, "MRRS was unable to be configured with a safe value.  If problems are experienced, try running with pci=pcie_bus_safe\n");
>>>>>>  }
>>>>>>
>>>>>> +/**
>>>>>> + * pcie_bus_update_set - update device mps when device doing hot-add
>>>>>> + * @dev: PCI device to set
>>>>>> + *
>>>>>> + * After device hot add, mps will be set to default(128B), But the
>>>>>> + * upstream port device's mps may be larger than 128B which was set
>>>>>> + * by firmware during system bootup. Then we should update the device
>>>>>> + * mps to equal to its parent mps, Or the device can not work normally.
>>>>>> + */
>>>>>> +static void pcie_bus_update_set(struct pci_dev *dev)
>>>>>> +{
>>>>>> +       int mps, p_mps, mpss;
>>>>>> +       struct pci_dev *parent;
>>>>>> +
>>>>>> +       if (!pci_is_pcie(dev) || !dev->bus->self
>>>>>> +                       || !dev->bus->self->is_hotplug_bridge)
>>>>>> +               return;
>>>>>> +
>>>>>> +       parent = dev->bus->self;
>>>>>> +       mps = pcie_get_mps(dev);
>>>>>> +       p_mps = pcie_get_mps(parent);
>>>>>> +
>>>>>> +       if (mps >= p_mps)
>>>>>> +               return;
>>>>>> +
>>>>>> +       mpss = 128 << dev->pcie_mpss;
>>>>>> +       if (mpss < p_mps) {
>>>>>> +               dev_warn(&dev->dev, "MPSS %d smaller than upstream MPS %d\n"
>>>>>> +                               "If necessary, use \"pci=pcie_bus_safe\" boot parameter to avoid this problem\n",
>>>>>> +                               mpss, p_mps);
>>>>>> +               return;
>>>>>> +       }
>>>>>> +
>>>>>> +       pcie_write_mps(dev, p_mps);
>>>>>> +       dev_info(&dev->dev, "Max Payload Size set to %4d/%4d (was %4d)\n",
>>>>>> +                       pcie_get_mps(dev), 128 << dev->pcie_mpss, mps);
>>>>>> +}
>>>>>> +
>>>>>>  static void pcie_bus_detect_mps(struct pci_dev *dev)
>>>>>>  {
>>>>>>         struct pci_dev *bridge = dev->bus->self;
>>>>>> @@ -1637,6 +1675,7 @@ static int pcie_bus_configure_set(struct pci_dev *dev, void *data)
>>>>>>                 return 0;
>>>>>>
>>>>>>         if (pcie_bus_config == PCIE_BUS_TUNE_OFF) {
>>>>>> +               pcie_bus_update_set(dev);
>>>>>>                 pcie_bus_detect_mps(dev);
>>>>>>                 return 0;
>>>>>>         }
>>>>>> --
>>>>>> 1.7.1
>>>>>>
>>>>>> --
>>>>>> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
>>>>>> the body of a message to majordomo@vger.kernel.org
>>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>>
>>>>> .
>>>>>
>>>>
>>>>
>>>> --
>>>> Thanks!
>>>> Yijing
>>>>
>>>
>>> .
>>>
>>
>>
>> --
>> Thanks!
>> Yijing
>>
>
> .
>


--
Thanks!
Yijing

