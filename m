Return-Path: <SRS0=bOp+=MB=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C818BECE564
	for <linux-pci@archiver.kernel.org>; Wed, 19 Sep 2018 18:55:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8276121523
	for <linux-pci@archiver.kernel.org>; Wed, 19 Sep 2018 18:55:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sRwIl45N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8276121523
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387583AbeITAeo (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 19 Sep 2018 20:34:44 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40739 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387586AbeITAen (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 Sep 2018 20:34:43 -0400
Received: by mail-wm1-f67.google.com with SMTP id 207-v6so8118973wme.5;
        Wed, 19 Sep 2018 11:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=j2iPDhDe4iOXAw3mn4RE+Jg+ftaFRwYf7U24CRFhk5A=;
        b=sRwIl45NFJ60cVaarp5Dle10v/aHKve7PLxjSVDBVRMXwEaNTB/nxCfj2jdJZGUl4g
         kfJahCJjCcqMafBCp1uP+agEIkqkFsCjI6ttO1MgbocMkADPqLFCK7bCneylLRwy68XY
         974a2dSyX/74M7qvl8+8K3PtqrznvRCf2Wfs9j8yJWXeUWkDU7gmH+e4V7IX0050FqrZ
         16KWiF5xRxrUfc9w8+C7FG1yh0p+PqUeUnvVjYBz0Sj/8AYDjfIYLhhCU857mKcYcVb1
         zrQdY+qq4zrGF2FUWmQmOgeazX/GyAeLCZJE2oKardA7+CK4VTJR1IvHU0yt7lxaj+w6
         F3UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=j2iPDhDe4iOXAw3mn4RE+Jg+ftaFRwYf7U24CRFhk5A=;
        b=rQOLnW2ZShQQjPIsJtEaIIgA7UvS/CvPgKzFgVz9oLzx7MC0ZMAB4vyC+3qSwrkfki
         vWv/nStZGYA97dj1SDCtzSGT0BO+URRI1jmNfdCxEc1T8IHt9XqO0DD1TDXLPibvp+/t
         bLzpAPHG/c78MPjCrp1XBGuTR9tEDvnMjbqLl8WCc1jc9hqiTdZHlvybh0z7rFAK+Qn2
         0a6TNyIp8/Gj4kmO4VK9dEdFgPtqe2xTCxXo/UOqqY/nVDEHvmM1zRabuonHHMqsnAUi
         EOkJepsQ53gcs/8hFDrlh6fubpObmjQL18kYfyhnKQ7hrmEKDoNEPIQT/ft9iMINqdzk
         fIvw==
X-Gm-Message-State: APzg51DJKdkLyiC4XHBcF8dtb7T57RaBTMZhw0xwUmlZD2cX6Qf6o3LH
        bUpBayaJH5Lw/vD8NOQ/dAQ=
X-Google-Smtp-Source: ANB0VdZkG2oSxYr6TGxQCSGEt8TrGKAqwLsWAhQBgh2oDN5i8W5euc/UzkJfSNmf0PQqw/M/cfjx4A==
X-Received: by 2002:a1c:3743:: with SMTP id e64-v6mr20013895wma.63.1537383326922;
        Wed, 19 Sep 2018 11:55:26 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id y206-v6sm7727359wmg.14.2018.09.19.11.55.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Sep 2018 11:55:26 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Xiaowei Song <songxiaowei@hisilicon.com>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH v2] PCI: kirin: Fix section mismatch warning
Date:   Wed, 19 Sep 2018 11:53:42 -0700
Message-Id: <20180919185341.31298-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org
Message-ID: <20180919185342.rCFztzuD0zxkWnQmWQDLl9j1C7oFjSzsFljVHFER7BQ@z>

WARNING: vmlinux.o(.text+0x4758cc): Section mismatch in reference from
the function kirin_pcie_probe() to the function
.init.text:kirin_add_pcie_port()
The function kirin_pcie_probe() references
the function __init kirin_add_pcie_port().
This is often because kirin_pcie_probe lacks a __init
annotation or the annotation of kirin_add_pcie_port is wrong.

Add the __init annotation to both kirin_pcie_probe and
kirin_pcie_add_msi then use builtin_platform_driver_probe
instead of builtin_platform_driver + .probe to avoid a section
mismatch warning with kirin_pcie_driver.

Fixes: fc5165db245a ("PCI: kirin: Add HiSilicon Kirin SoC PCIe controller driver")
Reported-by: Nick Desaulniers <ndesaulniers@google.com>
Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---

v1 -> v2:

Instead of removing the annotation on kirin_add_pcie_port, add it to
kirin_pcie_add_msi and kirin_pcie_probe. To avoid a warning with this
configuration, use builtin_platform_driver_probe.

 drivers/pci/controller/dwc/pcie-kirin.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-kirin.c b/drivers/pci/controller/dwc/pcie-kirin.c
index 5352e0c3be82..f64fed12de51 100644
--- a/drivers/pci/controller/dwc/pcie-kirin.c
+++ b/drivers/pci/controller/dwc/pcie-kirin.c
@@ -448,8 +448,8 @@ static const struct dw_pcie_host_ops kirin_pcie_host_ops = {
 	.host_init = kirin_pcie_host_init,
 };
 
-static int kirin_pcie_add_msi(struct dw_pcie *pci,
-				struct platform_device *pdev)
+static int __init kirin_pcie_add_msi(struct dw_pcie *pci,
+				     struct platform_device *pdev)
 {
 	int irq;
 
@@ -481,7 +481,7 @@ static int __init kirin_add_pcie_port(struct dw_pcie *pci,
 	return dw_pcie_host_init(&pci->pp);
 }
 
-static int kirin_pcie_probe(struct platform_device *pdev)
+static int __init kirin_pcie_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct kirin_pcie *kirin_pcie;
@@ -533,11 +533,10 @@ static const struct of_device_id kirin_pcie_match[] = {
 };
 
 static struct platform_driver kirin_pcie_driver = {
-	.probe			= kirin_pcie_probe,
 	.driver			= {
 		.name			= "kirin-pcie",
 		.of_match_table = kirin_pcie_match,
 		.suppress_bind_attrs = true,
 	},
 };
-builtin_platform_driver(kirin_pcie_driver);
+builtin_platform_driver_probe(kirin_pcie_driver, kirin_pcie_probe);
-- 
2.19.0

