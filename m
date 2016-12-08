Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:58076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752496AbcLHPMD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 8 Dec 2016 10:12:03 -0500
Date: Thu, 8 Dec 2016 09:11:58 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Keith Busch <keith.busch@intel.com>
Cc: Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 3/3] pciehp: Fix race condition handling surprise
 link-down
Message-ID: <20161208151158.GB19822@bhelgaas-glaptop.roam.corp.google.com>
References: <1479544367-7195-1-git-send-email-ashok.raj@intel.com>
 <1479544367-7195-4-git-send-email-ashok.raj@intel.com>
 <20161207234054.GL22129@bhelgaas-glaptop.roam.corp.google.com>
 <20161208000433.GD25959@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161208000433.GD25959@localhost.localdomain>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Dec 07, 2016 at 07:04:33PM -0500, Keith Busch wrote:
> On Wed, Dec 07, 2016 at 05:40:54PM -0600, Bjorn Helgaas wrote:
> > On Sat, Nov 19, 2016 at 12:32:47AM -0800, Ashok Raj wrote:
> > > --- a/drivers/pci/hotplug/pciehp_ctrl.c
> > > +++ b/drivers/pci/hotplug/pciehp_ctrl.c
> > > @@ -182,6 +182,7 @@ static void pciehp_power_thread(struct work_struct *work)
> > >  	switch (info->req) {
> > >  	case DISABLE_REQ:
> > >  		mutex_lock(&p_slot->hotplug_lock);
> > > +		p_slot->state = POWEROFF_STATE;
> > 
> > It sounds right that p_slot->state should be protected.
> > 
> > It looks like handle_button_press_event() and
> > pciehp_sysfs_enable_slot() hold p_slot->lock while updating
> > p_slot->state.
> > 
> > You're setting "state = POWEROFF_STATE" while holding
> > p_slot->hotplug_lock (not p_slot->lock).  Four lines down, we set
> > "state = STATIC_STATE", but this time we're holding p_slot->lock.
> > 
> > What is the difference between the p_slot->lock and
> > p_slot->hotplug_lock?  Do we need both?  How do we know which one to
> > use?
> > 
> > I'm very confused.
> 
> This is _very_ confusing. :)
> 
> The p_slot->hotplug_lock serializes a power off and a power on event. We
> only want to set the state when one of those events gets to execute
> rather than when the event is queued. Changing the state when the event
> is queued can trigger a never ending up-down sequence.
> 
> It currently looks safe to nest the p_slot->lock under the
> p_slot->hotplug_lock if that is you recommendation.

I'm not making a recommendation; that would take a lot more thought
than I've given this.

There are at least three locks in pciehp:

  struct controller.ctrl_lock
  struct slot.lock
  struct slot.hotplug_lock

There shouldn't really be any performance paths in pciehp, so I'm
pretty doubtful that we need such complicated locking.

> Alternatively we could fix this if we used an ordered work queue for
> the slot's work, but that is a significantly more complex change.

You mean we can currently execute things from the work queue in a
different order than they were enqueued?  That sounds ... difficult to
analyze, to say the least.

I don't know much about work queues, and Documentation/workqueue.txt
doesn't mention alloc_ordered_workqueue().  Is that what you are
referring to?

Bjorn
