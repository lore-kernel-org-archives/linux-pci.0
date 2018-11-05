Return-Path: <SRS0=Hm5h=NQ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83B00C0044C
	for <linux-pci@archiver.kernel.org>; Mon,  5 Nov 2018 12:51:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 057F020869
	for <linux-pci@archiver.kernel.org>; Mon,  5 Nov 2018 12:51:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mobiveil.co.in header.i=@mobiveil.co.in header.b="DmGUOSbO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 057F020869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mobiveil.co.in
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729917AbeKEWL2 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 5 Nov 2018 17:11:28 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:41045 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729015AbeKEWL2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 5 Nov 2018 17:11:28 -0500
Received: by mail-pl1-f196.google.com with SMTP id p16-v6so4425952plr.8
        for <linux-pci@vger.kernel.org>; Mon, 05 Nov 2018 04:51:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mobiveil.co.in; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=61IM1BpJF7hP0Xm3lMelzTNjW0VhxJvVmEeUdyzQx18=;
        b=DmGUOSbOn5EsBORSGteAO4mn7aRiYH2vxN51jCbjfBhynZmwDh5d16YTOHSlspylhm
         nugxCrOJauCFVC9RJYxlHYp43NAuEgITjO35YTAFBZIxsVHw0hJWJsfW+p1raBmGlP9j
         hlCywhgpDk76dDShDsvNr7rkSG8CctbySqfBI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=61IM1BpJF7hP0Xm3lMelzTNjW0VhxJvVmEeUdyzQx18=;
        b=OUrGsAmZjyORSjHnc6ln9tJSAWtb8pOgbeeciQTgAXuLYMB15TX3IDNrEba2hj+RYc
         j2j35qd/rdJcuCGutcdGx0BY/HJIILC3rZzuejc0ggr/1KdjwteGvI07BWFk5Acgza+N
         DfrhcM6c+s5Gc7LFmdQ2IQSXClZKjXQfLXzdJvWErmrsvS6+G7njTLrKy+8cKiVKr2BW
         Nm0Jg9x34BFZEBnc49/iBSkM2elFpWYl7o98u4/d0aK7zgx6ebPMMXHRjNbbP1K1YOO9
         vSK3vi5tnUrd1LS7tqyx+vGs076E4cUNGGrj2/ly5prL41ntWILRFu6iFpgnU9CFqeru
         CbAw==
X-Gm-Message-State: AGRZ1gKaLbX2szsVOAquHtklDuqZ1PeuAfm6pmky1Rd6Qo4vFox9Ns/C
        YMyPaA3E7qAC6v5MCiKVC5ZhcdM2JYnpwA==
X-Google-Smtp-Source: AJdET5ejy0emOGJ82xRaYQSmZZwU1H9DyAFZ/jyrFGzYsFTe2dAQeQZnNyTYiOhRmYxH0N68Bjetzw==
X-Received: by 2002:a17:902:f209:: with SMTP id gn9mr21096464plb.6.1541422311402;
        Mon, 05 Nov 2018 04:51:51 -0800 (PST)
Received: from localhost.localdomain.localdomain ([106.51.129.105])
        by smtp.gmail.com with ESMTPSA id 144-v6sm38860034pfu.129.2018.11.05.04.51.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Nov 2018 04:51:50 -0800 (PST)
From:   Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
To:     linux-pci@vger.kernel.org, bhelgaas@google.com,
        lorenzo.pieralisi@arm.com
Cc:     Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
Subject: [PATCH 1/1] PCI: mobiveil: fix multi function endpoint failures
Date:   Mon,  5 Nov 2018 07:51:40 -0500
Message-Id: <1541422301-29176-1-git-send-email-l.subrahmanya@mobiveil.co.in>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The fix enables mobiveil pcie controller to detect more than one
functions per device. Also increases the MSI interrupts.

Fixes: 1e913e58335f ("PCI: mobiveil: Add MSI support")
Fixes: 9af6bcb11e12 ("PCI: mobiveil: Add Mobiveil PCIe Host Bridge IP
driver")
Signed-off-by: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
---
 drivers/pci/controller/pcie-mobiveil.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pcie-mobiveil.c b/drivers/pci/controller/pcie-mobiveil.c
index 4d6c20e..113d56a 100644
--- a/drivers/pci/controller/pcie-mobiveil.c
+++ b/drivers/pci/controller/pcie-mobiveil.c
@@ -89,7 +89,7 @@
 #define PAB_INTX_START	5
 
 /* supported number of MSI interrupts */
-#define PCI_NUM_MSI	16
+#define PCI_NUM_MSI	256
 
 /* MSI registers */
 #define MSI_BASE_LO_OFFSET	0x04
@@ -172,7 +172,7 @@ static bool mobiveil_pcie_valid_device(struct pci_bus *bus, unsigned int devfn)
 	 * Do not read more than one device on the bus directly
 	 * attached to RC
 	 */
-	if ((bus->primary == pcie->root_bus_nr) && (devfn > 0))
+	if ((bus->number == pcie->root_bus_nr) && (devfn > 0))
 		return false;
 
 	return true;
-- 
1.8.3.1

