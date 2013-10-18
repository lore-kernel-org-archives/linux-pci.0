Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-db9lp0251.outbound.messaging.microsoft.com ([213.199.154.251]:32608
	"EHLO db9outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750930Ab3JRGeM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 18 Oct 2013 02:34:12 -0400
From: Zhu Richard-R65037 <r65037@freescale.com>
To: Tim Harvey <tharvey@gateworks.com>, Sean Cross <xobs@kosagi.com>
CC: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawn.guo@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	=?iso-8859-2?Q?Marek_Va=B9ut?= <marex@denx.de>,
	Jingoo Han <jg1.han@samsung.com>,
	Pratyush Anand <pratyush.anand@st.com>,
	Troy Kisky <troy.kisky@boundarydevices.com>
Subject: RE: [PATCH v6 3/3] PCI: imx6: Add support for i.MX6 PCIe controller
Date: Fri, 18 Oct 2013 06:34:05 +0000
Message-ID: <0E83723C55F66F43A6041464FE31119D40FC99@039-SN2MPN1-011.039d.mgd.msft.net>
References: <1379319655-20210-1-git-send-email-xobs@kosagi.com>
	<1379319655-20210-4-git-send-email-xobs@kosagi.com>
 <CAJ+vNU36neHP77dVnqSP=+oMxaU=-6PxWQ8Afni-tTRjNTkM_A@mail.gmail.com>
In-Reply-To: <CAJ+vNU36neHP77dVnqSP=+oMxaU=-6PxWQ8Afni-tTRjNTkM_A@mail.gmail.com>
Content-Type: text/plain; charset="iso-8859-2"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> -----Original Message-----
> From: Tim Harvey [mailto:tharvey@gateworks.com]
> Sent: Friday, October 18, 2013 1:33 PM
> To: Sean Cross
> Cc: devicetree@vger.kernel.org; linux-pci@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; Sascha Hauer; Zhu Richard-R65037; Shawn Guo; Bjorn
> Helgaas; Marek Va¹ut; Jingoo Han; Pratyush Anand; Troy Kisky
> Subject: Re: [PATCH v6 3/3] PCI: imx6: Add support for i.MX6 PCIe controller
> 
> On Mon, Sep 16, 2013 at 1:20 AM, Sean Cross <xobs@kosagi.com> wrote:
> > Add support for the PCIe port present on the i.MX6 family of controllers.
> > These use the Synopsis Designware core tied to their own PHY.
> >
> > Signed-off-by: Sean Cross <xobs@kosagi.com>
> > Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> > ---
> >  .../devicetree/bindings/pci/designware-pcie.txt    |    7 +-
> > diff --git a/arch/arm/boot/dts/imx6qdl.dtsi
> > b/arch/arm/boot/dts/imx6qdl.dtsi index ccd55c2..125202e 100644
> > --- a/arch/arm/boot/dts/imx6qdl.dtsi
> > +++ b/arch/arm/boot/dts/imx6qdl.dtsi
> > @@ -116,6 +116,22 @@
> >                         arm,data-latency = <4 2 3>;
> >                 };
> >
> > +               pcie: pcie@0x01000000 {
> > +                       compatible = "fsl,imx6q-pcie", "snps,dw-pcie";
> > +                       reg = <0x01ffc000 0x4000>; /* DBI */
> > +                       #address-cells = <3>;
> > +                       #size-cells = <2>;
> > +                       device_type = "pci";
> > +                       ranges = <0x00000800 0 0x01f00000 0x01f00000 0
> 0x00080000 /* configuration space */
> > +                                 0x81000000 0 0          0x01f80000 0
> 0x00010000 /* downstream I/O */
> > +                                 0x82000000 0 0x01000000 0x01000000 0
> 0x00f00000>; /* non-prefetchable memory */
> > +                       num-lanes = <1>;
> > +                       interrupts = <0 123 0x04>;
> > +                       clocks = <&clks 189>, <&clks 187>, <&clks 205>,
> <&clks 144>;
> > +                       clock-names = "pcie_ref_125m", "sata_ref_100m",
> "lvds_gate", "pcie_axi";
> > +                       status = "disabled";
> > +               };
> > +
> 
> Sean,
> 
> The devicetree portion above is now here
> https://gitorious.org/thierryreding/linux-
> next/commit/3a57291fa4ca7f7647d826f5b47082ef306d839f
> (which I'm told gets pulled into linux-next) and I wanted to see if you or any
> of the other IMX/PCI gurus here can answer a question about region mapping.
> 
> The above ranges look to me to allocate 15MB for mem resources, 64K for io
> resources, and 256K for cfg space.
> 
> Table 2.1 of the IMX6DQRM.pdf
> (http://cache.freescale.com/files/32bit/doc/ref_manual/IMX6DQRM.pdf)
> shows:
>   01FF_C000 01FF_FFFF 16 KB PCIe registers
>   0100_0000 01FF_BFFF 16368 KB PCIe
> 
> The driver in the fsl 3.0.35_4.1.0 BSP maps the following (see
> http://git.freescale.com/git/cgit.cgi/imx/linux-2.6-
> imx.git/tree/arch/arm/mach-mx6/pcie.c?h=imx_3.0.35_4.1.0#n331):
> 
> 0x0100_0000 --- 0x01DF_FFFF 14MB IORESOURCE_MEM
> 0x01E0_0000 --- 0x01EF_FFFF 1MB IORESOURCE_IO
> 0x01F0_0000 --- 0x01FF_FFFF 1MB Cfg + MSI + Registers
> 
> and, in a discussion on the IMX Community forum
> (https://community.freescale.com/message/334959#334959) points out that you
> have more flexibility if you map the MEM resource first because of its more
> limited alignment.  So, if you were going to stick with the fsl mapping I
> would think we would want something like this in the dt node:
> 
> ranges = <0x00000800 0 0x01f00000 0x01f00000 0 0x00080000 /* 512K
> configuration space */
>                0x81000000 0 0          0x01e00000 0 0x00100000 /* 1MB
> downstream I/O */
>                0x82000000 0 0x01000000 0x01000000 0 0x00e00000>; /* 14MB non-
> prefetchable memory */
> 
> Can these regions be moved around however you want depending on what kind of
> mem vs io resource configurations you desire?  How about the cfg space - is
> 512K really needed?
> 
> Are we sure the committed values to linux-next 'wrong' in any way?  I still am
> seeing bus-hangs with devices behind a bridge that use io-space resources and
> am trying to figure out where the issue is.  I don't get these bus-hangs when
> using the fsl driver which is structured very different so its been difficult
> for me to determine the difference.  The mappings and the way iATU mappings
> are done are very different.

Hi Tim:
Regarding to my experience, the difference shouldn't be related with the bus hang.
Here are my DT region setup when I trying to bring up imx6 pcie on 3.1x kernel by my own driver.
                        clock-names = "pcie_axi", "pcie_ref", "pcie_bus_in", "pcie_bus_out";
                        #address-cells = <3>;
                        #size-cells = <2>;
                        ranges = <0x00000800 0 0x01f00000 0x01f00000 0 0x00080000   /* configuration space */
                                  0x81000000 0 0          0x01f80000 0 0x00010000   /* downstream I/O */
                                  0x82000000 0 0x01000000 0x01000000 0 0x00f00000>; /* non-prefetchable memory */
                        num-lanes = <1>;

It works sometimes, although that there is random kernel panic and system hang(log is pasted below):(
LOGS, when pericom's PI7C9X2G303EL and Intel e1000e network card is used.
...
imx-pcie 1ffc000.pcie: legacy_irq 155
imx-pcie 1ffc000.pcie: map [mem 0x01ffc000-0x01ffffff]
IMX PCIe port: link up.
PCI host bridge to bus 0000:00
pci_bus 0000:00: root bus resource [io  0x1000-0x10000]
pci_bus 0000:00: root bus resource [mem 0x01000000-0x01efffff]
pci_bus 0000:00: No busn resource found for root bus, will use [bus 00-ff]
PCI: bus0: Fast back to back transfers disabled
PCI: bus1: Fast back to back transfers disabled
pci 0000:01:00.0: bridge configuration invalid ([bus 00-00]), reconfiguring
PCI: bus2: Fast back to back transfers disabled
pci 0000:02:01.0: bridge configuration invalid ([bus 00-00]), reconfiguring
pci 0000:02:02.0: bridge configuration invalid ([bus 00-00]), reconfiguring
PCI: bus3: Fast back to back transfers disabled
PCI: bus4: Fast back to back transfers enabled
pci 0000:00:00.0: BAR 0: assigned [mem 0x01000000-0x010fffff 64bit]
pci 0000:00:00.0: BAR 8: assigned [mem 0x01100000-0x012fffff]
pci 0000:00:00.0: BAR 6: assigned [mem 0x01300000-0x0130ffff pref]
pci 0000:00:00.0: BAR 7: assigned [io  0x1000-0x1fff]
pci 0000:01:00.0: BAR 8: assigned [mem 0x01100000-0x012fffff]
pci 0000:01:00.0: BAR 7: assigned [io  0x1000-0x1fff]
pci 0000:02:01.0: BAR 8: assigned [mem 0x01100000-0x012fffff]
pci 0000:02:01.0: BAR 7: assigned [io  0x1000-0x1fff]
pci 0000:03:00.0: BAR 1: assigned [mem 0x01100000-0x011fffff]
pci 0000:03:00.0: BAR 0: assigned [mem 0x01200000-0x0121ffff]
pci 0000:03:00.0: BAR 3: assigned [mem 0x01220000-0x01223fff]
pci 0000:03:00.0: BAR 2: assigned [io  0x1000-0x101f]
pci 0000:02:01.0: PCI bridge to [bus 03]
pci 0000:02:01.0:   bridge window [io  0x1000-0x1fff]
pci 0000:02:01.0:   bridge window [mem 0x01100000-0x012fffff]
pci 0000:02:02.0: PCI bridge to [bus 04]
pci 0000:01:00.0: PCI bridge to [bus 02-04]
pci 0000:01:00.0:   bridge window [io  0x1000-0x1fff]
pci 0000:01:00.0:   bridge window [mem 0x01100000-0x012fffff]
pci 0000:00:00.0: PCI bridge to [bus 01-04]
pci 0000:00:00.0:   bridge window [io  0x1000-0x1fff]
pci 0000:00:00.0:   bridge window [mem 0x01100000-0x012fffff]
PCI: enabling device 0000:01:00.0 (0140 -> 0143)
PCI: enabling device 0000:02:01.0 (0140 -> 0143)
PCI: enabling device 0000:02:02.0 (0140 -> 0143)
...
e1000e: Intel(R) PRO/1000 Network Driver - 2.3.2-k
e1000e: Copyright(c) 1999 - 2013 Intel Corporation.
e1000e 0000:03:00.0: Disabling ASPM L0s L1
PCI: enabling device 0000:03:00.0 (0140 -> 0142)
e1000e 0000:03:00.0: Interrupt Throttling Rate (ints/sec) set to dynamic conservative mode
e1000e 0000:03:00.0 eth1: registered PHC clock
e1000e 0000:03:00.0 eth1: (PCI Express:2.5GT/s:Width x1) 00:1b:21:3a:18:8b
e1000e 0000:03:00.0 eth1: Intel(R) PRO/1000 Network Connection
e1000e 0000:03:00.0 eth1: MAC: 3, PHY: 8, PBA No: E42641-005
igb: Intel(R) Gigabit Ethernet Network Driver - version 5.0.3-k
igb: Copyright (c) 2007-2013 Intel Corporation.
...

ALSA device list:
  #0: wm8962-audio
VFS: Mounted root (nfs filesystem) on device 0:11.
devtmpfs: mounted
Freeing unused kernel memory: 324K (8082d000 - 8087e000)
Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b  <-- Kernel panic here randomly. Same phenomena when the root-fs is located in SD.

CPU1: stopping
CPU: 1 PID: 0 Comm: swapper/1 Not tainted 3.11.0-rc3+ #13
Backtrace: 
[<80011b58>] (dump_backtrace+0x0/0x10c) from [<80011cf8>] (show_stack+0x18/0x1c)
 r6:bf896000 r5:8087dd84 r4:00000000 r3:00000000
[<80011ce0>] (show_stack+0x0/0x1c) from [<80642d8c>] (dump_stack+0x78/0x94)
[<80642d14>] (dump_stack+0x0/0x94) from [<80014a60>] (handle_IPI+0x138/0x174)
> 
> Thanks,
> 
> Tim


Thanks.

Best Regards
Richard Zhu


