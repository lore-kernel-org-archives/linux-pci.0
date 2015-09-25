Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Fri, 25 Sep 2015 17:19:24 +0100
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
Message-ID: <20150925161924.GA2271@red-moon>
References: <5570447D.3020705@linaro.org>
 <557504A2.3060203@linaro.org>
 <20150608151443.GA16151@red-moon>
 <55E4340D.6050004@linaro.org>
 <55ED6010.3020406@linaro.org>
 <20150908150727.GF29293@red-moon>
 <55F0388B.1090607@linaro.org>
 <20150911112018.GA13033@red-moon>
 <55F6DFF6.4010807@linaro.org>
 <56057001.9000101@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <56057001.9000101@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Sep 25, 2015 at 05:02:09PM +0100, Tomasz Nowicki wrote:

[...]

> > My concerns/ideas related to raw accessors for ARM64, please correct me
> > at any point.
> >
> > ACPI spec - chapter: 19.5.96 OperationRegion (Declare Operation Region)
> > defines PCI_Config as one of region types. Every time ASL opcode
> > operates on corresponding PCI config space region, ASL interpreter is
> > dispatching address space to our raw accessors, please see
> > acpi_ex_pci_config_space_handler, acpi_ev_pci_config_region_setup calls.
> > What is more important, such operations may happen after (yes after) bus
> > enumeration, but always raw accessors are called at the end with the
> > {segment, bus, dev, fn} tuple.
> >
> > Giving above, here are some ideas:
> > 1. We force somehow vendors to avoid operations on PCI config regions in
> > ASL code. PCI config region definitions still fall into Hardware Reduced
> > profile, so new ACPICA special subset for ARM64 is need. Then raw ACPI
> > accessors can be empty (and overridden by x86).
> > 2. We provide raw accessors which translate {segment, bus, dev, fn}
> > tuple to Linux generic accessors (this can be considered only if PCI
> > config accesses happened after bus enumeration for HR profile, thus
> > tuple to bus structure map is possible).
> > 4. We rely on the generic MCFG based raw read and writes.
> 
> I will appreciate your opinion on above ideas.

Well, (1) does not seem allowed by the ACPI specification, the only
way we can detect that is by leaving the raw accessors empty for
now and see how things will turn out on ARM64, in the meantime
I will start a thread on ASWG to check how that's used on x86, I
do not have any machine to test this and grokking ACPICA is not
trivial, there is lots of history there and it is hard to fathom.

(2) is tempting but I am not sure it works all the time (I still
think that's a quirk of ACPI specs, namely that some OperationRegion
should always be available to ASL, maybe that's just an unused ACPI
spec quirk).

If I read you series correctly (4) can be implemented easily if and
when we deem the raw accessors necessary, on top of the MCFG layer,
by making the MCFG raw accessors the default instead of leaving them
empty.

I pulled your branch and started testing it on AMD Seattle, next week
we should try to get this done.

I think you should target option (1) and in the meantime we should
reach a conclusion on the raw accessors usage on ARM64.

Thanks,
Lorenzo
