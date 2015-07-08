Return-Path: <linux-acpi-owner@vger.kernel.org>
Message-ID: <559CD1CF.3030601@linux.intel.com>
Date: Wed, 08 Jul 2015 15:31:27 +0800
From: Jiang Liu <jiang.liu@linux.intel.com>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>
CC: Thomas Gleixner <tglx@linutronix.de>,
	"Rafael J . Wysocki" <rjw@rjwysocki.net>,
	LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, "x86 @ kernel . org" <x86@kernel.org>
Subject: Re: [Patch v3 0/4] Introduce a mechanism to allocate PCI IRQ on demand
References: <1433926501-22956-1-git-send-email-jiang.liu@linux.intel.com> <20150619161001.GJ7710@google.com>
In-Reply-To: <20150619161001.GJ7710@google.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2015/6/20 0:10, Bjorn Helgaas wrote:
> On Wed, Jun 10, 2015 at 04:54:57PM +0800, Jiang Liu wrote:
>> Hi Bjorn,
>> 	I have verified that this patch set could be applied to the
>> mainstream kernel without dependency on other patches, so could you
>> please help to merge it?
> 
> I already acked these and said I was willing to merge them and that I was
> hoping for an ack from Thomas.
> 
> Any thoughts, Thomas?

Hi Thomas,
	Any comments about this bugfix series?
Thanks!
Gerry

> 
>> This patch set introduces a mechanism to allocate PCI IRQ on demand and
>> free it when not used anymore by hooking pci_device_probe() and
>> pci_device_remove().
>>
>> It will be used to track IOAPIC pin usage on x86 so we could support
>> IOAPIC hot-removal.
>>
>> The patch set passes Fengguang's 0day test suite.
>>
>> V2->V3:
>> 1) Change the default pcibios_alloc_irq() to always return 0, as
>>    suggested by Bjorn.
>> 2) Refine comments.
>>
>> V1->V2:
>> 1) Refine pci_device_probe() to optimize for mainline code as suggested
>>    by Bjorn
>> 2) Reorder patch set to put optional patch as the last (Patch 4)
>>
>>
>> Jiang Liu (4):
>>   PCI: Add hooks to allocate/free IRQ resources when binding/unbinding
>>     driver
>>   PCI, x86: Allocate PCI IRQ on demand and free it when not used
>>     anymore
>>   PCI: Add helpers to manage pci_dev->irq and pci_dev->irq_managed
>>   PCI, MSI: Free legacy PCI IRQ when enabling MSI/MSI-X
>>
>>  arch/x86/include/asm/pci_x86.h |    2 --
>>  arch/x86/pci/common.c          |   20 +++++++++-----------
>>  arch/x86/pci/intel_mid_pci.c   |    9 ++++++---
>>  arch/x86/pci/irq.c             |   23 ++++-------------------
>>  drivers/acpi/pci_irq.c         |   17 ++++-------------
>>  drivers/pci/msi.c              |    6 +++++-
>>  drivers/pci/pci-driver.c       |   26 ++++++++++++++++++++------
>>  include/linux/pci.h            |   19 +++++++++++++++++++
>>  8 files changed, 67 insertions(+), 55 deletions(-)
>>
>> -- 
>> 1.7.10.4
>>
