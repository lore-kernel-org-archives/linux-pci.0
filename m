Return-Path: <SRS0=AklG=ND=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A57AC67863
	for <linux-pci@archiver.kernel.org>; Tue, 23 Oct 2018 10:21:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFD88207DD
	for <linux-pci@archiver.kernel.org>; Tue, 23 Oct 2018 10:21:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="A50lZ43q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFD88207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727692AbeJWSoY (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 23 Oct 2018 14:44:24 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45690 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727787AbeJWSoX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 23 Oct 2018 14:44:23 -0400
Received: by mail-pf1-f195.google.com with SMTP id u12-v6so415025pfn.12
        for <linux-pci@vger.kernel.org>; Tue, 23 Oct 2018 03:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CcMDxNBk/Yd4SL7mv73ZiHvfITpf8/s8LwHW3zfcT1I=;
        b=A50lZ43qx41gaGQXqgkXDFAUhf9rQ71ksQCSCizaLRmTtvc3jieTXc5Z0tyA6oxuBk
         AWeMoc6aCRxxai8qCc5U2vmeoO0f8putlc4F192FfgkQVtv5CmTa80Gxe8hQRcJ92/8b
         ATd9vzzXiB7NNxMAjX84WYBXT2FuqRJxDmQcA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CcMDxNBk/Yd4SL7mv73ZiHvfITpf8/s8LwHW3zfcT1I=;
        b=MW27AGQXAYet7rGeMPekOibD0EGNfp+JGGyZ0T70sOJjAJD55cfGC157bq/iF+x467
         DpE5szfDK0ntMYaBIo2Byzr8pUQmB4tlE+5cSgFPe6TZSdyuIgj/NDwxC4JYxUf26vku
         RP1A0T6fXOp0pKJ9qpadSgj/p199lPcYLjrELbvG15JgEi5xgWXp/bTxhgWbeolIT1uU
         G3zErigN8amkS57Cd8rKk7Mn3VHkTfxycDt1PlDslssD5ZbZVNVjLw08RRJ+UlAl3In8
         lTPH9+QImVLO+B25DNTmYupWRBhYbOa3Les4H615Kp4bKWDKPtZDds9jEOIoUPhbW0yD
         aTBg==
X-Gm-Message-State: ABuFfoizItxmVFdABmF5kmR+MiAWSjLBLR3/+GUgEpqHRSGNaKe3m1Z/
        SuJKXKvqx/+Buwq5Scx0myc1ZA==
X-Google-Smtp-Source: ACcGV62+WmNrYzn69q3a+VZLCa3KSs08y3K+tfYJls6l1ATuZ9mYQ4RTdderHi4qKZxKtYvhydWH7g==
X-Received: by 2002:a63:e943:: with SMTP id q3-v6mr45847440pgj.42.1540290095802;
        Tue, 23 Oct 2018 03:21:35 -0700 (PDT)
Received: from dhcp-10-123-74-106.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id m10-v6sm2918523pfg.180.2018.10.23.03.21.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Oct 2018 03:21:35 -0700 (PDT)
From:   Suganath Prabu <suganath-prabu.subramani@broadcom.com>
To:     helgaas@kernel.org, lukas@wunner.de, linux-scsi@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     benh@kernel.crashing.org, ruscur@russell.cc,
        sbobroff@linux.ibm.com, oohall@gmail.com,
        andy.shevchenko@gmail.com, Sathya.Prakash@broadcom.com,
        sreekanth.reddy@broadcom.com,
        Suganath Prabu <suganath-prabu.subramani@broadcom.com>
Subject: [v6 1/4] mpt3sas: Separate out mpt3sas_wait_for_ioc_to_operational
Date:   Tue, 23 Oct 2018 15:51:18 +0530
Message-Id: <1540290081-15827-2-git-send-email-suganath-prabu.subramani@broadcom.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1540290081-15827-1-git-send-email-suganath-prabu.subramani@broadcom.com>
References: <1540290081-15827-1-git-send-email-suganath-prabu.subramani@broadcom.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

No functional changes. This section of code
 "wait for IOC to be operational" is used in many places
 across the driver, and hence moved this code in to
 a function "mpt3sas_wait_for_ioc_to_operational()"

Signed-off-by: Suganath Prabu <suganath-prabu.subramani@broadcom.com>
---
 drivers/scsi/mpt3sas/mpt3sas_base.c      | 73 ++++++++++++++++++--------------
 drivers/scsi/mpt3sas/mpt3sas_base.h      |  4 ++
 drivers/scsi/mpt3sas/mpt3sas_config.c    | 24 +++--------
 drivers/scsi/mpt3sas/mpt3sas_ctl.c       | 21 ++-------
 drivers/scsi/mpt3sas/mpt3sas_transport.c | 63 ++++-----------------------
 5 files changed, 62 insertions(+), 123 deletions(-)

diff --git a/drivers/scsi/mpt3sas/mpt3sas_base.c b/drivers/scsi/mpt3sas/mpt3sas_base.c
index 166b607..243bf32 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_base.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_base.c
@@ -5079,6 +5079,41 @@ _base_send_ioc_reset(struct MPT3SAS_ADAPTER *ioc, u8 reset_type, int timeout)
 }
 
 /**
+ * mpt3sas_wait_for_ioc_to_operational - IOC's operational
+ *		state and HBA hot unplug status are checked here.
+ * @ioc: per adapter object
+ * @wait_count: timeout in seconds
+ *
+ * Return: Waits up to timeout seconds for the IOC to
+ * become operational. Returns 0 if IOC is present
+ * and operational; otherwise returns -EFAULT.
+ */
+
+int
+mpt3sas_wait_for_ioc_to_operational(struct MPT3SAS_ADAPTER *ioc,
+	int timeout)
+{
+	int wait_state_count = 0;
+	u32 ioc_state;
+
+	do {
+		ioc_state = mpt3sas_base_get_iocstate(ioc, 1);
+		if (ioc_state == MPI2_IOC_STATE_OPERATIONAL)
+			break;
+		ssleep(1);
+		ioc_info(ioc, "%s: waiting for operational state(count=%d)\n",
+				__func__, ++wait_state_count);
+	} while (--timeout);
+	if (!timeout) {
+		ioc_err(ioc, "%s: failed due to ioc not operational\n", __func__);
+		return -EFAULT;
+	}
+	if (wait_state_count)
+		ioc_info(ioc, "ioc is operational\n");
+	return 0;
+}
+
+/**
  * _base_handshake_req_reply_wait - send request thru doorbell interface
  * @ioc: per adapter object
  * @request_bytes: request length
@@ -5212,11 +5247,9 @@ mpt3sas_base_sas_iounit_control(struct MPT3SAS_ADAPTER *ioc,
 	Mpi2SasIoUnitControlRequest_t *mpi_request)
 {
 	u16 smid;
-	u32 ioc_state;
 	u8 issue_reset = 0;
 	int rc;
 	void *request;
-	u16 wait_state_count;
 
 	dinitprintk(ioc, ioc_info(ioc, "%s\n", __func__));
 
@@ -5228,20 +5261,9 @@ mpt3sas_base_sas_iounit_control(struct MPT3SAS_ADAPTER *ioc,
 		goto out;
 	}
 
-	wait_state_count = 0;
-	ioc_state = mpt3sas_base_get_iocstate(ioc, 1);
-	while (ioc_state != MPI2_IOC_STATE_OPERATIONAL) {
-		if (wait_state_count++ == 10) {
-			ioc_err(ioc, "%s: failed due to ioc not operational\n",
-				__func__);
-			rc = -EFAULT;
-			goto out;
-		}
-		ssleep(1);
-		ioc_state = mpt3sas_base_get_iocstate(ioc, 1);
-		ioc_info(ioc, "%s: waiting for operational state(count=%d)\n",
-			 __func__, wait_state_count);
-	}
+	rc = mpt3sas_wait_for_ioc_to_operational(ioc, IOC_OPERATIONAL_WAIT_COUNT);
+	if (rc)
+		goto out;
 
 	smid = mpt3sas_base_get_smid(ioc, ioc->base_cb_idx);
 	if (!smid) {
@@ -5307,11 +5329,9 @@ mpt3sas_base_scsi_enclosure_processor(struct MPT3SAS_ADAPTER *ioc,
 	Mpi2SepReply_t *mpi_reply, Mpi2SepRequest_t *mpi_request)
 {
 	u16 smid;
-	u32 ioc_state;
 	u8 issue_reset = 0;
 	int rc;
 	void *request;
-	u16 wait_state_count;
 
 	dinitprintk(ioc, ioc_info(ioc, "%s\n", __func__));
 
@@ -5323,20 +5343,9 @@ mpt3sas_base_scsi_enclosure_processor(struct MPT3SAS_ADAPTER *ioc,
 		goto out;
 	}
 
-	wait_state_count = 0;
-	ioc_state = mpt3sas_base_get_iocstate(ioc, 1);
-	while (ioc_state != MPI2_IOC_STATE_OPERATIONAL) {
-		if (wait_state_count++ == 10) {
-			ioc_err(ioc, "%s: failed due to ioc not operational\n",
-				__func__);
-			rc = -EFAULT;
-			goto out;
-		}
-		ssleep(1);
-		ioc_state = mpt3sas_base_get_iocstate(ioc, 1);
-		ioc_info(ioc, "%s: waiting for operational state(count=%d)\n",
-			 __func__, wait_state_count);
-	}
+	rc = mpt3sas_wait_for_ioc_to_operational(ioc, IOC_OPERATIONAL_WAIT_COUNT);
+	if (rc)
+		goto out;
 
 	smid = mpt3sas_base_get_smid(ioc, ioc->base_cb_idx);
 	if (!smid) {
diff --git a/drivers/scsi/mpt3sas/mpt3sas_base.h b/drivers/scsi/mpt3sas/mpt3sas_base.h
index 8f1d6b0..c860ed2 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_base.h
+++ b/drivers/scsi/mpt3sas/mpt3sas_base.h
@@ -139,6 +139,8 @@
 #define DEFAULT_NUM_FWCHAIN_ELEMTS	8
 
 #define FW_IMG_HDR_READ_TIMEOUT	15
+
+#define IOC_OPERATIONAL_WAIT_COUNT	10
 /*
  * NVMe defines
  */
@@ -1487,6 +1489,8 @@ mpt3sas_wait_for_commands_to_complete(struct MPT3SAS_ADAPTER *ioc);
 
 u8 mpt3sas_base_check_cmd_timeout(struct MPT3SAS_ADAPTER *ioc,
 	u8 status, void *mpi_request, int sz);
+int mpt3sas_wait_for_ioc_to_operational(struct MPT3SAS_ADAPTER *ioc,
+	int wait_count);
 
 /* scsih shared API */
 struct scsi_cmnd *mpt3sas_scsih_scsi_lookup_get(struct MPT3SAS_ADAPTER *ioc,
diff --git a/drivers/scsi/mpt3sas/mpt3sas_config.c b/drivers/scsi/mpt3sas/mpt3sas_config.c
index 0220944..88062d1 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_config.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_config.c
@@ -300,11 +300,9 @@ _config_request(struct MPT3SAS_ADAPTER *ioc, Mpi2ConfigRequest_t
 	void *config_page, u16 config_page_sz)
 {
 	u16 smid;
-	u32 ioc_state;
 	Mpi2ConfigRequest_t *config_request;
 	int r;
 	u8 retry_count, issue_host_reset = 0;
-	u16 wait_state_count;
 	struct config_request mem;
 	u32 ioc_status = UINT_MAX;
 
@@ -361,23 +359,11 @@ _config_request(struct MPT3SAS_ADAPTER *ioc, Mpi2ConfigRequest_t
 		ioc_info(ioc, "%s: attempting retry (%d)\n",
 			 __func__, retry_count);
 	}
-	wait_state_count = 0;
-	ioc_state = mpt3sas_base_get_iocstate(ioc, 1);
-	while (ioc_state != MPI2_IOC_STATE_OPERATIONAL) {
-		if (wait_state_count++ == MPT3_CONFIG_PAGE_DEFAULT_TIMEOUT) {
-			ioc_err(ioc, "%s: failed due to ioc not operational\n",
-				__func__);
-			ioc->config_cmds.status = MPT3_CMD_NOT_USED;
-			r = -EFAULT;
-			goto free_mem;
-		}
-		ssleep(1);
-		ioc_state = mpt3sas_base_get_iocstate(ioc, 1);
-		ioc_info(ioc, "%s: waiting for operational state(count=%d)\n",
-			 __func__, wait_state_count);
-	}
-	if (wait_state_count)
-		ioc_info(ioc, "%s: ioc is operational\n", __func__);
+
+	r = mpt3sas_wait_for_ioc_to_operational(ioc,
+				MPT3_CONFIG_PAGE_DEFAULT_TIMEOUT);
+	if (r)
+		goto free_mem;
 
 	smid = mpt3sas_base_get_smid(ioc, ioc->config_cb_idx);
 	if (!smid) {
diff --git a/drivers/scsi/mpt3sas/mpt3sas_ctl.c b/drivers/scsi/mpt3sas/mpt3sas_ctl.c
index 0f6305c..83fdf11 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_ctl.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_ctl.c
@@ -641,7 +641,6 @@ _ctl_do_mpt_command(struct MPT3SAS_ADAPTER *ioc, struct mpt3_ioctl_command karg,
 	MPI2DefaultReply_t *mpi_reply;
 	Mpi26NVMeEncapsulatedRequest_t *nvme_encap_request = NULL;
 	struct _pcie_device *pcie_device = NULL;
-	u32 ioc_state;
 	u16 smid;
 	u8 timeout;
 	u8 issue_reset;
@@ -654,7 +653,6 @@ _ctl_do_mpt_command(struct MPT3SAS_ADAPTER *ioc, struct mpt3_ioctl_command karg,
 	dma_addr_t data_in_dma = 0;
 	size_t data_in_sz = 0;
 	long ret;
-	u16 wait_state_count;
 	u16 device_handle = MPT3SAS_INVALID_DEVICE_HANDLE;
 	u8 tr_method = MPI26_SCSITASKMGMT_MSGFLAGS_PROTOCOL_LVL_RST_PCIE;
 
@@ -666,22 +664,9 @@ _ctl_do_mpt_command(struct MPT3SAS_ADAPTER *ioc, struct mpt3_ioctl_command karg,
 		goto out;
 	}
 
-	wait_state_count = 0;
-	ioc_state = mpt3sas_base_get_iocstate(ioc, 1);
-	while (ioc_state != MPI2_IOC_STATE_OPERATIONAL) {
-		if (wait_state_count++ == 10) {
-			ioc_err(ioc, "%s: failed due to ioc not operational\n",
-				__func__);
-			ret = -EFAULT;
-			goto out;
-		}
-		ssleep(1);
-		ioc_state = mpt3sas_base_get_iocstate(ioc, 1);
-		ioc_info(ioc, "%s: waiting for operational state(count=%d)\n",
-			 __func__, wait_state_count);
-	}
-	if (wait_state_count)
-		ioc_info(ioc, "%s: ioc is operational\n", __func__);
+	ret = mpt3sas_wait_for_ioc_to_operational(ioc, IOC_OPERATIONAL_WAIT_COUNT);
+	if (ret)
+		goto out;
 
 	mpi_request = kzalloc(ioc->request_sz, GFP_KERNEL);
 	if (!mpi_request) {
diff --git a/drivers/scsi/mpt3sas/mpt3sas_transport.c b/drivers/scsi/mpt3sas/mpt3sas_transport.c
index 031b420..bc1e67b 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_transport.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_transport.c
@@ -296,7 +296,6 @@ _transport_expander_report_manufacture(struct MPT3SAS_ADAPTER *ioc,
 	struct rep_manu_request *manufacture_request;
 	int rc;
 	u16 smid;
-	u32 ioc_state;
 	void *psge;
 	u8 issue_reset = 0;
 	void *data_out = NULL;
@@ -304,7 +303,6 @@ _transport_expander_report_manufacture(struct MPT3SAS_ADAPTER *ioc,
 	dma_addr_t data_in_dma;
 	size_t data_in_sz;
 	size_t data_out_sz;
-	u16 wait_state_count;
 
 	if (ioc->shost_recovery || ioc->pci_error_recovery) {
 		ioc_info(ioc, "%s: host reset in progress!\n", __func__);
@@ -320,22 +318,9 @@ _transport_expander_report_manufacture(struct MPT3SAS_ADAPTER *ioc,
 	}
 	ioc->transport_cmds.status = MPT3_CMD_PENDING;
 
-	wait_state_count = 0;
-	ioc_state = mpt3sas_base_get_iocstate(ioc, 1);
-	while (ioc_state != MPI2_IOC_STATE_OPERATIONAL) {
-		if (wait_state_count++ == 10) {
-			ioc_err(ioc, "%s: failed due to ioc not operational\n",
-				__func__);
-			rc = -EFAULT;
-			goto out;
-		}
-		ssleep(1);
-		ioc_state = mpt3sas_base_get_iocstate(ioc, 1);
-		ioc_info(ioc, "%s: waiting for operational state(count=%d)\n",
-			 __func__, wait_state_count);
-	}
-	if (wait_state_count)
-		ioc_info(ioc, "%s: ioc is operational\n", __func__);
+	rc = mpt3sas_wait_for_ioc_to_operational(ioc, IOC_OPERATIONAL_WAIT_COUNT);
+	if (rc)
+		goto out;
 
 	smid = mpt3sas_base_get_smid(ioc, ioc->transport_cb_idx);
 	if (!smid) {
@@ -1077,13 +1062,11 @@ _transport_get_expander_phy_error_log(struct MPT3SAS_ADAPTER *ioc,
 	struct phy_error_log_reply *phy_error_log_reply;
 	int rc;
 	u16 smid;
-	u32 ioc_state;
 	void *psge;
 	u8 issue_reset = 0;
 	void *data_out = NULL;
 	dma_addr_t data_out_dma;
 	u32 sz;
-	u16 wait_state_count;
 
 	if (ioc->shost_recovery || ioc->pci_error_recovery) {
 		ioc_info(ioc, "%s: host reset in progress!\n", __func__);
@@ -1099,22 +1082,9 @@ _transport_get_expander_phy_error_log(struct MPT3SAS_ADAPTER *ioc,
 	}
 	ioc->transport_cmds.status = MPT3_CMD_PENDING;
 
-	wait_state_count = 0;
-	ioc_state = mpt3sas_base_get_iocstate(ioc, 1);
-	while (ioc_state != MPI2_IOC_STATE_OPERATIONAL) {
-		if (wait_state_count++ == 10) {
-			ioc_err(ioc, "%s: failed due to ioc not operational\n",
-				__func__);
-			rc = -EFAULT;
-			goto out;
-		}
-		ssleep(1);
-		ioc_state = mpt3sas_base_get_iocstate(ioc, 1);
-		ioc_info(ioc, "%s: waiting for operational state(count=%d)\n",
-			 __func__, wait_state_count);
-	}
-	if (wait_state_count)
-		ioc_info(ioc, "%s: ioc is operational\n", __func__);
+	rc = mpt3sas_wait_for_ioc_to_operational(ioc, IOC_OPERATIONAL_WAIT_COUNT);
+	if (rc)
+		goto out;
 
 	smid = mpt3sas_base_get_smid(ioc, ioc->transport_cb_idx);
 	if (!smid) {
@@ -1381,13 +1351,11 @@ _transport_expander_phy_control(struct MPT3SAS_ADAPTER *ioc,
 	struct phy_control_reply *phy_control_reply;
 	int rc;
 	u16 smid;
-	u32 ioc_state;
 	void *psge;
 	u8 issue_reset = 0;
 	void *data_out = NULL;
 	dma_addr_t data_out_dma;
 	u32 sz;
-	u16 wait_state_count;
 
 	if (ioc->shost_recovery || ioc->pci_error_recovery) {
 		ioc_info(ioc, "%s: host reset in progress!\n", __func__);
@@ -1403,22 +1371,9 @@ _transport_expander_phy_control(struct MPT3SAS_ADAPTER *ioc,
 	}
 	ioc->transport_cmds.status = MPT3_CMD_PENDING;
 
-	wait_state_count = 0;
-	ioc_state = mpt3sas_base_get_iocstate(ioc, 1);
-	while (ioc_state != MPI2_IOC_STATE_OPERATIONAL) {
-		if (wait_state_count++ == 10) {
-			ioc_err(ioc, "%s: failed due to ioc not operational\n",
-				__func__);
-			rc = -EFAULT;
-			goto out;
-		}
-		ssleep(1);
-		ioc_state = mpt3sas_base_get_iocstate(ioc, 1);
-		ioc_info(ioc, "%s: waiting for operational state(count=%d)\n",
-			 __func__, wait_state_count);
-	}
-	if (wait_state_count)
-		ioc_info(ioc, "%s: ioc is operational\n", __func__);
+	rc = mpt3sas_wait_for_ioc_to_operational(ioc, IOC_OPERATIONAL_WAIT_COUNT);
+	if (rc)
+		goto out;
 
 	smid = mpt3sas_base_get_smid(ioc, ioc->transport_cb_idx);
 	if (!smid) {
-- 
1.8.3.1

