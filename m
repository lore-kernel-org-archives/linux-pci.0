Return-Path: <linux-acpi-owner@vger.kernel.org>
Subject: Re: [PATCH V2 00/23] MMCONFIG refactoring and support for ARM64 PCI
 hostbridge init based on ACPI
To: Tomasz Nowicki <tn@semihalf.com>, bhelgaas@google.com,
	arnd@arndb.de, will.deacon@arm.com, catalin.marinas@arm.com,
	rjw@rjwysocki.net, hanjun.guo@linaro.org,
	Lorenzo.Pieralisi@arm.com, jiang.liu@linux.intel.com,
	Stefano.Stabellini@eu.citrix.com
References: <1450278993-12664-1-git-send-email-tn@semihalf.com>
Cc: robert.richter@caviumnetworks.com, mw@semihalf.com,
	Liviu.Dudau@arm.com, ddaney@caviumnetworks.com, tglx@linutronix.de,
	wangyijing@huawei.com, Suravee.Suthikulpanit@amd.com,
	msalter@redhat.com, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org,
	jchandra@broadcom.com, jcm@redhat.com
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <5673281E.7020204@codeaurora.org>
Date: Thu, 17 Dec 2015 16:24:46 -0500
MIME-Version: 1.0
In-Reply-To: <1450278993-12664-1-git-send-email-tn@semihalf.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Tomasz,

On 12/16/2015 10:16 AM, Tomasz Nowicki wrote:
> From the functionality point of view this series might be split into the
> following logic parts:
> 1. Make MMCONFIG code arch-agnostic which allows all architectures to collect
>    PCI config regions and used when necessary.
> 2. Move non-arch specific bits to the core code.
> 3. Use MMCONFIG code and implement generic ACPI based PCI host
>    controller driver.
> 4. Enable above driver on ARM64
> 
> Patches has been built on top of 4.4-rc4 and can be found here:
> git@github.com:semihalf-nowicki-tomasz/linux.git (pci-acpi-v2)
> 
> NOTE, this patch set depends on Matthew's patches:
> http://www.spinics.net/lists/linux-pci/msg45950.html
> https://github.com/Vality/linux/tree/pci-fixes
> 
> This has been tested on Cavium ThunderX 1 socket server and QEMU.
> Any help in reviewing and testing is very appreciated.
> 
> v1 -> v2
> - moved non-arch specific piece of code to dirver/acpi/ directory
> - fixed IO resource handling
> - introduced PCI config accessors quirks matching
> - moved ACPI_COMPANION_SET to generic code
> 

Just tested your series. I'm seeing a resource assignment problem below. 
The bus addresses show as memory addresses and memory addresses show as 
bus addresses and IO resource did not show up.


Tomasz V2

[    2.520852] ACPI: PCI Interrupt Link [LN1C] (IRQs *238)
[    2.535472] ACPI: PCI Interrupt Link [LN1D] (IRQs *239)
[    2.550562] ACPI: PCI Root Bridge [PCI2] (domain 0002 [bus 00-1f])
[    2.567813] acpi PNP0A08:02: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
[    2.591270] acpi PNP0A08:02: _OSC: platform does not support [PCIeHotplug]
[    2.611144] acpi PNP0A08:02: _OSC: OS now controls [PME AER PCIeCapability]
[    2.630299] ACPI: IORT: can't find node related to (null) device
[    2.647184]_acpi_PNP0A08:02:_PCI_host_bridge_to_bus_0002:00
[    2.662663] pci_bus 0002:00: root bus resource [mem 0x00100000-0x3fffffff window] (bus address [0xfffff5ff00100000-0xfffff5ff3fffffff])
[    2.703561] pci_bus 0002:00: root bus resource [mem 0x40000000-0x7fffffff window] (bus address [0xfffff5fe80000000-0xfffff5febfffffff])
[    2.737737] pci_bus 0002:00: root bus resource [mem 0x80000000-0xffffffff window] (bus address [0xfffff5fe00000000-0xfffff5fe7fffffff])
[    2.794961] pci_bus 0002:00: root bus resource [bus 00-1f]

Mark Salter's patches

[    2.730011] ACPI: PCI Interrupt Link [LN1C] (IRQs *238)
[    2.744648] ACPI: PCI Interrupt Link [LN1D] (IRQs *239)
[    2.759330] ACPI: PCI Root Bridge [PCI2] (domain 0002 [bus 00-1f])
[    2.783295] acpi PNP0A08:02: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
[    2.806726] acpi PNP0A08:02: _OSC: platform does not support [PCIeHotplug]
[    2.826005] acpi PNP0A08:02: _OSC: OS now controls [PME AER PCIeCapability]
[    2.845361] PCI host bridge to bus 0002:00
[    2.856719]_pci_bus_0002:00:_root_bus_resource_[bus_00-1f]
[    2.872056] pci_bus 0002:00: root bus resource [mem 0xa0100100000-0xa013fffffff] (bus address [0x00100000-0x3fffffff])
[    2.902008] pci_bus 0002:00: root bus resource [mem 0xa0200000000-0xa023fffffff] (bus address [0x40000000-0x7fffffff])
[    2.932396] pci_bus 0002:00: root bus resource [mem 0xa0300000000-0xa037fffffff] (bus address [0x80000000-0xffffffff])
[    2.983827] pci_bus 0002:00: root bus resource [io  0x0000-0xffff]

Here is how the ACPI table looks like:

		QWORDMemory(			// Consumed-And-prodced resource(all of memory space)
			ResourceProducer,	// bit 0 of general flags is 0
			PosDecode,		// positive Decode:  		_DEC
			MinFixed,		// Range is fixed:   		_MIF
			MaxFixed,		// Range is fixed:   		_MAF
			NonCacheable,		// 				_MEM
			ReadWrite,		// 				_RW
			0x00000000,		// Granularity: 	   	_GRA
			0x00100000,		// Min - PCI Memory start: 	_MIN
			0x3FFFFFFF,		// Max - PCI Memory end:   	_MAX
			0xA0100000000,		// Translation: 		_TRA
			0x3FF00000,		// Range Length: 		_LEN
			,			// Optional field left blank
			,			// Optional field left blank
			MEM0,			// Name declaration for this descriptor
			AddressRangeMemory,
			TypeStatic
			) 


Any thoughts?


-- 
Sinan Kaya
Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project

