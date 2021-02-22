Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00A4AC433DB
	for <linux-pci@archiver.kernel.org>; Mon, 22 Feb 2021 11:42:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB2DE64E27
	for <linux-pci@archiver.kernel.org>; Mon, 22 Feb 2021 11:42:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbhBVLmZ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 22 Feb 2021 06:42:25 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:60558 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbhBVLmT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 22 Feb 2021 06:42:19 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 11MBeYp4012507;
        Mon, 22 Feb 2021 05:40:34 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1613994034;
        bh=xRMR/gwIH0RJIoZU05qrkf2DdEF5SPVW6KGv8Mwwbew=;
        h=From:To:CC:Subject:Date;
        b=wX+TmfxS9D884H3hQ+ekW028sFR4OFCo2ATZqH1e3OhC1JKN5oqoqigLCWA9ZBjI6
         l63H/sls36p7gNCT55BxAFgBl3IdkYAkdBRRkK/8Us7Ewqz/1q2dgnOBx5tGnAN+TW
         xFqiWF8Qrlt+fdp1ahxZdIe4ia4s+I6CTMe9ZcIM=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 11MBeYGg126007
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 22 Feb 2021 05:40:34 -0600
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 22
 Feb 2021 05:40:34 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 22 Feb 2021 05:40:34 -0600
Received: from a0393678-ssd.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 11MBeVjm105473;
        Mon, 22 Feb 2021 05:40:31 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Tom Joseph <tjoseph@cadence.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v3 0/4] AM64: Add PCIe bindings and driver support
Date:   Mon, 22 Feb 2021 17:10:26 +0530
Message-ID: <20210222114030.26445-1-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

AM64 uses the same PCIe controller as in J7200, however AM642 EVM
doesn't have a clock generator (unlike J7200 base board). Here
the clock from the SERDES has to be routed to the PCIE connector.
This series provides an option for the pci-j721e.c driver to
drive reference clock output to the connector.

v1 of the patch series can be found @ [1]
v2 of the patch series can be found @ [2]

Changes from v2:
*) Fix DT binding documentation suggested by Rob

Changes from v1:
*) Fixed missing initialization of "ret" variable in the error path.

[1] -> http://lore.kernel.org/r/20201224115658.2795-1-kishon@ti.com
[2] -> https://lore.kernel.org/r/20210104124103.30930-1-kishon@ti.com

Kishon Vijay Abraham I (4):
  dt-bindings: PCI: ti,j721e: Add binding to represent refclk to the
    connector
  dt-bindings: PCI: ti,j721e: Add host mode dt-bindings for TI's AM64
    SoC
  dt-bindings: PCI: ti,j721e: Add endpoint mode dt-bindings for TI's
    AM64 SoC
  PCI: j721e: Add support to provide refclk to PCIe connector

 .../bindings/pci/ti,j721e-pci-ep.yaml         |  9 ++++----
 .../bindings/pci/ti,j721e-pci-host.yaml       | 19 +++++++++++------
 drivers/pci/controller/cadence/pci-j721e.c    | 21 ++++++++++++++++++-
 3 files changed, 38 insertions(+), 11 deletions(-)

-- 
2.17.1

