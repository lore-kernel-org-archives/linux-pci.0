Return-Path: <SRS0=piPB=QZ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7470AC43381
	for <linux-pci@archiver.kernel.org>; Mon, 18 Feb 2019 09:53:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44ED8217F9
	for <linux-pci@archiver.kernel.org>; Mon, 18 Feb 2019 09:53:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729609AbfBRJw4 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 18 Feb 2019 04:52:56 -0500
Received: from inva020.nxp.com ([92.121.34.13]:55526 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728118AbfBRJwy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 18 Feb 2019 04:52:54 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id D3EAE1A010F;
        Mon, 18 Feb 2019 10:52:52 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 7204E1A00EF;
        Mon, 18 Feb 2019 10:52:45 +0100 (CET)
Received: from titan.ap.freescale.net (TITAN.ap.freescale.net [10.192.208.233])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 37D86402D8;
        Mon, 18 Feb 2019 17:52:36 +0800 (SGT)
From:   Xiaowei Bao <xiaowei.bao@nxp.com>
To:     bhelgaas@google.com, Zhiqiang.Hou@nxp.com, robh+dt@kernel.org,
        mark.rutland@arm.com, shawnguo@kernel.org, leoyang.li@nxp.com,
        kishon@ti.com, lorenzo.pieralisi@arm.com,
        gregkh@linuxfoundation.org, l.subrahmanya@mobiveil.co.in,
        arnd@arndb.de, Minghuan.Lian@nxp.com, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Xiaowei Bao <xiaowei.bao@nxp.com>
Subject: [PATCH 2/6] dt-bindings: add DT binding for the layerscape PCIe GEN4 controller with EP mode
Date:   Mon, 18 Feb 2019 17:46:39 +0800
Message-Id: <20190218094643.2692-2-xiaowei.bao@nxp.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20190218094643.2692-1-xiaowei.bao@nxp.com>
References: <20190218094643.2692-1-xiaowei.bao@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add the documentation for the Device Tree binding for the layerscape
PCIe GEN4 controller with EP mode.

Signed-off-by: Xiaowei Bao <xiaowei.bao@nxp.com>
---
depends on: http://patchwork.ozlabs.org/project/linux-pci/list/?series=88754

 .../bindings/pci/layerscape-pci-gen4.txt           |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/layerscape-pci-gen4.txt b/Documentation/devicetree/bindings/pci/layerscape-pci-gen4.txt
index b40fb5d..1b9d0bf 100644
--- a/Documentation/devicetree/bindings/pci/layerscape-pci-gen4.txt
+++ b/Documentation/devicetree/bindings/pci/layerscape-pci-gen4.txt
@@ -5,7 +5,10 @@ the common properties defined in mobiveil-pcie.txt.
 
 Required properties:
 - compatible: should contain the platform identifier such as:
-  "fsl,lx2160a-pcie"
+  RC mode:
+	"fsl,lx2160a-pcie"
+  EP mode:
+	"fsl,lx2160a-pcie-ep"
 - reg: base addresses and lengths of the PCIe controller register blocks.
   "csr_axi_slave": Bridge config registers
   "config_axi_slave": PCIe controller registers
-- 
1.7.1

