Return-Path: <linux-acpi-owner@vger.kernel.org>
Message-ID: <555BFA31.5040206@linux.intel.com>
Date: Wed, 20 May 2015 11:06:25 +0800
From: Jiang Liu <jiang.liu@linux.intel.com>
MIME-Version: 1.0
To: Thomas Gleixner <tglx@linutronix.de>
CC: "Rafael J . Wysocki" <rjw@rjwysocki.net>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lv Zheng <lv.zheng@intel.com>,
	LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, "x86 @ kernel . org" <x86@kernel.org>
Subject: Re: [RFC 2/4] PCI, MSI: Optionally free legacy PCI IRQ when enabling
 MSI/MSI-X
References: <1430968374-29286-1-git-send-email-jiang.liu@linux.intel.com> <1430968374-29286-3-git-send-email-jiang.liu@linux.intel.com> <alpine.DEB.2.11.1505152259480.4225@nanos>
In-Reply-To: <alpine.DEB.2.11.1505152259480.4225@nanos>
Content-Type: text/plain; charset=windows-1252
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2015/5/16 5:02, Thomas Gleixner wrote:
> On Thu, 7 May 2015, Jiang Liu wrote:
> 
>> Once PCI MSI/MSI-X is enabled by the device driver, PCI device won't
>> make use of legacy PCI IRQ until PCI MSI/MSI-X is disabled again.
>> So optionally free legacy PCI IRQ when enabling MSI/MSI-X and reallocate
>> when disabling MSI/MSI-X.
> 
> This is a bit odd. With your proposed change we'll have:
> 
>      alloc_legacy_irq()
> 
>      msi[x]_enable()
> 	free_legacy_irq()
> 
>      msi[x]_disable()
> 	alloc_legacy_irq()
Hi Thomas,
	It's for safety. I'm not sure whether the device driver will
make use of legacy IRQ after calling msi[x]_disable(). I have concerns
about following pattern in PCI device drivers:
---------------------------------------------------
if (enable_msi() == SUCCESS) {
	if (allocate_resource_for_msi() == SUCCESS)
		return;
	disable_msi();
}
use_legacy_irq()

Thanks!
Gerry

> 
> And after that we shut down the device which will free the legacy irq
> again.
> 
> Shouldn't we allocate the legacy irq only if we really need it?
> 
> Thanks,
> 
> 	tglx
> 
