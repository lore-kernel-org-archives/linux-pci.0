Return-Path: <SRS0=zisR=CQ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5651C43461
	for <linux-pci@archiver.kernel.org>; Mon,  7 Sep 2020 05:46:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85CEA215A4
	for <linux-pci@archiver.kernel.org>; Mon,  7 Sep 2020 05:46:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbgIGFqA (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 7 Sep 2020 01:46:00 -0400
Received: from inva020.nxp.com ([92.121.34.13]:44056 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726708AbgIGFqA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 7 Sep 2020 01:46:00 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 5BE101A0FB4;
        Mon,  7 Sep 2020 07:45:58 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 1DA351A0FCC;
        Mon,  7 Sep 2020 07:45:53 +0200 (CEST)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 5B770402CA;
        Mon,  7 Sep 2020 07:45:46 +0200 (CEST)
From:   Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
To:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, bhelgaas@google.com,
        robh+dt@kernel.org, shawnguo@kernel.org, leoyang.li@nxp.com,
        lorenzo.pieralisi@arm.com, gustavo.pimentel@synopsys.com
Cc:     minghuan.Lian@nxp.com, mingkai.hu@nxp.com, roy.zang@nxp.com,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Subject: [PATCH 0/7] PCI: layerscape: Add power management support
Date:   Mon,  7 Sep 2020 13:37:54 +0800
Message-Id: <20200907053801.22149-1-Zhiqiang.Hou@nxp.com>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

This patch series is to add PCIe power management support for NXP
Layerscape platfroms.

Hou Zhiqiang (7):
  PCI: dwc: Fix a bug of the case dw_pci->ops is NULL
  PCI: layerscape: Change to use the DWC common link-up check function
  dt-bindings: pci: layerscape-pci: Add a optional property big-endian
  arm64: dts: layerscape: Add big-endian property for PCIe nodes
  dt-bindings: pci: layerscape-pci: Update the description of SCFG
    property
  dts: arm64: ls1043a: Add SCFG phandle for PCIe nodes
  PCI: layerscape: Add power management support

 .../bindings/pci/layerscape-pci.txt           |   6 +-
 .../arm64/boot/dts/freescale/fsl-ls1012a.dtsi |   1 +
 .../arm64/boot/dts/freescale/fsl-ls1043a.dtsi |   6 +
 .../arm64/boot/dts/freescale/fsl-ls1046a.dtsi |   3 +
 drivers/pci/controller/dwc/pci-layerscape.c   | 473 ++++++++++++++----
 drivers/pci/controller/dwc/pcie-designware.c  |  12 +-
 drivers/pci/controller/dwc/pcie-designware.h  |   1 +
 7 files changed, 388 insertions(+), 114 deletions(-)

-- 
2.17.1

