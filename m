Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.83.26
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795453992;
	b=I45e4FaChbRVCvrVlPV+zlsrEWFMhlcfCRbKhSw4X4qk1Sz+DIW13SxsvSIDuqA+HEm6
	 I6KFL5qGCgS69J1BFrAQiGE3XB/JEzYM0csS1VLgFWJReATE95cCoRAjMCu+dvTOWxJX4
	 s5u04o5tCmrXY9R8VTQJaPVjmBHA3TU100Btly5V2bgRpkA3t14JGOV3whGnrEISeYhIL
	 AZTxDLZehgVoAXu4CzfaxpbiInF2fuwKjZ+KW2nWCzoeuT+A3mzFBP0LufZPPamGQ02eU
	 CrYcbX5TfeUJOBW9MOgPZzDohJ3bz4OXnZt67m8raysxVwL9A1AJbE05y//mNY2WGJg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795453992;
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
	bh=ONQNyGo5iY4S3L55kpo9OeUK61Dcern6tImyKMhiyS8=;
	b=qkiKUW8abcSWtd+Ng9FkDUcRJcLUE/W7M95Lymd3S2bRXf3sldhcAgIu08kKMVso4rYr
	 DqI0y1Asmg1FmAKRpc+6sjE8bdGtbrBtoWDyQqBhJMe5ah740IkrqsMg7Lm8zsC+oQtWl
	 QztCl3CvN+/qUDCm4CAs+kxJkq2PjITa4tVuawPWLENs5wPc+vHmak5yRFRLIgTqYhHDh
	 oZnu7q4lEHeH1SskV95wduzbKstVaUOGBBGhxvPMQVElglxOygZTcO+DxAUGxCMV8No2K
	 0Hv1MmchY//a3gzEPlengpA9csvxgbqfftyPX1nKiABKwLrbrOf2B69WFxjHeJo/W9g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=nbLhIiZR;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.83.26
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013026.outbound.protection.outlook.com [52.101.83.26])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5EAA606A31A;
	Mon, 23 Nov 2026 17:13:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A5EAA606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=nbLhIiZR
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q4n3n5cH5Cyh2pQ5v7FXzT6RjbcLbkOriMKUNySx1viOfUwyMH5HtccB7T+gTM8mNqqxmXoBmFQvTw3ScLPo7JqNi0TnhfAZIQQ4QQikCoakxy8oJAN7RWZuEdoJhsxO9PNc/q2dOLs2BNNV2aClgyXPxAZcOP5PTIIwIq677xDBRHzP3G8rBMj0v5PJ6NxXXHv05vEnPgg7rnJDbjBET/Vd50fqRZnHoYWPS/49CTogh97YQk4rRVCc67bMp64mU0xYyNfre+zjHQyiacRHXwFmo2pc9fFzAxw18/xzo+elipUlxPs3zEy+ydD7eMK66DSR8A610y7yZ/o1ZIbQ7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ONQNyGo5iY4S3L55kpo9OeUK61Dcern6tImyKMhiyS8=;
 b=ybPhRVk78U5dOitOPmDZ/AuNXjuJFB5NPiHXjDMtNMAJuWH9hnOYloOK3H7E/SyhOY3J2xkWoleiJWFT+nt8RtdyXj7cfDk4d5pSgJqRu476OYw0qRhLfroUMwb2mXC9x9cB15TqolmXBhLIV6ESWsp2z+1fvRkebBWNlDgYGHT7CbUMJV7XmjXlJWqD38tNnSfX6FYppP4S+yI7+55ZYng8RVwfVrzpL9pcphZsEwx5qE3UtYt5ZAgG+GtVfwYpyhCo2SalsfN1/HoTOf3DUQqNlxDY3daitGFzIJiXvT7UVGkCkZxnV5CvjhpoD95Kyxf+S4WBoYWnCCBk4W4jJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ONQNyGo5iY4S3L55kpo9OeUK61Dcern6tImyKMhiyS8=;
 b=nbLhIiZRkArv5NeII2wVvHt+spFjfP1ilZggTHdxtk2TZgjjPcs9mpbYsO4Pwu3TjdtsFXKb8sk1BP3hS1hdJkqLB8BzMM3hnTDNJUi2YaonjnaalRI9PS/KMqJ9V4+1WaHHCNJ1911bXfye1estvMRSKKz/XE9j2BwKDv33yBjIv538MnmK0q6L3yR2pW+5w1+BEVYRcALeIT5KW3g4XrLIBvVDBESTPaore57N8aUUYsdeC5PFZUM35visTcvSOyOh1UnQi741LWuVuxKf+khz8qLUqzbU4c0nr7B1CN89ifUOFBq3T3l3HYlAAbsZzfG+e8daQXmcLr6YLEveMQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by AM9PR04MB8383.eurprd04.prod.outlook.com (2603:10a6:20b:3ed::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Mon, 23 Nov
 2026 17:13:07 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%4]) with mapi id 15.21.0639.012; Mon, 23 Nov 2026
 17:13:07 +0000
Date: Mon, 23 Nov 2026 11:12:56 -0600
From: Frank Li <Frank.li@oss.nxp.com>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Frank Li <Frank.Li@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Niklas Cassel <cassel@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>, Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Abel Vesa <abelvesa@kernel.org>, mhi@lists.linux.dev,
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-phy@lists.infradead.org
Subject: Re: [PATCH 08/11] PCI: qcom-ep: Add Nord PCIe Endpoint controller
 support
Message-ID: <awR0GBjnekYKlHzA@SMW015318>
References: <20261122-nord_ep-v1-0-6d8839ffa9aa@oss.qualcomm.com>
 <20261122-nord_ep-v1-8-6d8839ffa9aa@oss.qualcomm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261122-nord_ep-v1-8-6d8839ffa9aa@oss.qualcomm.com>
X-ClientProxiedBy: PH8P223CA0024.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:510:2db::14) To MI3PR04MB12438.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|AM9PR04MB8383:EE_
X-MS-Office365-Filtering-Correlation-Id: 83b851bb-24d4-4003-179f-08df49850ac9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|366016|1800799024|19092799006|10067099003|261026140227099003|4143699003|5023799004|11063799006|56012099006|261022105027099003|261009223027099003|261021121427099003|261102123227099003|261028144727099003|261022075727099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	9WeSFEfqDuQYf1ERcQQj6h4mF+Mgyap3/5x6vCrm6YftJhfIuqDM9tgn0FqUacehtvVWq1HAGy5KS+WonWCgzghN2iz8VUrKkwAmsFodW8+fNBitPnoBhPCVRli2RpnxZxEz4jUsAW1IuiuoxSgkrZxhyYmMKxUs4jtaAb3XCmrhz3LpPbXl3oel88Ii2+yJUSQ56B/IEEnh94XXZDtVL4Ivo703rfvemWQYvy2JKB/7O5Vm7pCm4BWs5zozDc3THM+o2w3OSFoBpnHtUXx6Wti+5sYvmrQSbfOFHXaWXTE2+H1KSP/bPdZcdgdovM2Y/PZVAcGMWiYpSM/dw9ZkPuEB76xi1Wokdmc/97QN3R84J3kbZQ44RZmAoEeorlLC12GGNzgjk3uO53uZZreyEfkpQzXK1q3+QjqPrZOer81eJZa+VZ3tkEnBKvSZOS83ZAK3Lb6zHFaU1+Y32D2SGumuYphxBqlmDgJzuqpD9xQ8VwjjoktBE8jJiHZdy0vtjmbdpUmAKzzbRK7R7Zyf3epZbg6x9ajOL3USBswx37ttG8DqJoZz8c4GnXO/DpBT8DwcdM2joo+Gwa2CL1zToEIK20ZlcW7fTQ/DhrDxav4TFQTwN5AefZ/H4cjGSeaafCllA0sVJpVS+Zdn+S6x04Zh5bgNvvRqTyH1Dlfqmkc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(366016)(1800799024)(19092799006)(10067099003)(261026140227099003)(4143699003)(5023799004)(11063799006)(56012099006)(261022105027099003)(261009223027099003)(261021121427099003)(261102123227099003)(261028144727099003)(261022075727099003)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wdmD8ZxzEW2Fm8jq/OYvP1HTs8Aa6dTBDrUSh4s507D4rJejqdyVqijMFtEt?=
 =?us-ascii?Q?/czvr/mOK7W2yavmF2JzVAzRuStA4McCNJ+ZrTbdmtGPbScwg6OBVr/gae5Q?=
 =?us-ascii?Q?GNApJV2AIJov2MssTgqGz84uASi1ujivYaB16FFwyga+5obLSvbmQmpWDbVR?=
 =?us-ascii?Q?ahsDiowC5tw103ZLD6kD5FbFc4De/Y6iJRpbC5i+SzELTWzcikyoCWWGhqQ/?=
 =?us-ascii?Q?Xih2IhHe+DWK3uw2ABfGPdMeR1Sgvt0pvZ4pXmUCAr2hUF2NDHJdSdpv0gQR?=
 =?us-ascii?Q?1ej8nPBIxGg3Ffv8/znYVX/c9IKND5EDomRUFo4b3kL4wKm4UXSRwnqgm/ax?=
 =?us-ascii?Q?s9pDFTgVlI5xyh83f9P3mvYEvh9Oq+VvRfZL9XB2djSTF42UrXTmNRiYlxyJ?=
 =?us-ascii?Q?7X0ulzUPznYhWu7s2QwpD2lBv7FxK6tDbCIJ1NTSfZGBr77FahJfWz5dTETB?=
 =?us-ascii?Q?vr4MPszM79qEYFpX5RxOwDidAubBkquv+J5YU6gIlO9H9JMf9FiHJnKZWLdN?=
 =?us-ascii?Q?Jq5Af5I97KypMEmOZ9WcI0UperwUFS1aTDByfB2x9swHhDndZLaZbLlYNFDQ?=
 =?us-ascii?Q?L07THDbKSL9d5ayc8cwgIomaW5cAJwNSQoXxaQa09NWZcnhcP1RahlkAasc5?=
 =?us-ascii?Q?iF6Q2EpeMKukpqdzE7WP8cve9F1yZsMmNui7GkDkA3ERCvMLcSPEc6aD3MNd?=
 =?us-ascii?Q?qXOZkJveGX0ue5wFCzuArMcnDIq0c4M5KHgIJy9xE7b8snVObLDVx5gyvmYu?=
 =?us-ascii?Q?TRseJgllT351b7Qc68rGEKrJlLdIbaOpVaSvDYAQ2Fn/NmLBh/qssmJb4u/4?=
 =?us-ascii?Q?idkUW7v7nWg8TEqHTJxLHHy++JwUoGmZELYoE3v+Y3nk66xrDHppEN2k6J46?=
 =?us-ascii?Q?4ntKevA0XqAn2ovvlZMdwfCsz3ghmpj8/Rk/bxQ9VCWLzfWaAdissJhpf2v3?=
 =?us-ascii?Q?Qq93rKAWRvijU0AkYsRGWEGPr8X0iRsQwGlqqzACZl8uyNcevVjdPUSVtVVw?=
 =?us-ascii?Q?baXq+36sj1DX1wHv8NoMTDrXQhlGn3GpLc++e7aAiPBffxD8SIxDbcB72Zvv?=
 =?us-ascii?Q?PM07MRoyNlz/rGSWovTcha4Jf8JxtFxBrib8enrJHblVKTw/351dvvDSz2X9?=
 =?us-ascii?Q?SxTxvr3++H8Vod04+YZUgmKgJFRhUPgoRwNOmyQXrVyM7ye11cVHhOc+KLV0?=
 =?us-ascii?Q?qAEdzb2HCUQpo8+DjRnz7ttEIRrieZJIAq25K+Y0qicaWjHjvLE6bZfIUx2e?=
 =?us-ascii?Q?46q00zXOMZd6ppuZy77MGSTXdzg+F3eqxg8L6qPsnRZEs8w5XA2IuIHss3Tz?=
 =?us-ascii?Q?JzOvdBqcYYpTUsdNpIR8KE0/iuP9Di6qFsNJFdW0LqPVBW4l0MvnDqhJB+Fb?=
 =?us-ascii?Q?LOF4hbmmRTCYNbSi2r4/FHlb1TzSyVvr7Aq6d/pzrjxfARB+jkruZTfU4o41?=
 =?us-ascii?Q?zllh9DNy+M/DWNSuk5GEQLqQim3lP0dGzZKbYS3BGZq35pwnKgXnhwiEbt/I?=
 =?us-ascii?Q?U6IXDOIkbVekE3094/njcQGfHy8PjqcCBSIgtmUFBM83mI1FOGcTsUSlLP27?=
 =?us-ascii?Q?2LwOW4GkRQjarotJXLVU66vw5pbBirpTfPqv3vERhQtd29qOQ4mAIxSCqFXl?=
 =?us-ascii?Q?cwJRM9kfPLI5RNPYr1TJM6wCxqdGUVPsEk69bFuReQMmO3qF7PxwEccLX9PP?=
 =?us-ascii?Q?/6l2CE5eDmUShcYhXgQlUvh2yP6+nQ45JbmFNOdWSlfqey/JVgEKdZG2e9kT?=
 =?us-ascii?Q?W7XnfD8YgpZQJ9Buz4Dx7gjLMsL2ReNNW1k3I8T0w+wh9xcJz9Gw?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83b851bb-24d4-4003-179f-08df49850ac9
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 17:13:07.2425
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l2OOt4otx/9IJB/DYwRm/y/7vGd0FXptr3byUYxzlws/cJ61q62MUU3Fwr+0VkEo2EfNy9lo7T7SPKSBjYP/Adi6PQWt7IOzQlSA/kG1ycVzwfon+y7YTcp6SJD6KZlQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8383

On Sun, Nov 22, 2026 at 08:26:21AM +0530, Krishna Chaitanya Chundru wrote:
> Add support for the PCIe Endpoint controller found on the Nord platform
> via the qcom,nord-pcie-ep compatible. It supports HDMA, overrides the
> NO_SNOOP attribute and disables the MHI RAM parity check, and is MSI-X
> capable.
>
> The Nord HDMA block spaces its per-channel register blocks 4K apart
> instead of the dw-edma 256-byte default, so program edma.ch_space_sz
> from the SoC config.
>
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/pci/controller/dwc/pcie-qcom-ep.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
> index c794a2207df2..661bd8aac7cc 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
> @@ -171,6 +171,8 @@ enum qcom_pcie_ep_link_status {
>   * @disable_mhi_ram_parity_check: Disable MHI RAM data parity error check
>   * @firmware_managed: Set if the controller is firmware managed
>   * @msix_capable: Set if the controller supports MSI-X
> + * @ch_space_sz: HDMA per-channel register space size in bytes. 0 selects the
> + *               dw-edma default (256).
>   */
>  struct qcom_pcie_ep_cfg {
>  	bool hdma_support;
> @@ -178,6 +180,7 @@ struct qcom_pcie_ep_cfg {
>  	bool disable_mhi_ram_parity_check;
>  	bool firmware_managed;
>  	bool msix_capable;
> +	u32 ch_space_sz;
>  };
>
>  /**
> @@ -903,6 +906,7 @@ static int qcom_pcie_ep_probe(struct platform_device *pdev)
>  		pcie_ep->pci.edma.ll_wr_cnt = 8;
>  		pcie_ep->pci.edma.ll_rd_cnt = 8;
>  		pcie_ep->pci.edma.mf = EDMA_MF_HDMA_NATIVE;
> +		pcie_ep->pci.edma.ch_space_sz = pcie_ep->cfg->ch_space_sz;
>  	}
>
>  	platform_set_drvdata(pdev, pcie_ep);
> @@ -984,7 +988,16 @@ static const struct qcom_pcie_ep_cfg cfg_1_34_0_fw_managed = {
>  	.firmware_managed = true,
>  };
>
> +static const struct qcom_pcie_ep_cfg cfg_nord = {
> +	.hdma_support = true,
> +	.override_no_snoop = true,
> +	.disable_mhi_ram_parity_check = true,
> +	.msix_capable = true,
> +	.ch_space_sz = SZ_4K,
> +};
> +
>  static const struct of_device_id qcom_pcie_ep_match[] = {
> +	{ .compatible = "qcom,nord-pcie-ep", .data = &cfg_nord},
>  	{ .compatible = "qcom,sa8255p-pcie-ep", .data = &cfg_1_34_0_fw_managed},
>  	{ .compatible = "qcom,sa8775p-pcie-ep", .data = &cfg_1_34_0},
>  	{ .compatible = "qcom,sdx55-pcie-ep", },
>
> --
> 2.34.1
>
