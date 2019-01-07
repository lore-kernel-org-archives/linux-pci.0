Return-Path: <SRS0=70A0=PP=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5D52C43387
	for <linux-pci@archiver.kernel.org>; Mon,  7 Jan 2019 06:43:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75B1D2085A
	for <linux-pci@archiver.kernel.org>; Mon,  7 Jan 2019 06:43:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="kZPHA6oK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726285AbfAGGnG (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 7 Jan 2019 01:43:06 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:36580 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725771AbfAGGnG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Jan 2019 01:43:06 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x076gj8U021418;
        Mon, 7 Jan 2019 00:42:45 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1546843365;
        bh=DSaAqsEfEzTCywHsfjCCo04K82q4H4Dl4uu8P0Qbj8E=;
        h=From:To:CC:Subject:Date;
        b=kZPHA6oKtBt1ZBJwMnyd7XEFM3Wof6RkU8UM+/WBldwlDlTJ9C4TudSECdkNDY3uT
         45/oMF49uYteHJENr2aMvBzAL0fQEfhHFhnYw53lhFjygBFUwsVtn+T3FQaS0Ob1/M
         kuiWp+HxVP10lXqyVFFtPGWLZavoseBONQMM0zWE=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x076gj8A070684
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 7 Jan 2019 00:42:45 -0600
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 7
 Jan 2019 00:42:45 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 7 Jan 2019 00:42:45 -0600
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x076gfnv002672;
        Mon, 7 Jan 2019 00:42:41 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Alan Douglas <adouglas@cadence.com>,
        Shawn Lin <shawn.lin@rock-chips.com>
CC:     Jingoo Han <jingoohan1@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Cyrille Pitchen <cyrille.pitchen@free-electrons.com>,
        Jia-Ju Bai <baijiaju1990@gmail.com>,
        <linux-omap@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-rockchip@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>, <kishon@ti.com>
Subject: [PATCH 00/15] PCI: endpoint: Cleanup EPC features
Date:   Mon, 7 Jan 2019 12:11:33 +0530
Message-ID: <20190107064148.10152-1-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Lorenzo,

The Endpoint controller driver uses features member in 'struct pci_epc'
to advertise the list of supported features to the endpoint function
driver.

There are a few shortcomings with this approach.
  *) Certain endpoint controllers support fixed size BAR (e.g. TI's
     AM654 uses Designware configuration with fixed size BAR). The
     size of each BARs cannot be passed to the endpoint function
     driver.
  *) Too many macros for handling EPC features.
     (EPC_FEATURE_NO_LINKUP_NOTIFIER, EPC_FEATURE_BAR_MASK,
      EPC_FEATURE_MSIX_AVAILABLE, EPC_FEATURE_SET_BAR,
      EPC_FEATURE_GET_BAR)
  *) Endpoint controllers are directly modifying struct pci_epc
     members. (I have plans to move struct pci_epc to
     drivers/pci/endpoint so that pci_epc members are referenced
     only by endpoint core).

To overcome the above shortcomings, introduced pci_epc_get_features()
API, pci_epc_features structure and a ->get_features() callback.

Also added a patch to set BAR flags in pci_epf_alloc_space and
remove it from pci-epf-test function driver.

Tested on TI's DRA7xx platform.

Thanks
Kishon

Kishon Vijay Abraham I (15):
  PCI: endpoint: Add new pci_epc_ops to get EPC features
  PCI: dwc: Add ->get_features() callback function in dw_pcie_ep_ops
  PCI: designware-plat: Populate ->get_features() dw_pcie_ep_ops
  PCI: pci-dra7xx: Populate ->get_features() dw_pcie_ep_ops
  PCI: rockchip: Populate ->get_features() dw_pcie_ep_ops
  PCI: cadence: Populate ->get_features() cdns_pcie_epc_ops
  PCI: endpoint: Add helper to get first unreserved BAR
  PCI: endpoint: Fix pci_epf_alloc_space to set correct MEM TYPE flags
  PCI: pci-epf-test: Remove setting epf_bar flags in function driver
  PCI: pci-epf-test: Do not allocate next BARs memory if current BAR is
    64Bit
  PCI: pci-epf-test: Use pci_epc_get_features to get EPC features
  PCI: cadence: Remove pci_epf_linkup from Cadence EP driver
  PCI: rockchip: Remove pci_epf_linkup from Rockchip EP driver
  PCI: designware-plat: Remove setting epc->features in Designware plat
    EP driver
  PCI: endpoint: Remove features member in struct pci_epc

 drivers/pci/controller/dwc/pci-dra7xx.c       | 13 +++
 .../pci/controller/dwc/pcie-designware-ep.c   | 12 +++
 .../pci/controller/dwc/pcie-designware-plat.c | 17 +++-
 drivers/pci/controller/dwc/pcie-designware.h  |  1 +
 drivers/pci/controller/pcie-cadence-ep.c      | 25 +++---
 drivers/pci/controller/pcie-rockchip-ep.c     | 16 +++-
 drivers/pci/endpoint/functions/pci-epf-test.c | 80 ++++++++++---------
 drivers/pci/endpoint/pci-epc-core.c           | 52 ++++++++++++
 drivers/pci/endpoint/pci-epf-core.c           |  3 +
 include/linux/pci-epc.h                       | 30 +++++--
 10 files changed, 185 insertions(+), 64 deletions(-)

-- 
2.17.1

