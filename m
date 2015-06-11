Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:65231 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1755266AbbFKUuV (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 11 Jun 2015 16:50:21 -0400
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Jarod Wilson <jarod@redhat.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org,
	Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [Update][PATCH] PCIe / hotplug: Drop pointless ACPI-based "slot detection" check
Date: Thu, 11 Jun 2015 23:16:12 +0200
Message-ID: <1777389.skUOsvr7P3@vostro.rjw.lan>
In-Reply-To: <5579F1B4.9000206@redhat.com>
References: <1431632038-39917-1-git-send-email-jarod@redhat.com> <5579BFD9.9040904@redhat.com> <5579F1B4.9000206@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thursday, June 11, 2015 04:38:12 PM Jarod Wilson wrote:
> On 6/11/2015 1:05 PM, Jarod Wilson wrote:
> > On 5/21/2015 9:21 PM, Rafael J. Wysocki wrote:
> >> On Thursday, May 21, 2015 11:11:46 AM Bjorn Helgaas wrote:
> >>> On Tue, May 19, 2015 at 03:27:58PM +0200, Rafael J. Wysocki wrote:
> >>>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >>>>
> >>>> Jarod Wilson reports that the expresscard hotplug setup doesn't work
> >>>> on HP ZBook G2.  The problem turns out to be the ACPI-based "slot
> >>>> detection" code called from pciehp_probe() which tries to use some
> >>>> questionable heuristics based on what ACPI objects are present for
> >>>> the PCIe port device at hand to figure out whether or not to register
> >>>> a hotplug slot for that port.
> >>>>
> >>>> That code is used if there is at least one PCIe port having an ACPI
> >>>> device configuration object related to hotplug (such as _EJ0 or _RMV)
> >>>> and the Thunderbolt port on the affected machine has _RMV.  Of course,
> >>>> Thunderbolt and PCIe native hotplug need not be mutually exclusive
> >>>> (as they aren't on the machine in question), so that rule is simply
> >>>> incorrect.
> >>>>
> >>>> Moreover, the ACPI-based "slot detection" check does not add any
> >>>> value if pciehp_probe() is called at all and the service type of the
> >>>> device object it has been called for is PCIE_PORT_SERVICE_HP, because
> >>>> PCIe hotplug services are only registered if the _OSC handshake in
> >>>> acpi_pci_root_add() allows the kernel to control the PCIe native
> >>>> hotplug feature.  No more checks need to be carried out to decide
> >>>> whether or not to register a native PCIe hotlug slot in that case.
> >>>>
> >>>> For the above reasons, make pciehp_probe() check if it has been
> >>>> called for the right service type and drop the pointless ACPI-based
> >>>> "slot detection" check from it.  Also remove the entire code whose
> >>>> only user is that check (the entire pciehp_acpi.c file goes away
> >>>> as a result) and drop function headers related to it from the
> >>>> internal PCIeHP header file.
> >>>>
> >>>> Link: http://marc.info/?t=143163219300002&r=1&w=2
> >>>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=98581
> >>>> Reported-by: Jarod Wilson <jarod@redhat.com>
> >>>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >>>
> >>> This is awesome!  Applied to pci/hotplug for v4.2, with Jarod's
> >>> reviewed/tested-by.
> >>
> >> Thanks!
> >
> > Looks like I didn't test enough. I can't explain WHY, but with this
> > applied, now thunderbolt hot unplug of a network adapter goes haywire,
> > where prior to the patch, it worked just fine. Still looking into it...
> 
> Filed bug, dmesg spew can be found in the bug.
> 
> https://bugzilla.kernel.org/show_bug.cgi?id=99841

If it worked for you previously, can you possibly try to re-create that
configuration and set of patches applied and retest then?


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
