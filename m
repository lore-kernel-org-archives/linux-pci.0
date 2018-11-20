Return-Path: <SRS0=4GJS=N7=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AB12C41536
	for <linux-pci@archiver.kernel.org>; Tue, 20 Nov 2018 10:35:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14A2620671
	for <linux-pci@archiver.kernel.org>; Tue, 20 Nov 2018 10:35:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Jm8QYxw0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14A2620671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728473AbeKTVDe (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 20 Nov 2018 16:03:34 -0500
Received: from mail-eopbgr60051.outbound.protection.outlook.com ([40.107.6.51]:59771
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726569AbeKTVDe (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 20 Nov 2018 16:03:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tsVM6OvNopiZVZShFA5ESQPdDgIWP+pxhO+ofU+3fh8=;
 b=Jm8QYxw0ez1zVMhn6zngGwcxY8+xDvGRPjz2JS1znpn3JfhyL8iyHlormDO93c0Ikj4gdzXQHIy9HnyABtBBnp3QmV8elNRnr2KwbCEaGf1RXvJID8tfRX5o57KqgD9RlcnIP+WKZ9WHMu5qFzBy4UBF8/qjwG70dQB7fPmYI38=
Received: from HE1PR0401MB2235.eurprd04.prod.outlook.com (10.168.32.20) by
 HE1PR0401MB2667.eurprd04.prod.outlook.com (10.168.148.148) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1339.26; Tue, 20 Nov 2018 10:34:23 +0000
Received: from HE1PR0401MB2235.eurprd04.prod.outlook.com
 ([fe80::60ff:1b2a:d0fd:5bd2]) by HE1PR0401MB2235.eurprd04.prod.outlook.com
 ([fe80::60ff:1b2a:d0fd:5bd2%8]) with mapi id 15.20.1339.027; Tue, 20 Nov 2018
 10:34:23 +0000
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
Subject: RE: [PATCHv2 05/25] PCI: mobiveil: correct PCI base address in MEM/IO
 outbound windows
Thread-Topic: [PATCHv2 05/25] PCI: mobiveil: correct PCI base address in
 MEM/IO outbound windows
Thread-Index: AQHUgLMQsrQshiueh0e3aoUcxeibAqVYd8VA
Date:   Tue, 20 Nov 2018 10:34:23 +0000
Message-ID: <HE1PR0401MB2235D9D485A1CC090CC6C6D3E8D90@HE1PR0401MB2235.eurprd04.prod.outlook.com>
References: <20181120092615.11680-1-Zhiqiang.Hou@nxp.com>
 <20181120092615.11680-6-Zhiqiang.Hou@nxp.com>
In-Reply-To: <20181120092615.11680-6-Zhiqiang.Hou@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=minghuan.lian@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HE1PR0401MB2667;6:7gmjD1C6NomxgM3Fc2qL3+qaj01XTRwQa0V/6Ak6dgg/+0M8SsYBAG8cFdBrKAOZ+keRNJsLSRaSsrBc7uSHaFnP65gnE/Ep5bSLHyJbqQNsHprbTXW5LIeM+v03FdSAZnGZWcl5pIefr4cGlR6OQdYvAjyipsR2Wx3HByfLblTfB/A8qY4kV7VqdvMUNKAWFzDpKB8EPnI9wx9JGSukRNbG4DM8/2dcj3eg3+ba2Ihk7HD3nqw3Wiy5Zy2x/GVwsfa9kkipzcLzOKqAPW5ebwnmSDinClXRSWyvNV7aGp2p2rem7rCwqqqwyzrBTum2EwMLbOA69tj8OHopxz6zfVu+4NEaS4oOD9lK/cbwc6RIU4Ev/XXY450NtNnlA6p0mu8rOS+1pRw7EW3fdWtD/oW3GqEG7y18m63n5ckeAUmt9Crw4r9YK/VzKMNZZml+qX5nnxlCLWTF6EZr2kCtUA==;5:/cSGoPqKg69GhR2cNauYouoX9DkcPVQ+nGEzV04A7qFDshTA86n8kN6GEzHKVeqZ5AfVoCrXXutJ29FSElByXLv+1XseatqAcIhI2HT32if7tit5+r5S18fdUU9/Yj5ea7QFJr8nKEWhFkDUUq09PCot0SSkwesjU65bbZSZjdk=;7:AoJEMamPsazhLFXpTXRaBnfdl6WTlSPw4D7hyBlYcrt35LLB7rspjwnDKLiIldilINd5cT1/n6VEdg1+N2IdRnq1OWnSwEI6ymT3dy+Y/ulTnyR4afalRSIXqNBWgj8qwVBMbPvx0gStbq99Gi/9AA==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 82f5197e-298a-43f4-3afd-08d64ed3bd1a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:HE1PR0401MB2667;
x-ms-traffictypediagnostic: HE1PR0401MB2667:
x-microsoft-antispam-prvs: <HE1PR0401MB2667A93600E80ECE09079E14E8D90@HE1PR0401MB2667.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231442)(944501410)(52105112)(10201501046)(3002001)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:HE1PR0401MB2667;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0401MB2667;
x-forefront-prvs: 08626BE3A5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(396003)(346002)(136003)(376002)(13464003)(199004)(189003)(6246003)(33656002)(105586002)(2900100001)(8676002)(81166006)(478600001)(4326008)(81156014)(106356001)(25786009)(6116002)(3846002)(2906002)(229853002)(8936002)(14454004)(7696005)(71190400001)(71200400001)(9686003)(256004)(53936002)(6436002)(7736002)(5660300001)(55016002)(305945005)(68736007)(486006)(74316002)(476003)(99286004)(11346002)(446003)(76176011)(110136005)(186003)(54906003)(66066001)(316002)(6506007)(53546011)(86362001)(575784001)(7416002)(2201001)(26005)(2501003)(97736004)(102836004)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR0401MB2667;H:HE1PR0401MB2235.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 2J8zj/gPo4Aiknch1Al/g5i1V3qmQ6B/zETtD7jUMY93/TKJG0Yr/lPyCy+mcmcHqncTte4vVHTP9rfuy8KFlnP3EqWpxWXjuGPS7lR+V5RcDhwtb1YQ9CX8SE4BoyPJAZws07bceFpbBdP2J7txObfrgdRtjO4/cf7LbA0iFRGhEB+nl9tc7oS94vABED9AdqfIvS1z2lUJETmmi9SZkrhqr+pgdAjb06CS6mq2FYqcODfI9ijZRHUVjr/8ozzlCbHowb6j6P+fL1WBIlecxiBHg+h+tLIqgLBXS/JA/nYJe19FoIfkbHepSP9d/3HDcjG7w4+Jvbm5VAlEhpRrnEzfocKVcNEBpZcxnbOpz70=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82f5197e-298a-43f4-3afd-08d64ed3bd1a
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2018 10:34:23.5307
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0401MB2667
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
> Subject: [PATCHv2 05/25] PCI: mobiveil: correct PCI base address in MEM/I=
O
> outbound windows
>=20
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
>=20
> It should get PCI base address from the DT node property 'ranges'
> to setup MEM/IO outbound windows instead of always zero.
>=20
> Fixes: 9af6bcb11e12 ("PCI: mobiveil: Add Mobiveil PCIe Host Bridge IP dri=
ver")
> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> ---
> V2:
>  - Added fixes entry.
>=20
>  drivers/pci/controller/pcie-mobiveil.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/pci/controller/pcie-mobiveil.c
> b/drivers/pci/controller/pcie-mobiveil.c
> index a0dd337c6214..8ff873023b5f 100644
> --- a/drivers/pci/controller/pcie-mobiveil.c
> +++ b/drivers/pci/controller/pcie-mobiveil.c
> @@ -630,8 +630,9 @@ static int mobiveil_host_init(struct mobiveil_pcie
> *pcie)
>=20
>  		/* configure outbound translation window */
>  		program_ob_windows(pcie, pcie->ob_wins_configured,
> -				   win->res->start, 0, type,
> -				   resource_size(win->res));
> +				   win->res->start,
> +				   win->res->start - win->offset,
> +				   type, resource_size(win->res));
>  	}
>=20
>  	/* setup MSI hardware registers */
> --
> 2.17.1

