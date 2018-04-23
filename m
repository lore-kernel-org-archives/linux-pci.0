Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cloudserver094114.home.pl ([79.96.170.134]:41459 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751356AbeDWHoB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 23 Apr 2018 03:44:01 -0400
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI / PM: Do not clear state_saved in pci_pm_freeze() when smart suspend is set
Date: Mon, 23 Apr 2018 09:43:52 +0200
Message-ID: <7417684.AuALTLa7H7@aspire.rjw.lan>
In-Reply-To: <20180420122202.29944-1-mika.westerberg@linux.intel.com>
References: <20180420122202.29944-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Friday, April 20, 2018 2:22:02 PM CEST Mika Westerberg wrote:
> If a driver uses DPM_FLAG_SMART_SUSPEND and the device is already
> runtime suspended when hibernate is started PCI core skips runtime
> resuming the device but still clears pci_dev->state_saved. After the
> hibernation image is written pci_pm_thaw_noirq() makes sure subsequent
> thaw phases for the device are also skipped leaving it runtime suspended
> with pci_dev->state_saved == false.
> 
> When the device is eventually runtime resumed pci_pm_runtime_resume()
> restores config space by calling pci_restore_standard_config(), however
> because pci_dev->state_saved == false pci_restore_state() never actually
> restores the config space leaving the device in a state that is not what
> the driver might expect.
> 
> For example here is what happens for intel-lpss I2C devices once the
> hibernation snapshot is taken:
> 
>   intel-lpss 0000:00:15.0: power state changed by ACPI to D0
>   intel-lpss 0000:00:1e.0: power state changed by ACPI to D3cold
>   video LNXVIDEO:00: Restoring backlight state
>   PM: hibernation exit
>   i2c_designware i2c_designware.1: Unknown Synopsys component type: 0xffffffff
>   i2c_designware i2c_designware.0: Unknown Synopsys component type: 0xffffffff
>   i2c_designware i2c_designware.1: timeout in disabling adapter
>   i2c_designware i2c_designware.0: timeout in disabling adapter
> 
> Since PCI config space is not restored the device is still in D3hot
> making MMIO register reads return 0xffffffff.
> 
> Fix this by clearing pci_dev->state_saved only if we actually end up
> runtime resuming the device.
> 
> Fixes: c4b65157aeef ("PCI / PM: Take SMART_SUSPEND driver flag into account")
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Since this fixes a commit that went in through the PM tree, I've queued it up.

Bjorn, please let me know if you prefer to route it through the PCI tree.

> ---
>  drivers/pci/pci-driver.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index 6ace47099fc5..b9a131137e64 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -958,10 +958,11 @@ static int pci_pm_freeze(struct device *dev)
>  	 * devices should not be touched during freeze/thaw transitions,
>  	 * however.
>  	 */
> -	if (!dev_pm_test_driver_flags(dev, DPM_FLAG_SMART_SUSPEND))
> +	if (!dev_pm_smart_suspend_and_suspended(dev)) {
>  		pm_runtime_resume(dev);
> +		pci_dev->state_saved = false;
> +	}
>  
> -	pci_dev->state_saved = false;
>  	if (pm->freeze) {
>  		int error;
>  
> 
