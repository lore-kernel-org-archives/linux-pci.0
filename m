Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout1.hostsharing.net ([83.223.95.204]:38523 "EHLO
	mailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752067AbcD1QCs (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 28 Apr 2016 12:02:48 -0400
Date: Thu, 28 Apr 2016 18:05:26 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Qipeng Zha <qipeng.zha@intel.com>,
	Qi Zheng <qi.zheng@intel.com>, Dave Airlie <airlied@gmail.com>,
	Mathias Nyman <mathias.nyman@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andreas Noever <andreas.noever@gmail.com>,
	linux-pci@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v4 4/4] PCI: Add runtime PM support for PCIe ports
Message-ID: <20160428160526.GA18261@wunner.de>
References: <1461578004-129094-1-git-send-email-mika.westerberg@linux.intel.com>
 <1461578004-129094-5-git-send-email-mika.westerberg@linux.intel.com>
 <20160428142216.GA18211@wunner.de>
 <20160428151356.GF32610@lahna.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160428151356.GF32610@lahna.fi.intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Mika,

On Thu, Apr 28, 2016 at 06:13:56PM +0300, Mika Westerberg wrote:
> On Thu, Apr 28, 2016 at 04:22:16PM +0200, Lukas Wunner wrote:
> > As said I've amended my series to allow runtime pm on hotplug ports
> > if they're Thunderbolt ports on a Mac:
> > https://github.com/l1k/linux/commit/a6810db929485c7fc8677f265b1c68e31879ce61
> 
> If we are going to add more conditions, I think it makes sense to
> introduce pcie_port_runtime_pm_possible() or similar which includes all
> these checks.

Initially I reintroduced that in my patch (bikeshedded the name to
pcie_port_can_runtime_suspend() though ;) ), then decided to throw
it away because I'm just adding a one-liner for Thunderbolt on Macs
to the if-condition. Your call. :)

If you decide to reintroduce it, you could use IS_ENABLED to avoid
having to declare an additional inline stub that returns false, e.g.

if (IS_ENABLED(CONFIG_PM) && pcie_port_can_runtime_suspend()) {
	...
	pm_runtime_allow(&dev->dev);
}


> > So you could just drop the .runtime_resume entry here and it shouldn't
> > result in any functional change:
> > 
> > > @@ -101,6 +122,9 @@ static const struct dev_pm_ops pcie_portdrv_pm_ops = {
> > >  	.poweroff	= pcie_port_device_suspend,
> > >  	.restore	= pcie_port_device_resume,
> > >  	.resume_noirq	= pcie_port_resume_noirq,
> > > +	.runtime_suspend = pcie_port_runtime_suspend,
> > > +	.runtime_resume	= pcie_port_runtime_resume,
> > > +	.runtime_idle	= pcie_port_runtime_idle,
> 
> Hmm, PM core calls pci_pm_runtime_resume() for PCI drivers which then
> delegates to driver->runtime_resume() if set. However, if it is missing
> it just returns -ENOSYS and does not put the device back to D0.
> 
> So if I'm reading this right we actually need to provide
> pcie_port_runtime_resume().

Ugh, you're right.

Best regards,

Lukas
