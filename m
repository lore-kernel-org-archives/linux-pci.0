Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Tue, 20 May 2014 08:35:35 +0900 (JST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Jiang Liu <jiang.liu@linux.intel.com>
cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
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
	x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
	linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
	sfi-devel@simplefirmware.org,
	Grant Likely <grant.likely@linaro.org>
Subject: Re: [RFC Patch Part1 V1 00/30] use irqdomain to dynamically allocate
 IRQ for IOAPIC pin
In-Reply-To: <alpine.DEB.2.02.1405192250170.22305@ionos.tec.linutronix.de>
Message-ID: <alpine.DEB.2.02.1405200823300.5204@ionos.tec.linutronix.de>
References: <1400227550-5935-1-git-send-email-jiang.liu@linux.intel.com> <alpine.DEB.2.02.1405161601060.4039@ionos.tec.linutronix.de> <53787F09.9000200@linux.intel.com> <alpine.DEB.2.02.1405192250170.22305@ionos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Jiang,

On Mon, 19 May 2014, Thomas Gleixner wrote:
> > We may build hierarchy irqdomains as below for x86,
> > [IOAPIC]      [MSI/MSI-x]  [HPET]  [DMAR] [Legacy]
> >     |            |           |       |       |
> >     v            v           v       |       |
> > [           Remapping           ]    |       |
> >                  |                   |       |
> >                  v                   v       v
> > [                   Root/vector                ]
> > 
> > For x86, irq_alloc_info_t structure will be used to host CPU mask,
> > device pointer, IOAPIC pin attributes, NUMA node info etc.
> 
> Do we really need to hand all of this down?

having recovered from a 24hr travel, I think we really only need to
hand down cpumask.

If you want to allocate a vector, all the vector domain needs to know
is the cpumask and the number of consecutive vectors you want to
allocate.

The IOAPIC pin attribute is only interesting inside the ioapic domain,
there is no need to have it elsewhere.

Numa node is encoded in the cpumask, IOW the node info selects only
bits for that node in the mask.

Same for the device. It's only relevant for setting up MSI[x] or
legacy PCI interrupts. But the underlying vector domain does not care
at all about it.

Thanks,

	tglx
