Return-Path: <SRS0=6A7A=Q3=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72A1DC43381
	for <linux-pci@archiver.kernel.org>; Wed, 20 Feb 2019 16:34:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C7932147C
	for <linux-pci@archiver.kernel.org>; Wed, 20 Feb 2019 16:34:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="aUZj46IR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726423AbfBTQeI (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 20 Feb 2019 11:34:08 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39938 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726360AbfBTQeI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 Feb 2019 11:34:08 -0500
Received: by mail-pg1-f193.google.com with SMTP id u9so8586197pgo.7
        for <linux-pci@vger.kernel.org>; Wed, 20 Feb 2019 08:34:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=3BWkOhTkkswDxf0FP7V9XAIUNHK7O40ffyu257dAaTY=;
        b=aUZj46IRGnkuSkRUWj0nYxAonh1J6EkNT/y4rr1tH8pGk5NypxqYTuQGiYsPsE3XRv
         Xiy6pRLJSj5/nQb7W0v+t8CUqDDWUmxp4rXtpYRfEzdFihPrjgp/Vk3Lgn2SD0wr890M
         GMKL8YWs5Rh5PN6aofXra2UQZdazKe/2M+n6I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=3BWkOhTkkswDxf0FP7V9XAIUNHK7O40ffyu257dAaTY=;
        b=KBKtxeMBKQgXerNR2QBD7sFhPYa3STjbZlQLmBA6ZXwLr8ne32JLH47zqHEsNJgyTc
         sVMjQIvR2bTywP+adVPL57/AhAW62m+qM0UCkOKWRQQMsoTysLgOGKXUBV/aWaOsKYNF
         xr6TBwWfaEkMEA5bWbdwMpqS3QDg/B7mcAcaIqzIL2k1qzD2TgysnMG3CfujFFBvYkL9
         qUU3yXYd20vhH12bjyCO9U2Vgax8bDba4PSdD/eCdVh2gxj33y/L8pvmBmq2oOehAChn
         kMHXdX8KBClb0LTrvaiu25QG1yuQy/crxdHYSxMT7eybLjUU7vmx7B7ETeRkz0H5u0yH
         UgcQ==
X-Gm-Message-State: AHQUAuZAuy3bnLS+kusQEOtDQ9aSmHpjdS4oeRO2R4ckFm9uufAaQ57k
        SAKjpyVxTniURBta8CQjcQtolA==
X-Google-Smtp-Source: AHgI3IYSJLYMwme1v91novIPjbuXRyKVN3exUtRlX5MVCQx7Vp2iq0J0P/Zkr5gUTDZGSw0ZY2F9Zw==
X-Received: by 2002:a62:9917:: with SMTP id d23mr36693549pfe.88.1550680447687;
        Wed, 20 Feb 2019 08:34:07 -0800 (PST)
Received: from mannams-OptiPlex-7010.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id t10sm26556717pfa.151.2019.02.20.08.34.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 20 Feb 2019 08:34:06 -0800 (PST)
From:   Srinath Mannam <srinath.mannam@broadcom.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>
Cc:     bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Srinath Mannam <srinath.mannam@broadcom.com>
Subject: [PATCH v3 0/2] Add IPROC PCIe new features
Date:   Wed, 20 Feb 2019 22:03:53 +0530
Message-Id: <1550680435-9706-1-git-send-email-srinath.mannam@broadcom.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This patch set extends support of new IPROC PCIe host controller features
 - Add CRS check using controller register status flags
 - Add outbound window mapping configuration for 32-bit I/O region

This patch set is based on Linux-5.0-rc2.

Changes from v2:
  - Based on Lorenzo Pieralisi comments, commit logs are expanded.

Changes from v1:
  - Addressed Bjorn Helgaas comments.
  - Removed set order mode patch from patchset.

Srinath Mannam (2):
  PCI: iproc: Add CRS check in config read
  PCI: iproc: Add outbound configuration for 32-bit I/O region

 drivers/pci/controller/pcie-iproc.c | 44 +++++++++++++++++++++++++++++++++----
 1 file changed, 40 insertions(+), 4 deletions(-)

-- 
2.7.4

