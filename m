Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f171.google.com ([209.85.214.171]:32965 "EHLO
	mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753419Ab3HVSSe (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 22 Aug 2013 14:18:34 -0400
Received: by mail-ob0-f171.google.com with SMTP id tb18so4333437obb.16
        for <linux-pci@vger.kernel.org>; Thu, 22 Aug 2013 11:18:34 -0700 (PDT)
Date: Thu, 22 Aug 2013 12:18:23 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Yijing Wang <wangyijing@huawei.com>
Cc: Jon Mason <jdmason@kudzu.us>, linux-pci@vger.kernel.org,
	Hanjun Guo <guohanjun@huawei.com>, jiang.liu@huawei.com,
	joe.jin@oracle.com
Subject: Re: [PATCH v8 6/6] PCI: update device mps when doing pci hotplug
Message-ID: <20130822181823.GA25721@google.com>
References: <1377141888-7000-1-git-send-email-wangyijing@huawei.com>
 <1377141888-7000-7-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1377141888-7000-7-git-send-email-wangyijing@huawei.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Joe]

On Thu, Aug 22, 2013 at 11:24:48AM +0800, Yijing Wang wrote:
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
>  drivers/pci/probe.c |   48 +++++++++++++++++++++++++++++++++++++++++++++++-
>  1 files changed, 47 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 4afd158..06e88c5 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1602,6 +1602,43 @@ static int pcie_bus_configure_set(struct pci_dev *dev, void *data)
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
> +	} else if (pci_pcie_type(parent) == PCI_EXP_TYPE_ROOT_PORT) {
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
> @@ -1616,8 +1653,17 @@ void pcie_bus_configure_settings(struct pci_bus *bus)
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

I think the strategy of updating the device MPS when possible makes
sense, but I don't think we should do it in PCIE_BUS_TUNE_OFF mode.
That mode is documented as "Disable PCIe MPS tuning and use the
BIOS-configured MPS defaults."  This patch changes that to something
like "Disable PCIe MPS tuning, except for hot-added devices" and there
is no longer a way to tell Linux to never touch MPS.

Eventually, I think the default mode should change to PCIE_BUS_SAFE,
where Linux changes MPS settings at boot-time and at hotplug-time to
make sure every device works.  (This mode assumes no peer-to-peer
DMA.)  I know this was tried in the past, and we tripped over all
sorts of issues, but it's not clear how many were problems with the
Linux code and how many were unsolvable BIOS or platform issues.

Then we'd have these choices:

  PCIE_BUS_TUNE_OFF	Never touch MPS
  PCIE_BUS_PEER2PEER	Set all MPS to 128, so peer-to-peer DMA works
  PCIE_BUS_SAFE		Configure each device with largest safe MPS
			(assumes no peer-to-peer DMA)
  PCIE_BUS_PERFORMANCE	Use MRRS in addition to MPS
			(assumes no peer-to-peer DMA)

The hot-add issue [1] could be regarded as a BIOS bug -- the BIOS
programmed a hotplug bridge with MPS=256.  A hot-added device powers
up with MPS=128, so it's only safe for BIOS to set MPS=256 if the OS
is smart enough to change the bridge MPS, the device MPS, or both, at
hot-add time.  That doesn't seem like a good assumption for a BIOS to
make.

I think we should always *warn* about potential MPS issues, even in
PCIE_BUS_TUNE_OFF mode.  That would help diagnose the hot-add issue as
well as issues like the ones Joe Jin reported [2] and [3].

I think what we should do is *always* call pcie_bus_configure_set(),
no matter what mode we're in, but make pcie_bus_configure_set() smart
enough to do different things (print warnings, adjust settings, do the
stuff you added in pcie_bus_update_set(), etc.) depending on what mode
we're in.

Bjorn

>  		return;
> +	}
>  
>  	/* FIXME - Peer to peer DMA is possible, though the endpoint would need
>  	 * to be aware to the MPS of the destination.  To work around this,
> -- 
> 1.7.1
> 
> 

[1] https://bugzilla.kernel.org/show_bug.cgi?id=60671
[2] http://lkml.kernel.org/r/4FFA9B96.6040901@oracle.com
[3] http://lkml.kernel.org/r/509B5038.8090304@oracle.com
