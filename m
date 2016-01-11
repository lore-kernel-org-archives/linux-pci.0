Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Mon, 11 Jan 2016 16:09:46 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Tomasz Nowicki <tn@semihalf.com>, okaya@codeaurora.org,
	bhelgaas@google.com, will.deacon@arm.com, catalin.marinas@arm.com,
	rjw@rjwysocki.net, hanjun.guo@linaro.org,
	jiang.liu@linux.intel.com, stefano.stabellini@eu.citrix.com,
	robert.richter@caviumnetworks.com, mw@semihalf.com,
	liviu.dudau@arm.com, ddaney@caviumnetworks.com, tglx@linutronix.de,
	wangyijing@huawei.com, suravee.suthikulpanit@amd.com,
	msalter@redhat.com, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org,
	jchandra@broadcom.com, jcm@redhat.com
Subject: Re: [PATCH V2 00/23] MMCONFIG refactoring and support for ARM64 PCI
 hostbridge init based on ACPI
Message-ID: <20160111160946.GB2366@red-moon>
References: <1450278993-12664-1-git-send-email-tn@semihalf.com>
 <20151221121050.GB11145@red-moon>
 <5677F3C8.8040200@semihalf.com>
 <201512211515.55447.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201512211515.55447.arnd@arndb.de>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Arnd,

On Mon, Dec 21, 2015 at 03:15:54PM +0100, Arnd Bergmann wrote:
> On Monday 21 December 2015, Tomasz Nowicki wrote:
> > On 21.12.2015 13:10, Lorenzo Pieralisi wrote:
> > > On Fri, Dec 18, 2015 at 06:56:39PM +0000, okaya@codeaurora.org wrote:
> 
> > >> I have multiple root ports with the same IO port configuration in the
> > >> current ACPI table.
> > >>
> > >> Root port 0 = IO range 0x1000-0x10FFF
> > >> Root port 1 = IO range 0x1000-0x10FFF
> > >> Root port 2 = IO range 0x1000-0x10FFF
> > >
> > > It is fine. You end up mapping for each of those a 4k window of the
> > > virtual address space allocated to IO and that's what you will have in
> > > the kernel PCI resources (not in the HW BARs though). If that was a problem
> > > it would be even for the current DT host controllers eg:
> > >
> > > arch/arm64/boot/dts/apm/apm-storm.dtsi
> > >
> > > it should not be (again I will let Arnd comment on this since he may be
> > > aware of issues encountered on other arches/platforms).
> > >
> > 
> > Root port 0 = IO range 0x1000-0x10FFF
> > Root port 1 = IO range 0x1000-0x10FFF
> > Root port 2 = IO range 0x1000-0x10FFF
> > 
> > If above ranges are mapped into different CPU windows, then yes, it is fine.
> 
> Ideally, they should all be the same CPU address so we only have to
> map the window once, each device gets an address below 64K, and you
> can have legacy port numbers (below 4K) on any bus, which is required
> to make certain GPUs work.

Can I ask you to elaborate on the above please ? Do you mean a single
CPU physical address range mapping the whole PCI IO address space ?
I did not quite get what you mean by "you can have legacy port numbers
on any bus", I think it would be good to clarify so that we are all
on the same page.

Thanks a lot !
Lorenzo
