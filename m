Return-Path: <linux-kernel-owner@vger.kernel.org>
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Jarod Wilson <jarod@redhat.com>, linux-kernel@vger.kernel.org,
	Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [Update][PATCH] PCIe / hotplug: Drop pointless ACPI-based "slot detection" check
Date: Fri, 22 May 2015 03:21:51 +0200
Message-ID: <3372859.5Hat5UqSL7@vostro.rjw.lan>
In-Reply-To: <20150521161146.GE32152@google.com>
References: <1431632038-39917-1-git-send-email-jarod@redhat.com> <1573807.HQlNd2BFYP@vostro.rjw.lan> <20150521161146.GE32152@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thursday, May 21, 2015 11:11:46 AM Bjorn Helgaas wrote:
> On Tue, May 19, 2015 at 03:27:58PM +0200, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > 
> > Jarod Wilson reports that the expresscard hotplug setup doesn't work
> > on HP ZBook G2.  The problem turns out to be the ACPI-based "slot
> > detection" code called from pciehp_probe() which tries to use some
> > questionable heuristics based on what ACPI objects are present for
> > the PCIe port device at hand to figure out whether or not to register
> > a hotplug slot for that port.
> > 
> > That code is used if there is at least one PCIe port having an ACPI
> > device configuration object related to hotplug (such as _EJ0 or _RMV)
> > and the Thunderbolt port on the affected machine has _RMV.  Of course,
> > Thunderbolt and PCIe native hotplug need not be mutually exclusive
> > (as they aren't on the machine in question), so that rule is simply
> > incorrect.
> > 
> > Moreover, the ACPI-based "slot detection" check does not add any
> > value if pciehp_probe() is called at all and the service type of the
> > device object it has been called for is PCIE_PORT_SERVICE_HP, because
> > PCIe hotplug services are only registered if the _OSC handshake in
> > acpi_pci_root_add() allows the kernel to control the PCIe native
> > hotplug feature.  No more checks need to be carried out to decide
> > whether or not to register a native PCIe hotlug slot in that case.
> > 
> > For the above reasons, make pciehp_probe() check if it has been
> > called for the right service type and drop the pointless ACPI-based
> > "slot detection" check from it.  Also remove the entire code whose
> > only user is that check (the entire pciehp_acpi.c file goes away
> > as a result) and drop function headers related to it from the
> > internal PCIeHP header file.
> > 
> > Link: http://marc.info/?t=143163219300002&r=1&w=2
> > Link: https://bugzilla.kernel.org/show_bug.cgi?id=98581
> > Reported-by: Jarod Wilson <jarod@redhat.com>
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> This is awesome!  Applied to pci/hotplug for v4.2, with Jarod's
> reviewed/tested-by.

Thanks!

> I suspect a lot of this stuff dates back to when acpiphp and pciehp could
> be modules, and one driver really couldn't know whether the other was up
> to.  In any event, I think it will be much more predictable and
> maintainable now.

Yes, this code has been outdated since we changed ACPIPHP to look at the
host bridge _OSC bits when deciding whether or not to register a hotplug
port.

Rafael

