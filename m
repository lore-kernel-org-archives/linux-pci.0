Return-Path: <SRS0=Zwnb=M5=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71C46C5ACC6
	for <linux-pci@archiver.kernel.org>; Wed, 17 Oct 2018 05:59:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38515214DD
	for <linux-pci@archiver.kernel.org>; Wed, 17 Oct 2018 05:59:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="d2iJC7Dp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38515214DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727194AbeJQNxb (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 17 Oct 2018 09:53:31 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:35523 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726691AbeJQNxa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 17 Oct 2018 09:53:30 -0400
Received: by mail-yb1-f193.google.com with SMTP id o63-v6so9887085yba.2
        for <linux-pci@vger.kernel.org>; Tue, 16 Oct 2018 22:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Q9qIuTLxRg9OeFnbMrw8PFoAgwe6dGo2J+7euWhkhmQ=;
        b=d2iJC7DpuKNorsBKsLbXzoBvOKxMrP+wjmEz80ALGNeoNgU8HFHE7347Yp1D33Yh6l
         sJhOQpV4ACrXni3D7KtELr+Nfr1vJ69j4HsT2Rb5JwcblN9We4AJDqttd1cXkIuFok4p
         cUpOWYcz426Et50buPK38RYnhWKtp0SlfnXmM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Q9qIuTLxRg9OeFnbMrw8PFoAgwe6dGo2J+7euWhkhmQ=;
        b=HsJJXytbZR1u6hDznKuAJ/3YHd2mXcc1y3kZ7nMWEB3arEdSJxodbB9gl2bFMvWfOf
         kLiX1231UgNDCfMYGc49h3EilvBfNrtKu8/B3R9X7MoLTgKjouhBxvPPqVmhOnRWkAmF
         KkGrQHsQFjQGoioGuc95q4L4qGoZQTGLFVPubzsQGJmlEa+gPxoCPXvuzWrs5XxC+MJo
         HwgVkJe6e+W9kFculRxwD/1Mqr30dknhk8tlqxgyfhtOxcx6AJoNv8evEnDjPpXY7U10
         762WvO7psfRj6gbd0dP8B7kcQ/6JidUPHiqI1pU4NkOkQembiTgecZANlroFRp34XxE8
         OUUA==
X-Gm-Message-State: ABuFfoiJmmUtm94lBnUCTyZ/9naEx1GDyOI82ozaSAB1F2VY8ymx5qn3
        Duecozoj+PQP9E4NgWr9iTZCww==
X-Google-Smtp-Source: ACcGV61jtrg21aiEDwD4wxNC3sqtGjughjc5LcryszXAAFqsjM/w5uMvTsC+JTVy8w+sNf9aglmQKA==
X-Received: by 2002:a25:d183:: with SMTP id i125-v6mr13233866ybg.466.1539755970877;
        Tue, 16 Oct 2018 22:59:30 -0700 (PDT)
Received: from dhcp-10-123-74-106.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id y1-v6sm3930329ywf.34.2018.10.16.22.59.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Oct 2018 22:59:30 -0700 (PDT)
From:   Suganath Prabu <suganath-prabu.subramani@broadcom.com>
To:     helgaas@kernel.org, lukas@wunner.de, linux-scsi@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     benh@kernel.crashing.org, ruscur@russell.cc,
        sbobroff@linux.ibm.com, oohall@gmail.com,
        andy.shevchenko@gmail.com, Sathya.Prakash@broadcom.com,
        sreekanth.reddy@broadcom.com,
        Suganath Prabu <suganath-prabu.subramani@broadcom.com>
Subject: [v5 2/4] mpt3sas: Fix Sync cache command failure during driver unload
Date:   Wed, 17 Oct 2018 11:29:05 +0530
Message-Id: <1539755947-27014-3-git-send-email-suganath-prabu.subramani@broadcom.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1539755947-27014-1-git-send-email-suganath-prabu.subramani@broadcom.com>
References: <1539755947-27014-1-git-send-email-suganath-prabu.subramani@broadcom.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This is to fix Sync cache and start stop command
 failures with DID_NO_CONNECT during driver unload.

1) Release drives first from SML, then remove internally
in driver.
2) And allow sync cache and Start stop commands to firmware,
even when remove_host flag is set.

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
index 7acb408..8ce45e2 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_transport.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_transport.c
@@ -808,10 +808,13 @@ mpt3sas_transport_port_remove(struct MPT3SAS_ADAPTER *ioc, u64 sas_address,
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

