Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-Id: <55015F690200007800068D86@mail.emea.novell.com>
Date: Thu, 12 Mar 2015 08:42:01 +0000
From: "Jan Beulich" <JBeulich@suse.com>
To: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Cc: <luto@amacapital.net>, <thomas.petazzoni@free-electrons.com>,
	<andy.shevchenko@gmail.com>, <bhelgaas@google.com>,
	<rientjes@google.com>, "Ingo Molnar" <mingo@kernel.org>,
	<x86@kernel.org>, <tglx@linutronix.de>,
	<pure.logic@nexus-software.ie>, <mingo@redhat.com>,
	"Juergen Gross" <JGross@suse.com>,
	"Luis Rodriguez" <Mcgrof@Suse.com>, <bp@suse.de>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<hpa@zytor.com>
Subject: Re: [PATCH v1 2/2] x86: kconfig: remove X86_UP_APIC
References: <1426115422-1823-1-git-send-email-mcgrof@do-not-panic.com>
 <1426115422-1823-3-git-send-email-mcgrof@do-not-panic.com>
In-Reply-To: <1426115422-1823-3-git-send-email-mcgrof@do-not-panic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

>>> On 12.03.15 at 00:10, <mcgrof@do-not-panic.com> wrote:
>  config X86_LOCAL_APIC
>  	def_bool y
> -	depends on X86_64 || SMP || X86_32_NON_STANDARD || X86_UP_APIC || PCI_MSI
> +	depends on X86_64 || SMP || X86_32_NON_STANDARD || PCI_MSI

I.e. building a 32-bit kernel with APIC support but with !SMP, !PCI_MSI,
and !X86_32_NON_STANDARD will now be impossible. Surely not
what the patch description says.

> --- a/drivers/pci/Kconfig
> +++ b/drivers/pci/Kconfig
> @@ -5,6 +5,8 @@ config PCI_MSI
>  	bool "Message Signaled Interrupts (MSI and MSI-X)"
>  	depends on PCI
>  	select GENERIC_MSI_IRQ
> +	select X86_LOCAL_APIC
> +	select X86_IO_APIC

I don't see the need for the latter - MSI specifically works without
any IO-APIC interaction. And for the former you should decide
which way you want it - PCI_MSI select X86_LOCAL_APIC
(probably the right thing in x86, but surely wrong everwhere
else, i.e. this at least needs a condition tagged onto it) or
X86_LOCAL_APIC depend on PCI_MSI; in no case should this
be a forward _and_ reverse dependency.

Jan

