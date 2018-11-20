Return-Path: <SRS0=4GJS=N7=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 310E1C43441
	for <linux-pci@archiver.kernel.org>; Tue, 20 Nov 2018 10:17:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEE56208E4
	for <linux-pci@archiver.kernel.org>; Tue, 20 Nov 2018 10:17:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="hyAyaSYU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEE56208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726253AbeKTUpa (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 20 Nov 2018 15:45:30 -0500
Received: from mail-eopbgr50050.outbound.protection.outlook.com ([40.107.5.50]:15803
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726177AbeKTUpa (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 20 Nov 2018 15:45:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7byRCVGejvOmOHZkIe8P/5BG5CNvkgSq/v69RaNGwr0=;
 b=hyAyaSYUD7fm5zxn9zAWIzN2fUvv6QDdzo5NkL2PKS7j0RbnpAE3evIX3YH1/3HnuKrjD5VFcD762HP7dfw/qf3zP4CTazJwHnwKJvtVYJzAOZAz7Tq1EzQLKHhA0hHnmk4XfTJ1l+adpigAMQHgWp8ep8fvOMTWwUzaAo6N2tA=
Received: from HE1PR0401MB2235.eurprd04.prod.outlook.com (10.168.32.20) by
 HE1PR0401MB1770.eurprd04.prod.outlook.com (10.169.118.148) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1339.26; Tue, 20 Nov 2018 10:17:01 +0000
Received: from HE1PR0401MB2235.eurprd04.prod.outlook.com
 ([fe80::60ff:1b2a:d0fd:5bd2]) by HE1PR0401MB2235.eurprd04.prod.outlook.com
 ([fe80::60ff:1b2a:d0fd:5bd2%8]) with mapi id 15.20.1339.027; Tue, 20 Nov 2018
 10:17:00 +0000
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
Subject: RE: [PATCHv2 01/25] PCI: mobiveil: uniform the register accessors
Thread-Topic: [PATCHv2 01/25] PCI: mobiveil: uniform the register accessors
Thread-Index: AQHUgLMDpFVmi5B5TUe8o9WTM7kGlKVYct1A
Date:   Tue, 20 Nov 2018 10:17:00 +0000
Message-ID: <HE1PR0401MB223598EE9DB8F00248464BEFE8D90@HE1PR0401MB2235.eurprd04.prod.outlook.com>
References: <20181120092615.11680-1-Zhiqiang.Hou@nxp.com>
 <20181120092615.11680-2-Zhiqiang.Hou@nxp.com>
In-Reply-To: <20181120092615.11680-2-Zhiqiang.Hou@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=minghuan.lian@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HE1PR0401MB1770;6:TV6Iq5w528l0dujO9JQmoqA/a+/YnxgJ1Wnp0VUuP9IANnJ0SEYsbTKft6W0QCwnADINVBDXZVHSYHbevYxKVEWQ+TOiOX0q+d/oqV+i614cRV67h47DaKcWZtpsD6f9ve6zyYIr9E7tT0zfPicFvEp56kmYLkl30PCg1NLbreO2484cFx+Zc0yum/YxmNyYRO7jkjXSy69KFfD39xixR8t3vAcl9EX4aJ5Co18hv5RpCTTZS3+8EfDharXErfNL2nZq5WAEBkwb0F080EhMxe88NDmZlXzBKKbZO9jkQZmLgq4OtSO6vJdExnyXIPFcPdJsDnNG2YYeE9w8drMljCBDb3+TJuZwBdol8PDqFFCtKB9b3chlQSndbhMJ/am0/89VYo/RVN7YolAQkFlSf2ar2e4/gnrtg7qSDSCddfMPdflT/3/u68j/ia8i8jCQPO1B43iBTB6XAnnP6ae8Cw==;5:hCb9iQccmtvIpRJKyVp6kpNMC+ZvlxmqY8hHs3wGC7g+/2pQuBlFhcsrYNNV7Z7tTQS0rrI8L0F1GV9qi9hdgcfoxPCM0b1T2KpthcNGoYX9LfLMFE7t+fXfMN92H7zOl93EZ8XqnXo83ucgZyOB3S+lDJUmWesEufKzHvXn4ac=;7:grUcRL/IZjIbjuBzsdFmjTr8on31lm61uIPxhzZu5+/Fj9LGHqcBI8Wbi6Tp7t8TcVu9l8H1Ebax8+Tf8YQl6tXtDJVh1fT/Lc0lTxSzSjCIP3RexY3vMXaXFIF+YMUkKhPAVOn6JlAoeR330tzPvA==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: b58f3b35-2a08-4d44-734d-08d64ed14f8a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:HE1PR0401MB1770;
x-ms-traffictypediagnostic: HE1PR0401MB1770:
x-microsoft-antispam-prvs: <HE1PR0401MB17706BF979B0075C9F4C984FE8D90@HE1PR0401MB1770.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231442)(944501410)(52105112)(93006095)(93001095)(10201501046)(3002001)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:HE1PR0401MB1770;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0401MB1770;
x-forefront-prvs: 08626BE3A5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(346002)(136003)(366004)(376002)(396003)(13464003)(189003)(199004)(2201001)(81156014)(81166006)(8936002)(8676002)(26005)(86362001)(575784001)(6436002)(106356001)(105586002)(2501003)(478600001)(186003)(11346002)(6506007)(102836004)(229853002)(97736004)(53546011)(2906002)(446003)(76176011)(99286004)(25786009)(14444005)(7696005)(256004)(71200400001)(71190400001)(14454004)(3846002)(6116002)(7736002)(305945005)(4326008)(110136005)(54906003)(74316002)(5660300001)(6246003)(2900100001)(316002)(68736007)(486006)(33656002)(476003)(7416002)(53936002)(9686003)(66066001)(55016002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR0401MB1770;H:HE1PR0401MB2235.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: W3O+jhpQ73r9Jbg2azAaJJllHE+twFfo7GHTv0oe9iQnVQrhHBCEdyWT9+0Iy8wbuYgWfUTsGSlFgkc3F+KMHtbPojfBMfkrELLiyh3XstIwhwNBbSqocKDd/LUQsD4Zi3f4iPlNDZPu15RFPOejUTaDxuT9yixmIL0R9k+bNFQU3U3ODMU4AcMO/PvFeNfj1ha1V9DWmoTt0Y/nXAQ1tKt2aYtOuYTizKwylZqYsKXQCBYOp9xabrvH7X65cMZQL+U5gJGgp+SbyrDnOf6SZ+H7VjjRMXvqxKebVVfcSdDXNOh0jTuadTPCNH1ADVFjGfDDt341XbN7Xxvsi9Hu97PsRNRkr0Y2t+U/SlC3SoI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b58f3b35-2a08-4d44-734d-08d64ed14f8a
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2018 10:17:00.7233
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0401MB1770
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
> Subject: [PATCHv2 01/25] PCI: mobiveil: uniform the register accessors
>=20
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
>=20
> It's confused that R/W some registers by csr_readl()/csr_writel(), while
> others by read_paged_register()/write_paged_register().
> Actually the low 3KB of 4KB PCIe configure space can be accessed directly=
 and
> high 1KB is paging area. So this patch uniformed the register accessors t=
o
> csr_readl() and csr_writel() by comparing the register offset with page a=
ccess
> boundary 3KB in the accessor internal.
>=20
> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> ---
> V2:
>  - no change
>=20
>  drivers/pci/controller/pcie-mobiveil.c | 179 +++++++++++++++++--------
>  1 file changed, 124 insertions(+), 55 deletions(-)
>=20
> diff --git a/drivers/pci/controller/pcie-mobiveil.c
> b/drivers/pci/controller/pcie-mobiveil.c
> index 77052a0712d0..d55c7e780c6e 100644
> --- a/drivers/pci/controller/pcie-mobiveil.c
> +++ b/drivers/pci/controller/pcie-mobiveil.c
> @@ -47,7 +47,6 @@
>  #define  PAGE_SEL_SHIFT	13
>  #define  PAGE_SEL_MASK		0x3f
>  #define  PAGE_LO_MASK		0x3ff
> -#define  PAGE_SEL_EN		0xc00
>  #define  PAGE_SEL_OFFSET_SHIFT	10
>=20
>  #define PAB_AXI_PIO_CTRL	0x0840
> @@ -117,6 +116,12 @@
>  #define LINK_WAIT_MIN	90000
>  #define LINK_WAIT_MAX	100000
>=20
> +#define PAGED_ADDR_BNDRY			0xc00
> +#define OFFSET_TO_PAGE_ADDR(off)		\
> +	((off & PAGE_LO_MASK) | PAGED_ADDR_BNDRY)
> +#define OFFSET_TO_PAGE_IDX(off)			\
> +	((off >> PAGE_SEL_OFFSET_SHIFT) & PAGE_SEL_MASK)
> +
>  struct mobiveil_msi {			/* MSI information */
>  	struct mutex lock;		/* protect bitmap variable */
>  	struct irq_domain *msi_domain;
> @@ -145,15 +150,119 @@ struct mobiveil_pcie {
>  	struct mobiveil_msi msi;
>  };
>=20
> -static inline void csr_writel(struct mobiveil_pcie *pcie, const u32 valu=
e,
> -		const u32 reg)
> +/*
> + * mobiveil_pcie_sel_page - routine to access paged register
> + *
> + * Registers whose address greater than PAGED_ADDR_BNDRY (0xc00) are
> +paged,
> + * for this scheme to work extracted higher 6 bits of the offset will
> +be
> + * written to pg_sel field of PAB_CTRL register and rest of the lower
> +10
> + * bits enabled with PAGED_ADDR_BNDRY are used as offset of the register=
.
> + */
> +static void mobiveil_pcie_sel_page(struct mobiveil_pcie *pcie, u8
> +pg_idx)
>  {
> -	writel_relaxed(value, pcie->csr_axi_slave_base + reg);
> +	u32 val;
> +
> +	val =3D readl(pcie->csr_axi_slave_base + PAB_CTRL);
> +	val &=3D ~(PAGE_SEL_MASK << PAGE_SEL_SHIFT);
> +	val |=3D (pg_idx & PAGE_SEL_MASK) << PAGE_SEL_SHIFT;
> +
> +	writel(val, pcie->csr_axi_slave_base + PAB_CTRL);
>  }
>=20
> -static inline u32 csr_readl(struct mobiveil_pcie *pcie, const u32 reg)
> +static void *mobiveil_pcie_comp_addr(struct mobiveil_pcie *pcie, u32
> +off)
>  {
> -	return readl_relaxed(pcie->csr_axi_slave_base + reg);
> +	if (off < PAGED_ADDR_BNDRY) {
> +		/* For directly accessed registers, clear the pg_sel field */
> +		mobiveil_pcie_sel_page(pcie, 0);
> +		return pcie->csr_axi_slave_base + off;
> +	}
> +
> +	mobiveil_pcie_sel_page(pcie, OFFSET_TO_PAGE_IDX(off));
> +	return pcie->csr_axi_slave_base + OFFSET_TO_PAGE_ADDR(off); }
> +
> +static int mobiveil_pcie_read(void __iomem *addr, int size, u32 *val) {
> +	if ((uintptr_t)addr & (size - 1)) {
> +		*val =3D 0;
> +		return PCIBIOS_BAD_REGISTER_NUMBER;
> +	}
> +
> +	switch (size) {
> +	case 4:
> +		*val =3D readl(addr);
> +		break;
> +	case 2:
> +		*val =3D readw(addr);
> +		break;
> +	case 1:
> +		*val =3D readb(addr);
> +		break;
> +	default:
> +		*val =3D 0;
> +		return PCIBIOS_BAD_REGISTER_NUMBER;
> +	}
> +
> +	return PCIBIOS_SUCCESSFUL;
> +}
> +
> +static int mobiveil_pcie_write(void __iomem *addr, int size, u32 val) {
> +	if ((uintptr_t)addr & (size - 1))
> +		return PCIBIOS_BAD_REGISTER_NUMBER;
> +
> +	switch (size) {
> +	case 4:
> +		writel(val, addr);
> +		break;
> +	case 2:
> +		writew(val, addr);
> +		break;
> +	case 1:
> +		writeb(val, addr);
> +		break;
> +	default:
> +		return PCIBIOS_BAD_REGISTER_NUMBER;
> +	}
> +
> +	return PCIBIOS_SUCCESSFUL;
> +}
> +
> +static u32 csr_read(struct mobiveil_pcie *pcie, u32 off, size_t size) {
> +	void *addr;
> +	u32 val;
> +	int ret;
> +
> +	addr =3D mobiveil_pcie_comp_addr(pcie, off);
> +
> +	ret =3D mobiveil_pcie_read(addr, size, &val);
> +	if (ret)
> +		dev_err(&pcie->pdev->dev, "read CSR address failed\n");
> +
> +	return val;
> +}
> +
> +static void csr_write(struct mobiveil_pcie *pcie, u32 val, u32 off,
> +size_t size) {
> +	void *addr;
> +	int ret;
> +
> +	addr =3D mobiveil_pcie_comp_addr(pcie, off);
> +
> +	ret =3D mobiveil_pcie_write(addr, size, val);
> +	if (ret)
> +		dev_err(&pcie->pdev->dev, "write CSR address failed\n"); }
> +
> +static u32 csr_readl(struct mobiveil_pcie *pcie, u32 off) {
> +	return csr_read(pcie, off, 0x4);
> +}
> +
> +static void csr_writel(struct mobiveil_pcie *pcie, u32 val, u32 off) {
> +	csr_write(pcie, val, off, 0x4);
>  }
>=20
>  static bool mobiveil_pcie_link_up(struct mobiveil_pcie *pcie) @@ -342,45
> +451,6 @@ static int mobiveil_pcie_parse_dt(struct mobiveil_pcie *pcie)
>  	return 0;
>  }
>=20
> -/*
> - * select_paged_register - routine to access paged register of root comp=
lex
> - *
> - * registers of RC are paged, for this scheme to work
> - * extracted higher 6 bits of the offset will be written to pg_sel
> - * field of PAB_CTRL register and rest of the lower 10 bits enabled with
> - * PAGE_SEL_EN are used as offset of the register.
> - */
> -static void select_paged_register(struct mobiveil_pcie *pcie, u32 offset=
) -{
> -	int pab_ctrl_dw, pg_sel;
> -
> -	/* clear pg_sel field */
> -	pab_ctrl_dw =3D csr_readl(pcie, PAB_CTRL);
> -	pab_ctrl_dw =3D (pab_ctrl_dw & ~(PAGE_SEL_MASK <<
> PAGE_SEL_SHIFT));
> -
> -	/* set pg_sel field */
> -	pg_sel =3D (offset >> PAGE_SEL_OFFSET_SHIFT) & PAGE_SEL_MASK;
> -	pab_ctrl_dw |=3D ((pg_sel << PAGE_SEL_SHIFT));
> -	csr_writel(pcie, pab_ctrl_dw, PAB_CTRL);
> -}
> -
> -static void write_paged_register(struct mobiveil_pcie *pcie,
> -		u32 val, u32 offset)
> -{
> -	u32 off =3D (offset & PAGE_LO_MASK) | PAGE_SEL_EN;
> -
> -	select_paged_register(pcie, offset);
> -	csr_writel(pcie, val, off);
> -}
> -
> -static u32 read_paged_register(struct mobiveil_pcie *pcie, u32 offset) -=
{
> -	u32 off =3D (offset & PAGE_LO_MASK) | PAGE_SEL_EN;
> -
> -	select_paged_register(pcie, offset);
> -	return csr_readl(pcie, off);
> -}
> -
>  static void program_ib_windows(struct mobiveil_pcie *pcie, int win_num,
>  		int pci_addr, u32 type, u64 size)
>  {
> @@ -397,19 +467,19 @@ static void program_ib_windows(struct
> mobiveil_pcie *pcie, int win_num,
>  	pio_ctrl_val =3D csr_readl(pcie, PAB_PEX_PIO_CTRL);
>  	csr_writel(pcie,
>  		pio_ctrl_val | (1 << PIO_ENABLE_SHIFT), PAB_PEX_PIO_CTRL);
> -	amap_ctrl_dw =3D read_paged_register(pcie,
> PAB_PEX_AMAP_CTRL(win_num));
> +	amap_ctrl_dw =3D csr_readl(pcie, PAB_PEX_AMAP_CTRL(win_num));
>  	amap_ctrl_dw =3D (amap_ctrl_dw | (type << AMAP_CTRL_TYPE_SHIFT));
>  	amap_ctrl_dw =3D (amap_ctrl_dw | (1 << AMAP_CTRL_EN_SHIFT));
>=20
> -	write_paged_register(pcie, amap_ctrl_dw | lower_32_bits(size64),
> -				PAB_PEX_AMAP_CTRL(win_num));
> +	csr_writel(pcie, amap_ctrl_dw | lower_32_bits(size64),
> +		   PAB_PEX_AMAP_CTRL(win_num));
>=20
> -	write_paged_register(pcie, upper_32_bits(size64),
> -				PAB_EXT_PEX_AMAP_SIZEN(win_num));
> +	csr_writel(pcie, upper_32_bits(size64),
> +		   PAB_EXT_PEX_AMAP_SIZEN(win_num));
>=20
> -	write_paged_register(pcie, pci_addr,
> PAB_PEX_AMAP_AXI_WIN(win_num));
> -	write_paged_register(pcie, pci_addr,
> PAB_PEX_AMAP_PEX_WIN_L(win_num));
> -	write_paged_register(pcie, 0,
> PAB_PEX_AMAP_PEX_WIN_H(win_num));
> +	csr_writel(pcie, pci_addr, PAB_PEX_AMAP_AXI_WIN(win_num));
> +	csr_writel(pcie, pci_addr, PAB_PEX_AMAP_PEX_WIN_L(win_num));
> +	csr_writel(pcie, 0, PAB_PEX_AMAP_PEX_WIN_H(win_num));
>  }
>=20
>  /*
> @@ -437,8 +507,7 @@ static void program_ob_windows(struct
> mobiveil_pcie *pcie, int win_num,
>  	csr_writel(pcie, 1 << WIN_ENABLE_SHIFT | type << WIN_TYPE_SHIFT
> |
>  			lower_32_bits(size64),
> PAB_AXI_AMAP_CTRL(win_num));
>=20
> -	write_paged_register(pcie, upper_32_bits(size64),
> -				PAB_EXT_AXI_AMAP_SIZE(win_num));
> +	csr_writel(pcie, upper_32_bits(size64),
> +PAB_EXT_AXI_AMAP_SIZE(win_num));
>=20
>  	/*
>  	 * program AXI window base with appropriate value in
> --
> 2.17.1

