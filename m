Return-Path: <SRS0=vhAr=RQ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9044CC43381
	for <linux-pci@archiver.kernel.org>; Wed, 13 Mar 2019 11:46:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66EA02177E
	for <linux-pci@archiver.kernel.org>; Wed, 13 Mar 2019 11:46:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725836AbfCMLqC (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 13 Mar 2019 07:46:02 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:23049 "EHLO smtp3-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725856AbfCMLqC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 13 Mar 2019 07:46:02 -0400
Received: from [192.168.108.8] (unknown [213.36.7.13])
        (Authenticated sender: marc.w.gonzalez)
        by smtp3-g21.free.fr (Postfix) with ESMTPSA id E3CFA13F8A9;
        Wed, 13 Mar 2019 12:45:38 +0100 (CET)
Subject: [PATCH v2] PCI: qcom: Use default config space read function
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
To:     Stanimir Varbanov <svarbanov@mm-sol.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        PCI <linux-pci@vger.kernel.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jeffrey Hugo <jhugo@codeaurora.org>
References: <94bb3f22-c5a7-1891-9d89-42a520e9a592@free.fr>
 <65321fe3-ca29-c454-63ae-98a46c2e5158@mm-sol.com>
 <1205cbfb-ac06-63a5-9401-75d4e68b15b5@free.fr>
 <38ad143b-3b07-4d19-8ccd-ca39fb51e53d@free.fr>
Message-ID: <7d3d788a-d6a3-a70b-adab-6c65771cacc4@free.fr>
Date:   Wed, 13 Mar 2019 12:45:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <38ad143b-3b07-4d19-8ccd-ca39fb51e53d@free.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

We don't need to fudge the device class in qcom_pcie_rd_own_conf()
because dw_pcie_setup_rc() already does the right thing:

	/* Program correct class for RC */
	dw_pcie_wr_own_conf(pp, PCI_CLASS_DEVICE, 2, PCI_CLASS_BRIDGE_PCI);

Signed-off-by: Marc Gonzalez <marc.w.gonzalez@free.fr>
---
Changes from v1 to v2: Completely drop qcom_pcie_rd_own_conf
Srinivas, could you test this patch on apq/ipq8064?
---
 drivers/pci/controller/dwc/pcie-qcom.c | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 3de5510fd3d5..d0c5c7616b3e 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -1131,25 +1131,8 @@ static int qcom_pcie_host_init(struct pcie_port *pp)
 	return ret;
 }
 
-static int qcom_pcie_rd_own_conf(struct pcie_port *pp, int where, int size,
-				 u32 *val)
-{
-	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
-
-	/* the device class is not reported correctly from the register */
-	if (where == PCI_CLASS_REVISION && size == 4) {
-		*val = readl(pci->dbi_base + PCI_CLASS_REVISION);
-		*val &= 0xff;	/* keep revision id */
-		*val |= PCI_CLASS_BRIDGE_PCI << 16;
-		return PCIBIOS_SUCCESSFUL;
-	}
-
-	return dw_pcie_read(pci->dbi_base + where, size, val);
-}
-
 static const struct dw_pcie_host_ops qcom_pcie_dw_ops = {
 	.host_init = qcom_pcie_host_init,
-	.rd_own_conf = qcom_pcie_rd_own_conf,
 };
 
 /* Qcom IP rev.: 2.1.0	Synopsys IP rev.: 4.01a */
-- 
2.17.1
