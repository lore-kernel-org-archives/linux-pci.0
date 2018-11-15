Return-Path: <SRS0=ulVR=N2=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=DATE_IN_PAST_03_06,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E37FDC43441
	for <linux-pci@archiver.kernel.org>; Thu, 15 Nov 2018 03:16:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2190214F1
	for <linux-pci@archiver.kernel.org>; Thu, 15 Nov 2018 03:16:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2190214F1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbeKONWe (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 15 Nov 2018 08:22:34 -0500
Received: from mail-eopbgr710066.outbound.protection.outlook.com ([40.107.71.66]:6113
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727341AbeKONWd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 15 Nov 2018 08:22:33 -0500
Received: from DM5PR19CA0010.namprd19.prod.outlook.com (2603:10b6:3:151::20)
 by SN2PR19MB0735.namprd19.prod.outlook.com (2603:10b6:804:29::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1294.26; Thu, 15 Nov
 2018 03:16:29 +0000
Received: from BL2FFO11FD006.protection.gbl (2a01:111:f400:7c09::168) by
 DM5PR19CA0010.outlook.office365.com (2603:10b6:3:151::20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1339.21 via Frontend Transport; Thu, 15 Nov 2018 03:16:29 +0000
Authentication-Results: spf=softfail (sender IP is 208.19.100.22)
 smtp.mailfrom=microchip.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=microchip.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 microchip.com discourages use of 208.19.100.22 as permitted sender)
Received: from AVMBX2.microsemi.net (208.19.100.22) by
 BL2FFO11FD006.mail.protection.outlook.com (10.173.161.2) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.1339.12 via Frontend Transport; Thu, 15 Nov 2018 03:16:29 +0000
Received: from AVMBX3.microsemi.net (10.100.34.33) by AVMBX2.microsemi.net
 (10.100.34.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1531.3; Wed, 14 Nov
 2018 18:46:14 -0800
Received: from server1.microsemi.net (10.188.116.185) by avmbx3.microsemi.net
 (10.100.34.33) with Microsoft SMTP Server id 15.1.1531.3 via Frontend
 Transport; Wed, 14 Nov 2018 18:46:12 -0800
From:   Wesley Sheng <wesley.sheng@microchip.com>
To:     <kurt.schwemmer@microsemi.com>, <logang@deltatee.com>,
        <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <wesleyshenggit@sina.com>, <wesley.sheng@microchip.com>
Subject: [PATCH 4/5] switchtec: Improve MRPC efficiency by leveraging write combining
Date:   Thu, 15 Nov 2018 17:44:03 +0800
Message-ID: <1542275044-10970-5-git-send-email-wesley.sheng@microchip.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1542275044-10970-1-git-send-email-wesley.sheng@microchip.com>
References: <1542275044-10970-1-git-send-email-wesley.sheng@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-Matching-Connectors: 131867253894595531;(5a93feec-e11d-4f7b-166a-08d09f1f276b);()
X-Forefront-Antispam-Report: CIP:208.19.100.22;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(346002)(396003)(376002)(39860400002)(2980300002)(199004)(189003)(8936002)(2201001)(68736007)(14444005)(6666004)(305945005)(2906002)(498600001)(107886003)(4326008)(8676002)(48376002)(50466002)(53416004)(356004)(105596002)(81156014)(81166006)(106466001)(36756003)(5660300001)(53936002)(50226002)(450100002)(76176011)(47776003)(44832011)(51416003)(86362001)(16586007)(2616005)(316002)(446003)(476003)(11346002)(69596002)(126002)(336012)(26005)(54906003)(110136005)(486006)(77096007)(97736004);DIR:OUT;SFP:1101;SCL:1;SRVR:SN2PR19MB0735;H:AVMBX2.microsemi.net;FPR:;SPF:SoftFail;LANG:en;PTR:InfoDomainNonexistent;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2FFO11FD006;1:L4Wj8xShy8vT9Fnk+Ozw5u4NpZSGoOOmo67WMgNk+YgIgEWKi4Ziy39rozrcLq0s0wKG5iFOYU2BGe6ctXw2RNO3SVcvTwl/ylH3lVE0H3WkWeCi2M/0WnAKrEX3L1O/
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9e74a889-0b8d-48bb-b1c6-08d64aa8bc48
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(5600074)(711020)(2017052603328);SRVR:SN2PR19MB0735;
X-Microsoft-Exchange-Diagnostics: 1;SN2PR19MB0735;3:aKpxvuLkjhyhxKy9gHMNz19TsSgKN/4jijHxYF27VYkz8v/js5ME5vgPxYggf9LZUKl9lG8lcE4evToc+BvNi/oJ+WnxT9rGxFhrJ+KEXhDhN3jgBLnu7Xf7K9A9BIXt+kfy+rhRxSvPzxwyoG7oSyOCjk6s7NRZoNyUX/en25JBicgLvLZvDfJYEs1fHJljlwyV/pt6ajsa8p60F9Oe8AHTS9sjgX7vNfFU03AHI+JGLpSiPBZKhi9A9SAq6ZQVg+dQz2YDYjoPOiGUfhn3Vsb7mUAsQWThCaS0XTZutPkv0f17lpjMbeE6NcoWCFKA4IxyKYr54z9IEVgKd4ED2gInXKj536CFqe2oAwaDHj4=;25:Q2d3pc/jqRfN+5flv5VrVogYq66KZ3/wQ9llfM7JczL71pWygagLkI8O2HjsoeAckXL+xTNrlygj89+VzSctMvrRvZb9GrVq5o9/eQgB0CCjbMIWPWAWttVddNcNTQ2y7HizAPFhWrmQSNErJ9hssZFmZAbiFxonpDdF37BbnvGMVSS+VPtlNShOV3ItMNTNEUNVS9ABOuk2IoKJ71G3AC6n6o4JUKY4Dq2pDt6rMCF7E7vSapot318F3+ghrzzczRJCLri3W8kZGaP0rAIF8qXppzKzytZg0mkAWV6z0FptnvVCdTcF6YVUFAwbmkt78aOxpwbeiYGrWS12UNr7WQ==
X-MS-TrafficTypeDiagnostic: SN2PR19MB0735:
X-Microsoft-Exchange-Diagnostics: 1;SN2PR19MB0735;31:cCVvEQxoOVKTY3etDU2i50VUUo8oy5OosFQqUuikyi2Y2cVShZIff9n4MHnbWeymohx8ttMnhOlFKQjSehEzFdVIrMSlB1zCoWdx2+LmF4yV1nMjqTzEuzQHoksYjvDJR4KdTMMK0Eruy/XRGe+qHNGVOaYs3YR8TJ3OmxS9OndvVmNFog5Ca2+YsrwQQ0LfU3XlwgRF9QoOlf4LA6W7rK0ikgY6GOAds4p8YLMe4qo=;4:wZeF/Ffrbs5B25u2R9qiLzTx2MCYq8auMF5mLZ+nUsQILEUG52XJYjRjw9Sr0OWXpbwtgop+Ii2Wj7KQYemwi1+4X9XAfGXcVAbClX6o7tddrqqnW9ACxpxb4LQf7lgI1ksgYSntwbNPulaPCdnABf36lkyFORaaPsP2tBhe2BHWdzlotc+z4t+hokmGxdr5a1+i+5jl4RgHw1VDQyoRTX8HRR5SKL5gPWHL17G8oNEFt6NSMp9MFdnc02+ZwZTgH87j/zf2EBMFyCMZaRnTlw==
X-Microsoft-Antispam-PRVS: <SN2PR19MB07358A3203E80806479146F795DC0@SN2PR19MB0735.namprd19.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6095135)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231415)(944501410)(52105112)(3002001)(10201501046)(6055026)(148016)(6096035)(20161123565025)(201703131430075)(201703131448075)(201703131433075)(201703151042153)(20161123561025)(20161123563025)(20161123559100)(20161123556025)(201708071742011)(7699051)(76991095);SRVR:SN2PR19MB0735;BCL:0;PCL:0;RULEID:(400006);SRVR:SN2PR19MB0735;
X-Forefront-PRVS: 08572BD77F
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN2PR19MB0735;23:g95BZ6n1sW0QpA8vZB/a1llD4T3k1GTYkv+HedDm9?=
 =?us-ascii?Q?0hYore0KvP6KA0rxTd0TZBhQTfaRk3fSpdoKSnqaV91S7Ba1748LYg389zEl?=
 =?us-ascii?Q?Ws/Al+eTwDZ5ky1vVzz7D55hAD56Fv7qIrEtAhmtyCEaHCZKx1cYdcpj44Ne?=
 =?us-ascii?Q?X9AQqw4Z6bEweBDVxbJblPjn+SWoj8Jnke9SNEIK8E4WZaH8uR/Tl3h4iTLp?=
 =?us-ascii?Q?2K9ifrMZY2aeeKSofNy04aAen6sgsXB7RK/tZTC+NUuc7u6H4TxaVIPqDqgE?=
 =?us-ascii?Q?cSXqOuRRiG4FlY1I+rKgrewnIyt2YH5dkAPIWhl78y50aIK4E6Qrcf5P9qNu?=
 =?us-ascii?Q?T+oCVxlPpQxToG9L8QWk45iNxt8+YSx6AUl29hTyX3K8u2Enr1nfccJsaGrD?=
 =?us-ascii?Q?3kRsQO5zB+WlGl4OhxTLhJ8++X33tOZ8lQsOpTwF/zqa3xj1RiEilC7L3mHR?=
 =?us-ascii?Q?BDU/4KM31XCmdWTGDh3DrGA6BTNRNkEVNbktfJmdGB0sOBOqnYEZhHDEQehs?=
 =?us-ascii?Q?wLjUD3CRP8EY3QNt6e2csYFjJugzF+djL7R8sM/g19joE/HMz0XUujYIzdis?=
 =?us-ascii?Q?6B1cA4ZxZHiZ1HDlOXcsNwxSEmItBfAnpGZ4AnoSDJb1O0yYxBWmFltr8ne9?=
 =?us-ascii?Q?cya1hiIkitZOfMkcCwvHuB7K9zZn4IbGWmR1AthhUYVPe5N3Q/5+J9AuyROH?=
 =?us-ascii?Q?js78hY9wyoohtiTmxNBSqbw4I/Tm2c/PqKvOGSIf374izdd1B2iXCCil/I8F?=
 =?us-ascii?Q?m8pi+wjhXdTVlnWFXAEoFZ+XVmlSk5wc52ZGJ9wI8LVGNGipT/sQSu94xpIr?=
 =?us-ascii?Q?hUzP1hkDQu4T0pPhTYVdJnOlx+681d7MMrRCqaJyh587UhGWlE5Upi5VIfwr?=
 =?us-ascii?Q?nXzDniSnwID2ngOkXjQrhNBeIE3P48VQvl1j/PQ+CsjhZj20H/Ei2+TUUvNy?=
 =?us-ascii?Q?8YjaymO7/rIKmVdQUAhbpHWyjTRJnpZ4zlvXxaUMkH+Lwci43UyMZmWOcUlH?=
 =?us-ascii?Q?QBSbc0tKzy290L6Sn4BmKt9ARYZxqXlMiA7YGjmfponl8YOM0w1BDnKHiy6X?=
 =?us-ascii?Q?mPNV3ARNkc9b+kj3Z8scPCgCLm1Z7nwp1+jeEQeqb0lY6lgLQy0dMOGnsSPz?=
 =?us-ascii?Q?egA/NX7YgoqbIi2vUOKuB4Hef6WJb9XvwvU7XQiPI9x2x8wa4vCSg=3D=3D?=
X-Microsoft-Antispam-Message-Info: terhj50CKD2wPGYx47Qr+jK271S9mwGPCGc3lQLZpFcHwWIY16NYYlkLTVvjmWQ0jAgx1eQzUR96ydfBgXHSWa9uSo0t8edwGRlpUkQoiUMmnjYBIayZNNAZ2bnDlnMzBufHy55c+WBTX78ph5Q/wOcV6gcwwg6zJnUWgnHGVKXcmnh5U6DeL/YFvbuYXBs7+FxfC3Fa7sjtYwFwgXJMsZqJPuHxCnpZsK/M1V3VkPMz76Mw5hwlGgiGpfjKQ97bhH5/ckNm1HTTiINk6aokkfoICa/YmR/xVKErtGs4G73WAcf0VPDMSzT68cgI+eg8NHmUrFJM8iud9PXMRjxHzY1HNIaC+VaPA6OEWkZ4R08=
X-Microsoft-Exchange-Diagnostics: 1;SN2PR19MB0735;6:mZFanitg5489gM1jbY9xthfbEUmeyhv3EjBwuWwJlgx4OgHatndO7vb08bWUTI9Fu3zF9xxbv/CLh1Nh7EGjSkvxnNouI695hhZTWgkp2ubBeypkt4CLQszuMEFlpkm2uv/aIerCTEktD8log4YmcJWF4K3Iy2A1q5ckb/ASXujTr9OQxEcb/AtDBWDFhM5JP76bPP5A/fDFH4H6kz5X8lIM80WUIToKOJmINs/9XxIXKeaUy+fJf+Y1LZPNKE2on574dLwjt1FWPcdCIPI/5zWJea1yz17uWTgxQcC2jDWeSDPbAoklPMzqv29+GPTD5nOkgb1PkOFdbG4CbZC/Rk+6xV3aEJcd+7cT42mcXEj8YM2T6PHgShaArHIshLYsVWqWoxSyR6hm8mFNOWYuZg/L3YYp2mfKS/aVJtlh483qD2fY5lHwakgBQLNOcFiI+L+M6F0ZfGg6v7kXcL20Aw==;5:fxPvmoXtcNeKUq+WPP+7d/Ws7+/AXAct4128hQprJJCxE6emVpQ5+psRx/RS2U9nB3jjtTH3NXWb7mBHgoIuuZEDEAIYqJ9Sr0i819XWK2Ah2HB9umGJyMgMqZ9vB0EMsuVqohmj8vWNO1oOWRI8WBnIUGsBpXj2d3UUZQ8Nshc=;7:UXlcUj+/2KJ8dcJcJjf1Uu4aCawodJ22QvQjNoxLPAzTf+2v/9yDWGR8BfVF196iHfrmaFIOS/qlGG2alT951PojuiFUXXnNJrgRko/MVelcsbIgmwGfOdYyvzcyhK5JyX+FGI6a78UP/Fqb7r9few==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2018 03:16:29.1939
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e74a889-0b8d-48bb-b1c6-08d64aa8bc48
X-MS-Exchange-CrossTenant-Id: 5afe0b00-7697-4969-b663-5eab37d5f47e
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5afe0b00-7697-4969-b663-5eab37d5f47e;Ip=[208.19.100.22];Helo=[AVMBX2.microsemi.net]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN2PR19MB0735
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Kelvin Cao <kelvin.cao@microchip.com>

MRPC Input buffer is mostly memory without any side effects, thus we can
improve the access time by enabling write combining on only this region of
the BAR.

In a few places, we still need to flush the WC buffer. To do this, we
simply read from the Outbound Doorbell register seeing reads to this
register are processed by low latency hardware.

Signed-off-by: Kelvin Cao <kelvin.cao@microchip.com>
Signed-off-by: Wesley Sheng <wesley.sheng@microchip.com>
---
 drivers/pci/switch/switchtec.c | 41 +++++++++++++++++++++++++++++++++++------
 1 file changed, 35 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/switch/switchtec.c b/drivers/pci/switch/switchtec.c
index a908670..0b8862b 100644
--- a/drivers/pci/switch/switchtec.c
+++ b/drivers/pci/switch/switchtec.c
@@ -113,6 +113,19 @@ static void stuser_set_state(struct switchtec_user *stuser,
 
 static void mrpc_complete_cmd(struct switchtec_dev *stdev);
 
+static void flush_wc_buf(struct switchtec_dev *stdev)
+{
+	struct ntb_dbmsg_regs __iomem *mmio_dbmsg;
+
+	/*
+	 * odb (outbound doorbell) register is processed by low latency
+	 * hardware and w/o side effect
+	 */
+	mmio_dbmsg = (void __iomem *)stdev->mmio_ntb +
+		SWITCHTEC_NTB_REG_DBMSG_OFFSET;
+	ioread32(&mmio_dbmsg->odb);
+}
+
 static void mrpc_cmd_submit(struct switchtec_dev *stdev)
 {
 	/* requires the mrpc_mutex to already be held when called */
@@ -132,6 +145,7 @@ static void mrpc_cmd_submit(struct switchtec_dev *stdev)
 	stdev->mrpc_busy = 1;
 	memcpy_toio(&stdev->mmio_mrpc->input_data,
 		    stuser->data, stuser->data_len);
+	flush_wc_buf(stdev);
 	iowrite32(stuser->cmd, &stdev->mmio_mrpc->cmd);
 
 	schedule_delayed_work(&stdev->mrpc_timeout,
@@ -1231,23 +1245,38 @@ static int switchtec_init_pci(struct switchtec_dev *stdev,
 			      struct pci_dev *pdev)
 {
 	int rc;
+	void __iomem *map;
+	unsigned long res_start, res_len;
 
 	rc = pcim_enable_device(pdev);
 	if (rc)
 		return rc;
 
-	rc = pcim_iomap_regions(pdev, 0x1, KBUILD_MODNAME);
-	if (rc)
-		return rc;
-
 	rc = dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(64));
 	if (rc)
 		return rc;
 
 	pci_set_master(pdev);
 
-	stdev->mmio = pcim_iomap_table(pdev)[0];
-	stdev->mmio_mrpc = stdev->mmio + SWITCHTEC_GAS_MRPC_OFFSET;
+	res_start = pci_resource_start(pdev, 0);
+	res_len = pci_resource_len(pdev, 0);
+
+	if (!devm_request_mem_region(&pdev->dev, res_start,
+				     res_len, KBUILD_MODNAME))
+		return -EBUSY;
+
+	stdev->mmio_mrpc = devm_ioremap_wc(&pdev->dev, res_start,
+					   SWITCHTEC_GAS_TOP_CFG_OFFSET);
+	if (!stdev->mmio_mrpc)
+		return -ENOMEM;
+
+	map = devm_ioremap(&pdev->dev,
+			   res_start + SWITCHTEC_GAS_TOP_CFG_OFFSET,
+			   res_len - SWITCHTEC_GAS_TOP_CFG_OFFSET);
+	if (!map)
+		return -ENOMEM;
+
+	stdev->mmio = map - SWITCHTEC_GAS_TOP_CFG_OFFSET;
 	stdev->mmio_sw_event = stdev->mmio + SWITCHTEC_GAS_SW_EVENT_OFFSET;
 	stdev->mmio_sys_info = stdev->mmio + SWITCHTEC_GAS_SYS_INFO_OFFSET;
 	stdev->mmio_flash_info = stdev->mmio + SWITCHTEC_GAS_FLASH_INFO_OFFSET;
-- 
2.7.4

