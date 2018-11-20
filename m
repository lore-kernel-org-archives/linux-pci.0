Return-Path: <SRS0=4GJS=N7=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56368C43441
	for <linux-pci@archiver.kernel.org>; Tue, 20 Nov 2018 11:00:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1249121104
	for <linux-pci@archiver.kernel.org>; Tue, 20 Nov 2018 11:00:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="boh13N8n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1249121104
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728560AbeKTV3X (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 20 Nov 2018 16:29:23 -0500
Received: from mail-eopbgr70047.outbound.protection.outlook.com ([40.107.7.47]:51606
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727582AbeKTV3W (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 20 Nov 2018 16:29:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mlHblm4G0NX3cP18ECJmUlbAk+XtcSlkr52OTPk5KJU=;
 b=boh13N8nw2CItO409/3J3qP9LgoHS7UHDjPEcV73u3oM/DTxa3M3XeHy0ABj7SJIK7PYOEgN1bpVeZtDqW92YKQMyF6cOmTHZDUDZ7DT8ki0fjdbh6lnnW2lOPrU0RrLQu/CQUKwaky8x/928cfO1d8c5WaGpySMEwDWom9Nhq4=
Received: from HE1PR0401MB2235.eurprd04.prod.outlook.com (10.168.32.20) by
 HE1PR0401MB2202.eurprd04.prod.outlook.com (10.166.76.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1339.26; Tue, 20 Nov 2018 11:00:44 +0000
Received: from HE1PR0401MB2235.eurprd04.prod.outlook.com
 ([fe80::60ff:1b2a:d0fd:5bd2]) by HE1PR0401MB2235.eurprd04.prod.outlook.com
 ([fe80::60ff:1b2a:d0fd:5bd2%8]) with mapi id 15.20.1339.027; Tue, 20 Nov 2018
 11:00:43 +0000
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
Subject: RE: [PATCHv2 10/25] PCI: mobiveil: fix the INTx process error
Thread-Topic: [PATCHv2 10/25] PCI: mobiveil: fix the INTx process error
Thread-Index: AQHUgLMjYcftjmg7iE2fOoFo4PqH6KVYfyAA
Date:   Tue, 20 Nov 2018 11:00:43 +0000
Message-ID: <HE1PR0401MB2235C1EBD0DF9EB219F5FFE8E8D90@HE1PR0401MB2235.eurprd04.prod.outlook.com>
References: <20181120092615.11680-1-Zhiqiang.Hou@nxp.com>
 <20181120092615.11680-11-Zhiqiang.Hou@nxp.com>
In-Reply-To: <20181120092615.11680-11-Zhiqiang.Hou@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=minghuan.lian@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HE1PR0401MB2202;6:HaWOh6i6sFpT36lKWqTfHFHmq2RVTjWmrtmYo4SzSXVgKq7KQDTG/77cEoI3VroDO0fsK/fptG5IQr5DjIIbTjr751s9utQ4WssA5Z6kTf6Q/xKwCk2ZxChHbP0IbXKL02Pyh5KXMSd5CcPY80qX3xaG3om8umiCCSe3KkMxnVpULb+xqtu6zUD41gJHhV6WU1JL918zKQ52uJehLVGvIOXE33Ps5Q0K/qXnq2rUjs3kaHiar2d6Xypsgu0R+U+mf/zYwhJYzDX3Ex8f2BK3CjfhzuGzvmIZC6Mo7GDnTpih/xvPYYKyW/1Y3cVhGhP3C0BzS6lpxKHEBok03cbMWxL8SghBHTs48Fz4h9rXDLUYUgmRFGbHFvHTIu6fxY7AXhbD0DaA6/oA6yA0Sukr8jrCAQFc0saExdjcf/o1Aq9n71QAbCRtGL0nttpCdKKuEqfXoiD/Yoq6zxu75UUP1g==;5:PLJcuXyvAdkObbpMwbPqZUzLZ57/1jkaA7LUCk2kiuLQiVUqLm+2jydOotPBFhpdJaStpuJlxb8GgXaBHIOwvaEXm91YmT3bqZa1rkZqbXEVJ2/8SPq6sYnORIE4hv7BPCqhmtHtpXox21YukKwW7m6KH0K8facH02f6qQQnwaA=;7:cx3NWZL5OdnF07GYf7VJNhKeqo77+K7kLpJ56cXTd5WgYl+bRkL/OjNXyCwI3UmvEm+PKunOeE2Wtm9PRBVzGj71BLo54str8F7QLYfI2RnmooMZHgdJbc+a5UdgiBSRaq3UA7BBMScIMwTGRtFcXw==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: cd92d640-8665-4b43-da6f-08d64ed76af7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:HE1PR0401MB2202;
x-ms-traffictypediagnostic: HE1PR0401MB2202:
x-microsoft-antispam-prvs: <HE1PR0401MB22027F4E30BDDA7E0F87F0C9E8D90@HE1PR0401MB2202.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231442)(944501410)(52105112)(3002001)(10201501046)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:HE1PR0401MB2202;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0401MB2202;
x-forefront-prvs: 08626BE3A5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(376002)(39860400002)(346002)(136003)(366004)(189003)(199004)(13464003)(6506007)(53546011)(102836004)(99286004)(26005)(186003)(76176011)(7696005)(229853002)(106356001)(105586002)(54906003)(6436002)(14454004)(33656002)(25786009)(110136005)(486006)(3846002)(478600001)(68736007)(2900100001)(476003)(316002)(11346002)(446003)(53936002)(9686003)(55016002)(2201001)(81156014)(81166006)(74316002)(71200400001)(8936002)(71190400001)(7736002)(8676002)(66066001)(97736004)(305945005)(5660300001)(2501003)(6116002)(4326008)(2906002)(6246003)(7416002)(86362001)(256004)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR0401MB2202;H:HE1PR0401MB2235.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: aneeokM8PvgwT9I6A/yO1raIi7BcvNrNPQq2Zch29EFlG+2k2lV1RVH1QVQPZ3cJe/PMZksfz5taKTmU6V5X8F1vvv7zyd38OQhqY9O7T+Rlk4nT0Ma0MI4lvgRxsY2Am/nFpPDtD9qS28vUzbz79Xd45dniM3/T03X/5z2HYkpRTnMpFJbdLCfHaHbiKfV+Z46RycEoilCcAI1PQfoxH+S4u7h/HVZu9B0B8dvnJBhQ4R9/7PnU+wIwPIzaHvEzUIT6KG7C/BtYjZvjFiVekINI2Jpe2icW3yhvqGPntHU6a19Y1sKeMnfkinozudv7XpDAI/i8IRIho3DAvh6SoJRZjAQQVPIjuRmYODvj0K0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd92d640-8665-4b43-da6f-08d64ed76af7
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2018 11:00:43.7035
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0401MB2202
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
> Subject: [PATCHv2 10/25] PCI: mobiveil: fix the INTx process error
>=20
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
>=20
> In the loop block, there is not code change the loop key, this patch upda=
ted
> the loop key by re-read the INTx status register.
>=20
> This patch also change to clear the handled INTx status.
>=20
> Note: Need MV to test this fix.
>=20
> Fixes: 9af6bcb11e12 ("PCI: mobiveil: Add Mobiveil PCIe Host Bridge IP dri=
ver")
> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> ---
> V2:
>  - Added fixes entry.
>=20
>  drivers/pci/controller/pcie-mobiveil.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/pci/controller/pcie-mobiveil.c
> b/drivers/pci/controller/pcie-mobiveil.c
> index 4ba458474e42..78e575e71f4d 100644
> --- a/drivers/pci/controller/pcie-mobiveil.c
> +++ b/drivers/pci/controller/pcie-mobiveil.c
> @@ -361,6 +361,7 @@ static void mobiveil_pcie_isr(struct irq_desc *desc)
>  	/* Handle INTx */
>  	if (intr_status & PAB_INTP_INTX_MASK) {
>  		shifted_status =3D csr_readl(pcie,
> PAB_INTP_AMBA_MISC_STAT);
> +		shifted_status &=3D PAB_INTP_INTX_MASK;
>  		shifted_status >>=3D PAB_INTX_START;
>  		do {
>  			for_each_set_bit(bit, &shifted_status,
> PCI_NUM_INTX) { @@ -372,12 +373,16 @@ static void
> mobiveil_pcie_isr(struct irq_desc *desc)
>  					dev_err_ratelimited(dev,
> "unexpected IRQ, INT%d\n",
>  							    bit);
>=20
> -				/* clear interrupt */
> -				csr_writel(pcie,
> -					   shifted_status << PAB_INTX_START,
> +				/* clear interrupt handled */
> +				csr_writel(pcie, 1 << (PAB_INTX_START + bit),
>  					   PAB_INTP_AMBA_MISC_STAT);
>  			}
> -		} while ((shifted_status >> PAB_INTX_START) !=3D 0);
> +
> +			shifted_status =3D csr_readl(pcie,
> +
> PAB_INTP_AMBA_MISC_STAT);
> +			shifted_status &=3D PAB_INTP_INTX_MASK;
> +			shifted_status >>=3D PAB_INTX_START;
> +		} while (shifted_status !=3D 0);
>  	}
>=20
>  	/* read extra MSI status register */
> --
> 2.17.1

