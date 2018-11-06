Return-Path: <SRS0=wh2u=NR=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C0CEC0044C
	for <linux-pci@archiver.kernel.org>; Tue,  6 Nov 2018 02:04:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1ADE320862
	for <linux-pci@archiver.kernel.org>; Tue,  6 Nov 2018 02:04:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HDOLs4Ap"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1ADE320862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727358AbeKFL0v (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 6 Nov 2018 06:26:51 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:37048 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726368AbeKFL0v (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Nov 2018 06:26:51 -0500
Received: by mail-pl1-f196.google.com with SMTP id p6-v6so5376826pll.4;
        Mon, 05 Nov 2018 18:04:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:subject:date:message-id;
        bh=19U5nnS+32OVLXwVWLlWkIemkFQKEnGuAOn8fC7twHs=;
        b=HDOLs4ApedBKIWZ/OBpRz1OMpDdkqI697Nyoi/M796demU//wCxG6HyM4qiGvvoHWm
         hRpMcvl67TUNd4uO75gt6TWZV4z+kOQzHT95LT9QNCKhzxsX+UXgSi6763Km1t5va5IU
         9mU5yesYuautARMkG1pmXpcPsk/Jgi4SDaJVd8U3JPWt/8UXcBpaauo3PiXRE1CMjohD
         VX/z+7ir8IB9nVuD57585G7c7B3Zo/MVgh7Tw2PfUR3DfH7uZseyDlim2t+f3r2sJMfh
         l6/UquRbE6YLKENM6IqA8clfhH16T7jndwPAjklNVGqgKf7OnNpgdl84mfaOV1QmReiX
         O1nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:subject:date:message-id;
        bh=19U5nnS+32OVLXwVWLlWkIemkFQKEnGuAOn8fC7twHs=;
        b=Cv+wyWGymD9a2gUWelZT5g4S8wfkCJ2wsLuSuILZKFMsaF9SiAUEWlGDcaAyjMzo6m
         +LivMQ5lqLTz83DiUf14rStA5bJZFTIogDPZs1pRx7Ccc3Cr4uYLq8GgSPiae1qAdj3z
         ZyCl+opgon1BcMly0AVfzOeqWB7RFNzoOW7j6/tzLzX2XXE8y3+9YGpmYzUw7bH2WtqF
         7ee5U2K+XyDGFRT3xR894wTUxOn+Y6htIWhwrsHgZa1GAl6m1x0gcPuLD67SCrykvlH8
         G1le2A2f0hPrC9vbN9wzF2SSNCFZe6sJMbm6FZqcHmBsvWridPpZNbykKSPmnknzkNkG
         HoMA==
X-Gm-Message-State: AGRZ1gJooWD2PGhIug9ekppc2sd2/9iiP4TDgeTJNKqFVklG5qOtqTLc
        iwy2mg0aYQqG2tr/TqmHFcg=
X-Google-Smtp-Source: AJdET5furphSaw6cCr9eHYAqjKJBwOC/zGAlzk746wPD1wfv2R9IPwCRNL+qj6bRQs1eT2BDXlROIA==
X-Received: by 2002:a17:902:9a04:: with SMTP id v4-v6mr23924878plp.247.1541469845887;
        Mon, 05 Nov 2018 18:04:05 -0800 (PST)
Received: from localhost (61-220-137-37.HINET-IP.hinet.net. [61.220.137.37])
        by smtp.gmail.com with ESMTPSA id 64-v6sm2591804pfa.120.2018.11.05.18.04.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Nov 2018 18:04:04 -0800 (PST)
From:   AceLan Kao <acelan.kao@canonical.com>
To:     Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: [PATCH 1/2] pci: prevent sk hynix nvme from entering D3
Date:   Tue,  6 Nov 2018 10:04:01 +0800
Message-Id: <20181106020402.21120-1-acelan.kao@canonical.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

It leads to the power consumption raises to 2.2W during s2idle, while
it consumes less than 1W during long idle if put SK hynix nvme to D3
and then enter s2idle.
From SK hynix FE, MS Windows doesn't put nvme to D3, and uses its own
APST feature to do the power management.
To leverage its APST feature during s2idle, we can't disable nvme
device while suspending, too.

BTW, prevent it from entering D3 will increase the power consumtion around
0.13W ~ 0.15W during short/long idle, and the power consumption during
s2idle becomes 0.77W.

Signed-off-by: AceLan Kao <acelan.kao@canonical.com>
---
 drivers/pci/quirks.c    | 1 +
 include/linux/pci_ids.h | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 4700d24e5d55..b7e6492e8311 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -1332,6 +1332,7 @@ DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_AL, PCI_ANY_ID,
    occur when mode detecting */
 DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_VIA, PCI_ANY_ID,
 				PCI_CLASS_STORAGE_IDE, 8, quirk_no_ata_d3);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SK_HYNIX, 0x1527, quirk_no_ata_d3);
 
 /*
  * This was originally an Alpha-specific thing, but it really fits here.
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 69f0abe1ba1a..5f5adda07de0 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -3090,4 +3090,6 @@
 
 #define PCI_VENDOR_ID_NCUBE		0x10ff
 
+#define PCI_VENDOR_ID_SK_HYNIX		0x1c5c
+
 #endif /* _LINUX_PCI_IDS_H */
-- 
2.17.1

