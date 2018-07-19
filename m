Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:39214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731774AbeGSTuQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 19 Jul 2018 15:50:16 -0400
Date: Thu, 19 Jul 2018 14:05:45 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Yinghai Lu <yinghai@kernel.org>, Sinan Kaya <okaya@kernel.org>,
        linux-pci@vger.kernel.org, Greg Kroah-Hartman <greg@kroah.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mayurkumar Patel <mayurkumar.patel@intel.com>,
        Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
        Stefan Roese <sr@denx.de>, Rajat Jain <rajatja@google.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Andreas Noever <andreas.noever@gmail.com>
Subject: Re: [PATCH 00/32] Rework pciehp event handling & add runtime PM
Message-ID: <20180719190545.GN128988@bhelgaas-glaptop.roam.corp.google.com>
References: <cover.1529173804.git.lukas@wunner.de>
 <20180716142053.GA12391@bhelgaas-glaptop.roam.corp.google.com>
 <20180719094315.GA19033@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180719094315.GA19033@wunner.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jul 19, 2018 at 11:43:15AM +0200, Lukas Wunner wrote:
> On Mon, Jul 16, 2018 at 09:20:54AM -0500, Bjorn Helgaas wrote:

> >   - You mentioned withdrawing "03/32 PCI: pciehp: Fix deadlock on
> >     unplug".  I tried simply dropping that, but that caused a conflict
> >     that I didn't try to resolve.
> 
> Yes, a single patch succeeding it won't apply cleanly if patch 03/32 is
> omitted, namely "06/32 PCI: pciehp: Declare pciehp_unconfigure_device()
> void".  However resolving the conflict is straightforward, I'm including
> a replacement patch below.

Thanks, I'll pull that in shortly.

> >   - Mika had a few questions/comments that are still dangling.
> 
> I could resolve those with two further replacement patches:
> 
> - "17/32 PCI: pciehp: Enable/disable exclusively from IRQ thread"
>   => Deduplicate code to detect a change in slot occupancy
>      by introducing a small helper.
> 
> - "23/32 PCI: pciehp: Avoid slot access during reset"
>   => Amend commit message to justify usage of rw_semaphore.
> 
> However ISTR that you dislike replacement patches because they're
> more complicated for you to handle.  Would you prefer me to repost
> the full series instead?

No need, if you want to post updates for those, I can incorporate
those, too.

This is an extremely well-done series; thanks for all the work you've
done on it!

Bjorn
