Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013054.outbound.protection.outlook.com [40.107.162.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE2472612
	for <linux-pci@vger.kernel.org>; Tue, 27 Jan 2026 18:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769537807; cv=fail; b=klx7YO/lbdDk5uDxwNnqmofluuaa0TZ3yzmXCuX0ZNnDWhLs2DssqO9IylgESL5ktAr+yRLAxBC6LPLY7jvs7OnU3Ec/hZQeMtwPXsK0YQf6Y53a5yUQOMtYqu3dRzzb+Q0u53hxgLxOBgaBEQTK2H4snR3q7/44E9UyTpdX37w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769537807; c=relaxed/simple;
	bh=j52eduBwGoWUlX8djdoAqlNNTYZ7sTQJMtf8WvT0oNc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rwOvqFRcteEBNsXMs/qPfIcvVUqQgwqw639BXhyO0mvnRKTvdF8YyhmxXFHyh6o3GTKStcSYGvHQ7F0ChpeQnzNODxcjnkw0wqiDebDoVVqSICPez9bGPVL9XfJS1RavbB+hISRuM/yCU/ZisZhnrOJlAHP2gv380EXatpKfICA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=KON/+Xa1; arc=fail smtp.client-ip=40.107.162.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="KON/+Xa1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GklRAFsP2B6gdgRn4w2IspK7yIgbiDPUawcuAhukzJqQj7gpNna0RT2CqK4Wfwli3kC/1d9ueC+EeuwJUPpMdFC83rU5yqsNsB66vjI8dNgUuZQH5KpaT21uCXsCAyXG2q4RfMlfTZY7kSszn4GddqVgIaZwqwUI6P/KaRKcOlZqXnaLGqHqAWTAkPdSrUtp/ZZ4t5FlzKjvy0sW2ojRzTppGDHMqj2N3G/h2adPuFDv08UU+fY2N7BpBXCwo+CBQZRDO7kxd52EK6nOrlgs6yGYTQE/wO2rFDhn0LjAtbJ290DK3a/+UnMiNvSuA7bgrtlAz8e+kCN6XgRkSv77NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fHJLJDJDtAcfevwg0Mt9WXCST+QBxojqh/+ejnBiAdI=;
 b=VuDiacWmJLV4pCuetU2jDvHJchUu+GjivBMb7JR4eqzly1/vuWgbAGECDMsMMg+zXMhVWg2P83jfO+ZB5Sp1zPmQdBTN+0DZcIzQgBE1TNWO9QfOrFWVYBeNRnep0Qgmgw0Ag6sHtI+c//16CMrjmoSgxgF8InlzGUR2q3/6SGZdy/MSwoUrYJj7GSy5Is6FHFHJE0h+9LPcuaX98hDiL87vcm78yh8OdryQweB5ZgUU7WPEAum1QkNIerAnNZCeXm5j3/X/Wi+ZdqD3gDMd2/DlTAwiXviBMOTMa0FeWWN2vF6t6gk7pu2X7peTVuegqyNPJ13U6cKywh1F/jq2SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fHJLJDJDtAcfevwg0Mt9WXCST+QBxojqh/+ejnBiAdI=;
 b=KON/+Xa1QKmIIQa6CozB5MtCvemjk0t/pSKmWTqJqFx4dkdkKX1b/CsXSAipzWoPOCcFhMUkqaMYXbfrqCNSHeJiDFEuJ4Mj/cOYGFMo5kkkRGK7fQEbmGvR83OjijR+dmyVVyybz0HoS6ujv8aOZGW/NN3o4m6BTBvt/ztb/7xE8O1xUFiRXNQPLWiOc7/rA2iCqA5P4BqPs8Y1m5salLTKG2zrFe/tDBA2HKI+5YgOiMdCg3av7kbZl1x6/5loBJMFD0/2n8FJIG4Q/GnYceDh9FPQa9lUw+kaWYqWa/tz9wLTrbXQMLEMCnta63Sio206QJhRanDQRjC+ln3JgQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by DU4PR04MB10402.eurprd04.prod.outlook.com (2603:10a6:10:55b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Tue, 27 Jan
 2026 18:16:42 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9520.005; Tue, 27 Jan 2026
 18:16:42 +0000
Date: Tue, 27 Jan 2026 13:16:32 -0500
From: Frank Li <Frank.li@nxp.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
	Randolph Lin <randolph@andestech.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Charles Mirabile <cmirabil@redhat.com>, tim609@andestech.com,
	dlemoal@kernel.org, "Maciej W. Rozycki" <macro@orcam.me.uk>,
	stable+noautosel@kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v5 3/3] PCI: dwc: Fix missing iATU setup when ECAM is
 enabled
Message-ID: <aXkBAK6wK5bx1rR8@lizhi-Precision-Tower-5810>
References: <20260127151038.1484881-5-cassel@kernel.org>
 <20260127151038.1484881-8-cassel@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260127151038.1484881-8-cassel@kernel.org>
X-ClientProxiedBy: BYAPR05CA0017.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::30) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|DU4PR04MB10402:EE_
X-MS-Office365-Filtering-Correlation-Id: 5eafff83-3a60-4d51-f914-08de5dd038d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|19092799006|7416014|366016|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6BMDPhamJwzROZM2PDaYrXZaA0vktga6c//O5ZFsoeIBwc+SFHwPfbNrSQ84?=
 =?us-ascii?Q?lKug2ZjUAg4WOioh9qX71JSeGucHkfhMDtdz0ohfkv8gJOM65YM+WGxEbDPT?=
 =?us-ascii?Q?RoZKUuxITytEvkInYfXBe7Kymi/u25W4BBndH29FUE9iizEMTdwB4wdb0U8W?=
 =?us-ascii?Q?IhSUmGvGvMfFAbDAVFsOBk63rnFeiQlZAa3q1WAbngw7Abxp2frJaXcncxZp?=
 =?us-ascii?Q?pGeb8hb4k0JIGwnnp55r+i56R87aOfxt+pjHBUMjmOyX9/xrdZn1ns85+7ZB?=
 =?us-ascii?Q?HR/sOM/UXgyFkwRCXMhEJa3wU/sgPFjXSwtFTII0Sn74KTWoWzQeYiCfZAsg?=
 =?us-ascii?Q?Mp8fhmC9DAhjrxC1lMjE6yaltEb2GqeTyxLOuMj0xhVi88HxbAibjwu011aL?=
 =?us-ascii?Q?5zo8nbdINcxCF2CriqHlkz4wNmTWh0RXeV6zW1/eAIlWxX6dCUmHnEzuC8ec?=
 =?us-ascii?Q?G/ivz3Ftn5ims7ObcHgixzNyoWIBNoKS/Xc4PtWCY+RUSEaW8+/7weXTJ8ak?=
 =?us-ascii?Q?W3Ev9FsookZJgptCFyyh8xXaiLdYhD7KBabgSnsohxBFENqTIk7nYfEH3SNU?=
 =?us-ascii?Q?NoVWihJ0pE++1KSelEiuvoi+RHNJOmQR/u2LAUfQfSla+wxHeNPxhbSNyl5B?=
 =?us-ascii?Q?rTr5uvQ+4265br8YnwQuS5cUbRQYRY0fMLP3zWa9NSGbOz9RPooWRCyW7bWJ?=
 =?us-ascii?Q?xjLmo1cst335i6kf92zEVpfeF44odL6OWCQ0dYU2QPFS5axdSrkUjE2EMbIN?=
 =?us-ascii?Q?LQWN/dYFjX4EkQjCjsLDDYAg5KXEWxhu7VblzGzbzFwIneWqRnSnLlREbuOb?=
 =?us-ascii?Q?jClVW2+w5H7Vtwtrw2a31a9xFe1o9tN+S+cq9KJkTe1Ib3g3v5y/GIV+P3W0?=
 =?us-ascii?Q?i0eFksMC0mnL9mMCl9KEe/domyxoi960etp7wscS5CUZpJ8qOj0ZcZdmHN3W?=
 =?us-ascii?Q?OkJnGVRy2UCOr0yl9xnaCEIMsBnGFQboX62BanEv11vKYz7bcEONF90qVFki?=
 =?us-ascii?Q?aZORtR9koMMabZfEBMM5mS4JdGCKHj62Op2vXraffxg/ejTAiJuGt5iaCS0Z?=
 =?us-ascii?Q?vm8H4XlBCjqL1H/YbjwFvXyd3ZoKAFRckbMGlpp47Ql2GxmfwvVqO+9JIlnO?=
 =?us-ascii?Q?rJJlf3LGmwCz1lxZoyzgElFKfx05Vq7wb7eEQYGOMhjE+tRl1kU57VezdEug?=
 =?us-ascii?Q?YcB9MRPAxpFEVkFQWda+1F0RNS7tXjXSc5OgXXPubuwP4AFgZoKY8UzjpM0z?=
 =?us-ascii?Q?A0nmSOetoyX+74i94VtBiONb/JZGS1wm32EG3uKaJlTTvxZ3TlyTLx5lazNQ?=
 =?us-ascii?Q?mrXvh1gJdO6jDy5TugDPtTlM7y8Rrt2R+sWy9PgtMg111OuZNfWToW0c09N4?=
 =?us-ascii?Q?Rkj+hEZjMvEqsq1og3eE+rns0V31EFIS2wbXRmYdYztb+nggDcyrh1sx+Qn2?=
 =?us-ascii?Q?sMy60yY8WL6Qm816d3Lt6pWHZtyE9uZbR9e1AA2R4x1A38uJuca9vq5zyKcP?=
 =?us-ascii?Q?g2Zp+fQp8iWOhHxuWnmIy5QylkubomdEic49IAROwFWUAq/vLfoZtY1frj4d?=
 =?us-ascii?Q?9VKL5vjsLUjvj4/peTdBEEos1xtW0EcyDbcNwuvGs0Vh6G5gyM2cuS1bCmeR?=
 =?us-ascii?Q?SkQc6VNDphUQOeg37WaopU4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(19092799006)(7416014)(366016)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9LXWglKcnuaDuyYACu9R9GUkXn4jNnRmlxSWZKjjG2pt/K8shkx0KWw0mPR1?=
 =?us-ascii?Q?MWWKFG4xypzGqDm15A5Wy3/+e6Or+cGLI1Cydv8eTFfu25bdWkR5XMCsg6hO?=
 =?us-ascii?Q?br9495+M2wipp3YoYtzMnrU/kKr0bAnd65XkrkF0dahTGlfK4T+ZKN0wZxdg?=
 =?us-ascii?Q?VW1jwaVV5l4rCTB+f/tR3Z2NiE9E3v19df8yAkq7BhMxEKDeSWP4eyx3Li2+?=
 =?us-ascii?Q?1rpepvXMCnDXriYYd+vEubla2M9c5YUOzCr35z3Imv6qC+NFE0XcPqlDnTln?=
 =?us-ascii?Q?1xE6WXExFTpvWTD1Tu+aONhvxB9EzNfWcQt+Hh2UyTgbS/GDbOgStnuVFRPM?=
 =?us-ascii?Q?D86K3PxDUnqmykODpB207fggLQkY87/K78qa/yw+nCeVvepTAHmIrbEPluAh?=
 =?us-ascii?Q?RjFWn7vnDpqdNZ2vjxMsCYTqRrfb4h0MQBSmOmJG5lxIS0Inkwc8/P0WXaYy?=
 =?us-ascii?Q?sKqOEAzofsAEfeicZkHaBuIcIBfew5NarR4WBrYhzfqMOSD0wmZzTMyUD4lx?=
 =?us-ascii?Q?rY6mDZShSz+8uDcwqrUvTBsWBbc7B1zUjcKcvc2z0poCcPmvoifdCDMeW6KZ?=
 =?us-ascii?Q?hzaIXLfwaUdRcD/BXyiM8HGngPd1lx605MKFWNJKUrq82evIwH50jy0zAvRc?=
 =?us-ascii?Q?MhzYrvo5SS3a/pRcGxsrnJGRXpMcoF4ekXAPV/hnjOkVQgqvBoF8SHtMUago?=
 =?us-ascii?Q?jWVrqcYpFtjsLYdfYg3w9+AQ+9P8UDX8sWMyjKoS6O+RgjALF3mmX2twJBtf?=
 =?us-ascii?Q?7TMvnkCYBUkmTRKZ98BNs0wtV02+tGtlJQYZV8tbWO8ipic9NGvczVp1Pz7Y?=
 =?us-ascii?Q?A+jOXrL+4yZ0WXH04gzCkyea7JIPu6a3HxnTFSvyuE5GhEwea+XWyejIvBNl?=
 =?us-ascii?Q?1S0HDHnEczLQta9Z8gRlFtQWTSntd23xBmj4vIbWGyapcUf1y/kmYDnWDtZT?=
 =?us-ascii?Q?y7X/6Aqtqe7qZA8R54MZxEjWWVs28IHpxkrN0QzXSKRKtmmF9416Ogkn1WLy?=
 =?us-ascii?Q?beYXDDxuEkN8RIDoucjOcbUVb+IAwaDRZ1JC1Y/D66R3quRsaH2S6mo+4UQT?=
 =?us-ascii?Q?5wzNmd+AIXBGKISiWwY8pXhCWB1DyeeFiHqHdO/AL4oxNPxaMqowJJRv5tbU?=
 =?us-ascii?Q?HnPU9r3qOvnM99NGRAjgg7hV0TJ1poeS98Grxq3YAwcgCWwtqMZIjhzPwT4s?=
 =?us-ascii?Q?RGWki/fLc/rV5gAUKAoWRPH21RFJqkpRhrw0RY24VH5XQreBX2Co5Y30dGHy?=
 =?us-ascii?Q?G59mCLVHZsVpSiIIOaB6/0ORimSrge9YQil96rAg0NcH2cl2XMRSKlwDSOb2?=
 =?us-ascii?Q?MkPNxPf6drL/g3KGcFKXKpIUj9AaOc0vx9FyOLb4tk1+HmAIamPRXtQAQUjO?=
 =?us-ascii?Q?yMaLE9WsJ1L7eapdV2vr0HW4cj9HQ6Krkcv2nb0EGD4KKRWi2x9AifewCydg?=
 =?us-ascii?Q?GXwcqDhYh1bl4r12ZhQwZXUt7F3r+I+bwr2P74JNm4Olo73O3dUClyGw0RBg?=
 =?us-ascii?Q?zxWb0bcy//qfAlLUKB/mVQUTem0vzOCm19lZcprQr59o+974z83iym2KHvMl?=
 =?us-ascii?Q?6yggipz+sfzQpypyv41qD5TkZeUWHplEWne5SOEczXTfiX8/8e4SgFkKg1BN?=
 =?us-ascii?Q?nqzVP0W2c7QbFYk5sg1T+UQBfZdqNBT5LLmNIZS/NoupWEzuvLOOjqqcsb/E?=
 =?us-ascii?Q?5tT+lnijYWdGdtt8xy8HY77AYKrn41S013gdlHjY+scJVz/Gm1ZGS1BU5+US?=
 =?us-ascii?Q?o8WQhme9KA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5eafff83-3a60-4d51-f914-08de5dd038d7
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2026 18:16:42.3618
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rufJRa5IZQ4aGaEqn/wHgHa98Kb28tZtykQEXMOgg5gMGFq+Kn/lB3qxl5Y7qP0FLfJcmiP61mTRVBprH3vtyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10402

On Tue, Jan 27, 2026 at 04:10:41PM +0100, Niklas Cassel wrote:
> From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
>
> When ECAM is enabled, the driver skipped calling dw_pcie_iatu_setup()
> before configuring ECAM iATU entries. This left IO and MEM outbound
> windows unprogrammed, resulting in broken IO transactions. Additionally,
> dw_pcie_config_ecam_iatu() was only called during host initialization,
> so ECAM-related iATU entries were not restored after suspend/resume,
> leading to failures in configuration space access
>
> To resolve these issues, the ECAM iATU configuration is moved into
> dw_pcie_iatu_setup(), and dw_pcie_iatu_setup() is invoked when ECAM is
> enabled.
>
> Furthermore, error checks are added in dw_pcie_prog_outbound_atu() and
> dw_pcie_prog_inbound_atu() such that an error is returned if trying to
> program an iATU that is outside the number of iATUs provided by the
> controller.
>
> Fixes: f6fd357f7afb ("PCI: dwc: Prepare the driver for enabling ECAM mechanism using iATU 'CFG Shift Feature'")
> Cc: stable+noautosel@kernel.org # depends on Clean up iATU index usage in dw_pcie_iatu_setup()
> Reported-by: Maciej W. Rozycki <macro@orcam.me.uk>
> Closes: https://lore.kernel.org/all/alpine.DEB.2.21.2511280256260.36486@angie.orcam.me.uk/
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> Co-developed-by: Niklas Cassel <cassel@kernel.org>
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---
Reviewed-by: Frank Li <Frank.Li@nxp.com>
>  .../pci/controller/dwc/pcie-designware-host.c | 33 ++++++++++++-------
>  drivers/pci/controller/dwc/pcie-designware.c  |  6 ++++
>  2 files changed, 28 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 87e6a32dbb9a..bc2e08ec515e 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -641,14 +641,6 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
>  	if (ret)
>  		goto err_free_msi;
>
> -	if (pp->ecam_enabled) {
> -		ret = dw_pcie_config_ecam_iatu(pp);
> -		if (ret) {
> -			dev_err(dev, "Failed to configure iATU in ECAM mode\n");
> -			goto err_free_msi;
> -		}
> -	}
> -
>  	/*
>  	 * Allocate the resource for MSG TLP before programming the iATU
>  	 * outbound window in dw_pcie_setup_rc(). Since the allocation depends
> @@ -915,8 +907,21 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
>  	 * NOTE: For outbound address translation, outbound iATU at index 0 is
>  	 * reserved for CFG IOs (dw_pcie_other_conf_map_bus()), thus start at
>  	 * index 1.
> +	 *
> +	 * If using ECAM, outbound iATU at index 0 and index 1 is reserved for
> +	 * CFG IOs.
>  	 */
> -	ob_iatu_index = 1;
> +	if (pp->ecam_enabled) {
> +		ob_iatu_index = 2;
> +		ret = dw_pcie_config_ecam_iatu(pp);
> +		if (ret) {
> +			dev_err(pci->dev, "Failed to configure iATU in ECAM mode\n");
> +			return ret;
> +		}
> +	} else {
> +		ob_iatu_index = 1;
> +	}
> +
>  	resource_list_for_each_entry(entry, &pp->bridge->windows) {
>  		resource_size_t res_size;
>
> @@ -985,8 +990,14 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
>  			 * be shared between I/O space and CFG IOs, by
>  			 * temporarily reconfiguring the iATU to CFG space, in
>  			 * order to do a CFG IO, and then immediately restoring
> -			 * it to I/O space.
> +			 * it to I/O space. This is only implemented when using
> +			 * dw_pcie_other_conf_map_bus(), which is not the case
> +			 * when using ECAM.
>  			 */
> +			if (pp->ecam_enabled) {
> +				dev_err(pci->dev, "Cannot add outbound window for I/O\n");
> +				return -ENOMEM;
> +			}
>  			pp->cfg0_io_shared = true;
>  		}
>  	}
> @@ -1157,7 +1168,7 @@ int dw_pcie_setup_rc(struct dw_pcie_rp *pp)
>  	 * the platform uses its own address translation component rather than
>  	 * ATU, so we should not program the ATU here.
>  	 */
> -	if (pp->bridge->child_ops == &dw_child_pcie_ops) {
> +	if (pp->bridge->child_ops == &dw_child_pcie_ops || pp->ecam_enabled) {
>  		ret = dw_pcie_iatu_setup(pp);
>  		if (ret)
>  			return ret;
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index 18331d9e85be..5741c09dde7f 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -532,6 +532,9 @@ int dw_pcie_prog_outbound_atu(struct dw_pcie *pci,
>  	u32 retries, val;
>  	u64 limit_addr;
>
> +	if (atu->index >= pci->num_ob_windows)
> +		return -ENOSPC;
> +
>  	limit_addr = parent_bus_addr + atu->size - 1;
>
>  	if ((limit_addr & ~pci->region_limit) != (parent_bus_addr & ~pci->region_limit) ||
> @@ -605,6 +608,9 @@ int dw_pcie_prog_inbound_atu(struct dw_pcie *pci, int index, int type,
>  	u64 limit_addr = pci_addr + size - 1;
>  	u32 retries, val;
>
> +	if (index >= pci->num_ib_windows)
> +		return -ENOSPC;
> +
>  	if ((limit_addr & ~pci->region_limit) != (pci_addr & ~pci->region_limit) ||
>  	    !IS_ALIGNED(parent_bus_addr, pci->region_align) ||
>  	    !IS_ALIGNED(pci_addr, pci->region_align) || !size) {
> --
> 2.52.0
>
