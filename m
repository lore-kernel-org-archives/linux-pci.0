Return-Path: <SRS0=4GJS=N7=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DD59C4161D
	for <linux-pci@archiver.kernel.org>; Tue, 20 Nov 2018 10:32:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CB942087E
	for <linux-pci@archiver.kernel.org>; Tue, 20 Nov 2018 10:32:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="WhEDUafj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CB942087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726250AbeKTVAj (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 20 Nov 2018 16:00:39 -0500
Received: from mail-eopbgr70074.outbound.protection.outlook.com ([40.107.7.74]:11046
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726177AbeKTVAi (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 20 Nov 2018 16:00:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OwN6do3EvXf6JlaGRuF1FQdRvvx6fICnoNTD4ZNfFq8=;
 b=WhEDUafjl3HLbc08CWzbjsEbUFC+aLGp1Ao13qLilwmTH9rBpQnV+Oh2Phs65oVbTzhC18rAVEnxguWUZFYWXjJ4Xuf1Ij3ldJTwqWdAdwXIwozUhFuZ5gv56y1GyYzWuy6m1gU1g6D1AmJwnIHh247WHS+xSjW/dYYzn9oyN6o=
Received: from HE1PR0401MB2235.eurprd04.prod.outlook.com (10.168.32.20) by
 HE1PR0401MB1946.eurprd04.prod.outlook.com (10.166.122.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1339.26; Tue, 20 Nov 2018 10:31:53 +0000
Received: from HE1PR0401MB2235.eurprd04.prod.outlook.com
 ([fe80::60ff:1b2a:d0fd:5bd2]) by HE1PR0401MB2235.eurprd04.prod.outlook.com
 ([fe80::60ff:1b2a:d0fd:5bd2%8]) with mapi id 15.20.1339.027; Tue, 20 Nov 2018
 10:31:53 +0000
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
Subject: RE: [PATCHv2 03/25] PCI: mobiveil: correct the returned error number
Thread-Topic: [PATCHv2 03/25] PCI: mobiveil: correct the returned error number
Thread-Index: AQHUgLMJq8x5SPby6k21YblAt3at2aVYdvpQ
Date:   Tue, 20 Nov 2018 10:31:53 +0000
Message-ID: <HE1PR0401MB223513976E17780C1A19EFEDE8D90@HE1PR0401MB2235.eurprd04.prod.outlook.com>
References: <20181120092615.11680-1-Zhiqiang.Hou@nxp.com>
 <20181120092615.11680-4-Zhiqiang.Hou@nxp.com>
In-Reply-To: <20181120092615.11680-4-Zhiqiang.Hou@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=minghuan.lian@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HE1PR0401MB1946;6:uDdJMb+XIT0NIdOyvBWr3eaRA68lc7Xn1nEYb3EqaWp6qyGN95UCAsEBQ44L+t86lfcmRTmu+8XPiTUoevwCexGcwU8u/Gk5Dcvj26WkI/MgvZNByrugmjkc6Ju3uhfJDpLCV7+sVG47+EQ5hUKcsVCwUP0oX8pRZ1KDdoA/m8CSZBnwK/02fDkKI3AqFh30CKEq5XCG6uD8N4P0jwSyDj5SQ40DG5ZdyqSeBirX2IvEM4gjYCRzExcfDkhLNSxpqGwXbiQvYv3oVqNubS8x14WQ2pYeBzgVSpVMTVjdFjNFD8TXkRsHLE3AvfPzLssh1SwYJ+E3f6jfRlyJZFiF/tOJs6TWIkH8o37Sy1euoNMlRzACwtKQDxKAHJp7AvYKmhx4RNhiJFwgTVQOTBSQ/4+Ab9ePTb5JBoCZyXG659vxpcZQC3mxjqF8DTDBKkQygK/ChYlRj/rAI+sZ1+xcVjVWgsBCR1Z/owX146zpKf0=;5:zVKlhhc7Wz32Uc1AdIWmVR5ly83fUrmJXFjZsN+ARO+9Pday71uFot5IWg21bMZlRnwipIkuHeuHrJgjHaQewxnLCbM6R4oCloUyt06s4+dDS6me2gT9xQOSeJnv32lqEH7wGtClUmpdqSJJb61W8Dx6KM2zQxvtCSfwDnLyXtk=;7:MaW5VthliDR/zRwg3RbNX1c6S06axKeXKbBk+/fl0cHjPDWo+e3QNh+dBeRaFoQ07096EzOP/IEIhF3MGftS1Wi0c+mFkD6Qf0Vc8737eyYVAeum5AJLtGEGouCnZvtl6z5vvdaizgaSQ0l2LrRgFg==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: f1571130-3808-4140-233b-08d64ed363cc
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:HE1PR0401MB1946;
x-ms-traffictypediagnostic: HE1PR0401MB1946:
x-microsoft-antispam-prvs: <HE1PR0401MB1946D0E6DE1E3B01F7C51A0AE8D90@HE1PR0401MB1946.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231442)(944501410)(52105112)(10201501046)(3002001)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:HE1PR0401MB1946;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0401MB1946;
x-forefront-prvs: 08626BE3A5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(346002)(39860400002)(396003)(376002)(13464003)(189003)(199004)(256004)(71190400001)(71200400001)(4326008)(486006)(81166006)(8936002)(81156014)(8676002)(14444005)(7416002)(5660300001)(476003)(11346002)(25786009)(2201001)(6246003)(86362001)(446003)(97736004)(6436002)(14454004)(68736007)(229853002)(2501003)(2900100001)(54906003)(76176011)(6506007)(53546011)(26005)(102836004)(66066001)(99286004)(33656002)(55016002)(53936002)(110136005)(9686003)(478600001)(3846002)(6116002)(316002)(105586002)(106356001)(2906002)(305945005)(7736002)(74316002)(186003)(7696005)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR0401MB1946;H:HE1PR0401MB2235.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:3;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: XWGeWlqkGFJqd/REg4Zh3HlAeW3aaqJNMY5Vg9clOmNmlqNBx2VkHMtIUNFzZ7Z4Zra+66FPp1tMVO8pfNGzrRYVugaBeRLpSvuvwO/omt60JBIsc9dPJ1StPemX1pTHiAUDPrsyMiX+RWCs5PYkzGgaXX9lsjY7RrgEc2pGrl0vPHFvWMe8WUiZGQQdd/tj9HBK+f393kmDr0EZb06EAdu58o3hUm0N1PXAE6NBrEGSoUzpSbGvhGEAG5Bc5ARXxnU3qzWil1debEgaTrV4WoXI2Y7ukSx+3FPVU9Ex6QlXR40EzLF2e/8GUEjNLomkieeUH6ZfEcJVhXNx0Ly5xjSbEq1AAg6/u1WNjLGW6n0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1571130-3808-4140-233b-08d64ed363cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2018 10:31:53.7486
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0401MB1946
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
> Subject: [PATCHv2 03/25] PCI: mobiveil: correct the returned error number
>=20
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
>=20
> This patch corrected the returned error number by convention, and removed
> a unnecessary error check.
>=20
> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> ---
> V2:
>  - no change
>=20
>  drivers/pci/controller/pcie-mobiveil.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/pci/controller/pcie-mobiveil.c
> b/drivers/pci/controller/pcie-mobiveil.c
> index b87471f08a40..563210e731d3 100644
> --- a/drivers/pci/controller/pcie-mobiveil.c
> +++ b/drivers/pci/controller/pcie-mobiveil.c
> @@ -819,7 +819,7 @@ static int mobiveil_pcie_init_irq_domain(struct
> mobiveil_pcie *pcie)
>=20
>  	if (!pcie->intx_domain) {
>  		dev_err(dev, "Failed to get a INTx IRQ domain\n");
> -		return -ENODEV;
> +		return -ENOMEM;
>  	}
>=20
>  	raw_spin_lock_init(&pcie->intx_mask_lock);
> @@ -845,11 +845,9 @@ static int mobiveil_pcie_probe(struct
> platform_device *pdev)
>  	/* allocate the PCIe port */
>  	bridge =3D devm_pci_alloc_host_bridge(dev, sizeof(*pcie));
>  	if (!bridge)
> -		return -ENODEV;
> +		return -ENOMEM;
>=20
>  	pcie =3D pci_host_bridge_priv(bridge);
> -	if (!pcie)
> -		return -ENOMEM;
>=20
>  	pcie->pdev =3D pdev;
>=20
> @@ -866,7 +864,7 @@ static int mobiveil_pcie_probe(struct platform_device
> *pdev)
>  						    &pcie->resources, &iobase);
>  	if (ret) {
>  		dev_err(dev, "Getting bridge resources failed\n");
> -		return -ENOMEM;
> +		return ret;
>  	}
>=20
>  	/*
> --
> 2.17.1

