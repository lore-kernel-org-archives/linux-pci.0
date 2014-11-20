Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Thu, 20 Nov 2014 15:26:50 -0700
From: Bjorn Helgaas <bhelgaas@google.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org,
	Tomasz Nowicki <tomasz.nowicki@linaro.org>,
	catalin.marinas@arm.com, will.deacon@arm.com,
	lorenzo.pieralisi@arm.com, wangyijing@huawei.com,
	hanjun.guo@linaro.org, Liviu.Dudau@arm.com, tglx@linutronix.de,
	mingo@redhat.com, hpa@zytor.com, rjw@rjwysocki.net,
	linaro-acpi@lists.linaro.org, linux-pci@vger.kernel.org,
	x86@kernel.org, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: Re: [PATCH 6/6] pci, acpi: Share ACPI PCI config space accessors.
Message-ID: <20141120222650.GC7987@google.com>
References: <1416413091-13452-1-git-send-email-tomasz.nowicki@linaro.org>
 <1416413091-13452-7-git-send-email-tomasz.nowicki@linaro.org>
 <2360791.Aj7tQ0nCJ3@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <2360791.Aj7tQ0nCJ3@wuerfel>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Nov 19, 2014 at 05:19:20PM +0100, Arnd Bergmann wrote:
> On Wednesday 19 November 2014 17:04:51 Tomasz Nowicki wrote:
> > +/*
> > + * raw_pci_read/write - ACPI PCI config space accessors.
> > + *
> > + * ACPI spec defines MMCFG as the way we can access PCI config space,
> > + * so let MMCFG be default (__weak).
> > + *
> > + * If platform needs more fancy stuff, should provides its own implementation.
> > + */
> > +int __weak raw_pci_read(unsigned int domain, unsigned int bus,
> > +                       unsigned int devfn, int reg, int len, u32 *val)
> > +{
> > +       return pci_mmcfg_read(domain, bus, devfn, reg, len, val);
> > +}
> > +
> > +int __weak raw_pci_write(unsigned int domain, unsigned int bus,
> > +                        unsigned int devfn, int reg, int len, u32 val)
> > +{
> > +       return pci_mmcfg_write(domain, bus, devfn, reg, len, val);
> > +}
> > +
> > 
> 
> I think it would be better to avoid __weak functions here, as they tend
> to be hard to follow when trying to understand the code.

That's interesting.  I would have said exactly the opposite -- I think the
extra Kconfiggery is harder to follow than weak/strong functions :)

But consistency is better than my personal opinion.  Is there a consensus
that we should use the Kconfig strategy instead of __weak?

> How about using a Kconfig symbol like this:
> 
> #ifdef CONFIG_ARCH_RAW_PCI_READWRITE
> int raw_pci_read(unsigned int domain, unsigned int bus, unsigned int devfn,
>                  int reg, int len, u32 *val);
> int raw_pci_write(unsigned int domain, unsigned int bus, unsigned int devfn,
>                   int reg, int len, u32 val);
> #else
> static inline int raw_pci_read(unsigned int domain, unsigned int bus,
> 	                       unsigned int devfn, int reg, int len, u32 *val)
> {
> 	return pci_mmcfg_read(domain, bus, devfn, reg, len, val);
> }
> 
> static inline int raw_pci_write(unsigned int domain, unsigned int bus,
>              		                unsigned int devfn, int reg, int len, u32 val)
> {
>        return pci_mmcfg_write(domain, bus, devfn, reg, len, val);
> }
> #endif
