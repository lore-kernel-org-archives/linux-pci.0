Return-Path: <SRS0=AklG=ND=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A347C7112C
	for <linux-pci@archiver.kernel.org>; Tue, 23 Oct 2018 10:21:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEBFC20813
	for <linux-pci@archiver.kernel.org>; Tue, 23 Oct 2018 10:21:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="crRxmpfo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEBFC20813
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727787AbeJWSo1 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 23 Oct 2018 14:44:27 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44202 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727841AbeJWSo1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 23 Oct 2018 14:44:27 -0400
Received: by mail-pg1-f196.google.com with SMTP id w3-v6so406039pgs.11
        for <linux-pci@vger.kernel.org>; Tue, 23 Oct 2018 03:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zWzyBaxgZowo/341gedHJbESpkMqKG/G6TiBCSuRyeY=;
        b=crRxmpfof31hBTkMJjSJ2nypUtrsPc0m0mWC6S1EpPQNkR8aSjSKfRJIxgP3avfB9t
         O5Y5r+Cudk909AFTfImCGcmSQkDlg3De3VPrCIaiRh7A9m4HbXbLbJMmG9EhGqdAHBhu
         yEKTp62pWDBmwacToIuSemV5ShEWXcprld6jU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zWzyBaxgZowo/341gedHJbESpkMqKG/G6TiBCSuRyeY=;
        b=uGK38WoiOj/B5xs+aLiQAN/NS5Yi90b3/js5AwL5X8pnIUrX4vWsjz/SgS0WDQD/k1
         wGi57QHsmNCB3cpW+5NdlmTEzTqm3ONpxjxJgYajMElwF6r+waJZzzD/tBoEAY4nqrog
         ooM0OZsLVsuPHst8uqsXFieZLjGeUdNloKsNwyKTjW0eFnsiqZ52EZwZ7NDatNqu65gN
         Bg+q4eKTU7gx4KcdQn+NQjQhKtpTRR8rKzfT7FrWlDO5WA2w3uc/iIYZ62bZzJZq1vkC
         UKmMy+1R70qwBp/XSg1jeDMgY5l5xXBoNG8tpmXI+vOlKe+hJn6vPIxapmugVbHFnLCy
         O+Ow==
X-Gm-Message-State: ABuFfoj+3XfhDKao+UqjvfpVDpLCWaA6PzIcQq4xM46b7+vpFlS0p5ll
        tyMOqYOwR4VNKZ2C5awEs4pXjYYzmc4=
X-Google-Smtp-Source: ACcGV61lf7EixRkx1datTF1zJYUVyTvuE8N9+YBqhvnn/LVrNKDq8OjbRtBzCdX9s4Q3GeWVfq9TNw==
X-Received: by 2002:a62:36c3:: with SMTP id d186-v6mr48123531pfa.133.1540290099892;
        Tue, 23 Oct 2018 03:21:39 -0700 (PDT)
Received: from dhcp-10-123-74-106.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id m10-v6sm2918523pfg.180.2018.10.23.03.21.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Oct 2018 03:21:39 -0700 (PDT)
From:   Suganath Prabu <suganath-prabu.subramani@broadcom.com>
To:     helgaas@kernel.org, lukas@wunner.de, linux-scsi@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     benh@kernel.crashing.org, ruscur@russell.cc,
        sbobroff@linux.ibm.com, oohall@gmail.com,
        andy.shevchenko@gmail.com, Sathya.Prakash@broadcom.com,
        sreekanth.reddy@broadcom.com,
        Suganath Prabu <suganath-prabu.subramani@broadcom.com>
Subject: [v6 2/4] mpt3sas: Fix Sync cache command failure during driver unload
Date:   Tue, 23 Oct 2018 15:51:19 +0530
Message-Id: <1540290081-15827-3-git-send-email-suganath-prabu.subramani@broadcom.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1540290081-15827-1-git-send-email-suganath-prabu.subramani@broadcom.com>
References: <1540290081-15827-1-git-send-email-suganath-prabu.subramani@broadcom.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This is to fix Sync cache and start stop command
 failures with DID_NO_CONNECT during driver unload.

1) Release drives first from SML, then remove internally
in driver.
2) And allow sync cache and Start stop commands to firmware,
even when remove_host flag is set

Signed-off-by: Suganath Prabu <suganath-prabu.subramani@broadcom.com>
---
 drivers/scsi/mpt3sas/mpt3sas_scsih.c     | 38 ++++++++++++++++++++++++++++++--
 drivers/scsi/mpt3sas/mpt3sas_transport.c |  7 ++++--
 2 files changed, 41 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/mpt3sas/mpt3sas_scsih.c b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
index 4d73b5e..df56cbe 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_scsih.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
@@ -3748,6 +3748,40 @@ _scsih_tm_tr_complete(struct MPT3SAS_ADAPTER *ioc, u16 smid, u8 msix_index,
 	return _scsih_check_for_pending_tm(ioc, smid);
 }
 
+/** _scsih_allow_scmd_to_device - check whether scmd needs to
+ *				 issue to IOC or not.
+ * @ioc: per adapter object
+ * @scmd: pointer to scsi command object
+ *
+ * Returns true if scmd can be issued to IOC otherwise returns false.
+ */
+inline bool _scsih_allow_scmd_to_device(struct MPT3SAS_ADAPTER *ioc,
+	struct scsi_cmnd *scmd)
+{
+
+	if (ioc->pci_error_recovery)
+		return false;
+
+	if (ioc->hba_mpi_version_belonged == MPI2_VERSION) {
+		if (ioc->remove_host)
+			return false;
+
+		return true;
+	}
+
+	if (ioc->remove_host) {
+
+		switch (scmd->cmnd[0]) {
+		case SYNCHRONIZE_CACHE:
+		case START_STOP:
+			return true;
+		default:
+			return false;
+		}
+	}
+
+	return true;
+}
 
 /**
  * _scsih_sas_control_complete - completion routine
@@ -4571,7 +4605,7 @@ scsih_qcmd(struct Scsi_Host *shost, struct scsi_cmnd *scmd)
 		return 0;
 	}
 
-	if (ioc->pci_error_recovery || ioc->remove_host) {
+	if (!(_scsih_allow_scmd_to_device(ioc, scmd))) {
 		scmd->result = DID_NO_CONNECT << 16;
 		scmd->scsi_done(scmd);
 		return 0;
@@ -9641,6 +9675,7 @@ static void scsih_remove(struct pci_dev *pdev)
 
 	/* release all the volumes */
 	_scsih_ir_shutdown(ioc);
+	sas_remove_host(shost);
 	list_for_each_entry_safe(raid_device, next, &ioc->raid_device_list,
 	    list) {
 		if (raid_device->starget) {
@@ -9682,7 +9717,6 @@ static void scsih_remove(struct pci_dev *pdev)
 		ioc->sas_hba.num_phys = 0;
 	}
 
-	sas_remove_host(shost);
 	mpt3sas_base_detach(ioc);
 	spin_lock(&gioc_lock);
 	list_del(&ioc->list);
diff --git a/drivers/scsi/mpt3sas/mpt3sas_transport.c b/drivers/scsi/mpt3sas/mpt3sas_transport.c
index bc1e67b..7d722b9 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_transport.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_transport.c
@@ -807,10 +807,13 @@ mpt3sas_transport_port_remove(struct MPT3SAS_ADAPTER *ioc, u64 sas_address,
 			    mpt3sas_port->remote_identify.sas_address,
 			    mpt3sas_phy->phy_id);
 		mpt3sas_phy->phy_belongs_to_port = 0;
-		sas_port_delete_phy(mpt3sas_port->port, mpt3sas_phy->phy);
+		if (!ioc->remove_host)
+			sas_port_delete_phy(mpt3sas_port->port,
+						mpt3sas_phy->phy);
 		list_del(&mpt3sas_phy->port_siblings);
 	}
-	sas_port_delete(mpt3sas_port->port);
+	if (!ioc->remove_host)
+		sas_port_delete(mpt3sas_port->port);
 	kfree(mpt3sas_port);
 }
 
-- 
1.8.3.1

