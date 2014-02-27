Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 27 Feb 2014 19:12:59 +0000
From: Liviu Dudau <liviu@dudau.co.uk>
To: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Cc: Liviu Dudau <Liviu.Dudau@arm.com>,
	linux-pci <linux-pci@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Catalin Marinas <Catalin.Marinas@arm.com>,
	Will Deacon <Will.Deacon@arm.com>,
	linaro-kernel <linaro-kernel@lists.linaro.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	LAKML <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 1/4] pci: OF: Fix the conversion of IO ranges into IO
 resources.
Message-ID: <20140227191259.GA31753@bart.dudau.co.uk>
References: <1393506402-11474-1-git-send-email-Liviu.Dudau@arm.com>
 <1393506402-11474-2-git-send-email-Liviu.Dudau@arm.com>
 <20140227181951.GC24656@obsidianresearch.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20140227181951.GC24656@obsidianresearch.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Feb 27, 2014 at 11:19:51AM -0700, Jason Gunthorpe wrote:
> On Thu, Feb 27, 2014 at 01:06:39PM +0000, Liviu Dudau wrote:
> > +	if (res->flags & IORESOURCE_IO) {
> > +		unsigned long port;
> > +		port = pci_address_to_pio(range->pci_addr);
> 
> This looks very suspicious, pci_addr is not unique across all domains,
> so there is no way to convert from a pci_addr to the virtual IO
> address without knowing the domain number as well.
> 
> I would like to see it be:
>   port = pci_address_to_pio(range->cpu_addr);
> 
> cpu_addr is unique across all domains.

Jason,

First thanks for reviewing the updated series.

We have agreed early on that indeed using range->cpu_addr is the correct aproach
and me taking the lazy shortcut of using range->pci_addr because of the broken
default implementation of pci_address_to_pio is wrong. I will fix this for v3.

The outstanding issue is how to fix pci_address_to_pio() as it will not
for for range->cpu_addr > IO_SPACE_LIMIT (16MB in my case).

Best regards,
Liviu

> 
> Looking at the microblaze and PPC versions I think the above version
> is actually correct (assuming io_base_phys is the CPU address of the
> IO window)
> 
> Jason
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

