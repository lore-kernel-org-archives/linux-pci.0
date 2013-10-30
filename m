Return-Path: <linux-acpi-owner@vger.kernel.org>
Message-ID: <1383143050.4097.164.camel@ul30vt.home>
Subject: Re: [PATCH] ACPI / hotplug / PCI: Always rescan the slot for new
 devices
From: Alex Williamson <alex.williamson@redhat.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	linux-acpi@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Len Brown <lenb@kernel.org>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Date: Wed, 30 Oct 2013 08:24:10 -0600
In-Reply-To: <2238508.7Zxn6keMnr@vostro.rjw.lan>
References: <1383136836-15306-1-git-send-email-mika.westerberg@linux.intel.com>
	 <1383141466.4097.163.camel@ul30vt.home> <2238508.7Zxn6keMnr@vostro.rjw.lan>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, 2013-10-30 at 15:13 +0100, Rafael J. Wysocki wrote:
> On Wednesday, October 30, 2013 07:57:46 AM Alex Williamson wrote:
> > On Wed, 2013-10-30 at 14:40 +0200, Mika Westerberg wrote:
> > > Commit 2dc4128 (ACPI / hotplug / PCI: Avoid doing too much for spurious
> > > notifies) changed the enable_slot() to check return value of pci_scan_slot()
> > > and if it is zero return early from the function. It means that there were
> > > no new devices in this particular slot.
> > > 
> > > However, if a device appeared deeper in the hierarchy the code now ignores
> > > it causing things like Thunderbolt chaining fail to recognize new devices.
> > > 
> > > The problem with Alex Williamson's machine was solved with commit
> > > a47d8c8 (ACPI / hotplug / PCI: Avoid parent bus rescans on spurious device
> > > checks) and hence we should be able to restore the original functionality
> > > that we always rescan on bus check notification.
> > > 
> > > On a device check notification we still check what acpiphp_rescan_slot()
> > > returns and on zero bail out early.
> > > 
> > > Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > > ---
> > > Alex,
> > > 
> > > Are you able to check if your machine still works and doesn't slow down
> > > during boot after this patch is applied?
> > 
> > Looks ok to me, no new console output or boot delay.  Thanks,
> 
> Great, thanks!
> 
> May I add your Tested-by to it, then?

Sure

Tested-by: Alex Williamson <alex.williamson@redhat.com>

