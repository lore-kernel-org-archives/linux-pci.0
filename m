Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f170.google.com ([209.85.223.170]:52587 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756416AbaGOW4y (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 15 Jul 2014 18:56:54 -0400
Received: by mail-ie0-f170.google.com with SMTP id rl12so84685iec.15
        for <linux-pci@vger.kernel.org>; Tue, 15 Jul 2014 15:56:54 -0700 (PDT)
Subject: [PATCH 2/2] PCI: rcar: Fix GPL v2 license string typo
To: linux-pci@vger.kernel.org, Simon Horman <horms@verge.net.au>,
	Will Deacon <will.deacon@arm.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: Thierry Reding <treding@nvidia.com>,
	linux-arm-kernel@lists.infradead.org, linux-sh@vger.kernel.org
Date: Tue, 15 Jul 2014 16:56:52 -0600
Message-ID: <20140715225652.22578.86359.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20140715225503.22578.32174.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20140715225503.22578.32174.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The proper MODULE_LICENSE() string for the GPL v2 is "GPL v2", not "GPLv2".

Based-on-work-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pcie-rcar.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/host/pcie-rcar.c b/drivers/pci/host/pcie-rcar.c
index f7d3de32c9a0..a393cc60b5a3 100644
--- a/drivers/pci/host/pcie-rcar.c
+++ b/drivers/pci/host/pcie-rcar.c
@@ -1003,4 +1003,4 @@ module_platform_driver(rcar_pcie_driver);
 
 MODULE_AUTHOR("Phil Edworthy <phil.edworthy@renesas.com>");
 MODULE_DESCRIPTION("Renesas R-Car PCIe driver");
-MODULE_LICENSE("GPLv2");
+MODULE_LICENSE("GPL v2");

