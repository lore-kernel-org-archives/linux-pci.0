Return-Path: <SRS0=0XkI=5T=wp.pl=kubakici@kernel.org>
Return-Path: <SRS0=0XkI=5T=wp.pl=kubakici@kernel.org>
Date: Tue, 13 Jun 2017 21:57:13 -0700
From: Jakub Kicinski <kubakici@wp.pl>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Emil Tantilov <emil.s.tantilov@intel.com>,
 Alexander Duyck <alexander.h.duyck@intel.com>, oss-drivers@netronome.com
Subject: Re: [PATCH] pci: iov: use device lock to protect IOV sysfs accesses
Message-ID: <20170613215713.42af408e@cakuba.netronome.com>
In-Reply-To: <20170530163429.07977942@cakuba.lan>
References: <20170522225023.14010-1-jakub.kicinski@netronome.com>
	<20170526234726.GD21531@bhelgaas-glaptop.roam.corp.google.com>
	<20170526165820.7ec488e3@cakuba.netronome.com>
	<20170530230718.GG14896@bhelgaas-glaptop.roam.corp.google.com>
	<20170530163429.07977942@cakuba.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-pci.vger.kernel.org>

On Tue, 30 May 2017 16:34:29 -0700, Jakub Kicinski wrote:
> On Tue, 30 May 2017 18:07:18 -0500, Bjorn Helgaas wrote:
> > On Fri, May 26, 2017 at 04:58:20PM -0700, Jakub Kicinski wrote:  
> > > On Fri, 26 May 2017 18:47:26 -0500, Bjorn Helgaas wrote:    
> > > > On Mon, May 22, 2017 at 03:50:23PM -0700, Jakub Kicinski wrote:    
> > > > > PCI core sets the driver pointer before calling ->probe() and only
> > > > > clears it after ->remove().  This means driver's ->sriov_configure()
> > > > > callback will happily race with probe() and remove(), most likely
> > > > > leading to BUGs, since drivers don't expect this.      
> > > > 
> > > > I guess you're referring to the pci_dev->driver pointer set by
> > > > local_pci_probe(), and this is important because sriov_numvfs_store()
> > > > checks that pointer, right?    
> > > 
> > > Yes, exactly.  I initially thought this is how the safety of sriov
> > > callback may have been ensured, but since the order of
> > > local_pci_probe() and the assignment is what it is, it can't.    
> > 
> > Right.  I was hoping other subsystems would establish a convention
> > about whether we set the ->driver pointer before or after calling the
> > driver probe() method, but if there is one, I don't see it.
> > local_pci_probe() and really_probe() set ->driver first, but
> > pnp_device_probe() calls the probe() method first.  
> 
> I didn't dig into reordering the pointer setting, to be honest.  I
> thought establishing that driver callbacks should generally hold device
> lock, whenever possible, would be even better than pointer setting
> conventions.
> 
> If we order the assignments better, wouldn't we still need appropriate
> memory barriers to rely on the order? (:
> 
> > Can you expand on how you reproduce this problem?  The only real way I
> > see to call ->sriov_configure() is via the sysfs entry point, and I
> > would think user-space code would typically not touch that until after
> > it knows the driver has claimed a device.  But I can certainly imagine
> > targeted test code that could hit this problem.  
> 
> Correct.  It's not something that users should be triggering often in
> normal use.  I also found it by code inspection rather than by getting
> an oops.
> 
> OTOH if the driver performs FW load or other time-consuming operations
> in ->probe() the time window when this can be triggered may be counted
> in seconds.

Hi Bjorn, 

is this patch still considered for 4.13, or should I change it somehow?
