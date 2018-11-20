Return-Path: <SRS0=4GJS=N7=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B735C28CF8
	for <linux-pci@archiver.kernel.org>; Tue, 20 Nov 2018 11:14:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC9D9208E3
	for <linux-pci@archiver.kernel.org>; Tue, 20 Nov 2018 11:13:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="lFos1VhA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC9D9208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728506AbeKTVmA (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 20 Nov 2018 16:42:00 -0500
Received: from mail-eopbgr70074.outbound.protection.outlook.com ([40.107.7.74]:56832
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728099AbeKTVmA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 20 Nov 2018 16:42:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/LRgsF7NvDD4/+WyCbPXQKVmqkvcjZf7lCjDOR70HU4=;
 b=lFos1VhAcm5KawSxs5Pd7ZNjGc7zFgZlwMZj3CUN//WV3gU5r9TUC58ctBWgyZH5e69Rr6xyeWvH2aSetvToJEixEtJq78Ex45R7lmfypYCMaeE8LCdjfx+0GMoVmeDBQ5RnjHayRhPCGzWd95S6e4Pq5aWEchuOi4eZc7IwpPM=
Received: from HE1PR0401MB2235.eurprd04.prod.outlook.com (10.168.32.20) by
 HE1PR0401MB2426.eurprd04.prod.outlook.com (10.168.33.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.14; Tue, 20 Nov 2018 11:13:19 +0000
Received: from HE1PR0401MB2235.eurprd04.prod.outlook.com
 ([fe80::60ff:1b2a:d0fd:5bd2]) by HE1PR0401MB2235.eurprd04.prod.outlook.com
 ([fe80::60ff:1b2a:d0fd:5bd2%8]) with mapi id 15.20.1339.027; Tue, 20 Nov 2018
 11:13:19 +0000
From:   "M.h. Lian" <minghuan.lian@nxp.com>
To:     "Z.q. Hou" <zhiqiang.hou@nxp.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "l.subrahmanya@mobiveil.co.in" <l.subrahmanya@mobiveil.co.in>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Leo Li <leoyang.li@nxp.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>
CC:     Mingkai Hu <mingkai.hu@nxp.com>, Xiaowei Bao <xiaowei.bao@nxp.com>
Subject: RE: [PATCHv2 14/25] PCI: mobiveil: initialize
 Primary/Secondary/Subordinate bus number
Thread-Topic: [PATCHv2 14/25] PCI: mobiveil: initialize
 Primary/Secondary/Subordinate bus number
Thread-Index: AQHUgLMyZ11mQet0XEKQKM3OcVjbMqVYgqeQ
Date:   Tue, 20 Nov 2018 11:13:19 +0000
Message-ID: <HE1PR0401MB22353520967DE24454F733FDE8D90@HE1PR0401MB2235.eurprd04.prod.outlook.com>
References: <20181120092615.11680-1-Zhiqiang.Hou@nxp.com>
 <20181120092615.11680-15-Zhiqiang.Hou@nxp.com>
In-Reply-To: <20181120092615.11680-15-Zhiqiang.Hou@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=minghuan.lian@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HE1PR0401MB2426;6:oWk3O/Tq1papoBFKtvhgc+TLMG4VDUUwdaRGJcpEb9vlM6OZ3aPaYyVDegm5iUyN2Z4sIgfUiUOi/8CqXkPzVfjdsZ4hH3RljP9sMHsjtIBMaxKdVhUcvzjjbKKNGj492SxJ97/bow4z+e7HjwJDzRAxV2u209Shk+pMEJrOhKBq0SEj1f8Po6afY7l013lL45CuyJvITGGXSmkLMci4BAmpbdRZ6oM+eR45qPFY9WqH3nPx8Ws9NReKRgl4WXCKvkY20UnSofIDVxYQ0MD3RDKQSNV3vXoJnvAWSX5kSsCtLpwvkXeHL+66MaNr7u8G+raPrCb1gh2b0g0IZC3PbiE4lyojSQcyd7Vnnz3srBUeueeTExE5Pityfk3SXTG22V3aipHyVXVj/cpXKS4cQ5uoIhLppHw9BNU3isKjRMzt/cZw8HivRTQGBLZkFTCVFpVZXC83n1n4j6XdTBBmaA==;5:n4h3kqd+3QAI2UR1b5uEKllEOU8qAemHpouLb3msvtSuGFmNQ8NEhEVGHw6AIiSEFaouyIIeoEo9hmFrWYkqtulP2T238x4T6I+aBXjEhlO/TrIHne4BTslqvNGDgSjE9eD054kVoV8RBPpDyTk2grNTxMaEAm3NVIcAamgpSN0=;7:GscfnXoRksm3y9O6eolcbKLuq4Dv7TU7AuGdLMmUWN9xFRm6QoSde3kXj6GSoDTiHk+tuZ+9GVuH75YCKvBYLWkbkFT1BocgWa8ABLsc1gEjtV9z1qfNvznZgqTC+DG/7VfnNaQQWtU6ITZDjmlVBg==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 9383dfbe-6ee4-46be-0a1a-08d64ed92d53
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:HE1PR0401MB2426;
x-ms-traffictypediagnostic: HE1PR0401MB2426:
x-microsoft-antispam-prvs: <HE1PR0401MB242665AD0161FDDA994DE354E8D90@HE1PR0401MB2426.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231442)(944501410)(52105112)(10201501046)(3002001)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:HE1PR0401MB2426;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0401MB2426;
x-forefront-prvs: 08626BE3A5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(136003)(366004)(376002)(346002)(189003)(199004)(13464003)(9686003)(6246003)(2906002)(81156014)(55016002)(8676002)(97736004)(4326008)(81166006)(53936002)(7416002)(5660300001)(7736002)(74316002)(305945005)(66066001)(8936002)(86362001)(2201001)(6436002)(33656002)(229853002)(2900100001)(3846002)(105586002)(106356001)(6116002)(446003)(11346002)(76176011)(71190400001)(71200400001)(2501003)(256004)(476003)(99286004)(486006)(7696005)(25786009)(186003)(54906003)(53546011)(316002)(478600001)(14454004)(102836004)(110136005)(26005)(68736007)(6506007)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR0401MB2426;H:HE1PR0401MB2235.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 4B6WRsS0BRqv7GnMf9mOE7JzFQSHB2d0K07MoNXaa/Iaw37NJLfqmVRiqs8K5XPH8/ThJhzU3B1zjo4LcfzEulPkT3wdPjxMu8jIUmsfWXPtx4OxEta4ScLAUz9f1sUz+xaJl7HiAeb3tncTDp1jXIHPmfq69AWcX4ohyTudPgHFmXoKvjbJkVnuyORlJi9+wum55jlpjKizwQMqPPKL3MU2CYX5zTJ4LORNXWg96MN1hS1Q+U28wMSwfl9n8cmR8QbDY4UvXbBXZCJsAc4kWJouv652yyC6py4ozyClBnt73u797ShCLHtfl6Jrf8v/HI1XgTnw4jMpz8ZhkC3OYuYz4TgvWHbLvOc9g3ny+OQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9383dfbe-6ee4-46be-0a1a-08d64ed92d53
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2018 11:13:19.2915
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0401MB2426
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

reviewed-by: Minghuan Lian <Minghuan.Lian@nxp.com>

> -----Original Message-----
> From: Z.q. Hou
> Sent: Tuesday, November 20, 2018 5:27 PM
> To: linux-pci@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org;
> bhelgaas@google.com; robh+dt@kernel.org; mark.rutland@arm.com;
> l.subrahmanya@mobiveil.co.in; shawnguo@kernel.org; Leo Li
> <leoyang.li@nxp.com>; lorenzo.pieralisi@arm.com;
> catalin.marinas@arm.com; will.deacon@arm.com
> Cc: Mingkai Hu <mingkai.hu@nxp.com>; M.h. Lian
> <minghuan.lian@nxp.com>; Xiaowei Bao <xiaowei.bao@nxp.com>; Z.q. Hou
> <zhiqiang.hou@nxp.com>
> Subject: [PATCHv2 14/25] PCI: mobiveil: initialize
> Primary/Secondary/Subordinate bus number
>=20
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
>=20
> The reset value is all zero, so set a workable value for Primary, Seconda=
ry
> and Subordinate bus numbers.
>=20
> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> ---
> V2:
>  - no change
>=20
>  drivers/pci/controller/pcie-mobiveil.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/drivers/pci/controller/pcie-mobiveil.c
> b/drivers/pci/controller/pcie-mobiveil.c
> index db7ecb021c63..9210165fe8c0 100644
> --- a/drivers/pci/controller/pcie-mobiveil.c
> +++ b/drivers/pci/controller/pcie-mobiveil.c
> @@ -582,6 +582,12 @@ static int mobiveil_host_init(struct mobiveil_pcie
> *pcie)
>  	u32 value, pab_ctrl, type;
>  	struct resource_entry *win;
>=20
> +	/* setup bus numbers */
> +	value =3D csr_readl(pcie, PCI_PRIMARY_BUS);
> +	value &=3D 0xff000000;
> +	value |=3D 0x00ff0100;
> +	csr_writel(pcie, value, PCI_PRIMARY_BUS);
> +
>  	/*
>  	 * program Bus Master Enable Bit in Command Register in PAB Config
>  	 * Space
> --
> 2.17.1

