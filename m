Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Thu, 21 Sep 2017 16:03:13 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [PATCH v4 4/5] drivers: pci: add support for relative addressing
 in quirk tables
Message-ID: <20170921210312.GK22312@bhelgaas-glaptop.roam.corp.google.com>
References: <20170920195721.7939-1-ard.biesheuvel@linaro.org>
 <20170920195721.7939-5-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
In-Reply-To: <20170920195721.7939-5-ard.biesheuvel@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>, Paul Mackerras <paulus@samba.org>,
 "H. Peter Anvin" <hpa@zytor.com>, Nicolas Pitre <nico@linaro.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Ingo Molnar <mingo@redhat.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 "Serge E. Hallyn" <serge@hallyn.com>, Petr Mladek <pmladek@suse.com>,
 Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>,
 Will Deacon <will.deacon@arm.com>, Steven Rostedt <rostedt@goodmis.org>,
 James Morris <james.l.morris@oracle.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org,
 linux-pci@vger.kernel.org, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
 Jessica Yu <jeyu@kernel.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Thomas Garnier <thgarnie@google.com>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

[+cc linux-pci]

You copied LKML on some previous versions, but not this one.  Seems
like that would be useful.

Please adjust the subject line of this one so it matches the typical
ones for this file, e.g.,

  PCI: Add support for relative addressing in quirk tables

On Wed, Sep 20, 2017 at 12:57:20PM -0700, Ard Biesheuvel wrote:
> Allow the PCI quirk tables to be emitted in a way that avoids absolute
> references to the hook functions. This reduces the size of the entries,
> and, more importantly, makes them invariant under runtime relocation
> (e.g., for KASLR)
> 
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

This really uglifies the code (and initcall_from_entry() in the other
patch makes my head hurt), but I don't have any cleaner implementation
ideas, and it does seem like a worthwhile space optimization.

> ---
>  drivers/pci/quirks.c | 13 ++++++++++---
>  include/linux/pci.h  | 20 ++++++++++++++++++++
>  2 files changed, 30 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index a4d33619a7bb..82a66235d60c 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -3548,9 +3548,16 @@ static void pci_do_fixups(struct pci_dev *dev, struct pci_fixup *f,
>  		     f->vendor == (u16) PCI_ANY_ID) &&
>  		    (f->device == dev->device ||
>  		     f->device == (u16) PCI_ANY_ID)) {
> -			calltime = fixup_debug_start(dev, f->hook);
> -			f->hook(dev);
> -			fixup_debug_report(dev, calltime, f->hook);
> +			void (*hook)(struct pci_dev *dev);
> +#ifdef CONFIG_HAVE_ARCH_PREL32_RELOCATIONS
> +			hook = (void *)((unsigned long)&f->hook_offset +
> +					f->hook_offset);
> +#else
> +			hook = f->hook;
> +#endif
> +			calltime = fixup_debug_start(dev, hook);
> +			hook(dev);
> +			fixup_debug_report(dev, calltime, hook);
>  		}
>  }
>  
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index f68c58a93dd0..d7a01d7fc3a7 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1791,7 +1791,11 @@ struct pci_fixup {
>  	u16 device;		/* You can use PCI_ANY_ID here of course */
>  	u32 class;		/* You can use PCI_ANY_ID here too */
>  	unsigned int class_shift;	/* should be 0, 8, 16 */
> +#ifdef CONFIG_HAVE_ARCH_PREL32_RELOCATIONS
> +	signed int hook_offset;
> +#else
>  	void (*hook)(struct pci_dev *dev);
> +#endif
>  };
>  
>  enum pci_fixup_pass {
> @@ -1805,12 +1809,28 @@ enum pci_fixup_pass {
>  	pci_fixup_suspend_late,	/* pci_device_suspend_late() */
>  };
>  
> +#ifdef CONFIG_HAVE_ARCH_PREL32_RELOCATIONS
> +#define __DECLARE_PCI_FIXUP_SECTION(sec, name, vendor, device, class,	\
> +				    class_shift, hook)			\
> +	__ADDRESSABLE(hook)						\
> +	asm(".section "	#sec ", \"a\"				\n"	\
> +	    ".balign	16					\n"	\
> +	    ".short "	#vendor ", " #device "			\n"	\
> +	    ".long "	#class ", " #class_shift "		\n"	\
> +	    ".long "	VMLINUX_SYMBOL_STR(hook) " - .		\n"	\
> +	    ".previous						\n");
> +#define DECLARE_PCI_FIXUP_SECTION(sec, name, vendor, device, class,	\
> +				  class_shift, hook)			\
> +	__DECLARE_PCI_FIXUP_SECTION(sec, name, vendor, device, class,	\
> +				  class_shift, hook)
> +#else
>  /* Anonymous variables would be nice... */
>  #define DECLARE_PCI_FIXUP_SECTION(section, name, vendor, device, class,	\
>  				  class_shift, hook)			\
>  	static const struct pci_fixup __PASTE(__pci_fixup_##name,__LINE__) __used	\
>  	__attribute__((__section__(#section), aligned((sizeof(void *)))))    \
>  		= { vendor, device, class, class_shift, hook };
> +#endif
>  
>  #define DECLARE_PCI_FIXUP_CLASS_EARLY(vendor, device, class,		\
>  					 class_shift, hook)		\
> -- 
> 2.11.0
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
