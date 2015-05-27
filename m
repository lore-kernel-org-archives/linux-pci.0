Return-Path: <linux-acpi-owner@vger.kernel.org>
Message-ID: <55657EA3.5000601@linaro.org>
Date: Wed, 27 May 2015 16:21:55 +0800
From: Hanjun Guo <hanjun.guo@linaro.org>
MIME-Version: 1.0
To: Jiang Liu <jiang.liu@linux.intel.com>,
	Liviu Dudau <Liviu.Dudau@arm.com>
CC: Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>,
	Catalin Marinas <Catalin.Marinas@arm.com>,
	Will Deacon <Will.Deacon@arm.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Thomas Gleixner <tglx@linutronix.de>,
	Yijing Wang <wangyijing@huawei.com>,
	Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
	Tomasz Nowicki <tomasz.nowicki@linaro.org>,
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
	"msalter@redhat.com" <msalter@redhat.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>
Subject: Re: [PATCH 01/11] ARM64 / PCI: introduce struct pci_controller for
 ACPI
References: <1432644564-24746-1-git-send-email-hanjun.guo@linaro.org> <1432644564-24746-2-git-send-email-hanjun.guo@linaro.org> <20150526165844.GD2175@e106497-lin.cambridge.arm.com> <5564AB68.6080502@linux.intel.com>
In-Reply-To: <5564AB68.6080502@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Liviu,

On 2015年05月27日 01:20, Jiang Liu wrote:
> On 2015/5/27 0:58, Liviu Dudau wrote:
>> On Tue, May 26, 2015 at 01:49:14PM +0100, Hanjun Guo wrote:
>>> ARM64 ACPI based PCI host bridge init needs a arch dependent
>>> struct pci_controller to accommodate common PCI host bridge
>>> code which is introduced later, or it will lead to compile
>>> errors on ARM64.
>>
>> Hi Hanjun,
>>
>> Two questions: why don't you introduce this patch next to the
>> one that is going to make use of it (or even merge it there)?

this is because of this patch is needed by Jiang Liu's patch set
to fix the compile error on ARM64, I'd rather do that, but It's
better to let Jiang Liu's patch goes in, and then this one, that's
why I prepared a single patch for the struct. (I mentioned it
in the cover letter)

>> Second, why is the whole struct pci_controller not surrounded
>> by #ifdef CONFIG_ACPI as you are implying that this is needed
>> only for ACPI?

I hope it can be reused, since the NUMA node and segment (domain)
is both needed for DT and ACPI, if it's not the case foe now, I
can surrounded them all by #ifdef CONFIG_ACPI.

>>
>> Btw, looking through the whole series I'm not (yet) convinced
>> that this is needed at all.
> Hi Liviu,
> 	This structure is required by the requested patch set
> at http://patchwork.ozlabs.org/patch/472249/, which consolidates
> the common code to support PCI host bridge into ACPI core.

Jiang, thanks for the explanation :)

Thanks
Hanjun
