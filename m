Return-Path: <linux-acpi-owner@vger.kernel.org>
Message-ID: <53C5EB19.7060104@linux.intel.com>
Date: Wed, 16 Jul 2014 11:01:45 +0800
From: Jiang Liu <jiang.liu@linux.intel.com>
MIME-Version: 1.0
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Yinghai Lu <yinghai@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Tony Luck <tony.luck@intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	x86@kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [Patch V3 00/16] Enable support of IOAPIC hotplug on x86 platforms
References: <1403685648-10103-1-git-send-email-jiang.liu@linux.intel.com> <20140714172642.GA12920@laptop.dumpdata.com> <20140714194133.GA22857@laptop.dumpdata.com> <53C54876.5090606@linux.intel.com> <20140715161035.GA8097@laptop.dumpdata.com>
In-Reply-To: <20140715161035.GA8097@laptop.dumpdata.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Konrad,
	We have found the root cause with your great support. If BIOS
assigns an IRQ number for a PCI device, acpi_pci_irq_enable() fails to
assign IOAPIC IRQ then due to the check:
        if (dev->irq > 0)
                return 0;
	For a quick workaround, just comment out above check. But we
need some time to figure out a clean fixup for it. We will send out new
version once it gets resolved.
	Thanks for your great help again.
Regards!
Gerry
On 2014/7/16 0:10, Konrad Rzeszutek Wilk wrote:
> already assigned IRQ
