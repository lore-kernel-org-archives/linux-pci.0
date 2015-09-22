Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 22 Sep 2015 10:46:24 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, Fam Zheng <famz@redhat.com>,
	Yinghai Lu <yhlu.kernel.send@gmail.com>,
	Ulrich Obergfell <uobergfe@redhat.com>,
	Rusty Russell <rusty@rustcorp.com.au>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	linux-pci@vger.kernel.org,
	virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v7] pci: quirk to skip msi disable on shutdown
Message-ID: <20150922154624.GF27964@google.com>
References: <1441553385-3810-1-git-send-email-mst@redhat.com>
 <20150921182147.GC27964@google.com>
 <20150921223622-mutt-send-email-mst@redhat.com>
 <20150921221043.GR25767@google.com>
 <20150922131303-mutt-send-email-mst@redhat.com>
 <20150922123640.GT25767@google.com>
 <20150922164107-mutt-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150922164107-mutt-send-email-mst@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Sep 22, 2015 at 05:07:19PM +0300, Michael S. Tsirkin wrote:
> On Tue, Sep 22, 2015 at 07:36:40AM -0500, Bjorn Helgaas wrote:
> > On Tue, Sep 22, 2015 at 02:29:03PM +0300, Michael S. Tsirkin wrote:
> > > On Mon, Sep 21, 2015 at 05:10:43PM -0500, Bjorn Helgaas wrote:

> > > > Can you describe exactly what the device bug is?  Apparently you're
> > > > saying that if we shut down MSI, it triggers the bug?  And I guess
> > > > you're talking about a virtio device as implemented in qemu or other
> > > > hypervisors?
> > > 
> > > Yes. Basically depending on an internal device state, disabling MSI
> > > sometimes wedges it.  The most easy to debug effect is if it starts
> > > sending INTx interrupts, for which there's no handler currently.
> > > Full system reset always gets us out of the bad state.
> > 
> > If disabling MSI causes the device to use INTx interrupts, that sounds
> > perfectly normal to me.
> > 
> > If disabling MSI causes the device to hang, *that* sounds like a bug.
> > Since this is virtio, we should be able to figure out exactly where
> > that happens.  Do you have a pointer to a virtio bug report, or even a
> > QEMU commit that fixes this virtio bug?
> > 
> > I understand that even if there is a virtio fix in QEMU, we want a
> > solution that works even with an old QEMU that doesn't contain the
> > fix.  But a pointer to a QEMU fix would really help understand and
> > document the Linux fix.
> 
> I'm not sure we ever understood it completely.
> 
> I think some of it has to do with the way the whole virtio 0
> device register layout changes when you enable/disable MSI.  So should
> be ok when using the modern virtio 1 model since we fixed this thing.

If you know that:

  - pci_device_shutdown() disables MSI,
  - disabling MSI changes the virtio register layout, and
  - the driver may touch the device after pci_device_shutdown(),

it seems like you might want a virtio shutdown method so you can
find out when the register layout changes.  Changing the register
layout sounds completely broken, and dealing with it sounds racy, but
it sounds like a mess that should be handled by the driver.

> I was hoping that since disabling MSI in pci core is only useful as a
> work-around (for devices with a broken bus master enable - even though I
> don't think we know what these are exactly), a flag for not disabling it
> won't be held to such a high standard.

Well, I suppose you see the problem with adding workarounds on top of
workarounds, especially when we don't have a clear understanding of
why we need them.  The "disable MSI on shutdown" code was added here:

http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=d52877c7b1af

and there is no information in that patch about it being a workaround
for devices with broken bus master enable.

The cumulative effect of stuff like this is that it becomes impossible
to do any meaningful restructuring in the core without breaking some
corner case.

Bjorn
