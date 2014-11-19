Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Arnd Bergmann <arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
Cc: Tomasz Nowicki <tomasz.nowicki@linaro.org>,
	catalin.marinas@arm.com, will.deacon@arm.com, bhelgaas@google.com,
	lorenzo.pieralisi@arm.com, wangyijing@huawei.com,
	hanjun.guo@linaro.org, Liviu.Dudau@arm.com, tglx@linutronix.de,
	mingo@redhat.com, hpa@zytor.com, rjw@rjwysocki.net,
	linaro-acpi@lists.linaro.org, linux-pci@vger.kernel.org,
	x86@kernel.org, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: Re: [PATCH 6/6] pci, acpi: Share ACPI PCI config space accessors.
Date: Wed, 19 Nov 2014 17:19:20 +0100
Message-ID: <2360791.Aj7tQ0nCJ3@wuerfel>
In-Reply-To: <1416413091-13452-7-git-send-email-tomasz.nowicki@linaro.org>
References: <1416413091-13452-1-git-send-email-tomasz.nowicki@linaro.org> <1416413091-13452-7-git-send-email-tomasz.nowicki@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday 19 November 2014 17:04:51 Tomasz Nowicki wrote:
> +/*
> + * raw_pci_read/write - ACPI PCI config space accessors.
> + *
> + * ACPI spec defines MMCFG as the way we can access PCI config space,
> + * so let MMCFG be default (__weak).
> + *
> + * If platform needs more fancy stuff, should provides its own implementation.
> + */
> +int __weak raw_pci_read(unsigned int domain, unsigned int bus,
> +                       unsigned int devfn, int reg, int len, u32 *val)
> +{
> +       return pci_mmcfg_read(domain, bus, devfn, reg, len, val);
> +}
> +
> +int __weak raw_pci_write(unsigned int domain, unsigned int bus,
> +                        unsigned int devfn, int reg, int len, u32 val)
> +{
> +       return pci_mmcfg_write(domain, bus, devfn, reg, len, val);
> +}
> +
> 

I think it would be better to avoid __weak functions here, as they tend
to be hard to follow when trying to understand the code.

How about using a Kconfig symbol like this:

#ifdef CONFIG_ARCH_RAW_PCI_READWRITE
int raw_pci_read(unsigned int domain, unsigned int bus, unsigned int devfn,
                 int reg, int len, u32 *val);
int raw_pci_write(unsigned int domain, unsigned int bus, unsigned int devfn,
                  int reg, int len, u32 val);
#else
static inline int raw_pci_read(unsigned int domain, unsigned int bus,
	                       unsigned int devfn, int reg, int len, u32 *val)
{
	return pci_mmcfg_read(domain, bus, devfn, reg, len, val);
}

static inline int raw_pci_write(unsigned int domain, unsigned int bus,
             		                unsigned int devfn, int reg, int len, u32 val)
{
       return pci_mmcfg_write(domain, bus, devfn, reg, len, val);
}
#endif

Same thing for the weak symbols in patch 5.

	Arnd
