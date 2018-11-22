Return-Path: <SRS0=lMXa=OB=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=DATE_IN_PAST_03_06,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D794C43441
	for <linux-pci@archiver.kernel.org>; Thu, 22 Nov 2018 03:04:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F41C42075B
	for <linux-pci@archiver.kernel.org>; Thu, 22 Nov 2018 03:04:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F41C42075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404091AbeKVNls (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 22 Nov 2018 08:41:48 -0500
Received: from mail-eopbgr770042.outbound.protection.outlook.com ([40.107.77.42]:31984
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729872AbeKVNlr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 22 Nov 2018 08:41:47 -0500
Received: from CY4PR19CA0036.namprd19.prod.outlook.com (2603:10b6:903:103::22)
 by SN2PR19MB0735.namprd19.prod.outlook.com (2603:10b6:804:29::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1361.15; Thu, 22 Nov
 2018 03:04:27 +0000
Received: from BL2FFO11FD014.protection.gbl (2a01:111:f400:7c09::192) by
 CY4PR19CA0036.outlook.office365.com (2603:10b6:903:103::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1361.14 via Frontend Transport; Thu, 22 Nov 2018 03:04:27 +0000
Authentication-Results: spf=softfail (sender IP is 208.19.99.221)
 smtp.mailfrom=microchip.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=microchip.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 microchip.com discourages use of 208.19.99.221 as permitted sender)
Received: from AUSMBX1.microsemi.net (208.19.99.221) by
 BL2FFO11FD014.mail.protection.outlook.com (10.173.160.222) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.1339.12 via Frontend Transport; Thu, 22 Nov 2018 03:04:26 +0000
Received: from AUSMBX1.microsemi.net (10.201.34.31) by AUSMBX1.microsemi.net
 (10.201.34.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1531.3; Wed, 21 Nov
 2018 20:04:10 -0600
Received: from server1.microsemi.net (10.188.116.209) by ausmbx1.microsemi.net
 (10.201.34.31) with Microsoft SMTP Server id 15.1.1531.3 via Frontend
 Transport; Wed, 21 Nov 2018 20:04:07 -0600
From:   Wesley Sheng <wesley.sheng@microchip.com>
To:     <kurt.schwemmer@microsemi.com>, <logang@deltatee.com>,
        <jdmason@kudzu.us>, <dave.jiang@intel.com>, <allenbh@gmail.com>,
        <linux-pci@vger.kernel.org>, <linux-ntb@googlegroups.com>,
        <linux-kernel@vger.kernel.org>
CC:     <wesleyshenggit@sina.com>, <wesley.sheng@microchip.com>
Subject: [PATCH 2/3] ntb_hw_switchtec: Added support of >=4G memory windows
Date:   Thu, 22 Nov 2018 17:02:01 +0800
Message-ID: <1542877322-24548-3-git-send-email-wesley.sheng@microchip.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1542877322-24548-1-git-send-email-wesley.sheng@microchip.com>
References: <1542877322-24548-1-git-send-email-wesley.sheng@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-Matching-Connectors: 131873294671628129;(5a93feec-e11d-4f7b-166a-08d09f1f276b);()
X-Forefront-Antispam-Report: CIP:208.19.99.221;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(979002)(136003)(346002)(376002)(39860400002)(396003)(2980300002)(199004)(189003)(68736007)(110136005)(54906003)(316002)(16586007)(77096007)(76176011)(6666004)(51416003)(356004)(26005)(4326008)(81156014)(81166006)(8936002)(50226002)(305945005)(53936002)(69596002)(107886003)(36756003)(105596002)(2906002)(498600001)(86362001)(2201001)(106466001)(5660300001)(48376002)(450100002)(47776003)(336012)(44832011)(50466002)(8676002)(53416004)(2616005)(97736004)(486006)(476003)(446003)(126002)(11346002)(2101003)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN2PR19MB0735;H:AUSMBX1.microsemi.net;FPR:;SPF:SoftFail;LANG:en;PTR:InfoDomainNonexistent;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2FFO11FD014;1:kKw+i+JHj7NciZJHXRcXFadBfK3s8tprtCgRnWk3C9aV8Ht9K/GOOTJ5mahj3G0CLuZ3BOt0u9AG11NbAWW1i3+h0Br5GdmnZ/ybmPv8ROFvZrB6wRZoXTBV7KD4TK+W
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9c699c02-f49b-471a-beac-08d6502736b0
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(5600074)(711020)(2017052603328);SRVR:SN2PR19MB0735;
X-Microsoft-Exchange-Diagnostics: 1;SN2PR19MB0735;3:bLBXgYzBHYOLpEUAkM2oKU1phus7BJxfcRfEUfrySNP8sr1Vv0FVBYUxig2AiT1/1Eqje3emAD0MxCQj1ZRBeN/dLv7DJ7q1aXMm27R4A5BCoHF/FZN5x2VoEaDeYdD6wSUfDpev0nm40YoRH2w4bPTm5oq0wgBGMW8C+zQ9irzlJC1RrstAUwDcbIyOO1Wo0z9TFGn7CQHfKA5jYlLbImY9D36BUtWjAfjo6wdrxW2AtbNKiRNm2h2RXdieey5f2tAgOsiVEhQHUxgNLDE84TpwdUPLU97s6e19fcJpoGlVChbNdXnA6B8HnRwtVaJ3QrR9I7GOJr1gTdVFSqqifnoUpoCFm7k09OsK+jWLR8c=;25:O5NE8n1+hTM8dLpLeC0iHb2y6KNJBqf/EHHUu7ZUNJaNccE0AXe7ncJyWz3cYm0NYaeZMMSYJeZifnQElFxpM2TVm3GwQExxlaifumusSkbWRfuG+7OWrmUSfgqXz/usMKmeMJDlUuxLLBLlcNkn9cK8y7i2wZIxS5d05AhABk2UO8i+6obh6z8OLnFz/WrKtYtG4hkbI4yiLcv8WY/DI1Le0KT+OFB0gV7XX+D/3wIOA+4tk2ev7DiPRv/C2YZS9laUik0ZVj8YUadrNYBANtEEg0D/xdl1bhEUoStO7zjGbcoJbfBz7a1iou1IPuk/u0zEQzHFDcYyrSSpm26ZWA==
X-MS-TrafficTypeDiagnostic: SN2PR19MB0735:
X-Microsoft-Exchange-Diagnostics: 1;SN2PR19MB0735;31:o0ms+dV0/0XRPskJMtGpLVB7r4vRpgcb4F6GSQV3AfjVF15mmDlCdHMyiOS/QPCgHrCOxFaLHQ0AOHWzm/ezl7dAX+k5KYEs5MmnkjQscOc/0+kWRTwVE/ph5LyIEizFvpECnulDIM5Riq8ii0DTv2XIYbAOfHS6m9d8jQCTJIu7bT7y1XKC3qzOMHJ5Afuu15NC6ezKymxqLaNaa8j9dTu5eDojDkHro+XUQbtO45c=;4:Jo9IvVVBdEC2+N7hv2uprspAlkxjOPoNPR/lgqVfHmthTLIIoWqwx0pVSuiXWTwGp6t9VyA2PhZC5kJ/4le7ZBnD+N5MQ8x5hBSf/IXASQrD7Ydp/JHpcyIPTAHShnYXo3Bw0VEBukTJcdGMemvakxD3YEcnbiT2H+WYdVxcRaRrRjmiEb8NEbIfZkKKL/zP0lp8CgDDg7yoFYXMuhak+nuNB/QyqOo7sE053xxEPmcldEDKbfiZdBjdJE4Tz1Ar7Z2AgzwcOosbrXTWjjsfug==
X-Microsoft-Antispam-PRVS: <SN2PR19MB0735D915402FA5B57B31F88195DB0@SN2PR19MB0735.namprd19.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6095135)(2401047)(5005006)(8121501046)(10201501046)(3231442)(944501410)(52105112)(3002001)(93006095)(93001095)(6055026)(148016)(6096035)(20161123565025)(20161123563025)(20161123559100)(20161123556025)(20161123561025)(201703131430075)(201703131448075)(201703131433075)(201703151042153)(201708071742011)(7699051)(76991095);SRVR:SN2PR19MB0735;BCL:0;PCL:0;RULEID:(400006);SRVR:SN2PR19MB0735;
X-Forefront-PRVS: 0864A36BBF
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN2PR19MB0735;23:RmkzxWrbd68vDd5Sxfci4dgv8HMMYKWkWuVrJ8Vuk?=
 =?us-ascii?Q?wxZ+WHpl/Wy3kJEdSurPWNZiGG2QSkoDdvP53H9ilwFqFd0ad6Xjj1+EBN2b?=
 =?us-ascii?Q?fALlLxFOuFjh6KCWbuTIQZoBlPrP5iETonwc2uykp6GSqJ36Z0RzIDSQbqr1?=
 =?us-ascii?Q?lApYu2Joa6hI0CTRTkHfD2mpneydMDeg7jrqdWbqEIlfhTC2McZhsZFlafMf?=
 =?us-ascii?Q?O0EYVb98N6EaJLVVV+dJpPu/wjCsA0qhUvBJhSzm6lySuIrnfuoZwDWTc81m?=
 =?us-ascii?Q?Sk/f7qH3sFt7rKnfBQjusAv5aIp46jGA9nvfFDhJ0TeX+btIda2bMA6lOGdp?=
 =?us-ascii?Q?wotDW3zB0gF8DuA4F8uK93CinfBU8rDZyUTygoBbwLedZDI4PoLrSkBWcBNq?=
 =?us-ascii?Q?B7zHzeTKw+RqhZqoWKLG4uFnhb+bB5vwCOEawmpo7sTSWiS8HQ4RJrC1g7KA?=
 =?us-ascii?Q?lE9//UQ3InTCbf6VlFMnzVpgvH5Zwzv719rkrv4lxoRk5qNpNf0iPU9GxZLk?=
 =?us-ascii?Q?LzgAGO8TM+51j7wYBwGDhMAQhGvdiaH2T9M6NA2971ucrYly7KdzS3ooWJ3j?=
 =?us-ascii?Q?YJi0oAKrSdBRrzXwvkBy+FXhhL/uNFVZiXwbJVIr79MEUzDURXi8UkZb0ATg?=
 =?us-ascii?Q?TLeCozCU2VvPidyTBjQ+xfqOAuXU64m96sJiNjM1mOORM2HXROUfwMQLsqPj?=
 =?us-ascii?Q?hEQ3h3d7Yw8IGjZSC3eCQ2KQEqFbxqpq4JzSpSjUnNbPf8R9gBpdxFGkgbWc?=
 =?us-ascii?Q?KouW5fYkQBQo9pTpeX2SgLMS8vNHooE7RZHjOZ40XMZAIoz/xaRHmIf5aM2f?=
 =?us-ascii?Q?iqv5DsI22gVKCcNbSUOGqOEXpRo+B+YWng3juM8dDwlNBb4Oe9LdbfiCheZd?=
 =?us-ascii?Q?F+LtKjbAKVSwQJ+7GGx0AjLJFVxjTXq26u96+whR9nPoHRK7InNO4UHdXhjD?=
 =?us-ascii?Q?KQ40bmBmK3qDyhav0zA1JkfffdY+aCr/Xgazb3UvM9nENbMnO7++ZmQr1rEg?=
 =?us-ascii?Q?sCLzODFdx2BgJ5aX7fMhfuIFQmWF+7/tRElGrcyfqCz6QLOW2h0BsZ7Qx3pO?=
 =?us-ascii?Q?DaF19RtOAqxa2S4mDC5/jSAHlwog22hIukwKHZ05UPcG5LDHBvaUY3+jymw0?=
 =?us-ascii?Q?rWY5MiBhvhzE3FuSDFoOLY5jvIq2iU0c0unTs+22DcVO5xNf7HxF76Q8khE1?=
 =?us-ascii?Q?8Q80pPJeh8Hm485i26AR6M6FzAE+Et3ZtyXFJJ25AVt9bwgU5enfcKixrMDu?=
 =?us-ascii?Q?KFsptyFjbtsw/VPzBK1hjybAfMlGaXq82shILb1?=
X-Microsoft-Antispam-Message-Info: 16wch/MsrJkfF6RLQrLw5SXekquf3LSX32ME9omj1vO5UHRxnOG8jonmje7BN4gg5lyQh/V5+ggyvVnPcj/eJa89ZFb4BC1QdBSgmiQxGLlQx6wFw2uf251lYuP5Xh40XUxWxk6CDOpFLEyuRl0cEqUks9n53oYB7apJtHmuk6q1kcJe1z0MevfVdAfzrE2Yj8rrCOOLx9t7vSQScpW9L74x8Yt1p0U35zIp5yS0BRqOZ0FoUy9aZb1jWOU50ezl1KrElXirS6OhwBdgT+mEPPx+N+bDRf0VjhIOhDp3euTJkOUAok0aQ5prxLhs0alFW/OZ1TIHVRshrJUekfFY8xBskVMJjN9Xk/ypLXdY54Q=
X-Microsoft-Exchange-Diagnostics: 1;SN2PR19MB0735;6:yUA7Z29QbsEXEuUTDSUKENJgwkaZ8Xow4ZKeKeZfsQEeQWPYAU84eQkOOHdD15vfWV+aW6Ot+IZRiwSM8/hSP8Qx4VYSNffiO/ZTM4NcCYYKP/3hBWL6GPIrBHxbvT8JA4/+/d7D+fgGXLFYNmoYkvmfmRRB2asoUgfoVjVxC7YZ7MNxSn1ICo2tidD3JrOFvBu5ojRfcvbDuE/US9bhIi8168N3PfEcDIQ6eDz1vUdU85MzeAqmikKl0tYwxyDVoaobS4Y9dx/J/UaE0K0qqThfoaiQTp/c/dJW6oI+2xYNX1SpYY7I2bE5EPBrZWTR5um2xSdifpMT023dx0z+3LKlO512lp4hwayTnf4Zi9yL7SdupQc1eEalFVEgv6ItbHMAzSyFq/wSb9R1yEy54ldjXOpgACqiJ8TjA2I2STcZeT8V5unIYeCY+YY+Kj8P7kUvwIhp/cEZ/6fo8W2INw==;5:8dXOwHusOqHEcC9WuAVYKsUYSmJhnaZSdezZhSZGimF+7cWllImQ1WFndoR9+kA+BEQmkxjW0dMVRS73Vlf/eJfp9SOEAIJko3RQO3Lkiimf8WgEGFabc8PkhK1fCfI1XHhPAaWPxagKp44Qq9kKyJAo6M8P++apAYuRyDR6Xhw=;7:aHE6nVm58pXOJRwXa+HPg/C+tWu3ZSPJs9nGsy/Orcf3RQYuXaQUMqynnm2IqtCrNfEQSxEBPys32nuWIgvq4U6xRZRnw+7PSeOWXpYbw3BXLTQr/iWasCuTQ+ucOXuwBnZga2yrjyVv7d4gQw0H3g==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2018 03:04:26.9753
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c699c02-f49b-471a-beac-08d6502736b0
X-MS-Exchange-CrossTenant-Id: 5afe0b00-7697-4969-b663-5eab37d5f47e
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5afe0b00-7697-4969-b663-5eab37d5f47e;Ip=[208.19.99.221];Helo=[AUSMBX1.microsemi.net]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN2PR19MB0735
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Paul Selles <paul.selles@microchip.com>

Current Switchtec's BAR setup registers are limited to 32bits,
corresponding to the maximum MW (memory window) size is <4G.

Increase the MW sizes with the addition of the BAR Setup Extension
Register for the upper 32bits of a 64bits MW size. This increases the MW
range to between 4K and 2^63.

Reported-by: Boris Glimcher <boris.glimcher@emc.com>
Signed-off-by: Paul Selles <paul.selles@microchip.com>
Signed-off-by: Wesley Sheng <wesley.sheng@microchip.com>
---
 drivers/ntb/hw/mscc/ntb_hw_switchtec.c | 9 +++++++--
 include/linux/switchtec.h              | 6 +++++-
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
index 9916bc5..32850fb 100644
--- a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
+++ b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
@@ -264,6 +264,7 @@ static void switchtec_ntb_mw_clr_direct(struct switchtec_ntb *sndev, int idx)
 	ctl_val &= ~NTB_CTRL_BAR_DIR_WIN_EN;
 	iowrite32(ctl_val, &ctl->bar_entry[bar].ctl);
 	iowrite32(0, &ctl->bar_entry[bar].win_size);
+	iowrite32(0, &ctl->bar_ext_entry[bar].win_size);
 	iowrite64(sndev->self_partition, &ctl->bar_entry[bar].xlate_addr);
 }
 
@@ -286,7 +287,9 @@ static void switchtec_ntb_mw_set_direct(struct switchtec_ntb *sndev, int idx,
 	ctl_val |= NTB_CTRL_BAR_DIR_WIN_EN;
 
 	iowrite32(ctl_val, &ctl->bar_entry[bar].ctl);
-	iowrite32(xlate_pos | size, &ctl->bar_entry[bar].win_size);
+	iowrite32(xlate_pos | (size & 0xFFFFF000),
+		  &ctl->bar_entry[bar].win_size);
+	iowrite32(size >> 32, &ctl->bar_ext_entry[bar].win_size);
 	iowrite64(sndev->self_partition | addr,
 		  &ctl->bar_entry[bar].xlate_addr);
 }
@@ -1053,7 +1056,9 @@ static int crosslink_setup_mws(struct switchtec_ntb *sndev, int ntb_lut_idx,
 		ctl_val |= NTB_CTRL_BAR_DIR_WIN_EN;
 
 		iowrite32(ctl_val, &ctl->bar_entry[bar].ctl);
-		iowrite32(xlate_pos | size, &ctl->bar_entry[bar].win_size);
+		iowrite32(xlate_pos | (size & 0xFFFFF000),
+			  &ctl->bar_entry[bar].win_size);
+		iowrite32(size >> 32, &ctl->bar_ext_entry[bar].win_size);
 		iowrite64(sndev->peer_partition | addr,
 			  &ctl->bar_entry[bar].xlate_addr);
 	}
diff --git a/include/linux/switchtec.h b/include/linux/switchtec.h
index eee0412..1e6e333 100644
--- a/include/linux/switchtec.h
+++ b/include/linux/switchtec.h
@@ -248,7 +248,11 @@ struct ntb_ctrl_regs {
 		u32 win_size;
 		u64 xlate_addr;
 	} bar_entry[6];
-	u32 reserved2[216];
+	struct {
+		u32 win_size;
+		u32 reserved[3];
+	} bar_ext_entry[6];
+	u32 reserved2[192];
 	u32 req_id_table[256];
 	u32 reserved3[512];
 	u64 lut_entry[512];
-- 
2.7.4

