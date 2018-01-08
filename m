Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:23958 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756263AbeAHObx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 8 Jan 2018 09:31:53 -0500
Subject: Re: [PATCH 5/7] PM: i2c-designware-platdrv: Use
 DPM_FLAG_SMART_PREPARE
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
 <2436726.ykYRzVD45y@aspire.rjw.lan> <1780798.HpLBO7aPyI@aspire.rjw.lan>
From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Message-ID: <8924de22-96f5-0e10-7aaf-29b5a490afe2@linux.intel.com>
Date: Mon, 8 Jan 2018 16:31:49 +0200
MIME-Version: 1.0
In-Reply-To: <1780798.HpLBO7aPyI@aspire.rjw.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 01/03/2018 02:35 AM, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Modify i2c-designware-platdrv to set DPM_FLAG_SMART_PREPARE for its
> devices and return 0 from the system suspend ->prepare callback
> if the device has an ACPI companion object in order to tell the PM
> core and middle layers to avoid skipping system suspend/resume
> callbacks for the device in that case (which may be problematic,
> because the device may be accessed during suspend and resume of
> other devices via I2C operation regions then).
> 
> Also the pm_runtime_suspended() check in dw_i2c_plat_prepare()
> is not necessary any more, because the core does it when setting
> power.direct_complete for the device, so drop it.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>   drivers/i2c/busses/i2c-designware-platdrv.c |   10 +++++++++-
>   1 file changed, 9 insertions(+), 1 deletion(-)
> 
Acked-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
