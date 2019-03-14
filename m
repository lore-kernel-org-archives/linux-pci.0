Return-Path: <SRS0=NdPK=RR=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25919C43381
	for <linux-pci@archiver.kernel.org>; Thu, 14 Mar 2019 13:24:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F34252184E
	for <linux-pci@archiver.kernel.org>; Thu, 14 Mar 2019 13:24:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727268AbfCNNYa (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 14 Mar 2019 09:24:30 -0400
Received: from ns.iliad.fr ([212.27.33.1]:60804 "EHLO ns.iliad.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726916AbfCNNYa (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 14 Mar 2019 09:24:30 -0400
X-Greylist: delayed 343 seconds by postgrey-1.27 at vger.kernel.org; Thu, 14 Mar 2019 09:24:28 EDT
Received: from ns.iliad.fr (localhost [127.0.0.1])
        by ns.iliad.fr (Postfix) with ESMTP id 6E042206C6;
        Thu, 14 Mar 2019 14:18:44 +0100 (CET)
Received: from [192.168.108.8] (freebox.vlq16.iliad.fr [213.36.7.13])
        by ns.iliad.fr (Postfix) with ESMTP id 4B030206AA;
        Thu, 14 Mar 2019 14:18:44 +0100 (CET)
Subject: Re: [PATCH v2] PCI: qcom: Use default config space read function
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
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
 <7d3d788a-d6a3-a70b-adab-6c65771cacc4@free.fr>
 <3c76613e-e60d-94b8-dd6f-b8f4e1928263@linaro.org>
 <2f901228-52db-7661-8257-ca8fd2ff2a46@free.fr>
 <29664b43-535c-c4b1-a93d-18f49687f929@linaro.org>
 <b0e0dc68-4be9-1b0f-7528-fb7d143fea2b@free.fr>
 <9c5a7620-e9ed-82d6-0708-34fe33e39030@linaro.org>
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
Message-ID: <29d33e81-fe8d-7fd9-843d-cc53ea6c9586@free.fr>
Date:   Thu, 14 Mar 2019 14:18:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <9c5a7620-e9ed-82d6-0708-34fe33e39030@linaro.org>
Content-Type: text/plain; charset=iso-8859-15
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: ClamAV using ClamSMTP ; ns.iliad.fr ; Thu Mar 14 14:18:44 2019 +0100 (CET)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 14/03/2019 12:10, Srinivas Kandagatla wrote:

> Here is the output: https://paste.ubuntu.com/p/kFWZ4kXCxT/

Could you test the following patch:
And report boot log as well as output of lspci -vv ?

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 45ff5e4f8af6..aca656eff8ca 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -727,7 +727,11 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
 	/* Enable write permission for the DBI read-only register */
 	dw_pcie_dbi_ro_wr_en(pci);
 	/* Program correct class for RC */
+	dw_pcie_rd_own_conf(pp, PCI_CLASS_REVISION, 4, &val);
+	printk("\tBEFORE: CLASS/REV=%08x\n", val);
 	dw_pcie_wr_own_conf(pp, PCI_CLASS_DEVICE, 2, PCI_CLASS_BRIDGE_PCI);
+	dw_pcie_rd_own_conf(pp, PCI_CLASS_REVISION, 4, &val);
+	printk("\t AFTER: CLASS/REV=%08x\n", val);
 	/* Better disable write permission right after the update */
 	dw_pcie_dbi_ro_wr_dis(pci);
 
diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index d185ea5fe996..c5e16f9aaf44 100644
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
@@ -1299,6 +1282,13 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 	return ret;
 }
 
+static void qcom_fixup_class(struct pci_dev *dev)
+{
+	printk("\tAPPLYING %s\n", __func__);
+	dev->class = PCI_CLASS_BRIDGE_PCI << 8;
+}
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_QCOM, 0x0101, qcom_fixup_class); // 8064
+
 static const struct of_device_id qcom_pcie_match[] = {
 	{ .compatible = "qcom,pcie-apq8084", .data = &ops_1_0_0 },
 	{ .compatible = "qcom,pcie-ipq8064", .data = &ops_2_1_0 },
