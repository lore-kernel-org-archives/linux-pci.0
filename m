Return-Path: <SRS0=u7li=ZF=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80C0DC43331
	for <linux-pci@archiver.kernel.org>; Wed, 13 Nov 2019 07:21:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 641E121D7F
	for <linux-pci@archiver.kernel.org>; Wed, 13 Nov 2019 07:21:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726074AbfKMHVa (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 13 Nov 2019 02:21:30 -0500
Received: from mga18.intel.com ([134.134.136.126]:51386 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725858AbfKMHVa (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 13 Nov 2019 02:21:30 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Nov 2019 23:21:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,299,1569308400"; 
   d="scan'208";a="198361776"
Received: from sgsxdev004.isng.intel.com (HELO localhost) ([10.226.88.13])
  by orsmga008.jf.intel.com with ESMTP; 12 Nov 2019 23:21:25 -0800
From:   Dilip Kota <eswara.kota@linux.intel.com>
To:     gustavo.pimentel@synopsys.com, lorenzo.pieralisi@arm.com,
        andrew.murray@arm.com, helgaas@kernel.org, jingoohan1@gmail.com,
        robh@kernel.org, martin.blumenstingl@googlemail.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        andriy.shevchenko@intel.com
Cc:     linux-kernel@vger.kernel.org, cheol.yong.kim@intel.com,
        chuanhua.lei@linux.intel.com, qi-ming.wu@intel.com,
        Dilip Kota <eswara.kota@linux.intel.com>
Subject: [PATCH v6 0/3] PCI: Add Intel PCIe Driver and respective dt-binding yaml file
Date:   Wed, 13 Nov 2019 15:21:19 +0800
Message-Id: <cover.1573613534.git.eswara.kota@linux.intel.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Intel PCIe is Synopsys based controller. Intel PCIe driver uses
DesignWare PCIe framework for host initialization and register
configurations.

Changes on v6:
	Add Reviewed by tags for all the patches.
	Address review comments for all the patches.

Dilip Kota (3):
  dt-bindings: PCI: intel: Add YAML schemas for the PCIe RC controller
  dwc: PCI: intel: PCIe RC controller driver
  PCI: artpec6: Configure FTS with dwc helper function

 .../devicetree/bindings/pci/intel-gw-pcie.yaml     | 138 ++++++
 drivers/pci/controller/dwc/Kconfig                 |  10 +
 drivers/pci/controller/dwc/Makefile                |   1 +
 drivers/pci/controller/dwc/pcie-artpec6.c          |   8 +-
 drivers/pci/controller/dwc/pcie-designware.c       |  57 +++
 drivers/pci/controller/dwc/pcie-designware.h       |  12 +
 drivers/pci/controller/dwc/pcie-intel-gw.c         | 546 +++++++++++++++++
 include/uapi/linux/pci_regs.h                      |   1 +
 8 files changed, 766 insertions(+), 7 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/intel-gw-pcie.yaml
 create mode 100644 drivers/pci/controller/dwc/pcie-intel-gw.c

-- 
2.11.0

