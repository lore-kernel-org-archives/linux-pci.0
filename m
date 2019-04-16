Return-Path: <SRS0=aMvC=SS=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08608C10F13
	for <linux-pci@archiver.kernel.org>; Tue, 16 Apr 2019 14:15:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAFE9223DC
	for <linux-pci@archiver.kernel.org>; Tue, 16 Apr 2019 14:15:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="KLNwVFFD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726230AbfDPOPY (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 16 Apr 2019 10:15:24 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:1980 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725861AbfDPOPY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 16 Apr 2019 10:15:24 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cb5e3790000>; Tue, 16 Apr 2019 07:15:21 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 16 Apr 2019 07:15:24 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 16 Apr 2019 07:15:24 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL106.nvidia.com
 (172.18.146.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 16 Apr
 2019 14:15:23 +0000
Received: from HQMAIL103.nvidia.com (172.20.187.11) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 16 Apr
 2019 14:15:23 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL103.nvidia.com
 (172.20.187.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Tue, 16 Apr 2019 14:15:23 +0000
Received: from vidyas-desktop.nvidia.com (Not Verified[10.24.37.38]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5cb5e3780000>; Tue, 16 Apr 2019 07:15:23 -0700
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>,
        <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <Jisheng.Zhang@synaptics.com>, <thierry.reding@gmail.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kthota@nvidia.com>, <mmaddireddy@nvidia.com>,
        <sagar.tv@gmail.com>, <vidyas@nvidia.com>
Subject: [PATCH V2 0/2] PCI: dwc: Export symbols to support module build
Date:   Tue, 16 Apr 2019 19:45:14 +0530
Message-ID: <20190416141516.23908-1-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1555424121; bh=+pBwCWTKln8bF+APdRIZAUrNKPPT8pHzC9TPDFoIYjk=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         X-NVConfidentiality:MIME-Version:Content-Type;
        b=KLNwVFFDTgX9tUoz4K00aPpTiib+08396YVsB78WHYYpnpZ6ThfAzlagS+hJuYKa6
         t/7entEb+G2ylVPClkqj1zkywqHAJKgjNGlW4UaMTIQ5PAu0nh1RMdNRaxRC+ubZC0
         g1Vj3OQOurj29N5hzSDAgKC8XSyC0NukZNHUQJySf3agWeZ24gE0ba4TFRL33ePUT/
         Sd0TfnwrL6u+fB9XVq8skasCjCKHOtF37Ip96Te+BpY7yVWxI/FE9orxQk+El6wHns
         Y/N40BRKOlasDgkJMC6YVyrZCHIMt6zVhXx3QlvKtxx9eubqZsUJI2kKEGdm+eYGXr
         VYfId/Ip0rM1A==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This patch set is based on Jisheng Zhang's <Jisheng.Zhang@synaptics.com>
patch set to support implementing .remove() hook in host controller
drivers of DesignWare based implementations.
Jisheng's patches: https://patchwork.kernel.org/project/linux-pci/list/?series=98559
This patch set moves config space APIs which are inlined in headers to
source files and exports them along with the other required APIs to
support building host controller drivers as modules.

Vidya Sagar (2):
  PCI: dwc: Add API support to de-initialize host
  PCI: dwc: Export APIs to support .remove() implementation

 .../pci/controller/dwc/pcie-designware-host.c | 11 +++++
 drivers/pci/controller/dwc/pcie-designware.c  | 38 ++++++++++++++++++
 drivers/pci/controller/dwc/pcie-designware.h  | 40 +++++--------------
 3 files changed, 60 insertions(+), 29 deletions(-)

-- 
2.17.1

