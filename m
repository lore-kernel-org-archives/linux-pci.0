Return-Path: <SRS0=Pgd8=VV=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 043B1C76186
	for <linux-pci@archiver.kernel.org>; Wed, 24 Jul 2019 23:39:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0CCD21880
	for <linux-pci@archiver.kernel.org>; Wed, 24 Jul 2019 23:39:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W25R1WYe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388709AbfGXXjc (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 24 Jul 2019 19:39:32 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:45974 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388699AbfGXXjc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 24 Jul 2019 19:39:32 -0400
Received: by mail-io1-f68.google.com with SMTP id g20so93285072ioc.12;
        Wed, 24 Jul 2019 16:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qNiVS6KaY4NBAE+rZSVHlFmLJSQHz8WYKfYsVUbOMCM=;
        b=W25R1WYezOB68dc9K78bpE8OES+u0aPNWsLm0Z/eSuGSyd0/XPQymoibZ4/BQIpcIq
         Eq3IrnM+oHw+Eh6OmLLt8+VcxYmuU7nbhOPftOr6CUCfGsWZq9kd6MU+KuDYSCr2lTKO
         97W3ST3Ccjp0sPANSoCmnLWC6kpqmG6IaQnHr44maxuHGR4ryk1xyGo+Wk+1lOSkxNXL
         UDih0DZ1Xyp4+xltmYYSvYQOzDSm2m3cCP3Fp/o2ZyIuEcCwIs4aPI8LYmnnxHyEVJuP
         U6Lhd/1lq9BN0VuDudKaKlZrFQ3hgzTlZR7WlT/+jUemIuKhKe2DvVx9o8boR7KYii2E
         GmiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qNiVS6KaY4NBAE+rZSVHlFmLJSQHz8WYKfYsVUbOMCM=;
        b=tRUDZw7IH4RPePqk0vUJzEV5DE1RnKJ+zOD3cFPpQTpvnRtM6f3ycigE7I+htk5nd7
         TO+ubNTxfxFZCY9rckwt0GDaRhwtP/8pJXiUM1xOfg07zGnVYJcE0HTXUYhzOerpfqcd
         sdR6j2XhwPIdNERaeN/WMphQZhtjWyAqwjKWbhbd0qLyKMUx7OEKJjOW4Dw+avd2+PQT
         JzKwh4+vnONiT8U9iNUvKibnIRRnlzItdhP+bsUTpmAguFoAfugO9XcjGNZ/sWxSppN6
         VwVmOkP0hHlyPr6WENuvK1FutAL9sZzcYXZnBgm1rDRo+6kGT4V6Iqhnkwu0f3qgpH/l
         TX7A==
X-Gm-Message-State: APjAAAX2nmFxT7ywTX30oAGtjL4IrVxTvvVI9j2A52L9yHnsnPAOAFQM
        4Jeqlwk+htMzMq8vdDyMd4o=
X-Google-Smtp-Source: APXvYqw9oabF3ab6Yv6x4v9tkcwqQAHiGbRpr88mk5G7RA3GapanX5AoCAwO5O+GaUOM0sxzbT5vIg==
X-Received: by 2002:a6b:6505:: with SMTP id z5mr76156608iob.295.1564011571550;
        Wed, 24 Jul 2019 16:39:31 -0700 (PDT)
Received: from localhost.localdomain (c-73-243-191-173.hsd1.co.comcast.net. [73.243.191.173])
        by smtp.gmail.com with ESMTPSA id b14sm51612959iod.33.2019.07.24.16.39.30
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 24 Jul 2019 16:39:30 -0700 (PDT)
From:   Kelsey Skunberg <skunberg.kelsey@gmail.com>
To:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     skunberg.kelsey@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skhan@linuxfoundation.org
Subject: [PATCH v2 08/11] PCI: Move pci_ats_init() to drivers/pci/pci.h
Date:   Wed, 24 Jul 2019 17:38:45 -0600
Message-Id: <20190724233848.73327-9-skunberg.kelsey@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190724233848.73327-1-skunberg.kelsey@gmail.com>
References: <20190711222341.111556-1-skunberg.kelsey@gmail.com>
 <20190724233848.73327-1-skunberg.kelsey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

pci_ats_init() is only called with drivers/pci/. Since declarations do not
need to be visible to the rest of the kernel, move to drivers/pci/pci.h.

Signed-off-by: Kelsey Skunberg <skunberg.kelsey@gmail.com>
---
 drivers/pci/pci.h   | 7 ++++---
 include/linux/pci.h | 2 --
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index feec29853a44..7c0488b64faf 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -439,11 +439,12 @@ static inline void pci_restore_dpc_state(struct pci_dev *dev) {}
 #endif
 
 #ifdef CONFIG_PCI_ATS
+/* Address Translation Service */
+void pci_ats_init(struct pci_dev *dev);
 void pci_restore_ats_state(struct pci_dev *dev);
 #else
-static inline void pci_restore_ats_state(struct pci_dev *dev)
-{
-}
+static inline void pci_ats_init(struct pci_dev *d) { }
+static inline void pci_restore_ats_state(struct pci_dev *dev) { }
 #endif /* CONFIG_PCI_ATS */
 
 #ifdef CONFIG_PCI_IOV
diff --git a/include/linux/pci.h b/include/linux/pci.h
index c6a25c32a49a..5760e19cb625 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1766,13 +1766,11 @@ static inline bool pci_ats_disabled(void) { return true; }
 
 #ifdef CONFIG_PCI_ATS
 /* Address Translation Service */
-void pci_ats_init(struct pci_dev *dev);
 int pci_enable_ats(struct pci_dev *dev, int ps);
 void pci_disable_ats(struct pci_dev *dev);
 int pci_ats_queue_depth(struct pci_dev *dev);
 int pci_ats_page_aligned(struct pci_dev *dev);
 #else
-static inline void pci_ats_init(struct pci_dev *d) { }
 static inline int pci_enable_ats(struct pci_dev *d, int ps) { return -ENODEV; }
 static inline void pci_disable_ats(struct pci_dev *d) { }
 static inline int pci_ats_queue_depth(struct pci_dev *d) { return -ENODEV; }
-- 
2.20.1

