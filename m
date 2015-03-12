Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <5500E992.60505@nexus-software.ie>
Date: Thu, 12 Mar 2015 01:19:14 +0000
From: Bryan O'Donoghue <pure.logic@nexus-software.ie>
MIME-Version: 1.0
To: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>, rientjes@google.com,
	bhelgaas@google.com, mingo@redhat.com, tglx@linutronix.de,
	hpa@zytor.com, jgross@suse.com, luto@amacapital.net,
	andy.shevchenko@gmail.com, thomas.petazzoni@free-electrons.com,
	JBeulich@suse.com, bp@suse.de
CC: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	x86@kernel.org, "Luis R. Rodriguez" <mcgrof@suse.com>,
	Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v1 1/2] x86: kconfig: remove X86_UP_IOAPIC
References: <1426115422-1823-1-git-send-email-mcgrof@do-not-panic.com> <1426115422-1823-2-git-send-email-mcgrof@do-not-panic.com>
In-Reply-To: <1426115422-1823-2-git-send-email-mcgrof@do-not-panic.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 11/03/15 23:10, Luis R. Rodriguez wrote:

ACK the concept - the logic to compile up APIC support is circuitous to 
say the least.

Personally think we should just always compile up the APIC code if the 
arch declares support and let the bootstrap code interrogate CPUID. Who 
in 2015 is really running a system without an APIC/IO-APIC and 
tip-of-tree Linux and does that one user care about adding 12k to her 
kernel ? I suspect not and in any case can force the APIC off with a 
command line argument

> @@ -899,6 +899,7 @@ config X86_UP_APIC
>   	bool "Local APIC support on uniprocessors" if !PCI_MSI

Tried to apply this to torvalds-master to test :( Should it ? Which 
branch are you on here ?

Applying: x86: kconfig: remove X86_UP_IOAPIC
error: patch failed: arch/x86/Kconfig:899
error: arch/x86/Kconfig: patch does not apply
Patch failed at 0001 x86: kconfig: remove X86_UP_IOAPIC

