Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Thu, 12 Jun 2014 12:58:37 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Jiang Liu <jiang.liu@linux.intel.com>
cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Grant Likely <grant.likely@linaro.org>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Yinghai Lu <yinghai@kernel.org>, x86@kernel.org,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Tony Luck <tony.luck@intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	Paul Gortmaker <paul.gortmaker@windriver.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>
Subject: Re: [Patch V4 12/42] x86, ioapic: kill static variable nr_irqs_gsi
In-Reply-To: <53969834.3040404@linux.intel.com>
Message-ID: <alpine.DEB.2.10.1406121256090.5170@nanos>
References: <1402302011-23642-1-git-send-email-jiang.liu@linux.intel.com> <1402302011-23642-13-git-send-email-jiang.liu@linux.intel.com> <alpine.DEB.2.10.1406100121090.3830@nanos> <53969834.3040404@linux.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, 10 Jun 2014, Jiang Liu wrote:

> Hi Thomas,
> 	This piece of code is inherited from current IOAPIC driver
> and I think it's a workaround for some weird platforms.
> 	For normal platforms with both 8259A and IOAPIC controllers,
> legacy ISA IRQs should be connected to both 8259A and IOAPIC pins
> (ignore timer and cascade IRQs for simplicity). According to comments
>  in current kernel, there are some platforms on which:
> 1) some ISA IRQs are only connected to 8259A controllers.
> 2) the corresponding IOAPIC pins are connected to some non-ISA IRQs.
> 	For such platforms, IRQ0-15 are used for ISA IRQs and another
> 16 IRQs just above gsi_top are reserved for IOAPIC pins 0-15 which
> are connected to non-ISA IRQs.
> 	I have no real experience with such a platform, but just
> guessing possible cases according to kernel comments and "Multiple
> Processor Specification". Please look at these two pictures for quick
> reference.
> http://www.manualslib.com/manual/77733/Intel-Multiprocessor.html?page=31#manual
> http://www.manualslib.com/manual/77733/Intel-Multiprocessor.html?page=63#manual

Duh. I completely forgot about the 82489 mess.

We probably want a comment somewhere why we have this gsi + legacy
thing.

Thanks,

	tglx
