Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012009.outbound.protection.outlook.com [52.101.66.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A805246C4D2;
	Tue, 28 Jul 2026 19:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785265926; cv=fail; b=BMDdXUFT0RoAApA59OGUUj3N7TJdP1gqnJmND5vAZfD7AhWzuAm+koFCwd6auv7AZD7gIw38m46F4qN7EhDvUnfKS4RRG2V/q2NXXxoQdPGSsfkX+5M5B6O9uy42yLZ+byPZnNQlSOmontCWfgwELBE9UbOZ3MajLXa43325eRc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785265926; c=relaxed/simple;
	bh=g4s1vN2v8EXEAkwVo5gWfDKQ0bvGOgMNVpOLkGs6LZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FGRWUK0+b1OvkNb/XT/huSENKUcHHmVnso4GnvuDdZoSrb+AtzJZwnvO0IxbihOMg8BaJao2UfPdPqU04wa4idorfEJlTFYbVqSlDU+/KiL6Kx0Ed5mRAa9hkqwFUBhzpEVMYe13Cu7XbXsRiJknhDsT7sW8tkei4npbyhmOKlg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=cEGlow5a; arc=fail smtp.client-ip=52.101.66.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="cEGlow5a"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QPL1K8F4LtAp7nb7AfABTQUga7nQhbIGjkgqDJA9qf7pYRPGDRHpSs3jnJcmUMdz+8hAaPwXhAQ1s504qzKBu28gHfIgTD4ugZ2Zp5bjY4BHLZOtxsJO6XKU5CyTXyHnr+E2QW4RzMo85dDpqqixD1fDVWhA4Ryzghwp0njGLAeSvm6R+32UAEBe2TsSMnwa8tzqhzK55fHzmFb7xPlrEpfBJeGI6e8+rqycvFRLjsyuDdCJnkr+iWci14f1oO/fjkNeTO4qgEzacFeGBG6NV6nl0XzreZa73LY3a2rWW8BmHcFKebta51tpxcwcsEOW1Xl9RSGA17ZiUKHID6+cSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PvLRbn1D0FFUnsTwLsrPMdrQNORdZ4j47n0987+Abxg=;
 b=heqT3klDJEaLhjMXxRpQhqDFGJ7ujro/hoe9WcSPwRTV3/mtDnYyDITUscfwR/CPrixvUEiVws2JriQsPL4KRruPQAsw60NHyxbymPzkdKeCNgZmRAnK5CX1K7wihYPt0AKTcTxdByI+xvNIKGJ7DXdyWh575+xNfiz7FgzvpSSf8vlsaOU9AgpSw8vqlYsAHAgNCjfx4rZcCGJn4bqPADx3S2KEakg4/RdwM1vuAHd5dTJ0v/+2dhdhly3P8zX3fLWPOBYZps5x1MUZRhCiqFzlHiig3NWh3h7XkrfVxXcVB/tQOIVxV7nehpAJn6wVZ5dwZfvA+UwKK70YrFXRaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PvLRbn1D0FFUnsTwLsrPMdrQNORdZ4j47n0987+Abxg=;
 b=cEGlow5aN9V3YxeqFSCvRcvLh63KPUcXLFbritAELufpYtevLF2iOaKEqk6uXi/qlS/FTjsLdFKmlXtMd1JMkv5keBLbZ0qPoN2A3h86l2qCr2yMUpTKFUVkPrthN6N3h0oIj8Ech1Gj+JM0pO3hBuQrEubg7gtQ7EmF07b9Jy6FAsWSS8jyA7gkWvTMlaOE+Ttmqn7AGWHD9wCiPH2OYPwR0H1UPR3WhxgpecUoKU4nbETMbpM5ze4HFvSFiP6AouLZwWLTSBGaLMZ+B1hQGh+3/COGS12QicIDBYQUI/tfkQOxUijM+Ws5gNCVVSJD2fR56vn1mmtpsoHYIq6leg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by VI0PR04MB10319.eurprd04.prod.outlook.com (2603:10a6:800:231::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Tue, 28 Jul
 2026 19:11:59 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0270.009; Tue, 28 Jul 2026
 19:11:58 +0000
Date: Tue, 28 Jul 2026 15:11:46 -0400
From: Frank Li <Frank.li@oss.nxp.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: linux-pci@vger.kernel.org,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Anand Moon <linux.amoon@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>, Frank Li <Frank.Li@nxp.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Heiko Stuebner <heiko@sntech.de>,
	Jesper Nilsson <jesper.nilsson@axis.com>,
	Jingoo Han <jingoohan1@gmail.com>, Koichiro Den <den@valinux.co.jp>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Minghuan Lian <minghuan.Lian@nxp.com>,
	Mingkai Hu <mingkai.hu@nxp.com>,
	Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
	Niklas Cassel <cassel@kernel.org>,
	Qianfeng Rong <rongqianfeng@vivo.com>,
	Qiang Yu <qiang.yu@oss.qualcomm.com>, Rob Herring <robh@kernel.org>,
	Roy Zang <roy.zang@nxp.com>, Shawn Lin <shawn.lin@rock-chips.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Srikanth Thokala <srikanth.thokala@intel.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Yuho Choi <dbgh9129@gmail.com>, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-omap@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH 1/2] PCI: dwc: Handle return value from endpoint .init
 callback
Message-ID: <amj-8tqEToQF6_gY@lizhi-Precision-Tower-5810>
References: <20260728012548.465139-1-marek.vasut+renesas@mailbox.org>
 <20260728012548.465139-2-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260728012548.465139-2-marek.vasut+renesas@mailbox.org>
X-ClientProxiedBy: PH7P220CA0148.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:327::16) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|VI0PR04MB10319:EE_
X-MS-Office365-Filtering-Correlation-Id: a02ee67b-24f6-48ef-be23-08deecdc18c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|19092799006|366016|23010399003|376014|18002099003|4143699003|56012099006|10067099003|5023799004|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	aYvA0EaNnyGTRsQfb0ARcYzPuxyMdoFOVMAPGDAmT+mJRZBxMFpveb/Z1FlqeExi/ABZ6n8Sw4y3/gcTVXkvl9v00R6HAYE/vg4ct2EoQ+dZq5ojSl1aP9wgz23B+STP2/SeJMsAB2Eq28EpNpoi0h/fbdmU+Gh2h+rIG3iY+8lbKCtGB+hZCkfOGqhMIsQ1MJMGRnuuP3BO+6LFESpo0mMDTiUtRtxLi9GiZ/Lppd1Kw6nwcX0N8xzK2ceRfXXr/QLDOuRXhI5PhUKdM9IPF9TF+n4W5WrQKQFzoiaNOsgMZ5DrB/lyTvD+8fyRZKUpZMYGZ2RKEkfv+XhOrWBK21aY4uPezAnHfh53Ql5Dij1C297JEyozHvfUOaqrrEAu31VQxClMD62NdvGQ9FXpN+EJygTpLhBcJGZkCwkFEFk8qr/ymbsS6n7IKRDhZcP5XL074FLZKawijiQ6ZElRsX+ZCrH0L7gn/5pcyFeHWM0TJ5cHCD13FXp2/sH66tIiDeZ/hP+0yQC38lr341fW1K+6kh6awpax9ya8PGI9YN1ewkO7t35UfGEQrKZg8h1Q2rxwbZF+mCgzpsjJpvdkRmwp1QQg9/on7zULzuQBq6qsfpWHxLHTSINhltnLF1LG6ac6qMta3sH/FO6PRkGSx8pE4zTJQAyr0ldRmnj/fG8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(19092799006)(366016)(23010399003)(376014)(18002099003)(4143699003)(56012099006)(10067099003)(5023799004)(22082099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UXl4WFJ0VmU4ZTBKb04zQXF1bzVGK3VaSm4xd2gvcHIrOFdHT0JEbnRhNnhp?=
 =?utf-8?B?NllPMy9mSFJIb001SHgzZi9KVGRYbHFXNzRuakt2MHlvM2JSM1hDbk00TDVm?=
 =?utf-8?B?ZHdNQmNFdUlTV3A3OERjNy80QUs5Zk9EaW8yQXJHNWZkRVBVejZDajlmUkRy?=
 =?utf-8?B?aGFaYStvUnJIdHhkRThUZ242WlFxTXVWdWkrbVQ5dXlBUTFQZDZqMFFOWWNi?=
 =?utf-8?B?SzVHTndEeXozdkkvRWlERWU3d0J2dnQvMmJ2dXJUTVhXSkxYVzR4N1F6aG01?=
 =?utf-8?B?Rk4wckRpOXdxakVRNWUwbHY0RmFWOEQ3UzBmZUtCTXFiNWFCVGhmRWxvZVd1?=
 =?utf-8?B?OUlEa1Y0VStvZlJTekhTMllGM1phaURWek9sNEtOVGJPeDNaTCtZM25BeFB6?=
 =?utf-8?B?ZytZQjhaaElDclFJUGVYenEvcUxydFNiVHNjbGNzOTJDZCtSUmNiOVN4RU9x?=
 =?utf-8?B?OXlxVlZHeTVBUlFDeFc4Sk1RdDIvNmZSUExIbmd5Q2dTMGtpTjdPYWFNcHVk?=
 =?utf-8?B?RlVQd3djTjM2aXpTdmVZUXN3SE1HT09MV1hWcXBBZHV4dXY2aXVFNmR1QVpB?=
 =?utf-8?B?bERiRU1mcXFKUGI3TnJYSjdYMGlZZnpWMTBBbjYzcFNkdW5sSkYzN1RSakwz?=
 =?utf-8?B?MWcyNFVkL1M0TzVmQ0xlUE40NXJlWnhXS0EzS1BzblpLdFErdHpxZXp2THRW?=
 =?utf-8?B?cC9ua3paVUR1M1BzbGF3YkxLWFk2NFRQUmZOTUFrRWhSZy80dFBKeW1yNkpN?=
 =?utf-8?B?ZUdZU1Z2MUtUZ01qZXlnTHZLTTlFZlEvQWpEUHZJVm1zU0dXano1a3A4MWtK?=
 =?utf-8?B?V2NRZlN4S2hSR3NNTVhuNVIrOVpFMWwxL3pBRnAvUEdLWDBTZVkxTVZkWVVI?=
 =?utf-8?B?dTNpZ3VZdTVvK1RGbmgzUUdiYkFqcEJsZWV1Yk5jbmtNSks2NkNBNnB4ODBH?=
 =?utf-8?B?QjEreWZHZ29nU0VPbnBQN3YrRWEwZjEzM2F5TEhSN09nNVkxV2VycC9hT1ZI?=
 =?utf-8?B?bERjRWpnaGpnL1NQdGZjREsvM1JpNDNJTkNOMkJwQUpkZjRJdjltVDhZUm14?=
 =?utf-8?B?dTRaaWtILzg3cXhtZ0xxcHlzTUFzOUkvOGQ5N282VThaL0F2NjdORFVCQkZy?=
 =?utf-8?B?b2ZZbzhlcVU2NVg5K1gwdzBYTmZRbWtNSkFWNGpyK3pDUC95TXQrMzArdFBM?=
 =?utf-8?B?M1owZWdud0ozM3JXQ0oyQndZVjBaN2NDVVBRVVRUZG5BdGRIamRTUDkzVDVM?=
 =?utf-8?B?ZVVjeXovWFhDV3A2Tzl0c0FuRFl5ZjhSM0xRSW0zVUFSMXphOS9HQmVnK25y?=
 =?utf-8?B?NUJRdjUvNE5lRFIyb3paYzJrS3FkcHJPcGRLWlRrNmR6NWFkRmgvUnRsU0Vv?=
 =?utf-8?B?emZXQitYVjdpRDhNK0h5clJsMk5DVy92WWdQdU5UVHJrM3BMUXZXMzBrQkRt?=
 =?utf-8?B?QnE3SXlONEJEZzdGczlxNTY1KzNiSkpVSVRmcmhTSVlJc3FUS1I0YmhHZ3lK?=
 =?utf-8?B?WHd6ZUVUazZheTBBZ0crbmlCWkpUbXpEQ1VWOHBLb1E2WE9HTGN0dDM3b0VF?=
 =?utf-8?B?aFViYWI1Nk9lVUZPaW5ZOHpZSHRoWHRGUk1FSDgwRnpURXNvNEZ1OFE0MjR3?=
 =?utf-8?B?UUM5TFMxTGtKOFZwVC80VC9rcFFnbTdPczdLdTVGcWVraytrTDN0RlF4UDJM?=
 =?utf-8?B?c05aNWwxOWcvSHlBblRjRjE3dWpubTV3Z1FGeGZwVE04aEsvN0MvUEZrdG5E?=
 =?utf-8?B?Zks5c25mb0p4ek94aWdBRlVPMnBxVElMVGMraVUrMWV3R3pZS0Y1WEVHa1BL?=
 =?utf-8?B?cWIvTWhqV1dMY2RBWENZK2pIb0VGbFQ2VDQ0dnJ5YUtpQUl4c08rbWI1MzQx?=
 =?utf-8?B?blpLeURlL0VqTW9TYk5nb25VRDRiSmhHb3hTc2RxQ2Zsa2lEalpJcjArMksy?=
 =?utf-8?B?NC91dXpkWlZkeVR0Mi93V1NGUWhvTGE1L3ZjeDFTQW1Rc0hHSDhQV0l1b3NY?=
 =?utf-8?B?UjJPcmQvdGxkdVJpb3NrSm9LanN5ZEs4eDRCcm9ETHVDZDlKTGp6TFZ6KzUz?=
 =?utf-8?B?QUtSUXFJakdMK1E4K3U5eTdDMC9pY003Ri8zcEdHc0JtZk1hYklzMm9PM3hl?=
 =?utf-8?B?M2pJb1N5YlhFVlJmMG1qZHg2UEw0ZWl0amlBZXFwVU0vSjJEOWtOOVFPekxR?=
 =?utf-8?B?eDROTGd6NUR2QWV2YjRldkV3Qm1EZkFseUJCTTc0V2hpWjQva1RJUmM4Q2Ew?=
 =?utf-8?B?NTZtdy8zRWZkeG0vTW50UnozYVJEMStIYzRaeThuT2JVS0c3N1lYYXlobFhM?=
 =?utf-8?B?dGN4SlJOLysvd0tUUTVQWVE5VGxndlVVRXY2U0N6UDZidDE5YWpPT0hXOHNt?=
 =?utf-8?Q?KKkOILqfkngSdwQKUteE/nzTayX6E2wqo5yI/?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a02ee67b-24f6-48ef-be23-08deecdc18c9
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2026 19:11:58.8679
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P1dw1090ZBswtQu4fIcXjkLY6+2tw6u6O5o2FqmOkxSPcI3vp57lU4DnM/I5Q9aaFFxeM4rwIFzjz9X3l0V/6WuhF2iSC19Qr6PVT+ayQuDb5jbj/NMJN8w68+LneqBb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10319

On Tue, Jul 28, 2026 at 03:24:24AM +0200, Marek Vasut wrote:
> Add return value handling for struct dw_pcie_ep_ops .init callback.
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: "Krzysztof Wilczyński" <kwilczynski@kernel.org>
> Cc: Anand Moon <linux.amoon@gmail.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Frank Li <Frank.Li@nxp.com>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Heiko Stuebner <heiko@sntech.de>
> Cc: Jesper Nilsson <jesper.nilsson@axis.com>
> Cc: Jingoo Han <jingoohan1@gmail.com>
> Cc: Koichiro Den <den@valinux.co.jp>
> Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
> Cc: Magnus Damm <magnus.damm@gmail.com>
> Cc: Manivannan Sadhasivam <mani@kernel.org>
> Cc: Minghuan Lian <minghuan.Lian@nxp.com>
> Cc: Mingkai Hu <mingkai.hu@nxp.com>
> Cc: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> Cc: Niklas Cassel <cassel@kernel.org>
> Cc: Qianfeng Rong <rongqianfeng@vivo.com>
> Cc: Qiang Yu <qiang.yu@oss.qualcomm.com>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Roy Zang <roy.zang@nxp.com>
> Cc: Shawn Lin <shawn.lin@rock-chips.com>
> Cc: Siddharth Vadapalli <s-vadapalli@ti.com>
> Cc: Srikanth Thokala <srikanth.thokala@intel.com>
> Cc: Vignesh Raghavendra <vigneshr@ti.com>
> Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Cc: Yuho Choi <dbgh9129@gmail.com>
> Cc: imx@lists.linux.dev
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-omap@vger.kernel.org
> Cc: linux-pci@vger.kernel.org
> Cc: linux-renesas-soc@vger.kernel.org
> Cc: linux-rockchip@lists.infradead.org
> ---
>  drivers/pci/controller/dwc/pci-dra7xx.c         | 4 +++-
>  drivers/pci/controller/dwc/pci-keystone.c       | 4 +++-
>  drivers/pci/controller/dwc/pci-layerscape-ep.c  | 6 ++++--
>  drivers/pci/controller/dwc/pcie-artpec6.c       | 4 +++-
>  drivers/pci/controller/dwc/pcie-designware-ep.c | 7 +++++--
>  drivers/pci/controller/dwc/pcie-designware.h    | 2 +-
>  drivers/pci/controller/dwc/pcie-dw-rockchip.c   | 4 +++-
>  drivers/pci/controller/dwc/pcie-keembay.c       | 4 +++-
>  8 files changed, 25 insertions(+), 10 deletions(-)

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>
> diff --git a/drivers/pci/controller/dwc/pci-dra7xx.c b/drivers/pci/controller/dwc/pci-dra7xx.c
> index 3fc889944f021..6ae5b27e27b32 100644
> --- a/drivers/pci/controller/dwc/pci-dra7xx.c
> +++ b/drivers/pci/controller/dwc/pci-dra7xx.c
> @@ -373,12 +373,14 @@ static const struct dw_pcie_host_ops dra7xx_pcie_host_ops = {
>  	.init = dra7xx_pcie_host_init,
>  };
>
> -static void dra7xx_pcie_ep_init(struct dw_pcie_ep *ep)
> +static int dra7xx_pcie_ep_init(struct dw_pcie_ep *ep)
>  {
>  	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
>  	struct dra7xx_pcie *dra7xx = to_dra7xx_pcie(pci);
>
>  	dra7xx_pcie_enable_wrapper_interrupts(dra7xx);
> +
> +	return 0;
>  }
>
>  static void dra7xx_pcie_raise_intx_irq(struct dra7xx_pcie *dra7xx)
> diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
> index f1b27aed488de..602516239a573 100644
> --- a/drivers/pci/controller/dwc/pci-keystone.c
> +++ b/drivers/pci/controller/dwc/pci-keystone.c
> @@ -876,7 +876,7 @@ static const struct dw_pcie_ops ks_pcie_dw_pcie_ops = {
>  	.write_dbi2 = ks_pcie_am654_write_dbi2,
>  };
>
> -static void ks_pcie_am654_ep_init(struct dw_pcie_ep *ep)
> +static int ks_pcie_am654_ep_init(struct dw_pcie_ep *ep)
>  {
>  	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
>  	int flags;
> @@ -885,6 +885,8 @@ static void ks_pcie_am654_ep_init(struct dw_pcie_ep *ep)
>  	flags = PCI_BASE_ADDRESS_SPACE_MEMORY | PCI_BASE_ADDRESS_MEM_TYPE_32;
>  	dw_pcie_writel_dbi2(pci, PCI_BASE_ADDRESS_0, APP_ADDR_SPACE_0 - 1);
>  	dw_pcie_writel_dbi(pci, PCI_BASE_ADDRESS_0, flags);
> +
> +	return 0;
>  }
>
>  static void ks_pcie_am654_raise_intx_irq(struct keystone_pcie *ks_pcie)
> diff --git a/drivers/pci/controller/dwc/pci-layerscape-ep.c b/drivers/pci/controller/dwc/pci-layerscape-ep.c
> index 8936975ff104e..527c57114dcfe 100644
> --- a/drivers/pci/controller/dwc/pci-layerscape-ep.c
> +++ b/drivers/pci/controller/dwc/pci-layerscape-ep.c
> @@ -147,7 +147,7 @@ ls_pcie_ep_get_features(struct dw_pcie_ep *ep)
>  	return pcie->ls_epc;
>  }
>
> -static void ls_pcie_ep_init(struct dw_pcie_ep *ep)
> +static int ls_pcie_ep_init(struct dw_pcie_ep *ep)
>  {
>  	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
>  	struct ls_pcie_ep *pcie = to_ls_pcie_ep(pci);
> @@ -155,10 +155,12 @@ static void ls_pcie_ep_init(struct dw_pcie_ep *ep)
>
>  	ep_func = dw_pcie_ep_get_func_from_ep(ep, 0);
>  	if (!ep_func)
> -		return;
> +		return -ENODEV;
>
>  	pcie->ls_epc->msi_capable = ep_func->msi_cap ? true : false;
>  	pcie->ls_epc->msix_capable = ep_func->msix_cap ? true : false;
> +
> +	return 0;
>  }
>
>  static int ls_pcie_ep_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
> diff --git a/drivers/pci/controller/dwc/pcie-artpec6.c b/drivers/pci/controller/dwc/pcie-artpec6.c
> index 5cd227dda9a10..7f0ba506dd1cf 100644
> --- a/drivers/pci/controller/dwc/pcie-artpec6.c
> +++ b/drivers/pci/controller/dwc/pcie-artpec6.c
> @@ -335,7 +335,7 @@ static const struct dw_pcie_host_ops artpec6_pcie_host_ops = {
>  	.init = artpec6_pcie_host_init,
>  };
>
> -static void artpec6_pcie_ep_init(struct dw_pcie_ep *ep)
> +static int artpec6_pcie_ep_init(struct dw_pcie_ep *ep)
>  {
>  	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
>  	struct artpec6_pcie *artpec6_pcie = to_artpec6_pcie(pci);
> @@ -344,6 +344,8 @@ static void artpec6_pcie_ep_init(struct dw_pcie_ep *ep)
>  	artpec6_pcie_init_phy(artpec6_pcie);
>  	artpec6_pcie_deassert_core_reset(artpec6_pcie);
>  	artpec6_pcie_wait_for_phy(artpec6_pcie);
> +
> +	return 0;
>  }
>
>  static int artpec6_pcie_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> index 7d2794945704e..d78fb845582b2 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -1367,8 +1367,11 @@ int dw_pcie_ep_init_registers(struct dw_pcie_ep *ep)
>  		list_add_tail(&ep_func->list, &ep->func_list);
>  	}
>
> -	if (ep->ops->init)
> -		ep->ops->init(ep);
> +	if (ep->ops->init) {
> +		ret = ep->ops->init(ep);
> +		if (ret)
> +			goto err_remove_edma;
> +	}
>
>  	dw_pcie_ep_disable_bars(ep);
>
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index de4b245b1758c..004b433f17135 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -475,7 +475,7 @@ struct dw_pcie_rp {
>
>  struct dw_pcie_ep_ops {
>  	void	(*pre_init)(struct dw_pcie_ep *ep);
> -	void	(*init)(struct dw_pcie_ep *ep);
> +	int	(*init)(struct dw_pcie_ep *ep);
>  	int	(*raise_irq)(struct dw_pcie_ep *ep, u8 func_no,
>  			     unsigned int type, u16 interrupt_num);
>  	const struct pci_epc_features* (*get_features)(struct dw_pcie_ep *ep);
> diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> index 731d93663ccae..bd5d1a2472a40 100644
> --- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> +++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> @@ -469,12 +469,14 @@ static void rockchip_pcie_ep_hide_broken_ats_cap_rk3588(struct dw_pcie_ep *ep)
>  	dw_pcie_remove_ext_capability(pci, PCI_EXT_CAP_ID_ATS);
>  }
>
> -static void rockchip_pcie_ep_init(struct dw_pcie_ep *ep)
> +static int rockchip_pcie_ep_init(struct dw_pcie_ep *ep)
>  {
>  	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
>
>  	rockchip_pcie_enable_l0s(pci);
>  	rockchip_pcie_ep_hide_broken_ats_cap_rk3588(ep);
> +
> +	return 0;
>  };
>
>  static int rockchip_pcie_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
> diff --git a/drivers/pci/controller/dwc/pcie-keembay.c b/drivers/pci/controller/dwc/pcie-keembay.c
> index 42fb5f24a2230..b11e66c10fffa 100644
> --- a/drivers/pci/controller/dwc/pcie-keembay.c
> +++ b/drivers/pci/controller/dwc/pcie-keembay.c
> @@ -278,12 +278,14 @@ static int keembay_pcie_setup_msi_irq(struct keembay_pcie *pcie)
>  	return 0;
>  }
>
> -static void keembay_pcie_ep_init(struct dw_pcie_ep *ep)
> +static int keembay_pcie_ep_init(struct dw_pcie_ep *ep)
>  {
>  	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
>  	struct keembay_pcie *pcie = dev_get_drvdata(pci->dev);
>
>  	writel(EDMA_INT_EN, pcie->apb_base + PCIE_REGS_INTERRUPT_ENABLE);
> +
> +	return 0;
>  }
>
>  static int keembay_pcie_ep_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
> --
> 2.53.0
>
