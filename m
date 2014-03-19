Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Arnd Bergmann <arnd@arndb.de>
To: linaro-kernel@lists.linaro.org
Cc: Rob Herring <robherring2@gmail.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	linux-pci <linux-pci@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Will Deacon <Will.Deacon@arm.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	LKML <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	LAKML <linux-arm-kernel@lists.infradead.org>,
	Tanmay Inamdar <tinamdar@apm.com>,
	Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH v7 3/3] arm64: Add architecture support for PCI
Date: Wed, 19 Mar 2014 19:36:10 +0100
Message-ID: <14992874.y2jPSm88bi@wuerfel>
In-Reply-To: <CAL_JsqJCa6kz8H_W7vz4YW5eOrOZ43kwxQq9Uh-M0qpCtW_pQQ@mail.gmail.com>
References: <1394811258-1500-1-git-send-email-Liviu.Dudau@arm.com> <20140319172140.GA16328@e106497-lin.cambridge.arm.com> <CAL_JsqJCa6kz8H_W7vz4YW5eOrOZ43kwxQq9Uh-M0qpCtW_pQQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday 19 March 2014 12:53:11 Rob Herring wrote:
> I've successfully used the preceeding series on ARM converting the
> Versatile PCI support to use it. The main part of the process was just
> copying this arm64 code to arm which tells me the code is in the wrong
> place. There are still some differences in pcibios_fixup_bus, and it
> is not clear to me whether the arm version should be doing all the
> things the arm64 version does and vice-versa. Certainly that should be
> sorted out. The other issues I see is pci_ioremap_io still has to be
> called by the driver and is not aligned at least for the prototype as
> I pointed out. Seems all these issues could be fixed with a simple
> CONFIG_ARCH_HAS_MMIO_IOSPACE kconfig option.

I don't even think we need a CONFIG option: Any architecture that wants
to provide pci_ioremap_io (or whatever we end up calling the new version)
needs to pass the virtual base address to the common code, and the
easiest way to do that is using a macro  (e.g. PCI_IO_VIRT_BASE).

What I think we should end up with is a generic implementation like

/* 
 * architectures with special needs may provide their own version,
 * but most should be able to use this one.
 */
unsigned long __weak pci_ioremap_iospace(struct resource *bus, unsigned long cpu)
{
#ifdef PCI_IO_VIRT_BASE
	/* find free space, ioremap the bus address, return the offset */
	...
#endif

	/* this architecture doesn't have memory mapped I/O space,
	   so this function should never be called */
	WARN_ON(1);
	return -ENODEV;
}

	Arnd
