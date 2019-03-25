Return-Path: <SRS0=Cb4Y=R4=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D044DC43381
	for <linux-pci@archiver.kernel.org>; Mon, 25 Mar 2019 09:44:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F4EC2147C
	for <linux-pci@archiver.kernel.org>; Mon, 25 Mar 2019 09:44:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="xC7zVjEm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730820AbfCYJo1 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 25 Mar 2019 05:44:27 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:33706 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730525AbfCYJo0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 25 Mar 2019 05:44:26 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x2P9i8ie011385;
        Mon, 25 Mar 2019 04:44:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1553507048;
        bh=2++9Tg54a9f6hIecMipMBo4Cbzj6epb7v0EYAzsW2ns=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=xC7zVjEmGIGSwxwMa7ujENOVn5bfh0qrEbrWEt2siiuK6wTJX6XidurqTtAICTdRY
         a74R8iq9BpF2jw/DaNvdq9ixtaelieErWLeFdF176j6RiD5/7nxOpf5OGytScYSQzk
         fDE+iYwwza7GalOYQm456v3fTTONfz3duvba49Ho=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x2P9i8uO055981
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 25 Mar 2019 04:44:08 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Mon, 25
 Mar 2019 04:44:08 -0500
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5 via Frontend Transport;
 Mon, 25 Mar 2019 04:44:08 -0500
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x2P9feaf028077;
        Mon, 25 Mar 2019 04:44:03 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Murali Karicheri <m-karicheri2@ti.com>
CC:     Kishon Vijay Abraham I <kishon@ti.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-arm-kernel@axis.com>, Minghuan Lian <minghuan.Lian@nxp.com>,
        Mingkai Hu <mingkai.hu@nxp.com>, Roy Zang <roy.zang@nxp.com>,
        Jesper Nilsson <jesper.nilsson@axis.com>
Subject: [PATCH v3 26/26] misc: pci_endpoint_test: Fix test_reg_bar to be updated in pci_endpoint_test
Date:   Mon, 25 Mar 2019 15:09:47 +0530
Message-ID: <20190325093947.32633-27-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190325093947.32633-1-kishon@ti.com>
References: <20190325093947.32633-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

commit 834b9051992580ac8fd3966d023b ("misc: pci_endpoint_test: Add support
for PCI_ENDPOINT_TEST regs to be mapped to any BAR") while adding
test_reg_bar in order to map PCI_ENDPOINT_TEST regs to be mapped to any
BAR failed to update test_reg_bar in pci_endpoint_test. This results in
test_reg_bar having invalid value when used outside probe. Fix it here.

Fixes: 834b9051992580ac8fd3966d023b ("misc: pci_endpoint_test: Add support
for PCI_ENDPOINT_TEST regs to be mapped to any BAR")

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/misc/pci_endpoint_test.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index e015e8fa9bd3..7b015f2a1c6f 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -670,6 +670,7 @@ static int pci_endpoint_test_probe(struct pci_dev *pdev,
 	data = (struct pci_endpoint_test_data *)ent->driver_data;
 	if (data) {
 		test_reg_bar = data->test_reg_bar;
+		test->test_reg_bar = test_reg_bar;
 		test->alignment = data->alignment;
 		irq_type = data->irq_type;
 	}
-- 
2.17.1

