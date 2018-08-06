Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from esa2.dell-outbound.iphmx.com ([68.232.149.220]:30902 "EHLO
        esa2.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728936AbeHFUuP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 6 Aug 2018 16:50:15 -0400
Cc: <linux-pci@vger.kernel.org>, <bhelgaas@google.com>,
        <keith.busch@intel.com>, <Austin.Bolen@dell.com>,
        <Shyam.Iyer@dell.com>, <jeffrey.t.kirsher@intel.com>,
        <ariel.elior@cavium.com>, <michael.chan@broadcom.com>,
        <ganeshgr@chelsio.com>, <tariqt@mellanox.com>, <airlied@gmail.com>,
        <alexander.deucher@amd.com>, <mike.marciniszyn@intel.com>,
        <linux-kernel@vger.kernel.org>
From: <Alex_Gagniuc@Dellteam.com>
To: <talgi@mellanox.com>, <mr.nuke.me@gmail.com>,
        <jakub.kicinski@netronome.com>
Subject: Re: [PATCH v5] PCI: Check for PCIe downtraining conditions
Date: Mon, 6 Aug 2018 18:39:48 +0000
Message-ID: <c0f2f79b1fe1491287b35e70ba76902a@ausx13mps321.AMER.DELL.COM>
References: <20180718215359.GG128988@bhelgaas-glaptop.roam.corp.google.com>
 <20180723200339.23943-1-mr.nuke.me@gmail.com>
 <20180723140143.1a46902f@cakuba.netronome.com>
 <b9a6b3b8-56cf-8bb5-2568-071ccd8a4f28@mellanox.com>
 <fc04618a-3b3b-58bd-edd5-cbde11638d7b@mellanox.com>
 <1b914780-e342-6aee-ffb2-ef81ac3ddd29@gmail.com>
 <7424c5ba-ae44-3d8d-9dd5-360e17b6e3b9@mellanox.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 08/05/2018 02:06 AM, Tal Gilboa wrote:=0A=
> On 7/31/2018 6:10 PM, Alex G. wrote:=0A=
>> On 07/31/2018 01:40 AM, Tal Gilboa wrote:=0A=
>> [snip]=0A=
>>>>>> @@ -2240,6 +2258,9 @@ static void pci_init_capabilities(struct=0A=
>>>>>> pci_dev *dev)=0A=
>>>>>>  =A0=A0=A0=A0=A0 /* Advanced Error Reporting */=0A=
>>>>>>  =A0=A0=A0=A0=A0 pci_aer_init(dev);=0A=
>>>>>> +=A0=A0=A0 /* Check link and detect downtrain errors */=0A=
>>>>>> +=A0=A0=A0 pcie_check_upstream_link(dev);=0A=
>>>>=0A=
>>>> This is called for every PCIe device right? Won't there be a=0A=
>>>> duplicated print in case a device loads with lower PCIe bandwidth=0A=
>>>> than needed?=0A=
>>>=0A=
>>> Alex, can you comment on this please?=0A=
>>=0A=
>> Of course I can.=0A=
>>=0A=
>> There's one print at probe() time, which happens if bandwidth < max. I=
=0A=
>> would think that's fine. There is a way to duplicate it, and that is if=
=0A=
>> the driver also calls print_link_status(). A few driver maintainers who=
=0A=
>> call it have indicated they'd be fine with removing it from the driver,=
=0A=
>> and leaving it in the core PCI.=0A=
> =0A=
> We would be fine with that as well. Please include the removal in your=0A=
> patches.=0A=
=0A=
What's the proper procedure? Do I wait for confirmation from Bjorn =0A=
before knocking on maintainer's doors, or do I William Wallace into =0A=
their trees and demand they merge the removal (pending Bjorn's approval =0A=
on the other side) ?=0A=
=0A=
Alex=0A=
=0A=
>>=0A=
>> Should the device come back at low speed, go away, then come back at=0A=
>> full speed we'd still only see one print from the first probe. Again, if=
=0A=
>> driver doesn't also call the function.=0A=
>> There's the corner case where the device come up at < max, goes away,=0A=
>> then comes back faster, but still < max. There will be two prints, but=
=0A=
>> they won't be true duplicates -- each one will indicate different BW.=0A=
> =0A=
> This is fine.=0A=
> =0A=
>>=0A=
>> Alex=0A=
>>=0A=
>>>>>> +=0A=
>>>>>>  =A0=A0=A0=A0=A0 if (pci_probe_reset_function(dev) =3D=3D 0)=0A=
>>>>>>  =A0=A0=A0=A0=A0=A0=A0=A0=A0 dev->reset_fn =3D 1;=0A=
>>>>>>  =A0 }=0A=
>>>>>> diff --git a/include/linux/pci.h b/include/linux/pci.h=0A=
>>>>>> index abd5d5e17aee..15bfab8f7a1b 100644=0A=
>>>>>> --- a/include/linux/pci.h=0A=
>>>>>> +++ b/include/linux/pci.h=0A=
>>>>>> @@ -1088,6 +1088,7 @@ int pcie_set_mps(struct pci_dev *dev, int mps)=
;=0A=
>>>>>>  =A0 u32 pcie_bandwidth_available(struct pci_dev *dev, struct pci_de=
v=0A=
>>>>>> **limiting_dev,=0A=
>>>>>>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 enum pci_bus=
_speed *speed,=0A=
>>>>>>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 enum pcie_li=
nk_width *width);=0A=
>>>>>> +void __pcie_print_link_status(struct pci_dev *dev, bool verbose);=
=0A=
>>>>>>  =A0 void pcie_print_link_status(struct pci_dev *dev);=0A=
>>>>>>  =A0 int pcie_flr(struct pci_dev *dev);=0A=
>>>>>>  =A0 int __pci_reset_function_locked(struct pci_dev *dev);=0A=
>>>>>=0A=
> =0A=
=0A=
