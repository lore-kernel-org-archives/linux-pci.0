Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-dm3nam03on0076.outbound.protection.outlook.com ([104.47.41.76]:42273
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750914AbcHaJ4L (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 31 Aug 2016 05:56:11 -0400
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
Date: Wed, 31 Aug 2016 09:56:02 +0000
Message-ID: <8520D5D51A55D047800579B094147198258D28AF@XAP-PVEXMBX01.xlnx.xilinx.com>
References: <1472553558-27215-1-git-send-email-bharatku@xilinx.com>
 <1472553558-27215-3-git-send-email-bharatku@xilinx.com>
 <57C57975.7040306@arm.com>
 <8520D5D51A55D047800579B094147198258D239D@XAP-PVEXMBX01.xlnx.xilinx.com>
 <57C59FE8.30307@arm.com>
In-Reply-To: <57C59FE8.30307@arm.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

 > On 30/08/16 15:13, Bharat Kumar Gogada wrote:
> >> Hi Bharat,
> >>> @@ -561,7 +561,7 @@ static int nwl_pcie_init_irq_domain(struct
> >>> nwl_pcie
> >> *pcie)
> >>>     }
> >>>
> >>>     pcie->legacy_irq_domain =3D irq_domain_add_linear(legacy_intc_nod=
e,
> >>> -                                                   INTX_NUM,
> >>> +                                                   INTX_NUM + 1,
> >>>                                                     &legacy_domain_op=
s,
> >>>                                                     pcie);
> >>
> >> This feels like the wrong thing to do. You have INTX_NUM irqs, so the
> >> domain allocation should reflect this. On the other hand, the way the
> >> driver currently deals with mappings is quite broken (consistently add=
ing 1 to
> the HW interrupt).
> >>
> > Hi Marc,
> >
> > Without above change I get following crash in kernel while booting.
> >
> > [    2.441684] error: hwirq 0x4 is too large for dummy
> >
> > [    2.441694] ------------[ cut here ]------------
> >
> > [    2.441698] WARNING: at kernel/irq/irqdomain.c:344
> >
> > [    2.441702] Modules linked in:
> >
> > [    2.441706]
> >
> > [    2.441714] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 4.4.0 #8
> >
> > [    2.441718] Hardware name: xlnx,zynqmp (DT)
> >
> > [    2.441723] task: ffffffc071886b80 ti: ffffffc071888000 task.ti:
> ffffffc071888000
> >
> > [    2.441732] PC is at irq_domain_associate+0x138/0x1c0
> >
> > [    2.441738] LR is at irq_domain_associate+0x138/0x1c0
> >
> > In kernel/irq/irqdomain.c function irq_domain_associate
> >
> > if (WARN(hwirq >=3D domain->hwirq_max,
> >                  "error: hwirq 0x%x is too large for %s\n", (int)hwirq,=
 domain->name))
> >                 return -EINVAL;
> >
> > Here the hwirq and hwirq_max are equal to 4 without the above condition
> (INTX_NUM + 1) due to which crash is coming.
> > This is happening as the legacy interrupts are starting from 1 (INTA).
>=20
> I understood that. I'm still persisting in saying that you have the wrong=
 fix.
>=20
> Your domain should always allocate many interrupts as you have interrupt
> sources. These interrupts (hwirq) should be numbered from 0 to (n-1).

Agreed, but here comes the problem the hwirq for legacy interrupts will sta=
rt at 0x1 to 0x4 (INTA to INTD) and=20
these values are as per PCIe specification for legacy interrupts.
So these cannot be numbered from 0. So when 0x4 (INTD) for a multi-function=
 device comes the crash occurs.
=09
>=20
> > And I'm  consistently adding 1 to the HW interrupt as in
> > nwl_pcie_leg_handler I get 0th bit set from MSGF_LEG_STATUS if INTA
> > interrupt is raised but my hwirq number being mapped for INTA is 0x1
> > so that's I'm adding 1 to obtain correct virtual irq. Same case in
> > nwl_pcie_free_irq_domain since hwirq starts from one I'm adding 1 to
> > obtain virtual irq and free it.
>=20
> I can see that. Nonetheless, this is wrong. Can you please test the patch=
 I
> provided in my reply and report what happens?

Can you be more specific on what is the wrong, I'm adding one since the hwi=
rq starts from 0x1 as mentioned=20
above.
I did try your suggestion with Ethernet card, but kernel hangs (it does not=
 show any crash also, just hangs) when I do=20
interface up (without bit + 1, using only bit position in handler). This is=
 not working because in the legacy domain virq mapping
starts with hwirq 0x1, there is no mapping for 0x0 in the domain, so EP int=
errupt is not serviced since virq being returned is zero.

Thanks & Regards,
Bharat



=20
