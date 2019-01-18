Return-Path: <SRS0=ljL/=P2=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8AD7C43612
	for <linux-pci@archiver.kernel.org>; Fri, 18 Jan 2019 04:23:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 910B920855
	for <linux-pci@archiver.kernel.org>; Fri, 18 Jan 2019 04:23:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="MaO13wyC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbfAREXg (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 17 Jan 2019 23:23:36 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33504 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726955AbfAREXg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 Jan 2019 23:23:36 -0500
Received: by mail-pl1-f196.google.com with SMTP id z23so5773518plo.0
        for <linux-pci@vger.kernel.org>; Thu, 17 Jan 2019 20:23:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=lkyUh9icSEKOoKzJdnqtktOdVMrgPrWedNRK3nkMezA=;
        b=MaO13wyCdWwhnawBbm4ve7FF5FpVb7kVh6+cZesvH30M+nkS3k/Q2w3V6yRq6J41IR
         M2g2R94lvqnxaY5a1gUT6QDVRQv3TEcXuHl9wbH7rdXOAY1SoON9GRV7q9sqiTvojlhC
         Z+aBhMjWYo1SDgHXbTMHFbMI8BWrSFX7fT91E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=lkyUh9icSEKOoKzJdnqtktOdVMrgPrWedNRK3nkMezA=;
        b=bnPLcIlheMgHXtX/qxlDcLYTg6ul6SipC/zRgU6CZN9cA19tmHjrIweLd4RUQMLCOJ
         i2p5upadyDPgWC2N8UM/nPH81qPUsJboH3wBT5gm26oidV0/8/EV4wWkkzs1nM90V18t
         xqo3c3B7/cVECJoPhhW6HNSnkfSyvWJvPyMbMkiWqJl7WOXujR4W91BxMtw/7jCrAqGk
         2bk6Hitrizhqz7NJ4MR+EnHkOjGgDeuFwoOvQ+vHskbE9z1/IRtRcX6YXS2Iz3f6F0ZQ
         3V/OawcGznU4hvaSAtExBdFXKhIlKbCGBW/SC1VJUa+gQiRXCkmwsNgIvEvhhzEl2yM4
         XjEw==
X-Gm-Message-State: AJcUukfeKqM9rK2vtvQKm2C9+D90IGM3ba+tO6MrOsLmTNIVxkh1Xz2w
        n3+tZJbmB/xF0mBaaB4onFgsEg==
X-Google-Smtp-Source: ALg8bN7BQHSNE42r7oE7vtISOSH1+C1FDA5Sz2z/shhdLGBd9Nft8N4KdD3bTC0EVW3tYj6GJ4erGg==
X-Received: by 2002:a17:902:1105:: with SMTP id d5mr17166964pla.47.1547785415103;
        Thu, 17 Jan 2019 20:23:35 -0800 (PST)
Received: from mannams-OptiPlex-7010.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id l19sm7339642pfi.71.2019.01.17.20.23.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 17 Jan 2019 20:23:34 -0800 (PST)
From:   Srinath Mannam <srinath.mannam@broadcom.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>
Cc:     bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Srinath Mannam <srinath.mannam@broadcom.com>
Subject: [PATCH 0/3] Add IPROC PCIe new features
Date:   Fri, 18 Jan 2019 09:53:20 +0530
Message-Id: <1547785403-32268-1-git-send-email-srinath.mannam@broadcom.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add changes related to IPROC PCIe RC IP new features.

This patch set is based on Linux-5.0-rc2.

Srinath Mannam (3):
  PCI: iproc: Add feature to set order mode
  PCI: iproc: CRS state check in config request
  PCI: iproc: Add PCIe 32bit outbound memory configuration

 drivers/pci/controller/pcie-iproc.c | 172 +++++++++++++++++++++++++++++++++++-
 drivers/pci/controller/pcie-iproc.h |  16 ++++
 2 files changed, 184 insertions(+), 4 deletions(-)

-- 
2.7.4

