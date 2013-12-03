Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-we0-f182.google.com ([74.125.82.182]:49753 "EHLO
	mail-we0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755140Ab3LCUOw (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 3 Dec 2013 15:14:52 -0500
Received: by mail-we0-f182.google.com with SMTP id q59so14343066wes.27
        for <linux-pci@vger.kernel.org>; Tue, 03 Dec 2013 12:14:50 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <201311270944.09383.marex@denx.de>
References: <1385500248-6551-1-git-send-email-marex@denx.de>
	<1385500248-6551-2-git-send-email-marex@denx.de>
	<20131127043009.GB12773@pratyush-vbox>
	<201311270944.09383.marex@denx.de>
Date: Tue, 3 Dec 2013 12:14:47 -0800
Message-ID: <CAJ+vNU050mtdiyXBXue_JGFJhFLiKCvoyf031Uda2e5U+vA12g@mail.gmail.com>
Subject: Re: [PATCH 2/7] [RFC] PCI: imx6: remove outbound io/mem ATU region mapping
From: Tim Harvey <tharvey@gateworks.com>
To: Marek Vasut <marex@denx.de>
Cc: Pratyush Anand <pratyush.anand@st.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Frank Li <lznuaa@gmail.com>, Harro Haan <hrhaan@gmail.com>,
	Jingoo Han <jg1.han@samsung.com>,
	Mohit KUMAR DCG <Mohit.KUMAR@st.com>,
	Richard Zhu <r65037@freescale.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Sean Cross <xobs@kosagi.com>, Shawn Guo <shawn.guo@linaro.org>,
	Siva Reddy Kallam <siva.kallam@samsung.com>,
	Srikanth T Shivanand <ts.srikanth@samsung.com>,
	Troy Kisky <troy.kisky@boundarydevices.com>,
	Yinghai Lu <yinghai@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Nov 27, 2013 at 12:44 AM, Marek Vasut <marex@denx.de> wrote:
> Dear Pratyush Anand,
>
>> Dear Marek Vasut,
>>
>> Please replace imx6 with designware in subject line  of this patch.
>
> OK, this one has to be fixed anyway. We need to figure out why do we even need
> this one.
>
>> On Wed, Nov 27, 2013 at 05:10:43AM +0800, Marek Vasut wrote:
>> > From: Tim Harvey <tharvey@gateworks.com>
>> >
>> > The IMX6 iATU is used for address translation between the AXI bus
>> > address space and PCI address space.  This is used for type0 and type1
>> > config cycles but is not necessary for outbound io/mem regions.
>> >
>> > This patch removes the calls that inappropriately re-configures the ATU
>> > viewport for outbound memory and IO after config cycles and removes them
>> > altogether as they are not necessary.
>>
>> Yes, they are not necessary for all the cases where translation is one
>> to one. So so for sure all the platform till now introduced should
>> work.
>> But, what about a platform where memory translation is not one to one?
>>
>> Existing code should work with all sort of memory translation on a
>> platform having atleast two viewports capable of programming any type
>> of outbound transaction.
>
> Full ACK, that's why it's called RFC.
>
>> > This resolves issues with PCI devices behind switches and has been tested
>> > with a Gige device behind a PLX PEX860x switch.  More testing is needed
>> > for other configurations.
>>
>> I do not understand if MX6 has 4 Outbound Viewport then how this patch
>> helps?
>> -- PCI devices behind switches would not have been working because
>> CFG1 transaction would not have been correct.
>> -- It works with this patch. This patch changes viewport for CFG1 from
>> 1 to 0.
>> -- Can it be possible that MX6 has some restriction on viewport
>> programming capability. I mean,like only viewport0 can be programmed
>> for CFG0/1?
>
> Tim ?
>
> Here is the MX6 datasheet [1], the section 48.3.9.1.1 and 48.3.9.1.2 describe
> the iATU configuration on MX6. My understanding from this description is that
> the MX6 has 4 inbound and 4 outbound iATU regions. Am I wrong ?
>
> [1] http://cache.freescale.com/files/32bit/doc/ref_manual/IMX6DQRM.pdf
>
>> Otherwise I do not find any convincing reason that why this patch
>> helps in resolving issues with PCI devices behind switches.

In my configuration I have a PLX switch off the IMX root complex with
several devices behind it.  I find that the devices enumerate
correctly but as soon as data is transferred to or from (not sure
which) the device the system hangs (INFO: rcu_sched detected stalls on
CPUs/tasks: { 0} (detected by 3, t=2135 jiffies, g=20, c=19, q=66)).
My current test case is a GigE ethernet device and when I connect a
network to the device I hange when a packet is responded to.

I can't claim to fully understand PCI resource mappings or the iATU
and I don't understand why dw_pcie_rd_other_conf/dw_pcie_wr_other_conf
need to change the viewport then change it back instead of using
multiple viewports (perhaps because some hardware may not have more
than the 2 viewports currently being used?).  The current driver uses
viewport0 for cfg0 and mem and viewport1 for cfg1 and io.  If I remove
the call to dw_pcie_prog_viewport_io_outbound to reconfigure viewport1
for io after its altered for type1 cfg cycles, devices behind the
bridge work for me:

diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designwa
index e33b68b..a064bc5 100644
--- a/drivers/pci/host/pcie-designware.c
+++ b/drivers/pci/host/pcie-designware.c
@@ -556,7 +556,7 @@ static int dw_pcie_rd_other_conf(struct pcie_port *pp, struc
        } else {
                dw_pcie_prog_viewport_cfg1(pp, busdev);
                ret = cfg_read(pp->va_cfg1_base + address, where, size, val);
-               dw_pcie_prog_viewport_io_outbound(pp);
+//               dw_pcie_prog_viewport_io_outbound(pp);
        }

        return ret;
@@ -579,7 +579,7 @@ static int dw_pcie_wr_other_conf(struct pcie_port *pp, struc
        } else {
                dw_pcie_prog_viewport_cfg1(pp, busdev);
                ret = cfg_write(pp->va_cfg1_base + address, where, size, val);
-               dw_pcie_prog_viewport_io_outbound(pp);
+//               dw_pcie_prog_viewport_io_outbound(pp);
        }

Can anyone explain whats going on here?   I would think this would
perhaps break devices that use IO resources?

Thanks,

Tim

>>
>>
>> Regards
>> Pratyush
>>
>> > From: Tim Harvey <tharvey@gateworks.com>
>> > Signed-off-by: Tim Harvey <tharvey@gateworks.com>
>> > Cc: Bjorn Helgaas <bhelgaas@google.com>
>> > Cc: Frank Li <lznuaa@gmail.com>
>> > Cc: Harro Haan <hrhaan@gmail.com>
>> > Cc: Jingoo Han <jg1.han@samsung.com>
>> > Cc: Mohit KUMAR <Mohit.KUMAR@st.com>
>> > Cc: Pratyush Anand <pratyush.anand@st.com>
>> > Cc: Richard Zhu <r65037@freescale.com>
>> > Cc: Sascha Hauer <s.hauer@pengutronix.de>
>> > Cc: Sean Cross <xobs@kosagi.com>
>> > Cc: Shawn Guo <shawn.guo@linaro.org>
>> > Cc: Siva Reddy Kallam <siva.kallam@samsung.com>
>> > Cc: Srikanth T Shivanand <ts.srikanth@samsung.com>
>> > Cc: Tim Harvey <tharvey@gateworks.com>
>> > Cc: Troy Kisky <troy.kisky@boundarydevices.com>
>> > Cc: Yinghai Lu <yinghai@kernel.org>
>> > ---
>> >
>> >  drivers/pci/host/pcie-designware.c | 41
>> >  +++----------------------------------- 1 file changed, 3 insertions(+),
>> >  38 deletions(-)
>> >
>> > diff --git a/drivers/pci/host/pcie-designware.c
>> > b/drivers/pci/host/pcie-designware.c index ed9b11b..01d76ad 100644
>> > --- a/drivers/pci/host/pcie-designware.c
>> > +++ b/drivers/pci/host/pcie-designware.c
>> > @@ -46,7 +46,6 @@
>> >
>> >  #define PCIE_ATU_VIEWPORT          0x900
>> >  #define PCIE_ATU_REGION_INBOUND            (0x1 << 31)
>> >  #define PCIE_ATU_REGION_OUTBOUND   (0x0 << 31)
>> >
>> > -#define PCIE_ATU_REGION_INDEX1             (0x1 << 0)
>> >
>> >  #define PCIE_ATU_REGION_INDEX0             (0x0 << 0)
>> >  #define PCIE_ATU_CR1                       0x904
>> >  #define PCIE_ATU_TYPE_MEM          (0x0 << 0)
>> >
>> > @@ -494,8 +493,8 @@ static void dw_pcie_prog_viewport_cfg0(struct
>> > pcie_port *pp, u32 busdev)
>> >
>> >  static void dw_pcie_prog_viewport_cfg1(struct pcie_port *pp, u32 busdev)
>> >  {
>> >
>> > -   /* Program viewport 1 : OUTBOUND : CFG1 */
>> > -   dw_pcie_writel_rc(pp, PCIE_ATU_REGION_OUTBOUND |
>> > PCIE_ATU_REGION_INDEX1, +   /* Program viewport 0 : OUTBOUND : CFG1 */
>> > +   dw_pcie_writel_rc(pp, PCIE_ATU_REGION_OUTBOUND |
>> > PCIE_ATU_REGION_INDEX0,
>> >
>> >                       PCIE_ATU_VIEWPORT);
>> >
>> >     dw_pcie_writel_rc(pp, PCIE_ATU_TYPE_CFG1, PCIE_ATU_CR1);
>> >     dw_pcie_writel_rc(pp, PCIE_ATU_ENABLE, PCIE_ATU_CR2);
>> >
>> > @@ -505,38 +504,8 @@ static void dw_pcie_prog_viewport_cfg1(struct
>> > pcie_port *pp, u32 busdev)
>> >
>> >                       PCIE_ATU_LIMIT);
>> >
>> >     dw_pcie_writel_rc(pp, busdev, PCIE_ATU_LOWER_TARGET);
>> >     dw_pcie_writel_rc(pp, 0, PCIE_ATU_UPPER_TARGET);
>> >
>> > -}
>> > -
>> > -static void dw_pcie_prog_viewport_mem_outbound(struct pcie_port *pp)
>> > -{
>> > -   /* Program viewport 0 : OUTBOUND : MEM */
>> > -   dw_pcie_writel_rc(pp, PCIE_ATU_REGION_OUTBOUND |
>> > PCIE_ATU_REGION_INDEX0, -                     PCIE_ATU_VIEWPORT);
>> > -   dw_pcie_writel_rc(pp, PCIE_ATU_TYPE_MEM, PCIE_ATU_CR1);
>> > -   dw_pcie_writel_rc(pp, PCIE_ATU_ENABLE, PCIE_ATU_CR2);
>> > -   dw_pcie_writel_rc(pp, pp->mem_base, PCIE_ATU_LOWER_BASE);
>> > -   dw_pcie_writel_rc(pp, (pp->mem_base >> 32), PCIE_ATU_UPPER_BASE);
>> > -   dw_pcie_writel_rc(pp, pp->mem_base + pp->config.mem_size - 1,
>> > -                     PCIE_ATU_LIMIT);
>> > -   dw_pcie_writel_rc(pp, pp->config.mem_bus_addr, PCIE_ATU_LOWER_TARGET);
>> > -   dw_pcie_writel_rc(pp, upper_32_bits(pp->config.mem_bus_addr),
>> > -                     PCIE_ATU_UPPER_TARGET);
>> > -}
>> > -
>> > -static void dw_pcie_prog_viewport_io_outbound(struct pcie_port *pp)
>> > -{
>> > -   /* Program viewport 1 : OUTBOUND : IO */
>> > -   dw_pcie_writel_rc(pp, PCIE_ATU_REGION_OUTBOUND |
>> > PCIE_ATU_REGION_INDEX1, -                     PCIE_ATU_VIEWPORT);
>> > -   dw_pcie_writel_rc(pp, PCIE_ATU_TYPE_IO, PCIE_ATU_CR1);
>> > +   dw_pcie_writel_rc(pp, PCIE_ATU_TYPE_CFG1, PCIE_ATU_CR1);
>> >
>> >     dw_pcie_writel_rc(pp, PCIE_ATU_ENABLE, PCIE_ATU_CR2);
>> >
>> > -   dw_pcie_writel_rc(pp, pp->io_base, PCIE_ATU_LOWER_BASE);
>> > -   dw_pcie_writel_rc(pp, (pp->io_base >> 32), PCIE_ATU_UPPER_BASE);
>> > -   dw_pcie_writel_rc(pp, pp->io_base + pp->config.io_size - 1,
>> > -                     PCIE_ATU_LIMIT);
>> > -   dw_pcie_writel_rc(pp, pp->config.io_bus_addr, PCIE_ATU_LOWER_TARGET);
>> > -   dw_pcie_writel_rc(pp, upper_32_bits(pp->config.io_bus_addr),
>> > -                     PCIE_ATU_UPPER_TARGET);
>> >
>> >  }
>> >
>> >  static int dw_pcie_rd_other_conf(struct pcie_port *pp, struct pci_bus
>> >  *bus,
>> >
>> > @@ -552,11 +521,9 @@ static int dw_pcie_rd_other_conf(struct pcie_port
>> > *pp, struct pci_bus *bus,
>> >
>> >     if (bus->parent->number == pp->root_bus_nr) {
>> >
>> >             dw_pcie_prog_viewport_cfg0(pp, busdev);
>> >             ret = cfg_read(pp->va_cfg0_base + address, where, size, val);
>> >
>> > -           dw_pcie_prog_viewport_mem_outbound(pp);
>> >
>> >     } else {
>> >
>> >             dw_pcie_prog_viewport_cfg1(pp, busdev);
>> >             ret = cfg_read(pp->va_cfg1_base + address, where, size, val);
>> >
>> > -           dw_pcie_prog_viewport_io_outbound(pp);
>> >
>> >     }
>> >
>> >     return ret;
>> >
>> > @@ -575,11 +542,9 @@ static int dw_pcie_wr_other_conf(struct pcie_port
>> > *pp, struct pci_bus *bus,
>> >
>> >     if (bus->parent->number == pp->root_bus_nr) {
>> >
>> >             dw_pcie_prog_viewport_cfg0(pp, busdev);
>> >             ret = cfg_write(pp->va_cfg0_base + address, where, size, val);
>> >
>> > -           dw_pcie_prog_viewport_mem_outbound(pp);
>> >
>> >     } else {
>> >
>> >             dw_pcie_prog_viewport_cfg1(pp, busdev);
>> >             ret = cfg_write(pp->va_cfg1_base + address, where, size, val);
>> >
>> > -           dw_pcie_prog_viewport_io_outbound(pp);
>> >
>> >     }
>> >
>> >     return ret;
