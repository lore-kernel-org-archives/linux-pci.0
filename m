Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011054.outbound.protection.outlook.com [52.101.65.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF34355055;
	Fri,  7 Aug 2026 19:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786132401; cv=fail; b=rYuRvxeztDIT+vlaGBb8PgAATLQSVWPfJFqo7GFDCLapg+bCP9F4nUs0wD4tczj57w3VLaiLg4cinWM/8nxKiuoCws0ZIREbT9AcLwPbIleD6onlWY13AqsoWfieAuY8VXk7xv2FDWMX8zztF/TEatDG8J25p3uyLoeM7s6KdLw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786132401; c=relaxed/simple;
	bh=3Nhmm10f7uYoo7fMtl7gq+erJsn0RHHi5y07jeKs4C0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IkQ9Q4L5RsblQ7YzoQumBeq7egz7sTneLqFzHz8zSaRqOyLgTmJ3utsGgluCHlFVu3GLqc7xHEtcinG9mUD+pOuIT+jy2VDrWjHCHznyHRZz1LpOSPqUsaEYPvTHj/nBwNrEwRPNGyX8CsdMLYKlNToyyvavTVydwgb4Xe8PmBA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=BHrT98qu; arc=fail smtp.client-ip=52.101.65.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="BHrT98qu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OAXxGtLnBo1sU8pa0Raak/D6gvw5cIzWJH2gdez0LhHEs5hcmAa41eFylJ0QVziF6gAJ6fkIz97tW7ZJqGmsEym+nPAD4skWM4emqEuJMbVMhY5pI0SwhdOlF6pEXAVhaQ4D/ArxkspLpeVcrPzM3XNow+rMEUcpDeosyl/Y1dmO2tHwbuFLyxA6O84Uccd9iZfpCJT3asZsaAR9Bt0w8WZ2jNdkPlvTHKjCrpaTA/ks+ydG2VGDJ0VBs5N96J1HH/bGmbjRJUnblkgHgQWelAvIzUJrXTKAe276dPXKmG2orRldBYClt49atX5m8sx01SxDCn1RMbre6UvwAwNSIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=09+ly3wj4zkUBYXUu00CgDhn5h3Z/QHsn3bvHMYNdBY=;
 b=F1mh4hQNdQfDlRU7cyHhV41pQirukWSyKavtjmgzhp4BMeCIkPFZbSTgIrZ0c7Nx2v5Qzxozxk+2zcqlgqnIWW4hgjB8eNG+OgM/XMOuVY9o10ZKwtR7hKNuTMotCN9btbEieYEWlDvWtPkf/bJ71FwV/4pOW/kkEcc9i6Tsm9a6yhJeagwJcxet5LcChd4JIpmSR/xImPB2fFTgVBJmo9wUSFxNssuz/IlkSg5S6z3ihdZDDyxX4R+WW714BdVcVmFZ2O3P1lOOE4aTN9dCYYLKpfOS2HM74Ic6cv0ssv+jb7WpJtXVvqCkycNNcYQZT0dL16dCqdy+2dBvrDNvsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=09+ly3wj4zkUBYXUu00CgDhn5h3Z/QHsn3bvHMYNdBY=;
 b=BHrT98qu7XxF7d+9ZgfeC0yMJ1nFAHLu+9+KwddvKTKBOAhBGJIHhgQ0j7mCguK2eEAsvXk2kDbXgS2e8mW+JzmsiYl0TvH1dGSlODXv5NiVAazLVi4Emo1ITsBiYr7GkTU/a3gqC8VvYyGbHm9RyfNwHU79CIj6p5Crp2T+tXT8Pwgiz7ej0cTvtpX58iJAon1aN8AvMepYjIXwwaM0B4YdrvHmko5kWW7HsRoGiuUAnE6+Mp6Ewads4Csx3OBJexlspeF+eM7DxMcABDltb25OnXD8yuzU5T5PmcbCf0fw/Zg/ZUf4xYf1v8kaDCJ3juOayw5EF8gpPsUvVCinLQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by AS8PR04MB8247.eurprd04.prod.outlook.com (2603:10a6:20b:3f2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.24; Fri, 7 Aug
 2026 19:53:16 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0292.018; Fri, 7 Aug 2026
 19:53:16 +0000
From: Frank.Li@oss.nxp.com
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	amitkumar.karwar@nxp.com,
	neeraj.sanjaykale@nxp.com,
	marcel@holtmann.org,
	luiz.dentz@gmail.com,
	hongxing.zhu@nxp.com,
	l.stach@pengutronix.de,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	bhelgaas@google.com,
	brgl@kernel.org,
	"Sherry Sun (OSS)" <sherry.sun@oss.nxp.com>
Cc: Frank Li <Frank.Li@nxp.com>,
	imx@lists.linux.dev,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-bluetooth@vger.kernel.org,
	linux-pm@vger.kernel.org,
	sherry.sun@nxp.com
Subject: Re: (subset) [PATCH V6 0/4] Add PCIe M.2 Key E connector support for NXP i.MX boards
Date: Fri,  7 Aug 2026 15:53:05 -0400
Message-ID: <178613233956.1446311.6562635307844065538.b4-ty@b4>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260713023435.235765-1-sherry.sun@oss.nxp.com>
References: <20260713023435.235765-1-sherry.sun@oss.nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH8P221CA0009.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:2d8::12) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|AS8PR04MB8247:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b0e1ffd-dd4a-496f-679c-08def4bd8570
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|23010399003|376014|19092799006|366016|1800799024|921020|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	90i4oNbJy8GOykOTx9fFCHv1+6uVkUwYjkfdNkGlUMNWR3xRsbiUcGQ+WESjtNyMj5LXfFdETyjVPMuMBJshp5ciGwglBvaiVxZGb0FmXdKnKUUQuFo2OdCbUypbesIJ+R3dzjOtPIv5YvtQC/zsWxHGPNHUQ9hZgpDHHVZydA5ktuJZooMk4GH9LjnO3+wpM1VqU8weKLm5zt7G7NkZoDtLXmvqeu8Urne8acz61CzTe4a0kz2TdStz4pYwHt1n0khbpOfbcQzKdWYZ3c1gbXa5Ypkq0X+CCKv5uCo7j6EGBk35kQctpvWKHfhzQ3ESxQC9f+CzOBrD85iikmTTSMxqqDF8q6d722k/CSBOLH8jh8LbOyswFUz1l/9NInXOcOZ2pSKK2fmHL9EpOiyLrwK3+M3fw+Uf3zWFEsgmq5CHS6M/d0AJUO+Z8PEMrHDJDVgh8D3FsQoMRdm2C8O3KGByABYy2r/xEZ471Vshy2I3bwb763NleZwuHjgZticl7u3RcJYggpGigl2M7kX6RRDpwyF5zuyt7tH6/JvhY7AznN05Zp03TqThw6JwwCY1KDqTQhPno3ggk357n+zKbWZNyqkMtIaeSLCQVgITl7QmqIZJnu618/mrPNHKqHqQSnaQqi66DuLx0Vx1Pk/3HK5JmY2hwfUovHjrRYyO+r9SHGvGbpmkxBzKhcxxD7D34SNBFEtUmIGpLjn39z0MUw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(376014)(19092799006)(366016)(1800799024)(921020)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZThjSkIzbHpLS1Y0THNmK2ZWMjllYU9WWkFnTjZBbVZsTUM3L1VSNVkzQjFq?=
 =?utf-8?B?TnZHK1V5anNycFowQmpGeUdEV2xaZVBsa2gzWWFLOVVZY1FCV2tqTy9aakUv?=
 =?utf-8?B?QTlhTS9ZQU9aajUzbHU4a2I1bng2aVJoQXlDZmp5ZFNHWTdvcjNmZTBja05h?=
 =?utf-8?B?WTRQSXlVLzNzL3FMTEkyVXVUQlJXUzFJckQ4Qkx0SWdhZjlYdlNLNjF4Tkp3?=
 =?utf-8?B?SjVxZTlQVGM2VE1nQ0ZuaXl4ZWJLRXJUcGNEeXp5VXRCbVA4VkdWa1pBMytW?=
 =?utf-8?B?dzhYMVNlaWpmVFRjbmtXcUorME9DdVVPeEtYbFkwb05qZ1NKOTFlcnZOeUJt?=
 =?utf-8?B?MlhZTHMxKy9zMGZVbWk3L0FvSENrTVY4VHlnYjN1Uzh4SjJSek5vcDlianBK?=
 =?utf-8?B?Myt4d21jYVBTUnY2MGFqTjJaYmxZR3ZKSXhUOEZuNkluV0pTK2dwRXNkWUdn?=
 =?utf-8?B?eGlHQ21xVEJwY0NvM2xDalRNN2NQVWd4dnZCV29DSkJrOUQzalpLUnE4amhk?=
 =?utf-8?B?V1lxRU1jOWZoWFlsb3U3WWxGcWxEZjhoNzQwNlZ2SXk1L0ViUmdJUFhRNnNu?=
 =?utf-8?B?TmJEYlVYTWR4RjNqQ1ViL01CSE5zTWFIdVg3V3BEMEtIWXowZU1lY1BuMUwx?=
 =?utf-8?B?UnA3dGc0TklISzg4QnFTVW9uS1NZQm9mVVFYUWpFOWROb2NNL2pHNVdKeVMx?=
 =?utf-8?B?U0UwbDJIZ2pOZjdXcFY4VmxuQUc1djlocTdMejNVWnB2WHNGVms3NjBPdktV?=
 =?utf-8?B?TXdweVJZVkxUR0xiRG9nU2FnU3A3dHRaa29DYVpWZnZBN3h6YUJmZWhnRkMv?=
 =?utf-8?B?YjNmTGlaT1VFYXVTbHFOK01qVERRdldCUWlZYkVRWWhLNlNMZ3FyMGxuNnBM?=
 =?utf-8?B?V2tPai9mdUdhODlIMjloNWtQOUcwYnhjYlBoWU5sK1pIWHZ4MEhpb0ZWeSs1?=
 =?utf-8?B?dEMvek94b2Y2cTFuSFdKL0c2TjAwcmttQzdzK1U4aHJucTBPNXBBRXZ2WFdy?=
 =?utf-8?B?M1pBdndqRU12Qy9YelhpSlhRNEtiSUE4OE94b2ZaM0NxZll6OHRWYTB4dUxN?=
 =?utf-8?B?MWNHemFCVHI0MFRTQmlJM013M2ljazB4VlZPYVFja3ljSzJwRUwydjliSi8z?=
 =?utf-8?B?d2pqOUhwZUl2dUdqdnhiRFlHYnVobURlcWFKRHg4YThneG5yRjBqQzRtN2Y3?=
 =?utf-8?B?a2RTTGE0SXE2YzdvSWVLU1hOV0VOMVZwWnVNTGY5VDJHa2t0T1FPRUtzSzNr?=
 =?utf-8?B?ZVhseW5oMFZ4ancxbUhoYXhJZmdlZjlxNElFQUhDT2ZTcVlJRW1QeHB1YThR?=
 =?utf-8?B?Uzh5RVpzZi9ud3l4Q3RhNEZvMm1JbDF0anpkMFduNWhQWVViVmZ0RUZMNjdw?=
 =?utf-8?B?UGlpakptYXd6VEo4cThtMVFuNFRmTjc0WnMxZzM1VW5SK1d3aWRrQ0tjYmJp?=
 =?utf-8?B?ZzFqUzdxRVUyRWREN0I0cDdxbWFTZUppckMyZ2hYMnNwQ0EwOXhYZWp1VXFD?=
 =?utf-8?B?NC83WUpINzNCMFFkeWxTQ2k3cHVMZGtmL0FGYlJtMUZoOVZDMkVLcFAwVkN3?=
 =?utf-8?B?VFhJcFhhTlBjQml2RGlKRDE3Zld0czZ4OWo2dC90dmthcUdPd3Jwall6cStH?=
 =?utf-8?B?dXIxb3JsaEN5NmJ3S3BTWUpOWTdoeFB2cXhVZkZZU21lZFpseUN3L04rTllW?=
 =?utf-8?B?dWkzT1QrenFCQlYxeGJ0MzJSMjhBa1I0YzhMc1hHbkh5V2hJaDZhMmNabVU1?=
 =?utf-8?B?TThNVHFZWk9rdXcvNTBIZVBGV0lFazBvTXhEeEwwOXZsajlqQU5LN0F6UzhF?=
 =?utf-8?B?cmNjOTNmanZDQnZZb3dDVTgwWFhrOEhQMFFNY1FUM0RUU0NxVlNxWkVldWtS?=
 =?utf-8?B?N1kvbklBOUJhcXB3c0kyb1h0T2RXZ2tIa25UVFVGTzJJcHVybzkycCtJSklZ?=
 =?utf-8?B?YW5sdU9kS0NRMnpzb3NVTmlidFhOWkpsd0YrTE11N3RIdGVsclNBNzl5Yk9l?=
 =?utf-8?B?K1MxTllYY082aDlsMFpkY2dBbVFkVGdrTElKeVU5WFFkQkM4VUxKbEhhNmJU?=
 =?utf-8?B?MW5jRlZzdElGbW5WMmhEWEswRmN2d2JJNXcyeUJYdU9jUnEzdHdmUG9idS9T?=
 =?utf-8?B?ZFhnT05PZ1Q0ODhaN0N5UVJEUStHc3kvTUp3dUdQVEtpOFkxajlvbUIvRXdh?=
 =?utf-8?B?a0V4VFZPSlhjandtODQzUnc1WGE1MGFPVUNRbFdydGMrbVJoNUg5WFBDNjls?=
 =?utf-8?B?VmtSa2dBQTZJS29hYzFXV0Ivc2J4cGpWd0hnQW1UWWZuRitjOTA3NmZMVU5k?=
 =?utf-8?B?SjZta1VycFFxM2V6MnQ4S29qdThFdTRRZG5LdnYydEdueXN3VU9DUko5QXI4?=
 =?utf-8?Q?HcEii9rieK2NXVnoZBSy7KvQqu6u89rIaEQqA?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b0e1ffd-dd4a-496f-679c-08def4bd8570
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2026 19:53:15.9751
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UB4PfL8FhwJwBwi6rQyUpV8dfGjSP9sJoJb6vBdc/pnJqoD8NDTJk66f962Y0P3X9dvsenSmRyF1JJw/Kq4cLz4cpRjfNtWVRIREK18nTT/Y5cTbNkQIGHhlyjc31070
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8247

From: Frank Li <Frank.Li@nxp.com>


On Mon, 13 Jul 2026 10:34:31 +0800, Sherry Sun (OSS) wrote:
> From: Sherry Sun <sherry.sun@nxp.com>
>
> This series adds support for NXP Wi-Fi/BT combo chips (88W9098, AW693)
> inserted into PCIe M.2 Key E connectors on i.MX95-19x19-EVK boards.
>
> For M.2 cards that rely on PCIe L2 link state and wake-up mechanisms, the
> card must remain powered during suspend. Patch #2 uses the existing
> dw_pcie_rp::skip_pwrctrl_off flag to skip power-off during suspend and skip
> power-on during the init path.
>
> [...]

Applied to imx/dt64-intend, thanks!

[4/4] arm64: dts: imx95-19x19-evk: Describe the PCIe M.2 Key E connector
      commit: 825817212686334aa7c3c04d6e2797647ef7fa6e

Best regards,
--
Frank Li <Frank.Li@nxp.com>
