Return-Path: <SRS0=4lLw=ZH=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4835FC432C3
	for <linux-pci@archiver.kernel.org>; Fri, 15 Nov 2019 13:58:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17D7D20733
	for <linux-pci@archiver.kernel.org>; Fri, 15 Nov 2019 13:58:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573826331;
	bh=GsjF0h/E0+8I7R6L/+hj/jr89JoWifHmcBHsyTy1V/4=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=2U8PCTbxcZlrbbxYbNp6mVsXtpBIrbfpJ62dZ4nxEgpRCT73BKW06l0q5rVbRmVVP
	 k3zHJjWCgzC+zNg3ld1CujhhE8nUxcemjaO3olopbCW540rYt+vNT6Ozbo/NPhaE7t
	 0INB9uiLgXNnUHCf880cFbZfY6PyrfjYsQUP892I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727612AbfKON6u (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 15 Nov 2019 08:58:50 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:34311 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727412AbfKON6u (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 15 Nov 2019 08:58:50 -0500
Received: by mail-wm1-f67.google.com with SMTP id j18so10144891wmk.1
        for <linux-pci@vger.kernel.org>; Fri, 15 Nov 2019 05:58:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dz4PbGwAteQtR2JgDtB6690W8xZ69utvjZMMf2EnDPw=;
        b=dBgHv33sP2yCAULKSG7/AXPsycxYCdBlXW0VCSM4Tl+v2i073r38huEMArbeDALySx
         XnniQn1vJuEo01HfPXiwLIEso6JwFJHcLn3E+sioCS0i61Bi0gUI0dcpb32+CxpDDXKc
         oVrkL0ykQ3ZlTF1aiVJOz5QelQipD5hY6RlTVP6XoC608B/rwiQwaACjrWELDPFCs3Y3
         pg2bA/+uYcHIiK5KWqjys7sHE3fRDWJo8AfJqAJGnofv58fmxHiCls4FlyqNIHWSa684
         6q0hr2OHVJqDy+ti/MX4cXY41o2+4wUXuViKeVyP1bhefjEzKUwjh8HhR8PetclO/DNz
         KcrA==
X-Gm-Message-State: APjAAAVFdk4GWfdnFkbpKeq7I8JVSiS6JTt8I/fmhdBSMGGwc+H0Y4lF
        LWrYtBySIpqMVrmO0NJeZfgMpEx/vPg=
X-Google-Smtp-Source: APXvYqyXdgmAPR+hXUdj3Bx8u/CSewNUB+jbDQ0SdwHQ/UrCUDnAPfpWs+xgtmbXPqI2TOBgTKUQVQ==
X-Received: by 2002:a05:600c:299:: with SMTP id 25mr15576426wmk.50.1573826328549;
        Fri, 15 Nov 2019 05:58:48 -0800 (PST)
Received: from liuwe-devbox.j3c5onc20sse1dnehy4noqpfcg.zx.internal.cloudapp.net ([52.151.97.152])
        by smtp.gmail.com with ESMTPSA id n17sm11020730wrp.40.2019.11.15.05.58.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2019 05:58:48 -0800 (PST)
From:   Wei Liu <wei.liu@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     bhelgaas@google.com, rjui@broadcom.com,
        Wei Liu <wei.liu@kernel.org>
Subject: [PATCH] PCI: build Broadcom PAXC quirks unconditionally
Date:   Fri, 15 Nov 2019 13:58:42 +0000
Message-Id: <20191115135842.119621-1-wei.liu@kernel.org>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

CONFIG_PCIE_IPROC_PLATFORM only gets defined when the driver is built
in.  Removing the ifdef will allow us to build the driver as a module.

Signed-off-by: Wei Liu <wei.liu@kernel.org>
---
Alternatively, we can change the condition to:

  #ifdef CONFIG_PCIE_IPROC_PLATFORM || CONFIG_PCIE_IPROC_PLATFORM_MODULE
.

I chose to remove the ifdef because that's what other quirks looked like
in this file.
---
 drivers/pci/quirks.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 320255e5e8f8..cd0e7c18e717 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -2381,7 +2381,6 @@ DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_BROADCOM,
 			 PCI_DEVICE_ID_TIGON3_5719,
 			 quirk_brcm_5719_limit_mrrs);
 
-#ifdef CONFIG_PCIE_IPROC_PLATFORM
 static void quirk_paxc_bridge(struct pci_dev *pdev)
 {
 	/*
@@ -2405,7 +2404,6 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_BROADCOM, 0x16f0, quirk_paxc_bridge);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_BROADCOM, 0xd750, quirk_paxc_bridge);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_BROADCOM, 0xd802, quirk_paxc_bridge);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_BROADCOM, 0xd804, quirk_paxc_bridge);
-#endif
 
 /*
  * Originally in EDAC sources for i82875P: Intel tells BIOS developers to
-- 
2.24.0

