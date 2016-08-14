Return-Path: <lukas@wunner.de>
Return-Path: <lukas@wunner.de>
Date: Sun, 14 Aug 2016 12:27:25 +0200
From: Lukas Wunner <lukas@wunner.de>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Linux PCI <linux-pci@vger.kernel.org>,
	Linux PM <linux-pm@vger.kernel.org>,
	Andreas Noever <andreas.noever@gmail.com>
Subject: Re: [PATCH v2 10/13] PCI: Avoid going from D3cold to D3hot for
 system sleep
Message-ID: <20160814102725.GA8634@wunner.de>
References: <cover.1463134231.git.lukas@wunner.de>
 <CAJZ5v0g86L+nL6SxfBMQ84NNpUzz0X83bvP=E5WdSs1TozpY8w@mail.gmail.com>
 <20160812161609.GA8060@wunner.de>
 <2003407.8XLAPPsQTe@vostro.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <2003407.8XLAPPsQTe@vostro.rjw.lan>
List-ID: <linux-pci.vger.kernel.org>

On Sat, Aug 13, 2016 at 12:18:26AM +0200, Rafael J. Wysocki wrote:
> Yes, so specifically I'm concerned about the pci_target_state() invocation
> in pci_dev_keep_suspended() which is done exactly for this purpose.
> 
> If you apply the "keep it in D3cold if already there" logic to that case,
> it may lead to a wrong decision in theory. Say the device is in D3cold and
> platform_pci_choose_state() returns D1, but pci_no_d1d2() returns true,
> the device will end up in D3cold, but it may not be able to signal wakeup
> from that state after the system has been suspended.

Ugh, I had missed those break statements in the platform-case.
I must be blind. You're right of course, that wouldn't be correct.

> Of course, I guess you'll say that it may not be able to signal wakeup from
> D3hot as well in that case, which is correct. :-)

Hm, what would be the correct power state in that case then? PCI_D0?

> Why don't you simply rearrange the routine like
> 
> 	pci_power_t target_state = PCI_D3hot;
> 
> 	if (platform_pci_power_manageable(dev)) {
> 		...
> 		return target_state;
> 	}
> 
> 	if (!dev->pm_cap)
> 		return PCI_D0;
> 
> 	if (dev->current_state == PCI_D3cold)
> 		target_state = PCI_D3cold;
> 
> 	if (device_may_wakeup(&dev->dev)) {
> 		...
> 	}
> 
> 	return target_state;
> 
> And that would be fine by me.

Looks good, I'll give that a try.

If the correct power state in the pci_no_d1d2() case is PCI_D0,
I could fix that up as well.

> That said I'm not sure why you want to use pci_target_state() so badly?
> 
> If you are going to use a PM domain, why do you still need that function?

The dev_pm_domain is only assigned to the topmost device exposed by
the Thunderbolt controller (the upstream bridge). I would like to avoid
having to assign separate dev_pm_domains to the downstream bridges.

So I let the NHI and downstream bridges go to D3hot. And when the
upstream bridge cuts power, it iterates over all child devices
and changes their current_state to D3cold to reflect reality.

When the system is later put to sleep, this patch ensures that the
NHI and downstream bridges are not unnecessarily resumed to D3hot.

So why change the current_state of the children at all? I could just
leave the (incorrect) PCI_D3hot and everything would be peachy, right?
Well, there's another problem: The first few Thunderbolt chips had
broken MSI, they have to use INTx to signal hotplug. Unfortunately on
some Macs built 2011/2012, the IRQ is shared with multiple other devices,
most importantly the wireless card which can generate thousands of
interrupts on a crowded WLAN. If power is cut to the Thunderbolt
controller, reading from the hotplug ports' config space in pcie_isr()
fails and results in a "no response from device" message logged with
KERN_INFO. Getting thousands of such messages is annoying, not to
mention the giant waste of CPU cycles to read from the config space
of a device which we *know* is powered down.

The solution I came up with is to add a tiny two-liner to pcie_isr()
with commit ed91de7e14fb ("PCI: pciehp: Ignore interrupts during D3cold").
But that requires that I update the children's current_state to D3cold,
and necessitates that pci_target_state() doesn't resume them to D3hot
for system sleep. Hence the need for this patch.

The approach has the additional benefit that hybrid graphics devices
are implicitly also afforded direct-complete without having to add a
->prepare hook that returns a positive int. They only need to set their
current_state to D3cold, which they already do, see azx_vs_set_state(),
nouveau_pmops_runtime_suspend(), radeon_pmops_runtime_suspend(),
amdgpu_pmops_runtime_suspend().

However this also means that adding a can_power_off flag to struct
dev_pm_domain wouldn't be a viable solution because then I'd have to
assign a dev_pm_domain to the downstream bridges. Another thing I've
missed. Ugh. This is so complicated it's easy to get tangled up in
all these intricate little details.

Thanks for your patience in dealing with these issues,

Lukas
