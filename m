Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:56160 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753983AbcIGPrY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 7 Sep 2016 11:47:24 -0400
Date: Wed, 7 Sep 2016 18:47:19 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Lukas Wunner <lukas@wunner.de>
Cc: linux-pci@vger.kernel.org,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH] PCI: Fix bridge_d3 update on device removal
Message-ID: <20160907154719.GR1716@lahna.fi.intel.com>
References: <9bc855a01d0f29cc8425cf50dce9812062309cfb.1473135221.git.lukas@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9bc855a01d0f29cc8425cf50dce9812062309cfb.1473135221.git.lukas@wunner.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Sep 06, 2016 at 06:20:46AM +0200, Lukas Wunner wrote:
> Starting with v4.8, we allow a PCIe port to runtime suspend to D3hot if
> the port itself and its children satisfy a number of conditions.  Once a
> child is removed, we recheck those conditions in case the removed device
> was blocking the port from suspending.
> 
> The rechecking needs to happen *after* the device has been removed from
> the bus it resides on.  Otherwise when walking the port's subordinate
> bus in pci_bridge_d3_update(), the device being removed would
> erroneously still be taken into account.
> 
> However the device is removed from the bus_list in pci_destroy_dev() and
> we currently recheck *before* that.  Fix it.

Yes, makes sense.

> Fixes: 9d26d3a8f1b0 ("PCI: Put PCIe ports into D3 during suspend")
> Cc: Mika Westerberg <mika.westerberg@linux.intel.com>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
