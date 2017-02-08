Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:52672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750911AbdBHSOg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 8 Feb 2017 13:14:36 -0500
Date: Wed, 8 Feb 2017 12:04:58 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Yinghai Lu <yinghai@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PCI: pciehp: Don't enable PME on runtime suspend
Message-ID: <20170208180458.GC27298@bhelgaas-glaptop.roam.corp.google.com>
References: <d1ae979d256631e7c189694a6d3e1a518abf3fc8.1486359844.git.lukas@wunner.de>
 <20170206221502.GA27899@bhelgaas-glaptop.roam.corp.google.com>
 <20170207062101.GB791@wunner.de>
 <26564356.WaYtlag6jj@aspire.rjw.lan>
 <20170208042354.GA976@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170208042354.GA976@wunner.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Feb 08, 2017 at 05:23:54AM +0100, Lukas Wunner wrote:
> On Tue, Feb 07, 2017 at 05:04:45PM +0100, Rafael J. Wysocki wrote:

> > The bottom line, in any case, is that the current code causes problems to
> > happen somewhere and as a rule we don't release code that is known to
> > cause problems to happen to anyone.  This means something needs to be done
> > about that and the choice at this point is pretty much between reverting and
> > quirking the affected system(s).
> 
> Quirking is not an option in this case because the PCI device IDs of the
> affected hotplug ports as well as DMI data are unknown.  Yinghai Lu is
> refusing to publish that, for both affected systems.

A quirk is appropriate if the hardware isn't working per spec.  I
don't think we have convincing evidence of that yet, so I'm more
interested in investigating that than I am in getting the device IDs
to add a quirk.

I suspect there's useful information to be had by disabling CONFIG_PM
and CONFIG_HOTPLUG_PCI_PCIE and poking things with setpci, which could
be done regardless of any NDAs.

Bjorn
