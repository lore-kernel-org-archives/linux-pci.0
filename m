Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011029.outbound.protection.outlook.com [52.101.70.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6FB6182B7
	for <linux-pci@vger.kernel.org>; Wed, 25 Feb 2026 20:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772051316; cv=fail; b=dbNVoA78G4dBGEo7QVT2MOnn9eaq6eDgdPR2MHsl8Xc1c5lsujO3VTXIhHQLoz6ObVgPtot89YGiaAK53GuERZ27GBsgaZ9hZLdlqzBvmCJAZRddJXk8ehVvfG0XNAXcY9rjbNuFYHR10ZIEBxJ9m+JvtScg8p5vHPakCkt1RIU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772051316; c=relaxed/simple;
	bh=G4r8fyhSA6PV0IiStgZfSuoD5r01BbLV8Fg3bLfpYmw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZwcDwW/Fo3usC9L+ioZtxX70lZIOEB7tqD4z8qhE/j+FAVCzcnPBVQ66mlpYyaIF5svl1Al6K+N4pVQ/y2RRODTj2UGYA91zpEanGhORcioJdReWIS3mg5CXyvF8Hinf9oEH8MRuaTkRIW3ki4cbpijrWlDiNiQ1KjNPQzHKSJI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Kty6H2oy; arc=fail smtp.client-ip=52.101.70.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Kty6H2oy"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IloA14X+k07GrOOTkGYUiFCASgsI5W+2VpRwbgX7euk6lwDXbaHyKSKx3hIyYEhXscRwlOu8aNlqsFfDrt8UaiKca9+EGIbjFbVNaqcS3YZvfMPLwq5x4BiEmTHe27N/XDA5mVZt+mwJe0o9ptTewEPg6apSU/AsVqnCX4Ux3AGhaLYWwADk5PQm9v0MsWKCcHV75VlNT8dpoW4+9DvRwqjUz7/sxQyVaFKO9C+9Iys8rOHyEd2Ve3mClaFOH8ERVp+bgfsphDp2KSoXqerCQrFzwd2Y3t1haC18hEuBZ5BDPtgzK8REi3YYSJ5OI2mAFfHC0IC4hi+dOQcmIDfkZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gj3OszEHtmPIWUUBj1n+NvA+qMRft6+zZKMnxBeXbH8=;
 b=hNBoOVdSvyePgyp/+XEbxOn73CjEM57J+nQRKAy/p5+nfBaSnrdGjghnNE12ICp/b4m1FsK9KGa5I4g2cpevJf5FSwDsGsELVzk0qbZRyo0+Xm7J2yfPxKpEDyMOhZ/uCqxiTfCcCJsHqUw8p2RBJdi8KieXHhKshyc5rBjNI06+Zg1eJgTOktEKRO7NNLYHlsxmKhgoaEwVGinPDOlvRnt6bQHha71Y3/7msf3IUC05J39upaVAw5eYCBD/vav46aUcwPPsdnpcngVDdjl6FgkMMKlA5orMupX2LlUggzK4GiFkWryMm3JZBmpokE1mn+ovYisboix5PUDNAcjCDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gj3OszEHtmPIWUUBj1n+NvA+qMRft6+zZKMnxBeXbH8=;
 b=Kty6H2oyVxX+uWPjNH6utVj2ak+BYek7NFOakMNdlmNvbxl4vNPamFM25jDVA2/CZV9RQE41bhGltHVaBkOyDzsmp5DoWUlNXJjk8bxcl0flGdsMShiM7GVLtyQeSqdVQxAOAhJIs9nYFyzKCQNFbImt9vw4zVNMDHq/0L23fBEFRiRTqhstlRMsYsviFLIV/ET5YpBCCp/MoHGitMy/tEcBNQJXlQUltj7T0YubQYA6Eo4H4T14H98tqpZXxLGMBrxfBqaAUJsTSnLpY3NBdj5U66PH9d6FysGGxVcD+5e9cOdcehaSKfQCbxc2W5GKwLX5diIxXq/h5NteEmrwEQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by AM0PR04MB6817.eurprd04.prod.outlook.com (2603:10a6:208:17e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.15; Wed, 25 Feb
 2026 20:28:33 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 20:28:33 +0000
Date: Wed, 25 Feb 2026 15:28:26 -0500
From: Frank Li <Frank.li@nxp.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Manikanta Maddireddy <mmaddireddy@nvidia.com>,
	Koichiro Den <den@valinux.co.jp>,
	Damien Le Moal <dlemoal@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 7/9] PCI: endpoint: pci-epf-test: Advertise reserved
 BARs
Message-ID: <aZ9barLmVpQ0c7KQ@lizhi-Precision-Tower-5810>
References: <20260225170324.4033466-11-cassel@kernel.org>
 <20260225170324.4033466-18-cassel@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260225170324.4033466-18-cassel@kernel.org>
X-ClientProxiedBy: PH0PR07CA0046.namprd07.prod.outlook.com
 (2603:10b6:510:e::21) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|AM0PR04MB6817:EE_
X-MS-Office365-Filtering-Correlation-Id: feb2aeec-af07-40fd-58d7-08de74ac71dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|19092799006|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	09xDDdeE0fw6u+rE0jNTLYoHTLCEAk+uNY2jXQTEFBjlZQdfTHhfUDtXJwRpQiNXKqb3DFSWuw5V6u4FtuxVVsturYGj2jLUYNmtFkiVIHcM4/VtqDsI9DmTgKb+n0noWRHe8pD+0NU8Xkb0+kmyKn8goiYNdQLy4iWioxH5QXS1SCjc/U3RJs1kuw9GpvZ4LBn4UiSR/znkXbgoaOyber9YfRyRqp1pmc6/HecZWZ8a3O6/EzbXpzaIncKA6J5T9GEpmfXqU38JUG7YpxKScUDwJ0e+Eg7ISDtU3qLIT54m9lKD3aSdxwr91GO09AiM1E+rr2GV1R6QcsQA5hLF8KwnZl8AeIC+TrtMckIwrX8WwoZ2oVxKL0wfAEvVxWx7V+fWr/YGWxtAm5XzGCsRn1MGziTafAaaqGAWw/4kNK1RJAFHfckQfcML6Ui17wDkJlTdlmOEILgPVtnRsDFJbGga7yj+NGnnPp/GEmeGKmluPhLBlJDEs71e71VEotbrGmBbzg7w9NPc7hAdzHaOs3fb0A4zxCXGCyHa+wsjEiP/wnrb2f/RYD1R7s0N4OlG0xjEoBCCEy1s8U9WOOh9//8hor6B/uaPOB9M/Awyawf3QtndVPFbwGg1na+n/j3uv+YIdZnZRKZT3lUrzkiN2U2/cP4i+h1cqwnnaVivJw89pO/ypaFDsXmogfwM92PLK/uefELkOuKaZzMyHvxZ0ijMmL6/1coMgUoWj40Isj0eyJOZBE1bLJ0hjXYfQw5dLSnCfAtmZAOFR4bkCfIr4JJwSe8qE2qOBJ3/pw89AXA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(19092799006)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pl+5tiAzGDQoRzd6ecuO219WFW2u5CwY8kxbdQerVv1DZq3643X20FsqbKb9?=
 =?us-ascii?Q?ZcEwBuE1rwXxLI3Zy/NdIGS02Lv7OImnMLM0Hjc7XZSVasCMj4huVO/GTuY7?=
 =?us-ascii?Q?ry5omQelq5qxmhR/ALA41AzAisGZh72L7KC+E4ICsBpeKgMHWvsdLOdrHrcR?=
 =?us-ascii?Q?+qGV6oakcO+EjnMdbIo5z6YYE4MJVvIUhmnJw56McAODdEZIHT3wQJUmjCNT?=
 =?us-ascii?Q?1LmkwZM5lFVKh+axW1Gpxg5/sxxNaYpX5SQlBvaJozq9x5KpoK9EvM/4Ic0y?=
 =?us-ascii?Q?e/j0Q3p9BOKYCCNkYrdjRoANARu5q6n1aANQCqpSKJuj5vmEzMo6133H89lF?=
 =?us-ascii?Q?b3OBbpZQccbZLr1G/w4qHoOopaJF0XAcWCFZuKcOOLvgskRZ3Gmob8JSicY4?=
 =?us-ascii?Q?QZW6Ivj1JRL80fcssAEWiszN3PvI7DXkt5e7y4ydF8chC1T7OUNz4LGSNYqZ?=
 =?us-ascii?Q?MXbFaSqWcWbLPZeYiQKN9mwbGadKBExzeMb1ANjtH7FDpIuZ4jvZd76Nf0ZG?=
 =?us-ascii?Q?FVqjkrO312YWn4zp6HqrA3KFyzTzSNd0OFDx+yN+hpWl/25WPUwxYz1GsdMn?=
 =?us-ascii?Q?PcaPGU8srbGQXii8j0k3++fwoYdCNWAbtvjRgLsMiLEYY7JCYlyKrfa6/oW9?=
 =?us-ascii?Q?JejcAGVmWuXBcbZ2vYaArQ/IzbHUaWavuACMmnMC+3Mr+xHEiYlam6ffYDZW?=
 =?us-ascii?Q?jLk1arsEg1KvDnzEg4wg6yENT0k7hCYkawSnyZjujmDxljfA9GS4cUBF/BPu?=
 =?us-ascii?Q?1enNl9nOxZ6yoQY+OQ8ReDMUoXGh+nmgyT+2WgaQYCMVoprffBBOnNusGW+w?=
 =?us-ascii?Q?06KkmadE9AxshH2UAhYNgabCa1UdPIMYuw3EkCB35qDKSNW1UNgxN/MPs2ko?=
 =?us-ascii?Q?CoBjZRitEl7z2F9Vu0d15wD5AQV0wbr4m+cjVfobRQLcpSRMqU+sa5815TGG?=
 =?us-ascii?Q?+SopQ2aHBAlECfgRc9cuKZtBc1+Ew9R4VbXVjht+ZUz6ZBfAV3h90TGZC3ax?=
 =?us-ascii?Q?nEAIhmtW9HFi75eGSRAEQaHrsQAo//eKzdodC0JzB4ywKRHa+a/x4oW65GJx?=
 =?us-ascii?Q?LLTh2qsyziXz5huJvejN6XgxktzM5j85MZ3iLfNARpjbwfga55rKLY69W7W/?=
 =?us-ascii?Q?S9QiaoKmiZ5FoqZyJKe0q87b84E5AIKXvC8jFUI2t/RLJgr+qWBeV1tgRUTb?=
 =?us-ascii?Q?uktH8MVmckXd1flZmYex9pUaAzvR38dAQkCZ2NP6Y+si8tB7Ng0sszyWn/Db?=
 =?us-ascii?Q?e5ZrckQQmKMPB+cFHr/3G6Dyk+gqqh5v1FVHBTBfpE1VEO9A3o0HZC4ZIECe?=
 =?us-ascii?Q?SNrCsC06tM5TRW6jxi4XbyOT30ba2QrYRXwM7yMPdaUcq+JcGY2LznWuiKKA?=
 =?us-ascii?Q?1Rf4oFNEGF2c+Kv8dtWAgton8C2QNmVX/vAPqrAbcN1nPpkITzbXPCdPfL7X?=
 =?us-ascii?Q?mzsPgFSR77j0lNy9X0K7XIjcvrntSyk310ifuvtpbmAMY+q71XLEnxn9UG1Y?=
 =?us-ascii?Q?EvXud/qkkCjOteFYplQ/O67xhHYGPuyznOS4/WQvitMDzLJaFnZKMfrQGdCc?=
 =?us-ascii?Q?HSJNCXR+G7Qzar1yq9qYPNO2GUQtEtlci/C9Lv+XiVQv9jTideU/BvTqTGXG?=
 =?us-ascii?Q?1Y3cbKhl6LGICo3pZI34ifBhWfd3Q1SBKbJdosmAj84zIP9ejFoNfPSHw7Sy?=
 =?us-ascii?Q?A9mmuqiesM65ZZL6YLo/KZ3GewwxqC8/W+NB8zE+0dmAfN/2?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: feb2aeec-af07-40fd-58d7-08de74ac71dc
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 20:28:32.8044
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nj75Z5BZtGQcE5p7iM1BlLg1Rwz+ri9w4d8dSJoi35RDiis8gldggljAk1jGUWChk5nwIlA4uR96/rN/M3FUug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6817

On Wed, Feb 25, 2026 at 06:03:30PM +0100, Niklas Cassel wrote:
> Advertise reserved BARs as reserved in the Capabilities register,
> such that the host side driver will be able to skip reserved BARs.
>
> Tested-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> Reviewed-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---
Reviewed-by: Frank Li <Frank.Li@nxp.com>
>  drivers/pci/endpoint/functions/pci-epf-test.c | 24 +++++++++++++++++++
>  1 file changed, 24 insertions(+)
>
> diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> index 6030ae1373b1..14e61ebe1f11 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> @@ -65,6 +65,12 @@
>  #define CAP_INTX			BIT(3)
>  #define CAP_SUBRANGE_MAPPING		BIT(4)
>  #define CAP_DYNAMIC_INBOUND_MAPPING	BIT(5)
> +#define CAP_BAR0_RESERVED		BIT(6)
> +#define CAP_BAR1_RESERVED		BIT(7)
> +#define CAP_BAR2_RESERVED		BIT(8)
> +#define CAP_BAR3_RESERVED		BIT(9)
> +#define CAP_BAR4_RESERVED		BIT(10)
> +#define CAP_BAR5_RESERVED		BIT(11)
>
>  #define PCI_EPF_TEST_BAR_SUBRANGE_NSUB	2
>
> @@ -1112,6 +1118,24 @@ static void pci_epf_test_set_capabilities(struct pci_epf *epf)
>  	    epf_test->epc_features->subrange_mapping)
>  		caps |= CAP_SUBRANGE_MAPPING;
>
> +	if (epf_test->epc_features->bar[BAR_0].type == BAR_RESERVED)
> +		caps |= CAP_BAR0_RESERVED;
> +
> +	if (epf_test->epc_features->bar[BAR_1].type == BAR_RESERVED)
> +		caps |= CAP_BAR1_RESERVED;
> +
> +	if (epf_test->epc_features->bar[BAR_2].type == BAR_RESERVED)
> +		caps |= CAP_BAR2_RESERVED;
> +
> +	if (epf_test->epc_features->bar[BAR_3].type == BAR_RESERVED)
> +		caps |= CAP_BAR3_RESERVED;
> +
> +	if (epf_test->epc_features->bar[BAR_4].type == BAR_RESERVED)
> +		caps |= CAP_BAR4_RESERVED;
> +
> +	if (epf_test->epc_features->bar[BAR_5].type == BAR_RESERVED)
> +		caps |= CAP_BAR5_RESERVED;
> +
>  	reg->caps = cpu_to_le32(caps);
>  }
>
> --
> 2.53.0
>
