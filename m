Return-Path: <SRS0=Zwnb=M5=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33E3DC5ACCD
	for <linux-pci@archiver.kernel.org>; Wed, 17 Oct 2018 05:59:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9DFF214C4
	for <linux-pci@archiver.kernel.org>; Wed, 17 Oct 2018 05:59:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="C5hM8wTQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9DFF214C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727270AbeJQNxf (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 17 Oct 2018 09:53:35 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:42735 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727262AbeJQNxe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 17 Oct 2018 09:53:34 -0400
Received: by mail-yb1-f193.google.com with SMTP id p74-v6so9869229ybc.9
        for <linux-pci@vger.kernel.org>; Tue, 16 Oct 2018 22:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PkfXlMZupblJe1vzCW6LkLbmNH7XcD5/rnzvalEdrPs=;
        b=C5hM8wTQfQ0iKNgAEtDRnTrUUgXgugDdBnjLKV5JC6viEbW1SfMbVzS9faAT+T2RhY
         TRXNTo7TiNHDgbFQ8UAvVrJkJVTzXOJ36bkk0u0iQU2P7BPjRaEK5oKp31NXY8GL1HWy
         o5nzH6OLMyYJg1cqHp7yIjslMrxPxwrIcFDH0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PkfXlMZupblJe1vzCW6LkLbmNH7XcD5/rnzvalEdrPs=;
        b=H0vgdltHU7BkggmxDFXQ/vD0t6WSlkWa9BmkApvB8e0aoUFrzI4eW5IrgfHzsuI8/J
         zz8Ca9XT+Q4Xh1VDeu4EXZN8MVROY6mA4yK1qF0yyFpJO41v07uk9le5IWmM5SOvmTGB
         2UkH9+XwLAV42eg0H5gUxWSj9CZTCBNsxsMpvUY8g+ITBOuokLiTPjERegJtNxX9pEES
         pSmjHd+KJoQ7M9lZTi4zuUnsetoVrRjxOyaR8utMmIx+eoiPd0ZrsuwmxTS1hIUwwCOW
         0V7fBmUpVnW2vbzQdFmhd1qsaMhPXWibWHWpO9hF7ltU6h56WzmTdSt5W9Yn3wOBOlCd
         /9PQ==
X-Gm-Message-State: ABuFfogft6wjlvrrE0asymaHxMGuC7BzTQRQlZkNxBwqJVDPCt7JJcNY
        jdvLafHOObmufnfB88qsSekbkQ==
X-Google-Smtp-Source: ACcGV62xhmptM5KLCZuaa7HJcBiE75CyMSXbGl754fV9kZvfIMxXN6oBBkPePrqHwwAjWNZnzBNdJg==
X-Received: by 2002:a25:8745:: with SMTP id e5-v6mr5177694ybn.119.1539755975409;
        Tue, 16 Oct 2018 22:59:35 -0700 (PDT)
Received: from dhcp-10-123-74-106.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id y1-v6sm3930329ywf.34.2018.10.16.22.59.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Oct 2018 22:59:34 -0700 (PDT)
From:   Suganath Prabu <suganath-prabu.subramani@broadcom.com>
To:     helgaas@kernel.org, lukas@wunner.de, linux-scsi@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     benh@kernel.crashing.org, ruscur@russell.cc,
        sbobroff@linux.ibm.com, oohall@gmail.com,
        andy.shevchenko@gmail.com, Sathya.Prakash@broadcom.com,
        sreekanth.reddy@broadcom.com,
        Suganath Prabu <suganath-prabu.subramani@broadcom.com>
Subject: [v5 3/4] mpt3sas:Fix driver modifying persistent data.
Date:   Wed, 17 Oct 2018 11:29:06 +0530
Message-Id: <1539755947-27014-4-git-send-email-suganath-prabu.subramani@broadcom.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1539755947-27014-1-git-send-email-suganath-prabu.subramani@broadcom.com>
References: <1539755947-27014-1-git-send-email-suganath-prabu.subramani@broadcom.com>
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
index a6c217c..770f52b 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_base.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_base.c
@@ -4062,7 +4062,7 @@ _base_static_config_pages(struct MPT3SAS_ADAPTER *ioc)
 	 * flag unset in NVDATA.
 	 */
 	mpt3sas_config_get_manufacturing_pg11(ioc, &mpi_reply, &ioc->manu_pg11);
-	if (ioc->manu_pg11.EEDPTagMode == 0) {
+	if ((!ioc->is_gen35_ioc) && (ioc->manu_pg11.EEDPTagMode == 0)) {
 		pr_err("%s: overriding NVDATA EEDPTagMode setting\n",
 		    ioc->name);
 		ioc->manu_pg11.EEDPTagMode &= ~0x3;
diff --git a/drivers/scsi/mpt3sas/mpt3sas_config.c b/drivers/scsi/mpt3sas/mpt3sas_config.c
index 14a195c..aa41cb9 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_config.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_config.c
@@ -660,10 +660,6 @@ mpt3sas_config_set_manufacturing_pg11(struct MPT3SAS_ADAPTER *ioc,
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

