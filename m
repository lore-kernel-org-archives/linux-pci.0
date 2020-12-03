Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45B49C8447D
	for <linux-pci@archiver.kernel.org>; Thu,  3 Dec 2020 13:39:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 997C120637
	for <linux-pci@archiver.kernel.org>; Thu,  3 Dec 2020 13:39:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437068AbgLCNfl (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 3 Dec 2020 08:35:41 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:1593 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437051AbgLCNfk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Dec 2020 08:35:40 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fc8e9840000>; Thu, 03 Dec 2020 05:35:00 -0800
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 3 Dec
 2020 13:34:58 +0000
Received: from vidyas-desktop.nvidia.com (10.124.1.5) by mail.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Thu, 3 Dec 2020 13:34:54 +0000
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <lorenzo.pieralisi@arm.com>, <robh+dt@kernel.org>,
        <bhelgaas@google.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <amanharitsh123@gmail.com>,
        <dinghao.liu@zju.edu.cn>, <kw@linux.com>
CC:     <linux-pci@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>, <sagar.tv@gmail.com>
Subject: [PATCH V5 0/5] Enhancements to Tegra194 PCIe driver
Date:   Thu, 3 Dec 2020 19:04:46 +0530
Message-ID: <20201203133451.17716-1-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1607002500; bh=ES8XBJgJwYyN3RocTBM7NDyRiClwtsyQdX1IU0viogQ=;
        h=From:To:CC:Subject:Date:Message-ID:X-Mailer:X-NVConfidentiality:
         MIME-Version:Content-Type;
        b=mkLFuSGcyAMiUF/gxLdLwuxZQo+hcpRI1O+4eqCdBu6VQVb56jtO51zX8yqphh1vg
         fTvYFdevfaQSb6Ctdna0cJHd5mjoVMJ3m+iVQM5slbAEzXa1D4ZiT8EFqRcDMbDjqN
         y6hiP7lbspxVA2gwPR2lEbFZxecET7WWI+eCPiYtaodG7OBHzCSJXG96VFhSCSVehr
         ohahIGJOQUb5a7r9PzVZueZfFyVVHIQ2lfFTNbZHTyIRPD37ph+SJozvArEDGGzjF6
         huNdWpPennkMLtkAS+tfsybrOTrglkSw2mn9siw2nScEWhyWeTYpQ+O1KA0D8G8Pmp
         y+sCKTEShQZEA==
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This series of patches do some enhancements and some bug fixes to the
Tegra194 PCIe platform driver like
- Fix Vendor-ID corruption
- Update DWC IP version
- Continue with uninitialization sequence even if parts fail
- Check return value of tegra_pcie_init_controller()
- Disable LTSSM during link's L2 entry

V5:
* Rebased the first patch in the series
* Dropped the second patch
* Added Tested-by and Acked-by for rest of the patches

V4:
* Added a new patch to address link-up issues with some of the cards

V3:
* Addressed Bjorn's review comments
* Split earlier patch-4 into two
  - Continue with the uninitialization sequence even if some parts fail
  - Check return value of tegra_pcie_init_controller() and exit accordingly

V2:
* Addressed Rob's comments. Changed 'Strongly Ordered' to 'nGnRnE'

Vidya Sagar (5):
  PCI: tegra: Fix ASPM-L1SS advertisement disable code
  PCI: tegra: Set DesignWare IP version
  PCI: tegra: Continue unconfig sequence even if parts fail
  PCI: tegra: Check return value of tegra_pcie_init_controller()
  PCI: tegra: Disable LTSSM during L2 entry

 drivers/pci/controller/dwc/pcie-tegra194.c | 74 +++++++++++-----------
 1 file changed, 36 insertions(+), 38 deletions(-)

-- 
2.17.1

