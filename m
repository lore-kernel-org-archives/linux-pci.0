Return-Path: <SRS0=UQhf=HT=kontron.com=gilles.buloz@kernel.org>
Return-Path: <SRS0=UQhf=HT=kontron.com=gilles.buloz@kernel.org>
From: Gilles Buloz <Gilles.Buloz@kontron.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: Bjorn Helgaas <bhelgaas@google.com>, linux-pci
	<linux-pci@vger.kernel.org>, "Minghuan.Lian@nxp.com" <Minghuan.Lian@nxp.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, Ard Biesheuvel
	<ard.biesheuvel@linaro.org>
Subject: Re: LS1043A : "synchronous abort" at boot due to PCI config read
Date: Mon, 30 Apr 2018 17:53:14 +0000
Message-ID: <5AE75809.30701@kontron.com>
References: <5AD0E995.3090802@kontron.com>
 <CAKv+Gu_v4V8DUa6f4WxvjZHoJbbqT0mKpOwYVmaLaE20CB3U_g@mail.gmail.com>
 <5AE317AB.4020404@kontron.com>
 <20180427165627.GA8199@bhelgaas-glaptop.roam.corp.google.com>
 <5AE6D7E2.9030506@kontron.com> <5AE71BF4.2010200@kontron.com>
 <20180430170447.GA95643@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20180430170447.GA95643@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
List-ID: <linux-pci.vger.kernel.org>

Le 30/04/2018 19:04, Bjorn Helgaas a =E9crit :
> On Mon, Apr 30, 2018 at 01:36:53PM +0000, Gilles Buloz wrote:
>> Le 30/04/2018 10:46, Gilles BULOZ a =E9crit :
>>> Le 27/04/2018 18:56, Bjorn Helgaas a =E9crit :
>>>> On Fri, Apr 27, 2018 at 12:29:32PM +0000, Gilles Buloz wrote:
>>>>> Le 27/04/2018 10:43, Ard Biesheuvel a =E9crit :
>>>>>> (add Bjorn and linux-pci)
>>>>>>
>>>>>> On 13 April 2018 at 19:32, Gilles Buloz <Gilles.Buloz@kontron.com> w=
rote:
>>>>>>> Dear developers,
>>>>>>>
>>>>>>> I currently have two functional workarounds for this issue but
>>>>>>> would like to know which one you would recommend, if any :-) I'm
>>>>>>> using a LS1043A CPU (NXP QorIQ Layerscape) and get a "synchronous
>>>>>>> external abort" when booting because of a PCI config read during
>>>>>>> PCI scan.
>>>>>>>
>>>>>>> I'm using a custom hardware (based on LS1043ARDB) having a
>>>>>>> PEX8112 PCIe-to-PCI bridge connected to the LS1043A to have a PCI
>>>>>>> slot for legacy devices. This bridge only supports PCI-Compatible
>>>>>>> config accesses (offset 0x00-0xFF).
>>>> I would guess the PEX8112 itself has 4K of config space, but it only
>>>> forwards 256 bytes of config space to the conventional PCI secondary
>>>> bus.
>>>>
>>>>>>> On this PCI slot I connect a PCI module made of a PCI-to-PCIe
>>>>>>> bridge plus PCIe devices behind.
>>>>>>>
>>>>>>> The problem occurs when the kernel probes the PCIe devices : as
>>>>>>> they are PCIe devices, the kernel does a PCI config read access
>>>>>>> at offset 0x100 to check if "PCIe extended capability registers"
>>>>>>> are accessible (see drivers/pci/probe.c, function
>>>>>>> pci_cfg_space_size_ext()). Unfortunately the PEX8112 PCIe-to-PCI
>>>>>>> bridge that is in the path reports an error to the CPU for this
>>>>>>> access, and it seems there's no way to disable that on this
>>>>>>> bridge.
>>>>>>>
>>>>>>> The first workaround I found was to patch
>>>>>>> drivers/pci/host/pci-layerscape.c to have PCIE_ABSERR_SETTING set
>>>>>>> to 0x9400 instead of 0x9401 (for PCIE_ABSERR register) to disable
>>>>>>> error reporting. This only impacts an NXP part of the Linux
>>>>>>> kernel code, but I'm not sure this is a good idea (however it
>>>>>>> seems to be like that on Intel platforms where even MEM accesses
>>>>>>> to a no-device address return FF without any error).
>>>>>>>
>>>>>>> I've also tried another workaround that works : patch
>>>>>>> drivers/pci/probe.c to use bus_flags to remember if a bus is
>>>>>>> behind a bridge without extended address capability, to avoid PCi
>>>>>>> config read accesses at offset 0x100 in pci_cfg_space_size() /
>>>>>>> pci_cfg_space_size_ext(). But this patch impacts the generic PCI
>>>>>>> probe method of Linux.
>>>>>>>
>>>>>>> Any Idea to properly handle that issue ?
>>>>>>>
>>>>>> This seems like a rather unusual configuration, but I guess that
>>>>>> if the first bridge/switch advertises its inability to support
>>>>>> extended config space accesses, we should not be performing them
>>>>>> on any of its subordinate buses. How does the PEX8112 advertise
>>>>>> this limitation?
>>>>>>
>>>>>> That said, I wonder if it is reasonable in the first place to
>>>>>> expect that a PCIe device works as expected passing through a
>>>>>> legacy PCI layer like that.
>>>>>>
>>>>> The PEX8112 PCIe-to-PCI bridge has capability PCI_CAP_ID_EXP, but
>>>>> has no PCI_CAP_ID_PCIX capability.  As I understand the lack of
>>>>> PCI_CAP_ID_PCIX is advertising this limitation on the PCI side (no
>>>>> support for PCI config offset >=3D0x100).
>>>> Sounds right to me.
>>>>
>>>>> Also I guess in the case of a bridge having PCI_CAP_ID_PCIX, this
>>>>> limitation would be advertised by the lack of PCI_X_STATUS_266MHZ
>>>>> and PCI_X_STATUS_533MHZ (as done in drivers/pci/probe.c at
>>>>> pci_cfg_space_size())
>>>> Also sounds right.  Per the PCI-X spec, checking for PCI_X_STATUS_266M=
HZ
>>>> should be enough, but it shouldn't hurt to check for either
>>>> PCI_X_STATUS_266MHZ or PCI_X_STATUS_533MHZ.
>>>>
>>>>> I'm currently using the attached patch (for kernel 4.1.35-rt41 from
>>>>> NXP Yocto BSP). It uses bus_flags to remember if a bus is behind a
>>>>> bridge without extended address capability to avoid PCi config
>>>>> accesses at offset >=3D 0x100. Thanks to this patch I now have a
>>>>> functional system with functional PCI/PCIe devices.
>>>> The patch seems like it's looking at the right things, but I don't
>>>> want to build it into pci_scan_bridge_extend() because that function
>>>> is much too complicated already.
>>>>
>>>> I'd rather build it into pci_cfg_space_size() or
>>>> pci_cfg_space_size_ext() somehow.  Maybe something along these lines?
>>>> This doesn't account for the case of a PCIe-to-PCI-X Mode 2 bridge; in
>>>> that case, I think all 4K would be accessible on the PCI-X side.
>>>>
>>>> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
>>>> index ac91b6fd0bcd..d8b091f0bcd1 100644
>>>> --- a/drivers/pci/probe.c
>>>> +++ b/drivers/pci/probe.c
>>>> @@ -1367,7 +1367,7 @@ static bool pci_ext_cfg_is_aliased(struct pci_de=
v *dev)
>>>>     * pci_cfg_space_size - Get the configuration space size of the PCI=
 device
>>>>     * @dev: PCI device
>>>>     *
>>>> - * Regular PCI devices have 256 bytes, but PCI-X 2 and PCI Express de=
vices
>>>> + * Regular PCI devices have 256 bytes, but PCI-X Mode 2 and PCI Expre=
ss devices
>>>>     * have 4096 bytes.  Even if the device is capable, that doesn't me=
an we can
>>>>     * access it.  Maybe we don't have a way to generate extended confi=
g space
>>>>     * accesses, or the device is behind a reverse Express bridge.  So =
we try
>>>> @@ -1376,9 +1376,14 @@ static bool pci_ext_cfg_is_aliased(struct pci_d=
ev *dev)
>>>>     */
>>>>    static int pci_cfg_space_size_ext(struct pci_dev *dev)
>>>>    {
>>>> +    struct pci_dev *bridge =3D pci_upstream_bridge(dev);
>>>>        u32 status;
>>>>        int pos =3D PCI_CFG_SPACE_SIZE;
>>>>    +    if (bridge && pci_is_pcie(bridge) &&
>>>> +        pci_pcie_type(bridge) =3D=3D PCI_EXP_TYPE_PCI_BRIDGE)
>>>> +        return PCI_CFG_SPACE_SIZE;
>>>> +
>>>>        if (pci_read_config_dword(dev, pos, &status) !=3D PCIBIOS_SUCCE=
SSFUL)
>>>>            return PCI_CFG_SPACE_SIZE;
>>>>        if (status =3D=3D 0xffffffff || pci_ext_cfg_is_aliased(dev))
>>>>
>>>>> --- include/linux/pci.h.orig 2018-03-26 16:51:18.050000000 +0000
>>>>> +++ include/linux/pci.h    2018-03-26 16:51:27.660000000 +0000
>>>>> @@ -193,6 +193,7 @@
>>>>>    enum pci_bus_flags {
>>>>>        PCI_BUS_FLAGS_NO_MSI   =3D (__force pci_bus_flags_t) 1,
>>>>>        PCI_BUS_FLAGS_NO_MMRBC =3D (__force pci_bus_flags_t) 2,
>>>>> +    PCI_BUS_FLAGS_COMPAT_CFG_SPACE =3D (__force pci_bus_flags_t) 4,
>>>>>    };
>>>>>      /* These values come from the PCI Express Spec */
>>>>> --- drivers/pci/probe.c.orig    2018-01-22 09:29:52.000000000 +0000
>>>>> +++ drivers/pci/probe.c    2018-03-26 16:54:30.830000000 +0000
>>>>> @@ -827,6 +827,28 @@
>>>>>                child->primary =3D primary;
>>>>>                pci_bus_insert_busn_res(child, secondary, subordinate)=
;
>>>>>                child->bridge_ctl =3D bctl;
>>>>> +
>>>>> +            {
>>>>> +                int pos;
>>>>> +                u32 status;
>>>>> +                bool pci_compat_cfg_space =3D false;
>>>>> +
>>>>> +                if (!pci_is_pcie(dev) || (pci_pcie_type(dev) =3D=3D =
PCI_EXP_TYPE_PCIE_BRIDGE) || (pci_pcie_type(dev) =3D=3D
>>>>> PCI_EXP_TYPE_PCI_BRIDGE)) {
>>>>> +                    /* for PCI/PCI bridges, or PCIe/PCI bridge in fo=
rward or reverse mode, we have to check for PCI-X
>>>>> capabilities */
>>>>> +                    pos =3D pci_find_capability(dev, PCI_CAP_ID_PCIX=
);
>>>>> +                    if (pos) {
>>>>> +                        pci_read_config_dword(dev, pos + PCI_X_STATU=
S, &status);
>>>>> +                        if (!(status & (PCI_X_STATUS_266MHZ | PCI_X_=
STATUS_533MHZ)))
>>>>> +                            pci_compat_cfg_space =3D true;
>>>>> +                    } else {
>>>>> +                        pci_compat_cfg_space =3D true;
>>>>> +                    }
>>>>> +                    if (pci_compat_cfg_space) {
>>>>> +                        dev_info(&dev->dev, "[%04x:%04x] Child bus l=
imited to PCI-Compatible config space\n", dev->vendor,
>>>>> dev->device);
>>>>> +                        child->bus_flags |=3D PCI_BUS_FLAGS_COMPAT_C=
FG_SPACE;
>>>>> +                    }
>>>>> +                }
>>>>> +            }
>>>>>            }
>>>>>              cmax =3D pci_scan_child_bus(child);
>>>>> @@ -1098,6 +1120,11 @@
>>>>>                goto fail;
>>>>>        }
>>>>>    +    if (dev->bus->bus_flags & PCI_BUS_FLAGS_COMPAT_CFG_SPACE) {
>>>>> +        dev_info(&dev->dev, "[%04x:%04x] PCI-Compatible config space=
 only due to parent bus(es)\n", dev->vendor, dev->device);
>>>>> +        return PCI_CFG_SPACE_SIZE;
>>>>> +    }
>>>>> +
>>>>>        return pci_cfg_space_size_ext(dev);
>>>>>       fail:
>>> Bjorn,
>>> If I'm right about your proposed patch to
>>> pci_cfg_space_size_ext(), *bridge is pointing to the upper device
>>> of device *dev being checked. I understand the purpose, but I
>>> think this fails for my config that is :
>>>
>>> LS1043 PCIe root -> PEX8112 PCIe-to-PCI bridge -> PMC slot connector ->=
 PCI-to-PCIe bridge -> PCIe switch (4 ports) -> 4 PCIe
>>> devices (one on each port)
>>>
>>> because :
>>> - when pci_cfg_space_size_ext() is run on the 4 PCIe devices,
>>> *bridge is the PCIe switch which is not matching
>>> PCI_EXP_TYPE_PCI_BRIDGE. In this case *bridge should also be
>>> checked for the parent bus of the PCIe switch, and so on.
>>> - when pci_cfg_space_size_ext() is run for the PCI-to-PCIe bridge,
>>> *bridge is the PEX8112 that is also not matching
>>> PCI_EXP_TYPE_PCI_BRIDGE but PCI_EXP_TYPE_PCIE_BRIDGE. This leads
>>> to a config access at offset 0x100 to the PCI-to-PCIe bridge, so a
>>> crash (because of the PEX8112)
>>>
>>> I think setting a bit in bus_flags when creating a child bus is
>>> very efficient because once set it is automatically inherited by
>>> all child buses and then the only thing that pci_cfg_space_size()
>>> has to do for each device is to check for this bit. Also this
>>> PCI_BUS_FLAGS_COMPAT_CFG_SPACE flag is actually a bus property
>>> that is compliant with the purpose of bus_flags.
> Yeah, it needs to be inherited somehow, and I don't like the idea of
> traversing up the tree, so I prefer your idea.  Although I don't
> actually see the inheritance in the patch below -- I thought there
> would be something like this:
>
>    dev =3D bus->self;
>    parent_bus =3D dev->bus;
>    if (parent_bus && parent_bus->bus_flags & PCI_BUS_FLAGS_COMPAT_CFG_SPA=
CE)
>      bus->bus_flags |=3D PCI_BUS_FLAGS_COMPAT_CFG_SPACE;
>
> pci_scan_bridge_extend() calls pci_add_new_bus() from two places.  You
> added a call to pci_bus_check_compat_cfg_space() at one of them, and
> it's not obvious why we wouldn't need it at the other place, too.
>
> Can you set this up in pci_alloc_child_bus()?  If you can put it
> there, it would be clear that every time we allocate a secondary bus,
> we figure out whether extended config space is accessible on that bus.
>
> That doesn't cover the root bus case, where we currently assume the
> host bridge can generate config accesses to all config space supported
> by devices on the root bus.  But we don't have a problem there, so I
> guess we don't need to worry about it now.
>
> If you can put it in pci_alloc_child_bus(), could you make your new
> function return a boolean, e.g., pci_bus_ext_cfg_accessible(), or
> similar, and then use the result to set the
> PCI_BUS_FLAGS_COMPAT_CFG_SPACE flag?  Names like "*_check_*()" don't
> tell the reader much about what's happening.
>
>>> I agree that pci_scan_bridge_extend() is already too complicated,
>>> so would you be okay to only add one line to it :
>>>    pci_bus_set_compat_cfg_space(child);
>>> and put all the code I suggested in this new function
>>> pci_bus_set_compat_cfg_space() ? (also supporting PCI-X Mode 2
>>> devices)
>>>
>>> Improvement : this function can return immediately if the child
>>> bus has already inherited the flag from its parent.
>> I mean something like the attached patch I tested this morning...
>> Sorry, this is for old kernel 4.1.35 but just to clarify what I
>> propose (also applies to 4.16.6 by changing value of
>> PCI_BUS_FLAGS_COMPAT_CFG_SPACE in pci.h to 8).
>> --- include/linux/pci.h.orig=092018-03-26 16:51:18.050000000 +0000
>> +++ include/linux/pci.h=092018-04-30 09:50:57.660000000 +0000
>> @@ -193,6 +193,7 @@
>>   enum pci_bus_flags {
>>   =09PCI_BUS_FLAGS_NO_MSI   =3D (__force pci_bus_flags_t) 1,
>>   =09PCI_BUS_FLAGS_NO_MMRBC =3D (__force pci_bus_flags_t) 2,
>> +=09PCI_BUS_FLAGS_COMPAT_CFG_SPACE =3D (__force pci_bus_flags_t) 4,
>>   };
>>  =20
>>   /* These values come from the PCI Express Spec */
>> --- drivers/pci/probe.c.orig=092018-01-22 09:29:52.000000000 +0000
>> +++ drivers/pci/probe.c=092018-04-30 13:29:50.600000000 +0000
>> @@ -754,6 +754,35 @@
>>   =09=09=09=09=09 PCI_EXP_RTCTL_CRSSVE);
>>   }
>>  =20
>> +static void pci_bus_check_compat_cfg_space(struct pci_bus *bus)
>> +{
>> +=09struct pci_dev *dev =3D bus->self;
>> +=09bool pci_compat_cfg_space =3D false;
>> +=09int pos;
>> +=09u32 status;
>> +
>> +=09if (bus->bus_flags & PCI_BUS_FLAGS_COMPAT_CFG_SPACE)
>> +=09=09return;
>> +
>> +=09if (!pci_is_pcie(dev) || /* PCI/PCI bridge */
>> +=09    (pci_pcie_type(dev) =3D=3D PCI_EXP_TYPE_PCIE_BRIDGE) || /* PCIe/=
PCI bridge in forward mode */
>> +=09    (pci_pcie_type(dev) =3D=3D PCI_EXP_TYPE_PCI_BRIDGE)) {  /* PCIe/=
PCI bridge in reverse mode */
>> +=09=09pos =3D pci_find_capability(dev, PCI_CAP_ID_PCIX);
>> +=09=09if (pos) {
>> +=09=09=09pci_read_config_dword(dev, pos + PCI_X_STATUS, &status);
>> +=09=09=09if (!(status & (PCI_X_STATUS_266MHZ | PCI_X_STATUS_533MHZ)))
>> +=09=09=09=09pci_compat_cfg_space =3D true;
>> +=09=09} else {
>> +=09=09=09pci_compat_cfg_space =3D true;
>> +=09=09}
>> +=09=09if (pci_compat_cfg_space) {
>> +=09=09=09dev_info(&dev->dev, "bus %02x limited to PCI-Compatible config=
 space\n",
>> +=09=09=09=09 bus->number);
>> +=09=09=09bus->bus_flags |=3D PCI_BUS_FLAGS_COMPAT_CFG_SPACE;
>> +=09=09}
>> +=09}
>> +}
>> +
>>   /*
>>    * If it's a bridge, configure it and scan the bus behind it.
>>    * For CardBus bridges, we don't scan behind as the devices will
>> @@ -827,6 +856,7 @@
>>   =09=09=09child->primary =3D primary;
>>   =09=09=09pci_bus_insert_busn_res(child, secondary, subordinate);
>>   =09=09=09child->bridge_ctl =3D bctl;
>> +=09=09=09pci_bus_check_compat_cfg_space(child);
>>   =09=09}
>>  =20
>>   =09=09cmax =3D pci_scan_child_bus(child);
>> @@ -1084,6 +1114,9 @@
>>   =09u32 status;
>>   =09u16 class;
>>  =20
>> +=09if (dev->bus->bus_flags & PCI_BUS_FLAGS_COMPAT_CFG_SPACE)
>> +=09=09return PCI_CFG_SPACE_SIZE;
>> +
>>   =09class =3D dev->class >> 8;
>>   =09if (class =3D=3D PCI_CLASS_BRIDGE_HOST)
>>   =09=09return pci_cfg_space_size_ext(dev);
>
The inheritence is made by this line in pci_alloc_child_bus() :
     child->bus_flags =3D parent->bus_flags;
So once we detect a limitation on a bridge impacting a child bus and that w=
e set the flag in child->bus_flags, this flag is=20
automatically present in the child->bus_flags of all its children buses.

I agree with your remarks and will create a function named pci_bus_check_co=
mpat_cfg_space() that will be called from=20
pci_alloc_child_bus().
I'll test that on Wednesday 2th and will give you my feedback.
