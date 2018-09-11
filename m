Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtprelay2.synopsys.com ([198.182.60.111]:50584 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726612AbeIKRFi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 Sep 2018 13:05:38 -0400
From: Joao Pinto <Joao.Pinto@synopsys.com>
To: bhelgaas@google.com, lorenzo.pieralisi@arm.com
Cc: gustavo.pimentel@synopsys.com, jingoohan1@gmail.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Joao Pinto <Joao.Pinto@synopsys.com>
Subject: [PATCH] PCI: designware: Change maintainer to Gustavo Pimentel
Date: Tue, 11 Sep 2018 13:06:30 +0100
Message-Id: <aa29f3f8dbae3a2c8523ddfd74d11505600bc47f.1536659938.git.jpinto@synopsys.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Currently I am managing the Synopsys drivers & tools team (full-time) and so I
am passing the pcie-designware maintenance to Gustavo.

Signed-off-by: Joao Pinto <jpinto@synopsys.com>
CC: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
CC: Jingoo Han <jingoohan1@gmail.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index a5b256b..e5e8984 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11153,7 +11153,7 @@ F:	drivers/pci/controller/dwc/pci-exynos.c
 
 PCI DRIVER FOR SYNOPSYS DESIGNWARE
 M:	Jingoo Han <jingoohan1@gmail.com>
-M:	Joao Pinto <Joao.Pinto@synopsys.com>
+M:	Gustavo Pimentel <gustavo.pimentel@synopsys.com>
 L:	linux-pci@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/pci/designware-pcie.txt
-- 
2.9.3
