Return-Path: <SRS0=XSei=MI=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C9AAC43382
	for <linux-pci@archiver.kernel.org>; Wed, 26 Sep 2018 04:23:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 043342086E
	for <linux-pci@archiver.kernel.org>; Wed, 26 Sep 2018 04:23:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="XVyjO5aq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 043342086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726544AbeIZKeT (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 26 Sep 2018 06:34:19 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:40134 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726467AbeIZKeT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 26 Sep 2018 06:34:19 -0400
Received: by mail-qt1-f196.google.com with SMTP id e9-v6so15498271qtp.7
        for <linux-pci@vger.kernel.org>; Tue, 25 Sep 2018 21:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LqRL8dNwARUvs/LP09w4PZ2Y7NLe5A6pIZX8pDBAg9I=;
        b=XVyjO5aqFxjEwqurKzk5kBrar+HuxBtb9Z/44eBoxeoiTwAOYQya0N1gfr4C5hSnX5
         gUyfLuC3HdHYpUUaGbrSJxokFI+vp5IsdnGmQwnryYm4QTHUozWCx8F1NvAmKqMABBFY
         /8C9vMclA1SccyNDl4RcIi8d0qgARq0DpjsH8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LqRL8dNwARUvs/LP09w4PZ2Y7NLe5A6pIZX8pDBAg9I=;
        b=Up0rpwIXP0WlZiUBqpASbkl3vgynle7DRFbSgd+SIYGwOeZUjYYVR3MLkZBPUaTdDX
         mV6XnwZOEenrniYz5VVpRO/Z9wxCiLOTnARiDqKi43kmmwXiHSYXpWjFgVLS6HisZea6
         qAqyynjWet6N/1s84CLxdn/Octuexmy65pIm9L0tsus/u5jMkYmJqvnLOIeV6i1tH5q+
         AUurBEGL1/Z2Drl5/u31YoIc9cvdfRU0GTWQObNCw0eV7FMZDD8SWnfheF0NCGoqwALH
         fndw00QBmODOzp9jytBjboRKo38fiRgxRJqAopNjSAmZ1k3TWTCrcTYfeST/jAr2nKm8
         MokA==
X-Gm-Message-State: ABuFfoiM3OQ4+zSiTOeE+qso6q6wuB4NV4emQhR9ve+RHOvdxEvXlnH7
        aFEVC+etfuubzmsUOWUshaUH2g==
X-Google-Smtp-Source: ACcGV60xUGZVJfbFIBcEIVULPhoedJixZ5VvHQuDnlQR6UZnMQ5faXrBG3agsv3C2wgOh1uZ1ukvuQ==
X-Received: by 2002:a0c:e9ce:: with SMTP id q14-v6mr3044310qvo.144.1537935802043;
        Tue, 25 Sep 2018 21:23:22 -0700 (PDT)
Received: from dhcp-10-123-74-106.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id a17-v6sm2375260qkb.62.2018.09.25.21.23.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Sep 2018 21:23:21 -0700 (PDT)
From:   Suganath Prabu S <suganath-prabu.subramani@broadcom.com>
To:     linux-scsi@vger.kernel.org, linux-pci@vger.kernel.org
Cc:     lukas@wunner.de, andy.shevchenko@gmail.com,
        Sathya.Prakash@broadcom.com, sreekanth.reddy@broadcom.com,
        Suganath Prabu S <suganath-prabu.subramani@broadcom.com>
Subject: [PATCH v4 5/6] mpt3sas: Fix driver modifying NVRAM/persistent data.
Date:   Wed, 26 Sep 2018 09:52:38 +0530
Message-Id: <1537935759-14754-6-git-send-email-suganath-prabu.subramani@broadcom.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1537935759-14754-1-git-send-email-suganath-prabu.subramani@broadcom.com>
References: <1537935759-14754-1-git-send-email-suganath-prabu.subramani@broadcom.com>
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
change only current copy of Manufacturing page11

Signed-off-by: Suganath Prabu S <suganath-prabu.subramani@broadcom.com>
---
 drivers/scsi/mpt3sas/mpt3sas_base.c   | 2 +-
 drivers/scsi/mpt3sas/mpt3sas_config.c | 4 ----
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/scsi/mpt3sas/mpt3sas_base.c b/drivers/scsi/mpt3sas/mpt3sas_base.c
index 9f1d8fb..a43579e 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_base.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_base.c
@@ -4122,7 +4122,7 @@ _base_static_config_pages(struct MPT3SAS_ADAPTER *ioc)
 	 * flag unset in NVDATA.
 	 */
 	mpt3sas_config_get_manufacturing_pg11(ioc, &mpi_reply, &ioc->manu_pg11);
-	if (ioc->manu_pg11.EEDPTagMode == 0) {
+	if ((!ioc->is_gen35_ioc) && (ioc->manu_pg11.EEDPTagMode == 0)) {
 		pr_err("%s: overriding NVDATA EEDPTagMode setting\n",
 		    ioc->name);
 		ioc->manu_pg11.EEDPTagMode &= ~0x3;
diff --git a/drivers/scsi/mpt3sas/mpt3sas_config.c b/drivers/scsi/mpt3sas/mpt3sas_config.c
index 5713a2d..f2a326a 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_config.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_config.c
@@ -676,10 +676,6 @@ mpt3sas_config_set_manufacturing_pg11(struct MPT3SAS_ADAPTER *ioc,
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

