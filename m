Return-Path: <SRS0=7Kzx=O2=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4607C43387
	for <linux-pci@archiver.kernel.org>; Mon, 17 Dec 2018 10:24:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 835C12133F
	for <linux-pci@archiver.kernel.org>; Mon, 17 Dec 2018 10:24:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZX8RobhA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbeLQKYT (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 17 Dec 2018 05:24:19 -0500
Received: from mail-eopbgr80077.outbound.protection.outlook.com ([40.107.8.77]:65440
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726642AbeLQKYT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 17 Dec 2018 05:24:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WXewcvaTum2B8tHvGi1qTjvHxhSCpjBfpDgc4Igi1sc=;
 b=ZX8RobhA/nIu4tAZG5rwlPpqo6ks4D3rzrLVPEYCakCWXUG0jMy/M2NxpGvdx1dIaDa+ztGooRxssuncQub+RHfpG9oWMC/JT6qpSNGPv6742aIY8RjZNc/7opr7VwCCTwbx8FYOgYEMXNoP5mKhLxkcmZTjchz5ySX2IVvNh0c=
Received: from VI1PR04MB5533.eurprd04.prod.outlook.com (20.178.122.159) by
 VI1PR04MB4589.eurprd04.prod.outlook.com (20.177.55.223) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.20; Mon, 17 Dec 2018 10:24:14 +0000
Received: from VI1PR04MB5533.eurprd04.prod.outlook.com
 ([fe80::f80a:77f3:7cbf:62b5]) by VI1PR04MB5533.eurprd04.prod.outlook.com
 ([fe80::f80a:77f3:7cbf:62b5%2]) with mapi id 15.20.1425.021; Mon, 17 Dec 2018
 10:24:14 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Stefan Agner <stefan@agner.ch>
CC:     Bjorn Helgaas <bhelgaas@google.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Chris Healy <cphealy@gmail.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 2/3] PCI: imx6: Invert checks in imx6_pcie_reset_phy() and
 imx6_setup_phy_mpll()
Thread-Topic: [PATCH 2/3] PCI: imx6: Invert checks in imx6_pcie_reset_phy()
 and imx6_setup_phy_mpll()
Thread-Index: AQHUlZRvbyChC8TODkarZLATTN7mRw==
Date:   Mon, 17 Dec 2018 10:24:14 +0000
Message-ID: <VI1PR04MB5533AAAEA69A54F1CF01D44CEEBC0@VI1PR04MB5533.eurprd04.prod.outlook.com>
References: <20181216230916.22982-1-andrew.smirnov@gmail.com>
 <20181216230916.22982-3-andrew.smirnov@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [192.88.166.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB4589;6:eu6jYBE2C4D6M7g7PMB2La1Qa4JiQQNCqlafMU9u6n65UMNE+Mbijh3tHVT2EqCn0F2lvO5Y2dSIpAZCpvrauwpYahxCb5LF4ssnkzPIZlE5n0x/18WnkjGfs53QZXZP/fr0IugqrcqTqiARwldbA6R8Y46QB2KJhHsK+wsqSUOPOwf0KElXj30tjVKZdBK8k9GqK/oYlXWXd0c+ouGJDUkaed0GUC2IPRLHJbTjo7sQ+uyzDeJvzyvKyki9ktK3ZMlggk/kYRqcacD4DSBZKdJaHtlyseo70ER5LeHKVD4rLoGJEEjrYW46YFkDPPlF30GBcqjoz2skjMEv35nZSWTkFN6qhiWBsTmy8y7VC+GQsmcCsnX5O3NI6XWUO9orsYbgKIhQqMFgccerrP3UDpZNUPwKeMKCk7a0OXfjg8/0EVhfMQmebRFQG/G8bAEvy9R0ZhOYgeAHd++UHk80AA==;5:RDzk0br5yx/xYq/oUqczkI6TDKcQmcw8tqWeCugNjifIT4dwnNMFqhwQzRMSODlafIaHqy3LmhMbVVKwjm/XJGys+CjKEbJbCR65eJtZT5lVz0SuYUURZg6LqrLCTKKtbDHek6S7LFUUtc8E1YbaZGceD1M+AyVA6T/C1MPhBdU=;7:xNcRcA66l1NfQ8TBloxcLZirGjHvYD6MXzOCk6wCY52t/tfK6ylEFar6zv2IHW1WRNqXWn4Yp+SKPP0e0xU7o+6ov5YsA5fyTi9vdU6H8X51ctRiGqKDXyuO3QN5SQ5i544p2qt9betd7OI+K4JIVA==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: d3497a25-0dc2-4349-1f14-08d66409cb43
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB4589;
x-ms-traffictypediagnostic: VI1PR04MB4589:
x-microsoft-antispam-prvs: <VI1PR04MB458989B926D0CB0CFF291A58EEBC0@VI1PR04MB4589.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(5005020)(6040522)(2401047)(8121501046)(10201501046)(3231475)(944501520)(52105112)(3002001)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:VI1PR04MB4589;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB4589;
x-forefront-prvs: 08897B549D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(39860400002)(376002)(346002)(366004)(199004)(189003)(54534003)(53546011)(186003)(6506007)(6306002)(99286004)(316002)(54906003)(8936002)(66066001)(86362001)(5660300001)(39060400002)(68736007)(106356001)(33656002)(97736004)(476003)(76176011)(25786009)(446003)(110136005)(8676002)(71200400001)(81166006)(81156014)(9686003)(71190400001)(3846002)(6116002)(74316002)(229853002)(2906002)(478600001)(14454004)(14444005)(7696005)(305945005)(105586002)(7736002)(486006)(102836004)(26005)(6246003)(44832011)(55016002)(53936002)(4326008)(256004)(966005)(6436002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4589;H:VI1PR04MB5533.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 0qKWFFckxxX2ynmlRQpheaEC3pqGW2FqHiumWl8Xe3UzCwh46aSP+/MnYfR8YnPDdDmEDfhDKkYg5TKct0qH1yMpb0FCCfUruTHCivXjTgGIYrpv1MiWfql1snfKKSkY8P0IXwtyWG7kA5In4xfUTRLaF9/pI6UyxTPx034H9LcB5tXh0d/9UP8L8IqV5qGkqvP+dRuKTGHA9xn2pE7CRI6zhcRZiju4VFCgmBjCIAo6ctZUTRm8ovF5p8+OUfr6otD++LR6RRR854PGlUxHFHvOa4P5ZDiRM07QSwAnb5lEANnGJnyiQJ5ofYqALAn3
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3497a25-0dc2-4349-1f14-08d66409cb43
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2018 10:24:14.5609
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4589
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 12/17/2018 1:09 AM, Andrey Smirnov wrote:=0A=
> In order to avoid having potentially ever growing list of variants=0A=
> that don't support methods implemented in imx6_pcie_reset_phy() and=0A=
> imx6_setup_phy_mpll(), change logical checks in the to check for SoC's=0A=
> that _do_ support what they implement. While at it, share the code via=0A=
> a small helper function.=0A=
>   =0A=
> +static bool imx6_pcie_has_imx6_phy(struct imx6_pcie *imx6_pcie)=0A=
> +{=0A=
> +	return imx6_pcie->variant =3D=3D IMX6Q ||=0A=
> +	       imx6_pcie->variant =3D=3D IMX6SX ||=0A=
> +	       imx6_pcie->variant =3D=3D IMX6QP;=0A=
> +}=0A=
=0A=
This would be an ideal match for adding a field inside drvdata, sadly =0A=
that was part of a series which stalled:=0A=
=0A=
https://patchwork.kernel.org/patch/10712261/=0A=
