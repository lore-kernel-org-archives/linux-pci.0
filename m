Return-Path: <SRS0=XSei=MI=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B206EC43382
	for <linux-pci@archiver.kernel.org>; Wed, 26 Sep 2018 04:23:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D9412086E
	for <linux-pci@archiver.kernel.org>; Wed, 26 Sep 2018 04:23:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="PBeWzhex"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D9412086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726499AbeIZKeE (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 26 Sep 2018 06:34:04 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:39558 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726319AbeIZKeE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 26 Sep 2018 06:34:04 -0400
Received: by mail-qk1-f193.google.com with SMTP id b19-v6so14906984qkc.6
        for <linux-pci@vger.kernel.org>; Tue, 25 Sep 2018 21:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=STXYwcuZ6eGYL41qRAcLLT0slTRuTiO5gvh6v7lPktQ=;
        b=PBeWzhexng/hX2qrvOdfbRTCD8ImH3SwXf3zTwPEpJ8BjbV0+7QW70N04l70pCYKXJ
         tnsIjDHqFr9jS0d8g64M5+Y9p2x7Nt/Frx+iR0OKoQiZPLe+THI5w3k17nbSgHjbSIlF
         F5cSUxvCRT9f5Sqtnum1BKGaLv3+DBpZeDlz8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=STXYwcuZ6eGYL41qRAcLLT0slTRuTiO5gvh6v7lPktQ=;
        b=L4lUwkIr5oStQuY53INyE0x0H79TwJNhrWY2fTS1pvtqV42IAgbDQ2b8z7tDLbju+K
         j4/y5dgp5YV8QKT0glutpyI1OdbjgTBbQ1q+6juLJT8J+i9rYmTeFjpoiPhkHuQnAC6y
         CEEfhCpateSfWqd56PXDRxJTmsWJkmZ2u3gwddoR8x8dvEKlW5q+p+4z/5+rSs3XHjiG
         bq9ws7QYm2+V8ybr1G9SY1wnPyBv+p/XPLoefDOV1Qf426YHXSXWF+h4axi6yQAyOsHi
         +p6EoiS9uTLjVrBYSJ7eK/+D8cCmO96mi7FBOisCsHYs5nfWmqikbMA/FBI4sDTCc3rb
         4E9w==
X-Gm-Message-State: ABuFfoicj6/w5Q6GFtX495P+Et3cOlaaQkRlWItddBN+8RnSrzFew17Z
        zUw4hi3OZ66LrSpQCDSgLQPwWw==
X-Google-Smtp-Source: ACcGV62orMHiRdx5oc2RmNi1Q7+piEKm0Pmr48ZvRtYFFmjKVfeBp0GV3opbb3B6xvmxIxPuosueBw==
X-Received: by 2002:a37:9986:: with SMTP id b128-v6mr2869963qke.288.1537935786675;
        Tue, 25 Sep 2018 21:23:06 -0700 (PDT)
Received: from dhcp-10-123-74-106.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id a17-v6sm2375260qkb.62.2018.09.25.21.23.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Sep 2018 21:23:05 -0700 (PDT)
From:   Suganath Prabu S <suganath-prabu.subramani@broadcom.com>
To:     linux-scsi@vger.kernel.org, linux-pci@vger.kernel.org
Cc:     lukas@wunner.de, andy.shevchenko@gmail.com,
        Sathya.Prakash@broadcom.com, sreekanth.reddy@broadcom.com,
        Suganath Prabu S <suganath-prabu.subramani@broadcom.com>
Subject: [PATCH v4 1/6] mpt3sas: Introduce  mpt3sas_base_pci_device_is_available
Date:   Wed, 26 Sep 2018 09:52:34 +0530
Message-Id: <1537935759-14754-2-git-send-email-suganath-prabu.subramani@broadcom.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1537935759-14754-1-git-send-email-suganath-prabu.subramani@broadcom.com>
References: <1537935759-14754-1-git-send-email-suganath-prabu.subramani@broadcom.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

* Driver uses "pci_device_is_present" to check whether
If Hot unplugged:
the outstanding IOs with 'DID_NO_CONNECT' before removing the drives
attached to the HBA.
"DID_NO_CONNECT" status and free the smid, if driver detects that
HBA is hot unplugged.

* In the hard reset flush out all the outstanding IOs even if diag reset
fails and also if driver detects that HBA is hot unplugged.

v1 change set:
==============
unlock mutex before goto "out_unlocked",
if active reset is in progress.

v2 change set:
==============
1) Use pci_device_is_present instead of
mpt3sas_base_pci_device_is_unplugged.
2) As suggested by Lukas, removed using
watchdog thread for checking hba hot unplug(Patch 02 of V1).
Added Hot unplug checks in scan finish and reset paths.

v3 Change Set:
=============
Simplified function "mpt3sas_base_pci_device_is_available" and
made inline.

v4 Changes:
===========
Dont split strings in print statement.

Signed-off-by: Suganath Prabu S <suganath-prabu.subramani@broadcom.com>
---
 drivers/scsi/mpt3sas/mpt3sas_base.c  | 39 ++++++++++++++++++++++++++++
 drivers/scsi/mpt3sas/mpt3sas_base.h  |  3 ++-
 drivers/scsi/mpt3sas/mpt3sas_scsih.c | 50 ++++++++++++++++++++++++++++++++----
 3 files changed, 86 insertions(+), 6 deletions(-)

diff --git a/drivers/scsi/mpt3sas/mpt3sas_base.c b/drivers/scsi/mpt3sas/mpt3sas_base.c
index 59d7844..c880e72 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_base.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_base.c
@@ -543,6 +543,20 @@ static int mpt3sas_remove_dead_ioc_func(void *arg)
 }
 
 /**
+ * mpt3sas_base_pci_device_is_available - check whether pci device is
+ *			available for any transactions with FW
+ *
+ * @ioc: per adapter object
+ *
+ * Return 1 if pci device state is up and running else return 0.
+ */
+inline bool
+mpt3sas_base_pci_device_is_available(struct MPT3SAS_ADAPTER *ioc)
+{
+	return !ioc->pci_error_recovery && pci_device_is_present(ioc->pdev);
+}
+
+/**
  * _base_fault_reset_work - workq handling ioc fault conditions
  * @work: input argument, used to derive ioc
  *
@@ -6122,6 +6136,11 @@ _base_diag_reset(struct MPT3SAS_ADAPTER *ioc)
 
 	count = 0;
 	do {
+		if (!pci_device_is_present(ioc->pdev)) {
+			ioc->remove_host = 1;
+			pr_err(MPT3SAS_FMT "Hba Hot unplugged\n", ioc->name);
+			goto out;
+		}
 		/* Write magic sequence to WriteSequence register
 		 * Loop until in diagnostic mode
 		 */
@@ -6853,6 +6872,13 @@ mpt3sas_wait_for_commands_to_complete(struct MPT3SAS_ADAPTER *ioc)
 
 	ioc->pending_io_count = 0;
 
+	if (!mpt3sas_base_pci_device_is_available(ioc)) {
+		pr_err(MPT3SAS_FMT
+		    "%s: pci error recovery reset or pci device unplug occurred\n",
+		    ioc->name, __func__);
+		return;
+	}
+
 	ioc_state = mpt3sas_base_get_iocstate(ioc, 0);
 	if ((ioc_state & MPI2_IOC_STATE_MASK) != MPI2_IOC_STATE_OPERATIONAL)
 		return;
@@ -6899,6 +6925,19 @@ mpt3sas_base_hard_reset_handler(struct MPT3SAS_ADAPTER *ioc,
 	/* wait for an active reset in progress to complete */
 	mutex_lock(&ioc->reset_in_progress_mutex);
 
+	if (!mpt3sas_base_pci_device_is_available(ioc)) {
+		pr_err(MPT3SAS_FMT
+		    "%s: pci error recovery reset or pci device unplug occurred\n",
+		    ioc->name, __func__);
+		if (!pci_device_is_present(ioc->pdev))
+			ioc->schedule_dead_ioc_flush_running_cmds(ioc);
+		r = 0;
+		mutex_unlock(&ioc->reset_in_progress_mutex);
+		goto out_unlocked;
+	}
+
+	mpt3sas_halt_firmware(ioc);
+
 	spin_lock_irqsave(&ioc->ioc_reset_in_progress_lock, flags);
 	ioc->shost_recovery = 1;
 	spin_unlock_irqrestore(&ioc->ioc_reset_in_progress_lock, flags);
diff --git a/drivers/scsi/mpt3sas/mpt3sas_base.h b/drivers/scsi/mpt3sas/mpt3sas_base.h
index 96dc15e..a802ad4 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_base.h
+++ b/drivers/scsi/mpt3sas/mpt3sas_base.h
@@ -1474,7 +1474,8 @@ void mpt3sas_base_update_missing_delay(struct MPT3SAS_ADAPTER *ioc,
 	u16 device_missing_delay, u8 io_missing_delay);
 
 int mpt3sas_port_enable(struct MPT3SAS_ADAPTER *ioc);
-
+inline bool  mpt3sas_base_pci_device_is_available(
+	struct MPT3SAS_ADAPTER *ioc);
 void
 mpt3sas_wait_for_commands_to_complete(struct MPT3SAS_ADAPTER *ioc);
 
diff --git a/drivers/scsi/mpt3sas/mpt3sas_scsih.c b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
index 53133cf..566a550 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_scsih.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
@@ -2846,9 +2846,19 @@ scsih_abort(struct scsi_cmnd *scmd)
 		"attempting task abort! scmd(%p)\n", scmd);
 	_scsih_tm_display_info(ioc, scmd);
 
+	if (!pci_device_is_present(ioc->pdev) || ioc->remove_host) {
+		sdev_printk(KERN_INFO, scmd->device, "%s scmd(%p)\n",
+		    ((ioc->remove_host) ? ("shost is getting removed!") :
+		    ("pci device been removed!")), scmd);
+		if (st && st->smid)
+			mpt3sas_base_free_smid(ioc, st->smid);
+		scmd->result = DID_NO_CONNECT << 16;
+		r = FAST_IO_FAIL;
+		goto out;
+	}
+
 	sas_device_priv_data = scmd->device->hostdata;
-	if (!sas_device_priv_data || !sas_device_priv_data->sas_target ||
-	    ioc->remove_host) {
+	if (!sas_device_priv_data || !sas_device_priv_data->sas_target) {
 		sdev_printk(KERN_INFO, scmd->device,
 			"device been deleted! scmd(%p)\n", scmd);
 		scmd->result = DID_NO_CONNECT << 16;
@@ -2918,6 +2928,15 @@ scsih_dev_reset(struct scsi_cmnd *scmd)
 		"attempting device reset! scmd(%p)\n", scmd);
 	_scsih_tm_display_info(ioc, scmd);
 
+	if (!pci_device_is_present(ioc->pdev) || ioc->remove_host) {
+		sdev_printk(KERN_INFO, scmd->device, "%s scmd(%p)\n",
+		    ((ioc->remove_host) ? ("shost is getting removed!") :
+		    ("pci device been removed!")), scmd);
+		scmd->result = DID_NO_CONNECT << 16;
+		r = FAST_IO_FAIL;
+		goto out;
+	}
+
 	sas_device_priv_data = scmd->device->hostdata;
 	if (!sas_device_priv_data || !sas_device_priv_data->sas_target ||
 	    ioc->remove_host) {
@@ -2995,9 +3014,17 @@ scsih_target_reset(struct scsi_cmnd *scmd)
 		scmd);
 	_scsih_tm_display_info(ioc, scmd);
 
+	if ((!pci_device_is_present(ioc->pdev)) || ioc->remove_host) {
+		sdev_printk(KERN_INFO, scmd->device, "%s scmd(%p)\n",
+		    ((ioc->remove_host) ? ("shost is getting removed!") :
+		    ("pci device been removed!")), scmd);
+		scmd->result = DID_NO_CONNECT << 16;
+		r = FAST_IO_FAIL;
+		goto out;
+	}
+
 	sas_device_priv_data = scmd->device->hostdata;
-	if (!sas_device_priv_data || !sas_device_priv_data->sas_target ||
-	    ioc->remove_host) {
+	if (!sas_device_priv_data || !sas_device_priv_data->sas_target) {
 		starget_printk(KERN_INFO, starget, "target been deleted! scmd(%p)\n",
 			scmd);
 		scmd->result = DID_NO_CONNECT << 16;
@@ -4474,7 +4501,9 @@ _scsih_flush_running_cmds(struct MPT3SAS_ADAPTER *ioc)
 		st = scsi_cmd_priv(scmd);
 		mpt3sas_base_clear_st(ioc, st);
 		scsi_dma_unmap(scmd);
-		if (ioc->pci_error_recovery || ioc->remove_host)
+
+		if ((!mpt3sas_base_pci_device_is_available(ioc))
+				|| ioc->remove_host)
 			scmd->result = DID_NO_CONNECT << 16;
 		else
 			scmd->result = DID_RESET << 16;
@@ -9726,6 +9755,9 @@ _scsih_ir_shutdown(struct MPT3SAS_ADAPTER *ioc)
 	if (list_empty(&ioc->raid_device_list))
 		return;
 
+	if (!pci_device_is_present(ioc->pdev))
+		return;
+
 	mutex_lock(&ioc->scsih_cmds.mutex);
 
 	if (ioc->scsih_cmds.status != MPT3_CMD_NOT_USED) {
@@ -10247,6 +10279,14 @@ scsih_scan_finished(struct Scsi_Host *shost, unsigned long time)
 {
 	struct MPT3SAS_ADAPTER *ioc = shost_priv(shost);
 
+	if (!pci_device_is_present(ioc->pdev)) {
+		complete(&ioc->port_enable_cmds.done);
+		ioc->port_enable_cmds.status = MPT3_CMD_NOT_USED;
+		ioc->is_driver_loading = 0;
+		ioc->remove_host = 1;
+		return 1;
+	}
+
 	if (disable_discovery > 0) {
 		ioc->is_driver_loading = 0;
 		ioc->wait_for_discovery_to_complete = 0;
-- 
1.8.3.1

