Return-Path: <SRS0=+gKf=SN=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64561C10F13
	for <linux-pci@archiver.kernel.org>; Thu, 11 Apr 2019 20:15:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 308652184E
	for <linux-pci@archiver.kernel.org>; Thu, 11 Apr 2019 20:15:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555013740;
	bh=24hwMdXJK2C2JM0b+d+8Ee83sS+2g88T1R6n21uE/Cw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=RxNCdyvTsIqaQHVcS//2aFfNSgJPzVB2Mxl82YWaT5VUz0Cp1UUecbMz4Aum0IlcA
	 YS69f0V4XbxR01pDbFKbc8S9yyIcDL4l6LIQtD2Y0QVTjqXiOnn4Oi3sKVz8gQjg45
	 8np9uJE7XZtBgNJnozBKGBtBdsE2DOAvNsa0gH0s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbfDKUPj (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 11 Apr 2019 16:15:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:43184 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726538AbfDKUPi (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 11 Apr 2019 16:15:38 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 28D0420850;
        Thu, 11 Apr 2019 20:15:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555013737;
        bh=24hwMdXJK2C2JM0b+d+8Ee83sS+2g88T1R6n21uE/Cw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0h14QDS8PdB/NehFMHMzgbDAY/gjTFJcyIDRbgET0NbvdQbZxPAH43OdS7RKbdVje
         BW6f1dttN92C59DHD6w8pZxw1jQDEMOuOgoTDBZrvVigI+2DO52w9ijynForyeU9O/
         h1nawQnVgbgtFEg4J0/mjN2j9P2tZU1cpXb1nqL0=
Date:   Thu, 11 Apr 2019 15:15:35 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc:     thierry.reding@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com,
        jonathanh@nvidia.com, lorenzo.pieralisi@arm.com, vidyas@nvidia.com,
        linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 22/30] PCI: tegra: Access endpoint config only if PCIe
 link is up
Message-ID: <20190411201535.GS256045@google.com>
References: <20190411170355.6882-1-mmaddireddy@nvidia.com>
 <20190411170355.6882-23-mmaddireddy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190411170355.6882-23-mmaddireddy@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Apr 11, 2019 at 10:33:47PM +0530, Manikanta Maddireddy wrote:
> Add PCIe link up check in config read and write callback functions
> before accessing endpoint config registers.
> 
> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> ---
>  drivers/pci/controller/pci-tegra.c | 38 ++++++++++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
> 
> diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
> index d08a63132c77..c050687020f0 100644
> --- a/drivers/pci/controller/pci-tegra.c
> +++ b/drivers/pci/controller/pci-tegra.c
> @@ -426,6 +426,14 @@ static inline u32 pads_readl(struct tegra_pcie *pcie, unsigned long offset)
>  	return readl(pcie->pads + offset);
>  }
>  
> +static bool tegra_pcie_link_status(struct tegra_pcie_port *port)

Most drivers call this *_pcie_link_up().  It would be better if tegra
followed that convention.

> +{
> +	u32 value;
> +
> +	value = readl(port->base + RP_LINK_CONTROL_STATUS);
> +	return !!(value & RP_LINK_CONTROL_STATUS_DL_LINK_ACTIVE);
> +}
> +
>  /*
>   * The configuration space mapping on Tegra is somewhat similar to the ECAM
>   * defined by PCIe. However it deviates a bit in how the 4 bits for extended
> @@ -491,20 +499,50 @@ static void __iomem *tegra_pcie_map_bus(struct pci_bus *bus,
>  static int tegra_pcie_config_read(struct pci_bus *bus, unsigned int devfn,
>  				  int where, int size, u32 *value)
>  {
> +	struct tegra_pcie *pcie = bus->sysdata;
> +	struct pci_dev *bridge;
> +	struct tegra_pcie_port *port;
> +
>  	if (bus->number == 0)
>  		return pci_generic_config_read32(bus, devfn, where, size,
>  						 value);
>  
> +	bridge = pcie_find_root_port(bus->self);
> +
> +	list_for_each_entry(port, &pcie->ports, list)
> +		if (port->index + 1 == PCI_SLOT(bridge->devfn))
> +			break;
> +
> +	/* If there is no link, then there is no device */
> +	if (!tegra_pcie_link_status(port)) {

This is racy and you should avoid it if possible.  The link could go down
between calling tegra_pcie_link_status() and issuing the config read/write.

If your driver is to be reliable, it must be able to handle any bad
consequence of issuing that config read/write anyway, so I think it's
better if it doesn't even bother checking whether the link is up.

> +		*value = 0xffffffff;
> +		return PCIBIOS_DEVICE_NOT_FOUND;
> +	}
> +
>  	return pci_generic_config_read(bus, devfn, where, size, value);
>  }
>  
>  static int tegra_pcie_config_write(struct pci_bus *bus, unsigned int devfn,
>  				   int where, int size, u32 value)
>  {
> +	struct tegra_pcie *pcie = bus->sysdata;
> +	struct tegra_pcie_port *port;
> +	struct pci_dev *bridge;
> +
>  	if (bus->number == 0)
>  		return pci_generic_config_write32(bus, devfn, where, size,
>  						  value);
>  
> +	bridge = pcie_find_root_port(bus->self);
> +
> +	list_for_each_entry(port, &pcie->ports, list)
> +		if (port->index + 1 == PCI_SLOT(bridge->devfn))
> +			break;
> +
> +	/* If there is no link, then there is no device */
> +	if (!tegra_pcie_link_status(port))
> +		return PCIBIOS_DEVICE_NOT_FOUND;
> +
>  	return pci_generic_config_write(bus, devfn, where, size, value);
>  }
>  
> -- 
> 2.17.1
> 
