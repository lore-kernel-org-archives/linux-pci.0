Return-Path: <SRS0=uEhh=YS=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CCD6CA9EA0
	for <linux-pci@archiver.kernel.org>; Fri, 25 Oct 2019 19:01:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1A9821D81
	for <linux-pci@archiver.kernel.org>; Fri, 25 Oct 2019 19:01:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TD84hYL8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729353AbfJYTBC (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 25 Oct 2019 15:01:02 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:42309 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbfJYTBB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 25 Oct 2019 15:01:01 -0400
Received: by mail-oi1-f196.google.com with SMTP id i185so2288571oif.9;
        Fri, 25 Oct 2019 12:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZGAwrWZgsty9clvwOGUkdUA2YOhaXXaSo85YzV6o32E=;
        b=TD84hYL8dXownyhIRGQ6Lz4qNy9OtOmSZU+TYDoXgBajq4NuVqDdXxeFw0SBNFEers
         Kcl3RScDT239I30Ii+h9a5rpckGd5FkRFVvI000RC83BlNy+Tqfo/h0p71VMPlceqNp5
         uIZYP2GDPePDXaL4Z+D8oyZM5qeJFbIGliYlh+meiR/rpSIzQU1NbhuPW9YSnSRZV96L
         j6iBYDZtqXze0vk9LGIQsDkodL/uM41qLWFX8+ksCy9dTaB4yu+QJY2MTi2+4GggqGcw
         5MUsgXScor/zbCIrveB+Nblwt1ScpJAFZ+dnAvpHH6l898AjgREfH1f+YsE7t8LF/kgq
         470Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZGAwrWZgsty9clvwOGUkdUA2YOhaXXaSo85YzV6o32E=;
        b=jFT7RJtlH6ml6869lcdWApd6++LyHkZqJ7I6sK9LuWGlQwVHXQGdCzTEMTZrE9xo5+
         TGwk43BKZLhf3QVoCGD8HuwwlCEOmyrJfMYVlxn/X69xV47kobbDOtnWdqxVbpdjjxjL
         zZEWo55g4y7mVn7dOEv2uPoKUNHWR3Wc8MVmtOca+W6ppnDVtHKX8yA5hAMGXQNwR4hj
         XGxREk7ETMOA5/roilv3y5z1n8xovxZtjgwKk+EdRlxK850JwJcl4UmZ2oxT1AporsD1
         c/szV3rgGRhk9PlsCRc1WihAL+7g0JyK21aJxQ360jeKSnpWd9diX/KDUFcl62nWDxJa
         54PQ==
X-Gm-Message-State: APjAAAXw9ZVj2a88G3jxzm7EtQw4wObHnCm6pKWonEkEexwmc7PzzVrw
        CsDA6h6UCv6HvUQ2/PWIWxM=
X-Google-Smtp-Source: APXvYqzQV+Rvxn24G4NO3C5hZVxdhp0q8NHAZF7HdWtQFO78njICcIHmjC7vdG6Gdfq0CorQDTreRw==
X-Received: by 2002:aca:3305:: with SMTP id z5mr4393147oiz.68.1572030060624;
        Fri, 25 Oct 2019 12:01:00 -0700 (PDT)
Received: from localhost.localdomain ([143.166.81.254])
        by smtp.gmail.com with ESMTPSA id 21sm748039oix.31.2019.10.25.12.00.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2019 12:01:00 -0700 (PDT)
From:   Stuart Hayes <stuart.w.hayes@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Austin Bolen <austin_bolen@dell.com>, keith.busch@intel.com,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
        Sinan Kaya <okaya@kernel.org>,
        Oza Pawandeep <poza@codeaurora.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, lukas@wunner.de,
        Stuart Hayes <stuart.w.hayes@gmail.com>
Subject: [PATCH v4 3/3] PCI: pciehp: Add dmi table for in-band presence disabled
Date:   Fri, 25 Oct 2019 15:00:47 -0400
Message-Id: <20191025190047.38130-4-stuart.w.hayes@gmail.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20191025190047.38130-1-stuart.w.hayes@gmail.com>
References: <20191025190047.38130-1-stuart.w.hayes@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Some systems have in-band presence detection disabled for hot-plug PCI
slots, but do not report this in the slot capabilities 2 (SLTCAP2) register.
On these systems, presence detect can become active well after the link is
reported to be active, which can cause the slots to be disabled after a
device is connected.

Add a dmi table to flag these systems as having in-band presence disabled.

Signed-off-by: Stuart Hayes <stuart.w.hayes@gmail.com>
---
v4
  add comment to dmi table

 drivers/pci/hotplug/pciehp_hpc.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index 02d95ab27a12..9541735bd0aa 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -14,6 +14,7 @@
 
 #define dev_fmt(fmt) "pciehp: " fmt
 
+#include <linux/dmi.h>
 #include <linux/kernel.h>
 #include <linux/types.h>
 #include <linux/jiffies.h>
@@ -26,6 +27,24 @@
 #include "../pci.h"
 #include "pciehp.h"
 
+static const struct dmi_system_id inband_presence_disabled_dmi_table[] = {
+	/*
+	 * Match all Dell systems, as some Dell systems have inband
+	 * presence disabled on NVMe slots (but don't support the bit to
+	 * report it). Setting inband presence disabled should have no
+	 * negative effect, except on broken hotplug slots that never
+	 * assert presence detect--and those will still work, they will
+	 * just have a bit of extra delay before being probed.
+	 */
+	{
+		.ident = "Dell System",
+		.matches = {
+			DMI_MATCH(DMI_OEM_STRING, "Dell System"),
+		},
+	},
+	{}
+};
+
 static inline struct pci_dev *ctrl_dev(struct controller *ctrl)
 {
 	return ctrl->pcie->port;
@@ -895,6 +914,9 @@ struct controller *pcie_init(struct pcie_device *dev)
 		ctrl->inband_presence_disabled = 1;
 	}
 
+	if (dmi_first_match(inband_presence_disabled_dmi_table))
+		ctrl->inband_presence_disabled = 1;
+
 	/*
 	 * If empty slot's power status is on, turn power off.  The IRQ isn't
 	 * requested yet, so avoid triggering a notification with this command.
-- 
2.18.1

