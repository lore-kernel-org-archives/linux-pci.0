Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 10 Mar 2015 17:49:10 -0700 (PDT)
From: David Rientjes <rientjes@google.com>
To: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
cc: Bjorn Helgaas <bhelgaas@google.com>,
	Ingo Molnar <mingo@redhat.com>, tglx@linutronix.de,
	"H. Peter Anvin" <hpa@zytor.com>, pure.logic@nexus-software.ie,
	jgross@suse.com, luto@amacapital.net, andy.shevchenko@gmail.com,
	thomas.petazzoni@free-electrons.com, JBeulich@suse.com, bp@suse.de,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	x86@kernel.org, "Luis R. Rodriguez" <mcgrof@suse.com>,
	Ingo Molnar <mingo@kernel.org>
Subject: Re: [RFC v1 1/2] x86: kconfig: simplify enabling [IO]APIC for
 PCI_MSI
In-Reply-To: <1426029275-9594-2-git-send-email-mcgrof@do-not-panic.com>
Message-ID: <alpine.DEB.2.10.1503101746450.26407@chino.kir.corp.google.com>
References: <1426029275-9594-1-git-send-email-mcgrof@do-not-panic.com> <1426029275-9594-2-git-send-email-mcgrof@do-not-panic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, 10 Mar 2015, Luis R. Rodriguez wrote:

> diff --git a/Documentation/PCI/MSI-HOWTO.txt b/Documentation/PCI/MSI-HOWTO.txt
> index 0d920d5..7306d2c 100644
> --- a/Documentation/PCI/MSI-HOWTO.txt
> +++ b/Documentation/PCI/MSI-HOWTO.txt
> @@ -71,10 +71,7 @@ will simply fail and the device will continue to use pin-based interrupts.
>  4.1 Include kernel support for MSIs
>  
>  To support MSI or MSI-X, the kernel must be built with the CONFIG_PCI_MSI
> -option enabled.  This option is only available on some architectures,
> -and it may depend on some other options also being set.  For example,
> -on x86, you must also enable X86_UP_APIC or SMP in order to see the
> -CONFIG_PCI_MSI option.
> +option enabled.  This option is only available on some architectures.
>  
>  4.2 Using MSI
>  
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index d038475..0ecdeb1 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -902,10 +902,6 @@ config X86_UP_APIC
>  	  performance counters), and the NMI watchdog which detects hard
>  	  lockups.
>  
> -config X86_UP_APIC_MSI
> -	def_bool y
> -	select X86_UP_APIC if X86_32 && !SMP && !X86_32_NON_STANDARD && PCI_MSI
> -
>  config X86_UP_IOAPIC
>  	bool "IO-APIC support on uniprocessors"
>  	depends on X86_UP_APIC
> @@ -924,7 +920,7 @@ config X86_LOCAL_APIC
>  	select GENERIC_IRQ_LEGACY_ALLOC_HWIRQ
>  
>  config X86_IO_APIC
> -	def_bool X86_64 || SMP || X86_32_NON_STANDARD || X86_UP_IOAPIC
> +	def_bool X86_64 || SMP || X86_32_NON_STANDARD || X86_UP_IOAPIC || PCI_MSI
>  	depends on X86_LOCAL_APIC
>  	select IRQ_DOMAIN
>  
> diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
> index 7a8f1c5..01370c0 100644
> --- a/drivers/pci/Kconfig
> +++ b/drivers/pci/Kconfig
> @@ -5,6 +5,8 @@ config PCI_MSI
>  	bool "Message Signaled Interrupts (MSI and MSI-X)"
>  	depends on PCI
>  	select GENERIC_MSI_IRQ
> +	select X86_LOCAL_APIC if X86_32 && !SMP && !X86_32_NON_STANDARD
> +	select X86_IO_APIC if X86_32 && !SMP && !X86_32_NON_STANDARD
>  	help
>  	   This allows device drivers to enable MSI (Message Signaled
>  	   Interrupts).  Message Signaled Interrupts enable a device to

This conflicts with commit 50849eefea3b ("x86/Kconfig: Simplify 
X86_UP_APIC handling"), which has already been merged for the 4.0 release 
cycle, and I think I prefer the simplification done there over the 
additional "select"s for PCI_MSI.
