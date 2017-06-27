Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:45352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753774AbdF0VL4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 27 Jun 2017 17:11:56 -0400
Date: Tue, 27 Jun 2017 16:11:52 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Peter Anvin <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>, linux-pci@vger.kernel.org
Subject: Re: [patch 4/7] PCI: Provide Kconfig option for lockless config
 space accessors
Message-ID: <20170627211152.GE764@bhelgaas-glaptop.roam.corp.google.com>
References: <20170316215002.726697858@linutronix.de>
 <20170316215057.205961140@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170316215057.205961140@linutronix.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc linux-pci]

On Thu, Mar 16, 2017 at 10:50:06PM +0100, Thomas Gleixner wrote:
> The generic pci configuration space accessors are globally serialized via
> pci_lock. On larger systems this causes massive lock contention when the
> configuration space has to be accessed frequently. One such access pattern
> is the Intel Uncore performance counter unit.

s/pci/PCI/ above.

> Provide a kernel config option which can be selected by an architecture
> when the low level PCI configuration space accessors in the architecture
> use their own serialization or can operate completely lockless.

The arch/x86/pci/common.c comment:

  /*
   * This interrupt-safe spinlock protects all accesses to PCI
   * configuration space.
   */
  DEFINE_RAW_SPINLOCK(pci_config_lock);

is no longer quite correct.

I think the raw_pci_read() and raw_pci_write() implementations are
such that we use the old locked accessors for the first 256 bytes,
even when ECAM is available.  Not necessarily a problem, just an
observation.  I guess the uncore PMU registers are in the extended
config space.

> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  drivers/pci/Kconfig  |    3 +++
>  drivers/pci/access.c |   16 ++++++++++++----
>  2 files changed, 15 insertions(+), 4 deletions(-)
> 
> --- a/drivers/pci/Kconfig
> +++ b/drivers/pci/Kconfig
> @@ -86,6 +86,9 @@ config PCI_ATS
>  config PCI_ECAM
>  	bool
>  
> +config PCI_LOCKLESS_CONFIG
> +	bool

It's conceivable that this could be a per-host bridge property, but
not worth worrying about for now.

>  config PCI_IOV
>  	bool "PCI IOV support"
>  	depends on PCI
> --- a/drivers/pci/access.c
> +++ b/drivers/pci/access.c
> @@ -25,6 +25,14 @@ DEFINE_RAW_SPINLOCK(pci_lock);
>  #define PCI_word_BAD (pos & 1)
>  #define PCI_dword_BAD (pos & 3)
>  
> +#ifdef CONFIG_PCI_LOCKLESS_CONFIG
> +# define pci_lock_config(f)	do { (void)(f); } while (0)
> +# define pci_unlock_config(f)	do { (void)(f); } while (0)
> +#else
> +# define pci_lock_config(f)	raw_spin_lock_irqsave(&pci_lock, f)
> +# define pci_unlock_config(f)	raw_spin_unlock_irqrestore(&pci_lock, f)
> +#endif
> +
>  #define PCI_OP_READ(size, type, len) \
>  int pci_bus_read_config_##size \
>  	(struct pci_bus *bus, unsigned int devfn, int pos, type *value)	\
> @@ -33,10 +41,10 @@ int pci_bus_read_config_##size \
>  	unsigned long flags;						\
>  	u32 data = 0;							\
>  	if (PCI_##size##_BAD) return PCIBIOS_BAD_REGISTER_NUMBER;	\
> -	raw_spin_lock_irqsave(&pci_lock, flags);			\
> +	pci_lock_config(flags);						\
>  	res = bus->ops->read(bus, devfn, pos, len, &data);		\
>  	*value = (type)data;						\
> -	raw_spin_unlock_irqrestore(&pci_lock, flags);		\
> +	pci_unlock_config(flags);					\
>  	return res;							\
>  }
>  
> @@ -47,9 +55,9 @@ int pci_bus_write_config_##size \
>  	int res;							\
>  	unsigned long flags;						\
>  	if (PCI_##size##_BAD) return PCIBIOS_BAD_REGISTER_NUMBER;	\
> -	raw_spin_lock_irqsave(&pci_lock, flags);			\
> +	pci_lock_config(flags);						\
>  	res = bus->ops->write(bus, devfn, pos, len, value);		\
> -	raw_spin_unlock_irqrestore(&pci_lock, flags);		\
> +	pci_unlock_config(flags);					\
>  	return res;							\
>  }
>  
> 
> 
