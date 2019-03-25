Return-Path: <SRS0=Cb4Y=R4=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8E24C43381
	for <linux-pci@archiver.kernel.org>; Mon, 25 Mar 2019 15:43:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7DEF2195D
	for <linux-pci@archiver.kernel.org>; Mon, 25 Mar 2019 15:43:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729514AbfCYPm7 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 25 Mar 2019 11:42:59 -0400
Received: from ns.iliad.fr ([212.27.33.1]:34750 "EHLO ns.iliad.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726203AbfCYPm6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 25 Mar 2019 11:42:58 -0400
Received: from ns.iliad.fr (localhost [127.0.0.1])
        by ns.iliad.fr (Postfix) with ESMTP id C4E82209B2;
        Mon, 25 Mar 2019 16:42:55 +0100 (CET)
Received: from [192.168.108.8] (freebox.vlq16.iliad.fr [213.36.7.13])
        by ns.iliad.fr (Postfix) with ESMTP id A891B209A8;
        Mon, 25 Mar 2019 16:42:55 +0100 (CET)
Subject: [PATCH v5] PCI: qcom: Use default config space read function
To:     Stanimir Varbanov <svarbanov@mm-sol.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Andy Gross <andy.gross@linaro.org>,
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
 <7d3d788a-d6a3-a70b-adab-6c65771cacc4@free.fr>
 <3c76613e-e60d-94b8-dd6f-b8f4e1928263@linaro.org>
 <2f901228-52db-7661-8257-ca8fd2ff2a46@free.fr>
 <29664b43-535c-c4b1-a93d-18f49687f929@linaro.org>
 <b0e0dc68-4be9-1b0f-7528-fb7d143fea2b@free.fr>
 <9c5a7620-e9ed-82d6-0708-34fe33e39030@linaro.org>
 <29d33e81-fe8d-7fd9-843d-cc53ea6c9586@free.fr>
 <a53911a5-198a-5073-59cf-a61ba067bfd8@free.fr>
 <eb1d808e-00aa-5411-be03-2a1a8c8d655a@mm-sol.com>
 <8cd24928-54d0-c320-b53f-08332d434477@free.fr>
 <f142da4d-303a-89f3-ba5a-b6800d613e15@free.fr>
 <df27f753-9464-02c0-b621-d5d7b54a3403@mm-sol.com>
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
Message-ID: <66ae38dc-1c0c-5a76-be23-fb87db90b327@free.fr>
Date:   Mon, 25 Mar 2019 16:42:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <df27f753-9464-02c0-b621-d5d7b54a3403@mm-sol.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: ClamAV using ClamSMTP ; ns.iliad.fr ; Mon Mar 25 16:42:55 2019 +0100 (CET)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Move the device class fudge to a proper fixup function, and remove
qcom_pcie_rd_own_conf() which has become useless.

NB: dw_pcie_setup_rc() already did the right thing, but it's broken
on older qcom chips, such as 8064.

Signed-off-by: Marc Gonzalez <marc.w.gonzalez@free.fr>
---
Changes from v4 to v5: Apply fixup to all qcom chips, the same way it was before
(thus the code remains functionally equivalent)
Drop Srinivas' Tested-by tag because of the change
---
 drivers/pci/controller/dwc/pcie-qcom.c | 23 ++++++-----------------
 1 file changed, 6 insertions(+), 17 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index a7f703556790..0ed235d560e3 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -1129,25 +1129,8 @@ static int qcom_pcie_host_init(struct pcie_port *pp)
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
@@ -1309,6 +1292,12 @@ static const struct of_device_id qcom_pcie_match[] = {
 	{ }
 };
 
+static void qcom_fixup_class(struct pci_dev *dev)
+{
+	dev->class = PCI_CLASS_BRIDGE_PCI << 8;
+}
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_QCOM, PCI_ANY_ID, qcom_fixup_class);
+
 static struct platform_driver qcom_pcie_driver = {
 	.probe = qcom_pcie_probe,
 	.driver = {
-- 
2.17.1
