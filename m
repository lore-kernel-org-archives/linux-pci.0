Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from basicbox7.server-home.net ([195.137.212.29]:47170 "EHLO
        basicbox7.server-home.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753068AbcJ3K5W (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 30 Oct 2016 06:57:22 -0400
Subject: Re: [REGRESSION, bisect] pci: artpec-6: imprecise external abort
To: Joao Pinto <Joao.Pinto@synopsys.com>,
        Niklas Cassel <niklas.cassel@axis.com>,
        Bjorn Helgaas <bhelgaas@google.com>
References: <b53d5807-8199-5789-6184-e37324a1d79e@axis.com>
 <ca0419f5-ad15-8db7-bf42-5c6752a8a3be@synopsys.com>
 <b3eb2df9-7675-ea52-a3b7-d2dfc4963c2d@axis.com>
 <99a01d19-2b5e-19e4-7e73-286acf1684c4@synopsys.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Carlos Palminha <CARLOS.PALMINHA@synopsys.com>,
        jose.abreu@synopsys.com, Jesper Nilsson <jespern@axis.com>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Message-ID: <864d1d7f-f09d-9780-1e01-0e1f95e63e3e@leemhuis.info>
Date: Sun, 30 Oct 2016 11:57:19 +0100
MIME-Version: 1.0
In-Reply-To: <99a01d19-2b5e-19e4-7e73-286acf1684c4@synopsys.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

FYI: I added this report to the list of regressions for Linux 4.9. I'll
watch this thread for further updates on this issue to document progress
in my weekly reports. Please let me know via regressions@leemhuis.info
in case the discussion moves to a different place (bugzilla or another
mail thread for example). tia!

Current status (afaics): Patch available
(https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1249922.html )

Ciao, Thorsten

On 14.10.2016 18:11, Joao Pinto wrote:
> On 10/14/2016 4:24 PM, Niklas Cassel wrote:
>> On 10/14/2016 03:02 PM, Joao Pinto wrote:
>>> Hi Niklas,
>>>
>>>
>>> On 10/14/2016 1:41 PM, Niklas Cassel wrote:
>>>> Hello
>>>>
> 
> (snip)
> 
>>                 }
>>         }
>>  
>> -       pp->iatu_unroll_enabled = dw_pcie_iatu_unroll_enabled(pp);
>> -
>>         if (pp->ops->host_init)
>>                 pp->ops->host_init(pp);
>>  
>> @@ -809,6 +807,11 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
>>  {
>>         u32 val;
>>  
>> +       /* get iATU unroll support */
>> +       pp->iatu_unroll_enabled = dw_pcie_iatu_unroll_enabled(pp);
>> +       dev_dbg(pp->dev, "iATU unroll: %s\n",
>> +                pp->iatu_unroll_enabled ? "enabled" : "disabled");
>> +
>>         /* set the number of lanes */
>>         val = dw_pcie_readl_rc(pp, PCIE_PORT_LINK_CONTROL);
>>         val &= ~PORT_LINK_MODE_MASK;
>>
> 
> Seems reasonable to me. Please make the an official patch and I get it tested
> for you.
> 
> Thanks.
> 
>>
>>
>> With my patch I get:
>>
>> [    0.976044] OF: PCI: host bridge /pcie@f8050000 ranges:
>> [    0.981307] OF: PCI:    IO 0xc0002000..0xc0011fff -> 0x00000000
>> [    0.987240] OF: PCI:   MEM 0xc0012000..0xdfffffff -> 0xc0012000
>> [    1.010590] artpec6-pcie f8050000.pcie: iATU unroll: disabled
>> [    1.116381] artpec6-pcie f8050000.pcie: link up
>> [    1.121044] artpec6-pcie f8050000.pcie: PCI host bridge to bus 0000:00
>>
>> and no SIGBUS/imprecise external abort.
>>
>>
>>
>> The only users of dw_pcie_prog_outbound_atu is
>> dw_pcie_rd_conf, dw_pcie_wr_conf and dw_pcie_setup_rc.
>>
>> As long as dw_pcie_setup_rc calls dw_pcie_iatu_unroll_enabled
>> before calling dw_pcie_prog_outbound_atu,
>> we should be fine (as done in my patch).
>>
>> dw_pcie_rd_conf and dw_pcie_wr_conf is only used by
>> struct pci_ops dw_pcie_ops, which is only used as an argument
>> for pci_scan_root_bus_msi and pci_scan_root_bus
>> (both are called after pp->ops->host_init, i.e.,
>> after dw_pcie_setup_rc). (My patch should be fine for
>> this code path too.)
>>
>>
>> The only other solution would be to break out some code
>> from artpec6_pcie_establish_link and move that to
>> artpec6_pcie_probe.
>> But in that case I would highly recommend that all other
>> dwc-based drivers verify that they are still working after
>> a0601a470537 ("PCI: designware: Add iATU Unroll feature"),
>> since they might also first enable their PCI Express interface
>> module in pp->ops->host_init().
>>
>>
>>>> From the ARTPEC-6 SoC manual:
>>>> By default, the PCI Express interface shall be held in reset and clock-gated.
>>>> Software is required to enable the relevant modules
>>>> (turns on clocks and de-asserts reset) before these modules can be used.
>>>>
>>>> Turning on the clocks and de-asserting reset is done in pp->ops->host_init().
>>>> We get an external abort when calling dw_pcie_iatu_unroll_enabled,
>>>> since that function does a read from the IP before we are allowed to do
>>>> AXI transfers (at least in the ARTPEC-6 case, might be the same for some
>>>> other SoCs).
>>>>
>>>> It appears that dw_pcie_iatu_unroll_enabled was actually called _before_
>>>> host_init() in v4 of Joao's patch, but was changed to after host_init() in v5,
>>>> unfortunately the patch doesn't state a reason for the move.
>>>>
>>
> 
> 
> http://news.gmane.org/find-root.php?message_id=99a01d19-2b5e-19e4-7e73-286acf1684c4%40synopsys.com 
> http://mid.gmane.org/99a01d19-2b5e-19e4-7e73-286acf1684c4%40synopsys.com
> 
