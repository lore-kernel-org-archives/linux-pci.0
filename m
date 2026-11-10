Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.162.65
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794322834;
	b=jxI9UuCiaHBzRNODYpxylmi++3opcgrB037OCuFFhZ8hgBhOchNCtkdYsPxScqFe+1jX
	 xf2xdI07AC5O9XqtMQyFvSNLW2IYq9YAYUqBNC+y69RLD9wkstklDO0U/l+8Yp0FkTVLR
	 Cl4JWmYizdF6vGRc39nPeS6rxQKOFc946K3Fo9mz50rtT/RJNv2DE1QW5IGOz/KxG/GRe
	 +b7bNiSJMWRWCNwWfkDBhRSO2Wed/t9GVoS3bcMn58O2dHBcR/iGe7UsBMonJ5dnQNBa+
	 9S05q7WhnhEvWndBBiT59Pm1ngoi9Y4+E4VLO8GsHf+Pqqolz2EpOw0j0C6NDZoBUZQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794322834;
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
	bh=oe4/oAE5YpYDDcZ9HryhJB0UxdkzwRITAUAQd/1J27w=;
	b=EHKyml1FhkN7YVQrOL3iv9bZSBeIRX0ukAHNWMpHigJWlAEWIj1mVNDceynCLjhNvEpu
	 xPFzH4MI1PRhnv7/LLUcIrmPrIBEQZjwULh2voAaJKPEcEM0RuUGBNowwiN8hqsQH1aaQ
	 r47G7vSq4KDul069TwgEvLrcsC8ZNsPNYNe/Kz5KDGwE1BH5V1NvjenXyGaFclO4EPNrl
	 SgoUWt0UTrqPlaR4kvy3dWpx9ejTt6N7dN+8REGZIuVWF4IPIAoXQvKTELygC7avrksJh
	 oTh4TKnDReQyRy8zwCnzlkd9SQKjOEdiGa2Zo+cP8/kOP6PH5OAV9HlX+13tR2BWVfA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b="Dh/r9lYu";
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.162.65
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013065.outbound.protection.outlook.com [40.107.162.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D37760A2622;
	Tue, 10 Nov 2026 15:00:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8D37760A2622
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=Dh/r9lYu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ifFIQbav3l6vprdRYe/kRJV+EHuLyxHiYUQwBU40uyx6U9uZyEepb2DhB+GCZmKftVNi3+3FNrFsOHyzyZApJHBDWWdHAD5k9EsRoX5Sk9hFCg9ntaEvL0sqnCNfvpgDiNo4jv8pjw3R+lF7+FRc72cwbB+B942wj0ViWru8K1ZvIRxnehFaXrfrMRDmePoYmRm6Ku1eq4LmDwLbjtXT4zSe0hV/YGdeHRuAwS1uQL3qmDsHvWqJeiv6kXy9iHNVlypjFCcT5j0SiueOLLKrCtzsyFw8gUBovA8B+ByVqki5JrHX6hRCQzmMQWGdcm3CIyswOV4zrpd9USJYE7P61g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oe4/oAE5YpYDDcZ9HryhJB0UxdkzwRITAUAQd/1J27w=;
 b=Dt65rWEbKmCGBpe2+nasbrswE5VrrzNG1ytqsD/aYBTgZTFyJb/L3wl+pq1sk2ABOTm3TSXnxJMl0j7y1AQyQXFpz1d0Y1jWd3ukVBhZXqvW2IGzkUn32ARjztuhhOVLtrvlqmInBEW5O6onFGLygJavYAxHFpTgVQAdHErO7ZipcLMr++WM21SMu6dhPFYNK0GEp3mEC/1zYxcBk6IweYW0axVVFfPgc5hsj1v6d4S1NNA4qjCYLZYqd+saI6QqVqbaq1EaFMxVBmjMUvrRSdZCDPyZuBkWC/693prBe6JNM8FlJY5dGnpThacbZVrTPkpWhWeKcqv2AjeveK5qUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oe4/oAE5YpYDDcZ9HryhJB0UxdkzwRITAUAQd/1J27w=;
 b=Dh/r9lYu0OgSDdM95OdTHq6XiRzIz38rlAs9/7a1xJ4huvOAhS3X5i9klXi9qJXZeeHyoZWtVzM0dwWaZjihHIJc992eV/XRURhxZjxJDn8aAcBRYkPnA/MZq2buGb4WP1R5GsszWsALCoxdl0tPB3kPcOG89/FClvLtiq+ykg+N8coZ609x7fHYNziOxWH6aGcdVGunslQU38D3d2jmQWOwPcGAEoavY8kInDYUvqdXq6YFwueBGNB236bdxXXktlnzZDROzzyIKePTjcpMc5zNQh6lSbF0xmEAOtkzPs1weJvh0z2ajYlJbjaRaBvSENyXvyg9OxHLZYSE/d1acA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by VI2PR04MB11098.eurprd04.prod.outlook.com (2603:10a6:800:293::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Tue, 10 Nov
 2026 15:00:28 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%4]) with mapi id 15.21.0615.007; Tue, 10 Nov 2026
 15:00:27 +0000
Date: Tue, 10 Nov 2026 09:00:16 -0600
From: Frank Li <Frank.li@oss.nxp.com>
To: Koichiro Den <den@valinux.co.jp>
Cc: Frank Li <Frank.Li@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>, Niklas Cassel <cassel@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>, Jerome Brunet <jbrunet@baylibre.com>,
	linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, ntb@lists.linux.dev
Subject: Re: [PATCH v9 06/10] PCI: endpoint: pci-epf-vntb: Allow DMA and MW
 to share a BAR
Message-ID: <avMxgP-Q7ZE7FOZL@SMW015318>
References: <20261110082459.1798763-1-den@valinux.co.jp>
 <20261110082459.1798763-7-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261110082459.1798763-7-den@valinux.co.jp>
X-ClientProxiedBy: PH7PR02CA0024.namprd02.prod.outlook.com
 (2603:10b6:510:33d::10) To MI3PR04MB12438.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|VI2PR04MB11098:EE_
X-MS-Office365-Filtering-Correlation-Id: 1bad18c2-afac-4448-0740-08df3f3b5b47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|23010399003|19092799006|261028144727099003|10067099003|11063799006|4143699003|56012099006|261021121427099003|261021123027099003|261022115727099003|261022075727099003|261022105027099003|261009223027099003|261026135527099003|261026140227099003|261102123227099003|261026121527099003|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	Doq+R7lKa8tYyJn17sPBCnSBPDAhj/uW3jzc4PJuVKrG+UXXY+i/Am7CxmvqV6pD6OqxwN7OuQOnzvBmhtASc/6X8CajPCXAs1SkwGz9Qee1OD5jmnn3GnUEGlplbGdAVQhRLHil3DJpi/RO57wGr/iWDrTRd+mkEFQex+BMT3DgRHsDqfQnY22WolnFPU7ppFME7nDvrw15EISVpzO9cLEW/GH5IPhx5zhqsmuDl4qq5+XSg7vMCoyVey1Yn5s2K/iL/GcDLnG3nWKOYkswF3SweQnxebd93++kOFr9VRJIH3BgezYNClrWuhievM85vmw4M/Hr3Ki50gfz125pJ7Hzp2ZDCw9iworbMxeQ29tl2sNIkuXbDCyiMar8pkjwMPHeSEkCYJo9MLf3ajJQQ99emIvXc4m5gVwWxV0aIcmfFaiNREwhyWmAuOoQfrlWXaLJTsXgi+yeqjHnb1JApkeXDPsNV/+5wkmtXG6zcLgXX7ytTV8qY2z/eGkaNzsAHLA/W5LwbE3FsDRnyjGRJwBxXjnuVvM2CpwoTN3EbhQzbGeHvUhLNqVy7Pk/8ro3hRpbJRujfleWS6ILnfaal+czsTOXxt+BFq+OXHZLvWMnscZxRh//tevXIVnXydc0
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(23010399003)(19092799006)(261028144727099003)(10067099003)(11063799006)(4143699003)(56012099006)(261021121427099003)(261021123027099003)(261022115727099003)(261022075727099003)(261022105027099003)(261009223027099003)(261026135527099003)(261026140227099003)(261102123227099003)(261026121527099003)(22082099003)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HpyDzRFc+71nD9W2tYWYXoUO8DtmrrkmBmt6JM9uweVmSY3SCCNKCj4ttFhl?=
 =?us-ascii?Q?yCEZg5Yfmeu3w8S++syolYF9zD5zIdeEfSEMc3E849qubobr2DPEr/lwyqFv?=
 =?us-ascii?Q?j3pM9npnfj0biPVov2k/EmZvgh0HmU0uejRabHbnWyvytoSLwGQGtd9/9r6a?=
 =?us-ascii?Q?jtla/tIAh5W8DwExgO2EryvhHwpLweNsc9b3b935erxb6Z2i4tGDRGwFvruE?=
 =?us-ascii?Q?82yT+lBwArGm5cbPRQaqbB/6jPNnEZ/pxJbhbhKgojj4Yk/t4w4WKNbCGwHt?=
 =?us-ascii?Q?xfHO2bDM7XV3lkcurcmbww8HwpOZ4Lp2p/zN82SbVRDaRxqNIsoAEjJ5uxK2?=
 =?us-ascii?Q?7UZn0pgr7dEzCWXFeS6YTi/dnTgxQNCMugCjw1I4Be6/Q9KLZ58pQBqaBt/6?=
 =?us-ascii?Q?aPZl9DAPwjQ2tA6ZexVYeaacuLONaeclj9ahJjm6hJZWZnhbEYMJOC6V7anm?=
 =?us-ascii?Q?W5Q3j1si9tUa+Cu/uhlyjuvhIJ4d6Wn/3+l39wLVxT5hcLkXZFQ95QxoKoCZ?=
 =?us-ascii?Q?zLnZbpUfARTl5tcZphRX7sp9L+itCt8zddC6F29Bl9j6VP+OrhJ/BLEsAgOB?=
 =?us-ascii?Q?i4BUdCxgcW4Q/ADX3u0gLf0wpHGVy6saiHOK0LNRf7kNNVFW7UJTkgXrSU/V?=
 =?us-ascii?Q?8TdEmiPpX2VOzpf9w5MJnaqU4Jd5aP4rK+25EnJ/9bePiKUndVLaa+WZqzsy?=
 =?us-ascii?Q?p3GBMOQQrCC+gZ19khsfAOOX7JSp8vD0cMsVrpvZ9Lq/WI8Iqpq9kLg80/Ty?=
 =?us-ascii?Q?3Sq4NdkNmOJ5mHjuF6QMBaWmzRppyVVpByvNL0y/cE+hh27UXxrXwhlazexE?=
 =?us-ascii?Q?gIuUitW9n0XI0yLM7EftXKQbpc35VdKRQ/jOcptrr8YEnbbL1gR+QC2UvC04?=
 =?us-ascii?Q?3yk+hUKCicFFjsieP3DF7ay2GTginiERp5hfxlAi5NNyfI2VtlgVo3QtIW8y?=
 =?us-ascii?Q?PgQ1VtBzhc0aVtySCoAGZb7Onng17w57JkjbGcTe6s9xE+H02eCa5jmKwM4c?=
 =?us-ascii?Q?QgjVQlphqpJ8rLuoZKxYzjHRTGeg5/xHf3VW3mE0j7HemXb6oVvoVaZ5XjrZ?=
 =?us-ascii?Q?uLZiVp2PLAh0lveOAFA9W4DiMG3ZaIbo6PauXZC7w11uq/e8T585vHCWvno2?=
 =?us-ascii?Q?p2CEu71lOpxIwAS54lToNkc8lby1k2PeazoHe20XRvDKse+3ZnPYqsXxNFm9?=
 =?us-ascii?Q?0fCYw5jQco3BjdX6qB0trdlCWwwXHhvYxqDZ7X+J4NeeZiuUjC3eHo3ytnjL?=
 =?us-ascii?Q?Actv0kR7e7kcuOJZArGLCQwVyjKmP7iIRAYYtmeR2ILxURe6IBOUQQ4zxm7v?=
 =?us-ascii?Q?xywFmi/u55vBoQnoWYyqEhjF4LYwXEJ92xEA32jnEYxwGcL4A8Qr+qFoiwAx?=
 =?us-ascii?Q?jAJ9arrVwew4KB0b5gu7Gt4G+Ppe8uk99R6n5Egiyz/lTq7hh3OsS1gQvQfw?=
 =?us-ascii?Q?eeaUdPkfR4QXcSnDulUABce6GWSqpF/Md01pKSD7BQcPIjOLZHyMXFMIf9mT?=
 =?us-ascii?Q?miLTqZpzYRyygCWCpvuNlL0Edz8dGcnr5kMkCkWRkyEv4PUv9595KcC2h38n?=
 =?us-ascii?Q?hhYmJnSWQW0y8CdkAhF5NYAM4SKmz7OnOrcYzzxhza535hIL8fStjQS3EnLX?=
 =?us-ascii?Q?47yrhSuvkq/cifHXy/LSoAPX8GO0ZF92gNHeR00Rf4PwsQCj9hm2MW4dbytq?=
 =?us-ascii?Q?CkUPOC6rNPByFVrq1C7fcl2+JojKobUYRj/FPjKUL0fxgIMx8tHtuOA87UyG?=
 =?us-ascii?Q?h5Yczw+q5ht1Zk6jvxlSo48YibNOmzZgng8qzunf/R2LFPfWUA74?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bad18c2-afac-4448-0740-08df3f3b5b47
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 15:00:27.9061
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xUs83CUsZRHdWXi7qe2esgzRomxZ0DJe/7BSV/S/60dErvbZsap8DBstJC2SfpA97FFTw8AmmNMZTtPDSKjk3JK6Ub9Sgo2BwfRE1sN1Cnf1YUrQkA3CO2yZvE/BVc+A
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB11098

On Tue, Nov 10, 2026 at 05:24:55PM +0900, Koichiro Den wrote:
> Some endpoint configurations have no spare BAR for DMA resources. Allow
> dma_bar to select an MW BAR and place the DMA ranges after that MW.
>
> DMA submaps have fixed BAR offsets, so a shared MW translation must
> cover its configured size. Keep the power-of-two restriction used for
> ordinary MWs. The size must also meet the EPC's alignment requirement
> for the following DMA submaps.
>
> Older hosts treat the whole BAR as an MW. Fall back to that layout when
> LINK_UP does not advertise MW/DMA boundary support, so that NTB keeps
> working without DMA: the enumerated BAR size is kept, the MW spans the
> whole BAR and the DMA submaps are removed.
>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
> Changes in v9:
>   - Report BAR-sized address alignment for shared-BAR fallback.
>     (Sashiko, #1)
>   - Reject partial shared MW requests without letting ntb_transport
>     round them up. (Sashiko, #2)
>   - Check the shared BAR number and MW offset alignment at bind time.
>     (Sashiko)
>   - Drop R-b tag due to the changes.
>   - Link to v8: https://lore.kernel.org/r/20261022082230.3164834-7-den@valinux.co.jp/
>
> To reviewers (esp. Frank):
>   Compared to v8, this may look like replacing the size_align change
>   with an addr_align change, but they apply to different paths.
>   Let me explain for clarity:
>
>   M = configured MW size, B = full shared BAR size. Values are v8 -> v9.
>
>   Path                   size_align    addr_align
>   ---------------------  ------------  -------------------------
>   Non-shared MW          1 -> 1        4 KiB -> 4 KiB
>   Shared, DMA submaps    M -> 1        4 KiB -> 4 KiB
>   Shared, fallback       1 -> 1        4 KiB -> max(4 KiB, B)
>
>   With DMA submaps, size_align = M could make ntb_transport round a
>   partial request up to M while allocating a smaller buffer. Returning 1
>   lets the existing full-size check in mw_set_trans() reject that
>   request instead. Supporting smaller MWs is left for later. I doubt it
>   would be worth complicating, just to support max_mw_size limitation
>   for such shared BAR cases, which people may not use. Addresses
>   (Sashiko, #2).
>
>   In fallback mode, the mapping covers the whole BAR even for a smaller
>   request. DWC requires a B-aligned target, so report that alignment.
>   size_align stays 1, so smaller translations remain allowed. Addresses
>   (Sashiko, #1).
>
>  drivers/pci/endpoint/functions/pci-epf-vntb.c | 220 ++++++++++++++----
>  include/linux/pci-epf-ntb.h                   |   3 +
>  2 files changed, 178 insertions(+), 45 deletions(-)
>
> diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> index 875a7a9e487f..ba2df2ee991c 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> @@ -84,15 +84,17 @@ enum epf_irq_slot {
>  #define MIN_DB_COUNT			(EPF_IRQ_DB_START + 1)
>
>  struct epf_ntb_dma {
> +	struct mutex lock; /* Serialize DMA submap and MW updates */
>  	struct epf_ntb_dma_ctrl ctrl;
>  	struct dma_chan *dchan[EDMA_MAX_RD_CH];
>  	void *bar_scratch;
>  	dma_addr_t bar_scratch_phys;
>  	size_t bar_scratch_size;
> -	struct pci_epf_bar_submap submap[EDMA_MAX_RD_CH + 2];
> +	struct pci_epf_bar_submap submap[EDMA_MAX_RD_CH + 3];
>  	struct pci_epf_bar_submap *reg_submap;
>  	unsigned int num_submap;
>  	u16 rd_ch_cnt;
> +	bool mw_fallback; /* The MW spans the whole shared BAR */
>  };
>
>  struct epf_ntb {
> @@ -229,6 +231,22 @@ static bool epf_ntb_is_bar_used(struct epf_ntb *ntb,
>  	return false;
>  }
>
> +static u64 epf_ntb_dma_bar_offset(struct epf_ntb *ntb, enum pci_barno barno)
> +{
> +	unsigned int i;
> +
> +	for (i = 0; i < ntb->num_mws; i++)
> +		if (ntb->epf_ntb_bar[BAR_MW1 + i] == barno)
> +			return ntb->mws_size[i];
> +
> +	return 0;
> +}
> +
> +static bool epf_ntb_dma_shares_bar(struct epf_ntb *ntb, enum pci_barno barno)
> +{
> +	return ntb->dma && ntb->epf_ntb_bar[BAR_DMA] == barno;
> +}
> +
>  struct epf_ntb_dma_filter {
>  	struct device *dev;
>  	int chan_id;
> @@ -353,6 +371,7 @@ static int epf_ntb_dw_edma_collect(struct epf_ntb *ntb,
>  	unsigned int i;
>  	size_t align;
>  	u32 next = 0;
> +	u64 offset;
>  	int ret;
>
>  	if (ctrl->u.dma_ctrl.reg_layout_data != EDMA_MF_EDMA_UNROLL)
> @@ -371,10 +390,30 @@ static int epf_ntb_dw_edma_collect(struct epf_ntb *ntb,
>  	if (!is_power_of_2(align))
>  		return -EINVAL;
>
> -	if (epf_ntb_is_bar_used(ntb, barno) ||
> -	    pci_epc_get_next_free_bar(features, barno) != barno)
> +	if (barno == ntb->epf_ntb_bar[BAR_CONFIG] ||
> +	    barno == ntb->epf_ntb_bar[BAR_DB])
>  		return -EINVAL;
>
> +	offset = epf_ntb_dma_bar_offset(ntb, barno);
> +	if (pci_epc_get_next_free_bar(features, barno) != barno ||
> +	    (!offset && epf_ntb_is_bar_used(ntb, barno)))
> +		return -EINVAL;
> +	if (offset > U32_MAX)
> +		return -EOVERFLOW;
> +	if (offset && (!is_power_of_2(offset) || !IS_ALIGNED(offset, align)))
> +		return -EINVAL;
> +	dma->ctrl.submap.offset = offset;
> +	next = offset;
> +	if (next) {
> +		/*
> +		 * submap[0] covers the MW prefix. Keep its temporary
> +		 * target at address 0 until the MW translation is
> +		 * installed.
> +		 */
> +		dma->submap[0].size = next;
> +		dma->num_submap = 1;
> +	}
> +
>  	dma->ctrl.magic = EPF_NTB_DMA_MAGIC;
>  	dma->ctrl.revision = EPF_NTB_DMA_REVISION;
>  	dma->ctrl.type = EPF_NTB_DMA_TYPE_DW_EDMA;
> @@ -408,7 +447,7 @@ static int epf_ntb_dw_edma_collect(struct epf_ntb *ntb,
>  		chan->desc_addr_lo = lower_32_bits(dma_addr);
>  		chan->desc_addr_hi = upper_32_bits(dma_addr);
>  	}
> -	dma->ctrl.submap.size = next;
> +	dma->ctrl.submap.size = next - dma->ctrl.submap.offset;
>
>  	dma_dev = ntb->epf->epc->dev.parent;
>  	for (i = 0; i < dma->rd_ch_cnt; i++) {
> @@ -481,6 +520,8 @@ static int epf_ntb_dma_collect(struct epf_ntb *ntb)
>  	if (!dma)
>  		return -ENOMEM;
>
> +	mutex_init(&dma->lock);
> +
>  	switch (ctrl->u.dma_ctrl.reg_layout) {
>  	case PCI_EPC_AUX_DMA_REG_LAYOUT_DW_EDMA:
>  		ret = epf_ntb_dw_edma_collect(ntb, dma, ctrl, resources, count);
> @@ -551,7 +592,7 @@ static int epf_ntb_dma_bar_init(struct epf_ntb *ntb)
>  		return -EOPNOTSUPP;
>
>  	barno = ntb->epf_ntb_bar[BAR_DMA];
> -	mapped_size = dma->ctrl.submap.size;
> +	mapped_size = dma->ctrl.submap.offset + dma->ctrl.submap.size;
>  	/*
>  	 * Submaps cannot be installed until the host assigns the BAR address.
>  	 * Use address 0 for the temporary BAR Match Mode mapping, as is done
> @@ -607,23 +648,29 @@ static void epf_ntb_dma_bar_clear(struct epf_ntb *ntb)
>  	memset(bar, 0, sizeof(*bar));
>  }
>
> -static int epf_ntb_dma_set_bar(struct epf_ntb *ntb)
> +static int epf_ntb_dma_set_bar_locked(struct epf_ntb *ntb, bool use_submap,
> +				      const dma_addr_t *mw_addr)
>  {
> -	struct pci_epf_bar_submap *old_submap;
>  	struct epf_ntb_dma *dma = ntb->dma;
> -	unsigned int old_num_submap;
> -	struct pci_epf_bar *bar;
> +	struct pci_epf_bar *bar, old_bar;
> +	dma_addr_t old_mw_addr;
>  	int restore, ret;
>
> -	if (!dma)
> -		return -EOPNOTSUPP;
> +	lockdep_assert_held(&dma->lock);
>
>  	bar = &ntb->epf->bar[ntb->epf_ntb_bar[BAR_DMA]];
> -
> -	old_submap = bar->submap;
> -	old_num_submap = bar->num_submap;
> -	bar->submap = dma->submap;
> -	bar->num_submap = dma->num_submap;
> +	old_bar = *bar;
> +	old_mw_addr = dma->submap[0].phys_addr;
> +	if (use_submap) {
> +		if (mw_addr)
> +			dma->submap[0].phys_addr = *mw_addr;
> +		bar->submap = dma->submap;
> +		bar->num_submap = dma->num_submap;
> +	} else {
> +		bar->submap = NULL;
> +		bar->num_submap = 0;
> +		bar->phys_addr = mw_addr ? *mw_addr : 0;
> +	}
>
>  	ret = pci_epc_set_bar(ntb->epf->epc, ntb->epf->func_no,
>  			      ntb->epf->vfunc_no, bar);
> @@ -631,8 +678,8 @@ static int epf_ntb_dma_set_bar(struct epf_ntb *ntb)
>  		return 0;
>
>  	/* A failed dynamic update may have already removed the old mapping. */
> -	bar->submap = old_submap;
> -	bar->num_submap = old_num_submap;
> +	dma->submap[0].phys_addr = old_mw_addr;
> +	*bar = old_bar;
>  	restore = pci_epc_set_bar(ntb->epf->epc, ntb->epf->func_no,
>  				  ntb->epf->vfunc_no, bar);
>  	if (restore)
> @@ -642,6 +689,51 @@ static int epf_ntb_dma_set_bar(struct epf_ntb *ntb)
>  	return ret;
>  }
>
> +static int epf_ntb_dma_set_bar(struct epf_ntb *ntb)
> +{
> +	struct epf_ntb_dma *dma = ntb->dma;
> +
> +	if (!dma)
> +		return -EOPNOTSUPP;
> +
> +	guard(mutex)(&dma->lock);
> +
> +	return epf_ntb_dma_set_bar_locked(ntb, true, NULL);
> +}
> +
> +static int epf_ntb_dma_link_up(struct epf_ntb *ntb, u32 argument)
> +{
> +	struct epf_ntb_dma *dma = ntb->dma;
> +	struct pci_epf_bar *bar;
> +	bool fallback;
> +	int ret;
> +
> +	if (!dma || !dma->ctrl.submap.offset)
> +		return 0;
> +
> +	fallback = !(argument & EPF_NTB_LINK_UP_DMA_MW_SUPPORTED);
> +
> +	guard(mutex)(&dma->lock);
> +
> +	if (fallback == dma->mw_fallback)
> +		return 0;
> +
> +	if (fallback) {
> +		dev_warn(&ntb->epf->dev,
> +			 "Host does not support MW/DMA BAR sharing, exposing the whole BAR as an MW\n");
> +		/* Replace installed DMA submaps until the MW is set up. */
> +		bar = &ntb->epf->bar[ntb->epf_ntb_bar[BAR_DMA]];
> +		if (bar->num_submap) {
> +			ret = epf_ntb_dma_set_bar_locked(ntb, false, NULL);
> +			if (ret)
> +				return ret;
> +		}
> +	}
> +	dma->mw_fallback = fallback;
> +
> +	return 0;
> +}
> +
>  /**
>   * epf_ntb_configure_mw() - Configure the Outbound Address Space for VHOST
>   *   to access the memory window of HOST
> @@ -780,7 +872,9 @@ static void epf_ntb_cmd_handler(struct work_struct *work)
>  					     EPF_NTB_COMMAND_STATUS_OK;
>  		break;
>  	case EPF_NTB_COMMAND_LINK_UP:
> -		ret = epf_ntb_set_link_enabled(ntb, true);
> +		ret = epf_ntb_dma_link_up(ntb, argument);
> +		if (!ret)
> +			ret = epf_ntb_set_link_enabled(ntb, true);
>  		if (ret < 0)
>  			ctrl->command_status = EPF_NTB_COMMAND_STATUS_ERROR;
>  		else
> @@ -1269,6 +1363,7 @@ static void epf_ntb_db_bar_clear(struct epf_ntb *ntb)
>   */
>  static int epf_ntb_mw_bar_init(struct epf_ntb *ntb)
>  {
> +	bool shared;
>  	int ret = 0;
>  	int i;
>  	u64 size;
> @@ -1278,22 +1373,25 @@ static int epf_ntb_mw_bar_init(struct epf_ntb *ntb)
>  	for (i = 0; i < ntb->num_mws; i++) {
>  		size = ntb->mws_size[i];
>  		barno = ntb->epf_ntb_bar[BAR_MW1 + i];
> -
> -		ntb->epf->bar[barno].barno = barno;
> -		ntb->epf->bar[barno].size = size;
> -		ntb->epf->bar[barno].addr = NULL;
> -		ntb->epf->bar[barno].phys_addr = 0;
> -		ntb->epf->bar[barno].flags |= upper_32_bits(size) ?
> -				PCI_BASE_ADDRESS_MEM_TYPE_64 :
> -				PCI_BASE_ADDRESS_MEM_TYPE_32;
> -
> -		ret = pci_epc_set_bar(ntb->epf->epc,
> -				      ntb->epf->func_no,
> -				      ntb->epf->vfunc_no,
> -				      &ntb->epf->bar[barno]);
> -		if (ret) {
> -			dev_err(dev, "MW set failed\n");
> -			goto err_alloc_mem;
> +		shared = epf_ntb_dma_shares_bar(ntb, barno);
> +
> +		if (!shared) {
> +			ntb->epf->bar[barno].barno = barno;
> +			ntb->epf->bar[barno].size = size;
> +			ntb->epf->bar[barno].addr = NULL;
> +			ntb->epf->bar[barno].phys_addr = 0;
> +			ntb->epf->bar[barno].flags |= upper_32_bits(size) ?
> +					PCI_BASE_ADDRESS_MEM_TYPE_64 :
> +					PCI_BASE_ADDRESS_MEM_TYPE_32;
> +
> +			ret = pci_epc_set_bar(ntb->epf->epc,
> +					      ntb->epf->func_no,
> +					      ntb->epf->vfunc_no,
> +					      &ntb->epf->bar[barno]);
> +			if (ret) {
> +				dev_err(dev, "MW set failed\n");
> +				goto err_alloc_mem;
> +			}
>  		}
>
>  		/* Allocate EPC outbound memory windows to vpci vntb device */
> @@ -1310,10 +1408,11 @@ static int epf_ntb_mw_bar_init(struct epf_ntb *ntb)
>  	return ret;
>
>  err_set_bar:
> -	pci_epc_clear_bar(ntb->epf->epc,
> -			  ntb->epf->func_no,
> -			  ntb->epf->vfunc_no,
> -			  &ntb->epf->bar[barno]);
> +	if (!shared)
> +		pci_epc_clear_bar(ntb->epf->epc,
> +				  ntb->epf->func_no,
> +				  ntb->epf->vfunc_no,
> +				  &ntb->epf->bar[barno]);
>  err_alloc_mem:
>  	epf_ntb_mw_bar_clear(ntb, i);
>  	return ret;
> @@ -1331,10 +1430,11 @@ static void epf_ntb_mw_bar_clear(struct epf_ntb *ntb, int num_mws)
>
>  	for (i = 0; i < num_mws; i++) {
>  		barno = ntb->epf_ntb_bar[BAR_MW1 + i];
> -		pci_epc_clear_bar(ntb->epf->epc,
> -				  ntb->epf->func_no,
> -				  ntb->epf->vfunc_no,
> -				  &ntb->epf->bar[barno]);
> +		if (!epf_ntb_dma_shares_bar(ntb, barno))
> +			pci_epc_clear_bar(ntb->epf->epc,
> +					  ntb->epf->func_no,
> +					  ntb->epf->vfunc_no,
> +					  &ntb->epf->bar[barno]);
>
>  		pci_epc_mem_free_addr(ntb->epf->epc,
>  				      ntb->vpci_mw_phy[i],
> @@ -1936,6 +2036,28 @@ static int vntb_epf_mw_set_trans(struct ntb_dev *ndev, int pidx, int idx,
>  	dev = &ndev->dev;
>  	barno = ntb->epf_ntb_bar[BAR_MW1 + idx];
>  	epf_bar = &ntb->epf->bar[barno];
> +	if (epf_ntb_dma_shares_bar(ntb, barno)) {
> +		guard(mutex)(&ntb->dma->lock);
> +
> +		if (ntb->dma->mw_fallback) {
> +			if (size > epf_bar->size)
> +				return -EINVAL;
> +		} else if (size != ntb->mws_size[idx]) {
> +			/*
> +			 * The MW submap spans the full size configured
> +			 * through configfs. DMA submaps follow it at
> +			 * fixed BAR offsets. Supporting smaller MWs
> +			 * would need a scratch-backed submap to fill
> +			 * the gap. Let's add that complexity only when
> +			 * it is really needed.
> +			 */
> +			return -EINVAL;
> +		}
> +
> +		return epf_ntb_dma_set_bar_locked(ntb, !ntb->dma->mw_fallback,
> +						  &addr);
> +	}
> +
>  	epf_bar->phys_addr = addr;
>  	epf_bar->barno = barno;
>  	epf_bar->size = size;
> @@ -2134,15 +2256,23 @@ static int vntb_epf_mw_get_align(struct ntb_dev *ndev, int pidx, int idx,
>  			resource_size_t *size_max)
>  {
>  	struct epf_ntb *ntb = ntb_ndev(ndev);
> +	enum pci_barno barno = ntb->epf_ntb_bar[BAR_MW1 + idx];
> +	resource_size_t aalign = SZ_4K;
> +	u64 size = ntb->mws_size[idx];
> +
> +	if (epf_ntb_dma_shares_bar(ntb, barno) && ntb->dma->mw_fallback) {
> +		size = ntb->epf->bar[barno].size;
> +		aalign = size;
> +	}
>
>  	if (addr_align)
> -		*addr_align = SZ_4K;
> +		*addr_align = max_t(resource_size_t, SZ_4K, aalign);
>
>  	if (size_align)
>  		*size_align = 1;
>
>  	if (size_max)
> -		*size_max = ntb->mws_size[idx];
> +		*size_max = size;
>
>  	return 0;
>  }
> diff --git a/include/linux/pci-epf-ntb.h b/include/linux/pci-epf-ntb.h
> index 5cc0f0badae0..8131ed4c6ac9 100644
> --- a/include/linux/pci-epf-ntb.h
> +++ b/include/linux/pci-epf-ntb.h
> @@ -24,6 +24,9 @@
>  #define EPF_NTB_DB_COUNT_MASK			GENMASK(15, 0)
>  #define EPF_NTB_MSIX_ENABLE			BIT(16)
>
> +/* LINK_UP argument: the host honors the MW/DMA BAR boundary. */
> +#define EPF_NTB_LINK_UP_DMA_MW_SUPPORTED		BIT(0)
> +
>  #define EPF_NTB_COMMAND_STATUS_OK		1
>  #define EPF_NTB_COMMAND_STATUS_ERROR		2
>
> --
> 2.54.0
>
