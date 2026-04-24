Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010066.outbound.protection.outlook.com [52.101.69.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA83323EA94;
	Fri, 24 Apr 2026 03:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777002364; cv=fail; b=A3kF3K5BpD8R7zcy+YcU3gj6xw60BiuxU2B5WjJBNj/ThPSrygjIEwQ41NiB9J76n7WjHvCJ5qF+Tz1+2FjVFCxRtIAFiqklAnC1HviLMzqAT673MW/PUF/YvVKakDGJmdJQuY3Fme9Li0eLCuOsmuKRKjFXRrZeUya+ydavWJ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777002364; c=relaxed/simple;
	bh=rk3VYSkYAaPN2ZZxpsx1Z2GyPFxE9/CRFm2HYsZ7oP4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tVFxtTfY1qtOEnSNc5R/HCt0byU49cPDkvrETPHWOqHQ2xDAq+2y6XeOdXCxC4Y1qa2eX93H4WrXslFGiKrgkL9OhQnSCVb5SHtopKoYWUJTZj4jezJ2LRcErjcSohtn7aODYscDT5UMEbvkr182PUa5AyIZlzDVU6dUC20QVuY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=iEC9gvDL; arc=fail smtp.client-ip=52.101.69.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="iEC9gvDL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t6THCJrsEcuyDaIS5iYKJJv13HfBhpSsqqytYyvoxRNK200yRC07HGsF9iY6V1CzId6rjEBZaLqfYtTUm9xSiiRSwwT3PG3pauJn/a+NEFcrP5Q2WGt0oCF1ag3yhjpOEtuSz+sgP6FbW5PiHDPeZQup5DqpmncTevCDHR/W0YvnYzgFcBXp4tyChcVi5RnFIblNGAvpS9zgGUpTXXKVR2joROCTMRmHhycIXzfOmAcR9ShJkpEVPQZZYTsUt33vsPwlzJ9LTOZRyulaIDEKV6FqV9PyxCeQ3fHJUa+74Df4GvOT1wANiUO0hO+9G7zjS4Dh6dV3CUPr1Cnh2hrEtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jWtxPk2LZK1xN5IifAGBjNI4Na0vNhUIBHblaRX7Skg=;
 b=gIPL0agk5BN/xKUdO9zSABu14nfs7vEbmT7LHEMVFsZJ1BGgtM1QjWcLzEWiy+iY5eu6L8YVHqRw/L4rvhjUgUmHxCtfIY4s9nM17tSoJF8JYSF3FqwQfbUZykNYj2Ei6V5Ru7q2BqGVqMiktkfY9z8y3e058DibqZBX1bQhnMmVYQoCqSU8Gz1C5xjyPvVuKmvXZBX4rZBbkSLeYDjbBYwaARuthGkB5KBzoUbjWOKtffYBYqf/EtCsCcki4ce81weiKiX4xBiCXJ8v8BDT0GCuOQ16zanz2li0OxHXGuOkt4mLJ+uQPHuY1Kgg0BfTE0hVI1EwxMvKybP9O8eg+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jWtxPk2LZK1xN5IifAGBjNI4Na0vNhUIBHblaRX7Skg=;
 b=iEC9gvDLs9p/d3OdRYVwwuZweo3fo30TaWgaU1n8ccGSESCyrsnHvAMaZCVJdmg6ELroq1PXm/Sqlqc3mKj0WrNi+SUef0j+1gaqd845DQEqEUP4hx+5VfPP1w90slXEz2Jg5T8Aw5n6EoiisJ38YkntmiLx4VxB706io59VD1vi8sPHa2cERqSSPYqCK7WB8E6kIx/YooFm24Umkqf3pgpOL60aXvFTcbmQC9Gmu0tYNoN7fNwZ7h0kQ9yAZ3PYyohn1e9bTJk0PjESay01DSBy4GLPvZJAXVHg25qIp56pr5rmosyigN6wfnxJeyfnNJ485796Sk2GLRYTWZqvBw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by PAXPR04MB9187.eurprd04.prod.outlook.com (2603:10a6:102:221::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.22; Fri, 24 Apr
 2026 03:45:58 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9846.021; Fri, 24 Apr 2026
 03:45:58 +0000
Date: Thu, 23 Apr 2026 23:45:46 -0400
From: Frank Li <Frank.li@nxp.com>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	bhelgaas@google.com, l.stach@pengutronix.de, lpieralisi@kernel.org,
	kwilczynski@kernel.org, mani@kernel.org, s.hauer@pengutronix.de,
	kernel@pengutronix.de, festevam@gmail.com,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/3] dt-bindings: PCI: imx6q-pcie: Add intr, aer and
 pme interrupts
Message-ID: <aernajxGnogO8BZz@lizhi-Precision-Tower-5810>
References: <20260424025735.1490772-1-hongxing.zhu@nxp.com>
 <20260424025735.1490772-2-hongxing.zhu@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260424025735.1490772-2-hongxing.zhu@nxp.com>
X-ClientProxiedBy: SA0PR11CA0017.namprd11.prod.outlook.com
 (2603:10b6:806:d3::22) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|PAXPR04MB9187:EE_
X-MS-Office365-Filtering-Correlation-Id: a1269769-2a1e-409c-9b59-08dea1b3ff32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|7416014|376014|19092799006|1800799024|56012099003|22082099003|18002099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	ZzfWFCTWfyf/8ej5Zh6EPYqIqsO6zcQDpdw3FqeIzqU7CA3NYwA2ZPY4KscukriHaU4JIH5QaQp+hnXd9gqqc43I+zyp5Akvlo/dXZF+xNYOhZUhchIznHlshwNafnZkUltGgjxoPwZ/Jc8REDgpLwCm0l8EGhrTdk2qvSChPZ9fE0KvO5Vwjt4zB3GzQnD8wVb5iJwpYbj7uq9zgkN9kFuWA7DKud2mNdUDbczVP4DwnKeYHJoFavinyXHxt+qzYn3i9iEMxKxHze+3J374Pd5sq0MB29kpgeZDbPlBQAOQNGUFWk4vYDFoQRhsb1FSj0Xa07UPK9O6EzHLh7jsquDOwd00KMkm5peT/kdP9hSjuBG1aRrXBHTGSzn1lXnyVAe2cSskObuK6IGjvRXpBYojVOP9YXVCMuxGWKSiUdS6Uby17lOFGMRJRt/oNq8te4dPlYJFp3Ssr+YjQ/94aigX0mjJ5JNDQEObwa6viAYxyOMUra5m4dx/pqiZSR6UqLrYOfM94JWkFvW+cS4U5DLVXG/cD8oFeREtjF7WMLQEIMIl5bjHciBWV/mFF3l200zhpoYHtOrVjz36Gir62w8ytTT1njNQlNyXkCNTb66Ww5s1Zi6i2WVb08L2dcft0/cWa4/vs+KWcSQAJT83TWC1MawvaAFISMFWzw+JHhnxsP34KfGZvPKdC7ktAaFmEqcVYT7AVJXmFNM6V34zj2qDxMipLvPPEhysBU0PoKvNzu1GRGoEBfYMTaEupIRn1UKvu7YDw5Mv4w/U25DGjceF89dE+DOCnyyIVGE1xQE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(7416014)(376014)(19092799006)(1800799024)(56012099003)(22082099003)(18002099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yzgSGcJu+XFNRQ8WS27miNkV3hmA4RF0lA77240xH9BSCxa9mlszqsLiHb+T?=
 =?us-ascii?Q?tqziRVNCH8sFic3fFhGyMFn2Csk7mQ8G7LWQMIp6uqOjGZtav80FLybkuoQo?=
 =?us-ascii?Q?gwWKSm+VXX+KgSs++xi8IPImnzUoU0jEcvKUni6JVng3Ci/kDVTA+PPzOnEH?=
 =?us-ascii?Q?qcQqc++ECBmzm/hzc1wKZlYSm2DnEPG+u4T+4v25TdcKs2S7BQQuXGOwm6/C?=
 =?us-ascii?Q?KqxRA45Rho0SnHqkXwdEECuH+jnEMDOZyuzPHe3KIsiO1C4unyXFXwf55Q9t?=
 =?us-ascii?Q?e4K4UWa/WaPoYkmrq6WHQ+yC9At0ZmPq56Ahy0RwiWlHOe6/9j8KVsjbtOnJ?=
 =?us-ascii?Q?YDGObDaGyVYHgTXltjNWmbFD1edRBXAe5GkAqSdvnueisUhzTgTdDpZUmbJp?=
 =?us-ascii?Q?BH3/5rWTGMevvXzqx/YsAzpduGGtwxsQIhxhBgUIWAjmNzUPCHXIPuG6EwZA?=
 =?us-ascii?Q?/Vq6yLU+Ps6ROBshJ3Y/sNT2xbawWHLaxQGQRJuZYpgtiy9T2LpnKefGCszR?=
 =?us-ascii?Q?wQAmdVE3v3/LQXbldJSGasXzM2GSJ1z9UaXyBovmWU1r/iMs8e11DDCiJhyN?=
 =?us-ascii?Q?8zp/YJFRFRw2jrRzuqkgkGZ/t+dsvT0VFq8YZhqroNnCGsUDD0Jqzr+QEMIg?=
 =?us-ascii?Q?8HLsjX1UG5KDBjiNt3VE5ZkoL9mLgpNGOsk9CrKLP7dMvGVvc2h2V4ryKx3Y?=
 =?us-ascii?Q?UG1GcVzuYRRtPz4Y3Vg6wtVd/3G41AuIFPps4q9Q47alqf26ipGmE9TZCJ0G?=
 =?us-ascii?Q?b6UOf9P1/8qXi9Onboj9pfN4vOMz2q2dCBWAnO2cg0sBpISoM3ud2ARYk6Tr?=
 =?us-ascii?Q?7WVMdCWIVuLk7gAe0TfCA0GV9Ih8WOoS6n7IjU1wnT9HQKSUj922GhfHwD+T?=
 =?us-ascii?Q?GZU9KwwjVn3YlvIFRPKdKcJ1Rg2agKIsamcH1yr1H2DxzFDcnajpiU0qfTzt?=
 =?us-ascii?Q?bzJgd2diI3xRxEcqTEiDdhBa/yT1crUN15CuSwuXJmh3INHiOfFhFxCH/4Ms?=
 =?us-ascii?Q?2nwrnfcBC/LFt2gTEgJ+hEZo9NZC6r+PBW8eYXNxvRoVvYYKPbhRIHf5DHf8?=
 =?us-ascii?Q?HAcgiBqrNHV8bFs+C6guYJLbj2IkZQgkkokvfvhK11fLc/K+k0ik+ZNjqOKA?=
 =?us-ascii?Q?ymI2IEFQMnRyocL6bfeyROAWk2f3zW33+60sGYxbIhEcgFsNchCmXUOKlnxA?=
 =?us-ascii?Q?EcM1Yi0Xsz8JKa/KnUxws0hksxN76CM+j/EL2Gw2KdxZ2fPRbZ3W6ca4594J?=
 =?us-ascii?Q?3SVm9EDq8DbPS7IamdAzZrych1gIRa65iFBLDOm6lKi9t9qriXSD6qy5/x7N?=
 =?us-ascii?Q?JfET+8cQTXu+xsUTL1fmJYrRYtXLvAu5RdspqN+zQFn8+dHvc5Ml79CL3XeJ?=
 =?us-ascii?Q?WitITjZ015lIvBkUbsCjkdPHHLFyK7sXpXiU2/29jspKrExM7/m40YrdnZ+w?=
 =?us-ascii?Q?jcdHOffq/Titd90ekZmCAqV3J//x/LHGZGEUe+8mlwb5T385fuaeIqu2Mk64?=
 =?us-ascii?Q?GPKwYL4e8wkJiuF/aO25wKLDbtxKW7VMvkuDhT0Mz6BfHT/TEHNAl+DJZG1c?=
 =?us-ascii?Q?VudPrQy+JQV0HG8WcF53AItrzOVu67vPMEgnhoPVYO781Qu0QAUVnGFnFvvL?=
 =?us-ascii?Q?It+xHa7YjbK9XYPNaAKGaMjBkOWXxB9LOr3SENiFfvEfR7bMDUJhcckDn0Pm?=
 =?us-ascii?Q?fJDZ/p6YSGj8d1IpuEA7eglNzRaThEvnkdVwXuPb9FkeMxYy?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1269769-2a1e-409c-9b59-08dea1b3ff32
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2026 03:45:58.7557
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O4jSjDExi82rg3HL1U8Sud02eINkIKvXRUy/hefIAUckk5ueIGVKfyDjhzD9TUMB7t4r+cPSMMvelA/7AAmHTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9187

On Fri, Apr 24, 2026 at 10:57:33AM +0800, Richard Zhu wrote:
> Add optional 'intr', 'aer', and 'pme' interrupt entries to the i.MX6Q
> PCIe binding to support PCIe event-based interrupts for general
> controller events, Advanced Error Reporting, and Power Management Events
> respectively.
>
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> index 9d1349855b422..badc7fcbd556c 100644
> --- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> @@ -58,12 +58,18 @@ properties:
>      items:
>        - description: builtin MSI controller.
>        - description: builtin DMA controller.
> +      - description: PCIe event interrupt.
> +      - description: builtin AER SPI standalone interrupter line.
> +      - description: builtin PME SPI standalone interrupter line.
>
>    interrupt-names:
>      minItems: 1
>      items:
>        - const: msi
>        - const: dma
> +      - const: intr
> +      - const: aer
> +      - const: pme
>
>    reset-gpio:
>      description: Should specify the GPIO for controlling the PCI bus device
> --
> 2.37.1
>
