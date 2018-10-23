Return-Path: <SRS0=AklG=ND=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FAE3C46475
	for <linux-pci@archiver.kernel.org>; Tue, 23 Oct 2018 10:21:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37F2D2080A
	for <linux-pci@archiver.kernel.org>; Tue, 23 Oct 2018 10:21:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="d9Inlnvy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37F2D2080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727978AbeJWSoa (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 23 Oct 2018 14:44:30 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34796 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727844AbeJWSoa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 23 Oct 2018 14:44:30 -0400
Received: by mail-pf1-f194.google.com with SMTP id f78-v6so443350pfe.1
        for <linux-pci@vger.kernel.org>; Tue, 23 Oct 2018 03:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Ttv6KF4v6krmUYAxrGmgeNChrc5bO214oYIMPjiRLic=;
        b=d9InlnvyB60YQyBIgv+jJWtFn2Fre7g3NyNZij5Y7UMbqeykO5I1C/YGChZyujoRc2
         zT2xqG4ug0iUop3SnBASnURW230FavWiDMP8Ch5G7YaYLbCECB2bBergb4q2QzpiqVSV
         2n4wkPp4hk40xTzMTcWIaxxm0F0UtQbpL0sZ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Ttv6KF4v6krmUYAxrGmgeNChrc5bO214oYIMPjiRLic=;
        b=GwF0dz1p9d9/P/S86oMoe4kqs2Yv7PvUIitQVS4h6VIuUTDDCPxbKOeP/vIH2Ub5PX
         Q7mtnwOQb5oBbN5sUnKtHTEkaDvvmHpJ0J5NgHTgRwJwV8QHfDZwD0Jx+CveeQjoDaoJ
         qfq2v+Dim67OLzRhOixYz1gnVl9WLd8Ux5FeVUIOWaZ/GxGaKHh+JfzC8QSFKJoD6A6U
         lTukS7XHmwjGriZCyv2tWamTHN1SDnG9OROZ8kXmvCKoKoHOJfvQ2wtGVNLLUtamRQOS
         p1Q9AeNsT8K4ggdBNOTEIqsVjwUZnKSuJ0XCpTMzIYfN0ZvWinMFt/6QDfqq8nepwyi5
         jseA==
X-Gm-Message-State: ABuFfoiChYLk85VFwmAWhIS9LqbTlEGmBm7EU7Am+ZZcboG/92Uf0Z7p
        QEspHbYmXEHrsunwLcDLjPUXHw==
X-Google-Smtp-Source: ACcGV61hYY/NJnLjzC6l9tQG/UGcgzzw+IG79yX/y2y35Mxgsve3yyBNpFOk3W5KXofn0kSOvtzrMw==
X-Received: by 2002:a63:1555:: with SMTP id 21-v6mr45815058pgv.383.1540290103670;
        Tue, 23 Oct 2018 03:21:43 -0700 (PDT)
Received: from dhcp-10-123-74-106.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id m10-v6sm2918523pfg.180.2018.10.23.03.21.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Oct 2018 03:21:43 -0700 (PDT)
From:   Suganath Prabu <suganath-prabu.subramani@broadcom.com>
To:     helgaas@kernel.org, lukas@wunner.de, linux-scsi@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     benh@kernel.crashing.org, ruscur@russell.cc,
        sbobroff@linux.ibm.com, oohall@gmail.com,
        andy.shevchenko@gmail.com, Sathya.Prakash@broadcom.com,
        sreekanth.reddy@broadcom.com,
        Suganath Prabu <suganath-prabu.subramani@broadcom.com>
Subject: [v6 3/4] mpt3sas:Fix driver modifying persistent data.
Date:   Tue, 23 Oct 2018 15:51:20 +0530
Message-Id: <1540290081-15827-4-git-send-email-suganath-prabu.subramani@broadcom.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1540290081-15827-1-git-send-email-suganath-prabu.subramani@broadcom.com>
References: <1540290081-15827-1-git-send-email-suganath-prabu.subramani@broadcom.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

* If EEDPTagMode field in manufacturing page11 is set,
unset it. This is needed to fix a hardware bug
in SAS3/SAS2 cards, So, skipping EEDPTagMode changes
in Manufacturing page11 for SAS35 controllers.

* Fix driver modifying NVRAM/persistent data in
Manufacturing page11 along with current copy. Driver should
change only current copy of Manufacturing page11.

Signed-off-by: Suganath Prabu <suganath-prabu.subramani@broadcom.com>
---
 drivers/scsi/mpt3sas/mpt3sas_base.c   | 2 +-
 drivers/scsi/mpt3sas/mpt3sas_config.c | 4 ----
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/scsi/mpt3sas/mpt3sas_base.c b/drivers/scsi/mpt3sas/mpt3sas_base.c
index 243bf32..2237681 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_base.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_base.c
@@ -4062,7 +4062,7 @@ _base_static_config_pages(struct MPT3SAS_ADAPTER *ioc)
 	 * flag unset in NVDATA.
 	 */
 	mpt3sas_config_get_manufacturing_pg11(ioc, &mpi_reply, &ioc->manu_pg11);
-	if (ioc->manu_pg11.EEDPTagMode == 0) {
+	if (!ioc->is_gen35_ioc && ioc->manu_pg11.EEDPTagMode == 0) {
 		pr_err("%s: overriding NVDATA EEDPTagMode setting\n",
 		    ioc->name);
 		ioc->manu_pg11.EEDPTagMode &= ~0x3;
diff --git a/drivers/scsi/mpt3sas/mpt3sas_config.c b/drivers/scsi/mpt3sas/mpt3sas_config.c
index 88062d1..fe3da1c 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_config.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_config.c
@@ -659,10 +659,6 @@ mpt3sas_config_set_manufacturing_pg11(struct MPT3SAS_ADAPTER *ioc,
 	r = _config_request(ioc, &mpi_request, mpi_reply,
 	    MPT3_CONFIG_PAGE_DEFAULT_TIMEOUT, config_page,
 	    sizeof(*config_page));
-	mpi_request.Action = MPI2_CONFIG_ACTION_PAGE_WRITE_NVRAM;
-	r = _config_request(ioc, &mpi_request, mpi_reply,
-	    MPT3_CONFIG_PAGE_DEFAULT_TIMEOUT, config_page,
-	    sizeof(*config_page));
  out:
 	return r;
 }
-- 
1.8.3.1

