Return-Path: <SRS0=XSei=MI=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9ED5C43382
	for <linux-pci@archiver.kernel.org>; Wed, 26 Sep 2018 15:09:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 714C2214FF
	for <linux-pci@archiver.kernel.org>; Wed, 26 Sep 2018 15:09:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m2M3w5or"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 714C2214FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727157AbeIZVWa (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 26 Sep 2018 17:22:30 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33726 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727136AbeIZVWa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 26 Sep 2018 17:22:30 -0400
Received: by mail-pf1-f194.google.com with SMTP id d4-v6so13596178pfn.0;
        Wed, 26 Sep 2018 08:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=9kMRVjtnqbz8teAqtBuI63zZnxWL+ysoXG9qdOLxuMk=;
        b=m2M3w5ormj/dNxl/blmBE7GNfH9hRNjrqbLyDlMFmYXY4xmRpmLs5eatXGOtqw3LpF
         RsOgnpILq/1Yp8LDrsUpQICVK+RVGd9fC7llIFVkJK3VXiNL4OVtOz3C7IU1Bll3yYn8
         VzGQjoThxD4leEAPJ/4Ef0YbAy8oIjDVLLRPB2RMfeOvzmRIm2vLDQDFvhJAFFYLSvbt
         40A2TMggGV2kaUEmuNnYvyj2lgf36cqFQT4xFwUe5yHyzTekhMfmrOTjjmMMYyJvK4gQ
         /jTvLlvymedP2VcSsQN2/QZhmpwM6+NMVUnrgm3W+oQhbZk+QhWqG6m/TRhvJO2L00fu
         E5Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=9kMRVjtnqbz8teAqtBuI63zZnxWL+ysoXG9qdOLxuMk=;
        b=uVjdE3aGtqvzIvcqvC57sxr3fHxcbIAUqQfBmQtTO3PEYD20g5Hb6ENTRIYABXYMHv
         WpQLwdFp7ywNbG5okoqfWNIJb6cOswJRNuNNBU5rY5S18NlnmsnG8lm75Sf7sXbyOgTR
         TTkOHzvonerZaG2cUilHhbVirMwcBsv89lUyMB3iY1puS6NQndCu4Ol3MmDrqqUpOTCj
         psFMq+nWyLp3mVr9TTNRcXQgS7huN8OeuB/oCQDO2oWg7qqvizJSLkBn2THejEOPkcoU
         ahioDTsKE0sm21Hvls3D5J+NVaNzN8U6vPBMSGUuX+JIzugW2roig8cpHvElk9Qo3nVd
         CHlA==
X-Gm-Message-State: ABuFfohaUx//cV/nf3W53KOjdUu4PY6msZs8UrrxfDsdWGt71/kj/B5s
        BiZ9Uy5lh8cb4PfheGeAtyE=
X-Google-Smtp-Source: ACcGV63/y9QpDg3lczRGRrhOHF+XjYQDu58BIDSHKI/tm3YihNy1ThDxZPmdzZv4FLq9emfc3mTAhQ==
X-Received: by 2002:a63:9b09:: with SMTP id r9-v6mr6051851pgd.307.1537974546747;
        Wed, 26 Sep 2018 08:09:06 -0700 (PDT)
Received: from ala-d2121-lx1.wrs.com (unknown-156-139.windriver.com. [147.11.156.139])
        by smtp.gmail.com with ESMTPSA id a15-v6sm9231741pfh.30.2018.09.26.08.09.05
        (version=TLS1_1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 26 Sep 2018 08:09:05 -0700 (PDT)
From:   Bin Meng <bmeng.cn@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>
Cc:     Thomas Jarosch <thomas.jarosch@intra2net.com>,
        stable <stable@vger.kernel.org>
Subject: [PATCH] pci: Add a few new IDs for Intel GPU "spurious interrupt" quirk
Date:   Wed, 26 Sep 2018 08:14:01 -0700
Message-Id: <1537974841-29928-1-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.9.5
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add more PCI IDs to the Intel GPU "spurious interrupt" quirk table,
which are known to break.

See commit f67fd55fa96f ("PCI: Add quirk for still enabled interrupts
on Intel Sandy Bridge GPUs"), and commit 7c82126a94e6 ("PCI: Add new
ID for Intel GPU "spurious interrupt" quirk") for some history.

Based on current findings, it is highly possible that all Intel
1st/2nd/3rd generation Core processors' IGD has such quirk.

Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
Cc: <stable@vger.kernel.org> # v3.4+
---

 drivers/pci/quirks.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 6bc27b7..c0673a7 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -3190,7 +3190,11 @@ static void disable_igfx_irq(struct pci_dev *dev)
 
 	pci_iounmap(dev, regs);
 }
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x0042, disable_igfx_irq);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x0046, disable_igfx_irq);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x004a, disable_igfx_irq);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x0102, disable_igfx_irq);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x0106, disable_igfx_irq);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x010a, disable_igfx_irq);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x0152, disable_igfx_irq);
 
-- 
2.7.4

