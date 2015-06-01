Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:48996 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752948AbbFAWDA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 1 Jun 2015 18:03:00 -0400
Message-ID: <1433196179.5794.159.camel@redhat.com>
Subject: Re: [PATCH RFC 2/4] PCI: pciehp: Wait for hotplug command
 completion lazily
From: Alex Williamson <alex.williamson@redhat.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Yinghai Lu <yinghai@kernel.org>, "Jan C. Nordholz" <jckn@gmx.net>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Rajat Jain <rajatxjain@gmail.com>, linux-pci@vger.kernel.org,
	Myron Stowe <myron.stowe@redhat.com>
Date: Mon, 01 Jun 2015 16:02:59 -0600
In-Reply-To: <20150601214322.GA3631@google.com>
References: <20140614210740.15202.84719.stgit@bhelgaas-glaptop.roam.corp.google.com>
	 <20140614212126.15202.66060.stgit@bhelgaas-glaptop.roam.corp.google.com>
	 <1432939534.5794.56.camel@redhat.com> <20150601214322.GA3631@google.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, 2015-06-01 at 16:43 -0500, Bjorn Helgaas wrote:
> On Fri, May 29, 2015 at 04:45:34PM -0600, Alex Williamson wrote:
> > 
> > Sorry, I'm digging up and old patch here and this RFC was the only copy
> > I could find in my mailbox.
> > 
> > On Sat, 2014-06-14 at 15:21 -0600, Bjorn Helgaas wrote:
> > > Previously we issued a hotplug command and waited for it to complete.  But
> > > there's no need to wait until we're ready to issue the *next* command.  The
> > > next command will probably be much later, so the first one may have already
> > > completed and we may not have to actually wait at all.
> > 
> > I'm seeing a regression as a result of this patch.  Consider the
> > following function:
> > 
> > int pciehp_reset_slot(struct slot *slot, int probe)
> > {
> > 	...
> > 	pcie_write_cmd(ctrl, 0, ctrl_mask);
> > 	...
> > 	pci_reset_bridge_secondary_bus(ctrl->pcie->port);
> > 
> > Our command write is clearing bits that control whether the slot has
> > presence detection and link layer state change enabled.  These are the
> > things that we're trying to clear to prevent a secondary bus reset from
> > turning into a surprise hotplug.  If we don't wait for the command to
> > complete, what state are when in as we initiate the secondary bus reset?
> > On my system, it's like we never issued the write command at all, the
> > previous behavior where the hotplug controller detects the link down as
> > a surprise hotplug returns.  So I'm afraid we do need to wait until
> > we're ready to issue the *next* command, because it's our only
> > indication that the current command has completed.
> 
> I think that's a bug.  If we do something that depends on a command
> completion, we'll have to wait for it.
> 
> > pciehp_set_attention_status
> > pciehp_green_led_on
> > pciehp_green_led_off
> > pciehp_green_led_blink
> > pciehp_power_on_slot
> > pciehp_power_off_slot
> > pcie_enable_notification
> > pcie_disable_notification
> > 
> > The slot power ones concern me the same as the reset issue.  In the 'on'
> > case, we immediately call link enable, so the slot better have
> > acknowledged the power on command.  In the 'off' case, it seems pretty
> > bad to complete the 'off' function, but we don't know if the slot is
> > actually off yet.  
> 
> I agree.
> 
> > For notifications, I can imagine that the caller of
> > those functions is going to want on or off at the completion of those
> > functions, not some in-between state.  
> 
> These control interrupt generation by the hotplug controller in the switch.
> When disabling interrupt generation, I think we should wait for completion
> before we call free_irq(); waiting should prevent spurious interrupts.
> When enabling interrupt generation, we've already hooked up the ISR before
> we enable interrupt generation, so I don't see a need to wait.
> 
> > Even in the case of the LED
> > functions, where do we want the error to occur, at the time the command
> > is issued, or maybe some time in the future when the next unrelated
> > command comes through.
> 
> The only error here is the "Timeout on hotplug command" message, and we
> don't do anything other than print the message, so I'm not too worried
> about this one.
> 
> > So, rather than posting a new patch adding a flush everywhere that it
> > seems a little scary, should we consider scrapping this patch altogether
> > as unsafe?  We need to wait, not only to issue the next command, but to
> > have any sort of acknowledgment that the current command has completed.
> 
> I definitely screwed up by assuming that completion was only useful for
> pacing writes to the command register.  I think lazy checking is fine for
> command pacing, but we certainly need to know about completions for other
> things, too.
> 
> If we added calls to pcie_wait_cmd() in these places:
> 
>   pciehp_power_on_slot
>   pciehp_power_off_slot
>   pcie_disable_notification
>   pciehp_reset_slot
> 
> do you think that would be enough?

I think that would solve the problem, but the API becomes very difficult
to use correctly if the programmer just needs to know that a
pcie_wait_cmd() is necessary following a pcie_write_cmd() if you really
want to be sure it's synchronous.  pcie_write_cmd() should probably
incorporate the "safe" behavior and some new _nowait version should
handle the special cases where we don't need to wait

> > > Because of hardware errata, some controllers generate command completion
> > > events for some commands but not others.  In the case of Intel CF118 (see
> > > spec update reference), the controller indicates command completion only
> > > for Slot Control writes that change the value of the following bits:
> > > 
> > >   Power Controller Control
> > >   Power Indicator Control
> > >   Attention Indicator Control
> > >   Electromechanical Interlock Control
> > > 
> > > Changes to other bits, e.g., the interrupt enable bits, do not cause the
> > > Command Completed bit to be set.  Controllers from AMD and Nvidia are
> > > reported to have similar errata.
> > > 
> > > These errata cause timeouts when pcie_enable_notification() enables
> > > interrupts.  Previously that timeout occurred at boot-time.  With this
> > > change, the timeout occurs later, when we change the state of the slot
> > > power, indicators, or interlock.  This speeds up boot but causes a timeout
> > > at the first hotplug event on the slot.  Subsequent events don't timeout
> > > because only the first (boot-time) hotplug command updates Slot Control
> > > without touching the power/indicator/interlock controls.
> > 
> > It sounds like we need some sort of completion mask to handle devices
> > like this, instead of effectively removing the write-barrier for the
> > general case.  Thanks,
> 
> You mean some quirk-based solution, where we know certain devices don't
> indicate command completion for certain events?  That seems hard because I
> think there are many devices that have this erratum.  It was difficult to
> extract this out of Intel, and I'm pretty sure other vendors have the same
> issue.

Yeah, I was thinking of a bitmap where we could quirk non-completion of
devices, but maybe it's not worth it.  Thanks,

Alex

