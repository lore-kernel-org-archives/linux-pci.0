Return-Path: <SRS0=+k2b=XY=intel.com=ashok.raj@kernel.org>
Return-Path: <SRS0=+k2b=XY=intel.com=ashok.raj@kernel.org>
Date: Fri, 9 Dec 2016 13:11:09 -0800
From: "Raj, Ashok" <ashok.raj@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Keith Busch <keith.busch@intel.com>, linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, ashok.raj@intel.com
Subject: Re: [PATCH 3/3] pciehp: Fix race condition handling surprise
 link-down
Message-ID: <20161209211109.GA18093@otc-nc-03>
References: <1479544367-7195-1-git-send-email-ashok.raj@intel.com>
 <1479544367-7195-4-git-send-email-ashok.raj@intel.com>
 <20161207234054.GL22129@bhelgaas-glaptop.roam.corp.google.com>
 <20161208000433.GD25959@localhost.localdomain>
 <20161208151158.GB19822@bhelgaas-glaptop.roam.corp.google.com>
 <20161208172058.GH25959@localhost.localdomain>
 <20161208175009.GA28421@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161208175009.GA28421@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn

Thanks. I have resent the last patch again with consistent lock usage as you
had requested.

I did attempt to make things a bit more easier to understand in one my
earlier experiments, but that resulted in very substantial changes. 
Certainly something we should look in future to make the state machine 
more robust.

Cheers,
Ashok

On Thu, Dec 08, 2016 at 11:50:09AM -0600, Bjorn Helgaas wrote:
> > Yes, the alloc_ordered_workqueue is what I had in mind, though switching
> > to that is not as simple as calling the different API. I am looking into
> > that for longer term, but for the incremental fix, do you think we can
> > go forward with Raj's proposal?
> 
> I'd like to at least see a consistent locking strategy for protecting
> p_slot->state.  All the existing updates are protected by
> p_slot->lock, but the one Raj is adding is protected by
> p_slot->hotplug_lock.
> 
> Bjorn
