Return-Path: <SRS0=ZQeV=OV=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAE9CC04EB8
	for <linux-pci@archiver.kernel.org>; Wed, 12 Dec 2018 05:46:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DFE720811
	for <linux-pci@archiver.kernel.org>; Wed, 12 Dec 2018 05:46:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="dOmth98p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DFE720811
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726478AbeLLFq3 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 12 Dec 2018 00:46:29 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45500 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726440AbeLLFq3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 12 Dec 2018 00:46:29 -0500
Received: by mail-wr1-f67.google.com with SMTP id b14so16347720wru.12
        for <linux-pci@vger.kernel.org>; Tue, 11 Dec 2018 21:46:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=iYjpjhqWEVdwBSRetUBfnfvuhWcZhfMXzJpWRMq2qFU=;
        b=dOmth98pTDIjOQZ70Stz7JOrHKvOAwm0y87/L587hKd46tEdpGlBBeYY6MbBR6TSLC
         neKsajk873us1d/w11Z4bqo1fXTiCKBeDL6Em7krdzObTeUWmkh2ONBNQkr/+Hjacq3n
         SbWEUidJtWZ1RCTe0zjiohtspg91WzlBDGyQ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=iYjpjhqWEVdwBSRetUBfnfvuhWcZhfMXzJpWRMq2qFU=;
        b=i5k7wfKI4RP0LENu32kKB34m69jmlQsuvhzxab6xYfuGALMUP/g9TbXgCASemzuKKP
         tWZ2T8piB5p6E+TRwUxpWxP9DdTe2chKNPNMb6DFAO1lcfqc2Ddn4JiOY5ggykOe3DjN
         VEaMEgCSVzblOcVdVqjojHTY7y3LP+DlhmSc5KXEnMrbJSHZs5Zk7YrxntoHS4tATx2P
         tt2KBoJoUrHB2qZlb3m5maPNXXy1uPO/dTIn2LI8/4Jk+Pi4uRuoTlSgIwGsMPGnqqTO
         24nCc28U4IMJS1hLHwVdbP1cQudBNAbdt5jMxumWlJc+HWkg5xm2eC2fMmZW8qWN50x4
         wKzw==
X-Gm-Message-State: AA+aEWYB1xKbg0ys7NOi6csdd4IxwoDsLRTD905wLTbVef5LhTlcui94
        SuPjAKWscktL4Ru5bOEQ9jsX0g==
X-Google-Smtp-Source: AFSGD/WHzBH6vUYB80WSgOhqfoFb89sO27o2t9d+uHDivBQ8B7BdAO9zeF3PYDofDU8E+CUrFoQL6g==
X-Received: by 2002:adf:f5d1:: with SMTP id k17mr17321627wrp.59.1544593586849;
        Tue, 11 Dec 2018 21:46:26 -0800 (PST)
Received: from mannams-OptiPlex-7010.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id z206sm2015947wmc.18.2018.12.11.21.46.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 11 Dec 2018 21:46:25 -0800 (PST)
From:   Srinath Mannam <srinath.mannam@broadcom.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Ray Jui <rjui@broadcom.com>
Cc:     bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Srinath Mannam <srinath.mannam@broadcom.com>
Subject: [RFC PATCH 0/3] PCIe Host request to reserve IOVA
Date:   Wed, 12 Dec 2018 11:16:06 +0530
Message-Id: <1544593569-8923-1-git-send-email-srinath.mannam@broadcom.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Few SOCs have limitation that their PCIe host
can't allow few inbound address ranges.
Allowed inbound address ranges are listed in
dma-ranges DT property and this address ranges
are required to do IOVA mapping.
Remaining address ranges have to be reserved in
IOVA mapping.

PCIe Host driver of those SOCs has to list all
address ranges which have to reserve their IOVA
address into PCIe host bridge resource entry list.
IOMMU framework will reserve these IOVAs while
initializing IOMMU domain.

This patch set is based on Linux-4.19-rc1.

Srinath Mannam (3):
  PCI: Add dma-resv window list
  iommu/dma: IOVA reserve for PCI host reserve address list
  PCI: iproc: Add dma reserve resources to host

 drivers/iommu/dma-iommu.c           |  8 ++++++
 drivers/pci/controller/pcie-iproc.c | 49 +++++++++++++++++++++++++++++++++++++
 drivers/pci/probe.c                 |  3 +++
 include/linux/pci.h                 |  1 +
 4 files changed, 61 insertions(+)

-- 
2.7.4

