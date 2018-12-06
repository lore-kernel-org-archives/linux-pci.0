Return-Path: <SRS0=KO/x=OP=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DATE_IN_FUTURE_03_06,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FCF8C65BB0
	for <linux-pci@archiver.kernel.org>; Thu,  6 Dec 2018 07:33:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BF992146D
	for <linux-pci@archiver.kernel.org>; Thu,  6 Dec 2018 07:33:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BF992146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729038AbeLFHdc (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 6 Dec 2018 02:33:32 -0500
Received: from mail-eopbgr720050.outbound.protection.outlook.com ([40.107.72.50]:47104
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729317AbeLFHdc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 6 Dec 2018 02:33:32 -0500
Received: from MWHPR19CA0005.namprd19.prod.outlook.com (2603:10b6:300:d4::15)
 by BY2PR19MB0389.namprd19.prod.outlook.com (2a01:111:e400:5a2d::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1404.21; Thu, 6 Dec
 2018 07:33:29 +0000
Received: from BN1AFFO11FD012.protection.gbl (2a01:111:f400:7c10::138) by
 MWHPR19CA0005.outlook.office365.com (2603:10b6:300:d4::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1404.17 via Frontend Transport; Thu, 6 Dec 2018 07:33:29 +0000
Authentication-Results: spf=softfail (sender IP is 208.19.99.221)
 smtp.mailfrom=microchip.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=microchip.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 microchip.com discourages use of 208.19.99.221 as permitted sender)
Received: from AUSMBX1.microsemi.net (208.19.99.221) by
 BN1AFFO11FD012.mail.protection.outlook.com (10.58.52.72) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.1404.13 via Frontend Transport; Thu, 6 Dec 2018 07:33:28 +0000
Received: from AUSMBX2.microsemi.net (10.201.34.32) by AUSMBX1.microsemi.net
 (10.201.34.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1531.3; Thu, 6 Dec 2018
 00:33:00 -0600
Received: from server1.microsemi.net (10.188.116.209) by ausmbx2.microsemi.net
 (10.201.34.32) with Microsoft SMTP Server id 15.1.1531.3 via Frontend
 Transport; Thu, 6 Dec 2018 00:32:57 -0600
From:   Wesley Sheng <wesley.sheng@microchip.com>
To:     <kurt.schwemmer@microsemi.com>, <logang@deltatee.com>,
        <jdmason@kudzu.us>, <dave.jiang@intel.com>, <allenbh@gmail.com>,
        <linux-pci@vger.kernel.org>, <linux-ntb@googlegroups.com>,
        <linux-kernel@vger.kernel.org>
CC:     <wesleyshenggit@sina.com>, <wesley.sheng@microchip.com>
Subject: [PATCH v2 3/3] ntb_hw_switchtec: Added support of >=4G memory windows
Date:   Thu, 6 Dec 2018 21:30:52 +0800
Message-ID: <1544103052-28191-4-git-send-email-wesley.sheng@microchip.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544103052-28191-1-git-send-email-wesley.sheng@microchip.com>
References: <1544103052-28191-1-git-send-email-wesley.sheng@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-Matching-Connectors: 131885552091019118;(5a93feec-e11d-4f7b-166a-08d09f1f276b);()
X-Forefront-Antispam-Report: CIP:208.19.99.221;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(136003)(346002)(396003)(376002)(2980300002)(189003)(199004)(44832011)(2201001)(316002)(16586007)(77096007)(336012)(47776003)(305945005)(86362001)(69596002)(8676002)(81166006)(81156014)(11346002)(446003)(5660300001)(2616005)(126002)(50226002)(476003)(8936002)(486006)(356004)(6666004)(53936002)(76176011)(97736004)(53416004)(68736007)(107886003)(498600001)(105596002)(4326008)(51416003)(26005)(54906003)(110136005)(2906002)(50466002)(48376002)(36756003)(106466001)(450100002)(2101003);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR19MB0389;H:AUSMBX1.microsemi.net;FPR:;SPF:SoftFail;LANG:en;PTR:InfoDomainNonexistent;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BN1AFFO11FD012;1:EXaPtraIymMsctqO7myIJ6sKkKVWYprLXzwNd0pph6kETAoV4TJhX686xXEJXH4IPQfeCCfB3NpmscYzNBOYQUd7MuUWgCjD2lMyrIHBcduv0usOQLVLCkUR8rtLVf9W
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c1ca6188-2319-44e4-24a7-08d65b4d1dc8
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(5600074)(711020)(2017052603328);SRVR:BY2PR19MB0389;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR19MB0389;3:Z/j6UyJZmz3WC4mNKzTpp2+mOw+vW7IoPX1zoYNT1S4u1b0T8a6jilxtiCTDKCjglXS2RxtWcDWWR2WlwVzcG0pOURuOJ1UnNtPN6L8eARG7K0IbvuxObwWzZy8pze1xH3iNf/VjaKH9B4UNzzY1e9k8RIIISDyG3ZFYzNqoCV5jNdEuGByi8sqcvTShqc4McJBqF/sum3NO5VEX2dwMlKHo0mVIz3C2mmioQ3xxBiU+YWs85y3BACifKXHEXH3VMYfy/qkKAlT+HqD6Yl0qFVUYxZo5eTHv4QxjYPbQjMCiFgtxKaeE2/D+maFQMjWl2Np6FZKC7MlaeEUFVVofuqWwT39CwAC8JQf97WNmGIs=;25:8xLqq8xU45Hc0Y7vJw3Zau9tPdqm+/25wp7hZe02E5+m+QonZH7EOioNVGS/Wpgp94TagUsfQHAfIyyuM7cEVju4S6A/pyfcWJOtqxLppokov5NgprZhsqKRzgUicXRCwK17R3GxW/ukVB7dsaWWNFRY96Y9bLF0V7gXHEM9rimEFk1s3uy+UV/buQxOcDpdJ7IE2jRcIMJyrodoMXBRKYQgfuTr04yQGHF2d6MH3MFqEweSZfVWRJPHfQ6h8/pUND2Ne/WSsv827mvxiLLzBSho77C2QtmK374mJVaTBwm+w0hTyfY6+PHPp3XqX9/O+TCIxYVT5DL1H7HPJFf49A==
X-MS-TrafficTypeDiagnostic: BY2PR19MB0389:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR19MB0389;31:EgK2k27w7XTvU3DoZjiBqxOYTOz/Dol68+5AGQzj/LBfkq5Av5BgMtyuj+ltGemVuvg442kMonvyjaIPGf27vyy7opxrcZIOQ64Wi2o1dIHpTZ1jTmGeYAHEvlAt4u/MuZZBC+d+Rg5jGyC/uIxu1Hji/tq+r1lobp4jLVdpQBSf5o1Td8slZMbUMGOi0bZn12GzETtrY8Mc3purtXvdhXFXKpeX0EbKHrMCcUq4qRw=;4:TxM4+tk74TbVV13n5JK41FeIQgGJO2nFb/pdCjABjAR6CY4Um/r6KHmL1UMKDqRwqMiZmklWJvYDVG+WJrY7/3xJaQHnNVWMmtT3pb61NPwkhS2f27dIU7Dy7xKzo9HeoKK+tddaIoL/RCVeYCeHVbaq3AZ4XIZZXpBLKqAZjHc82lO6SlEEL0jg2nMSVhxNkjB9cn+AVYufdEDvwtXyCg+tnylTvNNl7jw2TymdVxLx9rR0dzMdqpbINXJ/NCcO2bCtLWhuwcUQh6XLPzpQcw==
X-Microsoft-Antispam-PRVS: <BY2PR19MB0389EAAA9175B8528ECE522095A90@BY2PR19MB0389.namprd19.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6095135)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231455)(999002)(944501520)(52105112)(6055026)(148016)(6096035)(20161123559100)(20161123556025)(201703131430075)(201703131448075)(201703131433075)(201703151042153)(20161123565025)(20161123561025)(20161123563025)(201708071742011)(7699051)(76991095);SRVR:BY2PR19MB0389;BCL:0;PCL:0;RULEID:(400006);SRVR:BY2PR19MB0389;
X-Forefront-PRVS: 087894CD3C
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY2PR19MB0389;23:wh0DCYI46jDM/bL+DiH+HX5wJyuHn8GenReY6fyKD?=
 =?us-ascii?Q?QuWu87i5ztgMednFLFA8saRuB3+dAP/DPyWMP5I1cckn/RZ66CmQsyW9FLL9?=
 =?us-ascii?Q?QwoFYyL7p/q6Dy17QReymsmNmHLqAWnZftYbqSabS7QS4IxgSIuqBJPPp9s2?=
 =?us-ascii?Q?YYUoX7Sr7MwDt6nbHE+QJKgEv7u0qvjVvwr6X2pqmE/sKqpx04Z8zcpAZXrS?=
 =?us-ascii?Q?pvvfwgndTx3kgz1SEAhNQg/AEmVBVD4OEV0T32ny5fZb+WEVZ7loeL878nEW?=
 =?us-ascii?Q?9Ai+IfR50Z5+v4SonNqUu9vSt6SLtV3YI46hdICEJ4eRoH56+9HywBSUrGDD?=
 =?us-ascii?Q?i/w+i9NaWSZhNTAqbmHjiYRbYedCea5xovUmnVg1VPKLJTj74OGMLHPhrVxW?=
 =?us-ascii?Q?x43AZ8O8AB67sWfKmOADCOq8bEHM9OPnfYmacRz/2JXNVKnXCbaYSh2/AwgS?=
 =?us-ascii?Q?7xldV+vFNzOlgReZuS0dH3N5Hc5aDC7ghxaG4LogQO8hYGFe7oBuMbQjYVzu?=
 =?us-ascii?Q?ZQkX9oJC4q/VqByvyBhb8FY7ZzEc92zG48E4I4Vkp4TfZfEM7l7K6ITq9L5Y?=
 =?us-ascii?Q?71bz/RXJmfW6rt0oDzjSBJ+u6Ed43maluKy3jp/N9khxkGiQBs3XR99pC7k+?=
 =?us-ascii?Q?/8+Cs3AF2ro0mQV9Gz89Ln5hmaWu1xrHTlQWFSm6nhJpLJfOdbRgQNoytc7B?=
 =?us-ascii?Q?FzO197XuyuTGsyHFgwhyCXVYNsxnj0Sc9rX3zkrXabKZqZWtPi67hIYDtYGo?=
 =?us-ascii?Q?4MXJtOqPbNuuvnoqYu3KJut1dFwijtcb2tw4Ls/5agRKFjiwNXWdoIXZ7538?=
 =?us-ascii?Q?ZRP2n1ZQQ7hHBLPaCJGwwrlyOsH6+btD1+vvTOxzpYQnpmU55s/i0ab/r7Yw?=
 =?us-ascii?Q?an2i1bh6wsy9pbtzNJiyRKd6z4wp1RZw9tiNYrmZvWWSyeKDSo1eefweuUe0?=
 =?us-ascii?Q?zlc76POPCpD0mJ4RgKuFCFIJuKybB6AIAWQi+QvCmtJJBpqxprq8vauurDiF?=
 =?us-ascii?Q?naa4ppmUyufv7gYeEtQqLtWQ5z7VpHBrWu0DJLawMZ/raeWXRiyIp0VazBlW?=
 =?us-ascii?Q?7uie7RllrRrwr1t8X5c3+Dpt+KqeTFxv355j7CyRp3im6oEB4MwIq1yQKNf1?=
 =?us-ascii?Q?CyxFuxtyxpLoByliRrqGDqB0miMjTZRsV5bF1sZ1flzHlzrgyAf7A=3D=3D?=
X-Microsoft-Antispam-Message-Info: WmsiX/e9t7ZqgNY9gL0St7DdJcQXf/GpS4F3x0BjBicOpqskmcdc8y5WXTEeoHwHwo1pfh78rF4sfN2Tc5VoTUxvRBtP9Ia9Eg/KS2hNXd44iAHxZrVjB7JkuKbhK2BWqEIwCx5v22te4Vhmlx6BeH0mDbRUmqwmxme9chpAiFMFyBkUj3SQd3E38dYrn3zl9tYyUJjFgJn2UJy6HJKh+w+PD0bmEIKVL68e5L7lykCZ4vcxLUMgKYTd9Rnihy7zYaC4jyCwC3ADVighOYvfFXFUELnRRTXi3oTEts9+MD2/g+SEbcujyZ1WllQqiisCUME+uBVz7UXEa+tcA7OXXIrEDgqOqrzMApOcxagi8OE=
X-Microsoft-Exchange-Diagnostics: 1;BY2PR19MB0389;6:pJtgNaFa48NzxTkSF9ZZC4EIRbaZ08WKhPJPdjc7DTU92yfxPsRl3RYpQEJ7EI7eO/+nQ4MU5nGj5J2uxl8D0uPkasMCWNjxtxO+ZtDaS18fTWGehcMKejTNKKhImBufYdLnq9FK1ATw27n94xRGMmUKk1L2mVatxUYUzKbo8gRb07rBJ6Wh01V6VixodVdGudjOgXF+Nk81EszZ19V2NGBfkSdWRmJApGFetJHeinH1tD4SjUxgYV/z0F8OmDbIiA4UJpw1K+Yi6+L3mu7khP25Gz66mlBUQQKKRrnrFmZ0Gm4GBeH0DFVoDNMWjqfdGSsrpLzhrPSAzO/r4O1TH17EYdQNDwUzGZ2LzwKoZgdz/1Zvre8agOmUnmBRxYjWaNOZxpuvuFr3oZ5lRCDKUZaHHMryZM9L662JvgW2HAQtLUYLO8r1f9OPg0gLtdFzBLjRRcNWO1NvuaAS4jAvxw==;5:W329h6LY5Y92jT2gHfNBA01J3N6HuMZjvoeZI4Vu+Pmoh6LrPVK21LpIONr9sylAOs5wN9NLEsOEd3IWxb/V/Pwke6/o9lmjEcJJUxJSppNeiDYfbJDoAxTqTw3hcieCg4GwXoFzQjaSdfInA71hR8WxSKyCYxIM/a1vW1DlN7M=;7:CXhoyUzF7EpXBTnnccR8Yj4LI7z40qx6fb4OxCcXf89F5jWXDGPQFfE5InmDwMDKL074qc2HcYDGmED3nCFERfa1CtFY9mtZVi5xa7Zc/b4FvENOx/hLKM3UrdR+7QIl5jDi3jrQnxnmknVE1KHXfw==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2018 07:33:28.1331
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1ca6188-2319-44e4-24a7-08d65b4d1dc8
X-MS-Exchange-CrossTenant-Id: 5afe0b00-7697-4969-b663-5eab37d5f47e
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5afe0b00-7697-4969-b663-5eab37d5f47e;Ip=[208.19.99.221];Helo=[AUSMBX1.microsemi.net]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR19MB0389
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
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/ntb/hw/mscc/ntb_hw_switchtec.c | 9 +++++++--
 include/linux/switchtec.h              | 6 +++++-
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
index 9916bc5..f6f0035 100644
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
+	iowrite32(xlate_pos | (lower_32_bits(size) & 0xFFFFF000),
+		  &ctl->bar_entry[bar].win_size);
+	iowrite32(upper_32_bits(size), &ctl->bar_ext_entry[bar].win_size);
 	iowrite64(sndev->self_partition | addr,
 		  &ctl->bar_entry[bar].xlate_addr);
 }
@@ -1053,7 +1056,9 @@ static int crosslink_setup_mws(struct switchtec_ntb *sndev, int ntb_lut_idx,
 		ctl_val |= NTB_CTRL_BAR_DIR_WIN_EN;
 
 		iowrite32(ctl_val, &ctl->bar_entry[bar].ctl);
-		iowrite32(xlate_pos | size, &ctl->bar_entry[bar].win_size);
+		iowrite32(xlate_pos | (lower_32_bits(size) & 0xFFFFF000),
+			  &ctl->bar_entry[bar].win_size);
+		iowrite32(upper_32_bits(size), &ctl->bar_ext_entry[bar].win_size);
 		iowrite64(sndev->peer_partition | addr,
 			  &ctl->bar_entry[bar].xlate_addr);
 	}
diff --git a/include/linux/switchtec.h b/include/linux/switchtec.h
index 623719c9..64aa25e 100644
--- a/include/linux/switchtec.h
+++ b/include/linux/switchtec.h
@@ -243,7 +243,11 @@ struct ntb_ctrl_regs {
 		u32 win_size;
 		u64 xlate_addr;
 	} bar_entry[6];
-	u32 reserved2[216];
+	struct {
+		u32 win_size;
+		u32 reserved[3];
+	} bar_ext_entry[6];
+	u32 reserved2[192];
 	u32 req_id_table[512];
 	u32 reserved3[256];
 	u64 lut_entry[512];
-- 
2.7.4

