Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Mon, 14 Sep 2015 10:37:19 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Tomasz Nowicki <tomasz.nowicki@linaro.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	"hanjun.guo@linaro.org" <hanjun.guo@linaro.org>,
	Liviu Dudau <Liviu.Dudau@arm.com>,
	Yijing Wang <wangyijing@huawei.com>,
	Will Deacon <Will.Deacon@arm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Catalin Marinas <Catalin.Marinas@arm.com>,
	Jiang Liu <jiang.liu@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
	"msalter@redhat.com" <msalter@redhat.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>
Subject: Re: [PATCH 05/11] x86, pci, acpi: Move arch-agnostic MMCONFIG (aka
 ECAM) and ACPI code out of arch/x86/ directory
Message-ID: <20150914093719.GC18410@red-moon>
References: <20150604102253.GA31773@red-moon>
 <5570447D.3020705@linaro.org>
 <557504A2.3060203@linaro.org>
 <20150608151443.GA16151@red-moon>
 <55E4340D.6050004@linaro.org>
 <55ED6010.3020406@linaro.org>
 <20150908150727.GF29293@red-moon>
 <55F0388B.1090607@linaro.org>
 <20150911112018.GA13033@red-moon>
 <55F2CA98.7050905@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <55F2CA98.7050905@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Sep 11, 2015 at 01:35:36PM +0100, Tomasz Nowicki wrote:
> On 11.09.2015 13:20, Lorenzo Pieralisi wrote:

[...]

> >>> With that in place using raw_pci_write/read or the generic accessors
> >>> becomes almost identical, with code requiring the pci_bus to be
> >>> created using the generic accessors and ACPICA using the raw version.
> >>>
> >>> I might be missing something, so apologies if that's the case.
> >>>
> >>
> >> Actually, I think you showed me the right direction :) Here are some
> >> conclusions/comments/concerns. Please correct me if I am wrong:
> >>
> >> 1. We need raw_pci_write/read accessors (based on ECAM) for ARM64 too
> >> but only up to the point where buses are enumerated. From that point on,
> >> we should reuse generic accessors from access.c file, right?
> >
> > Well, I still have not figured out whether on arm64 the raw accessors
> > required by ACPICA make sense.
> >
> > So either arm64 relies on the generic MCFG based raw read and writes
> > or we define the global raw read and writes as empty (ie x86 overrides
> > them anyway).
> >
> > I will get back to you on this.
> >
> >> 2. For ARM64 ACPI PCI, we can use generic accessors right away, .map_bus
> >> would call common code part (pci_dev_base()). The only thing that worry
> >> me is fact that MCFG regions are RCU list so it needs rcu_read_lock()
> >> for the .map_bus (mcfg lookup) *and* read/write operation.
> >
> > Do you mean the address look-up and the mmio operation should be carried
> > out atomically right ?
> Yes.

We can wrap the calls pci_generic_read/write() within a function and
add rcu_read_lock()/unlock() around them, eg:

int pci_generic_config_read_rcu()
{
	rcu_read_lock();
	pci_generic_config_read(...);
	rcu_read_unlock();
}

Honestly it seems the RCU API is needed just because config space
can be also accessed by raw_ accessors in ACPICA code, that's the only
reason I see to protect the config structs against config space
removal (basically config entries are removed only when the host
bridge is released if I read the code correctly, and the only way
this can happen concurrently is having ACPICA code reusing the
same config space but accessing it with no pci_bus struct attached
to it, by just using the (segment, bus, dev, fn) tuple).

Lorenzo
