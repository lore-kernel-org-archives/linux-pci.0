Return-Path: <SRS0=IRPw=OW=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FABCC65BAE
	for <linux-pci@archiver.kernel.org>; Thu, 13 Dec 2018 10:33:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA94320811
	for <linux-pci@archiver.kernel.org>; Thu, 13 Dec 2018 10:33:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="JLHOCAhg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA94320811
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728569AbeLMKdS (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 13 Dec 2018 05:33:18 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36994 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727396AbeLMKdS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 Dec 2018 05:33:18 -0500
Received: by mail-wr1-f66.google.com with SMTP id s12so1000873wrt.4
        for <linux-pci@vger.kernel.org>; Thu, 13 Dec 2018 02:33:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=LtSfmEgwkXLipM2oN/tEJZ5i0J/LLJlpLAEY0OfDiU0=;
        b=JLHOCAhgzFEHqBtVgFMSU0jr0FAQyMNzUj1aOGT/ZKypZXOwMexKpagmP70EPmgHAe
         1CnUr3h+ie1j36w7LOjwn88K8z1eRP1js/WvHpquqqvRIjlvse+hx0smY33i7evJyosl
         CUlQTukUHKH/vmSGSg9T8KB54MenF3tEZHNyE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=LtSfmEgwkXLipM2oN/tEJZ5i0J/LLJlpLAEY0OfDiU0=;
        b=W/Di0NsRWofpemTf9s+47cNPJHAzLNyA22MynyAbfhKm/p45WtZhZrURR8ZQmYGBxS
         fP+VR/1E/BJNstmtLLXZ5HucH4oKJUqwEQpTlZmT9q56S5QAqaG7bMzl/MgXIIfAHRpi
         aJ229rrnyLa0rueY9hmUeCXd9JpYjkv7Ji+euvurAZtmeskl2saRneMlMC2ZgI+xpMKT
         M+I/TG3uZx01p77T1NUZkQd391479ns55Ss2cr5PwFLYbQsm5Ogf1pH0mlbErkIAp8Pf
         ++38ton8xjImDacWFYK3ruzE4Ax6tgQ3JhMgBeziDc8sIPOznIIv6riN2DEpG5p1uUj+
         aSvg==
X-Gm-Message-State: AA+aEWbcZnQAmOt6Ef1XPgKaJvxFdiYouLaE/dbJtWetyWksJ2a0+PKa
        IoC3igoVG72zV+jWXtPlR9IIqg==
X-Google-Smtp-Source: AFSGD/WykvkLgnLRFD8Su9Um5xoJbrYFafEDHsVSgEWPR4/QPDMlQEYiPI92nrS8tIAQsPzUWWae7g==
X-Received: by 2002:adf:e407:: with SMTP id g7mr19801956wrm.277.1544697196160;
        Thu, 13 Dec 2018 02:33:16 -0800 (PST)
Received: from mannams-OptiPlex-7010.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id x76sm3327058wmd.27.2018.12.13.02.33.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 13 Dec 2018 02:33:15 -0800 (PST)
From:   Srinath Mannam <srinath.mannam@broadcom.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Robin Murphy <robin.murphy@arm.com>, poza@codeaurora.org,
        Joerg Roedel <joro@8bytes.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Ray Jui <rjui@broadcom.com>
Cc:     bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Srinath Mannam <srinath.mannam@broadcom.com>
Subject: [PATCH v2 0/3] PCIe Host request to reserve IOVA
Date:   Thu, 13 Dec 2018 16:02:51 +0530
Message-Id: <1544697174-6029-1-git-send-email-srinath.mannam@broadcom.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Few SOCs have limitation that their PCIe host can't allow few inbound
address ranges.
Allowed inbound address ranges are listed in dma-ranges DT property and
this address ranges are required to do IOVA mapping.
Remaining address ranges have to be reserved in IOVA mapping.

PCIe Host driver of those SOCs has to list all address ranges which have
to reserve their IOVA address into PCIe host bridge resource entry list.
IOMMU framework will reserve these IOVAs while initializing IOMMU domain.

This patch set is based on Linux-4.19-rc1.

Changes from v1:
  - Addressed Oza review comments.

Srinath Mannam (3):
  PCI: Add dma-resv window list
  iommu/dma: IOVA reserve for PCI host reserve address list
  PCI: iproc: Add dma reserve resources to host

 drivers/iommu/dma-iommu.c           |  8 ++++++
 drivers/pci/controller/pcie-iproc.c | 51 ++++++++++++++++++++++++++++++++++++-
 drivers/pci/probe.c                 |  3 +++
 include/linux/pci.h                 |  1 +
 4 files changed, 62 insertions(+), 1 deletion(-)

-- 
2.7.4

