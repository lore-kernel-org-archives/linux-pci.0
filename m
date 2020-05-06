Return-Path: <SRS0=V6A1=6U=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59C09C28CBC
	for <linux-pci@archiver.kernel.org>; Wed,  6 May 2020 15:15:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29C8120A8B
	for <linux-pci@archiver.kernel.org>; Wed,  6 May 2020 15:15:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="HDwiHb9X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729435AbgEFPP0 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 6 May 2020 11:15:26 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:49322 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729244AbgEFPPS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 6 May 2020 11:15:18 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 046FExeE096943;
        Wed, 6 May 2020 10:14:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1588778099;
        bh=MKV79ofiysqnjU4+7T9T2gezrhTObALnfWPqqZdKvpo=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=HDwiHb9XbJG0exStePTLe8369CBn149z3g44GCxwxtVp/oFxh4U/THe1+af871SGA
         Ho/zuVOU9Eair34VAuZUHyaC+gPQyIoDyiT8N2ht55lzG9ntevnRmw/YDtAJi0UdYZ
         W65H3TRgCSV4f2ZKqfSQ5oKNxmfsfx8oSg3rtkR4=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 046FEx6f100075
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 6 May 2020 10:14:59 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 6 May
 2020 10:14:57 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 6 May 2020 10:14:57 -0500
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 046FEUgC119457;
        Wed, 6 May 2020 10:14:54 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>, Tom Joseph <tjoseph@cadence.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <kishon@ti.com>
Subject: [PATCH v4 06/14] PCI: cadence: Allow pci_host_bridge to have custom pci_ops
Date:   Wed, 6 May 2020 20:44:21 +0530
Message-ID: <20200506151429.12255-7-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200506151429.12255-1-kishon@ti.com>
References: <20200506151429.12255-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Certain platforms like TI's J721E allows only 32-bit configuration
space access. In such cases pci_generic_config_read and
pci_generic_config_write cannot be used. Add support in Cadence core
to let pci_host_bridge have custom pci_ops.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/controller/cadence/pcie-cadence-host.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/cadence/pcie-cadence-host.c b/drivers/pci/controller/cadence/pcie-cadence-host.c
index a60b9627cfbf..6c84520318a7 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-host.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-host.c
@@ -291,7 +291,8 @@ int cdns_pcie_host_setup(struct cdns_pcie_rc *rc)
 	list_splice_init(&resources, &bridge->windows);
 	bridge->dev.parent = dev;
 	bridge->busnr = pcie->bus;
-	bridge->ops = &cdns_pcie_host_ops;
+	if (!bridge->ops)
+		bridge->ops = &cdns_pcie_host_ops;
 	bridge->map_irq = of_irq_parse_and_map_pci;
 	bridge->swizzle_irq = pci_common_swizzle;
 
-- 
2.17.1

