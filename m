Return-Path: <linux-acpi-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20150218182739.GA17462@google.com>
References: <1416413091-13452-1-git-send-email-tomasz.nowicki@linaro.org>
 <1416413091-13452-4-git-send-email-tomasz.nowicki@linaro.org>
 <20141210231746.GF6692@google.com> <54E33C05.9010300@linaro.org> <20150218182739.GA17462@google.com>
From: Rob Herring <robherring2@gmail.com>
Date: Wed, 18 Feb 2015 13:02:56 -0600
Message-ID: <CAL_Jsq+vR2-YbfVqQ2hFCRLyWUZJW4_Ki+ZFRz1=JTeOiE07Lw@mail.gmail.com>
Subject: Re: [PATCH 3/6] x86, acpi, pci: Move PCI config space accessors.
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Tomasz Nowicki <tomasz.nowicki@linaro.org>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	"linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	"x86@kernel.org" <x86@kernel.org>,
	Will Deacon <will.deacon@arm.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Hanjun Guo <hanjun.guo@linaro.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Yijing Wang <wangyijing@huawei.com>,
	Liviu Dudau <Liviu.Dudau@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Feb 18, 2015 at 12:27 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> On Tue, Feb 17, 2015 at 02:03:01PM +0100, Tomasz Nowicki wrote:
>> On 11.12.2014 00:17, Bjorn Helgaas wrote:
>> >On Wed, Nov 19, 2014 at 05:04:48PM +0100, Tomasz Nowicki wrote:
>> >>We are going to use mmio_config_{} name convention across all architectures.
>> >
>> >mmio_config_*() are workarounds for an AMD Fam10h defect [1].  I would prefer
>> >not to extend these names to other architectures, because they should be
>> >able to use readb()/writeb()/etc. directly, as we did on x86 before
>> >3320ad994afb ("x86: Work around mmio config space quirk on AMD Fam10h").
>> >
>> >In fact, it would be nice if we could use readb()/writeb()/etc. on x86, and
>> >only use mmio_config_*() when we're on AMD Fam10h.  Maybe there could be a
>> >"struct pci_raw_ops pci_mmcfg_amd_fam10h" that used mmio_config_*(), and we
>> >could set raw_pci_ext_ops to those ops instead of the default ones when
>> >we're on AMD Fam10h.  Then x86 should be able to use the generic
>> >readb()-based ops on most platforms.
>>
>> While I do agree we should use readb()/writeb()... methods, I am not
>> sure there is a nice way to use mmio_config_*() exclusively for AMD
>> Fam10h. For x86, right now, we have three PCI config accessors sets:
>> mmconfig_32.c, mmconfig_64.c, numachip.c and each are different. So
>> one pci_mmcfg_amd_fam10h pci_raw_ops is not enough. I am thinking of
>> having additional structure (integrated with "struct
>> pci_mmcfg_region") that keeps MMIO accessors where readb()/writeb()
>> would be the default one. For AMD Fam10h case we could tweak it as
>> necessary. What do you thing Bjorn?
>
> It's OK if we use mmio_config_*() for all x86 (not just AMD Fam10h); that's
> what we do today.  It'd be *nicer* if we could use the workaround only for
> Fam10h, but if it complicates the code, don't bother.
>
> My main point is that I think your v1 posting requires every arch to
> implement mmio_config_*(), and they will all be the same.  If an arch
> doesn't require a workaround, it shouldn't have to supply anything and we
> should default to readb/writeb/etc.

Perhaps the abstraction needs to move up a level to pci_ops functions.
Then x86 can use the generic ones I added and AMD can use custom ones.

BTW, there are some cases on MIPS that need special accessors. It's
mainly a function of whether the accessors need to do endian swapping
or not.

Rob
