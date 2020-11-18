Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ADA1C64E7C
	for <linux-pci@archiver.kernel.org>; Wed, 18 Nov 2020 14:46:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC373246F3
	for <linux-pci@archiver.kernel.org>; Wed, 18 Nov 2020 14:46:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="VyeF7YZZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727140AbgKROqh (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 18 Nov 2020 09:46:37 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:5332 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727139AbgKROqh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 18 Nov 2020 09:46:37 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fb533c30000>; Wed, 18 Nov 2020 06:46:27 -0800
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 18 Nov
 2020 14:46:33 +0000
Received: from vidyas-desktop.nvidia.com (10.124.1.5) by mail.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Wed, 18 Nov 2020 14:46:29 +0000
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>,
        <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <amurray@thegoodpenguin.co.uk>, <robh@kernel.org>,
        <treding@nvidia.com>, <jonathanh@nvidia.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kthota@nvidia.com>, <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>,
        <sagar.tv@gmail.com>
Subject: [PATCH V2 0/2] Add support to handle prefetchable memory
Date:   Wed, 18 Nov 2020 20:16:24 +0530
Message-ID: <20201118144626.32189-1-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1605710787; bh=INq5vLbyTWWyt1vHczEGSDzUU1nqbXbjY6EbRNYLmHY=;
        h=From:To:CC:Subject:Date:Message-ID:X-Mailer:X-NVConfidentiality:
         MIME-Version:Content-Type;
        b=VyeF7YZZVl0r6COPqS5zNU7/8gxA34zg6yNPN1eMaiO2wACPm7ui3pKiQvQdAPljn
         bPRSblHzZ1K7HnUdN85ocUJu0NngaCiGHGcpy12uPdvtrt7KpsedsB0Zc6A4b5bJmt
         B80iYMPDJEm7cXIoqINaNLMrL28LhaGoO3/mYNd7Gd2xcJf2m++6HDRnOlrmpGGjIH
         Vruwk4A0+K/cMg/SXBKCFLmhC7Tvhu0HEABsYGgWeZoxZeiI6muwAHyVbp1vbzCegj
         kx0NbD13LIKftzc2gWaN1IqsnnAGNie0XTM2i8u04FMmSXc9NaqrY0ZciTtaf5eRQf
         7SZQVhRbZ/Esg==
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This patch series adds support for configuring the DesignWare IP's ATU
region for prefetchable memory translations.
It first starts by flagging a warning if the size of non-prefetchable
aperture goes beyond 32-bit as PCIe spec doesn't allow it.
And then adds required support for programming the ATU to handle higher
(i.e. >4GB) sizes.

V2:
* Dropped third patch from the series as Rob's patch
  (commit: 9fff3256f93d PCI: dwc: Restore ATU memory resource setup to use last entry)
  is already accepted
* Rebased first two patches on top of Rob's latest patch
  http://patchwork.ozlabs.org/project/linux-pci/patch/20201026181652.418729-1-robh@kernel.org/

Vidya Sagar (2):
  PCI: of: Warn if non-prefetchable memory aperture size is > 32-bit
  PCI: dwc: Add support to program ATU for >4GB memory

 drivers/pci/controller/dwc/pcie-designware.c | 12 +++++++-----
 drivers/pci/controller/dwc/pcie-designware.h |  3 ++-
 drivers/pci/of.c                             |  5 +++++
 3 files changed, 14 insertions(+), 6 deletions(-)

-- 
2.17.1

