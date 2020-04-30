Return-Path: <SRS0=q/mj=6O=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C26FC8300A
	for <linux-pci@archiver.kernel.org>; Thu, 30 Apr 2020 08:07:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C5102186A
	for <linux-pci@archiver.kernel.org>; Thu, 30 Apr 2020 08:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588234021;
	bh=kuyAXwOATAjORZINANy8r5DfKQd5TrKERHhwlhi4j8U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Bjj4QEoczXu8N9pMeG26qwIm8mYakuuXqZoYDs7b9+rVJlDEmwg1e+Xzkxi9oVQBy
	 ZUuGW4ZPpel7ApuFTGIJzm+9SazMJx1sLiwPZTOEB6xvw+H5tWxNIEOaHUe/3jK932
	 XcDYdBUOZK0LVOLF0KN9dMSfMyTxVFeNSH3Ksdeg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727062AbgD3IG4 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 30 Apr 2020 04:06:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:51494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727047AbgD3IGy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 30 Apr 2020 04:06:54 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 34D4321D91;
        Thu, 30 Apr 2020 08:06:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588234014;
        bh=kuyAXwOATAjORZINANy8r5DfKQd5TrKERHhwlhi4j8U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QzprLcgqDEonxaFzNfeojY+EjQDpkCWBj/1wxHIYvSOMaECE5CZRQH7oL6s6aJbSJ
         iEuNcNWSC+6q+z2UuQxnrNRupWKQBPWG2d15oax68vthdVOIS38AyRVelouP/a4ekg
         YsYTXeLW3Q1RrACGnl7BY6O9bNvRXsDyKukmDDUM=
Received: by pali.im (Postfix)
        id 60A31A19; Thu, 30 Apr 2020 10:06:52 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Remi Pommarel <repk@triplefau.lt>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>,
        Tomasz Maciej Nowak <tmn505@gmail.com>,
        Xogium <contact@xogium.me>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: [PATCH v4 12/12] arm64: dts: marvell: armada-37xx: Move PCIe max-link-speed property
Date:   Thu, 30 Apr 2020 10:06:25 +0200
Message-Id: <20200430080625.26070-13-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200430080625.26070-1-pali@kernel.org>
References: <20200430080625.26070-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Move the max-link-speed property of the PCIe node from board specific
device tree files to the generic armada-37xx.dtsi.

Armada 37xx supports only PCIe gen2 speed so max-link-speed property
should be in the genetic armada-37xx.dtsi file.

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts | 1 -
 arch/arm64/boot/dts/marvell/armada-37xx.dtsi           | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts b/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
index 15c1cf5c5b69..4cc735899c5d 100644
--- a/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
+++ b/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
@@ -132,7 +132,6 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pcie_reset_pins &pcie_clkreq_pins>;
 	status = "okay";
-	max-link-speed = <2>;
 	reset-gpios = <&gpiosb 3 GPIO_ACTIVE_LOW>;
 
 	/* enabled by U-Boot if PCIe module is present */
diff --git a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
index 5aaad64a793d..2bbc69b4dc99 100644
--- a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
@@ -493,6 +493,7 @@
 					<0 0 0 2 &pcie_intc 1>,
 					<0 0 0 3 &pcie_intc 2>,
 					<0 0 0 4 &pcie_intc 3>;
+			max-link-speed = <2>;
 			phys = <&comphy1 0>;
 			pcie_intc: interrupt-controller {
 				interrupt-controller;
-- 
2.20.1

