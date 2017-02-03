Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 3 Feb 2017 10:51:04 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Raj, Ashok" <ashok.raj@intel.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org, Keith Busch <keith.busch@intel.com>
Subject: Re: [PATCH] pciehp: Fix race condition handling surprise link-down
Message-ID: <20170203165104.GC15080@bhelgaas-glaptop.roam.corp.google.com>
References: <1481317564-18045-1-git-send-email-ashok.raj@intel.com>
 <20170203025901.GA15080@bhelgaas-glaptop.roam.corp.google.com>
 <20170203060053.GA240323@otc-nc-03>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170203060053.GA240323@otc-nc-03>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Feb 02, 2017 at 10:00:53PM -0800, Raj, Ashok wrote:
> Hi Bjorn
> 
> On Thu, Feb 02, 2017 at 08:59:01PM -0600, Bjorn Helgaas wrote:
> > Hi Ashok,
> > 
> > Sorry it took me so long to review this.  I never felt like I really
> > understood it, and it took me a long time to try to figure out a more
> > useful response.
> 
> No worries. Agree its a litte tricky, and took me several iterations before
> doing someting that was simple enough, without a complete overhaul of
> state management. 
> 
> Thanks a ton for capturing the sequence, I did capture
> some debug output along at that time. My apologies for not adding it
> along. But this becomes excellant notes and perhaps would be good to 
> capture in commit or in the documentation. Going through this isn't fun :-)

Maybe you could open a kernel.org bugzilla and attach the dmesg log
and "lspci -vv" output.  Then we could capture some of your logs and
this discussion there and include a pointer in the changelog.

> Responses below:
> > > 
> > > This patch fixes that by setting the p_slot->state only when the work to
> > > handle the power event is executing, protected by the p_slot->hotplug_lock.
> > 
> > So let me first try to understand what's going on with the current
> > code.  In the normal case where a device is removed or turned off and
> > pciehp can complete everything before another device appears, I think
> > the flow is like this:
> 
> You got this problem part right. Spot on!
> > 
> >       p_slot->state == STATIC_STATE (powered on, link up)
> > 
> >                         <-- surprise link down interrupt
> >       pciehp_isr()
> >         queue INT_LINK_DOWN work
> > 
> >       interrupt_event_handler(INT_LINK_DOWN)
> >         set p_slot->state = POWEROFF_STATE
> >         queue DISABLE_REQ work
> > 
> >       pciehp_power_thread(DISABLE_REQ)
> >         send PCI_EXP_SLTCTL_PWR_OFF command
> >         wait for power-off to complete
> >         set p_slot->state = STATIC_STATE
> > 
> >       p_slot->state == STATIC_STATE (powered off)
> > 
> > In the problem case, the link goes down, and while pciehp is still
> > dealing with that, the link comes back up.  So I think one possible
> > sequence is like this:
> > 
> >       p_slot->state == STATIC_STATE (powered on, link up)
> > 
> >                         <-- surprise link down interrupt
> >   1a  pciehp_isr()
> >         queue INT_LINK_DOWN work                     # queued: 1-LD
> > 
> >   1b  interrupt_event_handler(INT_LINK_DOWN)         # process 1-LD
> >         # handle_link_event() sees case STATIC_STATE
> >         set p_slot->state = POWEROFF_STATE
> >         queue DISABLE_REQ work                       # queued: 1-DR
> > 
> >                         <-- surprise link up interrupt
> >   2a  pciehp_isr()
> >         queue INT_LINK_UP work                       # queued: 1-DR 2-LU
> > 
> >   1c  pciehp_power_thread(DISABLE_REQ)               # process 1-DR
> >         send PCI_EXP_SLTCTL_PWR_OFF command
> >         wait for power-off to complete
> >         set p_slot->state = STATIC_STATE
> > 
> >                         <-- link down interrupt (result of PWR_OFF)
> >   3a  pciehp_isr()
> >         queue INT_LINK_DOWN work                     # queued: 2-LU 3-LD
> > 
> >   2b  interrupt_event_handler(INT_LINK_UP)           # process 2-LU
> >         # handle_link_event() sees case STATIC_STATE
> >         set p_slot->state = POWERON_STATE
> >         queue ENABLE_REQ work                        # queued: 3-LD 2-ER
> > 
> >   3b  interrupt_event_handler(INT_LINK_DOWN)         # process 3-LD
> >         # handle_link_event() sees case POWERON_STATE, so we emit
> >         # "Link Down event queued; currently getting powered on"
> >         set p_slot->state = POWEROFF_STATE
> >         queue DISABLE_REQ work                       # queued: 2-ER 3-DR
> > 
> >   2c  pciehp_power_thread(ENABLE_REQ)                # process 2-ER
> >         send PCI_EXP_SLTCTL_PWR_ON command
> >         wait for power-on to complete
> >         set p_slot->state = STATIC_STATE
> > 
> >                         <-- link up interrupt (result of PWR_ON)
> >   4a  pciehp_isr()
> >         queue INT_LINK_UP work                       # queued: 3-DR 4-LU
> > 
> >   3c  pciehp_power_thread(DISABLE_REQ)               # process 3-DR
> >         send PCI_EXP_SLTCTL_PWR_OFF command
> >         wait for power-off to complete
> >         set p_slot->state = STATIC_STATE
> > 
> >                         <-- link down interrupt (result of PWR_OFF)
> >   5a  pciehp_isr()
> >         queue INT_LINK_DOWN work                     # queued: 4-LU 5-LD
> > 
> > State 5a is the same as 3a (we're in STATIC_STATE with Link Up and
> > Link Down work items queued), so the whole cycle can repeat.
> > 
> > Now let's assume we apply this patch and see what changes.  The patch
> > changes where we set p_slot->state.  Currently we set POWEROFF_STATE
> > or POWERON_STATE in the interrupt_event_handler() work item.  The
> > patch moves that to the pciehp_power_thread() work item, where the
> > power commands are actually sent.
> 
> Right. The difference with this patch is when we set the state to 
> POWERON_STATE or POWEROFF_STATE, we only do that when the previous
> POWER* operation has entirely completed. Since now its protected with the
> hotplug_lock mutex.
> 
> In the problem case, since we set the state before the pciehp_power_thread,
> we end up changing the state to POWER*_STATE before the previous POWER*
> action has completed.
> > 
> >       p_slot->state == STATIC_STATE (powered on, link up)
> > 
> >                         <-- surprise link down interrupt
> >   1A  pciehp_isr()
> >         queue INT_LINK_DOWN work                     # queued: 1-LD
> > 
> >   1B  interrupt_event_handler(INT_LINK_DOWN)         # process 1-LD
> >         # handle_link_event() sees case STATIC_STATE
> >         # set p_slot->state = POWEROFF_STATE         # (removed by patch)
> >         queue DISABLE_REQ work                       # queued: 1-DR
> > 
> >                         <-- surprise link up interrupt
> >   2A  pciehp_isr()
> >         queue INT_LINK_UP work                       # queued: 1-DR 2-LU
> > 
> >   1C  pciehp_power_thread(DISABLE_REQ)               # process 1-DR
> 
> 	Also mutex hotplug_lock is held.
> 
> >         set p_slot->state = POWEROFF_STATE           # (added by patch)
> >         send PCI_EXP_SLTCTL_PWR_OFF command
> >         wait for power-off to complete
> >         set p_slot->state = STATIC_STATE
> > 
> >                         <-- link down interrupt (result of PWR_OFF)
> >   3A  pciehp_isr()
> >         queue INT_LINK_DOWN work                     # queued: 2-LU 3-LD
> 
> The above INT_LINK_DOWN will eventually be ignored in handle_link_event()
> because we are in POWEROFF_STATE, and a link down while in POWEROFF will
> be ignored.
> > 
> >   2B  interrupt_event_handler(INT_LINK_UP)           # process 2-LU
> >         # handle_link_event() sees case STATIC_STATE
> >         # set p_slot->state = POWERON_STATE          # (removed by patch)
> >         queue ENABLE_REQ work                        # queued: 3-LD 2-ER
> > 
> >   3B  interrupt_event_handler(INT_LINK_DOWN)         # process 3-LD
> >         # handle_link_event() sees case STATIC_STATE,
> >         # unlike 3b above, which saw POWERON_STATE;
> >         # doesn't emit a message, but still queues DISABLE_REQ
> >         # set p_slot->state = POWEROFF_STATE         # (removed by patch)
> >         queue DISABLE_REQ work                       # queued: 2-ER 3-DR
> 
> 3B will be ignored, since handle_link_event() knows we are in process
> of POWEROFF.

What enforces this ordering?  handle_link_event() will only see
POWEROFF_STATE if it happens to read the state after
pciehp_power_thread() sets POWEROFF_STATE and before it
sets it back to STATIC_STATE.  Given our work item concurrency,
I think that's possible, but I don't see how it's guaranteed.

> >   2C  pciehp_power_thread(ENABLE_REQ)                # process 2-ER
> 
> We are also protected by mutex hotplug_lock here. So  the following
> wont get executed until step 1C has run to completion and the 
> mutex is released.
> 
> >         set p_slot->state = POWERON_STATE            # (added by patch)
> >         send PCI_EXP_SLTCTL_PWR_ON command
> >         wait for power-on to complete
> >         set p_slot->state = STATIC_STATE
> > 
> >                         <-- link up interrupt (result of PWR_ON)
> >   4A  pciehp_isr()
> >         queue INT_LINK_UP work                       # queued: 3-DR 4-LU
> 
> handle_link_event() would eventually dismiss the INT_LINK_UP since
> it knows we are in process of POWERON.
> > 
> >   3C  pciehp_power_thread(DISABLE_REQ)               # process 3-DR
> >         set p_slot->state = POWEROFF_STATE           # (added by patch)
> >         send PCI_EXP_SLTCTL_PWR_OFF command
> >         wait for power-off to complete
> >         set p_slot->state = STATIC_STATE
> > 
> >                         <-- link down interrupt (result of PWR_OFF)
> >   5A  pciehp_isr()
> >         queue INT_LINK_DOWN work                     # queued: 4-LU 5-LD
> > 
> > With this particular ordering, I think we still have the same problem:
> > 5A is the same as 3A, so I think the cycle could repeat.
> 
> I think the sequence is almost right, except the fact since we are protected
> by hotplug_lock, we don't allow another POWERON or POWEROFF to be processed
> until the previous POWER* operation is completed entirely.

handle_link_event() is protected by "lock" but not by "hotplug_lock",
so I think it can queue ENABLE/DISABLE items even before the previous
POWER* operation completes.

You're right that I omitted the hotplug_lock details.  I added them to
my outline (at https://goo.gl/szqWTC if you're interested), but I
don't see how that prevents the scenario above.

> Just to summarize, we only queue the POWEROFF due to surprise link down
> and another POWERON due to link becoming back up. The transient link-down 
> events are coveniently ignored.

I'm leery about ignoring events, though it happens to be convenient in
this case.  I think we're ignoring them because we're running work
items simultaneously with other items, and I think that concurrency is
unnecessary complexity.

I think it would be safer to queue every event and process every event
serially.
