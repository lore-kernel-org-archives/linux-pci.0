Return-Path: <SRS0=zp2M=2Y=arm.com=Liviu.Dudau@kernel.org>
Return-Path: <SRS0=zp2M=2Y=arm.com=Liviu.Dudau@kernel.org>
Date: Wed, 15 Mar 2017 15:55:11 +0000
From: Liviu Dudau <liviu.dudau@arm.com>
To: Mason <slash.tmp@free.fr>
Cc: linux-pci <linux-pci@vger.kernel.org>,
	Linux ARM <linux-arm-kernel@lists.infradead.org>,
	Bjorn Helgaas <helgaas@kernel.org>,
	David Laight <david.laight@aculab.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Thibaud Cornic <thibaud_cornic@sigmadesigns.com>,
	Phuong Nguyen <phuong_nguyen@sigmadesigns.com>
Subject: Re: Enumerating an empty bus hangs the entire system
Message-ID: <20170315155511.GK6268@e110455-lin.cambridge.arm.com>
References: <1eeea8ff-0840-a005-38b4-61f3c253cee1@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1eeea8ff-0840-a005-38b4-61f3c253cee1@free.fr>
List-ID: <linux-pci.vger.kernel.org>

On Wed, Mar 15, 2017 at 04:25:44PM +0100, Mason wrote:
> Hello,

Hi Mason,

> 
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

AFAIK it is not. The PCI (and PCIe) host controller should give back 0xffffffff
as a return of a config read from any bus/dev/fn combination where nothing
exists.

> 
> Liviu suggested: "The PCIe controller probably generates (or propagates)
> a bus abort that it should actually trap in HW.	Check if there is a SW
> configurable way to recover that."
> 
> But I unmasked all system/misc errors, and I don't see any
> interrupts firing.

Have a look at drivers/pci/dwc/pci-imx6.c file where in imx6_pcie_probe() function
they hook an abort handler. See if doing the same thing helps you.

Best regards,
Liviu

> 
> Regards.

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯
