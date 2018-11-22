Return-Path: <SRS0=lMXa=OB=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=DATE_IN_PAST_03_06,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39050C43441
	for <linux-pci@archiver.kernel.org>; Thu, 22 Nov 2018 03:04:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3E452075B
	for <linux-pci@archiver.kernel.org>; Thu, 22 Nov 2018 03:04:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3E452075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404065AbeKVNlo (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 22 Nov 2018 08:41:44 -0500
Received: from mail-eopbgr740040.outbound.protection.outlook.com ([40.107.74.40]:39519
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729872AbeKVNlo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 22 Nov 2018 08:41:44 -0500
Received: from BN6PR19CA0053.namprd19.prod.outlook.com (2603:10b6:404:e3::15)
 by DM3PR19MB0794.namprd19.prod.outlook.com (2603:10b6:0:1a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1339.26; Thu, 22 Nov
 2018 03:04:24 +0000
Received: from BL2FFO11FD026.protection.gbl (2a01:111:f400:7c09::124) by
 BN6PR19CA0053.outlook.office365.com (2603:10b6:404:e3::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1361.16 via Frontend Transport; Thu, 22 Nov 2018 03:04:24 +0000
Authentication-Results: spf=softfail (sender IP is 208.19.99.221)
 smtp.mailfrom=microchip.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=microchip.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 microchip.com discourages use of 208.19.99.221 as permitted sender)
Received: from AUSMBX1.microsemi.net (208.19.99.221) by
 BL2FFO11FD026.mail.protection.outlook.com (10.173.161.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.1339.12 via Frontend Transport; Thu, 22 Nov 2018 03:04:23 +0000
Received: from AUSMBX1.microsemi.net (10.201.34.31) by AUSMBX1.microsemi.net
 (10.201.34.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1531.3; Wed, 21 Nov
 2018 20:04:06 -0600
Received: from server1.microsemi.net (10.188.116.209) by ausmbx1.microsemi.net
 (10.201.34.31) with Microsoft SMTP Server id 15.1.1531.3 via Frontend
 Transport; Wed, 21 Nov 2018 20:04:03 -0600
From:   Wesley Sheng <wesley.sheng@microchip.com>
To:     <kurt.schwemmer@microsemi.com>, <logang@deltatee.com>,
        <jdmason@kudzu.us>, <dave.jiang@intel.com>, <allenbh@gmail.com>,
        <linux-pci@vger.kernel.org>, <linux-ntb@googlegroups.com>,
        <linux-kernel@vger.kernel.org>
CC:     <wesleyshenggit@sina.com>, <wesley.sheng@microchip.com>
Subject: [PATCH 1/3] ntb_hw_switchtec: debug print 64bit aligned crosslink BAR Numbers
Date:   Thu, 22 Nov 2018 17:02:00 +0800
Message-ID: <1542877322-24548-2-git-send-email-wesley.sheng@microchip.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1542877322-24548-1-git-send-email-wesley.sheng@microchip.com>
References: <1542877322-24548-1-git-send-email-wesley.sheng@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-Matching-Connectors: 131873294640308226;(5a93feec-e11d-4f7b-166a-08d09f1f276b);()
X-Forefront-Antispam-Report: CIP:208.19.99.221;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(346002)(39850400004)(396003)(136003)(2980300002)(199004)(189003)(2906002)(2616005)(476003)(50466002)(126002)(11346002)(446003)(4326008)(450100002)(76176011)(77096007)(26005)(336012)(69596002)(107886003)(53936002)(36756003)(51416003)(97736004)(16586007)(316002)(305945005)(106466001)(105596002)(53416004)(50226002)(48376002)(8936002)(44832011)(47776003)(486006)(498600001)(81156014)(81166006)(8676002)(110136005)(54906003)(86362001)(2201001)(356004)(5660300001)(68736007)(14444005)(2101003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM3PR19MB0794;H:AUSMBX1.microsemi.net;FPR:;SPF:SoftFail;LANG:en;PTR:InfoDomainNonexistent;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2FFO11FD026;1:RovE4JWbmG8JwN/ydYJGzjxcUbA+hHKZjh2o3/bwFX6LSK4MZh/2+7GfiGqZ8dssc5S1lIP7jFq3nScYbOuGO1iMt9xceHb0y5vlxYp0IrydJLLTvZcx7e4/afyKhu4J
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7365d1b4-483e-416d-d67b-08d6502734d2
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(5600074)(711020)(2017052603328);SRVR:DM3PR19MB0794;
X-Microsoft-Exchange-Diagnostics: 1;DM3PR19MB0794;3:69NGlueq0w3BBOvukg7a7qK+egzp3G3Ai8FiZaMGuuux1SirAt9Tb+m6PKpZU1W6OLxjqlFBHbdtmf8XPgUhb7kaqPpwRCZztg60hxLHi4PG24D1+IRWltTkaZKuVBhjCtwW3KL6ijUDzkUW8CpLwaG/cX9GgmbpUf+6W+B0z5vNwp5mkrRdIxJufPdtyDtm/Ll7BnXQ7EF3X2E3BXgnOPBNNbwbxbi6spio63rBxEdtx2mjllICHRQkvfSPUuIOYzFDAExYkkS3U1VEDVY3WR9fLzrR8Q9IjFkC3sTwN7gz40AZyTgB4JXg5TdZc+r0tiMznbwZDDSq/uvVUUo8V7Q53MSpOptq6BXwNSocWhM=;25:vTNhfnpNq3fHPfE2slwxXHFnr9NNGCi/8TwSFyGWTzeBMm3UPzOJVedZUkGfHKkoG4pqYrqifg1BVc0D3Qk4CVEi/D2iPdt/QOwqmbWQIEvjIQBHqw1I5DxD9tM+F2+ZIu7jxBXCeZFR2ZrkItAx1iGuhN31ThmH4SK7NxpqMMGG9BOdBHPgZ0J/qeh0VPZttIWM3eYp7n8Ad4mCNfIDPwM4+RnK73oJ14dxSE3xKIIb52uPwW0U8qgtY2fBNhoBa0JTmFWKlYqIC/X5JSV51tcjRKB2aGEa46jHWAnbRLfEHyTUkjbSzB0z5cgrV5oI2XCKrakQPsQ9UTGmT4PW1w==;31:+PWqiRHTgw8ovh0bYfm2aP8OEaldYfPQ3sG3y9yBbEAnLxHiT/bhuO0iC60+BHxFc8JMPwiEM050LSraPnRIl0u9MB7Z/OkT3+aU1aS9xdeXzrYeVE5KNBXqgIWhpFAtbLGExCiBnpeKDM9dZez7MNOhDaNbCLLpBmu2OgkTtQV0Y/VJHICeUId6jWOOs0VrPWtKMBJrsTcRU1JN8ozGYQ==
X-MS-TrafficTypeDiagnostic: DM3PR19MB0794:
X-Microsoft-Antispam-PRVS: <DM3PR19MB07947CCA778526D62DC4EEA695DB0@DM3PR19MB0794.namprd19.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6095135)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231442)(944501410)(52105112)(6055026)(148016)(6096035)(20161123556025)(20161123565025)(201703131430075)(201703131448075)(201703131433075)(201703151042153)(20161123559100)(20161123563025)(20161123561025)(201708071742011)(7699051)(76991095);SRVR:DM3PR19MB0794;BCL:0;PCL:0;RULEID:(400006);SRVR:DM3PR19MB0794;
X-Microsoft-Exchange-Diagnostics: 1;DM3PR19MB0794;4:9vQKv0xk28zGp1PFhrr7TYno0vizzvO7v+qo296ZB726g3fKntQbNJlEqX/a3Yl4PXgmeyq/Fb8RG5EUJtXmBpbulAGgapOA7Y53K5qLmi0Uayq+1X6b8YBMTxY7VUqZJ1O0muf/dp9HAT3mhurEGZU/FrvmVa04CG+n8gThdMcqfsBjkYHOGs0F6daxGdEdfULKltM3dukaPyWdtuRvDcRsiqpXVWR9jBKt6X9E125hQMcS7kZofI9TVrdV3Y00jmrwn9QUjq4F6AJuWMHJxg==
X-Forefront-PRVS: 0864A36BBF
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM3PR19MB0794;23:CS5mQzBxKsAZ60TwLH7augSuv8lwE58haxjl5JH/Z?=
 =?us-ascii?Q?M0qJSTfs/E6yhrDdqPvD07R8Ik7dBTNHYlIDnT//2ICnPB+PfcGTWqOvIPer?=
 =?us-ascii?Q?inR7KAWuWh4koqHmSVrnu8nE/vyfeELqDSOPbP3SMVT22IcGcm4LZ3R001Sa?=
 =?us-ascii?Q?OIhI3256X7ujQsrIbm0xzbjTu7okzlb9CZSv77PIEiPnm2CKgTAo76bMB4CC?=
 =?us-ascii?Q?/Jh3pdhuGND6vzaCgwoYq6s6XGltE9PwgaV/FUXNjARUdqeDKNlDfmtG0AJP?=
 =?us-ascii?Q?2PAzSLaXK0JdPiwc4s7RnlPAZPqZCqiv4dImSJhJmUyzcotU+ebraChM20LC?=
 =?us-ascii?Q?shyZhNe124DjYZxGBYd6rqRYj659tp6D20bbHx5soEemPmAoQtQbHNuwuDL8?=
 =?us-ascii?Q?X63c3Ryc6jpBMUAQzwtosmIRW/PR2VJYQoEraU3Wtg8d55IKgE+APxsnzSPn?=
 =?us-ascii?Q?RFNXkpUXZZzAHNzx+NEmey2Q22zzlAqKZtT5SlltMP86rmSqrO5FSmAgDUFn?=
 =?us-ascii?Q?9tX2acU7zz1QJilu8GC2pj/ZMbzcLve3uAK1JwE5CeiBdxWWdWRTcXj5o9VV?=
 =?us-ascii?Q?N9/309dXyHOPjej5C1tAPuoOeQWDqXmaKfhjDEIiBZK2lB5+bO97RsAsDSZK?=
 =?us-ascii?Q?43eEdXPWPh5LYU0pRWBbP3Mgfnn1b8XCTW8AKq+/h04jkYCRhErZ9a8Yg5JD?=
 =?us-ascii?Q?XpSz1BreHmiFjRNI05BwHTKqi1R8YHRB0jYYz+ar7Jh+0qIJQTfxF18w7pHV?=
 =?us-ascii?Q?bxdKeapdpZpPdizt7q3aYxltupm16aD/7f+tKWd5VbRc8MDXIkvAPbWihfPU?=
 =?us-ascii?Q?iWfU9QrLtYGFNgYu4XhqrR2HTybr8GmKPZ7++rXKtFl25TOLFXGrbgXwXvl0?=
 =?us-ascii?Q?U5KMlJ7o+qheIblf2CvAXI3ZHSaFBKffIzELc9b76TAyEt0OGX8AL9sZhJge?=
 =?us-ascii?Q?7mX5W/oqzjIhmfCJka+EM0hzwIFT+O9SfBz9szsYVOlv/s5ddPhuOj90hQIK?=
 =?us-ascii?Q?O57AynZmlvV2IlRZSwHpM1tVtPiwX2v635d3jMMDV6Vb2muigabD3Zv9WuYW?=
 =?us-ascii?Q?lyEBxeafhXPGHnVn6849K+kKI5OYuTRUhcpS+8QJmTXzIk5DdjCQP8EKIYnB?=
 =?us-ascii?Q?txEjOvE1vlNtcwDVebL4mnfxdg2kNxNSm9ARkt8BootXnW5q7rWSg=3D=3D?=
X-Microsoft-Antispam-Message-Info: rXegAt8aERdy6Zx9IyNgYs24vO9dlp1Gk5uZU1Y+YuIgLjJRzELNb0Tb16UFtba8p9CBYiv8c9tGxbWPlsTrbT6PkutO99DdxtfYyJnbpo37rjmXypLwfzEydhMjfLB/fbFcFTQr+7v01wE2J2S5KmiuJnfKgn4/TazfxUf0LPhlZY4U9unfeJMvBtG6t3LOFg+Q6pJCKioThDWN4RHdPIgd6qpGF2SKUTRsrFA870CJ8qf9E+TvwX9OZi0IarO9bDuUPPwbKJCnKfSWnN1PY4p91xuJxVND3BKAizoWgahhtcsi9rh65qG3r/BCnYwAM0RkN76MJLXC1gIHMUEIIA==
X-Microsoft-Exchange-Diagnostics: 1;DM3PR19MB0794;6:qzK4jYFnRhFFb4mfTZ8yAa0enLullvPfOuFfRo1lUlt/1SKkb50ZvCXvT0lWy6RoxIEy/KBRDYnSVLeYT20Wmrzz0gRmBn9fuyCr92uatN2A2ZrrlxBBGsLBrj8wJcA0lI/OEJIQOJgcUm0/ZUxwjbQzFTSNHukFpyXSoIb/JE8sxjPKa8UpvV883fetxTAhmG2ZC7FTNpB5y8QPnZdScZ1ET0AODDelIS4IZIdbkst816RrXFDvGaXfxKA0XDLGWIKQOPZJdL4f4VLr3dxWLPLRCcf4ZUprfc20VArFxjMFRqMhcxO9dk6HVz3hVOZCrob+X2G0YpaKXXxSzAOrS+yKcPlTcA9IPb8h4BfK0GyP2lb1Uw1MJ44fCdEuLMGpvHG2jSi6VZ84lT08+g3BOeGBs+wtyfgdXop7RC7snaHntJSSiMoK3FPL1pcRj+h4lKjOhqcRLcoy/Ytnem3UPg==;5:icB6CK66pcZF4Lj1DoaNeBRGEq/e8tMXY0WuPKtRQAZgwBBhvq4ZYKp+vRr176FRX4kJ+Ij0XyXQpz/fP5ABvuXjfesR0HQ93riO87I4j2WMKqYnFYDyOXuv0yg56Au6AAzv4l6TBNnrVl2jQi7xtZET3mHxh9yfhzKWySjJTug=;7:4ASmoUEmqsMVnUWm7pbmv5QmAtwe6JgjttPCmI86VCibrlU8Q86bjFlApnLBaY2mekewEA4TfQCaWd6jC7fgDbu77E7k5qle6aJw2Egy5wFsatsYPB4agAC0ySbnrrYKb2v5KHPXSsx3LXMf2Blt/A==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2018 03:04:23.8433
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7365d1b4-483e-416d-d67b-08d6502734d2
X-MS-Exchange-CrossTenant-Id: 5afe0b00-7697-4969-b663-5eab37d5f47e
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5afe0b00-7697-4969-b663-5eab37d5f47e;Ip=[208.19.99.221];Helo=[AUSMBX1.microsemi.net]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR19MB0794
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Paul Selles <paul.selles@microchip.com>

Switchtec NTB crosslink BARs are 64bit addressed but they are printed as
32bit addressed BARs. Fix debug log to increment the BAR numbers by 2 to
reflect the 64bit address alignment.

Signed-off-by: Paul Selles <paul.selles@microchip.com>
Signed-off-by: Wesley Sheng <wesley.sheng@microchip.com>
---
 drivers/ntb/hw/mscc/ntb_hw_switchtec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
index 5ee5f40..9916bc5 100644
--- a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
+++ b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
@@ -1120,7 +1120,7 @@ static int crosslink_enum_partition(struct switchtec_ntb *sndev,
 
 		dev_dbg(&sndev->stdev->dev,
 			"Crosslink BAR%d addr: %llx\n",
-			i, bar_addr);
+			i*2, bar_addr);
 
 		if (bar_addr != bar_space * i)
 			continue;
-- 
2.7.4

