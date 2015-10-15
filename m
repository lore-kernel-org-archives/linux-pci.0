Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Thu, 15 Oct 2015 14:22:00 +0100
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
Message-ID: <20151015132200.GA7621@red-moon>
References: <20150604102253.GA31773@red-moon>
 <5570447D.3020705@linaro.org>
 <557504A2.3060203@linaro.org>
 <20150608151443.GA16151@red-moon>
 <55E4340D.6050004@linaro.org>
 <55ED6010.3020406@linaro.org>
 <20150908150727.GF29293@red-moon>
 <55F0388B.1090607@linaro.org>
 <20150911112018.GA13033@red-moon>
 <55F6DFF6.4010807@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <55F6DFF6.4010807@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Sep 14, 2015 at 03:55:50PM +0100, Tomasz Nowicki wrote:

[...]

> > Well, I still have not figured out whether on arm64 the raw accessors
> > required by ACPICA make sense.
> >
> > So either arm64 relies on the generic MCFG based raw read and writes
> > or we define the global raw read and writes as empty (ie x86 overrides
> > them anyway).
> >
> 
> My concerns/ideas related to raw accessors for ARM64, please correct me 
> at any point.
> 
> ACPI spec - chapter: 19.5.96 OperationRegion (Declare Operation Region)
> defines PCI_Config as one of region types. Every time ASL opcode 
> operates on corresponding PCI config space region, ASL interpreter is 
> dispatching address space to our raw accessors, please see 
> acpi_ex_pci_config_space_handler, acpi_ev_pci_config_region_setup calls. 
> What is more important, such operations may happen after (yes after) bus 
> enumeration, but always raw accessors are called at the end with the 
> {segment, bus, dev, fn} tuple.
> 
> Giving above, here are some ideas:
> 1. We force somehow vendors to avoid operations on PCI config regions in 
> ASL code. PCI config region definitions still fall into Hardware Reduced 
> profile, so new ACPICA special subset for ARM64 is need. Then raw ACPI 
> accessors can be empty (and overridden by x86).

I am coming back to this, I am not sure that PCI config based OperationRegions
fall into Hardware Reduced profile, I will finally start a thread on ASWG
to check that.

Other than that, are you posting an updated version of this series soon ?
Let me know if you need help refactoring/testing the patches.

Thanks,
Lorenzo

> 2. We provide raw accessors which translate {segment, bus, dev, fn} 
> tuple to Linux generic accessors (this can be considered only if PCI 
> config accesses happened after bus enumeration for HR profile, thus 
> tuple to bus structure map is possible).
> 4. We rely on the generic MCFG based raw read and writes.
> 
> Let me know your opinion.
> 
> Thanks,
> Tomasz
> 
