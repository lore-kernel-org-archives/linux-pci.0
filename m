Return-Path: <SRS0=eZdz=3D=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D6B0C33CA9
	for <linux-pci@archiver.kernel.org>; Tue, 14 Jan 2020 07:30:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EDA12187F
	for <linux-pci@archiver.kernel.org>; Tue, 14 Jan 2020 07:30:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728933AbgANHaD (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 14 Jan 2020 02:30:03 -0500
Received: from lucky1.263xmail.com ([211.157.147.135]:39328 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728896AbgANHaD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Jan 2020 02:30:03 -0500
X-Greylist: delayed 373 seconds by postgrey-1.27 at vger.kernel.org; Tue, 14 Jan 2020 02:30:02 EST
Received: from localhost (unknown [192.168.167.13])
        by lucky1.263xmail.com (Postfix) with ESMTP id 9B9534FF83;
        Tue, 14 Jan 2020 15:25:55 +0800 (CST)
X-MAIL-GRAY: 1
X-MAIL-DELIVERY: 0
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P19895T140279339108096S1578986754975103_;
        Tue, 14 Jan 2020 15:25:55 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <703626875cd62b4c13c2bb6d05db01c8>
X-RL-SENDER: shawn.lin@rock-chips.com
X-SENDER: lintao@rock-chips.com
X-LOGIN-NAME: shawn.lin@rock-chips.com
X-FST-TO: heiko@sntech.de
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
From:   Shawn Lin <shawn.lin@rock-chips.com>
To:     Heiko Stuebner <heiko@sntech.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Jingoo Han <jingoohan1@gmail.com>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, William Wu <william.wu@rock-chips.com>,
        Simon Xue <xxm@rock-chips.com>,
        linux-rockchip@lists.infradead.org,
        Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH 6/6] MAINTAINERS: Update PCIe drivers for Rockchip
Date:   Tue, 14 Jan 2020 15:25:15 +0800
Message-Id: <1578986715-72122-1-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1578986580-71974-1-git-send-email-shawn.lin@rock-chips.com>
References: <1578986580-71974-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 MAINTAINERS | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4b11d43..f95a85d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12956,11 +12956,13 @@ F:	drivers/pci/controller/dwc/*qcom*
 
 PCIE DRIVER FOR ROCKCHIP
 M:	Shawn Lin <shawn.lin@rock-chips.com>
+M:	Simon Xue <xxm@rock-chips.com>
 L:	linux-pci@vger.kernel.org
 L:	linux-rockchip@lists.infradead.org
 S:	Maintained
-F:	Documentation/devicetree/bindings/pci/rockchip-pcie*
+F:	Documentation/devicetree/bindings/pci/*rockchip*
 F:	drivers/pci/controller/pcie-rockchip*
+F:	drivers/pci/controller/dwc/*rockchip*
 
 PCI DRIVER FOR V3 SEMICONDUCTOR V360EPC
 M:	Linus Walleij <linus.walleij@linaro.org>
-- 
1.9.1



