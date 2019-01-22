Return-Path: <SRS0=s1t5=P6=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86A0DC282C3
	for <linux-pci@archiver.kernel.org>; Tue, 22 Jan 2019 09:52:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40132218D0
	for <linux-pci@archiver.kernel.org>; Tue, 22 Jan 2019 09:52:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Fl4Q/GXb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727587AbfAVJwZ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 22 Jan 2019 04:52:25 -0500
Received: from mail-eopbgr00043.outbound.protection.outlook.com ([40.107.0.43]:48346
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726872AbfAVJwZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 22 Jan 2019 04:52:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oVlAvoXLimayag07LtO1Z0/o4pX5Kq+Hh5SDDaYsJdw=;
 b=Fl4Q/GXbeNHe4s1pscxnUzaVkr+DkzE2bJX0V9eUp9pJbuEDAtbSyQrwIrddOFekIywSrgBOtFwZ0dUCuzubQllxakMle6OmprtbAUL/ILQ2bE+0dIt9WSCMpo5W/k7m9usJZIyG6z+tM1vKy+g517tSZGr7Tw54HcLGJ6V6S1g=
Received: from VI1PR04MB5533.eurprd04.prod.outlook.com (20.178.122.159) by
 VI1PR04MB4782.eurprd04.prod.outlook.com (20.177.48.215) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.27; Tue, 22 Jan 2019 09:52:20 +0000
Received: from VI1PR04MB5533.eurprd04.prod.outlook.com
 ([fe80::92d:bf44:9c1d:b907]) by VI1PR04MB5533.eurprd04.prod.outlook.com
 ([fe80::92d:bf44:9c1d:b907%6]) with mapi id 15.20.1537.031; Tue, 22 Jan 2019
 09:52:20 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
CC:     Ulf Hansson <ulf.hansson@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "Lukas F . Hartmann" <lukas@mntmn.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Jon Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH 1/2] PCI: imx: Fix probe failure without power domain
Thread-Topic: [PATCH 1/2] PCI: imx: Fix probe failure without power domain
Thread-Index: AQHUsdumnhpLtdU11UCqN+1L30Gg6Q==
Date:   Tue, 22 Jan 2019 09:52:20 +0000
Message-ID: <VI1PR04MB5533FD41536472C64A4A5559EE980@VI1PR04MB5533.eurprd04.prod.outlook.com>
References: <cover.1548110502.git.leonard.crestez@nxp.com>
 <375a852ae9170a5f8f53fdd364a7fb7ea642e89c.1548110502.git.leonard.crestez@nxp.com>
 <20190122071251.tgdwnunxksa45n5q@pengutronix.de>
 <VI1PR04MB5533DE236150B01461555A5BEE980@VI1PR04MB5533.eurprd04.prod.outlook.com>
 <20190122094430.rg76mkemz5wvk5t3@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [85.204.4.237]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB4782;6:lLyxrgcJsUhY8UcXTlw2b6qmJU7+rN3/DNA/SnI0BX3zyN951Hz+3PRUOxrMSYbmBuNh7OV0437grMkWuWPt8U23qOBspIWs3xW6QEzaDgTxxGReFjBFcm4tFvaQ8NqMWt2DUgDmCUiFC5u8Ap97NzISNHg33UiAmersiikAziUvvTwdZT2nz9p4/Qg3MUWaJYZxHZCGfclV6xV88U/nG/vOZfHFPT2JIYl6Fpl8lBittfwA+pUoSPrJqpgDULmIuv3SXNM8pK65UPZE/kRiWMc3QvvsVSbrBvli/bBlUZrns36fDTEBE0EtAE9praT5lRdFk6VvyDuOyUKPUvRywx1KF//Fy6l3Y8K8b6IEqkvOD120BGe/WB5daZ3VBpUGHHQ3gCloqc/WRwBaG7vFbR0dqSMOlv9fsfrGzXfscaQhDX6vcfnkf2repwBuaDAQx5dBnewndNNY3am73gMsog==;5:Eer8Bg1yUN+YYhpw/qLKpGGwemPL+BHav+5kHK06yeuO8jGzbg0RyKkUySzVMlwxDQmNSvEdFqQyZwCbyYbQ/VoGSVNKZfjzoDtI9zHwPiTXpHdYTvNN25l/cj5uuxTgadCZc6Pe3CvYG+b0E+kVigHZvzT0axj/L5sAETVQiG4Od/EZ0uHCSJYniRNcCpN3Q3hGPedN4ORKfNk7Xz+OCw==;7:jwcsJMLwrGvfvAP84hzsLo38h0kTrjsBUkTZaiv+e93E/6Cs8u6HM9A9pNAAJVcgoJBBTCAu5I7YlXCQFPpoCTvwdaFS4lo+WzHjGyGhrS0gC+Fh/K/q4hSwNFwed8F2yLuuAtlWOz5wqu9BzYAyLg==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: d6a65575-1be8-4ed6-b7e6-08d6804f4d0c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB4782;
x-ms-traffictypediagnostic: VI1PR04MB4782:
x-microsoft-antispam-prvs: <VI1PR04MB478270DA6AB777DA87470BF5EE980@VI1PR04MB4782.eurprd04.prod.outlook.com>
x-forefront-prvs: 0925081676
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(396003)(376002)(136003)(346002)(199004)(189003)(6436002)(105586002)(9686003)(6116002)(102836004)(305945005)(53936002)(53546011)(6506007)(3846002)(7736002)(106356001)(25786009)(256004)(86362001)(5024004)(486006)(7416002)(33656002)(81166006)(81156014)(8676002)(54906003)(478600001)(71200400001)(71190400001)(66066001)(68736007)(97736004)(7696005)(4326008)(99286004)(76176011)(229853002)(44832011)(8936002)(14454004)(55016002)(186003)(74316002)(2906002)(26005)(316002)(6246003)(476003)(93886005)(446003)(6916009);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4782;H:VI1PR04MB5533.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: R0hsDpAyJG5HGSFDGosYOu2LTZAxwG5bUi/mbYYb69dydSn/hXRx6GlOEe8IZBeyfsdKRCT2OnEAAwN5BZOw8o16hNmtMn0krlYcMPVsLZFD0t0cyg+2hPlWdPHeTSyepcOnM8pI1vnTLQ6hnSl0NAoPEOa+0ODV/Rx+4nvgORpuSLWl6gAoqcwkclUm6OTXEdmMpttIaKUZgno3CdposP56kiFwz7ODhQ5joJb8RMRKMVNDvNkGKmIz7YSeEot04856FQbWq/TTYvJMu/5wI8bArPZUToDrtZFOIE0mZtkSkfIpxUkKELZaKiKHkexLNp3ANNQV1lTH814SVjud0N39buE2fBCV1aKYxYj9u1xMUpdmGUbzTiIoGY6J0McE6I17KR/jChSVI/WtvD1K6kSIUBeJ8mW0WxBdLbCQAGk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6a65575-1be8-4ed6-b7e6-08d6804f4d0c
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2019 09:52:20.1994
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4782
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 1/22/19 11:44 AM, Uwe Kleine-K=F6nig wrote:=0A=
> On Tue, Jan 22, 2019 at 09:17:22AM +0000, Leonard Crestez wrote:=0A=
>> On 1/22/2019 9:12 AM, Uwe Kleine-K=F6nig wrote:=0A=
>>> On Mon, Jan 21, 2019 at 10:50:04PM +0000, Leonard Crestez wrote:=0A=
>>>> On chips without a separate power domain for PCI (such as 6q/6qp) the=
=0A=
>>>> imx6_pcie_attach_pd function incorrectly returns an error.=0A=
>>>>=0A=
>>>> Fix by returning 0 if dev_pm_domain_attach_by_name doesn't find=0A=
>>>> anything.=0A=
>>>>=0A=
>>>> Fixes: 3f7cceeab895 ("PCI: imx: Add multi-pd support")=0A=
>>>>=0A=
>>>> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/contr=
oller/dwc/pci-imx6.c=0A=
>>>> @@ -308,10 +308,13 @@ static int imx6_pcie_attach_pd(struct device *de=
v)=0A=
>>>>    		return 0;=0A=
>>>>    =0A=
>>>>    imx6_pcie->pd_pcie =3D dev_pm_domain_attach_by_name(dev, "pcie");=
=0A=
>>>>    if (IS_ERR(imx6_pcie->pd_pcie))=0A=
>>>>    	return PTR_ERR(imx6_pcie->pd_pcie);=0A=
>>>> +	/* Do nothing when power domain missing */=0A=
>>>> +	if (!imx6_pcie->pd_pcie)=0A=
>>>> +		return 0;=0A=
>>>=0A=
>>> As I said in the mail that proposed this patch for testing: I think it=
=0A=
>>> would be better to change dev_pm_domain_attach_by_name to not return an=
=0A=
>>> error indication by returning NULL or an ERR_PTR value. (Or change=0A=
>>> device_link_add to accept NULL if NULL is a dummy value.)=0A=
>>=0A=
>> I'm not sure what you mean. Should dev_pm_domain_attach_by_name return=
=0A=
>> ERR_PTR(-ENOENT) for name not found? It would still require special=0A=
>> handling for callers.=0A=
> =0A=
> Yes, callers would still need to handle an error, but they only need to=
=0A=
> check for IS_ERR(retval) instead of IS_ERR(retval) && retval !=3D NULL.=
=0A=
=0A=
But "not found" is not treated as an error here, it's what happens when =0A=
no PD is assigned. The fix makes imx6_pcie_attach_pd return success in =0A=
this case.=0A=
=0A=
Making dev_pm_domain_attach_by_name return ENOENT would still require a =0A=
special case for ENOENT here.=0A=
=0A=
--=0A=
Regards,=0A=
Leonard=0A=
