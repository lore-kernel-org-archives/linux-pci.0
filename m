Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:41818 "HELO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S936310AbcIGQBq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 7 Sep 2016 12:01:46 -0400
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Lukas Wunner <lukas@wunner.de>, linux-pci@vger.kernel.org,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] PCI: Fix bridge_d3 update on device removal
Date: Wed, 07 Sep 2016 18:07:44 +0200
Message-ID: <2064673.GKXRTE9TmZ@vostro.rjw.lan>
In-Reply-To: <20160907154719.GR1716@lahna.fi.intel.com>
References: <9bc855a01d0f29cc8425cf50dce9812062309cfb.1473135221.git.lukas@wunner.de> <20160907154719.GR1716@lahna.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday, September 07, 2016 06:47:19 PM Mika Westerberg wrote:
> On Tue, Sep 06, 2016 at 06:20:46AM +0200, Lukas Wunner wrote:
> > Starting with v4.8, we allow a PCIe port to runtime suspend to D3hot if
> > the port itself and its children satisfy a number of conditions.  Once a
> > child is removed, we recheck those conditions in case the removed device
> > was blocking the port from suspending.
> > 
> > The rechecking needs to happen *after* the device has been removed from
> > the bus it resides on.  Otherwise when walking the port's subordinate
> > bus in pci_bridge_d3_update(), the device being removed would
> > erroneously still be taken into account.
> > 
> > However the device is removed from the bus_list in pci_destroy_dev() and
> > we currently recheck *before* that.  Fix it.
> 
> Yes, makes sense.
> 
> > Fixes: 9d26d3a8f1b0 ("PCI: Put PCIe ports into D3 during suspend")
> > Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
> 
> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Acked-by: Rafael J. Wysocki <mika.westerberg@linux.intel.com>

Thanks!

