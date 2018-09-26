Return-Path: <SRS0=XSei=MI=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4894C43382
	for <linux-pci@archiver.kernel.org>; Wed, 26 Sep 2018 04:23:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9058C2086E
	for <linux-pci@archiver.kernel.org>; Wed, 26 Sep 2018 04:23:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="dfqA1GaI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9058C2086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbeIZKeM (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 26 Sep 2018 06:34:12 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:42284 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726411AbeIZKeM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 26 Sep 2018 06:34:12 -0400
Received: by mail-qt1-f195.google.com with SMTP id z8-v6so15886735qto.9
        for <linux-pci@vger.kernel.org>; Tue, 25 Sep 2018 21:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CQIUVe8kw8rc54n+Jp4srCzp/ifB3+reTSintP2mjnE=;
        b=dfqA1GaI/i3Yu7vreTMWT8CK1vCsOqFLmgsPpljtskPmDNOs/v21h1WECfduHBMUlL
         0asoA8b54cUoeW9JRbt3f6oTpohWry8ze1Z7v/xHY6ZxEmxuXPNxqCDbEehuHt8w3bBw
         ZazshRqxUZ7aMmIUKbzqFuptC2QhMu2JuVDdE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CQIUVe8kw8rc54n+Jp4srCzp/ifB3+reTSintP2mjnE=;
        b=oWJBqt9PIzhsCRQcuwomGYDlVBO2/C6JFWO8hKNfkjGXSO4yshGFhB1bMABZVFEC7V
         keSGcx/gall6JAUjPny8MJlR4UE7OEWiiUs/Vq73kK1L54Yd3gdseGGNe948XFqkkrpS
         zPtOGTb24tjhQ+rli7xl2UrruMTadLtKClGrxUI1FQ/tYI+p3pdT9TEVok5+PHDMCOxf
         HG+pMsiIk8Fi2uZtyzFzgl1WEc2Ruqr1+MAtUwmYnKk2WMQH8jlM+cCpxsUMVY7cqXI8
         233nGOBDuCiW/jiYS1v8pDxWw2BBrRkTFq8YgoNFb1HKQL12RI58B66AU7LDCYV0Q7us
         ffYw==
X-Gm-Message-State: ABuFfog77Yp8FAtPHAxOo4Q62HxidaiwVV/t18otajXHr3ARXkmU36oX
        ode5WYlfLGzMnH6MXMFoyzC9nSnzPG4=
X-Google-Smtp-Source: ACcGV60WhfJ6AwMsI9hHgKgTA/MqZ/aCK2NsH2Tzb54ZpPB83iFTLeQa6Uybys5FVviDBq5MdIktPg==
X-Received: by 2002:ac8:2a13:: with SMTP id k19-v6mr3082264qtk.245.1537935794267;
        Tue, 25 Sep 2018 21:23:14 -0700 (PDT)
Received: from dhcp-10-123-74-106.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id a17-v6sm2375260qkb.62.2018.09.25.21.23.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Sep 2018 21:23:13 -0700 (PDT)
From:   Suganath Prabu S <suganath-prabu.subramani@broadcom.com>
To:     linux-scsi@vger.kernel.org, linux-pci@vger.kernel.org
Cc:     lukas@wunner.de, andy.shevchenko@gmail.com,
        Sathya.Prakash@broadcom.com, sreekanth.reddy@broadcom.com,
        Suganath Prabu S <suganath-prabu.subramani@broadcom.com>
Subject: [PATCH v4 3/6] mpt3sas: Introdude  _scsih_get_shost_and_ioc.
Date:   Wed, 26 Sep 2018 09:52:36 +0530
Message-Id: <1537935759-14754-4-git-send-email-suganath-prabu.subramani@broadcom.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1537935759-14754-1-git-send-email-suganath-prabu.subramani@broadcom.com>
References: <1537935759-14754-1-git-send-email-suganath-prabu.subramani@broadcom.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The code for getting shost and IOC is redundant so
moved that to function "scsih_get_shost_and_ioc".
Also checks for NULL are added to IOC and shost.

Signed-off-by: Suganath Prabu S <suganath-prabu.subramani@broadcom.com>
---
 drivers/scsi/mpt3sas/mpt3sas_scsih.c | 98 ++++++++++++++++++++++++++++++------
 1 file changed, 82 insertions(+), 16 deletions(-)

diff --git a/drivers/scsi/mpt3sas/mpt3sas_scsih.c b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
index 566a550..f6e92eb 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_scsih.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
@@ -9809,6 +9809,35 @@ _scsih_ir_shutdown(struct MPT3SAS_ADAPTER *ioc)
 }
 
 /**
+ * _scsih_get_shost_and_ioc - get shost and ioc
+ *			and verify whether they are NULL or not
+ * @pdev: PCI device struct
+ * @shost: address of scsi host pointer
+ * @ioc: address of HBA adapter pointer
+ *
+ * Return zero if *shost and *ioc are not NULL otherwise return error number.
+ */
+static int
+_scsih_get_shost_and_ioc(struct pci_dev *pdev,
+	struct Scsi_Host **shost, struct MPT3SAS_ADAPTER **ioc)
+{
+	*shost = pci_get_drvdata(pdev);
+	if (*shost == NULL) {
+		dev_err(&pdev->dev, "pdev's driver data is null\n");
+		return -ENXIO;
+	}
+
+	*ioc = shost_priv(*shost);
+	if (*ioc == NULL) {
+		dev_err(&pdev->dev, "shost's private data is null\n");
+		return -ENXIO;
+	}
+
+	return 0;
+}
+
+
+/**
  * scsih_remove - detach and remove add host
  * @pdev: PCI device struct
  *
@@ -9816,8 +9845,8 @@ _scsih_ir_shutdown(struct MPT3SAS_ADAPTER *ioc)
  */
 static void scsih_remove(struct pci_dev *pdev)
 {
-	struct Scsi_Host *shost = pci_get_drvdata(pdev);
-	struct MPT3SAS_ADAPTER *ioc = shost_priv(shost);
+	struct Scsi_Host *shost = NULL;
+	struct MPT3SAS_ADAPTER *ioc = NULL;
 	struct _sas_port *mpt3sas_port, *next_port;
 	struct _raid_device *raid_device, *next;
 	struct MPT3SAS_TARGET *sas_target_priv_data;
@@ -9825,6 +9854,10 @@ static void scsih_remove(struct pci_dev *pdev)
 	struct workqueue_struct	*wq;
 	unsigned long flags;
 
+	if (_scsih_get_shost_and_ioc(pdev, &shost, &ioc)) {
+		dev_err(&pdev->dev, "unable to remove device\n");
+		return;
+	}
 	ioc->remove_host = 1;
 
 	mpt3sas_wait_for_commands_to_complete(ioc);
@@ -9898,11 +9931,16 @@ static void scsih_remove(struct pci_dev *pdev)
 static void
 scsih_shutdown(struct pci_dev *pdev)
 {
-	struct Scsi_Host *shost = pci_get_drvdata(pdev);
-	struct MPT3SAS_ADAPTER *ioc = shost_priv(shost);
+	struct Scsi_Host *shost = NULL;
+	struct MPT3SAS_ADAPTER *ioc = NULL;
 	struct workqueue_struct	*wq;
 	unsigned long flags;
 
+	if (_scsih_get_shost_and_ioc(pdev, &shost, &ioc)) {
+		dev_err(&pdev->dev, "unable to shutdown device\n");
+		return;
+	}
+
 	ioc->remove_host = 1;
 
 	mpt3sas_wait_for_commands_to_complete(ioc);
@@ -10727,10 +10765,16 @@ out_add_shost_fail:
 static int
 scsih_suspend(struct pci_dev *pdev, pm_message_t state)
 {
-	struct Scsi_Host *shost = pci_get_drvdata(pdev);
-	struct MPT3SAS_ADAPTER *ioc = shost_priv(shost);
+	struct Scsi_Host *shost = NULL;
+	struct MPT3SAS_ADAPTER *ioc = NULL;
 	pci_power_t device_state;
+	int rc;
 
+	rc = _scsih_get_shost_and_ioc(pdev, &shost, &ioc);
+	if (rc) {
+		dev_err(&pdev->dev, "unable to suspend device\n");
+		return rc;
+	}
 	mpt3sas_base_stop_watchdog(ioc);
 	flush_scheduled_work();
 	scsi_block_requests(shost);
@@ -10754,11 +10798,17 @@ scsih_suspend(struct pci_dev *pdev, pm_message_t state)
 static int
 scsih_resume(struct pci_dev *pdev)
 {
-	struct Scsi_Host *shost = pci_get_drvdata(pdev);
-	struct MPT3SAS_ADAPTER *ioc = shost_priv(shost);
+	struct Scsi_Host *shost = NULL;
+	struct MPT3SAS_ADAPTER *ioc = NULL;
 	pci_power_t device_state = pdev->current_state;
 	int r;
 
+	r = _scsih_get_shost_and_ioc(pdev, &shost, &ioc);
+	if (r) {
+		dev_err(&pdev->dev, "unable to resume device\n");
+		return r;
+	}
+
 	pr_info(MPT3SAS_FMT
 		"pdev=0x%p, slot=%s, previous operating state [D%d]\n",
 		ioc->name, pdev, pci_name(pdev), device_state);
@@ -10790,9 +10840,13 @@ scsih_resume(struct pci_dev *pdev)
 static pci_ers_result_t
 scsih_pci_error_detected(struct pci_dev *pdev, pci_channel_state_t state)
 {
-	struct Scsi_Host *shost = pci_get_drvdata(pdev);
-	struct MPT3SAS_ADAPTER *ioc = shost_priv(shost);
+	struct Scsi_Host *shost = NULL;
+	struct MPT3SAS_ADAPTER *ioc = NULL;
 
+	if (_scsih_get_shost_and_ioc(pdev, &shost, &ioc)) {
+		dev_err(&pdev->dev, "device unavailable\n");
+		return PCI_ERS_RESULT_DISCONNECT;
+	}
 	pr_info(MPT3SAS_FMT "PCI error: detected callback, state(%d)!!\n",
 	    ioc->name, state);
 
@@ -10827,10 +10881,14 @@ scsih_pci_error_detected(struct pci_dev *pdev, pci_channel_state_t state)
 static pci_ers_result_t
 scsih_pci_slot_reset(struct pci_dev *pdev)
 {
-	struct Scsi_Host *shost = pci_get_drvdata(pdev);
-	struct MPT3SAS_ADAPTER *ioc = shost_priv(shost);
+	struct Scsi_Host *shost = NULL;
+	struct MPT3SAS_ADAPTER *ioc = NULL;
 	int rc;
 
+	if (_scsih_get_shost_and_ioc(pdev, &shost, &ioc)) {
+		dev_err(&pdev->dev, "unable to perform slot reset\n");
+		return PCI_ERS_RESULT_DISCONNECT;
+	}
 	pr_info(MPT3SAS_FMT "PCI error: slot reset callback!!\n",
 	     ioc->name);
 
@@ -10863,9 +10921,13 @@ scsih_pci_slot_reset(struct pci_dev *pdev)
 static void
 scsih_pci_resume(struct pci_dev *pdev)
 {
-	struct Scsi_Host *shost = pci_get_drvdata(pdev);
-	struct MPT3SAS_ADAPTER *ioc = shost_priv(shost);
+	struct Scsi_Host *shost = NULL;
+	struct MPT3SAS_ADAPTER *ioc = NULL;
 
+	if (_scsih_get_shost_and_ioc(pdev, &shost, &ioc)) {
+		dev_err(&pdev->dev, "unable to resume device\n");
+		return;
+	}
 	pr_info(MPT3SAS_FMT "PCI error: resume callback!!\n", ioc->name);
 
 	pci_cleanup_aer_uncorrect_error_status(pdev);
@@ -10880,9 +10942,13 @@ scsih_pci_resume(struct pci_dev *pdev)
 static pci_ers_result_t
 scsih_pci_mmio_enabled(struct pci_dev *pdev)
 {
-	struct Scsi_Host *shost = pci_get_drvdata(pdev);
-	struct MPT3SAS_ADAPTER *ioc = shost_priv(shost);
+	struct Scsi_Host *shost = NULL;
+	struct MPT3SAS_ADAPTER *ioc = NULL;
 
+	if (_scsih_get_shost_and_ioc(pdev, &shost, &ioc)) {
+		dev_err(&pdev->dev, "unable to enable mmio\n");
+		return PCI_ERS_RESULT_DISCONNECT;
+	}
 	pr_info(MPT3SAS_FMT "PCI error: mmio enabled callback!!\n",
 	    ioc->name);
 
-- 
1.8.3.1

