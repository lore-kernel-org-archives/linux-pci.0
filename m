Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Sat, 1 Nov 2014 19:59:39 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Jiang Liu <jiang.liu@linux.intel.com>
cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Yinghai Lu <yinghai@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
	x86@kernel.org, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Tony Luck <tony.luck@intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [Patch v7 14/18] x86, irq, ACPI: Introduce a rwsem to protect
 IOAPIC operations from hotplug
In-Reply-To: <1414387308-27148-15-git-send-email-jiang.liu@linux.intel.com>
Message-ID: <alpine.DEB.2.11.1411011949370.5308@nanos>
References: <1414387308-27148-1-git-send-email-jiang.liu@linux.intel.com> <1414387308-27148-15-git-send-email-jiang.liu@linux.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, 27 Oct 2014, Jiang Liu wrote:
> We are going to support ACPI based IOAPIC hotplug, so introduce a rwsem
> to protect IOAPIC data structures from IOAPIC hotplug. We choose to
> serialize in ACPI instead of in the IOAPIC core because:
> 1) currently we are only plan to support ACPI based IOAPIC hotplug
> 2) it's much more cleaner and easier
> 3) It does't affect IOAPIC discovered by devicetree, SFI and mpparse.

I had a last intensive look at this series as I was about to merge
it. So I looked at the locking rules here again
 
> +/*
> + * Locks related to IOAPIC hotplug
> + * Hotplug side:
> + * 	->lock_device_hotplug()	//device_hotplug_lock
> + *		->acpi_ioapic_rwsem
> + *			->ioapic_lock
> + * Interrupt mapping side:
> + *	->acpi_ioapic_rwsem
> + *		->ioapic_mutex
> + *			->ioapic_lock
> + */

This looks sane, but I cannot figure out at all why this needs to be a
rwsem.

> +static DECLARE_RWSEM(acpi_ioapic_rwsem);

I think it should be a simple mutex because the rwsem does not protect
against concurrent execution what taken for read.

And the site which takes it for write is in the early boot process
where nothing runs in parallel AFAICT.

Thanks,

	tglx
