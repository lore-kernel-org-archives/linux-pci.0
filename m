Return-Path: <SRS0=yUVM=RE=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 208CFC4360F
	for <linux-pci@archiver.kernel.org>; Fri,  1 Mar 2019 04:52:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E439B2186A
	for <linux-pci@archiver.kernel.org>; Fri,  1 Mar 2019 04:52:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="G6PD7dlE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728753AbfCAEwp (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 28 Feb 2019 23:52:45 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:46327 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725978AbfCAEwo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 28 Feb 2019 23:52:44 -0500
Received: by mail-ed1-f68.google.com with SMTP id f2so18890093edy.13
        for <linux-pci@vger.kernel.org>; Thu, 28 Feb 2019 20:52:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7tYFx901gn1waLlfB6tmaVr0S+UtiRa0DyleMsc717E=;
        b=G6PD7dlEdElqWbrqJz/5H9lMbqshBNZm7gCrNMqUSikMN+GDUg8A91EUvhY0gT83VA
         dSo903xiFP3qd3HieStQrWGOxfgU1JdbJ9vV/rTV2d1wVLrb4kLFoa4yuIFJLWR9+EtL
         3Gq6csGGh00TKEc2PxxB6yREt9UuJaBaNh2yc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7tYFx901gn1waLlfB6tmaVr0S+UtiRa0DyleMsc717E=;
        b=oqXcnT6UupzbZevqjDqxieESEGQaBz76z2yJ9kfLRMTsvLrxf3a2hl59MM1iQ0RD/Z
         UWUPpBvkn1JlNtbt1fr0qPmmNq6OH2GGS6PzuTRpKVvmybNzw8MM4aZBVXK7akgfCYPP
         +25OzJLDPjqm8rccBP2Kn1fxeZAD82XqjUtkp8thQrYyZZ7Tp8GDiv0jlJFeStn/wJsa
         aOMpWRGQYY7wOrVGvXM+XT+LM54vaQAgOKeEiPB63RgOn6bnYe/etGMfWcxj4GLv+5GB
         2OhlaQS1q1mZC0cWqIuQD/XqwVU2XF668B6qB5knFop2JHNTPywq9f8JzVPW60e6h8Xr
         waKg==
X-Gm-Message-State: APjAAAXyisDgVRcyrcuhQwR8mT4eG/yS2ZiWyOnAUtesrT9nHXZVesh/
        zI4yalvwM9gtgCmlhQ0wHGNMrw==
X-Google-Smtp-Source: APXvYqxatr8K6ES0jlSld7/LuUdqsZHiAJMtTFnWtVVFu9E9OM+WS5m9Ym//dtAPJ2e5SCrVnuDvrA==
X-Received: by 2002:a17:906:1182:: with SMTP id n2mr1606542eja.35.1551415962656;
        Thu, 28 Feb 2019 20:52:42 -0800 (PST)
Received: from mannams-OptiPlex-7010.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id s24sm4300931edd.23.2019.02.28.20.52.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 28 Feb 2019 20:52:42 -0800 (PST)
From:   Srinath Mannam <srinath.mannam@broadcom.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>
Cc:     bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Srinath Mannam <srinath.mannam@broadcom.com>,
        Abhishek Shah <abhishek.shah@broadcom.com>,
        Ray Jui <ray.jui@broadcom.com>
Subject: [PATCH v4 2/2] PCI: iproc: Add outbound configuration for 32-bit I/O region
Date:   Fri,  1 Mar 2019 10:22:16 +0530
Message-Id: <1551415936-30174-3-git-send-email-srinath.mannam@broadcom.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1551415936-30174-1-git-send-email-srinath.mannam@broadcom.com>
References: <1551415936-30174-1-git-send-email-srinath.mannam@broadcom.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In the present driver outbound window configuration is done to map above
32-bit address I/O regions with corresponding PCI memory range given in
ranges DT property.

This patch add outbound window configuration to map below 32-bit I/O range
with corresponding PCI memory, which helps to access I/O region in ARM
32-bit and one to one mapping of I/O region to PCI memory.

Ex:
1. ranges DT property given for current driver is,
    ranges = <0x83000000 0x0 0x40000000 0x4 0x00000000 0 0x40000000>;
    I/O region address is 0x400000000
2. ranges DT property can be given after this patch,
    ranges = <0x83000000 0x0 0x42000000 0x0 0x42000000 0 0x2000000>;
    I/O region address is 0x42000000

Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
Signed-off-by: Abhishek Shah <abhishek.shah@broadcom.com>
Signed-off-by: Ray Jui <ray.jui@broadcom.com>
---
 drivers/pci/controller/pcie-iproc.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pcie-iproc.c b/drivers/pci/controller/pcie-iproc.c
index b882255..080f142 100644
--- a/drivers/pci/controller/pcie-iproc.c
+++ b/drivers/pci/controller/pcie-iproc.c
@@ -955,8 +955,25 @@ static int iproc_pcie_setup_ob(struct iproc_pcie *pcie, u64 axi_addr,
 			resource_size_t window_size =
 				ob_map->window_sizes[size_idx] * SZ_1M;
 
-			if (size < window_size)
-				continue;
+			/*
+			 * Keep iterating until we reach the last window and
+			 * with the minimal window size at index zero. In this
+			 * case, we take a compromise by mapping it using the
+			 * minimum window size that can be supported
+			 */
+			if (size < window_size) {
+				if (size_idx > 0 || window_idx > 0)
+					continue;
+
+				/*
+				 * For the corner case of reaching the minimal
+				 * window size that can be supported on the
+				 * last window
+				 */
+				axi_addr = ALIGN_DOWN(axi_addr, window_size);
+				pci_addr = ALIGN_DOWN(pci_addr, window_size);
+				size = window_size;
+			}
 
 			if (!IS_ALIGNED(axi_addr, window_size) ||
 			    !IS_ALIGNED(pci_addr, window_size)) {
-- 
2.7.4

