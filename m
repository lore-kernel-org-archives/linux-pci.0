Return-Path: <SRS0=0zNO=J2=ti.com=kishon@kernel.org>
Return-Path: <SRS0=0zNO=J2=ti.com=kishon@kernel.org>
Subject: Re: [PATCH] driver core: Partially revert "driver core: correct
 device's shutdown order"
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>
References: <1530600642-25090-1-git-send-email-kernelfans@gmail.com>
 <CAFgQCTsGC8NH+5kXYD7vykJeUsaAzCAjgxSP-R0EqA3YvgsY0w@mail.gmail.com>
 <8816662.k3KXbdkA2e@aspire.rjw.lan> <2927655.Y1qg3UnIrE@aspire.rjw.lan>
CC: Pingfan Liu <kernelfans@gmail.com>, <linux-kernel@vger.kernel.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Christoph Hellwig
	<hch@infradead.org>,
        Bjorn Helgaas <helgaas@kernel.org>, Dave Young
	<dyoung@redhat.com>,
        <linux-pci@vger.kernel.org>, Lukas Wunner
	<lukas@wunner.de>,
        Linux PM <linux-pm@vger.kernel.org>
From: Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <aa41cfa9-dedb-5f19-0d85-0d4c19d26ea8@ti.com>
Date: Tue, 10 Jul 2018 17:52:28 +0530
MIME-Version: 1.0
In-Reply-To: <2927655.Y1qg3UnIrE@aspire.rjw.lan>
Content-Type: text/plain; charset="windows-1252"
List-ID: <linux-pci.vger.kernel.org>

Hi,

On Tuesday 10 July 2018 05:05 PM, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Commit 52cdbdd49853 (driver core: correct device's shutdown order)
> introduced a regression by breaking device shutdown on some systems.
> 
> Namely, the devices_kset_move_last() call in really_probe() added by
> that commit is a mistake as it may cause parents to follow children
> in the devices_kset list which then causes shutdown to fail.  For
> example, if a device has children before really_probe() is called
> for it (which is not uncommon), that call will cause it to be
> reordered after the children in the devices_kset list and the
> ordering of that list will not reflect the correct device shutdown
> order any more.
> 
> Also it causes the devices_kset list to be constantly reordered
> until all drivers have been probed which is totally pointless
> overhead in the majority of cases and it only covers an issue
> with system shutdown, while system-wide suspend/resume potentially
> has the same issue on the affected platforms (which is not covered).
> 
> For that reason, revert the really_probe() modifications made by
> commit 52cdbdd49853 which unfortunately will expose the shutdown
> issue the problematic commit attempted to fix (and which will have
> to be addressed differently and correctly in the future).
> 
> The other code changes made by commit 52cdbdd49853 are useful and
> they need not be reverted.
> 
> Fixes: 52cdbdd49853 (driver core: correct device's shutdown order)
> Link: https://lore.kernel.org/lkml/CAFgQCTt7VfqM=UyCnvNFxrSw8Z6cUtAi3HUwR4_xPAc03SgHjQ@mail.gmail.com/
> Reported-by: Pingfan Liu <kernelfans@gmail.com>
> Tested-by: Pingfan Liu <kernelfans@gmail.com>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---

This issue because of which 52cdbdd49853 (driver core: correct device's
shutdown order) was added is not present from 4.18, since dra7 started using
sdhci-omap.c driver which doesn't disable regulator during shutdown. (The
original issue was present in omap_hsmmc driver).

When sdhci-omap driver is modified to disable regulator during shutdown,
something like device_link_add() can be added in _regulator_get().

Since this doesn't reintroduce the problem that was solved by 52cdbdd49853,
this can be safely merged.

Reviewed-by: Kishon Vijay Abraham I <kishon@ti.com>

Thanks
Kishon
