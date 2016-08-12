Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:39948 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752371AbcHLRaF (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 12 Aug 2016 13:30:05 -0400
Date: Fri, 12 Aug 2016 13:30:04 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
To: Lukas Wunner <lukas@wunner.de>
cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
	<linux-pci@vger.kernel.org>, <linux-pm@vger.kernel.org>,
	Andreas Noever <andreas.noever@gmail.com>
Subject: Re: [PATCH v2 11/13] PM / sleep: Allow opt-out from runtime resume
 after direct-complete
In-Reply-To: <20160812163910.GA8111@wunner.de>
Message-ID: <Pine.LNX.4.44L0.1608121314590.2361-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, 12 Aug 2016, Lukas Wunner wrote:

> Thank you for explaining the motivation to carry out ->prepare top-down.
> However my problem is really that ->complete is carried out bottom-up.
> What's the motivation for that? Merely to mirror the behaviour of
> ->prepare? Would it be possible to change it to top-down? Note that
> re-enablement of device addition is already allowed in ->resume,
> which is called top-down.

I'm not aware of any particular reason why making ->complete run
top-down wouldn't work.  Of course, if you did then the environment at
the start of the ->complete callback wouldn't be the same as it was at
the end of the ->prepare callback.

I think originally the idea was just to mirror ->prepare.  Perhaps
Rafael will remember something that has escaped me.

> By the way, neither the PCI nor USB bus-level ->prepare callbacks perform
> any action that would stop device addition. Same for the pciehp driver
> (we don't even have a ->prepare callback defined for PCIe port services.
> So it *is* possible to hotplug PCI devices after ->prepare.

I don't know about PCI (although what you describe sounds like a bug).  

USB relies on a freezable workqueue for adding child devices, so it
stops adding children even before the prepare phase begins.

Alan Stern

