Return-Path: <linux-acpi-owner@vger.kernel.org>
Subject: Re: [Patch v7 4/7] PCI/ACPI: Add interface acpi_pci_root_create()
To: Jiang Liu <jiang.liu@linux.intel.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
References: <1444804182-6596-1-git-send-email-jiang.liu@linux.intel.com>
 <1444804182-6596-5-git-send-email-jiang.liu@linux.intel.com>
 <563B65EE.7000406@semihalf.com> <20151105181959.GA352@red-moon>
 <563C6A5F.5030500@linux.intel.com> <563C82FA.7050707@semihalf.com>
 <563C930F.4060206@linux.intel.com> <563C9FBE.2090303@semihalf.com>
 <563CA9A6.7050309@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Hanjun Guo <hanjun.guo@linaro.org>,
	Liviu Dudau <Liviu.Dudau@arm.com>, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	x86@kernel.org
From: Tomasz Nowicki <tn@semihalf.com>
Message-ID: <5640A8AA.4000806@semihalf.com>
Date: Mon, 9 Nov 2015 15:07:38 +0100
MIME-Version: 1.0
In-Reply-To: <563CA9A6.7050309@linux.intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 06.11.2015 14:22, Jiang Liu wrote:
> On 2015/11/6 20:40, Tomasz Nowicki wrote:
>> On 06.11.2015 12:46, Jiang Liu wrote:
>>> On 2015/11/6 18:37, Tomasz Nowicki wrote:
>>>> On 06.11.2015 09:52, Jiang Liu wrote:
>>>> Sure, ARM64 (0-16M IO space) QEMU example:
>>>> DWordIO (ResourceProducer, MinFixed, MaxFixed, PosDecode, EntireRange,
>>>>            0x00000000,         // Granularity
>>>>            0x00000000,         // Range Minimum
>>>>            0x0000FFFF,         // Range Maximum
>>>>            0x3EFF0000,         // Translation Offset
>>>>            0x00010000,         // Length
>>>>            ,, , TypeStatic)
>>> The above DWordIO resource descriptor doesn't confirm to the ACPI spec.
>>> According to my understanding, ARM/ARM64 has no concept of IO port
>>> address space, so the PCI host bridge will map IO port on PCI side
>>> onto MMIO on host side. In other words, PCI host bridge on ARM64
>>> implement a IO Port->MMIO translation instead of a IO Port->IO Port
>>> translation. If that's true, it should use 'TypeTranslation' instead
>>> of 'TypeStatic'. And kernel ACPI resource parsing interface doesn't
>>> support 'TypeTranslation' yet, so we need to find a solution for it.
>>
>> I think you are right, we need TypeTranslation flag for ARM64 DWordIO
>> descriptors and an extra kernel patch to support it.
> How about the attached to patch to support TypeTranslation?
> It only passes compilation:)

Based on the further discussion, your draft patch looks good to me. 
Lorenzo, do you agree?

Gerry, what would be the best way to approach with this, extra patch of 
your set? or keep it separately, might be part of my set.

Thanks,
Tomasz
