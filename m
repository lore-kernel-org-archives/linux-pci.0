Return-Path: <SRS0=Xta/=UD=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72BA1C282CE
	for <linux-pci@archiver.kernel.org>; Tue,  4 Jun 2019 13:19:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DE832199C
	for <linux-pci@archiver.kernel.org>; Tue,  4 Jun 2019 13:19:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="lqjILHti"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727521AbfFDNTK (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 4 Jun 2019 09:19:10 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:55114 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727876AbfFDNTG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 4 Jun 2019 09:19:06 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x54DIrkc028239;
        Tue, 4 Jun 2019 08:18:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1559654333;
        bh=3RfvV7ZEVCE0D/QH1puvv34eRoVr5xAL88W1PeCX6A4=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=lqjILHti8GW+J9yPp0G2kM2m0NZYyrO/BSfrIqPN8c7pyHo1d+TOvideKNaLfh4WW
         QE1pti+R/YsfDiRspBX5/hRgrw5rwaxjTshIUyRxDvBxwCaDvYEgIY1SY8BH5SaYEB
         gX5DqC/pDEPB++4O+vUUISSafhwcpPPycN31ytEA=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x54DIraS044727
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 4 Jun 2019 08:18:53 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 4 Jun
 2019 08:18:52 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 4 Jun 2019 08:18:52 -0500
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x54DGdGd098972;
        Tue, 4 Jun 2019 08:18:48 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Tom Joseph <tjoseph@cadence.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Jingoo Han <jingoohan1@gmail.com>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-omap@vger.kernel.org>, <linux-rockchip@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: [RFC PATCH 23/30] of/platform: Export of_platform_device_create_pdata()
Date:   Tue, 4 Jun 2019 18:45:09 +0530
Message-ID: <20190604131516.13596-24-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190604131516.13596-1-kishon@ti.com>
References: <20190604131516.13596-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Export of_platform_device_create_pdata() to be used by drivers to
create child devices with the given platform data. This can be used
by platform specific driver to send platform data core driver. For e.g.,
this will be used by TI's J721E SoC specific PCIe driver to send
->start_link() ops and ->is_link_up() ops to Cadence core PCIe driver.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/of/platform.c       | 9 ++++-----
 include/linux/of_platform.h | 3 +++
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index 04ad312fd85b..94e0f733461a 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -169,11 +169,9 @@ EXPORT_SYMBOL(of_device_alloc);
  * Returns pointer to created platform device, or NULL if a device was not
  * registered.  Unavailable devices will not get registered.
  */
-static struct platform_device *of_platform_device_create_pdata(
-					struct device_node *np,
-					const char *bus_id,
-					void *platform_data,
-					struct device *parent)
+struct platform_device *
+of_platform_device_create_pdata(struct device_node *np, const char *bus_id,
+				void *platform_data, struct device *parent)
 {
 	struct platform_device *dev;
 
@@ -203,6 +201,7 @@ static struct platform_device *of_platform_device_create_pdata(
 	of_node_clear_flag(np, OF_POPULATED);
 	return NULL;
 }
+EXPORT_SYMBOL(of_platform_device_create_pdata);
 
 /**
  * of_platform_device_create - Alloc, initialize and register an of_device
diff --git a/include/linux/of_platform.h b/include/linux/of_platform.h
index 84a966623e78..0f1f58775086 100644
--- a/include/linux/of_platform.h
+++ b/include/linux/of_platform.h
@@ -70,6 +70,9 @@ extern int of_platform_device_destroy(struct device *dev, void *data);
 extern int of_platform_bus_probe(struct device_node *root,
 				 const struct of_device_id *matches,
 				 struct device *parent);
+extern struct platform_device *
+of_platform_device_create_pdata(struct device_node *np, const char *bus_id,
+				void *platform_data, struct device *parent);
 #ifdef CONFIG_OF_ADDRESS
 extern int of_platform_populate(struct device_node *root,
 				const struct of_device_id *matches,
-- 
2.17.1

