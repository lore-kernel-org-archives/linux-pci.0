Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:58238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965115AbcJGQnS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 7 Oct 2016 12:43:18 -0400
Subject: [PATCH 3/5] PCI: qcom: Remove redundant struct qcom_pcie.dev
To: Stanimir Varbanov <svarbanov@mm-sol.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org
Date: Fri, 07 Oct 2016 11:43:09 -0500
Message-ID: <20161007164309.26464.85324.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20161007164251.26464.42894.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20161007164251.26464.42894.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Remove the struct qcom_pcie.dev member, which is a duplicate of the generic
pp.dev member.  No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pcie-qcom.c |   10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/host/pcie-qcom.c b/drivers/pci/host/pcie-qcom.c
index e425fcf..915e70a 100644
--- a/drivers/pci/host/pcie-qcom.c
+++ b/drivers/pci/host/pcie-qcom.c
@@ -87,7 +87,6 @@ struct qcom_pcie_ops {
 
 struct qcom_pcie {
 	struct pcie_port pp;
-	struct device *dev;
 	union qcom_pcie_resources res;
 	void __iomem *parf;
 	void __iomem *elbi;
@@ -135,7 +134,7 @@ static int qcom_pcie_establish_link(struct qcom_pcie *qcom)
 static int qcom_pcie_get_resources_v0(struct qcom_pcie *qcom)
 {
 	struct qcom_pcie_resources_v0 *res = &qcom->res.v0;
-	struct device *dev = qcom->dev;
+	struct device *dev = qcom->pp.dev;
 
 	res->vdda = devm_regulator_get(dev, "vdda");
 	if (IS_ERR(res->vdda))
@@ -187,7 +186,7 @@ static int qcom_pcie_get_resources_v0(struct qcom_pcie *qcom)
 static int qcom_pcie_get_resources_v1(struct qcom_pcie *qcom)
 {
 	struct qcom_pcie_resources_v1 *res = &qcom->res.v1;
-	struct device *dev = qcom->dev;
+	struct device *dev = qcom->pp.dev;
 
 	res->vdda = devm_regulator_get(dev, "vdda");
 	if (IS_ERR(res->vdda))
@@ -236,7 +235,7 @@ static void qcom_pcie_deinit_v0(struct qcom_pcie *qcom)
 static int qcom_pcie_init_v0(struct qcom_pcie *qcom)
 {
 	struct qcom_pcie_resources_v0 *res = &qcom->res.v0;
-	struct device *dev = qcom->dev;
+	struct device *dev = qcom->pp.dev;
 	u32 val;
 	int ret;
 
@@ -358,7 +357,7 @@ static void qcom_pcie_deinit_v1(struct qcom_pcie *qcom)
 static int qcom_pcie_init_v1(struct qcom_pcie *qcom)
 {
 	struct qcom_pcie_resources_v1 *res = &qcom->res.v1;
-	struct device *dev = qcom->dev;
+	struct device *dev = qcom->pp.dev;
 	int ret;
 
 	ret = reset_control_deassert(res->core);
@@ -511,7 +510,6 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 	pp = &qcom->pp;
 
 	qcom->ops = (struct qcom_pcie_ops *)of_device_get_match_data(dev);
-	qcom->dev = dev;
 
 	qcom->reset = devm_gpiod_get_optional(dev, "perst", GPIOD_OUT_LOW);
 	if (IS_ERR(qcom->reset))

