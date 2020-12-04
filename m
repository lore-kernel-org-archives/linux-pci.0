Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9515EC19425
	for <linux-pci@archiver.kernel.org>; Fri,  4 Dec 2020 07:53:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5384622581
	for <linux-pci@archiver.kernel.org>; Fri,  4 Dec 2020 07:53:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728677AbgLDHx1 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 4 Dec 2020 02:53:27 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:36452 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726669AbgLDHx1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 4 Dec 2020 02:53:27 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0B47pe0R081483;
        Fri, 4 Dec 2020 01:51:40 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1607068300;
        bh=7B4Z9V9FJVne7AXPMH64Qu4HHhhon+GsU3KmmNhBkbw=;
        h=From:To:CC:Subject:Date;
        b=OTRjZLLXP+HqLLYpiZw9JmRmOj/YPm80KxiwFc66YTOZO6I6m6PUZ1Z0TDOdZ6hou
         6LXDzpeKfIClg0ZBNeP7wt8m8MfQhZn1vQQr7FJfDQFi8IWK7lSHEcA8+1/cbnj8Rp
         jt+keN7+C064XR8+j38sx9+qtc7/pXqQwhb1njFQ=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0B47peR0113074
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 4 Dec 2020 01:51:40 -0600
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 4 Dec
 2020 01:51:40 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 4 Dec 2020 01:51:40 -0600
Received: from a0393678-ssd.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0B47pL6s031834;
        Fri, 4 Dec 2020 01:51:24 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Tom Joseph <tjoseph@cadence.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-omap@vger.kernel.org>
Subject: [PATCH v2 0/3] PCI: J721E: Fix Broken DT w.r.t SYSCON DT
Date:   Fri, 4 Dec 2020 13:21:14 +0530
Message-ID: <20201204075117.10430-1-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Previously a subnode to syscon node was added which has the
exact memory mapped address of pcie_ctrl but based on review comment
provided by Rob [1], the offset is now being passed as argument to
"ti,syscon-pcie-ctrl" phandle.

This series has both driver change and DT change. The driver change
should be merged first and the driver takes care of maintaining old
DT compatibility.

Changes frm v1:
*) Remove use of allOf in schema
*) Added Fixes tag
*) Maintain old DT compatibility

[1] -> http://lore.kernel.org/r/CAL_JsqKiUcO76bo1GoepWM1TusJWoty_BRy2hFSgtEVMqtrvvQ@mail.gmail.com

Kishon Vijay Abraham I (3):
  dt-bindings: pci: ti,j721e: Fix "ti,syscon-pcie-ctrl" to take argument
  PCI: j721e: Get offset within "syscon" from "ti,syscon-pcie-ctrl"
    phandle arg
  arm64: dts: ti: k3-j721e-main: Remove "syscon" nodes added for
    pcieX_ctrl

 .../bindings/pci/ti,j721e-pci-ep.yaml         | 11 +++--
 .../bindings/pci/ti,j721e-pci-host.yaml       | 11 +++--
 arch/arm64/boot/dts/ti/k3-j721e-main.dtsi     | 48 ++++---------------
 drivers/pci/controller/cadence/pci-j721e.c    | 28 +++++++----
 4 files changed, 41 insertions(+), 57 deletions(-)

-- 
2.17.1

