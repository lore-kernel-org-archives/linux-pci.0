Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013022.outbound.protection.outlook.com [40.107.159.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 930A43D410A
	for <linux-pci@vger.kernel.org>; Mon, 20 Jul 2026 09:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784538995; cv=fail; b=mmc86wpUVslHma3VzfDCB6LYyRDyuWcaWMCKI/NxClKaj857xVvuBdGshiZ1TCOltTdC1sargFG2yy04IwqgkTC5pVJqy5ilToZUxhj1OZ33XVoCxSQj7AmLbBHWDGPHpmC2KuAmfY6OJ+nej+P2FD4x/UMZ1WawWaqNOxseDsA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784538995; c=relaxed/simple;
	bh=bUg6XO6Md58jUaZ/EkAr6a+0mtGV67AnKoEwpVGDFvU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=E5xnPiXybBjs1FSBrmuEDJUbiraqt41nAa9663IU5kFsz4VrgatYKn4DRSccBxgGHHdY4iGTJ9EkA61Ka1RCz8NeqDj6OrAVHTA4USjdE1uPuoW1QyghtZnbUu+xHQ1/bzPS2nfzkFvk0f+BGIgfY7H5U5crq/SJn7oLo637Aks=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=PVv+rnQh; arc=fail smtp.client-ip=40.107.159.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="PVv+rnQh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aGOyVeQyoAsbG5DG99a0GHUeZ1eUpbN6MSSzVMLTSPVcHKQJwFbQwFstGE9rNxX6UPjzt62k++cZqBE8QfyMSnbyekxG+zmBPJvlwrqLCPQBaxmLrl/EVAKepmeXOjJwCrZu/5Oe2NVGxxlQunTDMEJA4e2pgbKuZfNuyEqCDOvROlZ4pF5l/eqDseGOQJh2cc9RMMh+xKbZgYeCbcRPm/+wF+zCx/07M3fZQiHZYqIpsQTA9N70M0L2AFwQS8rKFJECVZyfv0D9uCeF/nQD/o4ySyKnr7ZxuR6QBCUxDLFh/ELGsIq/7Xgu3s/CwxKay9aGT06RKmHixnBzNT18vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9D7essDmVOLghMxbdf91/2gBUgg7c2AE0uY6AD4SfPU=;
 b=jdENEhnQrYJi9Xx47tYyjGls65etH9PSk+KmEyF9rQty/US+pmPIjrxQBHG8AG/IeBuZpoXKgVHGKfgkY27MmIxtaMMcWUFT62hhP+dYSmXbtwhv7a0FJ0a6Qr6DW85Tuhm7aQ916zP3IWzknoRSvZr4G2pBE8youkmcWChFqXK6GUiZhDKnlKz+8copsxO1sJdBcsHtbu0msUZDk3m59pIbrgvnZ5eEhBl2yjWECXU0ESP/7FtTygwEIDqg1vw4OTsy86TMtUseC+EnwclnUKr+5zhBjMgMFCVO+WrpU9pZExuqfgNvOie7JEguOGMG7FWXSZZbOSfZuIBjQ8I5Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9D7essDmVOLghMxbdf91/2gBUgg7c2AE0uY6AD4SfPU=;
 b=PVv+rnQhJ6YYr3/bRW+t3iI8LyjMq+m9m0wDeyOykAf5bSNV8q/O4pM3YvLH/OXusxHMaCc/WaOkczDhB1+ewDlPLvoi7gauUhv+KBK//XgHw1b+PnQR2J9nAuh1FzdMualLdRdy5yPzGCGZ+gbERaXB4kaMyFJATtAARHP3hVoNyjumKcImSpER52gQ13VZyRmK5qlo1IBlUonpBY0Yc0G8qkSWdfdEsVOnSkNDm3sHPNNv5xiR+EE3kKy+HDfgXM0YoCr63kXeruE/YdJ+OiJjYBORVZaaC8SSlHKKxi4/h8GTjVhP+IkabRC56syyW1yB0FWQPs3pDSnQN0lU4g==
Received: from GV2PR04MB12019.eurprd04.prod.outlook.com
 (2603:10a6:150:30c::14) by VI0PR04MB10687.eurprd04.prod.outlook.com
 (2603:10a6:800:25e::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Mon, 20 Jul
 2026 09:16:28 +0000
Received: from GV2PR04MB12019.eurprd04.prod.outlook.com
 ([fe80::ed75:bac1:2554:5cbe]) by GV2PR04MB12019.eurprd04.prod.outlook.com
 ([fe80::ed75:bac1:2554:5cbe%4]) with mapi id 15.21.0223.013; Mon, 20 Jul 2026
 09:16:27 +0000
From: Hongxing Zhu <hongxing.zhu@nxp.com>
To: Francesco Dolcini <francesco@dolcini.it>, Frank Li <frank.li@nxp.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>
CC: "l.stach@pengutronix.de" <l.stach@pengutronix.de>, "lpieralisi@kernel.org"
	<lpieralisi@kernel.org>, "kwilczynski@kernel.org" <kwilczynski@kernel.org>,
	"mani@kernel.org" <mani@kernel.org>, "robh@kernel.org" <robh@kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>, "s.hauer@pengutronix.de"
	<s.hauer@pengutronix.de>, "kernel@pengutronix.de" <kernel@pengutronix.de>,
	"festevam@gmail.com" <festevam@gmail.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>
Subject: RE: Non systematic PCIe error on resume on i.MX8QP on Linux 7.2
Thread-Topic: Non systematic PCIe error on resume on i.MX8QP on Linux 7.2
Thread-Index: AQHdGAiCOS1Dv99svEq6/bYedmdjW7Z2GFCg
Date: Mon, 20 Jul 2026 09:16:27 +0000
Message-ID:
 <GV2PR04MB1201926DADEFA97128E7C8CA68CC32@GV2PR04MB12019.eurprd04.prod.outlook.com>
References: <20260720052742.GA6753@francesco-nb>
In-Reply-To: <20260720052742.GA6753@francesco-nb>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR04MB12019:EE_|VI0PR04MB10687:EE_
x-ms-office365-filtering-correlation-id: fcf7f121-7962-43af-24ad-08dee63f941a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|1800799024|23010399003|376014|7416014|366016|38070700021|22082099003|18002099003|56012099006|11063799006|10067099003|6133799003;
x-microsoft-antispam-message-info:
 tIznoWSBBbMxSdl6rQtGS3t18piL+au+1m3uMLLYsijO1nv3rK1ddLd7r3lyLEv7KNV//75CP5upGU/Dn+48sI7p/EePpi26+ypiHH5jv/CHtlYFk5iqS8tTEAkO6ZRhgknXgkaxVHmlEdfxaw6w9AdvXyb/a6lb+mP1xNPB4epS2IS1f3gfw/Pxs4f+lOHsVTGjpKKOZdRA/85jeAVk9mEzm5fO61AlCCJW8M6PIh2GgHppThbdV5iBNX1cI8O46CykUmVCKr8h1Z6QBjBwWPNxpoJWfrFRgf17F40Y6iBMPfIpWTwGUTksRSA2nM/R+dUjVOgE9Yt326bEIIOQVQ0/kojq1PNoV+mz3WZ2Vl6pEpW1CoNj5zTO9RKcTLUmlOPm2R/0TgR9emX+raHlGN8lxspgJJ2kUMyR61MUjxr6a1RsnfrGUF+wRow0onO78PvgoxDvxA+k15rZvkChz+JeBZY+NEBwG5qbJaFKy9vEFxP6Q+5nr5MltmxUURGBfQz+yXDmdKRnla+V1LRG2gpBkWerMpXePqlXniB0EbsNp85If0tQPZOtOQib9wPkRCxBLUC8SAuoNCYe5BK1+VXc4DYo/bFrNMJgD1D8Qiw3oy4uzwOxuambT864dV3KLLS55Bb1PiqzHvIzb3gK4KOhWHv5FkkVdRfP911nWwXS0MAmyG+86bGUOKnB90AsCRHUQYEN8hDqLCvCwiqc8iW30aUwUCNVgc9KQiC2l/I=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB12019.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(23010399003)(376014)(7416014)(366016)(38070700021)(22082099003)(18002099003)(56012099006)(11063799006)(10067099003)(6133799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ypMhXg6sWMtSlTXceL5qpiZlCC5mB7LOW2FMBGaGqEK644y2wDG/dRWPK24k?=
 =?us-ascii?Q?NUN5EUbcCfyLwcKEa123YnpK3Jj3c7VqYWWl6CYo/QeWNGXLHQQokhken2qm?=
 =?us-ascii?Q?SL1SU8LQ+3vbWHFxqzUjcYdGm+oUxxGJrvIZexLCs5KHyVksPSwKfG5xvf5V?=
 =?us-ascii?Q?RxXA42hfhZkQpYaJyJKJvIgvA5Udl/zQThzGI5lZB/6EwWIYpK7eWcVGop9/?=
 =?us-ascii?Q?B0xlb9tAFsqQMqK4SgXI8nkgbaeuXRt7RDi6HLWdW2g5QHlsFzQDpi2eFvl+?=
 =?us-ascii?Q?e3Eky28cb5qtp7lnt0+mzYXOSoVzc5weXJWmL5Cs4UAIxTzD6aYMbTrkIWBv?=
 =?us-ascii?Q?hom/tM2uAW7HpvxRJRWrF9QLS45etvwyxTtOXlKArHnEuRo97iAXPtAYZc10?=
 =?us-ascii?Q?K+EC19BoxDXJMF3wxu9zlLjuSPshUG4kyTbG8mitdGTSTpdk3SkEEUZ/wbmJ?=
 =?us-ascii?Q?DE5/CciJhv/HNZ5y4M5y92j6390vgHjd88RtIEIH6EQDQmmNDpx1YTgoeQ4x?=
 =?us-ascii?Q?vdSblr/TlZ5H1DQ+RA9F+mgSv4pZQaGyP7mdnX0QaauxoPFj1S3+mS6B3HYC?=
 =?us-ascii?Q?TvMkbW8LiodGPQT8rgrNqs/51g7yqiXLsqlDfPkZ0F4Icw10SRFOczAcScI2?=
 =?us-ascii?Q?kDaBNu0mWLbjda6Z+MdsSVnaC1N2hyZZgx9x+B6fecF9c6NOvC5GTLOAI2mf?=
 =?us-ascii?Q?ba0Brjw0xjfLuOiO87jccCiZYR7jb5O6lHQIRnZwzBDNLWy09z91Wx9+k2Ms?=
 =?us-ascii?Q?W/R1yJwF59Suv89d4v3mzzrt/o0MWxriJX5RsyZ2kaAUVVKgzpKKrJ63p94v?=
 =?us-ascii?Q?ni61/HB8ig+SaxI6C4yWAfkiR7xF0yAn55kIr8ylY/mMBxUTy7ncZ28yAX3o?=
 =?us-ascii?Q?rxk5gZQit9/CvRF0MPDTID1e0afBjme3cLITk1dxjCJVmCicEbqWrbwfXpib?=
 =?us-ascii?Q?o0N+rOhRtia5gheJcuw41uN4n9sqM97Rc8zQwpsd6C/itAZCXm4yWNWiXqsS?=
 =?us-ascii?Q?9OgwO6rqhD/DS2k+8XpK4ogvA8drSPISHseBQzcxZKKRRCMhgAMVUwEs1cKv?=
 =?us-ascii?Q?dmkLjII2r7eEl/vN6mnTJMUEKEh5Wd8fm/4ZB8/PEMPW8B5CNvRuuEJpg3P2?=
 =?us-ascii?Q?nG3fxi/sIVPSzfPrhKjiKez3R6+Pk9L65KQ4T20OolrXnh6pbhI20EHavpeQ?=
 =?us-ascii?Q?Z/BJiaOtHuw2aOznAzLZ2XVNgjJQ9Goo53t5mfQxVZjIDiLBZP/+iqSqI+MY?=
 =?us-ascii?Q?/1nzNEo6VST8/6HNbdpoTKnDyIYZflcJjofuKcFOY1XqAFoiKK2io7TALpil?=
 =?us-ascii?Q?uJC9fSsWDLyJLZ/C8ad+pjgyfXykFOjW/r7JlrqwEfSFLN/ROMJXxAMxGDBB?=
 =?us-ascii?Q?5zT1I334iAUN65SjwTrDcLJ8iEoB6GOEujSH5sljK/0rH+jv5eIpDjo//5QB?=
 =?us-ascii?Q?1+W+/kKacbdnIDFjNPKeXjV0PtyMP+OE0DFky5d5U2RAPQDr9l4nt6NovN5e?=
 =?us-ascii?Q?OLlPNDJdmvZhRHAjzFtB9XUJppgpvCrg9kq8WhWd9tx+/W1DHAmzHfwyI5AJ?=
 =?us-ascii?Q?kNpJEzebKPWlWyfA1MtS+bbPfVHng6XKMNjowbzrKu13wOnUJSHGia5LfTK9?=
 =?us-ascii?Q?QwV11dm8b3eyXBUWNPgIx00k7MRPEo0gLqp0peeu1bof9pwLt8tnUq+Z/w7e?=
 =?us-ascii?Q?NNmlPh1jsM5T0X1HHi6j9M5ThggWYP59PTuybwLGtrBPbvkY?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB12019.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcf7f121-7962-43af-24ad-08dee63f941a
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2026 09:16:27.5145
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rq35BkGilUcwUeaiz6uZw67RNm6D8AGETm9u6Y8OXFs/3VNGXefkEBxc4BdIJNeqGG7doQH/5dwhxZr0l6GgCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10687

> -----Original Message-----
> From: Francesco Dolcini <francesco@dolcini.it>
> Sent: Monday, July 20, 2026 1:28 PM
> To: Hongxing Zhu <hongxing.zhu@nxp.com>; Frank Li <frank.li@nxp.com>; lin=
ux-
> pci@vger.kernel.org; imx@lists.linux.dev
> Cc: l.stach@pengutronix.de; lpieralisi@kernel.org; kwilczynski@kernel.org=
;
> mani@kernel.org; robh@kernel.org; bhelgaas@google.com;
> s.hauer@pengutronix.de; kernel@pengutronix.de; festevam@gmail.com; linux-
> pci@vger.kernel.org
> Subject: Non systematic PCIe error on resume on i.MX8QP on Linux 7.2
>=20
> Hello,
> our CI spotted this error on resume. It is not systematic, and it is poss=
ible that this
> is not a new issue from 7.2.
>=20
> Does it rings any bell?
>=20
> [  745.849237] imx8qm-hsio-phy 5f180000.phy: HSIO_PM_REQ_CORE_RST is set
> [  745.855800] phy phy-5f180000.phy.1: phy poweron failed --> -110
Based on the log, the PHY initialization is failing during resume.  I'll se=
t
up a platform on my end to see if I can reproduce this issue consistently.

BTW, is this occurring on the i.MX8QM MEK board? What's the frequency of
occurrence in CI (failure rate)?

Best Regards
Richard Zhu
> [  745.861824] imx6q-pcie 5f000000.pcie: waiting for PHY ready timeout!
> [  745.868378] imx6q-pcie 5f000000.pcie: Host init failed: -110 [  745.87=
4144]
> imx6q-pcie 5f000000.pcie: PM: dpm_run_callback(): genpd_resume_noirq
> returns -110 [  745.882791] imx6q-pcie 5f000000.pcie: PM: failed to resum=
e
> noirq: error -110 [  745.889979] Internal error: synchronous external abo=
rt:
> 0000000096000210 [#1]  SMP [  745.897647] Modules linked in: can_raw can
> 8021q garp stp mrp llc bluetooth ecdh_generic ecc uas nls_iso8859_1 nls_c=
p437
> mwifiex_pcie mwifiex cfg80211 ahci rfkill sd_mod cdns caam_jr caamhash_de=
sc
> spidev caamalg_desc rng crypto_engine kpp rng_core libdes
> snd_soc_fsl_asoc_card aes_ce_blk ghash_ce snd_soc_simple_card
> snd_soc_imx_audmux leds_gpio gf128mul imx_sc_thermal rtc_imx_sc
> nvmem_imx_ocotp_scu snd_soc_simple_card_utils led_class gpio_fan ahci_imx
> libahci_platform libahci phy_fsl_imx8qm_hsio libata fsl_imx8_ddr_perf
> ci_hdrc_imx ci_hdrc ulpi phy_cadence_salvo ehci_hcd roles usbmisc_imx
> phy_mxs_usb cdns3_imx usb3503 snd_soc_sgtl5000 flexcan can_dev
> imx8qxp_adc snd_soc_fsl_spdif snd_soc_fsl_sai imx_pcm_dma snd_soc_fsl_uti=
ls
> snd_soc_fsl_asrc pwm_imx27 spi_fsl_lpspi caam etnaviv error gpu_sched
> amphion_vpu fuse autofs4
> [  745.970466] CPU: 2 UID: 0 PID: 53 Comm: kworker/u21:2 Tainted: G   M
> 7.2.0-rc4-0.0.0-devel #1 PREEMPT
> [  745.981181] Tainted: [M]=3DMACHINE_CHECK [  745.985018] Hardware name:
> Toradex Apalis iMX8QP V1.1 on Apalis Ixora V1.2 Carrier Board (DT)
> [  745.993643] Workqueue: async async_run_entry_fn [  745.998279] pstate:
> 600000c5 (nZCv daIF -PAN -UAO -TCO -DIT -SSBS BTYPE=3D--) [  746.005337] =
pc :
> pci_generic_config_read+0x64/0xc0 [  746.010231] lr :
> pci_generic_config_read+0x24/0xc0 [  746.015118] sp : ffff800080513ba0
> [  746.018520] x29: ffff800080513ba0 x28: 0000000000000000 x27:
> 0000000000000000 [  746.025761] x26: ffff00000043d400 x25:
> 0000000000000000 x24: ffff0000004d1e05 [  746.033000] x23:
> 0000000000000003 x22: ffffa79a09fe3118 x21: ffff000003a000d0 [  746.04024=
2]
> x20: 0000000000000002 x19: ffff800080513be4 x18: 0000000000000001
> [  746.047482] x17: 0000000000000000 x16: 0000000000000000 x15:
> 0000000000000002 [  746.054720] x14: ffff000000718f90 x13: ffffa79a09f6f0=
68
> x12: 0000000000000003 [  746.061959] x11: 0000000000000028 x10:
> 000000016a2a9b62 x9 : 000000000000003c [  746.069197] x8 :
> ffffa79a09861b20 x7 : ffff0000067fe800 x6 : ffffa79a0a6bf000 [  746.07643=
8] x5 :
> 0000000000000000 x4 : ffff800080513be4 x3 : ffffa79a0989d904 [  746.08367=
6]
> x2 : 0000000000000044 x1 : 0000000000000000 x0 : ffff8000827c0044
> [  746.090917] Call trace:
> [  746.093455]  pci_generic_config_read+0x64/0xc0 (P) [  746.098345]
> pci_bus_read_config_word+0x74/0xe0
> [  746.102971]  pci_read_config_word+0x2c/0x48 [  746.107252]
> pci_power_up+0x50/0x1e4 [  746.110927]
> pci_pm_power_up_and_verify_state+0x2c/0xa0
> [  746.116249]  pci_pm_resume_noirq+0xe8/0x1ac [  746.120528]
> dpm_run_callback+0x4c/0x108 [  746.124550]
> device_resume_noirq+0x110/0x3c4 [  746.128917]
> async_resume_noirq+0x20/0x40 [  746.133024]
> async_run_entry_fn+0x34/0x164 [  746.137215]
> process_one_work+0x15c/0x2a0 [  746.141317]  worker_thread+0x18c/0x2e0
> [  746.145159]  kthread+0x11c/0x13c [  746.148486]  ret_from_fork+0x10/0x=
20
> [  746.152167] Code: 52800000 a8c27bfd d50323bf d65f03c0 (79400000)
> [  746.158371] ------------[ cut here ]------------ [  746.163077] WARNIN=
G:
> /usr/src/kernel/kernel/printk/printk.c:4627 at __wake_up_klogd+0xf4/0x100=
,
> CPU#2: kworker/u21:2/53 [  746.173972] Modules linked in: can_raw can 802=
1q
> garp stp mrp llc bluetooth ecdh_generic ecc uas nls_iso8859_1 nls_cp437
> mwifiex_pcie mwifiex cfg80211 ahci rfkill sd_mod cdns caam_jr caamhash_de=
sc
> spidev caamalg_desc rng crypto_engine kpp rng_core libdes
> snd_soc_fsl_asoc_card aes_ce_blk ghash_ce snd_soc_simple_card
> snd_soc_imx_audmux leds_gpio gf128mul imx_sc_thermal rtc_imx_sc
> nvmem_imx_ocotp_scu snd_soc_simple_card_utils led_class gpio_fan ahci_imx
> libahci_platform libahci phy_fsl_imx8qm_hsio libata fsl_imx8_ddr_perf
> ci_hdrc_imx ci_hdrc ulpi phy_cadence_salvo ehci_hcd roles usbmisc_imx
> phy_mxs_usb cdns3_imx usb3503 snd_soc_sgtl5000 flexcan can_dev
> imx8qxp_adc snd_soc_fsl_spdif snd_soc_fsl_sai imx_pcm_dma snd_soc_fsl_uti=
ls
> snd_soc_fsl_asrc pwm_imx27 spi_fsl_lpspi caam etnaviv error gpu_sched
> amphion_vpu fuse autofs4
> [  746.246751] CPU: 2 UID: 0 PID: 53 Comm: kworker/u21:2 Tainted: G   M
> 7.2.0-rc4-0.0.0-devel #1 PREEMPT
> [  746.257464] Tainted: [M]=3DMACHINE_CHECK [  746.261300] Hardware name:
> Toradex Apalis iMX8QP V1.1 on Apalis Ixora V1.2 Carrier Board (DT)
> [  746.269921] Workqueue: async async_run_entry_fn [  746.274548] pstate:
> 600000c5 (nZCv daIF -PAN -UAO -TCO -DIT -SSBS BTYPE=3D--) [  746.281605] =
pc :
> __wake_up_klogd+0xf4/0x100 [  746.285881] lr : wake_up_klogd+0x14/0x20
> [  746.289899] sp : ffff800080513920 [  746.293304] x29: ffff800080513920=
 x28:
> ffff000000718f00 x27: 0000000000000000 [  746.300545] x26: ffff00000043d4=
00
> x25: 0000000000000000 x24: 00000000000000c0 [  746.307786] x23:
> ffffa79a09861b84 x22: 0000000000000000 x21: ffff800080513a60
> [  746.315026] x20: ffffa79a0a202cc0 x19: ffffa79a0a678370 x18:
> 000000000000000a [  746.322266] x17: 3430306337323830 x16:
> 3030386666666620 x15: 0730076307330730 [  746.329506] x14:
> 0766073507360764 x13: 0730076307330730 x12: 0766073507360764
> [  746.336746] x11: ffffa79a0a55c7c0 x10: 00000000000002af x9 :
> ffffa79a0a55c7c0 [  746.343986] x8 : 3fffffffffffefff x7 : ffffa79a0a5b47=
c0 x6 :
> 0000000000000000 [  746.351226] x5 : 00000000000002b0 x4 :
> 0000000000000000 x3 : 0000000000000000 [  746.358467] x2 :
> 0000000000000000 x1 : 0000000000000001 x0 : 0000000000000001
> [  746.365708] Call trace:
> [  746.368241]  __wake_up_klogd+0xf4/0x100 (P) [  746.372520]
> bust_spinlocks+0x4c/0x60 [  746.376279]  die+0xc0/0x144 [  746.379166]
> arm64_notify_die+0xa0/0xa4 [  746.383099]  do_sea+0x68/0x80 [  746.386163=
]
> do_mem_abort+0x40/0x9c [  746.389745]  el1_abort+0x44/0x64 [  746.393068]
> el1h_64_sync_handler+0x50/0xac [  746.397348]  el1h_64_sync+0x6c/0x70
> [  746.400934]  pci_generic_config_read+0x64/0xc0 (P) [  746.405821]
> pci_bus_read_config_word+0x74/0xe0
> [  746.410448]  pci_read_config_word+0x2c/0x48 [  746.414727]
> pci_power_up+0x50/0x1e4 [  746.418398]
> pci_pm_power_up_and_verify_state+0x2c/0xa0
> [  746.423721]  pci_pm_resume_noirq+0xe8/0x1ac [  746.427998]
> dpm_run_callback+0x4c/0x108 [  746.432013]
> device_resume_noirq+0x110/0x3c4 [  746.436380]
> async_resume_noirq+0x20/0x40 [  746.440482]
> async_run_entry_fn+0x34/0x164 [  746.444674]
> process_one_work+0x15c/0x2a0 [  746.448778]  worker_thread+0x18c/0x2e0
> [  746.452620]  kthread+0x11c/0x13c [  746.455943]  ret_from_fork+0x10/0x=
20
> [  746.459614] ---[ end trace 0000000000000000 ]--- [  746.464322] ---[ e=
nd
> trace 0000000000000000 ]--- [  746.469033] note: kworker/u21:2[53] exited
> with irqs disabled [  746.474916] note: kworker/u21:2[53] exited with
> preempt_count 1
>=20

