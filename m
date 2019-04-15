Return-Path: <SRS0=Mgic=SR=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D00A2C10F0E
	for <linux-pci@archiver.kernel.org>; Mon, 15 Apr 2019 17:08:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB6012183F
	for <linux-pci@archiver.kernel.org>; Mon, 15 Apr 2019 17:08:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726740AbfDORIq convert rfc822-to-8bit (ORCPT
        <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 15 Apr 2019 13:08:46 -0400
Received: from mail-oln040092255049.outbound.protection.outlook.com ([40.92.255.49]:25980
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725972AbfDORIp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 15 Apr 2019 13:08:45 -0400
Received: from HK2APC01FT059.eop-APC01.prod.protection.outlook.com
 (10.152.248.58) by HK2APC01HT008.eop-APC01.prod.protection.outlook.com
 (10.152.248.130) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1771.16; Mon, 15 Apr
 2019 17:08:41 +0000
Received: from PS2P216MB0642.KORP216.PROD.OUTLOOK.COM (10.152.248.52) by
 HK2APC01FT059.mail.protection.outlook.com (10.152.249.214) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1771.16 via Frontend Transport; Mon, 15 Apr 2019 17:08:41 +0000
Received: from PS2P216MB0642.KORP216.PROD.OUTLOOK.COM
 ([fe80::50ee:2afa:f5b:9647]) by PS2P216MB0642.KORP216.PROD.OUTLOOK.COM
 ([fe80::50ee:2afa:f5b:9647%6]) with mapi id 15.20.1792.018; Mon, 15 Apr 2019
 17:08:41 +0000
From:   Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
Subject: [PATCH v3 0/5] PCI: Patch series to support Thunderbolt without any
 BIOS support
Thread-Topic: [PATCH v3 0/5] PCI: Patch series to support Thunderbolt without
 any BIOS support
Thread-Index: AQHU863fNGvRDPO5WUWRROps6ZedjA==
Date:   Mon, 15 Apr 2019 17:08:41 +0000
Message-ID: <PS2P216MB06429DB03193EF6635554275802B0@PS2P216MB0642.KORP216.PROD.OUTLOOK.COM>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SG2PR04CA0151.apcprd04.prod.outlook.com (2603:1096:4::13)
 To PS2P216MB0642.KORP216.PROD.OUTLOOK.COM (2603:1096:300:1c::16)
x-incomingtopheadermarker: OriginalChecksum:A96F0A23CC5D4E183E8A000534414104D7AD8118CC9165C9C1FC5F8A080B81E4;UpperCasedChecksum:62D596AD83BF5BD0A7AC3258C1047D32FE0D2C4F81746399A2E49F5CF25192EB;SizeAsReceived:7700;Count:48
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.19.1
x-tmn:  [0aNH8hPi64F+s+MexQxFswsPpfFo/LTjnqQZqoiIFzA1h8s7nc6my5BrzIlimurv]
x-microsoft-original-message-id: <20190416010756.31313-1-nicholas.johnson-opensource@outlook.com.au>
x-ms-publictraffictype: Email
x-incomingheadercount: 48
x-eopattributedmessage: 0
x-ms-exchange-slblob-mailprops: mBy7Mai7yE4ToL4gNTPdRpfskE+PVEk3OPh1cD11jwdBmQ+SDMtDWRnCYLjk8docpaN7ZB+0hL8J/1m9og3o7I4iNkFE+Oi0x9V4s15dQsLYRsH0+vvMpiYlYsi77hKQOJBgNwjlIhWy3FUs+7gdMys6zNZq5TnaYTLXgutmxp6knVbYwmtbPigDhgHVcmS/dkUiN1gFSJ0fMEWMvHQCmLl5BmouyB3bg963hlzwpxNvbX5KyWcEJxjxJ/2pCfcFWup8+jjEBBmXyQ55IKHM+RVMlsytoIrFBK7HqILr8ioF2DCsHtqwpiUvnJMPd7P8BfR9EFcGxDtck4SnZ5rDk/49umhqrJ6z4YoIHPM5Y9jp5oS5fFOudvtlmJ1uF6l7AisiJLXojUgw5MQ6fn+NuO1lKOLf5xanG+fVdCEiRecKPDnKss8nI4kHE6dwxsv7yBjvFwA8ldJqZMOP8zKYumPj5AKXFFXaC7puLQRoPjvmVs7TmnxFWvzHQe8eomjyHBn1CQetYuewZpKjGmHuEncx5oKeN388uXPXWbDOx7HSfK2JfuMyVvsiswXe1qtCF0MH6FH5J1mR1CfWR+43JOddoU6QY/cQyuMgZWa3VHg4R+oiHiq1BM9bh0n2zBmRLtnyFpSDuusu3rEDhQBK5ExpYLgcXbCZ+8bo41xX1Kq0a9Y+mMB+w+vXU7GHKILUtcBqWiBsePF+LN51Z+7YXapfKsoU+lLM
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(20181119110)(201702061078)(5061506573)(5061507331)(1603103135)(2017031320274)(201702181274)(2017031323274)(2017031324274)(2017031322404)(1601125500)(1603101475)(1701031045);SRVR:HK2APC01HT008;
x-ms-traffictypediagnostic: HK2APC01HT008:
x-microsoft-antispam-message-info: ziMT7izKSED+hUbxFy2BCY6rnIFu33Jqfe2fwSsRy6QIGDTCGRpuTl5h8qyJAu4NRNd9J/CBzkEj2YNctZFx46SkHivrEQNIzJC8tDB5X3m4U8ORvPEOAGVBMb0whILpEvd4rVfq9wddDFfFIumUZULeIrs7PfSSGG4o25Eyc81ScU0dmC34cpTnnNM7Jorx
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e02c05a-8306-42c4-60b1-08d6c1c501f6
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2019 17:08:41.2141
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK2APC01HT008
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

I have split the last patch into the two patches as suggested. One to 
add the new parameter and another to rename them nicely.

There is no longer depreciation of the old kernel parameters - they are 
simply dropped, as suggested.

I would find it cleaner to just do a single patch without the 
depreciation, as both patches change the same things, doubling up on the 
number of patch lines. I can still do this if requested.

Bjorn has fixed a trivial problem with the second patch in the series 
not applying cleanly due to changes since I first sent it. He said not 
to bother fixing it.

Please let me know if there are any more issues to be addressed.

Sorry I took longer than intended. Cold / flu. The code is not as 
thoroughly tested as my last revision but the changes are pretty simple 
and it still works as intended and compiles cleanly. I just hope I did 
not let a oopsie through.

Nicholas Johnson (5):
  PCI: Consider alignment of hot-added bridges when distributing
    available resources
  PCI: Cleanup comments in setup-bus.c to meet kernel coding style
    guidelines
  PCI: Fix serious bug when sizing bridges with additional size
  PCI: modify kernel parameters to differentiate between MMIO and
    MMIO_PREF sizes
  PCI: Rename pci=hpiosize,hpmemsize,hpmemprefsize to be more readable

 .../admin-guide/kernel-parameters.txt         |   7 +-
 drivers/pci/pci.c                             |  18 +-
 drivers/pci/setup-bus.c                       | 512 +++++++++---------
 include/linux/pci.h                           |   3 +-
 4 files changed, 287 insertions(+), 253 deletions(-)

-- 
2.20.1

