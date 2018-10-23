Return-Path: <SRS0=AklG=ND=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93B23C46475
	for <linux-pci@archiver.kernel.org>; Tue, 23 Oct 2018 10:21:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FE3520665
	for <linux-pci@archiver.kernel.org>; Tue, 23 Oct 2018 10:21:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="f5m32EOT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FE3520665
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728016AbeJWSoe (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 23 Oct 2018 14:44:34 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:41359 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728015AbeJWSoe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 23 Oct 2018 14:44:34 -0400
Received: by mail-pl1-f194.google.com with SMTP id p5-v6so400691plq.8
        for <linux-pci@vger.kernel.org>; Tue, 23 Oct 2018 03:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XSmVEIviJMjQM1OKrDTk07dUzJE9uaUtvcYab6n5jL0=;
        b=f5m32EOT/vCXExXgRUN1nIQnAtDdyyUquN528h4tSrEnX9XADX7crql2as+22vnBRp
         QSl1lhwAhiunwEt+aFwL6mn7dHB794n/sjFmSaDAt5XkA1hfTf7xtYUm/ZBZHLWSHYEQ
         31gzo8+rwen+Kdw8F2HlDEOAY9AHe7m57L3fo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XSmVEIviJMjQM1OKrDTk07dUzJE9uaUtvcYab6n5jL0=;
        b=LSIh6NJsENeJ0+Xib7jdGQn1qUtXE1B5sg9B88YNUFSSZrDGGVLbLrHGAhIyzoYG1q
         FkjSZItzhKCUCxOQ3QwkaoRTY6ve2XFShHrc5M0lvYqtnFkwkR+gT9UK15BrU3zGYyga
         p6+cehzg06J/m+hVrAq9AYdoaLLNDG8syTla/F4ieGPHZmy+OvBJIpt2FrZ8zIJWEZbo
         yVU4yEyqNuflPWoUB5YprFPQZDhTfyKfMFJs1uDVY2kOYeo911jqWs3sEt3b1xcBqG/n
         951mfTEz6Vb2atpAZ5OIYbAxoWIZl74Tcrtv7dBw0zo7tg83G8q0sDAXHU6UZyyrxJeG
         RWHw==
X-Gm-Message-State: ABuFfoj/vab+8ItYANkdXRNUav9CZIML6eNFyPXmlPjVGO5U8PeOQ66e
        XpHCZ1bs/Ce3Rrw83xMGVZ3L6Z78zyg=
X-Google-Smtp-Source: ACcGV62zEJBvgcdzSw4vGFXNygLkGw5PGBD4xs5lpDLsROd+kHW6NHLw9EQpbqyTMcT+UZXmMdBSCg==
X-Received: by 2002:a17:902:b58c:: with SMTP id a12-v6mr46713929pls.226.1540290107472;
        Tue, 23 Oct 2018 03:21:47 -0700 (PDT)
Received: from dhcp-10-123-74-106.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id m10-v6sm2918523pfg.180.2018.10.23.03.21.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Oct 2018 03:21:46 -0700 (PDT)
From:   Suganath Prabu <suganath-prabu.subramani@broadcom.com>
To:     helgaas@kernel.org, lukas@wunner.de, linux-scsi@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     benh@kernel.crashing.org, ruscur@russell.cc,
        sbobroff@linux.ibm.com, oohall@gmail.com,
        andy.shevchenko@gmail.com, Sathya.Prakash@broadcom.com,
        sreekanth.reddy@broadcom.com,
        Suganath Prabu <suganath-prabu.subramani@broadcom.com>
Subject: [v6 4/4] mpt3sas: Bump driver version to 27.100.00.00.
Date:   Tue, 23 Oct 2018 15:51:21 +0530
Message-Id: <1540290081-15827-5-git-send-email-suganath-prabu.subramani@broadcom.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1540290081-15827-1-git-send-email-suganath-prabu.subramani@broadcom.com>
References: <1540290081-15827-1-git-send-email-suganath-prabu.subramani@broadcom.com>
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

