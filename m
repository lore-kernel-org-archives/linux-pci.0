Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:46249 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932203AbbCLPSh (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 12 Mar 2015 11:18:37 -0400
Date: Thu, 12 Mar 2015 16:18:35 +0100
From: "Luis R. Rodriguez" <mcgrof@suse.com>
To: Jan Beulich <JBeulich@suse.com>
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>,
	Juergen Gross <JGross@suse.com>, luto@amacapital.net,
	thomas.petazzoni@free-electrons.com, andy.shevchenko@gmail.com,
	bhelgaas@google.com, rientjes@google.com,
	Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
	tglx@linutronix.de, pure.logic@nexus-software.ie, mingo@redhat.com,
	bp@suse.de, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, hpa@zytor.com
Subject: Re: [PATCH v1 2/2] x86: kconfig: remove X86_UP_APIC
Message-ID: <20150312151835.GL25035@wotan.suse.de>
References: <1426115422-1823-1-git-send-email-mcgrof@do-not-panic.com>
 <1426115422-1823-3-git-send-email-mcgrof@do-not-panic.com>
 <55015F690200007800068D86@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <55015F690200007800068D86@suse.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Mar 12, 2015 at 02:42:01AM -0600, Jan Beulich wrote:
> >>> On 12.03.15 at 00:10, <mcgrof@do-not-panic.com> wrote:
> >  config X86_LOCAL_APIC
> >  	def_bool y
> > -	depends on X86_64 || SMP || X86_32_NON_STANDARD || X86_UP_APIC || PCI_MSI
> > +	depends on X86_64 || SMP || X86_32_NON_STANDARD || PCI_MSI
> 
> I.e. building a 32-bit kernel with APIC support but with !SMP, !PCI_MSI,
> and !X86_32_NON_STANDARD will now be impossible.

These are the requirements for X86_UP_APIC though.

> Surely not what the patch description says.

The only removal I see here is the option to opt-in or out of
X86_UP_APIC when PCI_MSI is *not* enabled provided you meet the
requirements.

> > --- a/drivers/pci/Kconfig
> > +++ b/drivers/pci/Kconfig
> > @@ -5,6 +5,8 @@ config PCI_MSI
> >  	bool "Message Signaled Interrupts (MSI and MSI-X)"
> >  	depends on PCI
> >  	select GENERIC_MSI_IRQ
> > +	select X86_LOCAL_APIC
> > +	select X86_IO_APIC
> 
> I don't see the need for the latter - MSI specifically works without
> any IO-APIC interaction.

Although it can some MSI platforms need it as Bryan originally
had expressed in his original patch [0] that Intel CE, Intel MID
and Intel Quark are all 32-bit uniprocessor systems with IO-APICs
that also use PCI-MSI, so this is not a hard requirement but rather
compromising on enabling it since the the X86_IOAPIC cost is only
~12 KiB at with no performance penalty.

https://lkml.org/lkml/2015/1/22/718

> And for the former you should decide
> which way you want it - PCI_MSI select X86_LOCAL_APIC
> (probably the right thing in x86, but surely wrong everwhere
> else, i.e. this at least needs a condition tagged onto it)

selects are done *iff* the dependencies are met, otherwise we can't
select it, that's all, so the *iff* is implicit.

> or
> X86_LOCAL_APIC depend on PCI_MSI; in no case should this
> be a forward _and_ reverse dependency.

There is no reverse requirement here because of the select.
The trick here is the select implies the depends the value
you are selecting has.

mcgrof@ergon ~/linux-next (git::master)$ export ARCH=alpha
mcgrof@ergon ~/linux-next (git::master)$ make allnoconfig
mcgrof@ergon ~/linux-next (git::master)$ make menuconfig
  --> System setup  --->
      [*] Message Signaled Interrupts (MSI and MSI-X)
mcgrof@ergon ~/linux-next (git::master)$ grep -i APIC .config
mcgrof@ergon ~/linux-next (git::master)$ echo $?
1

  Luis
