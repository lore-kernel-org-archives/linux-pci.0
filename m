Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Tue, 21 Mar 2017 15:26:36 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: [PATCH 05/20] ARM: implement pci_remap_cfgspace() interface
Message-ID: <20170321152636.GA4799@red-moon>
References: <20170227151436.18698-1-lorenzo.pieralisi@arm.com>
 <20170227151436.18698-6-lorenzo.pieralisi@arm.com>
 <20170320164354.GQ21222@n2100.armlinux.org.uk>
MIME-Version: 1.0
In-Reply-To: <20170320164354.GQ21222@n2100.armlinux.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Wenrui Li <wenrui.li@rock-chips.com>,
 Gabriele Paoloni <gabriele.paoloni@huawei.com>, linux-pci@vger.kernel.org,
 Shawn Lin <shawn.lin@rock-chips.com>, Will Deacon <will.deacon@arm.com>,
 Thierry Reding <thierry.reding@gmail.com>, Tanmay Inamdar <tinamdar@apm.com>,
 linux-arch@vger.kernel.org, Joao Pinto <Joao.Pinto@synopsys.com>,
 Pratyush Anand <pratyush.anand@gmail.com>,
 Michal Simek <michal.simek@xilinx.com>, Jon Mason <jonmason@broadcom.com>,
 Murali Karicheri <m-karicheri2@ti.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Arnd Bergmann <arnd@arndb.de>,
 Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
 Ray Jui <rjui@broadcom.com>, John Garry <john.garry@huawei.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Mingkai Hu <mingkai.hu@freescale.com>,
 linux-arm-kernel@lists.infradead.org,
 Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
 Jingoo Han <jingoohan1@gmail.com>, linux-kernel@vger.kernel.org,
 Stanimir Varbanov <svarbanov@mm-sol.com>,
 Minghuan Lian <minghuan.Lian@freescale.com>,
 Zhou Wang <wangzhou1@hisilicon.com>, Roy Zang <tie-fei.zang@freescale.com>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Hi Russell,

On Mon, Mar 20, 2017 at 04:43:55PM +0000, Russell King - ARM Linux wrote:
> On Mon, Feb 27, 2017 at 03:14:16PM +0000, Lorenzo Pieralisi wrote:
> > The PCI bus specifications (rev 3.0, 3.2.5 "Transaction Ordering
> > and Posting") define rules for PCI configuration space transactions
> > ordering and posting, that state that configuration writes have to
> > be non-posted transactions.
> > 
> > Current ioremap interface on ARM provides mapping functions that
> > provide "bufferable" writes transactions (ie ioremap uses MT_DEVICE
> > memory type) aka posted writes, so PCI host controller drivers have
> > no arch interface to remap PCI configuration space with memory
> > attributes that comply with the PCI specifications for configuration
> > space.
> > 
> > Implement an ARM specific pci_remap_cfgspace() interface that allows to
> > map PCI config memory regions with MT_UNCACHED memory type (ie strongly
> > ordered - non-posted writes), providing a remap function that complies
> > with PCI specifications for config space transactions.
> 
> Doesn't this have the side effect that configuration writes can bypass
> writes to device memory if there isn't an intervening dsb?  (They
> probably can do on some CPUs today anyway.)

I assumed that in plain terms, the difference between MT_DEVICE and
MT_UNCACHED is write posting (aka bufferable) behaviour (across CPU
architecture versions) and that does not affect write ordering rules.

You and Catalin have more insights into ARM 32-bit memory types so
I definitely need your input here to be comprehensive and avoid
pitfalls, let me know if you have some specific CPUs in mind on
which this may trigger a regression.

> So, in any case, this looks like an improvement:
> 
> Acked-by: Russell King <rmk+kernel@armlinux.org.uk>

Thank you !

Lorenzo

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
