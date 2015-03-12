Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 12 Mar 2015 16:35:35 +0100
From: "Luis R. Rodriguez" <mcgrof@suse.com>
To: Bryan O'Donoghue <pure.logic@nexus-software.ie>
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>, rientjes@google.com,
	bhelgaas@google.com, mingo@redhat.com, tglx@linutronix.de,
	hpa@zytor.com, jgross@suse.com, luto@amacapital.net,
	andy.shevchenko@gmail.com, thomas.petazzoni@free-electrons.com,
	JBeulich@suse.com, bp@suse.de, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, x86@kernel.org,
	Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v1 1/2] x86: kconfig: remove X86_UP_IOAPIC
Message-ID: <20150312153535.GN25035@wotan.suse.de>
References: <1426115422-1823-1-git-send-email-mcgrof@do-not-panic.com>
 <1426115422-1823-2-git-send-email-mcgrof@do-not-panic.com>
 <5500E992.60505@nexus-software.ie>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5500E992.60505@nexus-software.ie>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Mar 12, 2015 at 01:19:14AM +0000, Bryan O'Donoghue wrote:
> On 11/03/15 23:10, Luis R. Rodriguez wrote:
> 
> ACK the concept - the logic to compile up APIC support is circuitous
> to say the least.

It took me a while to grok this and indeed the goal was to make it
much simpler to read, but at the same time to see if we can reach
a compromise to simplify it for 32-bit.

> Personally think we should just always compile up the APIC code if
> the arch declares support and let the bootstrap code interrogate
> CPUID.

This would be the *next* level of compromise to make, I felt comfortable
in raising the size compromise question for 32-bit but its not clear
to me if this is a general question which we can address for all x86.
There is indeed no performance pentalty for both so the question comes
down to tex size increase, and its why I provided the numbers.

My preference was to leave the optimization question for all x86 as
a rather secondary question *iff* we can agree on something for 32-bit.

> Who in 2015 is really running a system without an
> APIC/IO-APIC and tip-of-tree Linux and does that one user care about
> adding 12k to her kernel ? I suspect not and in any case can force
> the APIC off with a command line argument

I also figured this was the case, but figured it was safer to pose
the question for 32-bit. If indeed folks who produce the hardware
can conclude the size increase is reasonable for all platforms
given no performance penalty then we can surely keep this even
simpler -- I think its safer to ask this question for 32-bit and
leave only the larger picture questoin as an evolutionairy question.

> >@@ -899,6 +899,7 @@ config X86_UP_APIC
> >  	bool "Local APIC support on uniprocessors" if !PCI_MSI
> 
> Tried to apply this to torvalds-master to test :( Should it ? Which
> branch are you on here ?
> 
> Applying: x86: kconfig: remove X86_UP_IOAPIC
> error: patch failed: arch/x86/Kconfig:899
> error: arch/x86/Kconfig: patch does not apply
> Patch failed at 0001 x86: kconfig: remove X86_UP_IOAPIC

linux-next tag next-20150311

  Luis
