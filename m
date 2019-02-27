Return-Path: <SRS0=6dzI=RC=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AD2EC43381
	for <linux-pci@archiver.kernel.org>; Wed, 27 Feb 2019 10:01:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D6CC205F4
	for <linux-pci@archiver.kernel.org>; Wed, 27 Feb 2019 10:01:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728462AbfB0KBL (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 27 Feb 2019 05:01:11 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:57779 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728036AbfB0KBL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 27 Feb 2019 05:01:11 -0500
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <l.stach@pengutronix.de>)
        id 1gyw1V-0002pC-Q6; Wed, 27 Feb 2019 11:01:09 +0100
Message-ID: <1551261667.2305.6.camel@pengutronix.de>
Subject: Re: IMX6 dwc PCI regression through switch - unable to request
 (legacy) interrupt (pci=nomsi)
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Tim Harvey <tharvey@gateworks.com>, linux-pci@vger.kernel.org,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Niklas Cassel <niklas.cassel@axis.com>
Date:   Wed, 27 Feb 2019 11:01:07 +0100
In-Reply-To: <CAJ+vNU2XcJ+btfM64p4W7VrBvB6W89MZ=+8G5NYWP16MRrY56A@mail.gmail.com>
References: <CAJ+vNU2XcJ+btfM64p4W7VrBvB6W89MZ=+8G5NYWP16MRrY56A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::2a
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pci@vger.kernel.org
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Tim,

Am Dienstag, den 26.02.2019, 13:13 -0800 schrieb Tim Harvey:
> Greetings,
> 
> I've got a miniPCIe card with a TW6869 8x frame grabber that stopped
> working on an IMX6 based board with a PLX switch with Linux 4.17 as
> the driver errors out with 'tw686x 0000:07:00.0: unable to request
> interrupt' (request_irq() fails). I've found this only happens on
> boards that have a switch. Note I'm booting with pci=nomsi as well as
> the IMX6 has a limitation where legacy IRQ's wont fire if MSI irq's
> are enabled. Strangely I don't see this issue with other cards such
> as
> the ath9k with msi disabled.
> 
> I bisected the issue to 7c5925afbc58c6d6b384e1dc051bb992969bf787
> 'PCI:
> dwc: Move MSI IRQs allocation to IRQ domains hierarchical API' which
> due to continued changes in drivers/pci/dwc can no longer be
> reverted.
> 
> Any ideas what happened here? IMX6 PCIe through a bridge always seems
> not so well tested and very fragile over the past couple of years.

Thanks for the report. Both the DWC PCIe core in general and the i.MX6
integration have some rough edges, which makes things fall from time to
time. Having a PCIe bridge in the mix does extend the test space quite
a bit.

Does the following patch help? I didn't test it yet, but it's based on
my assumption of what is going wrong with the referenced commit.

Regards,
Lucas

----------------------------->8--------------------------------------

From 40b4fc03878a935fa81af226a8e759d4c72a3603 Mon Sep 17 00:00:00 2001
From: Lucas Stach <l.stach@pengutronix.de>
Date: Wed, 27 Feb 2019 10:50:20 +0100
Subject: [PATCH] PCI: dwc: skip MSI init if MSIs have been explicitly disabled

Since 7c5925afbc58 (PCI: dwc: Move MSI IRQs allocation to IRQ domains
hierarchical API) the MSi init claims one of the controller IRQs as a
chained IRQ line for the MSI controller. On some designs, like the i.MX6,
this line is shared with a PCIe legacy IRQ. When the line is claimed for
the MSI domain, any device trying to use this legacy IRQs will fail to
request this IRQ line.

As MSI and legacy IRQs are already mutually exclusive on the DWC core,
as the core won't forward any legacy IRQs once any MSI has been enabled,
users wishing to use legacy IRQs already need to explictly disable MSI
support (usually via the pci=nomsi kernel commandline option). To avoid
any issues with MSI conflicting with legacy IRQs, just skip all of the
DWC MSI initalization, inclusing the IRQ line claim, when MSI is disabled.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 29a05759a294..f4a8494f616b 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -433,7 +433,7 @@ int dw_pcie_host_init(struct pcie_port *pp)
 	if (ret)
 		pci->num_viewport = 2;
 
-	if (IS_ENABLED(CONFIG_PCI_MSI)) {
+	if (IS_ENABLED(CONFIG_PCI_MSI) && pci_msi_enabled()) {
 		/*
 		 * If a specific SoC driver needs to change the
 		 * default number of vectors, it needs to implement
-- 
2.20.1
