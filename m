Return-Path: <SRS0=4GJS=N7=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E14AC41537
	for <linux-pci@archiver.kernel.org>; Tue, 20 Nov 2018 10:36:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D1CA20671
	for <linux-pci@archiver.kernel.org>; Tue, 20 Nov 2018 10:36:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="tPeGMswc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D1CA20671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbeKTVEk (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 20 Nov 2018 16:04:40 -0500
Received: from mail-eopbgr60060.outbound.protection.outlook.com ([40.107.6.60]:51693
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728119AbeKTVEk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 20 Nov 2018 16:04:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7bOvrTgZcxR1pGK0UVBSa7wpeUa1MpQm9DcGBmINqPc=;
 b=tPeGMswcfmqIjQ90bEGrqt1Ok2sVOsRIGCdg71+YwXO2eFS1IL1I0nz5vrSakmcu2MKCy/zLW5yU8SWOc0+sM6Wnm7hVrHD+lBYq9035NjM9TvPhVpxDSKBBs1ot0MM89XOWn56CmWjolovdejj87zLj0+G9Vh9VkoMlgbjywPQ=
Received: from HE1PR0401MB2235.eurprd04.prod.outlook.com (10.168.32.20) by
 HE1PR0401MB1884.eurprd04.prod.outlook.com (10.166.122.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1339.23; Tue, 20 Nov 2018 10:35:28 +0000
Received: from HE1PR0401MB2235.eurprd04.prod.outlook.com
 ([fe80::60ff:1b2a:d0fd:5bd2]) by HE1PR0401MB2235.eurprd04.prod.outlook.com
 ([fe80::60ff:1b2a:d0fd:5bd2%8]) with mapi id 15.20.1339.027; Tue, 20 Nov 2018
 10:35:28 +0000
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
Subject: RE: [PATCHv2 07/25] PCI: mobiveil: use WIN_NUM_0 explicitly for CFG
 outbound window
Thread-Topic: [PATCHv2 07/25] PCI: mobiveil: use WIN_NUM_0 explicitly for CFG
 outbound window
Thread-Index: AQHUgLMYVvtpvt2HK0G434t0xXdQBKVYeBJQ
Date:   Tue, 20 Nov 2018 10:35:27 +0000
Message-ID: <HE1PR0401MB223579F27C305AD96ABC4202E8D90@HE1PR0401MB2235.eurprd04.prod.outlook.com>
References: <20181120092615.11680-1-Zhiqiang.Hou@nxp.com>
 <20181120092615.11680-8-Zhiqiang.Hou@nxp.com>
In-Reply-To: <20181120092615.11680-8-Zhiqiang.Hou@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=minghuan.lian@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HE1PR0401MB1884;6:Y59aPeX3pqATfG+MKQVk9EpNqinndwJSdkBTb4n3+RGPHKVwh08T65N8F3vtAlymzsZW81BrEKIV3gfmP/ME04F7FtU4LZKBx+6eaAE7uE/oFplDbRIIbbRSncUwRbOaMCh+Sx5bYAYfYCToHaVG3t3UsAXDbxijaWunqkNiQlXYYluznuIJFfQwe9WKDLxj0xMv3DH9452dBTof3Z/803gUgtLHkdwKYvqi9UHRRw/kkag5/1aCbVJn37ZbfHYBJfusVr/26O3Qi36cLfgyrwCs5c19mc91K0NWSTl3RSuzeTYH0MD2QZRXvV6jI9ZL9C6vjbfyOj/iUpaObt84BwidaXRSRCVcuXx3joHoyM+HXMKWpl9qyNCL5IjYJO0CDWAgiAPba1OFnL2UNYyIh+FcDULEkI7lBM7JG3UdWqBtut6EorqL+OjvwUGXR29l76RGy2ODuTE2lk0Is+ANcfIttGQ/lbrAkVM1EMg7V2Q=;5:5i0T2j5mP39mPciZ8tyQ502RFQRj4pDQiCSY8GvFkVvy7hHNwH7+QduQLbcbTBh1WOYhiZHEYoiPKhGZgXMkQctfqMQr36Y2ouOZLTSG929Hp+5z2Hrx7HlYdJFQHOiiyYWR9bvPJmTMZqEu5bSBlqmGu4vg0NktAcjXiF79R+g=;7:fL9Lnf0LZR4IWVeHjUmDIQTNGY3ix7YiqC9lBtK8grXU9gi+xC9lFkSI7OhcmSCo5CM9xdIGN1fXwRBX8N47iL/BwakFM104PuY4RLvdKrDqG6jshRMM8wpfDjJxYSX+uuM7sKxX4EWcUjwaXMpH/w==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: a8ae165c-a4e5-4162-abba-08d64ed3e382
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:HE1PR0401MB1884;
x-ms-traffictypediagnostic: HE1PR0401MB1884:
x-microsoft-antispam-prvs: <HE1PR0401MB1884DA40C4D7089B5E97B0F8E8D90@HE1PR0401MB1884.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231442)(944501410)(52105112)(10201501046)(3002001)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:HE1PR0401MB1884;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0401MB1884;
x-forefront-prvs: 08626BE3A5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(39860400002)(136003)(366004)(396003)(189003)(199004)(13464003)(26005)(6116002)(3846002)(102836004)(14454004)(66066001)(53936002)(186003)(6246003)(106356001)(8936002)(81156014)(81166006)(316002)(54906003)(478600001)(6506007)(4326008)(76176011)(8676002)(53546011)(33656002)(99286004)(68736007)(7696005)(25786009)(229853002)(2900100001)(7416002)(97736004)(110136005)(74316002)(256004)(7736002)(2201001)(71200400001)(305945005)(105586002)(71190400001)(5660300001)(11346002)(476003)(446003)(486006)(86362001)(2501003)(2906002)(55016002)(6436002)(9686003)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR0401MB1884;H:HE1PR0401MB2235.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: zTlvzralXgtxDHKFisg3Qm0GHkMEpfe4EEP5KDCBe4J698+AMyXhNNkTFd6YHcUxOKbnOCY6FGg0+9zCcAjoudH3NGjImJpRwqQhEkoXKPNBKS8qfivOix8ph2BnPNoH4KNI1TT+dXT1cdQJFFyuGOxM/ph8Oh1RvnHw783iNeUjrcRIU1eE9HP5/G1+IoJT/iiKwzt+Ba2GCLHc9XFgbcO6wHLZWFmfWMJZC2rugB2nn4vSc/YZC4P94RY1pDsWWiaCvp4rVGz93RCqfjgoHTgIX5vjWQzAbm+LrKDc346Y43RjxaWdenlL31WPe51fsQfXT0l+i4CrWuUrN8ArX9nxF0pBNDh3bTHTQ2M4xIU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8ae165c-a4e5-4162-abba-08d64ed3e382
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2018 10:35:27.9686
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0401MB1884
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

reviewed-by: Minghuan Lian <Minghuan.Lian@nxp.com>

> -----Original Message-----
> From: Z.q. Hou
> Sent: Tuesday, November 20, 2018 5:26 PM
> To: linux-pci@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org;
> bhelgaas@google.com; robh+dt@kernel.org; mark.rutland@arm.com;
> l.subrahmanya@mobiveil.co.in; shawnguo@kernel.org; Leo Li
> <leoyang.li@nxp.com>; lorenzo.pieralisi@arm.com;
> catalin.marinas@arm.com; will.deacon@arm.com
> Cc: Mingkai Hu <mingkai.hu@nxp.com>; M.h. Lian
> <minghuan.lian@nxp.com>; Xiaowei Bao <xiaowei.bao@nxp.com>; Z.q. Hou
> <zhiqiang.hou@nxp.com>
> Subject: [PATCHv2 07/25] PCI: mobiveil: use WIN_NUM_0 explicitly for CFG
> outbound window
>=20
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
>=20
> As the .map_bus() use the WIN_NUM_0 for CFG transactions, it's better
> passing WIN_NUM_0 explicitly when initialize the CFG outbound window.
>=20
> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> ---
> V2:
>  - no change
>=20
>  drivers/pci/controller/pcie-mobiveil.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/pci/controller/pcie-mobiveil.c
> b/drivers/pci/controller/pcie-mobiveil.c
> index b2cc9c097fc9..df71c11b4810 100644
> --- a/drivers/pci/controller/pcie-mobiveil.c
> +++ b/drivers/pci/controller/pcie-mobiveil.c
> @@ -612,9 +612,8 @@ static int mobiveil_host_init(struct mobiveil_pcie
> *pcie)
>  	 */
>=20
>  	/* config outbound translation window */
> -	program_ob_windows(pcie, pcie->ob_wins_configured,
> -			   pcie->ob_io_res->start, 0, CFG_WINDOW_TYPE,
> -			   resource_size(pcie->ob_io_res));
> +	program_ob_windows(pcie, WIN_NUM_0, pcie->ob_io_res->start, 0,
> +			   CFG_WINDOW_TYPE, resource_size(pcie-
> >ob_io_res));
>=20
>  	/* memory inbound translation window */
>  	program_ib_windows(pcie, WIN_NUM_1, 0, MEM_WINDOW_TYPE,
> IB_WIN_SIZE);
> --
> 2.17.1

