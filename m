Return-Path: <SRS0=4GJS=N7=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 275A0C04EBC
	for <linux-pci@archiver.kernel.org>; Tue, 20 Nov 2018 10:34:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A403520671
	for <linux-pci@archiver.kernel.org>; Tue, 20 Nov 2018 10:33:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Cb1gAVg7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A403520671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728393AbeKTVCN (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 20 Nov 2018 16:02:13 -0500
Received: from mail-eopbgr60087.outbound.protection.outlook.com ([40.107.6.87]:14955
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726569AbeKTVCN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 20 Nov 2018 16:02:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xAErwYvq2Jdi68aov0h3A/FrpbetKsOHJzRd6vwhpls=;
 b=Cb1gAVg7eZRkHPu6ooQWoDABPu46J60HTv77UYik2nBbBEoemQgOEsIG5OS/ZXZlxM6VqHUsqRRLo/VAZU0Czqy0WdekRNn7Kpr8e5rvZWzDqQNv6PM7h9tAzfkgxYUxIa8dSczzo9jlkohQzTgTess+bL+zfa6OJBIO5xBWiRM=
Received: from HE1PR0401MB2235.eurprd04.prod.outlook.com (10.168.32.20) by
 HE1PR0401MB2667.eurprd04.prod.outlook.com (10.168.148.148) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1339.26; Tue, 20 Nov 2018 10:33:42 +0000
Received: from HE1PR0401MB2235.eurprd04.prod.outlook.com
 ([fe80::60ff:1b2a:d0fd:5bd2]) by HE1PR0401MB2235.eurprd04.prod.outlook.com
 ([fe80::60ff:1b2a:d0fd:5bd2%8]) with mapi id 15.20.1339.027; Tue, 20 Nov 2018
 10:33:42 +0000
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
Subject: RE: [PATCHv2 04/25] PCI: mobiveil: remove flag MSI_FLAG_MULTI_PCI_MSI
Thread-Topic: [PATCHv2 04/25] PCI: mobiveil: remove flag
 MSI_FLAG_MULTI_PCI_MSI
Thread-Index: AQHUgLMNccCBxrgME0WFNhaFH8o5caVYd4iQ
Date:   Tue, 20 Nov 2018 10:33:42 +0000
Message-ID: <HE1PR0401MB22350E24ECD8F70877D7FEF6E8D90@HE1PR0401MB2235.eurprd04.prod.outlook.com>
References: <20181120092615.11680-1-Zhiqiang.Hou@nxp.com>
 <20181120092615.11680-5-Zhiqiang.Hou@nxp.com>
In-Reply-To: <20181120092615.11680-5-Zhiqiang.Hou@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=minghuan.lian@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HE1PR0401MB2667;6:I1cjE0/G2EUNizbdAkjLTKFupnu9LVijSKrgelWEdpYS9AWI68MSKr/e5IFa+3DGdkpC0aaj9M1IQYhW3+mSGWxobMUT/31y6InFH8nfi93SZYoOcPME2FqxW/5h6Mhjedm21uvJXjV1F3tYtZTdoH3Fuf3/5+XliEojWEZ2e2hRfP2qKPuTQQugtnzktmNeDzoxLeHwFv9iCZOuNDqesXXSeKMTSJRSOMdVU8nku8AQ4jG47vs48B5Fukdemh6DVQDCHVEOo2xT2jROnEx28Bt+Up00JE8udcRfHRqQbu/bfX1gJ6FQ3RNf4w4RBVihFyokVJ7iokQG4HX8RunutHVLjiAD5b0CBee54i9MfNeSTNE0eJu0xgIjog80e5DwnuOocX4m1MXf0X9GevimEr7F0CHOg/RZZGZSHtUSfkIArR/z6Pci0oClnuWWc7GWUU8rsYrq2qOz3JEqyGg3QA==;5:e8XuELmKorriklkNwa8ofq23Voc0mOWRkwZWiD7W4p1HLZy6T7NJ8WJIVVyuQsyU0YHP89BiYrF/q+B5DoQ6nZNR4EkLBhaWh9Yfh7HOyw6PSayCB3nuZdU/OqQQ3VoFfOrCo2QSAfVtt50cqmycHh+78sqgykY++4G1jd/oKbA=;7:1dvZatfnZfgTQpooKSa10JIzipnAFknaWGzhU8iW9Pr7LIvDo0OhM5h6bplO+0/JhZDAfzlvJNV/cac4d3l9HT4QkcI7yConFrAMw1ql76doyU8gb7PEEKUBNs2VQe4ezP7f9RCpipJ3DwvbTj9rJA==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 6f5c01b5-8b3f-44d3-cba0-08d64ed3a45d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:HE1PR0401MB2667;
x-ms-traffictypediagnostic: HE1PR0401MB2667:
x-microsoft-antispam-prvs: <HE1PR0401MB2667BA61937F43D157A2124AE8D90@HE1PR0401MB2667.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231442)(944501410)(52105112)(10201501046)(3002001)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:HE1PR0401MB2667;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0401MB2667;
x-forefront-prvs: 08626BE3A5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(396003)(346002)(136003)(376002)(13464003)(199004)(189003)(6246003)(33656002)(105586002)(2900100001)(8676002)(81166006)(478600001)(4326008)(81156014)(106356001)(25786009)(6116002)(3846002)(2906002)(229853002)(8936002)(14454004)(7696005)(71190400001)(71200400001)(9686003)(14444005)(256004)(53936002)(6436002)(7736002)(5660300001)(55016002)(305945005)(68736007)(486006)(74316002)(476003)(99286004)(11346002)(446003)(76176011)(110136005)(186003)(54906003)(66066001)(316002)(6506007)(53546011)(86362001)(575784001)(7416002)(2201001)(26005)(2501003)(97736004)(102836004)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR0401MB2667;H:HE1PR0401MB2235.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: i4elzbFQ9YywcL/DI5q16KikSKTH1Ff4pVqi9+kKz4uFmK09nrhLp5E/L0vgI+Ah61bR3eU5Z9IlN3hVcFqX2uQegVJaSGcsCjebE/aCCOhessqKY7EA6n86rB6AaQQegTu376055k6opS0+Ya6gLyUVdgGgimmaDICcwzwE4w0wSlV2x81JKN/Cozz8yph0FpnjDyDR+jLBv5bJsnZHfC1JZyyRNzbRQixmvzRhPDOdP+RLx3GWbNzb+srPvpjzPAe7hvWA5zRVKyKBI3fhf5yUADWos3FSRHKBarz2z23NCZIZc6AYDD54TCzWeQMOyubtAJD9GeE9EglMVGecYnD/eoFv4ir5qPubkzQe2fw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f5c01b5-8b3f-44d3-cba0-08d64ed3a45d
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2018 10:33:42.0617
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
> Subject: [PATCHv2 04/25] PCI: mobiveil: remove flag
> MSI_FLAG_MULTI_PCI_MSI
>=20
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
>=20
> The current code does not support multiple MSIs, so remove the
> corresponding flag from the msi_domain_info structure.
>=20
> Fixes: 1e913e58335f ("PCI: mobiveil: Add MSI support")
> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> ---
> V2:
>  - Added fixes entry.
>=20
>  drivers/pci/controller/pcie-mobiveil.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/pci/controller/pcie-mobiveil.c
> b/drivers/pci/controller/pcie-mobiveil.c
> index 563210e731d3..a0dd337c6214 100644
> --- a/drivers/pci/controller/pcie-mobiveil.c
> +++ b/drivers/pci/controller/pcie-mobiveil.c
> @@ -703,7 +703,7 @@ static struct irq_chip mobiveil_msi_irq_chip =3D {
>=20
>  static struct msi_domain_info mobiveil_msi_domain_info =3D {
>  	.flags	=3D (MSI_FLAG_USE_DEF_DOM_OPS |
> MSI_FLAG_USE_DEF_CHIP_OPS |
> -		   MSI_FLAG_MULTI_PCI_MSI | MSI_FLAG_PCI_MSIX),
> +		   MSI_FLAG_PCI_MSIX),
>  	.chip	=3D &mobiveil_msi_irq_chip,
>  };
>=20
> --
> 2.17.1

