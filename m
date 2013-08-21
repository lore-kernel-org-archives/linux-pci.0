Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oa0-f50.google.com ([209.85.219.50]:58265 "EHLO
	mail-oa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752369Ab3HUXbL (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 21 Aug 2013 19:31:11 -0400
Received: by mail-oa0-f50.google.com with SMTP id i4so2245557oah.9
        for <linux-pci@vger.kernel.org>; Wed, 21 Aug 2013 16:31:10 -0700 (PDT)
Date: Wed, 21 Aug 2013 17:31:06 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Yijing Wang <wangyijing@huawei.com>
Cc: Jon Mason <jdmason@kudzu.us>, linux-pci@vger.kernel.org,
	Hanjun Guo <guohanjun@huawei.com>, jiang.liu@huawei.com,
	stable@vger.kernel.org.#.3.4+
Subject: Re: [PATCH v6 2/2] PCI: update device mps when doing pci hotplug
Message-ID: <20130821233106.GA31379@google.com>
References: <1377051937-5712-1-git-send-email-wangyijing@huawei.com>
 <1377051937-5712-3-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1377051937-5712-3-git-send-email-wangyijing@huawei.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Aug 21, 2013 at 10:25:37AM +0800, Yijing Wang wrote:
> Currently we don't update device's mps value when doing
> pci device hot-add. The hot-added device's mps will be set
> to default value (128B). But the upstream port device's mps
> may be larger than 128B which was set by firmware during
> system bootup. In this case the new added device may not
> work normally. This patch try to update the hot added device
> mps equal to its parent mps, if device mpss < parent mps,
> print warning.
> 
> References: https://bugzilla.kernel.org/show_bug.cgi?id=60671
> Reported-by: Yijing Wang <wangyijing@huawei.com>
> Signed-off-by: Yijing Wang <wangyijing@huawei.com>
> Cc: Jon Mason <jdmason@kudzu.us>
> Cc: stable@vger.kernel.org # 3.4+
> ---
>  drivers/pci/probe.c |   49 ++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 files changed, 48 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 160ae38..a18fa3b 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1600,6 +1600,44 @@ static int pcie_bus_configure_set(struct pci_dev *dev, void *data)
>  	return 0;
>  }
>  
> +static int pcie_bus_update_set(struct pci_dev *dev, void *data)
> +{
> +	int mps, p_mps, mpss;
> +	struct pci_dev *parent;
> +
> +	if (!pci_is_pcie(dev) || !dev->bus->self)
> +		return 0;
> +
> +	parent = dev->bus->self;
> +	mps = pcie_get_mps(dev);
> +	p_mps = pcie_get_mps(dev->bus->self);
> +
> +	if (mps >= p_mps)
> +		return 0;
> +
> +	/* we only update the device mps, unless its parent device is root port,
> +	 * and it is the only slot directly connected to root port.
> +	 */
> +	mpss = 128 << dev->pcie_mpss;
> +	if (mpss >= p_mps) {
> +		pcie_write_mps(dev, p_mps);
> +	} else if (pci_pcie_type(parent) == PCI_EXP_TYPE_ROOT_PORT &&
> +			pci_only_one_slot(dev->bus)) {

Good grief.  You apparently didn't even compile this, because
pci_only_one_slot() doesn't exist.

I reworked a couple of your previous patches and added a cleanup or two
of my own.  I'll post those as v7, and you can fix this one and post it
as a v8.  That way you and Jon can fix errors in my comments and changelogs
at the same time.

> +		pcie_write_mps(parent, mpss);
> +		pcie_write_mps(dev, mpss);
> +	} else
> +		dev_warn(&dev->dev, "MPS %d MPSS %d both smaller than upstream MPS %d\n"
> +				"If necessary, use \"pci=pcie_bus_peer2peer\" boot parameter to avoid this problem\n",
> +				mps, 128 << dev->pcie_mpss, p_mps);
> +	return 0;
> +}
> +
> +static void pcie_bus_update_setting(struct pci_bus *bus)
> +{
> +	if (bus->self->is_hotplug_bridge)
> +		pci_walk_bus(bus, pcie_bus_update_set, NULL);
> +}
> +
>  /* pcie_bus_configure_settings requires that pci_walk_bus work in a top-down,
>   * parents then children fashion.  If this changes, then this code will not
>   * work as designed.
> @@ -1611,8 +1649,17 @@ void pcie_bus_configure_settings(struct pci_bus *bus, u8 mpss)
>  	if (!pci_is_pcie(bus->self))
>  		return;
>  
> -	if (pcie_bus_config == PCIE_BUS_TUNE_OFF)
> +	if (pcie_bus_config == PCIE_BUS_TUNE_OFF) {
> +		/* Sometimes we should update device mps here,
> +		 * eg. after hot add, device mps value will be
> +		 * set to default(128B), but the upstream port
> +		 * mps value may be larger than 128B, if we do
> +		 * not update the device mps, it maybe can not
> +		 * work normally.
> +		 */
> +		pcie_bus_update_setting(bus);
>  		return;
> +	}
>  
>  	/* FIXME - Peer to peer DMA is possible, though the endpoint would need
>  	 * to be aware to the MPS of the destination.  To work around this,
> -- 
> 1.7.1
> 
> 
