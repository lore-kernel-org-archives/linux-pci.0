Return-Path: <jonathan.derrick@intel.com>
Return-Path: <jonathan.derrick@intel.com>
Date: Thu, 22 Sep 2016 15:05:20 -0600
From: Jon Derrick <jonathan.derrick@intel.com>
To: Keith Busch <keith.busch@intel.com>
Cc: helgaas@kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCHv2] PCI/Hotplug: Schedule device add retries
Message-ID: <20160922210519.GA6274@localhost.localdomain>
References: <1474485155-10822-1-git-send-email-jonathan.derrick@intel.com>
 <20160922151811.GA14301@keith>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160922151811.GA14301@keith>
List-ID: <linux-pci.vger.kernel.org>

> >  err_exit:
> > +	if (ctrl->slot_retries++ < DEVICE_ADD_RETRIES) {
> > +		ctrl_dbg(ctrl, "Retrying (%d/%d) device add at %04x:%02x:00\n",
> > +			ctrl->slot_retries, DEVICE_ADD_RETRIES,
> > +			pci_domain_nr(parent), parent->number);
> > +		pciehp_queue_power_work(p_slot, ENABLE_RETRY_REQ);
> > +		return retval;
> > +	}
> 
> Does the retry need to be requeued instead of just doing this in a loop?

The requeue gives a little bit more time and performs the actions in pciehp_enable_slot in case something has changed.

We could push the loop to within pciehp_enable_slot, but that could cause us to potentially miss DISABLE_REQ events.
..
That brings up the question about racing with DISBALE_REQ. If a power controller is implemented, a DISABLE_REQ request will disable the slot, which could then be reenabled by the ENABLE_RETRY_REQ path. Would disabling and reenabling the slot's power just cause the same faults over and over again? I'm not so sure.
