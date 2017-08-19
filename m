Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Fri, 18 Aug 2017 21:55:53 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: David Daney <ddaney@caviumnetworks.com>
Subject: Re: [PATCH v2 3/3] vfio/pci: Don't probe devices that can't be reset
Message-ID: <20170818215553.3396d509@ul30vt.home>
In-Reply-To: <d7492153-ec84-eb87-13ac-eb3fc9116114@caviumnetworks.com>
References: <1502957663-5527-1-git-send-email-jglauber@cavium.com>
 <1502957663-5527-4-git-send-email-jglauber@cavium.com>
 <20170817070017.1e9c9456@w520.home> <20170818134231.GA3464@hc>
 <20170818081251.2bbffe56@w520.home>
 <d7492153-ec84-eb87-13ac-eb3fc9116114@caviumnetworks.com>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: kvm@vger.kernel.org, david.daney@cavium.com, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jan Glauber <jan.glauber@caviumnetworks.com>,
 Robert Richter <robert.richter@cavium.com>, Jon Masters <jcm@redhat.com>,
 Bjorn Helgaas <bhelgaas@google.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, 18 Aug 2017 08:57:09 -0700
David Daney <ddaney@caviumnetworks.com> wrote:

> On 08/18/2017 07:12 AM, Alex Williamson wrote:
> > On Fri, 18 Aug 2017 15:42:31 +0200
> > Jan Glauber <jan.glauber@caviumnetworks.com> wrote:
> >   
> >> On Thu, Aug 17, 2017 at 07:00:17AM -0600, Alex Williamson wrote:  
> >>> On Thu, 17 Aug 2017 10:14:23 +0200
> >>> Jan Glauber <jglauber@cavium.com> wrote:
> >>>      
> >>>> If a PCI device supports neither function-level reset, nor slot
> >>>> or bus reset then refuse to probe it. A line is printed to inform
> >>>> the user.  
> >>>
> >>> But that's not what this does, this requires that the device is on a
> >>> reset-able bus.  This is a massive regression.  With this we could no
> >>> longer assign devices on the root complex or any device which doesn't
> >>> return from bus reset and currently makes use of the NO_BUS_RESET flag
> >>> and works happily otherwise.  Full NAK.  Thanks,  
> >>
> >> Looks like I missed the slot reset check. So how about this:
> >>
> >> if (pci_probe_reset_slot(pdev->slot) && pci_probe_reset_bus(pdev->bus)) {
> >> 	dev_warn(...);
> >> 	return -ENODEV;
> >> }
> >>
> >> Or am I still missing something here?  
> > 
> > We don't require that a device is on a reset-able bus/slot, so any
> > attempt to impose that requirement means that there are devices that
> > might work perfectly fine that are now excluded from assignment.  The
> > entire premise is unacceptable.  Thanks,  
> 
> 
> You previously rejected the idea to silently ignore bus reset requests 
> on buses that do not support it.
> 
> So this leaves us with two options:
> 
> 1) Do nothing, and crash the kernel on systems with bad combinations of 
> PCIe target devices and cn88xx when vfio_pci is used.
> 
> 2) Do something else.
> 
> We are trying to figure out what that something else should be.  The 
> general concept we are working on is that if vfio_pci wants to reset a 
> device, *and* bus reset is the only option available, *and* cn88xx, then 
> make vfio_pci fail.

But that's not what these attempts do, they say if we can't do a bus or
slot reset, fail the device probe.  The comment is trying to suggest
they do something else, am I misinterpreting the actual code change?
There are plenty of devices out there that don't care if bus reset
doesn't work, they support FLR or PM reset or device specific reset or
just deal without a reset.  We can't suddenly say this new thing is a
requirement and sorry if you were happily using device assignment
before, but there's a slim chance you're on this platform that falls
over if we attempt to do a secondary bus reset.

> What is your opinion of doing that (assuming it is properly implemented)?

It seems like these attempts are trying to completely turn off vfio-pci
on cn88xx, do you just want it unsupported on these platforms?  Should
we blacklist anything where dev->bus->self is this root port?
Otherwise, what's wrong with returning an error if a bus reset fails,
because we should *never* silently ignore the request and pretend that
it worked, perhaps even dev_warn()'ing that the platform doesn't
support bus resets?  Thanks,

Alex

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
