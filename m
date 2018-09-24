Return-Path: <SRS0=+fdl=MG=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A068DC433F4
	for <linux-pci@archiver.kernel.org>; Mon, 24 Sep 2018 13:10:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E3032098A
	for <linux-pci@archiver.kernel.org>; Mon, 24 Sep 2018 13:10:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E3032098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729330AbeIXTMt (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 24 Sep 2018 15:12:49 -0400
Received: from mail.bootlin.com ([62.4.15.54]:39811 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729307AbeIXTMt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 24 Sep 2018 15:12:49 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 2C5CF20723; Mon, 24 Sep 2018 15:10:40 +0200 (CEST)
Received: from windsurf (AAubervilliers-681-1-42-80.w90-88.abo.wanadoo.fr [90.88.160.80])
        by mail.bootlin.com (Postfix) with ESMTPSA id D4C0D204AE;
        Mon, 24 Sep 2018 15:10:39 +0200 (CEST)
Date:   Mon, 24 Sep 2018 15:10:40 +0200
From:   Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Russell King - ARM Linux <linux@armlinux.org.uk>,
        Jan Kundr??t <jan.kundrat@cesnet.cz>,
        Baruch Siach <baruch@tkos.co.il>,
        Jason Cooper <jason@lakedaemon.net>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [BISECTED] Regression: Solidrun Clearfog Base won't boot since
 "PCI: mvebu: Only remap I/O space if configured"
Message-ID: <20180924151040.5e57462b@windsurf>
In-Reply-To: <20180924124620.GA10322@e107981-ln.cambridge.arm.com>
References: <61fdfd69-2bb6-478c-b0d5-69d8744adae3@cesnet.cz>
        <87zhwm4kl6.fsf@tkos.co.il>
        <20180912231050.GX30658@n2100.armlinux.org.uk>
        <20180913094515.351967bb@windsurf>
        <5ad46fec-a71a-477a-b23f-d20aacfb481d@cesnet.cz>
        <20180913104241.65db8243@windsurf>
        <20180924101213.GO30658@n2100.armlinux.org.uk>
        <20180924122614.70738b5c@windsurf>
        <20180924111341.GP30658@n2100.armlinux.org.uk>
        <20180924141203.3df9707a@windsurf>
        <20180924124620.GA10322@e107981-ln.cambridge.arm.com>
Organization: Bootlin (formerly Free Electrons)
X-Mailer: Claws Mail 3.15.1-dirty (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello,

On Mon, 24 Sep 2018 13:46:29 +0100, Lorenzo Pieralisi wrote:

> What I think you can do short term, given that AFAICS MVEBU is not
> removable, instead of using pci_host_probe() you move part of its code
> into the driver and make sure that you remap IO as last operation before
> probe completion (ie after scanning the host bridge) so that you do not
> need to unmap it on failure; write a commit log summarising/linking this
> thread please and when v4.20 lands we will give this a more thorough
> look as Russell requested.
> 
> How does that sound ?

The only thing that can fail in pci_host_probe() is:

	ret = pci_scan_root_bus_bridge(bridge);
	if (ret < 0) {
		dev_err(bridge->dev.parent, "Scanning root bridge
	failed"); return ret;
	}

In the pci-mvebu driver prior to the conversion to pci_host_probe(),
the code flow at the end of ->probe() was:

  mvebu_pcie_enable()
    pci_common_init_dev()
      pcibios_init_hw()

and pcibios_init_hw() calls pci_scan_root_bus_bridge(), without doing
much about the return value other than issuing a warning:

                                ret = pci_scan_root_bus_bridge(bridge);
                        }

                        if (WARN(ret < 0, "PCI: unable to scan bus!")) {
                                pci_free_host_bridge(bridge);
                                break;
                        }

I.e, even before the conversion to pci_host_probe(), in case of
failure in pci_scan_root_bus_bridge(), we would have the I/O mapping in
place, but the PCI controller not registered.

We could keep the same (not great) behavior by doing:

diff --git a/drivers/pci/controller/pci-mvebu.c b/drivers/pci/controller/pci-mvebu.c
index 50eb0729385b..487492f0c5f7 100644
--- a/drivers/pci/controller/pci-mvebu.c
+++ b/drivers/pci/controller/pci-mvebu.c
@@ -1179,9 +1179,6 @@ static int mvebu_pcie_parse_request_resources(struct mvebu_pcie *pcie)
                                         resource_size(&pcie->io) - 1);
                pcie->realio.name = "PCI I/O";
 
-               for (i = 0; i < resource_size(&pcie->realio); i += SZ_64K)
-                       pci_ioremap_io(i, pcie->io.start + i);
-
                pci_add_resource(&pcie->resources, &pcie->realio);
        }
 
@@ -1197,7 +1194,7 @@ static int mvebu_pcie_probe(struct platform_device *pdev)
        struct device_node *child;
        int num, i, ret;
 
-       bridge = devm_pci_alloc_host_bridge(dev, sizeof(struct mvebu_pcie));
+       bridge = pci_alloc_host_bridge(sizeof(struct mvebu_pcie));
        if (!bridge)
                return -ENOMEM;
 
@@ -1212,8 +1209,10 @@ static int mvebu_pcie_probe(struct platform_device *pdev)
        num = of_get_available_child_count(np);
 
        pcie->ports = devm_kcalloc(dev, num, sizeof(*pcie->ports), GFP_KERNEL);
-       if (!pcie->ports)
-               return -ENOMEM;
+       if (!pcie->ports) {
+               ret = -ENOMEM;
+               goto free_host_bridge;
+       }
 
        i = 0;
        for_each_available_child_of_node(np, child) {
@@ -1222,7 +1221,7 @@ static int mvebu_pcie_probe(struct platform_device *pdev)
                ret = mvebu_pcie_parse_port(pcie, port, child);
                if (ret < 0) {
                        of_node_put(child);
-                       return ret;
+                       goto free_host_bridge;
                } else if (ret == 0) {
                        continue;
                }
@@ -1268,7 +1267,21 @@ static int mvebu_pcie_probe(struct platform_device *pdev)
        bridge->align_resource = mvebu_pcie_align_resource;
        bridge->msi = pcie->msi;
 
-       return pci_host_probe(bridge);
+       if (resource_size(&pcie->io) != 0) {
+               for (i = 0; i < resource_size(&pcie->realio); i += SZ_64K)
+                       pci_ioremap_io(i, pcie->io.start + i);
+       }
+
+       ret = pci_host_probe(bridge);
+       if (ret)
+               pci_free_host_bridge(bridge);
+
+       /* Yes, when pci_host_probe() returns a failure, we don't care */
+       return 0;
+
+free_host_bridge:
+       pci_free_host_bridge(bridge);
+       return ret;
 }
 
 static const struct of_device_id mvebu_pcie_of_match_table[] = {

I.e, we simply ignore the failure of pci_host_probe().

To be honest, I really prefer the option of introducing pci_unmap_io().

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
