Return-Path: <SRS0=5lyS=PH=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3E8EC43387
	for <linux-pci@archiver.kernel.org>; Sun, 30 Dec 2018 11:06:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62C7820855
	for <linux-pci@archiver.kernel.org>; Sun, 30 Dec 2018 11:06:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T/k2YsSW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725972AbeL3LGY (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sun, 30 Dec 2018 06:06:24 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35737 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725971AbeL3LGY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 30 Dec 2018 06:06:24 -0500
Received: by mail-wr1-f65.google.com with SMTP id 96so24532437wrb.2
        for <linux-pci@vger.kernel.org>; Sun, 30 Dec 2018 03:06:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:cc:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=7uTH9rrc/5536CWxDXni6P4TMwJvDumLBnGklSMZ0Tg=;
        b=T/k2YsSWcBKAGtyDJxWVHUi2LFOBB2/soNsFkU+rhP4b1gqZoJGYvdo+b6ogU1RJNq
         3UCa/FRAvsugR496uW5Xu4vhsy9xNXLwyGNJekapEuSIVYV5wUCmU8hpZ1VfnMpCr+Pw
         byTwnSYRxp1ZlNWnugccKkU+MvcFYJji6n6qSoRbzzkI70/xaROUG82ZEfgfSjCk1Fv+
         XxLesy7/gbXBDbUSC2N6XfOyQitdAS75GjOEugWPF3SBqyTv7s1o/YxEgt//CVYy4rWi
         vKascwNnrKkIXBMd9xADN28HkfdRWyjLggyMp7UmRc+aoWLyZQCF5HV4M9/YLXoQcPw+
         04tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=7uTH9rrc/5536CWxDXni6P4TMwJvDumLBnGklSMZ0Tg=;
        b=CkXMvjcohNL12irAVbHmBzYUJQne4BVzLsQjd15LJavtii0jBMxV2YZ1wUBdZO/Foh
         rOzBd8K8QoXmQF02TG8lBzD/+NF5v+iXLu0rM6xm1c0HqoVGkduHfoB1gDb2eqDGWOXg
         Cmp6PRSg30UsNamYo2wXN3SWv4MMzGjinORvIKo7xh2mDJxO/NpjbkeKs9QafMCL0TL9
         H3VWaJCNuAUARf2aNRJYzc4sSBKvT0DGaRNd0jWZq65eA/hmMJc4Zgp8VyDzdqSGzxoc
         Awrqu5m2FhM8IrXIKi11JjYNYkEg7aOE0jGm6eQgdpqCDg7sGQPrRHL3HdaACAxb8ffR
         NNLA==
X-Gm-Message-State: AJcUukdpkfVt7ope/5jo1P2Cu+koYqdzFJZvWUufTXAmjjdoLAQRq8A/
        uI5dLBYfAhPCu1ALjXkGGgJsooGO
X-Google-Smtp-Source: ALg8bN5OO92MoSCn0lW97DXcCPBjciqf9WT9mmuNJj260TcpzbB7s4vbOGvRuuKrmLV8jkux9TezrQ==
X-Received: by 2002:adf:e509:: with SMTP id j9mr32382938wrm.76.1546167982369;
        Sun, 30 Dec 2018 03:06:22 -0800 (PST)
Received: from ?IPv6:2003:ea:8bcf:e300:91d:395e:672d:52a9? (p200300EA8BCFE300091D395E672D52A9.dip0.t-ipconnect.de. [2003:ea:8bcf:e300:91d:395e:672d:52a9])
        by smtp.googlemail.com with ESMTPSA id q9sm49770810wrp.0.2018.12.30.03.06.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Dec 2018 03:06:21 -0800 (PST)
From:   Heiner Kallweit <hkallweit1@gmail.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH RFC] PCI/PME: fix PME runtime PM handling
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Message-ID: <1e0c3baa-c2bb-0a91-19ca-65f4784b1424@gmail.com>
Date:   Sun, 30 Dec 2018 12:06:14 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

I face the issue that no PME is generated if the network cable is
re-plugged. To explain that in a little more detail:
r8169 driver enters runtime suspend 10 seconds after cable is detached.
LinkUp detection is armed and device enters D3hot. When the cable is
re-plugged Linkup should generate a PME and device is resumed.
But system receives no PME from the device.

Wake-on-LAN from S3 works perfectly fine and generates a PME.

After checking the pcie pme code and some experiments I found that
the following fixes the issue for me. Now system receives the PME
and properly runtime-resumes the network device.

But I'm no expert in PCIe and PME, therefore I'm not sure whether
the fix is correct. Please advise.

Adding also Mika as author of 0e157e528604 ("PCI/PME: Implement
runtime PM callbacks").

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/pci/pcie/pme.c | 29 ++---------------------------
 1 file changed, 2 insertions(+), 27 deletions(-)

diff --git a/drivers/pci/pcie/pme.c b/drivers/pci/pcie/pme.c
index 0dbcf4290..285ea0ed2 100644
--- a/drivers/pci/pcie/pme.c
+++ b/drivers/pci/pcie/pme.c
@@ -432,31 +432,6 @@ static void pcie_pme_remove(struct pcie_device *srv)
 	kfree(get_service_data(srv));
 }
 
-static int pcie_pme_runtime_suspend(struct pcie_device *srv)
-{
-	struct pcie_pme_service_data *data = get_service_data(srv);
-
-	spin_lock_irq(&data->lock);
-	pcie_pme_interrupt_enable(srv->port, false);
-	pcie_clear_root_pme_status(srv->port);
-	data->noirq = true;
-	spin_unlock_irq(&data->lock);
-
-	return 0;
-}
-
-static int pcie_pme_runtime_resume(struct pcie_device *srv)
-{
-	struct pcie_pme_service_data *data = get_service_data(srv);
-
-	spin_lock_irq(&data->lock);
-	pcie_pme_interrupt_enable(srv->port, true);
-	data->noirq = false;
-	spin_unlock_irq(&data->lock);
-
-	return 0;
-}
-
 static struct pcie_port_service_driver pcie_pme_driver = {
 	.name		= "pcie_pme",
 	.port_type	= PCI_EXP_TYPE_ROOT_PORT,
@@ -464,8 +439,8 @@ static struct pcie_port_service_driver pcie_pme_driver = {
 
 	.probe		= pcie_pme_probe,
 	.suspend	= pcie_pme_suspend,
-	.runtime_suspend = pcie_pme_runtime_suspend,
-	.runtime_resume	= pcie_pme_runtime_resume,
+	.runtime_suspend = pcie_pme_suspend,
+	.runtime_resume	= pcie_pme_resume,
 	.resume		= pcie_pme_resume,
 	.remove		= pcie_pme_remove,
 };
-- 
2.20.1

