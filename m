Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:37220 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752841AbaKLQcO (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 12 Nov 2014 11:32:14 -0500
Message-ID: <1415809929.2876.5.camel@pengutronix.de>
Subject: Re: [PATCH v2] PCI: designware: Add support 4 ATUs assignment
From: Lucas Stach <l.stach@pengutronix.de>
To: Srikanth Thokala <sriku.linux@gmail.com>
Cc: Lian Minghuan-B31939 <B31939@freescale.com>,
	Minghuan Lian <Minghuan.Lian@freescale.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Zang Roy-R61911 <r61911@freescale.com>,
	Hu Mingkai-B21284 <B21284@freescale.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 12 Nov 2014 17:32:09 +0100
In-Reply-To: <CA+mB=1KObT9O783SMcvHy8nJGQPnxyKgP332r5bHx-K_D+LhVg@mail.gmail.com>
References: <1415682444-24911-1-git-send-email-Minghuan.Lian@freescale.com>
	 <CA+mB=1+4Dzxhbin6z0PUENvjUz-y8bq-K09FXTnSepFvVfe9HQ@mail.gmail.com>
	 <546308DD.40109@freescale.com>
	 <CA+mB=1K=Oyzdb2yfBvPRG9DHi-PFjRPtVS_dY9JMOz6dQog8QQ@mail.gmail.com>
	 <546331E7.5060003@freescale.com>
	 <CA+mB=1KObT9O783SMcvHy8nJGQPnxyKgP332r5bHx-K_D+LhVg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Am Mittwoch, den 12.11.2014, 21:53 +0530 schrieb Srikanth Thokala:
> Hi Minghuan,
> 
> On Wed, Nov 12, 2014 at 3:39 PM, Lian Minghuan-B31939
> <B31939@freescale.com> wrote:
> > Hi Srikanth,
> >
> > please see my comments inline.
> >
> > Thanks,
> > Minghuan
> >
> >
> > On 2014年11月12日 17:01, Srikanth Thokala wrote:
> >>
> >> Hi Minghuan,
> >>
> >> On Wed, Nov 12, 2014 at 12:44 PM, Lian Minghuan-B31939
> >> <B31939@freescale.com> wrote:
> >>>
> >>> Hi  Srikanth,
> >>>
> >>> Thanks for your comments, please see my reply inline.
> >>>
> >>>
> >>> On 2014年11月12日 14:22, Srikanth Thokala wrote:
> >>>>
> >>>> Hi,
> >>>>
> >>>> On Tue, Nov 11, 2014 at 10:37 AM, Minghuan Lian
> >>>> <Minghuan.Lian@freescale.com> wrote:
> >>>>>
> >>>>> Currently, pcie-designware.c only supports two ATUs, ATU0 is used
> >>>>> for CFG0 and MEM, ATU1 is used for CFG1 and IO. There is a conflict
> >>>>> when MEM and CFG0 are accessed simultaneously. The patch adds
> >>>>> 'num-atus' property to PCIe dts node to describe the number of
> >>>>> PCIe controller's ATUs. If num_atus is bigger than or equal to 4,
> >>>>> we will change ATUs assignment: ATU0 for CFG0, ATU1 for CFG1,
> >>>>> ATU2 for MEM, ATU3 for IO.
> >>>>>
> >>>>> Signed-off-by: Minghuan Lian <Minghuan.Lian@freescale.com>
> >>>>> ---
> >>>>> change log:
> >>>>> v1-v2:
> >>>>> 1. add the default value to property num-atus description
> >>>>> 2. Use atu_idx[] instead of single values
> >>>>> 3. initialize num_atus to 2
> >>>>>
> >>>>>    .../devicetree/bindings/pci/designware-pcie.txt    |  1 +
> >>>>>    drivers/pci/host/pcie-designware.c                 | 53
> >>>>> ++++++++++++++++------
> >>>>>    drivers/pci/host/pcie-designware.h                 |  9 ++++
> >>>>>    3 files changed, 50 insertions(+), 13 deletions(-)
> >>>>>
> >>>>> diff --git a/Documentation/devicetree/bindings/pci/designware-pcie.txt
> >>>>> b/Documentation/devicetree/bindings/pci/designware-pcie.txt
> >>>>> index 9f4faa8..64d0533 100644
> >>>>> --- a/Documentation/devicetree/bindings/pci/designware-pcie.txt
> >>>>> +++ b/Documentation/devicetree/bindings/pci/designware-pcie.txt
> >>>>> @@ -26,3 +26,4 @@ Optional properties:
> >>>>>    - bus-range: PCI bus numbers covered (it is recommended for new
> >>>>> devicetrees to
> >>>>>      specify this property, to keep backwards compatibility a range of
> >>>>> 0x00-0xff
> >>>>>      is assumed if not present)
> >>>>> +- num-atus: number of ATUs. The default value is 2 if not present.
> >>>>> diff --git a/drivers/pci/host/pcie-designware.c
> >>>>> b/drivers/pci/host/pcie-designware.c
> >>>>> index dfed00a..46a609d 100644
> >>>>> --- a/drivers/pci/host/pcie-designware.c
> >>>>> +++ b/drivers/pci/host/pcie-designware.c
> >>>>> @@ -48,6 +48,8 @@
> >>>>>    #define PCIE_ATU_VIEWPORT              0x900
> >>>>>    #define PCIE_ATU_REGION_INBOUND                (0x1 << 31)
> >>>>>    #define PCIE_ATU_REGION_OUTBOUND       (0x0 << 31)
> >>>>> +#define PCIE_ATU_REGION_INDEX3         (0x3 << 0)
> >>>>> +#define PCIE_ATU_REGION_INDEX2         (0x2 << 0)
> >>>>>    #define PCIE_ATU_REGION_INDEX1         (0x1 << 0)
> >>>>>    #define PCIE_ATU_REGION_INDEX0         (0x0 << 0)
> >>>>>    #define PCIE_ATU_CR1                   0x904
> >>>>> @@ -346,7 +348,7 @@ int __init dw_pcie_host_init(struct pcie_port *pp)
> >>>>>           struct of_pci_range range;
> >>>>>           struct of_pci_range_parser parser;
> >>>>>           struct resource *cfg_res;
> >>>>> -       u32 val, na, ns;
> >>>>> +       u32 num_atus = 2, val, na, ns;
> >>>>
> >>>> I think this can be u8?
> >>>
> >>> [Minghuan] I define num-atus like this: num-atus = <6> (our controller
> >>> supports 6 outbound ATUs)
> >>> So, num_atus should be u32 type.
> >>> If we use u8 type to define num_atus, the dts node should be changed to
> >>> num_atus = /bits/ 8 <8>.
> >>> I prefer the previous definition num-atus = <6> which is more simple and
> >>> clear.
> >>
> >> Yes, I agree.  But as it holds only 6 possible distinct values, I
> >> prefer to use u8.
> >
> > [Minghuan] PCIe Designware IP supports more than 6 ATUs. But our
> > current PCIe controller only supports 6 outbound ATUs and 6 inbound ATUs.
> > The next PCIe controller may supports more ATUs. I think u32 can be better
> > compatible with hardware upgrade.
> >
> > I inquired dts, almost all dts property use u32 type.
> 
> I don't think this property will have values > 255, but if you think
> so you could
> use u16 and then u32.
> 
Using a smaller type complicates the DT for little to no benefit. I
think it's ok to use u32 here, which is a common standard for integer
values in DT.

Though this discussion lead me to the question if we even need to have
this property in the DT at all. Isn't this a property that is fixed for
a specific silicon implementation of the DW core? In that case we could
just infer the number of ATUs from the DT compatible, so this should
probably just be added to struct pcie_port and properly initialized by
the SoC glue drivers.

Regards,
Lucas

-- 
Pengutronix e.K.             | Lucas Stach                 |
Industrial Linux Solutions   | http://www.pengutronix.de/  |

