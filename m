Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010070.outbound.protection.outlook.com [52.101.69.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 943F53624CF;
	Fri, 27 Mar 2026 16:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774629086; cv=fail; b=TFLEppMFjF+8ar14o06Dto/oe8VlGH6yoksGksl7h86k0SY6L3tAAH0fKslbnqmooRZeBQZbqkoMWPJw/vpm9q0/q7i0iv01pKPUCOCSjqEIxr4R4vt9KmUfuCwYS2C5Qkb1IKsTO3pBPNd7pqC1gS/Ok+fgGMa5QoOnPIWrOSU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774629086; c=relaxed/simple;
	bh=XTmfPMDZDRgK6d7QrwSSkmtoXVb2vQGcZMPbtyK17Gw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EJt+bV3SyK3tEANwEtji3WUp7gnc5MsaK3Amoe/JILRxV6p5nloDolYgglTZdg7aY5XmQIeKwRvc3lESg/ibyEIuW6SpViZbT0WhEDi10EII/fjnMKaBHLYpXbLK27AFOSwnQIq2EErolJcVaEON65dQ7BDw+69tZREk6Lw5oFo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=JH8Mpx9z; arc=fail smtp.client-ip=52.101.69.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="JH8Mpx9z"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TaFkKUGFE7Fn0gGj+MLU+T+VKRibiqWkQtVbcxmjOeHrRVlpMpfq7DnXRgz0d8sbY+T0c/FPGHfFukpLF+WuQ/dWdPD3CiG+4ENhK4UVrCNejnBRp7Np2oDqxaiRGj1FCMIN7s50pvvFyVUzvtl8+GrcqHUy1DFjXJoExe2b/hwg8tn2jAYtTels5BfcvGp94TkwKBGO9yaXqRgIZMp06lp47aE7OrW+w3S0G312oYsNaJclSZqzLBUSaKk5wIRrhWhDDbp15Yd72pY6CmTL4fytAn7T+kTIhZ0vYaFPboQSgAgtrXgzZSOLxSXeqV3ZSJYp+QCSvvTk/G8r8InwgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2U+oNGywaI3L7jnw9GVW16sJ9OLWO2rhn4Z+JP6ce8I=;
 b=R5LxqwsqE6X+XMDjq87hxhoEcSU2w6yQD+F3BJXQlpS/z0cNS8ixy9cFakoklTL+/RzDSRfFS0aU6sMgmC03NP2e2YM/2HS/ppVbazT/sFJvE27T7CUxzrnqQbliVWi71cjsWJYzMM6PqT/I9x2dH8Ugm00iFBpoU+k+yP/9neUKomrdFj9zEbOvKWiUNGtzh/w0RO/AEEY/8SHYETCdBSXbIDCmQl0/9I11MZL/76sF2h9zuaFP0lcQQ1aDNuPhDUaCn294Jm10Kq8fx/ALD+0U+382PGZ6PiVPH5qbN4FK/h9WK0xc1PvANClVR9RsFqELyei6jG+8Divqf94wKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2U+oNGywaI3L7jnw9GVW16sJ9OLWO2rhn4Z+JP6ce8I=;
 b=JH8Mpx9zMJv4op20RdXMnsxtuesW5K6z1eToLu9SbsiTxQQfzNTI6wKUfzitr0SuaKI90lQ1dnA1W7AJanayc4mU9r1b5OD1BfLI8A97SLL0r5tqF1AcdqHQ8An9659/oaWjJHqArhNgYpRdmfkZ/rY2E5OoDAoGDY35Hh+V07T/oEOooRiv3N14nFjeiZq4RfYI3bhSHb/Y3Bd+9c1MAYUKCOAuXomxtUxQzNSa4C6NYpBJX6C5dCvXWB0M5D8Y/r86nlu21j6FsEBLUB3RMJ0RsRv2KmFGPrmV7qnOdS8OOXHZZsQve9F431pRI71GDLP3574GgcjBx2QMeVtGvQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by FRWPR04MB11282.eurprd04.prod.outlook.com (2603:10a6:d10:19e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.22; Fri, 27 Mar
 2026 16:31:18 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9745.023; Fri, 27 Mar 2026
 16:31:18 +0000
Date: Fri, 27 Mar 2026 12:31:09 -0400
From: Frank Li <Frank.li@nxp.com>
To: Koichiro Den <den@valinux.co.jp>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>, Niklas Cassel <cassel@kernel.org>,
	Bhanu Seshu Kumar Valluri <bhanuseshukumar@gmail.com>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Manikanta Maddireddy <mmaddireddy@nvidia.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	ntb@lists.linux.dev
Subject: Re: [PATCH v12 1/7] PCI: endpoint: Add auxiliary resource query API
Message-ID: <acawzbj2s8P95YKi@lizhi-Precision-Tower-5810>
References: <20260327035422.4020455-1-den@valinux.co.jp>
 <20260327035422.4020455-2-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260327035422.4020455-2-den@valinux.co.jp>
X-ClientProxiedBy: PH7P221CA0053.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:33c::22) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|FRWPR04MB11282:EE_
X-MS-Office365-Filtering-Correlation-Id: ce416784-abfe-4516-06b1-08de8c1e45d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|52116014|1800799024|19092799006|18002099003|22082099003|56012099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	Q+S6p8ZiOynjAsvWCDQovGHTwwojpL1OdVruuY1HE/oMerjintiN1vePitGt4AR4J7JSXRN7vdGYQmERpLBoUlOLYgzwgYHFww77VSrsiS7ghlz+lndUMhsZ59rU/G78BsBHldpxsqyReNBSa0VIJVKwJ09Rhu2Q5X57XQHOT3AJVwoZMUYYmkbjHowfZGbo/+P1CU18+iW/Ll7khIRUXfABAQ3C6pieMwhXR1bO3rcY93PcccJ+z3k2JrWp4s9qfL/Rso7xcTQwCfuXObxBklQcmf3RWwzARxVoSsvwzl9P6SlsYUoGHWOIIQfJLY2bjfmskquZ6SqRSbIyMAfvHJjY23aL+0goy/crVHVTNq+IZ7T3DWITbiO4fX+o3PhvuxGl+w9avT8Cx0YoTj4CO1SO0dGdIaP7WHSk9Gm34EwUwweyWSyqxps9SfnIGtcqdcWp1YV7x62PjAQG+kz5do15hO1uSkQvdF18XCYl2rDjmCoLoTDG6P4u2V1zrZCxy2YenhpzY8Gh+O73z43CjRpn6AumqoBHbdMlmBrqWtGjj7/a2Ll7kjuyKmH4iTRsfsp9ucrrl1VLJbXy+kbH9WPMBOkp8ug+ua0d53YqbnhBZhGzbkOes8ElTF3dl1x+yfC22VVvmbsQDhsTY8DuAg3cFT7nUgtahfjjVeRCsKqJyDYpcUFxWmMGepd0CNMMnAn5yO8tgVka/tHj3V5/OJ/VKMezX2eTukrF5Uzs3DgaeXnFkTo8yI/rWLvZewASlaEgSbXB0cB8i0AInaKz84ZaFIXo8uah624K00nvOrE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(52116014)(1800799024)(19092799006)(18002099003)(22082099003)(56012099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ASShniBdLODyL4CgNw13MuR5LsMoqK02yJBU2jUQog7giujdFR0BtLdlMjuh?=
 =?us-ascii?Q?vHrvCEGc0rZlMj8cbP66dE1tXWdJC4xD6+yFnMgT287igfdp0RiATaTel0UH?=
 =?us-ascii?Q?kq6oApCQ/hBC3bDmp7EyPwYE4A5KFzkI11AjWYMh7MlcnYfGGCvVkWSaJlBS?=
 =?us-ascii?Q?6vEfOw0j2mFg8znbc/U2EpABEJkktQoxAmATMCK7sQmhTogVlJS16tn2Kflv?=
 =?us-ascii?Q?14kSULXiSN3G6zCUbDmd40g6QHBuzSWYHcQCc2kehRvGK79NHDwGbp7qxLKL?=
 =?us-ascii?Q?3bYwJhJzYruJtrP3/m8JyecNIPHOz8Bk98lZiM5UVyffM/HlhLeKsyxfkyxL?=
 =?us-ascii?Q?bcFA3/5nmBZsOF0CgNvDeA4joOkd9hnFIPFv7SE8GHv4DM2JSEmaBVM3Ea9R?=
 =?us-ascii?Q?AeEvVloE2zzal/u78756t78WpBbkXemwL4dS2OEL4akkkOabM/I2Oy3pNAYa?=
 =?us-ascii?Q?xzS2yQ50OkDcQM2jIEyK6yo/68k04OJJQ1bdkQ2tIp4iZ16+nvQvsOEJAXug?=
 =?us-ascii?Q?IJ7DNGXgEIpq83MgLHca2QdTqLYassfcn8f17kPTxjdemSYhSDTFpX4AhUPp?=
 =?us-ascii?Q?V9I1lho9how+//uAm6WGo8wFHxB6FN8m0Q/kSSw8jRviya0Jq+C5Wlhq5G4t?=
 =?us-ascii?Q?32RrJYbZL9hlyeWU3Ha+vh3EPCECeVV/wbtjG0R61SCtn/JD6ow+fCgyWOk5?=
 =?us-ascii?Q?EzHNelVwrIEgGJDYCPH7v2vQNnadgLjNqu2fBKSAqBhGa+Z6NSeHn1yW0WJK?=
 =?us-ascii?Q?KTcOU0xhLeVxPFdjYbVZyjZcyrmqIXw9A3r9uYajikC/k/g2LPPiwJGemq8u?=
 =?us-ascii?Q?XAMZgBWu0O6AfLk0qi2s5qGwpH1Hw06awOoIalkBxCZkSkqONK5n7A5Lhc2S?=
 =?us-ascii?Q?bb/lVXJXmlWv1vuJfc7M1+YsH38Md/JmCbtgweKGdpYYXZyCDPaBbiwYuktS?=
 =?us-ascii?Q?l87aRfbekYNygxDs26dvLFHY3VeE+Akgw1hHoItVJ7XIZh94t1D2agHCHojn?=
 =?us-ascii?Q?3wNqiJOLNxNlUR4IQp4F4ZQL/v2aDseeRbeIEKtHLcVSG4i7Rjhz4x9dHP5+?=
 =?us-ascii?Q?eOb+1zqJRc1J1120cjec/Dju7vZUiiI+hiP02uxK7/kEAv7uoWkE6udOSF5d?=
 =?us-ascii?Q?JJImiBYBzPBD+lqdf1E32ifsjEQMkcB4iQ/WpQYZf4JOGrLYucqyMJ5J0HOF?=
 =?us-ascii?Q?THqWUJ6Sg6EatxbImjy3rjurbui0owD7o2ac3mlfi2DEOt7mZWI/nkdhBYum?=
 =?us-ascii?Q?9uZVl2IY+0GjuvbcDOERaerk518CqBSihmUBgEOEfRs2m4jwEX1JTrCdp1CU?=
 =?us-ascii?Q?vqMVOjiqxgBadkXiX1IHIpfz9aQTGthB5sPS8ypWV25pfoliBi9xNZSb2BL/?=
 =?us-ascii?Q?A/oZFg5gaXcJ04GkMmCnbV/EDmDdrxhYRkdek5zDV94JKmhxEtNQqmtS6Kjb?=
 =?us-ascii?Q?T24bmk+gbYfZkuJ9jpZ1I9Oo1BBXAssg6S37UbKMD9fAyjXrwux/ocbbaW7p?=
 =?us-ascii?Q?HR+CNKjDctwPD+p8rjw/H7ieJGGxCihhzu2gLzy7uoTnQq2hsYL7RYZw2kyN?=
 =?us-ascii?Q?MC8wgtmxW3D981D5cxXtJtr91L+XOmZvo/VZGZRewbddrCWkzBn4zs5iuGYk?=
 =?us-ascii?Q?TG7Q04OmZ+L0PXei75TE6HxVhqCx7eHCaw77kgwLmPHmStIB7zjHIic4nPrA?=
 =?us-ascii?Q?0QxsEN0Q6OJ1m4hnGfAMeDXDTQGapzepzJ781LhjGy/WD9oOUuz+FVlB1Mcv?=
 =?us-ascii?Q?e7Y16Tg68Q=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce416784-abfe-4516-06b1-08de8c1e45d1
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2026 16:31:18.2550
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i1Cu220ERxp1Cjt1GUAIsVjjJdroxDP1aKKf8lo6kQwyE8J+Gc3QzrFpkS3aUo09PzLIgu5GIk/9jrDFMMgMlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRWPR04MB11282

On Fri, Mar 27, 2026 at 12:54:16PM +0900, Koichiro Den wrote:
> Endpoint controller drivers may integrate auxiliary blocks (e.g. DMA
> engines) whose register windows and descriptor memories metadata need to
> be exposed to a remote peer. Endpoint function drivers need a generic
> way to discover such resources without hard-coding controller-specific
> helpers.
>
> Add pci_epc_count_aux_resources() / pci_epc_get_aux_resources() and the
> corresponding pci_epc_ops callbacks. The count helper returns the number
> of available resources via an output parameter, while the get helper
> fills a caller-provided array of resources described by type, physical
> address and size, plus type-specific metadata.
>
> Suggested-by: Manivannan Sadhasivam <mani@kernel.org>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---
> Changes in v12:
>   - Add pci_epc_count_aux_resources() and pci_epc_ops.count_aux_resources
>   - Use pci_epc_function_is_valid() instead of open-coding
>
>  drivers/pci/endpoint/pci-epc-core.c | 83 +++++++++++++++++++++++++++++
>  include/linux/pci-epc.h             | 53 ++++++++++++++++++
>  2 files changed, 136 insertions(+)
>
> diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
> index 6c3c58185fc5..fded71a19d71 100644
> --- a/drivers/pci/endpoint/pci-epc-core.c
> +++ b/drivers/pci/endpoint/pci-epc-core.c
> @@ -156,6 +156,89 @@ const struct pci_epc_features *pci_epc_get_features(struct pci_epc *epc,
>  }
>  EXPORT_SYMBOL_GPL(pci_epc_get_features);
>
> +/**
> + * pci_epc_count_aux_resources() - count EPC-provided auxiliary resources
> + * @epc: EPC device
> + * @func_no: function number
> + * @vfunc_no: virtual function number
> + * @num_resources: returned number of auxiliary resources
> + *
> + * Some EPC backends integrate auxiliary blocks (e.g. DMA engines) whose control
> + * registers and/or descriptor memories can be exposed to the host by mapping
> + * them into BAR space. This helper queries how many such resources the backend
> + * provides.
> + *
> + * Return: 0 on success, -EOPNOTSUPP if the backend does not support auxiliary
> + * resource queries, or another -errno on failure.
> + */
> +int pci_epc_count_aux_resources(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
> +				int *num_resources)

Most like such kinds APIs return count directly,
  < 0,  means error.
 >= 0,  means how many resource.

Frank
