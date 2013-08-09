Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:44973 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966931Ab3HIArL (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 8 Aug 2013 20:47:11 -0400
Received: by mail-wi0-f182.google.com with SMTP id hi8so1168015wib.3
        for <linux-pci@vger.kernel.org>; Thu, 08 Aug 2013 17:47:09 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <520306E9.5050901@huawei.com>
References: <1375776540-23988-1-git-send-email-wangyijing@huawei.com>
	<CAPoiz9wAufM8HV_Drdxg50zs5=1AduBUN5oXNRBHYqjwMCOTaQ@mail.gmail.com>
	<5201A877.2080303@huawei.com>
	<CAPoiz9z1yS=-GwWuBjbxCUk4s+K5KtEBLwaWsO5XVT_uePeHHg@mail.gmail.com>
	<520306E9.5050901@huawei.com>
Date: Thu, 8 Aug 2013 17:47:09 -0700
Message-ID: <CAPoiz9zDQjvj1jYyW=0+0=qX60gu-FSZTHpYj2Yq2okg1WDOXA@mail.gmail.com>
Subject: Re: [PATCH -v3] PCI: update device mps when doing pci hotplug
From: Jon Mason <jdmason@kudzu.us>
To: Yijing Wang <wangyijing@huawei.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>, jiang.liu@huawei.com,
	stable@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Aug 7, 2013 at 7:48 PM, Yijing Wang <wangyijing@huawei.com> wrote:
>>> Because for safety, I won't touch the running pcie device(RP, UP/DP,EP) mps.
>>> Consider the following case:
>>> Root Port------>Upstream Port------>Downstream Port 1 ---->Endpoint device A (newly inserted device)
>>> mps=256          256               |    256                     128
>>>                                    |Downstream Port 2 ---->Endpoint device B
>>>                                         256                     256
>>>
>>> This patch try to update device A's mps equal to its parent DP 1 mps (256).
>>> Because EP A device is not running, newly inserted, not configure yet. So configure its mps
>>> to 256B is safe.
>>
>> I understand your logic now and agree.
>
> Hi Jon,
>    Thanks for your comments!
> I think we can improve this logic a little . As your comments in pcie_find_smpss(), if the PCI hotplug
> slot is directly connected to the root port and there are not other devices on the fabric, then this
> is not an issue..  So I think in this case, we can first update the newly hot added device mps as above logic.
> if newly hot added device mpss < root port mps, then we can modify both root port device and newly hot added device
> mps to device mpss. What do you think?
>
> eg.
> Root port --------------> slot (mps is default 128,assume mpss is 256)
> (mps 512)
>
> Only in this case, I think we try to update the parent device is safe.
>
> after update:
> Root port --------------> slot (mps is default 128,assume mpss is 256)
> (mps 512-->256)         mps 128--->256


Yes, but this is where it get difficult.  You can only do it if the
parent bus is the root port.  Otherwise, the other devices on the bus
will already have their MPS configured and changing the root port MPS
will do bad things.  That is why I have the check in pcie_find_smpss()
of

        if (dev->is_hotplug_bridge && (!list_is_singular(&dev->bus->devices) ||
             (dev->bus->self &&
              pci_pcie_type(dev->bus->self) != PCI_EXP_TYPE_ROOT_PORT)))

So, you either need to mimic this code in your new function or make
PCIE_BUS_SAFE the default option.  I'm leaning towards the latter, but
if you need something for the stable tree then we should temporarily
have a patch which does it the former.

Thoughts?

>
>>
>>> But if we try to configure DP 1 mps to 128B, it's not safe. its parent Upstream port still is 256.
>>
>> This is exactly the case that the "PERFORMANCE" option is trying to
>> allow.  If the MRRS is set to the MPS of the device, it should work.
>> If not, then we should rip out all of the "PERFORMANCE" code.  Is this
>> something you can verify?
>
> Hi Jon,
>    I am not very clear about what the role of MRRS. So if I understand wrong, please correct me, thanks.
>
> eg.
> DP1 ----------------> EP A
> mps=256                 mps=128
>
> MRRS can control the read request TLP size when the Function as a Requester.
> So if we set the EP A MRRS to mps value(128), EP A won't generate
> TLP larger than 128, so Request stream from EP A to DP1 is safe.
>
> But if EP A is as a receiver, DP 1 generate completion TLP (larger than 128) to EP A.
> these TLPs will be discarded by EP A, right?

Yes

> So in my idea, If we set both mps and mrrs of EP A to 128, we can insure TLPs stream from EP A is safe.
> But How do we guarantee that DP1 won't generate TLPs to EP A is larger than 128?

The device will never do any reads of larger than the MRRS, but writes
to the device are an issue.  Assuming that all I/O is between CPU/RAM
and the device and there are no peer-to-peer transfers, we should be
safe (but is that a safe assumption?).  So my question to you is that
the setup you have that is failing due to MPS sizes being off, can you
set the only MRRS to 128 and get it working?

> Jon, PCIe Spec only involves mps and mrrs setting a little, Are there any other specs about this?

I have the Mindshare PCIE book, but it doesn't go very deep into this.
 Most of this is an idea from benh, which I attempted to implement.
If it works then all credit goes to him, if it breaks then it is my
fault :)

Thanks,
Jon

>
>
> Thanks!
> Yijing.
>
>
>>
>> Thanks,
>> Jon
>>
>>>>
>>>>> +}
>>>>> +
>>>>>  /* pcie_bus_configure_settings requires that pci_walk_bus work in a top-down,
>>>>>   * parents then children fashion.  If this changes, then this code will not
>>>>>   * work as designed.
>>>>> @@ -1614,6 +1648,15 @@ void pcie_bus_configure_settings(struct pci_bus *bus, u8 mpss)
>>>>>         if (!pci_is_pcie(bus->self))
>>>>>                 return;
>>>>>
>>>>> +       /* Sometimes we should update device mps here,
>>>>> +        * eg. after hot add, device mps value will be
>>>>> +        * set to default(128B), but the upstream port
>>>>> +        * mps value may be larger than 128B, if we do
>>>>> +        * not update the device mps, it maybe can not
>>>>> +        * work normally.
>>>>
>>>> This is slightly confusing to me.  It would be more clear to say:
>>>> There are situations (i.e., hot add) where the upstream port might
>>>> have a larger MPS than the device.  In these situations, the port MPS
>>>> needs to be reconfigured to the lower value or the device will not
>>>> operate properly.
>>>
>>> Sorry for my poor English, I mean the device  is the newly hot added device, not
>>> the port device. So we will only reconfigure the newly hot added device mps.
>>>
>>>>
>>>>> +        */
>>>>> +       pcie_bus_update_setting(bus);
>>>>
>>>> This only seems to be necessary in the "TUNE_OFF" case.  It would be
>>>> best to move it under that, just 2 lines down.
>>>
>>> Good idea, will update, thanks!
>>>
>>>
>>> Thanks!
>>> Yijing.
>>>>
>>>>> +
>>>>>         if (pcie_bus_config == PCIE_BUS_TUNE_OFF)
>>>>
>>>> Perhaps it is time to make "SAFE" the default option, per the
>>>> discussion at last years PCI mini-summit.
>>>> Bjorn, thoughts?
>>>>
>>>>
>>>> Thanks,
>>>> Jon
>>>>
>>>>>                 return;
>>>>>
>>>>> --
>>>>> 1.7.1
>>>>>
>>>>>
>>>>
>>>> .
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
