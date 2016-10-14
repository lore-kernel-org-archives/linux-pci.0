Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [REGRESSION, bisect] pci: artpec-6: imprecise external abort
To: Niklas Cassel <niklas.cassel@axis.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Bjorn Helgaas <bhelgaas@google.com>
References: <b53d5807-8199-5789-6184-e37324a1d79e@axis.com>
 <ca0419f5-ad15-8db7-bf42-5c6752a8a3be@synopsys.com>
 <b3eb2df9-7675-ea52-a3b7-d2dfc4963c2d@axis.com>
CC: <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        "Carlos Palminha" <CARLOS.PALMINHA@synopsys.com>,
        <jose.abreu@synopsys.com>, "Jesper Nilsson" <jespern@axis.com>
From: Joao Pinto <Joao.Pinto@synopsys.com>
Message-ID: <99a01d19-2b5e-19e4-7e73-286acf1684c4@synopsys.com>
Date: Fri, 14 Oct 2016 17:11:55 +0100
MIME-Version: 1.0
In-Reply-To: <b3eb2df9-7675-ea52-a3b7-d2dfc4963c2d@axis.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 10/14/2016 4:24 PM, Niklas Cassel wrote:
> On 10/14/2016 03:02 PM, Joao Pinto wrote:
>> Hi Niklas,
>>
>>
>> On 10/14/2016 1:41 PM, Niklas Cassel wrote:
>>> Hello
>>>

(snip)

>                 }
>         }
>  
> -       pp->iatu_unroll_enabled = dw_pcie_iatu_unroll_enabled(pp);
> -
>         if (pp->ops->host_init)
>                 pp->ops->host_init(pp);
>  
> @@ -809,6 +807,11 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
>  {
>         u32 val;
>  
> +       /* get iATU unroll support */
> +       pp->iatu_unroll_enabled = dw_pcie_iatu_unroll_enabled(pp);
> +       dev_dbg(pp->dev, "iATU unroll: %s\n",
> +                pp->iatu_unroll_enabled ? "enabled" : "disabled");
> +
>         /* set the number of lanes */
>         val = dw_pcie_readl_rc(pp, PCIE_PORT_LINK_CONTROL);
>         val &= ~PORT_LINK_MODE_MASK;
> 

Seems reasonable to me. Please make the an official patch and I get it tested
for you.

Thanks.

> 
> 
> With my patch I get:
> 
> [    0.976044] OF: PCI: host bridge /pcie@f8050000 ranges:
> [    0.981307] OF: PCI:    IO 0xc0002000..0xc0011fff -> 0x00000000
> [    0.987240] OF: PCI:   MEM 0xc0012000..0xdfffffff -> 0xc0012000
> [    1.010590] artpec6-pcie f8050000.pcie: iATU unroll: disabled
> [    1.116381] artpec6-pcie f8050000.pcie: link up
> [    1.121044] artpec6-pcie f8050000.pcie: PCI host bridge to bus 0000:00
> 
> and no SIGBUS/imprecise external abort.
> 
> 
> 
> The only users of dw_pcie_prog_outbound_atu is
> dw_pcie_rd_conf, dw_pcie_wr_conf and dw_pcie_setup_rc.
> 
> As long as dw_pcie_setup_rc calls dw_pcie_iatu_unroll_enabled
> before calling dw_pcie_prog_outbound_atu,
> we should be fine (as done in my patch).
> 
> dw_pcie_rd_conf and dw_pcie_wr_conf is only used by
> struct pci_ops dw_pcie_ops, which is only used as an argument
> for pci_scan_root_bus_msi and pci_scan_root_bus
> (both are called after pp->ops->host_init, i.e.,
> after dw_pcie_setup_rc). (My patch should be fine for
> this code path too.)
> 
> 
> The only other solution would be to break out some code
> from artpec6_pcie_establish_link and move that to
> artpec6_pcie_probe.
> But in that case I would highly recommend that all other
> dwc-based drivers verify that they are still working after
> a0601a470537 ("PCI: designware: Add iATU Unroll feature"),
> since they might also first enable their PCI Express interface
> module in pp->ops->host_init().
> 
> 
>>> From the ARTPEC-6 SoC manual:
>>> By default, the PCI Express interface shall be held in reset and clock-gated.
>>> Software is required to enable the relevant modules
>>> (turns on clocks and de-asserts reset) before these modules can be used.
>>>
>>> Turning on the clocks and de-asserting reset is done in pp->ops->host_init().
>>> We get an external abort when calling dw_pcie_iatu_unroll_enabled,
>>> since that function does a read from the IP before we are allowed to do
>>> AXI transfers (at least in the ARTPEC-6 case, might be the same for some
>>> other SoCs).
>>>
>>> It appears that dw_pcie_iatu_unroll_enabled was actually called _before_
>>> host_init() in v4 of Joao's patch, but was changed to after host_init() in v5,
>>> unfortunately the patch doesn't state a reason for the move.
>>>
> 
