Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH V3 00/21] MMCONFIG refactoring and support for ARM64 PCI
 hostbridge init based on ACPI
To: Tomasz Nowicki <tn@semihalf.com>, bhelgaas@google.com,
	arnd@arndb.de, will.deacon@arm.com, catalin.marinas@arm.com,
	rjw@rjwysocki.net, hanjun.guo@linaro.org,
	Lorenzo.Pieralisi@arm.com, okaya@codeaurora.org,
	jiang.liu@linux.intel.com, Stefano.Stabellini@eu.citrix.com
References: <1452691267-32240-1-git-send-email-tn@semihalf.com>
Cc: jchandra@broadcom.com, jcm@redhat.com,
	linaro-acpi@lists.linaro.org, linux-pci@vger.kernel.org,
	Liviu.Dudau@arm.com, ddaney@caviumnetworks.com,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	robert.richter@caviumnetworks.com, Suravee.Suthikulpanit@amd.com,
	msalter@redhat.com, wangyijing@huawei.com, tglx@linutronix.de,
	mw@semihalf.com, linux-arm-kernel@lists.infradead.org
From: Jeremy Linton <jeremy.linton@arm.com>
Message-ID: <56982766.8060000@arm.com>
Date: Thu, 14 Jan 2016 16:55:34 -0600
MIME-Version: 1.0
In-Reply-To: <1452691267-32240-1-git-send-email-tn@semihalf.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 01/13/2016 07:20 AM, Tomasz Nowicki wrote:
>  From the functionality point of view this series might be split into the
> following logic parts:
> 1. Make MMCONFIG code arch-agnostic which allows all architectures to collect
>     PCI config regions and used when necessary.
> 2. Move non-arch specific bits to the core code.
> 3. Use MMCONFIG code and implement generic ACPI based PCI host controller driver.
> 4. Enable above driver on ARM64
>
> Patches has been built on top of 4.4 and can be found here:
> git@github.com:semihalf-nowicki-tomasz/linux.git (pci-acpi-v3)

I boot tested this on JunoR2 with a recent build of Tianocore EDK2.

It works enough to boot the machine with PCIe attached sata, and 
ethernet, but is throwing messages like:

[    1.094643] pci 0000:00:00.0: BAR 13: no space for [io  size 0x2000]
[    1.101022] pci 0000:00:00.0: BAR 13: failed to assign [io  size 0x2000]

Its also throwing:

[    1.029958] pci 0000:00:00.0: of_irq_parse_pci() failed with rc=-22
[    1.052784] pci 0000:00:00.0: of_irq_parse_pci() failed with rc=-22


(see other response for the DwordIo resource i'm using).
