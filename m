Return-Path: <SRS0=4GJS=N7=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A420C18DF5
	for <linux-pci@archiver.kernel.org>; Tue, 20 Nov 2018 11:12:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27B89208E3
	for <linux-pci@archiver.kernel.org>; Tue, 20 Nov 2018 11:12:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="bVBnPz18"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27B89208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729049AbeKTVl0 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 20 Nov 2018 16:41:26 -0500
Received: from mail-eopbgr70081.outbound.protection.outlook.com ([40.107.7.81]:16224
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727728AbeKTVlZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 20 Nov 2018 16:41:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ePRmZNj/FP6mWPjRcEZe5g5EuSPfRJm6JxEmzsxJMKU=;
 b=bVBnPz18tPyziGtXArO8L3pKYYJ176P38OH3eq02PU3aEsO5IE9T/5k2fBtH5/VEPZ1jHT9rZcvkr5nkoQHg38aOyb3coYOWo1uBOfWfdmilacB/LUWfQ4Fp9zYZbzmPrXDMhjTddAJOcbRrY6MEiRtWvDmpa3/sU/uU/OxeWj0=
Received: from HE1PR0401MB2235.eurprd04.prod.outlook.com (10.168.32.20) by
 HE1PR0401MB2426.eurprd04.prod.outlook.com (10.168.33.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.14; Tue, 20 Nov 2018 11:12:44 +0000
Received: from HE1PR0401MB2235.eurprd04.prod.outlook.com
 ([fe80::60ff:1b2a:d0fd:5bd2]) by HE1PR0401MB2235.eurprd04.prod.outlook.com
 ([fe80::60ff:1b2a:d0fd:5bd2%8]) with mapi id 15.20.1339.027; Tue, 20 Nov 2018
 11:12:44 +0000
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
Subject: RE: [PATCHv2 13/25] PCI: mobiveil: move irq chained handler setup out
 of DT parse
Thread-Topic: [PATCHv2 13/25] PCI: mobiveil: move irq chained handler setup
 out of DT parse
Thread-Index: AQHUgLMuebxRe02bmUKlvIFNrqMQ56VYf4AA
Date:   Tue, 20 Nov 2018 11:12:44 +0000
Message-ID: <HE1PR0401MB22357E7A16AD7261C5C6A14AE8D90@HE1PR0401MB2235.eurprd04.prod.outlook.com>
References: <20181120092615.11680-1-Zhiqiang.Hou@nxp.com>
 <20181120092615.11680-14-Zhiqiang.Hou@nxp.com>
In-Reply-To: <20181120092615.11680-14-Zhiqiang.Hou@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=minghuan.lian@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HE1PR0401MB2426;6:hMzA67H8t2FA9g3/w2vsOOTaTawUrU2qiJEpt608srhdLGqrjGFHz8AHkFMKvghzbsT5FkDJoxdPYJN1sYCeymCpaQG/ia8AjYnn2HHab3+zFlz/F9vcqs+wyQ7STU0Ik9D8j9Avz2cCNkmIHtfBSRJaAkWW5zdLGl5fUHZhQKnD2WnNkKhc97fOdjzGv1BCsaqr3UHCljnc8nqL9MQXEY3o5fJf6enGbQEaUttIwTuGSXvcTIJfp3qfOzY/A7g8E0vIomLtgFmTluoVFV6iGgPvxZuROLOmnjuJRHegspoTTeSPVNGjQnapr4Hx6mMWPN/iAABhZW9kxVzvxZMB+1TnDD2H2MRSDKoff3Z/hmA4JjW/CmDSPuXl9EPQy+kI80Cm5l0oWiX7vAmod1EolDasPiJI8Gz4fn4ruta86QeksXJcfRAoHK4KoBcadyEbrYfuSlg9PIvcjEPWpXY10Q==;5:8tVxw3GrgJuhTZdCZGOBp99pqGRox+wj6ENdmjr9o1hoTXisB6pEdF0Csh3eHmH1figpRaQvYzNbIurtLWq5Srn9TPKEAQkivpVzv0r9tTSkdFcjMChKQJgsy8tfwyH6R1ZUnPOmN1EXbLrJjp7R1Mb5vnPNaktJmSe+tQ5wudA=;7:HWjoTZ2aZKvT6dC1dB0Akx52DvyLS/Dq7zYcsR4XV0e2ET4/kKrtjpl/hV9p+aSpP6efgNfMW0A3jKH/y/M2O12T1GkWyqhEu+cXoHLBqoihv7Dk7s/BsrlNmg9ysFam972La4Jk/vA6NxKfXdcHEQ==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: aaf66136-e8e3-4ed5-c895-08d64ed91865
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:HE1PR0401MB2426;
x-ms-traffictypediagnostic: HE1PR0401MB2426:
x-microsoft-antispam-prvs: <HE1PR0401MB2426E2C99B28FDF91EFA25D1E8D90@HE1PR0401MB2426.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231442)(944501410)(52105112)(10201501046)(3002001)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201703061421075)(201703161042150)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6042181)(201708071742011)(7699051)(76991095);SRVR:HE1PR0401MB2426;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0401MB2426;
x-forefront-prvs: 08626BE3A5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(189003)(199004)(13464003)(9686003)(6246003)(2906002)(81156014)(55016002)(8676002)(97736004)(4326008)(81166006)(53936002)(7416002)(5660300001)(7736002)(74316002)(305945005)(66066001)(8936002)(86362001)(2201001)(6436002)(33656002)(229853002)(2900100001)(3846002)(105586002)(106356001)(6116002)(446003)(11346002)(76176011)(71190400001)(71200400001)(2501003)(256004)(14444005)(476003)(99286004)(486006)(7696005)(25786009)(186003)(54906003)(53546011)(498600001)(14454004)(102836004)(110136005)(26005)(68736007)(6506007)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR0401MB2426;H:HE1PR0401MB2235.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: G4lkgzI5OAaaBBvEdvqV7Rk8y0/mbCSttxysKRDbxYbfi4LUzFcw7OyvF93r1uNFCp5hZ06i+hWJ/Qb1MwIM48omzWiS8UApu1HADWDNI88b4BcF1sXDf8Zh576MDQPI3da34QWlX5dn83Eg1lIfte8jFk7Ymz4TbiJzJ6NaDIQRzw6IhIDKNSjZCiLy7j5McUFjt9CvPHgHGbnE+y2ivlOGlBvQve3Y1peCTfOKJcAdKji5P6j34UiasmyweXDZmxKqlzHp7r+bMEftY/buzRvjhJYijd4Dmrb1ftvOhMeMHZWijgzsbT/RzwX7xaipq3pF8k5EKKLf70dLROrDhUPnnh1Fld4WUotOEOMK6A4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aaf66136-e8e3-4ed5-c895-08d64ed91865
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2018 11:12:44.1821
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
> Subject: [PATCHv2 13/25] PCI: mobiveil: move irq chained handler setup ou=
t
> of DT parse
>=20
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
>=20
> Move irq_set_chained_handler_and_data() out of DT parse function.
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
> index c2848c22b466..db7ecb021c63 100644
> --- a/drivers/pci/controller/pcie-mobiveil.c
> +++ b/drivers/pci/controller/pcie-mobiveil.c
> @@ -460,8 +460,6 @@ static int mobiveil_pcie_parse_dt(struct
> mobiveil_pcie *pcie)
>  		return -ENODEV;
>  	}
>=20
> -	irq_set_chained_handler_and_data(pcie->irq, mobiveil_pcie_isr,
> pcie);
> -
>  	return 0;
>  }
>=20
> @@ -902,6 +900,8 @@ static int mobiveil_pcie_probe(struct platform_device
> *pdev)
>  		goto error;
>  	}
>=20
> +	irq_set_chained_handler_and_data(pcie->irq, mobiveil_pcie_isr,
> pcie);
> +
>  	ret =3D devm_request_pci_bus_resources(dev, &pcie->resources);
>  	if (ret)
>  		goto error;
> --
> 2.17.1

