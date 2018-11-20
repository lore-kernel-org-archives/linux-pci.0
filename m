Return-Path: <SRS0=4GJS=N7=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16918C4161B
	for <linux-pci@archiver.kernel.org>; Tue, 20 Nov 2018 11:27:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3F5A2087E
	for <linux-pci@archiver.kernel.org>; Tue, 20 Nov 2018 11:27:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="tP/0h0pg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3F5A2087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729165AbeKTVzl (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 20 Nov 2018 16:55:41 -0500
Received: from mail-eopbgr30069.outbound.protection.outlook.com ([40.107.3.69]:29856
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729163AbeKTVzl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 20 Nov 2018 16:55:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uCwzwnHM9MN1ARJXLYDXSC8V1MKE6vzj5OAYLV+E0q8=;
 b=tP/0h0pgNOKSWAt2HF/dsPFJqi0IJRsRMMKwoluGSsOkxK8ulde9AEknIJ+hK8vgfMXmFqp5rd8XVWeFXCpx48NkZ/U2rGk7VPrmIN+Q6lLJ6HhnL7Sm+Twy0V3uyDRmWRjZrGU/v+hPbvcLwGKjVVLSg+Id4I283pWNjNGxhRs=
Received: from HE1PR0401MB2235.eurprd04.prod.outlook.com (10.168.32.20) by
 HE1PR0401MB1962.eurprd04.prod.outlook.com (10.166.122.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1339.20; Tue, 20 Nov 2018 11:26:56 +0000
Received: from HE1PR0401MB2235.eurprd04.prod.outlook.com
 ([fe80::60ff:1b2a:d0fd:5bd2]) by HE1PR0401MB2235.eurprd04.prod.outlook.com
 ([fe80::60ff:1b2a:d0fd:5bd2%8]) with mapi id 15.20.1339.027; Tue, 20 Nov 2018
 11:26:56 +0000
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
Subject: RE: [PATCHv2 19/25] PCI: mobiveil: disabled IB and OB windows set by
 bootloader
Thread-Topic: [PATCHv2 19/25] PCI: mobiveil: disabled IB and OB windows set by
 bootloader
Thread-Index: AQHUgLNECOMlXkvY1UGBUIR3F5Xcl6VYhnTg
Date:   Tue, 20 Nov 2018 11:26:55 +0000
Message-ID: <HE1PR0401MB223585063880133513F87A5BE8D90@HE1PR0401MB2235.eurprd04.prod.outlook.com>
References: <20181120092615.11680-1-Zhiqiang.Hou@nxp.com>
 <20181120092615.11680-20-Zhiqiang.Hou@nxp.com>
In-Reply-To: <20181120092615.11680-20-Zhiqiang.Hou@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=minghuan.lian@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HE1PR0401MB1962;6:JtylYYWOJLzF+YuhbiJvea0S0frJx9tEBLqOmXfnBj/w2VuItGMIL4f9L6HE3vdqlmhmgF6C3v29yu26JdvxuqEKDfCD/kpEhIpAuxhT4Pk02TeN9phfVE6AuRBkjItO9zBo23kB5jelhqZ3Ld2Aw+0Vdnm0/oJeEb/rptNVrL/J9sO6RnYRQjWIpK00VOcUbyt8hUSWnnTeg2sSj9169NRmpvZntLUU5/3xZTAG+4OeTswEJ2E9or4wItMYWP6rUpVKq7N3sJCPyBMvA4g/NSa2M9E+B3InXQlY7weY5V+m0ct4zGWm1HbEwouir1fKx+S4A85KSMcHDfLrEaHrrXvLALHKwrY3AbyLkpEYjnNSSjHwP/pnrBTQdVysu3VXfWkzGmVUmQNZkulSPI9ow0alkFoahZDcMRWeiQZN0SPvgwghUmxmUAd5YqsTlZIkiIaz/tXyz/rT73edZWs8MO0MzBfSjoKHy96p33CAN2I=;5:QPeMAeNs7G5jCwJO0nl1bmZb1YlkMvpKNBBtOgmy2Yt9q8gzgzc+/pmCNXG+bF8cQb3lEAZ3KRss0kiByNaYTnZaOUmudOJRFS2vD/Dv5fiJJsFbx5NbitXovR7l0GZuJsiwzHgVQBguDfgp9mq8HsOKrGL5U84Z6nnB0HbwlsU=;7:ts2PdRFj7zUAmFbdN8NJZl7gKMvJ2gFVGuacxf1bWmV6HZdCcurnj8gRm13NBf6TJECDqdVLvgJG5+FMbK1gxYPpNe0UjQjB+ZToVBEr+LkSmckc07ch6qB9HAvRg0V3aCviFkKfHpttLM8DBozCRg==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 9334ab26-6bec-4717-ff19-08d64edb1404
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:HE1PR0401MB1962;
x-ms-traffictypediagnostic: HE1PR0401MB1962:
x-microsoft-antispam-prvs: <HE1PR0401MB1962C4B6703A935C67AA9C48E8D90@HE1PR0401MB1962.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231442)(944501410)(52105112)(10201501046)(3002001)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:HE1PR0401MB1962;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0401MB1962;
x-forefront-prvs: 08626BE3A5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(376002)(366004)(346002)(136003)(189003)(199004)(13464003)(8936002)(316002)(54906003)(25786009)(110136005)(4326008)(81166006)(81156014)(8676002)(2501003)(2201001)(229853002)(575784001)(86362001)(74316002)(486006)(97736004)(106356001)(478600001)(2906002)(105586002)(14454004)(7736002)(476003)(446003)(14444005)(55016002)(305945005)(33656002)(11346002)(53936002)(68736007)(66066001)(71190400001)(71200400001)(7696005)(6436002)(6116002)(2900100001)(256004)(76176011)(3846002)(26005)(5660300001)(7416002)(99286004)(9686003)(6246003)(102836004)(6506007)(186003)(53546011)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR0401MB1962;H:HE1PR0401MB2235.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: fWJ6USP7dymnz2R8fbtYZpHTQl37NeVQdIKJFPqpLMVjrAk5uJBGbpYw4uhYnllmTi2Vfc6yvrJ1KHcxfm2PeuxlGs+AYs15elKm6wCRo9HNfjorr9z9Y3k6XK0cep+nz0rtQQYjLKJYIXf2Nm1i8o6qJ/L8ektjWFRKitxXpEZAgE9WisQNcbdc2KQOciTUZGVcnWJZ+MEuJ81UkCZKTokJZ1BuOlbUy1cKUF24O7N5S6/IFnHWQBULCNDX4GmOVzHQXWb/MM8fzAxQub8U7lSYB1XfIAz7+Mp+l5jSfT5f5yGf8AwLwbHsB5yV45HAcyaHEo/4+7xRJq4yMKStbkvNwNuFRMAbi6BBKcqQUY4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9334ab26-6bec-4717-ff19-08d64edb1404
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2018 11:26:55.8617
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
> Subject: [PATCHv2 19/25] PCI: mobiveil: disabled IB and OB windows set by
> bootloader
>=20
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
>=20
> Disabled all inbound and outbound windows before set up the windows in
> kernel, in case transactions match the window set by bootloader.
>=20
> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> ---
> V2:
>  - no change
>=20
>  .../controller/mobiveil/pcie-mobiveil-host.c   |  7 +++++++
>  .../pci/controller/mobiveil/pcie-mobiveil.c    | 18 ++++++++++++++++++
>  .../pci/controller/mobiveil/pcie-mobiveil.h    |  2 ++
>  3 files changed, 27 insertions(+)
>=20
> diff --git a/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
> b/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
> index d1765d572f44..d028cdf31d0e 100644
> --- a/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
> +++ b/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
> @@ -221,6 +221,13 @@ static int mobiveil_host_init(struct mobiveil_pcie
> *pcie)  {
>  	u32 value, pab_ctrl, type;
>  	struct resource_entry *win;
> +	int i;
> +
> +	/* Disable all inbound/outbound windows */
> +	for (i =3D 0; i < pcie->apio_wins; i++)
> +		mobiveil_pcie_disable_ob_win(pcie, i);
> +	for (i =3D 0; i < pcie->ppio_wins; i++)
> +		mobiveil_pcie_disable_ib_win(pcie, i);
>=20
>  	/* setup bus numbers */
>  	value =3D csr_readl(pcie, PCI_PRIMARY_BUS); diff --git
> a/drivers/pci/controller/mobiveil/pcie-mobiveil.c
> b/drivers/pci/controller/mobiveil/pcie-mobiveil.c
> index 370658d6546d..49d471b75925 100644
> --- a/drivers/pci/controller/mobiveil/pcie-mobiveil.c
> +++ b/drivers/pci/controller/mobiveil/pcie-mobiveil.c
> @@ -226,3 +226,21 @@ int mobiveil_bringup_link(struct mobiveil_pcie *pcie=
)
>=20
>  	return -ETIMEDOUT;
>  }
> +
> +void mobiveil_pcie_disable_ib_win(struct mobiveil_pcie *pci, int
> +win_num) {
> +	u32 val;
> +
> +	val =3D csr_readl(pci, PAB_PEX_AMAP_CTRL(win_num));
> +	val &=3D ~(1 << AMAP_CTRL_EN_SHIFT);
> +	csr_writel(pci, val, PAB_PEX_AMAP_CTRL(win_num)); }
> +
> +void mobiveil_pcie_disable_ob_win(struct mobiveil_pcie *pci, int
> +win_num) {
> +	u32 val;
> +
> +	val =3D csr_readl(pci, PAB_AXI_AMAP_CTRL(win_num));
> +	val &=3D ~(1 << WIN_ENABLE_SHIFT);
> +	csr_writel(pci, val, PAB_AXI_AMAP_CTRL(win_num)); }
> diff --git a/drivers/pci/controller/mobiveil/pcie-mobiveil.h
> b/drivers/pci/controller/mobiveil/pcie-mobiveil.h
> index eb4cb61291a8..81685840b378 100644
> --- a/drivers/pci/controller/mobiveil/pcie-mobiveil.h
> +++ b/drivers/pci/controller/mobiveil/pcie-mobiveil.h
> @@ -171,6 +171,8 @@ void program_ob_windows(struct mobiveil_pcie
> *pcie, int win_num, u64 cpu_addr,
>  			u64 pci_addr, u32 type, u64 size);
>  void program_ib_windows(struct mobiveil_pcie *pcie, int win_num, u64
> cpu_addr,
>  			u64 pci_addr, u32 type, u64 size);
> +void mobiveil_pcie_disable_ob_win(struct mobiveil_pcie *pci, int
> +win_num); void mobiveil_pcie_disable_ib_win(struct mobiveil_pcie *pci,
> +int win_num);
>  u32 csr_read(struct mobiveil_pcie *pcie, u32 off, size_t size);  void
> csr_write(struct mobiveil_pcie *pcie, u32 val, u32 off, size_t size);
>=20
> --
> 2.17.1

