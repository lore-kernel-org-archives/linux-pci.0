Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:46461 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751670AbaG2QSX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 29 Jul 2014 12:18:23 -0400
Message-ID: <1406650687.1011.180.camel@ul30vt.home>
Subject: Re: [PATCH] PCI: update device mps when doing pci hotplug
From: Alex Williamson <alex.williamson@redhat.com>
To: Yijing Wang <wangyijing@huawei.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Jordan_Hargrave@Dell.com, keith.busch@intel.com,
	jon.mason@intel.com, Jon Mason <jdmason@kudzu.us>
Date: Tue, 29 Jul 2014 10:18:07 -0600
In-Reply-To: <1406621877-12022-1-git-send-email-wangyijing@huawei.com>
References: <1406621877-12022-1-git-send-email-wangyijing@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, 2014-07-29 at 16:17 +0800, Yijing Wang wrote:
> Currently we don't update device's mps value when doing
> pci device hot-add. The hot-added device's mps will be set
> to default value (128B). But the upstream port device's mps
> may be larger than 128B which was set by firmware during
> system bootup. In this case the new added device may not
> work normally.

Apologies if we rehash some previously discussed topics while I try to
cover for Bjorn while he's out.  By "normally", do you mean "optimally"?
The device should be functional with a lower mps setting, right?

>  This issue was found in huawei 5885 server
> and Dell R620 server. And if we run the platform with windows,
> this problem is gone. This patch try to update the hot added
> device mps equal to its parent mps, if device mpss < parent mps,
> print warning.
> 
> References: https://bugzilla.kernel.org/show_bug.cgi?id=60671
> Reported-by: Keith Busch <keith.busch@intel.com>
> Reported-by: Jordan_Hargrave@Dell.com
> Reported-by: Yijing Wang <wangyijing@huawei.com>
> Signed-off-by: Yijing Wang <wangyijing@huawei.com>
> Cc: Jon Mason <jdmason@kudzu.us>
> ---
>  drivers/pci/probe.c |   39 +++++++++++++++++++++++++++++++++++++++
>  1 files changed, 39 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index e3cf8a2..583ca52 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1613,6 +1613,44 @@ static void pcie_write_mrrs(struct pci_dev *dev)
>  		dev_err(&dev->dev, "MRRS was unable to be configured with a safe value.  If problems are experienced, try running with pci=pcie_bus_safe\n");
>  }
>  
> +/**
> + * pcie_bus_update_set - update device mps when device doing hot-add
> + * @dev: PCI device to set
> + * 
> + * After device hot add, mps will be set to default(128B), But the 
> + * upstream port device's mps may be larger than 128B which was set 
> + * by firmware during system bootup. Then we should update the device
> + * mps to equal to its parent mps, Or the device can not work normally.
> + */
> +static void pcie_bus_update_set(struct pci_dev *dev)
> +{
> +	int mps, p_mps, mpss;
> +	struct pci_dev *parent;
> +
> +	if (!pci_is_pcie(dev) || !dev->bus->self 
> +			|| !dev->bus->self->is_hotplug_bridge)
> +		return;
> +	
> +	parent = dev->bus->self;
> +	mps = pcie_get_mps(dev);
> +	p_mps = pcie_get_mps(parent);
> +
> +	if (mps >= p_mps)
> +		return;
> +
> +	mpss = 128 << dev->pcie_mpss;
> +	if (mpss < p_mps) {
> +		dev_warn(&dev->dev, "MPSS %d smaller than upstream MPS %d\n"
> +				"If necessary, use \"pci=pcie_bus_safe\" boot parameter to avoid this problem\n",
> +				mpss, p_mps);
> +		return;
> +	}
> +
> +	pcie_write_mps(dev, p_mps);
> +	dev_info(&dev->dev, "Max Payload Size set to %4d/%4d (was %4d)\n", 
> +			pcie_get_mps(dev), 128 << dev->pcie_mpss, mps);
> +}

So if the device mps is less than the parent mps and the device supports
the parent mps, we update the device.  If the device cannot support the
parent mps, warn.  Why do we bypass the opportunity to reduce the device
mps if it exceeds the parent mps?

> +
>  static void pcie_bus_detect_mps(struct pci_dev *dev)
>  {
>  	struct pci_dev *bridge = dev->bus->self;
> @@ -1637,6 +1675,7 @@ static int pcie_bus_configure_set(struct pci_dev *dev, void *data)
>  		return 0;
>  
>  	if (pcie_bus_config == PCIE_BUS_TUNE_OFF) {
> +		pcie_bus_update_set(dev);
>  		pcie_bus_detect_mps(dev);
>  		return 0;
>  	}

pcie_bus_update_set() and pcie_bus_detect_mps() have a lot of
redundancy, can't we merge this new functionality into the existing
function?  Also, we're in the PCIE_BUS_TUNE_OFF branch, but we seem to
be adding code which would imply PCIE_BUS_PERFORMANCE since we're
bringing the device up to an optimal mps to match the parent.  Is there
a simpler solution to simply downgrade the dev_warn in
pcie_bus_detect_mps() to dev_info and change the text?  Thanks,

Alex

