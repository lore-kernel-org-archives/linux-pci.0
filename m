Return-Path: <SRS0=Zwnb=M5=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4036AC04EB9
	for <linux-pci@archiver.kernel.org>; Wed, 17 Oct 2018 05:59:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07E1D214DD
	for <linux-pci@archiver.kernel.org>; Wed, 17 Oct 2018 05:59:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="JRN0HLQ2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07E1D214DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727291AbeJQNxj (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 17 Oct 2018 09:53:39 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:37403 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727290AbeJQNxj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 17 Oct 2018 09:53:39 -0400
Received: by mail-yb1-f194.google.com with SMTP id h1-v6so9885444ybm.4
        for <linux-pci@vger.kernel.org>; Tue, 16 Oct 2018 22:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XSmVEIviJMjQM1OKrDTk07dUzJE9uaUtvcYab6n5jL0=;
        b=JRN0HLQ2vn0SUat03zxJ7LEOMaZ1o2IUV0PZ3POwkg1puCSUn1STS/dP4O0h9iT0al
         xm06OrNd9efjrpibs53nDk81u5PjwbFj+V5UxgbB4F//ToCcyVcJP9tVkx0T1zsN7Uq0
         kx/vuBx5Glzpvi/YFJxWaKMhm89sQHjOgP05c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XSmVEIviJMjQM1OKrDTk07dUzJE9uaUtvcYab6n5jL0=;
        b=d/FV+qa5/YdHvaVFqAuHJDoioKz+RITxQNRfMdHpnUlWsqI1ISJSp8JPhVJxWhXClW
         mW1PyQuM+CCqtlGdKO+I/A2IPJ0M+edKAEspjpM6BlYzpBvQQJDZTWzzk0gqc5C/vLeF
         PtKLJU9eTvgCeAdUlcKcXxYfAueiCjAOryUDUdBhY/YIdtP36A4SMAGntLUOc7GZis6x
         hpWuF44mllYGy5pW95bkjB7u9u64AvE7XkR9v7VxIiNMbKLosQJNjxDxqD8w2Rj3CB3r
         2aAcjxhvZcs5zYdNTw+46en61+uXIhrY9NiHLEd57IIsCpwqfvw3/yZxTL99wFa+fnm7
         nnbA==
X-Gm-Message-State: ABuFfogx3irJISfqwbEbgYqI96N6kOKnenqsMmNYcfw7/xZ/zzHO51GR
        /N2/7vM54D1qFBJag3+xHOlPsw==
X-Google-Smtp-Source: ACcGV63OCJpSLFBipP9Z/gMPd36/6Y5p0OcLRVhm5eI5gbif55wIPsFLT8T8wMvv2fdQd1yL8kYMPQ==
X-Received: by 2002:a25:5d12:: with SMTP id r18-v6mr13443353ybb.480.1539755980154;
        Tue, 16 Oct 2018 22:59:40 -0700 (PDT)
Received: from dhcp-10-123-74-106.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id y1-v6sm3930329ywf.34.2018.10.16.22.59.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Oct 2018 22:59:39 -0700 (PDT)
From:   Suganath Prabu <suganath-prabu.subramani@broadcom.com>
To:     helgaas@kernel.org, lukas@wunner.de, linux-scsi@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     benh@kernel.crashing.org, ruscur@russell.cc,
        sbobroff@linux.ibm.com, oohall@gmail.com,
        andy.shevchenko@gmail.com, Sathya.Prakash@broadcom.com,
        sreekanth.reddy@broadcom.com,
        Suganath Prabu <suganath-prabu.subramani@broadcom.com>
Subject: [v5 4/4] mpt3sas: Bump driver version to 27.100.00.00.
Date:   Wed, 17 Oct 2018 11:29:07 +0530
Message-Id: <1539755947-27014-5-git-send-email-suganath-prabu.subramani@broadcom.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1539755947-27014-1-git-send-email-suganath-prabu.subramani@broadcom.com>
References: <1539755947-27014-1-git-send-email-suganath-prabu.subramani@broadcom.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Modify driver version to 27.100.00.00
(which is equivalent to PH8 OOB driver)

Signed-off-by: Suganath Prabu <suganath-prabu.subramani@broadcom.com>
---
 drivers/scsi/mpt3sas/mpt3sas_base.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/mpt3sas/mpt3sas_base.h b/drivers/scsi/mpt3sas/mpt3sas_base.h
index c860ed2..7fdaf29 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_base.h
+++ b/drivers/scsi/mpt3sas/mpt3sas_base.h
@@ -74,8 +74,8 @@
 #define MPT3SAS_DRIVER_NAME		"mpt3sas"
 #define MPT3SAS_AUTHOR "Avago Technologies <MPT-FusionLinux.pdl@avagotech.com>"
 #define MPT3SAS_DESCRIPTION	"LSI MPT Fusion SAS 3.0 Device Driver"
-#define MPT3SAS_DRIVER_VERSION		"26.100.00.00"
-#define MPT3SAS_MAJOR_VERSION		26
+#define MPT3SAS_DRIVER_VERSION		"27.100.00.00"
+#define MPT3SAS_MAJOR_VERSION		27
 #define MPT3SAS_MINOR_VERSION		100
 #define MPT3SAS_BUILD_VERSION		0
 #define MPT3SAS_RELEASE_VERSION	00
-- 
1.8.3.1

