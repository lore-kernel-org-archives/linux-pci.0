Return-Path: <SRS0=4GJS=N7=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B20AEC4161B
	for <linux-pci@archiver.kernel.org>; Tue, 20 Nov 2018 11:31:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66C082087E
	for <linux-pci@archiver.kernel.org>; Tue, 20 Nov 2018 11:31:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="UVx0Rjgu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66C082087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729110AbeKTV7q (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 20 Nov 2018 16:59:46 -0500
Received: from mail-eopbgr60063.outbound.protection.outlook.com ([40.107.6.63]:55376
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729108AbeKTV7p (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 20 Nov 2018 16:59:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NOc+j1l2Tugx+wFo8DZYJxGVRieTgFQ6wTR0hHpRmhE=;
 b=UVx0RjguI6glRU+LleIxkstT2HrrOy1zIPpPGYQ5vc4dqFtdHMwVXY8wsoxiiIEwIsN9D0AhrIbT8hela4etiUukclwe7m8vOIbhvTZfgF+uP+TyPRK4tLasrJ7T9PwOxK3NPcAu2Clmq9mnNzCpFUxwk51HKEPuh5OcsFcoO1M=
Received: from HE1PR0401MB2235.eurprd04.prod.outlook.com (10.168.32.20) by
 HE1PR0401MB2297.eurprd04.prod.outlook.com (10.168.32.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1339.23; Tue, 20 Nov 2018 11:30:59 +0000
Received: from HE1PR0401MB2235.eurprd04.prod.outlook.com
 ([fe80::60ff:1b2a:d0fd:5bd2]) by HE1PR0401MB2235.eurprd04.prod.outlook.com
 ([fe80::60ff:1b2a:d0fd:5bd2%8]) with mapi id 15.20.1339.027; Tue, 20 Nov 2018
 11:30:59 +0000
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
Subject: RE: [PATCHv2 21/25] PCI: mobiveil: make mobiveil_host_init can be
 used to re-init host
Thread-Topic: [PATCHv2 21/25] PCI: mobiveil: make mobiveil_host_init can be
 used to re-init host
Thread-Index: AQHUgLNM3A/Z0pFGckGmABxQsi+m7aVYhrkA
Date:   Tue, 20 Nov 2018 11:30:58 +0000
Message-ID: <HE1PR0401MB223545A1B302BE7B5BC816FCE8D90@HE1PR0401MB2235.eurprd04.prod.outlook.com>
References: <20181120092615.11680-1-Zhiqiang.Hou@nxp.com>
 <20181120092615.11680-22-Zhiqiang.Hou@nxp.com>
In-Reply-To: <20181120092615.11680-22-Zhiqiang.Hou@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=minghuan.lian@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HE1PR0401MB2297;6:CVJKp9ta0DcihYXqf3zbSRCrwD3fXKdK9qCfUt89eRtA+D394FLWXvoG/2kgFW8FCwcx78twupqr/SCAPubzXn1GYZMN5aySc5FTyu6iva6U+8XTqjepwRpHryLCAbduMzYe6ugKYCEEcy8yNbzTN/oAFX40Vke7v0t5oz9bVL/Kt7RqbaBPFZeAJwqWPOi1BUcpfyqOgp5UGEyA1LvXtbV8+Nmkkg1NoIcrS921YlDoHw8I8cOmpgwVu9wVV/8hWruIWi4Jprbj60XxlP4U6wLKrdHLKwf0JWKaBKlu8gube/Geinvqg5xHbGM12WM9GzdNBKi492jvoitxA97KH06c0C7rPpKtjvK9eRObzLLOKgto6SGEQxurOfi32v6e1X8iZco/I72pbrVlGUb3dofTC/jc50vbbe5LRCiiYf9UQWWiGFKduK3cN1bB6iuJ6qoVSx15yztEXQENmrHF6Q==;5:0jd+nof+D9Rh6DpXUQ54mAIOhochGuK0hOQiOVsMOL6ofRIst0b/CQCH25nOlWU91NRpo5IfNtLRH2uQQLpcsTDu0FvJbiOK9m0XA4XPoJz/JgRyFmi9mvTfUcOlkUYteLwOipnPHVu0OfZUIBeQs+NxuxJdu/N/yB/6EPRQG8M=;7:kvHfY5+BHHV5i/0SoqOkRV/++9A27Kz6qDiL5pa79eIHl4zU8s8+kT74ibLcTJMyMHABUxiNRY37JNZtW3/S8BhFFwKzvJ43kUjpm0ZIvYYAbaVpMh8ewAAAMImC7Rthf7hz5f7a2zw9vuqfq6bN3Q==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 42b05a34-94db-4518-8060-08d64edba4d9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:HE1PR0401MB2297;
x-ms-traffictypediagnostic: HE1PR0401MB2297:
x-microsoft-antispam-prvs: <HE1PR0401MB2297987EAE63FE79C242651CE8D90@HE1PR0401MB2297.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231442)(944501410)(52105112)(3002001)(10201501046)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:HE1PR0401MB2297;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0401MB2297;
x-forefront-prvs: 08626BE3A5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(346002)(376002)(136003)(366004)(39860400002)(189003)(199004)(13464003)(11346002)(446003)(3846002)(6506007)(6116002)(9686003)(33656002)(5660300001)(106356001)(99286004)(26005)(2900100001)(486006)(76176011)(7696005)(14454004)(2501003)(6246003)(476003)(6436002)(2906002)(53546011)(102836004)(8936002)(55016002)(105586002)(478600001)(81166006)(14444005)(81156014)(8676002)(7736002)(256004)(305945005)(2201001)(575784001)(97736004)(74316002)(53936002)(229853002)(316002)(71200400001)(25786009)(186003)(7416002)(71190400001)(68736007)(54906003)(110136005)(86362001)(4326008)(66066001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR0401MB2297;H:HE1PR0401MB2235.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: VthzyBWpXgFqFfQcamADqr6CeHTSQ3sjmkj8MFaBQLgD/9M+rK/P+3l8srd6HzULXWU0qbb1YbAG+wd2DOfD+WeR4Hs8FpK7aWlVIcNyDsFD+8KPSyNoF+iAT4XROhBlmouB6wR5es/sU6bUkjZvjBmHfzlbW7HQE+rNbOXatzVtXG48d1TOCsFel0ZJdsD9zCIg9qm7fUCylIMxY7fmakLeiEUe8La7fvsxU3083gwXhRmcQUsUAnIfWdPjexBSAtmRwpP67oopHH6V4JzkVxYqvRFSU3oVuAPpPC9/2rnHFc7iQQbTrPKfxTyXx+q7sRMDXznj4nzC3MDOH9CswWhZHiLqoMVH7KsSYjtX3W4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42b05a34-94db-4518-8060-08d64edba4d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2018 11:30:58.8463
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
> Subject: [PATCHv2 21/25] PCI: mobiveil: make mobiveil_host_init can be us=
ed
> to re-init host
>=20
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
>=20
> Make the mobiveil_host_init function can be used to re-init host controll=
er's
> PAB and GPEX CSR register block, as NXP integrated Mobiveil IP has to res=
et
> and then re-init the PAB and GPEX CSR registers upon Hot-reset.
>=20
> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> ---
> V2:
>  - Reset the statistic of IB/OB windows configured.
>  - Change the type of member 'resources' to pointer to record the parsed
>    resources for re-init the outbound windows.
>=20
>  .../controller/mobiveil/pcie-mobiveil-host.c  | 32 +++++++++++--------
>  .../pci/controller/mobiveil/pcie-mobiveil.h   |  3 +-
>  2 files changed, 20 insertions(+), 15 deletions(-)
>=20
> diff --git a/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
> b/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
> index d028cdf31d0e..c85f00d3cfcf 100644
> --- a/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
> +++ b/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
> @@ -217,7 +217,7 @@ static void mobiveil_pcie_enable_msi(struct
> mobiveil_pcie *pcie)
>  	writel_relaxed(1, pcie->apb_csr_base + MSI_ENABLE_OFFSET);  }
>=20
> -static int mobiveil_host_init(struct mobiveil_pcie *pcie)
> +int mobiveil_host_init(struct mobiveil_pcie *pcie, bool reinit)
>  {
>  	u32 value, pab_ctrl, type;
>  	struct resource_entry *win;
> @@ -229,11 +229,16 @@ static int mobiveil_host_init(struct mobiveil_pcie
> *pcie)
>  	for (i =3D 0; i < pcie->ppio_wins; i++)
>  		mobiveil_pcie_disable_ib_win(pcie, i);
>=20
> -	/* setup bus numbers */
> -	value =3D csr_readl(pcie, PCI_PRIMARY_BUS);
> -	value &=3D 0xff000000;
> -	value |=3D 0x00ff0100;
> -	csr_writel(pcie, value, PCI_PRIMARY_BUS);
> +	pcie->ib_wins_configured =3D 0;
> +	pcie->ob_wins_configured =3D 0;
> +
> +	if (!reinit) {
> +		/* setup bus numbers */
> +		value =3D csr_readl(pcie, PCI_PRIMARY_BUS);
> +		value &=3D 0xff000000;
> +		value |=3D 0x00ff0100;
> +		csr_writel(pcie, value, PCI_PRIMARY_BUS);
> +	}
>=20
>  	/*
>  	 * program Bus Master Enable Bit in Command Register in PAB Config
> @@ -279,7 +284,7 @@ static int mobiveil_host_init(struct mobiveil_pcie
> *pcie)
>  	program_ib_windows(pcie, WIN_NUM_0, 0, 0,
> MEM_WINDOW_TYPE, IB_WIN_SIZE);
>=20
>  	/* Get the I/O and memory ranges from DT */
> -	resource_list_for_each_entry(win, &pcie->resources) {
> +	resource_list_for_each_entry(win, pcie->resources) {
>  		if (resource_type(win->res) =3D=3D IORESOURCE_MEM) {
>  			type =3D MEM_WINDOW_TYPE;
>  		} else if (resource_type(win->res) =3D=3D IORESOURCE_IO) { @@ -
> 550,8 +555,6 @@ int mobiveil_pcie_host_probe(struct mobiveil_pcie *pcie)
>  	resource_size_t iobase;
>  	int ret;
>=20
> -	INIT_LIST_HEAD(&pcie->resources);
> -
>  	ret =3D mobiveil_pcie_parse_dt(pcie);
>  	if (ret) {
>  		dev_err(dev, "Parsing DT failed, ret: %x\n", ret); @@ -565,17
> +568,19 @@ int mobiveil_pcie_host_probe(struct mobiveil_pcie *pcie)
>=20
>  	/* parse the host bridge base addresses from the device tree file */
>  	ret =3D devm_of_pci_get_host_bridge_resources(dev, 0, 0xff,
> -						    &pcie->resources, &iobase);
> +						    &bridge->windows,
> &iobase);
>  	if (ret) {
>  		dev_err(dev, "Getting bridge resources failed\n");
>  		return ret;
>  	}
>=20
> +	pcie->resources =3D &bridge->windows;
> +
>  	/*
>  	 * configure all inbound and outbound windows and prepare the RC
> for
>  	 * config access
>  	 */
> -	ret =3D mobiveil_host_init(pcie);
> +	ret =3D mobiveil_host_init(pcie, false);
>  	if (ret) {
>  		dev_err(dev, "Failed to initialize host\n");
>  		goto error;
> @@ -587,12 +592,11 @@ int mobiveil_pcie_host_probe(struct mobiveil_pcie
> *pcie)
>  		goto error;
>  	}
>=20
> -	ret =3D devm_request_pci_bus_resources(dev, &pcie->resources);
> +	ret =3D devm_request_pci_bus_resources(dev, pcie->resources);
>  	if (ret)
>  		goto error;
>=20
>  	/* Initialize bridge */
> -	list_splice_init(&pcie->resources, &bridge->windows);
>  	bridge->dev.parent =3D dev;
>  	bridge->sysdata =3D pcie;
>  	bridge->busnr =3D pcie->rp.root_bus_nr;
> @@ -619,6 +623,6 @@ int mobiveil_pcie_host_probe(struct mobiveil_pcie
> *pcie)
>=20
>  	return 0;
>  error:
> -	pci_free_resource_list(&pcie->resources);
> +	pci_free_resource_list(pcie->resources);
>  	return ret;
>  }
> diff --git a/drivers/pci/controller/mobiveil/pcie-mobiveil.h
> b/drivers/pci/controller/mobiveil/pcie-mobiveil.h
> index 933c2f34bc52..0f5303962e88 100644
> --- a/drivers/pci/controller/mobiveil/pcie-mobiveil.h
> +++ b/drivers/pci/controller/mobiveil/pcie-mobiveil.h
> @@ -152,7 +152,7 @@ struct mobiveil_pab_ops {
>=20
>  struct mobiveil_pcie {
>  	struct platform_device *pdev;
> -	struct list_head resources;
> +	struct list_head *resources;
>  	void __iomem *csr_axi_slave_base;	/* PAB registers base */
>  	phys_addr_t pcie_reg_base;	/* Physical PCIe Controller Base */
>  	void __iomem *apb_csr_base;	/* MSI register base */
> @@ -165,6 +165,7 @@ struct mobiveil_pcie {  };
>=20
>  int mobiveil_pcie_host_probe(struct mobiveil_pcie *pcie);
> +int mobiveil_host_init(struct mobiveil_pcie *pcie, bool reinit);
>  bool mobiveil_pcie_link_up(struct mobiveil_pcie *pcie);  int
> mobiveil_bringup_link(struct mobiveil_pcie *pcie);  void
> program_ob_windows(struct mobiveil_pcie *pcie, int win_num, u64
> cpu_addr,
> --
> 2.17.1

