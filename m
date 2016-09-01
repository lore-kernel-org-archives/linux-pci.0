Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
To: Marc Zyngier <marc.zyngier@arm.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "colin.king@canonical.com" <colin.king@canonical.com>,
        Soren Brinkmann <sorenb@xilinx.com>,
        Michal Simek <michals@xilinx.com>,
        "arnd@arndb.de" <arnd@arndb.de>
CC: "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ravikiran Gummaluri <rgummal@xilinx.com>
Subject: RE: [PATCH 3/3] PCI: Xilinx NWL PCIe: Fix Error for multi function
 device for legacy interrupts.
Date: Thu, 1 Sep 2016 05:19:55 +0000
Message-ID: <8520D5D51A55D047800579B094147198258D2C99@XAP-PVEXMBX01.xlnx.xilinx.com>
References: <1472553558-27215-1-git-send-email-bharatku@xilinx.com>
 <1472553558-27215-3-git-send-email-bharatku@xilinx.com>
 <57C57975.7040306@arm.com>
 <8520D5D51A55D047800579B094147198258D239D@XAP-PVEXMBX01.xlnx.xilinx.com>
 <57C59FE8.30307@arm.com>
 <8520D5D51A55D047800579B094147198258D28AF@XAP-PVEXMBX01.xlnx.xilinx.com>
 <57C6B7F1.5000001@arm.com>
In-Reply-To: <57C6B7F1.5000001@arm.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> >>>> Hi Bharat,
> >>>>> @@ -561,7 +561,7 @@ static int nwl_pcie_init_irq_domain(struct
> >>>>> nwl_pcie
> >>>> *pcie)
> >>>>>     }
> >>>>>
> >>>>>     pcie->legacy_irq_domain =3D irq_domain_add_linear(legacy_intc_n=
ode,
> >>>>> -                                                   INTX_NUM,
> >>>>> +                                                   INTX_NUM + 1,
> >>>>>                                                     &legacy_domain_=
ops,
> >>>>>                                                     pcie);
> >>>>
> >>>> This feels like the wrong thing to do. You have INTX_NUM irqs, so
> >>>> the domain allocation should reflect this. On the other hand, the
> >>>> way the driver currently deals with mappings is quite broken
> >>>> (consistently adding 1 to
> >> the HW interrupt).
> >>>>
> >>> Hi Marc,
> >>>
> >>> Without above change I get following crash in kernel while booting.
> >>>
> >>> [    2.441684] error: hwirq 0x4 is too large for dummy
> >>>
> >>> [    2.441694] ------------[ cut here ]------------
> >>>
> >>> [    2.441698] WARNING: at kernel/irq/irqdomain.c:344
> >>>
> >>> [    2.441702] Modules linked in:
> >>>
> >>> [    2.441706]
> >>>
> >>> [    2.441714] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 4.4.0 #8
> >>>
> >>> [    2.441718] Hardware name: xlnx,zynqmp (DT)
> >>>
> >>> [    2.441723] task: ffffffc071886b80 ti: ffffffc071888000 task.ti:
> >> ffffffc071888000
> >>>
> >>> [    2.441732] PC is at irq_domain_associate+0x138/0x1c0
> >>>
> >>> [    2.441738] LR is at irq_domain_associate+0x138/0x1c0
> >>>
> >>> In kernel/irq/irqdomain.c function irq_domain_associate
> >>>
> >>> if (WARN(hwirq >=3D domain->hwirq_max,
> >>>                  "error: hwirq 0x%x is too large for %s\n", (int)hwir=
q, domain-
> >name))
> >>>                 return -EINVAL;
> >>>
> >>> Here the hwirq and hwirq_max are equal to 4 without the above
> >>> condition
> >> (INTX_NUM + 1) due to which crash is coming.
> >>> This is happening as the legacy interrupts are starting from 1 (INTA)=
.
> >>
> >> I understood that. I'm still persisting in saying that you have the wr=
ong fix.
> >>
> >> Your domain should always allocate many interrupts as you have
> >> interrupt sources. These interrupts (hwirq) should be numbered from 0 =
to (n-
> 1).
> >
> > Agreed, but here comes the problem the hwirq for legacy interrupts
> > will start at 0x1 to 0x4 (INTA to INTD) and these values are as per
> > PCIe specification for legacy interrupts. So these cannot be numbered
> > from 0. So when 0x4 (INTD) for a multi-function device comes the crash
> > occurs.
>=20
> So who provides this hwirq? Who calls irq_domain_associate() with hwirq s=
et to
> 4?
>=20
PCIe subsystem invokes pcibios_add_device function in arch/arm64/kernel/pci=
.c for every pci device.
The purpose of this function is to assign dev->irq using of_irq_parse_and_m=
ap_pci.
of_irq_parse_and_map_pci invokes of_irq_parse_pci where it reads PCI_INTERR=
UPT_PIN from configuration space and saves it
in parameter of struct of_phandle_args.
This structure is passed to irq_create_of_mapping where it invokes irq_crea=
te_fwspec_mapping.
irq_create_fwspec_mapping invokes irq_domain_translate and gets hwirq, here=
 the above saved PCI_INTERRUPT_PIN value is assigned=20
to hwirq (*hwirq =3D fwspec->param[0]).
And then using this hwirq irq_create_mapping -> irq_domain_associate were i=
nvoked and mapping is created for virtual irq with this hwirq.
So for any end point PCI_INTERRUPT_PIN value starts from 0x1 to 0x4 and so =
hwirq starts from 0x1 to 0x4.

So the values are more generic w.r.t to protocol, that's why hwirq will ran=
ge from 0x1 to 0x4.=20
And then if you check pcie-altera.c they are doing this adding one in their=
 handler and while creating legacy domain.
=20
Thanks & Regards,
Bharat
=20

=20
