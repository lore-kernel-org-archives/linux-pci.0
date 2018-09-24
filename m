Return-Path: <SRS0=+fdl=MG=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84C7FECE561
	for <linux-pci@archiver.kernel.org>; Mon, 24 Sep 2018 14:52:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49F332087A
	for <linux-pci@archiver.kernel.org>; Mon, 24 Sep 2018 14:52:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49F332087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730135AbeIXUzC (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 24 Sep 2018 16:55:02 -0400
Received: from mail.bootlin.com ([62.4.15.54]:42548 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728441AbeIXUzB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 24 Sep 2018 16:55:01 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id A61F9208B1; Mon, 24 Sep 2018 16:52:28 +0200 (CEST)
Received: from windsurf (AAubervilliers-681-1-42-80.w90-88.abo.wanadoo.fr [90.88.160.80])
        by mail.bootlin.com (Postfix) with ESMTPSA id 579A1207CA;
        Mon, 24 Sep 2018 16:52:18 +0200 (CEST)
Date:   Mon, 24 Sep 2018 16:52:18 +0200
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
Message-ID: <20180924165218.26c7c418@windsurf>
In-Reply-To: <20180924141512.GA11875@e107981-ln.cambridge.arm.com>
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
        <20180924141512.GA11875@e107981-ln.cambridge.arm.com>
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

On Mon, 24 Sep 2018 15:15:12 +0100, Lorenzo Pieralisi wrote:

> I understand that, I wanted to make sure we come up with a fix asap
> and what I put forward would cover everything discussed in this thread,
> at least temporarily, giving us time to check ISA related issues while
> unmapping IO space.

Something like this should implemented what you suggest I guess:

diff --git a/drivers/pci/controller/pci-mvebu.c b/drivers/pci/controller/pci-mvebu.c
index 50eb0729385b..a41d79b8d46a 100644
--- a/drivers/pci/controller/pci-mvebu.c
+++ b/drivers/pci/controller/pci-mvebu.c
@@ -1145,7 +1145,6 @@ static int mvebu_pcie_parse_request_resources(struct mvebu_pcie *pcie)
 {
        struct device *dev = &pcie->pdev->dev;
        struct device_node *np = dev->of_node;
-       unsigned int i;
        int ret;
 
        INIT_LIST_HEAD(&pcie->resources);
@@ -1179,13 +1178,58 @@ static int mvebu_pcie_parse_request_resources(struct mvebu_pcie *pcie)
                                         resource_size(&pcie->io) - 1);
                pcie->realio.name = "PCI I/O";
 
+               pci_add_resource(&pcie->resources, &pcie->realio);
+       }
+
+       return devm_request_pci_bus_resources(dev, &pcie->resources);
+}
+
+/*
+ * This is a copy of pci_host_probe(), except that it does the I/O
+ * remap as the last step, once we are sure we won't fail.
+ *
+ * It should be removed once the I/O remap error handling issue has
+ * been sorted out.
+ */
+static int mvebu_pci_host_probe(struct pci_host_bridge *bridge)
+{
+       struct mvebu_pcie *pcie;
+       struct pci_bus *bus, *child;
+       int ret;
+
+       ret = pci_scan_root_bus_bridge(bridge);
+       if (ret < 0) {
+               dev_err(bridge->dev.parent, "Scanning root bridge failed");
+               return ret;
+       }
+
+       pcie = pci_host_bridge_priv(bridge);
+       if (resource_size(&pcie->io) != 0) {
+               unsigned int i;
+
                for (i = 0; i < resource_size(&pcie->realio); i += SZ_64K)
                        pci_ioremap_io(i, pcie->io.start + i);
+       }
 
-               pci_add_resource(&pcie->resources, &pcie->realio);
+       bus = bridge->bus;
+
+       /*
+        * We insert PCI resources into the iomem_resource and
+        * ioport_resource trees in either pci_bus_claim_resources()
+        * or pci_bus_assign_resources().
+        */
+       if (pci_has_flag(PCI_PROBE_ONLY)) {
+               pci_bus_claim_resources(bus);
+       } else {
+               pci_bus_size_bridges(bus);
+               pci_bus_assign_resources(bus);
+
+               list_for_each_entry(child, &bus->children, node)
+                       pcie_bus_configure_settings(child);
        }
 
-       return devm_request_pci_bus_resources(dev, &pcie->resources);
+       pci_bus_add_devices(bus);
+       return 0;
 }
 
 static int mvebu_pcie_probe(struct platform_device *pdev)
@@ -1268,7 +1312,7 @@ static int mvebu_pcie_probe(struct platform_device *pdev)
        bridge->align_resource = mvebu_pcie_align_resource;
        bridge->msi = pcie->msi;
 
-       return pci_host_probe(bridge);
+       return mvebu_pci_host_probe(bridge);
 }
 
 static const struct of_device_id mvebu_pcie_of_match_table[] = {

If that's what you meant, I'll go ahead and test on actual hardware and
submit as a proper patch.

Thanks!

Thomas
-- 
Thomas Petazzoni, CTO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
