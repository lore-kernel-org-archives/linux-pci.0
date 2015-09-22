Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 22 Sep 2015 17:07:19 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-kernel@vger.kernel.org, Fam Zheng <famz@redhat.com>,
	Yinghai Lu <yhlu.kernel.send@gmail.com>,
	Ulrich Obergfell <uobergfe@redhat.com>,
	Rusty Russell <rusty@rustcorp.com.au>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	linux-pci@vger.kernel.org,
	virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v7] pci: quirk to skip msi disable on shutdown
Message-ID: <20150922164107-mutt-send-email-mst@redhat.com>
References: <1441553385-3810-1-git-send-email-mst@redhat.com>
 <20150921182147.GC27964@google.com>
 <20150921223622-mutt-send-email-mst@redhat.com>
 <20150921221043.GR25767@google.com>
 <20150922131303-mutt-send-email-mst@redhat.com>
 <20150922123640.GT25767@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150922123640.GT25767@google.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Sep 22, 2015 at 07:36:40AM -0500, Bjorn Helgaas wrote:
> On Tue, Sep 22, 2015 at 02:29:03PM +0300, Michael S. Tsirkin wrote:
> > On Mon, Sep 21, 2015 at 05:10:43PM -0500, Bjorn Helgaas wrote:
> > > On Mon, Sep 21, 2015 at 10:42:13PM +0300, Michael S. Tsirkin wrote:
> > > > On Mon, Sep 21, 2015 at 01:21:47PM -0500, Bjorn Helgaas wrote:
> > > > > On Sun, Sep 06, 2015 at 06:32:35PM +0300, Michael S. Tsirkin wrote:
> > > > > > On some hypervisors, virtio devices tend to generate spurious interrupts
> > > > > > when switching between MSI and non-MSI mode.  Normally, either MSI or
> > > > > > non-MSI is used and all is well, but during shutdown, linux disables MSI
> > > > > > which then causes an "irq %d: nobody cared" message, with irq being
> > > > > > subsequently disabled.
> > > > > 
> > > > > My understanding is:
> > > > > 
> > > > >   Linux disables MSI/MSI-X during device shutdown.  If the device
> > > > >   signals an interrupt after that, it may use INTx.
> > > > > 
> > > > > This INTx interrupt is not necessarily spurious.  Using INTx to signal an
> > > > > interrupt that occurs when MSI is disabled seems like reasonable behavior
> > > > > for any PCI device.
> > > > > And it doesn't seem related to switching between MSI and non-MSI mode.
> > > > > Yes, the INTx happens *after* disabling MSI, but it is not at all
> > > > > *because* we disabled MSI.  So I wouldn't say "they generate spurious
> > > > > interrupts when switching between MSI and non-MSI."
> > > > > 
> > > > > Why doesn't virtio-pci just register an INTx handler in addition to an MSI
> > > > > handler?
> > > > 
> > > > The handler causes an expensive exit to the hypervisor,
> > > > and the INTx lines are shared with other devices.
> > > 
> > > Do we care?  Is this a performance path?  I thought we were in a kexec
> > > shutdown path.
> > 
> > Yes but the handler would always have to be registered, right?
> 
> The pci_device_shutdown() path you're modifying calls drv->shutdown()
> immediately before disabling MSI, so I suppose you could register a
> handler in a virtio shutdown method.

I guess we could. Not sure what we'd do e.g. if that fails.

> > > > Seems silly to slow them down just so we can do something
> > > > that triggers the device bug.  The bus master is disabled by that time,
> > > > if linux can just desist from touching MSI enable device won't
> > > > send either INTx (because MSI is on) or MSI
> > > > (because bus master is on) and all will be well.
> > > 
> > > It would also be silly to put special-purpose code in the PCI core
> > > if there's a reasonable way to handle this in a driver.
> > > 
> > > Can you describe exactly what the device bug is?  Apparently you're
> > > saying that if we shut down MSI, it triggers the bug?  And I guess
> > > you're talking about a virtio device as implemented in qemu or other
> > > hypervisors?
> > 
> > Yes. Basically depending on an internal device state, disabling MSI
> > sometimes wedges it.  The most easy to debug effect is if it starts
> > sending INTx interrupts, for which there's no handler currently.
> > Full system reset always gets us out of the bad state.
> 
> If disabling MSI causes the device to use INTx interrupts, that sounds
> perfectly normal to me.
> 
> If disabling MSI causes the device to hang, *that* sounds like a bug.
> Since this is virtio, we should be able to figure out exactly where
> that happens.  Do you have a pointer to a virtio bug report, or even a
> QEMU commit that fixes this virtio bug?
> 
> I understand that even if there is a virtio fix in QEMU, we want a
> solution that works even with an old QEMU that doesn't contain the
> fix.  But a pointer to a QEMU fix would really help understand and
> document the Linux fix.
> 
> Bjorn

I'm not sure we ever understood it completely.

I think some of it has to do with the way the whole virtio 0
device register layout changes when you enable/disable MSI.  So should
be ok when using the modern virtio 1 model since we fixed this thing.

I was hoping that since disabling MSI in pci core is only useful as a
work-around (for devices with a broken bus master enable - even though I
don't think we know what these are exactly), a flag for not disabling it
won't be held to such a high standard.

-- 
MST
