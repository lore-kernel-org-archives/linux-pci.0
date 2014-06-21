Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Sat, 21 Jun 2014 23:08:12 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Jiang Liu <jiang.liu@linux.intel.com>
cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Grant Likely <grant.likely@linaro.org>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Yinghai Lu <yinghai@kernel.org>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Tony Luck <tony.luck@intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	Paul Gortmaker <paul.gortmaker@windriver.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	x86@kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [Patch V4 00/42] use irqdomain to dynamically allocate IRQ for
 IOAPIC
In-Reply-To: <1402302011-23642-1-git-send-email-jiang.liu@linux.intel.com>
Message-ID: <alpine.DEB.2.10.1406212306540.5170@nanos>
References: <1402302011-23642-1-git-send-email-jiang.liu@linux.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Jiang,

On Mon, 9 Jun 2014, Jiang Liu wrote:

> On x86 platforms, IRQ number are statically allocated to IOAPIC pins at boot.
> There are two issues with this design. First it causes trouble to IOAPIC
> hotplug because we need to allocate a block of IRQ numbers for each IOAPIC.
> Second it may waste IRQ nubmers even if some IOAPIC pins are not used because
> IRQ numbers are statically assigned.
> 
> This patchset tries to enable dynamic IRQ number allocation for IOAPIC
> by adopting the irqdomain framework, it solves the two issues mentioned
> above. It also simplifies the IOAPIC driver by consolidating ways to
> program IOAPIC pins with the irqdomain map interface.
> 
> We will enhance the IOAPIC driver core to support ACPI based IOAPIC hotplug
> once the IOAPIC driver has been converted to irqdomain.

I merged the whole lot. Thanks for doing this and reacting on all the
review comments. Very nice cleanup work!

Thanks,

	tglx


