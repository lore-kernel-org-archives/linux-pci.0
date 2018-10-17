Return-Path: <SRS0=Zwnb=M5=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C623ECDE32
	for <linux-pci@archiver.kernel.org>; Wed, 17 Oct 2018 07:44:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D70912152C
	for <linux-pci@archiver.kernel.org>; Wed, 17 Oct 2018 07:44:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="MUbpYAgz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D70912152C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbeJQPi2 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 17 Oct 2018 11:38:28 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:56882 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727023AbeJQPi2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 17 Oct 2018 11:38:28 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id w9H7fkHs022804;
        Wed, 17 Oct 2018 02:41:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1539762106;
        bh=2WWPQAMSM+k66AkuBrc5v+Kp8ZWsb02iNUcBxfmuAhw=;
        h=From:To:CC:Subject:Date;
        b=MUbpYAgzmlOlklANhzp4ze+Q7vCpmBJcFkkLikf1G/YPug0kfByGavZe53t3QibjX
         4lbvOYaoh/l84V5ToXqXKvbfdWj25xaTSExVzRKIjAKJIjt7WSawiIvP5PBkO2Ln/T
         GCNEtwQQZgZxjtoXKfe/yZrIXYUv2ucUucwGk97c=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w9H7fk7N023068;
        Wed, 17 Oct 2018 02:41:46 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Wed, 17
 Oct 2018 02:41:45 -0500
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Wed, 17 Oct 2018 02:41:45 -0500
Received: from a0393678ub.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w9H7fgSL009413;
        Wed, 17 Oct 2018 02:41:42 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Murali Karicheri <m-karicheri2@ti.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
CC:     Rob Herring <robh+dt@kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v2 00/21] PCI: Cleanup pci-keystone driver
Date:   Wed, 17 Oct 2018 13:10:53 +0530
Message-ID: <20181017074114.28239-1-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The PCIe controller in AM654 uses Synopsys core revision 4.90a and uses
the same TI wrapper as used in keystone2 with certain modification.
Hence AM654 will use the same pci wrapper driver pci-keystone.c

In preparation for adding AM654 support, cleanup pci-keystone driver
here.

Most of the cleanups here are trivial with major modification being
merging pci-keystone-dw.c and pci-keystone.c

Cleaning-up irq handling in the RFC series is dropped here as it has
few comments to be addressed.

Changes from v1:
*) remove phy_reset in the cleanup PHY handling patch. It will be sent
   while adding AM654 support
*) Add a separate patch for using ERR_IRQ_STATUS instead of
   ERR_IRQ_STATUS_RAW
*) Split outbound window configuration into two patches. One which
   gets the number of outbound windows from DT and the other cleansup
   outbound window configuration.

Kishon Vijay Abraham I (21):
  PCI: keystone: Use quirk to limit MRRS for K2G
  PCI: keystone: Use quirk to set MRRS for PCI host bridge
  PCI: keystone: Move dw_pcie_setup_rc out of ks_pcie_establish_link()
  PCI: keystone: Do not initiate link training multiple times
  PCI: keystone: Remove unused argument from ks_dw_pcie_host_init()
  PCI: keystone: Merge pci-keystone-dw.c and pci-keystone.c
  PCI: keystone: Remove redundant platform_set_drvdata
  PCI: keystone: Use uniform function naming convention
  dt-bindings: PCI: keystone: Add bindings to get device control module
  PCI: keystone: Use syscon APIs to get device id from control module
  PCI: keystone: Cleanup PHY handling
  PCI: keystone: Invoke pm_runtime APIs to enable clock
  PCI: keystone: Cleanup configuration space access
  PCI: keystone: Get number of outbound windows from DT
  PCI: keystone: Cleanup outbound window configuration
  PCI: keystone: Cleanup set_dbi_mode and get_dbi_mode
  PCI: keystone: Cleanup ks_pcie_link_up()
  PCI: keystone: Use ERR_IRQ_STATUS instead of ERR_IRQ_STATUS_RAW to get
    interrupt status
  PCI: keystone: Add debug error message for all errors
  PCI: keystone: Reorder header file in alphabetical order
  PCI: keystone: Cleanup macros defined in pci-keystone.c

 .../devicetree/bindings/pci/pci-keystone.txt  |   3 +
 MAINTAINERS                                   |   2 +-
 drivers/pci/controller/dwc/Makefile           |   2 +-
 drivers/pci/controller/dwc/pci-keystone-dw.c  | 484 -----------
 drivers/pci/controller/dwc/pci-keystone.c     | 788 +++++++++++++++---
 drivers/pci/controller/dwc/pci-keystone.h     |  57 --
 drivers/pci/controller/dwc/pcie-designware.h  |   4 +
 7 files changed, 686 insertions(+), 654 deletions(-)
 delete mode 100644 drivers/pci/controller/dwc/pci-keystone-dw.c
 delete mode 100644 drivers/pci/controller/dwc/pci-keystone.h

-- 
2.17.1

