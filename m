Return-Path: <SRS0=4GJS=N7=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1EF8C43441
	for <linux-pci@archiver.kernel.org>; Tue, 20 Nov 2018 11:01:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8526420989
	for <linux-pci@archiver.kernel.org>; Tue, 20 Nov 2018 11:01:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="khmsfChM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8526420989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728021AbeKTV3L (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 20 Nov 2018 16:29:11 -0500
Received: from mail-eopbgr60062.outbound.protection.outlook.com ([40.107.6.62]:3050
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727118AbeKTV3L (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 20 Nov 2018 16:29:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A2TwjYXiPUhrch1GNHWzKBVXdvByxxGAu5i4SeR41Hg=;
 b=khmsfChMVeOSMKGAe8m8g507xB4w7pmYdS0HFzvDdLCJFtV+lVAAQh9w7xIER7hNdo34NAkAHwoQfYsA3bYTt6naGazD2Oqr1WOToUFRKFnprngLNheYJUTh8DPddKc3psBPGvWd7CE4M17PzsGNtMiyqBvjde8KVljL0wTxQI0=
Received: from HE1PR0401MB2235.eurprd04.prod.outlook.com (10.168.32.20) by
 HE1PR0401MB2202.eurprd04.prod.outlook.com (10.166.76.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1339.26; Tue, 20 Nov 2018 11:00:29 +0000
Received: from HE1PR0401MB2235.eurprd04.prod.outlook.com
 ([fe80::60ff:1b2a:d0fd:5bd2]) by HE1PR0401MB2235.eurprd04.prod.outlook.com
 ([fe80::60ff:1b2a:d0fd:5bd2%8]) with mapi id 15.20.1339.027; Tue, 20 Nov 2018
 11:00:29 +0000
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
Subject: RE: [PATCHv2 09/25] PCI: mobiveil: correct inbound/outbound window
 setup routines
Thread-Topic: [PATCHv2 09/25] PCI: mobiveil: correct inbound/outbound window
 setup routines
Thread-Index: AQHUgLMfkENIss5XQkaaWgfFbCFRCaVYfwbQ
Date:   Tue, 20 Nov 2018 11:00:29 +0000
Message-ID: <HE1PR0401MB223528FB386B36A0585A8F94E8D90@HE1PR0401MB2235.eurprd04.prod.outlook.com>
References: <20181120092615.11680-1-Zhiqiang.Hou@nxp.com>
 <20181120092615.11680-10-Zhiqiang.Hou@nxp.com>
In-Reply-To: <20181120092615.11680-10-Zhiqiang.Hou@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=minghuan.lian@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HE1PR0401MB2202;6:NHXKygMctSdRKCYPmhD8lI/SN4pL/bUdagwPgI4XxEs2NGf4VhTD4MYKtk1s7HY49hpYViDraTy7gO5ZPCI4H0M9UF1XfU9xafLG6/lWeO0znJBmiFqlsbfSBK/9dAXqVluxI/wIxoHOPKlfTqAW6mkST4yeBnLDmm+Us+53x2tlNBrMvuK2sep0hlmUgNwCeGb4Wm43FJ/VxTjKL6taC7JVPzBMBOvNUWirkVvGM45V58Cwp1mrluvs9OC/ergoy/28Ug2fj4M20L6VAtzOPZXAxJmcBqHjaB2wSADIYJ0OSsHkjQCHIO1U/O9xhYzwWLLnRBUnrdVABU1a4lWu0/yv/R0P/SHSa145XjEDnQTPm9FyeoYWplr38Cpq2vX8jpN0gOIfDnAJkTkrpyPReyVzloVtjFcrAMZpEgEobAVXSF+4nM3VbqH5xmMiT33g579idcJqWNG6vKxK8OYlvtN83O6g/NvamGO7S9sH4wI=;5:Xox+HziV9i67oxIlpIoqgKo00zIxCv8W2BBkvpKpbFnxL9j2hOzMUki21q9yjlhbXqrBez0QLKin/LwKY133x5MStLzfTMu7qWgk/17lQrjzt7LVmOfIYdnDHuHbtV3TJu8c2K6VnZRaw0AeergGMm310czGr1J2EEpk+PL2mPM=;7:P1KNiVbvRr3bjB0I4ROwEmtmYX7jyrOH7Phmk6cZ5OhCfQ+QVsUHmk1LdRSBUwn/X9dxGzXM05SAXevWpeiY7DahmN/JkRy2PZtFlICsFQ0LiOpQmdwgITwj/XMWbUe5PSL2c1GfHOIXYPg2PCR7tw==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: c54ec627-04a1-4ad7-7170-08d64ed7623b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:HE1PR0401MB2202;
x-ms-traffictypediagnostic: HE1PR0401MB2202:
x-microsoft-antispam-prvs: <HE1PR0401MB2202C0FDBA6DA83ED10CDA00E8D90@HE1PR0401MB2202.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231442)(944501410)(52105112)(3002001)(10201501046)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:HE1PR0401MB2202;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0401MB2202;
x-forefront-prvs: 08626BE3A5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(376002)(39860400002)(346002)(136003)(366004)(189003)(199004)(13464003)(6506007)(53546011)(102836004)(99286004)(26005)(186003)(76176011)(7696005)(229853002)(106356001)(105586002)(54906003)(6436002)(14454004)(33656002)(25786009)(110136005)(486006)(3846002)(478600001)(68736007)(2900100001)(476003)(316002)(11346002)(446003)(53936002)(9686003)(55016002)(2201001)(81156014)(81166006)(74316002)(71200400001)(8936002)(71190400001)(7736002)(8676002)(66066001)(97736004)(305945005)(5660300001)(2501003)(6116002)(4326008)(2906002)(6246003)(7416002)(86362001)(575784001)(256004)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR0401MB2202;H:HE1PR0401MB2235.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:3;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: PU1t3g6xptNSZ+cyKkMIMRTRqvgJt5lySVWnbDHrQIK7R6QwWWuO16gJxIFGqit1/7jqVdwb8GN4hzUHX8lQd1/QlKqzGBVzbG0YlgkMLwQEGgVx/WB8eBZ381oHyjmEKQBzMBNKSFhKG85nmQOoFX9miaot99o1eEI0WKjmg9gPG220yCR6vr11fBPN2qUF0W5nI1DKEdTI5IP5xbZXhwXXDcZ1QQnI9ikGVFoYnTygQQdHCIEarki2nnj4w6YUe2up/DMNl38UVPbhJjd5pZdpOmqmMhk5dW0A8gVgiFwlCEKr+mcvgX7yHfVI2dRuTNFoEj4l51J9LAhWzIPQG5e6JYB40ZAXzzOO16pw4u8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c54ec627-04a1-4ad7-7170-08d64ed7623b
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2018 11:00:29.0939
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
> Subject: [PATCHv2 09/25] PCI: mobiveil: correct inbound/outbound window
> setup routines
>=20
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
>=20
> Outbound window routine:
>  - Removed unused var definition and register read operations.
>  - Added the upper 32-bit cpu address setup of the window.
>  - Instead of blindly write, only change the fields specified.
>  - Masked the lower bits of window size in case override the
>    control bits.
>  - Check if the passing window number is available, instead of
>    the total number of the initialized windows.
>=20
> Inbound window routine:
>  - Added parameter 'u64 cpu_addr' to specify the cpu address
>    of the window instead of using 'pci_addr'.
>  - Changed 'int pci_addr' to 'u64 pci_addr', and added setup
>    of the upper 32-bit pci address of the window.
>  - Moved the PCIe PIO master enablement to mobiveil_host_init().
>  - Instead of blindly write, only change the fields specified.
>  - Masked the lower bits of window size in case override the
>    control bits.
>  - Check if the passing window number is available, instead of
>    the total number of the initialized windows.
>  - And added the statistic of initialized inbound windows.
>=20
> Fixes: 9af6bcb11e12 ("PCI: mobiveil: Add Mobiveil PCIe Host Bridge IP dri=
ver")
> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> ---
> V2:
>  - Inbound window setup rountine: clear the size field before set it.
>=20
>  drivers/pci/controller/pcie-mobiveil.c | 70 +++++++++++++++-----------
>  1 file changed, 42 insertions(+), 28 deletions(-)
>=20
> diff --git a/drivers/pci/controller/pcie-mobiveil.c
> b/drivers/pci/controller/pcie-mobiveil.c
> index e88afc792a5c..4ba458474e42 100644
> --- a/drivers/pci/controller/pcie-mobiveil.c
> +++ b/drivers/pci/controller/pcie-mobiveil.c
> @@ -65,9 +65,13 @@
>  #define PAB_AXI_AMAP_CTRL(win)		PAB_REG_ADDR(0x0ba0, win)
>  #define  WIN_ENABLE_SHIFT		0
>  #define  WIN_TYPE_SHIFT			1
> +#define  WIN_TYPE_MASK			0x3
> +#define  WIN_SIZE_SHIFT			10
> +#define  WIN_SIZE_MASK			0x3fffff
>=20
>  #define PAB_EXT_AXI_AMAP_SIZE(win)	PAB_EXT_REG_ADDR(0xbaf0,
> win)
>=20
> +#define PAB_EXT_AXI_AMAP_AXI_WIN(win)	PAB_EXT_REG_ADDR(0x80a0,
> win)
>  #define PAB_AXI_AMAP_AXI_WIN(win)	PAB_REG_ADDR(0x0ba4, win)
>  #define  AXI_WINDOW_ALIGN_MASK		3
>=20
> @@ -82,8 +86,10 @@
>  #define PAB_PEX_AMAP_CTRL(win)		PAB_REG_ADDR(0x4ba0, win)
>  #define  AMAP_CTRL_EN_SHIFT		0
>  #define  AMAP_CTRL_TYPE_SHIFT		1
> +#define  AMAP_CTRL_TYPE_MASK		3
>=20
>  #define PAB_EXT_PEX_AMAP_SIZEN(win)	PAB_EXT_REG_ADDR(0xbef0,
> win)
> +#define PAB_EXT_PEX_AMAP_AXI_WIN(win)	PAB_EXT_REG_ADDR(0xb4a0,
> win)
>  #define PAB_PEX_AMAP_AXI_WIN(win)	PAB_REG_ADDR(0x4ba4, win)
>  #define PAB_PEX_AMAP_PEX_WIN_L(win)	PAB_REG_ADDR(0x4ba8, win)
>  #define PAB_PEX_AMAP_PEX_WIN_H(win)	PAB_REG_ADDR(0x4bac, win)
> @@ -455,49 +461,51 @@ static int mobiveil_pcie_parse_dt(struct
> mobiveil_pcie *pcie)  }
>=20
>  static void program_ib_windows(struct mobiveil_pcie *pcie, int win_num,
> -			       int pci_addr, u32 type, u64 size)
> +			       u64 cpu_addr, u64 pci_addr, u32 type, u64 size)
>  {
> -	int pio_ctrl_val;
> -	int amap_ctrl_dw;
> +	u32 value;
>  	u64 size64 =3D ~(size - 1);
>=20
> -	if ((pcie->ib_wins_configured + 1) > pcie->ppio_wins) {
> +	if (win_num >=3D pcie->ppio_wins) {
>  		dev_err(&pcie->pdev->dev,
>  			"ERROR: max inbound windows reached !\n");
>  		return;
>  	}
>=20
> -	pio_ctrl_val =3D csr_readl(pcie, PAB_PEX_PIO_CTRL);
> -	pio_ctrl_val |=3D 1 << PIO_ENABLE_SHIFT;
> -	csr_writel(pcie, pio_ctrl_val, PAB_PEX_PIO_CTRL);
> -
> -	amap_ctrl_dw =3D csr_readl(pcie, PAB_PEX_AMAP_CTRL(win_num));
> -	amap_ctrl_dw |=3D (type << AMAP_CTRL_TYPE_SHIFT) |
> -			(1 << AMAP_CTRL_EN_SHIFT) |
> -			lower_32_bits(size64);
> -	csr_writel(pcie, amap_ctrl_dw, PAB_PEX_AMAP_CTRL(win_num));
> +	value =3D csr_readl(pcie, PAB_PEX_AMAP_CTRL(win_num));
> +	value &=3D ~(AMAP_CTRL_TYPE_MASK << AMAP_CTRL_TYPE_SHIFT |
> +		 WIN_SIZE_MASK << WIN_SIZE_SHIFT);
> +	value |=3D (type << AMAP_CTRL_TYPE_SHIFT) | (1 <<
> AMAP_CTRL_EN_SHIFT) |
> +		 (lower_32_bits(size64) & WIN_SIZE_MASK <<
> WIN_SIZE_SHIFT);
> +	csr_writel(pcie, value, PAB_PEX_AMAP_CTRL(win_num));
>=20
>  	csr_writel(pcie, upper_32_bits(size64),
>  		   PAB_EXT_PEX_AMAP_SIZEN(win_num));
>=20
> -	csr_writel(pcie, pci_addr, PAB_PEX_AMAP_AXI_WIN(win_num));
> +	csr_writel(pcie, lower_32_bits(cpu_addr),
> +		   PAB_PEX_AMAP_AXI_WIN(win_num));
> +	csr_writel(pcie, upper_32_bits(cpu_addr),
> +		   PAB_EXT_PEX_AMAP_AXI_WIN(win_num));
> +
> +	csr_writel(pcie, lower_32_bits(pci_addr),
> +		   PAB_PEX_AMAP_PEX_WIN_L(win_num));
> +	csr_writel(pcie, upper_32_bits(pci_addr),
> +		   PAB_PEX_AMAP_PEX_WIN_H(win_num));
>=20
> -	csr_writel(pcie, pci_addr, PAB_PEX_AMAP_PEX_WIN_L(win_num));
> -	csr_writel(pcie, 0, PAB_PEX_AMAP_PEX_WIN_H(win_num));
> +	pcie->ib_wins_configured++;
>  }
>=20
>  /*
>   * routine to program the outbound windows
>   */
>  static void program_ob_windows(struct mobiveil_pcie *pcie, int win_num,
> -			       u64 cpu_addr, u64 pci_addr,
> -			       u32 config_io_bit, u64 size)
> +			       u64 cpu_addr, u64 pci_addr, u32 type, u64 size)
>  {
>=20
> -	u32 value, type;
> +	u32 value;
>  	u64 size64 =3D ~(size - 1);
>=20
> -	if ((pcie->ob_wins_configured + 1) > pcie->apio_wins) {
> +	if (win_num >=3D pcie->apio_wins) {
>  		dev_err(&pcie->pdev->dev,
>  			"ERROR: max outbound windows reached !\n");
>  		return;
> @@ -507,10 +515,12 @@ static void program_ob_windows(struct
> mobiveil_pcie *pcie, int win_num,
>  	 * program Enable Bit to 1, Type Bit to (00) base 2, AXI Window Size
> Bit
>  	 * to 4 KB in PAB_AXI_AMAP_CTRL register
>  	 */
> -	type =3D config_io_bit;
>  	value =3D csr_readl(pcie, PAB_AXI_AMAP_CTRL(win_num));
> -	csr_writel(pcie, 1 << WIN_ENABLE_SHIFT | type << WIN_TYPE_SHIFT
> |
> -		   lower_32_bits(size64), PAB_AXI_AMAP_CTRL(win_num));
> +	value &=3D ~(WIN_TYPE_MASK << WIN_TYPE_SHIFT |
> +		 WIN_SIZE_MASK << WIN_SIZE_SHIFT);
> +	value |=3D 1 << WIN_ENABLE_SHIFT | type << WIN_TYPE_SHIFT |
> +		 (lower_32_bits(size64) & WIN_SIZE_MASK <<
> WIN_SIZE_SHIFT);
> +	csr_writel(pcie, value, PAB_AXI_AMAP_CTRL(win_num));
>=20
>  	csr_writel(pcie, upper_32_bits(size64),
> PAB_EXT_AXI_AMAP_SIZE(win_num));
>=20
> @@ -518,11 +528,10 @@ static void program_ob_windows(struct
> mobiveil_pcie *pcie, int win_num,
>  	 * program AXI window base with appropriate value in
>  	 * PAB_AXI_AMAP_AXI_WIN0 register
>  	 */
> -	value =3D csr_readl(pcie, PAB_AXI_AMAP_AXI_WIN(win_num));
> -	csr_writel(pcie, cpu_addr & (~AXI_WINDOW_ALIGN_MASK),
> +	csr_writel(pcie, lower_32_bits(cpu_addr) &
> (~AXI_WINDOW_ALIGN_MASK),
>  		   PAB_AXI_AMAP_AXI_WIN(win_num));
> -
> -	value =3D csr_readl(pcie, PAB_AXI_AMAP_PEX_WIN_H(win_num));
> +	csr_writel(pcie, upper_32_bits(cpu_addr),
> +		   PAB_EXT_AXI_AMAP_AXI_WIN(win_num));
>=20
>  	csr_writel(pcie, lower_32_bits(pci_addr),
>  		   PAB_AXI_AMAP_PEX_WIN_L(win_num));
> @@ -604,6 +613,11 @@ static int mobiveil_host_init(struct mobiveil_pcie
> *pcie)
>  	value |=3D APIO_EN_MASK;
>  	csr_writel(pcie, value, PAB_AXI_PIO_CTRL);
>=20
> +	/* Enable PCIe PIO master */
> +	value =3D csr_readl(pcie, PAB_PEX_PIO_CTRL);
> +	value |=3D 1 << PIO_ENABLE_SHIFT;
> +	csr_writel(pcie, value, PAB_PEX_PIO_CTRL);
> +
>  	/*
>  	 * we'll program one outbound window for config reads and
>  	 * another default inbound window for all the upstream traffic @@ -
> 616,7 +630,7 @@ static int mobiveil_host_init(struct mobiveil_pcie *pcie)
>  			   CFG_WINDOW_TYPE, resource_size(pcie-
> >ob_io_res));
>=20
>  	/* memory inbound translation window */
> -	program_ib_windows(pcie, WIN_NUM_0, 0, MEM_WINDOW_TYPE,
> IB_WIN_SIZE);
> +	program_ib_windows(pcie, WIN_NUM_0, 0, 0,
> MEM_WINDOW_TYPE,
> +IB_WIN_SIZE);
>=20
>  	/* Get the I/O and memory ranges from DT */
>  	resource_list_for_each_entry(win, &pcie->resources) {
> --
> 2.17.1

