Return-Path: <SRS0=bOp+=MB=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71C61ECE564
	for <linux-pci@archiver.kernel.org>; Wed, 19 Sep 2018 14:33:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D4502086E
	for <linux-pci@archiver.kernel.org>; Wed, 19 Sep 2018 14:33:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EDk36OMK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D4502086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732447AbeISULe (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 19 Sep 2018 16:11:34 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:44926 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732354AbeISULd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 Sep 2018 16:11:33 -0400
Received: by mail-qk1-f196.google.com with SMTP id d131-v6so3084052qke.11;
        Wed, 19 Sep 2018 07:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dHH1ppMPThGqV5VyOb9W3/uiepQ9nDJkklt+sF0I9g0=;
        b=EDk36OMKe6a92UllATseyp3PLc/hh2AViyfyy0H+Ohe5F25o47wnIRmgIc45+rJv/p
         0uLjyQkJVg27KXGsIx5alEDJIfSpqrdN8RUkFYIivPARPIatBOvkbgq3IAriZIX3D9pV
         ejT2oVkpUgDa2tyo0zlrQeaJESzbTUSd6NBXXEPI+vUTM28IAJImTaqT/eKxfzF9kFoJ
         tlmy4rZMaK52afRL7IoSDvxLf9MskpofYRVFRPRt1+lwt1GaONKJmU7c52sk+yhEoptn
         7VIjOJM71NncOpAIf+j88VmnZ7RIMXjcOIE5I74l50teej9bHmSnBD+qt+lDKW6XLbSZ
         sMww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dHH1ppMPThGqV5VyOb9W3/uiepQ9nDJkklt+sF0I9g0=;
        b=SGr+P01NZITsClGurhkdZVXTwKY2FLK9i4eW4mbRq5C3GiIMhcQHIKcIsMAyblymIX
         HwX2Wfiy1J5VBpdSn7wFI8SmrQZ2SaTSZngTicC0nd+NUu09cENDSFH6++K+jhnot1si
         N+WsP2TKO7qvwyvxOoVZa2mUAupI8p8GQlTVmwWHrx0uuAvfbXoEfW7a9EjRjjgCmWp2
         F+449JqfbbHEYROaHsff6EqkprhnitQqO71BMfvIB8dNNWowKGyA+Jz85vqgkTtu2vLj
         U49hctD09mDmFMtbBoxLDZZv+kywh8yEizWbQnI+IQ3Fazndewpe5V+Rxn4225V0pxDt
         jhCA==
X-Gm-Message-State: APzg51CHffYHRY3wlg/quZyI+Y8ilkCVRIhqjmlC1b3mKGgqYBot3dRK
        S/wZtyB+jUrAgsNRwd7RWZmZMqa4
X-Google-Smtp-Source: ANB0VdYseHQASVlRcBL0qWt+wqKL+4V4L+JSjQQbtVOOVs5Wf5W1z6K89dm1GkOwaWXftSn1grbspQ==
X-Received: by 2002:a37:d78e:: with SMTP id t14-v6mr6322766qkt.220.1537367600213;
        Wed, 19 Sep 2018 07:33:20 -0700 (PDT)
Received: from stbsrv-and-3.and.broadcom.com ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id 17-v6sm2104051qkf.74.2018.09.19.07.33.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Sep 2018 07:33:19 -0700 (PDT)
From:   Jim Quinlan <jim2101024@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jim Quinlan <jim2101024@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v5 11/12] ARM64: add dma remap for BrcmSTB PCIe
Date:   Wed, 19 Sep 2018 10:32:06 -0400
Message-Id: <1537367527-20773-12-git-send-email-jim2101024@gmail.com>
X-Mailer: git-send-email 1.9.0.138.g2de3478
In-Reply-To: <1537367527-20773-1-git-send-email-jim2101024@gmail.com>
References: <1537367527-20773-1-git-send-email-jim2101024@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org
Message-ID: <20180919143206.uSGbb8pIO6QhgUsg6zAHokLVgNp6RDXYorpozUwgfkk@z>

The BrcmSTB PCIe controller needs to remap DMA accesses to it because
of the requirements of its interface with the SOC memory controllers.

Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
---
 drivers/pci/controller/Kconfig        |  1 +
 drivers/pci/controller/pcie-brcmstb.c | 12 ++++++++++++
 2 files changed, 13 insertions(+)

diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
index 8daa621..4394430 100644
--- a/drivers/pci/controller/Kconfig
+++ b/drivers/pci/controller/Kconfig
@@ -284,6 +284,7 @@ config PCIE_BRCMSTB
 	depends on OF && PCI_MSI
 	depends on SOC_BRCMSTB
 	default ARCH_BRCMSTB || BMIPS_GENERIC
+	select ARCH_HAS_PHYS_TO_DMA if ARM64
 	help
 	  Say Y here to enable PCIe host controller support for
 	  Broadcom Settop Box SOCs.  A Broadcom SOC will may have
diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index a805d87..ae9df8e 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -974,6 +974,18 @@ phys_addr_t brcm_dma_to_phys(struct device *dev, dma_addr_t dev_addr)
 	return (phys_addr_t)dev_addr;
 }
 
+#if defined(CONFIG_ARM64)
+dma_addr_t __phys_to_dma(struct device *dev, phys_addr_t paddr)
+{
+	return brcm_phys_to_dma(dev, paddr);
+}
+
+phys_addr_t __dma_to_phys(struct device *dev, dma_addr_t dev_addr)
+{
+	return brcm_dma_to_phys(dev, dev_addr);
+}
+#endif
+
 static int brcm_pcie_add_controller(struct brcm_pcie *pcie)
 {
 	int i, ret = 0;
-- 
1.9.0.138.g2de3478

