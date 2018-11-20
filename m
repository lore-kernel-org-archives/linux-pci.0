Return-Path: <SRS0=4GJS=N7=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84C2CC4161B
	for <linux-pci@archiver.kernel.org>; Tue, 20 Nov 2018 11:25:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40FEC20831
	for <linux-pci@archiver.kernel.org>; Tue, 20 Nov 2018 11:25:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="n7bjkqI/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40FEC20831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729095AbeKTVyd (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 20 Nov 2018 16:54:33 -0500
Received: from mail-eopbgr50044.outbound.protection.outlook.com ([40.107.5.44]:55120
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726792AbeKTVyd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 20 Nov 2018 16:54:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CDA91wmUz+NJejjvi1ZwzdFeY6am+SoUE4XuBJbDjGs=;
 b=n7bjkqI/ejfHvpmtB9/SYgxeBCj7qE6QVUo47poZxolxEt2N5IpKxECrVbemE3q8+AXXbdvYGlmG//yavF0NMVT2RLcjR/XcI12X0seIOXKya5BkLxgFny7JK+VMrb0tKvxO/b5eog+/axDJVzPphc2YBr+6eMkxGEP0VOkez9E=
Received: from HE1PR0401MB2235.eurprd04.prod.outlook.com (10.168.32.20) by
 HE1PR0401MB2393.eurprd04.prod.outlook.com (10.168.33.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1339.26; Tue, 20 Nov 2018 11:25:08 +0000
Received: from HE1PR0401MB2235.eurprd04.prod.outlook.com
 ([fe80::60ff:1b2a:d0fd:5bd2]) by HE1PR0401MB2235.eurprd04.prod.outlook.com
 ([fe80::60ff:1b2a:d0fd:5bd2%8]) with mapi id 15.20.1339.027; Tue, 20 Nov 2018
 11:25:08 +0000
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
Subject: RE: [PATCHv2 15/25] dt-bindings: pci: mobiveil: change gpio_slave and
 apb_csr to optional
Thread-Topic: [PATCHv2 15/25] dt-bindings: pci: mobiveil: change gpio_slave
 and apb_csr to optional
Thread-Index: AQHUgLM2ppaPc2Dn3Ema1xz+JSR+gqVYhfQQ
Date:   Tue, 20 Nov 2018 11:25:07 +0000
Message-ID: <HE1PR0401MB2235255D95CFABE423EC0665E8D90@HE1PR0401MB2235.eurprd04.prod.outlook.com>
References: <20181120092615.11680-1-Zhiqiang.Hou@nxp.com>
 <20181120092615.11680-16-Zhiqiang.Hou@nxp.com>
In-Reply-To: <20181120092615.11680-16-Zhiqiang.Hou@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HE1PR0401MB2393;6:2rYa92I2NwL/qub6X/w3STDyD7bZPYQJCicxaJNUd+HExqj0Ex7YGBAJhvrKrDZBUqxCgiMUkfprVyeZr9k2NZxAxaIzka089eR5aHUrdTl5CckHTNcisFjz2gQefQfw7bRXNabyYRx8TEMwfvd68uDQrQ/MemeZuqaUHcRme0+SMNHMEusYS8yndRlnADGqioPRFX35CCWBaT5jB5OHkGs8bujG5FfiK5C+TR+HmvJa/sAzmVuqIIMk7GnlzfjelQxQEzCeabTsLDjaBqzWZollD9flbQQD321jsIdP2hQ+LaTIUt6XJkZrl6pPNPNUwlcPLzO2Tcp4GNowtpps9fjtf8aQVnvxrVou2UHz25MNMMXnbX4gpztd9nA5j8FFY3KZ1BoiA9KiDzj5ZZZE6R1XmP7FU7dhv8E7QFkeolqr7wuEGI2mOsnPlYYqRwtJzA66hyUVoER913WG0pMynA==;5:8gH/gFMOPcnShEpdA5fq/mno/iPewNib/td4Qo0NRh0p4VuE+oLLkqkWoppNJLeDLm2BsOc6jwoB7eo8E3zx4fTBOGfrtir8awdZtv5trJuJhixNNGnD7D/iYMyzrgf8TW44M9zExeBB4vYCkRtP6ZKh4JGrXanI5Zu2ro4Ejyw=;7:22QfbFXgzNPGt+P8r/axeE70N0+cn7UIakRsl5+FoCiqsd/O9ANIfROWRU8Ju0A/W/UA5J20dSRbA/db8A0bTjh6yoNjzpK//4d5JJDNDvZalzAo2nTKXrWLRrwYDXEgL60DgmkejuakWhTPq4E7lQ==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 430c36d7-9574-4737-06ec-08d64edad3af
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:HE1PR0401MB2393;
x-ms-traffictypediagnostic: HE1PR0401MB2393:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=minghuan.lian@nxp.com; 
x-microsoft-antispam-prvs: <HE1PR0401MB239340D3809AAD96A38911E8E8D90@HE1PR0401MB2393.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231442)(944501410)(52105112)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:HE1PR0401MB2393;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0401MB2393;
x-forefront-prvs: 08626BE3A5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(366004)(136003)(39860400002)(396003)(189003)(199004)(13464003)(6506007)(53546011)(54906003)(110136005)(26005)(8676002)(11346002)(316002)(446003)(102836004)(81166006)(81156014)(97736004)(478600001)(76176011)(25786009)(476003)(7696005)(6246003)(9686003)(68736007)(55016002)(14454004)(6436002)(74316002)(7736002)(305945005)(486006)(53936002)(186003)(2501003)(106356001)(105586002)(33656002)(229853002)(6116002)(3846002)(7416002)(4326008)(5660300001)(256004)(2201001)(99286004)(2900100001)(8936002)(2906002)(86362001)(71200400001)(71190400001)(66066001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR0401MB2393;H:HE1PR0401MB2235.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: jP2yYafgxKA+I83FmcLG/sh9+uFGYtz3eAcUdcI7+VB3viVMpJKsLqyFXmBFnVQoavssGQjNVHThSbjNFCoG0fAqYdAE4CFzABEOynZ17BixVVVxUmRPcVepDvmNcgyIVc1IdDvbp836gIBkN4T3rIRY6myv9/kJysVGR7/3N/SlQzihmOHrtBlEruWeCaNz88QxOz7HqX5w9D6Z6R7ezwZqhlftwdwnaX4+dFPf75vUleLJjvN5XSMKDiob2qAn3WKfmx1ngNS9MkjV/Bbtsl4V7zMvbV3FAwK0HQQPHSt7mHeqJxgp1CVLLj6WGMo4DVe3lRJ7YEwZfzQ+P6+9efbP6Mv84hYj5Vg955p440s=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 430c36d7-9574-4737-06ec-08d64edad3af
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2018 11:25:07.9554
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0401MB2393
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
> Subject: [PATCHv2 15/25] dt-bindings: pci: mobiveil: change gpio_slave an=
d
> apb_csr to optional
>=20
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
>=20
> Change the "gpio_slave" and "apb_csr" to optional, the "gpio_slave"
> is not used in current code, and "apb_csr" is not used by some platforms.
>=20
> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> Acked-by: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
> Acked-by: Rob Herring <robh@kernel.org>
> ---
> V2:
>  - no change
>=20
>  Documentation/devicetree/bindings/pci/mobiveil-pcie.txt | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/pci/mobiveil-pcie.txt
> b/Documentation/devicetree/bindings/pci/mobiveil-pcie.txt
> index a618d4787dd7..64156993e052 100644
> --- a/Documentation/devicetree/bindings/pci/mobiveil-pcie.txt
> +++ b/Documentation/devicetree/bindings/pci/mobiveil-pcie.txt
> @@ -10,8 +10,10 @@ Required properties:
>  	interrupt source. The value must be 1.
>  - compatible: Should contain "mbvl,gpex40-pcie"
>  - reg: Should contain PCIe registers location and length
> +	Mandatory:
>  	"config_axi_slave": PCIe controller registers
>  	"csr_axi_slave"	  : Bridge config registers
> +	Optional:
>  	"gpio_slave"	  : GPIO registers to control slot power
>  	"apb_csr"	  : MSI registers
>=20
> --
> 2.17.1

