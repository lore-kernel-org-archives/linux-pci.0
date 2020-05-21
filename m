Return-Path: <SRS0=y01v=7D=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0015CC433E0
	for <linux-pci@archiver.kernel.org>; Thu, 21 May 2020 18:06:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6AB920823
	for <linux-pci@archiver.kernel.org>; Thu, 21 May 2020 18:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590084410;
	bh=LPEY7GPvQkzuyjPiKXL++uc96ILoo2loJJZuOX38gZk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BH45hglbXZPttaZq4tKx9bbYo4hiZixuF910g6e7Xqf0A/9ZYklyc2oHQSPuorINc
	 IDpPc48tD1kbNZvI1UyRv1BSla/cKDV/KUCBXZXqaM347nFBEOKA/35fIMawgJm5FQ
	 7Y0le50I4QRPfcrF3MU58j8ITNABIOjkYIJBlPvI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729497AbgEUSGu (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 21 May 2020 14:06:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:34106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728885AbgEUSGu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 21 May 2020 14:06:50 -0400
Received: from localhost (mobile-166-175-190-200.mycingular.net [166.175.190.200])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1A6A0207D3;
        Thu, 21 May 2020 18:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590084409;
        bh=LPEY7GPvQkzuyjPiKXL++uc96ILoo2loJJZuOX38gZk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AjBFDwH864EULtwUrWLbjtwaG3GQPFCPbYarYowPg5OkllOH/ZRLXmJ7z4FrKZW1H
         SNAO+zc35uEzVyniPGsFCZRp/mIzrzsn5eOfpWI1dv7Tnecr2JijUtw9JYMtyDsPLw
         alrcsRgXB7UZUzf6uN4gAxy9+GmOCa2ydd8RL4nw=
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Klaus Doth <kdlnx@doth.eu>, Rui Feng <rui_feng@realsil.com.cn>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 4/6] misc: rtsx: Use pcie_capability_clear_and_set_word() for PCI_EXP_LNKCTL
Date:   Thu, 21 May 2020 13:05:43 -0500
Message-Id: <20200521180545.1159896-5-helgaas@kernel.org>
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

Instead of using the driver-specific rtsx_pci_update_cfg_byte() to update
the PCIe Link Control Register, use pcie_capability_clear_and_set_word()
like the rest of the kernel does.  This makes it easier to maintain ASPM
across the PCI core and drivers.

Remove the now-unused rtsx_pci_update_cfg_byte() and ASPM_MASK_NEG
definitions.

No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/misc/cardreader/rts5249.c  |  9 +++------
 drivers/misc/cardreader/rts5260.c  |  9 +++------
 drivers/misc/cardreader/rts5261.c  | 14 ++++----------
 drivers/misc/cardreader/rtsx_pcr.c |  8 ++++----
 drivers/misc/cardreader/rtsx_pcr.h |  1 -
 include/linux/rtsx_pci.h           | 12 ------------
 6 files changed, 14 insertions(+), 39 deletions(-)

diff --git a/drivers/misc/cardreader/rts5249.c b/drivers/misc/cardreader/rts5249.c
index 5171fdd92f3c..d122608e9f79 100644
--- a/drivers/misc/cardreader/rts5249.c
+++ b/drivers/misc/cardreader/rts5249.c
@@ -349,15 +349,12 @@ static int rtsx_base_switch_output_voltage(struct rtsx_pcr *pcr, u8 voltage)
 
 static void rts5249_set_aspm(struct rtsx_pcr *pcr, bool enable)
 {
-	u8 val = 0;
-
 	if (pcr->aspm_enabled == enable)
 		return;
 
-	if (enable)
-		val = pcr->aspm_en;
-	rtsx_pci_update_cfg_byte(pcr, pcr->pcie_cap + PCI_EXP_LNKCTL,
-				 ASPM_MASK_NEG, val);
+	pcie_capability_clear_and_set_word(pcr->pci, PCI_EXP_LNKCTL,
+					   PCI_EXP_LNKCTL_ASPMC,
+					   enable ? pcr->aspm_en : 0);
 
 	pcr->aspm_enabled = enable;
 }
diff --git a/drivers/misc/cardreader/rts5260.c b/drivers/misc/cardreader/rts5260.c
index b4c1386382ea..75fc67d78d7f 100644
--- a/drivers/misc/cardreader/rts5260.c
+++ b/drivers/misc/cardreader/rts5260.c
@@ -572,15 +572,12 @@ static int rts5260_extra_init_hw(struct rtsx_pcr *pcr)
 
 static void rts5260_set_aspm(struct rtsx_pcr *pcr, bool enable)
 {
-	u8 val = 0;
-
 	if (pcr->aspm_enabled == enable)
 		return;
 
-	if (enable)
-		val = pcr->aspm_en;
-	rtsx_pci_update_cfg_byte(pcr, pcr->pcie_cap + PCI_EXP_LNKCTL,
-				 ASPM_MASK_NEG, val);
+	pcie_capability_clear_and_set_word(pcr->pci, PCI_EXP_LNKCTL,
+					   PCI_EXP_LNKCTL_ASPMC,
+					   enable ?  pcr->aspm : 0);
 
 	pcr->aspm_enabled = enable;
 }
diff --git a/drivers/misc/cardreader/rts5261.c b/drivers/misc/cardreader/rts5261.c
index 807ffbd9c06d..5bf59957b31e 100644
--- a/drivers/misc/cardreader/rts5261.c
+++ b/drivers/misc/cardreader/rts5261.c
@@ -518,28 +518,22 @@ static int rts5261_extra_init_hw(struct rtsx_pcr *pcr)
 
 static void rts5261_enable_aspm(struct rtsx_pcr *pcr, bool enable)
 {
-	u8 val = 0;
-
 	if (pcr->aspm_enabled == enable)
 		return;
 
-	val = pcr->aspm_en;
-	rtsx_pci_update_cfg_byte(pcr, pcr->pcie_cap + PCI_EXP_LNKCTL,
-				 ASPM_MASK_NEG, val);
+	pcie_capability_clear_and_set_word(pcr->pci, PCI_EXP_LNKCTL,
+					   PCI_EXP_LNKCTL_ASPMC, pcr->aspm_en);
 	pcr->aspm_enabled = enable;
 
 }
 
 static void rts5261_disable_aspm(struct rtsx_pcr *pcr, bool enable)
 {
-	u8 val = 0;
-
 	if (pcr->aspm_enabled == enable)
 		return;
 
-	val = 0;
-	rtsx_pci_update_cfg_byte(pcr, pcr->pcie_cap + PCI_EXP_LNKCTL,
-				 ASPM_MASK_NEG, val);
+	pcie_capability_clear_and_set_word(pcr->pci, PCI_EXP_LNKCTL,
+					   PCI_EXP_LNKCTL_ASPMC, 0);
 	rtsx_pci_write_register(pcr, SD_CFG1, SD_ASYNC_FIFO_NOT_RST, 0);
 	udelay(10);
 	pcr->aspm_enabled = enable;
diff --git a/drivers/misc/cardreader/rtsx_pcr.c b/drivers/misc/cardreader/rtsx_pcr.c
index afde5499bfb6..a8ce9c3744be 100644
--- a/drivers/misc/cardreader/rtsx_pcr.c
+++ b/drivers/misc/cardreader/rtsx_pcr.c
@@ -57,14 +57,14 @@ MODULE_DEVICE_TABLE(pci, rtsx_pci_ids);
 
 static inline void rtsx_pci_enable_aspm(struct rtsx_pcr *pcr)
 {
-	rtsx_pci_update_cfg_byte(pcr, pcr->pcie_cap + PCI_EXP_LNKCTL,
-		ASPM_MASK_NEG, pcr->aspm_en);
+	pcie_capability_clear_and_set_word(pcr->pci, PCI_EXP_LNKCTL,
+					   PCI_EXP_LNKCTL_ASPMC, pcr->aspm_en);
 }
 
 static inline void rtsx_pci_disable_aspm(struct rtsx_pcr *pcr)
 {
-	rtsx_pci_update_cfg_byte(pcr, pcr->pcie_cap + PCI_EXP_LNKCTL,
-		ASPM_MASK_NEG, 0);
+	pcie_capability_clear_and_set_word(pcr->pci, PCI_EXP_LNKCTL,
+					   PCI_EXP_LNKCTL_ASPMC, 0);
 }
 
 static int rtsx_comm_set_ltr_latency(struct rtsx_pcr *pcr, u32 latency)
diff --git a/drivers/misc/cardreader/rtsx_pcr.h b/drivers/misc/cardreader/rtsx_pcr.h
index ed391df52f4f..024cbd998b2a 100644
--- a/drivers/misc/cardreader/rtsx_pcr.h
+++ b/drivers/misc/cardreader/rtsx_pcr.h
@@ -29,7 +29,6 @@
 #define LTR_L1OFF_SNOOZE_SSPWRGATE_5249_DEF	0xAC
 #define LTR_L1OFF_SNOOZE_SSPWRGATE_5250_DEF	0xF8
 #define CMD_TIMEOUT_DEF		100
-#define ASPM_MASK_NEG		0xFC
 #define MASK_8_BIT_DEF		0xFF
 
 #define SSC_CLOCK_STABLE_WAIT	130
diff --git a/include/linux/rtsx_pci.h b/include/linux/rtsx_pci.h
index a75132a0cf8f..e8780d4e4636 100644
--- a/include/linux/rtsx_pci.h
+++ b/include/linux/rtsx_pci.h
@@ -1307,18 +1307,6 @@ static inline u8 *rtsx_pci_get_cmd_data(struct rtsx_pcr *pcr)
 	return (u8 *)(pcr->host_cmds_ptr);
 }
 
-static inline int rtsx_pci_update_cfg_byte(struct rtsx_pcr *pcr, int addr,
-		u8 mask, u8 append)
-{
-	int err;
-	u8 val;
-
-	err = pci_read_config_byte(pcr->pci, addr, &val);
-	if (err < 0)
-		return err;
-	return pci_write_config_byte(pcr->pci, addr, (val & mask) | append);
-}
-
 static inline void rtsx_pci_write_be32(struct rtsx_pcr *pcr, u16 reg, u32 val)
 {
 	rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, reg,     0xFF, val >> 24);
-- 
2.25.1

