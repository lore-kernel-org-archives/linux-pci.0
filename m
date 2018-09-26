Return-Path: <SRS0=XSei=MI=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05ED6C43382
	for <linux-pci@archiver.kernel.org>; Wed, 26 Sep 2018 04:23:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4DAC2086E
	for <linux-pci@archiver.kernel.org>; Wed, 26 Sep 2018 04:23:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="c+0M7EFH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4DAC2086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbeIZKeP (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 26 Sep 2018 06:34:15 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:47018 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726404AbeIZKeP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 26 Sep 2018 06:34:15 -0400
Received: by mail-qk1-f196.google.com with SMTP id q12-v6so6554417qkl.13
        for <linux-pci@vger.kernel.org>; Tue, 25 Sep 2018 21:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0/V5YKy5esTLDrOt7DVdzxfFXSOKSFPF2j7Lhnoe424=;
        b=c+0M7EFHarkfLgbVMILS7nCpeJUkuJ7YOMoFkux4G7wLBb+tBfb7eLU6Jvbl+7Mgpq
         P4mMlhsXyplnNRD2R9GHCDrh1kMch5itW9KDRRtXaPIllRLo76wIrKyCUUfnoGulZ+kT
         T5nQTccQFHd88cpHxzwL+jfyWFhRY1yHohtJE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0/V5YKy5esTLDrOt7DVdzxfFXSOKSFPF2j7Lhnoe424=;
        b=HO3Idrg64FSaE04IVQERpB1XA8FBkOL9+CT073ssoXYOhQPEnSRk+iDCFDpS4S8mK+
         HHE30J/dLLUG7EPnjkWlcXNvB0NEViTHiXdTchHUUMMKExyqFmLz6yEAdW6RRV0sOlkg
         rmSW93Aw79U9Sryp47PQqCg3EYbTP73n98b1sXToHJJyUAbyClmuRCPYCwpR2JMG1J8J
         bteemsLg9cB/w+B9OKlTS1zSiQlk9AdVh6k5qsfYfvenl7kbT9b2VjtB5cW7GFmg/WyJ
         yBS7Uj4rXIsdv7QaqkkrrUDaAHaoVggzwoPOFXooZievSR90oFwba7bbFv4v6zVGChc8
         AofQ==
X-Gm-Message-State: ABuFfohwd8KFCa2MLnGcAXAPs1AwhnZODjNzLWCAQ0wasDUFX+LiE3Jf
        fpZ4/+Y9uTjSdgvR82BSsZ8YSQ==
X-Google-Smtp-Source: ACcGV619xuzpue1JiaUMXY+VdKy5NCqsKyaHxkfOTGfLB1y3j9TGTQenYAuLIqlvN4xJWGn/Jz4tTw==
X-Received: by 2002:a37:6888:: with SMTP id d130-v6mr3001058qkc.192.1537935798138;
        Tue, 25 Sep 2018 21:23:18 -0700 (PDT)
Received: from dhcp-10-123-74-106.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id a17-v6sm2375260qkb.62.2018.09.25.21.23.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Sep 2018 21:23:17 -0700 (PDT)
From:   Suganath Prabu S <suganath-prabu.subramani@broadcom.com>
To:     linux-scsi@vger.kernel.org, linux-pci@vger.kernel.org
Cc:     lukas@wunner.de, andy.shevchenko@gmail.com,
        Sathya.Prakash@broadcom.com, sreekanth.reddy@broadcom.com,
        Suganath Prabu S <suganath-prabu.subramani@broadcom.com>
Subject: [PATCH v4 4/6] mpt3sas: Fix Sync cache command failure during driver  unload.
Date:   Wed, 26 Sep 2018 09:52:37 +0530
Message-Id: <1537935759-14754-5-git-send-email-suganath-prabu.subramani@broadcom.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1537935759-14754-1-git-send-email-suganath-prabu.subramani@broadcom.com>
References: <1537935759-14754-1-git-send-email-suganath-prabu.subramani@broadcom.com>
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

v2 Changeset:
Replaced this function mpt3sas_base_pci_device_is_unplugged
with pci_device_is_present

Signed-off-by: Suganath Prabu S <suganath-prabu.subramani@broadcom.com>
---
 drivers/scsi/mpt3sas/mpt3sas_scsih.c     | 41 ++++++++++++++++++++++++++++++--
 drivers/scsi/mpt3sas/mpt3sas_transport.c |  7 ++++--
 2 files changed, 44 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/mpt3sas/mpt3sas_scsih.c b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
index f6e92eb..5d15d06 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_scsih.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
@@ -3806,6 +3806,43 @@ _scsih_tm_tr_complete(struct MPT3SAS_ADAPTER *ioc, u16 smid, u8 msix_index,
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
+
+	if (ioc->remove_host) {
+		if (!pci_device_is_present(ioc->pdev))
+			return false;
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
@@ -4640,7 +4677,7 @@ scsih_qcmd(struct Scsi_Host *shost, struct scsi_cmnd *scmd)
 		return 0;
 	}
 
-	if (ioc->pci_error_recovery || ioc->remove_host) {
+	if (!(_scsih_allow_scmd_to_device(ioc, scmd))) {
 		scmd->result = DID_NO_CONNECT << 16;
 		scmd->scsi_done(scmd);
 		return 0;
@@ -9874,6 +9911,7 @@ static void scsih_remove(struct pci_dev *pdev)
 
 	/* release all the volumes */
 	_scsih_ir_shutdown(ioc);
+	sas_remove_host(shost);
 	list_for_each_entry_safe(raid_device, next, &ioc->raid_device_list,
 	    list) {
 		if (raid_device->starget) {
@@ -9916,7 +9954,6 @@ static void scsih_remove(struct pci_dev *pdev)
 		ioc->sas_hba.num_phys = 0;
 	}
 
-	sas_remove_host(shost);
 	mpt3sas_base_detach(ioc);
 	spin_lock(&gioc_lock);
 	list_del(&ioc->list);
diff --git a/drivers/scsi/mpt3sas/mpt3sas_transport.c b/drivers/scsi/mpt3sas/mpt3sas_transport.c
index b10d73e..742da74 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_transport.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_transport.c
@@ -817,10 +817,13 @@ mpt3sas_transport_port_remove(struct MPT3SAS_ADAPTER *ioc, u64 sas_address,
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

