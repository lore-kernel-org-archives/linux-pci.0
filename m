Return-Path: <SRS0=lwCQ=2V=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3730CC2D0DD
	for <linux-pci@archiver.kernel.org>; Tue, 31 Dec 2019 11:34:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B5B420409
	for <linux-pci@archiver.kernel.org>; Tue, 31 Dec 2019 11:34:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="eYa84y0l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727170AbfLaLeZ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 31 Dec 2019 06:34:25 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:33442 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727145AbfLaLeY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 31 Dec 2019 06:34:24 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id xBVBY0cx121219;
        Tue, 31 Dec 2019 05:34:01 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1577792041;
        bh=jqsa++lCvjyELh9SjLjw9ykSFWnOzndvoFRmjfRfvbM=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=eYa84y0lK9EfPbFapBY8/3Zn/A3ew9pjim0tgw4m7cTU0eIFjgSdm8Ze1JeZ/oAbA
         JOpZtRaXas6AYgBNik3O4EQ5920P7vBptrM6GB2IuAZnThb+e6oPvhuZhjk93Ckt9u
         LcSsPpfar0v/aGEpD3RwU7/5EgKBM25/h88hpn38=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xBVBY0C4090355
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 31 Dec 2019 05:34:00 -0600
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 31
 Dec 2019 05:34:00 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 31 Dec 2019 05:34:00 -0600
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id xBVBXX35024759;
        Tue, 31 Dec 2019 05:33:55 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Tom Joseph <tjoseph@cadence.com>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-doc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-rockchip@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 4/7] PCI: endpoint: Add support to link a physical function to a virtual function
Date:   Tue, 31 Dec 2019 17:05:31 +0530
Message-ID: <20191231113534.30405-5-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191231113534.30405-1-kishon@ti.com>
References: <20191231113534.30405-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

While the physical function has to be linked to endpoint controller, the
virtual function has to be linked to a physical function. Add support to
link a physical function to a virtual function in pci-ep-cfs.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/endpoint/pci-ep-cfs.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/pci/endpoint/pci-ep-cfs.c b/drivers/pci/endpoint/pci-ep-cfs.c
index e7e8367eead1..c18ef626ada5 100644
--- a/drivers/pci/endpoint/pci-ep-cfs.c
+++ b/drivers/pci/endpoint/pci-ep-cfs.c
@@ -350,6 +350,28 @@ static struct configfs_attribute *pci_epf_attrs[] = {
 	NULL,
 };
 
+static int pci_epf_vepf_link(struct config_item *epf_pf_item,
+			     struct config_item *epf_vf_item)
+{
+	struct pci_epf_group *epf_vf_group = to_pci_epf_group(epf_vf_item);
+	struct pci_epf_group *epf_pf_group = to_pci_epf_group(epf_pf_item);
+	struct pci_epf *epf_pf = epf_pf_group->epf;
+	struct pci_epf *epf_vf = epf_vf_group->epf;
+
+	return pci_epf_add_vepf(epf_pf, epf_vf);
+}
+
+static void pci_epf_vepf_unlink(struct config_item *epf_pf_item,
+				struct config_item *epf_vf_item)
+{
+	struct pci_epf_group *epf_vf_group = to_pci_epf_group(epf_vf_item);
+	struct pci_epf_group *epf_pf_group = to_pci_epf_group(epf_pf_item);
+	struct pci_epf *epf_pf = epf_pf_group->epf;
+	struct pci_epf *epf_vf = epf_vf_group->epf;
+
+	pci_epf_remove_vepf(epf_pf, epf_vf);
+}
+
 static void pci_epf_release(struct config_item *item)
 {
 	struct pci_epf_group *epf_group = to_pci_epf_group(item);
@@ -362,6 +384,8 @@ static void pci_epf_release(struct config_item *item)
 }
 
 static struct configfs_item_operations pci_epf_ops = {
+	.allow_link		= pci_epf_vepf_link,
+	.drop_link		= pci_epf_vepf_unlink,
 	.release		= pci_epf_release,
 };
 
-- 
2.17.1

