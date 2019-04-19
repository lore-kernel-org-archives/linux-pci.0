Return-Path: <SRS0=PPlZ=SV=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BACF2C282DF
	for <linux-pci@archiver.kernel.org>; Fri, 19 Apr 2019 18:30:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86FA420449
	for <linux-pci@archiver.kernel.org>; Fri, 19 Apr 2019 18:30:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ns3z3KsZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727900AbfDSS37 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:29:59 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34878 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728044AbfDSS36 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 19 Apr 2019 14:29:58 -0400
Received: by mail-wr1-f67.google.com with SMTP id o12so4538590wrn.2;
        Fri, 19 Apr 2019 11:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kB/xsYXQ3pDchMWCMlizuJaQAcde2gxIfDs80kGqcvg=;
        b=Ns3z3KsZx/W4kFe5JADMz8Ais2iFw6Gh5nL5qAhGF3ro1ufJVeX4A3/gnKXVLtEHfK
         vwqyszPue5w5WzcSwQzmHMmQtwWJRssnu3SPuPADZ9D7SGG6r6K3F0Z4pYD/Djp43ov5
         twAqwASGNULTYn21oLW+cg/HZXC4oT6GmRPa7/Ksb34VsXSJQiuDwsqoIZ0PL1BQamaD
         zkb7FkdjzdpNqgMLDBd1+G/QjMo7Gq+K729vzRHaGCWCL1Z/OPuPg4jKE2vlYmRStMGy
         Gx8SOXH+9uqfTabkIWfxlRPUqZLUTEERXUreq6/fZbf3rpsj+6mvBHD1YKMTubPOaKXy
         c6Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kB/xsYXQ3pDchMWCMlizuJaQAcde2gxIfDs80kGqcvg=;
        b=G8GgmPESYTRmbTCb0Ha9mXQ7sLo3yQjMN0Td+qF73RMjFLY5bhVjVXYFGh/v3RdbTC
         ghtCOF5MUV7ZFGrSMw3DVhhDrYWn3OAhXcGKf3be8CkYYg/6SIVkqcqxNb4PxOu4KSmE
         q/igvzXSux5Higkvb1QGT4DTIUYLT34Zr31Ght0DIzjpqnviPs/tRnadNUzD0xAL/NMV
         I8t1rsOKqfRuBAwoKEdsNRB/G71J9r7WV4CmzAflE+kmxugoesk+EC0QlHU9KoaVehWO
         QXrWJimicJ3C9/Kh0W21wkodsNVbDaOtiSCS3DkzhbFR5wgoNtjYVPcXnq54xufBk/9g
         6Xzw==
X-Gm-Message-State: APjAAAXaW34pkvR0bbElXqzizWwKEUhQaotT991jfmQNIsvha+oiteV3
        W+xIboTCrC0YMTwaVzi6KOjYHYd4
X-Google-Smtp-Source: APXvYqyuqnLbOVpwUcCzjVlI2O0XUWAo4/xEvLin9ExLDemiSUTh5qit8EXwL+UXezpVMNTo+hsaQA==
X-Received: by 2002:a5d:4087:: with SMTP id o7mr4145080wrp.9.1555698596375;
        Fri, 19 Apr 2019 11:29:56 -0700 (PDT)
Received: from ?IPv6:2003:ea:8bd4:5700:584:3262:bfe6:7518? (p200300EA8BD4570005843262BFE67518.dip0.t-ipconnect.de. [2003:ea:8bd4:5700:584:3262:bfe6:7518])
        by smtp.googlemail.com with ESMTPSA id t6sm4825163wrn.3.2019.04.19.11.29.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Apr 2019 11:29:55 -0700 (PDT)
Subject: [PATCH 2/3] PCI: use helper pci_dev_id
From:   Heiner Kallweit <hkallweit1@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <b193514c-23d1-e090-7ddb-40371595f3a7@gmail.com>
Message-ID: <5c6c4e3b-060f-ecc8-9155-80becefd5387@gmail.com>
Date:   Fri, 19 Apr 2019 20:29:14 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <b193514c-23d1-e090-7ddb-40371595f3a7@gmail.com>
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



