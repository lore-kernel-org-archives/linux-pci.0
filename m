Return-Path: <SRS0=j1yu=SW=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B05F9C282DD
	for <linux-pci@archiver.kernel.org>; Sat, 20 Apr 2019 04:04:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7998621855
	for <linux-pci@archiver.kernel.org>; Sat, 20 Apr 2019 04:04:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cOT0Kz5L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725911AbfDTEEB (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sat, 20 Apr 2019 00:04:01 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:37400 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725910AbfDTEEA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 20 Apr 2019 00:04:00 -0400
Received: by mail-lf1-f65.google.com with SMTP id o19so5250512lfl.4;
        Fri, 19 Apr 2019 21:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=W7EuQ38Jk5ir6uq2mAZGOW3QIER8a/X6pBTKduTAxU0=;
        b=cOT0Kz5LDOzXz2f4n/ryXXvF89jL5Zy7fwTSex89VHz5rJHMUS6LsUFwrazN+bPUM9
         dg5MbYjN4UFqUL/YczbI9ZmwYdoAjiepF/c9e2hOjaxu1lq/U2E4Ta1OS9UxShuJRlMj
         Kx504f+IlzsV0mIGnz8WbmcW+xPPVEwDcP4e7nybULJ9ukcStQrCoRCbCB/2vvnAuEZx
         XFNMOhkskGCfSdh3aQ/grOmyVU7lKQfZfEYi/iTgg1oy8M1oh3akr1ClSQeBRnrLKtS/
         J9Rx44TilvwWJR3xDnkiw1zIjGw4C1K+WRH/WxcrfruCypUApT+uUc3WY2HL1LCYEL4I
         Gy6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=W7EuQ38Jk5ir6uq2mAZGOW3QIER8a/X6pBTKduTAxU0=;
        b=nVPnHlAQGz0rBqI8DdY0oxtAifzDUiPzxkC8Nex/a5NVP/vENZVwnhjFAIO+QRpPjY
         gCaUm19Rr+MlYSc4Y0uDElwEUEl4cqNcHnuOY0q3JjTSuWfgH8B9w6gsftWNIuJ69ODs
         dISj2R/5rv+5I1NI3Lni3a3fmTk/0v71TnLqI23CgW4JKKWkGxbZ3YltZZLG6zaBfLTt
         L+dQoXzWrBTgVGm9PKqtntVkJ3y6xRhd32cPCnh2DBAgPujRObSlCKO30XgSCRcO9523
         xdrrkZsaC40ni9mw5BlL+J/kP6QGqG9gs1jZmHA7ifo3hfrMAFXPkD8uH5rlMeUyPcg1
         tujQ==
X-Gm-Message-State: APjAAAXq9LTaL9tejEAWwOzX/x2asUgRRpLyUDWTOZ+/8w7N/utIvTaL
        q51ZfMwagBg6v+RT/zd8bGA=
X-Google-Smtp-Source: APXvYqzqmBc0b7EyiVkU95u1ViIKH3O9RtfeKCGUvfFIwixXqpOM3PBF0+AGuSYtDdrZ//GqKyxHYw==
X-Received: by 2002:ac2:5a11:: with SMTP id q17mr4042073lfn.145.1555733038211;
        Fri, 19 Apr 2019 21:03:58 -0700 (PDT)
Received: from localhost.localdomain (93-96-157.netrun.cytanet.com.cy. [93.109.96.157])
        by smtp.gmail.com with ESMTPSA id s2sm1551503lfp.20.2019.04.19.21.03.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 19 Apr 2019 21:03:57 -0700 (PDT)
From:   Mohan Kumar <mohankumar718@gmail.com>
To:     rjw@rjwysocki.net
Cc:     lenb@kernel.org, bhelgaas@google.com, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] PCI: Cleanup printk logging
Date:   Sat, 20 Apr 2019 07:03:46 +0300
Message-Id: <1555733026-19609-1-git-send-email-mohankumar718@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Replace printk with pr_* to avoid checkpatch warnings.

Signed-off-by: Mohan Kumar <mohankumar718@gmail.com>
---
 drivers/pci/pci-acpi.c | 11 ++++-------
 drivers/pci/quirks.c   |  2 +-
 2 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index e1949f7..3ada026 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -140,8 +140,7 @@ static acpi_status decode_type0_hpx_record(union acpi_object *record,
 		hpx->t0->enable_perr     = fields[5].integer.value;
 		break;
 	default:
-		printk(KERN_WARNING
-		       "%s: Type 0 Revision %d record not supported\n",
+		pr_warn("%s: Type 0 Revision %d record not supported\n",
 		       __func__, revision);
 		return AE_ERROR;
 	}
@@ -169,8 +168,7 @@ static acpi_status decode_type1_hpx_record(union acpi_object *record,
 		hpx->t1->tot_max_split = fields[4].integer.value;
 		break;
 	default:
-		printk(KERN_WARNING
-		       "%s: Type 1 Revision %d record not supported\n",
+		pr_warn("%s: Type 1 Revision %d record not supported\n",
 		       __func__, revision);
 		return AE_ERROR;
 	}
@@ -211,8 +209,7 @@ static acpi_status decode_type2_hpx_record(union acpi_object *record,
 		hpx->t2->sec_unc_err_mask_or   = fields[17].integer.value;
 		break;
 	default:
-		printk(KERN_WARNING
-		       "%s: Type 2 Revision %d record not supported\n",
+		pr_warn("%s: Type 2 Revision %d record not supported\n",
 		       __func__, revision);
 		return AE_ERROR;
 	}
@@ -272,7 +269,7 @@ static acpi_status acpi_run_hpx(acpi_handle handle, struct hotplug_params *hpx)
 				goto exit;
 			break;
 		default:
-			printk(KERN_ERR "%s: Type %d record not supported\n",
+			pr_err("%s: Type %d record not supported\n",
 			       __func__, type);
 			status = AE_ERROR;
 			goto exit;
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index f9cd4d4..06af0c3 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -2613,7 +2613,7 @@ static void nvbridge_check_legacy_irq_routing(struct pci_dev *dev)
 	pci_read_config_dword(dev, 0x74, &cfg);
 
 	if (cfg & ((1 << 2) | (1 << 15))) {
-		printk(KERN_INFO "Rewriting IRQ routing register on MCP55\n");
+		pr_info("Rewriting IRQ routing register on MCP55\n");
 		cfg &= ~((1 << 2) | (1 << 15));
 		pci_write_config_dword(dev, 0x74, cfg);
 	}
-- 
2.7.4

