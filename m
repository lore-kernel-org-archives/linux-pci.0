Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012038.outbound.protection.outlook.com [52.101.66.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F473A7056
	for <linux-pci@vger.kernel.org>; Thu, 22 Jan 2026 20:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769114682; cv=fail; b=bObKIqRWGdlnFFAfTF/hVcuGKaLkssKVbLZ8vGSGhVGsly5y888J6TIGGYwO8nZG/VD3TEzyYiKuFHT3ourYoDlxXcWPB3MoXAlvDrR1mnv5jEqifqHggdlgyjAiSpXM0viqPLeW5tL3eHwM73X68MpoMBkKVzZwAKAiWDV3DjY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769114682; c=relaxed/simple;
	bh=UV4gJr/ovl5xT/s3du7eYtrdFC0XtuiP++zK9l0LU2o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UCCt1yHEX94gsogP4hvRX2LaGyzoSZZNGVa0jOwKs2YuZ5u99Nsn4moFTpkko3HRBEP5srGEhPE2pZ0w3aMaC6BP8uXcd6Ok2iFiZU+CFKs/iSOdHdLV/CuhyeR7KOoGyM+/zLS7WTxUzEWxxMBGw0UWSpe1ar+pE1lE0HoiUb0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Z8CIOsnj; arc=fail smtp.client-ip=52.101.66.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Z8CIOsnj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OtW4H17Isovyn/yvAORwhsSbFOTcs/f1O5oHKEfjOV3mOfjgDNpSxQ+vNWKZx5degD1iEtxGTCWcTHF1dYaiHCzRTK9jXj0M5ffQbm4sveArfk1ScIx/aXcUUlAcrl025HTrIxVszSgFZbGwCdPQQ3+jzaaW+P/zEqMk9Fsbk3rjD8rpAzZnudYhMvmPtps+8PRlnPW3vx4i2Z+dFJXJQRVRCxYu77SkpvSGWwyJlhhtIRf3AVAusWkbxBjC4rnIb4JBn1gKKEWpltBlKvzlupflfjEVAhYz3lJeikCgOCK1kScgQ/RDtzFbfHdyx+C/N8tK8qgPr5/OK5HpdvhrpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AVts4Ka+T1siotOnzIUzn+YddtKjfzBYGFLhbDf8o8s=;
 b=OIesYP7p/Ihr4eDJUqr8CLONvvk0EgNtTbLO3nNyosU6QGequ4apvkLd5X5cf/kG8RHFJHuBaqfaglI0IUsEi3kuWSv+Gj6twGYkHrK753lVmU/sDn4Il+czamYjiqVtHxv4RI20wONkw1B9DvXMg8eQn3td72y1FwcKYhoQI4OocjUSIEID1QzBfcXI3hN1OCgsPGrK9e2zMiSzt5Ik0GEu3qCXudaicygOhbjzLgXRQmLombE0S30swcae3drLpc/NJE1DjlemO3zYz6OvneDnYKxWiRyyrvICTUQjZrNP5V9TaW6PyAYgrdI5tPqqe1/cLmrrtYqgrJSzoUehrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AVts4Ka+T1siotOnzIUzn+YddtKjfzBYGFLhbDf8o8s=;
 b=Z8CIOsnjgKZyuSREU5HpLpucR8SKj6QqWirdZcsdS5Li+iMryH3azh0hcd9wWq05GIIVY/A3OoMnhT//Vw6neEG9cZawWZePB09Rcq/vNiGqIFKCYypAALRamQAea+WWhjWpR0d847utyY/TrZ/oQhBAtUMZSoiSwnnky6rNTwAF0bvnrsVuitJDBpbpkijPDQE5th0S9c+yVEvcLZsy0byrSdprVQNOQLTBOT6VcG/tdMA4f2+dz/rV8Mhy0lAJ3W0UPNID6h2+2vTfrs2bQiMhU1sag7ItEdHX33JBw0nlsXJGYphy3mt2NP62W4b0igYwrUoPiBq77DDt7jmpow==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com (2603:10a6:10:2e2::22)
 by GV2PR04MB12165.eurprd04.prod.outlook.com (2603:10a6:150:339::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Thu, 22 Jan
 2026 20:44:31 +0000
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196]) by DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196%4]) with mapi id 15.20.9520.011; Thu, 22 Jan 2026
 20:44:31 +0000
Date: Thu, 22 Jan 2026 15:44:24 -0500
From: Frank Li <Frank.li@nxp.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Randolph Lin <randolph@andestech.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Charles Mirabile <cmirabil@redhat.com>, tim609@andestech.com,
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH 3/3] PCI: dwc: Clean up iatu index usage in
 dw_pcie_iatu_setup()
Message-ID: <aXKMKAfhkOy6bP0G@lizhi-Precision-Tower-5810>
References: <20260122145411.453291-4-cassel@kernel.org>
 <20260122145411.453291-6-cassel@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260122145411.453291-6-cassel@kernel.org>
X-ClientProxiedBy: PH8PR07CA0018.namprd07.prod.outlook.com
 (2603:10b6:510:2cd::15) To DU2PR04MB8951.eurprd04.prod.outlook.com
 (2603:10a6:10:2e2::22)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8951:EE_|GV2PR04MB12165:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e9a8f83-08f6-4f12-c4c4-08de59f70b43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|52116014|376014|19092799006|366016|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mmRPzbkplD+fzSfWgwBpjTWnL0Llhfwr/Fu/ewWEtCZ1nCiYS1Qg+6PxueOQ?=
 =?us-ascii?Q?DBAfwZMBsPrq8Una5K/SuNoPVsW29o4LSbJKy5/ZMd1Ldu55+CB1eH9SNlVQ?=
 =?us-ascii?Q?HnRRmPtyp1+f/eulu0zhbjCxbb77z9LNIZKB8EGG6JA5rLtY0n6F+cUbOKKU?=
 =?us-ascii?Q?TpKvf0HkirUfvlzjzWarEtcVZr7BeyYqQj7adDivcKMGc+ktC00dZ4CXBW9k?=
 =?us-ascii?Q?b4VgtlKqqVxHNCMzRNHsrecruQMwv8i+ADySxw/4/YOdf11/ioiQ/Gp1AvrJ?=
 =?us-ascii?Q?giNXW27XZEXcvcd3XjbznjfcV9Jt2p3aXpEAy1xkEytpiWVokSQIAsJ4eFbu?=
 =?us-ascii?Q?ccZ0gHBOFAQql+jRH9wR3YjI0CYzTqHhm9BNx6PSv9EfR49T+Nrd0pG5DAXs?=
 =?us-ascii?Q?Bb+lsAUqUekd5136IZRnrt3knkWxsnIQnwdT2T7Evi19UAqtVy93bEC867ke?=
 =?us-ascii?Q?ssJbru5Pzb5DGz/XxfPBbuQKZ4rrM0puUxamKQUwVCrlWI5orp9Ell3x7GwH?=
 =?us-ascii?Q?+ubruIAOjrGdGuK9VodHPDQIlfoB87cQoWz/1CIMhuwerh2GbrZvj0A/TfaA?=
 =?us-ascii?Q?cwyypi2JDnMcnGhiwqD8jGptQEcF22gqZy/kVQuG9Pg9VSfQiXbfv7NAcePq?=
 =?us-ascii?Q?KmQwWsU02rV58+usc+6mdvhUxXenyk/AxGF5k9/oRMYAIXuDjjb9n6Hb7ZUC?=
 =?us-ascii?Q?ypeEZ4pDa4GOjUUhASa/gBbxhLorOM5G0sOhxifIRZed5xmrtLTD4XGeoPBN?=
 =?us-ascii?Q?w6yiLFlQUcDe7qYI0ri/Zk4gemnFhhucWFwzYJrsF4bVH0noiiPv5n6WiqVB?=
 =?us-ascii?Q?gYPxNlWhYK1I2dVFuBAg0VZoZ+Hy/q4jjN7RAMvkVLOqEsiuUp12ZqOqsgeT?=
 =?us-ascii?Q?iH3bTwDdfXAR3NBOUYvdDRtmUALM2gVKKv4AIh5Mo7JAH9nwBlf1x1FU9yyr?=
 =?us-ascii?Q?LOB9v8RPYpbcWkYvpJ3p2H6b9HdN2sqcyKpVhU3ZSdc+j73z262MZqpX+zpt?=
 =?us-ascii?Q?Sz0OjwvBda2cEC41G1lOP5lOVhGzd1irJSm1Qey8HUNlsfe/kjJQBqXInXnj?=
 =?us-ascii?Q?y//V70V8cShLRLt7D/23jFmlr9phccazAE48Rg/VmboDGD7cyGrCxni8y5ix?=
 =?us-ascii?Q?OZ9j8PlmB6E2bNhVmUAkm/WfPcFKI9/5Ky96Yz5BYJCwIJVi1NbYVzbZN5td?=
 =?us-ascii?Q?zYbg2Gc0DOUCQQD7Y4sSOUP41TGHY5C/IzNRf8lUUYCj2uf/K1UWOLlhXHlv?=
 =?us-ascii?Q?YqhxpK1bKXuYlHiJJE1rc16QVwVvH7tJWlyn7Ww/Hs6bfmRHmz3b8wCAAZt5?=
 =?us-ascii?Q?RDVYLhoeUWQCRPpoNWNuQGalgIuVjyE6d35WjYcsBeAMUK795+vtmFXON+Zn?=
 =?us-ascii?Q?B9FDwk9SmTPCkRkmt37AgG7jGh5C2BAfzEj1mgidq8lUqbc5ak9n526SPbE5?=
 =?us-ascii?Q?pR/4XQ+d1fD2Ynj56WuyzsdEjZqqaOwXVDYlDgWOkKWezrmtVemaSeel5AW9?=
 =?us-ascii?Q?aTK8cE2QstfuYcpB5wKwZgmbh/sPDy101gGRhxMaUVK/jxEqTEJ7sQfgo3LV?=
 =?us-ascii?Q?6zf1nDNVPNa6mWe1mln9ve34h9GUaDkp54UV0F0qPLkuV78QIXyUoltgb+dJ?=
 =?us-ascii?Q?yeZUsgkxI010wTRd2pBfk5o=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8951.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(52116014)(376014)(19092799006)(366016)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5ocNkUwxBNHNmbZ4KBgrWtPRjGGEJIcrBw8VvpoW6Y4+qQeJvF4c4Ujcnalm?=
 =?us-ascii?Q?/IjtD2YejcNVqtk/Tbl1Ifw3WkmvmZG17aXzw5Rh76msM9PzdTaEM3JRtftR?=
 =?us-ascii?Q?BE81BnW43kOMpCBor+KdHwDNZiSQW+x/Cqyi4ZoHzizwJgW2kpYvnkQWdU1e?=
 =?us-ascii?Q?51ib8u2nzbeRoT3IDLEF7FqUIqVPTTETxPYB2U4LX+AeGeLeQkh1Qc132+K5?=
 =?us-ascii?Q?XM644uWfx38GPC8CfdcswveLNEhLTk4Fpw2R4lei4nx7aiemms8x+oYURzRC?=
 =?us-ascii?Q?du9y/gg0Jw02mVQc/UZFQ/YXG1ix3XNgIaPdYQravaZAkzUM2l8g6pTb3Wj8?=
 =?us-ascii?Q?n0wcX0MG9xjurX7qddwJcYfOVOM0k8SXL6CqEx+7/Fmm2KaAUyFsRvBNgUUU?=
 =?us-ascii?Q?5AEVMImxVhOK4txXrK4Ft029dgenC25BlHILefelLLBT0DwBdyTd9/Av/vNe?=
 =?us-ascii?Q?S1Zy40hFYr+ahmqdJ6f1jXm4r9rXe/2JtOEHFRhWmn37HY1E/Rtqe93T4kSm?=
 =?us-ascii?Q?Frqa1x1FP0RBlQlg/T0nr3dtZR6H7cr57PA6OW6WMExNeufQE58b0S9ntfXJ?=
 =?us-ascii?Q?xx5RAjdJ0F7BhzwTb63pJ7BGtY76tih1Eww8p7miuQ0F4iU+geS7wy+QioEa?=
 =?us-ascii?Q?G158ninb0PVMJCCPN4uOBvK2Ds+rpjk2ALsi6BAFZWKN1zBBeY+SFtI1EhVO?=
 =?us-ascii?Q?PYcj6k2uqmASMC8i5KgiFeN45qiyYmkD1+tv69ap4i/w8dyhEFAAqD+gj7K+?=
 =?us-ascii?Q?WE+2vzYPSUC+NiW8c9ln9LFJqGQ9TFfD5ATQthPtoqO2i4cPprdG7hGN4FKj?=
 =?us-ascii?Q?4ITkY+o66hf2k2cxSabsfvCuSuovcYMcfLRmio77n28LIh6NUnsNnowI61tT?=
 =?us-ascii?Q?QTXcLPr1j9xGzjkxsC2u2koQm6sRZyJSXlPP+sH85q3NGrb2E84H/FXSxk5Q?=
 =?us-ascii?Q?L3b8o98gmmY8Fo1eLjlAMqMwGGhf4RnFh1kqcl2RkXmOr2kB+Co12BZDVG8m?=
 =?us-ascii?Q?sRHarxEofuE7Ng+O/zgZvmjE3jlTue5Xh1wYQcNJ7N3IKy+c9T6xGY66YrdM?=
 =?us-ascii?Q?DSYxplzj+WdN1W+NOY8g2wkmMroRRl7s7Rtw0qT7tH6QubQGrI3aMVSZWkVu?=
 =?us-ascii?Q?kiB1AI/XfAij3R6tZ5+SzBww7kG6vzJ0lwwJs6PEs47Wec7K4mWitxtNavbr?=
 =?us-ascii?Q?BLiGd07Rt4UzyZTH32AdWmTZrsvBFldn2Fhu2fG5z44Gt4XbLW4K104M0iIi?=
 =?us-ascii?Q?q41ml3Qs/lHUUGKAM4d9VBt1LAkdzsd+M/qxo5qwGi9UqibmEia+G4uE/5J2?=
 =?us-ascii?Q?+6/xkp0Ku586cxwMFDO8pZwIMNrL/m1ORnJJCTJFuqXoT5NvwKYuo3a53Z/S?=
 =?us-ascii?Q?yZsxex2B9hlu5WqAK84d+YkHheC7FkqCcpocGM0QsAe3VjYvMSV5zl4e6jeW?=
 =?us-ascii?Q?UDcAfkTtX3ULNK6nh32kY7k53IWfEGya2s6QX7wZxw7Y9mjV8MMH4vV3zPSV?=
 =?us-ascii?Q?2yjffwC+/fqBAmUpMzydLXtc09Kmnr3ILW6lCkYDGJR6yx5+rV5f3ghKFhj0?=
 =?us-ascii?Q?e0PYfngGkRX5y0LogoMBxOKVeUJQFQBPmwT2GXrl06CVlY2R1JPRcBTxdili?=
 =?us-ascii?Q?IIxs2rAmZBZfWijx/gRfXPKcBVPnfPRVhID5LYqo8YvP9YvagQcffZsNDyyG?=
 =?us-ascii?Q?VQb8U4M5hVCVUjK8OMj0nVyUcXzl/Lipg6P9s+K+OS+XRvKKvif55YpKXEZ8?=
 =?us-ascii?Q?Gwxn2Ms9uA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e9a8f83-08f6-4f12-c4c4-08de59f70b43
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8951.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 20:44:31.5121
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A/FjdY3IGANCxPpm4WwjnA4z6GVpmQEVBD1l8O9C9UpU2AWgVAGMMJmPmvS+X1JhixuIN9Y8FxQcilQ8zMCCbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB12165

On Thu, Jan 22, 2026 at 03:54:14PM +0100, Niklas Cassel wrote:
> The current iatu index usage in dw_pcie_iatu_setup() is a mess.
>
> For outbound address translation the index is incremented before usage.
> For inbound address translation the index is incremented after usage.
>
> Incrementing the index after usage make much more sense, and:
> Make the index usage consistent for both outbound and inbound address
> translation.
>
> Most likely, the overly complicated logic for the outbound address
> translation is because the iatu at index 0 is reserved for CFG IOs
> (dw_pcie_other_conf_map_bus()), however, we should be able to use the
> exact same logic for the indexing of the outbound and inbound iatus.
> (Only the starting index should be different.)
>
> Create two new variables ob_iatu_index_to_use, ib_iatu_index_to_use,
> which makes it clear from the name itself that it is the index before
> increment.
>
> Since we always check if there is an index available immediately before
> programming the iATU, we can remove the useless "ranges exceed outbound
> iATU size" warnings, as the code is already unreachable.
>
> Because we always check if there is an index available immediately before
> programming the iATU, we can also remove the useless breaks outside of
> while loop.

The condition is the same. So combine two paragraph

>
> Also switch to use the more logical, but equivalent check if index is
> smaller than length, which is the most common pattern when e.g. looping
> through an array which has length items (0 to length-1), such that it is
> even clearer to the reader that this is a zeroes based index.
>
> No functional changes intended.
>
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---
>  .../pci/controller/dwc/pcie-designware-host.c | 59 ++++++++++---------
>  1 file changed, 32 insertions(+), 27 deletions(-)
>
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 991fe5b9a7b3..eda94db04b63 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -892,9 +892,10 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
>  	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
>  	struct dw_pcie_ob_atu_cfg atu = { 0 };
>  	struct resource_entry *entry;
> +	int ob_iatu_index_to_use = 0;
> +	int ib_iatu_index_to_use = 0;
>  	int i, ret;
>
> -	/* Note the very first outbound ATU is used for CFG IOs */
>  	if (!pci->num_ob_windows) {
>  		dev_err(pci->dev, "No outbound iATU found\n");
>  		return -EINVAL;
> @@ -910,16 +911,19 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
>  	for (i = 0; i < pci->num_ib_windows; i++)
>  		dw_pcie_disable_atu(pci, PCIE_ATU_REGION_DIR_IB, i);
>
> -	i = 0;
> +	/*
> +	 * NOTE: For outbound address translation, outbound iATU at index 0 is
> +	 * reserved for CFG IOs (dw_pcie_other_conf_map_bus()), thus start at
> +	 * index 1.
> +	 */
> +	ob_iatu_index_to_use++;
> +
>  	resource_list_for_each_entry(entry, &pp->bridge->windows) {
>  		resource_size_t res_size;
>
>  		if (resource_type(entry->res) != IORESOURCE_MEM)
>  			continue;
>
> -		if (pci->num_ob_windows <= i + 1)
> -			break;
> -
>  		atu.type = PCIE_ATU_TYPE_MEM;
>  		atu.parent_bus_addr = entry->res->start - pci->parent_bus_offset;
>  		atu.pci_addr = entry->res->start - entry->offset;
> @@ -937,13 +941,13 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
>  			 * middle. Otherwise, we would end up only partially
>  			 * mapping a single resource.
>  			 */
> -			if (pci->num_ob_windows <= ++i) {
> -				dev_err(pci->dev, "Exhausted outbound windows for region: %pr\n",
> +			if (!(ob_iatu_index_to_use < pci->num_ob_windows)) {

Is it better "if (ob_iatu_index_to_use >= pci->num_ob_windows)"

Frank
> +				dev_err(pci->dev, "Cannot add outbound window for region: %pr\n",
>  					entry->res);
>  				return -ENOMEM;
>  			}
>
> -			atu.index = i;
> +			atu.index = ob_iatu_index_to_use;
>  			atu.size = MIN(pci->region_limit + 1, res_size);
>
>  			ret = dw_pcie_prog_outbound_atu(pci, &atu);
> @@ -953,6 +957,7 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
>  				return ret;
>  			}
>
> +			ob_iatu_index_to_use++;
>  			atu.parent_bus_addr += atu.size;
>  			atu.pci_addr += atu.size;
>  			res_size -= atu.size;
> @@ -960,8 +965,8 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
>  	}
>
>  	if (pp->io_size) {
> -		if (pci->num_ob_windows > ++i) {
> -			atu.index = i;
> +		if (ob_iatu_index_to_use < pci->num_ob_windows) {
> +			atu.index = ob_iatu_index_to_use;
>  			atu.type = PCIE_ATU_TYPE_IO;
>  			atu.parent_bus_addr = pp->io_base - pci->parent_bus_offset;
>  			atu.pci_addr = pp->io_bus_addr;
> @@ -973,34 +978,36 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
>  					entry->res);
>  				return ret;
>  			}
> +			ob_iatu_index_to_use++;
>  		} else {
> +			/*
> +			 * If there are not enough outbound windows to give I/O
> +			 * space its own iATU, the outbound iATU at index 0 will
> +			 * be shared between I/O space and CFG IOs, by
> +			 * temporarily reconfiguring the iATU to CFG space, in
> +			 * order to do a CFG IO, and then immediately restoring
> +			 * it to I/O space.
> +			 */
>  			pp->cfg0_io_shared = true;
>  		}
>  	}
>
> -	if (pci->num_ob_windows <= i)
> -		dev_warn(pci->dev, "Ranges exceed outbound iATU size (%d)\n",
> -			 pci->num_ob_windows);
> -
>  	if (pp->use_atu_msg) {
> -		if (pci->num_ob_windows > ++i) {
> -			pp->msg_atu_index = i;
> +		if (ob_iatu_index_to_use < pci->num_ob_windows) {
> +			pp->msg_atu_index = ob_iatu_index_to_use;
> +			ob_iatu_index_to_use++;
>  		} else {
>  			dev_err(pci->dev, "Cannot add outbound window for MSG TLP\n");
>  			return -ENOMEM;
>  		}
>  	}
>
> -	i = 0;
>  	resource_list_for_each_entry(entry, &pp->bridge->dma_ranges) {
>  		resource_size_t res_start, res_size, window_size;
>
>  		if (resource_type(entry->res) != IORESOURCE_MEM)
>  			continue;
>
> -		if (pci->num_ib_windows <= i)
> -			break;
> -
>  		res_size = resource_size(entry->res);
>  		res_start = entry->res->start;
>  		while (res_size > 0) {
> @@ -1009,14 +1016,15 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
>  			 * middle. Otherwise, we would end up only partially
>  			 * mapping a single resource.
>  			 */
> -			if (pci->num_ib_windows <= i) {
> -				dev_err(pci->dev, "Exhausted inbound windows for region: %pr\n",
> +			if (!(ib_iatu_index_to_use < pci->num_ib_windows)) {
> +				dev_err(pci->dev, "Cannot add inbound window for region: %pr\n",
>  					entry->res);
>  				return -ENOMEM;
>  			}
>
>  			window_size = MIN(pci->region_limit + 1, res_size);
> -			ret = dw_pcie_prog_inbound_atu(pci, i++, PCIE_ATU_TYPE_MEM, res_start,
> +			ret = dw_pcie_prog_inbound_atu(pci, ib_iatu_index_to_use,
> +						       PCIE_ATU_TYPE_MEM, res_start,
>  						       res_start - entry->offset, window_size);
>  			if (ret) {
>  				dev_err(pci->dev, "Failed to set DMA range %pr\n",
> @@ -1024,15 +1032,12 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
>  				return ret;
>  			}
>
> +			ib_iatu_index_to_use++;
>  			res_start += window_size;
>  			res_size -= window_size;
>  		}
>  	}
>
> -	if (pci->num_ib_windows <= i)
> -		dev_warn(pci->dev, "Dma-ranges exceed inbound iATU size (%u)\n",
> -			 pci->num_ib_windows);
> -
>  	return 0;
>  }
>
> --
> 2.52.0
>
