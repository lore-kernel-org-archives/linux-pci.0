Return-Path: <SRS0=vddI=EK=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68FFCC388F7
	for <linux-pci@archiver.kernel.org>; Wed,  4 Nov 2020 08:52:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03C37216C4
	for <linux-pci@archiver.kernel.org>; Wed,  4 Nov 2020 08:52:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="OPTuhg9g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728328AbgKDIwN (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 4 Nov 2020 03:52:13 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:5975 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbgKDIwN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 4 Nov 2020 03:52:13 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fa26bbb0000>; Wed, 04 Nov 2020 00:52:11 -0800
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 4 Nov
 2020 08:52:10 +0000
Received: from vidyas-desktop.nvidia.com (10.124.1.5) by mail.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Wed, 4 Nov 2020 08:52:05 +0000
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <lorenzo.pieralisi@arm.com>, <robh+dt@kernel.org>,
        <bhelgaas@google.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <amanharitsh123@gmail.com>,
        <dinghao.liu@zju.edu.cn>, <kw@linux.com>
CC:     <linux-pci@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>, <sagar.tv@gmail.com>
Subject: [PATCH V3 0/5] Enhancements to Tegra194 PCIe driver
Date:   Wed, 4 Nov 2020 14:20:13 +0530
Message-ID: <20201104085018.13021-1-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1604479931; bh=4gQ5tWn0Fs6MivWfKflLTNgLOSsVUn4p6ZgXMZgzNKw=;
        h=From:To:CC:Subject:Date:Message-ID:X-Mailer:X-NVConfidentiality:
         MIME-Version:Content-Type;
        b=OPTuhg9gdUUJLZYqI2M/ho6/nCVpxEQTUaOdAceYIVpruqyxVDWZWGvkN86hzVtzs
         EAy/KR3UbDTUmcd1BhaueP/6VCscRzwQEwgeDXRvBqYBzJ0wKzov48JJgbJqHCHitC
         vIrfwGobW8L7vP4WQo8UMWRTKVb1BYZT6Ac23CANtwO+tPn/oh4b94EQgenl9pge/T
         uOXXgPRT/bl9VKg6RoxwtqWPtyWqQPGBqL4ScayDiYqLsoIDqJOIN7wjwmJ1iHKg1N
         uaG7DijGekckAGeFTNUdwK1Emx0QctrUqcbZG6kIniRZ1dAppVkLGxhdwajYKcLqJY
         dQ9YieeO89Ewg==
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This series of patches do some enhancements and some bug fixes to the
Tegra194 PCIe platform driver like
- Fix Vendor-ID corruption
- Map DBI space correctly
- Update DWC IP version
- Continue with uninitialization sequence even if parts fail
- Check return value of tegra_pcie_init_controller()

V3:
* Addressed Bjorn's review comments
* Split earlier patch-4 into two
  - Continue with the uninitialization sequence even if some parts fail
  - Check return value of tegra_pcie_init_controller() and exit accordingly

V2:
* Addressed Rob's comments. Changed 'Strongly Ordered' to 'nGnRnE'

Vidya Sagar (5):
  PCI: tegra: Fix ASPM-L1SS advertisement disable code
  PCI: tegra: Map configuration space as nGnRnE
  PCI: tegra: Set DesignWare IP version
  PCI: tegra: Continue unconfig sequence even if parts fail
  PCI: tegra: Check return value of tegra_pcie_init_controller()

 drivers/pci/controller/dwc/pcie-tegra194.c | 62 +++++++++++-----------
 1 file changed, 30 insertions(+), 32 deletions(-)

-- 
2.17.1

