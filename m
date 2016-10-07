Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:45520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932268AbcJGQVg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 7 Oct 2016 12:21:36 -0400
Subject: [PATCH 5/5] PCI: aardvark: Remove unused platform data
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Date: Fri, 07 Oct 2016 11:21:31 -0500
Message-ID: <20161007162131.22668.30227.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20161007162053.22668.91420.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20161007162053.22668.91420.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The aardvark driver never uses the platform drvdata pointer, so don't
bother setting it.  No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pci-aardvark.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/host/pci-aardvark.c b/drivers/pci/host/pci-aardvark.c
index b255a08..5b12199 100644
--- a/drivers/pci/host/pci-aardvark.c
+++ b/drivers/pci/host/pci-aardvark.c
@@ -922,7 +922,6 @@ static int advk_pcie_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	advk->pdev = pdev;
-	platform_set_drvdata(pdev, advk);
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	advk->base = devm_ioremap_resource(dev, res);

