Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout1.hostsharing.net ([83.223.95.204]:46041 "EHLO
	mailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752488AbcHLQia (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 12 Aug 2016 12:38:30 -0400
Date: Fri, 12 Aug 2016 18:39:10 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pci@vger.kernel.org,
	linux-pm@vger.kernel.org, Andreas Noever <andreas.noever@gmail.com>
Subject: Re: [PATCH v2 11/13] PM / sleep: Allow opt-out from runtime resume
 after direct-complete
Message-ID: <20160812163910.GA8111@wunner.de>
References: <20160807095627.GB5679@wunner.de>
 <Pine.LNX.4.44L0.1608071105360.31680-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.44L0.1608071105360.31680-100000@netrider.rowland.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, Aug 07, 2016 at 11:33:17AM -0400, Alan Stern wrote:
> On Sun, 7 Aug 2016, Lukas Wunner wrote:
> 
> > Normally the device hierarchy is traversed bottom-up during suspend
> > and top-down during resume. However ->prepare and ->complete do it
> > the other way round. In the case of ->prepare, this is even documented
> > in Documentation/power/devices.txt but the reason thereof is not.
> > Could you explain this please?
> 
> The purpose of ->prepare is to tell drivers that a system sleep is
> beginning and accordingly they should stop registering new children.  
> This is necessary for the PM core to be able to traverse the entire
> device tree safely; we want to avoid races where a new child is added
> below a device concurrently with that device being suspended.  (Or if
> you want to be more precise, races in which a new child is added below
> a device while the PM core is acquiring the device's lock just prior to
> invoking its ->suspend callback.)
> 
> Telling drivers to stop registering new children below a device has to
> be done top-down, because if it were done bottom-up then it would be
> subject to the same race described above.  Doing it top-down avoids 
> problems; if a device registers new children while the PM core is 
> acquiring its lock prior to invoking ->prepare, it doesn't matter.  The
> new children will be handled later, right along with the existing ones.

Thank you for explaining the motivation to carry out ->prepare top-down.
However my problem is really that ->complete is carried out bottom-up.
What's the motivation for that? Merely to mirror the behaviour of
->prepare? Would it be possible to change it to top-down? Note that
re-enablement of device addition is already allowed in ->resume,
which is called top-down.

By the way, neither the PCI nor USB bus-level ->prepare callbacks perform
any action that would stop device addition. Same for the pciehp driver
(we don't even have a ->prepare callback defined for PCIe port services.
So it *is* possible to hotplug PCI devices after ->prepare.

Best regards,

Lukas
