Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:33294 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751604AbaASKgI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Sun, 19 Jan 2014 05:36:08 -0500
Date: Sun, 19 Jan 2014 12:39:13 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: eiichiro.oiwa.nm@hitachi.com,
	Sander Eikelenboom <linux@eikelenboom.it>,
	Dave Airlie <airlied@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Jesse Barnes <jbarnes@virtuousgeek.org>,
	David Airlie <airlied@linux.ie>
Subject: Re: Re[2]: In "pci_fixup_video" check if this is or should be
 theprimaryvideo d
Message-ID: <20140119103913.GA4195@redhat.com>
References: <XNM1$9$0$4$$3$3$7$A$9006870U52d8928d@hitachi.com>
 <CAErSpo678TwmMu7tB5u2uWogLCvQPyoZeXz3Do52XUTSGjYAwg@mail.gmail.c>
 <XNM1$9$0$4$$3$3$7$A$9006873U52d90952@hitachi.com>
 <CAErSpo5oi1cMyXiLAOd5j5Gi0GwKZ7-LD-TkD6r8HM5TBEq3Dg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAErSpo5oi1cMyXiLAOd5j5Gi0GwKZ7-LD-TkD6r8HM5TBEq3Dg@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jan 17, 2014 at 08:39:45AM -0700, Bjorn Helgaas wrote:
> On Fri, Jan 17, 2014 at 3:43 AM,  <eiichiro.oiwa.nm@hitachi.com> wrote:
> 
> To make progress here, I think you'll have to be even more detailed.

sorry, could you restate what the problem is please?

It all started with Sander trying to have two
video cards on his VM.
I suggested several solutions.
See 20140115190315.GA6661@redhat.com

Is there any other problematic configuration that's
not addressed by any of the suggested solutions?

> > Because legacy VGA is only one device on x86 System,
> 
> Where is it documented that there can be only one legacy VGA device in
> an x86 system?  I assume there exists a system with two slots on bus
> 0.  What happens if a user installs two VGA cards in those slots?
> Does that prevent the system from working at all because it's an
> illegal configuration?
> 
> I think such a system could work correctly if the I/O Space and Memory
> Space bits in the command registers were only set on one of the VGA
> devices.

Yes.
If you like, this is a bios bug - it enabled both devices.
But the disabled device would be completely non functional -
one wonders why have it in the first place.
So the cure's worse than the illness - at the moment
things actually kind of work because only one of
the devices actually claims the VGA addresses.

> > I think qemu has to emulate a bridge
> > for legacy VGA.
> 
> My Lenovo T410 has "00:02.0 VGA compatible controller," which I assume
> would qualify as a "legacy VGA device," and there's no bridge related
> to it.

If it says (prog-if 00 [VGA controller]) then it is.


> > The VGA Enable bit on its bridge control register has to set to 1. The VGA
> > Enable bit describes in Table 3-10 Bridge Control register. When there are two VGA cards
> > on the same system, I think its system needs two bridges for each device.
> 
> I think you meant to say that if there are two VGA cards, we need
> *one* bridge for each device, e.g., two bridges and two VGA cards.

No, it's enough to have one device behind a bridge
with disabled VGA forwarding.

> But where does the requirement for the bridges come from?

The bridge is just a way to filter out VGA addresses
without disabling memory and IO on the device.
PCI spec could include a device independent flag to
disable VGA on the device, but it does not have that.

> > These bridges
> > need bridge control registers. One VGA Enable bit on its bridge for legacy VGA has to set
> > to 1. Another VGA Enable bit for second VGA has to set to 0.
> 
> If you have a set of peer bridges, i.e., bridges on the same primary
> bus, I agree that at most one of them should have VGA Enable set.  If
> more than one had VGA Enable set, a read on the primary bus could
> receive multiple responses, which would be a PCI protocol violation.
> 
> Similarly, if there are multiple VGA devices on the same bus, I
> believe that at most one could have I/O Space and Memory Space enabled
> in their command registers.
> 
> But I don't see the requirement for a bridge for every VGA device.

No, as long as you don't need all of them to work.

> >>On Thu, Jan 16, 2014 at 7:16 PM,  <eiichiro.oiwa.nm@hitachi.com> wrote:
> >>> I think qemu is breaking "PCI-to-PCI Bridge Architecture Specification Revison 1.2
> >>> June 9, 2003 Chapter 12. VGA Support".
> >>
> >>And what exactly do you think qemu is doing wrong?  Chapter 12 is ten
> >>pages long.  Is there something there that prohibits two VGA devices
> >>on the same bus?  I'm not a qemu developer, but if I were, I would
> >>need a better hint about what is wrong before I could fix it.
> >>
> >>Again, sorry if you said this already and I missed it.
> >>
> >>>>[+cc Michael, Jesse, David, qemu-devel]
> >>>>
> >>>>On Wed, Jan 15, 2014 at 8:58 PM,  <eiichiro.oiwa.nm@hitachi.com> wrote:
> >>>>> I suggest you should not break the PCI specification, as a developer of proprietary
> >>>>> hypervisor, but I think your patch is no problem.
> >>>>> Your PCI structure is specialized structure for your virtual machine.
> >>>>> Maybe, your virtual machine will be causing another problem on Linux or other kernels
> >>>>> because of breaking the PCI specification.
> >>>>
> >>>>I assume you think qemu is breaking the PCI spec.  What exactly do you
> >>>>think is broken?  Please give specific references to the spec.  This
> >>>>conversation is pretty fragmented, and I came in late, so I apologize
> >>>>if I missed this.
> >>>>
> >>>>Bjorn
> >>>>
> >>
