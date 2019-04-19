Return-Path: <SRS0=PPlZ=SV=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25C15C282DF
	for <linux-pci@archiver.kernel.org>; Fri, 19 Apr 2019 18:15:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE81B222EB
	for <linux-pci@archiver.kernel.org>; Fri, 19 Apr 2019 18:15:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VaXAjqGV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725867AbfDSSPp (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:15:45 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36729 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725880AbfDSSPo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 19 Apr 2019 14:15:44 -0400
Received: by mail-wr1-f68.google.com with SMTP id a15so3328693wrw.3;
        Fri, 19 Apr 2019 11:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=kB/xsYXQ3pDchMWCMlizuJaQAcde2gxIfDs80kGqcvg=;
        b=VaXAjqGV+vVVSmMMQLPJayyVmgoBevlvb9BEUkj/jE0i8rLvNqELcUoR3GdksTDB7n
         CrhjtfME9njssgWasehqpC1gngUPDzOY3uFEnnSKpvwERnpX0bFyfBUXMGJveuXPUFux
         CxhYddFelJHnudlK+gJOAx4VPEy5/qGrPBMugP0Y6qgx3UqeCTsoOG6Nxv+UcClgisZF
         ctzWxlDSsNYoZRjYj/RQgT9e6ZOQAfUmAbVNUZOnM4d1eYZrUzcrDrz06iifSVa3a75A
         UdZaiFbWqCDVRzzj9ymVTgmmWzkccE/+Oa6qHHFTfQHZvmo+QF9O6gfBNFG+/0qZSY2H
         mdew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kB/xsYXQ3pDchMWCMlizuJaQAcde2gxIfDs80kGqcvg=;
        b=knP++ne4Jjuasplo2ImqTraOBlgUjbLObjY33kyo00EogKc5FLboEthkB225N3BmF+
         wNoX5+nSZ5CnstfrJPSUaRj2Kyf7sSDARYutdZeqCtoDdt1GMvvnO+Nr/VT3ad/MjwkO
         xxp2ZX8qDglTSxQXXKQPUMqypDQofbSNJ2vSMlZSo6MSB1tvlGDrMp10ZOy4+ECIIx6x
         c+G9mYXB9Hq8Fl/erYtbG2zseDPfqZntJ68OZsP+QWhR/kZ1rcH8bUGzT1AczX7EWRZ4
         vOZemuqauZV+p/DbNLiwmWJsOLvNRT0vsPLojiME4b+iodTbXU0Fq4nLaGvmxEwaU1/9
         KpXg==
X-Gm-Message-State: APjAAAWS509NYVCTjXv6fpWqRHCEyi/3lOf+cmwLEjiBBos8sSMrVE/L
        UQMBnfsTBNGn32FbiVcOhTwg7D6/
X-Google-Smtp-Source: APXvYqwGZYRxhQaiG2Ql39+qiMZCrZENYIQKu+cVh06piTjfCBnd4xH3FKzoj7QqrOgNemqRTIJKug==
X-Received: by 2002:adf:f30a:: with SMTP id i10mr2532633wro.111.1555672232978;
        Fri, 19 Apr 2019 04:10:32 -0700 (PDT)
Received: from ?IPv6:2003:ea:8bd4:5700:584:3262:bfe6:7518? (p200300EA8BD4570005843262BFE67518.dip0.t-ipconnect.de. [2003:ea:8bd4:5700:584:3262:bfe6:7518])
        by smtp.googlemail.com with ESMTPSA id g5sm5745383wrw.40.2019.04.19.04.10.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Apr 2019 04:10:32 -0700 (PDT)
Subject: [PATCH 2/3] PCI: use helper pci_dev_id
From:   Heiner Kallweit <hkallweit1@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <b352964f-a9a4-c8eb-520c-19b4dca4fba1@gmail.com>
Message-ID: <96beedd9-fc9d-68b6-049a-b8093c4c312e@gmail.com>
Date:   Fri, 19 Apr 2019 13:09:30 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <b352964f-a9a4-c8eb-520c-19b4dca4fba1@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Use new helper pci_dev_id() to simplify the code.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/pci/msi.c    |  6 +++---
 drivers/pci/search.c | 10 +++-------
 2 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 73986825d..e039b740f 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -1338,7 +1338,7 @@ irq_hw_number_t pci_msi_domain_calc_hwirq(struct pci_dev *dev,
 					  struct msi_desc *desc)
 {
 	return (irq_hw_number_t)desc->msi_attrib.entry_nr |
-		PCI_DEVID(dev->bus->number, dev->devfn) << 11 |
+		pci_dev_id(dev) << 11 |
 		(pci_domain_nr(dev->bus) & 0xFFFFFFFF) << 27;
 }
 
@@ -1508,7 +1508,7 @@ static int get_msi_id_cb(struct pci_dev *pdev, u16 alias, void *data)
 u32 pci_msi_domain_get_msi_rid(struct irq_domain *domain, struct pci_dev *pdev)
 {
 	struct device_node *of_node;
-	u32 rid = PCI_DEVID(pdev->bus->number, pdev->devfn);
+	u32 rid = pci_dev_id(pdev);
 
 	pci_for_each_dma_alias(pdev, get_msi_id_cb, &rid);
 
@@ -1531,7 +1531,7 @@ u32 pci_msi_domain_get_msi_rid(struct irq_domain *domain, struct pci_dev *pdev)
 struct irq_domain *pci_msi_get_device_domain(struct pci_dev *pdev)
 {
 	struct irq_domain *dom;
-	u32 rid = PCI_DEVID(pdev->bus->number, pdev->devfn);
+	u32 rid = pci_dev_id(pdev);
 
 	pci_for_each_dma_alias(pdev, get_msi_id_cb, &rid);
 	dom = of_msi_map_get_device_domain(&pdev->dev, rid);
diff --git a/drivers/pci/search.c b/drivers/pci/search.c
index 2b5f72086..5c7922612 100644
--- a/drivers/pci/search.c
+++ b/drivers/pci/search.c
@@ -33,7 +33,7 @@ int pci_for_each_dma_alias(struct pci_dev *pdev,
 	struct pci_bus *bus;
 	int ret;
 
-	ret = fn(pdev, PCI_DEVID(pdev->bus->number, pdev->devfn), data);
+	ret = fn(pdev, pci_dev_id(pdev), data);
 	if (ret)
 		return ret;
 
@@ -88,9 +88,7 @@ int pci_for_each_dma_alias(struct pci_dev *pdev,
 					return ret;
 				continue;
 			case PCI_EXP_TYPE_PCIE_BRIDGE:
-				ret = fn(tmp,
-					 PCI_DEVID(tmp->bus->number,
-						   tmp->devfn), data);
+				ret = fn(tmp, pci_dev_id(tmp), data);
 				if (ret)
 					return ret;
 				continue;
@@ -101,9 +99,7 @@ int pci_for_each_dma_alias(struct pci_dev *pdev,
 					 PCI_DEVID(tmp->subordinate->number,
 						   PCI_DEVFN(0, 0)), data);
 			else
-				ret = fn(tmp,
-					 PCI_DEVID(tmp->bus->number,
-						   tmp->devfn), data);
+				ret = fn(tmp, pci_dev_id(tmp), data);
 			if (ret)
 				return ret;
 		}
-- 
2.21.0


