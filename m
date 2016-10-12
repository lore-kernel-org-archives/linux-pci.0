Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:43598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754864AbcJLOAd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 12 Oct 2016 10:00:33 -0400
Subject: [PATCH v2 4/4] PCI: qcom: Reorder struct qcom_pcie
To: Stanimir Varbanov <svarbanov@mm-sol.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org
Date: Wed, 12 Oct 2016 09:00:27 -0500
Message-ID: <20161012140027.30144.729.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20161012135859.30144.30808.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20161012135859.30144.30808.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Reorder struct qcom_pcie to put generic fields first.  No functional change
intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pcie-qcom.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/host/pcie-qcom.c b/drivers/pci/host/pcie-qcom.c
index 6f6cbb1..ef0a84c 100644
--- a/drivers/pci/host/pcie-qcom.c
+++ b/drivers/pci/host/pcie-qcom.c
@@ -86,10 +86,10 @@ struct qcom_pcie_ops {
 };
 
 struct qcom_pcie {
-	struct pcie_port pp;
+	struct pcie_port pp;			/* pp.dbi_base is DT dbi */
+	void __iomem *parf;			/* DT parf */
+	void __iomem *elbi;			/* DT elbi */
 	union qcom_pcie_resources res;
-	void __iomem *parf;
-	void __iomem *elbi;
 	struct phy *phy;
 	struct gpio_desc *reset;
 	struct qcom_pcie_ops *ops;

