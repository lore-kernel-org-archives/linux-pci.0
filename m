Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from us01smtp3.synopsys.com ([198.182.44.81]:61318 "EHLO
	hermes.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756581Ab2BGVZ2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 7 Feb 2012 16:25:28 -0500
From: Paul Zimmerman <Paul.Zimmerman@synopsys.com>
To: "balbi@ti.com" <balbi@ti.com>
CC: "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Date: Tue, 7 Feb 2012 13:15:40 -0800
Subject: RE: [PATCH 4/4] usb: dwc3: second part of hibernation support
Message-ID: <F6C4814A9B336243ABC3D1FB44E08AE801D5677F0C@US01WXMBX1.internal.synopsys.com>
References: <cover.1328582753.git.paulz@synopsys.com>
 <9c4ee1f156d28640bc43dee647e3470b9e1b9f37.1328582753.git.paulz@synopsys.com>
 <20120207070322.GB3707@legolas.emea.dhcp.ti.com>
 <F6C4814A9B336243ABC3D1FB44E08AE801D5677E3A@US01WXMBX1.internal.synopsys.com>
 <20120207201742.GA10970@legolas.emea.dhcp.ti.com>
In-Reply-To: <20120207201742.GA10970@legolas.emea.dhcp.ti.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> -----Original Message-----
> From: Felipe Balbi [mailto:balbi@ti.com]
> Sent: Tuesday, February 07, 2012 12:18 PM
> 
> Hi,
> 
> On Tue, Feb 07, 2012 at 11:50:54AM -0800, Paul Zimmerman wrote:
> > > -----Original Message-----
> > > From: Felipe Balbi [mailto:balbi@ti.com]
> > > Sent: Monday, February 06, 2012 11:03 PM
> > >
> > > On Mon, Feb 06, 2012 at 07:20:16PM -0800, Paul Zimmerman wrote:
> > > > This patch adds the actual hibernation code, and allows it to be
> > > > enabled in the Kconfig.
> > >
> > > Actually, is there any real reason someone would not use such a feature
> > > if it's available in HW ?
> > >
> > > I mean, the guy chose to enable support for it on your core
> > > configuration tool, right ?
> >
> > It's a dangerous feature if it's not implemented 100% correctly.
> > It can cause the system to freeze solid. So I think it's best to
> > make it an optional feature, at least for the time being.
> 
> Could be, on the other hand, we want those failures to appear ASAP, so
> we fix them promptly. If we keep it disabled, we will most likely loose
> users, I'm afraid.

I'm worried more about an imperfect hardware implementation. If one of
those gets out into the field, then the user will be screwed unless they
have a way to disable this.

> Another argument is that we can keep this for testing for a loooong
> period of time before merging it to mainline. That's why we have
> linux-next and that's why we both have devices with DWC3 controller.
> Well there are a few more companies who might pitch in soon, so we might
> just get more people to help testing patches.
> 
> > < snip >
> >
> > > hmm, so this is all haps-specific ?? Isn't PCIe supposed to be
> > > standardized, how come you have vendor-specific registers ??
> >
> > The HAPS implementation is non-standard, sorry. There's nothing
> > I can do about that.
> 
> Can you talk more about what you're doing here ? Are you talking to
> HAPS' PCIe controller ? I mean, something on the FPGA, or something on
> the PCB ? I'm trying to understand whose registers are these ?

ASCII art diagram follows, hopefully Outlook won't screw it up.


       PCIe Bus
         |  |
   +--------------+
   |  DWC PCIe    |
   |  Controller  |  
   +--------------+
         |  |
 +------------------+
 | SNPS Custom Glue |<-------+
 | Logic ("Gasket") |<--+    |
 +------------------+   |    |
         |  |           |    |
    +------------+  IRQ |    |
    |  DWC USB3  |------+    |
    | Controller |           |
    +------------            |
         |  |                |
      +--------+ Wake Signal |
      |  SNPS  |-------------+
      |  Phy   |
      +--------+
         |  |
        USB Bus


All of the blocks shown, except for the Phy, are implemented in the
FPGA. The power control registers, the wake interrupt generation, and
logic to simulate having the power removed without actualy turning off
the power, are all contained in the custom gasket. The wake signal is
combined with the normal IRQ, so to the processor it appears to be
coming from the USB3 controller, except that it appears in one of the
gasket registers instead of the USB3 controller registers. The gasket
registers are in the same BAR address space as the USB3 controller.

< snip >

> > Since the HAPS has a non-standard implementation, not part of the PCI
> > interface, the PCI power control functions won't work, AFAIK.
> 
> I'm not a PCI expert, but you ought to find a way to hide it under some
> abstraction. Describing HAPS better would help other guys pitch in with
> ideas.
> 
> I'm adding linux-pci@vger to the Cc list in order to ask for some help.
> 
> There is anyway a set of PCI pm platform_ops which you might be able to
> use in order to hide this, I don't know. Like I said, I'm not very
> confortable with the PCI subsystem.

< snip >

> > Can you point me to an existing kernel driver that uses the pm_runtime
> > calls to perform what we need here? It must guarantee that after some
> 
> git grep -e "pm_runtime_" drivers/ will have show you many examples.
> There's also lots of information under
> Documentation/power/runtime_pm.txt
> 
> > function (pm_runtime_get?) is called, nothing will attempt to touch any
> 
> pm_runtime_get() will, well, do a get. In short, it will enable the
> platform for access. In case of e.g. OMAP, we will be enabling the
> correct clock nodes in order to be able to use the correct interconnect
> to access device's register.
> 
> > of the controller registers except the ones that are guaranteed to be
> > alive, namely the two HAPS-specific functions above. In particular, it
> > must prevent calls from the upper layers into the gadget API from
> > touching the controller registers.
> 
> that's something which is very driver specific ;-) So we must guarantee
> in the driver that this will not happen. It's not very complex to
> achieve that, though.
> 
> Actually, what most people do, is that they call pm_runtime_get_sync()
> before an access to the device is needed, and pm_runtime_put() when the
> device isn't needed anymore.
> 
> There's no way a generic pm layer can achieve that without help from the
> driver. See that with your ad-hoc PM implementation, you have a bunch of
> busy loops waiting for the device to come out of hibernation, those
> loops will be handled by the generic PM layer, but the driver has to
> help ;-)

OK, I will poke around and see if I can find an existing driver to use as
an example.

-- 
Paul

