Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Gilles Buloz <Gilles.Buloz@kontron.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: LS1043A : "synchronous abort" at boot due to PCI config read
Date: Mon, 30 Apr 2018 13:36:53 +0000
Message-ID: <5AE71BF4.2010200@kontron.com>
References: <5AD0E995.3090802@kontron.com>
 <CAKv+Gu_v4V8DUa6f4WxvjZHoJbbqT0mKpOwYVmaLaE20CB3U_g@mail.gmail.com>
 <5AE317AB.4020404@kontron.com>
 <20180427165627.GA8199@bhelgaas-glaptop.roam.corp.google.com>
 <5AE6D7E2.9030506@kontron.com>
In-Reply-To: <5AE6D7E2.9030506@kontron.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="_002_5AE71BF42010200kontroncom_"
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci <linux-pci@vger.kernel.org>,
 "Minghuan.Lian@nxp.com" <Minghuan.Lian@nxp.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

--_002_5AE71BF42010200kontroncom_
Content-Type: text/plain; charset=WINDOWS-1252
Content-ID: <0168611BECA21D40A7FDF3A2952A0424@Kontron.com>
Content-Transfer-Encoding: quoted-printable

Le 30/04/2018 10:46, Gilles BULOZ a =E9crit :
> Le 27/04/2018 18:56, Bjorn Helgaas a =E9crit :
>> On Fri, Apr 27, 2018 at 12:29:32PM +0000, Gilles Buloz wrote:
>>> Le 27/04/2018 10:43, Ard Biesheuvel a =E9crit :
>>>> (add Bjorn and linux-pci)
>>>>
>>>> On 13 April 2018 at 19:32, Gilles Buloz <Gilles.Buloz@kontron.com> wro=
te:
>>>>> Dear developers,
>>>>>
>>>>> I currently have two functional workarounds for this issue but
>>>>> would like to know which one you would recommend, if any :-) I'm
>>>>> using a LS1043A CPU (NXP QorIQ Layerscape) and get a "synchronous
>>>>> external abort" when booting because of a PCI config read during
>>>>> PCI scan.
>>>>>
>>>>> I'm using a custom hardware (based on LS1043ARDB) having a
>>>>> PEX8112 PCIe-to-PCI bridge connected to the LS1043A to have a PCI
>>>>> slot for legacy devices. This bridge only supports PCI-Compatible
>>>>> config accesses (offset 0x00-0xFF).
>> I would guess the PEX8112 itself has 4K of config space, but it only
>> forwards 256 bytes of config space to the conventional PCI secondary
>> bus.
>>
>>>>> On this PCI slot I connect a PCI module made of a PCI-to-PCIe
>>>>> bridge plus PCIe devices behind.
>>>>>
>>>>> The problem occurs when the kernel probes the PCIe devices : as
>>>>> they are PCIe devices, the kernel does a PCI config read access
>>>>> at offset 0x100 to check if "PCIe extended capability registers"
>>>>> are accessible (see drivers/pci/probe.c, function
>>>>> pci_cfg_space_size_ext()). Unfortunately the PEX8112 PCIe-to-PCI
>>>>> bridge that is in the path reports an error to the CPU for this
>>>>> access, and it seems there's no way to disable that on this
>>>>> bridge.
>>>>>
>>>>> The first workaround I found was to patch
>>>>> drivers/pci/host/pci-layerscape.c to have PCIE_ABSERR_SETTING set
>>>>> to 0x9400 instead of 0x9401 (for PCIE_ABSERR register) to disable
>>>>> error reporting. This only impacts an NXP part of the Linux
>>>>> kernel code, but I'm not sure this is a good idea (however it
>>>>> seems to be like that on Intel platforms where even MEM accesses
>>>>> to a no-device address return FF without any error).
>>>>>
>>>>> I've also tried another workaround that works : patch
>>>>> drivers/pci/probe.c to use bus_flags to remember if a bus is
>>>>> behind a bridge without extended address capability, to avoid PCi
>>>>> config read accesses at offset 0x100 in pci_cfg_space_size() /
>>>>> pci_cfg_space_size_ext(). But this patch impacts the generic PCI
>>>>> probe method of Linux.
>>>>>
>>>>> Any Idea to properly handle that issue ?
>>>>>
>>>> This seems like a rather unusual configuration, but I guess that
>>>> if the first bridge/switch advertises its inability to support
>>>> extended config space accesses, we should not be performing them
>>>> on any of its subordinate buses. How does the PEX8112 advertise
>>>> this limitation?
>>>>
>>>> That said, I wonder if it is reasonable in the first place to
>>>> expect that a PCIe device works as expected passing through a
>>>> legacy PCI layer like that.
>>>>
>>> The PEX8112 PCIe-to-PCI bridge has capability PCI_CAP_ID_EXP, but
>>> has no PCI_CAP_ID_PCIX capability.  As I understand the lack of
>>> PCI_CAP_ID_PCIX is advertising this limitation on the PCI side (no
>>> support for PCI config offset >=3D0x100).
>> Sounds right to me.
>>
>>> Also I guess in the case of a bridge having PCI_CAP_ID_PCIX, this
>>> limitation would be advertised by the lack of PCI_X_STATUS_266MHZ
>>> and PCI_X_STATUS_533MHZ (as done in drivers/pci/probe.c at
>>> pci_cfg_space_size())
>> Also sounds right.  Per the PCI-X spec, checking for PCI_X_STATUS_266MHZ
>> should be enough, but it shouldn't hurt to check for either
>> PCI_X_STATUS_266MHZ or PCI_X_STATUS_533MHZ.
>>
>>> I'm currently using the attached patch (for kernel 4.1.35-rt41 from
>>> NXP Yocto BSP). It uses bus_flags to remember if a bus is behind a
>>> bridge without extended address capability to avoid PCi config
>>> accesses at offset >=3D 0x100. Thanks to this patch I now have a
>>> functional system with functional PCI/PCIe devices.
>> The patch seems like it's looking at the right things, but I don't
>> want to build it into pci_scan_bridge_extend() because that function
>> is much too complicated already.
>>
>> I'd rather build it into pci_cfg_space_size() or
>> pci_cfg_space_size_ext() somehow.  Maybe something along these lines?
>> This doesn't account for the case of a PCIe-to-PCI-X Mode 2 bridge; in
>> that case, I think all 4K would be accessible on the PCI-X side.
>>
>> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
>> index ac91b6fd0bcd..d8b091f0bcd1 100644
>> --- a/drivers/pci/probe.c
>> +++ b/drivers/pci/probe.c
>> @@ -1367,7 +1367,7 @@ static bool pci_ext_cfg_is_aliased(struct pci_dev =
*dev)
>>    * pci_cfg_space_size - Get the configuration space size of the PCI de=
vice
>>    * @dev: PCI device
>>    *
>> - * Regular PCI devices have 256 bytes, but PCI-X 2 and PCI Express devi=
ces
>> + * Regular PCI devices have 256 bytes, but PCI-X Mode 2 and PCI Express=
 devices
>>    * have 4096 bytes.  Even if the device is capable, that doesn't mean =
we can
>>    * access it.  Maybe we don't have a way to generate extended config s=
pace
>>    * accesses, or the device is behind a reverse Express bridge.  So we =
try
>> @@ -1376,9 +1376,14 @@ static bool pci_ext_cfg_is_aliased(struct pci_dev=
 *dev)
>>    */
>>   static int pci_cfg_space_size_ext(struct pci_dev *dev)
>>   {
>> +    struct pci_dev *bridge =3D pci_upstream_bridge(dev);
>>       u32 status;
>>       int pos =3D PCI_CFG_SPACE_SIZE;
>>   +    if (bridge && pci_is_pcie(bridge) &&
>> +        pci_pcie_type(bridge) =3D=3D PCI_EXP_TYPE_PCI_BRIDGE)
>> +        return PCI_CFG_SPACE_SIZE;
>> +
>>       if (pci_read_config_dword(dev, pos, &status) !=3D PCIBIOS_SUCCESSF=
UL)
>>           return PCI_CFG_SPACE_SIZE;
>>       if (status =3D=3D 0xffffffff || pci_ext_cfg_is_aliased(dev))
>>
>>> --- include/linux/pci.h.orig 2018-03-26 16:51:18.050000000 +0000
>>> +++ include/linux/pci.h    2018-03-26 16:51:27.660000000 +0000
>>> @@ -193,6 +193,7 @@
>>>   enum pci_bus_flags {
>>>       PCI_BUS_FLAGS_NO_MSI   =3D (__force pci_bus_flags_t) 1,
>>>       PCI_BUS_FLAGS_NO_MMRBC =3D (__force pci_bus_flags_t) 2,
>>> +    PCI_BUS_FLAGS_COMPAT_CFG_SPACE =3D (__force pci_bus_flags_t) 4,
>>>   };
>>>     /* These values come from the PCI Express Spec */
>>> --- drivers/pci/probe.c.orig    2018-01-22 09:29:52.000000000 +0000
>>> +++ drivers/pci/probe.c    2018-03-26 16:54:30.830000000 +0000
>>> @@ -827,6 +827,28 @@
>>>               child->primary =3D primary;
>>>               pci_bus_insert_busn_res(child, secondary, subordinate);
>>>               child->bridge_ctl =3D bctl;
>>> +
>>> +            {
>>> +                int pos;
>>> +                u32 status;
>>> +                bool pci_compat_cfg_space =3D false;
>>> +
>>> +                if (!pci_is_pcie(dev) || (pci_pcie_type(dev) =3D=3D PC=
I_EXP_TYPE_PCIE_BRIDGE) || (pci_pcie_type(dev) =3D=3D=20
>>> PCI_EXP_TYPE_PCI_BRIDGE)) {
>>> +                    /* for PCI/PCI bridges, or PCIe/PCI bridge in forw=
ard or reverse mode, we have to check for PCI-X=20
>>> capabilities */
>>> +                    pos =3D pci_find_capability(dev, PCI_CAP_ID_PCIX);
>>> +                    if (pos) {
>>> +                        pci_read_config_dword(dev, pos + PCI_X_STATUS,=
 &status);
>>> +                        if (!(status & (PCI_X_STATUS_266MHZ | PCI_X_ST=
ATUS_533MHZ)))
>>> +                            pci_compat_cfg_space =3D true;
>>> +                    } else {
>>> +                        pci_compat_cfg_space =3D true;
>>> +                    }
>>> +                    if (pci_compat_cfg_space) {
>>> +                        dev_info(&dev->dev, "[%04x:%04x] Child bus lim=
ited to PCI-Compatible config space\n", dev->vendor,=20
>>> dev->device);
>>> +                        child->bus_flags |=3D PCI_BUS_FLAGS_COMPAT_CFG=
_SPACE;
>>> +                    }
>>> +                }
>>> +            }
>>>           }
>>>             cmax =3D pci_scan_child_bus(child);
>>> @@ -1098,6 +1120,11 @@
>>>               goto fail;
>>>       }
>>>   +    if (dev->bus->bus_flags & PCI_BUS_FLAGS_COMPAT_CFG_SPACE) {
>>> +        dev_info(&dev->dev, "[%04x:%04x] PCI-Compatible config space o=
nly due to parent bus(es)\n", dev->vendor, dev->device);
>>> +        return PCI_CFG_SPACE_SIZE;
>>> +    }
>>> +
>>>       return pci_cfg_space_size_ext(dev);
>>>      fail:
> Bjorn,
> If I'm right about your proposed patch to pci_cfg_space_size_ext(), *brid=
ge is pointing to the upper device of device *dev being=20
> checked. I understand the purpose, but I think this fails for my config t=
hat is :
>
> LS1043 PCIe root -> PEX8112 PCIe-to-PCI bridge -> PMC slot connector -> P=
CI-to-PCIe bridge -> PCIe switch (4 ports) -> 4 PCIe=20
> devices (one on each port)
>
> because :
> - when pci_cfg_space_size_ext() is run on the 4 PCIe devices, *bridge is =
the PCIe switch which is not matching=20
> PCI_EXP_TYPE_PCI_BRIDGE. In this case *bridge should also be checked for =
the parent bus of the PCIe switch, and so on.
> - when pci_cfg_space_size_ext() is run for the PCI-to-PCIe bridge, *bridg=
e is the PEX8112 that is also not matching=20
> PCI_EXP_TYPE_PCI_BRIDGE but PCI_EXP_TYPE_PCIE_BRIDGE. This leads to a con=
fig access at offset 0x100 to the PCI-to-PCIe bridge, so=20
> a crash (because of the PEX8112)
>
> I think setting a bit in bus_flags when creating a child bus is very effi=
cient because once set it is automatically inherited by=20
> all child buses and then the only thing that pci_cfg_space_size() has to =
do for each device is to check for this bit. Also this=20
> PCI_BUS_FLAGS_COMPAT_CFG_SPACE flag is actually a bus property that is co=
mpliant with the purpose of bus_flags.
>
> I agree that pci_scan_bridge_extend() is already too complicated, so woul=
d you be okay to only add one line to it :
>   pci_bus_set_compat_cfg_space(child);
> and put all the code I suggested in this new function pci_bus_set_compat_=
cfg_space() ? (also supporting PCI-X Mode 2 devices)
> Improvement : this function can return immediately if the child bus has a=
lready inherited the flag from its parent.
>
I mean something like the attached patch I tested this morning...
Sorry, this is for old kernel 4.1.35 but just to clarify what I propose (al=
so applies to 4.16.6 by changing value of=20
PCI_BUS_FLAGS_COMPAT_CFG_SPACE in pci.h to 8).

--_002_5AE71BF42010200kontroncom_
Content-Type: text/x-patch; name=cfgspace2_4.1.35.patch
Content-Description: cfgspace2_4.1.35.patch
Content-Disposition: attachment; filename="cfgspace2_4.1.35.patch"; size=2201;
	creation-date="Mon, 30 Apr 2018 13:36:53 GMT";
	modification-date="Mon, 30 Apr 2018 13:36:53 GMT"
Content-ID: <C224F344D4A5E549AD84B7118DE41854@Kontron.com>
Content-Transfer-Encoding: base64

LS0tIGluY2x1ZGUvbGludXgvcGNpLmgub3JpZwkyMDE4LTAzLTI2IDE2OjUxOjE4LjA1MDAwMDAw
MCArMDAwMA0KKysrIGluY2x1ZGUvbGludXgvcGNpLmgJMjAxOC0wNC0zMCAwOTo1MDo1Ny42NjAw
MDAwMDAgKzAwMDANCkBAIC0xOTMsNiArMTkzLDcgQEANCiBlbnVtIHBjaV9idXNfZmxhZ3Mgew0K
IAlQQ0lfQlVTX0ZMQUdTX05PX01TSSAgID0gKF9fZm9yY2UgcGNpX2J1c19mbGFnc190KSAxLA0K
IAlQQ0lfQlVTX0ZMQUdTX05PX01NUkJDID0gKF9fZm9yY2UgcGNpX2J1c19mbGFnc190KSAyLA0K
KwlQQ0lfQlVTX0ZMQUdTX0NPTVBBVF9DRkdfU1BBQ0UgPSAoX19mb3JjZSBwY2lfYnVzX2ZsYWdz
X3QpIDQsDQogfTsNCiANCiAvKiBUaGVzZSB2YWx1ZXMgY29tZSBmcm9tIHRoZSBQQ0kgRXhwcmVz
cyBTcGVjICovDQotLS0gZHJpdmVycy9wY2kvcHJvYmUuYy5vcmlnCTIwMTgtMDEtMjIgMDk6Mjk6
NTIuMDAwMDAwMDAwICswMDAwDQorKysgZHJpdmVycy9wY2kvcHJvYmUuYwkyMDE4LTA0LTMwIDEz
OjI5OjUwLjYwMDAwMDAwMCArMDAwMA0KQEAgLTc1NCw2ICs3NTQsMzUgQEANCiAJCQkJCSBQQ0lf
RVhQX1JUQ1RMX0NSU1NWRSk7DQogfQ0KIA0KK3N0YXRpYyB2b2lkIHBjaV9idXNfY2hlY2tfY29t
cGF0X2NmZ19zcGFjZShzdHJ1Y3QgcGNpX2J1cyAqYnVzKQ0KK3sNCisJc3RydWN0IHBjaV9kZXYg
KmRldiA9IGJ1cy0+c2VsZjsNCisJYm9vbCBwY2lfY29tcGF0X2NmZ19zcGFjZSA9IGZhbHNlOw0K
KwlpbnQgcG9zOw0KKwl1MzIgc3RhdHVzOw0KKw0KKwlpZiAoYnVzLT5idXNfZmxhZ3MgJiBQQ0lf
QlVTX0ZMQUdTX0NPTVBBVF9DRkdfU1BBQ0UpDQorCQlyZXR1cm47DQorDQorCWlmICghcGNpX2lz
X3BjaWUoZGV2KSB8fCAvKiBQQ0kvUENJIGJyaWRnZSAqLw0KKwkgICAgKHBjaV9wY2llX3R5cGUo
ZGV2KSA9PSBQQ0lfRVhQX1RZUEVfUENJRV9CUklER0UpIHx8IC8qIFBDSWUvUENJIGJyaWRnZSBp
biBmb3J3YXJkIG1vZGUgKi8NCisJICAgIChwY2lfcGNpZV90eXBlKGRldikgPT0gUENJX0VYUF9U
WVBFX1BDSV9CUklER0UpKSB7ICAvKiBQQ0llL1BDSSBicmlkZ2UgaW4gcmV2ZXJzZSBtb2RlICov
DQorCQlwb3MgPSBwY2lfZmluZF9jYXBhYmlsaXR5KGRldiwgUENJX0NBUF9JRF9QQ0lYKTsNCisJ
CWlmIChwb3MpIHsNCisJCQlwY2lfcmVhZF9jb25maWdfZHdvcmQoZGV2LCBwb3MgKyBQQ0lfWF9T
VEFUVVMsICZzdGF0dXMpOw0KKwkJCWlmICghKHN0YXR1cyAmIChQQ0lfWF9TVEFUVVNfMjY2TUha
IHwgUENJX1hfU1RBVFVTXzUzM01IWikpKQ0KKwkJCQlwY2lfY29tcGF0X2NmZ19zcGFjZSA9IHRy
dWU7DQorCQl9IGVsc2Ugew0KKwkJCXBjaV9jb21wYXRfY2ZnX3NwYWNlID0gdHJ1ZTsNCisJCX0N
CisJCWlmIChwY2lfY29tcGF0X2NmZ19zcGFjZSkgew0KKwkJCWRldl9pbmZvKCZkZXYtPmRldiwg
ImJ1cyAlMDJ4IGxpbWl0ZWQgdG8gUENJLUNvbXBhdGlibGUgY29uZmlnIHNwYWNlXG4iLA0KKwkJ
CQkgYnVzLT5udW1iZXIpOw0KKwkJCWJ1cy0+YnVzX2ZsYWdzIHw9IFBDSV9CVVNfRkxBR1NfQ09N
UEFUX0NGR19TUEFDRTsNCisJCX0NCisJfQ0KK30NCisNCiAvKg0KICAqIElmIGl0J3MgYSBicmlk
Z2UsIGNvbmZpZ3VyZSBpdCBhbmQgc2NhbiB0aGUgYnVzIGJlaGluZCBpdC4NCiAgKiBGb3IgQ2Fy
ZEJ1cyBicmlkZ2VzLCB3ZSBkb24ndCBzY2FuIGJlaGluZCBhcyB0aGUgZGV2aWNlcyB3aWxsDQpA
QCAtODI3LDYgKzg1Niw3IEBADQogCQkJY2hpbGQtPnByaW1hcnkgPSBwcmltYXJ5Ow0KIAkJCXBj
aV9idXNfaW5zZXJ0X2J1c25fcmVzKGNoaWxkLCBzZWNvbmRhcnksIHN1Ym9yZGluYXRlKTsNCiAJ
CQljaGlsZC0+YnJpZGdlX2N0bCA9IGJjdGw7DQorCQkJcGNpX2J1c19jaGVja19jb21wYXRfY2Zn
X3NwYWNlKGNoaWxkKTsNCiAJCX0NCiANCiAJCWNtYXggPSBwY2lfc2Nhbl9jaGlsZF9idXMoY2hp
bGQpOw0KQEAgLTEwODQsNiArMTExNCw5IEBADQogCXUzMiBzdGF0dXM7DQogCXUxNiBjbGFzczsN
CiANCisJaWYgKGRldi0+YnVzLT5idXNfZmxhZ3MgJiBQQ0lfQlVTX0ZMQUdTX0NPTVBBVF9DRkdf
U1BBQ0UpDQorCQlyZXR1cm4gUENJX0NGR19TUEFDRV9TSVpFOw0KKw0KIAljbGFzcyA9IGRldi0+
Y2xhc3MgPj4gODsNCiAJaWYgKGNsYXNzID09IFBDSV9DTEFTU19CUklER0VfSE9TVCkNCiAJCXJl
dHVybiBwY2lfY2ZnX3NwYWNlX3NpemVfZXh0KGRldik7DQo=
--_002_5AE71BF42010200kontroncom_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--_002_5AE71BF42010200kontroncom_--
