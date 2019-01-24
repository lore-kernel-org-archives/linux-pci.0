Return-Path: <SRS0=Sdll=QA=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C844C282C5
	for <linux-pci@archiver.kernel.org>; Thu, 24 Jan 2019 08:30:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B08E2184C
	for <linux-pci@archiver.kernel.org>; Thu, 24 Jan 2019 08:30:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="sdJRgCmd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727451AbfAXIai (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 24 Jan 2019 03:30:38 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:39790 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726212AbfAXIai (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Jan 2019 03:30:38 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x0O8UWWT098735;
        Thu, 24 Jan 2019 02:30:32 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1548318632;
        bh=4MdR0ga7d28v/h7qjL+PcjxkpY64yBu0ItQ7YJ4O6ZE=;
        h=From:To:CC:Subject:Date;
        b=sdJRgCmdHHCo/Jr2IqbAtR5ccQQWFdR7XsIffPWof8x0S4UKT9+C6WjV9LcMkX1Q5
         qjUiJsrul692vY0WGOyBRDT/Y1ZFpWw9KR5Gt548QMaE4Y0S0gdZ+WXfWQgLrkB5zJ
         EX6WjzsPLbamFXjT8oAOpMBTBDv+LTkChm0Ia4P8=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x0O8UWbW111606
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 24 Jan 2019 02:30:32 -0600
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Thu, 24
 Jan 2019 02:30:32 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Thu, 24 Jan 2019 02:30:32 -0600
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x0O8UTbY012320;
        Thu, 24 Jan 2019 02:30:29 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     Bjorn Helgaas <bhelgaas@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        <linux-omap@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 0/3] PCI: dra7xx: Support PCIe x2 lane mode
Date:   Thu, 24 Jan 2019 13:59:54 +0530
Message-ID: <20190124082957.29077-1-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Previous version of the patch series can be found here [1]

Patch series adds support to enable x2 lane mode in dra74/dra76 and
dra72 based boards in pci-dra7xx driver. It introduces new compatible
strings in order to enable x2 lane mode support.

Changes from v2:
*) Have a single syscon dt property for configuring x2 lanes
*) Fix minor comments given by Lorenzo (falling back to 1 lane mode,
   remove unused structure member).

Changes from v1:
*) Added ti prefix to syscon-lane-conf and syscon-lane-sel as
   suggested to Rob
*) Merged "PCI: dwc: dra7xx: Add support for SoC specific compatible
   strings" and "PCI: dwc: pci-dra7xx: Enable x2 mode support" into
   a single patch.
*) Fixed $subject as suggested by Bjorn
*) Added x2 lane mode support for DRA72x

The dts changes and phy changes will be sent as a separate series.

[1] ->  https://lkml.org/lkml/2017/12/19/175

Kishon Vijay Abraham I (3):
  dt-bindings: PCI: dra7xx: Add SoC specific compatible strings
  dt-bindings: PCI: dra7xx: Add properties to enable x2 lane in dra7
  PCI: dra7xx: Enable x2 mode support for dra74x, dra76x and dra72x

 .../devicetree/bindings/pci/ti-pci.txt        | 11 ++-
 drivers/pci/controller/dwc/pci-dra7xx.c       | 77 +++++++++++++++++++
 2 files changed, 86 insertions(+), 2 deletions(-)

-- 
2.17.1

