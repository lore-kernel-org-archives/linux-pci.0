Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:55598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750710AbeEJWyE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 10 May 2018 18:54:04 -0400
Date: Thu, 10 May 2018 17:54:02 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI / PM: Do not clear state_saved in pci_pm_freeze()
 when smart suspend is set
Message-ID: <20180510225402.GE190385@bhelgaas-glaptop.roam.corp.google.com>
References: <20180420122202.29944-1-mika.westerberg@linux.intel.com>
 <7417684.AuALTLa7H7@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <7417684.AuALTLa7H7@aspire.rjw.lan>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Apr 23, 2018 at 09:43:52AM +0200, Rafael J. Wysocki wrote:
> On Friday, April 20, 2018 2:22:02 PM CEST Mika Westerberg wrote:
> > If a driver uses DPM_FLAG_SMART_SUSPEND and the device is already
> > runtime suspended when hibernate is started PCI core skips runtime
> > resuming the device but still clears pci_dev->state_saved. After the
> > hibernation image is written pci_pm_thaw_noirq() makes sure subsequent
> > thaw phases for the device are also skipped leaving it runtime suspended
> > with pci_dev->state_saved == false.
> > 
> > When the device is eventually runtime resumed pci_pm_runtime_resume()
> > restores config space by calling pci_restore_standard_config(), however
> > because pci_dev->state_saved == false pci_restore_state() never actually
> > restores the config space leaving the device in a state that is not what
> > the driver might expect.
> > 
> > For example here is what happens for intel-lpss I2C devices once the
> > hibernation snapshot is taken:
> > 
> >   intel-lpss 0000:00:15.0: power state changed by ACPI to D0
> >   intel-lpss 0000:00:1e.0: power state changed by ACPI to D3cold
> >   video LNXVIDEO:00: Restoring backlight state
> >   PM: hibernation exit
> >   i2c_designware i2c_designware.1: Unknown Synopsys component type: 0xffffffff
> >   i2c_designware i2c_designware.0: Unknown Synopsys component type: 0xffffffff
> >   i2c_designware i2c_designware.1: timeout in disabling adapter
> >   i2c_designware i2c_designware.0: timeout in disabling adapter
> > 
> > Since PCI config space is not restored the device is still in D3hot
> > making MMIO register reads return 0xffffffff.
> > 
> > Fix this by clearing pci_dev->state_saved only if we actually end up
> > runtime resuming the device.
> > 
> > Fixes: c4b65157aeef ("PCI / PM: Take SMART_SUSPEND driver flag into account")
> > Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> 
> Since this fixes a commit that went in through the PM tree, I've queued it up.
> 
> Bjorn, please let me know if you prefer to route it through the PCI tree.

Thanks for taking it, that's perfect!

> > ---
> >  drivers/pci/pci-driver.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> > index 6ace47099fc5..b9a131137e64 100644
> > --- a/drivers/pci/pci-driver.c
> > +++ b/drivers/pci/pci-driver.c
> > @@ -958,10 +958,11 @@ static int pci_pm_freeze(struct device *dev)
> >  	 * devices should not be touched during freeze/thaw transitions,
> >  	 * however.
> >  	 */
> > -	if (!dev_pm_test_driver_flags(dev, DPM_FLAG_SMART_SUSPEND))
> > +	if (!dev_pm_smart_suspend_and_suspended(dev)) {
> >  		pm_runtime_resume(dev);
> > +		pci_dev->state_saved = false;
> > +	}
> >  
> > -	pci_dev->state_saved = false;
> >  	if (pm->freeze) {
> >  		int error;
> >  
> > 
> 
> 
