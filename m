Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013067.outbound.protection.outlook.com [40.107.201.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D4AF279329;
	Wed, 25 Mar 2026 02:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774405732; cv=fail; b=KjQLHlk21tDMKcRBA2ewD843Vsfvg8vMY5+thlen90ImWPFGmjA9qdK3K2DW8DEYe9RChfLQ0/M+raMqtG1XJXDDqRHoyi008cbHrldVYo+XQJSI+0RBNFc4E4MTgQ39LpvHQoMVDNHXi2SF4AnPB+caAI6BfP0EfKG5tuj/GD8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774405732; c=relaxed/simple;
	bh=O32d8pHMh2kU68VDbA6hJfVQIU4RkUd4IZzsDoURSLs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XDu8KsgDT1oGd9cKO0/stqEFWhV0GOEipdHU3ZJg9ecQ66oP+XXoBTSLTELFYhAOFom+dkr0ar5bGXZzMPZv2JczVHd7AR88S9Hf7EUcu36w57oqZaNyWikLaaUXUC6SnnyjLiOGyAMNl1ZSIc0B3g679L7q+y2YNWxe+DRjrbY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=X0cG5Dp7; arc=fail smtp.client-ip=40.107.201.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="X0cG5Dp7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jFLyM3nbC3wgP82N4dKrpJSVKTbtoZ/4gL4yuo/9O1cCbD5okGG8jVsf0WCl3egEkszlo9DgrTd8zleSs5+XPJ5hhXlwy1oin9LQdYSY6k5Cmri/ar3G5vj19yzmSu103hL/zPHNCUYdWLXCGeXXR4J3WHdryUrgIFp/WoIhsF+bVkkzcTazSDvFgVZQh2gf4bx6ACulXJnba9GtBg+uJ/jzOZKAebBTENOA3gN0I4DiioDUJLspCpPG7WCQbW2jvHiGQ8+PhBAHGFh2zEUEPOtBkPY4q+uKtvGALrjet3xsuWlWN41WMvnLam7t8/48HZLmV8gKu2JVQBDxZUiwGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l58JxM4xHdybqGvLoTYBgSCY8HZWGbd1GSKB+m1Xig4=;
 b=cpCfpyimpT0jv9yyuzUUnP+1puZ1vGiRpwYVskIbm83h8UIQtAxmWPFkg820uR87yonFoc6slxlTDc0Y06IbwgL0JwZSEozt3g+UhPNpi8UKFtbzIOD1jegXhlR3b23L3ieibpQ9TSW2Gza+bJkwEUXweSgY2Rgmft6dj5ZGNeCV24V/MHtxNLqlYNVdDK4hU1qAzJzhXOn1H5YPGl/CS0F0YRoC4hg9KXcMdBliFgMEiQi5uiLbwTx0PeN2dCjYIKIfsXy+sRtEvEcCb81AzsYu8M3nkB+mPFrWJDTlQEiJxeYnuWViJvCbF/obiGCaC306ZOz/Hhjg0fND5WOWXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l58JxM4xHdybqGvLoTYBgSCY8HZWGbd1GSKB+m1Xig4=;
 b=X0cG5Dp7zX5sTcDCLCHTkGQ6EdkcPQ9frQcqZ1oFhixURHcYIv+yUKFXXUAblF81N0MPY/cZqvNtZ8/ZWrO17AfFiEI6ffPiRRT6VzMEJaVakJec5eq91PcstnzvgzdscpB7J/6+EZS7YTPp7osPhbhwoXvcviQ5tWNPjLys5FYBHdIuD5oUyLKgZDDMPEUMPdqWcz9ks5vyOlN9YyAFviZ72IOHv3vaM0MmtyHK6eEGdRG66pFXxZAbyjSeoNvDSVjQqOFJOMH+JW0mNt9Us8iiqv6kOm85J+Q1E+Wscmn8FSQ8wqW1MAUpWA7cBjlPWzgcXDQWWZwUZNe9TNRrcQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by DS0PR12MB8042.namprd12.prod.outlook.com (2603:10b6:8:141::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 02:28:46 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%4]) with mapi id 15.20.9745.019; Wed, 25 Mar 2026
 02:28:46 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
To: Thierry Reding <thierry.reding@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Krzysztof =?UTF-8?B?V2lsY3p5xYRza2k=?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Thierry Reding <thierry.reding@kernel.org>
Cc: Jon Hunter <jonathanh@nvidia.com>, linux-pci@vger.kernel.org,
 devicetree@vger.kernel.org, linux-tegra@vger.kernel.org
Subject:
 Re: [PATCH v2 2/5] firmware: tegra: bpmp: Add tegra_bpmp_get_with_id()
 function
Date: Wed, 25 Mar 2026 11:28:41 +0900
Message-ID: <24777801.6Emhk5qWAg@senjougahara>
In-Reply-To: <20260320225443.2571920-3-thierry.reding@kernel.org>
References:
 <20260320225443.2571920-1-thierry.reding@kernel.org>
 <20260320225443.2571920-3-thierry.reding@kernel.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-ClientProxiedBy: TP0P295CA0046.TWNP295.PROD.OUTLOOK.COM (2603:1096:910:3::9)
 To SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|DS0PR12MB8042:EE_
X-MS-Office365-Filtering-Correlation-Id: dbd39a7f-78a3-4e95-6907-08de8a163db1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|10070799003|1800799024|366016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Y/XMMXgIZW8/4kTYiQJe6H2PTROyoulrQtpdk6yOqk+MxakzeP7/LMSGdFllolnsamVvKvwZnmdIAJuKqhVYsNktdrUNGFfZQULWj2uiOABvbnScOWPbKLBdlgbvg4SUqtCSCsPLN6Z/C0AY42PsGZMCak/oT7JilHW/z4ZMAclMNcFIEy+tJWcijpLu6aO9VRrR97cs+SnxZQIuz/LKoRDVcqvXL70fdLWfkSOpsgaJM31rJg64aXPCZ6zYYuMLTEZw6Ynq14lmGavZNDK3bAZLOM6FxiL/Ie/iQZthh/L0SeASLqi/vako7LSjX9rpMqZDp+P/H0UoAINSw54EkQOIvGvhl2ylWuodS4FP3mGVMHA+/ZpAd/fV7yGMYDqs+DImURsJHvcGGDCaN3Tss7Uipf+bnM7WxkNX9nf3Xk928jAh4iritMmlE8kDgf9xkYjQ661hapKi+2x1kg2rHuSBG93IoDSf5eFjHIi9v1dHTvQkOekCuKk4h6PF3ANVO/z3jl5JU7es6woKDsTF5xOHsMFVHZHDswFCqPa9ytc6gDSbu07R4fC+PKE9xmetktyJRYDCzeipuJREn2YIWig3TE6VWhcvqwmEZR/uGVIIKrBEw1iJ+CRM8WyXlrwofzpLq2CMTnLlGsSuw72KpRrkNsfCWkSMDZSQc3uaDZTmlFYcScIphtx4j+9jeKX8t+nIZXIr6iDRccPCDDjJctgS+HDRmcg6X6do1fMn9lI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB9161.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(10070799003)(1800799024)(366016)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WlpvSmgzZ2hnQzN0bTdLZzNVcVM1MDBmMEk0NldBUnphREMxVFpnN0J0V09M?=
 =?utf-8?B?OHpwWXpPMWJweTVXa0N4Q3cyUlZtZ012NzNxcVFaSmpETnV6aFpXbVI3YmRj?=
 =?utf-8?B?S0h2Nk1qczJQdDdsWUtGWGJBRytYSTJmOFRTQVRML3B6YWxWa3JiWFl5ai83?=
 =?utf-8?B?dWVCUExVZFViNVRYTmFOdDUrbytXWVVtVUhPYVA2TVJveElWZDJlcUdoWXo3?=
 =?utf-8?B?bEFSd2RKNm12VUxwMzMvcGEyc3RSUXhkeGE5KzlZUDYxcEFScmo2VjA4RFpu?=
 =?utf-8?B?WnRaaG1oRnNEQm42d0NTSk1kN3EwcEVyZ3k3d0c2anorL0pRUVpzY2ZwQVh4?=
 =?utf-8?B?Rkc1dkFxdmUxZ3FtTkNsN000N1AwZFg2YkFZV0RWaHYwS2NIeWlLWUQ3L21S?=
 =?utf-8?B?VlQ0L08vWUJCelY5bC91dGxLUmZ5ZzV5OUxxbnBhSHNkOEV4WXZKR2huL05Y?=
 =?utf-8?B?d2Eza1RsN2toSlp1dDhmcUEvOXhMdGxFTHFPdkNMdFlnZDh5RG5xZm9FQTZW?=
 =?utf-8?B?VVAyZ3lsYWxraFZodlNIRnJaNVVzdTlkWEs3UG1DNGNrbGQwblF6Q1U3dG5z?=
 =?utf-8?B?UlhkN2ZHK25hbzlsdlFBcm95TU9lYkIvRjcvTmErbWJiNVNwYUJrZG9nVFNN?=
 =?utf-8?B?MWRsR2RSMTRjWG9OdFp2VjlLcGtlOGY0WkRiSjltNm5zSkFtaFdqT2RiWDF3?=
 =?utf-8?B?TkY0RWNHN0xwRzB1LzBlTkxUcXRaUGNQUUtRNW0vN2swb0VNektFSFR3NUho?=
 =?utf-8?B?RURIUThnZnVIWUJaaFdrUklSYkp0eGpTMyt4a3k3ejA3OFE5cWIvY2E0eUZn?=
 =?utf-8?B?blp6Z09DR2FkU0lId1hORmVDU1M0cU4rSDVYV2o3aXAxY1g5dkV0QjV0ajFB?=
 =?utf-8?B?U0NUL0lidXhVaXBob3RvdlBVeWxnT0Z1TEhObGdheTN1MkdXa3Z2R1FNSkY4?=
 =?utf-8?B?YmJpcGQ1RXczbXgxRWlxUXBxOTlKZWs1aXVZeGJtd3AxbE5acENiYlZiUVU0?=
 =?utf-8?B?eHVZZE5iUThJNWZRUWNDdmQzQkNYODlhQmN4TERjeXg3dDBscXRZY1VOeTQw?=
 =?utf-8?B?cTFuWm5zTW01TURzUC90WDJuQlFKUTdqbmQrQ2E1WEx3U3N3TS85MkRjT2Rl?=
 =?utf-8?B?N0Erc21KOXRMYk4rSmh3R2tMK1dRQ1hpbEV4QSt5czhIcmI0RXorY2Q0ekta?=
 =?utf-8?B?NEZVYkcxT3pmaXI2cUFpaVhOWjN0RjJjNGlkbFJoRE9GcVpSVFl2ZDlSYlpp?=
 =?utf-8?B?WUk2R0tteDFLZ3BNYktHMDNITjVucnFRY0hvSktnYmlMNkliNXZTcEpudm9W?=
 =?utf-8?B?dEdveThHcExnNzRkeE5LbTNKbTEzZUN0L3BqajR3alk3RE9ieDk3RDkvR1hq?=
 =?utf-8?B?aFg4c3FISENRVDk4a2lSS1lGam5Od2JvUlpiNU1DK3BYOGNrdGdrUGprZGZl?=
 =?utf-8?B?QjRsakF4bGZBZFRmNUl1dHZLOS9zWURONWZhY1lmSFlmVzZEek5zb2VRSlNK?=
 =?utf-8?B?b2R1Z2R3c0Q3dnFzNmxwbjE3V2dDdE1PcXprdm9tenpvNWlYRDgvRmpZK3Bm?=
 =?utf-8?B?VW9kZlpHUmliUkY5YWhNSEd1aFF5SDU2MjR0OFlMWWVVZDJSdWxXTnphZ2s1?=
 =?utf-8?B?dXRjYzdTdUVMRDRWYzdvQmxvbFg0bll1QWRhRmpVRUp1bTk1WVhVT3pZbEo0?=
 =?utf-8?B?UVlQWGM1VzMxUnhVUDVyY2ZlbEdyRUlrbzJ2U1hIYWtBeWhKaWVRL3V6OFVa?=
 =?utf-8?B?U3RFWCtPSmZ4OWloVVRkU3hyUWlJdUQzSWRhOVpqaUV4QTQxVHp2VitRVTg1?=
 =?utf-8?B?SSt3VDZNYkVOcTNrMDB5c3lKMDFXNUF5U1REb21XclJsa2RQM2M1YWg5OGxs?=
 =?utf-8?B?VkNrMVRtckJyWUdWM094aVFudWVIOE9iQU5vOGpsYVJVWnU1N0lMSTdVcDNk?=
 =?utf-8?B?QjZDaSt1b3RKOW9OVUVNRzNIaEszV00zMUIrdDF6SE5tYVlscTBGK0NMQUlB?=
 =?utf-8?B?MmtSK3UvcG5JTGU5WUtsV1FURFUxdk1RSk5TZmp2Y3R1Q0dRRGRvVnZWeXc1?=
 =?utf-8?B?OER6L2VDRjJicXJVTW00V01jakFMYkEyTFFldWFBVXIrTXIraXF6dVFDazlw?=
 =?utf-8?B?STg5RWRNSFF1L3MxejgzN2l6UGNUOEU2OVhlU0NKTlBmeE16ZTQwbzNrSkhu?=
 =?utf-8?B?SGFuN3hJL3JCbjdrMFE3Q1pmcHJUMTJpWlAyejZNbXEvZ1c5OXNpUlFzRU1t?=
 =?utf-8?B?bXN3UUttZHA5MkxaMW1zZGZmRmhZV3lqeVA4d0lsTkxMNllPcFg5KzJGRmdj?=
 =?utf-8?B?UDNrdWNpWnNpV0RJcDcvNWozZUVvRVlWMXQ4cWRVVHZsNXFJbEZuZ2l3c0lO?=
 =?utf-8?Q?ym0gjzSZ9gLs3+YU6qeErewqpsalpodhoghg0uhbNKOso?=
X-MS-Exchange-AntiSpam-MessageData-1: nwRV8B6p31Go0A==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbd39a7f-78a3-4e95-6907-08de8a163db1
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 02:28:46.4577
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XluE2HHB0FEWk7r3WtnwmCzYw6W5zqRzXLbEBzy18ZuzZRFoluwZJAKPg5/Gk6jquoHXCm2edI2Nf3Saep+8bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8042

On Saturday, March 21, 2026 7:54=E2=80=AFAM Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
>=20
> Some device tree bindings need to specify a parameter along with a BPMP
> phandle reference to designate the ID associated with a given controller
> that needs to interoperate with BPMP. Typically this is specified as an
> extra cell in the nvidia,bpmp property, so add a helper to parse this ID
> while resolving the phandle reference.
>=20
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
>  drivers/firmware/tegra/bpmp.c | 34 ++++++++++++++++++++++++++++++++++
>  include/soc/tegra/bpmp.h      |  1 +
>  2 files changed, 35 insertions(+)
>=20
> diff --git a/drivers/firmware/tegra/bpmp.c b/drivers/firmware/tegra/bpmp.=
c
> index e74bba7ccc44..753472b53bd8 100644
> --- a/drivers/firmware/tegra/bpmp.c
> +++ b/drivers/firmware/tegra/bpmp.c
> @@ -32,6 +32,40 @@ channel_to_ops(struct tegra_bpmp_channel *channel)
>  	return bpmp->soc->ops;
>  }
> =20
> +struct tegra_bpmp *tegra_bpmp_get_with_id(struct device *dev, unsigned i=
nt=20
*id)
> +{
> +	struct platform_device *pdev;
> +	struct of_phandle_args args;
> +	struct tegra_bpmp *bpmp;
> +	int err;
> +
> +	err =3D __of_parse_phandle_with_args(dev->of_node, "nvidia,bpmp", NULL,
> +					   1, 0, &args);
> +	if (err < 0)
> +		return ERR_PTR(err);
> +
> +	pdev =3D of_find_device_by_node(args.np);
> +	if (!pdev) {
> +		bpmp =3D ERR_PTR(-ENODEV);
> +		goto put;
> +	}
> +
> +	bpmp =3D platform_get_drvdata(pdev);
> +	if (!bpmp) {
> +		bpmp =3D ERR_PTR(-EPROBE_DEFER);
> +		put_device(&pdev->dev);
> +		goto put;
> +	}
> +
> +	if (id)
> +		*id =3D args.args[0];
> +
> +put:
> +	of_node_put(args.np);
> +	return bpmp;
> +}
> +EXPORT_SYMBOL_GPL(tegra_bpmp_get_with_id);
> +
>  struct tegra_bpmp *tegra_bpmp_get(struct device *dev)
>  {
>  	struct platform_device *pdev;
> diff --git a/include/soc/tegra/bpmp.h b/include/soc/tegra/bpmp.h
> index f5e4ac5b8cce..424188c100d9 100644
> --- a/include/soc/tegra/bpmp.h
> +++ b/include/soc/tegra/bpmp.h
> @@ -127,6 +127,7 @@ struct tegra_bpmp_message {
> =20
>  #if IS_ENABLED(CONFIG_TEGRA_BPMP)
>  struct tegra_bpmp *tegra_bpmp_get(struct device *dev);
> +struct tegra_bpmp *tegra_bpmp_get_with_id(struct device *dev, unsigned i=
nt=20
*id);

Should add a stub function in the #else branch, as well.

>  void tegra_bpmp_put(struct tegra_bpmp *bpmp);
>  int tegra_bpmp_transfer_atomic(struct tegra_bpmp *bpmp,
>  			       struct tegra_bpmp_message *msg);
> --=20
> 2.52.0
>=20
>=20




