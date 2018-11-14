Return-Path: <SRS0=Q3Ib=NZ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A384EC43441
	for <linux-pci@archiver.kernel.org>; Wed, 14 Nov 2018 14:56:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49E4721582
	for <linux-pci@archiver.kernel.org>; Wed, 14 Nov 2018 14:56:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="1UZN++lu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49E4721582
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727885AbeKOBAJ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 14 Nov 2018 20:00:09 -0500
Received: from mail-eopbgr690089.outbound.protection.outlook.com ([40.107.69.89]:15725
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725828AbeKOBAI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 14 Nov 2018 20:00:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ow830ZFFUNbjDNJNQ0cYY4oALd5mYA2t5DhL+9KV5Tg=;
 b=1UZN++luO73qLK43aE//RUpHW33AR3a89W7tNhBMzMJJzJjn0FPDrYfA2ZHgklhJFhd9ptVGXpHYgyK8AiDLfUQdyFiPZqgZevwNRCYG1OvNZuBhtq8ojCgPJaiYU3xwsRVz5HekTEL4cXEAIlifQ9lEANwgHblrNYwAnGByDf0=
Received: from CY4PR02CA0007.namprd02.prod.outlook.com (2603:10b6:903:18::17)
 by SN4PR0201MB3518.namprd02.prod.outlook.com (2603:10b6:803:44::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1294.30; Wed, 14 Nov
 2018 14:54:40 +0000
Received: from SN1NAM02FT037.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::207) by CY4PR02CA0007.outlook.office365.com
 (2603:10b6:903:18::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1339.21 via Frontend
 Transport; Wed, 14 Nov 2018 14:54:40 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 SN1NAM02FT037.mail.protection.outlook.com (10.152.72.89) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1294.14
 via Frontend Transport; Wed, 14 Nov 2018 14:54:39 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:43848 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <bharat.kumar.gogada@xilinx.com>)
        id 1gMwYx-0001gY-En; Wed, 14 Nov 2018 06:54:39 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <bharat.kumar.gogada@xilinx.com>)
        id 1gMwYs-0007Y3-A9; Wed, 14 Nov 2018 06:54:34 -0800
Received: from xsj-pvapsmtp01 (mailman.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id wAEEsVj4014239;
        Wed, 14 Nov 2018 06:54:32 -0800
Received: from [172.23.37.224] (helo=xhdbharatku40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <bharat.kumar.gogada@xilinx.com>)
        id 1gMwYp-0007XE-EF; Wed, 14 Nov 2018 06:54:31 -0800
From:   Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
To:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <bhelgaas@google.com>, <rgummal@xilinx.com>,
        Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
Subject: [PATCH] PCI: Enable SERR# forwarding for Type-1 PCI devices
Date:   Wed, 14 Nov 2018 20:17:01 +0530
Message-ID: <1542206821-24503-1-git-send-email-bharat.kumar.gogada@xilinx.com>
X-Mailer: git-send-email 2.7.4
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(979002)(136003)(39860400002)(396003)(346002)(376002)(2980300002)(438002)(199004)(189003)(186003)(77096007)(2906002)(63266004)(2616005)(476003)(126002)(9786002)(36756003)(5660300001)(1857600001)(336012)(106466001)(106002)(47776003)(426003)(8936002)(6666004)(4326008)(356004)(50226002)(8676002)(36386004)(16586007)(48376002)(478600001)(107886003)(26005)(54906003)(305945005)(316002)(486006)(110136005)(7696005)(81156014)(81166006)(50466002)(51416003)(107986001)(5001870100001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN4PR0201MB3518;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT037;1:B3aJ9yO1+rLQjistZtWEs9QTiow+eYjZE7ARL8llmB1bXLoGO708PCDW+4ARIBB9wuCBUoZxL/UzQRCCbXIl70yGcZBx62s4niwKmv/dX4VKYO0yR6gd8tyyzR6orHFE
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 392fe82e-bdcc-49b5-ebb4-08d64a411aa5
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4608076)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060);SRVR:SN4PR0201MB3518;
X-Microsoft-Exchange-Diagnostics: 1;SN4PR0201MB3518;3:HoSC4kWwI4n2tTbxoDHlQP0mxldPNdBP3tLvo9yitoOMZ//Xpad7g77fUho/j8wW8lSEiALTFRYMdG3/MW9f5iOCUJr5MHbCsx04m/D7eEZpuXzmj3dLV3QZOIMB83C8WqWvilN8fMb6yZUe64Orqa4r57kvtHuSRjBPIpfwXDnAovIGsM85fDpYIiKXlFgj09avSkNi/O7Isnw+FYZ6rK4ns43UcHHcjELZ+BsxfZ8RjIMAiINMOYh135aO5TFYSyTnHqWeR+Np1aWUZe/Iqy8aL8JB8lQsmhmdH19Tmqrc9QVAiOF3lNJc/ejyuEqHuGfInYIfOTGzKSSyNOYelq3XMDKsNvHyXL537eN19fQ=;25:OktEI5p33WAyE+rRh0MYK88EJg5NQjfuTLlQSIIBjnLZPlinkHB76lzy2xpt6vXivPOCocJV89yrr3NxwtuQew+vC6S3hLhANmNuAmiS3qc0mBVX3RJFNuQ/Udv0m43PpZI6e7eY2bsBvo/WYmEmhH7EpHcShAAqEt8lKj7Rx4OzhH1pwquhDwzxx3WQea339v05O+Jz5eG1ffvspUuH7jxZXQqWVNYk+hmiqQcvizbNqWuGXGGtrHiLGVEuQjfaOJQehHFAUD50RKfCvcZQ2bB2pg25EfGt4mF+psHFSZv1PJJrBh1H0NbQMjhNL0oG8iV9fVPqOs17DYSen7XhgA==
X-MS-TrafficTypeDiagnostic: SN4PR0201MB3518:
X-Microsoft-Exchange-Diagnostics: 1;SN4PR0201MB3518;31:HYeb8bkNlRBOHzYriCZaZS96Vh8Hmbh817Q/YP1CMsKv/7VLH37cVUbFJzKX6tvpPDhyNj96B5tIdUHXPlNRwbLb22LS21pro8bBS51UIAT7kT1F5irxfQzsNGP0aFTdAOsDduwMvp1SIp5JBnwC9JwamxhvQe6JTg1dBffKnq/eZrg5/Q7xzmD/GNhOojDcALizMzbCzOG/O7H9zFe+0xCETJ7NHOY4okVuXgmssg8=;20:gfICMY8jNXL4tXkjjwv6P+fx7S6zaVT3m0WudAyT8bvZY1b3HR1ptv8apZ0PnTDSpX+K7o9iq2v2Z91cU99LyCVtRUeB+0JMVyxPQxrhkZOIL4PYjbZ0V09bLcd4b93uz+zRgrZVK26iNFYRqSpM6wHuNMokY+iqKOGh4X5OHJN6/2dr9aT1YLcmDuCN6n9eJJqSOFOP/+B3Ddqy3qcox/1ClcMfgUjlOVZVqQzd5ZRjn08pO/zmkoN04OkPvqtvqU78P6pBZfEWZXSY/UxM7XvsoljtAsVtNkzxiF9O6olvfEkToohTXIEcyD8/DktY+khDml7HZvV+nfsySQ32BqgvKn4jUhHGt0TL+ZFwKbBpNlS976Z/qc/1T/BKIDLOplXslfGveE3e1ImRZN4+yC4UKqMfN2ts40rxmt+MOANYtmsyLmn86t8DwSlRNLIZaQjS4dxKdaJy9OvBiF6g4FnK+JMWeJKJsDPisPxa48rn6jrCsfwM018RNjzKQPdE
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <SN4PR0201MB3518B39A1D615D701EC4ADD9A5C30@SN4PR0201MB3518.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231382)(944501410)(52105112)(3002001)(10201501046)(93006095)(93004095)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:SN4PR0201MB3518;BCL:0;PCL:0;RULEID:;SRVR:SN4PR0201MB3518;
X-Microsoft-Exchange-Diagnostics: 1;SN4PR0201MB3518;4:kbc2A6D+ukMo45aPHRIBf5ERLXaC1StLrlrGu2urXMI2uBj6oz7oDoShoRU4j70S2sSeHoP8V3PJIUbXOeTFKu+ItMK2I9sfIVfuJZRouz4lYcN6kZKc3IxiPJFyzo/9AvR+zf4FI42LzhUhCxn6Ml3QihLc34Tz0jnjffHFtH6Iv2Yai3SlLsytJIwHHa2H/fLoWi9rufCYXOZiE+/v81ejOrnVZm0hQ0acon7Y3urCUuO8DS0lQCL5xaS7lzBEjHYd8I7YU1+GISsoVD6jHOrw92cUe3TBw+0ZT1zTGyx6SBxctPv2ut2do6b+yMEK
X-Forefront-PRVS: 085634EFF4
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN4PR0201MB3518;23:sq/HaCpQB5yM7lTaUFf6BpIISneCTpJD0uaJG/O?=
 =?us-ascii?Q?4E0HH6k+Wcdj54mPDMb0OJ+cHfwnphcQWy6sL31DT3+0oeKD9AjXcJcZaUC1?=
 =?us-ascii?Q?+k46GbpS/4TKH791nAXEdPF2vgomv1UmmLM94Ko8IMkRlVWirFqCry0SupRv?=
 =?us-ascii?Q?/g5OG+Rd9xt7Ywt0qRudKpDSwtUrPJFnLh/WVEjivIc+oa8SOQ9lJXVo3bwF?=
 =?us-ascii?Q?J4y2Wb8BEq3QGi4UEFXsE5OKqZnpa4FKihj7wHRj+mDyWRgHwDuu3Ug0jMtk?=
 =?us-ascii?Q?G3TzIhKE87cNjtoWLrkRsuQ2XCtAGIDDf2DTBhW/jbwauyG8zkdBuHlF/EOG?=
 =?us-ascii?Q?FU1+YiETG0wE1IQQdd2zRkL1kIJO8Ftl9Tanf6Ng4j+uSHBOm6v6CbS5i8yU?=
 =?us-ascii?Q?9n+ZVH2M8ym0qoRUw7Qi5NCGjPwCArE249i+W1PFE8Cyss1WtWqqS4RMByfY?=
 =?us-ascii?Q?YiSBWbqBEcSgjZ9mX8NIkqfKk6DXq52OF3pzW0kLHhdo6bskXV++A99TSv5P?=
 =?us-ascii?Q?KlC+S7fAyuWbS4LkP1KCI7yEIQ4WYOyjIm+oS/xgOuh7q9CCCq7uogfzxlXD?=
 =?us-ascii?Q?Sasd3huHcds5KCu75D28e2+FJK5U6S4j+0/qOWwd5q35EPvdhqMzEdz3xiJf?=
 =?us-ascii?Q?lIcCZ0bnfhyFPLSHrbrXFvFlv1vCdv0NcXMubZviDewbiRCa0CeMKGvXJvHh?=
 =?us-ascii?Q?GSLpl6GqXGZBod4gZaUKqkffCaVE5KTJS7uk+RkrjcmhRr0lK4+CuwZFrv9C?=
 =?us-ascii?Q?piWP1jJZ5OlBxlNfBcdZdmWOOvRr5bzZ5Iz+ZriFUJqxsGuLStd9nKYBGw9T?=
 =?us-ascii?Q?kTcaQadp6TyhSOw+nRTPEor5ltqX+mbNgj72jgbKCfvSwp/1lkZWaO17n/dS?=
 =?us-ascii?Q?ep+xPJkafrgP+gusnU/js7l/ntgqK/kmOawmZgze8ou+e0Ehe5+l3ImxSGts?=
 =?us-ascii?Q?Bnz7vLz+tTDE1g2M/yBbKQ8pqIsy/SCeZm3ZVK1Hxi/FnKzSZSQ7uqDPZbK0?=
 =?us-ascii?Q?oFQsnFZRgTH9FnCnBVwUCClYp/R/uk+tLv+oP9XC1Srl3persc3VgsoPjm0f?=
 =?us-ascii?Q?2vUb8sOQB8BQV9iUtZbrUh4gObFZK1qkyI67ao9D6rNZ/rAgQ3iQxm0g45ln?=
 =?us-ascii?Q?ucjJ6SaQ93c5hFRKMHnWFSIhfD5TAV4YofOZBf4jiGM/pw1BU4z1wvGKba5/?=
 =?us-ascii?Q?GLHZU395bTgMkvCjZKGAz4tsatxo4+Bk3xwtk?=
X-Microsoft-Antispam-Message-Info: pxSiEXxf7EyBPvjjmjxkUvuIU+0diCsuwpuzI7QvU2167GoJ6CjKDU0wBwK7FdsXbCkjlLqljJUik/yoyZvrq1e2D2M5nVKuQJk04kYyfH2ZgLZOm3sxewr6XfF7iSNVJY8Fv2JhVDEKF2fNOH2Wqoxcnu7BaPtFdIEQPev6swIHlIVblwzlphGPTe4FBtQnjbQKagCvyABunuFs/FQcxcMmOo8GPJ8mESoJZgRWwz6Mzlg9uy6GVxjwe27e0hxARxvIolFNOuTssVFt5hgK+iLdcnApy3B5iObnuwsGCPY9j8BpilheTODfyI5YliSN7B91BsamTQtWEGscX/FpCKmiSCi9ZLQFmmeWHaD2PEk=
X-Microsoft-Exchange-Diagnostics: 1;SN4PR0201MB3518;6:7n+ZjdA24Cfypd6Y7QU+mk9kfUDrJNtczCWS2shcKJKtEITSqRdUPu436xByT39LjRTqobHYFn1yXsZtJG0r/5PhM6k2y+8hCY2ranzdHYac2mvhTucDj6NZKLHO5L+vARema6gcnVGM/PcX222cMkKJELzOZKMmcWqKtjQBr7UKaiIqTij3OrSBRDVCG+xIKBb3jtB5Te0mB+xD/uWZtnMwYFXu64/Fmoe2cnz2kHaHHhbooUiJCcGJpj3RYbUT6FuNjVwXXuGR/XTmp6GVUWgL/VZFGFb+q1U6znsvaTdoqHJYqZAqXHGE0HMhthwpW3xeAwdvzFuZ60ng0FK2YMPNYSbXtzx5sMR3Bjh7TopISN4ZPBdVNt2VVUKmvKX5CAu1x1etvBa4gGiBYeZkExbr2uOqgY1dKc0PWSvoLKCR4b9RuTj4BikDYPHyLT+kZnDHWMi91B+q4oAPWLP9XQ==;5:OZBlSreZdCpLuXErm5Fw/AnzKmDsfzNxTOvfnjrvK5QoqNffv0aC/n2j6xod2JhJUKaFIE3mHzT5BgmFGbwU8yauJ0IVw0AeccOcdW4qZJ9bVqMo6s76vTTwmfCjBVw8u0D38e/2XN6V3WFvdY8lz9bPcUqPGY025xQ0uv9cHU8=;7:8fZRU1TzWJPnhVaaeTbqmGe7NaWQtyGqbYguXgtCsmsOMJMha9B7pJfmSu6QJmmhAxEKh+JHarZzFGzTWdHaodfQYV+khfrQZbA303FkbzuhdtKzF3WIyOA/5pNMYHruCgOrDSfco7eRD/Cz50A/Aw==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2018 14:54:39.8352
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 392fe82e-bdcc-49b5-ebb4-08d64a411aa5
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0201MB3518
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

As per Figure 6-3 in PCIe r4.0, sec 6.2.6, ERR_ messages
will be forwarded from the secondary interface to the primary interface,
if the SERR# Enable bit in the Bridge Control register is set.
Currently PCI_BRIDGE_CTL_SERR is being enabled only in
ACPI flow.
This patch enables PCI_BRIDGE_CTL_SERR for Type-1 PCI device.

Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
---
 drivers/pci/probe.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index b1c05b5..ed71e8e 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1841,8 +1841,6 @@ static void program_hpp_type0(struct pci_dev *dev, struct hpp_type0 *hpp)
 		pci_write_config_byte(dev, PCI_SEC_LATENCY_TIMER,
 				      hpp->latency_timer);
 		pci_read_config_word(dev, PCI_BRIDGE_CONTROL, &pci_bctl);
-		if (hpp->enable_serr)
-			pci_bctl |= PCI_BRIDGE_CTL_SERR;
 		if (hpp->enable_perr)
 			pci_bctl |= PCI_BRIDGE_CTL_PARITY;
 		pci_write_config_word(dev, PCI_BRIDGE_CONTROL, pci_bctl);
@@ -2114,6 +2112,23 @@ static void pci_configure_eetlp_prefix(struct pci_dev *dev)
 #endif
 }
 
+static void pci_configure_serr(struct pci_dev *dev)
+{
+	if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE) {
+		u16 control;
+
+		/*
+		 * A Type-1 PCI bridge will not forward ERR_ messages coming
+		 * from an endpoint if SERR# forwarding is not enabled.
+		 */
+		pci_read_config_word(dev, PCI_BRIDGE_CONTROL, &control);
+		if (!(control & PCI_BRIDGE_CTL_SERR)) {
+			control |= PCI_BRIDGE_CTL_SERR;
+			pci_write_config_word(dev, PCI_BRIDGE_CONTROL, control);
+		}
+	}
+}
+
 static void pci_configure_device(struct pci_dev *dev)
 {
 	struct hotplug_params hpp;
@@ -2124,6 +2139,7 @@ static void pci_configure_device(struct pci_dev *dev)
 	pci_configure_relaxed_ordering(dev);
 	pci_configure_ltr(dev);
 	pci_configure_eetlp_prefix(dev);
+	pci_configure_serr(dev);
 
 	memset(&hpp, 0, sizeof(hpp));
 	ret = pci_get_hp_params(dev, &hpp);
-- 
2.7.4

