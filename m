Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:52584 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932191AbaICWlZ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 3 Sep 2014 18:41:25 -0400
Received: by mail-pa0-f43.google.com with SMTP id et14so18626242pad.2
        for <linux-pci@vger.kernel.org>; Wed, 03 Sep 2014 15:41:24 -0700 (PDT)
Date: Wed, 3 Sep 2014 16:42:01 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Yijing Wang <wangyijing@huawei.com>
Cc: linux-pci@vger.kernel.org, Jordan_Hargrave@Dell.com,
	keith.busch@intel.com, jon.mason@intel.com,
	Jon Mason <jdmason@kudzu.us>
Subject: Re: [PATCH] PCI: update device mps when doing pci hotplug
Message-ID: <20140903224201.GD26073@google.com>
References: <1406621877-12022-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1406621877-12022-1-git-send-email-wangyijing@huawei.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jul 29, 2014 at 04:17:57PM +0800, Yijing Wang wrote:
> Currently we don't update device's mps value when doing
> pci device hot-add. The hot-added device's mps will be set
> to default value (128B). But the upstream port device's mps
> may be larger than 128B which was set by firmware during
> system bootup. In this case the new added device may not
> work normally. This issue was found in huawei 5885 server
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

Part of this looks redundant because pcie_bus_configure_set() already
checks pci_is_pcie().  And I don't know why we need to test
is_hotplug_bridge here; MPS settings need to be consistent regardless of
whether the upstream bridge supports hotplug.

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

Since we can't configure the new device correctly, we really shouldn't
allow a driver to bind to it.  The current design doesn't have much
provision for doing that, so warning is probably all we can do.

> +	}
> +
> +	pcie_write_mps(dev, p_mps);
> +	dev_info(&dev->dev, "Max Payload Size set to %4d/%4d (was %4d)\n", 
> +			pcie_get_mps(dev), 128 << dev->pcie_mpss, mps);
> +}
> +
>  static void pcie_bus_detect_mps(struct pci_dev *dev)
>  {
>  	struct pci_dev *bridge = dev->bus->self;
> @@ -1637,6 +1675,7 @@ static int pcie_bus_configure_set(struct pci_dev *dev, void *data)
>  		return 0;
>  
>  	if (pcie_bus_config == PCIE_BUS_TUNE_OFF) {
> +		pcie_bus_update_set(dev);

You're only adding this to the PCIE_BUS_TUNE_OFF path.  Can't the same
problem occur for other pcie_bus_config settings?

>  		pcie_bus_detect_mps(dev);
>  		return 0;
>  	}

I have some long-term ideas here (below), but to make progress in the short
term, I think we just need to make sure this handles all pcie_bus_config
settings.

Bjorn



Stepping back a long ways, I think the current design is hard to use.
It's set up with the idea that we (1) enumerate all the devices in the
system, and then (2) configure MPS for everything all at once.

That's not a very good fit when we start hotplugging devices, and it's
part of the reason MPS configuration is not well integrated into the PCI
core and doesn't get done at all for most architectures.

What I'd prefer is something that could be done in the core as each device
is enumerated, e.g., in or near pci_device_add().  I know there's tension
between the need to do this before drivers bind to the device and the
desire to enumerate the whole hierarchy before committing to MPS settings.
But we need to handle that tension anyway for hot-added devices, so we
might as well deal with it at boot-time and use the same code path for
both boot-time and hot-add time.

I have in mind something like this:

  pcie_configure_mps(struct pci_dev *dev)
  {
    int ret;

    if (!pci_is_pci(dev))
      return;

    if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT) {
      /* set my MPS to dev->pcie_mpss (max supported size) */
      return;
    }

    if (dev->pcie_mpss >= upstream bridge MPS) {
      /* set my MPS to upstream bridge MPS */
      return;
    }

    ret = pcie_set_hierarchy_mps(pcie_root_port(dev), dev->mpss);
    if (ret == failure)
      /* emit warning, can't enable this device */
  }

  struct pci_dev *pcie_root_port(struct pci_dev *dev)
  {
    if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT)
      return dev;

    return pcie_root_port(dev->bus->self);
  }

  pcie_set_hierarchy_mps(struct pci_dev *root, int mpss)
  {
    struct pci_bus *secondary;
    struct pci_dev *dev;
    int ret;

    if (root->driver)
      return -EINVAL;

    secondary = root->subordinate;
    if (secondary) {
      list_for_each_entry(dev, &secondary->devices, bus_list) {
	ret = pcie_set_hierarchy(dev, mpss);
	if (ret)
	  return ret;
      }
    }

    /* set my MPS to mpss */
    return 0;
  }
