Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Fri, 7 Apr 2017 15:21:02 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Mason <slash.tmp@free.fr>
Subject: Re: Enumerating an empty bus hangs the entire system
Message-ID: <20170407202101.GA17896@bhelgaas-glaptop.roam.corp.google.com>
References: <1eeea8ff-0840-a005-38b4-61f3c253cee1@free.fr>
 <d0bdd0da-e6f6-396f-486a-7b1685d45d69@free.fr>
MIME-Version: 1.0
In-Reply-To: <d0bdd0da-e6f6-396f-486a-7b1685d45d69@free.fr>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 linux-pci <linux-pci@vger.kernel.org>,
 Thibaud Cornic <thibaud_cornic@sigmadesigns.com>,
 Liviu Dudau <liviu.dudau@arm.com>, David Laight <david.laight@aculab.com>,
 Phuong Nguyen <phuong_nguyen@sigmadesigns.com>,
 Robin Murphy <robin.murphy@arm.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Apr 07, 2017 at 05:15:32PM +0200, Mason wrote:
> On 15/03/2017 16:25, Mason wrote:
> 
> > My driver works reasonably well on revision 1 of the PCIe controller.
> > (For lax enough values of "reasonably well"...)
> > 
> > So I wanted to try it out on revision 2 of the controller.
> > 
> > Turns out the system hangs if I boot with no card inserted in the PCIe
> > slot. (This does not happen on revision 1.) If I log all config space
> > accesses, this is what I see:
> > 
> > ...
> > [    2.966402] tango_config_read: bus=0 devfn=0 where=128 size=2
> > [    2.972284] tango_config_read: bus=0 devfn=0 where=140 size=4
> > [    2.978167] tango_config_read: bus=0 devfn=0 where=146 size=2
> > [    2.984144] pci_bus 0000:01: busn_res: can not insert [bus 01-ff] under [bus 00-3f] (conflicts with (null) [bus 00-3f])
> > [    2.995105] tango_config_write: bus=0 devfn=0 where=24 size=4 val=0xff0100
> > [    3.002134] pci_bus 0000:01: scanning bus
> > [    3.006274] tango_config_read: bus=1 devfn=0 where=0 size=4
> > 
> > Basically, the PCI framework tries to read vendor and device IDs
> > of the non-existent device on bus 1, which hangs the system,
> > because the read never completes :-(
> > 
> > I had the same problem with the legacy driver for 3.4 but I was
> > hoping I would magically avoid it in a recent kernel.
> > 
> > The only work-around I see is: assuming the first access to a
> > bus will be to register 0, check the PHY for an active link
> > before sending an actual read request to register 0.
> > 
> > Is that reasonable?
> > 
> > Is it compliant for the PCIe controller to hang like that,
> > or should it handle some kind of time out?
> > 
> > Liviu suggested: "The PCIe controller probably generates (or propagates)
> > a bus abort that it should actually trap in HW. Check if there is a SW
> > configurable way to recover that."
> > 
> > But I unmasked all system/misc errors, and I don't see any
> > interrupts firing.
> 
> I now have a better understanding of the situation, which inevitably
> leads to more questions...
> 
> By reading a controller-specific debug register, I sampled the LTSSM
> (Link Training and Status State-Machine) value as fast as possible.
> 
> A) if there is no card inserted in the PCIe slot, the State-Machine
> oscillates between "Detect.Quiet" and "Detect.Active" SubStates of
> the "Detect" State.
> 
> B) if there is a card inserted in the PCIe slot, then after a few
> milliseconds, the State-Machine changes to "Polling.Active", then
> "Polling.Configuration", then "Configuration" (this step must be
> very short, because I don't see it consistently), then "L0".
> 
> 
> One issue I noted in a separate message is that, on rev1 of my HW,
> if the PCIe framework tries to read the card's device ID too soon,
> i.e. before link training is complete, then the read returns ~0,
> and the framework immediately gives up.
> 
> Looking at pci_bus_read_dev_vendor_id(), I see that there is a
> retry mechanism implemented, but it seems to be a quirk?

Configuration Request Retry is not a quirk; it's a standard part of
PCIe (see PCIe r3.1, sec 7.8.13), and pci_enable_crs() enables it
whenever a Root Port claims to support it.

> Does the framework expect pci_bus_read_dev_vendor_id() to always
> succeed when there is indeed a device on that specific bus?

Yes.

> In that cas, my driver needs to take care of only starting enumeration
> once the link to the PCIe card is really "up" and functional?

Yes.  Most of the drivers in drivers/pci/host/ have a
*_wait_for_link() function that does this.  I would start by copying
that style.

> I was given the advice to move the link detection code to the
> probe function, and reset the host bridge (to save power) when
> no link is detected after some time. What do you think?

I would copy what the other drivers do.  After you have a stable,
working driver, you can worry about power.

Bjorn

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
