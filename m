Return-Path: <SRS0=w1cP=EM=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10405C5517A
	for <linux-pci@archiver.kernel.org>; Fri,  6 Nov 2020 15:11:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9585B22247
	for <linux-pci@archiver.kernel.org>; Fri,  6 Nov 2020 15:11:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="CDl4hRbN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727656AbgKFPL0 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 6 Nov 2020 10:11:26 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:53962 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727591AbgKFPLU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 6 Nov 2020 10:11:20 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0A6FBBeH021847;
        Fri, 6 Nov 2020 09:11:11 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1604675471;
        bh=8bodEtP5BVgRAK4fX0dXA+G6u/k3Ei6hrCIVOyhMj/Y=;
        h=From:To:CC:Subject:Date;
        b=CDl4hRbNqLQkjrVW6O81Ucqem5Mncz9CSedRfkzwN2ioRoFv+bKsCK4hVSjsF/t6j
         yvS8Eo5Pw5EChwR5dUJZaWzxgi8kkdKKJQhxUZ7ernzfWkUcUTcGwNdSukccRIMpoI
         F/J8XNUv1n5pazgAOGaVNl6i+mmOQfi+f3lMtMjA=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0A6FBBUO010650
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 6 Nov 2020 09:11:11 -0600
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 6 Nov
 2020 09:11:11 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 6 Nov 2020 09:11:11 -0600
Received: from a0393678-ssd.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0A6FB7Tf092540;
        Fri, 6 Nov 2020 09:11:08 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Tom Joseph <tjoseph@cadence.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     Kishon Vijay Abraham I <kishon@ti.com>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/2] PCI: Make "cdns,max-outbound-regions" optional DT property
Date:   Fri, 6 Nov 2020 20:41:05 +0530
Message-ID: <20201106151107.3987-1-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Make "cdns,max-outbound-regions" optional DT property in all the
platforms using Cadence PCIe core.

Kishon Vijay Abraham I (2):
  dt-bindings: PCI: Make "cdns,max-outbound-regions" optional property
  PCI: cadence: Do not error if "cdns,max-outbound-regions" is not found

 Documentation/devicetree/bindings/pci/cdns-pcie-ep.yaml  | 3 ---
 .../devicetree/bindings/pci/ti,j721e-pci-ep.yaml         | 2 --
 drivers/pci/controller/cadence/pcie-cadence-ep.c         | 9 +++------
 drivers/pci/controller/cadence/pcie-cadence.h            | 1 +
 4 files changed, 4 insertions(+), 11 deletions(-)

-- 
2.17.1

