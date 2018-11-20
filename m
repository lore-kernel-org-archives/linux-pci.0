Return-Path: <SRS0=4GJS=N7=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E634C46466
	for <linux-pci@archiver.kernel.org>; Tue, 20 Nov 2018 11:27:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3227820831
	for <linux-pci@archiver.kernel.org>; Tue, 20 Nov 2018 11:27:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="B4vsxznM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3227820831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729173AbeKTVzm (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 20 Nov 2018 16:55:42 -0500
Received: from mail-eopbgr140050.outbound.protection.outlook.com ([40.107.14.50]:1918
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726792AbeKTVzk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 20 Nov 2018 16:55:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cwmjt1Y48ed1/WreqFsVhCKqEBn9cx7a+BwAEnmPvVE=;
 b=B4vsxznMDe2QK1ksZBAApk48eIrvfdYR3TGgavc7U3k+3ne0BsK+cYHEsJK6QzwVZW96LV0vc3tCyjHO6Ny63k5YnF7yZl2nDmzmPIPX33MNgTeqCLvejgmxoA2HjSTtqQkKoKZBa0KDEsK18jw7+QINPLFCJnWkVuKyw0uKiZo=
Received: from HE1PR0401MB2235.eurprd04.prod.outlook.com (10.168.32.20) by
 HE1PR0401MB2507.eurprd04.prod.outlook.com (10.168.147.142) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.28; Tue, 20 Nov 2018 11:26:29 +0000
Received: from HE1PR0401MB2235.eurprd04.prod.outlook.com
 ([fe80::60ff:1b2a:d0fd:5bd2]) by HE1PR0401MB2235.eurprd04.prod.outlook.com
 ([fe80::60ff:1b2a:d0fd:5bd2%8]) with mapi id 15.20.1339.027; Tue, 20 Nov 2018
 11:26:29 +0000
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
Subject: RE: [PATCHv2 18/25] PCI: mobiveil: continue to initialize the host
 upon no PCIe link
Thread-Topic: [PATCHv2 18/25] PCI: mobiveil: continue to initialize the host
 upon no PCIe link
Thread-Index: AQHUgLNBo/8Yg7CF1Uyx+JI1cAkX5KVYhlSA
Date:   Tue, 20 Nov 2018 11:26:28 +0000
Message-ID: <HE1PR0401MB223595ADCC743237CC48E3A8E8D90@HE1PR0401MB2235.eurprd04.prod.outlook.com>
References: <20181120092615.11680-1-Zhiqiang.Hou@nxp.com>
 <20181120092615.11680-19-Zhiqiang.Hou@nxp.com>
In-Reply-To: <20181120092615.11680-19-Zhiqiang.Hou@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=minghuan.lian@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HE1PR0401MB2507;6:JUTzWWq09kZ2WAj1JlR+yjB1I41Kkgp6tvyvLgw785WiqDyyYJePgJRgphni2X1NWbN72To1xiMRgtZS3Ysax/JB/b3wymdS3kCe69JUMIMWtjJMfBrmgKu9MvoqxW4G+gS7h+Yv2do53bEfWJcPYEQPWMiNaKbscIr8bLK19Z4w92BvVhGmauLswnBS8feQeTPuZ8k0YjOXBfsv9xHdo/0isbZvPunh2LviEqMFivmZbbCID12OdOXZ8ekuIDTYJQTKsUF8Me4VYoG8ySJ2LZqVHc69x5yXOxFGuZdpEkCjKJ1yGjizQK7kvYX/ero5G9KzQqkXElf3MkUa1evBu6GPAu75WgjmfLwJhwZrMRt/i06UGHPFAv5kK8yCHqAfZEsBxArXRZy82NfXVeumli/Y3ACEOM6yzvYnv1SQx640QrgSzpCn3pvdMDTz1Mu6IVsWR6BlpY9kUuex9w/vtg==;5:XBMoMQXhbH0bofTO9VCgGS7qPedk6lPMNTFCTqOM0SdUa9NV4id0cn6vKEIwMteP2S14SuryMVH09Gh6cXxrx1cYu4kBd6uHdrGrZk+5BktKSNaQLpLKm0j0AIBaiJMzCQNnxl1983RuIrYbZORbKXud4gWM9d9oIIp+R9K98HI=;7:uM9wIPHxIaG6riXwKzdI+9uZKZqAFjmITELhd2eea0fz7nVKUYJ8vc6nckvFs8wpLUaiDz+zSPFgajCKdDb2TDdeGtn18twsI7qj9bGuaABHFvyqvGAeU6l3O0pnhrVBn+iNyb32Rbfqgr2LpC+5cA==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: a11cc53d-6612-4767-3184-08d64edb0400
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:HE1PR0401MB2507;
x-ms-traffictypediagnostic: HE1PR0401MB2507:
x-microsoft-antispam-prvs: <HE1PR0401MB25071B60E712A87356EA8681E8D90@HE1PR0401MB2507.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(258649278758335)(211936372134217)(180628864354917)(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231442)(944501410)(52105112)(10201501046)(3002001)(6055026)(148016)(149066)(150057)(6041310)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:HE1PR0401MB2507;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0401MB2507;
x-forefront-prvs: 08626BE3A5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(136003)(376002)(346002)(366004)(13464003)(189003)(199004)(99286004)(5660300001)(106356001)(105586002)(486006)(229853002)(86362001)(26005)(186003)(8936002)(11346002)(446003)(7696005)(2201001)(97736004)(6506007)(476003)(76176011)(81166006)(53546011)(7416002)(8676002)(102836004)(81156014)(6436002)(9686003)(55016002)(316002)(110136005)(71200400001)(2501003)(25786009)(3846002)(4326008)(6116002)(71190400001)(478600001)(53936002)(6246003)(54906003)(68736007)(2900100001)(305945005)(256004)(2906002)(14454004)(7736002)(66066001)(33656002)(74316002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR0401MB2507;H:HE1PR0401MB2235.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 66OgsD8PVfAihh4882Bylss87aXITMbJLdGaG7LCIsuK0wRJPGc2MepvgziZDgvHX7Zi33GA+NLkD8xJqiFIHadtFpvZojYk00MGo/KzY+FgLQqVTzy7RvTfls1XDJ0ZxEit3jwXwxer9eihIVnnqRqinSsuSv+oNJKecO1GehMgQArZSM7WZuvJr3Wy8aYRoKRH6nMFt4HrzwE2+ivHr2f2GPQJC6nxZZcWzKEolkCJeWhF249Xju9u2+f70UVI2jl5QRoW/i2DDeyJbiHdLurSMdt6shTwptu58MUwb4NrThlhSNyb2ROI1lN6O8/d/14SZOZ1ZNoJ+np088vx9goBG7H3UlWp+r7xovuT4Is=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a11cc53d-6612-4767-3184-08d64edb0400
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2018 11:26:29.0023
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
> Subject: [PATCHv2 18/25] PCI: mobiveil: continue to initialize the host u=
pon
> no PCIe link
>=20
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
>=20
> Sometimes there is not a PCIe Endpoint in the PCIe slot, so do not exit w=
hen
> the PCIe link is not up. And degrade the print level of link up info.
>=20
> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> ---
> V2:
>  - no change
>=20
>  drivers/pci/controller/mobiveil/pcie-mobiveil-host.c | 1 -
>  drivers/pci/controller/mobiveil/pcie-mobiveil.c      | 2 +-
>  2 files changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
> b/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
> index 1ae82e790562..d1765d572f44 100644
> --- a/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
> +++ b/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
> @@ -596,7 +596,6 @@ int mobiveil_pcie_host_probe(struct mobiveil_pcie
> *pcie)
>  	ret =3D mobiveil_bringup_link(pcie);
>  	if (ret) {
>  		dev_info(dev, "link bring-up failed\n");
> -		goto error;
>  	}
>=20
>  	/* setup the kernel resources for the newly added PCIe root bus */
> diff --git a/drivers/pci/controller/mobiveil/pcie-mobiveil.c
> b/drivers/pci/controller/mobiveil/pcie-mobiveil.c
> index ee678a60825d..370658d6546d 100644
> --- a/drivers/pci/controller/mobiveil/pcie-mobiveil.c
> +++ b/drivers/pci/controller/mobiveil/pcie-mobiveil.c
> @@ -222,7 +222,7 @@ int mobiveil_bringup_link(struct mobiveil_pcie *pcie)
>  		usleep_range(LINK_WAIT_MIN, LINK_WAIT_MAX);
>  	}
>=20
> -	dev_err(&pcie->pdev->dev, "link never came up\n");
> +	dev_info(&pcie->pdev->dev, "link never came up\n");
>=20
>  	return -ETIMEDOUT;
>  }
> --
> 2.17.1

