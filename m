Return-Path: <SRS0=/qR3=MN=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64722C43143
	for <linux-pci@archiver.kernel.org>; Mon,  1 Oct 2018 14:01:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 372A22064D
	for <linux-pci@archiver.kernel.org>; Mon,  1 Oct 2018 14:01:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 372A22064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729291AbeJAUjG (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 1 Oct 2018 16:39:06 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:49614 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729289AbeJAUjG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 1 Oct 2018 16:39:06 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 81C797A9;
        Mon,  1 Oct 2018 07:01:09 -0700 (PDT)
Received: from red-moon (red-moon.emea.arm.com [10.4.13.120])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9599B3F5B7;
        Mon,  1 Oct 2018 07:01:07 -0700 (PDT)
Date:   Mon, 1 Oct 2018 15:01:46 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org,
        Jan =?iso-8859-1?Q?Kundr=E1t?= <jan.kundrat@cesnet.cz>,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        linux-arm-kernel@lists.infradead.org,
        Russell King <linux@arm.linux.org.uk>
Subject: Re: [PATCH] PCI: mvebu: Fix PCI I/O mapping creation sequence
Message-ID: <20181001140137.GA13049@red-moon>
References: <20181001124934.7222-1-thomas.petazzoni@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181001124934.7222-1-thomas.petazzoni@bootlin.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Oct 01, 2018 at 02:49:34PM +0200, Thomas Petazzoni wrote:
> Commit ee1604381a371 ("PCI: mvebu: Only remap I/O space if
> configured") had the side effect that the PCI I/O mapping was created
> much earlier than before, at a point where the probe() of the driver
> could still fail. This is for example a problem if one gets an
> -EPROBE_DEFER at some point during probe(), after pci_ioremap_io() has
> been called.
> 
> Indeed, there is currently no function to undo what pci_ioremap_io()
> did, and switching to pci_remap_iospace() is not an option in
> pci-mvebu due to the need for special memory attributes on Armada 38x.
> 
> Reverting ee1604381a371 ("PCI: mvebu: Only remap I/O space if
> configured") would be a possibility, but it would require also
> reverting 42342073e38b5 ("PCI: mvebu: Convert to use pci_host_bridge
> directly"). So instead, we use an open-coded version of
> pci_host_probe() that creates the PCI I/O mapping at a point where we
> are guaranteed not to fail anymore.
> 
> Reported-by: Jan Kundrát <jan.kundrat@cesnet.cz>
> Fixes: ee1604381a371 ("PCI: mvebu: Only remap I/O space if configured")
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
> ---
>  drivers/pci/controller/pci-mvebu.c | 52 +++++++++++++++++++++++++++++++++++---
>  1 file changed, 48 insertions(+), 4 deletions(-)

Thank you Thomas.

Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

Bjorn, is it possible please to send this patch for -rc7 ? It is
a regression we introduced in the last cycle.

Thanks,
Lorenzo

> diff --git a/drivers/pci/controller/pci-mvebu.c b/drivers/pci/controller/pci-mvebu.c
> index 50eb0729385b..a41d79b8d46a 100644
> --- a/drivers/pci/controller/pci-mvebu.c
> +++ b/drivers/pci/controller/pci-mvebu.c
> @@ -1145,7 +1145,6 @@ static int mvebu_pcie_parse_request_resources(struct mvebu_pcie *pcie)
>  {
>  	struct device *dev = &pcie->pdev->dev;
>  	struct device_node *np = dev->of_node;
> -	unsigned int i;
>  	int ret;
>  
>  	INIT_LIST_HEAD(&pcie->resources);
> @@ -1179,13 +1178,58 @@ static int mvebu_pcie_parse_request_resources(struct mvebu_pcie *pcie)
>  					 resource_size(&pcie->io) - 1);
>  		pcie->realio.name = "PCI I/O";
>  
> +		pci_add_resource(&pcie->resources, &pcie->realio);
> +	}
> +
> +	return devm_request_pci_bus_resources(dev, &pcie->resources);
> +}
> +
> +/*
> + * This is a copy of pci_host_probe(), except that it does the I/O
> + * remap as the last step, once we are sure we won't fail.
> + *
> + * It should be removed once the I/O remap error handling issue has
> + * been sorted out.
> + */
> +static int mvebu_pci_host_probe(struct pci_host_bridge *bridge)
> +{
> +	struct mvebu_pcie *pcie;
> +	struct pci_bus *bus, *child;
> +	int ret;
> +
> +	ret = pci_scan_root_bus_bridge(bridge);
> +	if (ret < 0) {
> +		dev_err(bridge->dev.parent, "Scanning root bridge failed");
> +		return ret;
> +	}
> +
> +	pcie = pci_host_bridge_priv(bridge);
> +	if (resource_size(&pcie->io) != 0) {
> +		unsigned int i;
> +
>  		for (i = 0; i < resource_size(&pcie->realio); i += SZ_64K)
>  			pci_ioremap_io(i, pcie->io.start + i);
> +	}
>  
> -		pci_add_resource(&pcie->resources, &pcie->realio);
> +	bus = bridge->bus;
> +
> +	/*
> +	 * We insert PCI resources into the iomem_resource and
> +	 * ioport_resource trees in either pci_bus_claim_resources()
> +	 * or pci_bus_assign_resources().
> +	 */
> +	if (pci_has_flag(PCI_PROBE_ONLY)) {
> +		pci_bus_claim_resources(bus);
> +	} else {
> +		pci_bus_size_bridges(bus);
> +		pci_bus_assign_resources(bus);
> +
> +		list_for_each_entry(child, &bus->children, node)
> +			pcie_bus_configure_settings(child);
>  	}
>  
> -	return devm_request_pci_bus_resources(dev, &pcie->resources);
> +	pci_bus_add_devices(bus);
> +	return 0;
>  }
>  
>  static int mvebu_pcie_probe(struct platform_device *pdev)
> @@ -1268,7 +1312,7 @@ static int mvebu_pcie_probe(struct platform_device *pdev)
>  	bridge->align_resource = mvebu_pcie_align_resource;
>  	bridge->msi = pcie->msi;
>  
> -	return pci_host_probe(bridge);
> +	return mvebu_pci_host_probe(bridge);
>  }
>  
>  static const struct of_device_id mvebu_pcie_of_match_table[] = {
> -- 
> 2.14.4
> 
