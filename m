Return-Path: <SRS0=ulVR=N2=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=DATE_IN_PAST_03_06,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78519C43441
	for <linux-pci@archiver.kernel.org>; Thu, 15 Nov 2018 03:16:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40C47214F1
	for <linux-pci@archiver.kernel.org>; Thu, 15 Nov 2018 03:16:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40C47214F1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728198AbeKONWP (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 15 Nov 2018 08:22:15 -0500
Received: from mail-eopbgr780047.outbound.protection.outlook.com ([40.107.78.47]:32021
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726892AbeKONWP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 15 Nov 2018 08:22:15 -0500
Received: from BL2PR19CA0019.namprd19.prod.outlook.com (2603:10b6:201:f::29)
 by BL2PR19MB0722.namprd19.prod.outlook.com (2603:10b6:201:1e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1294.27; Thu, 15 Nov
 2018 03:16:11 +0000
Received: from BN1BFFO11FD003.protection.gbl (2a01:111:f400:7c10::1:167) by
 BL2PR19CA0019.outlook.office365.com (2603:10b6:201:f::29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1339.21 via Frontend Transport; Thu, 15 Nov 2018 03:16:11 +0000
Authentication-Results: spf=softfail (sender IP is 208.19.100.21)
 smtp.mailfrom=microchip.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=microchip.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 microchip.com discourages use of 208.19.100.21 as permitted sender)
Received: from AVMBX1.microsemi.net (208.19.100.21) by
 BN1BFFO11FD003.mail.protection.outlook.com (10.58.144.66) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.1339.12 via Frontend Transport; Thu, 15 Nov 2018 03:16:11 +0000
Received: from AVMBX3.microsemi.net (10.100.34.33) by AVMBX1.microsemi.net
 (10.100.34.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1531.3; Wed, 14 Nov
 2018 18:46:06 -0800
Received: from server1.microsemi.net (10.188.116.185) by avmbx3.microsemi.net
 (10.100.34.33) with Microsoft SMTP Server id 15.1.1531.3 via Frontend
 Transport; Wed, 14 Nov 2018 18:46:04 -0800
From:   Wesley Sheng <wesley.sheng@microchip.com>
To:     <kurt.schwemmer@microsemi.com>, <logang@deltatee.com>,
        <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <wesleyshenggit@sina.com>, <wesley.sheng@microchip.com>
Subject: [PATCH 1/5] switchtec: Remove immediate status check after submit a MRPC command
Date:   Thu, 15 Nov 2018 17:44:00 +0800
Message-ID: <1542275044-10970-2-git-send-email-wesley.sheng@microchip.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1542275044-10970-1-git-send-email-wesley.sheng@microchip.com>
References: <1542275044-10970-1-git-send-email-wesley.sheng@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-Matching-Connectors: 131867253716909878;(5a93feec-e11d-4f7b-166a-08d09f1f276b);()
X-Forefront-Antispam-Report: CIP:208.19.100.21;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(346002)(376002)(136003)(39860400002)(2980300002)(189003)(199004)(105596002)(53416004)(44832011)(476003)(126002)(2616005)(446003)(336012)(486006)(11346002)(81166006)(97736004)(81156014)(8676002)(50226002)(8936002)(68736007)(16586007)(110136005)(316002)(305945005)(54906003)(53936002)(6666004)(76176011)(107886003)(498600001)(5660300001)(36756003)(450100002)(47776003)(69596002)(86362001)(77096007)(2201001)(26005)(4326008)(48376002)(50466002)(51416003)(356004)(2906002)(106466001)(14773001);DIR:OUT;SFP:1101;SCL:1;SRVR:BL2PR19MB0722;H:AVMBX1.microsemi.net;FPR:;SPF:SoftFail;LANG:en;PTR:InfoDomainNonexistent;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BN1BFFO11FD003;1:RM4hW4UfMdSorir6ySdSoZVwKmXoyBIEA+/1WglL4x6w5Sk0KCcY91SP0nXkyZ7/T5gcyIWXMkY4ACjAZnIxBAlOgMBadKv5B/IolXj7Po7teprpRAtHF0/vxwbDXIcY
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f59d08c0-56f7-41c0-3101-08d64aa8b1b6
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(5600074)(711020)(2017052603328);SRVR:BL2PR19MB0722;
X-Microsoft-Exchange-Diagnostics: 1;BL2PR19MB0722;3:hOCtySvwlG/qeVQnFEdnR98+M/JaYPsitN0RPlZCW2zq30Qr62WFHuHPIOpnbVhKk/T3Rd31anJHYiFt8VkcqvertNmpfyIH40Si1DrZbqWaVB4/mW3NeL0mr6DPUQaVQ1zASPNiC+C96eun6UDjmSirIN0rm13GzWo3V0KK3h9MT8XyzXMe6pMes0exEQxUzdv4IwLVoI+enQNEc9GUBpCFn9AOlpBwyuxIZY9aizQAWKoC0e3cN/OMXdo/DxDQOyJBcoh//GU/XQ4ezIGoqnYf/xkDs9wrSe+JnprBag9SJcvPT/Hu5EAUBXfz5rSMwRliwn+8GvnUm61YKwnC5nStMV2foA8vTmtVYTtf6s4=;25:iYfVxxOUrHuUStDmi4sJDyRGm4PKcfSicB0Bklxf3+1o+puDg7SRHcNwaeIw/fqdke/MFFudGK2HgOzicR2JffOTgWup4+1Bwhn2lmvizgrXCvwRY564otYTIg0/pLpTWR9yZjbgBS0p2H8i4QNmBDqYtykX6iw0GRi7aSHMtUYz+vqWqYz/u4h2tT1RD242VAmLHLYYHqcAhoFaAQruJ0tHiVTOPQfZAEelRj7cG5H1Si2dSsQFcII3UgY83JtddaExWBDikMHZphQYKtFr/X9qQgmoixE0LHdlpwx5UiEJe9M/eQ1hukxIpEQ4vQYMnc6KYkIyB0c+ln8eFTT0Ww==
X-MS-TrafficTypeDiagnostic: BL2PR19MB0722:
X-Microsoft-Exchange-Diagnostics: 1;BL2PR19MB0722;31:Fah6fesNY4KYTzm/u1+QmUY9aqv+A2GuCY8v/JyDpKjtfdiVhB1USndT2qpyR1Fg08Mo9C7o6mHeuV7ED8uWFjneCB292kWSFq3dcBUfuXMHQymcCAmyQvGo94II2p+YK6F3LVJCPbt4J5pP/qcuLiS7Le0VsYJ3kuYtq/vSyunMxA1Ejj82vd+REqxOqfxOG9Gnm0vbUV/BjKgBYDzlk+bOiplNztRs2Q5NPI3/77U=;4:y1DJ7mnltgkUheCyfGKiEB97S/RcBKhJ92jVD6vcsIVY0P98gOo3wcAtEFH/yVVTgdC/jIxN80yIadrJTvP+De7rQs3wv8Azb0OuzUXQ4pMz2o+2S8UhezMc77Yo+TZKJm6OSfQepWHavmoY5cZcZIwJP8Ht3AOMFBjgtqbKzCLpXdcsthDj5fEPzeql2tdA72kT3ZtmF/HWy9mPWZQvHTviwDwBBNHPjB56zyfu5ozkS0xUuTCNQCS43pEBPVeFbBuNjH6QYpO00secCcJoAg==
X-Microsoft-Antispam-PRVS: <BL2PR19MB07226EF8AC877EC1960EC17895DC0@BL2PR19MB0722.namprd19.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6095135)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(10201501046)(3231415)(944501410)(52105112)(6055026)(148016)(6096035)(201703131430075)(201703131448075)(201703131433075)(201703151042153)(20161123556025)(20161123565025)(20161123561025)(20161123559100)(20161123563025)(201708071742011)(7699051)(76991095);SRVR:BL2PR19MB0722;BCL:0;PCL:0;RULEID:(400006);SRVR:BL2PR19MB0722;
X-Forefront-PRVS: 08572BD77F
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BL2PR19MB0722;23:yi4QLl+fFwehGlCAtplhtLDyiJtbnvwh1bRcqDVWL?=
 =?us-ascii?Q?iaM2IVtvp/ffyot9Gb6hwv1ipR6gCufabj8YPj9d0QwW7cCZrVAce0m2v53Q?=
 =?us-ascii?Q?HYbOBcUdJ6ESvV9vArLQxsg80B7EimVIh+9ZfVSA0JsatE4HOdcB6Ziw2HJA?=
 =?us-ascii?Q?UjH8FjVgFmCEjy1npWudTrOHv5NeDWalMVPMZmTDPm8BsoeCeG/uOrZ9bZeC?=
 =?us-ascii?Q?dNE36ccVW6pQRTMGTdZm6LPSHZvGjloXxwlDIRrOUwk4K0Y/h5t9zSIJoZ9o?=
 =?us-ascii?Q?sk4s4/jd4wSjYB+yuz5DJJv41ROiXOGYAZP7iqsrQJY/El8b9HV1HNBXKohN?=
 =?us-ascii?Q?4h1Je7bBqu+cX5BMYSMA4AFi7KZ/Exl2ld7InJetA/HYL4JjvIvMAMDi0gCS?=
 =?us-ascii?Q?L8+hYvu5fYcfnCfUawhhQyYukvaYuJHCNoLlyfZnFjHnAFTgu3YFUFsB0Cmz?=
 =?us-ascii?Q?exrobOpLNoJZowv3r9xWFWYTomifBAPPnDleRH9CPO3KlXAuvyoBX5LNTkT4?=
 =?us-ascii?Q?1+gGs3X4Hq6HsoNLQ1Js+LOwi7RzjRVP6mFln3JvCPHUWfnwswCPyTWkNd+C?=
 =?us-ascii?Q?44682U2QTeiq3mGv0hkiy6SqCiWuE1IGhffgPAGzPiVjnQS7hpAMQ/GEetSp?=
 =?us-ascii?Q?kd0YpRtVcoNRZB4zYrWMHqEWxJjRBprsaQznl/C5zJgeKx05P1u+8v9plq3+?=
 =?us-ascii?Q?XSzrgt6eXMp0jDXc901XkrBk8QQ33E6DNqevGNqEir8uz/j/UYSgb7ocnP39?=
 =?us-ascii?Q?v83IjdefiKlPJN5HrCgaaGAs/+AYvrt14Bt6Jjrj6KRmV02zwqYt17tf49dY?=
 =?us-ascii?Q?f9C8N6i2fVZF0e3n6kJhbWBWFJmkCbaWeSa1+ywQz0BL9s/6m6ezBMo24+Yg?=
 =?us-ascii?Q?NKZn2dUu0J0j6Cj4in5dTYdRQOEiM8WoqicusP+hkm2EjegejyzFFyLuZTyu?=
 =?us-ascii?Q?FYf2Nd9URhreAdjkrFtKB0yycCGQSTxw/oyC6AYHQG65ZEfCyMx4dwzsNOCU?=
 =?us-ascii?Q?ojPC6JfqeWAclVJ7C8e7E5Ayr1joncwZ02gI3g++xEhlkDjYX0tkOAUPt7tL?=
 =?us-ascii?Q?DyF34RoP+1a2Nr4MZxkaPj6l3qo9QttqcsSdo5MND+Q6CZcpSCqlinFMa7h4?=
 =?us-ascii?Q?Wbn60GHbtc/ecUeDsOoLs8yyw3HFvp8D9SZmt++Vst7KTaT+yPbuA=3D=3D?=
X-Microsoft-Antispam-Message-Info: V4a9ZsI0uzknkr8lSs3tYgOMicNaxXPXjWinXE/urSZz7Q94kMB30Qkeq+ANK3NN4VFzHOt923pMWGtu0vXCDBFXPvwDRXmPw89Dqnh7TvjReziqbyZbx1ItjeZrIa6XgH58Fnb9uBJhbTMcL7NeWrpOAvgbu0Ir/i4u9705PmqKgtyb1fmKDCkZZZRVjGEprAC91jSXqX0wqqJH7+/6Quw1qLPqRIKTZsVCS7GbSbP6hMKbCD9gjnFWlIPDmAPEOlVGf7XCm1/CUUHGfqUfY4ggThKwNlvTl9l7G37tErZLOxuRnkwGYfEC2YSOFVHMUm1ZwKcoZpTiuspNnFeoCt/vXSwRAOCK3MUcFQiNO3w=
X-Microsoft-Exchange-Diagnostics: 1;BL2PR19MB0722;6:UZG3KWHDc4GFzGWn425dCw+Voewc9WurX2WkMzn01Sw4ppgJwJhB3SVnNNte43xjCVNzKiN72rT0Dfrw3W2ao8UKTamoHGxnY4kZClPQuBgN3AxdOqLVzcplPzt84s1nCTjYkUzIKMfcoAQbuqAGZWpggRlqUn5D0HED6Wuyea/hZwrlolIQCgAyeRhIO8xzbKqDlTVTvbbmvGxjdGZ5ZYGf2RGh0+zJwss3NNYxohDcMwv64sLxuRTBrfJU14aOw3w++M2U/PATGDpUp3U9mpc9+zklV0hZYGjhtYHu7tTKNvPmpFP1p7AB02KBJQOlLLeGeSxhPG28u2CCS8byBU2CV/1kcKgFP9MRjKUWCzhAuTCLaw8FeMGdVHMGOkjcdOKGp765DamoD1jLqHz6UPR+Pq2nU/di+4/NknewiiDt1EKX8LDuebr8YMiqNowtDW16mxiXNSwTK6RDjNtp3Q==;5:Smry7zP4LElv8T5Culffp2e1l8q0OTLa459Dl3TyCCTVtnfU9iEy2yf6CCv9KXjejhJL+b+UZsO8Qu4H7LbSbo8GcNTNtD9MsIivvYrQ2VVBisNI6Nshn/YfuPqnxEZX0Le/5DHJS4667Qv4ZteIjU6hPS4lxjCs1aHDqPnuOx8=;7:EnOuAN58eBVOdo1B+HjRq5Of8DAIlKsXQzl9J6e0eK+25NREgqu4OGCDMRaEUJXLG4t5r659+7wNFmIsUvUKOYvpdSHsXjTUaBChn7px0Rf0Ga7hSdGRNzev02tK+7PIxxU4Rzy1nkb+sbyFlx1C4w==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2018 03:16:11.4566
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f59d08c0-56f7-41c0-3101-08d64aa8b1b6
X-MS-Exchange-CrossTenant-Id: 5afe0b00-7697-4969-b663-5eab37d5f47e
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5afe0b00-7697-4969-b663-5eab37d5f47e;Ip=[208.19.100.21];Helo=[AVMBX1.microsemi.net]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL2PR19MB0722
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Kelvin Cao <kelvin.cao@microchip.com>

After submitting a Firmware Download MRPC command, Switchtec firmware will
delay Management EP BAR MemRd TLP responses by more than 10ms. This is a
firmware limitation. Delayed MemRd completions are problem for systems with
a low Completion Timeout (CTO).

The current driver checks the MRPC status immediately after submitting an
MRPC command, which results in the MemRd TLP that's affected by the above
limitation.

Remove the immediate status check and rely on the check after receiving an
interrupt or timing out.

This is only a software workaround to the READ issue and a proper fix of
this should be done in firmware.

Fixes: 080b47def5e5 ("MicroSemi Switchtec management interface driver")
Signed-off-by: Kelvin Cao <kelvin.cao@microchip.com>
Signed-off-by: Wesley Sheng <wesley.sheng@microchip.com>
---
 drivers/pci/switch/switchtec.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/pci/switch/switchtec.c b/drivers/pci/switch/switchtec.c
index 54a8b30..d2bca2d 100644
--- a/drivers/pci/switch/switchtec.c
+++ b/drivers/pci/switch/switchtec.c
@@ -134,10 +134,6 @@ static void mrpc_cmd_submit(struct switchtec_dev *stdev)
 		    stuser->data, stuser->data_len);
 	iowrite32(stuser->cmd, &stdev->mmio_mrpc->cmd);
 
-	stuser->status = ioread32(&stdev->mmio_mrpc->status);
-	if (stuser->status != SWITCHTEC_MRPC_STATUS_INPROGRESS)
-		mrpc_complete_cmd(stdev);
-
 	schedule_delayed_work(&stdev->mrpc_timeout,
 			      msecs_to_jiffies(500));
 }
-- 
2.7.4

