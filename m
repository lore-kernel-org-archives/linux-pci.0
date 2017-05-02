Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
MIME-Version: 1.0
In-Reply-To: <20170502171501.GA5545@red-moon>
References: <20170426111809.19922-1-lorenzo.pieralisi@arm.com>
 <20170426111809.19922-4-lorenzo.pieralisi@arm.com>
 <CAK8P3a0HmrrYBP5em1s4VOY4Tb6=bwOrDDN6K8rPp8OEXtpMtA@mail.gmail.com>
 <20170502171501.GA5545@red-moon>
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 2 May 2017 21:36:41 +0200
Message-ID: <CAK8P3a1dbopDOXot-brx+xfZeBbUZUfYf1Urs2T3UNwXyg8Mnw@mail.gmail.com>
Subject: Re: [RFC/RFT PATCH 03/18] PCI: Introduce pci_scan_root_bus_bridge()
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

On Tue, May 2, 2017 at 7:15 PM, Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
> On Fri, Apr 28, 2017 at 02:28:38PM +0200, Arnd Bergmann wrote:
>> On Wed, Apr 26, 2017 at 1:17 PM, Lorenzo Pieralisi
>> <lorenzo.pieralisi@arm.com> wrote:
>>
>> Good idea, yes. To avoid growing the number of interfaces too
>> much, should we change the existing users of pci_register_host_bridge
>> in host drivers over to this entry point, and make the other one
>> local to probe.c then?
>
> Yes, the problem is that there are drivers (ie pcie-iproc.c) that
> require the struct pci_bus (created by pci_register_host_bridge())
> to fiddle with it to check link status and THEN scan the bus (so
> the pci_register_host_bridge() call can't be embedded in the scan
> interface - the driver requires struct pci_bus for pci_ops to work
> before scanning the bus itself).
>
> I will see how I can accommodate this change because you definitely
> have a point.

The obvious answer for that particular problem would be a link_check()
callback in the bridge operations. I think that would also fit in well with
the dw_pcie driver that has some private infrastructure for it. I don't
know if that callback is sufficient to solve all related problems though.

       Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
