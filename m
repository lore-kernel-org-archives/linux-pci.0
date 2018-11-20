Return-Path: <SRS0=4GJS=N7=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0756AC46463
	for <linux-pci@archiver.kernel.org>; Tue, 20 Nov 2018 11:27:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26A00208E3
	for <linux-pci@archiver.kernel.org>; Tue, 20 Nov 2018 11:27:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="TKFZoR4A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26A00208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729149AbeKTVzi (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 20 Nov 2018 16:55:38 -0500
Received: from mail-eopbgr140050.outbound.protection.outlook.com ([40.107.14.50]:1918
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726792AbeKTVzh (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 20 Nov 2018 16:55:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3o5a+59GFz6uHQnytENMzDhjTt+IqIX/4emKvOvyOVg=;
 b=TKFZoR4AXSTAS4+VFfqX8zc7nY5AfcAwjdSDDxNDvjCUyZUmDjUJFV21UtafPaSbx2LOhwyf1EYvealPJmVbmyPFgwjpHAn1ud9PcYI494+iYP3Sif6pkVb6cAOUJJdu3v2kYE0c7pHGFVv014AGLAE2e8sEJxmV+iwtW77kTwE=
Received: from HE1PR0401MB2235.eurprd04.prod.outlook.com (10.168.32.20) by
 HE1PR0401MB2507.eurprd04.prod.outlook.com (10.168.147.142) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.28; Tue, 20 Nov 2018 11:26:13 +0000
Received: from HE1PR0401MB2235.eurprd04.prod.outlook.com
 ([fe80::60ff:1b2a:d0fd:5bd2]) by HE1PR0401MB2235.eurprd04.prod.outlook.com
 ([fe80::60ff:1b2a:d0fd:5bd2%8]) with mapi id 15.20.1339.027; Tue, 20 Nov 2018
 11:26:13 +0000
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
Subject: RE: [PATCHv2 17/25] PCI: mobiveil: fix the checking of valid device
Thread-Topic: [PATCHv2 17/25] PCI: mobiveil: fix the checking of valid device
Thread-Index: AQHUgLM9hHaOWmproUOdCVfdWcYZ2aVYhj8Q
Date:   Tue, 20 Nov 2018 11:26:13 +0000
Message-ID: <HE1PR0401MB22354A5A97A9E871B99FD42AE8D90@HE1PR0401MB2235.eurprd04.prod.outlook.com>
References: <20181120092615.11680-1-Zhiqiang.Hou@nxp.com>
 <20181120092615.11680-18-Zhiqiang.Hou@nxp.com>
In-Reply-To: <20181120092615.11680-18-Zhiqiang.Hou@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=minghuan.lian@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HE1PR0401MB2507;6:sEEyQpNAubkqT/d4l96qWT1Rltr6Cldy5Eyvgd1piutiNDpx1897GE11u0a6445HiLxhWYT3Qaru0InnY7jitON0gqZHcBw6QosLmUYa9w3m1LIkfzMxXbYx2sJxKcXm9WLFmi4NKorjV+ohzlW1cYo8UevJoEJePFesI/tqnzjMPh2h5O9oOpvNyEZngLRs0UMtr1jtQCPU9Z6OXTRiuAO9YZyP5Ln8cmk8Bu7ce8pRuYE/1YKe7dVtHB6vnLlKfZSdOEx/5Bb3flT/murspFdUO2rgptj7v/Y9+dX9Sf4+4M34kbDqm5b0YM07GDjTNT8QFck1pLHf0FhUPwFjwzJ0MgNFHUCAzuX5OK7s2u8m1GT+GsWdMFsIWtLA9t/H7WLEUZTK61yBksGH7vu8MymO7HaOfZ6S8d+wzRRai4nN8Oa5RlaZs/I4WyOMNO7Yb/Vok5e+IrMTDbqBbwWIOA==;5:cjUkp+ugHn6YWCeDe8vt3gfne9HyP9p9ME336Im6LgNwAEO+/4kl7YSfky9QWGt/6SUiUUYC2uJVMVYQKllPn3txbvlzIYG2OmpddVvegrSxsXOYc4kLsKpF85XtnNR9FG3YWkrjDFVhUliOazgrRMunf/vw01TCHdpOIq/v2kU=;7:PL+FTBPQ6zcoUYIVVh/oxSYJi6hYiV+iIJNTkb58NOnI3hKXGhYgfYWwfaKFbWnTYlfKvRqzy9PnpJqKfzFS6OMy5jGqVFBEE59LbJeIIS11Ss+VB+ez1jjVNcpnv8t2ZvHWgB8Arqt90inp6qbSfg==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 84e48871-a321-4040-7972-08d64edafa87
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:HE1PR0401MB2507;
x-ms-traffictypediagnostic: HE1PR0401MB2507:
x-microsoft-antispam-prvs: <HE1PR0401MB25077042B68EF8E042F00656E8D90@HE1PR0401MB2507.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(258649278758335)(211936372134217)(180628864354917)(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231442)(944501410)(52105112)(10201501046)(3002001)(6055026)(148016)(149066)(150057)(6041310)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:HE1PR0401MB2507;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0401MB2507;
x-forefront-prvs: 08626BE3A5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(366004)(136003)(39860400002)(396003)(13464003)(199004)(189003)(53936002)(478600001)(54906003)(6246003)(71190400001)(71200400001)(25786009)(2501003)(110136005)(6116002)(4326008)(3846002)(66066001)(7736002)(74316002)(33656002)(68736007)(305945005)(2900100001)(2906002)(14454004)(14444005)(5024004)(256004)(106356001)(105586002)(8936002)(186003)(26005)(11346002)(446003)(486006)(86362001)(229853002)(5660300001)(99286004)(9686003)(6436002)(316002)(55016002)(76176011)(81166006)(97736004)(2201001)(7696005)(476003)(6506007)(81156014)(102836004)(53546011)(8676002)(7416002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR0401MB2507;H:HE1PR0401MB2235.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: hEtzkHv/n2z1v6CQ35t/6MU/+Q1Fvs7ohaqdWVi54igRNPtRPZ0hvoycYpJ7T18ffL/bgUBa0KitX2TiW1hm7P3JZcX5pSPB1n96lC9gHFBG9Uybds+5/uU6G8W/lJQDhdjQmZ6KYa3lwBTK6xrghwQVbuwGAQJk0dewg70OkndQhcXkPvLHs0EQ8KD+BLTT0CGRsDPRgpXfre0jkLJPf54VWMFlrBOV5Wg/KZrlx6uAMFh6+q6KdNNVVBK4ljzujRgYSIorlWL/ZSLpXXY8t3qaPDX3oiEhJcXO/OMYBvtHkuQGX7WLD2frDAGcvbsQ+NpjZd7WKpIb5fq+0u7400jT4yt0GAXTdDn/W3K/zas=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84e48871-a321-4040-7972-08d64edafa87
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2018 11:26:13.0648
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0401MB2507
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
> Subject: [PATCHv2 17/25] PCI: mobiveil: fix the checking of valid device
>=20
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
>=20
> Avoid to issue CFG transactions to link partner when the PCIe link is not=
 up.
> And allow CFG transactions to all functions of Endpoint implemented
> multiple functions.
>=20
> Fixes: 9af6bcb11e12 ("PCI: mobiveil: Add Mobiveil PCIe Host Bridge IP dri=
ver")
> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> ---
> V2:
>  - New patch
>=20
>  drivers/pci/controller/mobiveil/pcie-mobiveil-host.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
> b/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
> index dc5324d94466..1ae82e790562 100644
> --- a/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
> +++ b/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
> @@ -29,6 +29,10 @@ static bool mobiveil_pcie_valid_device(struct pci_bus
> *bus, unsigned int devfn)  {
>  	struct mobiveil_pcie *pcie =3D bus->sysdata;
>=20
> +	/* If there is no link, then there is no device */
> +	if (bus->number > pcie->rp.root_bus_nr
> && !mobiveil_pcie_link_up(pcie))
> +		return false;
> +
>  	/* Only one device down on each root port */
>  	if ((bus->number =3D=3D pcie->rp.root_bus_nr) && (devfn > 0))
>  		return false;
> @@ -37,7 +41,7 @@ static bool mobiveil_pcie_valid_device(struct pci_bus
> *bus, unsigned int devfn)
>  	 * Do not read more than one device on the bus directly
>  	 * attached to RC
>  	 */
> -	if ((bus->primary =3D=3D pcie->rp.root_bus_nr) && (devfn > 0))
> +	if ((bus->primary =3D=3D pcie->rp.root_bus_nr) && (PCI_SLOT(devfn) > 0)=
)
>  		return false;
>=20
>  	return true;
> --
> 2.17.1

