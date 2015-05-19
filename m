Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:59442 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932525AbbESND6 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 19 May 2015 09:03:58 -0400
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Jarod Wilson <jarod@redhat.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org,
	Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCIe / hotplug: Drop pointless ACPI-based "slot detection" check
Date: Tue, 19 May 2015 15:29:17 +0200
Message-ID: <14352741.Nj7ZOtZbsW@vostro.rjw.lan>
In-Reply-To: <555B2F98.4050906@redhat.com>
References: <1431632038-39917-1-git-send-email-jarod@redhat.com> <6257210.QKy3yrBgEf@vostro.rjw.lan> <555B2F98.4050906@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tuesday, May 19, 2015 08:42:00 AM Jarod Wilson wrote:
> On 5/19/2015 7:43 AM, Rafael J. Wysocki wrote:
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
> > ---
> >
> > Bjorn, that's -stable material I think.  It should be applicable at least
> > since commit 5ba113f7c4fb (PCI: acpiphp: Handle PCIe ports without native
> > hotplug capability) that was shipped in 3.10.
> >
> > Thanks!
> 
> I believe you also want to rip the pciehp_acpi.o hunk out of 
> drivers/pci/hotplug/Makefile,

Right, just sent an updated patch.

> but I made more or less the exact same 
> changes here, and am about to give them a spin on the ZBook 17.

Cool, thanks!


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
