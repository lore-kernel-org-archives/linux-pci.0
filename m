Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:58270 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753087Ab2GZVpw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 26 Jul 2012 17:45:52 -0400
Message-ID: <1343339121.2118.5.camel@pasglop>
Subject: Re: PCI mini-summit
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Date: Fri, 27 Jul 2012 07:45:21 +1000
In-Reply-To: <CAErSpo5Ea_Rd2QSUXT13riDgHrkMGiN43+QiFTZYepHi-rg0Vw@mail.gmail.com>
References: <CAErSpo5Ea_Rd2QSUXT13riDgHrkMGiN43+QiFTZYepHi-rg0Vw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, 2012-07-24 at 21:33 -0600, Bjorn Helgaas wrote:
> We're planning a PCI mini-summit on Tuesday, August 28, in San Diego.
> If you'd like an invitation, let me know.
> 
> We haven't drafted an agenda yet, but based on ideas we've heard so
> far, we'll likely talk about some of the following topics:
> 
>       Host bridge hotplug
>       PCI hotplug core rework
>       VFIO v2 for KVM
>       Dynamic resource assignment
>       SRIOV
>           Management: driver (module parms) vs core (sysfs?)
>           Dynamic/static: changing number of VFs requires driver cooperation
>       Candidates for unification/moving from arch code to the core:
>           res->parent usage
>           Claiming resources
>           Unassigned BAR detection
>           ECAM (a.k.a. MMCONFIG)
>           Domain (a.k.a. PCI segment) support
>           MPS config
>           MPS safety with respect to hotplug
> 
> I've also heard that PCI-on-ARM may be of interest, so if you want to
> talk about that and possibly add some topics, let me know.

We don't necessarily need a firm agenda, we can put the list of topics
and pick them in time with a hourly stop to decide whether to move on to
a different one.

Unless some people want to actually present something in which case we
can allocate them a slot (those people need to let us know asap).

Cheers,
Ben.


