Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:38178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753904AbcJLNga (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 12 Oct 2016 09:36:30 -0400
Subject: [PATCH v2 2/7] PCI: artpec6: Remove unused platform data
To: Jesper Nilsson <jesper.nilsson@axis.com>,
        Niklas Cassel <niklas.cassel@axis.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-arm-kernel@axis.com
Date: Wed, 12 Oct 2016 08:29:12 -0500
Message-ID: <20161012132912.27228.30474.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20161012132616.27228.4618.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20161012132616.27228.4618.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The artpec6 driver never uses the platform drvdata pointer, so don't
bother setting it.  No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Acked-by: Jesper Nilsson <jesper.nilsson@axis.com>
---
 drivers/pci/host/pcie-artpec6.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/host/pcie-artpec6.c b/drivers/pci/host/pcie-artpec6.c
index ef2f04f..9423bf0 100644
--- a/drivers/pci/host/pcie-artpec6.c
+++ b/drivers/pci/host/pcie-artpec6.c
@@ -262,7 +262,6 @@ static int artpec6_pcie_probe(struct platform_device *pdev)
 	if (ret < 0)
 		return ret;
 
-	platform_set_drvdata(pdev, artpec6_pcie);
 	return 0;
 }
 

