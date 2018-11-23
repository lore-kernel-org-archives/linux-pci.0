Return-Path: <SRS0=PFnE=OC=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4926C43441
	for <linux-pci@archiver.kernel.org>; Fri, 23 Nov 2018 14:18:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93D3820664
	for <linux-pci@archiver.kernel.org>; Fri, 23 Nov 2018 14:18:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93D3820664
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436694AbeKXBDD (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 23 Nov 2018 20:03:03 -0500
Received: from mail.bootlin.com ([62.4.15.54]:33991 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2439882AbeKXBDD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 23 Nov 2018 20:03:03 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 04CD9207A8; Fri, 23 Nov 2018 15:18:39 +0100 (CET)
Received: from localhost.localdomain (aaubervilliers-681-1-94-205.w90-88.abo.wanadoo.fr [90.88.35.205])
        by mail.bootlin.com (Postfix) with ESMTPSA id 90F6F20741;
        Fri, 23 Nov 2018 15:18:38 +0100 (CET)
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
Subject: [PATCH 12/12] ARM64: dts: marvell: armada-3720-espressobin: declare PCIe PHY
Date:   Fri, 23 Nov 2018 15:18:31 +0100
Message-Id: <20181123141831.8214-13-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181123141831.8214-1-miquel.raynal@bootlin.com>
References: <20181123141831.8214-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The PCIe node is wired to the second PHY of the COMPHY IP.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts b/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts
index 76a508da80b9..43e8e1edc467 100644
--- a/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts
+++ b/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts
@@ -49,6 +49,7 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pcie_pins>;
 	reset-gpios = <&gpiosb 3 GPIO_ACTIVE_HIGH>;
+	phys = <&comphy1 0>;
 };
 
 /* J6 */
-- 
2.19.1

