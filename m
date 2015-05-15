Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Fri, 15 May 2015 23:02:59 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Jiang Liu <jiang.liu@linux.intel.com>
cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lv Zheng <lv.zheng@intel.com>,
	LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, "x86 @ kernel . org" <x86@kernel.org>
Subject: Re: [RFC 2/4] PCI, MSI: Optionally free legacy PCI IRQ when enabling
 MSI/MSI-X
In-Reply-To: <1430968374-29286-3-git-send-email-jiang.liu@linux.intel.com>
Message-ID: <alpine.DEB.2.11.1505152259480.4225@nanos>
References: <1430968374-29286-1-git-send-email-jiang.liu@linux.intel.com> <1430968374-29286-3-git-send-email-jiang.liu@linux.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, 7 May 2015, Jiang Liu wrote:

> Once PCI MSI/MSI-X is enabled by the device driver, PCI device won't
> make use of legacy PCI IRQ until PCI MSI/MSI-X is disabled again.
> So optionally free legacy PCI IRQ when enabling MSI/MSI-X and reallocate
> when disabling MSI/MSI-X.

This is a bit odd. With your proposed change we'll have:

     alloc_legacy_irq()

     msi[x]_enable()
	free_legacy_irq()

     msi[x]_disable()
	alloc_legacy_irq()

And after that we shut down the device which will free the legacy irq
again.

Shouldn't we allocate the legacy irq only if we really need it?

Thanks,

	tglx
