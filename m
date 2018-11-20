Return-Path: <SRS0=4GJS=N7=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A95AC46466
	for <linux-pci@archiver.kernel.org>; Tue, 20 Nov 2018 11:33:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3113020831
	for <linux-pci@archiver.kernel.org>; Tue, 20 Nov 2018 11:33:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="X8nz6Xcg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3113020831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729088AbeKTWBs (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 20 Nov 2018 17:01:48 -0500
Received: from mail-eopbgr140058.outbound.protection.outlook.com ([40.107.14.58]:5602
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729131AbeKTWBq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 20 Nov 2018 17:01:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CfJwZpzBtweWq/5Ms5ndxC0eIp/x8udJKohs6IMKoWk=;
 b=X8nz6Xcg1+tfUoUt6j7G9tBbd6KY1Hy+2nY8PhAsRF0p059B+eBoHFcAFpmx+vEa7QYTRT/VseZdnuujuAU2Db6zkDIuxUF8t+OO16huZxqdU5TX29g7Mm2dIFagnAty5v8dnF/cwjaqnQ7PQWrciJIxyv+FLNfxdJ/eLey1Uck=
Received: from HE1PR0401MB2235.eurprd04.prod.outlook.com (10.168.32.20) by
 HE1PR0401MB2297.eurprd04.prod.outlook.com (10.168.32.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1339.23; Tue, 20 Nov 2018 11:33:01 +0000
Received: from HE1PR0401MB2235.eurprd04.prod.outlook.com
 ([fe80::60ff:1b2a:d0fd:5bd2]) by HE1PR0401MB2235.eurprd04.prod.outlook.com
 ([fe80::60ff:1b2a:d0fd:5bd2%8]) with mapi id 15.20.1339.027; Tue, 20 Nov 2018
 11:33:01 +0000
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
Subject: RE: [PATCHv2 25/25] arm64: defconfig: Enable
 CONFIG_PCI_LAYERSCAPE_GEN4
Thread-Topic: [PATCHv2 25/25] arm64: defconfig: Enable
 CONFIG_PCI_LAYERSCAPE_GEN4
Thread-Index: AQHUgLNaVV8sIDTU2EqiS5vX7AF+faVYiBxQ
Date:   Tue, 20 Nov 2018 11:33:00 +0000
Message-ID: <HE1PR0401MB2235E2730953E918EFF77F17E8D90@HE1PR0401MB2235.eurprd04.prod.outlook.com>
References: <20181120092615.11680-1-Zhiqiang.Hou@nxp.com>
 <20181120092615.11680-26-Zhiqiang.Hou@nxp.com>
In-Reply-To: <20181120092615.11680-26-Zhiqiang.Hou@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=minghuan.lian@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HE1PR0401MB2297;6:CyA5O370X07UQP9vew7zmh5A931rspiBRM38w2jlWPJk54Gp1RdDDPcpP/BRkP87ZrUXHKLya0j/0H/4dLhwN+b8T8JKmXYEu3feIo5ZDbIYtGV/Zm7aAmj3CLnH2A3SowfmBxR4wjugBi5AqfhqwSOZ+BHGFKJR0fBY0GdB1mp/AdOnvnpkoMRc7C58VSVG7gkLhWd52E5ZcaMdyRYHdEcnThROHFGs2vaJa3Iw+p2VDdcMUnEaqYCO1c6TB3oDd4aYShgr9e5SQNioH0+CdzfsfR9FxhXnvKjfMdwXJazUhQ67GP9Q89LwDJFeNIAqaQqciIvF/4ipAjQel9IA5cIQlsRj6/oqfFY644jZ+bLMGz78VLYSovdo6d1ARTALJXT0WKVcQpaHGY6ixvf+yBSzaKvgAaUB4+3rqTMETruiiSHQJCvXFZ5gA1N7aSnl3OAu2+1auHwpD++vNalTDw==;5:jac/Yx18/IoGxjermeFrxRcZUwBKdHskoV4BY25RIxkS2ycDY8OPCFgRCISndQwwJeLP5SrpOzKau1pTf560ze1/XMj+/cd75lejw987ZHtTaXw/3/lS+6Bdc6DLYfDK6aQ3Pifdngr1SsWjVqhfZzjAHMMI+IH4+n6tFhRLvW8=;7:gs2UjrA3e6O9DhWxV75W6ekRwfIw9ExUFils8z0yNVe8zett4XOZKvsbJTTyRFsxAI3rt2LrJ8WOTkm28yoYFCkSGjJUeMzVvEH4ZVMgfiEFhpjSsj0YNyYJeI2VdojUEsbQwK6DSnMEcW3BRzCHhg==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 70e58da4-0cbc-4b30-d0b2-08d64edbeda8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:HE1PR0401MB2297;
x-ms-traffictypediagnostic: HE1PR0401MB2297:
x-microsoft-antispam-prvs: <HE1PR0401MB2297957C2DB7A43A3C526510E8D90@HE1PR0401MB2297.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231442)(944501410)(52105112)(3002001)(10201501046)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:HE1PR0401MB2297;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0401MB2297;
x-forefront-prvs: 08626BE3A5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(346002)(376002)(136003)(366004)(39860400002)(189003)(199004)(13464003)(11346002)(446003)(3846002)(6506007)(6116002)(9686003)(33656002)(5660300001)(106356001)(99286004)(26005)(2900100001)(486006)(76176011)(7696005)(14454004)(2501003)(6246003)(476003)(6436002)(2906002)(53546011)(102836004)(8936002)(55016002)(105586002)(478600001)(81166006)(81156014)(8676002)(7736002)(256004)(305945005)(2201001)(97736004)(74316002)(53936002)(229853002)(316002)(71200400001)(25786009)(186003)(7416002)(71190400001)(68736007)(54906003)(110136005)(86362001)(4326008)(66066001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR0401MB2297;H:HE1PR0401MB2235.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: dzTGpxZHATguHZdzTrYrXpU9bVl+eoBwQe95gdEusviSuVpdra5LjnuuUKjKl6exGudMJzJ+mJUuy4VQ9EBu7iaWcibu0F7Sj9ecBjJERbUXQsu1BN4nzfeGyU77jB41NOrKuNQFLmCmd5Q7f0qzgGN0u7HGt1cICx5KkvbiB9hNPtuvV+oRrzC7EZAfc2sUiBqfyF1ap4TV4yAzmTBV1nOHuny1jzphX/NZ81wRn7QY2wOm2uSe2LrawmMdIDDq4bRJffq7kGlJGRbV1/EXXm9q34foiFthO1mFCoZqb656gyjz0wTAFOaTTtgPcWnG6L6xGIjkWzGyhOGc1V+aovcIfvBR/HVtzA253ZBz2is=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70e58da4-0cbc-4b30-d0b2-08d64edbeda8
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2018 11:33:01.0009
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0401MB2297
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


reviewed-by: Minghuan Lian <Minghuan.Lian@nxp.com>

> -----Original Message-----
> From: Z.q. Hou
> Sent: Tuesday, November 20, 2018 5:28 PM
> To: linux-pci@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org;
> bhelgaas@google.com; robh+dt@kernel.org; mark.rutland@arm.com;
> l.subrahmanya@mobiveil.co.in; shawnguo@kernel.org; Leo Li
> <leoyang.li@nxp.com>; lorenzo.pieralisi@arm.com;
> catalin.marinas@arm.com; will.deacon@arm.com
> Cc: Mingkai Hu <mingkai.hu@nxp.com>; M.h. Lian
> <minghuan.lian@nxp.com>; Xiaowei Bao <xiaowei.bao@nxp.com>; Z.q. Hou
> <zhiqiang.hou@nxp.com>
> Subject: [PATCHv2 25/25] arm64: defconfig: Enable
> CONFIG_PCI_LAYERSCAPE_GEN4
>=20
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
>=20
> Enable the PCIe Gen4 controller driver for Layerscape SoCs.
>=20
> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> ---
> V2:
>  - New patch
>=20
>  arch/arm64/configs/defconfig | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index ad92daeac585..6b4385f26e85 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -83,6 +83,7 @@ CONFIG_PCI_HOST_THUNDER_PEM=3Dy
> CONFIG_PCI_HOST_THUNDER_ECAM=3Dy  CONFIG_PCIE_ROCKCHIP_HOST=3Dm
> CONFIG_PCI_LAYERSCAPE=3Dy
> +CONFIG_PCI_LAYERSCAPE_GEN4=3Dy
>  CONFIG_PCI_HISI=3Dy
>  CONFIG_PCIE_QCOM=3Dy
>  CONFIG_PCIE_ARMADA_8K=3Dy
> --
> 2.17.1

