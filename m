Return-Path: <keith.busch@intel.com>
Return-Path: <keith.busch@intel.com>
Date: Fri, 28 Oct 2016 14:33:32 -0400
From: Keith Busch <keith.busch@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Jon Derrick <jonathan.derrick@intel.com>
Subject: Re: [PATCH] pci: Don't set power fault if controller not present
Message-ID: <20161028183332.GD5621@localhost.localdomain>
References: <1476214747-10428-1-git-send-email-keith.busch@intel.com>
 <20161022144425.GH9007@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161022144425.GH9007@localhost>
List-ID: <linux-pci.vger.kernel.org>

On Sat, Oct 22, 2016 at 09:44:25AM -0500, Bjorn Helgaas wrote:
> On Tue, Oct 11, 2016 at 03:39:07PM -0400, Keith Busch wrote:
> > The pciehp control only clears the saved power fault detected if power
> > controller control is present, but there is no requirement that the
> > capability exist in order to observe power faults. This means a hot-added
> > device in a slot that had experienced a power fault at some point would
> > never be able to add a new device since the power fault detected would
> > be on permanently.
> > 
> > This patch sets the sticky field only if there is a chance it can
> > be cleared later.
> 
> I agree we should handle power_fault_detected consistently with
> respect to POWER_CTRL().  We currently clear power_fault_detected in
> pciehp_power_on_slot(), but we only call that if we have a power
> controller.  But we set power_fault_detected in pciehp_isr() always,
> resulting in this "sticky" situation.
> 
> I don't think it's 100% clear from the spec whether power faults can
> be detected without a power controller.  All the "power fault"
> references are in the context of a power controller, e.g., r3.0 sec
> 6.7.1.8, 7.8.10, 7.8.11.
> 
> But regardless, we're certainly doing the wrong thing right now.  If
> we do have a power controller, it's fairly clear what we should do:
> 
>   - Power off the slot (even though the hardware is supposed to remove
>     power automatically, sec 6.7.1.8 suggests that software should
>     turn off the power),
> 
>   - Wait at least one second, per 6.7.1.8 (I think we do the power off
>     and wait in the board_added() path, but not in the INT_POWER_FAULT
>     path where we handle asynchronous events),
> 
>   - It looks like we currently turn on the attention indicator and
>     turn off the power indicator (the INT_POWER_FAULT case in
>     interrupt_event_handler()),
> 
>   - Wait for another slot event.
> 
> If we *don't* have a power controller, we currently set
> power_fault_detected and log a message, but nothing else.


As always, thank you for the detailed analysis.

While there a power controller should be present to observe power faults,
a software controllable power controller (the "power controller control"
capability) is not necessary as I understand it.

That said, I've learned new information from the hardware side that may
not require this patch, or something different entirely. I'll send an
update if/when I find out.
