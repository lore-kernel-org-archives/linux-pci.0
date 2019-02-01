Return-Path: <SRS0=jDI6=QI=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB762C282D8
	for <linux-pci@archiver.kernel.org>; Fri,  1 Feb 2019 22:54:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3207214C6
	for <linux-pci@archiver.kernel.org>; Fri,  1 Feb 2019 22:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549061671;
	bh=MQpgxjQ3jciU2UyeiyCBFbU+Z7rWNZ563kpphRtj4GY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=RolbCopGAamQSeJtppnn1XHjNxN3kQQqSV4RwR6GdRYVjPripbyNadJANxHQRe8m3
	 jZz6s41ooUvCjN5XHkCaDn7WO/uajs78QWAjwNnzfDd+wzJXx+D8nQ1daVwHOZ4kIu
	 pXlsqghEsm+Z2c8etGDzd+aP9P3sXy/4jSJHZGMY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726582AbfBAWya (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 1 Feb 2019 17:54:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:44720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726456AbfBAWya (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 1 Feb 2019 17:54:30 -0500
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F3FEA2146E;
        Fri,  1 Feb 2019 22:54:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549061669;
        bh=MQpgxjQ3jciU2UyeiyCBFbU+Z7rWNZ563kpphRtj4GY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zuPHnb+rS16QZa5FuZjZrTwQEUOiuCfa4hdWLa3LbbqhmJgmAbvMeD0ucG7uV9ZF3
         y63+TrGGSUtbh/1cWYublrD2KGMt35j+BPJ9PxwsmcINn0e1VfQhG+KU9Z2DasygQM
         FdzEFY3/CaOQJByy5/wJN16tNHmh3qpFaqq67QYQ=
Date:   Fri, 1 Feb 2019 16:54:27 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jon Derrick <jonathan.derrick@intel.com>
Cc:     linux-pci@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Yinghai Lu <yinghai@kernel.org>
Subject: Re: [PATCH v2] PCI: Configure MPS on rescan
Message-ID: <20190201225427.GU229773@google.com>
References: <20181106201242.2862-1-jonathan.derrick@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181106201242.2862-1-jonathan.derrick@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 06, 2018 at 01:12:42PM -0700, Jon Derrick wrote:
> During pci_rescan_bus(), we may encounter new buses and devices which
> don't have MPS set for compatibility. Using this path, newly discovered
> buses and devices would then require their MPS to be configured after
> driver attachment, which may be too late for drivers which do memory
> transactions on probe.

This definitely looks like something we need to do.  Have you tripped
over an actual problem?  If so, it might be interesting to include a
symptom here, e.g., Unsupported Request error for hot-added device, or
whatever it is.

Can you clarify the "would then require their MPS to be configured"
part?  Is there some path where we *do* configure MPS after driver
attachment?  Or is this just a way of saying that "if we don't
configure MPS *before* driver attachment, we would have to do it
after"?

I'm thinking we could simply say something like:

  During pci_rescan_bus(), we may encounter new devices which haven't
  had MPS configured.  Their MPS must be configured before we make the
  devices available for driver attachment by calling
  pci_bus_add_devices().

> This additionally ensures that any pcie_bus_config kernel settings will
> be applied to the buses and devices discovered through this path prior
> to driver attachment.
> 
> Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
> ---
> v1: https://patchwork.kernel.org/patch/10642019/
> 
>  drivers/pci/probe.c | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index b1c05b5054a0..126cd426b6f2 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -3156,6 +3156,34 @@ unsigned int pci_rescan_bus_bridge_resize(struct pci_dev *bridge)
>  	return max;
>  }
>  
> +/*
> + * Walks the PCI/PCIe tree to find the first instance of a PCIe device and
> + * hands off the PCIe bus to pcie_bus_configure_settings to walk the rest.
> + */
> +static int pcie_rescan_bus_configure_settings(struct pci_dev *dev, void *data)
> +{
> +	if (pci_is_pcie(dev)) {
> +		struct pci_bus *child, *bus = dev->bus;
> +
> +		list_for_each_entry(child, &bus->children, node)
> +			pcie_bus_configure_settings(child);

It looks possible that this could call pcie_bus_configure_settings()
a second time for a device that we've already configured.  For
example, it's legal to call pci_rescan_bus() on an arbitrary bus even
if there has been no hot-add event.

Is there something that prevents us from touching this
already-configured device?  *Probably* we would configure it the same
way the second time, but a driver is likely already attached to it,
and we shouldn't do anything to it.  Even if
pcie_bus_configure_settings() happens to be idempotent, that seems
like it would be hard to verify and keep true indefinitely.

Bjorn

> +
> +		return 1;
> +	}
> +	return 0;
> +}
> +
> +/**
> + * pci_bus_configure_settings - Configure bus settings
> + * @bus: PCI/PCIE bus to configure
> + *
> + * Currently only configures PCIe bus settings related to MPS and MRRS.
> + */
> +static void pci_bus_configure_settings(struct pci_bus *bus)
> +{
> +	pci_walk_bus(bus, pcie_rescan_bus_configure_settings, NULL);
> +}
> +
>  /**
>   * pci_rescan_bus - Scan a PCI bus for devices
>   * @bus: PCI bus to scan
> @@ -3171,6 +3199,7 @@ unsigned int pci_rescan_bus(struct pci_bus *bus)
>  
>  	max = pci_scan_child_bus(bus);
>  	pci_assign_unassigned_bus_resources(bus);
> +	pci_bus_configure_settings(bus);
>  	pci_bus_add_devices(bus);
>  
>  	return max;
> -- 
> 2.14.4
> 
