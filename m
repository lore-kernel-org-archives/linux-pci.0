Return-Path: <SRS0=n77T=HX=kontron.com=gilles.buloz@kernel.org>
Return-Path: <SRS0=n77T=HX=kontron.com=gilles.buloz@kernel.org>
From: Gilles Buloz <Gilles.Buloz@kontron.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: Bjorn Helgaas <bhelgaas@google.com>, linux-pci
	<linux-pci@vger.kernel.org>, "Minghuan.Lian@nxp.com" <Minghuan.Lian@nxp.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, Ard Biesheuvel
	<ard.biesheuvel@linaro.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PCI: Check whether bridges allow access to extended
 config space
Date: Fri, 4 May 2018 15:45:07 +0000
Message-ID: <5AEC8002.5000309@kontron.com>
References: <20180427165627.GA8199@bhelgaas-glaptop.roam.corp.google.com>
 <5AE6D7E2.9030506@kontron.com> <5AE71BF4.2010200@kontron.com>
 <20180430170447.GA95643@bhelgaas-glaptop.roam.corp.google.com>
 <5AE75809.30701@kontron.com> <5AE9B5BB.2080003@kontron.com>
 <20180502132501.GE11698@bhelgaas-glaptop.roam.corp.google.com>
 <5AE9C1AB.8020403@kontron.com>
 <20180502172341.GA123831@bhelgaas-glaptop.roam.corp.google.com>
 <5AEB033A.4060407@kontron.com>
 <20180503223127.GB15790@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20180503223127.GB15790@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
List-ID: <linux-pci.vger.kernel.org>

Le 04/05/2018 00:31, Bjorn Helgaas a =E9crit :
> [+cc LKML]
>
> On Thu, May 03, 2018 at 12:40:27PM +0000, Gilles Buloz wrote:
>> Subject:    [PATCH] For exception at PCI probe due to bridge reporting U=
R
>>
>> Even if a device supports extended config access, no such access must be
>> done to this device If there's a bridge not supporting that in the path
>> to this device. Doing such access with UR reporting enabled on the root
>> bridge leads to an exception.
>>
>> This is the case on a LS1043A CPU (NXP QorIQ Layerscape) platform with
>> the following bus topology :
>>    LS1043 PCIe root
>>      -> PEX8112 PCIe-to-PCI bridge (not supporting ext cfg on PCI side)
>>        -> PMC slot connector (for legacy PMC modules)
>> With a PMC module topology as follows :
>>    PMC connector
>>      -> PCI-to-PCIe bridge
>>        -> PCIe switch (4 ports)
>>          -> 4 PCIe devices (one on each port)
>> In this case all devices behind the PEX8112 are supporting extended conf=
ig
>> access but this is prohibited by the PEX8112. Without this patch, an
>> exception (synchronous abort) occurs in pci_cfg_space_size_ext().
>>
>> This patch checks the parent bridge of each allocated child bus to know =
if
>> extended config access is supported on the child bus, and sets a flag in
>> child->bus_flags if not supported. This  flag is inherited by all childr=
en
>> buses of this child bus and then is checked to avoid this unsupported
>> accesses to every device on these buses.
> Hi Gilles,
>
> Thanks for the patch!  I reworked it a little bit to simplify the code
> in pci_alloc_child_bus().  Can you test it and make sure I didn't
> break anything?
>
Hi Bjorn,

Your rework works as expected. Tested on LS1043A platform with kernel 4.17-=
rc1, and with some backport on kernel 4.1.35

Suggestion : maybe change the pci_info() string to have :
     pci_bus 0000:xx: extended config space not accessible
instead of
     pci_bus 0000:xx: extended config space not accessible on secondary bus
as xx is already the number of the secondary bus

Info : with kernel 4.17-rc1, it turns out I need pcie_aspm=3Doff to have th=
e PMC devices behind the
PCI-to-PCIe bridge of the PMC safely detected/configured. But this is not c=
aused by the patch.
Without pcie_aspm=3Doff I saw this at one boot :
    "pci 0000:02:0e.0: ASPM: Could not configure common clock" for this bri=
dge, but devices
    correctly detected/configured
but at most boots I get :
    no ASPM message but "pci 0000:04:02.0: bridge configuration invalid ([b=
us ff-ff]), reconfiguring "
    instead, and some devices are missing. Also lspci show "rev ff" for som=
e devices.
I don't see this problem on 4.1.35 with the same backported patch.

Gilles
> commit cbaaa85b558a8f974e301fa0364d568efaf491ce
> Author: Gilles Buloz <Gilles.Buloz@kontron.com>
> Date:   Thu May 3 15:21:44 2018 -0500
>
>      PCI: Check whether bridges allow access to extended config space
>     =20
>      Even if a device supports extended config space, i.e., it is a PCI-X=
 Mode 2
>      or a PCI Express device, the extended space may not be accessible if
>      there's a conventional PCI bus in the path to it.
>     =20
>      We currently figure that out in pci_cfg_space_size() by reading the =
first
>      dword of extended config space.  On most platforms that returns ~0 d=
ata if
>      the space is inaccessible, but it may set error bits in PCI status
>      registers, and on some platforms it causes exceptions that we curren=
tly
>      don't recover from.
>     =20
>      For example, a PCIe-to-conventional PCI bridge treats config transac=
tions
>      with a non-zero Extended Register Address as an Unsupported Request =
on PCIe
>      and a received Master-Abort on the destination bus (see PCI Express =
to
>      PCI/PCI-X Bridge spec, r1.0, sec 4.1.3).
>     =20
>      A sample case is a LS1043A CPU (NXP QorIQ Layerscape) platform with =
the
>      following bus topology:
>     =20
>        LS1043 PCIe Root Port
>          -> PEX8112 PCIe-to-PCI bridge (doesn't support ext cfg on PCI si=
de)
>            -> PMC slot connector (for legacy PMC modules)
>     =20
>      With a PMC module topology as follows:
>     =20
>        PMC connector
>          -> PCI-to-PCIe bridge
>            -> PCIe switch (4 ports)
>              -> 4 PCIe devices (one on each port)
>     =20
>      The PCIe devices on the PMC module support extended config space, bu=
t we
>      can't reach it because the PEX8112 can't generate accesses to the ex=
tended
>      space on its secondary bus.  Attempts to access it cause Unsupported
>      Request errors, which result in synchronous aborts on this platform.
>     =20
>      To avoid these errors, check whether bridges are capable of generati=
ng
>      extended config space addresses on their secondary interfaces.  If t=
hey
>      can't, we restrict devices below the bridge to only the 256-byte
>      PCI-compatible config space.
>     =20
>      Signed-off-by: Gilles Buloz <gilles.buloz@kontron.com>
>      [bhelgaas: changelog, rework patch so bus_flags testing is all in
>      pci_bridge_child_ext_cfg_accessible()]
>      Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index ac91b6fd0bcd..7b1b7b2e01e4 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -882,6 +882,45 @@ static int pci_register_host_bridge(struct pci_host_=
bridge *bridge)
>   =09return err;
>   }
>  =20
> +static bool pci_bridge_child_ext_cfg_accessible(struct pci_dev *bridge)
> +{
> +=09int pos;
> +=09u32 status;
> +
> +=09/*
> +=09 * If extended config space isn't accessible on a bridge's primary
> +=09 * bus, we certainly can't access it on the secondary bus.
> +=09 */
> +=09if (bridge->bus->bus_flags & PCI_BUS_FLAGS_NO_EXTCFG)
> +=09=09return false;
> +
> +=09/*
> +=09 * PCIe Root Ports and switch ports are PCIe on both sides, so if
> +=09 * extended config space is accessible on the primary, it's also
> +=09 * accessible on the secondary.
> +=09 */
> +=09if (pci_is_pcie(bridge) &&
> +=09    (pci_pcie_type(bridge) =3D=3D PCI_EXP_TYPE_ROOT_PORT ||
> +=09     pci_pcie_type(bridge) =3D=3D PCI_EXP_TYPE_UPSTREAM ||
> +=09     pci_pcie_type(bridge) =3D=3D PCI_EXP_TYPE_DOWNSTREAM))
> +=09=09return true;
> +
> +=09/*
> +=09 * For the other bridge types:
> +=09 *   - PCI-to-PCI bridges
> +=09 *   - PCIe-to-PCI/PCI-X forward bridges
> +=09 *   - PCI/PCI-X-to-PCIe reverse bridges
> +=09 * extended config space on the secondary side is only accessible
> +=09 * if the bridge supports PCI-X Mode 2.
> +=09 */
> +=09pos =3D pci_find_capability(bridge, PCI_CAP_ID_PCIX);
> +=09if (!pos)
> +=09=09return false;
> +
> +=09pci_read_config_dword(bridge, pos + PCI_X_STATUS, &status);
> +=09return status & (PCI_X_STATUS_266MHZ | PCI_X_STATUS_533MHZ);
> +}
> +
>   static struct pci_bus *pci_alloc_child_bus(struct pci_bus *parent,
>   =09=09=09=09=09   struct pci_dev *bridge, int busnr)
>   {
> @@ -923,6 +962,16 @@ static struct pci_bus *pci_alloc_child_bus(struct pc=
i_bus *parent,
>   =09pci_set_bus_of_node(child);
>   =09pci_set_bus_speed(child);
>  =20
> +=09/*
> +=09 * Check whether extended config space is accessible on the child
> +=09 * bus.  Note that we currently assume it is always accessible on
> +=09 * the root bus.
> +=09 */
> +=09if (!pci_bridge_child_ext_cfg_accessible(bridge)) {
> +=09=09child->bus_flags |=3D PCI_BUS_FLAGS_NO_EXTCFG;
> +=09=09pci_info(child, "extended config space not accessible on secondary=
 bus\n");
> +=09}
> +
>   =09/* Set up default resource pointers and names */
>   =09for (i =3D 0; i < PCI_BRIDGE_RESOURCE_NUM; i++) {
>   =09=09child->resource[i] =3D &bridge->resource[PCI_BRIDGE_RESOURCES+i];
> @@ -1393,6 +1442,9 @@ int pci_cfg_space_size(struct pci_dev *dev)
>   =09u32 status;
>   =09u16 class;
>  =20
> +=09if (dev->bus->bus_flags & PCI_BUS_FLAGS_NO_EXTCFG)
> +=09=09return PCI_CFG_SPACE_SIZE;
> +
>   =09class =3D dev->class >> 8;
>   =09if (class =3D=3D PCI_CLASS_BRIDGE_HOST)
>   =09=09return pci_cfg_space_size_ext(dev);
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 230615620a4a..f7aa6d9f8999 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -217,6 +217,7 @@ enum pci_bus_flags {
>   =09PCI_BUS_FLAGS_NO_MSI=09=3D (__force pci_bus_flags_t) 1,
>   =09PCI_BUS_FLAGS_NO_MMRBC=09=3D (__force pci_bus_flags_t) 2,
>   =09PCI_BUS_FLAGS_NO_AERSID=09=3D (__force pci_bus_flags_t) 4,
> +=09PCI_BUS_FLAGS_NO_EXTCFG=09=3D (__force pci_bus_flags_t) 8,
>   };
>  =20
>   /* Values from Link Status register, PCIe r3.1, sec 7.8.8 */
>
> .
>
