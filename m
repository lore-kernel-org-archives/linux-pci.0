Return-Path: <SRS0=5wzB=3P=free.fr=slash.tmp@kernel.org>
Return-Path: <SRS0=5wzB=3P=free.fr=slash.tmp@kernel.org>
Subject: Re: Enumerating an empty bus hangs the entire system
From: Mason <slash.tmp@free.fr>
To: linux-pci <linux-pci@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>
Cc: Linux ARM <linux-arm-kernel@lists.infradead.org>,
 David Laight <david.laight@aculab.com>, Robin Murphy <robin.murphy@arm.com>,
 Liviu Dudau <liviu.dudau@arm.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Thibaud Cornic <thibaud_cornic@sigmadesigns.com>,
 Phuong Nguyen <phuong_nguyen@sigmadesigns.com>
References: <1eeea8ff-0840-a005-38b4-61f3c253cee1@free.fr>
Message-ID: <d0bdd0da-e6f6-396f-486a-7b1685d45d69@free.fr>
Date: Fri, 7 Apr 2017 17:15:32 +0200
MIME-Version: 1.0
In-Reply-To: <1eeea8ff-0840-a005-38b4-61f3c253cee1@free.fr>
Content-Type: text/plain; charset=ISO-8859-15
List-ID: <linux-pci.vger.kernel.org>

On 15/03/2017 16:25, Mason wrote:

> My driver works reasonably well on revision 1 of the PCIe controller.
> (For lax enough values of "reasonably well"...)
> 
> So I wanted to try it out on revision 2 of the controller.
> 
> Turns out the system hangs if I boot with no card inserted in the PCIe
> slot. (This does not happen on revision 1.) If I log all config space
> accesses, this is what I see:
> 
> ...
> [    2.966402] tango_config_read: bus=0 devfn=0 where=128 size=2
> [    2.972284] tango_config_read: bus=0 devfn=0 where=140 size=4
> [    2.978167] tango_config_read: bus=0 devfn=0 where=146 size=2
> [    2.984144] pci_bus 0000:01: busn_res: can not insert [bus 01-ff] under [bus 00-3f] (conflicts with (null) [bus 00-3f])
> [    2.995105] tango_config_write: bus=0 devfn=0 where=24 size=4 val=0xff0100
> [    3.002134] pci_bus 0000:01: scanning bus
> [    3.006274] tango_config_read: bus=1 devfn=0 where=0 size=4
> 
> Basically, the PCI framework tries to read vendor and device IDs
> of the non-existent device on bus 1, which hangs the system,
> because the read never completes :-(
> 
> I had the same problem with the legacy driver for 3.4 but I was
> hoping I would magically avoid it in a recent kernel.
> 
> The only work-around I see is: assuming the first access to a
> bus will be to register 0, check the PHY for an active link
> before sending an actual read request to register 0.
> 
> Is that reasonable?
> 
> Is it compliant for the PCIe controller to hang like that,
> or should it handle some kind of time out?
> 
> Liviu suggested: "The PCIe controller probably generates (or propagates)
> a bus abort that it should actually trap in HW. Check if there is a SW
> configurable way to recover that."
> 
> But I unmasked all system/misc errors, and I don't see any
> interrupts firing.

I now have a better understanding of the situation, which inevitably
leads to more questions...

By reading a controller-specific debug register, I sampled the LTSSM
(Link Training and Status State-Machine) value as fast as possible.

A) if there is no card inserted in the PCIe slot, the State-Machine
oscillates between "Detect.Quiet" and "Detect.Active" SubStates of
the "Detect" State.

B) if there is a card inserted in the PCIe slot, then after a few
milliseconds, the State-Machine changes to "Polling.Active", then
"Polling.Configuration", then "Configuration" (this step must be
very short, because I don't see it consistently), then "L0".


One issue I noted in a separate message is that, on rev1 of my HW,
if the PCIe framework tries to read the card's device ID too soon,
i.e. before link training is complete, then the read returns ~0,
and the framework immediately gives up.

Looking at pci_bus_read_dev_vendor_id(), I see that there is a
retry mechanism implemented, but it seems to be a quirk?

Does the framework expect pci_bus_read_dev_vendor_id() to always
succeed when there is indeed a device on that specific bus?

In that cas, my driver needs to take care of only starting enumeration
once the link to the PCIe card is really "up" and functional?

I was given the advice to move the link detection code to the
probe function, and reset the host bridge (to save power) when
no link is detected after some time. What do you think?

Regards.
