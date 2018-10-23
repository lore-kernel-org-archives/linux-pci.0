Return-Path: <SRS0=AklG=ND=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7C04C7112C
	for <linux-pci@archiver.kernel.org>; Tue, 23 Oct 2018 10:21:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF4A5207DD
	for <linux-pci@archiver.kernel.org>; Tue, 23 Oct 2018 10:21:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="VHx5p3a6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF4A5207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727420AbeJWSoU (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 23 Oct 2018 14:44:20 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36935 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727692AbeJWSoT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 23 Oct 2018 14:44:19 -0400
Received: by mail-pf1-f195.google.com with SMTP id j23-v6so435875pfi.4
        for <linux-pci@vger.kernel.org>; Tue, 23 Oct 2018 03:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=iOjpakRqqGtPPHcKgxLXCVHXs5ObeD9MwmIYarddrCk=;
        b=VHx5p3a6HdyMs+Nz1RsIqqQAVlxbNNXMiwsqF/1+dDDAIH3Zcim5w771uKZpYUjz0L
         nRdFcLYHuAic6bombnt5ItaWNUC6lOEHI6qvzYDWC4U1Yopg7XPa97muGqcQw4u91BAT
         v/sVfB/RbZnWVJtUXF2C6wMBs7viP9rJtOMaI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=iOjpakRqqGtPPHcKgxLXCVHXs5ObeD9MwmIYarddrCk=;
        b=K2RprBf5cN4qJfQjl6YPpyQ2tR4fndi2qLFLgFdmZnLDvJzVPfdI/tk7gJCn3xYK4x
         l23DbCkWGeZbtut+sK3U6IoRifjXfRfkxc3u66XvLcG5Y2tdO6Db3A3TN4ktNWqxpwfG
         AZ2udmwnNXr4QOJZ1hHV5UYCkfHcvV7KRrYakbRgi+IXhX+el5/LjCQH3N32C3vEKhyW
         pUbo5rI1De1xX5UtZDHXdCW80sOTzL5Bj8rtGuMUFhMcuTQfSNLx7rbZ8WqynNeKYGnc
         m6p9ynwvQNb0+EoDzgNs5oTijNptro2I8LWiW22kh2AvRuIN7n9P8NaKAduLk+Iu66PK
         f1YA==
X-Gm-Message-State: AGRZ1gJ5NInK8gne58E/xNc7U5dq7X/MJVs8uAqfi/a73oXeGto15rlA
        KLcnV79/aE6uQAscbQNN5XrPdV3lDH0=
X-Google-Smtp-Source: AJdET5d+oA37n0mLyI+M4IZqF/NyxUhnj7HgkRsV5MNVMXdQUvsrLeekmW0ApMyWTg+Sthr0YZEcAA==
X-Received: by 2002:a63:65c7:: with SMTP id z190mr4256525pgb.249.1540290091978;
        Tue, 23 Oct 2018 03:21:31 -0700 (PDT)
Received: from dhcp-10-123-74-106.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id m10-v6sm2918523pfg.180.2018.10.23.03.21.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Oct 2018 03:21:31 -0700 (PDT)
From:   Suganath Prabu <suganath-prabu.subramani@broadcom.com>
To:     helgaas@kernel.org, lukas@wunner.de, linux-scsi@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     benh@kernel.crashing.org, ruscur@russell.cc,
        sbobroff@linux.ibm.com, oohall@gmail.com,
        andy.shevchenko@gmail.com, Sathya.Prakash@broadcom.com,
        sreekanth.reddy@broadcom.com,
        Suganath Prabu <suganath-prabu.subramani@broadcom.com>
Subject: [v6 0/4] mpt3sas: Hot-Plug Surprise removal support on IOC.
Date:   Tue, 23 Oct 2018 15:51:17 +0530
Message-Id: <1540290081-15827-1-git-send-email-suganath-prabu.subramani@broadcom.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

v6 Change set:
Incorporated changes as suggested by Andy.
In Patch 1 converted while loop to do while in
function mpt3sas_wait_for_ioc_to_operational().
And in patch 3 removed parentheses.

V5 Change set:
V5 post has only defect fixes.
We are reworking and incorporating the suggestions from Bjorn.
And after covering tests, we ll be post Hot-Plug Surprise
 removal patches.

V4 Change set:
Reframe split strings in print statement, to avoid

V3 Change Set:
Simplified function "mpt3sas_base_pci_device_is_available" and
made inline

V2 changes:
Replaced mpt3sas_base_pci_device_is_unplugged with
pci_device_is_present.

V1 changes:
In Patch 0001 - unlock mutex, if active reset is in progress.
Suganath Prabu (4):
  mpt3sas: Separate out mpt3sas_wait_for_ioc_to_operational
  mpt3sas: Fix Sync cache command failure during driver unload
  mpt3sas:Fix driver modifying persistent data.
  mpt3sas: Bump driver version to 27.100.00.00.

 drivers/scsi/mpt3sas/mpt3sas_base.c      | 75 ++++++++++++++++++--------------
 drivers/scsi/mpt3sas/mpt3sas_base.h      |  8 +++-
 drivers/scsi/mpt3sas/mpt3sas_config.c    | 28 +++---------
 drivers/scsi/mpt3sas/mpt3sas_ctl.c       | 21 ++-------
 drivers/scsi/mpt3sas/mpt3sas_scsih.c     | 38 +++++++++++++++-
 drivers/scsi/mpt3sas/mpt3sas_transport.c | 70 ++++++-----------------------
 6 files changed, 106 insertions(+), 134 deletions(-)

-- 
1.8.3.1

