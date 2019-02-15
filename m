Return-Path: <SRS0=N/Da=QW=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27C5BC43381
	for <linux-pci@archiver.kernel.org>; Fri, 15 Feb 2019 16:26:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00AB62192D
	for <linux-pci@archiver.kernel.org>; Fri, 15 Feb 2019 16:26:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbfBOQ0q (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 15 Feb 2019 11:26:46 -0500
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:28020 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726238AbfBOQ0q (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 15 Feb 2019 11:26:46 -0500
X-IronPort-AV: E=Sophos;i="5.58,373,1544511600"; 
   d="scan'208";a="27792825"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 15 Feb 2019 09:24:44 -0700
Received: from microchip.com (10.10.76.4) by chn-sv-exch02.mchp-main.com
 (10.10.76.38) with Microsoft SMTP Server id 14.3.352.0; Fri, 15 Feb 2019
 09:24:43 -0700
From:   Daire McNamara <daire.mcnamara@microchip.com>
To:     <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     Daire McNamara <daire.mcnamara@microchip.com>
Subject: [PATCH v3 1/3] PCI: Add vendor ID for Microsemi
Date:   Fri, 15 Feb 2019 16:24:22 +0000
Message-ID: <20190215162424.564-2-daire.mcnamara@microchip.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190215162424.564-1-daire.mcnamara@microchip.com>
References: <20190215162424.564-1-daire.mcnamara@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This patch adds a new PCI vendor ID for Microsemi.

Signed-off-by: Daire McNamara <daire.mcnamara@microchip.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 4b1a2a8fcc16..d13f6e40dbf4 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -238,6 +238,7 @@ micrel	Micrel Inc.
 microchip	Microchip Technology Inc.
 microcrystal	Micro Crystal AG
 micron	Micron Technology Inc.
+microsemi	Microsemi Corporation
 mikroe		MikroElektronika d.o.o.
 minix	MINIX Technology Ltd.
 miramems	MiraMEMS Sensing Technology Co., Ltd.
-- 
2.17.0

