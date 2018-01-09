Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cloudserver094114.home.pl ([79.96.170.134]:64196 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753890AbeAIAbE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 8 Jan 2018 19:31:04 -0500
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: Linux PM <linux-pm@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Kevin Hilman <khilman@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-i2c <linux-i2c@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 0/7] PM / core: Direct handling of DPM_FLAG_SMART_SUSPEND and DPM_FLAG_LEAVE_SUSPENDED
Date: Tue, 09 Jan 2018 01:29:52 +0100
Message-ID: <2583612.BQJmMQYPBC@aspire.rjw.lan>
In-Reply-To: <0c8bf7c3-1aa4-e5fb-74e4-7117d6d43444@linux.intel.com>
References: <7742130.AaJQIxeI1n@aspire.rjw.lan> <2436726.ykYRzVD45y@aspire.rjw.lan> <0c8bf7c3-1aa4-e5fb-74e4-7117d6d43444@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Monday, January 8, 2018 3:33:07 PM CET Jarkko Nikula wrote:
> On 01/03/2018 02:29 AM, Rafael J. Wysocki wrote:
> > Resending the original series (except for the first patch that has been
> > applied already) along with some driver code changes based on them as
> > requested by Ulf.
> > 
> > The driver patches are an intel-lpss change (already reviewed), two
> > modifications of i2c-designware-platdrv (posted previously but slightly
> > changed since then) and a PCIe port driver change.
> > 
> > At this point patches [1-3/7] are pretty much on the way in and the driver
> > material depends on review comments (it is pointless to apply [4/7] without
> > [5-6/7], so it depends on them in my view).
> > 
> > I'm sending this from a system running with all of the series applied, although
> > admittedly not using i2c-designware-platdrv.  However, one of my test machines
> > has this one and I haven't seen any adverse effects of these changes on it so
> > far.
> > 
> Both i2cdetect and hexdump from touchscreen and touchpad devices were 
> working fine. I used linux-next next-20180108 and patches 4-7/7.
> 
> Tested-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>

Thank you!
