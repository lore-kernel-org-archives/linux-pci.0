Return-Path: <SRS0=DQv2=XX=intel.com=keith.busch@kernel.org>
Return-Path: <SRS0=DQv2=XX=intel.com=keith.busch@kernel.org>
Date: Thu, 8 Dec 2016 12:20:58 -0500
From: Keith Busch <keith.busch@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 3/3] pciehp: Fix race condition handling surprise
 link-down
Message-ID: <20161208172058.GH25959@localhost.localdomain>
References: <1479544367-7195-1-git-send-email-ashok.raj@intel.com>
 <1479544367-7195-4-git-send-email-ashok.raj@intel.com>
 <20161207234054.GL22129@bhelgaas-glaptop.roam.corp.google.com>
 <20161208000433.GD25959@localhost.localdomain>
 <20161208151158.GB19822@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161208151158.GB19822@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>

On Thu, Dec 08, 2016 at 09:11:58AM -0600, Bjorn Helgaas wrote:
> On Wed, Dec 07, 2016 at 07:04:33PM -0500, Keith Busch wrote:
> > 
> > It currently looks safe to nest the p_slot->lock under the
> > p_slot->hotplug_lock if that is you recommendation.
> 
> I'm not making a recommendation; that would take a lot more thought
> than I've given this.
> 
> There are at least three locks in pciehp:
> 
>   struct controller.ctrl_lock
>   struct slot.lock
>   struct slot.hotplug_lock
> 
> There shouldn't really be any performance paths in pciehp, so I'm
> pretty doubtful that we need such complicated locking.

They are protecting different things, but I agree it looks like room
for simplification exists.
 
> > Alternatively we could fix this if we used an ordered work queue for
> > the slot's work, but that is a significantly more complex change.
> 
> You mean we can currently execute things from the work queue in a
> different order than they were enqueued?  That sounds ... difficult to
> analyze, to say the least.

The events are dequeued in order, but they don't wait for the previous
to complete, so pciehp's current work queue can have multiple events
executing in parallel. That's part of why rapid pciehp slot events are
a little more difficult to follow, and I think we may even be unsafely
relying on the order the mutexes are obtained from these work events.

Partly unrelated, we could process surprise removals significantly
faster (microseconds vs. seconds), with the limited pci access series
here, giving fewer simultaneously executing events to consider:

 https://www.spinics.net/lists/linux-pci/msg55585.html

Do you have any concerns with that series?

> I don't know much about work queues, and Documentation/workqueue.txt
> doesn't mention alloc_ordered_workqueue().  Is that what you are
> referring to?

Yes, the alloc_ordered_workqueue is what I had in mind, though switching
to that is not as simple as calling the different API. I am looking into
that for longer term, but for the incremental fix, do you think we can
go forward with Raj's proposal?
