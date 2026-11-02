Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.72.57
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793635408;
	b=UTP4wrYMTGINcCxHMMjm1juOEK0LnRgpTvXkXKhHjzzeWy2texSSLYfL7mdrIk0us/ay
	 p/3HwBOTtzc7BOc4QR7MY9x0kH+mrDybh0uKU2RH5vPCH3JZMCVvD8adyPU2e90c1wW6W
	 nE7GH+Um3YqhuaHqQLS5LUCkSP6EeODkBziElVFJf/7puHOr2flPM2TycCpe7ahvKdiUT
	 JX53bOzBj5HJoh20Qvzpen26gEN0iM9aLS71ioQxcRoNaZR2knh4d3RAS8Yl/fSpH+5xy
	 plREuuqwABVTTIdDXMp6PPNRpIkC4j6++8xPS7epqdE4Cl6rTuaw0B4g31tPlVNAbZw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793635408;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=RtLtovAMjK4LgmxpVt6qcq4UU9uOugZcz/ZHNbVhN6g=;
	b=deS1zEy1BJHqYs7AkyAb1I3RP7WVq46FrWPhcGq1Myr1JhN31Vz3fLJFKLkbSdVCeTi1
	 KzPv5dVe9Apus3UFjnHdv4PgyoBW/krVzSJ3c1DdpFJtpmS43fBIubyia5qy2ytw3Ik7B
	 aV8AHw6KNzaAMdWc/me0g8/sa03seK/ad4R577s57deO+milBbxGAzNLP7uroQ+jtsCtJ
	 dWxGusTyt3itgvm/kLt0O6NqyqqO2l3K8b0nVeyWlTtmYBT0/3sOXz6ZL4Xb1LOSgWo1e
	 E7934tUTrBj0Rg35cSC7ZbHtqEc3IgGnTNKsl2vmO9hLYyuwKSSohxtFzNwOgqu32UQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=adDOPRTX;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.72.57
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013057.outbound.protection.outlook.com [52.101.72.57])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F042606C557;
	Mon,  2 Nov 2026 16:03:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4F042606C557
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=adDOPRTX
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ols2knZSLI2h1/VY0GrOd7l4u4/iVIwU/bHwUAKOebzqJxuJEIAe/9mlZJiHR7+z4P4G0EoJ+PO44a0OKBupwmMYuHaHldw95ci+hSyGtM1TIe1FcqliJ84HzxXkzQ3XPb2BSN+25sSYtI6JjFS7ReNCsgjdK2HhOU9VtYsUE7xrD6Hx+GtFqrg6fb2oCizWG9JsB/KQfjJvD2S1YYVucE1qA3H79hCLwnccEzn7gyj2iug0OYA6KMXV+w29UgucCod129uArUUJxLfgQmAi4ASUp0O3nLGas3mkKAjE/uee6q3njKq8lCZgcK0mangKIHhUueyuRfVrnsOIOjOF/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RtLtovAMjK4LgmxpVt6qcq4UU9uOugZcz/ZHNbVhN6g=;
 b=zABnAnafgqS/d4k0XBXYNgpxxn7IoEyT+fRdS8TqZXozawzA6QBtfMSEsMnntwFY7LSs4WLWxgb6CgMTXTCZkcbw3Lh1EjWJl7LdhL2f95ntgu/STYR/fYM2DLnEr7hDUhd60UrYPMXirkd3K9yxDCWJqpwkvL2SU6g7tNLfVEqmulUyeRDPEQh4SHSu+N+A6dBEKbMauksiPWhgLzYaQJibfYJw3KUSM78hUkwWf2CWKAqSOYuplwcGAjaEh24o1lc5em7f0xQSydS9CkrsLTlVzWgqvBh9EPcG9Kit+ScxJdF14c0CHUWKhvZJP69R1A35HkBArxHbGxIAI6Cpqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RtLtovAMjK4LgmxpVt6qcq4UU9uOugZcz/ZHNbVhN6g=;
 b=adDOPRTXZ9FTE0JRI0K4pNIGp4yE1e7KgS3qSVJDjKOQ6kK12SuD788E7A+psPBnWf5o1IoUDhvxp/TChRuaNtf5GglHbE1ITnYkZZpHGcJeGqr9yEn2SBq+EGeSZOtBxjfWt0RaK9yZnGgh1eT1gnBI/VWRZKbgofc/nkywXvYufFW+6M3eUbV8P5pwsxkzve/fYk8sCKYdSeoSGgvGprHMgkoGN8qFphU0Qwy50+byPw5jOqGUM2eU3al+JOyy600UssH+h9zNOUshp3xdYOP0tc7WWx/rMWzBIuA6kBUbixTJMbi9TyplbwwE/2ZBMWVWsxKrV/S6/uwpEvh6tQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by GV1PR04MB10332.eurprd04.prod.outlook.com (2603:10a6:150:1ca::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 16:03:23 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%6]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 16:03:23 +0000
Date: Mon, 2 Nov 2026 10:03:14 -0600
From: Frank Li <Frank.li@oss.nxp.com>
To: Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc: mani@kernel.org, kwilczynski@kernel.org, linux-pci@vger.kernel.org,
	kishon@kernel.org, Frank.Li@kernel.org, bhelgaas@google.com,
	cassel@kernel.org, den@valinux.co.jp, thierry.reding@kernel.org,
	jonathanh@nvidia.com, vidyas@nvidia.com,
	linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] PCI: endpoint: Skip upper halves of 64-bit BARs
 during search
Message-ID: <aui0QhcA4iq7J5tY@SMW015318>
References: <20261102112306.4018464-1-mmaddireddy@nvidia.com>
 <20261102112306.4018464-2-mmaddireddy@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261102112306.4018464-2-mmaddireddy@nvidia.com>
X-ClientProxiedBy: DS1P221CA0027.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:8:242::11) To MI3PR04MB12438.eurprd04.prod.outlook.com
 (2603:10a6:290:76::14)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|GV1PR04MB10332:EE_
X-MS-Office365-Filtering-Correlation-Id: d3b0452e-e426-458d-ec7d-08df38fad28c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|7416014|376014|23010399003|1800799024|6133799003|10067099003|22082099003|261102123227099003|18002099003|3023799007|56012099006|11063799006|4143699003|261022105027099003|261021123027099003|261021121427099003|261026140227099003|261026121527099003|261009223027099003|261028144727099003;
X-Microsoft-Antispam-Message-Info:
	Woc7USpNI5IPzDVNc6OqVn8PNjqrVDQFT2tucA0sAf6pw3ehvrFC0yMAEDYloqRSTnAlKdLHILai0xTQCtmQTyPByrJUXKfKzGs9oW5mMwBLvSWHqYOiCSqwMdikn7xRQPiDjIPqdE6Uw9mlksvIRc8M+s7bflY2mc6TxqYM7BH3zoDLYLoDHMeO7H2qaTiAI5TfpxkDii4A7Xiq1dVzzesE8aVDiKWHfl8ojeqfmuaKARvhYt0eSqcXN0/W2XThiq3g7Z8kQUJe/Ldcma3fSsN2RTYuU1BxrAHAYs9a7d650zXdgkp3O/scj1881wsLyFwp7s4Rh75eECl5kDOwHvngqNU5JSJziqHmEQST32DyLJZK5fOKSHct1yNLqcbUO8jsJTVQDVNn5DK+h6tdukHvCTy12PCc2o88RRVAQdCx1jqLs911/CjcRNuX8a1ElTLKSKLoSpno+mcf4sBhIG0ycBA4WzG4NAVICuOrTB99T+pfrRmrF6iVtt0llTSeDe5kcABw1wdt73ZcpM+CF68UHs3lfJey4x+VkcyahZYDfGQHTCe7wyRSthx4v7fLNUays4N5izwU1bfEYmZZP0RS6EClw5ksMPzFQrY1eCLQI0N4bkBht/sWtaeXdXkUvU5zVMkgcbnFJSCXJdzGLl4axsPWP5ULeNDVFeeXA2U=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(7416014)(376014)(23010399003)(1800799024)(6133799003)(10067099003)(22082099003)(261102123227099003)(18002099003)(3023799007)(56012099006)(11063799006)(4143699003)(261022105027099003)(261021123027099003)(261021121427099003)(261026140227099003)(261026121527099003)(261009223027099003)(261028144727099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7uz3Gb8AWKHpjkq7pRf7axccq3NgE3gBJnbbe+I1pkNXK09bIRW3Rz53KIgd?=
 =?us-ascii?Q?KoH5N3/9owMp63wLwLOzu9o7XF0kAfV6JgshRsq89V/3fNuybpYey4pl6YIj?=
 =?us-ascii?Q?MByJuD70OpUt62FZAQw0QVDnX85hSUVOkhz/8QcNppIvQZMWkjD9XzsjP6xV?=
 =?us-ascii?Q?JNfZlaYBVBfLaUo0V9lZUjxs4A3hAL6bnuxZVP6jvxd7Crn6wJvwny5QGNlf?=
 =?us-ascii?Q?rZC3jb41sfKBeeTbTpu6km+VHEM90/XYyGrlD5Ocw2Gnz5jaBn+1TcOoUKuL?=
 =?us-ascii?Q?8wVgw3ZLvfLPn0wbNW04Tkllcq3T5RdDQW/5cDouiz94jcq+SXN1UVFuynly?=
 =?us-ascii?Q?nVp8sBzl3+zbo55Hwns0ogmEYar2blOfV0j4zu6/ulS6GsMy8Kw6l1YTupaU?=
 =?us-ascii?Q?ZoK+MDPDS2L4U8Fm8nC8wP4NC0qGy5xE8CCIc0JOx36j5IO8PNHRQ5n4r3xw?=
 =?us-ascii?Q?sM+TF30zpTsj182sySMFGAA4gwke0FPw828bE7wWr1g4UElPnfTz7kGrUf+p?=
 =?us-ascii?Q?rTpY7bg/aaWCMZ0CFpq6U2wbJO5Il2YFW5b0gwVFHM/KYrFpzBWh5EAsnT/Z?=
 =?us-ascii?Q?QsF/iI9mQDJ60sp6+pBpvgJk8PYhjYLk1DIsdFE7ZXB8gZ12aJI1lThHnpxV?=
 =?us-ascii?Q?aTU0USSMuJ+hi3fYHh048gk8qnI3Zpt3uIGKaVonHbYTMVL82xiDWboewUIi?=
 =?us-ascii?Q?jpaiP5dFjv/osZ9IvrDnOs6mNTzw6/kwVv6q+3PVBAqaGXidmVo/EoAUflAE?=
 =?us-ascii?Q?6nVXfgixObzfDTK2rZ7JsPj6Zn5Qxhh5/rLVyM42h3EnWjIb5zuqKobHu6QD?=
 =?us-ascii?Q?pJUomn1poKW3SAASaXHY5b2+n4ZNSNTi7iaaabVCbfHrJCEu0igZVmRUZmCf?=
 =?us-ascii?Q?xnbol7abCSojGoxOwPSGgCUAKCLTobGE6RMvxdSgkjH8n2I1EftpJNftFW59?=
 =?us-ascii?Q?IHp36gySyTx39pOooMz6rIPlpgmxXOHTOVM4H+AGdi6EmRZOeBrY6yUJsl04?=
 =?us-ascii?Q?T25pNrDfyqXNhuEZMjnR5Lfa1ApNcYE8D+4sUBGACaP8/nBrtihrA0HeCPDu?=
 =?us-ascii?Q?RpqmqaRU+YNEZCaRBgfih5/4QgkRDGe6Mklz7roc2enBW0u7vcMTQkBqPfx7?=
 =?us-ascii?Q?gX3JKkSBdRZI7967VjdxiW8fbQDryOGPXpAqRhFXe2S93Ra/CwfhVfALdUhT?=
 =?us-ascii?Q?mELsOqmJ5vjxzvsjh+0gUs/I2tTmYGV3q4VzR5LCxdEgkyB5sRPuy8sIKfYu?=
 =?us-ascii?Q?g+aePusG1dZEzxe6x/AugMjIIVCftMl25mDnCXEYfmjdW4gHgjpE5VnOLLCz?=
 =?us-ascii?Q?9B2pfvpENHVmdorM5J9OKjLoZet9a32fDMaVPRx85FlJS0r+CBKE+myNOMEQ?=
 =?us-ascii?Q?cQKbihpf6QsYaPx4VHw9O1OQQdP3BYXcChYotR9ExE/IgPhOaKmZMU+Z2PjI?=
 =?us-ascii?Q?mHegCpjWEg2PjDz40yAhh/uSNhQnjyU6GTse01v88sb/FkYjDkSIl0m43ZUQ?=
 =?us-ascii?Q?JQ61cnJQy0607l+ZlC8paFyWItIfnPxQm7wVn+0GhqY3gvPeYlY+TUz82wkM?=
 =?us-ascii?Q?K0fODznxTfSXrWWg03hUBuNmIWNO5k9uxOJM8rnCryG9Wgxy++72RKGrfjCi?=
 =?us-ascii?Q?++nzjTYVT17ORgPYEUsgnGkeAQD+N5mXqn+tff2n2rmUPVo2Fx1dYlhgabK9?=
 =?us-ascii?Q?nUX1ffySofW/YLNvZ8B9BMby9VdqJD3BF1maAONeHWT+Hlha6HsBVLpG4o+W?=
 =?us-ascii?Q?ds1J6Goin6XsCp1COANEeDiDvrmW2G0264NI3YED9LRybB6gQLzz?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3b0452e-e426-458d-ec7d-08df38fad28c
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 16:03:23.7683
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U70rFnWa3gFk+pp9ql18jYYkzlzLe8xj1hHJxDUt8WEFtb+1zlCtWXfF4d8Xs1+kZ6tXz9ZiWeyrBlwReBi9JldCuqronuNbYZrVoI+evmX+2yGTRvWZDopIyJCiQXX7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10332

On Mon, Nov 02, 2026 at 04:53:05PM +0530, Manikanta Maddireddy wrote:
> pci_epc_get_next_free_bar() skips the upper half of a 64-bit BAR only
> when it is the starting BAR. If the search subsequently passes a
> reserved or disabled 64-bit BAR, it can return its upper half as an
> independent BAR because that slot has a default programmable descriptor.
>
> For example, Tegra exposes a programmable 64-bit BAR0 and reserved
> 64-bit BAR2 and BAR4. A search starting at BAR1 skips BAR1 and BAR2,
> then incorrectly returns BAR3. The next search can similarly return
> BAR5, causing the EPF test driver to allocate and program BARs that
> belong to the reserved hardware windows.
>
> Check each candidate's preceding descriptor inside the search loop so
> upper halves are skipped throughout the search. With the Tegra layout,
> BAR0 is the only available BAR and subsequent searches return NO_BAR.
>
> Fixes: 27ce1d8ecb9b ("PCI: endpoint: Allow only_64bit on BAR_RESERVED")
> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> Changes V1 -> V2:
> - Add Fixes: 27ce1d8ecb9b ("PCI: endpoint: Allow only_64bit on BAR_RESERVED")
>   following Niklas Cassel's review.
> - Rebase onto the current PCI main-based patch stack.
> - No code changes from v1.
>
>  drivers/pci/endpoint/pci-epc-core.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
> index 831b40458dcd..8d0df9fc1df9 100644
> --- a/drivers/pci/endpoint/pci-epc-core.c
> +++ b/drivers/pci/endpoint/pci-epc-core.c
> @@ -98,11 +98,11 @@ enum pci_barno pci_epc_get_next_free_bar(const struct pci_epc_features
>  	if (!epc_features)
>  		return BAR_0;
>
> -	/* If 'bar - 1' is a 64-bit BAR, move to the next BAR */
> -	if (bar > 0 && epc_features->bar[bar - 1].only_64bit)
> -		bar++;
> -
>  	for (i = bar; i < PCI_STD_NUM_BARS; i++) {
> +		/* Skip the upper half of a 64-bit BAR. */
> +		if (i > 0 && epc_features->bar[i - 1].only_64bit)
> +			continue;
> +
>  		/* If the BAR is not reserved or disabled, return it. */
>  		if (epc_features->bar[i].type != BAR_RESERVED &&
>  		    epc_features->bar[i].type != BAR_DISABLED)
> --
> 2.34.1
>
