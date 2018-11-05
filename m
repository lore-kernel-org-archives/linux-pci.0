Return-Path: <SRS0=Hm5h=NQ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5A2EC46475
	for <linux-pci@archiver.kernel.org>; Mon,  5 Nov 2018 12:52:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D77120819
	for <linux-pci@archiver.kernel.org>; Mon,  5 Nov 2018 12:52:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mobiveil.co.in header.i=@mobiveil.co.in header.b="QHbZ0NXW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D77120819
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mobiveil.co.in
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729675AbeKEWLf (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 5 Nov 2018 17:11:35 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39887 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729015AbeKEWLf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 5 Nov 2018 17:11:35 -0500
Received: by mail-pf1-f195.google.com with SMTP id n11-v6so4397503pfb.6
        for <linux-pci@vger.kernel.org>; Mon, 05 Nov 2018 04:51:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mobiveil.co.in; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=61IM1BpJF7hP0Xm3lMelzTNjW0VhxJvVmEeUdyzQx18=;
        b=QHbZ0NXW6P1YS3eywB0Q3GSydPqxjWbv9NbWj5guAz1Vup8DXtm1ls6qM5muhr2e+F
         H7jXLrx08ju9iZbN6LR+DuOXkBP6Q3b2WaC6SoO/Nt7x0N9AzAx1F32EEldCgCb0/JzL
         ObpSBrO/wG/Ajh9I+mojaIc1YYZ0pgMzQ17wA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=61IM1BpJF7hP0Xm3lMelzTNjW0VhxJvVmEeUdyzQx18=;
        b=sKeApsMeze4/p7ckrPCkwBY9mGI25Moj+gO+0B/V09Ap+hmA5WxsonYlnhFpTGZZtM
         vpTmQEFBKCemR8Az5xyuKA0E+pMy0/hGWk/P61kWyJ9z7jdswqLSbyNxNAA6LVRzk2vt
         eshQ3Sjhr+AHmJBE2F0pMob8DHjTbqfcFzt7EZ9fj67ITwiLhKWU+GVPgA3hYMJW3LMo
         KQlKBUm3pPlTC9Y4J6nk64h8950RXHuwWDROjW6QbdD+zjfGmALrKra2zAM5hNxcXeyB
         kyhyyQ5i4qlBlZMvn4pXau3GuBDii3ikwA4EqCX0ygOT+sPudRFWC8x+CSQ3Vzf9qhfe
         VYNQ==
X-Gm-Message-State: AGRZ1gL8yt+S9IhYmpnYNEB1xKAZ/rQInvgVNED2mWpwWVZfBZ2BWmu7
        FUq+0N8uuOQgZhhaqVAmv/vYaP1L9bijfw==
X-Google-Smtp-Source: AJdET5dNKl7PNL1S5y0IhC5m0Q7694Pv8Mpf7fQpfqhcG4Dt4IDg8lmjOS9M7YaZ4q+yGrcHcBsqnA==
X-Received: by 2002:a62:da54:: with SMTP id w20-v6mr7570318pfl.106.1541422318386;
        Mon, 05 Nov 2018 04:51:58 -0800 (PST)
Received: from localhost.localdomain.localdomain ([106.51.129.105])
        by smtp.gmail.com with ESMTPSA id 144-v6sm38860034pfu.129.2018.11.05.04.51.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Nov 2018 04:51:57 -0800 (PST)
From:   Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
To:     linux-pci@vger.kernel.org, bhelgaas@google.com,
        lorenzo.pieralisi@arm.com
Cc:     Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
Subject: [PATCH v2] PCI: mobiveil: fix multi function endpoint failures
Date:   Mon,  5 Nov 2018 07:51:41 -0500
Message-Id: <1541422301-29176-2-git-send-email-l.subrahmanya@mobiveil.co.in>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1541422301-29176-1-git-send-email-l.subrahmanya@mobiveil.co.in>
References: <1541422301-29176-1-git-send-email-l.subrahmanya@mobiveil.co.in>
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

