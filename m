Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:47495 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752692AbcD1POE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 28 Apr 2016 11:14:04 -0400
Date: Thu, 28 Apr 2016 18:13:56 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Qipeng Zha <qipeng.zha@intel.com>,
	Qi Zheng <qi.zheng@intel.com>, Dave Airlie <airlied@gmail.com>,
	Mathias Nyman <mathias.nyman@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andreas Noever <andreas.noever@gmail.com>,
	linux-pci@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v4 4/4] PCI: Add runtime PM support for PCIe ports
Message-ID: <20160428151356.GF32610@lahna.fi.intel.com>
References: <1461578004-129094-1-git-send-email-mika.westerberg@linux.intel.com>
 <1461578004-129094-5-git-send-email-mika.westerberg@linux.intel.com>
 <20160428142216.GA18211@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160428142216.GA18211@wunner.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Apr 28, 2016 at 04:22:16PM +0200, Lukas Wunner wrote:
> Hi Mika,
> 
> I've rebased my Thunderbolt runtime pm patches on v4 of your patches
> and everything seems to still work fine. d3cold_allowed also works
> as it should now.

Cool, thanks for testing.

> As said I've amended my series to allow runtime pm on hotplug ports
> if they're Thunderbolt ports on a Mac:
> https://github.com/l1k/linux/commit/a6810db929485c7fc8677f265b1c68e31879ce61

If we are going to add more conditions, I think it makes sense to
introduce pcie_port_runtime_pm_possible() or similar which includes all
these checks.

> I've also reviewed the patches one more time and spotted only this
> small nit:
> 
> On Mon, Apr 25, 2016 at 12:53:24PM +0300, Mika Westerberg wrote:
> > +static int pcie_port_runtime_resume(struct device *dev)
> > +{
> > +	pm_runtime_mark_last_busy(dev);
> > +	return 0;
> > +}
> 
> The PM core seems to do this automatically, see rpm_resume():
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/drivers/base/power/runtime.c#n749
> 
> So you could just drop the .runtime_resume entry here and it shouldn't
> result in any functional change:
> 
> > @@ -101,6 +122,9 @@ static const struct dev_pm_ops pcie_portdrv_pm_ops = {
> >  	.poweroff	= pcie_port_device_suspend,
> >  	.restore	= pcie_port_device_resume,
> >  	.resume_noirq	= pcie_port_resume_noirq,
> > +	.runtime_suspend = pcie_port_runtime_suspend,
> > +	.runtime_resume	= pcie_port_runtime_resume,
> > +	.runtime_idle	= pcie_port_runtime_idle,

Hmm, PM core calls pci_pm_runtime_resume() for PCI drivers which then
delegates to driver->runtime_resume() if set. However, if it is missing
it just returns -ENOSYS and does not put the device back to D0.

So if I'm reading this right we actually need to provide
pcie_port_runtime_resume().
