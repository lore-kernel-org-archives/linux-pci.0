Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:59312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755035AbeFRRcp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 18 Jun 2018 13:32:45 -0400
Date: Mon, 18 Jun 2018 12:32:43 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Lukas Wunner <lukas@wunner.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Gavin Shan <gwshan@linux.vnet.ibm.com>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: hotplug: Breathe new life into skeleton driver
Message-ID: <20180618173243.GA129280@bhelgaas-glaptop.roam.corp.google.com>
References: <173b4197138473a1f184cdc0c27093dfce318412.1529179055.git.lukas@wunner.de>
 <20180618151429.GA12288@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180618151429.GA12288@infradead.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jun 18, 2018 at 08:14:29AM -0700, Christoph Hellwig wrote:
> On Sat, Jun 16, 2018 at 10:09:10PM +0200, Lukas Wunner wrote:
> > Ten years ago, commit 58319b802a61 ("PCI: Hotplug core: remove 'name'")
> > dropped the name element from struct hotplug_slot but neglected to
> > update the skeleton driver.
> > 
> > That same year, commit f46753c5e354 ("PCI: introduce pci_slot") raised
> > the number of arguments to pci_hp_register() from one to four.
> > 
> > Fourteen years ago, historic commit 7ab60fc1b8e7 ("PCI Hotplug skeleton:
> > final cleanups") removed all usages of the retval variable from
> > pcihp_skel_init() but not the variable itself, provoking a compiler
> > warning:
> > https://git.kernel.org/tglx/history/c/7ab60fc1b8e7
> > 
> > Fix it and afford compile test coverage to the driver to prevent the
> > same thing from happening again.
> > 
> > Signed-off-by: Lukas Wunner <lukas@wunner.de>
> > ---
> > I guess an alternative would be to delete the skeleton driver,
> > considering that noone bothered to fix these bugs for years.
> > If that is preferred I'll be happy to submit a patch.
> 
> I think deleting is is the better idea.  skeleton drivers have a tendency
> to get out of sync with reality really quickly as you've shown.  And that
> assumes they started out correct, which often isn't the case.

I agree, I don't think it really serves a useful purpose any more.
And I hope we don't have any new hotplug drivers coming.
