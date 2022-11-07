Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C2B5C43217
	for <linux-pci@archiver.kernel.org>; Mon,  7 Nov 2022 21:11:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233433AbiKGVLc (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 7 Nov 2022 16:11:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231378AbiKGVKj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Nov 2022 16:10:39 -0500
Received: from post.baikalelectronics.com (post.baikalelectronics.com [213.79.110.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8035832BBE;
        Mon,  7 Nov 2022 13:07:33 -0800 (PST)
Received: from post.baikalelectronics.com (localhost.localdomain [127.0.0.1])
        by post.baikalelectronics.com (Proxmox) with ESMTP id 9C122E0EC0;
        Mon,  7 Nov 2022 23:50:18 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        baikalelectronics.ru; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:from:from:in-reply-to:message-id
        :mime-version:references:reply-to:subject:subject:to:to; s=post;
         bh=Yfpic8frEn8o3rraTnI56GKGY7EvlsQ+xuYVEJJd968=; b=dUgR5kUjjkDi
        0xkYrNesj8WSUZ0hurQXAVEW9M/vvNraDfbxz0ovaVLTteaHi6TlnEnlt2QisFzs
        j3fk/vtyYTZNQ2q6s2Jjm71jxpP4e2sqXvF8LQ5J8O+saP4Emo/LBs6SM4pBELtv
        axxcCogARQUEHKQ5gs3DWCG403LSgLQ=
Received: from mail.baikal.int (mail.baikal.int [192.168.51.25])
        by post.baikalelectronics.com (Proxmox) with ESMTP id 8E273E0E1D;
        Mon,  7 Nov 2022 23:50:18 +0300 (MSK)
Received: from localhost (192.168.168.10) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 7 Nov 2022 23:50:18 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Rob Herring <robh+dt@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Robin Murphy <robin.murphy@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        caihuoqing <caihuoqing@baidu.com>, Vinod Koul <vkoul@kernel.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v6 12/20] dt-bindings: PCI: dwc: Add dma-coherent property
Date:   Mon, 7 Nov 2022 23:49:26 +0300
Message-ID: <20221107204934.32655-13-Sergey.Semin@baikalelectronics.ru>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221107204934.32655-1-Sergey.Semin@baikalelectronics.ru>
References: <20221107204934.32655-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [192.168.168.10]
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

DW PCIe EP/RP AXI- and TRGT1-master interfaces are responsible for the
application memory access. They are used by the RP/EP PCIe buses (MWr/MWr
TLPs emitted by the peripheral PCIe devices) and the eDMA block. Since all
of them mainly involve the system memory and basically mean DMA we can
expect the corresponding platforms can be designed in a way to make sure
the transactions are cache-coherent. As such the DW PCIe DT-nodes can have
the 'dma-coherent' property specified. Let's permit it in the DT-bindings
then.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Reviewed-by: Rob Herring <robh@kernel.org>

---

Changelog v3:
- This is a new patch created on v3 lap of the series.
---
 Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml b/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml
index 4d9efcea3859..d87e13496834 100644
--- a/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml
+++ b/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml
@@ -259,6 +259,8 @@ properties:
       configuration space registers, Port Logic registers, DMA and iATU
       registers. This feature has been available since DWC PCIe v4.80a.
 
+  dma-coherent: true
+
 additionalProperties: true
 
 ...
-- 
2.38.0


