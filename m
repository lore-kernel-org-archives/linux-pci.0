Return-Path: <SRS0=/yaj=M3=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59139C04AA5
	for <linux-pci@archiver.kernel.org>; Mon, 15 Oct 2018 13:08:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CF9220652
	for <linux-pci@archiver.kernel.org>; Mon, 15 Oct 2018 13:08:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="oTgWruV/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CF9220652
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbeJOUxl (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 15 Oct 2018 16:53:41 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:43350 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726421AbeJOUxl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 Oct 2018 16:53:41 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id w9FD7x3Y089034;
        Mon, 15 Oct 2018 08:07:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1539608879;
        bh=CyfyeOqO+xEMDVi5R3qFBthl/zkUWZ8tRWgsoRxsgj8=;
        h=From:To:CC:Subject:Date;
        b=oTgWruV/FCj41fjMRmnwL0QrNTrYH3MOBqdrNqycY/bw+xlB+GFTcPyWxt1R1GSWA
         +DD3StGSPLf2PdcChzrv2W6LSaXCjGjTVteuDxsEWfOWJeS93+k11YbtEQIcxwd3Y/
         5NW+8wKODCQd4ueBNkUQP1WHWn+BLN/9e5c5an3c=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w9FD7x15031912;
        Mon, 15 Oct 2018 08:07:59 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Mon, 15
 Oct 2018 08:07:59 -0500
Received: from dflp33.itg.ti.com (10.64.6.16) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Mon, 15 Oct 2018 08:07:59 -0500
Received: from a0393678ub.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w9FD7tL3009433;
        Mon, 15 Oct 2018 08:07:56 -0500
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
Subject: [PATCH 00/19] PCI: Cleanup pci-keystone driver
Date:   Mon, 15 Oct 2018 18:37:02 +0530
Message-ID: <20181015130721.5535-1-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This series was sent as part of RFC series [1]

The PCIe controller in AM654 uses Synopsys core revision 4.90a and uses
the same TI wrapper as used in keystone2 with certain modification.
Hence AM654 will use the same pci wrapper driver pci-keystone.c

In preparation for adding AM654 support, cleanup pci-keystone driver
here.

Most of the cleanups here are trivial with major modification being
merging pci-keystone-dw.c and pci-keystone.c

Cleaning-up irq handling in the RFC series is dropped here as it has
few comments to be addressed.

Other patches which are part of the RFC series will be sent separately.

[1] -> https://lore.kernel.org/patchwork/cover/989487/

Kishon Vijay Abraham I (19):
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
  PCI: keystone: Get number of OB windows from DT and cleanup MEM space
    configuration
  PCI: keystone: Cleanup set_dbi_mode and get_dbi_mode
  PCI: keystone: Cleanup ks_pcie_link_up()
  PCI: keystone: Add debug error message for all errors
  PCI: keystone: Reorder header file in alphabetical order
  PCI: keystone: Cleanup macros defined in pci-keystone.c

 .../devicetree/bindings/pci/pci-keystone.txt  |   3 +
 MAINTAINERS                                   |   2 +-
 drivers/pci/controller/dwc/Makefile           |   2 +-
 drivers/pci/controller/dwc/pci-keystone-dw.c  | 484 -----------
 drivers/pci/controller/dwc/pci-keystone.c     | 794 +++++++++++++++---
 drivers/pci/controller/dwc/pci-keystone.h     |  57 --
 drivers/pci/controller/dwc/pcie-designware.h  |   4 +
 7 files changed, 692 insertions(+), 654 deletions(-)
 delete mode 100644 drivers/pci/controller/dwc/pci-keystone-dw.c
 delete mode 100644 drivers/pci/controller/dwc/pci-keystone.h

-- 
2.17.1

