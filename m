Return-Path: <SRS0=XSei=MI=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 544B5C43382
	for <linux-pci@archiver.kernel.org>; Wed, 26 Sep 2018 04:23:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F23412086E
	for <linux-pci@archiver.kernel.org>; Wed, 26 Sep 2018 04:23:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="efwev3Cj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F23412086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726421AbeIZKeI (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 26 Sep 2018 06:34:08 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:39132 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726319AbeIZKeI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 26 Sep 2018 06:34:08 -0400
Received: by mail-qt1-f196.google.com with SMTP id c25-v6so10162669qtp.6
        for <linux-pci@vger.kernel.org>; Tue, 25 Sep 2018 21:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=93rrYZzKcVmmN3+Fje/dzMDHanH/a/PuTjINaMW7h4E=;
        b=efwev3CjHGjCNe4MOz6rn8XTYlMxfC7yjtL2Q7Rs0c1/AouQEYREha/voePL7/IYWC
         4QkNbMhYoo7FpcsTG77Jy/EP5LRzhVaGrYwUsc5vEShSqmisRGdDDWpYYPDwuEYUzqEP
         9sNYAx9XYpNpZSzY/mwWRSVuuGQq/9CH8pAjo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=93rrYZzKcVmmN3+Fje/dzMDHanH/a/PuTjINaMW7h4E=;
        b=LU73s5izVh3ijJkKcZLy5u6BkPN+WEpECgiXx0SW8NorjUTjlfeW+pLyorTYy23lI0
         E3ZfiCNOuart992dciqFUOQ94IJsgKulcuCvXCTRsz0l97GONageHBonCG2xiew1xTgU
         bAYJlM9k8meNS1uyW3OdBEwDuDWkXVIhiRBvJwdRypuvjQo9wm82GpqQ4Bdp07GxnBoi
         XyW+K0awX7GtkBBtsERmQ+FJwGk/lDn0xiIsvIJ9cMZTsJyop2LjjO43UIaosEoq/DDa
         LBeL1jD20YVzvLq47HBndQTmD2UgYWcC46TjgOuOi5RPbd3MAcDriHEDdvYlL0pBeLeb
         irWg==
X-Gm-Message-State: ABuFfogmF0yNr5fqwIRfOY2INPmyAEZTraRwqwctds15fzChcBmO5d4t
        jog99Wh4u3HEeHdfsgMKquqEbA==
X-Google-Smtp-Source: ACcGV610Bv0VCK93hQJR8Xbh9mhqCpROsr+uwem5LdOnPZlMfbN55Jb3Sg93pjIErLQhfhoTsrfN4A==
X-Received: by 2002:aed:27de:: with SMTP id m30-v6mr3036631qtg.303.1537935790575;
        Tue, 25 Sep 2018 21:23:10 -0700 (PDT)
Received: from dhcp-10-123-74-106.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id a17-v6sm2375260qkb.62.2018.09.25.21.23.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Sep 2018 21:23:09 -0700 (PDT)
From:   Suganath Prabu S <suganath-prabu.subramani@broadcom.com>
To:     linux-scsi@vger.kernel.org, linux-pci@vger.kernel.org
Cc:     lukas@wunner.de, andy.shevchenko@gmail.com,
        Sathya.Prakash@broadcom.com, sreekanth.reddy@broadcom.com,
        Suganath Prabu S <suganath-prabu.subramani@broadcom.com>
Subject: [PATCH v4 2/6] mpt3sas: Separate out  mpt3sas_wait_for_ioc_to_operational
Date:   Wed, 26 Sep 2018 09:52:35 +0530
Message-Id: <1537935759-14754-3-git-send-email-suganath-prabu.subramani@broadcom.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1537935759-14754-1-git-send-email-suganath-prabu.subramani@broadcom.com>
References: <1537935759-14754-1-git-send-email-suganath-prabu.subramani@broadcom.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Introduce mpt3sas_wait_for_ioc_to_operational.

This section of code "wait for IOC to be operational"
is used in many places across the driver,
and hence moved this section of code in to the function
"mpt3sas_wait_for_ioc_to_operational".

Also added HBA hot unplug checks, and this returns with
error code EFAULT, if it detects HBA is hot unplugged
or IOC is not in operational state.

V2 change set:
used pci_device_is_present instead of
mpt3sas_base_pci_device_is_unplugged

v4 Change set:
Dont split strings in print statement

Signed-off-by: Suganath Prabu S <suganath-prabu.subramani@broadcom.com>
---
 drivers/scsi/mpt3sas/mpt3sas_base.c      | 92 +++++++++++++++++++-------------
 drivers/scsi/mpt3sas/mpt3sas_base.h      |  4 ++
 drivers/scsi/mpt3sas/mpt3sas_config.c    | 28 +++-------
 drivers/scsi/mpt3sas/mpt3sas_ctl.c       | 26 ++-------
 drivers/scsi/mpt3sas/mpt3sas_transport.c | 75 +++++---------------------
 5 files changed, 81 insertions(+), 144 deletions(-)

diff --git a/drivers/scsi/mpt3sas/mpt3sas_base.c b/drivers/scsi/mpt3sas/mpt3sas_base.c
index c880e72..9f1d8fb 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_base.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_base.c
@@ -5176,6 +5176,53 @@ _base_send_ioc_reset(struct MPT3SAS_ADAPTER *ioc, u8 reset_type, int timeout)
 }
 
 /**
+ * mpt3sas_wait_for_ioc_to_operational - IOC's operational
+ *		state and HBA hot unplug status are checked here.
+ * @ioc: per adapter object
+ * @wait_count: timeout in seconds
+ *
+ * Return:  Returns EFAULT, if HBA is hot unplugged or IOC is
+ * not in operational state, within the wait_count.
+ * And returns 0, If not hot unplugged Or ioc is in
+ * operational state.
+ */
+
+int
+mpt3sas_wait_for_ioc_to_operational(struct MPT3SAS_ADAPTER *ioc,
+	int wait_count)
+{
+	int wait_state_count = 0;
+	u32 ioc_state;
+
+	if (!pci_device_is_present(ioc->pdev))
+		return -EFAULT;
+
+	ioc_state = mpt3sas_base_get_iocstate(ioc, 1);
+	while (ioc_state != MPI2_IOC_STATE_OPERATIONAL) {
+
+		if (!pci_device_is_present(ioc->pdev))
+			return -EFAULT;
+
+		if (wait_state_count++ == wait_count) {
+			pr_err(MPT3SAS_FMT
+			    "%s: failed due to ioc not operational\n",
+			    ioc->name, __func__);
+			return -EFAULT;
+		}
+		ssleep(1);
+		ioc_state = mpt3sas_base_get_iocstate(ioc, 1);
+		pr_info(MPT3SAS_FMT
+		    "%s: waiting for operational state(count=%d)\n",
+		     ioc->name, __func__, wait_state_count);
+	}
+	if (wait_state_count)
+		pr_info(MPT3SAS_FMT "%s: ioc is operational\n",
+		    ioc->name, __func__);
+
+	return 0;
+}
+
+/**
  * _base_handshake_req_reply_wait - send request thru doorbell interface
  * @ioc: per adapter object
  * @request_bytes: request length
@@ -5316,11 +5363,9 @@ mpt3sas_base_sas_iounit_control(struct MPT3SAS_ADAPTER *ioc,
 	Mpi2SasIoUnitControlRequest_t *mpi_request)
 {
 	u16 smid;
-	u32 ioc_state;
 	u8 issue_reset = 0;
 	int rc;
 	void *request;
-	u16 wait_state_count;
 
 	dinitprintk(ioc, pr_info(MPT3SAS_FMT "%s\n", ioc->name,
 	    __func__));
@@ -5334,22 +5379,10 @@ mpt3sas_base_sas_iounit_control(struct MPT3SAS_ADAPTER *ioc,
 		goto out;
 	}
 
-	wait_state_count = 0;
-	ioc_state = mpt3sas_base_get_iocstate(ioc, 1);
-	while (ioc_state != MPI2_IOC_STATE_OPERATIONAL) {
-		if (wait_state_count++ == 10) {
-			pr_err(MPT3SAS_FMT
-			    "%s: failed due to ioc not operational\n",
-			    ioc->name, __func__);
-			rc = -EFAULT;
-			goto out;
-		}
-		ssleep(1);
-		ioc_state = mpt3sas_base_get_iocstate(ioc, 1);
-		pr_info(MPT3SAS_FMT
-			"%s: waiting for operational state(count=%d)\n",
-			ioc->name, __func__, wait_state_count);
-	}
+	rc = mpt3sas_wait_for_ioc_to_operational(ioc,
+					IOC_OPERATIONAL_WAIT_COUNT);
+	if (rc)
+		goto out;
 
 	smid = mpt3sas_base_get_smid(ioc, ioc->base_cb_idx);
 	if (!smid) {
@@ -5416,11 +5449,9 @@ mpt3sas_base_scsi_enclosure_processor(struct MPT3SAS_ADAPTER *ioc,
 	Mpi2SepReply_t *mpi_reply, Mpi2SepRequest_t *mpi_request)
 {
 	u16 smid;
-	u32 ioc_state;
 	u8 issue_reset = 0;
 	int rc;
 	void *request;
-	u16 wait_state_count;
 
 	dinitprintk(ioc, pr_info(MPT3SAS_FMT "%s\n", ioc->name,
 	    __func__));
@@ -5434,23 +5465,10 @@ mpt3sas_base_scsi_enclosure_processor(struct MPT3SAS_ADAPTER *ioc,
 		goto out;
 	}
 
-	wait_state_count = 0;
-	ioc_state = mpt3sas_base_get_iocstate(ioc, 1);
-	while (ioc_state != MPI2_IOC_STATE_OPERATIONAL) {
-		if (wait_state_count++ == 10) {
-			pr_err(MPT3SAS_FMT
-			    "%s: failed due to ioc not operational\n",
-			    ioc->name, __func__);
-			rc = -EFAULT;
-			goto out;
-		}
-		ssleep(1);
-		ioc_state = mpt3sas_base_get_iocstate(ioc, 1);
-		pr_info(MPT3SAS_FMT
-			"%s: waiting for operational state(count=%d)\n",
-			ioc->name,
-		    __func__, wait_state_count);
-	}
+	rc = mpt3sas_wait_for_ioc_to_operational(ioc,
+					IOC_OPERATIONAL_WAIT_COUNT);
+	if (rc)
+		goto out;
 
 	smid = mpt3sas_base_get_smid(ioc, ioc->base_cb_idx);
 	if (!smid) {
diff --git a/drivers/scsi/mpt3sas/mpt3sas_base.h b/drivers/scsi/mpt3sas/mpt3sas_base.h
index a802ad4..f0351a2 100644
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
@@ -1481,6 +1483,8 @@ mpt3sas_wait_for_commands_to_complete(struct MPT3SAS_ADAPTER *ioc);
 
 u8 mpt3sas_base_check_cmd_timeout(struct MPT3SAS_ADAPTER *ioc,
 	u8 status, void *mpi_request, int sz);
+int mpt3sas_wait_for_ioc_to_operational(struct MPT3SAS_ADAPTER *ioc,
+	int wait_count);
 
 /* scsih shared API */
 struct scsi_cmnd *mpt3sas_scsih_scsi_lookup_get(struct MPT3SAS_ADAPTER *ioc,
diff --git a/drivers/scsi/mpt3sas/mpt3sas_config.c b/drivers/scsi/mpt3sas/mpt3sas_config.c
index d29a2dc..5713a2d 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_config.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_config.c
@@ -303,11 +303,10 @@ _config_request(struct MPT3SAS_ADAPTER *ioc, Mpi2ConfigRequest_t
 	void *config_page, u16 config_page_sz)
 {
 	u16 smid;
-	u32 ioc_state;
 	Mpi2ConfigRequest_t *config_request;
 	int r;
 	u8 retry_count, issue_host_reset = 0;
-	u16 wait_state_count;
+
 	struct config_request mem;
 	u32 ioc_status = UINT_MAX;
 
@@ -365,26 +364,11 @@ _config_request(struct MPT3SAS_ADAPTER *ioc, Mpi2ConfigRequest_t
 		pr_info(MPT3SAS_FMT "%s: attempting retry (%d)\n",
 		    ioc->name, __func__, retry_count);
 	}
-	wait_state_count = 0;
-	ioc_state = mpt3sas_base_get_iocstate(ioc, 1);
-	while (ioc_state != MPI2_IOC_STATE_OPERATIONAL) {
-		if (wait_state_count++ == MPT3_CONFIG_PAGE_DEFAULT_TIMEOUT) {
-			pr_err(MPT3SAS_FMT
-			    "%s: failed due to ioc not operational\n",
-			    ioc->name, __func__);
-			ioc->config_cmds.status = MPT3_CMD_NOT_USED;
-			r = -EFAULT;
-			goto free_mem;
-		}
-		ssleep(1);
-		ioc_state = mpt3sas_base_get_iocstate(ioc, 1);
-		pr_info(MPT3SAS_FMT
-			"%s: waiting for operational state(count=%d)\n",
-			ioc->name, __func__, wait_state_count);
-	}
-	if (wait_state_count)
-		pr_info(MPT3SAS_FMT "%s: ioc is operational\n",
-		    ioc->name, __func__);
+
+	r = mpt3sas_wait_for_ioc_to_operational(ioc,
+				MPT3_CONFIG_PAGE_DEFAULT_TIMEOUT);
+	if (r)
+		goto free_mem;
 
 	smid = mpt3sas_base_get_smid(ioc, ioc->config_cb_idx);
 	if (!smid) {
diff --git a/drivers/scsi/mpt3sas/mpt3sas_ctl.c b/drivers/scsi/mpt3sas/mpt3sas_ctl.c
index 5e8c059..a46039c 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_ctl.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_ctl.c
@@ -652,7 +652,6 @@ _ctl_do_mpt_command(struct MPT3SAS_ADAPTER *ioc, struct mpt3_ioctl_command karg,
 	MPI2DefaultReply_t *mpi_reply;
 	Mpi26NVMeEncapsulatedRequest_t *nvme_encap_request = NULL;
 	struct _pcie_device *pcie_device = NULL;
-	u32 ioc_state;
 	u16 smid;
 	u8 timeout;
 	u8 issue_reset;
@@ -665,7 +664,6 @@ _ctl_do_mpt_command(struct MPT3SAS_ADAPTER *ioc, struct mpt3_ioctl_command karg,
 	dma_addr_t data_in_dma = 0;
 	size_t data_in_sz = 0;
 	long ret;
-	u16 wait_state_count;
 	u16 device_handle = MPT3SAS_INVALID_DEVICE_HANDLE;
 	u8 tr_method = MPI26_SCSITASKMGMT_MSGFLAGS_PROTOCOL_LVL_RST_PCIE;
 
@@ -678,26 +676,10 @@ _ctl_do_mpt_command(struct MPT3SAS_ADAPTER *ioc, struct mpt3_ioctl_command karg,
 		goto out;
 	}
 
-	wait_state_count = 0;
-	ioc_state = mpt3sas_base_get_iocstate(ioc, 1);
-	while (ioc_state != MPI2_IOC_STATE_OPERATIONAL) {
-		if (wait_state_count++ == 10) {
-			pr_err(MPT3SAS_FMT
-			    "%s: failed due to ioc not operational\n",
-			    ioc->name, __func__);
-			ret = -EFAULT;
-			goto out;
-		}
-		ssleep(1);
-		ioc_state = mpt3sas_base_get_iocstate(ioc, 1);
-		pr_info(MPT3SAS_FMT
-			"%s: waiting for operational state(count=%d)\n",
-			ioc->name,
-		    __func__, wait_state_count);
-	}
-	if (wait_state_count)
-		pr_info(MPT3SAS_FMT "%s: ioc is operational\n",
-		    ioc->name, __func__);
+	ret = mpt3sas_wait_for_ioc_to_operational(ioc,
+					IOC_OPERATIONAL_WAIT_COUNT);
+	if (ret)
+		goto out;
 
 	mpi_request = kzalloc(ioc->request_sz, GFP_KERNEL);
 	if (!mpi_request) {
diff --git a/drivers/scsi/mpt3sas/mpt3sas_transport.c b/drivers/scsi/mpt3sas/mpt3sas_transport.c
index f8cc267..b10d73e 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_transport.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_transport.c
@@ -299,7 +299,6 @@ _transport_expander_report_manufacture(struct MPT3SAS_ADAPTER *ioc,
 	struct rep_manu_request *manufacture_request;
 	int rc;
 	u16 smid;
-	u32 ioc_state;
 	void *psge;
 	u8 issue_reset = 0;
 	void *data_out = NULL;
@@ -307,7 +306,6 @@ _transport_expander_report_manufacture(struct MPT3SAS_ADAPTER *ioc,
 	dma_addr_t data_in_dma;
 	size_t data_in_sz;
 	size_t data_out_sz;
-	u16 wait_state_count;
 
 	if (ioc->shost_recovery || ioc->pci_error_recovery) {
 		pr_info(MPT3SAS_FMT "%s: host reset in progress!\n",
@@ -325,25 +323,10 @@ _transport_expander_report_manufacture(struct MPT3SAS_ADAPTER *ioc,
 	}
 	ioc->transport_cmds.status = MPT3_CMD_PENDING;
 
-	wait_state_count = 0;
-	ioc_state = mpt3sas_base_get_iocstate(ioc, 1);
-	while (ioc_state != MPI2_IOC_STATE_OPERATIONAL) {
-		if (wait_state_count++ == 10) {
-			pr_err(MPT3SAS_FMT
-			    "%s: failed due to ioc not operational\n",
-			    ioc->name, __func__);
-			rc = -EFAULT;
-			goto out;
-		}
-		ssleep(1);
-		ioc_state = mpt3sas_base_get_iocstate(ioc, 1);
-		pr_info(MPT3SAS_FMT
-			"%s: waiting for operational state(count=%d)\n",
-			ioc->name, __func__, wait_state_count);
-	}
-	if (wait_state_count)
-		pr_info(MPT3SAS_FMT "%s: ioc is operational\n",
-		    ioc->name, __func__);
+	rc = mpt3sas_wait_for_ioc_to_operational(ioc,
+					IOC_OPERATIONAL_WAIT_COUNT);
+	if (rc)
+		goto out;
 
 	smid = mpt3sas_base_get_smid(ioc, ioc->transport_cb_idx);
 	if (!smid) {
@@ -1089,13 +1072,11 @@ _transport_get_expander_phy_error_log(struct MPT3SAS_ADAPTER *ioc,
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
 		pr_info(MPT3SAS_FMT "%s: host reset in progress!\n",
@@ -1113,25 +1094,10 @@ _transport_get_expander_phy_error_log(struct MPT3SAS_ADAPTER *ioc,
 	}
 	ioc->transport_cmds.status = MPT3_CMD_PENDING;
 
-	wait_state_count = 0;
-	ioc_state = mpt3sas_base_get_iocstate(ioc, 1);
-	while (ioc_state != MPI2_IOC_STATE_OPERATIONAL) {
-		if (wait_state_count++ == 10) {
-			pr_err(MPT3SAS_FMT
-			    "%s: failed due to ioc not operational\n",
-			    ioc->name, __func__);
-			rc = -EFAULT;
-			goto out;
-		}
-		ssleep(1);
-		ioc_state = mpt3sas_base_get_iocstate(ioc, 1);
-		pr_info(MPT3SAS_FMT
-			"%s: waiting for operational state(count=%d)\n",
-			ioc->name, __func__, wait_state_count);
-	}
-	if (wait_state_count)
-		pr_info(MPT3SAS_FMT "%s: ioc is operational\n",
-		    ioc->name, __func__);
+	rc = mpt3sas_wait_for_ioc_to_operational(ioc,
+					IOC_OPERATIONAL_WAIT_COUNT);
+	if (rc)
+		goto out;
 
 	smid = mpt3sas_base_get_smid(ioc, ioc->transport_cb_idx);
 	if (!smid) {
@@ -1402,13 +1368,11 @@ _transport_expander_phy_control(struct MPT3SAS_ADAPTER *ioc,
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
 		pr_info(MPT3SAS_FMT "%s: host reset in progress!\n",
@@ -1426,25 +1390,10 @@ _transport_expander_phy_control(struct MPT3SAS_ADAPTER *ioc,
 	}
 	ioc->transport_cmds.status = MPT3_CMD_PENDING;
 
-	wait_state_count = 0;
-	ioc_state = mpt3sas_base_get_iocstate(ioc, 1);
-	while (ioc_state != MPI2_IOC_STATE_OPERATIONAL) {
-		if (wait_state_count++ == 10) {
-			pr_err(MPT3SAS_FMT
-			    "%s: failed due to ioc not operational\n",
-			    ioc->name, __func__);
-			rc = -EFAULT;
-			goto out;
-		}
-		ssleep(1);
-		ioc_state = mpt3sas_base_get_iocstate(ioc, 1);
-		pr_info(MPT3SAS_FMT
-			"%s: waiting for operational state(count=%d)\n",
-			ioc->name, __func__, wait_state_count);
-	}
-	if (wait_state_count)
-		pr_info(MPT3SAS_FMT "%s: ioc is operational\n",
-		    ioc->name, __func__);
+	rc = mpt3sas_wait_for_ioc_to_operational(ioc,
+					IOC_OPERATIONAL_WAIT_COUNT);
+	if (rc)
+		goto out;
 
 	smid = mpt3sas_base_get_smid(ioc, ioc->transport_cb_idx);
 	if (!smid) {
-- 
1.8.3.1

