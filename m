Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:57351 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756615Ab3A0WUJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Sun, 27 Jan 2013 17:20:09 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Jiang Liu <jiang.liu@huawei.com>,
	Taku Izumi <izumi.taku@jp.fujitsu.com>,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 01/22] PCI: Rename pci_release_bus_bridge_dev to pci_release_host_bridge_dev
Date: Sun, 27 Jan 2013 23:26:16 +0100
Message-ID: <9382237.AQYEN5f655@vostro.rjw.lan>
In-Reply-To: <1359265003-16166-2-git-send-email-yinghai@kernel.org>
References: <CAE9FiQUhrVPNKcdWbiqHLa5PzH7Dg-uduVc9BP-OjM-eCqSXdw@mail.gmail.com> <1359265003-16166-1-git-send-email-yinghai@kernel.org> <1359265003-16166-2-git-send-email-yinghai@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Saturday, January 26, 2013 09:36:22 PM Yinghai Lu wrote:
> It is with host bridge, so change the name to reflect the fact.
> 
> Signed-off-by: Yinghai Lu <yinghai@kernel.org>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  drivers/pci/probe.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index b494066..ef50154 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1187,7 +1187,7 @@ int pci_cfg_space_size(struct pci_dev *dev)
>  	return PCI_CFG_SPACE_SIZE;
>  }
>  
> -static void pci_release_bus_bridge_dev(struct device *dev)
> +static void pci_release_host_bridge_dev(struct device *dev)
>  {
>  	struct pci_host_bridge *bridge = to_pci_host_bridge(dev);
>  
> @@ -1692,7 +1692,7 @@ struct pci_bus *pci_create_root_bus(struct device *parent, int bus,
>  		goto err_out;
>  
>  	bridge->dev.parent = parent;
> -	bridge->dev.release = pci_release_bus_bridge_dev;
> +	bridge->dev.release = pci_release_host_bridge_dev;
>  	dev_set_name(&bridge->dev, "pci%04x:%02x", pci_domain_nr(b), bus);
>  	error = pcibios_root_bridge_prepare(bridge);
>  	if (error)
> 
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
