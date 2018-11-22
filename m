Return-Path: <SRS0=lMXa=OB=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DATE_IN_PAST_03_06,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A4E8C43441
	for <linux-pci@archiver.kernel.org>; Thu, 22 Nov 2018 03:04:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C75420684
	for <linux-pci@archiver.kernel.org>; Thu, 22 Nov 2018 03:04:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C75420684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731999AbeKVNli (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 22 Nov 2018 08:41:38 -0500
Received: from mail-eopbgr750047.outbound.protection.outlook.com ([40.107.75.47]:12768
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729872AbeKVNli (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 22 Nov 2018 08:41:38 -0500
Received: from BL2PR19CA0037.namprd19.prod.outlook.com (2603:10b6:201:f::47)
 by BY2PR19MB0392.namprd19.prod.outlook.com (2a01:111:e400:5a2d::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1361.15; Thu, 22 Nov
 2018 03:04:13 +0000
Received: from BL2FFO11FD005.protection.gbl (2a01:111:f400:7c09::157) by
 BL2PR19CA0037.outlook.office365.com (2603:10b6:201:f::47) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1361.14 via Frontend Transport; Thu, 22 Nov 2018 03:04:13 +0000
Authentication-Results: spf=softfail (sender IP is 208.19.99.221)
 smtp.mailfrom=microchip.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=microchip.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 microchip.com discourages use of 208.19.99.221 as permitted sender)
Received: from AUSMBX1.microsemi.net (208.19.99.221) by
 BL2FFO11FD005.mail.protection.outlook.com (10.173.161.1) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.1339.12 via Frontend Transport; Thu, 22 Nov 2018 03:04:13 +0000
Received: from AUSMBX1.microsemi.net (10.201.34.31) by AUSMBX1.microsemi.net
 (10.201.34.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1531.3; Wed, 21 Nov
 2018 20:04:01 -0600
Received: from server1.microsemi.net (10.188.116.209) by ausmbx1.microsemi.net
 (10.201.34.31) with Microsoft SMTP Server id 15.1.1531.3 via Frontend
 Transport; Wed, 21 Nov 2018 20:03:59 -0600
From:   Wesley Sheng <wesley.sheng@microchip.com>
To:     <kurt.schwemmer@microsemi.com>, <logang@deltatee.com>,
        <jdmason@kudzu.us>, <dave.jiang@intel.com>, <allenbh@gmail.com>,
        <linux-pci@vger.kernel.org>, <linux-ntb@googlegroups.com>,
        <linux-kernel@vger.kernel.org>
CC:     <wesleyshenggit@sina.com>, <wesley.sheng@microchip.com>
Subject: [PATCH 0/3] ntb_hw_switchtec: Added support of >=4G memory windows
Date:   Thu, 22 Nov 2018 17:01:59 +0800
Message-ID: <1542877322-24548-1-git-send-email-wesley.sheng@microchip.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-Matching-Connectors: 131873294531878880;(5a93feec-e11d-4f7b-166a-08d09f1f276b);()
X-Forefront-Antispam-Report: CIP:208.19.99.221;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(136003)(376002)(396003)(39860400002)(2980300002)(189003)(199004)(498600001)(105596002)(2616005)(356004)(110136005)(69596002)(97736004)(126002)(48376002)(50466002)(476003)(2906002)(44832011)(53416004)(336012)(50226002)(305945005)(81156014)(81166006)(26005)(8936002)(54906003)(77096007)(16586007)(36756003)(8676002)(2201001)(86362001)(486006)(68736007)(316002)(51416003)(107886003)(5660300001)(47776003)(966005)(4326008)(450100002)(53936002)(6306002)(106466001)(2101003);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR19MB0392;H:AUSMBX1.microsemi.net;FPR:;SPF:SoftFail;LANG:en;PTR:InfoDomainNonexistent;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2FFO11FD005;1:07KB+mPYugB1ZpLuZo0bAg1GrXmQPs78SI1famD5xaVDK7SiQyf8mgqQD1a79ZTovX3ik1gApt7cWTSSi4xMIfPSyJ5eZ+BRXdSvNWigL3pNEHU1aDWL7bKsrAnOYiE6
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e2e154a5-c0b9-4f44-5986-08d650272e5c
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(5600074)(711020)(2017052603328);SRVR:BY2PR19MB0392;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR19MB0392;3:osYTREHhMjBFS9EPl+XJI2Wn92Ya1+Cm92ROj+vhA2rSujnxVt+ra2Q+XiL/ppbInKFKelCCvxDu/Mwat6S7jhv89NDHgBzsZW0/cPZA8SosPPS/Qckyo19uirdoh6dGbSsIEKgkn3BvNuIpRzQNAyJtX8dmdzqFCmJessbdmgMC84ny1ZZByBdO6jEu1ihdbpQLtx/OTDV/Ssaa/XK0lpnA9TyiJ96l9eKB5+ybuooMcEX/+PkMyQayvK7JhR8sTzbOPoLqzF3rmLKUdspfHVmMaQwju5ZVaHcsSmTE6wLQ7SDvAPor2O3DMMkhbOwo0leedN5akUdkTFmbiGAtJFKglUZQGsh0Qme9Yt46T/k=;25:YxJscvYPvmkgzTr1jpYEljAjcP3hhPC4hs43nDm9rogDZSpCuKJ78/NMyaDIp4k682jcCSe9tPWrsz9INqrH8Ks/JQngJw6+IiM7/7Oh7WvRNOm0C/Nt9u3+JelKEo42NzbUHJM9VQpTjDZdhK9MHU+1+pBJsMhCeGLlsCvZuxa6TSUl0gqEBka/WEeUGyaS03ISLbLG04JYH3q3L9Y38HASXGgMYofCimyuJoL6dsaIodhkHPd7JPH/iOQojDMtOTtfZngrgBUZHXP6+Pj+0YTm0j+ojoNGkSc/i7prVNLQIut591PwOAW/eZUafsE/aWShHFud1AgtLfR95ljrig==
X-MS-TrafficTypeDiagnostic: BY2PR19MB0392:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR19MB0392;31:1WV3eRuv2fZ9gm3Sa8W3Wt57qAIt4RLcynkioTJhM8LyvxCRKGx3AlA4cPdiFe64FJAOqZvBvhRXmh5MNn/djZAtGH+x3NZ9i4wj4VJKe1qQv6LTnObLqFs9LRFFoGmo8u0rNtvCDMU44QYCy7g5PVlsOJZASIt0I0c1CX7CkAaef0TH0y6Twb7MWRe8+7cKU2+KpR3pTW4rKvQ+xvwhM9QcicwRCstVa/TSSkiSx+A=;4:b7xLw8HuynAE7k9ioGsAbmGN+w0ZO8DH1JjGyCRhotBKVukO0c4mlpfKH/7VGr3k+nMcAx4es7zd8ulu9pOTuoWNQGr8ZKxWMUlZUyc0EU+f0JsXmpfeFP+gdUxQxg/B02hGtywmKBl/sHaJUQlrIMItyYx5eWldr9dYwBKitXB+R14zhOCdqMEK/DRTKkgJC2SwD+aQ7VJz2kEKdRsbdwiCrol6zGm4Zn+KQB9uZ9Zbc0wx9IZsmQgmq5RrKGVii9rFbEAIoOyOTWVbVA4yxw==
X-Microsoft-Antispam-PRVS: <BY2PR19MB03920461B4C5BB11B4A69BA395DB0@BY2PR19MB0392.namprd19.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6095135)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231442)(944501410)(52105112)(3002001)(6055026)(148016)(6096035)(20161123563025)(201703131430075)(201703131448075)(201703131433075)(201703151042153)(20161123561025)(20161123565025)(20161123559100)(20161123556025)(201708071742011)(7699051)(76991095);SRVR:BY2PR19MB0392;BCL:0;PCL:0;RULEID:(400006);SRVR:BY2PR19MB0392;
X-Forefront-PRVS: 0864A36BBF
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY2PR19MB0392;23:FeK/hB5s0+tLpKBjpFpsVCbBQ+D7RKQMmZ0lH5SNK?=
 =?us-ascii?Q?tq7/1Of9t1+xCw71ltp2L8ZWwdYCMl/VsSgveu33i9QNtv2QGTm8mueEFMaF?=
 =?us-ascii?Q?KnhvDkTS26kffjiKnZvLOlLEcjY2f7ZMyX5GuAGWJdg0sTSL5HIGT6nnXZWP?=
 =?us-ascii?Q?ks3H0i5n3xTo57T3CqxiZAr3tM8tFIGSIfQV76kBveljkNPSkT2/eKCjc2xu?=
 =?us-ascii?Q?NKjd66BXendo1AbwJ4cmgMRCjmx2xqWzgH77eizCos+sg+p/aeUw0gDezBwA?=
 =?us-ascii?Q?gOJzAHtbMyp81ghT14rfusdmjTUYtNdF6ZtuBAmIHq7pVV/tSKdKalmkEJ34?=
 =?us-ascii?Q?Mvyhskmjq6Ykt9Z+CpEr19HBwqiWcKulumxT5VsJzfCXXaK528d/euzZAbnH?=
 =?us-ascii?Q?r6Xwnb84dDPqVIMvzCnaQ18AxUSxMT8bp5uj9Ejsyu5iZu0GVMkbaooQQbdm?=
 =?us-ascii?Q?sNQKZG7IAz1JTGrS1LD/X7DFCJ3477BfTUuTAvQrKPTxShlVyCQ0E83fDG9R?=
 =?us-ascii?Q?91d4OP3cgEnYjxTUiOnte8N2LgvF9VbuPADyQa0nXZ69s7eNM7k4DUlhtw1z?=
 =?us-ascii?Q?aX3NkulzTVbbQWju067ODX6zbANHrqtaUTpBH9Wnhjo/uNRMQwv635LtOzfH?=
 =?us-ascii?Q?DFoBpE/AdRtQTxwIjbN1WoPNE/YbDMh5jBk5zEJPogVNzKZjUMhNZ/gpkEY4?=
 =?us-ascii?Q?Qf3+if794Xg42/OpGPZ0+9Yf53vyagEGJoiySC7r6wzfgwwR/wRiXKtx7W3z?=
 =?us-ascii?Q?Lk0JpTo7rUUkiTJx1CCv+THaUktYzsJMZn1n5UPmLDX9rAK62r+RQEK9y9uH?=
 =?us-ascii?Q?dCkwWSZ5CUsLoiincGa7hz/KHMXI3XiUOYhgz6YMrKjEwZVeYcTU/8yr/sxi?=
 =?us-ascii?Q?LIQlJpiq0gZQXoIchDtbXWfAXIpJf2iScVucmFJRuiGCP2Mk230xPSL4SzHp?=
 =?us-ascii?Q?MTxw9xLTVj17RpfXgU+O/YJkzyNHRhsa/5UGs3/DjIf4r6PTBQ5W+ecGAnkM?=
 =?us-ascii?Q?9NsHXYySr/cXDENRa5mN60opfaRVDLndjVCuBfrWnY2WcBZvzndzb0e4N0vD?=
 =?us-ascii?Q?PYg7hHqMt2x2zMgykAThFOlrkKvKMMz2ubdzANXsCaA7kg+NW1yds/xGSio7?=
 =?us-ascii?Q?AhM/yJdPz2qH/UiEGyncOYF3qrJcMbq?=
X-Microsoft-Antispam-Message-Info: xaKC3CY/HfpwEPhAvrdLs26NQuNlc2J/BrWTDrGtvsqVPTtp8JWtBChPy8Z0NlNesVQ/SEVBKUOW0OKJ3RIaMX6+90YEirYOwJEU/kNuTYbDuk5jn3fWVQquVrFjqZUJSxL7mD1JVMNh1RnIqBGSUZMCSWzf2fNXzlS91CvxzpvI75NLcue8bow9f89P1+j+sq0mJT+UDE7cQY/sx+QfO2oW1tsSaCZ7Pg8EsWgnthBSLBLICBC9O6aoda0bjf3PshR9klcPPS4/MNmXIAtA1Z8Vp3TuQmy6lUPVkOcaa5Og/Y+8geO91rzEMCeli/GPAfdmKm/SQhrLOIoT1RN9XQ==
X-Microsoft-Exchange-Diagnostics: 1;BY2PR19MB0392;6:5Kydu7BiqZuk3gMX1eJmlgQ4g2tyGWFS/tcVkJGUhsMwptPEX8TNDt+kzBpb4KEfSskXq3SRAx0HB3sWeUQT7PJxZOdYCs0Wwlr+jGEva0PxR6yhx1gX2t5qEB4xAxKuOGv6fEddVY8tSM8gsC6mBWOl0FZAyHpMAKI4foghKobOlisj2gSqX7owSfhnwG4e9vMySVbeoqpSoQp/85MSyagj0XAc+r8t5cxyAaOPwktw1DjO04B5BUvjcqhT2mA+Yh4pibTI500ILKLpjkO4X+HTnKE1C4C4DZQEdF3LY79U/giZ7YzD+k0SVE5e7yozBtPKusyeLu3FLQ4OE66IXCGWOSzCB4bTQ7XUw3z2n+1C4R6FDYmHv4SihOypBRUKHMrNyjC76m4JFo1iDORRC8LlyfT3TJA1zZLX4D0oXn9S+2I0qZ/8qV0FLL61ImSZmwVpARqz9bT+Dae5TQk9uA==;5:0U6VVTT30EeAxA6+qatsTM/iQr7iTwD9bSOpuIt2a2JPFpBgqGOKN9PPEFfRapMKBg5SMkf9k/odIMYEn1muAjNZK97l9luoZJCy0g1sW8ReXZBLPZPopE86PxAAaGIP5/P6/G5sKCAanTpsfdGiQw7HCE+glashUBvOI4MJlaU=;7:miZl7knG2w2nb2RFnnxhK9a7VdL8zWmQ8ge7GakJX2NdMvoIjoRbw2rFpOB8YWdL92OpciQK06OcPG0gTMVHkkQxhF34pmA3IwxIUfIAL/9cvO1Df9p95AgY8kGjhCehmTVTWMy4DQeNPjBqsT8vmQ==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2018 03:04:13.0003
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e2e154a5-c0b9-4f44-5986-08d650272e5c
X-MS-Exchange-CrossTenant-Id: 5afe0b00-7697-4969-b663-5eab37d5f47e
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5afe0b00-7697-4969-b663-5eab37d5f47e;Ip=[208.19.99.221];Helo=[AUSMBX1.microsemi.net]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR19MB0392
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi, Everyone,

This patch series adds support of >=4G memory windows.

Current Switchtec's BAR setup registers are limited to 32bits,
corresponding to the maximum MW (memory window) size is <4G.
Increase the MW sizes with the addition of the BAR Setup Extension
Register for the upper 32bits of a 64bits MW size. This increases the MW
range to between 4K and 2^63.

Additionally, we've made the following changes:

* debug print 64bit aligned crosslink BAR numbers
* Fix the array size of NT req id mapping table

Tested with ntb_test.sh successfully based on NTB fixes series from
Logan Gunthorpe <logang@deltatee.com> at 
https://github.com/sbates130272/linux-p2pmem on branch of
ntb_multiport_fixes

Regards,
Wesley



Paul Selles (2):
  ntb_hw_switchtec: debug print 64bit aligned crosslink BAR Numbers
  ntb_hw_switchtec: Added support of >=4G memory windows

Wesley Sheng (1):
  ntb_hw_switchtec: NT req id mapping table register entry number should
    be 512

 drivers/ntb/hw/mscc/ntb_hw_switchtec.c | 11 ++++++++---
 include/linux/switchtec.h              | 10 +++++++---
 2 files changed, 15 insertions(+), 6 deletions(-)

-- 
2.7.4

