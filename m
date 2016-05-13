Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Fri, 13 May 2016 14:10:29 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Andreas Noever <andreas.noever@gmail.com>,
	Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [RFC 4/4] thunderbolt: Support runtime pm
Message-ID: <20160513121029.GA22994@wunner.de>
References: <20160316162017.GA28372@wunner.de>
 <Pine.LNX.4.44L0.1603171042520.2097-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.44L0.1603171042520.2097-100000@iolanthe.rowland.org>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Alan,

On Thu, Mar 17, 2016 at 10:54:55AM -0400, Alan Stern wrote:
> On Wed, 16 Mar 2016, Lukas Wunner wrote:
> > > The way you're doing it, how does the NHI driver know when to go into 
> > > suspend?  The runtime PM core won't notify it when all the hotplugged 
> > > devices attached to the other bridges have been suspended, since it's 
> > > not their parent.
> > 
> > The NHI knows when something is plugged in, it talks to the switches
> > in devices that are hotplugged to the controller. As I've explained
> > in the lengthy comment in the middle of patch [4/4], we acquire a
> > runtime pm ref for each switch that is plugged in and release one
> > whenever a switch is unplugged.
> 
> If I understand correctly, that means you allow the Thunderbolt
> controller to go into runtime suspend only when nothing is plugged into
> any of the ports.  Is that right?  It's quite inefficient.

In the case of Thunderbolt on the Mac, runtime suspend means that the
controller is powered down. A plug event is side-band signaled using a GPE
so that we're able to power the controller up once something is plugged in.

It's not possible to power the controller down while devices are attached
because downstream devices have no way to side-band signal an interrupt
when they need to send data to the controller.


> What I'm getting at is that we should have proper runtime-PM support
> for bridges, i.e., I agree with what you wrote above.  A bridge can
> safely go into runtime suspend when there are no unsuspended devices
> attached to any of its downstream ports.  (That's how the USB hub
> driver works, for instance.)  Doing things that way would make
> everything simpler in the long run.
> 
> So my suggestion is that you change over to the "less kludgy solution"  
> and work on that instead.

Alright, posted as v2 today. :-)

Thanks,

Lukas
