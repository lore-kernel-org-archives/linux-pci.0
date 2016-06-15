Return-Path: <linux-acpi-owner@vger.kernel.org>
Subject: Re: [PATCH V6 0/7] Introduce ACPI world to ITS irqchip
To: Marc Zyngier <marc.zyngier@arm.com>, rjw@rjwysocki.net,
	bhelgaas@google.com, lorenzo.pieralisi@arm.com
References: <1465828873-23498-1-git-send-email-tn@semihalf.com>
 <20160615100919.6b507b57@arm.com>
Cc: tglx@linutronix.de, jason@lakedaemon.net,
	robert.richter@caviumnetworks.com, shijie.huang@arm.com,
	Suravee.Suthikulpanit@amd.com, hanjun.guo@linaro.org,
	al.stone@linaro.org, mw@semihalf.com, graeme.gregory@linaro.org,
	Catalin.Marinas@arm.com, will.deacon@arm.com,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, ddaney.cavm@gmail.com,
	okaya@codeaurora.org, andrea.gallo@linaro.org,
	linux-pci@vger.kernel.org
From: Tomasz Nowicki <tn@semihalf.com>
Message-ID: <57612108.4050407@semihalf.com>
Date: Wed, 15 Jun 2016 11:34:00 +0200
MIME-Version: 1.0
In-Reply-To: <20160615100919.6b507b57@arm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 15.06.2016 11:09, Marc Zyngier wrote:
> On Mon, 13 Jun 2016 16:41:06 +0200
> Tomasz Nowicki <tn@semihalf.com> wrote:
>
>> The series builds the PCI/MSI domain stack based on initial IORT driver
>> which is added in first place. As a reference please see IORT spec:
>> http://infocenter.arm.com/help/topic/com.arm.doc.den0049b/DEN0049B_IO_Remapping_Table.pdf
>>
>> Patches were built on top of accepted ARM64 ACPI PCI support and can be found
>> all together here:
>> https://github.com/semihalf-nowicki-tomasz/linux.git (its-acpi-v6)
>>
>> Tested on Cavium ThunderX server.
>>
>> v5 -> v6
>> - added locking mechanism for IORT list with domain token
>> - IORT function name improvements
>> - extended IORT RID mapping helper
>> - reworked IORT to be more SMMU friendly
>> - IORT functions which map RID and find corresponding domain are not
>>    PCI specific any more (struct pci_dev -> struct device)
>> - bug fixes
>>
>> v4 -> v5
>> - rebased against v4.7-rc1
>> - drop generic layer and call IORT functions directly
>> - improve resource abstraction and string formatting
>>
>> v3 -> v4
>> - rebased against v4.5
>> - add ACPI support for IRQ domain handling on a per-device basis
>> - reorder domain setup step
>> - improve error handling
>> - code style improvements
>>
>> v2 -> v3
>> - rebased on top of 4.4
>> - fixes and improvements for redistributor init via GICC structures
>> - fixes as per kbuild reports
>>
>> v1 -> v2
>> - rebased on top of 4.4-rc4
>> - use pci_msi_domain_get_msi_rid for requester ID to device ID translation
>>
>> Tomasz Nowicki (7):
>>    ACPI: I/O Remapping Table (IORT) initial support
>>    PCI/MSI: Setup MSI domain on a per-devices basis using IORT ACPI table
>>    irqchip/gicv3-its: Cleanup for ITS domain initialization
>>    irqchip/gicv3-its: Refator ITS DT init code to prepare for ACPI
>>    irqchip/gicv3-its: Probe ITS in the ACPI way
>>    irqchip/gicv3-its: Factor out code that might be reused for ACPI
>>    irqchip/gicv3-its: Use MADT ITS subtable to do PCI/MSI domain
>>      initialization
>>
>>   drivers/acpi/Kconfig                     |   3 +
>>   drivers/acpi/Makefile                    |   1 +
>>   drivers/acpi/iort.c                      | 386 +++++++++++++++++++++++++++++++
>>   drivers/irqchip/Kconfig                  |   1 +
>>   drivers/irqchip/irq-gic-v3-its-pci-msi.c |  88 +++++--
>>   drivers/irqchip/irq-gic-v3-its.c         | 185 ++++++++++-----
>>   drivers/irqchip/irq-gic-v3.c             |   7 +-
>>   drivers/pci/msi.c                        |  11 +-
>>   include/linux/iort.h                     |  38 +++
>>   include/linux/irqchip/arm-gic-v3.h       |   4 +-
>>   10 files changed, 646 insertions(+), 78 deletions(-)
>>   create mode 100644 drivers/acpi/iort.c
>>   create mode 100644 include/linux/iort.h
>>
>
>
> Once you've addressed the couple of remarks I had, and unless someone
> has further objections, this should be in a sane state.

Thanks for having a look !

>
> Of course, the following question would be "who merges this thing". I'm
> happy to take it (mostly because it makes my life easier on the ITS
> side), but it needs to be Acked by the usual suspects (Rafael, Bjorn,
> Lorenzo).
>

As for me, I am fine you to merge it.

Bjorn, Rafael, Lorenzo,

Can you please check on respective patches? Thanks in advance.

Tomasz
