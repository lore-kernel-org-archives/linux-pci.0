Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
MIME-Version: 1.0
In-Reply-To: <20170602135619.GA10491@red-moon>
References: <20170426111809.19922-1-lorenzo.pieralisi@arm.com>
 <20170426111809.19922-9-lorenzo.pieralisi@arm.com>
 <CAK8P3a1ULYxkopxJ8-vZpFs_uPP2gu5TsRWjCKUOW+0QRombLw@mail.gmail.com>
 <20170602114956.GA20004@red-moon>
 <CAK8P3a0DRFxz_yjCeFZJ8Zukuy8gi9hPbWEfp29TaF2TMjrnTQ@mail.gmail.com>
 <20170602135619.GA10491@red-moon>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 2 Jun 2017 16:44:26 +0200
Message-ID: <CAK8P3a3Qf_DDU09XVXBm+Y3d+n5He-2cnqqYTtg6_yiKE07jkw@mail.gmail.com>
Subject: Re: [RFC/RFT PATCH 08/18] PCI: designware: Convert PCI scan API to
 pci_scan_root_bus_bridge()
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Pratyush Anand <pratyush.anand@gmail.com>,
 Gabriele Paoloni <gabriele.paoloni@huawei.com>,
 linux-pci <linux-pci@vger.kernel.org>, Shawn Lin <shawn.lin@rock-chips.com>,
 Will Deacon <will.deacon@arm.com>, Russell King <linux@armlinux.org.uk>,
 Thierry Reding <thierry.reding@gmail.com>, Tanmay Inamdar <tinamdar@apm.com>,
 Matthew Minter <matt@masarand.com>, Rob Herring <robh@kernel.org>,
 Joao Pinto <Joao.Pinto@synopsys.com>, Wenrui Li <wenrui.li@rock-chips.com>,
 Michal Simek <michal.simek@xilinx.com>, Murali Karicheri <m-karicheri2@ti.com>,
 Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
 Simon Horman <horms@verge.net.au>, Bjorn Helgaas <bhelgaas@google.com>,
 Mingkai Hu <mingkai.hu@freescale.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
 Jingoo Han <jingoohan1@gmail.com>, Stanimir Varbanov <svarbanov@mm-sol.com>,
 Minghuan Lian <minghuan.Lian@freescale.com>,
 Zhou Wang <wangzhou1@hisilicon.com>, Roy Zang <tie-fei.zang@freescale.com>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jun 2, 2017 at 3:56 PM, Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
> On Fri, Jun 02, 2017 at 03:12:48PM +0200, Arnd Bergmann wrote:
>> > I am almost done refactoring this series and this is the last review to
>> > address. What you suggest above makes sense but:
>> >
>> > 1) it means patching ALL dw_pcie_host_init() callers and allocate the
>> >    host bridge there, not sure it simplifies, certainly it complicates
>> >    the error handling path (given that the host bridge memory is
>> >    probably the only memory that is allocated with kzalloc instead of
>> >    devm interface so it needs unwinding)
>> >
>> > 2) I noticed that allocating the host bridge in the caller complicates
>> >    error handling, in particular code in the mainline (ie tegra and
>> >    ftpci100) using pci_alloc_host_bridge() needs already patching since it
>> >    may leak memory if PCI host bridge drivers probing fails.
>> >
>> > I can implement (1) and (2) but I wanted to ask first to understand if
>> > that's the direction we want to take.
>>
>> Good question. Maybe we should add a devm_pci_alloc_host_bridge()
>> instead? Would that solve these problems without creating bigger ones?
>
> It would be yet another PCI core call (ie unfortunately we still need
> pci_alloc_host_bridge() for bridges with no parent device eg bios32) but
> I think that's the only option we have if we do not want to clutter the
> host bridges error paths with host bridge free calls.
>
> Implementing it should be relatively simple by reshuffling functions.
>
> Thoughts ?

I think adding this one would be fairly harmless because it has a clear
purpose and can easily be mixed with the rest of the API.

In one of the earlier drafts, we discussed just letting the user call an
initialization function to set the members and otherwise using kmalloc()
themselves. We decided on this one to save an extra function call in
each driver, but in retrospect, it would have saved us the discussion
now.

If we end up adding a devm_pci_alloc_host_bridge (or maybe
pcim_alloc_host_bridge), we also need to decide what part of the
cleanup would happen during the unwinding, besides the kfree().

        Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
