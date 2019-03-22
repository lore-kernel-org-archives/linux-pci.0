Return-Path: <SRS0=nTPQ=RZ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0AFBC43381
	for <linux-pci@archiver.kernel.org>; Fri, 22 Mar 2019 16:18:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B9C62190A
	for <linux-pci@archiver.kernel.org>; Fri, 22 Mar 2019 16:18:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728640AbfCVQSM (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 22 Mar 2019 12:18:12 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:59561 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727898AbfCVQSM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 Mar 2019 12:18:12 -0400
Received: from wuerfel.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1N5mSj-1gwtJa2zff-017GR7; Fri, 22 Mar 2019 17:17:53 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     stable@vger.kernel.org, Jingoo Han <jingoohan1@gmail.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Niklas Cassel <niklas.cassel@axis.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Joao Pinto <jpinto@synopsys.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Sasha Levin <alexander.levin@microsoft.com>,
        Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [BACKPORT 4.14.y 2/8] PCI: designware-ep: dw_pcie_ep_set_msi() should only set MMC bits
Date:   Fri, 22 Mar 2019 17:17:17 +0100
Message-Id: <20190322161727.1153278-3-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190322161727.1153278-1-arnd@arndb.de>
References: <20190322161727.1153278-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Uo8SCd+/FXufp8zP23YIUZ9XHIAhfqzREoeT+kXGkT8DrQcIvtO
 ISLMiq4LYOZCjxilA5CckNAfOAqFDM+LAjWLcxmlmgVxM4p5Bgr6VgHEQIuJGeRFS2s/GYC
 ilIhAbagAtbWHr8HrO/vV7yevV+US9cos7fN8GQFx4BXmKoWrebgZilbJPg+jAo5alncl90
 z1hU1IY884EbOkFU6yBvg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:JgGkVkB65co=:ZK0Oq82pszuJbkxPzXZ9Yj
 73QDqJompKb4wnxLc5id8fEuPESPHDKbHZD+sh2o9651pNR5mtS+elVnpUUQH1VfuTvwRE74a
 jltal0bsxPt8UciDilVITIrcljRKJJk+Gnq9AHk3xZ2YArlfEv/Aop60qz8DIl1ssD/nfbQjS
 ttClDHA1MxHmYMG60Tld6z3lC3PFxzRBnUuCDWnfguvkJl/fTOahNCwolB6HAMaZRESHHNECE
 E1RKlc0Hl2miLYvVfK4vOajLAuoiO8yZhurMBKBfXBgWT8FtTW1mT/niodvRkm/QrS5q7o3Cg
 2cXEsm/LswE04L+gCAtyFepmsIVsEfloAT4xYv57+8CQxycUmmo4tUHEn+XeUSwvHso44d5o6
 lpIb4+OpuEVkcwmeFb9EF91RlNjRhzBl8kfzEOMryFUCwflw7lUA0rCsTt1C6XE/gcTOgPHHM
 wJm+y262gz8OXYGAQ38EJWrEajVIhzXImAbUXgu4uEHrReRU4w6JV2xl1S0TzFwVv85bUJqXj
 DsYz0gF2/2VaGoKWkbrGjG7264IzWnugr2FP422/sn4l2++MjDsJ6925vL6PWKYkwqUAe+VD8
 unr1v9Mri/9wzc5o35Gh7og3uKEMnU8Rz+Bdjy7RJ6iQYjScHYug1DY+n8uCkdnvIdpiDjF6i
 lK13EFS/7jhs/GOfb7r8VZK+APxrrPFU9vzUlWYPYX9T4rqLkQrp1VwmJYWVT8YXuzZUhWru8
 hI8Gv+CORdm2j3FXOkJPtSfJRGnVY7UoBS3xbg==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Niklas Cassel <niklas.cassel@axis.com>

Previously, dw_pcie_ep_set_msi() wrote all bits in the Message Control
register, thus overwriting the PCI_MSI_FLAGS_64BIT bit.
By clearing the PCI_MSI_FLAGS_64BIT bit, we break MSI
on systems where the RC has set a 64 bit MSI address.
Fix dw_pcie_ep_set_msi() so that it only sets MMC bits.

Tested-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Acked-by: Joao Pinto <jpinto@synopsys.com>
(cherry picked from commit 099a95f3591ade29da52131895a3ba9f92a0e82c)
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/pci/dwc/pcie-designware-ep.c | 4 +++-
 drivers/pci/dwc/pcie-designware.h    | 1 +
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/dwc/pcie-designware-ep.c b/drivers/pci/dwc/pcie-designware-ep.c
index 7c621877a939..df317d390317 100644
--- a/drivers/pci/dwc/pcie-designware-ep.c
+++ b/drivers/pci/dwc/pcie-designware-ep.c
@@ -214,7 +214,9 @@ static int dw_pcie_ep_set_msi(struct pci_epc *epc, u8 encode_int)
 	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
 
-	val = (encode_int << MSI_CAP_MMC_SHIFT);
+	val = dw_pcie_readw_dbi(pci, MSI_MESSAGE_CONTROL);
+	val &= ~MSI_CAP_MMC_MASK;
+	val |= (encode_int << MSI_CAP_MMC_SHIFT) & MSI_CAP_MMC_MASK;
 	dw_pcie_writew_dbi(pci, MSI_MESSAGE_CONTROL, val);
 
 	return 0;
diff --git a/drivers/pci/dwc/pcie-designware.h b/drivers/pci/dwc/pcie-designware.h
index 3551dd607b90..5af29d125c7e 100644
--- a/drivers/pci/dwc/pcie-designware.h
+++ b/drivers/pci/dwc/pcie-designware.h
@@ -99,6 +99,7 @@
 
 #define MSI_MESSAGE_CONTROL		0x52
 #define MSI_CAP_MMC_SHIFT		1
+#define MSI_CAP_MMC_MASK		(7 << MSI_CAP_MMC_SHIFT)
 #define MSI_CAP_MME_SHIFT		4
 #define MSI_CAP_MSI_EN_MASK		0x1
 #define MSI_CAP_MME_MASK		(7 << MSI_CAP_MME_SHIFT)
-- 
2.20.0

