Return-Path: <SRS0=4GJS=N7=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0388AC46465
	for <linux-pci@archiver.kernel.org>; Tue, 20 Nov 2018 10:35:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B06FC208E4
	for <linux-pci@archiver.kernel.org>; Tue, 20 Nov 2018 10:35:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Bf6q3E35"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B06FC208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728516AbeKTVES (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 20 Nov 2018 16:04:18 -0500
Received: from mail-eopbgr140077.outbound.protection.outlook.com ([40.107.14.77]:51778
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728336AbeKTVER (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 20 Nov 2018 16:04:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A8sc+A80r6el7lQhzIKrAQvm1wcBZSe2gjrYtRVH41c=;
 b=Bf6q3E35ewEpm6FRWczidUp3EPZ8s0ihvu2zTMX9P+bj/VnFEA+Sr3Hta0rD/nQM7iPodL4RdLiQea39wcypwP/iuxz7w0ebt/STLYy4ZvIp2QiDpsHTcjVGnpR/iXaHA2zuwxFPl0xE6dmn2/NV994F68fz47Z9hbHadsWDAAs=
Received: from HE1PR0401MB2235.eurprd04.prod.outlook.com (10.168.32.20) by
 HE1PR0401MB1851.eurprd04.prod.outlook.com (10.169.119.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1339.23; Tue, 20 Nov 2018 10:35:02 +0000
Received: from HE1PR0401MB2235.eurprd04.prod.outlook.com
 ([fe80::60ff:1b2a:d0fd:5bd2]) by HE1PR0401MB2235.eurprd04.prod.outlook.com
 ([fe80::60ff:1b2a:d0fd:5bd2%8]) with mapi id 15.20.1339.027; Tue, 20 Nov 2018
 10:35:01 +0000
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
Subject: RE: [PATCHv2 06/25] PCI: mobiveil: replace the resource list
 iteration function
Thread-Topic: [PATCHv2 06/25] PCI: mobiveil: replace the resource list
 iteration function
Thread-Index: AQHUgLMUuse19e43yUq2Mjt2cp9Q4aVYd/Lg
Date:   Tue, 20 Nov 2018 10:35:01 +0000
Message-ID: <HE1PR0401MB2235225683B36894815AA75DE8D90@HE1PR0401MB2235.eurprd04.prod.outlook.com>
References: <20181120092615.11680-1-Zhiqiang.Hou@nxp.com>
 <20181120092615.11680-7-Zhiqiang.Hou@nxp.com>
In-Reply-To: <20181120092615.11680-7-Zhiqiang.Hou@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=minghuan.lian@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HE1PR0401MB1851;6:oaBrV2PMhV4pWbIrnk4e2NH+Y/uJjuIFcWvHRRZIB+68CcUb1zfKuQnkbp/R/qrEL/WhNWsZVYWiAvNdash3rOhFv0JKXOqbcBwZ9renO78pXC0M7nJnXUo3mRFPq/c/dojazDcvWTvfRV+sjwtlxXZIDlcRhPhmeDUPN5FcA9ljjrvrzRBDuVvJqFQkaqj4LrEqk3jpum8rHrMSbYwvsdDJh4akUPE0wgyin/dTCoowsksLOUX026iJlIMI+4pq7RPxhvvH8OZvfEjdLgJZfoR2SykDlDckn0D1Vyy6A9o6VGk57XjrsZ5AxCdPSABIMLx0cNGWN4tdfKXlodLLgb1NqC/bhQ5diYK1//3/27wKviU0ZmaGiUGl0SThxGgRLT0pklpJ1/nUuH4VEAquwkv0SuQ0x5TQJ4TN4fO1L8vm4gvkKps1lm/qU1L13TAnCfYd9xDJOfZMOKgjFUHJVA==;5:dyJ7g1MJeVZFyfKqgM9+Tx9Io8A2KG1V6iBelFSy5je5DP5fGIq3yJV9iSpWNlKoEjEfxLf15lAyPewVZbLTn2P1ZKQk09SU8CjVGGcwxMdcl7trDXrSPpS+Xq00zn23wsC4+Sg1Ojoo7+EnEb4CWWkuBHyay/3vOPQJnTGSY+g=;7:hvik5QaGyi1wGCamlwk4K+mMmx0epyK2RJtNIW+T7nEdlp+5PEwJOwplJH9OKtPMApz/r18dEyOgpeBgn57iK1BCubOJJEZEbNLEuySuCHo8nuHZJXUdA0uOR2E8u2dI3h47S5W9CjZWEsWkUGrddg==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 60a8c23d-4f73-4094-9ae1-08d64ed3d3c0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:HE1PR0401MB1851;
x-ms-traffictypediagnostic: HE1PR0401MB1851:
x-microsoft-antispam-prvs: <HE1PR0401MB18514727D3C9FCF20479901EE8D90@HE1PR0401MB1851.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231442)(944501410)(52105112)(3002001)(10201501046)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:HE1PR0401MB1851;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0401MB1851;
x-forefront-prvs: 08626BE3A5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(39860400002)(366004)(396003)(136003)(376002)(346002)(13464003)(189003)(199004)(53546011)(105586002)(6506007)(7416002)(229853002)(2900100001)(66066001)(106356001)(76176011)(26005)(6436002)(5660300001)(305945005)(7696005)(2201001)(86362001)(74316002)(102836004)(97736004)(99286004)(316002)(186003)(478600001)(68736007)(2501003)(3846002)(256004)(14444005)(8936002)(81156014)(81166006)(8676002)(11346002)(33656002)(55016002)(446003)(6116002)(2906002)(110136005)(71200400001)(71190400001)(7736002)(9686003)(476003)(14454004)(4326008)(54906003)(6246003)(53936002)(486006)(25786009)(921003)(1121003)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR0401MB1851;H:HE1PR0401MB2235.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: UctycY70YfX35T6A//AticH+DRQjsV6ONti0jB+tMe2k1SBcyLpoXi5r3W3dypVs/S/ifnykFPwwci+DlldOASQIwoEIClqKkAj9r9tZpKMla14Dgg9Vi9KBvl+sYQzC3c3wzRDDZOyvdKOvPGSoH5HZLDHgI85txWG6fJtxVQuYQ4UVb5IikB+OECndaxSNfNVUYyZySfjsGSaXgFT+376F1pXMlmpEZvm0Rv3HtSEutmFtOkP17EPcSKQMuf/hXbQQIqTfsCL2eaINSjXIObTq4Zoi0At4YrnBvDTO4G9ZX0oQIKsd87ATaW77UWYce45joxWHYJQgwHxnIXNGs1tgHXJhTjFREcgefEaRF84=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60a8c23d-4f73-4094-9ae1-08d64ed3d3c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2018 10:35:01.5309
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0401MB1851
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
> Subject: [PATCHv2 06/25] PCI: mobiveil: replace the resource list iterati=
on
> function
>=20
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
>=20
> As it won't delete any node in this iteration, replaced the function
> resource_list_for_each_entry_safe() with the resource_list_for_each_entry=
().
>=20
> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> ---
> V2:
>  - no change
>=20
>  drivers/pci/controller/pcie-mobiveil.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/pci/controller/pcie-mobiveil.c
> b/drivers/pci/controller/pcie-mobiveil.c
> index 8ff873023b5f..b2cc9c097fc9 100644
> --- a/drivers/pci/controller/pcie-mobiveil.c
> +++ b/drivers/pci/controller/pcie-mobiveil.c
> @@ -569,7 +569,7 @@ static int mobiveil_host_init(struct mobiveil_pcie
> *pcie)  {
>  	u32 value, pab_ctrl, type;
>  	int err;
> -	struct resource_entry *win, *tmp;
> +	struct resource_entry *win;
>=20
>  	err =3D mobiveil_bringup_link(pcie);
>  	if (err) {
> @@ -620,7 +620,7 @@ static int mobiveil_host_init(struct mobiveil_pcie
> *pcie)
>  	program_ib_windows(pcie, WIN_NUM_1, 0, MEM_WINDOW_TYPE,
> IB_WIN_SIZE);
>=20
>  	/* Get the I/O and memory ranges from DT */
> -	resource_list_for_each_entry_safe(win, tmp, &pcie->resources) {
> +	resource_list_for_each_entry(win, &pcie->resources) {
>  		if (resource_type(win->res) =3D=3D IORESOURCE_MEM)
>  			type =3D MEM_WINDOW_TYPE;
>  		else if (resource_type(win->res) =3D=3D IORESOURCE_IO)
> --
> 2.17.1

