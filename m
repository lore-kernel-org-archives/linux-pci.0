Return-Path: <linux-kernel-owner@vger.kernel.org>
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Linux PCI <linux-pci@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	lorenzo.stanco@gmail.com, tiagdtd-lava@yahoo.de
Subject: Re: [PATCH] PCI / hotplug / ACPI: Check ignore_hotplug for all downstream devices
Date: Sat, 23 May 2015 00:16:31 +0200
Message-ID: <477458479.R3OxLNoNxN@vostro.rjw.lan>
In-Reply-To: <20150522214416.GJ32152@google.com>
References: <1499297.p2drhZLZaT@vostro.rjw.lan> <20150522214416.GJ32152@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Friday, May 22, 2015 04:44:16 PM Bjorn Helgaas wrote:
> [+cc Lorenzo, tiagdtd-lava]
> 
> On Wed, May 20, 2015 at 02:14:13AM +0200, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > 
> > If the ignore_hotplug flag is set for a PCI device without an ACPI
> > companion and a bus check notification is received for an ancestor
> > bridge that is not the device's parent, ACPIPHP will ignore that
> > flag.
> > 
> > Namely, in that case acpiphp_check_bridge() is called for the target
> > bridge and if all of the devices immediately below the bridge are
> > still present, trim_stale_devices() will be called for each of them.
> > That function recursively walks the hierarchy downwards and removes
> > device objects corresponding to devices that don't appear to be
> > present any more.  Unfortunately, it only checks ignore_hotplug
> > for devices having ACPI companions, so it will remove the others
> > (if they don't respond) regardless of the ignore_hotplug value.
> > 
> > Fix the problem by making trim_stale_devices() take ignore_hotplug
> > into consideration regardless of whether or not an ACPI companion
> > is present for the device it has been called for.
> > 
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Applied to pci/hotplug for v4.2, thanks!
> 
> I cc'd Lorenzo and tiagdtd-lava in hopes they can test this patch and see
> whether it resolves https://bugzilla.kernel.org/show_bug.cgi?id=61891 .
> 
> The branch with this patch applied is here:
> https://git.kernel.org/cgit/linux/kernel/git/helgaas/pci.git/log/?h=pci/hotplug

Thanks!

