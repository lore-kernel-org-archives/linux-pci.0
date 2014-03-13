Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pd0-f173.google.com ([209.85.192.173]:57579 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754281AbaCMRkQ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 13 Mar 2014 13:40:16 -0400
Received: by mail-pd0-f173.google.com with SMTP id z10so1382930pdj.4
        for <linux-pci@vger.kernel.org>; Thu, 13 Mar 2014 10:40:15 -0700 (PDT)
From: Tim Harvey <tharvey@gateworks.com>
To: linux-pci@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Subject: [PATCH 0/2] ARM: IMX: fix ability to use pcie interrupt-map
Date: Thu, 13 Mar 2014 10:40:03 -0700
Message-Id: <1394732405-2260-1-git-send-email-tharvey@gateworks.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The #address-cells of the arm-cortext-a9 gic in the imx pcie host controller
node is invalid which breaks the ability to user interrupt-map for legacy
pci interrupts.

Tim Harvey (2):
  ARM: DT: fix gic interrupt controller documentation
  ARM: dts: imx: fix invalid #address-cells value

 Documentation/devicetree/bindings/arm/gic.txt | 2 +-
 arch/arm/boot/dts/imx6qdl.dtsi                | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
1.8.3.2

