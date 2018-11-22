Return-Path: <SRS0=lMXa=OB=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=DATE_IN_PAST_03_06,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C9BAC43441
	for <linux-pci@archiver.kernel.org>; Thu, 22 Nov 2018 03:04:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C90A2075B
	for <linux-pci@archiver.kernel.org>; Thu, 22 Nov 2018 03:04:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C90A2075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404120AbeKVNlz (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 22 Nov 2018 08:41:55 -0500
Received: from mail-eopbgr750049.outbound.protection.outlook.com ([40.107.75.49]:18688
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729872AbeKVNly (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 22 Nov 2018 08:41:54 -0500
Received: from DM5PR19CA0024.namprd19.prod.outlook.com (2603:10b6:3:151::34)
 by BY2PR19MB0391.namprd19.prod.outlook.com (2a01:111:e400:5a2d::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1361.14; Thu, 22 Nov
 2018 03:04:33 +0000
Received: from BL2FFO11FD010.protection.gbl (2a01:111:f400:7c09::152) by
 DM5PR19CA0024.outlook.office365.com (2603:10b6:3:151::34) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1361.14 via Frontend Transport; Thu, 22 Nov 2018 03:04:33 +0000
Authentication-Results: spf=softfail (sender IP is 208.19.99.221)
 smtp.mailfrom=microchip.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=microchip.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 microchip.com discourages use of 208.19.99.221 as permitted sender)
Received: from AUSMBX1.microsemi.net (208.19.99.221) by
 BL2FFO11FD010.mail.protection.outlook.com (10.173.161.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.1339.12 via Frontend Transport; Thu, 22 Nov 2018 03:04:32 +0000
Received: from AUSMBX1.microsemi.net (10.201.34.31) by AUSMBX1.microsemi.net
 (10.201.34.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1531.3; Wed, 21 Nov
 2018 20:04:14 -0600
Received: from server1.microsemi.net (10.188.116.209) by ausmbx1.microsemi.net
 (10.201.34.31) with Microsoft SMTP Server id 15.1.1531.3 via Frontend
 Transport; Wed, 21 Nov 2018 20:04:11 -0600
From:   Wesley Sheng <wesley.sheng@microchip.com>
To:     <kurt.schwemmer@microsemi.com>, <logang@deltatee.com>,
        <jdmason@kudzu.us>, <dave.jiang@intel.com>, <allenbh@gmail.com>,
        <linux-pci@vger.kernel.org>, <linux-ntb@googlegroups.com>,
        <linux-kernel@vger.kernel.org>
CC:     <wesleyshenggit@sina.com>, <wesley.sheng@microchip.com>
Subject: [PATCH 3/3] ntb_hw_switchtec: NT req id mapping table register entry number should be 512
Date:   Thu, 22 Nov 2018 17:02:02 +0800
Message-ID: <1542877322-24548-4-git-send-email-wesley.sheng@microchip.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1542877322-24548-1-git-send-email-wesley.sheng@microchip.com>
References: <1542877322-24548-1-git-send-email-wesley.sheng@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-Matching-Connectors: 131873294732104630;(5a93feec-e11d-4f7b-166a-08d09f1f276b);()
X-Forefront-Antispam-Report: CIP:208.19.99.221;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(396003)(136003)(376002)(346002)(2980300002)(199004)(189003)(2201001)(11346002)(47776003)(305945005)(106466001)(86362001)(446003)(105596002)(44832011)(476003)(486006)(4326008)(450100002)(2616005)(498600001)(126002)(107886003)(68736007)(77096007)(26005)(53416004)(53936002)(54906003)(5660300001)(356004)(6666004)(8936002)(48376002)(316002)(50226002)(50466002)(8676002)(110136005)(16586007)(81156014)(81166006)(336012)(69596002)(2906002)(51416003)(97736004)(76176011)(36756003)(2101003);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR19MB0391;H:AUSMBX1.microsemi.net;FPR:;SPF:SoftFail;LANG:en;PTR:InfoDomainNonexistent;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2FFO11FD010;1:GZnxQPyHmw3wA+4JMrdioELxC053Z0SK8OBAELhMB06h1H3sqPSpON3HF7a8wVa2CMWZiiUZ54rZR0zjMevFXNGcTJR1LzUfNwlxASZxWSbHImNuxnCSIYjgNgVy+0md
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 027ed486-868f-421d-c485-08d650273a46
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(5600074)(711020)(2017052603328);SRVR:BY2PR19MB0391;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR19MB0391;3:9vmyBDQth49oDkEiXKulp0S8RH9ZAmy2ZGYGBKCsGp0PB2FiOoYlE0FZ++VdTpDbpPmKLgSUclH4HTKnjtGWfF0VhgL36DlF6EY78Y7IiUtSIRt4RSim/UGof/5tUMBYaR/hlWeZVCLB4DSNe2o0gxpEEQwsOYat6xJtdWTTqdYitpPOCsnsx8bBYCDBKpzByo+iNNOCphAL9Z1X/YrgGgzdICaioifwLgvZSpNPKLLwjvkrnBXp5CadTlK95B6LB7YK/3gxPX74RorcyS7EZUFOBtUdBKZoTz//TlpdRpWAKirFF8uIJpaWz+p4VGjDku27vrowvTIw0YeeFMxWd1wuJdi+HWbaso3F1/160n8=;25:2XCFEFkfi4hf9hAIdEUmM2ih7mTHFqwTWSxPKPQYKrRtEmoi6UO5mWLB7PwlUKY1mkAe1In/m4na85SQCzcuQaY7bAy/5KmUj9LqAj+uPI1LZSf5OVzJVLPKNHsdfdKrRBlzM7z5ZiXZZ5EfT12FaYfLx9I7lI46i5jUVejg06SDwu/+lm0H8oTSh9r1sPrxmC8rx2A5tEjpGoLCcbXg9oSbowDqvVy+dfDocsJO4BbtUaBTC0WE/DAscFATZqUmHTuq9LyZsmfThbe8/RYPnSantLeaC6N27WwCSZu0a+MAjRqQbCVkBFvMRA03vP1qmeM9sM683vdACNQDelKiJU9eoRPPg4hTYaGytkJIAXk=
X-MS-TrafficTypeDiagnostic: BY2PR19MB0391:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR19MB0391;31:pSByU9BODweNGsEnNQCNnvnasC8eRgBS/bIoAaTvSoN7tdECf5zQyjpgiLxbhlMCFiYaJoWnjr2m743h9Fc3N6TxLDiH5Af21m7gfY42fF22um1Is9YOqefdjus9bt7P2CILGx9rgOSXvvrkRzYEbS10aDvXQ0SW4nSyJlwwsuppcGOL7i/dMiV90u/x/3+2nOxuAHNkim2nBpE6z8W80wsqmdcnVEY74CWCNeUEhO0=;4:b/q27dNWNcR3YgHJfU6ydhGqJKdzO42vnqg2dteJuxpefH6ULnxPaRw9eXEEeWE4L9S4WvuGtDpNJwx/1JU36pqU5+cbCes3+eZT4ERCsHWP3FsH6zPKyvMMWv24un9nXZj3cLUlUnIUsIMmrG5FfDY3i8no7HeA0Gfy7JRXe4TRSTfbsc0hzt2F+mZmYCLIKGK92omox+FFv4lp6lHdKv6aSKO07V5UoXz+5wr7hwZws1VZrLaQiJPX55hwNOFWgW6iCk2l+q3/aR7Dv4xITA==
X-Microsoft-Antispam-PRVS: <BY2PR19MB039131E17CCFC784B3B1430795DB0@BY2PR19MB0391.namprd19.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6095135)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231442)(944501410)(52105112)(3002001)(6055026)(148016)(6096035)(20161123563025)(201703131430075)(201703131448075)(201703131433075)(201703151042153)(20161123561025)(20161123565025)(20161123559100)(20161123556025)(201708071742011)(7699051)(76991095);SRVR:BY2PR19MB0391;BCL:0;PCL:0;RULEID:(400006);SRVR:BY2PR19MB0391;
X-Forefront-PRVS: 0864A36BBF
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY2PR19MB0391;23:PCgHKJ0Q6+h4qkXTvre+YPCnQkTX/VXk+F/kQ6qsD?=
 =?us-ascii?Q?ldNaNa2eDU6PoM1Q4r8lOkinGI20gWWb6kCBS3lEofhB5BriS6dAfQ/qbFpX?=
 =?us-ascii?Q?QSTAyetsGegePTiQ9Qkelk5dYtCIeqG2LWJQcgUxXQvJ/FnLA8HWatjCQvfN?=
 =?us-ascii?Q?MbZSR1/3hPpWA2Rz0kaO1QfkatnCNEa5agf41Em6GlFSiKlhrgcrnZLeUbCJ?=
 =?us-ascii?Q?hValSIbFbNvwBTcQNy1rZxGluLqwAmBhfIl2ZkCNFlEOoxPAkyXGDHP6MEeG?=
 =?us-ascii?Q?A/kDAZwqVQjUgfhtSsibUct0czBghbcJP9IqSk8B3tHvAV8jrxzcMmmDGrXB?=
 =?us-ascii?Q?z49OcG1WPUeXTngIkgpJD1iLyVswYtvn4S3ncBKQ4IAfSqeriAv/eVx88wDV?=
 =?us-ascii?Q?1GCC73fkl6ReOxw4BeFrPL+IdyPxHy0QHcpZBeehzT9Ok30SHd86iLoFfRoJ?=
 =?us-ascii?Q?EuvvJDEdaNtGigzUNy7IpVgn8NeuWrGlKscFwCBSEgnlkkVhNM2ODNtsMF0/?=
 =?us-ascii?Q?ztdwxGiwCNERxDnTTs+oyWaaYKvEyS4gVGL+g/l1dukwaFehY2eSHEI979zJ?=
 =?us-ascii?Q?Rsny3sqWgbRMX1C80VIPFjNBDfBfOYutr8VQc3fTibhSmdWMk3yY6dXDrCEF?=
 =?us-ascii?Q?2nVcAX75ByiASzYPXlBt2kLxPeAJ3zOROcdtSS01cLgCY5DoCo4861f7tfui?=
 =?us-ascii?Q?mTXFIp3jEfFCJ4IiO0WisukVgpuTZ3bEsEweAgNXNWLs15lVYN0Hyx/y7j/t?=
 =?us-ascii?Q?wjRLbvO87eVjHGE/EnrFLi2rUesQTMxkIvokWjYdmmRUqUpdJr34BTReEeUX?=
 =?us-ascii?Q?Wc5ofMtAGOoEp3+jOse1R2lmtEw1Jr0Hb/UiWZR/DDBYj0t91WgNXFAIoE81?=
 =?us-ascii?Q?72Xd32CyaLkKmw5C1OknDWHPNFf6CzaZYpzc2Hawk6eGpwc1dMwch2sjysdF?=
 =?us-ascii?Q?uCIBd36FOXz9WJt7lQrJDD4JfIDq7DRCqsQlrpdFyaL9e3d+n1bKsbTngCuZ?=
 =?us-ascii?Q?ljcahzODmfCFzs0b4+5Ce9lh8fY/n7Cu2rfH/ehgpvFC3kDkJZxBhqd0IoEE?=
 =?us-ascii?Q?5YwGsMzMKrQqFl/o9HHF2gvnTcCL6Jqe7zDNIxSJRnB482L33TuPQukStKp3?=
 =?us-ascii?Q?SKwp+BIMYL5fxzUyG58z5+PQMcYuZVp65sjLs67btkr0B5yc2UmRw=3D=3D?=
X-Microsoft-Antispam-Message-Info: pbikIuxudU9EGmfagYPc2fZX5rkafqezAJJ+jU0gbOneiRbAkEIAYYOJwL+qlDp7s9pKi10RwUFJewKzEN0ubO+3vwLxXdIVD3w6ZTj8UiKX4EKgE694J3FKHiakTUR4aawH0R3WX0qVz/cYuzK5JEfp/64a4eJSi/tIOibY3azK/Bc4xYEd4uR0bl53OOeklrhXeBLfxlkXq6nB1lEE/Aw8cDgy++KB9KyK2FrRAooM0jKvJjLMiZ9E+mWWtV4iCslq8zQn+uCBgROkPL51UIJm0zhY75Oj+Kz2t1msjXZQCCiFLEa9uYYl1VaAQckyElUY2Iv5oCRCBo5OR91H1yE1R/7yt/r1wes4JOTe0rY=
X-Microsoft-Exchange-Diagnostics: 1;BY2PR19MB0391;6:Zs4lG+tAuFoP1I6aZELnIYz4LCaD3WEm5R0Rie95cUV1A7xiARu72nBgNqd7E8KTw9DEtH6GiUWyA+fpQqiMHI/V+wzcbnI6pS+e5SWN5CnwKjMLgZvEkHu40O7LstM9GfDZgE1ZLCoc3J81WB3+uxvajIYCWBvlqqeVubK41qb80SW3nC+Ou/XtH7BfLS6qJ5zzStiWHd3It2dW2jcNbGhM61+KfUfDr9cNOA8GMkN8e3ab5LKU8d0pZaxGS9K+XiPNaZpSFu8n61JyX1wRumgcXQYyWUGPoVa0wN3lq9OdVXiAmmvXCS8IPRwaNBWsXFfb/bComYh8MMx46UBEdlKbFb0MW88dImdpeWhQAstF1UJ7C0Lw9sn9qZ7Is+5tQ3qGcjbScv4J3dnUjPMC5zxFN002qEf13j8mE1mQvmTzumSvk8EoxAXNZ8Og73FdQPj6lDWNXakod5N8SggMLQ==;5:o24RUfFtbX4sucGk6qHuKM60FM0JWlj9wxfwTwM9i3jiHLuG0fvM8Dv7x+KGjfgcUOb5DrjvmlTDk8bPK7uiO6aJ3iVTRAlPaPIlpJE7vUew2e9zu1v0N0pUbUeZMoJ0Q6bdkqNZ4Xt/c0HxSkmZOjhzp9/XZFJl04TfbwwNzhE=;7:krfzcFqBw+duDs1kjK5fOiZGjtpRTrT2JXeQpO8mZD7uFUQA3jWkDBGzFDlNmp6O9de/iBiC0feH9Z/KJzzpR6WQD4i5nhCeK7pgiOKFsLUowFoA5ODQDYwIiB9Bo4aFcVuYrVj4sFiA7lsI0Hx47w==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2018 03:04:32.9916
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 027ed486-868f-421d-c485-08d650273a46
X-MS-Exchange-CrossTenant-Id: 5afe0b00-7697-4969-b663-5eab37d5f47e
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5afe0b00-7697-4969-b663-5eab37d5f47e;Ip=[208.19.99.221];Helo=[AUSMBX1.microsemi.net]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR19MB0391
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The number of available NT req id mapping table entries per NTB control
register is 512. The driver mistakenly limits the number to 256.

Fix the array size of NT req id mapping table.

Signed-off-by: Wesley Sheng <wesley.sheng@microchip.com>
---
 include/linux/switchtec.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/switchtec.h b/include/linux/switchtec.h
index 1e6e333..52a079b 100644
--- a/include/linux/switchtec.h
+++ b/include/linux/switchtec.h
@@ -253,8 +253,8 @@ struct ntb_ctrl_regs {
 		u32 reserved[3];
 	} bar_ext_entry[6];
 	u32 reserved2[192];
-	u32 req_id_table[256];
-	u32 reserved3[512];
+	u32 req_id_table[512];
+	u32 reserved3[256];
 	u64 lut_entry[512];
 } __packed;
 
-- 
2.7.4

