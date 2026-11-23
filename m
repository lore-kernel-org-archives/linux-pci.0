Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.83.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795452981;
	b=tTEwRbA2EZqqKLMUESqfid4UoWUpdTWw3fc0vlTPRHY/b/UQ70FAne6yMaqsGPP2ISeT
	 gekTFMCLnT+nbxQAWAnTKpVNMNDb5f2tsv/ZNsW4uwxkyPoUz/BSzg5guO5+EzzHApt4F
	 OoK9U6YbRaZMBfYyDzEgpfQw2kJ66cmteV5ubBcLkbbNxh70Bm3Xcd3IPeJwvpEOH2gUR
	 G4PaaP0MgQi3hGC4lfNgGrAdE/53gMDT31BaXVLPHur5+DV9tXsawuqBjIhnyFmu4LWzg
	 ZwnE8AGvmkYtVN6xnvq1CB/AuOc81Uez9vJILW0v51G7tOsE6dh6mmDn7AtCtOM90jg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795452981;
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
	bh=FV4g8wxHUrsaxZ8fea1wrl/W1FjlSngRQABDNLf4fFI=;
	b=hw1mogEcIlDWAvtpIU3gPW0G+NQPBtryasnl+b/NaO3pZ/7j8Ghp/oFHGuhfYLJRD1YH
	 RUl7qNE9bGea39wTq0QiBF/V8RQKWYz7Esf7xU9wI0wY7mYFg0nkR9vPenHxCpBMGuDWS
	 JqlMMh2+6jajyxHuU2Z3T9OmDHQ6jUJq4iMfpLsCb37v1crx05UIP81vGlvClo3rAZXXf
	 Ezo+A3ZpGdr2JfeitHQnQ/lae0rOCCrIhvGPPfKaliW9kh5hlBZJK0bWKDuIfuR1lqDt0
	 HfAqkr7WNRFDvZe3UD7pshA8WGfhqBTr5zW1EoPdypm9naJbIMpE07qlAQfAvUvzdUg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=vBFSsHlD;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.83.48
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013048.outbound.protection.outlook.com [52.101.83.48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDB77606A321;
	Mon, 23 Nov 2026 16:56:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BDB77606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=vBFSsHlD
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x7NGxfT6RYlBPMdGH8M/pBzhNa4PGzBe6IG3WqMGwxO5hZrSyJBofevWmskuusG47LRzpaiMGNBV0Qri4MI13y53x/cpgPhv7u9RdnlVgFxLmwsOIeXikbqwSuz/RudcIL1heh+xLcPBwyTf6vP8HG91fu7tjMo9VkOQBdybMhnXBcezwbUl0Mlt5YOGX4hxuXqD5xtK90nEIDxniBzLMttLZyrJJg0qHvQhIaDTuv93IboeusuWXJkX3Rc52F4Q+DfaqNrDo1bB/7xixsqfZjAVNOWPXijKSmBOHjJQgXRKjDicorqGs2z8F7Wtj4Csfwm/0fyrdMc5iMZxkiqn/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FV4g8wxHUrsaxZ8fea1wrl/W1FjlSngRQABDNLf4fFI=;
 b=hKGw89F/x+QTcQrQivkkJMovcCX50NQ+XNegkf10kIZj+va/MQ/ODgV/tSzB13P/h6DkGAIm0l6BXvnvxG7gaG9mP+0DLQ5FBMbr8W8sW5P4jTUdzQ4a1neUwREs0PKwYv5ZdsrEct7e4DA7//tMTbHG3bf91ZCbDlEBuAeEjZDjhnYQJtCOSw0v9wRmb+Bee+jTxaUWngzPjX06/aQRh2jOoMSL4gdQrny8WnkhHghwEy5HW6L6d5b62ecutnsrn5g6hNbkjzOmXnGHCCeJwdUE/b7sQL/arKoEzJ+LTiaNqWMrEnHu1si31GQByWSCHKEuiSdbf9cq7HhksvrPuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FV4g8wxHUrsaxZ8fea1wrl/W1FjlSngRQABDNLf4fFI=;
 b=vBFSsHlDXXRJPBvJ9JBXvaCPok6gjT0veAeUxHqDL4w6gPgNXXZ8QvCqaHCZCxVXu+epighlnoe7UiXL34bLdMTEDMJHK2RaIdtqfv7O4nW7aRN7gzxAx3xii0eQWbdoMPz/SZ1I1nugYMyRNiKdheNuV9ceLl9lKjKyPI1FAhN3tHmiVCAq9OWgeEMUrlfqKjNRoH7uodzg86NH+JwBHECfj7T37aYeDm3Q2+VAR79Ww1tZl+NEOdZp3gRkMqFIef9YaMKqd83V4T2DRAHr5toVYd1MQ5cTHyDaAOYn+tCtyVsG4sX/RwnATRjLD5ix1gpu2CX28GRV8cngsu0ynw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by AM0PR04MB12001.eurprd04.prod.outlook.com (2603:10a6:20b:73f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Mon, 23 Nov
 2026 16:56:18 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%4]) with mapi id 15.21.0639.012; Mon, 23 Nov 2026
 16:56:17 +0000
Date: Mon, 23 Nov 2026 10:56:06 -0600
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
Subject: Re: [PATCH 05/11] phy: qcom: qmp-pcie: Add PCIe endpoint mode support
Message-ID: <awRwJi0Wflbuox6i@SMW015318>
References: <20261122-nord_ep-v1-0-6d8839ffa9aa@oss.qualcomm.com>
 <20261122-nord_ep-v1-5-6d8839ffa9aa@oss.qualcomm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261122-nord_ep-v1-5-6d8839ffa9aa@oss.qualcomm.com>
X-ClientProxiedBy: PH8P221CA0028.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:2d8::28) To MI3PR04MB12438.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|AM0PR04MB12001:EE_
X-MS-Office365-Filtering-Correlation-Id: f7a70988-4684-4215-57ef-08df4982b12c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|23010399003|1800799024|366016|376014|7416014|261102123227099003|261028144727099003|261021121427099003|261021123027099003|261022105027099003|261022075727099003|261026121527099003|11063799006|261026140227099003|4143699003|56012099006|10067099003|22082099003|18002099003|6133799003|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	/9LYR1PgXWUk+hRt2X+R/qjyzeEeVwQGN/wO70VInPIn7YNl6HHIbksdBlSVCVDgXMPNEA1Mshr0hT9MUBNeEB/3uvE5uyEW5WiSotO4W53AeLkHlAlfbDXSobQNmn6KKpsrnmdsViAxKqWGmDun8DpPvakJ3XJ1n9mDqyp2GjJ3HOAx8ypZC5t02w8QfK3JYtEZ6IcHEWp7oiK5mil5aa6O2Vt5rfaoyEI+ji0WElPg1mPRh4qbuoTNPY8XJzDTpE1THImN81Y9MqOJ2I4S/fI2oUoRCKbemNUdUMhDI6Pqrmm+o7jzRziUCa1MqNN6elv6gz1LPywNY3XMeO12KrQ8eIlxzF9o8N2ZewCgev6VR81uIP3KEZJvVt6Su5CjKoJJDqj3FdEFTTlnJXOb2jRcazP2pcyADQvo2I9+qQwuflF68OOeqBBUz0vS7YcROoTtinv0TIcXjqXk8D/Hise9+lBn4e9z+GeNsx/mZVenls9ci46rKZJoFoP0uoNa1bsJiRS9hhH7GbDfFUrlMoJs7Ic/eqp7/cWo1Kvx6Y/qDuaG/IKhAypkbZViENExSHrfB7KSFvbKs9WQ5hhwyow6fMO/Ay+QlpTrqJGeuaGRtMWIlsnQakJd1QkuxJtnUr8+UKgIWPH4Az9ZC7STroFm+RImWMHLBKZU9SRiCNE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(23010399003)(1800799024)(366016)(376014)(7416014)(261102123227099003)(261028144727099003)(261021121427099003)(261021123027099003)(261022105027099003)(261022075727099003)(261026121527099003)(11063799006)(261026140227099003)(4143699003)(56012099006)(10067099003)(22082099003)(18002099003)(6133799003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1qFkDgoq93nUS4US3WiYna0QFp7V5r0A56k/hFKwZjyVQm/Hf2qms1R3umbr?=
 =?us-ascii?Q?JZk+eP3fIKBOQrBg4i9vw7Y97S2CNOiCuRJBE7HTdiH+PMf5wboNSBXl0pT/?=
 =?us-ascii?Q?8I8xwzYOE5ytBivFobaSJWKEm4NRsohqg9bIxUfNS6kf3bMUPnf/xAdcFwvW?=
 =?us-ascii?Q?qnKeCw641gdueZiB0RIFKrBL9Tr8LMgWVvD8NVg1yHb+H9ZV+omx/qdUsymN?=
 =?us-ascii?Q?0kEiDlY7HqL/fdqAgel0ZztU90hwE4vAUQyLfxZ7fnfUBDXRhr7LbYssykni?=
 =?us-ascii?Q?qerwLAoh5Txr0ehOfzM3+C0B054u87PolgQVjqMPr3HD1kXC8nb0f6qSeJpe?=
 =?us-ascii?Q?EsOZcv8mml4B701lmTzxQ+Sdcwkun1ChvhU7R90R7Tkfoy3DQxbhI8l5ChIU?=
 =?us-ascii?Q?GCB/MSegcFq9jtaaMxRsbkyRcNBviSXkMRgCy3FzonqJPhm0cnp+NdcTFsx2?=
 =?us-ascii?Q?5YRphxcgHtE6eU/7CBB7RCV1dnVe23e584H3wy/UvsimvsHGC3RgWMyXudTD?=
 =?us-ascii?Q?ogtYAZCUL/YXaONtjS5pxaFHlJeFqnj9mywPufP4gk/2y2L7s6zXt48eO0lX?=
 =?us-ascii?Q?CX8ebsJOxBxV8/fWtsd+4EtSiR9hC1XaXEsuxDv+w0KF4ajCJqzPV1zk43Ql?=
 =?us-ascii?Q?az0ghXkZ3216/QV82OmuSXNUFroKkQmXydbE7osuQZ5SkjgBfE5ODuoy2QrS?=
 =?us-ascii?Q?Zq231ihvVF4raOO+P2uc2wzfJ6K/Q2xlSOD/nbaW0C7D8BZHHpgU3SlCM1lZ?=
 =?us-ascii?Q?V+LJYbcT7W7PxZseyIinrJYRPXBkXOajdY4LpewVPo/Iv89OlCLlRztnvroM?=
 =?us-ascii?Q?7KzlDdHwxG3i8nRr+bFauCziFUD/3OnA2ojCjiWtk2iottO9ZshxSB74iYDm?=
 =?us-ascii?Q?NVYITR7EauHLjwK8NXTyK8dYgPg+ZR9gto3tEM/pegViwpQWqVZp5WQS5ZpD?=
 =?us-ascii?Q?ieNoK6w1ysJOGdg+D9eMlUdp51GA28rOKiFEMAuSTTz5D5x4H/HbmQzmPw+L?=
 =?us-ascii?Q?D/nWjj6Q85z/p/RWKNpypZQ55Wa1/CYiJ4h0Fl0w3nAvPKJJXigYdXLD2kz3?=
 =?us-ascii?Q?h6axW8PbJB5+lfMAfjA0MOKltjJXtiyj+IRfRKgt0sDzanlVscGwrKWMGUQ/?=
 =?us-ascii?Q?/n0tVTSzUshZ4TH5PSGSqTof9GbaHSmCuLA+uK93RV+wIuj56VB1QQaduvW4?=
 =?us-ascii?Q?3/zp+q3+S7TFhQ0v1T9ouxeOpv1ZVQvWmap11j/EVkJyXuLAtIDmNzXhgkr8?=
 =?us-ascii?Q?CysvP+RxOdh8MZKgxhtKNVrafUHPF97ue4g6VavB+C0Zwc9lLF2WwQBxgRiY?=
 =?us-ascii?Q?7nr4CWamYJr0x16ge7yaHTdM/8i+d1Y3mc9yp6P9mV1kNwV30+DoZ2XY81Ry?=
 =?us-ascii?Q?i9bBPJIcuK8bKXUSiGuw9OaUTgTtfhbpMx3jfpSMc566eA8ihiuh0qkKEsYs?=
 =?us-ascii?Q?JJOy1RwbSJ+QXzwRanKHwLC/4fksyD4x+xDv2yzyPYa84KbmXYK08p3qKkWL?=
 =?us-ascii?Q?O8Nn4yg/mAbZAXlaDYTflqvEnr9N00GhbCnaTDXZ4S/sp9+OUIH3YzRMJZWj?=
 =?us-ascii?Q?qaVh9pz9cxBUN/HjM7QVVW5D7jQrPe6VV8P9vlGfWkJiXt6LbifEw3ED00JE?=
 =?us-ascii?Q?/tCQBLAoC70X1993bCBfV8+jBxhu9QIm05Kw6v3EIxJZHdkdOiZRzyVQ1UcJ?=
 =?us-ascii?Q?hDavVCOQJhrb1J60x8Y6mMgT6uc/LxH1P3rvZoNwodqHxkvOLfGdFQdxGWaE?=
 =?us-ascii?Q?aqtZ5xrSf4Mt0ll/JJAR4d17JwN8L9ov5OJqm6rEuMWNN4kypIWO?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7a70988-4684-4215-57ef-08df4982b12c
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 16:56:17.9078
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vnf0VF3nxXwlD/weRncj+JzNO0O1xMmKWTU9j0ehxqYKf0DDTOyzP4NCrTOZ77CP5xghqYyAKDxczsB2kf39/f/F5whonK6hom+3Hbphsg8ix/bEXAma4Ccg+AwYK1cY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB12001

On Sun, Nov 22, 2026 at 08:26:18AM +0530, Krishna Chaitanya Chundru wrote:
>
> The register initialization sequence differs slightly between root
> complex and endpoint mode. Add a .set_mode() op that records the
> requested PCIe submode, and an optional per-config tbls_ep delta that is
> applied as a second qmp_configure() pass over the pll_common/txrxz/pcs
> blocks when the PHY was put into endpoint mode before power-on.
>
> Configs that do not provide tbls_ep are unaffected and continue to
> program only the root-complex tables.
>
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> ---
>  drivers/phy/qualcomm/phy-qcom-qmp-pcie-multiphy.c | 26 +++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie-multiphy.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie-multiphy.c
> index ccdb7748a9e1..21cf6adf7d60 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie-multiphy.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie-multiphy.c
> @@ -13,6 +13,7 @@
>  #include <linux/mfd/syscon.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> +#include <linux/phy/pcie.h>
>  #include <linux/phy/phy.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_domain.h>
> @@ -89,6 +90,7 @@ struct qmp_phy_cfg_tbls {
>  struct qmp_phy_cfg {
>         const struct qmp_pcie_offsets *offsets;
>         const struct qmp_phy_cfg_tbls tbls;
> +       const struct qmp_phy_cfg_tbls *tbls_ep;
>         const struct qmp_phy_init_tbl * const *pll_tbls;
>         const int *pll_nums;
>         bool port_split;
> @@ -121,6 +123,7 @@ struct qmp_pcie {
>         struct reset_control_bulk_data *nocsr_resets;
>         struct regulator_bulk_data *vregs;
>         struct device **pd_devs;
> +       bool is_ep;
>  };
>
>  struct qmp_pcie_multiphy {
> @@ -930,6 +933,7 @@ static void qmp_pcie_init_port_registers(struct qmp_pcie *qmp)
>         const struct qmp_phy_cfg *cfg = qmp->cfg;
>         const struct qmp_pcie_offsets *offs = cfg->offsets;
>         const struct qmp_phy_cfg_tbls *tbls = &cfg->tbls;
> +       const struct qmp_phy_cfg_tbls *ep_tbls = qmp->is_ep ? cfg->tbls_ep : NULL;
>         int i;
>
>         for (i = 0; i < cfg->num_regs; i++) {
> @@ -957,6 +961,15 @@ static void qmp_pcie_init_port_registers(struct qmp_pcie *qmp)
>                 qmp_configure(qmp->dev, port + offs->pcs_lanez,
>                               tbls->pcs_lanez, tbls->pcs_lanez_num);
>
> +               if (ep_tbls) {
> +                       qmp_configure(qmp->dev, port + offs->pll,
> +                                     ep_tbls->pll_common, ep_tbls->pll_common_num);
> +                       qmp_configure(qmp->dev, port + offs->txrxz,
> +                                     ep_tbls->txrxz, ep_tbls->txrxz_num);
> +                       qmp_configure(qmp->dev, port + offs->pcs,
> +                                     ep_tbls->pcs, ep_tbls->pcs_num);
> +               }
> +
>                 if (cfg->port_split)
>                         qmp_configure(qmp->dev, port + offs->txrxz,
>                                       tbls->port_split_post_cfg, tbls->port_split_post_cfg_num);
> @@ -1179,9 +1192,22 @@ static int qmp_pcie_disable(struct phy *phy)
>         return qmp_pcie_exit(phy);
>  }
>
> +static int qmp_pcie_set_mode(struct phy *phy, enum phy_mode mode, int submode)
> +{
> +       struct qmp_pcie *qmp = phy_get_drvdata(phy);
> +
> +       if (mode != PHY_MODE_PCIE)
> +               return -EINVAL;
> +
> +       qmp->is_ep = (submode == PHY_MODE_PCIE_EP);

feel direct save cfg->tbls_ep to qmp is simpler

	  qmp->tbls_ep = submode == PHY_MODE_PCIE_EP ? cfg->tbls_ep : NULL;;

Frank

> +
> +       return 0;
> +}
> +
>  static const struct phy_ops qmp_pcie_phy_ops = {
>         .power_on       = qmp_pcie_enable,
>         .power_off      = qmp_pcie_disable,
> +       .set_mode       = qmp_pcie_set_mode,
>         .owner          = THIS_MODULE,
>  };
>
>
> --
> 2.34.1
>
