Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout2.hostsharing.net ([83.223.90.233]:57942 "EHLO
	mailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752316AbcD1OTj (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 28 Apr 2016 10:19:39 -0400
Date: Thu, 28 Apr 2016 16:22:16 +0200
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
Message-ID: <20160428142216.GA18211@wunner.de>
References: <1461578004-129094-1-git-send-email-mika.westerberg@linux.intel.com>
 <1461578004-129094-5-git-send-email-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1461578004-129094-5-git-send-email-mika.westerberg@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Mika,

I've rebased my Thunderbolt runtime pm patches on v4 of your patches
and everything seems to still work fine. d3cold_allowed also works
as it should now.

As said I've amended my series to allow runtime pm on hotplug ports
if they're Thunderbolt ports on a Mac:
https://github.com/l1k/linux/commit/a6810db929485c7fc8677f265b1c68e31879ce61

I've also reviewed the patches one more time and spotted only this
small nit:

On Mon, Apr 25, 2016 at 12:53:24PM +0300, Mika Westerberg wrote:
> +static int pcie_port_runtime_resume(struct device *dev)
> +{
> +	pm_runtime_mark_last_busy(dev);
> +	return 0;
> +}

The PM core seems to do this automatically, see rpm_resume():
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/drivers/base/power/runtime.c#n749

So you could just drop the .runtime_resume entry here and it shouldn't
result in any functional change:

> @@ -101,6 +122,9 @@ static const struct dev_pm_ops pcie_portdrv_pm_ops = {
>  	.poweroff	= pcie_port_device_suspend,
>  	.restore	= pcie_port_device_resume,
>  	.resume_noirq	= pcie_port_resume_noirq,
> +	.runtime_suspend = pcie_port_runtime_suspend,
> +	.runtime_resume	= pcie_port_runtime_resume,
> +	.runtime_idle	= pcie_port_runtime_idle,

Best regards,

Lukas
