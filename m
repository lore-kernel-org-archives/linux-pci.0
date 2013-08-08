Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga03-in.huawei.com ([119.145.14.66]:1723 "EHLO
	szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932858Ab3HHCuf (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 7 Aug 2013 22:50:35 -0400
Message-ID: <520306E9.5050901@huawei.com>
Date: Thu, 8 Aug 2013 10:48:09 +0800
From: Yijing Wang <wangyijing@huawei.com>
MIME-Version: 1.0
To: Jon Mason <jdmason@kudzu.us>
CC: Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>, <jiang.liu@huawei.com>,
	<stable@vger.kernel.org>
Subject: Re: [PATCH -v3] PCI: update device mps when doing pci hotplug
References: <1375776540-23988-1-git-send-email-wangyijing@huawei.com> <CAPoiz9wAufM8HV_Drdxg50zs5=1AduBUN5oXNRBHYqjwMCOTaQ@mail.gmail.com> <5201A877.2080303@huawei.com> <CAPoiz9z1yS=-GwWuBjbxCUk4s+K5KtEBLwaWsO5XVT_uePeHHg@mail.gmail.com>
In-Reply-To: <CAPoiz9z1yS=-GwWuBjbxCUk4s+K5KtEBLwaWsO5XVT_uePeHHg@mail.gmail.com>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

>> Because for safety, I won't touch the running pcie device(RP, UP/DP,EP) mps.
>> Consider the following case:
>> Root Port------>Upstream Port------>Downstream Port 1 ---->Endpoint device A (newly inserted device)
>> mps=256          256               |    256                     128
>>                                    |Downstream Port 2 ---->Endpoint device B
>>                                         256                     256
>>
>> This patch try to update device A's mps equal to its parent DP 1 mps (256).
>> Because EP A device is not running, newly inserted, not configure yet. So configure its mps
>> to 256B is safe.
> 
> I understand your logic now and agree.

Hi Jon,
   Thanks for your comments!
I think we can improve this logic a little . As your comments in pcie_find_smpss(), if the PCI hotplug
slot is directly connected to the root port and there are not other devices on the fabric, then this
is not an issue..  So I think in this case, we can first update the newly hot added device mps as above logic.
if newly hot added device mpss < root port mps, then we can modify both root port device and newly hot added device
mps to device mpss. What do you think?

eg.
Root port --------------> slot (mps is default 128,assume mpss is 256)
(mps 512)

Only in this case, I think we try to update the parent device is safe.

after update:
Root port --------------> slot (mps is default 128,assume mpss is 256)
(mps 512-->256)		mps 128--->256

> 
>> But if we try to configure DP 1 mps to 128B, it's not safe. its parent Upstream port still is 256.
> 
> This is exactly the case that the "PERFORMANCE" option is trying to
> allow.  If the MRRS is set to the MPS of the device, it should work.
> If not, then we should rip out all of the "PERFORMANCE" code.  Is this
> something you can verify?

Hi Jon,
   I am not very clear about what the role of MRRS. So if I understand wrong, please correct me, thanks.

eg.
DP1 ----------------> EP A
mps=256			mps=128

MRRS can control the read request TLP size when the Function as a Requester.
So if we set the EP A MRRS to mps value(128), EP A won't generate
TLP larger than 128, so Request stream from EP A to DP1 is safe.

But if EP A is as a receiver, DP 1 generate completion TLP (larger than 128) to EP A.
these TLPs will be discarded by EP A, right?

So in my idea, If we set both mps and mrrs of EP A to 128, we can insure TLPs stream from EP A is safe.
But How do we guarantee that DP1 won't generate TLPs to EP A is larger than 128?

Jon, PCIe Spec only involves mps and mrrs setting a little, Are there any other specs about this?


Thanks!
Yijing.


> 
> Thanks,
> Jon
> 
>>>
>>>> +}
>>>> +
>>>>  /* pcie_bus_configure_settings requires that pci_walk_bus work in a top-down,
>>>>   * parents then children fashion.  If this changes, then this code will not
>>>>   * work as designed.
>>>> @@ -1614,6 +1648,15 @@ void pcie_bus_configure_settings(struct pci_bus *bus, u8 mpss)
>>>>         if (!pci_is_pcie(bus->self))
>>>>                 return;
>>>>
>>>> +       /* Sometimes we should update device mps here,
>>>> +        * eg. after hot add, device mps value will be
>>>> +        * set to default(128B), but the upstream port
>>>> +        * mps value may be larger than 128B, if we do
>>>> +        * not update the device mps, it maybe can not
>>>> +        * work normally.
>>>
>>> This is slightly confusing to me.  It would be more clear to say:
>>> There are situations (i.e., hot add) where the upstream port might
>>> have a larger MPS than the device.  In these situations, the port MPS
>>> needs to be reconfigured to the lower value or the device will not
>>> operate properly.
>>
>> Sorry for my poor English, I mean the device  is the newly hot added device, not
>> the port device. So we will only reconfigure the newly hot added device mps.
>>
>>>
>>>> +        */
>>>> +       pcie_bus_update_setting(bus);
>>>
>>> This only seems to be necessary in the "TUNE_OFF" case.  It would be
>>> best to move it under that, just 2 lines down.
>>
>> Good idea, will update, thanks!
>>
>>
>> Thanks!
>> Yijing.
>>>
>>>> +
>>>>         if (pcie_bus_config == PCIE_BUS_TUNE_OFF)
>>>
>>> Perhaps it is time to make "SAFE" the default option, per the
>>> discussion at last years PCI mini-summit.
>>> Bjorn, thoughts?
>>>
>>>
>>> Thanks,
>>> Jon
>>>
>>>>                 return;
>>>>
>>>> --
>>>> 1.7.1
>>>>
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
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> .
> 


-- 
Thanks!
Yijing

