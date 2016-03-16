Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Wed, 16 Mar 2016 14:22:28 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Jack Coulter <jscinoz@jscinoz.so>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Andreas Noever <andreas.noever@gmail.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Martin Andersson <martin.andersson@purplescout.se>
Subject: Re: Thunderbolt 3 (Skylake / Alpine Ridge) hotplug
Message-ID: <20160316132228.GB28222@wunner.de>
References: <56D0085B.60402@jscinoz.so>
 <20160315172909.GF19974@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160315172909.GF19974@localhost>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Jack,

On Tue, Mar 15, 2016 at 12:29:09PM -0500, Bjorn Helgaas wrote:
> On Fri, Feb 26, 2016 at 07:10:03PM +1100, Jack Coulter wrote:
> > I'm attempting to use the Thunderbolt 3 (which has a USB Type-C
> > connector) port on my laptop, a Dell XPS 15 (9550). The external device
> > I'm attempting to use is a gigabit ethernet + USB 3.0 hub, of an unknown
> > / generic brand, but bears model number KY-688 if that's of any use.
> > 
> > When the device is present at system startup, everything works
> > correctly, and shows up in lspci as a USB controller, which lsusb shows
> > having a hub and ethernet NIC attached, which the r8152 driver binds and
> > uses without issue: [...]
> > 
> > However, if the device is connected after the system boots (or
> > disconnected and reconnected), it is not detected at all. No messages
> > show up in dmesg upon connection and no additional devices show up in
> > the output of lspci & lsusb. Strangely enough, USB devices connected to
> > the external hub do still receive power.
>
> I don't know much about Thunderbolt.  But since it appears as a PCI
> device, I would expect some sort of hotplug notification when you
> attach the hub.  If pciehp handles hotplug, it looks like we should
> see something from pcie_isr() in the dmesg log.

Try booting with: pcie_hp=nomsi

This is needed with the Light Ridge controller built into 2011/2012 Macs
to receive hotplug notifications.

Best regards,

Lukas
