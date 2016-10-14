Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bes.se.axis.com ([195.60.68.10]:55858 "EHLO bes.se.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751158AbcJNPYq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 14 Oct 2016 11:24:46 -0400
Subject: Re: [REGRESSION, bisect] pci: artpec-6: imprecise external abort
To: Joao Pinto <Joao.Pinto@synopsys.com>,
        Bjorn Helgaas <bhelgaas@google.com>
References: <b53d5807-8199-5789-6184-e37324a1d79e@axis.com>
 <ca0419f5-ad15-8db7-bf42-5c6752a8a3be@synopsys.com>
CC: <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        Carlos Palminha <CARLOS.PALMINHA@synopsys.com>,
        <jose.abreu@synopsys.com>, Jesper Nilsson <jespern@axis.com>
From: Niklas Cassel <niklas.cassel@axis.com>
Message-ID: <b3eb2df9-7675-ea52-a3b7-d2dfc4963c2d@axis.com>
Date: Fri, 14 Oct 2016 17:24:40 +0200
MIME-Version: 1.0
In-Reply-To: <ca0419f5-ad15-8db7-bf42-5c6752a8a3be@synopsys.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 10/14/2016 03:02 PM, Joao Pinto wrote:
> Hi Niklas,
>
>
> On 10/14/2016 1:41 PM, Niklas Cassel wrote:
>> Hello
>>
>> Because of recent changes to drivers/pci/host/pcie-artpec6.c,
>> I was going to try out Bjorn's tag pci-v4.9-changes-2,
>> however I was greeted by an imprecise external abort:
>>
>>
>> [    0.613082] Trying to unpack rootfs image as initramfs...
>> [    0.886577] Freeing initrd memory: 4724K (c2900000 - c2d9d000)
> (snip)
>
>
>> [    1.282723] [<c07a1710>] (driver_register) from [<c0301eb4>] (do_one_initcall+0x44/0x174)
>> [    1.290919] [<c0301eb4>] (do_one_initcall) from [<c1000dc0>] (kernel_init_freeable+0x158/0x1e8)
>> [    1.299636] [<c1000dc0>] (kernel_init_freeable) from [<c0b047fc>] (kernel_init+0x8/0x10c)
>> [    1.307828] [<c0b047fc>] (kernel_init) from [<c0307e78>] (ret_from_fork+0x14/0x3c)
>> [    1.315404] Code: eafffef9 e5943008 e5930900 f57ff04f (eaffff69)
>> [    1.321503] ---[ end trace b458093682b1fb9a ]---
>>
>>
>> a git bisect later and the cause appears to be a0601a470537 ("PCI: designware: Add iATU Unroll feature")
>>
>> the following patch gives me a working system again:
>>
>> diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
>> index 035f50c03281..74510508fafc 100644
>> --- a/drivers/pci/host/pcie-designware.c
>> +++ b/drivers/pci/host/pcie-designware.c
>> @@ -637,11 +637,11 @@ int dw_pcie_host_init(struct pcie_port *pp)
>>                 }
>>         }
>>  
>> -       pp->iatu_unroll_enabled = dw_pcie_iatu_unroll_enabled(pp);
>> -
>>         if (pp->ops->host_init)
>>                 pp->ops->host_init(pp);
>>  
>> +       pp->iatu_unroll_enabled = dw_pcie_iatu_unroll_enabled(pp);
>> +
>>         pp->root_bus_nr = pp->busn->start;
>>         if (IS_ENABLED(CONFIG_PCI_MSI)) {
>>                 bus = pci_scan_root_bus_msi(pp->dev, pp->root_bus_nr,
> Before invoking the host initialization routine, the pcie driver must check if
> it going to work in Unroll Mode or not. Your work around un fortunately is not
> valid, because you are forcing the host init to be always in legacy mode since
> pp->iatu_unroll_enabled will be 0 (Legacy).
>
> If you check the driver will consider the iATU mode to be Unroll if the PortView
> register has the value 0xFFFFFFFF, which in 4.80 core means that the Core has
> Unroll activated. From what you are refering, I think that in your setup, the
> driver is assuming that your Core is in Unroll Mode for some reason. Could you
> please check the value of the PortView Register?

I cannot read the PortView register (call dw_pcie_iatu_unroll_enabled),
before calling pp->ops->host_init() (artpec6_pcie_host_init),
since that results in an imprecise external abort.
The value from my print is never displayed before crashing.

The reason why we get an imprecise external abort is because the
PCI Express interface module is by default disabled in the ARTPEC-6 SoC
system controller.
Doing an AXI transfer before the module is enabled will result in a
SIGBUS/imprecise external abort.

The PCI Express interface module gets enabled in artpec6_pcie_establish_link
(which is called from pp->ops->host_init() (artpec6_pcie_host_init)).



I can now see why we cannot move
pp->iatu_unroll_enabled = dw_pcie_iatu_unroll_enabled(pp);
to after pp->ops->host_init().
pp->ops->host_init() calls dw_pcie_setup_rc, which calls
dw_pcie_prog_outbound_atu, which uses pp->iatu_unroll_enabled.


How about this:

diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
index 035f50c03281..09eca2c5601d 100644
--- a/drivers/pci/host/pcie-designware.c
+++ b/drivers/pci/host/pcie-designware.c
@@ -637,8 +637,6 @@ int dw_pcie_host_init(struct pcie_port *pp)
                }
        }
 
-       pp->iatu_unroll_enabled = dw_pcie_iatu_unroll_enabled(pp);
-
        if (pp->ops->host_init)
                pp->ops->host_init(pp);
 
@@ -809,6 +807,11 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
 {
        u32 val;
 
+       /* get iATU unroll support */
+       pp->iatu_unroll_enabled = dw_pcie_iatu_unroll_enabled(pp);
+       dev_dbg(pp->dev, "iATU unroll: %s\n",
+                pp->iatu_unroll_enabled ? "enabled" : "disabled");
+
        /* set the number of lanes */
        val = dw_pcie_readl_rc(pp, PCIE_PORT_LINK_CONTROL);
        val &= ~PORT_LINK_MODE_MASK;



With my patch I get:

[    0.976044] OF: PCI: host bridge /pcie@f8050000 ranges:
[    0.981307] OF: PCI:    IO 0xc0002000..0xc0011fff -> 0x00000000
[    0.987240] OF: PCI:   MEM 0xc0012000..0xdfffffff -> 0xc0012000
[    1.010590] artpec6-pcie f8050000.pcie: iATU unroll: disabled
[    1.116381] artpec6-pcie f8050000.pcie: link up
[    1.121044] artpec6-pcie f8050000.pcie: PCI host bridge to bus 0000:00

and no SIGBUS/imprecise external abort.



The only users of dw_pcie_prog_outbound_atu is
dw_pcie_rd_conf, dw_pcie_wr_conf and dw_pcie_setup_rc.

As long as dw_pcie_setup_rc calls dw_pcie_iatu_unroll_enabled
before calling dw_pcie_prog_outbound_atu,
we should be fine (as done in my patch).

dw_pcie_rd_conf and dw_pcie_wr_conf is only used by
struct pci_ops dw_pcie_ops, which is only used as an argument
for pci_scan_root_bus_msi and pci_scan_root_bus
(both are called after pp->ops->host_init, i.e.,
after dw_pcie_setup_rc). (My patch should be fine for
this code path too.)


The only other solution would be to break out some code
from artpec6_pcie_establish_link and move that to
artpec6_pcie_probe.
But in that case I would highly recommend that all other
dwc-based drivers verify that they are still working after
a0601a470537 ("PCI: designware: Add iATU Unroll feature"),
since they might also first enable their PCI Express interface
module in pp->ops->host_init().


>> From the ARTPEC-6 SoC manual:
>> By default, the PCI Express interface shall be held in reset and clock-gated.
>> Software is required to enable the relevant modules
>> (turns on clocks and de-asserts reset) before these modules can be used.
>>
>> Turning on the clocks and de-asserting reset is done in pp->ops->host_init().
>> We get an external abort when calling dw_pcie_iatu_unroll_enabled,
>> since that function does a read from the IP before we are allowed to do
>> AXI transfers (at least in the ARTPEC-6 case, might be the same for some
>> other SoCs).
>>
>> It appears that dw_pcie_iatu_unroll_enabled was actually called _before_
>> host_init() in v4 of Joao's patch, but was changed to after host_init() in v5,
>> unfortunately the patch doesn't state a reason for the move.
>>

