Return-Path: <SRS0=vi1x=SO=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B985BC10F0E
	for <linux-pci@archiver.kernel.org>; Fri, 12 Apr 2019 03:13:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AF912184B
	for <linux-pci@archiver.kernel.org>; Fri, 12 Apr 2019 03:13:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="YFno93QX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726833AbfDLDNz (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 11 Apr 2019 23:13:55 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:46507 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726697AbfDLDNz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 11 Apr 2019 23:13:55 -0400
Received: by mail-ed1-f68.google.com with SMTP id d1so6997639edd.13
        for <linux-pci@vger.kernel.org>; Thu, 11 Apr 2019 20:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=lSZmLfiTS0tVJgkUC+AaFkmLshmlkzFI4jJrlCOnI6o=;
        b=YFno93QXuTT8g873ob4lzZVYz3tZWm+LfJx0YMpac2uEV9aJ6oZNSx9WOKnOf8lAo1
         +NqfDN8Br13bz4GqPuBdzRpRcU4aHRKhvkkpILIQq8DCmznfx/atr8QKvtlKx36BCQ8b
         DHYXbpmkIT46Gjd93nsMUBag2FEmJGH9PF5Ws=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=lSZmLfiTS0tVJgkUC+AaFkmLshmlkzFI4jJrlCOnI6o=;
        b=JzyxeEV2LADeXDPi5hfyN8focaAf+T8mIoBHz1T9+9JFMpq9wBrdSnn8LeMXnTzp9i
         aL4PhvC5WY8R2xfsrhemsR2QGBRfClubLWB0ZX1aOiq5e75WRJPTAeNq6YSnub2nRKTZ
         apc/9Shc3SzvJr6lE5j5goEl5LtBSTBweFaXWuIbPv+OvCnu0hRlkIFY2JSjFhya70kd
         Zdp3CoxNHp3bVeE65697ZVZnqTS9x+PmLhrpcR79J/oSGWhN1c7j4Xf47VIYBBzshpnD
         2hPiskcmM7hIzMbmDsYcpL1EFdYGUf0GkzbmH8z2znWgKmlaW/EE1rBUA02cGw0JVTGE
         lhDg==
X-Gm-Message-State: APjAAAUuaBiF8fflyI8Ppuv35Wp3Kzc8bQzZ1dDUG2C1ydUYX6pzKEQ9
        sjBW6KOgdsioumQQCu6AiVSYMQ==
X-Google-Smtp-Source: APXvYqz8Z8DBYr6JemK9OQFaobK4cwQGMmE9tVq+z/+aM5UzwZDbxfR2W0WlgQFUXvqBP0mVwT6VEg==
X-Received: by 2002:aa7:dc4d:: with SMTP id g13mr5176207edu.106.1555038833471;
        Thu, 11 Apr 2019 20:13:53 -0700 (PDT)
Received: from mannams-OptiPlex-7010.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id c7sm11533352edt.70.2019.04.11.20.13.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 11 Apr 2019 20:13:52 -0700 (PDT)
From:   Srinath Mannam <srinath.mannam@broadcom.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        poza@codeaurora.org, Ray Jui <rjui@broadcom.com>
Cc:     bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Srinath Mannam <srinath.mannam@broadcom.com>
Subject: [PATCH v4 0/3] PCIe Host request to reserve IOVA
Date:   Fri, 12 Apr 2019 08:43:32 +0530
Message-Id: <1555038815-31916-1-git-send-email-srinath.mannam@broadcom.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Few SOCs have limitation that their PCIe host can't allow few inbound
address ranges. Allowed inbound address ranges are listed in dma-ranges
DT property and this address ranges are required to do IOVA mapping.
Remaining address ranges have to be reserved in IOVA mapping.

PCIe Host driver of those SOCs has to list resource entries of allowed
address ranges given in dma-ranges DT property in sorted order. This
sorted list of resources will be processed and reserve IOVA address for
inaccessible address holes while initializing IOMMU domain.

This patch set is based on Linux-5.0-rc2.

Changes from v3:
  - Addressed Robin Murphy review comments.
    - pcie-iproc: parse dma-ranges and make sorted resource list.
    - dma-iommu: process list and reserve gaps between entries

Changes from v2:
  - Patch set rebased to Linux-5.0-rc2

Changes from v1:
  - Addressed Oza review comments.

Srinath Mannam (3):
  PCI: Add dma_ranges window list
  iommu/dma: Reserve IOVA for PCIe inaccessible DMA address
  PCI: iproc: Add sorted dma ranges resource entries to host bridge

 drivers/iommu/dma-iommu.c           | 19 ++++++++++++++++
 drivers/pci/controller/pcie-iproc.c | 44 ++++++++++++++++++++++++++++++++++++-
 drivers/pci/probe.c                 |  3 +++
 include/linux/pci.h                 |  1 +
 4 files changed, 66 insertions(+), 1 deletion(-)

-- 
2.7.4

