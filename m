Return-Path: <SRS0=4GJS=N7=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE334C28CF8
	for <linux-pci@archiver.kernel.org>; Tue, 20 Nov 2018 11:01:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68A4C20989
	for <linux-pci@archiver.kernel.org>; Tue, 20 Nov 2018 11:01:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="h+BaV5hn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68A4C20989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728437AbeKTVaN (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 20 Nov 2018 16:30:13 -0500
Received: from mail-eopbgr00077.outbound.protection.outlook.com ([40.107.0.77]:64761
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727497AbeKTVaN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 20 Nov 2018 16:30:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cS/5PpidjGcnn78bsYdYTEswylf1yw+fZ0N2SsLFepg=;
 b=h+BaV5hnZOz56Cllld6p9tnmWG5p4ML6MdDGb6KuoTKFeZuF1yG5iWP/sv6ZTR73Fv7gK0uASLhGCs9t8BelZIiTxf47H0YC8MaIShzmEX+h/r4HDuIyOgG6IMickkEqNsgsnriqHvUX5y/I4BXhKvDhj2vrD9X1nYWKrrjA8zY=
Received: from HE1PR0401MB2235.eurprd04.prod.outlook.com (10.168.32.20) by
 HE1PR0401MB1995.eurprd04.prod.outlook.com (10.166.122.145) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1339.26; Tue, 20 Nov 2018 11:01:31 +0000
Received: from HE1PR0401MB2235.eurprd04.prod.outlook.com
 ([fe80::60ff:1b2a:d0fd:5bd2]) by HE1PR0401MB2235.eurprd04.prod.outlook.com
 ([fe80::60ff:1b2a:d0fd:5bd2%8]) with mapi id 15.20.1339.027; Tue, 20 Nov 2018
 11:01:31 +0000
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
Subject: RE: [PATCHv2 11/25] PCI: mobiveil: only fix up the Class Code field
Thread-Topic: [PATCHv2 11/25] PCI: mobiveil: only fix up the Class Code field
Thread-Index: AQHUgLMnsTGtOAb4t0aetrrvJv2ysKVYf1xA
Date:   Tue, 20 Nov 2018 11:01:30 +0000
Message-ID: <HE1PR0401MB223591CD0D14451235200497E8D90@HE1PR0401MB2235.eurprd04.prod.outlook.com>
References: <20181120092615.11680-1-Zhiqiang.Hou@nxp.com>
 <20181120092615.11680-12-Zhiqiang.Hou@nxp.com>
In-Reply-To: <20181120092615.11680-12-Zhiqiang.Hou@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=minghuan.lian@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HE1PR0401MB1995;6:ZGMhDj//iFgoD+MxZfF21+Q2wTW5W33y+4ON6rpN0IstnVJKxJ3UNjTukJhNXdGb9AzI4AtsXv2muOZStKfRsOX26N/1CpbimNd5ahmfPRtbEwWTC+5ajKApVo5nXPY+06f28NHhvGAHvnpmbbVAgZCYbQCviCfs5aVpwQqeoCqMdAx+S5l/RGGiCmGR1yzCwj3MGjDqBX4J8yY1YaEO7v67B0k+03DNPUME303Jm4hYmedsowUdPBGRZmkj0Jvkh5t1+VkzHJi6Yt9dzAzKBXS+nI9rrHSBrsgh4fxK4wCDCUUyNnFjTrA6UBNv0JmzTr45tLWt2kg0axyNgsfaGsW7Bs2MfmaYT1GN9SHPqcAYAQ4fTW9jzoRmEKbd25lefyVlw6xTGWTOeFbLgi7LdgV0LLPH1S2B2tnVnE+2/NloWb0GL3iW8A+mh0Btyx2clplptxT/47oYacSkurfWdOh0q/45AKQrPnJUUyPdnm0=;5:Fbrxc5eYuKep9km40MszQEOKhAKt/ySNpduiPZ/R0McaOD2pAgV5EbLvrOTAcMJGqeSfvdSxbZZLywng3RHwyAxlimdC9uwbaJvgG9Vh6kOfNM6tHlFv/k62iPZhcw6wrk4fHqfBlA9cD4dtdm19Vgs7wxFicqa3AydvRnoRpuk=;7:4PDTPCNvsbX0ITLacOkY3mGg8s++NlrzIZBnGwSSjxIlXP7xH3AkdVa/uKN8YQ0+1bIpNu6qX61PTgIgANg/iBHJlkH+ryEly9kK3PNxSKUmuydi6Bbpk/o9H3FAUvn+l+hpyN3B3Qq7RJtTBPbglA==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: bae62f54-0bf1-4b3a-509b-08d64ed7870c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:HE1PR0401MB1995;
x-ms-traffictypediagnostic: HE1PR0401MB1995:
x-microsoft-antispam-prvs: <HE1PR0401MB19952889BC9E44B78BE7D5D0E8D90@HE1PR0401MB1995.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231442)(944501410)(52105112)(93006095)(93001095)(10201501046)(3002001)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:HE1PR0401MB1995;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0401MB1995;
x-forefront-prvs: 08626BE3A5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(396003)(366004)(376002)(136003)(39860400002)(13464003)(199004)(189003)(53546011)(4326008)(6506007)(25786009)(97736004)(102836004)(5660300001)(68736007)(71200400001)(256004)(53936002)(71190400001)(6246003)(26005)(55016002)(2900100001)(81156014)(186003)(8676002)(76176011)(8936002)(2201001)(14454004)(81166006)(99286004)(7696005)(9686003)(2906002)(86362001)(105586002)(486006)(476003)(11346002)(110136005)(316002)(305945005)(106356001)(478600001)(229853002)(2501003)(54906003)(3846002)(6436002)(6116002)(33656002)(7416002)(7736002)(66066001)(446003)(74316002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR0401MB1995;H:HE1PR0401MB2235.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:3;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: VKcyfaQ4tCC+bT6CsKsbTzxr70vj6EdaLrwxEiGWfXBfzhAmPrixkiNeKOINc2rYVyY99Ssag39y2WFY2npl7J7HxnmEFZBwEU46CP7opKNvm450oRdfFogs2VJNC2h0GY3wwvxrxu7/rREvZCt5tEHyWsjxIIbeHSpJjnSu633YMp1xdoNJVvsxCQtqKsE4u9E51aE4Aj3FOTINV5mgSh6vmx/SChMPNRSCxNVh/3+XN++Z3Lfu+AXn6Vx3+W391SyaRAirj3nYibrCTWn7mq6KQ/OxjdKzbOFDNYweJpgO4mbLIXXnX8JziL6HwmLeNq0rSH3XOWCR7298IH5Yks8ebXBSCqASk/50myIc0j0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bae62f54-0bf1-4b3a-509b-08d64ed7870c
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2018 11:01:30.8451
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0401MB1995
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
> Subject: [PATCHv2 11/25] PCI: mobiveil: only fix up the Class Code field
>=20
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
>=20
> Fix up the Class Code to PCI bridge, do not change the Revision ID.
> And move the fixup to mobiveil_host_init function.
>=20
> Fixes: 9af6bcb11e12 ("PCI: mobiveil: Add Mobiveil PCIe Host Bridge IP dri=
ver")
> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> ---
> V2:
>  - Added fixes entry.
>=20
>  drivers/pci/controller/pcie-mobiveil.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/pci/controller/pcie-mobiveil.c
> b/drivers/pci/controller/pcie-mobiveil.c
> index 78e575e71f4d..8eee1ab7ee24 100644
> --- a/drivers/pci/controller/pcie-mobiveil.c
> +++ b/drivers/pci/controller/pcie-mobiveil.c
> @@ -653,6 +653,12 @@ static int mobiveil_host_init(struct mobiveil_pcie
> *pcie)
>  				   type, resource_size(win->res));
>  	}
>=20
> +	/* fixup for PCIe class register */
> +	value =3D csr_readl(pcie, PAB_INTP_AXI_PIO_CLASS);
> +	value &=3D 0xff;
> +	value |=3D (PCI_CLASS_BRIDGE_PCI << 16);
> +	csr_writel(pcie, value, PAB_INTP_AXI_PIO_CLASS);
> +
>  	/* setup MSI hardware registers */
>  	mobiveil_pcie_enable_msi(pcie);
>=20
> @@ -896,9 +902,6 @@ static int mobiveil_pcie_probe(struct platform_device
> *pdev)
>  		goto error;
>  	}
>=20
> -	/* fixup for PCIe class register */
> -	csr_writel(pcie, 0x060402ab, PAB_INTP_AXI_PIO_CLASS);
> -
>  	/* initialize the IRQ domains */
>  	ret =3D mobiveil_pcie_init_irq_domain(pcie);
>  	if (ret) {
> --
> 2.17.1

