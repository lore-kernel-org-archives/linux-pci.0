Return-Path: <SRS0=4GJS=N7=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AEABC46463
	for <linux-pci@archiver.kernel.org>; Tue, 20 Nov 2018 11:27:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB52A2087E
	for <linux-pci@archiver.kernel.org>; Tue, 20 Nov 2018 11:27:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZOJC+ano"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB52A2087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729080AbeKTV41 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 20 Nov 2018 16:56:27 -0500
Received: from mail-eopbgr150071.outbound.protection.outlook.com ([40.107.15.71]:17728
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726792AbeKTV40 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 20 Nov 2018 16:56:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JkHDjY6kMm8FTf0hH+N43loeHQ7xT1Nz+Kjr4D2nI4c=;
 b=ZOJC+anogLZzHZNAo5aJGO4e/Jb24l33/+pD/i+cwmdtM/O/fpGaCdzOpW8GsPzzMITgB9zonvc5PaHLB2l21Xl2qcd24TpRJpuFks94PThabK+nn39b3xwRfvFtscb6rgBRDmF3vJHTxDYnScPhKdfYdAp3cmJv8XOJujQC9uc=
Received: from HE1PR0401MB2235.eurprd04.prod.outlook.com (10.168.32.20) by
 HE1PR0401MB1962.eurprd04.prod.outlook.com (10.166.122.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1339.20; Tue, 20 Nov 2018 11:27:25 +0000
Received: from HE1PR0401MB2235.eurprd04.prod.outlook.com
 ([fe80::60ff:1b2a:d0fd:5bd2]) by HE1PR0401MB2235.eurprd04.prod.outlook.com
 ([fe80::60ff:1b2a:d0fd:5bd2%8]) with mapi id 15.20.1339.027; Tue, 20 Nov 2018
 11:27:25 +0000
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
Subject: RE: [PATCHv2 20/25] PCI: mobiveil: add Byte and Half-Word width
 register accessors
Thread-Topic: [PATCHv2 20/25] PCI: mobiveil: add Byte and Half-Word width
 register accessors
Thread-Index: AQHUgLNIO6BqRSYoWkiS2hSi16NP+6VYhpWw
Date:   Tue, 20 Nov 2018 11:27:24 +0000
Message-ID: <HE1PR0401MB22354FEF2BDCCF9725FD81C5E8D90@HE1PR0401MB2235.eurprd04.prod.outlook.com>
References: <20181120092615.11680-1-Zhiqiang.Hou@nxp.com>
 <20181120092615.11680-21-Zhiqiang.Hou@nxp.com>
In-Reply-To: <20181120092615.11680-21-Zhiqiang.Hou@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=minghuan.lian@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HE1PR0401MB1962;6:eSO7pPt6VTpfM4pCHchYQoXCYsr7kyKrBb1fIpBJQ9kCe6Iv0oPuZFexjNfqpmQGHA8xCG61FdsZpsV3Cy3EJ6btBL1cQ3yDRjrUdpUUaIUfVHnbfH9m/6ClREC74EaKnG9fGPurDm5nC7D4v2wqAKOSyc0tbu/6B+TvgBaEDsSCdoE4u2FjNo3uFYO30Zs0Xbg40fdGRBVQcsXstu0+70xlzug6QlR6iWL6sV9mSeJyf+p6LanJL9r3TCTXrylER9BGRcshKNok8GcKM7IcORARFxuzkvx2bO0UtqJeWQoYvsPluzh4h4DN5ykeXuL2zChYly4kUqF/58yetkO2aItqReDbT3WJyn+a0WqwSm4gUdM2Ru0OMxIf50DpXA/vb+X/RI2kKJasAXWGtJBb2WWhnn3kzO7jXwrDT08iCqHizqiLcJ2oEuUJRjxD0REbckpmyNM6oR8gQZFf1Pmm9AZ4s+OXNXmYPey8PsmfNq0=;5:IOiiaHRtAgBFpToKNmSA67QhIMOz4TPOqEDUfh6g43aczNp5GPPAR8QfTte61zCCrXU2fT5w8NfhDo9KT76alODspwYgmEoWzAiQHa3k4sGeSA5bBq9RsnGbbaB9CnL74xpBr2eHsFr1F45FxO4YjElIdC4vC9w0LCMUprdWxfY=;7:Qpfw7GZV7eSVVGI3xofF0quq4KJ04c1OuawSEIDeUG2c0nyiUVrlaKHiDrp0kaF4/ZsGTE7G7GMY9kKIrAV6fQy8Sgr1YF1JLmVcAJoLHFQ/wc69I+jdGcmDbV8vQPX+x9EvbyhTYs2nQ9JhXDfWFA==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: c6ee9f15-45d3-4742-5aae-08d64edb255c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:HE1PR0401MB1962;
x-ms-traffictypediagnostic: HE1PR0401MB1962:
x-microsoft-antispam-prvs: <HE1PR0401MB1962A3DCE5F238297A4CF47FE8D90@HE1PR0401MB1962.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231442)(944501410)(52105112)(10201501046)(3002001)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:HE1PR0401MB1962;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0401MB1962;
x-forefront-prvs: 08626BE3A5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(376002)(366004)(346002)(136003)(189003)(199004)(13464003)(8936002)(316002)(54906003)(25786009)(110136005)(4326008)(81166006)(81156014)(8676002)(2501003)(2201001)(229853002)(86362001)(74316002)(486006)(97736004)(106356001)(478600001)(2906002)(105586002)(14454004)(7736002)(476003)(446003)(55016002)(305945005)(33656002)(11346002)(53936002)(68736007)(66066001)(71190400001)(71200400001)(7696005)(6436002)(6116002)(2900100001)(256004)(76176011)(3846002)(26005)(5660300001)(7416002)(99286004)(9686003)(6246003)(102836004)(6506007)(186003)(53546011)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR0401MB1962;H:HE1PR0401MB2235.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 6jGWQZ57ONO1iT6TGKtMFu+1nToznScxlZcwNTMpqnpujj7hjxDcTElBk0T+Nf7XhvMvtJgGjAvJgcjrCQRmZjOi+QoBiVlgguQR/gYyVTwm3441wD7ERD2ghEqbxp7XGjF+DFq5Sv0KNu8RtpKLDiOYik7OKhZdxBsb+tLMMDXTYe+nad/Ix4VzfgelHpi+xrzdiS39Jd9ZqeD/WOMGrEhTFddewS3d3f+SJlTODw+Q56Nu71kn4se1IX7ypUXM8ecAIbYctYbxC9S8jobXXygVuwHPX4mJrnHjLSkieqTPjv2Y6HD9tnzWJkxpHuNw/TjFpN79jAI7idzSvL4EFbRMuyI+wAM5qQ5DYRUOpqM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6ee9f15-45d3-4742-5aae-08d64edb255c
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2018 11:27:24.9711
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0401MB1962
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
> Subject: [PATCHv2 20/25] PCI: mobiveil: add Byte and Half-Word width
> register accessors
>=20
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
>=20
> As there are some Byte and Half-Work width registers in PCIe configuratio=
n
> space, add Byte and Half-Word width register accessors.
>=20
> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> ---
> V2:
>  - no change
>=20
>  .../pci/controller/mobiveil/pcie-mobiveil.h   | 20 +++++++++++++++++++
>  1 file changed, 20 insertions(+)
>=20
> diff --git a/drivers/pci/controller/mobiveil/pcie-mobiveil.h
> b/drivers/pci/controller/mobiveil/pcie-mobiveil.h
> index 81685840b378..933c2f34bc52 100644
> --- a/drivers/pci/controller/mobiveil/pcie-mobiveil.h
> +++ b/drivers/pci/controller/mobiveil/pcie-mobiveil.h
> @@ -181,9 +181,29 @@ static inline u32 csr_readl(struct mobiveil_pcie *pc=
ie,
> u32 off)
>  	return csr_read(pcie, off, 0x4);
>  }
>=20
> +static inline u32 csr_readw(struct mobiveil_pcie *pcie, u32 off) {
> +	return csr_read(pcie, off, 0x2);
> +}
> +
> +static inline u32 csr_readb(struct mobiveil_pcie *pcie, u32 off) {
> +	return csr_read(pcie, off, 0x1);
> +}
> +
>  static inline void csr_writel(struct mobiveil_pcie *pcie, u32 val, u32 o=
ff)  {
>  	csr_write(pcie, val, off, 0x4);
>  }
>=20
> +static inline void csr_writew(struct mobiveil_pcie *pcie, u32 val, u32
> +off) {
> +	csr_write(pcie, val, off, 0x2);
> +}
> +
> +static inline void csr_writeb(struct mobiveil_pcie *pcie, u32 val, u32
> +off) {
> +	csr_write(pcie, val, off, 0x1);
> +}
> +
>  #endif /* _PCIE_MOBIVEIL_H */
> --
> 2.17.1

