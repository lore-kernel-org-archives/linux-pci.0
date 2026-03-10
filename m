Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011054.outbound.protection.outlook.com [52.101.70.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E3CE3090FF;
	Tue, 10 Mar 2026 15:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773155190; cv=fail; b=lvOs08WrpE2emKHx/qFDLX4AJPV0YHBOuJHoDFBtJRsPzLTEh9Bg5Sct+hDQsocbWnQMjdGxEUSk5tqDUCNPoRr0IsFjfSSjiTJETs5OkmQsRL/edtOoT1lgviIfYBFTNrfJu8hzhGpzk/L7lQMgOrh+Jxiu/vkq3sRD8/wqgDo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773155190; c=relaxed/simple;
	bh=E/ANxYbHykYcyqMLN8Mvhnm8x93YOV3x2ouqXeaAmA8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=u+U9hxua2OHbe9ppoY/DvoIrG3vlAqQ6sSBtKm5OaWYDzFdFAWR5ixxq/d4lp7JrfibuX1/eZ9ligTAVvyotROQPUG1eA1/knCaUchgI6UMTlc2QsQ3jWc+MaAVTCYSfI4jMPbw5e4qYABmZt15TBwdDYLzty0mDxrpteuHLcJ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=f/jhaZWi; arc=fail smtp.client-ip=52.101.70.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="f/jhaZWi"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QqsAW7xx3tVXdRyJ7S/tJVQtx48q/bZi6z+18oikFqo9qbFzO0Tpk2AXneaE7J7WqNlqg/u5zBsrFiMA+4gy5quXOCn5gm4zocnqdRwYUoD5x5iisSy2ZOMZAVDrpz7ZTKFGHh3YkOGpU3zeaEEaMLjo3OMiJguFuFhTbF3wExdhkhbUGPglP4yvzwhZzsaKZw3Q6e/N7QiDFGFPluSI8pzTr+H00Q6rtkkHNcfPRZ3/HbHuTmyDLdi8Kq3fBgMIZiuGfJcibQ3fPt/PAtfcfvF9M7nWuiGY6igipGfHP1c5EpFl8Z3HWfmDM7Nl3Fnuis0wqaZgRR4KUGv3Fcgk3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kqCHndIzCij70EKofghCIHFb7mfFXN+wxAqk8ea21Hw=;
 b=ow2OE/ypbQePkVfVSzd+/3684vtilt+USckq0VYJSKgBH43a7yNv0Y29aSfUsY35dbo5yn05NqY2anDoHEqSe2XxqQz/NpZdcQgoy+dverdAwyThWCsSUQe21aWZ+GRWwDN25IbEdVx90wrK17yQqlwl7vLvTJNAsVgH7Z2kAO+A7I6eAPh9TzzwCpqqRo0BlfD4Evp2woxRt558C0/WZDpVNO7K9Yy03eWxHbsb+0r0OKOVFFe+kqwOVvXd4cEjYstI7oJ7z2LhvmbMjyDLHNkvqQQKyUBiqX4/dFJlYeqC4pUXAkGltGu/cXHDN1egFg1nFfKkjLq6yBIrJhZynw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kqCHndIzCij70EKofghCIHFb7mfFXN+wxAqk8ea21Hw=;
 b=f/jhaZWirWcIg7AKFZMCM4WE+/LrCQPfOFKDtadAxhiyyulZn3K8CQN8/azoC+o1x27QalWdgrQZ/avvq717MRD0+F89asIy2/rPnI7kgQEGLycPI48rreQZkCayZJbT5qKuxq4AwA8fErvuir515uVT0Ebz7p083DGh1J6A8mMHc1/cyGXZrrPbDRCaUFZGpMZo5/g+9AgM9At10/kdpJzA5Ra1VQfM9o2j7a3U4f2UrIanoBgAd4hYXjOzkgUOvB61sgkxiA8NUPX1vXIc9y0rp+f2zSkqn7dCbgcYeov7aPu81/nBdai4CqgiJKsQxMw6AnTR2Y/0aEHx9HFvBA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by DU4PR04MB11053.eurprd04.prod.outlook.com (2603:10a6:10:589::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.25; Tue, 10 Mar
 2026 15:06:25 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9678.017; Tue, 10 Mar 2026
 15:06:23 +0000
Date: Tue, 10 Mar 2026 11:06:15 -0400
From: Frank Li <Frank.li@nxp.com>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	bhelgaas@google.com, l.stach@pengutronix.de, lpieralisi@kernel.org,
	kwilczynski@kernel.org, mani@kernel.org, s.hauer@pengutronix.de,
	kernel@pengutronix.de, festevam@gmail.com,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/4] arm64: dts: imx94: add pcie0 and pcie0-ep supports
Message-ID: <abAzZ-7AQQNNmHLz@lizhi-Precision-Tower-5810>
References: <20260310075459.726495-1-hongxing.zhu@nxp.com>
 <20260310075459.726495-3-hongxing.zhu@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260310075459.726495-3-hongxing.zhu@nxp.com>
X-ClientProxiedBy: SA9P221CA0027.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:806:25::32) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|DU4PR04MB11053:EE_
X-MS-Office365-Filtering-Correlation-Id: c4f88ae6-038b-43c6-5633-08de7eb697fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|7416014|376014|19092799006|1800799024|38350700014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	t9NDZGO22RnbfMPwfdrqYrWyAaTpHqrO9SM4xhSl5eQTQtgpp6ngi9FsU3XRKCTigMmbZh0qncyXKXM35eYFCY9N/9vtZn6LBgCbDiZEvTMczM2BJZvD8jnfvXLGh4E3KiCqF2fdH8do9tTuW9zaVZkyB4SWAnUdYNIW2xtHBFY9sU3D4i0jMwI+uGHjnHUJF/RU6UytQxO1h9XMxnWFkFaVuO5PGlq16tPALm316HV8cEj2Wb2nuUQTYA9scnuxWb5yBmzseC7aUTGXFO4E+CxIv7LSoLk61wTqAi5dpjcHG9gIRNa5FyTc5m68Qd8WaEOXIzp5Jux9JHmnM1FXh9g1jD4fuLWcyUuaAzdYDl3MtPhQzFERzOgWKglqPOC4re9xfCuRayPNETxJeBeY8YcH57kbo38Xp6UX4FBNmDH0Yn0dZ6arh/+BTvBTI+D182eIUapt3yrXZJwVgwLR2e/vQtOemqnMbWyXFCQlNkELZaejeq2067u/AJ5rd5rIVeGY3WZ3F590y2YbibUfnLCDE8jecQJ/GBb0Dtw2ADTIuERM62mEnqlFtYKHPiEJoUb2BClCrJ6aT8gl6P2rQCX0s6MYMwwN4zJZZODdczlkYAzM31zejAeXkeyR5bu1vaA4jU3co4AIJ15Z85XC5yZiI0EaqbUywWkOEpMRTEgL5Nz1GbZJ712b0TSn5Okl/SednaSARzhiiwYituHNVwxZnHtn55SwtYp0ylhYEsnsl6GJrFUY0yKwzuWK+XGw6HlwHx3MUAMg3c/n3GXrYYWK6dpjgPYv33AYpuEyjRQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(7416014)(376014)(19092799006)(1800799024)(38350700014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3VyawPyhAA8+T5JmTFHY4glZA7O7+31/2Mpy5b7n9rjXAo7fwjj+prTRCaVR?=
 =?us-ascii?Q?rB9ua41XuqwrEexpugDHlCxabqtMZ7BF09kTL51HGL0X28Dyd8FBpZMnf91m?=
 =?us-ascii?Q?6oIy9AEZgEIYYP1+6Yb40fvGxBC1Zh3G59qDnm8honKxDgROTsj72Sc0Ptu3?=
 =?us-ascii?Q?FF58jE5GzcbGZxkq6gLjMxq7IgJ3y7lmPrF42Hne0rAgx8ILbIDH4eernYSS?=
 =?us-ascii?Q?W5/Xu0qc5RXfe7xcwD4bkFhUlYJ/BroWxah03nw88cfJlah0UcXpEVYuSFOd?=
 =?us-ascii?Q?xl0yp4ZIx7PHPF5ej3eYhSIm++X2n3fWVSFD7m9jxLxvY3oQ6UAWHloCwoHm?=
 =?us-ascii?Q?pn3O/JvO4wEyWBRd8TbL3hJc0mdeazRK90EVOKBhGgm987WXNdkOYESMEX7V?=
 =?us-ascii?Q?7DPu2c48HbAWCnNC8U991mh8ZsakoBwo380X7tpsUiZ//+KZVkXl3OonfSr+?=
 =?us-ascii?Q?Z1Lu5WL+t8+UhnXelf0DROO2VFOtQeCBtKt2SvvZvBEMt+SzuDbA5FaproeR?=
 =?us-ascii?Q?zvPVmPOEwuqdpEbiM4f/iP7ymgiKhXzexWgvqJnygREZt4Bwt79KwTSygKlR?=
 =?us-ascii?Q?izwVn4X3sL2A+rV7bgCh069hpYhTNpsQuYx7OmdMHv+4wv1XBDeUjbJFT5Yd?=
 =?us-ascii?Q?pXFWPh6JP3aI/JPfN3xC1NAd7ZLT3gyU30R8douw4KvnmkboKlUMT35/86Fs?=
 =?us-ascii?Q?rbM5Du5OYUJF/3k0XWRbeZKwHhy5bQ6OrWpTz5Hu4lZWKKu6TBR3N4nUTqfF?=
 =?us-ascii?Q?H3pyntwdnlEkUSTTTUIGvsztUu3p8KQSHzvQu4aolvB8YCjydvs6190aYxGQ?=
 =?us-ascii?Q?r1gczCag3hXeHzOrFvypwDc8sjcs9oVfzyVQghOODQ8PYyfnHqj3qe41tCO2?=
 =?us-ascii?Q?piqA1ckDLrJSUchoFm/W6geq42KmDhFLrAmo2W6bjoILcvQTND/sAR/AaiIA?=
 =?us-ascii?Q?5kfqv99usCJr3BH5HkQzRz1NQCQ8q2Gv5Jvhff+0zeJOERe2jsJRNl5B4zIn?=
 =?us-ascii?Q?G05dnL0S2m8VpU84Yc1XGHKTzaaLVc/c5jhd/BMUio61Ae2ZQ2YuPcNwBzZ2?=
 =?us-ascii?Q?ChJRugH4W+AhhuPQ6j8I9u8dBeYMnvtcw7KGKtway6LNzeAPcHfXAr2OPfPa?=
 =?us-ascii?Q?aXZgCyNxWXdII6tZKALXnnkiN/pedQVmVt7ZpgxxICZtltToH6flQXd4F9zC?=
 =?us-ascii?Q?dkfeB3YVjMJyXiOdEQ4tAxS9E6PWvmG/srCQl5L0pRdmok3MN1D1kY4kpm+e?=
 =?us-ascii?Q?rUAxwf7DnCGu9Hr3Af8OD/C/RuU2mQdf+SRLalI7phS3pw118Qf8SaQ+S6uT?=
 =?us-ascii?Q?uz0MtalE9SEPE5X4X1FJyADgxE60dTpvjuamR6wKSLFgeeD27V2PVsOOgQ8D?=
 =?us-ascii?Q?TOEA6DUd9fyWCy8pQA/Y6GrG6M/5wtX8CO28rCYXjUc41JOrW0xM+E0O0+qj?=
 =?us-ascii?Q?tenWw3sddz4XVyfm/gHeVF7oeUhtZG7kxhaBudlAteWPr/2/r3JOALiNqquq?=
 =?us-ascii?Q?mEGgkFGR8qHTA4SqLCmEgasCt1WXZG5kQjOx6a2XSeSQnSKF4KSkXO+kp5jW?=
 =?us-ascii?Q?WHaKeIPdLl9FLfn3eB2SQGPprN9HcGrMsGfIX9su3kwyypYGuYuqUI7jG01I?=
 =?us-ascii?Q?yfZtDaEY91Vy7fNa3RUHrrinB1GV7uVugDEwPp97WKbL8+sH6e3RDLMgUvnu?=
 =?us-ascii?Q?URr5sWd4L2Im7mQyeYuYk6yEPlpMTu6OO2KGts1VB6aZq+PJuW7lSIeoLiVp?=
 =?us-ascii?Q?ulnguDPbLA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4f88ae6-038b-43c6-5633-08de7eb697fb
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 15:06:23.3776
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T/JZp3dfuYNRYN17IdUZF40kBfB7F5nLCDrYMTLQlGJl7VuAmhNgj2/N/WsSPLOlr6EkuqxyRMi2mKZpYIZDuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB11053

On Tue, Mar 10, 2026 at 03:54:57PM +0800, Richard Zhu wrote:
> Add pcie0 and pcie0-ep supports.
>
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> ---
...
> +				  <0x100 &its 0x11 0x7>;
> +			msi-map-mask = <0x1ff>;
> +			bus-range = <0x00 0xff>;
> +			num-lanes = <1>;
> +			num-viewport = <8>;
> +			interrupts = <GIC_SPI 364 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "msi";

alex add "dma" irq for other soc.

Frank
> +			#interrupt-cells = <1>;
> --
> 2.37.1
>
