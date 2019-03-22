Return-Path: <SRS0=nTPQ=RZ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D5E4C10F03
	for <linux-pci@archiver.kernel.org>; Fri, 22 Mar 2019 16:18:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5DAB218A2
	for <linux-pci@archiver.kernel.org>; Fri, 22 Mar 2019 16:18:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728053AbfCVQSL (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 22 Mar 2019 12:18:11 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:56887 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727887AbfCVQSL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 Mar 2019 12:18:11 -0400
Received: from wuerfel.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1N4R0a-1gyGEE2KF4-011WD6; Fri, 22 Mar 2019 17:17:56 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     stable@vger.kernel.org, Jingoo Han <jingoohan1@gmail.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Niklas Cassel <niklas.cassel@axis.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Joao Pinto <jpinto@synopsys.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Sasha Levin <alexander.levin@microsoft.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [BACKPORT 4.14.y 3/8] PCI: designware-ep: Read-only registers need DBI_RO_WR_EN to be writable
Date:   Fri, 22 Mar 2019 17:17:18 +0100
Message-Id: <20190322161727.1153278-4-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190322161727.1153278-1-arnd@arndb.de>
References: <20190322161727.1153278-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:7BnjHSR4SGPL5O3iW2s2eF984rMLHtb/Z9rhiT9lkOTIb39GVI3
 hQtWPoO/mMPxp17/3ZU82z1T0gk6EIgXpT8Zy2BF8MfaPrR1TZ2Mbvlu8DnLpsl7zUqfqc2
 H1xvyjI3wl5D5wEr3IYLZZ1W+XCXF36k2ihAWilhu3CdEcwFbsJkvoiGL93/pWMYWDpUiOP
 s6dkhRXzQZObRFJI5EIGQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:17/Qz6aOfMk=:6VHlA6OIxePe+TiHtj83Ik
 FWXxQ/0KmePvCCJvWxAFwgxUE1LNAftApU6ai9SuFoRv8Tipqb2gN6LWaXzW8w5lH25aN2JFK
 Uf7WRhcZmIXR3RDcHbnoD61UsoDFdAfktEysc4ZKB5At48SyOZN/PX116X8al8Hr0Ambsr93Q
 kxoKlMFq9HoT29vniSHyi+pTN6Zg6O2AviF3zOLltAVfOhj1xyk9goI1DwSmI/JqON8A170kt
 TN+quaZyEomexWQiF3+696YXt17jrgUflQeSKI8pH1OtgtbDDjpmxky54P4OoxXiXemtNBMoD
 d5p5BeFK6F8DhPWg/guSRJ/qarrqWxUteCYWR3RsVKKoQyWtW55LL9SICT6122/cjaV5+RTT/
 8uWm3Cs+nrXlHCY+jQnQWKvLvugpr66uxhf1XWa2Bwod2dRcjHouuRFXUXZtbrbBlF8qyAcmY
 IZNxZhlTuDjpnno9VEtgznT6fMvOTF7WNy2Wqjc9MkJJRjw7rqg5xKQ2pwR/nLomHP+Xsx8vx
 Qu4PKfRbIMBGMgYDcKp3y21X5T++7mMPRm+2AJBRg+aa9SbbyooiTdxRhtbAh1x7HmCRH3/51
 Dy/xzPD5LJH9K9dVV48Pn6e9GFTrQa1kXg8J45LPzB9Plxw1MMPX/nHQL1PVzS/owr1cFVcuA
 xqpePZUamn/nm1pEXVIHjlK015udOe2jeNlJh3GdjvCRGC9En6ftcY8aecmcjsO48VdvuWW/t
 DBsGqZz7vV2F3jDAzqx+Z1IJko3pkavs4eTWng==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Niklas Cassel <niklas.cassel@axis.com>

Certain registers that pcie-designware-ep tries to write to are read-only
registers. However, these registers can become read/write if we first
enable the DBI_RO_WR_EN bit. Set/unset the DBI_RO_WR_EN bit before/after
writing these registers.

Tested-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Acked-by: Joao Pinto <jpinto@synopsys.com>
(cherry picked from commit 1cab826b30c6275d479a6ab1dea1067e15dbec62)
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/pci/dwc/pcie-designware-ep.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/pci/dwc/pcie-designware-ep.c b/drivers/pci/dwc/pcie-designware-ep.c
index df317d390317..abcbf0770358 100644
--- a/drivers/pci/dwc/pcie-designware-ep.c
+++ b/drivers/pci/dwc/pcie-designware-ep.c
@@ -35,8 +35,10 @@ static void dw_pcie_ep_reset_bar(struct dw_pcie *pci, enum pci_barno bar)
 	u32 reg;
 
 	reg = PCI_BASE_ADDRESS_0 + (4 * bar);
+	dw_pcie_dbi_ro_wr_en(pci);
 	dw_pcie_writel_dbi2(pci, reg, 0x0);
 	dw_pcie_writel_dbi(pci, reg, 0x0);
+	dw_pcie_dbi_ro_wr_dis(pci);
 }
 
 static int dw_pcie_ep_write_header(struct pci_epc *epc,
@@ -45,6 +47,7 @@ static int dw_pcie_ep_write_header(struct pci_epc *epc,
 	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
 
+	dw_pcie_dbi_ro_wr_en(pci);
 	dw_pcie_writew_dbi(pci, PCI_VENDOR_ID, hdr->vendorid);
 	dw_pcie_writew_dbi(pci, PCI_DEVICE_ID, hdr->deviceid);
 	dw_pcie_writeb_dbi(pci, PCI_REVISION_ID, hdr->revid);
@@ -58,6 +61,7 @@ static int dw_pcie_ep_write_header(struct pci_epc *epc,
 	dw_pcie_writew_dbi(pci, PCI_SUBSYSTEM_ID, hdr->subsys_id);
 	dw_pcie_writeb_dbi(pci, PCI_INTERRUPT_PIN,
 			   hdr->interrupt_pin);
+	dw_pcie_dbi_ro_wr_dis(pci);
 
 	return 0;
 }
@@ -142,8 +146,10 @@ static int dw_pcie_ep_set_bar(struct pci_epc *epc, enum pci_barno bar,
 	if (ret)
 		return ret;
 
+	dw_pcie_dbi_ro_wr_en(pci);
 	dw_pcie_writel_dbi2(pci, reg, size - 1);
 	dw_pcie_writel_dbi(pci, reg, flags);
+	dw_pcie_dbi_ro_wr_dis(pci);
 
 	return 0;
 }
@@ -217,7 +223,9 @@ static int dw_pcie_ep_set_msi(struct pci_epc *epc, u8 encode_int)
 	val = dw_pcie_readw_dbi(pci, MSI_MESSAGE_CONTROL);
 	val &= ~MSI_CAP_MMC_MASK;
 	val |= (encode_int << MSI_CAP_MMC_SHIFT) & MSI_CAP_MMC_MASK;
+	dw_pcie_dbi_ro_wr_en(pci);
 	dw_pcie_writew_dbi(pci, MSI_MESSAGE_CONTROL, val);
+	dw_pcie_dbi_ro_wr_dis(pci);
 
 	return 0;
 }
-- 
2.20.0

