Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013046.outbound.protection.outlook.com [52.101.72.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B3AB3F0771;
	Mon,  4 May 2026 19:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777921934; cv=fail; b=A4yWfBdtOp6OLOUeRZOW+qp0uUB48Yzwogu426ZPpEierFmj/JZ23HwWqKfxmynohdjQwQDo1JgSY/mSVB6jL0J1QzaHMfWxif6aSmfPW3uyrEPzscoBANTRS68gm5cEwBXzrOSF29gQ6sizck0Yjnmb7E7QYlb6IzeY5z/s/3Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777921934; c=relaxed/simple;
	bh=NU4KNFK8OnrqPS/4huMcbZS35SQ4NctBCTg4DOWJfXk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LoPaSSs+NE80GxnrIcAhd7S3kgI24+bmRSnm4QkDX4zO4SIjQlP/xzeUWNRgaY3Y7RJhY9b/s/N484TKNiBmHj+YtVqUSHNOohxMf1L3zFgwKcl9qhZ2r8vrlUgWbYQzrq6xcEoGpfzGq6UQj6q3Y3gq9OvykhlQ77Sez0LDqGE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=W6u4NJ1C; arc=fail smtp.client-ip=52.101.72.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="W6u4NJ1C"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x/Lq7yRcfGr0R7Rlo6Nsb/uPYm7QuDEnVTeczBToGDFUwiQYoijyhpuXKJNKXIdqlvVph6RZnd/afxdNFLcxWRQyyJjWYa5omvwwbgodZcq6yhiDqEwYGZ7JROZ+w+1IRbQkP2jS4wAKImYCEF39Pbuj38lvCaV2Sd1BCFDMDsFuKlpiF0F+Gs5qj0Z8JwA5T9dEhisNrczOT/1cI3khCWIyj5tNDevM0PBGBGJVtOdoKOIccs1PVX9AaLUbnPaWN3EgrzUs92VrPGLmpaVLFUfwCTfnCJ7xp5NNgbyj5RqW0GaJRnvmeLWyKoKDv4LjzHoaoiPt7ZrVHJoSjn8JNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PMOjy4vQ2i+xBIoAMe6krzSGov9z0IIP+6HpueQzmPU=;
 b=IF0C2bmTS/ueUjHgfe7/UucjX1ljkS6X+5qJdbBJFRXlqwP14PIWipKotv+pEnF4FW8jkneKTZxmbw+QP7DTrLmxZm/Wj5zVGeWJAGSVD2KORQM2szeFoZtpd3URjmQHIVMmuqdamsa69lAEMWXEtXNEPJAc6JQNJCSdZY1mnEzQhxfamHLd6EAH12FHW3aZ4r9fyrygoYnr54PSzQt0eM5lr02xYtTU/Kcq0lga7F15Z3EanluZgr0udxFIBqBdqK8NX1BQGCkviJtyrJAmWIfZfuY3cF3LmYE5ANzregJB/q78//f5INZ3WWnlR0lgpSNnhyvm7siBwVlQj2D7eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PMOjy4vQ2i+xBIoAMe6krzSGov9z0IIP+6HpueQzmPU=;
 b=W6u4NJ1Ch8Lo9gnTRuX9V70DNro5FaIHeah7kM9SJZyQ4s47lZo3Fzmg6hKtdJu8dDybCwdczeClv44XhoJJ0e3vkEPQRWyYt8pbQnOO5KWRH9pU7GDRVG5o9iQhSmbntOKzc36CVvHQDhSMNsRJzGxhTTERRfqvzFdeUnk1hhGX1GE5V4PN2ZGqfZ1vV37HjuCS9dwnMLfOhdkIg2ZFOV4iPJZAlaK/zruFZRz2MpC7m9ScLfRIONQNV9cWWWW/GQz2lka4gD9Ky6XhKJER7uDJBUtIv81rILc/lNezi2qoo85NUEUPFPp6FIA4D/bXLeBY5L9UNRECNOb9QcO+QA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by AM0PR04MB6898.eurprd04.prod.outlook.com (2603:10a6:208:185::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Mon, 4 May
 2026 19:12:09 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9870.023; Mon, 4 May 2026
 19:12:09 +0000
Date: Mon, 4 May 2026 15:12:04 -0400
From: Frank Li <Frank.li@nxp.com>
To: Hans Zhang <18255117159@163.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kwilczynski@kernel.org,
	mani@kernel.org, jingoohan1@gmail.com, robh@kernel.org, s32@nxp.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH 11/16] PCI: s32g: Use FIELD_MODIFY()
Message-ID: <afjvhLycxNcNFcqa@lizhi-Precision-Tower-5810>
References: <20260430162420.42839-1-18255117159@163.com>
 <20260430162420.42839-12-18255117159@163.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260430162420.42839-12-18255117159@163.com>
X-ClientProxiedBy: SN7PR04CA0184.namprd04.prod.outlook.com
 (2603:10b6:806:126::9) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|AM0PR04MB6898:EE_
X-MS-Office365-Filtering-Correlation-Id: 46ab1f03-2dc5-4344-0404-08deaa110a3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|52116014|376014|22082099003|56012099003|18002099003|18092099006|38350700014;
X-Microsoft-Antispam-Message-Info:
	26yLReRX5pLUUbSZynDmMBf+KLEGU60TzkpKEnfNXnWPtKDy4ox/azJOGzxPIweiCM+V/Mtdd6qVxScWe7JjNkyAqIPGL0CE4Fcgh29m/8UaU3blNWX7Jkp4q3MGOZFXauAIOod7RXVpR8oLnjTQabwp6LbNNprxyxAM+8Gmdx5scx1OIcJT95g09SUYMAew6zI7WlQzuesKsXv5U82Yyzy9V65jtOaB+Lq6uDUTf/hyoGPwClL7PDSYg4gnR/RA4IhDWOSUuH4m44iJ9Fw+QbXvXQMRMy4Hlrlgmpw2ZqYf/tQUXbo5cFXyYWsZMD53fXZyreS+sT/ebosCMneaFl1buDlQi9ryq5cDZ6utMvViK7YWqQHXUa1EVPc1n36vmkfiUk/jNTrJVzD6ZkQe1tEfgUPtXOZGCz0pWI+ENuSRTEjpxxnsgw3C3M/nwe/2I8bBL+KK+MZav4nrO5k7HIqN59Ib/3rco23qLuDRzUN8fsQAmUa74eIJe3LZOgA4hbGwvQ2o8Hw5aQQVyBtDEiciYdYWPKHnkFxh3sOonG5xJ5smsfI61IIxE1dtkVmqgyQcFYxzDDttpX+FweZhY0gI2BIS9++CMra8pWTUPESdyC78IMBC4qJ4allSjJGN2HflcqmAi95jDtCBJBX/xxPwiTyV5aL1bc/4C6L1CTs9OINmYufsb9oLZI8gkHLkS4DPrQfY3vFKmAchyEOJ5ssfSMonsSTVUIgWIjKWUkWhtSAZlLVHlPmkUcnigmHx
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(52116014)(376014)(22082099003)(56012099003)(18002099003)(18092099006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7akJ0perSIF94vPNxrGnKheZKGevYBcOgtxteP1pzyNuZmvddryiuEsrosiO?=
 =?us-ascii?Q?Fv2xqFm3P2DobG+cor/ZQq/yFom0ReSQUiA9v1e6xmKOJovYiZ+OhmvvuoB6?=
 =?us-ascii?Q?+Ok5tdy3/utiXvOzLn2ObaBjpmD3CZFhjkjEK/1oNZ+L8mOF1egmyiXm0htG?=
 =?us-ascii?Q?h1yl+rmtBAMBVbBG2ErcgtjIJhm6SFTdttKGfpD9sp7ocQxsxoq1YGPIQSma?=
 =?us-ascii?Q?hxnK+Uq0RUs4wT+AcF9vM1cw7zZmXETwlQKcBrTwdrulAasvMwGzumCr4G2s?=
 =?us-ascii?Q?pAB1OlMdivVx2c4RA7yDIvM4461yLboLRRAQ4k2ldWLmlMDGgHo7MSyIqAzA?=
 =?us-ascii?Q?O6cATfUGiL2a28HsEuGt5ZcvGyR1Hzt9kQhKTsLJDZeuHp6Fuu4He9wJ/7hY?=
 =?us-ascii?Q?E3N5w+rIhpzcWFcp8DSX4RLMJtkfRXIrspf3XUbebJE3FoAXabfXsBDyfKR6?=
 =?us-ascii?Q?0x07qX2AO447+Q2h2+wXF6TpCRsWE/hh9qcJYX0H9zLEjvQ+u1VcJNMqLB8V?=
 =?us-ascii?Q?u/lgzUK/yFTF8dKh9Qh/KfiCPyGYAfEStghh48ooypkVsBVNVPYrh1KOlSpF?=
 =?us-ascii?Q?s2PUZCuFKHwAqpiDKdgkntVDInb3oNuvBTchzs9IXHmH4zhiCpjvQEI8yLPI?=
 =?us-ascii?Q?FNxuy6Mo/dnl9ImrNmhYQsDrYHKkIYWXLTORyEVuHqfGsa9v+Y6lCcnG1g6F?=
 =?us-ascii?Q?PDQaBk2IDYljp2pXZGJ5AJeLt9y9JOnwetOtbGbedjKCElBOiWkAPbgSnPPm?=
 =?us-ascii?Q?d5U1ljHPE/DtA0HbJ7ClLF8AozuNUSVCxtak3av13YdZ/Uka2FFxnLCywWh1?=
 =?us-ascii?Q?sUuQ8vgdpykeg2aK/a29tTFWOCpYRmDwPN/cY+gSlrke6IQmVxo2DoQCoRdv?=
 =?us-ascii?Q?z2lDjf+hLtBomdyk/cm+DcNBx0oyjb4AUFxiLHSMcOFlEczZTjqEJ/phb5E2?=
 =?us-ascii?Q?15pyEVb2yYkQJcASozHrEmIB1PGnKUbDQkoXYMtCvMU3b2XQE0P542ksGeal?=
 =?us-ascii?Q?tCUf7tHlaM1CNXxYFObRJHAC9zf/wCgr4b2ebL0APdZRd8aqk6Ssl9UDouFq?=
 =?us-ascii?Q?nIjpo3T7/qZaePMDSXgAfsH846sHZ9BfcwJvBOwUVHlD4hrVrzpFLQrvHyBR?=
 =?us-ascii?Q?4ccnoegVwcaHESntK7opUB0qa34Z4/ToPAfT9jT2RRK30Pe+i4DBbOCXN6/C?=
 =?us-ascii?Q?NANzIQX6EbxOe7ldh7p4EFYjdBByGmRo+I22wQhMUtkfdwsc5UMptGbA+b6v?=
 =?us-ascii?Q?QA3YRwjBTKwyJDY9OPBqQLgXQpY28CdxZ8S2lGbHoVQDm3kKXnQNs66N8FUQ?=
 =?us-ascii?Q?0Apj8tuOqTmLsC+ou75QiLfCcy4bIcebUZ4kU6CjNWrieHKODIa7eP2YYQSx?=
 =?us-ascii?Q?J89Qv2kwgb7ddaNK/Fh0AM2Fz/NQw0eFbBcfXh8cfaAGVpgQ4XfOnpEF8Z/J?=
 =?us-ascii?Q?pCewU/+ZhxiYXXJHdx82SSaFgFCaJMVgbO/1LlQccRXIqrfpgCvAq1oEG0Gb?=
 =?us-ascii?Q?+jn0unsNN6mddH81WN6k0Psf+3GSf3YaQeKdWPhVqDIssCdxg/9jpoUbv60s?=
 =?us-ascii?Q?9r4aRQfG9xQC2puulL/zAPY8GsKdqNuAzNwqeCDH7KJovFJuzGG4YZ9l5V8A?=
 =?us-ascii?Q?kZhVApN9MtlbrJaxCBbvOeWPQe9S65eyNmaG/Ew1VdmpR1gj7tJ7hJsWbMd8?=
 =?us-ascii?Q?UaF3Zf8tqUkrjRazONuYZwL9ctpySe5oTcONMHyHCKGIfk6U?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46ab1f03-2dc5-4344-0404-08deaa110a3e
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2026 19:12:09.7762
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 62cwOaw6l0PzOZ0ldwt6t0TH9pxhV1XwQu86vxF5GBwBsRnw8LgdvGuSLADfuJjbZr73QW7RUd8b2qeCHCW6zw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6898

On Fri, May 01, 2026 at 12:24:15AM +0800, Hans Zhang wrote:
> Use FIELD_MODIFY() to remove open-coded bit manipulation.
> No functional change intended.
>
> Signed-off-by: Hans Zhang <18255117159@163.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/pci/controller/dwc/pcie-nxp-s32g.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/pci/controller/dwc/pcie-nxp-s32g.c b/drivers/pci/controller/dwc/pcie-nxp-s32g.c
> index b3ec38099fa3..31e1169b8ab6 100644
> --- a/drivers/pci/controller/dwc/pcie-nxp-s32g.c
> +++ b/drivers/pci/controller/dwc/pcie-nxp-s32g.c
> @@ -139,8 +139,7 @@ static int s32g_init_pcie_controller(struct dw_pcie_rp *pp)
>
>  	/* Set RP mode */
>  	val = s32g_pcie_readl_ctrl(s32g_pp, PCIE_S32G_PE0_GEN_CTRL_1);
> -	val &= ~DEVICE_TYPE_MASK;
> -	val |= FIELD_PREP(DEVICE_TYPE_MASK, PCI_EXP_TYPE_ROOT_PORT);
> +	FIELD_MODIFY(DEVICE_TYPE_MASK, &val, PCI_EXP_TYPE_ROOT_PORT);
>
>  	/* Use default CRNS */
>  	val &= ~SRIS_MODE;
> --
> 2.34.1
>
