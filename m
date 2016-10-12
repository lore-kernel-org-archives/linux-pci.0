Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:43376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755007AbcJLOAH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 12 Oct 2016 10:00:07 -0400
Subject: [PATCH v2 1/4] PCI: qcom: Remove unused platform data
To: Stanimir Varbanov <svarbanov@mm-sol.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org
Date: Wed, 12 Oct 2016 09:00:02 -0500
Message-ID: <20161012140002.30144.31966.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20161012135859.30144.30808.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20161012135859.30144.30808.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The qcom driver never uses the platform drvdata pointer, so don't bother
setting it.  No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pcie-qcom.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/pci/host/pcie-qcom.c b/drivers/pci/host/pcie-qcom.c
index 5ec2d44..51bb0a9 100644
--- a/drivers/pci/host/pcie-qcom.c
+++ b/drivers/pci/host/pcie-qcom.c
@@ -569,8 +569,6 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	platform_set_drvdata(pdev, pcie);
-
 	return 0;
 }
 

