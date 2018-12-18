Return-Path: <SRS0=EJXn=O3=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E97EC43387
	for <linux-pci@archiver.kernel.org>; Tue, 18 Dec 2018 08:24:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A92A214C6
	for <linux-pci@archiver.kernel.org>; Tue, 18 Dec 2018 08:24:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="zz74+Vu4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726522AbeLRIYt (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 18 Dec 2018 03:24:49 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:49314 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726316AbeLRIYt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 Dec 2018 03:24:49 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wBI8NGZo096842;
        Tue, 18 Dec 2018 08:23:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2018-07-02;
 bh=7+IfhTokIPopLuO9ziLBP7Bgq4DCNBy9E0xiZ6cKGrs=;
 b=zz74+Vu4DwHaznFrx/ZGHNcvY0smIjVOF1POG/itf/EMOm5EEn72gd/mb3Lhqq05mPzO
 xNdwIizQa7f+Q01rhfiHzX1yojlOOI55eYV/yXrZOS39CO7HYj1oRL0mjbv2O/dbfTcV
 OprV36fBZy7z8pMo04a4DpEwcxZNkNhsrNkGdZgQ3NDe+RPK7jo0Jy6EemmfKsyPtRMe
 3gaxnuZ8hc9MEHDBL9G0rMtOiDk2ogszdwK/5joTc38/DRdH7lgp4x2O9NgxXgwgwovc
 bwLLYVciIsogUAO4rrsK/q55j5W/TSLHJPK8dty+z8ioIlDXO9TmLMQvzTtFWxENzK+s Tg== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2130.oracle.com with ESMTP id 2pcs1thqgg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Dec 2018 08:23:32 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wBI8NVHa002022
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Dec 2018 08:23:31 GMT
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wBI8NU1K004024;
        Tue, 18 Dec 2018 08:23:30 GMT
Received: from kadam (/197.157.0.59)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 18 Dec 2018 00:23:29 -0800
Date:   Tue, 18 Dec 2018 11:23:29 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Richard Zhu <hongxing.zhu@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>
Cc:     Lucas Stach <l.stach@pengutronix.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] PCI: imx: Fix an IS_ERR() vs NULL bug
Message-ID: <20181218082329.GB440@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9110 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=907
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1812180075
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The device_link_add() function doesn't return error pointers, it returns
NULL if there is an error.

Fixes: 7a6991159bcd ("PCI: imx: Add multi-pd support")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index b54b4590ccf9..8e7956224a5f 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -326,9 +326,9 @@ static int imx6_pcie_attach_pd(struct device *dev)
 			DL_FLAG_STATELESS |
 			DL_FLAG_PM_RUNTIME |
 			DL_FLAG_RPM_ACTIVE);
-	if (IS_ERR(link)) {
-		dev_err(dev, "Failed to add device_link to pcie pd: %ld\n", PTR_ERR(link));
-		return PTR_ERR(link);
+	if (!link) {
+		dev_err(dev, "Failed to add device_link to pcie pd.\n");
+		return -EINVAL;
 	}
 
 	imx6_pcie->pd_pcie_phy = dev_pm_domain_attach_by_name(dev, "pcie_phy");
-- 
2.17.1

