Return-Path: <SRS0=y01v=7D=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50036C433DF
	for <linux-pci@archiver.kernel.org>; Thu, 21 May 2020 18:06:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C32820823
	for <linux-pci@archiver.kernel.org>; Thu, 21 May 2020 18:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590084362;
	bh=3meHT1q8fGypXlSNTy06UYH7exN4TK2HmUdxIAT9LCU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=l5x8Mzj/4tEAJW+Hu4pL23p8DIp3YDq+eOdTroH2CsmBVSw8D3+0RkaQ5qfuPmng1
	 Z/e5PF6ZEfS72PZpw4j+C3Pa6FYsIDnZjILCMPXBkevmlLYC63ENqA3fMQSr7RzL2I
	 XrDrpQGkoB3DSAsetDpkq/muqQD7XyE5GCNTxFU0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729029AbgEUSGB (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 21 May 2020 14:06:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:33266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728888AbgEUSGB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 21 May 2020 14:06:01 -0400
Received: from localhost (mobile-166-175-190-200.mycingular.net [166.175.190.200])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8D6A720738;
        Thu, 21 May 2020 18:06:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590084360;
        bh=3meHT1q8fGypXlSNTy06UYH7exN4TK2HmUdxIAT9LCU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MVl+kRNVwGw9BY5Ky3tp3LAQvOCPLiBvDcrQf/M6+Go9o5B8xggu83Qn6IxrDwfTe
         idwCeOgHYFtWXUXJhQ6ngby3sOfTm2aNqkJlnISRLk7CutaQ8abj2EIPiwg7XAu7Rd
         dl1Fje/b61FPu/uNEqcN+9zBftvTao1wmw5RrfA0=
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Klaus Doth <kdlnx@doth.eu>, Rui Feng <rui_feng@realsil.com.cn>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 1/6] misc: rtsx: Remove unused pcr_ops
Date:   Thu, 21 May 2020 13:05:40 -0500
Message-Id: <20200521180545.1159896-2-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200521180545.1159896-1-helgaas@kernel.org>
References: <20200521180545.1159896-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

Remove the following unused function pointers from struct pcr_ops:

  int (*set_ltr_latency)(struct rtsx_pcr *pcr, u32 latency);
  int (*set_l1off_sub)(struct rtsx_pcr *pcr, u8 val);
  void (*full_on)(struct rtsx_pcr *pcr);
  void (*power_saving)(struct rtsx_pcr *pcr);

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/misc/cardreader/rtsx_pcr.c | 15 +++------------
 include/linux/rtsx_pci.h           |  4 ----
 2 files changed, 3 insertions(+), 16 deletions(-)

diff --git a/drivers/misc/cardreader/rtsx_pcr.c b/drivers/misc/cardreader/rtsx_pcr.c
index 06038b325b02..7145de2504c2 100644
--- a/drivers/misc/cardreader/rtsx_pcr.c
+++ b/drivers/misc/cardreader/rtsx_pcr.c
@@ -85,10 +85,7 @@ static int rtsx_comm_set_ltr_latency(struct rtsx_pcr *pcr, u32 latency)
 
 int rtsx_set_ltr_latency(struct rtsx_pcr *pcr, u32 latency)
 {
-	if (pcr->ops->set_ltr_latency)
-		return pcr->ops->set_ltr_latency(pcr, latency);
-	else
-		return rtsx_comm_set_ltr_latency(pcr, latency);
+	return rtsx_comm_set_ltr_latency(pcr, latency);
 }
 
 static void rtsx_comm_set_aspm(struct rtsx_pcr *pcr, bool enable)
@@ -151,10 +148,7 @@ static void rtsx_comm_pm_full_on(struct rtsx_pcr *pcr)
 
 static void rtsx_pm_full_on(struct rtsx_pcr *pcr)
 {
-	if (pcr->ops->full_on)
-		pcr->ops->full_on(pcr);
-	else
-		rtsx_comm_pm_full_on(pcr);
+	rtsx_comm_pm_full_on(pcr);
 }
 
 void rtsx_pci_start_run(struct rtsx_pcr *pcr)
@@ -1108,10 +1102,7 @@ static void rtsx_comm_pm_power_saving(struct rtsx_pcr *pcr)
 
 static void rtsx_pm_power_saving(struct rtsx_pcr *pcr)
 {
-	if (pcr->ops->power_saving)
-		pcr->ops->power_saving(pcr);
-	else
-		rtsx_comm_pm_power_saving(pcr);
+	rtsx_comm_pm_power_saving(pcr);
 }
 
 static void rtsx_pci_idle_work(struct work_struct *work)
diff --git a/include/linux/rtsx_pci.h b/include/linux/rtsx_pci.h
index 65b8142a7fed..df86afb2b4fe 100644
--- a/include/linux/rtsx_pci.h
+++ b/include/linux/rtsx_pci.h
@@ -1080,11 +1080,7 @@ struct pcr_ops {
 	void		(*stop_cmd)(struct rtsx_pcr *pcr);
 
 	void (*set_aspm)(struct rtsx_pcr *pcr, bool enable);
-	int (*set_ltr_latency)(struct rtsx_pcr *pcr, u32 latency);
-	int (*set_l1off_sub)(struct rtsx_pcr *pcr, u8 val);
 	void (*set_l1off_cfg_sub_d0)(struct rtsx_pcr *pcr, int active);
-	void (*full_on)(struct rtsx_pcr *pcr);
-	void (*power_saving)(struct rtsx_pcr *pcr);
 	void (*enable_ocp)(struct rtsx_pcr *pcr);
 	void (*disable_ocp)(struct rtsx_pcr *pcr);
 	void (*init_ocp)(struct rtsx_pcr *pcr);
-- 
2.25.1

