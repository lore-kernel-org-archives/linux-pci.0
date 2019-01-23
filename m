Return-Path: <SRS0=s0ql=P7=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F592C282C2
	for <linux-pci@archiver.kernel.org>; Wed, 23 Jan 2019 13:18:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B8A12184B
	for <linux-pci@archiver.kernel.org>; Wed, 23 Jan 2019 13:18:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jFXvnEsF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726122AbfAWNSk (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 23 Jan 2019 08:18:40 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33078 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725991AbfAWNSk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Jan 2019 08:18:40 -0500
Received: by mail-pg1-f196.google.com with SMTP id z11so1090653pgu.0;
        Wed, 23 Jan 2019 05:18:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=y7IiTSYYlGgYVlFk/LzudBlD3TUdLxmGnj3nQr8qGSI=;
        b=jFXvnEsFGWsPvxoAiipPwqMdnC2T9sguh/rvj7aznT5m2/tpON/hQA0PUHIBML/um4
         HcBTK7uRqSmf9get99ewORFrNodT+Iy0x7xWw9FsRwdEkWrMSMBlB5WRJoI24PDi8RSR
         Ea3ltIjfV032J0gzXBzIyJIoSC3ZsLrVWRNDs51egcgoP2qwPVLY4ZytuZy40IluphuQ
         nyP0t+b8PoGaLQiNrQBVM9cjQ+H4a1qWG1Vavo4oZjak4leOkZykRJyMVrWnT8OAfru6
         nTZD/akLeY4QYnU2pjXBD1c1iNgfu9rszd5v5GwMRTCAyQH4Bhn2yYyStDQLO0B2xgZ5
         YHiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=y7IiTSYYlGgYVlFk/LzudBlD3TUdLxmGnj3nQr8qGSI=;
        b=t37OE+W5nZ+4g/OSvHu86pcUWtTfCwjaW+VY+B+zQGpBgYunNld8H/NAGZ3TtA3Tnd
         EMU8juePX8klnud0LwowQQt4d+oYIQdXtF4hoZA6yLwoxWrytujiUcIrxCduPooIx1TJ
         OqkZEoNylDOqWzWtvABQaJakU7feAcqTiio2CRAj5+wGpF3+jrG5BI/r07tSetWayKMq
         hf32L2kP9SpKymQbbqt221Aq5FxIu0vexVoujQY7AvYtCCV4NJQ7c9jsYYj183CHNk4z
         h/oUWgJqxbpsC1siWlxcdHCcxrer8L9MilRAnIPkVg8mOLyGiSCpER2UayVyfpR6outO
         dWbw==
X-Gm-Message-State: AJcUukclomC+gHALPGjjenHaIhlhXge2FdiNkdnaFY9R58oxdmlF3cA9
        L/X5DPHJEC7UJCt5hKCl2ozpng1Y
X-Google-Smtp-Source: ALg8bN7PJsvu+W8xVRPufG/J34rFIxdmAtRV23/qQxIIsYAqCi8yShkipG+SJH7P26KwUelTgk7N0w==
X-Received: by 2002:a63:184a:: with SMTP id 10mr1913288pgy.81.1548249519576;
        Wed, 23 Jan 2019 05:18:39 -0800 (PST)
Received: from hyd1358.caveonetworks.com. ([115.113.156.2])
        by smtp.googlemail.com with ESMTPSA id r187sm64600381pfc.63.2019.01.23.05.18.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Jan 2019 05:18:39 -0800 (PST)
From:   sundeep.lkml@gmail.com
To:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     sean.stalley@intel.com, sgoutham@marvell.com, helgaas@kernel.org,
        Subbaraya Sundeep <sbhatta@marvell.com>
Subject: [v3 PATCH 2/2] PCI: assign bus numbers present in EA capability for bridges
Date:   Wed, 23 Jan 2019 18:48:01 +0530
Message-Id: <1548249481-24645-2-git-send-email-sundeep.lkml@gmail.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1548249481-24645-1-git-send-email-sundeep.lkml@gmail.com>
References: <1548249481-24645-1-git-send-email-sundeep.lkml@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Subbaraya Sundeep <sbhatta@marvell.com>

As per the spec - ECN_Enhanced_Allocation_23_Oct_2014_Final
and section 6.9.1.2, bridges with EA capability work with fixed
secondary and subordinate bus numbers. Hence consider assigning
bus numbers to bridges from EA if the capability exists during
the scan.

Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
---
v3:
  removed function for reading fixed bus numbers
  instead those were captured in pci_ea_init
v2:
  None just added Sean

 drivers/pci/probe.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 257b9f6..9215e2e 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1064,6 +1064,7 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
 	u16 bctl;
 	u8 primary, secondary, subordinate;
 	int broken = 0;
+	int next_busnr;
 
 	/*
 	 * Make sure the bridge is powered on to be able to access config
@@ -1163,17 +1164,21 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
 		/* Clear errors */
 		pci_write_config_word(dev, PCI_STATUS, 0xffff);
 
+		next_busnr = max + 1;
+		/* Fixed secondary bus number from EA capability */
+		if (dev->fixed_sec_busnr)
+			next_busnr = dev->fixed_sec_busnr;
 		/*
 		 * Prevent assigning a bus number that already exists.
 		 * This can happen when a bridge is hot-plugged, so in this
 		 * case we only re-scan this bus.
 		 */
-		child = pci_find_bus(pci_domain_nr(bus), max+1);
+		child = pci_find_bus(pci_domain_nr(bus), next_busnr);
 		if (!child) {
-			child = pci_add_new_bus(bus, dev, max+1);
+			child = pci_add_new_bus(bus, dev, next_busnr);
 			if (!child)
 				goto out;
-			pci_bus_insert_busn_res(child, max+1,
+			pci_bus_insert_busn_res(child, next_busnr,
 						bus->busn_res.end);
 		}
 		max++;
@@ -1234,7 +1239,13 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
 			max += i;
 		}
 
-		/* Set subordinate bus number to its real value */
+		/*
+		 * Set subordinate bus number to its real value.
+		 * If fixed subordinate bus number exists from EA
+		 * capability then use it.
+		 */
+		if (dev->fixed_sub_busnr)
+			max = dev->fixed_sub_busnr;
 		pci_bus_update_busn_res_end(child, max);
 		pci_write_config_byte(dev, PCI_SUBORDINATE_BUS, max);
 	}
-- 
1.8.3.1

