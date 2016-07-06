Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:15838 "EHLO
	mx0a-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753831AbcGFLD7 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 6 Jul 2016 07:03:59 -0400
From: Jisheng Zhang <jszhang@marvell.com>
To: <jingoohan1@gmail.com>, <pratyush.anand@gmail.com>,
	<bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	Jisheng Zhang <jszhang@marvell.com>
Subject: [PATCH 0/2] PCI: designware: let dw_pcie_link_up() beware of LTSSM training bit
Date: Wed, 6 Jul 2016 18:59:40 +0800
Message-ID: <1467802782-3024-1-git-send-email-jszhang@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

patch1 is a trivial clean up: move the parameters for wait for link
into the core pcie-designware.c

Since link may be UP but still in link training, if so, we can't think
the link is up and operating correctly. So patch2 teaches
dw_pcie_link_up() beware of the PCIE_PHY_DEBUG_R1_LINK_IN_TRAINING bit.


Jisheng Zhang (2):
  PCI: designware: mv parameters for wait for link into
    pcie-designware.c
  PCI: designware: let dw_pcie_link_up() beware of LTSSM training bit

 drivers/pci/host/pcie-designware.c | 11 +++++++++--
 drivers/pci/host/pcie-designware.h |  5 -----
 2 files changed, 9 insertions(+), 7 deletions(-)

-- 
2.8.1

