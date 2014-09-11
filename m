Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Thu, 11 Sep 2014 10:23:36 +0200 (CEST)
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
	Grant Likely <grant.likely@linaro.org>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Tony Luck <tony.luck@intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	x86@kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [Patch v5 04/15] ACPI: Add interfaces to parse IOAPIC ID for
 IOAPIC hotplug
In-Reply-To: <1410422758-24942-5-git-send-email-jiang.liu@linux.intel.com>
Message-ID: <alpine.DEB.2.10.1409111021110.4178@nanos>
References: <1410422758-24942-1-git-send-email-jiang.liu@linux.intel.com> <1410422758-24942-5-git-send-email-jiang.liu@linux.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, 11 Sep 2014, Jiang Liu wrote:
> +
> +#ifdef CONFIG_ACPI_HOTPLUG_IOAPIC
> +static int map_ioapic_id(struct acpi_subtable_header *entry, u32 gsi_base,
> +			 u64 *phys_addr, int *ioapic_id)

I find these function names map_* quite confusing. All they do is a
lookup, right?

> +/**
> + * acpi_get_ioapic_id() - Get IOAPIC ID and physical address matching @gsi_base
> + * @handle ACPI object for IOAPIC device

Proper docbook formatting is:

 * acpi_get_ioapic_id - Get ....
 * @handle:	 ACPI object     

Thanks,

	tglx
