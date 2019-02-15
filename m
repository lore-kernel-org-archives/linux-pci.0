Return-Path: <SRS0=N/Da=QW=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FEB3C43381
	for <linux-pci@archiver.kernel.org>; Fri, 15 Feb 2019 16:24:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7043621924
	for <linux-pci@archiver.kernel.org>; Fri, 15 Feb 2019 16:24:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726388AbfBOQYj (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 15 Feb 2019 11:24:39 -0500
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:13589 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbfBOQYj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 15 Feb 2019 11:24:39 -0500
X-IronPort-AV: E=Sophos;i="5.58,373,1544511600"; 
   d="scan'208";a="26801961"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 15 Feb 2019 09:24:38 -0700
Received: from microchip.com (10.10.76.4) by chn-sv-exch02.mchp-main.com
 (10.10.76.38) with Microsoft SMTP Server id 14.3.352.0; Fri, 15 Feb 2019
 09:24:38 -0700
From:   Daire McNamara <daire.mcnamara@microchip.com>
To:     <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     Daire McNamara <daire.mcnamara@microchip.com>
Subject: [PATCH v3 0/3] Add Microchip/Microsemi PolarFire SoC PCIe support
Date:   Fri, 15 Feb 2019 16:24:21 +0000
Message-ID: <20190215162424.564-1-daire.mcnamara@microchip.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This v3 patch series adds support for PCIe IP block on Microsemi/Microchip PolarFire SoCs.

Updates since v2:

o Split out DT bindings and Vendor ID updates into their own
  patch from PCIe driver.

o Updated ChangeLog.

Updates since v1:

o Incorporate feedback from Bjorn Helgaas.

Thanx, Daire

Daire McNamara (3):
  PCI: Add vendor ID for Microsemi
  dt-bindings: PCI: microsemi: Add DT Bindings for Microsemi PCIe host
    controller
  PCI: microsemi: Add host driver for Microsemi PCIe controller

 .../bindings/pci/microsemi-pcie.txt           |  65 ++
 .../devicetree/bindings/vendor-prefixes.txt   |   1 +
 drivers/pci/controller/Kconfig                |   8 +
 drivers/pci/controller/Makefile               |   1 +
 drivers/pci/controller/pcie-microsemi.c       | 764 ++++++++++++++++++
 5 files changed, 839 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/microsemi-pcie.txt
 create mode 100644 drivers/pci/controller/pcie-microsemi.c

-- 
2.17.0

