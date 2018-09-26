Return-Path: <SRS0=XSei=MI=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03080C43382
	for <linux-pci@archiver.kernel.org>; Wed, 26 Sep 2018 04:23:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B21022086E
	for <linux-pci@archiver.kernel.org>; Wed, 26 Sep 2018 04:23:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="LH0q+b0L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B21022086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbeIZKeX (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 26 Sep 2018 06:34:23 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:37075 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726520AbeIZKeX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 26 Sep 2018 06:34:23 -0400
Received: by mail-qt1-f194.google.com with SMTP id n6-v6so15878765qtl.4
        for <linux-pci@vger.kernel.org>; Tue, 25 Sep 2018 21:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=r8rw6gqDYpHlvoJp0P0z8qjG62+8NnbzxaNMbNQa04I=;
        b=LH0q+b0LxzO8p/JpXxnXAvi7iRXZxVd/kbvWZfcEJ95h/grluZQXl3OG49FKDU19ad
         EuKAKS+HkBKMYs4cPNIRFKN6QxlOWTzb+yF3FduPO06o/y8SheWa0tSGEXxgAT+/ucm4
         Tl8QNJ+9L7jBD7ISI3f8LMN/u2G2hV4UqMyKs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=r8rw6gqDYpHlvoJp0P0z8qjG62+8NnbzxaNMbNQa04I=;
        b=KsiJEjgaIayWWkDpsIGFEnGHBjCW0vVB4epaAsjxBbs0T3TPLEPSS+taNqKo9xXpvI
         U2OQNglEvfaaIuQkhLxcySIyPcJMgSVCu6/Em5cQh4giVi8CN1qWyEurl/a/r5o2dgdV
         lMuP8OY+JPxqa3ntj4nn2qXxX6xKpFv9ykXF9zdLKCbqhnbOPTkIoqA6mxKCr4WTq3cX
         TqzFfjugPPuhu40KYzO0gkek2ZLHGjPrXstIhUrL0lCxEJoYZxoQgZ/pZoPrVOzLT2Hv
         sQU7hz1R0+ES0wMeiJjzDONKz6nTShvtfFe1Cb2Yv/d7NoCQ55To8l7/DMkluqGFEU5s
         HaOQ==
X-Gm-Message-State: ABuFfogS9k7QYeq7K3HKYFJ55TDRuJM7koW478ynho3xDo8F/MikLoMk
        xKlYNnYMgaQOado3Y3sYOmTsDw==
X-Google-Smtp-Source: ACcGV63wh/BH7n546fp45YSbMyQNpP0SfbX7HRbneptztj4MQ0PjjoSsU1cUEsMe6oFFoh84CqCr5w==
X-Received: by 2002:ac8:2bc3:: with SMTP id n3-v6mr3291339qtn.152.1537935806122;
        Tue, 25 Sep 2018 21:23:26 -0700 (PDT)
Received: from dhcp-10-123-74-106.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id a17-v6sm2375260qkb.62.2018.09.25.21.23.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Sep 2018 21:23:25 -0700 (PDT)
From:   Suganath Prabu S <suganath-prabu.subramani@broadcom.com>
To:     linux-scsi@vger.kernel.org, linux-pci@vger.kernel.org
Cc:     lukas@wunner.de, andy.shevchenko@gmail.com,
        Sathya.Prakash@broadcom.com, sreekanth.reddy@broadcom.com,
        Suganath Prabu S <suganath-prabu.subramani@broadcom.com>
Subject: [PATCH v4 6/6] mpt3sas: Bump driver version to 27.100.00.00.
Date:   Wed, 26 Sep 2018 09:52:39 +0530
Message-Id: <1537935759-14754-7-git-send-email-suganath-prabu.subramani@broadcom.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1537935759-14754-1-git-send-email-suganath-prabu.subramani@broadcom.com>
References: <1537935759-14754-1-git-send-email-suganath-prabu.subramani@broadcom.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Modify driver version to 27.100.00.00
(which is equivalent to PH8 OOB driver)

Signed-off-by: Suganath Prabu S <suganath-prabu.subramani@broadcom.com>
---
 drivers/scsi/mpt3sas/mpt3sas_base.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/mpt3sas/mpt3sas_base.h b/drivers/scsi/mpt3sas/mpt3sas_base.h
index f0351a2..b880d79 100644
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

