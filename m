Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx4-phx2.redhat.com ([209.132.183.25]:60048 "EHLO
	mx4-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751765Ab1KKRl7 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 11 Nov 2011 12:41:59 -0500
Date: Fri, 11 Nov 2011 12:41:58 -0500 (EST)
From: James Paradis <jparadis@redhat.com>
To: Don Dutile <ddutile@redhat.com>
Cc: Prarit Bhargava <prarit@redhat.com>, linux-pci@vger.kernel.org,
	mstowe@redhat.com, matthew wilcox <matthew.wilcox@linux.intel.com>,
	jbarnes@virtuousgeek.org, Matthew Wilcox <matthew@wil.cx>
Subject: Re: [PATCH] pci: Workaround Stratus broken PCIE hierarchy
Message-ID: <bd3514f0-1a80-45ac-a08e-b327a367b276@zmail15.collab.prod.int.phx2.redhat.com>
In-Reply-To: <4EBC00DD.4010009@redhat.com>
Content-Type: text/plain; charset=utf-8
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hmmm... would it be better to do this as a quirk or as a boot
parameter?  I've heard reports that other systems may be running
into similar issues... if we don't know exactly which systems
these are then maybe a boot parameter would be a more flexible
approach...

--jim

----- Original Message -----
> On 11/10/2011 09:31 AM, Matthew Wilcox wrote:
> > On Thu, Nov 10, 2011 at 09:00:13AM -0500, Prarit Bhargava wrote:
> >> Stratus systems have a hierarchy that includes a PCIE Downstream
> >> bridge
> >> connected to a PCIE Upstream bridge and a PCI Downstream bridge.
> >>  The system
> >> boots with this wrong hierarchy into a crippled mode (USB doesn't
> >> work,
> >> network doesn't work ...).  Avoiding the Downstream bridge check
> >> in
> >> only_one_child() causes all the bridges to be enumerated and the
> >> system
> >> to function properly.
> >
> >> @@ -1275,7 +1276,15 @@ static int only_one_child(struct pci_bus
> >> *bus)
> >>   	struct pci_dev *parent = bus->self;
> >>   	if (!parent || !pci_is_pcie(parent))
> >>   		return 0;
> >> -	if (parent->pcie_type == PCI_EXP_TYPE_ROOT_PORT ||
> >> +	if (parent->pcie_type == PCI_EXP_TYPE_ROOT_PORT)
> >> +		return 1;
> >> +	/*
> >> +	 * Stratus/NEC ftServer systems have a broken PCIE hierarchy in
> >> which
> >> +	 * one upstream and one downstream port are plugged into a
> >> downstream
> >> +	 * port.  Avoiding the downstream port check here results in a
> >> +	 * functional system.
> >> +	 */
> >> +	if (!dmi_name_in_vendors("ftServer")&&
> >>   	parent->pcie_type == PCI_EXP_TYPE_DOWNSTREAM)
> >>   		return 1;
> >>   	return 0;
> >
> > dmi_name_in_vendors is relatively expensive, so the order of these
> > two
> > should be swapped, at least:
> >
> >> 	if (parent->pcie_type == PCI_EXP_TYPE_DOWNSTREAM&&
> >>   	!dmi_name_in_vendors("ftServer"))
> >
> > Plus, this gets called for every PCI bridge.  We should be caching
> > it
> > somewhere, so it's only called once.
> >
> Then i recommend a dmi_name_in_vendors() check at init; stick result
> in
> global (or local static), and then it's not exec'd on each bridge,
> just
> a simple flag check.
> If that's the case, I'd re-cast my vote for putting the code in
> pci_quirks
> with an export, so it is tracked as a quirk.  that may get messy
> wrt other arches though (the export in common code; not sure if
> quirks is
> included on all arches).
> 
> 
