Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:55914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S964851AbcJGQiU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 7 Oct 2016 12:38:20 -0400
Subject: [PATCH 11/11] PCI: hisi: Remove unused platform data
To: Zhou Wang <wangzhou1@hisilicon.com>,
        Gabriele Paoloni <gabriele.paoloni@huawei.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Date: Fri, 07 Oct 2016 11:38:16 -0500
Message-ID: <20161007163816.25540.17480.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20161007163654.25540.29741.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20161007163654.25540.29741.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The hisi driver never uses the platform drvdata pointer, so don't bother
setting it.  No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pcie-hisi.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/pci/host/pcie-hisi.c b/drivers/pci/host/pcie-hisi.c
index 3fd6757..eef91a4 100644
--- a/drivers/pci/host/pcie-hisi.c
+++ b/drivers/pci/host/pcie-hisi.c
@@ -189,8 +189,6 @@ static int hisi_pcie_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	platform_set_drvdata(pdev, hisi);
-
 	dev_warn(dev, "only 32-bit config accesses supported; smaller writes may corrupt adjacent RW1C fields\n");
 
 	return 0;

