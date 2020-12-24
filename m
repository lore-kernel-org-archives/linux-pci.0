Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C1E2C433E0
	for <linux-pci@archiver.kernel.org>; Thu, 24 Dec 2020 09:47:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1800F22D57
	for <linux-pci@archiver.kernel.org>; Thu, 24 Dec 2020 09:47:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727946AbgLXJrH (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 24 Dec 2020 04:47:07 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:38704 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726859AbgLXJrH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Dec 2020 04:47:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1608803226; x=1640339226;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=Y6cYRDZBHofXC1+fMpkWazCbSAWSF9dRS/TDToGnCxg=;
  b=wglWfam4eBknvnkJFbAVVP4DY9cS8Io6qOJ0MReHnJcpR060HlQSAqNO
   VBqZ2FYBhObZgJLEEUFa+HuHCQNUuCUQ172enjIp+KOtK8pBHbuJOC2bi
   PTcsR4rnfvB5crrJUZM9NfOyfIMXdoRg3FIs9ZvzxCQKLaNmsValsO63L
   XnftsCW6kU2AA8PZ7Av16QAtlHnGoZ/GMxSzPkTPPMwwY4nL2O6w5QbRE
   z+j1H7xWOoyYvEaog837RYSdPyfEU+c/+mw3J6OSrGIWQERmEcTkMoS6r
   bcOP7uwNtJgUqsUkP/1qGrTP+aexpQ0DLxPEOpFw5tXJJHcnixBNnkiOU
   g==;
IronPort-SDR: WJKhA24Dwm+BKX4DgzkyuBTfJnLQuZw44CnZDoKT7hHRHw5WiqwV0DQ5xTWCJLSBmmc3JpYydS
 dGEr9UI7Ii6cwRD3IlxPy0R8bg80suvOz+pTUWfl9V5rLCQQ4XiUDWMPLeo3ZnWSMj4OUFcwS3
 MNSz2za51ItZ6jkxbrl9rlR1szDTb1ABw9anOnCOyB/Ug9htaU2n7FXzQ7CcRlvP34MwUulSc3
 L5/BGSfFBXM7SznfM0clXUcMRYtuQ/D5MyM/ReYg5IHlzPE70Zvf1s4iZnDab/MwCsFU9qFy+v
 9eI=
X-IronPort-AV: E=Sophos;i="5.78,444,1599548400"; 
   d="scan'208";a="108837035"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 Dec 2020 02:45:16 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 24 Dec 2020 02:45:15 -0700
Received: from ryzen.microchip.com (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Thu, 24 Dec 2020 02:45:13 -0700
From:   <daire.mcnamara@microchip.com>
To:     <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <robh@kernel.org>, <linux-pci@vger.kernel.org>,
        <robh+dt@kernel.org>, <devicetree@vger.kernel.org>
CC:     <david.abdurachmanov@gmail.com>, <cyril.jean@microchip.com>,
        <ben.dooks@codethink.co.uk>,
        Daire McNamara <daire.mcnamara@microchip.com>
Subject: [PATCH v19 4/4] MAINTAINERS: Add Daire McNamara as maintainer for the Microchip PCIe driver
Date:   Thu, 24 Dec 2020 09:45:00 +0000
Message-ID: <20201224094500.19149-5-daire.mcnamara@microchip.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201224094500.19149-1-daire.mcnamara@microchip.com>
References: <20201224094500.19149-1-daire.mcnamara@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Daire McNamara <daire.mcnamara@microchip.com>

Signed-off-by: Daire McNamara <daire.mcnamara@microchip.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e73636b75f29..f2dafbf3393c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13628,6 +13628,13 @@ S:	Supported
 F:	Documentation/devicetree/bindings/pci/mediatek*
 F:	drivers/pci/controller/*mediatek*
 
+PCIE DRIVER FOR MICROCHIP
+M:	Daire McNamara <daire.mcnamara@microchip.com>
+L:	linux-pci@vger.kernel.org
+S:	Supported
+F:	Documentation/devicetree/bindings/pci/microchip*
+F:	drivers/pci/controller/*microchip*
+
 PCIE DRIVER FOR QUALCOMM MSM
 M:	Stanimir Varbanov <svarbanov@mm-sol.com>
 L:	linux-pci@vger.kernel.org
-- 
2.25.1

