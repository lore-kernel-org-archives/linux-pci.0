Return-Path: <SRS0=ulVR=N2=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=DATE_IN_PAST_03_06,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF5FDC43610
	for <linux-pci@archiver.kernel.org>; Thu, 15 Nov 2018 03:16:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78466214F1
	for <linux-pci@archiver.kernel.org>; Thu, 15 Nov 2018 03:16:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78466214F1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbeKONW1 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 15 Nov 2018 08:22:27 -0500
Received: from mail-eopbgr800052.outbound.protection.outlook.com ([40.107.80.52]:48657
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727341AbeKONW0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 15 Nov 2018 08:22:26 -0500
Received: from CY4PR19CA0042.namprd19.prod.outlook.com (2603:10b6:903:103::28)
 by BY2PR19MB0391.namprd19.prod.outlook.com (2a01:111:e400:5a2d::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1294.31; Thu, 15 Nov
 2018 03:16:22 +0000
Received: from BL2FFO11FD013.protection.gbl (2a01:111:f400:7c09::107) by
 CY4PR19CA0042.outlook.office365.com (2603:10b6:903:103::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1339.21 via Frontend Transport; Thu, 15 Nov 2018 03:16:22 +0000
Authentication-Results: spf=softfail (sender IP is 208.19.100.22)
 smtp.mailfrom=microchip.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=microchip.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 microchip.com discourages use of 208.19.100.22 as permitted sender)
Received: from AVMBX2.microsemi.net (208.19.100.22) by
 BL2FFO11FD013.mail.protection.outlook.com (10.173.160.221) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.1339.12 via Frontend Transport; Thu, 15 Nov 2018 03:16:22 +0000
Received: from AVMBX3.microsemi.net (10.100.34.33) by AVMBX2.microsemi.net
 (10.100.34.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1531.3; Wed, 14 Nov
 2018 18:46:11 -0800
Received: from server1.microsemi.net (10.188.116.185) by avmbx3.microsemi.net
 (10.100.34.33) with Microsoft SMTP Server id 15.1.1531.3 via Frontend
 Transport; Wed, 14 Nov 2018 18:46:09 -0800
From:   Wesley Sheng <wesley.sheng@microchip.com>
To:     <kurt.schwemmer@microsemi.com>, <logang@deltatee.com>,
        <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <wesleyshenggit@sina.com>, <wesley.sheng@microchip.com>
Subject: [PATCH 3/5] switchtec: A temporary variable should be used for the flags of switchtec_ioctl_event_ctl
Date:   Thu, 15 Nov 2018 17:44:02 +0800
Message-ID: <1542275044-10970-4-git-send-email-wesley.sheng@microchip.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1542275044-10970-1-git-send-email-wesley.sheng@microchip.com>
References: <1542275044-10970-1-git-send-email-wesley.sheng@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-Matching-Connectors: 131867253824645354;(5a93feec-e11d-4f7b-166a-08d09f1f276b);()
X-Forefront-Antispam-Report: CIP:208.19.100.22;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(396003)(376002)(136003)(346002)(2980300002)(189003)(199004)(36756003)(68736007)(76176011)(450100002)(81166006)(14444005)(81156014)(8936002)(47776003)(8676002)(69596002)(106466001)(48376002)(105596002)(53416004)(26005)(51416003)(5660300001)(77096007)(4326008)(356004)(6666004)(2616005)(126002)(476003)(11346002)(446003)(54906003)(16586007)(110136005)(316002)(498600001)(2906002)(2201001)(336012)(486006)(50466002)(97736004)(50226002)(44832011)(86362001)(107886003)(305945005)(53936002);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR19MB0391;H:AVMBX2.microsemi.net;FPR:;SPF:SoftFail;LANG:en;PTR:InfoDomainNonexistent;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2FFO11FD013;1:Z9DPm2A86bSz5lyGZuv7EajNJc/xR3WZbkRlRzumGWRjB3NNjZwa+SYmMuW/Hpy6lp4p3n7mrmy8IYo/4Q3hIEjinmtFyHplG3C8z7hgynnOQNuBhAcpPr4SFB96iETO
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 27747807-949a-49d9-68ea-08d64aa8b830
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(5600074)(711020)(2017052603328);SRVR:BY2PR19MB0391;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR19MB0391;3:pYRnvqhS6DyMc/4jlrIVC6dEG4h3ReZYJkXyEZSddF41Xxp1h8Hui9hWAEQIQYE9u+7tSpVVps0ZNE5bHeS+7GYbueqgr8M4pzeBOIsnzqKtrMMXc1hAbsBFwDcEawxT7bi66Z806qsBJjutpA105cCSJ/BRTUAFl07j2ofuk5VZEq1H0IxMflE3vMP4iF/2NdjtwnZekyT7pOr7gIVqVV2Ox4H5jAasiO57ixxCf9lmF+uzLUvpfQIvB+Aop8emEeGmemi5wrT2wAQVIMXudxdsfyjhhB/Nw5PGT0FJP1Wd1p8X65PfF307R9ou0gOe01xvoqdnFXdGh5hKzwCSejsA9Iz7bBECuzv49H4UuyI=;25:x/+qKpuR+nABOuAu2qYjpNpjVUI5jxXn9++U7cw3eN6ax7PNIoQIE3qydpYiiVsiPxDqlpRkvp5v1d2s8bI3/Osj7sqg29DJWJs8HUw7UFJ8fniymY6schFWMVR/VHYV35kC6PgmNF3hzT6pEHwOvQ88Fyw327J5c1iTVTUz6mD/5ZuuGj958rQoq3TBOKLhs7KRmfrJwdjgI7Ze2kpxbmhlkw99ZLl94elx1eFigT12goMRb7LZRH4bfMd4C3ZLi1YqhKTI/nQ0KmEBlclhr81e7pBzCirUpTFvPozmKH2WCOZPjcfJKpPOohqUCxx2S9i1rpRLi4rTI+MhFerrSH4/CCsA3mz5byKn509Ogwc=
X-MS-TrafficTypeDiagnostic: BY2PR19MB0391:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR19MB0391;31:6TH7XeyEHeEoelICij7xccbr9hW2XuDMnwof3dPOvh2N2zMGY1YK5bQeF78fgC9Aj6Bw09OatjOWNhRHP02gZovSi9hgG/KAhdVQ+X4pm1b5jOMzYnBIBmDqtTyqqpXqbV9DoezQPAsDDugEBfItQu3yN6ItEtgN2LhqKpOSLgac5hbb77A6dcy3wR4+4bSe7SF8Ir15CtrFzIctm6xg5AXD2JFeiwFcuQtchC2EWsI=;4:+8rKQnuMaacFRrkRWWSFiC3WyylFaBTFnBvjI1FoqZadRKDC34aufIjDexmy3NvmrCd9JDAR4BNV6mo8yRocwq2Vgkm6cTALNTfhuLyMK2bhedQjSB1j+DHjhPKxwGja5NhbM8T5FUyf+iRFJyci4xOENuU4moFQJ2d8gOQBWdnxcKB5nHXc2De/b2wSyTlhQxFfNI5YWOANFLE8LUp7CGBH8xWGZUd8jYVKMwKSmH4McjAT6uLF8xbm8OZEh7bm/ngj9HZNc1f9ko4CleEvuQ==
X-Microsoft-Antispam-PRVS: <BY2PR19MB0391E87BFF2284996FC9851D95DC0@BY2PR19MB0391.namprd19.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6095135)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231415)(944501410)(52105112)(10201501046)(3002001)(6055026)(148016)(6096035)(20161123556025)(20161123561025)(20161123565025)(201703131430075)(201703131433075)(201703131448075)(201703151042153)(20161123563025)(20161123559100)(201708071742011)(7699051)(76991095);SRVR:BY2PR19MB0391;BCL:0;PCL:0;RULEID:(400006);SRVR:BY2PR19MB0391;
X-Forefront-PRVS: 08572BD77F
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY2PR19MB0391;23:rRNfBOHa0yzOBEaQl8xI31xitw22eKhiPcnk0t//P?=
 =?us-ascii?Q?UnGbegP7MFXz8VSUnDX39J33MEMwxamlxr3UO8iwQOpaRFk30JsDjQlm6HIK?=
 =?us-ascii?Q?I8cVmD3L3ZW2cu5H2mZbwHBWogk9VGaQ2tEqgiEvtB//p0szz91iQUL5it+m?=
 =?us-ascii?Q?tlHddbLhf73ChyMWouTCTL8FlwCxAzg/S/pKnZLL3e5BgXuvZolAOQfpmvaq?=
 =?us-ascii?Q?fxrNsaJREmZC/pQEr1U3HBEyjhLxG32xiOBDLXZs1+25QGlty26aEdp0eu0t?=
 =?us-ascii?Q?nN/EhN8iHud21fQYEDoYKyxiaVe2ZLCaC6YiV6nMiysMkc0dEcsfslzxSm3M?=
 =?us-ascii?Q?VNF5s0pvvodLVViTL1/DXavjtMT8ESnpNe2+YL2lHt4MWxbKKBD+g00em7bd?=
 =?us-ascii?Q?W3+SPP1iIpxwBvoOS1qlqk3jY3UMRzubyxdZnx2cUvebdQbTZRSRdQrp3Gun?=
 =?us-ascii?Q?G24sW21x+ULgPK6OK3DYKbvh84c3B9fgw322IlC/SVdQ1SMzLisGLyIZQ3zk?=
 =?us-ascii?Q?BYgJ/ozj+OsL4SR2BHtk+SkxokGlhI0VtFGTpwvp7Ft6UelVe2OR2AEgcnxI?=
 =?us-ascii?Q?Z1CsUgsedCS+ipuLA5cZlwaJB/Sh00S2Aq6p7xjCrbANV7k3yb+jynXqMq8i?=
 =?us-ascii?Q?aTHT+pZerrcPL5kdAZiuGVZsEW+JdGjD8bvWvq6eXC36FVF/lzLcb4A6WBF6?=
 =?us-ascii?Q?/Ybh1+ZMK/q5/5KSjn1d09qy3I6rLj/gWevnBUtozLg4YadoTwe681/C7CtN?=
 =?us-ascii?Q?gATvODJMsPmD4lIBAA+kLS24fQX8z35E2ZKkQs/5qqaiPLE/DAyjRiO6TZzV?=
 =?us-ascii?Q?bcpC0wLHDSY7cibBNSL7QNt4zHNu58tAIxznyP9egmuuysCWzInVQH9qmmEN?=
 =?us-ascii?Q?9lA8KlZN9IFLodOkVvtGcl11QIxEym0YePaJ5886kWOoHmFkbKpzyoS2GdNT?=
 =?us-ascii?Q?ncOIPAx15QaTbU8pBnU51kgeR5ijSA/U0EyQIbuhfT8mgaZNhxGJgtLgIT6i?=
 =?us-ascii?Q?BgtcQ9Lp+NV5uaK/9SbhcJT8hfiBv5Dnmw+pkU5l3C2t4Y3ap5FJKmqm64+5?=
 =?us-ascii?Q?0Ogr3rxwis8W65E+0TzFoptbXOkjpUkDw4DnuYv8+p0TMs+m1WAI5qs/iMZ/?=
 =?us-ascii?Q?1NTL79eZ9MkUaqjsBr5U7COB2TdWiGeCuH/cmmFHfTNuXGKw7Gmrg=3D=3D?=
X-Microsoft-Antispam-Message-Info: J9CdxYmSz4ILTD8sK+1d6wOTIXR0z4y69Z92OQjikytg6/JUZlJCCKiQCOByBY9pFhSMyCxxL0yFiVzaJxcdtk1cZnHh2MVN8kABnWqZZnx6UD2iB8HWJepjedpy008F+GcCg2DDvluWfsTq4EhEDg6+jEXJCA8/V9dhz6MOUwoxUDJhupjOj4ghI9j2K+SeVNOOTchns2baaAl5rq3GT7uwznn07SZ9Pd7FxLJOJSMezJb9Ko4TJcKyhSNlMtxlFPb+thJrOwaNHIuzxo+WkLG8BwAbq3+isBpesrvqA85ot7iSYSUFUTR83pJIEwyh4WjU6ykO2vvlKUfPCWkp3wC/C+DqVAqKL5a7RYjDLkY=
X-Microsoft-Exchange-Diagnostics: 1;BY2PR19MB0391;6:CM63XW7Bm9eGLyirUNz+JLt7oIf4Cpc2qII9e2cgwn3aDRqIvCg1LwVeis99hXCEdXW5CKgFVtPqsebYbZ9GNJp6lB71gT5CPSQmajZnj5poZbRcRICXRU7WONVR1xQaR8q8oUg/3TnT8jL7eefcclwTrO7gFqzKTcpOfUm5S3Wal++OINkUx1kpBZq3bBVtyRlmuukrMN+/FVr6I3vdbevPDdAsu+POsFTA8f7oruBmNV1y1wnfdyRQrHPnF+PkcqBQIVUzvRNxwTVem8FuaN9fYcmrtOSGzSsQ4IUWX1Uz4EQk90kFQBWRKXZgARwr3ixHP1T9U5GNQo8FYEtn9hSiZBWfa/OoFdW9K7Cr3ReK0QPXxOHOtQ25k85uWy1mbAAimYzFE7usGsW+EN0TOx4xpNbqfBDISxH9vDdNaHsJjPa2jMiZINRUHliohQNVU24+YfpaS7ncKG3FXhd7Fw==;5:kpDMXf/JA2PGtXWMO6y/3ScLBE5eWD7DcwwWZEhGvzjr6/N4qjpDblVgPwHelGGlC+mdhXTjkviMWK3Tn7+Y2TEGF99wSCdQurC11N44/XUGny0Jrot5nqvXTiAhfCHtAMrBc99U3qvTrFOFCIrmCcFh/sQhtd0d4qq1vjv0nJ0=;7:TsZpMKJEOzmzb31ez2RdhWP67w2hs5UgcHXsrP92ng+Nstq63IWX1EOoNhi7LkHkkYI/steThYDujqBzJV5HKxrgihMrmd1u1bSFfxwlbqgc7ZxaMTjxTp9jCSfe2R4Ry9vHh78ftwOp2i9oEljwdg==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2018 03:16:22.3239
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 27747807-949a-49d9-68ea-08d64aa8b830
X-MS-Exchange-CrossTenant-Id: 5afe0b00-7697-4969-b663-5eab37d5f47e
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5afe0b00-7697-4969-b663-5eab37d5f47e;Ip=[208.19.100.22];Helo=[AVMBX2.microsemi.net]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR19MB0391
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Joey Zhang <joey.zhang@microchip.com>

For nr_idxs is larger than 1 switchtec_ioctl_event_ctl event flags will be
used by each event indexes. In current implementation the event flags are
overwritten by first call of the function event_ctl().

Preserve the event flag value with a temporary variable.

Fixes: 52eabba5bcdb ("switchtec: Add IOCTLs to the Switchtec driver")
Signed-off-by: Joey Zhang <joey.zhang@microchip.com>
Signed-off-by: Wesley Sheng <wesley.sheng@microchip.com>
---
 drivers/pci/switch/switchtec.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/switch/switchtec.c b/drivers/pci/switch/switchtec.c
index 480107e..a908670 100644
--- a/drivers/pci/switch/switchtec.c
+++ b/drivers/pci/switch/switchtec.c
@@ -796,6 +796,7 @@ static int ioctl_event_ctl(struct switchtec_dev *stdev,
 {
 	int ret;
 	int nr_idxs;
+	unsigned int event_flags;
 	struct switchtec_ioctl_event_ctl ctl;
 
 	if (copy_from_user(&ctl, uctl, sizeof(ctl)))
@@ -817,7 +818,9 @@ static int ioctl_event_ctl(struct switchtec_dev *stdev,
 		else
 			return -EINVAL;
 
+		event_flags = ctl.flags;
 		for (ctl.index = 0; ctl.index < nr_idxs; ctl.index++) {
+			ctl.flags = event_flags;
 			ret = event_ctl(stdev, &ctl);
 			if (ret < 0)
 				return ret;
-- 
2.7.4

