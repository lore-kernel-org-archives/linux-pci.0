Return-Path: <linux-acpi-owner@vger.kernel.org>
Message-ID: <53E10136.9000505@linux.intel.com>
Date: Wed, 06 Aug 2014 00:07:18 +0800
From: Jiang Liu <jiang.liu@linux.intel.com>
MIME-Version: 1.0
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	xen-devel@lists.xenproject.org
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Yinghai Lu <yinghai@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Grant Likely <grant.likely@linaro.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Tony Luck <tony.luck@intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	x86@kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [Bugfix 0/2] Fix bugs caused by "use irqdomain to dynamically
 allocate IRQ for IOAPIC"
References: <1407209178-18644-1-git-send-email-jiang.liu@linux.intel.com> <20140805130448.GA13057@laptop.dumpdata.com>
In-Reply-To: <20140805130448.GA13057@laptop.dumpdata.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On 2014/8/5 21:04, Konrad Rzeszutek Wilk wrote:
> On Tue, Aug 05, 2014 at 11:26:16AM +0800, Jiang Liu wrote:
>> Two issues have been reported against patch set "use irqdomain to
>> dynamically allocate IRQ for IOAPIC" at https://lkml.org/lkml/2014/6/9/44.
>>
>> This first one causes failure of suspend/hibernation, please refer to
>> https://lkml.org/lkml/2014/7/28/822 for more information. And we have
>> worked out a patch to fix it (https://lkml.org/lkml/2014/7/30/725) and
>> Borislav has tested it. But with more testing and analysis, I found the
>> provided patch still has some issues:
>> 1) It may cause regression to Xen
> 
> Could you elaborate please?
> 
> Is there a git tree with all of these patches to test it?
Hi Konrad,
	The patch at https://lkml.org/lkml/2014/7/30/725 skips invoking
xen_pcifront_enable_irq() on resume from suspend or restore from
hibernation. I'm not sure whether that will affect suspend/hibernation
with Xen. This patch series won't affect Xen anymore.
	I have prepared a tree for you at
https://github.com/jiangliu/linux.git suspend

Thanks for help!
Gerry

>> 2) Flag dev->dev.power.is_prepared has already been cleared when
>>    pcibios_enable_device() gets called, so it will cause IOAPIC pin
>>    reference count leak.
>>
>> So I reworked the patch to fix above issues. The first patch fixes issue
>> 1 by moving check of dev->dev.power.is_prepared pcibios_enable_irq, so
>> it won't affect Xen. The second patch fixes the IOAPIC pin reference
>> count leakage issue. It also solves the issue we have discussed at
>> http://www.spinics.net/lists/linux-pci/msg32902.html
>>
>> Regards!
>> Gerry
>>
>> Jiang Liu (2):
>>   x86, irq, PCI: Keep IRQ assignment for PCI devices during
>>     suspend/hibernation
>>   x86, irq: Keep balance of IOAPIC pin reference count
>>
>>  arch/x86/pci/intel_mid_pci.c |    9 ++++++++-
>>  arch/x86/pci/irq.c           |    8 +++++++-
>>  drivers/acpi/pci_irq.c       |   15 +++++++++++++--
>>  include/linux/pci.h          |    1 +
>>  4 files changed, 29 insertions(+), 4 deletions(-)
>>
>> -- 
>> 1.7.10.4
>>
