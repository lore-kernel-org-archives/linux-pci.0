Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 27 Feb 2014 12:36:27 -0700
From: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
To: Liviu Dudau <Liviu.Dudau@arm.com>,
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
Message-ID: <20140227193627.GA7773@obsidianresearch.com>
References: <1393506402-11474-1-git-send-email-Liviu.Dudau@arm.com>
 <1393506402-11474-2-git-send-email-Liviu.Dudau@arm.com>
 <20140227181951.GC24656@obsidianresearch.com>
 <20140227191259.GA31753@bart.dudau.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140227191259.GA31753@bart.dudau.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Feb 27, 2014 at 07:12:59PM +0000, Liviu Dudau wrote:
> The outstanding issue is how to fix pci_address_to_pio() as it will not
> for for range->cpu_addr > IO_SPACE_LIMIT (16MB in my case).

The default actually looks fine to me, it is the correct behavior for
systems that actually have a dedicated IO space (like x86) where the
'CPU' value for IO is the exact value used in the IO accessor
instructions. In this case the IO_SPACE_LIMIT test is appropriate.

It also looks correct for architectures that use the CPU MMIO address
as the IO address directly (where IO_SPACE_LIMIT would be 4G)

Architectures that use the virtual IO window technique will always
require a custom pci_address_to_pio implementation.

BTW, something that occured to me after reading the patches:

For ARM64 you might want to think about doing away with the fixed
virtual IO window like we see in ARM32. Just use the CPU MMIO address
directly within the kernel, and implement a ioport_map to setup the MM
on demand.

I think the legacy reasons for having all those layers of translation
are probably not applicable to ARM64, and it is much simpler without
the extra translation step....

Arnd, what do you think?

Jason
