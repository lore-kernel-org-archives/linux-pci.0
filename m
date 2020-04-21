Return-Path: <SRS0=8E5B=6F=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F5BDC54FD0
	for <linux-pci@archiver.kernel.org>; Tue, 21 Apr 2020 11:17:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F22E22078C
	for <linux-pci@archiver.kernel.org>; Tue, 21 Apr 2020 11:17:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nic.cz header.i=@nic.cz header.b="qJ+XDDh3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728663AbgDULRN (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 21 Apr 2020 07:17:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728675AbgDULRH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 Apr 2020 07:17:07 -0400
Received: from mail.nic.cz (mail.nic.cz [IPv6:2001:1488:800:400::400])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 204A0C061BD3;
        Tue, 21 Apr 2020 04:17:07 -0700 (PDT)
Received: from dellmb.labs.office.nic.cz (unknown [IPv6:2001:1488:fffe:6:cac7:3539:7f1f:463])
        by mail.nic.cz (Postfix) with ESMTP id 3CCD3141357;
        Tue, 21 Apr 2020 13:17:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nic.cz; s=default;
        t=1587467824; bh=z86Pby6WpVm7JlTRtYanuiRiblbMvn2ciL8Fbb89Hw4=;
        h=From:To:Date;
        b=qJ+XDDh3ow/EhiHZY1chPhaVwxeYlUeL/E21IH2txuIGX7TAoDBFDCeYggqEvWB+U
         TdTjFeCa6t9tpI5VZbi+vJApzoReFydAWlR+BlEzTUahqq930Nv7m09yTTk9Xkd9Nk
         w1qlBfcI6mp2V26Ag6/6420CApcJOw0vacI9STNU=
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>
To:     linux-pci@vger.kernel.org
Cc:     Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Remi Pommarel <repk@triplefau.lt>,
        Tomasz Maciej Nowak <tmn505@gmail.com>,
        Xogium <contact@xogium.me>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH v2 9/9] arm64: dts: marvell: armada-37xx: move PCIe comphy handle property
Date:   Tue, 21 Apr 2020 13:17:01 +0200
Message-Id: <20200421111701.17088-10-marek.behun@nic.cz>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200421111701.17088-1-marek.behun@nic.cz>
References: <20200421111701.17088-1-marek.behun@nic.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: /
X-Virus-Scanned: clamav-milter 0.101.4 at mail
X-Virus-Status: Clean
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Move the comphy handle property of the PCIe node from board specific
device tree files (EspressoBin and Turris Mox) to the generic
armada-37xx.dtsi.

This is correct since this is the only possible PCIe PHY configuration
on Armada 37xx, so when PCIe is enabled on any board, this handle is
correct.

Signed-off-by: Marek Behún <marek.behun@nic.cz>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: devicetree@vger.kernel.org
---
 arch/arm64/boot/dts/marvell/armada-3720-espressobin.dtsi | 1 -
 arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts   | 1 -
 arch/arm64/boot/dts/marvell/armada-37xx.dtsi             | 1 +
 3 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dtsi b/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dtsi
index c92ad664cb0e..b97218c72727 100644
--- a/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dtsi
@@ -44,7 +44,6 @@ vcc_sd_reg1: regulator {
 /* J9 */
 &pcie0 {
 	status = "okay";
-	phys = <&comphy1 0>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pcie_reset_pins &pcie_clkreq_pins>;
 	reset-gpios = <&gpiosb 3 GPIO_ACTIVE_LOW>;
diff --git a/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts b/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
index e496bd9d4737..15c1cf5c5b69 100644
--- a/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
+++ b/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
@@ -134,7 +134,6 @@ &pcie0 {
 	status = "okay";
 	max-link-speed = <2>;
 	reset-gpios = <&gpiosb 3 GPIO_ACTIVE_LOW>;
-	phys = <&comphy1 0>;
 
 	/* enabled by U-Boot if PCIe module is present */
 	status = "disabled";
diff --git a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
index 7909c146eabf..5aaad64a793d 100644
--- a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
@@ -493,6 +493,7 @@ pcie0: pcie@d0070000 {
 					<0 0 0 2 &pcie_intc 1>,
 					<0 0 0 3 &pcie_intc 2>,
 					<0 0 0 4 &pcie_intc 3>;
+			phys = <&comphy1 0>;
 			pcie_intc: interrupt-controller {
 				interrupt-controller;
 				#interrupt-cells = <1>;
-- 
2.24.1

