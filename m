Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45132C43219
	for <linux-pci@archiver.kernel.org>; Thu, 14 Apr 2022 07:40:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240509AbiDNHnH (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 14 Apr 2022 03:43:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240541AbiDNHmr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Apr 2022 03:42:47 -0400
X-Greylist: delayed 60624 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 14 Apr 2022 00:40:23 PDT
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA0B840931;
        Thu, 14 Apr 2022 00:40:22 -0700 (PDT)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPA id 538A91C0005;
        Thu, 14 Apr 2022 07:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1649922021;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Rq+ltxRhp3LsK2RX5rxuOzGtedDWpOrBc28SFp5i+i8=;
        b=arTbcMZiBsjtNMjJGQQQJpwzV9vLsoSnNN8re9d33XbbwOjOmkNoxL/QYcVkZURGAq9URo
        Ye4bZxAj9Aj/Iga+wCvi7vKED4twsZ3YtaeME3Sxk7u2fhX3n7RGxiH5fRbSA/CGipN2Lx
        cvptcxz5wRrsULGIsffsBw4yoOKXwHjKB9Q2uKV2eLQseg6EirqdibK7DvD76Ldx7deIL2
        HrqykM5KMQ31E54EmAG6vj0ob4wzZ6S0fn1qdyp6wppgSoEZRR0mOWaF1JmdeVWZ9XL0Ys
        K9y//3XUNuMwAx5mekMrmyTXy8ix9RFVUkPVXwvoLpu0lyJtd+Zv5I/ZtW/Mbw==
From:   Herve Codina <herve.codina@bootlin.com>
To:     Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
Cc:     Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sergey Shtylyov <s.shtylyov@omp.ru>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Clement Leger <clement.leger@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Herve Codina <herve.codina@bootlin.com>
Subject: [PATCH v2 0/8] RZN1 USB Host support
Date:   Thu, 14 Apr 2022 09:40:03 +0200
Message-Id: <20220414074011.500533-1-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

This series add support for the USB Host controllers available on
RZN1 (r9a06g032) SOC.

These USB Host controllers are PCI OHCI/EHCI controllers located
behind a bridge.

Regards,
Herve

Changes v2:
- Convert bindings to json-schema
- Update clocks description
- Remove unneeded '.compatible = "renesas,pci-r9a06g032"'

Herve Codina (8):
  PCI: rcar-gen2: Add support for clocks
  dt-bindings: PCI: renesas-pci-usb: Convert bindings to json-schema
  dt-bindings: PCI: renesas-pci-usb: Allow multiple clocks
  dt-bindings: PCI: renesas-pci-usb: Add device tree support for
    r9a06g032
  PCI: rcar-gen2: Add R9A06G032 support
  ARM: dts: r9a06g032: Add internal PCI bridge node
  ARM: dts: r9a06g032: Add USB PHY DT support
  ARM: dts: r9a06g032: Link the PCI USB devices to the USB PHY

 .../devicetree/bindings/pci/pci-rcar-gen2.txt |  84 -----------
 .../bindings/pci/renesas,pci-usb.yaml         | 139 ++++++++++++++++++
 arch/arm/boot/dts/r9a06g032.dtsi              |  46 ++++++
 drivers/pci/controller/pci-rcar-gen2.c        |  29 +++-
 4 files changed, 212 insertions(+), 86 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/pci/pci-rcar-gen2.txt
 create mode 100644 Documentation/devicetree/bindings/pci/renesas,pci-usb.yaml

-- 
2.35.1

