Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:39274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727209AbeHJQ2j (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 10 Aug 2018 12:28:39 -0400
Date: Fri, 10 Aug 2018 08:58:37 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: joeyli <jlee@suse.com>
Cc: "Lee, Chun-Yi" <joeyli.kernel@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/PCI: Claim the resources of firmware enabled IOAPIC
 before children bus
Message-ID: <20180810135837.GI113140@bhelgaas-glaptop.roam.corp.google.com>
References: <20180724110144.16442-1-jlee@suse.com>
 <20180806214807.GE30691@bhelgaas-glaptop.roam.corp.google.com>
 <20180808155318.GE13767@linux-l9pv.suse>
 <20180808212322.GF49411@bhelgaas-glaptop.roam.corp.google.com>
 <20180810092501.GP13767@linux-l9pv.suse>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180810092501.GP13767@linux-l9pv.suse>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Aug 10, 2018 at 05:25:01PM +0800, joeyli wrote:
> On Wed, Aug 08, 2018 at 04:23:22PM -0500, Bjorn Helgaas wrote:
> ...

> The lspci log shows "Normal decode" on the bridge, I think that means
> positively decode.

Right.

> hm... I have another question that it may not relates to this issue. I
> was tracing the code path of PCI hot-remove/hotplug. Base on spec, looks
> that the RST# should be asserted when hot-remove. And the memory decode
> bit must be set to zero after RST# be asserted. But I didn't see that
> any kernel PCI/ACPI code set RST#. The only possible code to set RST# is
> in POWER architecture. Do you know who assert the RST# when hot-remove?    

RST# is a conventional PCI signal (not a PCIe signal).  In any case, I
would expect signals like that to be handled by hardware, not by
software.  What section of the spec are you looking at?  I wouldn't
expect any requirements for doing things to a device when the device
is being hot-removed, since the device may already be inaccessible,
e.g., physically unreachable.

On a hot-*add*, there would of course be requirements about how the
device powers up and comes out of reset.  For native drivers like
pciehp/shpcpd/etc, there are often ways for software to control power
to the slot, e.g., the "Power Controller Control" bit in the PCIe Slot
Control register.

For ACPI-mediated hotplug (as in your situation), the actual hardware
details are handled by the firmware and all the OS sees are things
like ACPI Notify events and it uses methods like _STA and other things
mentioned in ACPI v6.2, sec 6.3.

> > What are the chances of getting a firmware fix?  Has this firmware
> > already shipped to customers?
> 
> The good news is that the machine has not shipped yet. As I know
> that manufacturer is also finding the root cause for why firmware
> enabled memory decode bit and also set the wrong addresses.

I don't think it's necessarily a problem that firmware enables the
IOAPIC.  This is ACPI-mediated hotplug and it looks like it adds CPUs,
memory, and I/O.  I wouldn't be surprised if the firmware has to make
the IOAPIC operational to make some parts of the hot-add work.

The address conflict is the real problem.

Bjorn
