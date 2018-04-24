Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Alan Douglas <adouglas@cadence.com>
To: Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "Joao.Pinto@synopsys.com" <Joao.Pinto@synopsys.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "niklas.cassel@axis.com" <niklas.cassel@axis.com>,
        "jesper.nilsson@axis.com" <jesper.nilsson@axis.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [RFC 01/10] PCI: dwc: Add MSI-X callbacks handler
Date: Tue, 24 Apr 2018 14:05:26 +0000
Message-ID: <SN6PR07MB4512BED3D44003EF72EE06FDD8880@SN6PR07MB4512.namprd07.prod.outlook.com>
References: <cover.1523379766.git.gustavo.pimentel@synopsys.com>
 <77b7b2687e9618d3f7d1f11c3fc6ecec9a9442ef.1523379766.git.gustavo.pimentel@synopsys.com>
 <0b7023d9-29c6-0993-07d3-b046d25b67ff@ti.com>
 <e2fe7d5f-9f57-0e67-d321-541ff4706792@synopsys.com>
 <0e8b8ce9-db12-1e11-3eb5-62f3fa686d59@ti.com>
 <16d237b2-0052-447e-13cb-bc2f15848be4@synopsys.com>
In-Reply-To: <16d237b2-0052-447e-13cb-bc2f15848be4@synopsys.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Kishon,

On 24 April 2018 10:36 Gustavo Pimentel wrote:
> Hi Kishon,
>=20
> On 24/04/2018 08:07, Kishon Vijay Abraham I wrote:
> > Hi,
> >
> > On Monday 23 April 2018 03:06 PM, Gustavo Pimentel wrote:
> >> Hi Kishon,
> >>
> >> On 16/04/2018 10:29, Kishon Vijay Abraham I wrote:
> >>> Hi Gustavo,
> >>>
> >>> On Tuesday 10 April 2018 10:44 PM, Gustavo Pimentel wrote:
> >>>> Changes the pcie_raise_irq function signature, namely the
> >>>> interrupt_num variable type from u8 to u16 to accommodate the MSI-X
> >>>> maximum interrupts of 2048.
> >>>>
> >>>> Implements a PCIe config space capability iterator function to
> >>>> search and save the MSI and MSI-X pointers. With this method the
> >>>> code becomes more generic and flexible.
> >>>>
> >>>> Implements MSI-X set/get functions for sysfs interface in order to
> >>>> change the EP entries number.
> >>>>
> >>>> Implements EP MSI-X interface for triggering interruptions.
> >>>>
> >>>> Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> >>>> ---
> >>>>  drivers/pci/dwc/pci-dra7xx.c           |   2 +-
> >>>>  drivers/pci/dwc/pcie-artpec6.c         |   2 +-
> >>>>  drivers/pci/dwc/pcie-designware-ep.c   | 145
> ++++++++++++++++++++++++++++++++-
> >>>>  drivers/pci/dwc/pcie-designware-plat.c |   6 +-
> >>>>  drivers/pci/dwc/pcie-designware.h      |  23 +++++-
> >>>>  5 files changed, 173 insertions(+), 5 deletions(-)
> >>>>
> >>>> diff --git a/drivers/pci/dwc/pci-dra7xx.c
> >>>> b/drivers/pci/dwc/pci-dra7xx.c index ed8558d..5265725 100644
> >>>> --- a/drivers/pci/dwc/pci-dra7xx.c
> >>>> +++ b/drivers/pci/dwc/pci-dra7xx.c
> >>>> @@ -369,7 +369,7 @@ static void dra7xx_pcie_raise_msi_irq(struct
> >>>> dra7xx_pcie *dra7xx,  }
> >>>>
> >>>>  static int dra7xx_pcie_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
> >>>> -				 enum pci_epc_irq_type type, u8
> interrupt_num)
> >>>> +				 enum pci_epc_irq_type type, u16
> interrupt_num)
> >>>>  {
> >>>>  	struct dw_pcie *pci =3D to_dw_pcie_from_ep(ep);
> >>>>  	struct dra7xx_pcie *dra7xx =3D to_dra7xx_pcie(pci); diff --git
> >>>> a/drivers/pci/dwc/pcie-artpec6.c b/drivers/pci/dwc/pcie-artpec6.c
> >>>> index e66cede..96dc259 100644
> >>>> --- a/drivers/pci/dwc/pcie-artpec6.c
> >>>> +++ b/drivers/pci/dwc/pcie-artpec6.c
> >>>> @@ -428,7 +428,7 @@ static void artpec6_pcie_ep_init(struct
> >>>> dw_pcie_ep *ep)  }
> >>>>
> >>>>  static int artpec6_pcie_raise_irq(struct dw_pcie_ep *ep, u8 func_no=
,
> >>>> -				  enum pci_epc_irq_type type, u8
> interrupt_num)
> >>>> +				  enum pci_epc_irq_type type, u16
> interrupt_num)
> >>>>  {
> >>>>  	struct dw_pcie *pci =3D to_dw_pcie_from_ep(ep);
> >>>>
> >>>> diff --git a/drivers/pci/dwc/pcie-designware-ep.c
> >>>> b/drivers/pci/dwc/pcie-designware-ep.c
> >>>> index 15b22a6..874d4c2 100644
> >>>> --- a/drivers/pci/dwc/pcie-designware-ep.c
> >>>> +++ b/drivers/pci/dwc/pcie-designware-ep.c
> >>>> @@ -40,6 +40,44 @@ void dw_pcie_ep_reset_bar(struct dw_pcie
> *pci, enum pci_barno bar)
> >>>>  	__dw_pcie_ep_reset_bar(pci, bar, 0);  }
> >>>>
> >>>> +void dw_pcie_ep_find_cap_addr(struct dw_pcie_ep *ep) {
> >>>
> >>> This should be implemented in a generic way similar to
> pci_find_capability().
> >>> It'll be useful when we try to implement other capabilities as well.
> >>
> >> Hum, what you suggest? Something implemented on the pci-epf-core?
> >
> > yeah, Initially thought it could be implemented as a helper function
> > in pci-epc-core so that both designware and cadence can use it.
>=20
> That would be nice, however I couldn't find out how to access the config
> space, through the pci_epf or pci_epc structs.
>=20
> So, I reworked the functions like this:
>=20
> (on pcie-designware-ep.c)
>=20
> u8 __dw_pcie_ep_find_next_cap(struct dw_pcie *pci, u8 cap_ptr,
>                               u8 cap)
> {
>         u8 cap_id, next_cap_ptr;
>         u16 reg;
>=20
>         reg =3D dw_pcie_readw_dbi(pci, cap_ptr);
>         next_cap_ptr =3D (reg & 0xff00) >> 8;
>         cap_id =3D (reg & 0x00ff);
>=20
>         if (!next_cap_ptr || cap_id > PCI_CAP_ID_MAX)
>                 return 0;
>=20
>         if (cap_id =3D=3D cap)
>                 return cap_ptr;
>=20
>         return __dw_pcie_ep_find_next_cap(pci, next_cap_ptr, cap); }
>=20
> u8 dw_pcie_ep_find_capability(struct dw_pcie *pci, u8 cap) {
>         u8 next_cap_ptr;
>         u16 reg;
>=20
>         reg =3D dw_pcie_readw_dbi(pci, PCI_CAPABILITY_LIST);
>         next_cap_ptr =3D (reg & 0x00ff);
>=20
>         if (!next_cap_ptr)
>                 return 0;
>=20
>         return __dw_pcie_ep_find_next_cap(pci, next_cap_ptr, cap); }
>=20
> int dw_pcie_ep_init(struct dw_pcie_ep *ep) { [...]
>         ep->msi_cap =3D dw_pcie_ep_find_capability(pci, PCI_CAP_ID_MSI);
>         ep->msix_cap =3D dw_pcie_ep_find_capability(pci, PCI_CAP_ID_MSIX)=
; [...]
> }
>=20
> >
> > But do we really have to find the address like this? since all
> > designware IP's will have a particular capability at a fixed address
> > offset, why not follow use existing mechanism in dw_pcie_ep_get_msi?
>=20
> The capabilities are not fixed to a specific address offset by default th=
ey
> assume those values, but they can be easily change at design stage.
>=20
> >
> > Or is it possible for a particular capability to have address offsets
> > for different vendors? How is it for cadence?
>=20
> Yes, it's possible to have different address offset for different vendors=
.
>=20
For cadence the offsets are fixed for each specific hw (if a capability is=
=20
disabled it will just be removed from the linked list) but it would be=20
better to allow for the possibility for them to vary between different hw.

> >
> > Thanks
> > Kishon
> >
>=20
> Thanks,
> Gustavo
Regards,
Alan
