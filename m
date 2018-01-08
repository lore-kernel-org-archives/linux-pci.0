Return-Path: <SRS0=ZRB8=ED=ncentric.com=koen.vandeputte@kernel.org>
Return-Path: <SRS0=ZRB8=ED=ncentric.com=koen.vandeputte@kernel.org>
Subject: Re: [PATCH] imx6: fix pcie enumeration
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
 bhelgaas@google.com, Richard Zhu <hongxing.zhu@nxp.com>,
 Lucas Stach <l.stach@pengutronix.de>, linux-arm-kernel@lists.infradead.org,
 Joao Pinto <Joao.Pinto@synopsys.com>, Jingoo Han <jingoohan1@gmail.com>
References: <20180104202430.GC189897@bhelgaas-glaptop.roam.corp.google.com>
 <a2d7afee-7a41-6da6-e5a4-a36a6fcde55d@ncentric.com>
 <20180105123206.GA24511@e107981-ln.cambridge.arm.com>
 <ebf30c78-b772-6214-f441-c86ae7fdba7e@ncentric.com>
 <20180105171828.GC24933@red-moon>
 <5bc70c34-45b2-5aed-eb06-f8ecfe859fd0@ncentric.com>
 <20180108110015.GA32027@red-moon>
From: Koen Vandeputte <koen.vandeputte@ncentric.com>
Message-ID: <1684b8c6-1006-948b-f4f9-c9aaf9cf26a8@ncentric.com>
Date: Mon, 8 Jan 2018 12:13:34 +0100
MIME-Version: 1.0
In-Reply-To: <20180108110015.GA32027@red-moon>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-pci.vger.kernel.org>



On 2018-01-08 12:00, Lorenzo Pieralisi wrote:
> [+cc Joao, Jingoo]
>
> On Mon, Jan 08, 2018 at 09:51:37AM +0100, Koen Vandeputte wrote:
>
> [...]
>
>> [ Node 4 | node-4 ] lspci -v
>> 00:00.0 PCI bridge: Synopsys, Inc. Device abcd (rev 01) (prog-if 00
>> [Normal decode])
>>      Flags: bus master, fast devsel, latency 0, IRQ 298
>>      Memory at 01000000 (32-bit, non-prefetchable) [size=1M]
>>      Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
>                                       ^^^^^^^^^^^^^^
>
> So basically, the subordinate number in the root port does not
> affect config space forwarding from what I see and it has always
> been like that for dwc.
>
> You are forced to update it to 0xff because otherwise the kernel
> stops enumerating bus numbers > 1
Indeed, which affects all devices using Designware PCIe init + a PCIe 
bridge downstream
> but that's a software issue
> not HW - the subordinate bus number does not seem to affect anything
> here.

> Sigh.
>
> Another option would consist in forcing the kernel to reassign
> all bus numbers by setting the PCI_REASSIGN_ALL_BUS flag but
> that's not a good idea given how inconsistent that flag usage is.
>
> I think that updating the subordinate bus numbers in the DWC
> config register is the correct solution to make sure the kernel
> won't get confused anymore by what seems to be a fake root port,
> I need input from DWC maintainers to confirm my understanding.
>
> Thanks,
> Lorenzo
>

The patch I'm currently using internally:


--- a/drivers/pci/host/pcie-designware.c
+++ b/drivers/pci/host/pcie-designware.c
@@ -861,7 +861,7 @@ void dw_pcie_setup_rc(struct pcie_port *
      /* setup bus numbers */
      val = dw_pcie_readl_rc(pp, PCI_PRIMARY_BUS);
      val &= 0xff000000;
-    val |= 0x00010100;
+    val |= 0x00ff0100;
      dw_pcie_writel_rc(pp, PCI_PRIMARY_BUS, val);

      /* setup command register */


Above version logically fixes it for all dwc devices using a bridge 
after the RC, not only imx6.
If this is fine, I would submit the patch above and drop the current one.

Backporting this to stable kernels (4.9 .. 4.4 .. etc) will fix all 
nasty warnings on these setups during boot without any change in 
functionality.
These kernels will require a separate patch as this source file got 
moved & renamed.


Thanks for your time and analysis so far,

Koen
