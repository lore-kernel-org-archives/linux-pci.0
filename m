Return-Path: <SRS0=ZQeV=OV=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BF66C04EB8
	for <linux-pci@archiver.kernel.org>; Wed, 12 Dec 2018 10:23:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E119C2086D
	for <linux-pci@archiver.kernel.org>; Wed, 12 Dec 2018 10:23:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E119C2086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbeLLKV4 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 12 Dec 2018 05:21:56 -0500
Received: from mail.bootlin.com ([62.4.15.54]:57438 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726727AbeLLKV4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 12 Dec 2018 05:21:56 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 921D720DBC; Wed, 12 Dec 2018 11:21:53 +0100 (CET)
Received: from localhost.localdomain (aaubervilliers-681-1-89-7.w90-88.abo.wanadoo.fr [90.88.30.7])
        by mail.bootlin.com (Postfix) with ESMTPSA id 2517620733;
        Wed, 12 Dec 2018 11:21:43 +0100 (CET)
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
Subject: [PATCH v2 00/12] Bring suspend to RAM support to PCIe Aardvark driver
Date:   Wed, 12 Dec 2018 11:21:30 +0100
Message-Id: <20181212102142.16053-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello,

As part of an effort to bring suspend to RAM support to Armada 3700
SoCs (main target: ESPRESSObin), this series handles the work around
the PCIe IP.

First, more configuration is done in the 'setup' helper as inspired
from the U-Boot driver. This is needed to entirely initialize the IP
during future resume operation (patch 1).

Then, reset GPIO, PHY and clock support are introduced (patch 2-4). As
current device trees do not provide the corresponding properties, not
finding one of these properties is not an error and just produces a
warning. However, if the property is present, an error during PHY
initialization will fail the probe of the driver.

Note: To be sure the clock will be resumed before this driver, a first
series adding links between clocks and consumers has been submitted,
see [1]. Anyway, having the clock series applied first is not needed.

Patch 5 adds suspend/resume hooks, re-using all the above.

Finally, bindings and device trees are updated to reflect the hardware
(patch 6-12). While the clock depends on the SoC, the reset GPIO and
the PHY depends on the board so the clock is added in the
armada-37xx.dtsi file while the two other properties are added in
armada-3720-espressobin.dts.

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2018-November/614527.html

Thanks,
Miquèl

Changes since v1:
=================
* Change the capitalization in commit titles to follow the PCI
  subsystem rules.
* Added Suggested-by tag to the patch adding PHY support and to the
  patch adding the PHY property in the DT.
* Added Rob's Reviewed-by tags on bindings.
* I am following the discussion about calling functions that might
  sleep in a NOIRQ context. As there is no real problem yet (as per my
  understanding), I did not change anything on this regard.


Miquel Raynal (12):
  PCI: aardvark: Configure more registers in the configuration helper
  PCI: aardvark: Add reset GPIO support
  PCI: aardvark: Add PHY support
  PCI: aardvark: Add clock support
  PCI: aardvark: Add suspend to RAM support
  dt-bindings: PCI: aardvark: Describe the reset-gpios property
  dt-bindings: PCI: aardvark: Describe the clocks property
  dt-bindings: PCI: aardvark: Describe the PHY property
  ARM64: dts: marvell: armada-37xx: declare PCIe reset pin
  ARM64: dts: marvell: armada-3720-espressobin: declare PCIe reset GPIO
  ARM64: dts: marvell: armada-37xx: declare PCIe clock
  ARM64: dts: marvell: armada-3720-espressobin: declare PCIe PHY

 .../devicetree/bindings/pci/aardvark-pci.txt  |   9 +
 .../dts/marvell/armada-3720-espressobin.dts   |   4 +
 arch/arm64/boot/dts/marvell/armada-37xx.dtsi  |   5 +
 drivers/pci/controller/pci-aardvark.c         | 214 ++++++++++++++++++
 4 files changed, 232 insertions(+)

-- 
2.19.1

