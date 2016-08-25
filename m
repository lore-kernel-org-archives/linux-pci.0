Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.131]:42289 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755428AbcHYIJ7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 25 Aug 2016 04:09:59 -0400
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc: linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, Brian Norris <briannorris@chromium.org>,
        Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH 2/2] MAINTAINERS: Add rockchip pcie driver entry
Date: Thu, 25 Aug 2016 16:05:07 +0800
Message-Id: <1472112307-31597-1-git-send-email-shawn.lin@rock-chips.com>
In-Reply-To: <1472112214-31550-1-git-send-email-shawn.lin@rock-chips.com>
References: <1472112214-31550-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The pcie driver of Rockchip has no entry in the MAINTAINERS
file, so add one.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 20bb1d0..c0e623f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9083,6 +9083,15 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/pci/hisilicon-pcie.txt
 F:	drivers/pci/host/pcie-hisi.c
 
+PCIE DRIVER FOR ROCKCHIP
+M:	Shawn Lin <shawn.lin@rock-chips.com>
+M:	Wenrui Li <wenrui.li@rock-chips.com>
+L:	linux-pci@vger.kernel.org
+L:	linux-rockchip@lists.infradead.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/pci/rockchip-pcie.txt
+F:	drivers/pci/host/pcie-rockchip.c
+
 PCIE DRIVER FOR QUALCOMM MSM
 M:     Stanimir Varbanov <svarbanov@mm-sol.com>
 L:     linux-pci@vger.kernel.org
-- 
2.3.7


