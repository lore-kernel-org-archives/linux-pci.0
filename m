Return-Path: <SRS0=6A7A=Q3=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB72AC43381
	for <linux-pci@archiver.kernel.org>; Wed, 20 Feb 2019 16:34:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BA472147C
	for <linux-pci@archiver.kernel.org>; Wed, 20 Feb 2019 16:34:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="X3XX+67r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726904AbfBTQeQ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 20 Feb 2019 11:34:16 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44361 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726352AbfBTQeP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 Feb 2019 11:34:15 -0500
Received: by mail-pg1-f193.google.com with SMTP id y1so12104772pgk.11
        for <linux-pci@vger.kernel.org>; Wed, 20 Feb 2019 08:34:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bJTqQVyPqTRoZmzEJxDokZKH2fjNCLF3wrzuRLWaY7o=;
        b=X3XX+67reBKkrMvXlNfWVFEU+fnIh7nMlqCJx3q+OCq+BwKowbHjaL3mPaFV5NP3bg
         DMu9VViwbDfzjm0K9RyV8zhs2vzVHgPodYEG4L+14ss9ZE1bm+Hj5h3pZxBeLx4GwuKN
         xaqTKHoXLOaCrUjYAeeENs32xVXdYhLRhubt4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bJTqQVyPqTRoZmzEJxDokZKH2fjNCLF3wrzuRLWaY7o=;
        b=MLT+AgKyYu+NEBzhclMqHUwHN3VtkajPWM16pqfSIGgDq05EeC1BtjiLetYl/IJTr3
         q8fQzNpqB2vxMUgiqKQ2H04PovqBgvVco6HPHORklzUX7WNY/yYsVh/vH+YXWF8Mp+W2
         uSYnHdErKLzJY19J4abyv3AdZYWme0K0rXaiUexHH1wCC4mgZbz+qom48q2Q1RMp7Yhn
         9nIMiuzPFMIkCOQ0FRQ5UMy8bwqI0yNapAKqrXWA8caeCVXem56KfHzj4aWDqm9Vwqoj
         kgEsoEpFGWqq/rLc6zK8yFIYEUvRbW/b7pJUFxxyOStltnq9wjW+AI/h0lZkHQ2WMErz
         ijBA==
X-Gm-Message-State: AHQUAubJ3UnKV3xcEFCpuNeoqODoakRYHGWiCPOJ6lJGnf/eVblR8Q09
        aCOhJvQlNkhBZhNl3EXywx8R3g==
X-Google-Smtp-Source: AHgI3IbWdOKn2kPVyPQZugoB9bJ8zsTbbKF6MSd1O++9KKKnaBS5MqwvPTgfHSG4QW1d4pK61uQzPQ==
X-Received: by 2002:a62:76d4:: with SMTP id r203mr36036679pfc.15.1550680454764;
        Wed, 20 Feb 2019 08:34:14 -0800 (PST)
Received: from mannams-OptiPlex-7010.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id t10sm26556717pfa.151.2019.02.20.08.34.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 20 Feb 2019 08:34:14 -0800 (PST)
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
Subject: [PATCH v3 2/2] PCI: iproc: Add outbound configuration for 32-bit I/O region
Date:   Wed, 20 Feb 2019 22:03:55 +0530
Message-Id: <1550680435-9706-3-git-send-email-srinath.mannam@broadcom.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1550680435-9706-1-git-send-email-srinath.mannam@broadcom.com>
References: <1550680435-9706-1-git-send-email-srinath.mannam@broadcom.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In the present driver outbound window configuration is done to map above
32-bit address I/O regions with corresponding PCI memory range given in
ranges DT property.

This patch add outbound window configuration to map below 32-bit I/O range
with corresponding PCI memory, which helps to access I/O region in IA32
and one to one mapping of I/O region to PCI memory.

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
Reviewed-by: Scott Branden <scott.branden@broadcom.com>
Reviewed-by: Vikram Prakash <vikram.prakash@broadcom.com>
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

