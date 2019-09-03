Return-Path: <SRS0=pntK=W6=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E48DC3A5A7
	for <linux-pci@archiver.kernel.org>; Tue,  3 Sep 2019 11:10:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00DC82339D
	for <linux-pci@archiver.kernel.org>; Tue,  3 Sep 2019 11:10:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728860AbfICLKu (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 3 Sep 2019 07:10:50 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52522 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727667AbfICLKt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 Sep 2019 07:10:49 -0400
Received: by mail-wm1-f68.google.com with SMTP id t17so17681487wmi.2;
        Tue, 03 Sep 2019 04:10:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/JZWeFamsO4Isg/LD+2KIcQomVjj1vItid4mxiHlSfQ=;
        b=jh65utJL2OReMNC5QeoCnDZLvJzjCWQGwYy51LW5Cehg/YQC5yDcpE9u5ZUcp+sM22
         VS8yVusdMEbN6aCRLCaYObHyBUS3RoJZdrP/DUhSk9jLOl2KHFZiylMRbUWu/n5L0ceI
         sD7KuFJGKKvDxcQQrGrb59dFEzOgcGwCOWV1Ilk/4F5X7MWXoM1kLblvlbMR4LKeIV7A
         +pANvddiDjYbCsQR7N+MW3Go0oa+285FVP3jQ1mlE/YTtZm51oWAW4bTp0KYacJ3699L
         ug3w0cH+dlNV8BS55WQcWaIdUwHu8JzZxhH5j9Ms1NjgW9M2LwYt1yLcgsPc2WyaTcwA
         PLmA==
X-Gm-Message-State: APjAAAWmeyrqGbngUGLl5HwVt2Zyb2mKZOB48iQjibiaTn4379Dxpt9U
        XxSk/L1y9y5dpPRqjeDCpnYAkPCt
X-Google-Smtp-Source: APXvYqzcdB7i0kpa39goRE4oXcTqkb9IrnFabUOMTcUV64ZcIiCgrOHwqGgg1hFodzxEVHKP4sjAzw==
X-Received: by 2002:a1c:4b14:: with SMTP id y20mr9401219wma.10.1567509046689;
        Tue, 03 Sep 2019 04:10:46 -0700 (PDT)
Received: from black.home (broadband-188-32-48-208.ip.moscow.rt.ru. [188.32.48.208])
        by smtp.googlemail.com with ESMTPSA id w12sm4363572wrg.47.2019.09.03.04.10.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2019 04:10:46 -0700 (PDT)
From:   Denis Efremov <efremov@linux.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Denis Efremov <efremov@linux.com>, Lukas Wunner <lukas@wunner.de>,
        linux-pci@vger.kernel.org,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Oliver O'Halloran <oohall@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/4] PCI: pciehp: Switch LED indicators with a single write
Date:   Tue,  3 Sep 2019 14:10:19 +0300
Message-Id: <20190903111021.1559-3-efremov@linux.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190903111021.1559-1-efremov@linux.com>
References: <20190903111021.1559-1-efremov@linux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This patch replaces all consecutive switches of power and attention
indicators with pciehp_set_indicators() call. Thus, performing only
single write to a register.

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Reviewed-by: Lukas Wunner <lukas@wunner.de>
Signed-off-by: Denis Efremov <efremov@linux.com>
---
 drivers/pci/hotplug/pciehp_ctrl.c | 19 ++++++++++---------
 drivers/pci/hotplug/pciehp_hpc.c  |  4 ++--
 2 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp_ctrl.c b/drivers/pci/hotplug/pciehp_ctrl.c
index 631ced0ab28a..232f7bfcfce9 100644
--- a/drivers/pci/hotplug/pciehp_ctrl.c
+++ b/drivers/pci/hotplug/pciehp_ctrl.c
@@ -42,8 +42,8 @@ static void set_slot_off(struct controller *ctrl)
 		msleep(1000);
 	}
 
-	pciehp_green_led_off(ctrl);
-	pciehp_set_attention_status(ctrl, 1);
+	pciehp_set_indicators(ctrl, PCI_EXP_SLTCTL_PWR_IND_OFF,
+			      PCI_EXP_SLTCTL_ATTN_IND_ON);
 }
 
 /**
@@ -90,8 +90,8 @@ static int board_added(struct controller *ctrl)
 		}
 	}
 
-	pciehp_green_led_on(ctrl);
-	pciehp_set_attention_status(ctrl, 0);
+	pciehp_set_indicators(ctrl, PCI_EXP_SLTCTL_PWR_IND_ON,
+			      PCI_EXP_SLTCTL_ATTN_IND_OFF);
 	return 0;
 
 err_exit:
@@ -172,8 +172,8 @@ void pciehp_handle_button_press(struct controller *ctrl)
 				  slot_name(ctrl));
 		}
 		/* blink green LED and turn off amber */
-		pciehp_green_led_blink(ctrl);
-		pciehp_set_attention_status(ctrl, 0);
+		pciehp_set_indicators(ctrl, PCI_EXP_SLTCTL_PWR_IND_BLINK,
+				      PCI_EXP_SLTCTL_ATTN_IND_OFF);
 		schedule_delayed_work(&ctrl->button_work, 5 * HZ);
 		break;
 	case BLINKINGOFF_STATE:
@@ -187,12 +187,13 @@ void pciehp_handle_button_press(struct controller *ctrl)
 		cancel_delayed_work(&ctrl->button_work);
 		if (ctrl->state == BLINKINGOFF_STATE) {
 			ctrl->state = ON_STATE;
-			pciehp_green_led_on(ctrl);
+			pciehp_set_indicators(ctrl, PCI_EXP_SLTCTL_PWR_IND_ON,
+					      PCI_EXP_SLTCTL_ATTN_IND_OFF);
 		} else {
 			ctrl->state = OFF_STATE;
-			pciehp_green_led_off(ctrl);
+			pciehp_set_indicators(ctrl, PCI_EXP_SLTCTL_PWR_IND_OFF,
+					      PCI_EXP_SLTCTL_ATTN_IND_OFF);
 		}
-		pciehp_set_attention_status(ctrl, 0);
 		ctrl_info(ctrl, "Slot(%s): Action canceled due to button press\n",
 			  slot_name(ctrl));
 		break;
diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index 4d0fe39ef049..d2c60d844d30 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -659,8 +659,8 @@ static irqreturn_t pciehp_ist(int irq, void *dev_id)
 	if ((events & PCI_EXP_SLTSTA_PFD) && !ctrl->power_fault_detected) {
 		ctrl->power_fault_detected = 1;
 		ctrl_err(ctrl, "Slot(%s): Power fault\n", slot_name(ctrl));
-		pciehp_set_attention_status(ctrl, 1);
-		pciehp_green_led_off(ctrl);
+		pciehp_set_indicators(ctrl, PCI_EXP_SLTCTL_PWR_IND_OFF,
+				      PCI_EXP_SLTCTL_ATTN_IND_ON);
 	}
 
 	/*
-- 
2.21.0

