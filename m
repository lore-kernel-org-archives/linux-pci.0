Return-Path: <SRS0=vzDi=QP=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B93AC169C4
	for <linux-pci@archiver.kernel.org>; Fri,  8 Feb 2019 16:24:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD1AF2084D
	for <linux-pci@archiver.kernel.org>; Fri,  8 Feb 2019 16:24:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XIVFiS8I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727139AbfBHQY2 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 8 Feb 2019 11:24:28 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:35493 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726522AbfBHQY1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 8 Feb 2019 11:24:27 -0500
Received: by mail-it1-f196.google.com with SMTP id r6so10283340itk.0;
        Fri, 08 Feb 2019 08:24:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CKsceA5iPCGK4z0HB5rNefLzAM6T95Spw0/oJusSaSU=;
        b=XIVFiS8I4nJAXERJxlHwRKu+FWWioUL/8LT/F12RysZsDHtfFSKygeAGCotNArJgIc
         JOyQsmpSXW4hl/AO/FURSEXLzP2Je5sDw0ybVClnLeLMCJ1ZWPrNSDz+etuvu8yKhMAU
         03p5Ym+KPuaZY6ewxuSAfIyXxrt+QC4KKfAqLXs4Aw8zXx4scG4XiNE60x5OrFfXm8Kg
         6b0xWySMpJ0JtBkQuIb2ot0y7jKh36sSRbEvX6dvf7yxAf8IoQyNj1nMK9nPhW5j0AC5
         GFmwjX5qBN97NwMTtGcNSRx7LrBKptzBl2Sl3V6td6BgYI1EoxtWHo9YYyIFqTYoK0zY
         immw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CKsceA5iPCGK4z0HB5rNefLzAM6T95Spw0/oJusSaSU=;
        b=W9GmxBx58Y1DsQxTV3IHb9JdEUMhwtRj4t2Kg/wNxCOTF7xvmFmKx3cxSw5J6H6nFF
         4yAOmq65oILtqCX6QUqQN1xIGVatRjoRl1rJkU/RSzq8/0xg48oOPw3E270IvbPOdryg
         qYDAuOMag9hTHEEupxcHj7D4OYU3gQtE+TCuD3TGKCa5o3I0C85RBV4bpPGXdpCGj9e2
         FXBlWtRKLdv1Cx+9z0HgS51a7W5ElKsoQLw5EUIVWWUrERFGkML50ncFh9CvaP+LO817
         emI/SN3p68KYXBLz+wgUS41pt+6B2919j1Wn4Z8O50FtEmJ6m3MYYBCNxGKUI2mU+mmO
         JTBw==
X-Gm-Message-State: AHQUAubMpJNS/Q9KAq/3HdmkqbIaHOU7UkYhAz0lIYLT53W9w4O3OsAZ
        SLcPG6YTc6ZPZoVUkzI5fJE=
X-Google-Smtp-Source: AHgI3IbCEmbmZhps6lcAWfO4MUFsdN5MsBxu0eKEShq5fd24i88X3vDUBIdvZ0orKS8Z0TuhqkRtkQ==
X-Received: by 2002:a24:5c45:: with SMTP id q66mr5504510itb.159.1549643066833;
        Fri, 08 Feb 2019 08:24:26 -0800 (PST)
Received: from nuclearis2-1.lan (c-98-195-139-126.hsd1.tx.comcast.net. [98.195.139.126])
        by smtp.gmail.com with ESMTPSA id j142sm1403722itj.40.2019.02.08.08.24.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 08 Feb 2019 08:24:26 -0800 (PST)
From:   Alexandru Gagniuc <mr.nuke.me@gmail.com>
To:     bhelgaas@google.com
Cc:     austin_bolen@dell.com, alex_gagniuc@dellteam.com,
        keith.busch@intel.com, Shyam_Iyer@Dell.com, lukas@wunner.de,
        okaya@kernel.org, Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/3] PCI / ACPI: Do not export pci_get_hp_params()
Date:   Fri,  8 Feb 2019 10:24:11 -0600
Message-Id: <20190208162414.3996-2-mr.nuke.me@gmail.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190208162414.3996-1-mr.nuke.me@gmail.com>
References: <20190208162414.3996-1-mr.nuke.me@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This is only used within drivers/pci, and there is no reason to make
it available outside of the PCI core.

Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
---
 drivers/pci/pci-acpi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index e1949f7efd9c..b25e5fa9d1c9 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -366,7 +366,6 @@ int pci_get_hp_params(struct pci_dev *dev, struct hotplug_params *hpp)
 	}
 	return -ENODEV;
 }
-EXPORT_SYMBOL_GPL(pci_get_hp_params);
 
 /**
  * pciehp_is_native - Check whether a hotplug port is handled by the OS
-- 
2.19.2

