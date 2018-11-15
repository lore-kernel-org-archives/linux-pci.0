Return-Path: <SRS0=ulVR=N2=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=DATE_IN_PAST_03_06,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B60E9C43441
	for <linux-pci@archiver.kernel.org>; Thu, 15 Nov 2018 03:16:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67D2C22360
	for <linux-pci@archiver.kernel.org>; Thu, 15 Nov 2018 03:16:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67D2C22360
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728748AbeKONWj (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 15 Nov 2018 08:22:39 -0500
Received: from mail-eopbgr800085.outbound.protection.outlook.com ([40.107.80.85]:55616
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728499AbeKONWi (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 15 Nov 2018 08:22:38 -0500
Received: from DM5PR19CA0010.namprd19.prod.outlook.com (2603:10b6:3:151::20)
 by BY2PR19MB0391.namprd19.prod.outlook.com (2a01:111:e400:5a2d::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1294.31; Thu, 15 Nov
 2018 03:16:30 +0000
Received: from BL2FFO11FD006.protection.gbl (2a01:111:f400:7c09::168) by
 DM5PR19CA0010.outlook.office365.com (2603:10b6:3:151::20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1339.21 via Frontend Transport; Thu, 15 Nov 2018 03:16:30 +0000
Authentication-Results: spf=softfail (sender IP is 208.19.100.22)
 smtp.mailfrom=microchip.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=microchip.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 microchip.com discourages use of 208.19.100.22 as permitted sender)
Received: from AVMBX2.microsemi.net (208.19.100.22) by
 BL2FFO11FD006.mail.protection.outlook.com (10.173.161.2) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.1339.12 via Frontend Transport; Thu, 15 Nov 2018 03:16:30 +0000
Received: from AVMBX3.microsemi.net (10.100.34.33) by AVMBX2.microsemi.net
 (10.100.34.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1531.3; Wed, 14 Nov
 2018 18:46:17 -0800
Received: from server1.microsemi.net (10.188.116.185) by avmbx3.microsemi.net
 (10.100.34.33) with Microsoft SMTP Server id 15.1.1531.3 via Frontend
 Transport; Wed, 14 Nov 2018 18:46:15 -0800
From:   Wesley Sheng <wesley.sheng@microchip.com>
To:     <kurt.schwemmer@microsemi.com>, <logang@deltatee.com>,
        <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <wesleyshenggit@sina.com>, <wesley.sheng@microchip.com>
Subject: [PATCH 5/5] switchtec: MRPC DMA mode implementation
Date:   Thu, 15 Nov 2018 17:44:04 +0800
Message-ID: <1542275044-10970-6-git-send-email-wesley.sheng@microchip.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1542275044-10970-1-git-send-email-wesley.sheng@microchip.com>
References: <1542275044-10970-1-git-send-email-wesley.sheng@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-Matching-Connectors: 131867253902877199;(5a93feec-e11d-4f7b-166a-08d09f1f276b);()
X-Forefront-Antispam-Report: CIP:208.19.100.22;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(396003)(376002)(136003)(346002)(2980300002)(189003)(199004)(36756003)(68736007)(76176011)(450100002)(81166006)(14444005)(81156014)(8936002)(217873002)(47776003)(8676002)(69596002)(106466001)(48376002)(105596002)(53416004)(26005)(51416003)(5660300001)(77096007)(4326008)(356004)(6666004)(2616005)(126002)(476003)(11346002)(446003)(54906003)(16586007)(110136005)(316002)(498600001)(2906002)(2201001)(336012)(486006)(50466002)(97736004)(50226002)(44832011)(86362001)(107886003)(305945005)(53936002);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR19MB0391;H:AVMBX2.microsemi.net;FPR:;SPF:SoftFail;LANG:en;PTR:InfoDomainNonexistent;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2FFO11FD006;1:INHsdHkEPHU+3SOyYVOzBJ0SAjhw2Jt6IWhrpb/ssnqMNGfczdTaoDUYFH+tFnD2IQFhJ2W79cKaiXmf6hs8DavIY15p49EuqKn7hGynl1yoVx+//lgIsB2D7k327X6B
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2b6681c7-bd0b-4643-220f-08d64aa8bcda
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(5600074)(711020)(2017052603328);SRVR:BY2PR19MB0391;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR19MB0391;3:IeGrHZA7fgiQ/dvXAVIq3QU7gwduPzWgme2HSIbaXniYbuXNgR0fulBIsmIEeaGaZnnK5jUQsa0Mgz+XTQRY0SZ3uyhnnoqLDOqrmUgldJVWazm7vkAz5kvFwtRKbyk7eA6nNlWW0vdluninR8GWRS6mch3ZNT5E4H8Zq0CVfs+ivzEOy18dkKXy0Ar6FTTGy+LQ8gk8I/QV1MXNB7B/XxZZyJO8XWgWW1w+3UlLy3txZvjRCKrkeGGWomUyPsiSQTvRpeO8LTzBUu+8osj24eRJp7hhSy+HdEn685T3Cs8JbqFf60jjjlPxQeFKvBD4+IxQVXdBFAx8AgTGzoiMaVqpXClc2WxG7sAKAtChnVc=;25:h9KvteIEhqqknCfQ+OsjAAm3bRzMAYRsmTfiMDGF1Rm3G1t9F9mtPST2MnM6aqbMJzRuzm6WPNfmWh0XfgCzgOzK516B8D0SUwbxuL2OfpQo+NrWLYdN01z2Jsx+gcUCjqytqYqZ85bllr551LM2NtkC6mRSpdNjPRtSu9XHOkirBKE+GBOhoBW2Fdm5J7Nh48575p3z5LczPd1X3SNr4SvMKVzmNdgE8iUCnu9jm9glB6GfHESAMDxLcm9p00fdli4PwD0mo3VbL+4I0H2KMN6iwB0b3ejLH6+GqdXadSUNq/tidvPdEvija7PTS2HAp7pzjPcjwT7p2KnJfEnZkg==
X-MS-TrafficTypeDiagnostic: BY2PR19MB0391:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR19MB0391;31:/m6QVQ8q5cHxkuRh7hiETlamFV27GYEpOFx4/gxg/ZdczXRbdrSg0hJv+eAHiyH6hLt378ri3BXxItg3RHkDcuVj2+S8bT2+64IFnkwofHRvVqMlr1qEZxJQ4CD1o4v66w94MAkIkzHTnYs/Z3H4gqeLVA/Ai4+o+afVM4Yzl8UCJJlcSlKv97S1makpKk1jMIhh+giJHGrEBTJA8m+sIUOekJJ1eznLqqG/RSM+k7Q=;4:OBsr6B5oQQOY727Gdovls48m3D8R+mntS5dcuBJbdE4RGHDen2KZv+ypw0kpjpMP1I0Bdaub7XyLPUs6Tfq95qu62ZupyWk1oZ8a6ydgLpk7h4eg0wb3jAiUYiFAPquTIjBu8twApDvKaYIe5BiUd+bKJ6e1qf10l3ZCEOUX6w0isvBVczy/gKNPhofd/A2/ovO4Jq7aM3K9k8UrTWrriB6YFGGtR7EOgq1nkdIQfCR0LPd6HvuSbl3vSJwcdOMZXIqlaMrcHKRAkXofP3OItA==
X-Microsoft-Antispam-PRVS: <BY2PR19MB0391FCD3804613A2BE475C5595DC0@BY2PR19MB0391.namprd19.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6095135)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231415)(944501410)(52105112)(10201501046)(3002001)(6055026)(148016)(6096035)(20161123556025)(20161123561025)(20161123565025)(201703131430075)(201703131433075)(201703131448075)(201703151042153)(20161123563025)(20161123559100)(201708071742011)(7699051)(76991095);SRVR:BY2PR19MB0391;BCL:0;PCL:0;RULEID:(400006);SRVR:BY2PR19MB0391;
X-Forefront-PRVS: 08572BD77F
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY2PR19MB0391;23:0UlHX2e2rah0nvdtvT5PB3vaN883a2B6Jeb35uYQr?=
 =?us-ascii?Q?pN+SsB9CbEz2ND1xT1E/Xg0MlsphzcdKz7EHENFqLEGRreiedMELOs/k/1WL?=
 =?us-ascii?Q?ZgDxG4vxJYN9a9rs+XfNx0OuyKqpb6irSmM0MeEMLAM248qtwgk/lG+i/sWl?=
 =?us-ascii?Q?QFdoK6s6nbJj6Q5jZPttmfFgqxqx2aQCWU9OYl2irolcFtId2yBr2IoCdeq3?=
 =?us-ascii?Q?6AIL3ru3WXsFAhBY52hhQjXanRITlhl+l1NGMupM8g8XKM+ugxMlwbXkuLhl?=
 =?us-ascii?Q?vydK8zCwb5fQwwLTtZYUUMpwKa3ZcibkogEx8jQrEec7w9ADStdTMrm1JeQ0?=
 =?us-ascii?Q?hymHN5tIGW31RPCNZ1+2b0qS7l/I9nHKYTjm7/06YbB6Nm/dSaKF9p4d2KQS?=
 =?us-ascii?Q?3uuFYBr8jVEqrvdnoR1t0zvDoCWm2VxdFDK3Xf2kNaZ7oI+cKn//FTfU9FXj?=
 =?us-ascii?Q?OwvbrV8n/QLOk4O+DrzPvLsYb1xTDf70IxKAbvPy8QiKoe2/75TNmXjLBiIK?=
 =?us-ascii?Q?pHG1CwcAC+33MaoE2ht3BZHp0lE6zUNA1Ie9oV9zjwMDcnNrXa6sNShDmL/t?=
 =?us-ascii?Q?EgOrn5k3C+W0ov77gTP8ghTCorKW3fBEU5yyDy6TOhPn2LqNiVh4HKniQFp9?=
 =?us-ascii?Q?i/XiwdC4TNs++REjZ0HRBdFfLN7bJjRzogXQhdyP3GL+FPxe/XnOpV/QIiVc?=
 =?us-ascii?Q?x7Fs+7EB9fmcNRs6sPTXpV2rajtpEjjnVZIL1da58qY3yBEY/KkMpldO1yCM?=
 =?us-ascii?Q?tDYlots9oRIf5PZIpwi1hHIIM6Vbip4fPv7V+0cgioeVaKTEjjpd9AEsOQym?=
 =?us-ascii?Q?kO8T18XkJpQuxFvyjyKtzfvDQl7JputW5RGv+eKJK6NDaQveNs7JcWgoIMnf?=
 =?us-ascii?Q?D7v1IvlhVQwHjOo8y8KBb2w+vmX/7QxxdQZqdr4tWrNFewnm30Zae/J2P/hj?=
 =?us-ascii?Q?esVLr1YAzPCwxlwrKmSdaUohl8h9kPw91/pjzFI9qOje5owpSSA9+kkNzeXW?=
 =?us-ascii?Q?ENKyZlZup9hXjjeZKO9NRBaSvGU/VtPOgvFLHs5ok5t7lyp1kxL3G0jXWj9e?=
 =?us-ascii?Q?8jLCTyExJwGsyw3DOyv513wMbbl9YVpKEDMcIv8VFeOmqHntb7iCu3bhIJn4?=
 =?us-ascii?Q?sH0mGEzhYHbE5HbMQFCcjb13mh3yJusieapk/CNypHagV6KEcbzVfNaZyrSL?=
 =?us-ascii?Q?pFNrkP3w6hVaH0=3D?=
X-Microsoft-Antispam-Message-Info: L1z/AvtNkp+Nqs9EZF0t692yv1ffSt5AZZ6PoImNwtnl3TSTuwXaUhl7zoq5qh2K2PkGliTtnX5XuokhSB1F/6dFRpkK97NSaoqByGlIv+7ALtXmUIEV9LFTOj8/Y7R8j6zIm7/HV/3rFbIf4jffFeWvE9xlfe2q+bT6/QtxLqgJCLbWGLpW430tDAx685WD7qZkmC59VG3VyLkZAbeeao/pwFIQEBKNCvUHHTlWKUJlWT0evx7cuXYT+IYnbumhWoNhyI/rMS6d/ZP4Iyb3tceUJnGGypwp6Rk/OiMJtOjWmx/5SKrhJAUgFVB8vps+G6GSIKXhxniqpwwWPHe52E+aVPNEmRCQcaEG/4tsqwY=
X-Microsoft-Exchange-Diagnostics: 1;BY2PR19MB0391;6:LRoQIWF98MImIvDRs+BBVSfaVhtPo7ZXaZvzcShrX0vHASrI3J2WY5lTlNp/4rGyYpAc6aquKtUon/RhvSkpu3Td7cjunTimPrQZAVZZ8qHyh4Ds3/QWoCuEyQ25Pd4d9nVS41+GySKZQwIYMLOK0JYR120FrxacH6W93E4iHBCcGMV8IpRrAQouTav4iYzk91j0qvJ0RYnIEvhf1WDNhKAr37Kbjf1pbcKtRJbDEFpMkNXSYJJV4Zzf4RT5E7RmF0Eea+kglCWrVHcS3S+gF9dtCG/rudlS+1140cF+D2rJwiBMWCSLwUFcgGGZyGvWqwVZdawXreC7sDQmrzvB4BkuN8mltGjzKT1n6FsFLn4dkuoOR3vrUmWinKBOw5AuKFfPndpRQk+EkGH/KhZmn43wk4qqDFiTpfGlGkVyuKgQvVGsLwLofUBzIp9sHRueWQ0Rf/KXbRc/gjoDO25bTA==;5:E6fM7YhFakEHIfNxXF9GdZUGpBiePrMrYB2Lq5vtB/DW1QzPbfOp/7FZAApFKQtY7f394M9cc10tTt1I0H/aHayc3GZ4UWpeQ1oLlK8FEh/y6HG6MYuG77B/3qrjXCzwEaUIQaEKVfYNOq/HaQAJ1uazCoV1DK8FW711GFFvJKg=;7:y1pjUV5i4EqOfr9dhz7xxsfh2NUILqBikRrqw4HnXt/tQXSEc67T4ltzZcXCcNHTqwxkFuODIuiIX5IaFWlqGZlRsxZfIAKMoyZlYi4dWBIVqiJcBySah/MEMmyfrKCHTXHIXqRGGEvbzVn0cLVjsg==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2018 03:16:30.1470
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b6681c7-bd0b-4643-220f-08d64aa8bcda
X-MS-Exchange-CrossTenant-Id: 5afe0b00-7697-4969-b663-5eab37d5f47e
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5afe0b00-7697-4969-b663-5eab37d5f47e;Ip=[208.19.100.22];Helo=[AVMBX2.microsemi.net]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR19MB0391
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

MRPC normal mode requires the host to read the MRPC command status and
output data from BAR. This results in high latency responses from the
Memory Read TLP and potential Completion Timeout (CTO).

MRPC DMA mode implementation includes:
Macro definitions for registers and data structures corresponding to
MRPC DMA mode.

Add module parameter use_dma_mrpc to select between MRPC DMA mode and
MRPC normal mode.

Add MRPC mode functionality to:
* Retrieve MRPC DMA mode version
* Allocate DMA buffer, ISR registration, and enable DMA function during
  initialization
* Check MRPC execution status and collect execution results from DMA buffer
* Release DMA buffer and disable DMA function when unloading module

MRPC DMA mode is a new feature of firmware and the driver will fall back
to MRPC normal mode if there is no support in the legacy firmware.

Include <linux/io-64-nonatomic-lo-hi.h> so that readq/writeq is replaced
by two readl/writel on systems that do not support it.

Signed-off-by: Wesley Sheng <wesley.sheng@microchip.com>
---
 drivers/pci/switch/switchtec.c | 108 +++++++++++++++++++++++++++++++++++++----
 include/linux/switchtec.h      |  16 ++++++
 2 files changed, 114 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/switch/switchtec.c b/drivers/pci/switch/switchtec.c
index 0b8862b..6b726cb 100644
--- a/drivers/pci/switch/switchtec.c
+++ b/drivers/pci/switch/switchtec.c
@@ -13,7 +13,7 @@
 #include <linux/uaccess.h>
 #include <linux/poll.h>
 #include <linux/wait.h>
-
+#include <linux/io-64-nonatomic-lo-hi.h>
 #include <linux/nospec.h>
 
 MODULE_DESCRIPTION("Microsemi Switchtec(tm) PCIe Management Driver");
@@ -25,6 +25,11 @@ static int max_devices = 16;
 module_param(max_devices, int, 0644);
 MODULE_PARM_DESC(max_devices, "max number of switchtec device instances");
 
+static bool use_dma_mrpc = 1;
+module_param(use_dma_mrpc, bool, 0644);
+MODULE_PARM_DESC(use_dma_mrpc,
+		 "Enable the use of the DMA MRPC feature");
+
 static dev_t switchtec_devt;
 static DEFINE_IDA(switchtec_minor_ida);
 
@@ -141,6 +146,11 @@ static void mrpc_cmd_submit(struct switchtec_dev *stdev)
 	stuser = list_entry(stdev->mrpc_queue.next, struct switchtec_user,
 			    list);
 
+	if (stdev->dma_mrpc) {
+		stdev->dma_mrpc->status = SWITCHTEC_MRPC_STATUS_INPROGRESS;
+		memset(stdev->dma_mrpc->data, 0xFF, SWITCHTEC_MRPC_PAYLOAD_SIZE);
+	}
+
 	stuser_set_state(stuser, MRPC_RUNNING);
 	stdev->mrpc_busy = 1;
 	memcpy_toio(&stdev->mmio_mrpc->input_data,
@@ -180,7 +190,11 @@ static void mrpc_complete_cmd(struct switchtec_dev *stdev)
 	stuser = list_entry(stdev->mrpc_queue.next, struct switchtec_user,
 			    list);
 
-	stuser->status = ioread32(&stdev->mmio_mrpc->status);
+	if (stdev->dma_mrpc)
+		stuser->status = stdev->dma_mrpc->status;
+	else
+		stuser->status = ioread32(&stdev->mmio_mrpc->status);
+
 	if (stuser->status == SWITCHTEC_MRPC_STATUS_INPROGRESS)
 		return;
 
@@ -190,13 +204,19 @@ static void mrpc_complete_cmd(struct switchtec_dev *stdev)
 	if (stuser->status != SWITCHTEC_MRPC_STATUS_DONE)
 		goto out;
 
-	stuser->return_code = ioread32(&stdev->mmio_mrpc->ret_value);
+	if (stdev->dma_mrpc)
+		stuser->return_code = stdev->dma_mrpc->rtn_code;
+	else
+		stuser->return_code = ioread32(&stdev->mmio_mrpc->ret_value);
 	if (stuser->return_code != 0)
 		goto out;
 
-	memcpy_fromio(stuser->data, &stdev->mmio_mrpc->output_data,
-		      stuser->read_len);
-
+	if (stdev->dma_mrpc)
+		memcpy(stuser->data, &stdev->dma_mrpc->data,
+			      stuser->read_len);
+	else
+		memcpy_fromio(stuser->data, &stdev->mmio_mrpc->output_data,
+			      stuser->read_len);
 out:
 	complete_all(&stuser->comp);
 	list_del_init(&stuser->list);
@@ -231,7 +251,10 @@ static void mrpc_timeout_work(struct work_struct *work)
 
 	mutex_lock(&stdev->mrpc_mutex);
 
-	status = ioread32(&stdev->mmio_mrpc->status);
+	if (stdev->dma_mrpc)
+		status = stdev->dma_mrpc->status;
+	else
+		status = ioread32(&stdev->mmio_mrpc->status);
 	if (status == SWITCHTEC_MRPC_STATUS_INPROGRESS) {
 		schedule_delayed_work(&stdev->mrpc_timeout,
 				      msecs_to_jiffies(500));
@@ -239,7 +262,6 @@ static void mrpc_timeout_work(struct work_struct *work)
 	}
 
 	mrpc_complete_cmd(stdev);
-
 out:
 	mutex_unlock(&stdev->mrpc_mutex);
 }
@@ -1030,10 +1052,24 @@ static void enable_link_state_events(struct switchtec_dev *stdev)
 	}
 }
 
+static void enable_dma_mrpc(struct switchtec_dev *stdev)
+{
+	writeq(stdev->dma_mrpc_dma_addr, &stdev->mmio_mrpc->dma_addr);
+	flush_wc_buf(stdev);
+	iowrite32(SWITCHTEC_DMA_MRPC_EN, &stdev->mmio_mrpc->dma_en);
+}
+
 static void stdev_release(struct device *dev)
 {
 	struct switchtec_dev *stdev = to_stdev(dev);
 
+	if (stdev->dma_mrpc) {
+		iowrite32(0, &stdev->mmio_mrpc->dma_en);
+		flush_wc_buf(stdev);
+		writeq(0, &stdev->mmio_mrpc->dma_addr);
+		dma_free_coherent(&stdev->pdev->dev, sizeof(*stdev->dma_mrpc),
+				stdev->dma_mrpc, stdev->dma_mrpc_dma_addr);
+	}
 	kfree(stdev);
 }
 
@@ -1189,10 +1225,27 @@ static irqreturn_t switchtec_event_isr(int irq, void *dev)
 	return ret;
 }
 
+
+static irqreturn_t switchtec_dma_mrpc_isr(int irq, void *dev)
+{
+	struct switchtec_dev *stdev = dev;
+	irqreturn_t ret = IRQ_NONE;
+
+	iowrite32(SWITCHTEC_EVENT_CLEAR |
+		  SWITCHTEC_EVENT_EN_IRQ,
+		  &stdev->mmio_part_cfg->mrpc_comp_hdr);
+	schedule_work(&stdev->mrpc_work);
+
+	ret = IRQ_HANDLED;
+	return ret;
+}
+
 static int switchtec_init_isr(struct switchtec_dev *stdev)
 {
 	int nvecs;
 	int event_irq;
+	int dma_mrpc_irq;
+	int rc;
 
 	nvecs = pci_alloc_irq_vectors(stdev->pdev, 1, 4,
 				      PCI_IRQ_MSIX | PCI_IRQ_MSI);
@@ -1207,9 +1260,29 @@ static int switchtec_init_isr(struct switchtec_dev *stdev)
 	if (event_irq < 0)
 		return event_irq;
 
-	return devm_request_irq(&stdev->pdev->dev, event_irq,
+	rc = devm_request_irq(&stdev->pdev->dev, event_irq,
 				switchtec_event_isr, 0,
 				KBUILD_MODNAME, stdev);
+
+	if (rc)
+		return rc;
+
+	if (!stdev->dma_mrpc)
+		return rc;
+
+	dma_mrpc_irq = ioread32(&stdev->mmio_mrpc->dma_vector);
+	if (dma_mrpc_irq < 0 || dma_mrpc_irq >= nvecs)
+		return -EFAULT;
+
+	dma_mrpc_irq  = pci_irq_vector(stdev->pdev, dma_mrpc_irq);
+	if (dma_mrpc_irq < 0)
+		return dma_mrpc_irq;
+
+	rc = devm_request_irq(&stdev->pdev->dev, dma_mrpc_irq,
+				switchtec_dma_mrpc_isr, 0,
+				KBUILD_MODNAME, stdev);
+
+	return rc;
 }
 
 static void init_pff(struct switchtec_dev *stdev)
@@ -1294,6 +1367,19 @@ static int switchtec_init_pci(struct switchtec_dev *stdev,
 
 	pci_set_drvdata(pdev, stdev);
 
+	if (!use_dma_mrpc)
+		return 0;
+
+	if (!(ioread32(&stdev->mmio_mrpc->dma_ver) ? true : false))
+		return 0;
+
+	stdev->dma_mrpc = dma_zalloc_coherent(&stdev->pdev->dev,
+					      sizeof(*stdev->dma_mrpc),
+					      &stdev->dma_mrpc_dma_addr,
+					      GFP_KERNEL);
+	if (stdev->dma_mrpc == NULL)
+		return -ENOMEM;
+
 	return 0;
 }
 
@@ -1325,6 +1411,9 @@ static int switchtec_pci_probe(struct pci_dev *pdev,
 		  &stdev->mmio_part_cfg->mrpc_comp_hdr);
 	enable_link_state_events(stdev);
 
+	if (stdev->dma_mrpc)
+		enable_dma_mrpc(stdev);
+
 	rc = cdev_device_add(&stdev->cdev, &stdev->dev);
 	if (rc)
 		goto err_devadd;
@@ -1350,7 +1439,6 @@ static void switchtec_pci_remove(struct pci_dev *pdev)
 	cdev_device_del(&stdev->cdev, &stdev->dev);
 	ida_simple_remove(&switchtec_minor_ida, MINOR(stdev->dev.devt));
 	dev_info(&stdev->dev, "unregistered.\n");
-
 	stdev_kill(stdev);
 	put_device(&stdev->dev);
 }
diff --git a/include/linux/switchtec.h b/include/linux/switchtec.h
index ab400af..eee0412 100644
--- a/include/linux/switchtec.h
+++ b/include/linux/switchtec.h
@@ -29,6 +29,7 @@
 #define SWITCHTEC_EVENT_EN_IRQ   BIT(3)
 #define SWITCHTEC_EVENT_FATAL    BIT(4)
 
+#define SWITCHTEC_DMA_MRPC_EN	BIT(0)
 enum {
 	SWITCHTEC_GAS_MRPC_OFFSET       = 0x0000,
 	SWITCHTEC_GAS_TOP_CFG_OFFSET    = 0x1000,
@@ -46,6 +47,10 @@ struct mrpc_regs {
 	u32 cmd;
 	u32 status;
 	u32 ret_value;
+	u32 dma_en;
+	u64 dma_addr;
+	u32 dma_vector;
+	u32 dma_ver;
 } __packed;
 
 enum mrpc_status {
@@ -342,6 +347,14 @@ struct pff_csr_regs {
 
 struct switchtec_ntb;
 
+struct dma_mrpc_output {
+	u32 status;
+	u32 cmd_id;
+	u32 rtn_code;
+	u32 output_size;
+	u8 data[SWITCHTEC_MRPC_PAYLOAD_SIZE];
+};
+
 struct switchtec_dev {
 	struct pci_dev *pdev;
 	struct device dev;
@@ -381,6 +394,9 @@ struct switchtec_dev {
 	u8 link_event_count[SWITCHTEC_MAX_PFF_CSR];
 
 	struct switchtec_ntb *sndev;
+
+	struct dma_mrpc_output *dma_mrpc;
+	dma_addr_t dma_mrpc_dma_addr;
 };
 
 static inline struct switchtec_dev *to_stdev(struct device *dev)
-- 
2.7.4

