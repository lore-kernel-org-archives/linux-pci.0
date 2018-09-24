Return-Path: <SRS0=+fdl=MG=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B5B8C433F4
	for <linux-pci@archiver.kernel.org>; Mon, 24 Sep 2018 14:15:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1F2A20883
	for <linux-pci@archiver.kernel.org>; Mon, 24 Sep 2018 14:15:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1F2A20883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728233AbeIXURk (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 24 Sep 2018 16:17:40 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:36286 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725982AbeIXURk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 24 Sep 2018 16:17:40 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4940080D;
        Mon, 24 Sep 2018 07:15:19 -0700 (PDT)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.Emea.Arm.com [10.4.13.117])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A1E5A3F5B7;
        Mon, 24 Sep 2018 07:15:17 -0700 (PDT)
Date:   Mon, 24 Sep 2018 15:15:12 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc:     Russell King - ARM Linux <linux@armlinux.org.uk>,
        Jan Kundr??t <jan.kundrat@cesnet.cz>,
        Baruch Siach <baruch@tkos.co.il>,
        Jason Cooper <jason@lakedaemon.net>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [BISECTED] Regression: Solidrun Clearfog Base won't boot since
 "PCI: mvebu: Only remap I/O space if configured"
Message-ID: <20180924141512.GA11875@e107981-ln.cambridge.arm.com>
References: <20180912231050.GX30658@n2100.armlinux.org.uk>
 <20180913094515.351967bb@windsurf>
 <5ad46fec-a71a-477a-b23f-d20aacfb481d@cesnet.cz>
 <20180913104241.65db8243@windsurf>
 <20180924101213.GO30658@n2100.armlinux.org.uk>
 <20180924122614.70738b5c@windsurf>
 <20180924111341.GP30658@n2100.armlinux.org.uk>
 <20180924141203.3df9707a@windsurf>
 <20180924124620.GA10322@e107981-ln.cambridge.arm.com>
 <20180924151040.5e57462b@windsurf>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180924151040.5e57462b@windsurf>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Sep 24, 2018 at 03:10:40PM +0200, Thomas Petazzoni wrote:
> Hello,
> 
> On Mon, 24 Sep 2018 13:46:29 +0100, Lorenzo Pieralisi wrote:
> 
> > What I think you can do short term, given that AFAICS MVEBU is not
> > removable, instead of using pci_host_probe() you move part of its code
> > into the driver and make sure that you remap IO as last operation before
> > probe completion (ie after scanning the host bridge) so that you do not
> > need to unmap it on failure; write a commit log summarising/linking this
> > thread please and when v4.20 lands we will give this a more thorough
> > look as Russell requested.
> > 
> > How does that sound ?
> 
> The only thing that can fail in pci_host_probe() is:
> 
> 	ret = pci_scan_root_bus_bridge(bridge);
> 	if (ret < 0) {
> 		dev_err(bridge->dev.parent, "Scanning root bridge
> 	failed"); return ret;
> 	}
> 
> In the pci-mvebu driver prior to the conversion to pci_host_probe(),
> the code flow at the end of ->probe() was:
> 
>   mvebu_pcie_enable()
>     pci_common_init_dev()
>       pcibios_init_hw()
> 
> and pcibios_init_hw() calls pci_scan_root_bus_bridge(), without doing
> much about the return value other than issuing a warning:
> 
>                                 ret = pci_scan_root_bus_bridge(bridge);
>                         }
> 
>                         if (WARN(ret < 0, "PCI: unable to scan bus!")) {
>                                 pci_free_host_bridge(bridge);
>                                 break;
>                         }
> 
> I.e, even before the conversion to pci_host_probe(), in case of
> failure in pci_scan_root_bus_bridge(), we would have the I/O mapping in
> place, but the PCI controller not registered.
> 
> We could keep the same (not great) behavior by doing:
> 
> diff --git a/drivers/pci/controller/pci-mvebu.c b/drivers/pci/controller/pci-mvebu.c
> index 50eb0729385b..487492f0c5f7 100644
> --- a/drivers/pci/controller/pci-mvebu.c
> +++ b/drivers/pci/controller/pci-mvebu.c
> @@ -1179,9 +1179,6 @@ static int mvebu_pcie_parse_request_resources(struct mvebu_pcie *pcie)
>                                          resource_size(&pcie->io) - 1);
>                 pcie->realio.name = "PCI I/O";
>  
> -               for (i = 0; i < resource_size(&pcie->realio); i += SZ_64K)
> -                       pci_ioremap_io(i, pcie->io.start + i);
> -
>                 pci_add_resource(&pcie->resources, &pcie->realio);
>         }
>  
> @@ -1197,7 +1194,7 @@ static int mvebu_pcie_probe(struct platform_device *pdev)
>         struct device_node *child;
>         int num, i, ret;
>  
> -       bridge = devm_pci_alloc_host_bridge(dev, sizeof(struct mvebu_pcie));
> +       bridge = pci_alloc_host_bridge(sizeof(struct mvebu_pcie));
>         if (!bridge)
>                 return -ENOMEM;
>  
> @@ -1212,8 +1209,10 @@ static int mvebu_pcie_probe(struct platform_device *pdev)
>         num = of_get_available_child_count(np);
>  
>         pcie->ports = devm_kcalloc(dev, num, sizeof(*pcie->ports), GFP_KERNEL);
> -       if (!pcie->ports)
> -               return -ENOMEM;
> +       if (!pcie->ports) {
> +               ret = -ENOMEM;
> +               goto free_host_bridge;
> +       }
>  
>         i = 0;
>         for_each_available_child_of_node(np, child) {
> @@ -1222,7 +1221,7 @@ static int mvebu_pcie_probe(struct platform_device *pdev)
>                 ret = mvebu_pcie_parse_port(pcie, port, child);
>                 if (ret < 0) {
>                         of_node_put(child);
> -                       return ret;
> +                       goto free_host_bridge;
>                 } else if (ret == 0) {
>                         continue;
>                 }
> @@ -1268,7 +1267,21 @@ static int mvebu_pcie_probe(struct platform_device *pdev)
>         bridge->align_resource = mvebu_pcie_align_resource;
>         bridge->msi = pcie->msi;
>  
> -       return pci_host_probe(bridge);
> +       if (resource_size(&pcie->io) != 0) {
> +               for (i = 0; i < resource_size(&pcie->realio); i += SZ_64K)
> +                       pci_ioremap_io(i, pcie->io.start + i);
> +       }
> +
> +       ret = pci_host_probe(bridge);
> +       if (ret)
> +               pci_free_host_bridge(bridge);
> +
> +       /* Yes, when pci_host_probe() returns a failure, we don't care */
> +       return 0;
> +
> +free_host_bridge:
> +       pci_free_host_bridge(bridge);
> +       return ret;
>  }
>  
>  static const struct of_device_id mvebu_pcie_of_match_table[] = {
> 
> I.e, we simply ignore the failure of pci_host_probe().
> 
> To be honest, I really prefer the option of introducing pci_unmap_io().

I understand that, I wanted to make sure we come up with a fix asap
and what I put forward would cover everything discussed in this thread,
at least temporarily, giving us time to check ISA related issues while
unmapping IO space.

Lorenzo
