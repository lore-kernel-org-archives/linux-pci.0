Return-Path: <SRS0=6KXC=OT=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DATE_IN_FUTURE_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83476C67838
	for <linux-pci@archiver.kernel.org>; Mon, 10 Dec 2018 02:44:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51A3A2082F
	for <linux-pci@archiver.kernel.org>; Mon, 10 Dec 2018 02:44:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51A3A2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726488AbeLJCon (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sun, 9 Dec 2018 21:44:43 -0500
Received: from mail-eopbgr750079.outbound.protection.outlook.com ([40.107.75.79]:23180
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726461AbeLJCom (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 9 Dec 2018 21:44:42 -0500
Received: from BN6PR19CA0089.namprd19.prod.outlook.com (2603:10b6:404:133::27)
 by DM5PR19MB1322.namprd19.prod.outlook.com (2603:10b6:3:bf::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1404.21; Mon, 10 Dec
 2018 02:44:40 +0000
Received: from BY2FFO11FD009.protection.gbl (2a01:111:f400:7c0c::158) by
 BN6PR19CA0089.outlook.office365.com (2603:10b6:404:133::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.19 via Frontend Transport; Mon, 10 Dec 2018 02:44:40 +0000
Authentication-Results: spf=softfail (sender IP is 208.19.99.221)
 smtp.mailfrom=microchip.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=microchip.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 microchip.com discourages use of 208.19.99.221 as permitted sender)
Received: from AUSMBX1.microsemi.net (208.19.99.221) by
 BY2FFO11FD009.mail.protection.outlook.com (10.1.14.73) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.1404.13 via Frontend Transport; Mon, 10 Dec 2018 02:44:40 +0000
Received: from AUSMBX3.microsemi.net (10.201.34.33) by AUSMBX1.microsemi.net
 (10.201.34.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1531.3; Sun, 9 Dec 2018
 20:14:31 -0600
Received: from server1.microsemi.net (10.188.116.209) by ausmbx3.microsemi.net
 (10.201.34.33) with Microsoft SMTP Server id 15.1.1531.3 via Frontend
 Transport; Sun, 9 Dec 2018 20:14:29 -0600
From:   Wesley Sheng <wesley.sheng@microchip.com>
To:     <kurt.schwemmer@microsemi.com>, <logang@deltatee.com>,
        <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <wesleyshenggit@sina.com>, <wesley.sheng@microchip.com>
Subject: [PATCH 4/5] switchtec: Improve MRPC efficiency by leveraging write combining
Date:   Mon, 10 Dec 2018 17:12:23 +0800
Message-ID: <1544433144-7563-5-git-send-email-wesley.sheng@microchip.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544433144-7563-1-git-send-email-wesley.sheng@microchip.com>
References: <1544433144-7563-1-git-send-email-wesley.sheng@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-Matching-Connectors: 131888834803174920;(5a93feec-e11d-4f7b-166a-08d09f1f276b);()
X-Forefront-Antispam-Report: CIP:208.19.99.221;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(376002)(39850400004)(136003)(346002)(2980300002)(189003)(199004)(316002)(16586007)(97736004)(110136005)(54906003)(105596002)(50226002)(50466002)(486006)(68736007)(2906002)(106466001)(44832011)(5660300001)(8936002)(36756003)(48376002)(4326008)(53936002)(51416003)(107886003)(69596002)(446003)(126002)(2616005)(476003)(14444005)(11346002)(356004)(6666004)(47776003)(336012)(2201001)(498600001)(305945005)(81156014)(81166006)(76176011)(86362001)(26005)(77096007)(8676002)(450100002)(53416004);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR19MB1322;H:AUSMBX1.microsemi.net;FPR:;SPF:SoftFail;LANG:en;PTR:InfoDomainNonexistent;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BY2FFO11FD009;1:gpe02ZTZRhFAqJsZ4NJZTl5kqe9d5ipuD81Hd5/ag0Z79iEm3yPh2r+o14VHHFNXPWIhFuPgR7AyhigW94D2IfFJetJU/j8aT10oYUe/0bCaKMRpQRUqDaDEKqUOX067
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 550812f8-a0a9-4678-a44e-08d65e496eb3
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(5600074)(711020)(2017052603328);SRVR:DM5PR19MB1322;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR19MB1322;3:DwJWBzQxt0bXtctoSMI32I/6FzWNMWYckeKPfZo/F5Zl1winhFyyjQditziuMkqp/+o5PAjLY0uhMzvrs9kwTXSajwqAHWbS0lkFvZVuXkM38dup2J+iKPOezc5fIAavUsxsXrphxMw2L2RtDlo54Y3XcQOQIx0OKE9FZ8pXHG2ZjZ31lMxGxDb09jucTtIQnQB1imInsHyzZdKd4OWAJ/i0Tra1Ka0zGA7BOVd1NZOTQVAHEW2aQF2IVVfdVLOKLrKJsuc9xefrwnqD9mMetCo6oVdBaF5nK28RrM9N4LDVQwqoepf6T8J9iIBvW2IjEShLaICH5Ee4JcOHWLUPh9Fs64VSnSYZgCKiBM7Cqt4=;25:pOoFl9jvoJ/ghRoqhJ7gku2UrrGIPUSa7c8NTdobaSFUF6+5a7E0zka0+QFVDTQb2mf+ecuFjp7VErCpfOYZUcsdBtwiZK8PV5nNbi3NyGVNTUXz7eEXUg1nSZHoGTsWkU/IGGB6jt7z8Pjh4uCKznR9Kwrk0kkiWqcfCFwjuPmgrUtSCaCRqzu0dNEut5Jx/LoLtqDbSd5LES/1qKr13wU4gIdsgyuF7G9OfPTMq/HjEHUL83boGt4H53sjyJ35hgUrcN/psgnYj0BEzNh0wWcS5FqG0/B4SG1yC62cZGDeZ58ZkYpv9sJ+p6TY+aenrX3IRJ/D4EUQ0RMIIImmQw==
X-MS-TrafficTypeDiagnostic: DM5PR19MB1322:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR19MB1322;31:nXjb+E/NoMClyN3D/PpxDJgYlCXULUvGdxEr0DBaZuceH3gX1TYlkVp7l/DgLJbhq638JJpFVvZ1+8LsSmyH7n01qt5E7rPCS+Ls4+eV4W74zHxdVS4OoXtjqSSTr1MiKZz0gzK4b7P41PNvP/sMggfcnNZ/ZgVguZ4jHBkG7i3BfSDT/lvWBdpE54/wySnlTfgHCM9r7NnqacyWfqvZb+Pb20EA6613JU3wKeGxMYc=;4:+BDyp7B9GeY4z/cPcCPx3+DOqJTllhRzpLIHzoSs0NItuhbPWFqYaJkO6cEHoL39s+VGP52GSYLJZktRW9SiYgc0gUslVahbiWdL0WVIuPtVDng6cTEAk3nsHy8Ci6ao87q4ExpslYqmlcdBemAzeILhXRGSj59JiwU8qEAQb6RtsX7PNYmqqDhNbP0Fohts3l/0NWSOan7DFsQXJs6N8timsQw12ZiyYrwXDW2KvfoSv/FImlQ6Oz/KYFxdZ6XHYoBxPOzfPj6nZAbqMROfwQ==
X-Microsoft-Antispam-PRVS: <DM5PR19MB1322E8CE59D3533EE518932995A50@DM5PR19MB1322.namprd19.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6095135)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231455)(999002)(944501520)(52105112)(6055026)(148016)(6096035)(20161123556025)(20161123561025)(20161123563025)(201703131430075)(201703131448075)(201703131433075)(201703151042153)(20161123559100)(20161123565025)(201708071742011)(7699051)(76991095);SRVR:DM5PR19MB1322;BCL:0;PCL:0;RULEID:(400006);SRVR:DM5PR19MB1322;
X-Forefront-PRVS: 08828D20BC
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR19MB1322;23:QHKFO5sygocHyqRVrdGeY7dApZQTLdOXQ1qHGhM4C?=
 =?us-ascii?Q?ssMeAO3oxDM808kbW8SZujspp/CVbvl3uUbXhUx69xEdZOHWkmbhfBPDuDuI?=
 =?us-ascii?Q?xaCviIYP1U6rI+G8T5X5VaueEb7jZ8sDPZt7URwk1gb5J0uaID3hFfvj+uSz?=
 =?us-ascii?Q?9iVjPtt47FKqoQk9yNyOm55PAD+NoXWtd7SZsDs825hi5yv7SANX1lqv38xy?=
 =?us-ascii?Q?XmI3paRtrRz+d5tQ7L6qiauIWztJkMLPnjxGwDIAaPD/+R3RA0fo7HBX9146?=
 =?us-ascii?Q?mZAoXFYTWMU09nHuYRRrd+GDhQ6+YR3AaG2Grr08KhJFhQ5FE1Wa45smgbdb?=
 =?us-ascii?Q?/cPW5SH9xh12WHkdOol5IJFzW7pegT0CZubfZKicslBGsw5RcWCHMBs9M1w9?=
 =?us-ascii?Q?kbU9+HwQxEVjHDhIezUKsZPa3y/N8eEH+its7pDOQx42mtVh3thmyuOZEV8I?=
 =?us-ascii?Q?eXuWfG/IXDgXfoLhB3664dBZfRGcZYNBVpfYgtMiae40U3FCOLnTjxMgr013?=
 =?us-ascii?Q?GY7oq0y4HVEYj0bvGVgZWndnCLigimuFjy/TaQRBKSWbPs4ErEpcF0X6xWnF?=
 =?us-ascii?Q?YEkiW3iieE3JjVsWnHulbF/WGf3S9lV+Mbwi5IVzF7h+YH3SAF7UR46Tin5O?=
 =?us-ascii?Q?CR4KHCOZu+JOlmVKs9czl2IyeybmUoO3bpQ2BJO/UwccPpExvRRIu12NtbKB?=
 =?us-ascii?Q?DO4o4r2tfa/ksoIK8cc7sCYH0VtWwYzOPdO7WekexlHh2CerawtHyVpTLgbO?=
 =?us-ascii?Q?PgGxuU0s0/WqzSvnRDGy58Eet/kW04+uFHhAZvVWaA4e9KUGc/ZV57A1mDYs?=
 =?us-ascii?Q?e8RP6DZbBDum/CXvAqwwMXsnua5vi7a9+PmIlyRyt8sWsSmiqJuxm+yq4XxF?=
 =?us-ascii?Q?CMwg9mXLdvDtbGDJL1nn3CGh9Q6H6zvkiWTNZ+POjHh6Ltr+FWRKjYWeqGrW?=
 =?us-ascii?Q?NAkj/5I4FqI1QzK14BrK6YaRVfiK1BmhB8QV9G/xpRF+uJPw8qW5qPo+Zpox?=
 =?us-ascii?Q?70QSmPpiVAgNirhignRteMvKJ0mr4VoUVSwZCDQT1KuUyC7nwbrtmra4HDbd?=
 =?us-ascii?Q?PbY3TISyUQKsaKP8fJZXbvR8ipJvCsgYkRaev0TQN5vQv9baB2oHUP+LihRK?=
 =?us-ascii?Q?qImJq4rzZyc1IJr1/+RK35X7kQQDi7xljsV39W6GJA4abm25pFL/Q=3D=3D?=
X-Microsoft-Antispam-Message-Info: hnthwzDNFUmoW8ePGrWxtTpm4jjotZWEaLyvYBvRdopF8HocQ8TpIXbC35lty3kg2YY25QZ+EAmpi6gESypRCfE52zZ34UcG7xFOFyx4muXKPMn1Q5Lmu9RgNH1TX2Y5bVrHR9x54XAU9Lvf0ERCW5lo/n4CFvEgt8GeYWwrkaouQ/CpVn4y17JE9KeFb6c0QfB2oC7/bPVIEJxO+/8kEo6jS65st7fCZCedtBBFFUQE1FpEJOGgvqcMe0h8MD+WSheWKTfbdiQIltizT35yOG/UJx0602uKwDZ/aTq9T8S7Y8pqEm5NzRiAb0q+9cYL22FG8iygmGtP1f3VWED8EDXf9sw7mFYOIKAOGiaRj3A=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR19MB1322;6:RPtq0FsZ321Og9WZPwqzjNsTNBP2uXvxc1Ec8wFW0+dHyWe7sdc3P9dGbevE3uxtf5AY1n4M9c6gS6MgR++PFzAI/8xcmSb9XeDdXLElHH+6WQ25N32YELNTRKmiiSATT1z3DDqB3js9bC2bRpk9+pCE/1Ub7A5gaOHR5b59k+5SUUJEYjZRWQLhGt2gpwtj/pWRzOg/zH8MvLw1YthLGM377CG5qk0Nxo+OX1I93tLJXqzCGsLgg4gVRueM7Cw4RL1+2P7iIkgNufrQ9Ho3i1tWgexa93AX5j65rhbXZrBthPtle0ILBMB5sOFX45J0VEAGXRrO3KQSVKgrbcGxiciKJn/OqNvb3RqA2TOeS9MHUKlEcGrr/gKXpUbVVz9osczyRQ3QSflSMOfQBpXTeeVNOSboLr+tkJJIitdvNUMvGIWVuji2OCJXZ/yhcG9g9VeJEAjcz1A8A8IB2sl7oQ==;5:8AiiSwtbaSw3UaWgouOOL/cGxQlCQJ/fTj4WJQ6WiLKKi29LYHIPLk8pr1VxbjyykjlihyPg+jCcL0Y1ZCF6SreUUSMy9Ca3FcH9hw8ZwhQmtZEPQ7soDV8vYsUsEbPcqf2THHagaEiT0naJf1MXa4vvZbhTUCs7kltbgorRNkg=;7:xWCjbWYGQx/yH7ZDdaNLNhr3nyrhHylsyi1a2OZa3eg9BbRNJ0vT3RJDeGbn3cR4guUK8uw7xSUQvxrXQRl7UWG97cA1Hm1of522fV1Tl4ue39UlE12abuthT8Sz1OhZ4/V3mR7rg3boO+hwFqbO2g==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2018 02:44:40.1144
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 550812f8-a0a9-4678-a44e-08d65e496eb3
X-MS-Exchange-CrossTenant-Id: 5afe0b00-7697-4969-b663-5eab37d5f47e
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5afe0b00-7697-4969-b663-5eab37d5f47e;Ip=[208.19.99.221];Helo=[AUSMBX1.microsemi.net]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR19MB1322
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
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
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

