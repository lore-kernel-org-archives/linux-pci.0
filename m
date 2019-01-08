Return-Path: <SRS0=3dpc=PQ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78F8AC43387
	for <linux-pci@archiver.kernel.org>; Tue,  8 Jan 2019 16:25:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 530E72087F
	for <linux-pci@archiver.kernel.org>; Tue,  8 Jan 2019 16:25:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729535AbfAHQZi (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 8 Jan 2019 11:25:38 -0500
Received: from mail.bootlin.com ([62.4.15.54]:44894 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729289AbfAHQYu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 8 Jan 2019 11:24:50 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id E64BC20A1D; Tue,  8 Jan 2019 17:24:47 +0100 (CET)
Received: from localhost.localdomain (aaubervilliers-681-1-45-241.w90-88.abo.wanadoo.fr [90.88.163.241])
        by mail.bootlin.com (Postfix) with ESMTPSA id 86DFD207A3;
        Tue,  8 Jan 2019 17:24:47 +0100 (CET)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Gregory Clement <gregory.clement@bootlin.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Nadav Haklai <nadavh@marvell.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v3 08/15] dt-bindings: PCI: aardvark: Describe the clocks property
Date:   Tue,  8 Jan 2019 17:24:33 +0100
Message-Id: <20190108162441.5278-9-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190108162441.5278-1-miquel.raynal@bootlin.com>
References: <20190108162441.5278-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Describe the missing gated clock feeding the PCIe IP.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/pci/aardvark-pci.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/aardvark-pci.txt b/Documentation/devicetree/bindings/pci/aardvark-pci.txt
index 310ef7145c47..9d19ebfea189 100644
--- a/Documentation/devicetree/bindings/pci/aardvark-pci.txt
+++ b/Documentation/devicetree/bindings/pci/aardvark-pci.txt
@@ -12,6 +12,7 @@ contain the following properties:
  - #size-cells: set to <2>
  - device_type: set to "pci"
  - ranges: ranges for the PCI memory and I/O regions
+ - clocks: the clock feeding the IP
  - #interrupt-cells: set to <1>
  - msi-controller: indicates that the PCIe controller can itself
    handle MSI interrupts
@@ -37,6 +38,7 @@ Example:
 		#address-cells = <3>;
 		#size-cells = <2>;
 		bus-range = <0x00 0xff>;
+		clocks = <&sb_periph_clk 13>;
 		interrupts = <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>;
 		#interrupt-cells = <1>;
 		msi-controller;
-- 
2.19.1

