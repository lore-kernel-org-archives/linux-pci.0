Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
To: Bjorn Helgaas <helgaas@kernel.org>,
        Marc Zyngier <marc.zyngier@arm.com>
CC: "robh@kernel.org" <robh@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "colin.king@canonical.com" <colin.king@canonical.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 3/3] PCI: Xilinx NWL PCIe: Fix Error for multi function
 device for legacy interrupts.
Date: Thu, 2 Mar 2017 08:46:18 +0000
Message-ID: <8520D5D51A55D047800579B094147198263F7207@XAP-PVEXMBX02.xlnx.xilinx.com>
References: <1472553558-27215-1-git-send-email-bharatku@xilinx.com>
 <1472553558-27215-3-git-send-email-bharatku@xilinx.com>
 <57C57975.7040306@arm.com>
 <8520D5D51A55D047800579B094147198258D239D@XAP-PVEXMBX01.xlnx.xilinx.com>
 <57C59FE8.30307@arm.com>
 <8520D5D51A55D047800579B094147198258D28AF@XAP-PVEXMBX01.xlnx.xilinx.com>
 <57C6B7F1.5000001@arm.com>
 <8520D5D51A55D047800579B094147198258D2C99@XAP-PVEXMBX01.xlnx.xilinx.com>
 <20160912220241.GG23532@localhost> <57D7ADA8.5060201@arm.com>
 <20160913150511.GC27748@localhost>
In-Reply-To: <20160913150511.GC27748@localhost>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

Any one is working on fix for this issue ?=20

Regards,
Bharat

> -----Original Message-----
> From: Bjorn Helgaas [mailto:helgaas@kernel.org]
> Sent: Tuesday, September 13, 2016 8:35 PM
> To: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Bharat Kumar Gogada <bharatku@xilinx.com>; robh@kernel.org;
> bhelgaas@google.com; colin.king@canonical.com; Soren Brinkmann
> <sorenb@xilinx.com>; Michal Simek <michals@xilinx.com>; arnd@arndb.de;
> linux-arm-kernel@lists.infradead.org; linux-pci@vger.kernel.org; linux-
> kernel@vger.kernel.org; Ravikiran Gummaluri <rgummal@xilinx.com>
> Subject: Re: [PATCH 3/3] PCI: Xilinx NWL PCIe: Fix Error for multi functi=
on device
> for legacy interrupts.
>=20
> On Tue, Sep 13, 2016 at 08:41:28AM +0100, Marc Zyngier wrote:
> > On 12/09/16 23:02, Bjorn Helgaas wrote:
> > > On Thu, Sep 01, 2016 at 05:19:55AM +0000, Bharat Kumar Gogada wrote:
> > >>>>>>> Hi Bharat,
> > >>>>>>>> @@ -561,7 +561,7 @@ static int
> > >>>>>>>> nwl_pcie_init_irq_domain(struct nwl_pcie
> > >>>>>>> *pcie)
> > >>>>>>>>     }
> > >>>>>>>>
> > >>>>>>>>     pcie->legacy_irq_domain =3D
> irq_domain_add_linear(legacy_intc_node,
> > >>>>>>>> -                                                   INTX_NUM,
> > >>>>>>>> +                                                   INTX_NUM
> > >>>>>>>> + + 1,
> > >>>>>>>>                                                     &legacy_do=
main_ops,
> > >>>>>>>>                                                     pcie);
> > >>>>>>>
> > >>>>>>> This feels like the wrong thing to do. You have INTX_NUM irqs,
> > >>>>>>> so the domain allocation should reflect this. On the other
> > >>>>>>> hand, the way the driver currently deals with mappings is
> > >>>>>>> quite broken (consistently adding 1 to
> > >>>>> the HW interrupt).
> > >>>>>>>
> > >>>>>> Hi Marc,
> > >>>>>>
> > >>>>>> Without above change I get following crash in kernel while booti=
ng.
> > >>>>>>
> > >>>>>> [    2.441684] error: hwirq 0x4 is too large for dummy
> > >>>>>>
> > >>>>>> [    2.441694] ------------[ cut here ]------------
> > >>>>>>
> > >>>>>> [    2.441698] WARNING: at kernel/irq/irqdomain.c:344
> > >>>>>>
> > >>>>>> [    2.441702] Modules linked in:
> > >>>>>>
> > >>>>>> [    2.441706]
> > >>>>>>
> > >>>>>> [    2.441714] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 4.4.0 #=
8
> > >>>>>>
> > >>>>>> [    2.441718] Hardware name: xlnx,zynqmp (DT)
> > >>>>>>
> > >>>>>> [    2.441723] task: ffffffc071886b80 ti: ffffffc071888000 task.=
ti:
> > >>>>> ffffffc071888000
> > >>>>>>
> > >>>>>> [    2.441732] PC is at irq_domain_associate+0x138/0x1c0
> > >>>>>>
> > >>>>>> [    2.441738] LR is at irq_domain_associate+0x138/0x1c0
> > >>>>>>
> > >>>>>> In kernel/irq/irqdomain.c function irq_domain_associate
> > >>>>>>
> > >>>>>> if (WARN(hwirq >=3D domain->hwirq_max,
> > >>>>>>                  "error: hwirq 0x%x is too large for %s\n",
> > >>>>>> (int)hwirq, domain-
> > >>>> name))
> > >>>>>>                 return -EINVAL;
> > >>>>>>
> > >>>>>> Here the hwirq and hwirq_max are equal to 4 without the above
> > >>>>>> condition
> > >>>>> (INTX_NUM + 1) due to which crash is coming.
> > >>>>>> This is happening as the legacy interrupts are starting from 1 (=
INTA).
> > >>>>>
> > >>>>> I understood that. I'm still persisting in saying that you have t=
he wrong
> fix.
> > >>>>>
> > >>>>> Your domain should always allocate many interrupts as you have
> > >>>>> interrupt sources. These interrupts (hwirq) should be numbered
> > >>>>> from 0 to (n-
> > >>> 1).
> > >>>>
> > >>>> Agreed, but here comes the problem the hwirq for legacy
> > >>>> interrupts will start at 0x1 to 0x4 (INTA to INTD) and these
> > >>>> values are as per PCIe specification for legacy interrupts. So
> > >>>> these cannot be numbered from 0. So when 0x4 (INTD) for a
> > >>>> multi-function device comes the crash occurs.
> > >>>
> > >>> So who provides this hwirq? Who calls irq_domain_associate() with
> > >>> hwirq set to 4?
> > >>>
> > >> PCIe subsystem invokes pcibios_add_device function in
> arch/arm64/kernel/pci.c for every pci device.
> > >> The purpose of this function is to assign dev->irq using
> of_irq_parse_and_map_pci.
> > >> of_irq_parse_and_map_pci invokes of_irq_parse_pci where it reads
> > >> PCI_INTERRUPT_PIN from configuration space and saves it in parameter=
 of
> struct of_phandle_args.
> > >> This structure is passed to irq_create_of_mapping where it invokes
> irq_create_fwspec_mapping.
> > >> irq_create_fwspec_mapping invokes irq_domain_translate and gets
> > >> hwirq, here the above saved PCI_INTERRUPT_PIN value is assigned to h=
wirq
> (*hwirq =3D fwspec->param[0]).
> > >> And then using this hwirq irq_create_mapping -> irq_domain_associate
> were invoked and mapping is created for virtual irq with this hwirq.
> > >> So for any end point PCI_INTERRUPT_PIN value starts from 0x1 to 0x4 =
and
> so hwirq starts from 0x1 to 0x4.
> > >>
> > >> So the values are more generic w.r.t to protocol, that's why hwirq w=
ill
> range from 0x1 to 0x4.
> > >> And then if you check pcie-altera.c they are doing this adding one i=
n their
> handler and while creating legacy domain.
> > >
> > > Is this resolved yet?  Marc, are you happy, or should we iterate on
> > > this again?
> >
> > Ah, sorry to have dropped the ball on this patch.
>=20
> No problem, I wasn't making forward progress anyway.
>=20
> > I guess that given that the infrastructure imposes the hwirq range on
> > the host drivers, Bharat's approach is the only way (and a number of
> > other host drivers are already slightly broken). I'll try and have a
> > look at solving this at the generic level. In the meantime:
> >
> > Acked-by: Marc Zyngier <marc.zyngier@arm.com>
>=20
> After looking at this myself, I'm not happy with this either.  It feels l=
ike there are
> bugs lurking here and we're just hiding one of them.
>=20
> Here are the callers of irq_domain_add_linear() for legacy INTx in
> drivers/pci/host:
>=20
>   advk_pcie_init_irq_domain    LEGACY_IRQ_NUM   (4)
>   dra7xx_pcie_init_irq_domain  4
>   ks_dw_pcie_host_init         MAX_LEGACY_IRQS  (4)
>   altera_pcie_init_irq_domain  INTX_NUM + 1     (5)
>   nwl_pcie_init_irq_domain     INTX_NUM + 1     (5)
>   xilinx_pcie_init_irq_domain  4
>=20
> I think all of these use the of_irq_parse_and_map_pci() path you mentione=
d, so
> if the problem is in the way that path works, I would think these should =
*all* be
> requesting the same number of interrupts in the domain.
>=20
> I agree with Marc that we should request 4 IRQs, because that's what we n=
eed.
> If we can't do that for some reason, we ought to at least make all these =
callers
> the same.
>=20
> Bjorn
