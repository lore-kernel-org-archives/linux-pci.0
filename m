Return-Path: <SRS0=4GJS=N7=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6C45C4161D
	for <linux-pci@archiver.kernel.org>; Tue, 20 Nov 2018 11:25:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F48C208E4
	for <linux-pci@archiver.kernel.org>; Tue, 20 Nov 2018 11:25:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="h0gUPNxT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F48C208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728896AbeKTVxi (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 20 Nov 2018 16:53:38 -0500
Received: from mail-eopbgr00088.outbound.protection.outlook.com ([40.107.0.88]:5422
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726792AbeKTVxi (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 20 Nov 2018 16:53:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dg5YUHqdieceX+qPlYbex5tKwy+MIBpSBvhHOBTdR1k=;
 b=h0gUPNxTFvtM5pb+pq6LVFL+x19h0ZRHvSkj/NtxBkRDO461sGj3s99e8AvhnMpQ/sE7d8albAeAWU3MLmAYjscWnvrZETV5W0wxsNSJT/3+K0lTpZ8jySfb51v4AwgAxvLUZoP33H/PbNABmmi37CIyvnNC8w8ABqj7wZuZbv0=
Received: from HE1PR0401MB2235.eurprd04.prod.outlook.com (10.168.32.20) by
 HE1PR0401MB1996.eurprd04.prod.outlook.com (10.166.122.146) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1339.26; Tue, 20 Nov 2018 11:24:53 +0000
Received: from HE1PR0401MB2235.eurprd04.prod.outlook.com
 ([fe80::60ff:1b2a:d0fd:5bd2]) by HE1PR0401MB2235.eurprd04.prod.outlook.com
 ([fe80::60ff:1b2a:d0fd:5bd2%8]) with mapi id 15.20.1339.027; Tue, 20 Nov 2018
 11:24:53 +0000
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
Thread-Index: AQHUgLMyZ11mQet0XEKQKM3OcVjbMqVYhd7Q
Date:   Tue, 20 Nov 2018 11:24:53 +0000
Message-ID: <HE1PR0401MB22353443B478CFD95466B664E8D90@HE1PR0401MB2235.eurprd04.prod.outlook.com>
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
x-microsoft-exchange-diagnostics: 1;HE1PR0401MB1996;6:IkXsFy4Vbf4fz+8Dwco9yvdxyr0tsOQQfC7q28HVj1KhVoeFtjwbBYMFUZrvDgAekfz1kUwikPpLxdkB4OdU405zBT8Tt43980ilYjgsvrE5WHdg4RI2z5w0OYXHaYp6R65yCxsvfAgWOtlCyV1kMcq1FXsLhNVap2KcPMUhsJHHgYhzhimyyl9R7rWlFv41e4tAV1ZsX4c77sUaOFcZ7q3tB5oQlMkE5c9w4u6xSmSQADVQ8iad0Z5Zmofi7rl7G9Od4iYHUY0kADyBFDTOBohmtlK5O6TbRk0fQuOTTlmRHpAyaaHJ0T4fI7iwycemTKhCTNtNDrO5j1wu5ackQQH6l67BQb8gJ1J47RaUc0VG84+46kuX4n7CfYu5SHpBKdgoXuWX3Cb/13CjUBCrPKCiuj2wMQhp6/QAcQHyyCnyf9wbiwtBFUtS4aT79+U2RFkuZA+cNuCA2xkkenFOE1FpcLvPVJaltmlDsQTKYTE=;5:OtHSb4PhnzqD5XtdBIqk2KjnAqidqUyzM0fb1RGYdZ5ki/NiFfO0h1UDGhl6YgwIx2afK6gz0H4aaoJ51IEaukY2UlEhnE/YYK2IJ5P6BTV5W5A/D4JY5ZTwaJ7PQXbsqM8YxATOjhwZ2hCJnFe57x6+UhSGP+5J3kCrW/ifcak=;7:m2CtkjW/QlRdDhCoJ6XMRBnkwN1/y5Mkyu8vO6T69vxgU3eTLJru04LjIrruHB8PE62DvarxPFUxPYYlikWLlSWoO1LOnPA4Bg5o9d28VJost7EgkvWEYNVwwRPFf0uh6QYY/6kxxzHoblEzLsDQVA==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 02531f20-17cf-4cef-9195-08d64edacb3c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:HE1PR0401MB1996;
x-ms-traffictypediagnostic: HE1PR0401MB1996:
x-microsoft-antispam-prvs: <HE1PR0401MB19966F588932F7B48CC1CF68E8D90@HE1PR0401MB1996.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231442)(944501410)(52105112)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:HE1PR0401MB1996;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0401MB1996;
x-forefront-prvs: 08626BE3A5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(396003)(376002)(346002)(366004)(199004)(189003)(13464003)(53546011)(6506007)(105586002)(14454004)(102836004)(3846002)(26005)(106356001)(478600001)(6116002)(4326008)(33656002)(476003)(256004)(5660300001)(11346002)(7416002)(446003)(2900100001)(81156014)(486006)(7736002)(186003)(8676002)(81166006)(2906002)(6246003)(8936002)(305945005)(6436002)(316002)(110136005)(97736004)(71190400001)(71200400001)(2501003)(55016002)(54906003)(53936002)(25786009)(68736007)(2201001)(76176011)(99286004)(86362001)(74316002)(229853002)(7696005)(66066001)(9686003)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR0401MB1996;H:HE1PR0401MB2235.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: LVO5mK4vv8XW9nXoIJSvzIxet+FtaSECi5VTKAICml6URRKnv2VM/I6jGtVjVfZ9m/CnwE1mOMhr9n+pJ1Ue30y0uJFtSJ+U8xK4APZJiJH64nA/1M6taYvLZmuJJEqQl2nw5/wYQ3AIZv4MTHLQMZeggMnPOAQButZ/3+rdPA0QLOeDCpGGNGPpBXe9f7ZMouQ5qnl6A1GP5SYK6byUlqcsxN4A1mt4RaaiSXh4bcSkDrUrYpXTW/mharhlTYrqbcebhwCUuMBFSB1ODBf5u8XEZavTzDsJVKTMoYU5WwnSQrMyt8Ptx8Gs57GqcVedEq/V5fPPdW6UeOmIwVxWdk4fAxVWjh6Rgz1u1Gkz1EY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02531f20-17cf-4cef-9195-08d64edacb3c
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2018 11:24:53.7366
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0401MB1996
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

