Return-Path: <SRS0=PTHP=RO=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 865B6C43381
	for <linux-pci@archiver.kernel.org>; Mon, 11 Mar 2019 11:46:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F30120657
	for <linux-pci@archiver.kernel.org>; Mon, 11 Mar 2019 11:46:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="3cdSmXel"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726989AbfCKLqZ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 11 Mar 2019 07:46:25 -0400
Received: from mail-eopbgr810079.outbound.protection.outlook.com ([40.107.81.79]:34209
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726605AbfCKLqZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 11 Mar 2019 07:46:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pfGJRA38vGVzyPGyQbDdce86uvqc2W+o9OrpHXzYC60=;
 b=3cdSmXelqjKMY/my0ThR5kRkMquujGFnRNROVH27NZKdI1Zqp3YTSsn428X8hcqBQeXYKSAjj1WC39BbqGOCXOvDRtG8G4KJzH9FELaaNHMtd/AgQbRioLhnWrnzNTyuRzlSBOsGpwIaIGI4pzZdvazuyuRwFkZHmlKrj8SeOSs=
Received: from BN6PR02CA0025.namprd02.prod.outlook.com (2603:10b6:404:5f::11)
 by DM5PR02MB2380.namprd02.prod.outlook.com (2603:10b6:3:51::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1686.18; Mon, 11 Mar
 2019 11:46:22 +0000
Received: from BL2NAM02FT023.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::200) by BN6PR02CA0025.outlook.office365.com
 (2603:10b6:404:5f::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1686.16 via Frontend
 Transport; Mon, 11 Mar 2019 11:46:22 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT023.mail.protection.outlook.com (10.152.77.72) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1686.19
 via Frontend Transport; Mon, 11 Mar 2019 11:46:21 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <bharat.kumar.gogada@xilinx.com>)
        id 1h3JNs-0002Ng-VV; Mon, 11 Mar 2019 04:46:20 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <bharat.kumar.gogada@xilinx.com>)
        id 1h3JNn-0000St-SW; Mon, 11 Mar 2019 04:46:15 -0700
Received: from xsj-pvapsmtp01 (smtp3.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x2BBk6AZ009849;
        Mon, 11 Mar 2019 04:46:07 -0700
Received: from [172.23.37.224] (helo=xhdbharatku40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <bharat.kumar.gogada@xilinx.com>)
        id 1h3JNe-0000R1-Ex; Mon, 11 Mar 2019 04:46:06 -0700
From:   Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
To:     <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>
CC:     <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
Subject: [PATCH v2] PCI: xilinx-nwl: Fix Multi MSI data programming
Date:   Mon, 11 Mar 2019 17:15:59 +0530
Message-ID: <1552304759-5394-1-git-send-email-bharat.kumar.gogada@xilinx.com>
X-Mailer: git-send-email 2.7.4
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(396003)(346002)(376002)(136003)(2980300002)(199004)(189003)(126002)(51416003)(50226002)(7696005)(107886003)(486006)(63266004)(476003)(8936002)(36756003)(8676002)(36386004)(2616005)(305945005)(81156014)(4326008)(9786002)(81166006)(47776003)(336012)(478600001)(106002)(6666004)(316002)(356004)(16586007)(106466001)(5660300002)(48376002)(186003)(26005)(110136005)(50466002)(54906003)(14444005)(426003)(2906002)(77096007);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR02MB2380;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 641e0917-4343-4909-5052-08d6a6172eb0
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4608103)(4709054)(2017052603328)(7153060);SRVR:DM5PR02MB2380;
X-MS-TrafficTypeDiagnostic: DM5PR02MB2380:
X-LD-Processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Exchange-Diagnostics: 1;DM5PR02MB2380;20:Qhs+Ju9vpb4d5tSji/04w4RHfoPNbk4HuopWMGFMYwQq47+dV4NG4yq2igahgwqaaIAnkqC2xXfrKa5afV2ZgYcEztt8UUBjTDfGhKJfvgHwqV63FKGRcdf7k+nUqeccM3WOGllJixyee8SglpMqtp/Nuwr8cyC6/2d8PwQgY/jxYnLdL2S9TkQ5gYokivhDihHjdUXiqCICxVjOm/gQ5ViE9foYTZS6477TGZrBxc4Zak/CQLJDpWTCviuWMc9biwuFfdRNJtcgkaEBqjtqewxwQ0dovHDYeuZ6CW+9ybZxyi+Bk2hnmy0ZvQwVKgsG8Ec+wCE+a4EH6KZdDHx1ZfE3aKlaKrPnEZMysrcVfihDFjhsQDL/KiuXYU56ywRMuK7VKJ/lJMrGN8j0+YNArt0Au+KuYKRZihTFuguYYRbobTJfbII+E8LExjWzJqd4GtDZEiqy/mFclxfH4aHOgd5nJhkNI4bHXEkN0Ff6Cmp4yK9w4Bza4mFMn2kUfEqT
X-Microsoft-Antispam-PRVS: <DM5PR02MB23809781A5988627F9972BCEA5480@DM5PR02MB2380.namprd02.prod.outlook.com>
X-Forefront-PRVS: 09730BD177
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR02MB2380;23:znSqCbyzYGYwwLU8UjkYYmbKnSoMzPs83rgcXe9lT?=
 =?us-ascii?Q?2ENWSHqmMGR51DwNbDOPR9KuzL2I2ebu3DxhHWPaDX3SdwNXlBh9HKd6p58s?=
 =?us-ascii?Q?zICVZn+fjBAmI8tp1nNx/UK3MZ58oEKmsHosd5p62E09F2tw9Nae12LJavYJ?=
 =?us-ascii?Q?VqUSuft7TzpW6lVt71irD9HtYproiUPTiMZxTY1n+iR+xHN7TwhAlWHbH54y?=
 =?us-ascii?Q?TqWcOzyqRbNDJ9/6TK5AWD8uvy9i2/JcCoLnOtpVw7f423xxdY7Yq0nFHnfa?=
 =?us-ascii?Q?kFkTxONd7u405bH8C1O7wgOLnE4YeVi/S4IKUQ85Fks01Kyhalsdg2PGqZuW?=
 =?us-ascii?Q?mAr9EXUMbymzjc7gSRPL3Yz6Bj6/8b/nphMGBeUtaWvZIqg2dCpl6GZ/ZO5r?=
 =?us-ascii?Q?ndqVKD9i7Q8KmOmNIhbdmWXFdmCx8f8Iom4KbNvUVw5OO7JBHXE36NW6yeCL?=
 =?us-ascii?Q?YhLxC7oZlOb6W0TZnGH4C7cE8LDLE2zEYsRS4MwMNQ+56ffyDsE9yRZMgebF?=
 =?us-ascii?Q?C04aS2dCBIxLXZh5llquBdHunbPwIAnvNa1olJVn6EJvLz5xV4vv1rRXUHra?=
 =?us-ascii?Q?wXwecYqc5EDuJut5kGn1y4LHm8IBMLrcBwUshQnFB0/7Tr2+RjBSCTWAHFAO?=
 =?us-ascii?Q?sE55B7JrTCIzNWCbxb23leozDOXUmJZvT4fcwdalJ6+iMqgTfjRnGcuhRst0?=
 =?us-ascii?Q?y0YqzAeuPG/fITwUsyqyxJJhg/ZPNarQxxJHzwCEMmK8lMKHXD5avIJLIlAL?=
 =?us-ascii?Q?UV/CZwVGpvhf356aPb/v2qoV/FNDWPOGCfa7fCsV1ZtTwt7Abg5aBMuGnZJI?=
 =?us-ascii?Q?vcJp3uXz6v0k/YaQ1zB1c/SeugE89Ny4ZPKtjxBXtFRP+GUWj5zjid5wgeKJ?=
 =?us-ascii?Q?JIOzrywGRQM2Gvk3XaEe4K+Hlyx3gc0XRBFODyfogTIo4GHZNSkJPkOdbSAd?=
 =?us-ascii?Q?yU+mxw5hz6TWZvp6sdlcxa+zLsXayvD3gFnmO9XIy0R2xU24aQQEoWt9NRM6?=
 =?us-ascii?Q?Qx4u5VVPMyR+cEyS1meLRnAcoxtlpZGE0HhnjLPzkdhdQ=3D=3D?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: /8svfYq+V3sVE1mRCUFbgrX32r0lOtXsJssmUc3wLjJTQj1+JQjx6pns6eOSlsU4Sp7zVubSogtKQtj1lrp3zWXysBWWoJpeygKiK0PSdm401Lc9UM6z3zjyAKPf0mpL1wJSYzNk6jt1N2tCbab6EH0MbBMhEfFC+VwyorrTr7TlfHooZ6L+dSapAOZlRatM2wHZAVef6HZokMZ0iNheSqpSoIzr+IQGUQIBxoSXaFSfp7R2lOLo4i2drh8OZUQsD8ovalFVgtNkwv727z++bbar1DNN559wZs/Fz5bOhbXUCgM2CCOiudPggFgo8Uvzw50aj+t/FtPpdUynsjEWTqJsUx2XPGr3Xyyb4WiI1D0FSJIYOZY2wnNq0exJmsixshlrqWtv6akKPcInwcvy82R6V4FcVeeeG8a+NZBCAp4=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2019 11:46:21.5513
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 641e0917-4343-4909-5052-08d6a6172eb0
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR02MB2380
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The current Multi MSI data programming fails if multiple end points
requesting MSI and multi MSI are connected with switch, i.e the current
multi MSI data being given is not considering the number of vectors
being requested in case of multi MSI.
Due to this if multiple end points are connected and requesting MSI
and multi MSI combination, the multi MSI data is ending up using
wrong MSI data, which might be used by different device.

Fix Multi MSI data programming with required alignment by
using number of vectors being requested.

Fixes: ab597d35ef11 ("PCI: xilinx-nwl: Add support for Xilinx NWL PCIe
Host Controller")
Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
---
V2:
 - Added more description of fix
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

