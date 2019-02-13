Return-Path: <SRS0=kgfr=QU=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2D9AC282C2
	for <linux-pci@archiver.kernel.org>; Wed, 13 Feb 2019 14:26:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6171222B2
	for <linux-pci@archiver.kernel.org>; Wed, 13 Feb 2019 14:26:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="CRtWfBig"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388885AbfBMO0m (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 13 Feb 2019 09:26:42 -0500
Received: from mail-eopbgr690051.outbound.protection.outlook.com ([40.107.69.51]:16256
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731144AbfBMO0m (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 13 Feb 2019 09:26:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3NZT4xX8DocpGW7VTFVffzaL1hJvBCxlUcjGaAtBSyQ=;
 b=CRtWfBigAw4A80nPie5WxDs4Tpd7p8lFENokUlymlMz4IULJxzovzKY02P75Czyv0TvZZLQdgfhKIAOMx8AmadtnYP8MqepkQjC2WQuPW6JaNVpwT7WFhIiwq9afcGqDBxp3FrAujuf1fk+17Y/W3g3U/HJfFalijjQQmZqcULc=
Received: from BN6PR02CA0043.namprd02.prod.outlook.com (2603:10b6:404:5f::29)
 by BN6PR02MB2644.namprd02.prod.outlook.com (2603:10b6:404:54::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1601.24; Wed, 13 Feb
 2019 14:25:58 +0000
Received: from CY1NAM02FT055.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::200) by BN6PR02CA0043.outlook.office365.com
 (2603:10b6:404:5f::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1622.16 via Frontend
 Transport; Wed, 13 Feb 2019 14:25:58 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT055.mail.protection.outlook.com (10.152.74.80) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1580.10
 via Frontend Transport; Wed, 13 Feb 2019 14:25:57 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <bharat.kumar.gogada@xilinx.com>)
        id 1gtvU5-0006ad-ER; Wed, 13 Feb 2019 06:25:57 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <bharat.kumar.gogada@xilinx.com>)
        id 1gtvU0-0005jV-AP; Wed, 13 Feb 2019 06:25:52 -0800
Received: from xsj-pvapsmtp01 (smtp2.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x1DEPiUE029165;
        Wed, 13 Feb 2019 06:25:44 -0800
Received: from [172.23.37.224] (helo=xhdbharatku40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <bharat.kumar.gogada@xilinx.com>)
        id 1gtvTs-0005hw-07; Wed, 13 Feb 2019 06:25:44 -0800
From:   Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
To:     <bhelgaas@google.com>, <lorenzo.pieralisi@arm.com>
CC:     <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
Subject: [PATCH] PCI: xilinx-nwl: Fix Multi MSI data programming
Date:   Wed, 13 Feb 2019 19:55:39 +0530
Message-ID: <1550067939-9859-1-git-send-email-bharat.kumar.gogada@xilinx.com>
X-Mailer: git-send-email 2.7.4
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(39860400002)(396003)(376002)(136003)(2980300002)(199004)(189003)(6666004)(478600001)(356004)(36386004)(107886003)(63266004)(14444005)(106466001)(50226002)(36756003)(51416003)(7696005)(476003)(47776003)(81166006)(81156014)(426003)(26005)(2906002)(77096007)(186003)(8676002)(126002)(110136005)(486006)(2616005)(4326008)(316002)(50466002)(16586007)(48376002)(4744005)(305945005)(106002)(54906003)(9786002)(8936002)(336012)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR02MB2644;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT055;1:wgIse9XV477tgp2/+hjF+N18qgJ6GG7WF2GUc5qeOYJ5ad13pb0iYF0rlTiXyPcYO6ojR1OnWgx0EZ4vNHEhR8vQX+IgbGDbXM/ERnth98rJRmgEgqi0VmHQ6AccgN3HzLtCmRoXZxC8ECGGncjrDQ==
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b7f03ae3-dade-4d22-ff88-08d691bf2c0f
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4608076)(4709027)(2017052603328)(7153060);SRVR:BN6PR02MB2644;
X-MS-TrafficTypeDiagnostic: BN6PR02MB2644:
X-LD-Processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Exchange-Diagnostics: 1;BN6PR02MB2644;20:2WpWqhVG+3n3KTiGycZ2quod5iIlLt9M9qpO7kBsbnv+dMLHv/MA0sdPEbkbjXlswIOSsHGp2+rBKhBkE+zforaevju0wPKeZ7jOLcaPX6M7rY8n2Ch5tN73UAdMWcIb80w9rmkYr7bvOTkkjZZnIslIC1Oj+jpGDOnbl6rzuX8RgzJQ2aOyB6OA1YSk9etqJKsZt2jsF+YvwqTVBx9urjPqyn7gWxAwnzoxf+rdGeOvC8/w66/33xFKVXZh98/9CrDSTTMVsqYkmJfry0y/IwqSyGWBJGQDxlhJ95j4giTmOjFQ6Mjg3QEbG0aIn7P55fCZEqReoCoLmMHaZqklyu8FbO9eVwNOIvxr1wkBBbStJsW8pv8JBI6yeU4M4YXHVwwQr4RrD5zLKOuFnbPczLI7JS7zCcNZKpiG39RaAmafrSSkfsblrpE8DmjHWr8WT4lpK/M0KtyhVyh6w0my80DPY2aLTq3pTFGBrcx9KArbcdOdBbJhPNM7UjtgGKCW
X-Microsoft-Antispam-PRVS: <BN6PR02MB2644FFD8E0AD7F346A887510A5660@BN6PR02MB2644.namprd02.prod.outlook.com>
X-Forefront-PRVS: 094700CA91
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN6PR02MB2644;23:MtMO9DkXQ3PXfBIL2qFBb5Tdh6c3qA+fvCWAMdY8M?=
 =?us-ascii?Q?Vft9cL8Zlhfmc7sOV1cH+/vxINzq6T9zgbunMWXdnSLRVayWg3G9JeM1fVS5?=
 =?us-ascii?Q?GGKC/SHKmK9B9g4o794ekSoSMp/WSwwUUZkIZlQf8eY78A/Mug67aZheNl94?=
 =?us-ascii?Q?LKau6QOpEMbyB/ZoDZm3yiox7h03ZjgFPgUBKTi9VSYmBPuoZ+OAIRT0P4GF?=
 =?us-ascii?Q?Ta+JWwIy4qmRfyUKo2c0/jPJR1YKTtBKiSFsswdQVd9AMMhSAs6XIMJXd7kT?=
 =?us-ascii?Q?qJtRpzGGeK/Lmn8V0C3XfHnHurnsB/rCk98+q+8pPuqFe7t3jIBUImYxEwzL?=
 =?us-ascii?Q?4r5vSwAoVttwoHprQ8YxtMg5dN382JF7z9qPAjlsjK1frIEiVSCoxowYb6kr?=
 =?us-ascii?Q?UtbJLacdVhjnVIIy3xZl11nmPY+ro6ABlfs+b2DpqZo38r18asCGda1p3ShA?=
 =?us-ascii?Q?DlDMzwXtT/ztQL82JUDlPELOqhtm+RN3hX1g6nSYkyGb2BpjArSRwhpdxHyz?=
 =?us-ascii?Q?p5zM2zi3UvqAQFxrXbiKIWtjcf2rjwGNzkAfqDWwU989GWhHSmxoyOc0VPgi?=
 =?us-ascii?Q?ki50cl8BxetF5iPM178RIGiYr3FSNOAwBlDI3URFatQUIhRzutymc7mVyubM?=
 =?us-ascii?Q?d22MBIMLlnaUYb+t5sRmCnxReLwag/MUp5H+PVD4BVo11TeSuAO01DoCmdDI?=
 =?us-ascii?Q?WZr29jtLml2avZ9C1jqb6fKvH26JH5kSsLKNlQveXz3EtgbqkoYY01KGDKR1?=
 =?us-ascii?Q?Olm+Jy13c0Jp//Q/0iJOh7BSk5Iqmq99cE6ulQwOUxdf12mfjiKcJi6Czpy1?=
 =?us-ascii?Q?atvlOOem28InV5CsxYleWyAx4j0PCAlFTS93Jqn8HtDHqDu/llESxJ1jCE6p?=
 =?us-ascii?Q?ddojWxwSqrCBJBi+Np6vsmKUl9O6IFKPgsulWWta1nHoCF9Rn7PRh9YZ1Oaz?=
 =?us-ascii?Q?AVbMBnKlcdpIZxQwjpfasT56KmLH8XWPKO5wQEV5PLVUnjjw81/9DCY8AfKc?=
 =?us-ascii?Q?rdmg5L5EP50YImilSep/rRfnL2sQjpFIVlUislcj8LwLA=3D=3D?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: ztwc/x8fzHX84tYlRCagHGq2IlGw0aZUCkjmfvo2R4w0WabxHb7rPTUeJb1z4RR2wIUP88z4BQ3elVADG/kV7l5g2s9n+Bo1n09xT3FoQSiTaQ+ttekaZJivqyqiIWKAyTrauBv7YrTkn6jBnIswT76cwsZIiRnpLgku+8Lesctq1FkBiKmVK0EJedmhL+q/ljP9uhiGq4EX4MatmWvwOVDtjYVycWNMyHsjAhEnXMgzlVZWVLAf8Kkarg2B7NuLf1y/8dmyiphlsR+R/H9VYNbMbV19uiSmejpGRwGnd5p/7BSaVOpyfxNrpq3Bq1LccK+5mZS0SkGCwHThoTynmiVGWYUKh30sGD9Pw5DiViyZWQbSfz7mA7rXrO+1X0fQ699zlljQ86KwmgcxGECxEnDmNjoFtM+NoUKbl4Sdt2M=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2019 14:25:57.9607
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b7f03ae3-dade-4d22-ff88-08d691bf2c0f
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR02MB2644
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The current Multi MSI data programming fails if a
end point is connected with switch.

Fix Multi MSI data, by programming data with required alignment.

Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
---
 drivers/pci/controller/pcie-xilinx-nwl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-xilinx-nwl.c b/drivers/pci/controller/pcie-xilinx-nwl.c
index 81538d7..36669c5 100644
--- a/drivers/pci/controller/pcie-xilinx-nwl.c
+++ b/drivers/pci/controller/pcie-xilinx-nwl.c
@@ -484,7 +484,7 @@ static int nwl_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
 
 	mutex_lock(&msi->lock);
 	bit = bitmap_find_next_zero_area(msi->bitmap, INT_PCI_MSI_NR, 0,
-					 nr_irqs, 0);
+					 nr_irqs, nr_irqs - 1);
 	if (bit >= INT_PCI_MSI_NR) {
 		mutex_unlock(&msi->lock);
 		return -ENOSPC;
-- 
2.7.4

