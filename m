Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cloudserver094114.home.pl ([79.96.170.134]:55391 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751121AbeACAkp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 2 Jan 2018 19:40:45 -0500
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Kevin Hilman <khilman@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-i2c <linux-i2c@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH 0/7] PM / core: Direct handling of DPM_FLAG_SMART_SUSPEND and DPM_FLAG_LEAVE_SUSPENDED
Date: Wed, 03 Jan 2018 01:29:40 +0100
Message-ID: <2436726.ykYRzVD45y@aspire.rjw.lan>
In-Reply-To: <7742130.AaJQIxeI1n@aspire.rjw.lan>
References: <7742130.AaJQIxeI1n@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sunday, December 10, 2017 12:55:23 AM CET Rafael J. Wysocki wrote:
> Hi All,
> 
> This series is a follow-up for
> 
> https://marc.info/?l=linux-doc&m=151101644105835&w=2
> 
> Patches[1-3/6] from the above have been reviewed and agreed on, so
> they are in linux-next now and here's a next version of the rest.
> 
> Patches [1-2/4] are preparatory.  The first one is just really small
> code duplication avoidance on top of this recent fix:
> 
> https://patchwork.kernel.org/patch/10097563/
> 
> and the second one simply moves some code to separate functions.
> 
> Patch [3/4] causes the PM core to carry out some optimizations for
> drivers of devices with DPM_FLAG_SMART_SUSPEND set whose "late"
> and "noirq" suspend (or equivalent) driver callbacks are invoked
> directly by the core.
> 
> The underlying observation is that if the device is suspended (via
> runtime PM) during the "late suspend" phase of a system transition,
> invoking the "late" and "noirq" callbacks from the driver for it is not
> going to make it more suspended, so to speak, so it doesn't make sense to
> invoke them at all.
> 
> [That optimization is only done for devices with DPM_FLAG_SMART_SUSPEND
> set, because drivers setting that flag are expected to be prepared for
> skipping their "late" and "noirq" callbacks if the device is already
> suspended.]
> 
> Patch [4/4] makes the core do an analogous thing for devices with
> DPM_FLAG_LEAVE_SUSPENDED set whose "noirq" and "early" resume (or
> equivalent) driver callbacks are directly invoked by the core.
> 
> In that case the observation is that if such devices can be left in
> suspend after the system transition to the working state, running
> resume callbacks from their drivers is simply not necessary.
> 
> Pathes [3-4/4] have been reoredered and reworked a bit since the last
> iteration, so they are regarded as new.
> 
> The series is on top of the linux-next branch of the linux-pm.git tree
> that should be merged into linux-next on Monday.
> 
> [I have developed debug bus type and driver modules to test that code,
> but they are not ready to be made available at this point.]

Resending the original series (except for the first patch that has been
applied already) along with some driver code changes based on them as
requested by Ulf.

The driver patches are an intel-lpss change (already reviewed), two
modifications of i2c-designware-platdrv (posted previously but slightly
changed since then) and a PCIe port driver change.

At this point patches [1-3/7] are pretty much on the way in and the driver
material depends on review comments (it is pointless to apply [4/7] without
[5-6/7], so it depends on them in my view).

I'm sending this from a system running with all of the series applied, although
admittedly not using i2c-designware-platdrv.  However, one of my test machines
has this one and I haven't seen any adverse effects of these changes on it so
far.

Thanks,
Rafael
