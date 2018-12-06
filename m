Return-Path: <SRS0=KO/x=OP=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DATE_IN_FUTURE_03_06,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A23D6C04EB8
	for <linux-pci@archiver.kernel.org>; Thu,  6 Dec 2018 07:33:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67DC12146D
	for <linux-pci@archiver.kernel.org>; Thu,  6 Dec 2018 07:33:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67DC12146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729082AbeLFHd1 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 6 Dec 2018 02:33:27 -0500
Received: from mail-eopbgr700069.outbound.protection.outlook.com ([40.107.70.69]:23590
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729016AbeLFHd1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 6 Dec 2018 02:33:27 -0500
Received: from DM5PR19CA0042.namprd19.prod.outlook.com (2603:10b6:3:9a::28) by
 BY2PR19MB0390.namprd19.prod.outlook.com (2a01:111:e400:5a2d::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1404.19; Thu, 6 Dec
 2018 07:33:24 +0000
Received: from BN1AFFO11FD022.protection.gbl (2a01:111:f400:7c10::124) by
 DM5PR19CA0042.outlook.office365.com (2603:10b6:3:9a::28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1404.19 via Frontend Transport; Thu, 6 Dec 2018 07:33:23 +0000
Authentication-Results: spf=softfail (sender IP is 208.19.99.221)
 smtp.mailfrom=microchip.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=microchip.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 microchip.com discourages use of 208.19.99.221 as permitted sender)
Received: from AUSMBX1.microsemi.net (208.19.99.221) by
 BN1AFFO11FD022.mail.protection.outlook.com (10.58.52.82) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.1404.13 via Frontend Transport; Thu, 6 Dec 2018 07:33:22 +0000
Received: from AUSMBX2.microsemi.net (10.201.34.32) by AUSMBX1.microsemi.net
 (10.201.34.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1531.3; Thu, 6 Dec 2018
 00:32:56 -0600
Received: from server1.microsemi.net (10.188.116.209) by ausmbx2.microsemi.net
 (10.201.34.32) with Microsoft SMTP Server id 15.1.1531.3 via Frontend
 Transport; Thu, 6 Dec 2018 00:32:52 -0600
From:   Wesley Sheng <wesley.sheng@microchip.com>
To:     <kurt.schwemmer@microsemi.com>, <logang@deltatee.com>,
        <jdmason@kudzu.us>, <dave.jiang@intel.com>, <allenbh@gmail.com>,
        <linux-pci@vger.kernel.org>, <linux-ntb@googlegroups.com>,
        <linux-kernel@vger.kernel.org>
CC:     <wesleyshenggit@sina.com>, <wesley.sheng@microchip.com>
Subject: [PATCH v2 2/3] ntb_hw_switchtec: NT req id mapping table register entry number should be 512
Date:   Thu, 6 Dec 2018 21:30:51 +0800
Message-ID: <1544103052-28191-3-git-send-email-wesley.sheng@microchip.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544103052-28191-1-git-send-email-wesley.sheng@microchip.com>
References: <1544103052-28191-1-git-send-email-wesley.sheng@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-Matching-Connectors: 131885552032870463;(5a93feec-e11d-4f7b-166a-08d09f1f276b);()
X-Forefront-Antispam-Report: CIP:208.19.99.221;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(396003)(376002)(39860400002)(346002)(2980300002)(199004)(189003)(126002)(44832011)(2616005)(476003)(486006)(446003)(336012)(81166006)(53416004)(81156014)(316002)(16586007)(8676002)(110136005)(8936002)(50226002)(54906003)(53936002)(86362001)(26005)(2201001)(77096007)(69596002)(97736004)(107886003)(305945005)(11346002)(68736007)(51416003)(105596002)(356004)(76176011)(36756003)(48376002)(106466001)(47776003)(50466002)(498600001)(5660300001)(2906002)(4326008)(450100002)(2101003);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR19MB0390;H:AUSMBX1.microsemi.net;FPR:;SPF:SoftFail;LANG:en;PTR:InfoDomainNonexistent;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BN1AFFO11FD022;1:I7cCwpzMDHXt/2h46hPMh+mm2BlD1GYe7gFU/kncWysBmd28Gq5yRdfEJi2kI9O2YwJdYRJmkSNQ63o7RuPweSf1yoKoHJ06y/qsUKqE3vMyEbgLM8FLhciYrhxveh1Z
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b9fa23e4-a4d3-4be6-3f7d-08d65b4d1a53
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(5600074)(711020)(2017052603328);SRVR:BY2PR19MB0390;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR19MB0390;3:xHM+XKrAtQ1tuTsaRogVnl7kWaye7W2cxhB/4ffk9Uh0iNF+2sPvJwEDqT1iFbG34CZGSshgv87TvA/I516J8kWpyg+3ndoZu1KazE2NrrFhh7e3hnYqnCigqCuunxxqdjNEyhZWadz/9tWa/2XR+2MWYAEp1mFTIe/hFSBenzy98gIjHrcQ9iH45N9Q4gEXUuiIohHhJ407KcEHaxDnrJd1zNYw2bzPyh7f9IGkt2m6uQ/GbAiMZamNhm2r0ZV7EdAHplW+LPU+Ilgy0gezDLMFfBoL1TMpa1tySa5J2nm/CfiqTJQmTneN31V15oVpEhVhXRb/ojfdIo7x9AHv16jq62dzdiRhZ9aj3ww+Xqk=;25:2hA11ZgCy06TaltapzGkNuxQpCWD36wUALxFDpfi77w3fkfTbMvkbdPw/vBLOohH0sKi3nKyXJythAHcYIijp9e1J61Mr8x6VJW/AHiW/plQOv/kATkFGhmTCJMigXs3XJMQyhqzQrre3TLjqV7LC7T5OQ8MT9DcxSClF/VEIaIosTbnZF3+7nGtVFBUmqdSbgqNNoxu5uEuI97V3IlglECX0JKRLo/nmP46GOCd5PClrXk4QFtJ9p756BeCwiZH99qz6Dt/bxwBoU6Fb8OORW89Bx85fYQc2nxBhzn74JNhZ19r54Yade09KsEaxUjTn2mh7QzDoZuSkoISzCcgfA==
X-MS-TrafficTypeDiagnostic: BY2PR19MB0390:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR19MB0390;31:1PFGncd4vW4tZwcxjk3F0JbkB8EFRLQHSAc88OTaYWiQ+2Zol9KyT7kyMDuvJoCPGMGpPbm2d0H11GBnew0rC9fYMKiR+Dx4K22H+fZsfpFvIUxfj+K9bO6WdOVE4WHkf2//qjiWWP3dp20BNhSHgs3flcriJURRYS5oSfGxBETW7d4NR7H83PDVqBSfVMfZy090reDhibNIECA79Maz8zOiAlOa52lBuZzTivpqCks=;4:NMhLuG7OeBegusB2VwTlwP1MVZH+BFC5swX+lwd7/wl3tdnHS+5g0gCFD7Mwi+tZei2xngV4G23Y35a989lCp4i8P+Zg0LujdeZgRpWtHSVwURiQe2fU09Lm4HiL4x2UxNzKZ/7vJyffz3/MP1S5Bd/JowsoVdzcUiWUDJmbYsY4n6wWwI9iGMzKTaQn98IMXKLC0ajGk1/KurcxlkKUfp8CF8VZ4zHdmUdfsc24/GEjtO+7yXVVxNXWbTTMUXmL/uMJaL6tubfp5RJBoYqjlQ==
X-Microsoft-Antispam-PRVS: <BY2PR19MB039066889A62605AC8B8DA0995A90@BY2PR19MB0390.namprd19.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6095135)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231455)(999002)(944501520)(52105112)(6055026)(148016)(6096035)(20161123559100)(20161123556025)(201703131430075)(201703131448075)(201703131433075)(201703151042153)(20161123565025)(20161123561025)(20161123563025)(201708071742011)(7699051)(76991095);SRVR:BY2PR19MB0390;BCL:0;PCL:0;RULEID:(400006);SRVR:BY2PR19MB0390;
X-Forefront-PRVS: 087894CD3C
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY2PR19MB0390;23:ueUzLrXvWtWH5a2dbLKM67TODTtSPbz5y5kU+OoQY?=
 =?us-ascii?Q?gmiNJr7dRv4OqkNf0JvSU1L28mDqkGiVQwCI+UXinC1nhAHtsR78sHGPoEEj?=
 =?us-ascii?Q?fw1BbSMRUzqGNmhnIVTGGQNhG8HpKj12MPlZY4Ncgq1dIVYC9r4+QHoxI7ml?=
 =?us-ascii?Q?xNUQ0RkcZp9mYEn3e8+isao3H6CiiNYWfL4XtBeZY7vZMI/t0ymwTlUkWSY3?=
 =?us-ascii?Q?7jP35K0ABSITLdawVHa2T0g5GoAseRSO+lz5WRVBU4vW9kWhdIveyV4SF054?=
 =?us-ascii?Q?e8pd6u0spM65jl3Sd1PLnwRR/+awTWWuWes5TIx4CGhhSKSRkJHddGMLmwdX?=
 =?us-ascii?Q?+hikK3pJ9fh7Y2D/IhvXyY5DBh0KsLD7gnx8XVBr9qQjwOwsyOCYFjX2jKpy?=
 =?us-ascii?Q?vL+q4VNeKIzsSFIq0cpbFP8tADd+nxrLriCdCCN8aa1eYeyOHB4vx6T9sPOe?=
 =?us-ascii?Q?1OpeIQhzQYMXylZTw424yYCJtO4li4MxlzLYfowBeUGWHL283URMbZ7C6Jr2?=
 =?us-ascii?Q?fdb6nBmgN9LZDEN2AR2MAnerhh5AGeTUfIurPllS5DAOdjL+rQmRnLhmYz5A?=
 =?us-ascii?Q?QEVsU/diLkmwRv7aOwXM1ahOPzeOEG1evtWTMBq0iblrFuotpgwYLeQa7AxK?=
 =?us-ascii?Q?5c/8tSu2a+tYXta3hExF+5Y+cB7hJ0kuqDMjUs9CKyh1/gKap5Tk6qlNYya2?=
 =?us-ascii?Q?ARgw+YANxJxKFo3E4uDKuhyxLvVqynZ6e3Nj04SpmhGEgmKUQRL+0gvZ53NN?=
 =?us-ascii?Q?NBYlxgaY5rep6ZJLQlYJNGpUfnPqp1SF570ySKfvm52SSgwRDRllPpID/JQP?=
 =?us-ascii?Q?12xcptz5EEbo9zx3otja1ikEMEXGtGO7iR5QmKRpCCIFjp5UfCvsk6cg6Man?=
 =?us-ascii?Q?CMS7wBN8d9Omm8a5PMBCDLkUySoSV8lr671qPlL39/v/CbOqo+1mLUKMRmx6?=
 =?us-ascii?Q?6fz3ppQ9wfakmu6Rn9DZznIUDu0KEVTu3M3DG7O6ScLMYQ7BdzT1m+qu9Uxg?=
 =?us-ascii?Q?bVp2lGQuQWEF4Y+Un92dkAruuaOM3tcRyUyxGPPCr4IVumbENzSE7PQqDLtE?=
 =?us-ascii?Q?rP+ugsqu2shg/BNLyuBeuLDw39MXBx0vCozAoxvZiHUZACiq0cZPcIvltBlA?=
 =?us-ascii?Q?5nlMcopInA6Dp3x8x5hxZmYlZw15v+uymdcMpCOqNCXUjxNuX6x1Q=3D=3D?=
X-Microsoft-Antispam-Message-Info: EQmEtyoZaln/ILjrR3j8c+pvEk20ilbXVnlMsC4qQQFu653Gj3MMg82Gcng2fOROryBaZlUhAhLFveQo70zxJq+bXlEBG2/zHb0q63bp+fbmXH/+0PrWak/vcvLxWP1SltKw/6CV6La9UlhAnQ/HKBPSo/xbI682gkhkRJIYTitK96YGon9ESvZNDwlbjsA+vmynT53u7DjHv2eGVL2qzdf/p+DILeUot5sZ0orJDy4bnSU12333y8NtLOok9g5a2pK8FuekHPn7H2Y7vP1vv24uvt1TlhazcqEEsD1K9K6vJXNMoVj0R177P1TXIttXzmy/zsf+tBPD3IpKLnxNiRtoHrbbYz8k1Z4O71mSHJQ=
X-Microsoft-Exchange-Diagnostics: 1;BY2PR19MB0390;6:ZKKCeQUyXITrqsCpZnN8nvDt6vLHehKmjO5ur7qEaPxfi7mgTBXNYm7Dq09ViPHlvveLUsFvFma6YycYN33QGOmIAP0Ith4nhOWstiGyJJtvaBVU6iSwRDxkTddbFiEWZ4Nfwd+hPTZM6De9rDtM3wX2qMRvISznMZwbuJqQfl2a3tq67Ra84MgpuU6jL8oHEQkY3t6I1qDTTIavCwKsRBHCJPPAUYs/G9TJDqXI3r1IYScD74wqMSrvRwm4w5Q+fG47VyCN4YO+rY7zK3YkgVC72+BLHCYAj6o7STzowR7Rqtfsyw/i3K11UaYu/1vBltodNjT4pgJZSMO/BCbn0jAaezCXYIEqhrsr5bOwG0wZspw64Jr9cnr8dufsc4BHnEkvb3l24i99gVfgVuB579Gpz1Q/Dksmuaxdn5uQ6+jz/x68uOEZnsu74+WLtOoUMXhuFFN58saalzKziXyJtg==;5:mQ0EXGM1T/8uWEvrcvvdBbb9CCM4SGFj6qgf3tyg3bj0hxQL/3udm1WJrMQ3+xbco24j6fl31cgePGYRRRdUDdr/fXwXfOz3wrDci4qexdT6x/14yaipZk3qpG/muN+JHuo1uhQLncepo82SNTCxeAU5Kb20Ltm1QVoH5750o4w=;7:alKeBb5Py7siJL4wnoRf14Vsp8dv8NU0ZGpbJoXGkwbiKLaqYVrgeIpsTCloybk4TnHar6jqYth4+UAnJfdNtWqz78l7wCYup8jSo1NPOpr8Byb0Gta/83dlZ7EHdF8IyNeJZ36AR8m+ZAUm4n6bpw==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2018 07:33:22.9901
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b9fa23e4-a4d3-4be6-3f7d-08d65b4d1a53
X-MS-Exchange-CrossTenant-Id: 5afe0b00-7697-4969-b663-5eab37d5f47e
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5afe0b00-7697-4969-b663-5eab37d5f47e;Ip=[208.19.99.221];Helo=[AUSMBX1.microsemi.net]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR19MB0390
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The number of available NT req id mapping table entries per NTB control
register is 512. The driver mistakenly limits the number to 256.

Fix the array size of NT req id mapping table.

Fixes: c082b04c9d40 ("NTB: switchtec: Add NTB hardware register definitions")
Signed-off-by: Wesley Sheng <wesley.sheng@microchip.com>
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
---
 include/linux/switchtec.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/switchtec.h b/include/linux/switchtec.h
index ab400af..623719c9 100644
--- a/include/linux/switchtec.h
+++ b/include/linux/switchtec.h
@@ -244,8 +244,8 @@ struct ntb_ctrl_regs {
 		u64 xlate_addr;
 	} bar_entry[6];
 	u32 reserved2[216];
-	u32 req_id_table[256];
-	u32 reserved3[512];
+	u32 req_id_table[512];
+	u32 reserved3[256];
 	u64 lut_entry[512];
 } __packed;
 
-- 
2.7.4

