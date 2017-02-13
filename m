Return-Path: <SRS0=41+x=Z2=rjwysocki.net=rjw@kernel.org>
Return-Path: <SRS0=41+x=Z2=rjwysocki.net=rjw@kernel.org>
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, Andreas Noever <andreas.noever@gmail.com>, linux-pci@vger.kernel.org, linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v5 3/8] PCI: Don't block runtime PM for Thunderbolt host hotplug ports
Date: Mon, 13 Feb 2017 13:17:54 +0100
Message-ID: <3042740.EMeTt20fd7@aspire.rjw.lan>
In-Reply-To: <20170212171301.GA2845@wunner.de>
References: <cover.1484486499.git.lukas@wunner.de> <20170210183912.GF29169@bhelgaas-glaptop.roam.corp.google.com> <20170212171301.GA2845@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-pci.vger.kernel.org>

On Sunday, February 12, 2017 06:13:01 PM Lukas Wunner wrote:
> On Fri, Feb 10, 2017 at 12:39:12PM -0600, Bjorn Helgaas wrote:
> > On Sun, Jan 15, 2017 at 09:03:45PM +0100, Lukas Wunner wrote:
> > > Hotplug ports generally block their parents from suspending to D3hot as
> > > otherwise their interrupts couldn't be delivered.
> > 
> > This sounds related to PCIe r3.1, sec 5.3.1.4, which says functions
> > supporting PME generation from D3 must support it for both D3cold and
> > D3hot.  I think in PCIe, PMEs mean PME Messages, and the 5.3.1
> > implementation note says Messages are not affected by the PM state of
> > virtual bridges.
> > 
> > So that seems to say that hotplug ports *should* be able to deliver
> > PMEs even while in D3hot.
> > 
> > Maybe you're referring to the hotplug interrupts themselves, not the
> > PME?  I assume a hotplug event (presence detect, attention button,
> > etc) would first cause a PME, then the OS would return the path to D0,
> > then the hotplug interrupt would be delivered.
> > 
> > > An exception are Thunderbolt host controllers:  They have a separate
> > > GPIO pin to side-band signal plug events even if the controller is
> > > powered down or its parent ports are suspended to D3.  They can be told
> > > apart from Thunderbolt controllers in attached devices by checking if
> > > they're situated below a non-Thunderbolt device (typically a root port,
> > > or the downstream port of a PCIe switch in the case of the MacPro6,1).
> > 
> > In PCIe terms, does a "Thunderbolt host controller" look like a
> > downstream port that supports hotplug?
> > 
> > It seems like the PCIe PME mechanism *should* work pretty much like
> > this sideband GPIO.  But I might be reading the spec wrong.
> 
> I am dropping this patch in v6 of my Thunderbolt runpm series.
> 
> The "Light Ridge" Thunderbolt controller in my machine claims to support
> PME, but its WAKE# pin is not connected.  (It's pulled up to 3.3V.)
> I also have an external Thunderbolt chassis with the same controller,
> and the controller likewise claims to support PME, but its WAKE# pin is
> not connected to the PCIe root im my machine in any way.

WAKE# should not be necessary if PME messages can be delivered in-band.

Of course, root ports still need to be able to signal PME wakeup via port
interrupts for this to work, and some kind of side-band wakeup signaling
may be necessary for waking up the system from sleep states via PME.

Thanks,
Rafael
