Return-Path: <SRS0=mKlk=QB=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B24BC282C0
	for <linux-pci@archiver.kernel.org>; Fri, 25 Jan 2019 10:14:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB88F2184B
	for <linux-pci@archiver.kernel.org>; Fri, 25 Jan 2019 10:14:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="g9PzHzGp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728697AbfAYKOG (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 25 Jan 2019 05:14:06 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:39324 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728469AbfAYKOF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 25 Jan 2019 05:14:05 -0500
Received: by mail-yw1-f65.google.com with SMTP id k188so3679749ywa.6
        for <linux-pci@vger.kernel.org>; Fri, 25 Jan 2019 02:14:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=RMdk5cmmpnbcM5aDvhKNw8euAJU+GnQUtHbH0E7iD/U=;
        b=g9PzHzGp8la7oxzZTPfTFoQm9IFcfqOdD7nOidKQb/q+pllpO6tb036MeN79ZAGaRz
         x5eLsgaA5vhvk2rd2o3M0JqT3IRxlGIgTDFMcUNCMSur1wHfyspOd8kQ6rZSbTqsSnZR
         LRRXlA8xxOPEGrWT3NKM8TbNdUu8LClFN8DNA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=RMdk5cmmpnbcM5aDvhKNw8euAJU+GnQUtHbH0E7iD/U=;
        b=OzDN91sM2WI4p6qU5F4DMHQ+cb+rL8v049xZaGEkhcZQ5I1Rq/onMbwUhxhVnfnGcN
         EpU8rXTD9ciKDnTU43OPSpqxdsoovySa7uUXFXkUBulClzsOsQ+nrJnsCxmwxZJEIF1N
         2ywz8wwhVXXYMkK1ArFgX1Ld+5wMFZ1v0+AsvTtCNV146RjgF4yOM0/nC8sq8wjArbgq
         leYxB+M8pWPWf/45SQ9vqsCjR9vLVbDoA7X3dbAolFLmrrKMZ/at6qLZk3LLlzpS/+Kt
         +j2HeeGZ4X9wuVOp1DAxtDZ2/wiJ7sKqTInEvI3edJerIkzAQ9U4w8A5RGN0iAmOOP/S
         Ztaw==
X-Gm-Message-State: AJcUukf/c2SMBri4UtB0jbNR1ZJ7KLtjQdu1uUgERT16ksARxJFK3xLg
        kwRn37Y8ikIX8hP9uL9SKaBYOw==
X-Google-Smtp-Source: ALg8bN5QB5ob6Y0xv1UaOJgip5bvq68c7tU+9rz7aINOL1ZyxxGvWN/mtRM+CLkbN3AUy/7z89LtwA==
X-Received: by 2002:a81:60c4:: with SMTP id u187mr9997130ywb.345.1548411244973;
        Fri, 25 Jan 2019 02:14:04 -0800 (PST)
Received: from mannams-OptiPlex-7010.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id x203sm11868695ywd.41.2019.01.25.02.14.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 25 Jan 2019 02:14:04 -0800 (PST)
From:   Srinath Mannam <srinath.mannam@broadcom.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        poza@codeaurora.org, Ray Jui <rjui@broadcom.com>
Cc:     bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Srinath Mannam <srinath.mannam@broadcom.com>
Subject: [PATCH v3 0/3] PCIe Host request to reserve IOVA
Date:   Fri, 25 Jan 2019 15:43:48 +0530
Message-Id: <1548411231-27549-1-git-send-email-srinath.mannam@broadcom.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Few SOCs have limitation that their PCIe host can't allow few inbound
address ranges. Allowed inbound address ranges are listed in dma-ranges
DT property and this address ranges are required to do IOVA mapping.
Remaining address ranges have to be reserved in IOVA mapping.

PCIe Host driver of those SOCs has to list all address ranges which have
to reserve their IOVA address into PCIe host bridge resource entry list.
IOMMU framework will reserve these IOVAs while initializing IOMMU domain.

This patch set is based on Linux-5.0-rc2.

Changes from v2:
  - Patch set rebased to Linux-5.0-rc2

Changes from v1:
  - Addressed Oza review comments.

Srinath Mannam (3):
  PCI: Add dma-resv window list
  iommu/dma: Reserve IOVA for PCI host reserve address list
  PCI: iproc: Add dma reserve resources to host

 drivers/iommu/dma-iommu.c           |  8 ++++++
 drivers/pci/controller/pcie-iproc.c | 51 ++++++++++++++++++++++++++++++++++++-
 drivers/pci/probe.c                 |  3 +++
 include/linux/pci.h                 |  1 +
 4 files changed, 62 insertions(+), 1 deletion(-)

-- 
2.7.4

