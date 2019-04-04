Return-Path: <SRS0=GqAx=SG=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F70FC4360F
	for <linux-pci@archiver.kernel.org>; Thu,  4 Apr 2019 12:20:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D33D206C0
	for <linux-pci@archiver.kernel.org>; Thu,  4 Apr 2019 12:20:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="hJecLp56"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729013AbfDDMUd (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 4 Apr 2019 08:20:33 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:3786 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727039AbfDDMUd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 4 Apr 2019 08:20:33 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ca5f6940000>; Thu, 04 Apr 2019 05:20:36 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 04 Apr 2019 05:20:32 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 04 Apr 2019 05:20:32 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL106.nvidia.com
 (172.18.146.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 4 Apr
 2019 12:20:32 +0000
Received: from HQMAIL106.nvidia.com (172.18.146.12) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 4 Apr
 2019 12:20:32 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL106.nvidia.com
 (172.18.146.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Thu, 4 Apr 2019 12:20:32 +0000
Received: from vidyas-desktop.nvidia.com (Not Verified[10.24.37.38]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5ca5f68c0004>; Thu, 04 Apr 2019 05:20:31 -0700
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>,
        <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <Jisheng.Zhang@synaptics.com>, <thierry.reding@gmail.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kthota@nvidia.com>, <mmaddireddy@nvidia.com>,
        <sagar.tv@gmail.com>, <vidyas@nvidia.com>
Subject: [PATCH 0/2] PCI: dwc: Export symbols to support module build
Date:   Thu, 4 Apr 2019 17:50:22 +0530
Message-ID: <1554380425-29215-1-git-send-email-vidyas@nvidia.com>
X-Mailer: git-send-email 2.7.4
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1554380436; bh=mqCkPzy2rZXR2sQNjNDKE7RuHYFRZkaG/Q8D44z+Eck=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         X-NVConfidentiality:MIME-Version:Content-Type;
        b=hJecLp56XaHOhsIBRtMhVTVNPkFUe8B9B/6/Mf4lLSeClsLsZgFksBg3VxSZQYlHL
         ikSpTA4gKykPlhdwD6yFPSHjxbIKW5xep0VquxbfqsFLVm5sNEDgbJUchYQGp6mRL7
         B5EuPGsNXMBEHksd6n/7+udVivGAW3qUE4P8+vDmTRADypBoJpOjLrBqoNqOx1Ztgc
         ziXbCQzGJ9z9AM3koutBRhSM3zN+sXY/UhzoIiUuPVVArDIwg6OShgNQDWx6cmkTVp
         a4oI+DlAeCBZGsUiicqjKYRaBfTTLdyWhHaRnzosP4MnSNk8n+ot6idm/qr0LRtDyq
         otjdL/MY9IyJQ==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This patch set is based on Jisheng Zhang's <Jisheng.Zhang@synaptics.com>
patch set to support implementing .remove() hook in host controller
drivers of Designware based implementations.
Jisheng's patches: https://patchwork.kernel.org/project/linux-pci/list/?series=98559
This patch set moves config space APIs which are inlined in headers to
source files and exports them along with the other required APIs to
support building host controller drivers as modules.

Vidya Sagar (2):
  PCI: dwc: Add API support to de-initialize host
  PCI: dwc: Export APIs to support .remove() implementation

 drivers/pci/controller/dwc/pcie-designware-host.c | 11 +++++++
 drivers/pci/controller/dwc/pcie-designware.c      | 38 +++++++++++++++++++++
 drivers/pci/controller/dwc/pcie-designware.h      | 40 +++++++----------------
 3 files changed, 60 insertions(+), 29 deletions(-)

-- 
2.7.4

