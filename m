Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:23967 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757886AbeAHOcB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 8 Jan 2018 09:32:01 -0500
Subject: Re: [PATCH 6/7] PM: i2c-designware-platdrv: Optimize power management
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
References: <7742130.AaJQIxeI1n@aspire.rjw.lan>
 <2436726.ykYRzVD45y@aspire.rjw.lan> <6243259.Xh4soKtjBb@aspire.rjw.lan>
From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Message-ID: <bb17c593-d8ab-ace6-4127-249da0b8af54@linux.intel.com>
Date: Mon, 8 Jan 2018 16:31:58 +0200
MIME-Version: 1.0
In-Reply-To: <6243259.Xh4soKtjBb@aspire.rjw.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 01/03/2018 02:37 AM, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Optimize the power management in i2c-designware-platdrv by making it
> set the DPM_FLAG_SMART_SUSPEND and DPM_FLAG_LEAVE_SUSPENDED which
> allows some code to be dropped from its PM callbacks.
> 
> First, setting DPM_FLAG_SMART_SUSPEND causes the intel-lpss driver
> to avoid resuming i2c-designware-platdrv devices in its ->prepare
> callback, so they can stay in runtime suspend after that point even
> if the direct-complete feature is not used for them.
> 
> It also causes the ACPI PM domain and the PM core to avoid invoking
> "late" and "noirq" suspend callbacks for these devices if they are
> in runtime suspend at the beginning of the "late" phase of device
> suspend during system suspend.  That guarantees dw_i2c_plat_suspend()
> to be called for a device only if it is not in runtime suspend.
> 
> Moreover, it causes the device's runtime PM status to be set to
> "active" after calling dw_i2c_plat_resume() for it, so the
> driver doesn't need internal flags to avoid invoking either
> dw_i2c_plat_suspend() or dw_i2c_plat_resume() twice in a row.
> 
> Second, setting DPM_FLAG_LEAVE_SUSPENDED enables the optimization
> allowing the device to stay suspended after system resume under
> suitable conditions, so again the driver doesn't need to take
> care of that by itself.
> 
> Accordingly, the internal "suspended" and "skip_resume" flags
> used by the driver are not necessary any more, so drop them and
> simplify the driver's PM callbacks.
> 
> Additionally, notice that dw_i2c_plat_complete() only needs to
> schedule runtime PM resume for the device if platform firmware
> has been involved in resuming the system, so make it call
> pm_resume_via_firmware() to check that.  Also make it check the
> runtime PM status of the device instead of its direct_complete
> flag which also works if the device remained suspended due to
> the DPM_FLAG_LEAVE_SUSPENDED driver flag.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>   drivers/i2c/busses/i2c-designware-core.h    |    2 -
>   drivers/i2c/busses/i2c-designware-platdrv.c |   31 ++++++++++------------------
>   2 files changed, 12 insertions(+), 21 deletions(-)
> 
This doesn't apply to linux-next due 0326f9f801b2 ("i2c: designware: 
rename i2c_dw_plat_prepare_clk to i2c_dw_prepare_clk"). It was trivial 
to fix which I did locally for testing.

Acked-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
