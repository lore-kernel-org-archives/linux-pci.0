Return-Path: <SRS0=6KXC=OT=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DATE_IN_FUTURE_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCA48C07E85
	for <linux-pci@archiver.kernel.org>; Mon, 10 Dec 2018 02:44:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6D5E20865
	for <linux-pci@archiver.kernel.org>; Mon, 10 Dec 2018 02:44:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6D5E20865
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726447AbeLJCod (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sun, 9 Dec 2018 21:44:33 -0500
Received: from mail-eopbgr820081.outbound.protection.outlook.com ([40.107.82.81]:2273
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726395AbeLJCod (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 9 Dec 2018 21:44:33 -0500
Received: from DM5PR19CA0008.namprd19.prod.outlook.com (2603:10b6:3:151::18)
 by DM5PR1901MB2007.namprd19.prod.outlook.com (2603:10b6:4:a6::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1404.21; Mon, 10 Dec
 2018 02:44:31 +0000
Received: from BY2FFO11FD028.protection.gbl (2a01:111:f400:7c0c::140) by
 DM5PR19CA0008.outlook.office365.com (2603:10b6:3:151::18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1404.17 via Frontend Transport; Mon, 10 Dec 2018 02:44:31 +0000
Authentication-Results: spf=softfail (sender IP is 208.19.99.221)
 smtp.mailfrom=microchip.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=microchip.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 microchip.com discourages use of 208.19.99.221 as permitted sender)
Received: from AUSMBX1.microsemi.net (208.19.99.221) by
 BY2FFO11FD028.mail.protection.outlook.com (10.1.15.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.1404.13 via Frontend Transport; Mon, 10 Dec 2018 02:44:31 +0000
Received: from AUSMBX3.microsemi.net (10.201.34.33) by AUSMBX1.microsemi.net
 (10.201.34.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1531.3; Sun, 9 Dec 2018
 20:14:24 -0600
Received: from server1.microsemi.net (10.188.116.209) by ausmbx3.microsemi.net
 (10.201.34.33) with Microsoft SMTP Server id 15.1.1531.3 via Frontend
 Transport; Sun, 9 Dec 2018 20:14:22 -0600
From:   Wesley Sheng <wesley.sheng@microchip.com>
To:     <kurt.schwemmer@microsemi.com>, <logang@deltatee.com>,
        <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <wesleyshenggit@sina.com>, <wesley.sheng@microchip.com>
Subject: [PATCH 2/5] switchtec: Set DMA coherent mask in Switchtec driver
Date:   Mon, 10 Dec 2018 17:12:21 +0800
Message-ID: <1544433144-7563-3-git-send-email-wesley.sheng@microchip.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544433144-7563-1-git-send-email-wesley.sheng@microchip.com>
References: <1544433144-7563-1-git-send-email-wesley.sheng@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-Matching-Connectors: 131888834712196847;(5a93feec-e11d-4f7b-166a-08d09f1f276b);()
X-Forefront-Antispam-Report: CIP:208.19.99.221;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(136003)(376002)(396003)(346002)(2980300002)(189003)(199004)(69596002)(26005)(476003)(486006)(450100002)(126002)(305945005)(81156014)(81166006)(8676002)(50466002)(44832011)(50226002)(11346002)(86362001)(5660300001)(8936002)(36756003)(77096007)(48376002)(2616005)(2201001)(446003)(16586007)(51416003)(316002)(54906003)(110136005)(356004)(105596002)(106466001)(53936002)(68736007)(76176011)(2906002)(107886003)(47776003)(97736004)(336012)(4326008)(53416004)(498600001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR1901MB2007;H:AUSMBX1.microsemi.net;FPR:;SPF:SoftFail;LANG:en;PTR:InfoDomainNonexistent;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BY2FFO11FD028;1:zt5ehEm8pidLd07fXSEKgpvvZwRAShG84aNNoI+ts3hztwdcqCPw+ZOJ5aqe74qr6Qe8WWiJONY0s8WFXtcukz4txaVkDg6XOAE6BQmXhNMAUUhu0uA20eoQG/XDYNV/
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f1d63412-8838-47ab-56ef-08d65e496953
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(5600074)(711020)(2017052603328);SRVR:DM5PR1901MB2007;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR1901MB2007;3:Nk1t1U3DRnhb0uKxkjX7Pvw1rCbrUcb9OPl5SINseU4ifPE3LlUfdRrF09LxkBpOhfyFZUfEO82GWNpIceZnUMDQ8vcP47VMI9NODG3NFPsDZIVGsZFmAXWAOcQE/wXCWZqNtkyW8WTUkNvx/bYNxaeCnucwVKIFWsEsUUYpp8yW71F191J2mA9BtpiTvdfXXk2tbmpgJRxoGfItm3KeAYgxVbtfmml03kevEiuS8QTzl6exbiGPyA2ticCo1bUzjk9Qengr3CZP1E3lUuqCHIiVuUhxz5y1Mkd+EKG/tTiCrB3/aYhtVVWqUo9dvfmfB7Z/igO0ut5Ks3Ve62GgEDQ/OG7piyRpdrT7QBujrxY=;25:O3wW+1Q+BTb8GUyuVUaPa/X4x5vI8fThieKjckJNQZHVJLugLTyHKH3HLmJfOcIkwYRYd70cNZVNAYNpQklwpDqv8EXguC09OlYFWb4lXfC+ryrohC67UBtQ9bkXLKb3yHJyBth3j4F5X1EugK8Le94FGt7HBbU00HfdKORyyHOM7wtKDcJEat5zMaN0sCYguOCjIY1zTaxNtWBzgfoGINg5Sw4CmCadezhtO8gwJaq4jSzSLwVN6bqolcwZ2CfNoxsjXDGxiSdUEXTC7Z+NzkG8XoVWk3Rs+gLCLkhZ/q11bUrNV+ALfwbH5VZaC9cF8Lq6LGzsq6W/utqqQy/kqw==
X-MS-TrafficTypeDiagnostic: DM5PR1901MB2007:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR1901MB2007;31:ujgk1ycgrzgLaFRUbxokaDAQBUFyT/jrRQvbDZAHTRh+EVlvQrJNlZhcLE0y4AcT33LhT0NV3bkTPvo44SmzW2cpJiULlnorT91vF1onYr5lHnOs7guU9my+loht4R0qG1I6vgwWt+7lMITQo//oXSVn0E5gzehHStdZZcpaqGFIXrX668/2+pzfLduSDEY/0wz4yvcTlu78cYEmFoUd3PsjCZhX3kUAtLu3mOkiNdQ=;4:OVZ0LME4BVU33tKGfm3riX7p0w5IKmTMy4UMO3/z1voDXWgjUGoDgDKfwJVOwgANPt2saO9FSmS5Vm2hhV6BBDiIIJU36gg+xtTsHgQV3GB+TBPEedRUyT1i3uV9jJorXVZnRpsMykl0ghDSEeT66mLt2TCwcYvP8GcqXs1zxMftGxiFXAgyKqoPq9RoTVmJk8Z3nMfpzVLJ0iDHvcS58uPuAuiW40xx8YitxMz4xUHYugpsmKWimTOCFCG/dTzwKzYCTend90s/4RtqRu9cdQ==
X-Microsoft-Antispam-PRVS: <DM5PR1901MB20073BC4BADB4B2BBC5BB5A395A50@DM5PR1901MB2007.namprd19.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(3230017)(999002)(6095135)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231472)(944501520)(52105112)(6055026)(148016)(6096035)(20161123556025)(20161123565025)(20161123563025)(20161123559100)(201703131430075)(201703131448075)(201703131433075)(201703151042153)(20161123561025)(201708071742011)(7699051)(76991095);SRVR:DM5PR1901MB2007;BCL:0;PCL:0;RULEID:(400006);SRVR:DM5PR1901MB2007;
X-Forefront-PRVS: 08828D20BC
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR1901MB2007;23:56vz6k6zCdO2f3+z/vTDVGUcuVukGHI/ZCnH8BK?=
 =?us-ascii?Q?2df0WuSIga2rVIb1u1xyhsiqGq1cJvMo104ZbBovBV8udRRq7bfDf7k+jgpP?=
 =?us-ascii?Q?Ltrk+oDgVukt6VYExv2776+W3ujbrx2gMQ5DOMhLfqU9eWtSastx762YdUJS?=
 =?us-ascii?Q?Mqhx/KmM2s4bUCHqjUHVOt80trfT5ClMlXz8qgYGYy1/wd6qQp663muOK73S?=
 =?us-ascii?Q?LWXN7oKMDX4JnPkv6DFGbTNSgxQvPzujmNvoca2664ZEkxMTYnUnG2tPxtOT?=
 =?us-ascii?Q?LKsZZ77RXvDqNEPuVF/ZYPhKnesc2ufFHBfcplKqiJ6mVi8HYIhqNcWA9znj?=
 =?us-ascii?Q?TD/bOPD17amK0htTl5Ot4emj9+TvMVeJyyCWhIeN9W4o847YXW9q8X5AoBSK?=
 =?us-ascii?Q?IuUC85uZLRHDuhlToomUpWDrUWb2OkSMaLTuIpOeejUeuhrv+ZrvFjfgNtUW?=
 =?us-ascii?Q?5QacmKkduViuontAdpOwhbK7SsZOetE0zRXfuVFv64uZtfua2P8q7Ev/Q6N7?=
 =?us-ascii?Q?MBugLBd/AD3thVUbhfOJZZ8/op+7+SsRWK1xaUmLd5Sl0WUwolCrqnRnaPva?=
 =?us-ascii?Q?TptAXpy+RCyKd2X64U8orbOq0M84RduS8LyInnwpaVA6tyqMdGTXcK+I1r8Z?=
 =?us-ascii?Q?NL4lsuL9CPG4RY70/NyuoM9AKT17dHJgxCpeS1nhKZFdZFBx7NsbfOE49UFy?=
 =?us-ascii?Q?ZlqESDYZ5F1/EP3Jm83Wyy+TWSdRxGYiTZoqHo1i8yZxgOrMFHXT7kdyOZC7?=
 =?us-ascii?Q?3OVHwULUca6Aq67h++QepPgAvHWgckGO5fV1mBGHiafutBxieKhd3MBwQ4Rl?=
 =?us-ascii?Q?stuGCOokdIAkrf5h5QgGJrCPUN9V/QOVoD04glCzKzJ37pOYNkbowGqNon5t?=
 =?us-ascii?Q?Dh6xl+JsfsQSI1wSfZnTthJlttbh/O4ntVmiWTZ3Em598l2YuZtta14wUBgt?=
 =?us-ascii?Q?z6soEdwGAI1CmyA4frFaruxkVPAikE9fNCFORy3a55bbGcti76iK5bVjgWEm?=
 =?us-ascii?Q?d7BtBmgAQ0wezIFCBZE04hg/E2D+GFbH9mHN6Dfv0Ka5DwA70h+hXXfp37r6?=
 =?us-ascii?Q?VSIaiMe0cakTwEqiGAp25bjjLkx87scqr5L5t5Tb4mwghHt/mDuZlJnSkNBV?=
 =?us-ascii?Q?6oHMDUQFVO3LxXakc1az3ZnUYc6TVFXC5?=
X-Microsoft-Antispam-Message-Info: OI2DrL49Td0rmDXKH/xXbWiJu4/T+fsJxMRRmfANQnk292w/JeXvcOF6skAWc7qnMm6WF0pxOzWUjZBz7heDWoxfL1eKKLlUX/hW6EAdW3iX0T+n3VJ9BgUibJtUJoj5bxsygDfz/2a1oDDzyNdG5y01UPOxNz+0t4Pny6+zQ+ajXSe6td3HnyLIyBNpXP9eBrUn3zQscCkJgtdtmd1lYSD6ZMabdb5dmRuDtIa7iZ7R/3SmTYu70AHuar76Xj0V9GGHRx7ffq+N0F9OgwmSUIxVyHisnlDCv707iQEQCXaOTaftWx6dQ50Q1lAKoxCK
X-Microsoft-Exchange-Diagnostics: 1;DM5PR1901MB2007;6:ji/4NQJJzAPHz9Ym+H+575VpPgguaknOfULPc0/yBqc1Xg3InJnFlsNH3tBi+kZhnz7AULhAjpHnd5pJ4S0tWqs2TM4evlz7r/tQmFBKUjiqGBgGLHcorUpGWIIoVodr7aQ82w7UDH9akEaokr8QyA06PpvbZHgjsJIev0fX9EDFXbrglnGVoD8NWZSaGJK+1Ac/li5Pi70W81C19K/wBY98YnFNpuOZz9rPhuw9ZDVPPZleYXd4pMvu+FxNwdzVYqUlCEAC9YkY5ChpQSkkOlcovS97NHtl+WX8YneshD4sz65yAG5xSXAlVo9c+UCicuFto3Y9LIEs7K6t9wj5jOUfaQoU5jI1IuWxJm/Qe/T3IV1qdqiditg4NQ0WuRmLRONiGnryyayLaGdIJFz5dCuzFNvQuQc2wn+QEi1Gz3y9NfwVJZNWV6EAeDG4edKK8eLqAdWjk8Iw6EHrClhQZw==;5:iuS1rsGpyG2ULrfmntwyhNSR+0j+01seA2zx6KLQJmIZ4IdNN+vZZ/NQZ9fSQL8WYGvfPyofGkpMcxoZa6FMHnJsVLTZ/Mz/B5KAfYSyz3CpWrBBO5y1NHqwHmOgd+7M7IJyK7G6M6RlyB+WNxJ4aoiVgtRPCjUqb6BMD8nYc2A=;7:/ANtPG7cPaxro8WMV1AbGB50ZWl/ssTjdsxyp8hZ/yblrLYUlFquz4R2EyKasRspv7h9uRUl1jG/ds+QkrWbfXDphE6Uplze8SgZrCBRAbgyy03w9WZVajJ/uYI6vJ4vFAXIou+4AIWFVnrb4qsHiQ==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2018 02:44:31.0790
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f1d63412-8838-47ab-56ef-08d65e496953
X-MS-Exchange-CrossTenant-Id: 5afe0b00-7697-4969-b663-5eab37d5f47e
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5afe0b00-7697-4969-b663-5eab37d5f47e;Ip=[208.19.99.221];Helo=[AUSMBX1.microsemi.net]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1901MB2007
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Boris Glimcher <Boris.Glimcher@emc.com>

Switchtec hardware supports 64-bit DMA, set the correct DMA mask.
This allows the CMA to allocate larger buffers for memory windows.

Signed-off-by: Boris Glimcher <Boris.Glimcher@emc.com>
Signed-off-by: Wesley Sheng <wesley.sheng@microchip.com>
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/pci/switch/switchtec.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/switch/switchtec.c b/drivers/pci/switch/switchtec.c
index d2bca2d..480107e 100644
--- a/drivers/pci/switch/switchtec.c
+++ b/drivers/pci/switch/switchtec.c
@@ -1237,6 +1237,10 @@ static int switchtec_init_pci(struct switchtec_dev *stdev,
 	if (rc)
 		return rc;
 
+	rc = dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(64));
+	if (rc)
+		return rc;
+
 	pci_set_master(pdev);
 
 	stdev->mmio = pcim_iomap_table(pdev)[0];
-- 
2.7.4

