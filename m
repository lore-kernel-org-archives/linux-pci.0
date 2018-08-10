Return-Path: <SRS0=+vaL=KZ=suse.com=jlee@kernel.org>
Return-Path: <SRS0=+vaL=KZ=suse.com=jlee@kernel.org>
Date: Fri, 10 Aug 2018 17:25:01 +0800
From: joeyli <jlee@suse.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: "Lee, Chun-Yi" <joeyli.kernel@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>,
	x86@kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/PCI: Claim the resources of firmware enabled IOAPIC
 before children bus
Message-ID: <20180810092501.GP13767@linux-l9pv.suse>
References: <20180724110144.16442-1-jlee@suse.com>
 <20180806214807.GE30691@bhelgaas-glaptop.roam.corp.google.com>
 <20180808155318.GE13767@linux-l9pv.suse>
 <20180808212322.GF49411@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180808212322.GF49411@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>

On Wed, Aug 08, 2018 at 04:23:22PM -0500, Bjorn Helgaas wrote:
> On Wed, Aug 08, 2018 at 11:53:18PM +0800, joeyli wrote:
> > Hi Bjorn,
> > 
> > First, thanks for your review!
> > 
> > On Mon, Aug 06, 2018 at 04:48:07PM -0500, Bjorn Helgaas wrote:
> > > On Tue, Jul 24, 2018 at 07:01:44PM +0800, Lee, Chun-Yi wrote:
> > > > I got a machine that the resource of firmware enabled IOAPIC conflicts
> > > > with the resource of a children bus when the PCI host bus be hotplug.
> > > > 
> > > > [ 3182.243325] PCI host bridge to bus 0001:40
> > > > [ 3182.243328] pci_bus 0001:40: root bus resource [io  0xc000-0xdfff window]
> > > > [ 3182.243330] pci_bus 0001:40: root bus resource [mem 0xdc000000-0xebffffff window]
> > > > [ 3182.243331] pci_bus 0001:40: root bus resource [mem 0x212400000000-0x2125ffffffff window]
> > > > [ 3182.243334] pci_bus 0001:40: root bus resource [bus 40-7e]
> > > > ...
> > > > [ 3182.244737] pci 0001:40:05.4: [8086:6f2c] type 00 class 0x080020
> > > > [ 3182.244746] pci 0001:40:05.4: reg 0x10: [mem 0xdc000000-0xdc000fff]
> > > > ...
> > > > [ 3182.246697] pci 0001:40:02.0: PCI bridge to [bus 41]
> > > > [ 3182.246702] pci 0001:40:02.0:   bridge window [mem 0xdc000000-0xdc7fffff]
> > > > ...
> > > > pci 0001:40:05.4: can't claim BAR 0 [mem 0xdc000000-0xdc000fff]: address conflict with PCI Bus 0001:41 [mem 0xdc000000-0xdc7fffff]
> > > > 
> > > > The bus topology:
> > > > 
> > > >  +-[0001:40]-+-02.0-[41]--
> > > >  |           +-03.0-[41]--
> > > >  |           +-03.2-[41]--+-00.0  Intel Corporation I350 Gigabit Network Connection
> > > >  |           |            +-00.1  Intel Corporation I350 Gigabit Network Connection
> > > >  |           |            +-00.2  Intel Corporation I350 Gigabit Network Connection
> > > >  |           |            \-00.3  Intel Corporation I350 Gigabit Network Connection
> > > >  |           +-05.0  Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon E3 v4/Xeon D Map/VTd_Misc/System Management
> > > >  |           +-05.1  Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon E3 v4/Xeon D IIO Hot Plug
> > > >  |           +-05.2  Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon E3 v4/Xeon D IIO RAS/Control Status/Global Errors
> > > >  |           \-05.4  Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon E3 v4/Xeon D I/O APIC
> > > > 
> > > > This problem causes that the NIC behine the child bus was not available
> > > > after PCI host bridge hotpluged.
> > > > 
> > > > Kernel does not want to change resource of firmware enabled IOAPIC, but
> > > > the priority of children bus's resources are higher than any other devices.
> > > > So this conflict can not be handled by the reassigning logic of kernel.
> > 
> > Sorry for my description is not clear. The "priority" is for resources
> > clamining, not for the address decoding.
> > 
> > > I don't understand this paragraph.  AFAIK, if two devices on a bus
> > > both decode the same address, as the IOAPIC and the bridge do here,
> > > the only real "priority" in PCI would be subtractive decode.  But I
> > > don't think that applies here since the bridge is using a positive
> > > decode window.
> > 
> > Sorry for I didn't understand... How could you know the bridge doesn't
> > apply subtractive decode?
> 
> A subtractive decode bridge forwards anything appearing on its primary
> bus to its secondary bus.  In conventional PCI, it only does this if
> no other agent on the primary bus asserts DEVSEL# (PCI r3.0, sec
> 3.6.1).  In PCIe, the primary "bus" is a link and there's only one
> device on it, so a subtractive decode bridge could forward anything it
> sees.  If the subtractive decode bridge is part of a multi-function
> device, I assume that multi-function device would have to determine
> internally whether the subtractive decode bridge or another function
> should claim the transaction.
> 
> Either way, a subtractive decode bridge can forward anything that
> appears on its primary bus, so a subtractive decode window effectively
> contains everything the upstream bridge passes down.  In this case you
> have:
> 
>   pci_bus 0001:40: root bus resource [mem 0xdc000000-0xebffffff window]
>   pci_bus 0001:40: root bus resource [mem 0x212400000000-0x2125ffffffff window]
>   pci 0001:40:02.0: PCI bridge to [bus 41]
>   pci 0001:40:02.0:   bridge window [mem 0xdc000000-0xdc7fffff]
> 
> The 40:02.0 bridge could see [mem 0xdc000000-0xebffffff] or [mem
> 0x212400000000-0x2125ffffffff] on its primary bus, so if it were a
> subtractive decode bridge, its "window" would contain both of those
> regions, and we should label them as "(subtractive decode)" in the
> dmesg log.
>

Learned! Thanks a lot!
 
> Since [mem 0xdc000000-0xdc7fffff] is only part of the first root bus
> resource, I infer that it must be a positively decoded window.
> "lspci -vv" would tell you for sure.
>

The lspci log shows "Normal decode" on the bridge, I think that means
positively decode.
 
> > > I would expect that a read to the [mem 0xdc000000-0xdc000fff] range
> > > would potentially receive two read completions, which would cause an
> > > Unexpected Completion error.
> > 
> > Thanks for your information. The I350 NIC doesn't work after hotplug.
> > So it may causes by Unexpected Completion error as you mentioned.
> >  
> > > Maybe you mean that we don't want to change the IOAPIC resources, but
> > > it's OK if we move the bridge window, so in that sense, the IOAPIC is
> > > "higher priority" than the bridge window?  This is the reverse of what
> > > your paragraph seems to say.
> > 
> > Yes, this is what I mean. Sorry for my paragraph causes confusing. 
> > 
> > The memory decoder bit in the command register of 0001:40:05.4 IOAPIC
> > is raised by firmware after hotplug. So kernel treats it as a
> > _firmware enabled_ IOAPIC. Because kernel don't want to change the IOAPIC
> > resources, so my patch try to claim the IOAPIC resources before all
> > bridges. It can workaround the hotplug problem on issue machine.
> > 
> > But, actually I am not sure that this hacking makes sense. And, I also
> > don't know why the memory decoder bit is raised by firmware when hotplug.
> > Maybe this is a firmware problem.
> 
> That's a good point.  It's fine for firmware to enable the IOAPIC
> memory decode.  But the address conflict:

Per my understood, normally the firmware set memory decode bit for booting.
I have no idea why firmware set the bit for hotplug.

> 
>   [ 3906.092119] pci 0001:40:05.4: reg 0x10: [mem 0xdc000000-0xdc000fff]
>   [ 3906.093898] pci 0001:40:02.0: PCI bridge to [bus 41]
>   [ 3906.093902] pci 0001:40:02.0:   bridge window [mem 0xdc000000-0xdc7fffff]
> 
> is not so fine.  That looks like a firmware bug to me.  These devices
> should power up with zeroes in their BARs, so the addresses must have
> been assigned by firmware before it sent the ACPI hotplug notification
> to Linux.

The interesting thing is that the addresses in BAR do not have any
conflict after normal booting. This problem only happened after hotplug.

hm... I have another question that it may not relates to this issue. I
was tracing the code path of PCI hot-remove/hotplug. Base on spec, looks
that the RST# should be asserted when hot-remove. And the memory decode
bit must be set to zero after RST# be asserted. But I didn't see that
any kernel PCI/ACPI code set RST#. The only possible code to set RST# is
in POWER architecture. Do you know who assert the RST# when hot-remove?    

> 
> In principle, Linux *should* be able to recover from that by moving
> the IOAPIC or the bridge window, but obviously we don't.
> 
> What are the chances of getting a firmware fix?  Has this firmware
> already shipped to customers?
>

The good news is that the machine has not shipped yet. As I know
that manufacturer is also finding the root cause for why firmware
enabled memory decode bit and also set the wrong addresses.
 
> > > > This patch claims the resources of firmware enabled IOAPIC before
> > > > children bus. Then kernel gets a chance to reassign the resources of
> > > > children bus to avoid the conflict.
> > > 
> > > Can you open a report at https://bugzilla.kernel.org, attach the
> > > before and after dmesg logs, and include the URL in the commit log?
> > 
> > OK, I have filed a bug on kernel bugzilla and also attached dmesg
> > log:
> > 	https://bugzilla.kernel.org/show_bug.cgi?id=200765
> 
> Thanks.  Please include this URL in the changelog if you post an
> updated patch.

OK, I will add the URL to bug description in next version.

Thanks a lot!
Joey Lee 
