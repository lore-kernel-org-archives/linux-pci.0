Return-Path: <SRS0=6KXC=OT=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DATE_IN_FUTURE_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CCEEC65BAF
	for <linux-pci@archiver.kernel.org>; Mon, 10 Dec 2018 02:45:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 588C22082F
	for <linux-pci@archiver.kernel.org>; Mon, 10 Dec 2018 02:45:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 588C22082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726363AbeLJCos (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sun, 9 Dec 2018 21:44:48 -0500
Received: from mail-eopbgr750055.outbound.protection.outlook.com ([40.107.75.55]:28457
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726487AbeLJCos (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 9 Dec 2018 21:44:48 -0500
Received: from BN6PR19CA0089.namprd19.prod.outlook.com (2603:10b6:404:133::27)
 by BN6PR19MB1316.namprd19.prod.outlook.com (2603:10b6:404:f3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1404.22; Mon, 10 Dec
 2018 02:44:41 +0000
Received: from BY2FFO11FD009.protection.gbl (2a01:111:f400:7c0c::158) by
 BN6PR19CA0089.outlook.office365.com (2603:10b6:404:133::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.19 via Frontend Transport; Mon, 10 Dec 2018 02:44:41 +0000
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 microchip.com discourages use of 208.19.99.221 as permitted sender)
Received: from AUSMBX1.microsemi.net (208.19.99.221) by
 BY2FFO11FD009.mail.protection.outlook.com (10.1.14.73) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.1404.13 via Frontend Transport; Mon, 10 Dec 2018 02:44:41 +0000
Received: from AUSMBX3.microsemi.net (10.201.34.33) by AUSMBX1.microsemi.net
 (10.201.34.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1531.3; Sun, 9 Dec 2018
 20:14:34 -0600
Received: from server1.microsemi.net (10.188.116.209) by ausmbx3.microsemi.net
 (10.201.34.33) with Microsoft SMTP Server id 15.1.1531.3 via Frontend
 Transport; Sun, 9 Dec 2018 20:14:32 -0600
From:   Wesley Sheng <wesley.sheng@microchip.com>
To:     <kurt.schwemmer@microsemi.com>, <logang@deltatee.com>,
        <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <wesleyshenggit@sina.com>, <wesley.sheng@microchip.com>
Subject: [PATCH 5/5] switchtec: MRPC DMA mode implementation
Date:   Mon, 10 Dec 2018 17:12:24 +0800
Message-ID: <1544433144-7563-6-git-send-email-wesley.sheng@microchip.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544433144-7563-1-git-send-email-wesley.sheng@microchip.com>
References: <1544433144-7563-1-git-send-email-wesley.sheng@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-Matching-Connectors: 131888834812552082;(5a93feec-e11d-4f7b-166a-08d09f1f276b);()
X-Forefront-Antispam-Report: CIP:208.19.99.221;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(39860400002)(376002)(136003)(346002)(2980300002)(189003)(199004)(486006)(44832011)(86362001)(53936002)(106466001)(8936002)(8676002)(126002)(4326008)(316002)(336012)(81166006)(476003)(217873002)(81156014)(2201001)(2906002)(97736004)(68736007)(5660300001)(16586007)(105596002)(2616005)(36756003)(53416004)(69596002)(446003)(11346002)(50226002)(6666004)(356004)(14444005)(110136005)(107886003)(6346003)(305945005)(50466002)(450100002)(498600001)(48376002)(54906003)(77096007)(26005)(47776003)(76176011)(51416003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR19MB1316;H:AUSMBX1.microsemi.net;FPR:;SPF:SoftFail;LANG:en;PTR:InfoDomainNonexistent;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BY2FFO11FD009;1:szXjAF3SaoX4tvLQ92tZim4FHo3jM9qS5LWoSJUvRnCuy1cXiVS04jovf3mLi2ITe+PBR/3ptBF1Xb4BFnjWGldaORauvkSTCMxGHjSrRT7vFaDbM45JG2V009kD+O1Y
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a593a939-f8e5-4c1a-a392-08d65e496f4e
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(5600074)(711020)(2017052603328);SRVR:BN6PR19MB1316;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR19MB1316;3:C4CnjEB7+taLaxFnvd3addS8tQC1shpKvczkdZ/lDHx1iezw1oyBQYaO3/E6hQSryoTOkB5rTOeX66HYvd1ISo01Yf2tO1/9BTV22D7GCkqxaTRWZhOcjgs0bYGZUzhk7ZjDcgzMIp7i5ri5YEVZtWQGc/uYlbtasxVAB358iLCWIxiWfv75vReViNz4yDFB9H0OXZBpsafv8uzlMAor/UpDWSL8isiMPvbGhCp45PAwt21w0a2mKd2Epg8P9Q1SEdFGui7EhA9nvT5uS0RCu4ojIhwT0PVNy8vAUnaqyFdOw2zXKvHyU0l6lZGffcKb7onDrFURK/WxZjAj5hMImU5fBHhW5mHKYU81citmAfk=;25:822uvfy29n2AlqKsevwIqc5Yj4Xn0s7AfCUGaXu9DBx/7Kp9YRs95l09H3V40Kna5m+MA+dqY5sIH+FMdEErU7s7/vUqytkmtPcMSSY4CfcO2/cVDlf2Q6922HWUibsWv+Uk5p6HuNrNtmvnPi7nOO7XbX/xUKslqkk497GhB3ojUP3jUd9lTJDsD+ueru4/mnIzoFuHYlP45QSslYHMwfU3FfhymXYCNPnM9YnJsXsw4iAuY5RqueuX7xyEtLSXKW3HnLps58tOWqcPU1RoWAf/dirYnT9AkmtoVJW9ouIGgn9oSuuUT81wKzB5vl5Zd+QZOPLGzMGuy7rEvHU/NQ==
X-MS-TrafficTypeDiagnostic: BN6PR19MB1316:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR19MB1316;31:ytQr/eLSFN71rwulq6CbAz319Qx46l4txAzJS+YeNWuLr6xrgajN7ek7utQ6pMDbboc5lSKOXWHs+z10qdbJFJkQoYPLVd0GwegXibw7j3RRDGISeDlvSHoOcG1V49vrUDS2UakIxH2yOSbT9RsFw5hsdjqDvLXMS2WZMQ28Xb5fJzAZ3QwggszaXxCdMeYfvwsnL3+QeFPeEYsizJsTMZLmBCCvzNutZUaI25Pd3s8=;4:V7kqgB2O/OLMcA5O3a7U8ABumQMM2REWbTY4mDPFT87TJ+l2se5GKoATWNX8JRMhSvssE7iNJAmhopCJHtet+5D9qlFcx+PYWAWhLs4jDdCRjXtvaQ1++Y7WTWQbdf+xaG3Z3RjrQ9Z/9svO/8+ivV/kO5q1fdGSGfY8SQaZlXHcS3H+kmFHim+PaJ4IOE/RG2JlFqHSMVZm6/kixokWN2sahmoYenhrRW6f/umF4+v+vWJ/yRhxuYaS3521Wy3K8zWK46qTf/HYxpzFIkXdBA==
X-Microsoft-Antispam-PRVS: <BN6PR19MB1316BF443F8037E12ECF409095A50@BN6PR19MB1316.namprd19.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(3230017)(999002)(6095135)(2401047)(8121501046)(5005006)(3231472)(944501520)(52105112)(93006095)(93001095)(3002001)(10201501046)(6055026)(148016)(6096035)(20161123556025)(20161123559100)(20161123561025)(20161123565025)(20161123563025)(201703131430075)(201703131448075)(201703131433075)(201703151042153)(201708071742011)(7699051)(76991095);SRVR:BN6PR19MB1316;BCL:0;PCL:0;RULEID:(400006);SRVR:BN6PR19MB1316;
X-Forefront-PRVS: 08828D20BC
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN6PR19MB1316;23:HvY04jOZcGeDv/iCoBN81gENs2XjnHWF6n4byZnRH?=
 =?us-ascii?Q?yUETa2h5YR/+E6N64yOvoPPbXIS/p/0W+I3GKkmx6iJyLz0+UWJAVQmLFu0r?=
 =?us-ascii?Q?aOfUZ+HqlpeoVtGyuXqR64SmWNXHIRSKn6m/Fmmi7f2Ab+mxDeJcQbrHW7Fq?=
 =?us-ascii?Q?m3GVFtksyBk+3Rn6QDfvLwMV4COcBXC/HLHbX/nrYdaK8FK4OHG/NnS0q7wM?=
 =?us-ascii?Q?kr76ACLz2atj+ue6ykZUcjUxp8WHmEyZ/PX+3cQyVNeRAByR2SVMnwtKu+Eq?=
 =?us-ascii?Q?Zl3v9u6WxTnbs9RsW347/D8kbmEweNgrhZ31eBqNV69SZxdkaiFNJAKUL1CC?=
 =?us-ascii?Q?ELhehn4eiuvwN2a/JeYPmisurr5BB1e9fqVqH7YE3fy6W9+L0hzqlz4iaBx0?=
 =?us-ascii?Q?fZ57OGL3likdhFJ+yXCVltmgrjPFeRM+R71Jet/j6aqRAvuDLlfQ46L8OrDa?=
 =?us-ascii?Q?vpoN6Yz/FTubMH1KHTo/gBqb4/dLnYVspe8zJrK3h0BtTwjYHz9E0EMgmqrX?=
 =?us-ascii?Q?5Y/o+fBpYxxGn6oBMD1hO6JIx9jwM7FiPnYpvO4TqnObupKEdFiSEBDNjRTC?=
 =?us-ascii?Q?Rm4Ffvu28kMG2z9gKRswwYi9Etg/NC84RPHSdJCiEdsQLDuHbEsMQ7UoIMib?=
 =?us-ascii?Q?eixqGSv6PpTg39KydYEW+xe0DDfm2igD4rkE+tXG9snPynIpKVzfMRZt+e4+?=
 =?us-ascii?Q?+BecBUzx0h+AJY3EVFYG27gr+V5hjx/Jn3BYiv2R7b/ro1558NRihpWc++Og?=
 =?us-ascii?Q?CrfOoP+uhJzMPJLN6gwmUupaZvsrIweu/8ap1sA+0ooj8L7yZDaPgctG7/AZ?=
 =?us-ascii?Q?amVA/lELZhBY3o3Yul6XEmzJiaQ9rAcmwZXdFu3G1odx0+mZAXPN7G19UnSs?=
 =?us-ascii?Q?riO604ouJIgTYJkgFeBRELomaxrEIFQMjDjv7G45m6IrgBPljUkKHFX8c6DT?=
 =?us-ascii?Q?gW6ZSJGg59PqVHVG+r1iuQ5Vvnq/8RwFbhuiAVx0jtQEKku99VMXEsZOwcO/?=
 =?us-ascii?Q?Y2KZCZ8LuF0ukRZvyz7jzqTVQS4EmOimO0VFQbhGHkCAgvbUjd2PrJe7zJcy?=
 =?us-ascii?Q?PvCxOF37V9h45YF6a+xp7IIB+IRFt8U9YS28Jgi8ZqskvnBfaZIVu7U7ZoP6?=
 =?us-ascii?Q?vQ42cUgjkh87QpoPm2DxFm3L6jtYe7N28KRoFS8wEcM6n7YvrCnVkQ0otAMi?=
 =?us-ascii?Q?cG09gwfPM3QL6lgSKcuPfUX04hzYET9okBN?=
X-Microsoft-Antispam-Message-Info: x6c5gO/Ll4t/lnlmztRACiXcZsf18D47RfLeB3ekMyrwEUg4SuGRFWdPsT92nFY9/7zU+1FzVSoyJxqyRYT2zPZHd6QKVsZfqPq3kwvYCi+9+F/fyTI4bIaLEuxi+KbZd3dvkFzFxFzSQ2kxpkpcs9ANE30Q3DeQVswrpw9ZeTxhMa30SubpmisGUjr88kdbaU0q3ZMp2gEYbjJsGkGmUa3C5UW7SSvZhM+Rb8ih+8RlZe6luwvT0swgdYffcA6sBv1IzLGWTU0AIkBn61JWP2n+ZwOUCQScvJiBOwgiqo5wAucHOmh5KzN3uw6WE81J
X-Microsoft-Exchange-Diagnostics: 1;BN6PR19MB1316;6:DvL4Wq6aEP1AGA1DTh4skJHqMrstOp6emz4KN7FKDQUcz1Ak60J//CvsksA3DJBrJAK7p37/ydNNI2Vj2Yf26xOT3hqOBCmWqSFKzXu/+kB+MAy/SX5Qfu/Oie7i7KwDW1L3rQ7uZ0SKJ7t9ZRMD/WT7cAIrvavwAO62a5h5V3VC/mRtMl/f3YnNkUrZ9A14uCctmRhmbmlSPXiqmqPawJPabVyKADZPVYJuFCH3AKgCQ87CCpbQ7nh0zKxw+jk3kfRreAY0sZ6qAF28rAbJ334Y2/LJmo64z9HTFYDZOAQp031I8D/+hUxNrmAlljmKuqTGXOMla1DKW7/84PU7s0Ws0MBtuNli5wmKWYsWmMTCYU1rjfPjzTxxscSFcbqdISgP+5tDc5sEW7Ekd3Z624xSldyvKl3w2slS+U+Xv91jdlSAf15wrCttiSKwD6LC5gLah5L1ynobYvKTN/l8pg==;5:8qU+J33lQCibVRp/tavwhKnho5I5RxVw8CNKbcWBssNtsmAz4LgHbNiOMno0TvjRmHTVSVdqInnYnAxH5pZ1YnxMeoUJZCr4ALBgCD6YOe5jy8n52ZdZGuitas+8mU1gUCknIjS2VfbLAQpV/8lV9S5xYlSpl//ZjVGOxIHRMs8=;7:XAuJCHSYXLdKdJEuJkZW6kgb4mf8thTSyjDp6g8udXxC3fQgKJInDqE9pOHTbHJZWLqZEmvX41R1YJ9Be/5rtCP0X5uQ8N/hDlJzkEnV42xuO8wawYYtZF8+CLTCGyrEyreADWc9leH6I1KqkruQ2A==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2018 02:44:41.1145
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a593a939-f8e5-4c1a-a392-08d65e496f4e
X-MS-Exchange-CrossTenant-Id: 5afe0b00-7697-4969-b663-5eab37d5f47e
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5afe0b00-7697-4969-b663-5eab37d5f47e;Ip=[208.19.99.221];Helo=[AUSMBX1.microsemi.net]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR19MB1316
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
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
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

