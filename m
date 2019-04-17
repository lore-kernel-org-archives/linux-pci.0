Return-Path: <SRS0=SWM8=ST=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E23BCC282DA
	for <linux-pci@archiver.kernel.org>; Wed, 17 Apr 2019 14:16:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA20720872
	for <linux-pci@archiver.kernel.org>; Wed, 17 Apr 2019 14:16:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731844AbfDQOQb convert rfc822-to-8bit (ORCPT
        <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 17 Apr 2019 10:16:31 -0400
Received: from mail-oln040092253069.outbound.protection.outlook.com ([40.92.253.69]:48544
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731743AbfDQOQa (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 17 Apr 2019 10:16:30 -0400
Received: from HK2APC01FT008.eop-APC01.prod.protection.outlook.com
 (10.152.248.59) by HK2APC01HT019.eop-APC01.prod.protection.outlook.com
 (10.152.249.49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1771.16; Wed, 17 Apr
 2019 14:16:24 +0000
Received: from PS2P216MB0642.KORP216.PROD.OUTLOOK.COM (10.152.248.51) by
 HK2APC01FT008.mail.protection.outlook.com (10.152.248.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1771.16 via Frontend Transport; Wed, 17 Apr 2019 14:16:24 +0000
Received: from PS2P216MB0642.KORP216.PROD.OUTLOOK.COM
 ([fe80::adb3:4c16:60fd:65]) by PS2P216MB0642.KORP216.PROD.OUTLOOK.COM
 ([fe80::adb3:4c16:60fd:65%5]) with mapi id 15.20.1813.011; Wed, 17 Apr 2019
 14:16:24 +0000
From:   Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
Subject: [PATCH v4 0/4] PCI: Patch series to support Thunderbolt without any
 BIOS support
Thread-Topic: [PATCH v4 0/4] PCI: Patch series to support Thunderbolt without
 any BIOS support
Thread-Index: AQHU9SgjzA7gZFnnDUaHy6fCOX1Rrg==
Date:   Wed, 17 Apr 2019 14:16:24 +0000
Message-ID: <PS2P216MB06427AB6C60D2848A5A015C880250@PS2P216MB0642.KORP216.PROD.OUTLOOK.COM>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SG3P274CA0012.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::24)
 To PS2P216MB0642.KORP216.PROD.OUTLOOK.COM (2603:1096:300:1c::16)
x-incomingtopheadermarker: OriginalChecksum:46BB39BAE394C538EA30CBB9FCAD8F637F792E1F3A1A18B7D9B983343C13EF86;UpperCasedChecksum:1A9CC05C6D1A9571CF710F2CA31AE5E43CA0C2FEA2A80573CA5F8B0B964A406B;SizeAsReceived:7658;Count:48
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.19.1
x-tmn:  [37iRqCiOdNruC8HLHjwatwwklSHT1s9DIzTW8xbDIwM=]
x-microsoft-original-message-id: <20190417141610.6730-1-nicholas.johnson-opensource@outlook.com.au>
x-ms-publictraffictype: Email
x-incomingheadercount: 48
x-eopattributedmessage: 0
x-ms-exchange-slblob-mailprops: mBy7Mai7yE5GOp0BEGlYkd86SxW4/tB+yqhSIPKzB2c+9bKhujokHdF10X6U5BBeO8nJOA5QPNvf6k2RluEzW6ze+P7HUdVF6fNmJi80ED7wRi7I2UXmFvzuaqAr48pRBz6782rlQ+m7COIvEKJE3/8e4GaqII9wgVSX6A7ADBtvce117Cgnz9R51T2nd1iZdMZxpboyj8XqnNl6IXKfdWEICwuzbxXitPjQeICocjlTsB55HODSF4Zf9RlrFSX1T1geFlr0vaqWtY81htfyu11Scw3jwJ0VQF135sXja6KDQTVjZ9UKEEsfnTdF0+GMVrgmZTsSs8M0wHlY9vzLYoLhxHrDXEwKawpQNo5eCNrAgt14tTCl95Fo0nubdEG/1D6iO8Z/uT+RTQeLXYdPtp2nudVSz/osDCKP7e38sNaWc0Q5pLlDkhUCogpRry7Bt9S6PpEaFAuDcrHgZactweleMD25Rgp6Xuk9L2nwGmLJEodF/0riM+ZFrIxyeeDm8kt2cg0Mh9ZCX1ZN21ddQvzwwfoCEnEWiDs7Zx5RxhS/oZ9b7sYJ1pvo+1+jLehpqgNK8kcTB9UXH0nPFezv3pBRDHfq8fnlOt4PrpLV+yCyVf0yNtVNEoyu5i4MoIOKHVUrM1TpawXigh8eyufkY4s94DFZxFUcG02GUMPVmWy7AGFbj/ASnYdEiawsM/W9cdaTZ9M6RoFhQT7j2k7L9ds9vjbXiRUY
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(20181119110)(201702061078)(5061506573)(5061507331)(1603103135)(2017031320274)(201702181274)(2017031323274)(2017031324274)(2017031322404)(1601125500)(1603101475)(1701031045);SRVR:HK2APC01HT019;
x-ms-traffictypediagnostic: HK2APC01HT019:
x-microsoft-antispam-message-info: g9bMMi0Z55Jl+fiKA1YaAA4aB7xHLVkRsFK5IGzGLAEVTQscRV6T1Wgw5KdJ3EiFwUCWlP4B9Jj4c06ILAjna+pTIcr3rZlw24ZPXDy+kEJAKjNZzlo75X4GJ17Jk/vOFJpHqfgwFk5w20oQmF94qSknMhE4DoLA713HUrxPGNFrI5DoA4a+jqhj9z/DvOmP
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 613ed3ba-7446-44e8-698c-08d6c33f457d
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2019 14:16:24.4313
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK2APC01HT019
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

1. Based on 5.1-rc5 so should apply cleanly to latest version
2. The comment clean-up patch is now last
3. Kernel parameters are no longer renamed

Sorry - last time I misunderstood or read over the requirements too 
quickly. I hope this time everything is as requested. Please let me know 
if there is anything else to change.

It is still not as thoroughly checked over as my PATCH v2 series for 
small typos, but I cannot find any problems. All patches pass the 
scripts/checkpatch.pl perfectly with no warnings.

Thank you for your continued patience and understanding.

Nicholas Johnson (4):
  PCI: Consider alignment of hot-added bridges when distributing
    available resources
  PCI: Fix serious bug when sizing bridges with additional size
  PCI: Modify kernel parameters to differentiate between MMIO and
    MMIO_PREF sizes
  PCI: Cleanup block comments in setup-bus.c to meet kernel style
    guidelines

 .../admin-guide/kernel-parameters.txt         |   5 +-
 drivers/pci/pci.c                             |  12 +-
 drivers/pci/setup-bus.c                       | 504 +++++++++---------
 include/linux/pci.h                           |   3 +-
 4 files changed, 278 insertions(+), 246 deletions(-)

-- 
2.20.1

