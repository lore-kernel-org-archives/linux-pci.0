Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.159.17
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794520721;
	b=S11/EMgiLYRPUMCH8NXeL1ES4ugyc5V1yARASS6x51OxroA9kS+8Zdnjk+5YXrWdksh5
	 8HV0jr8JyT39o+zEy5juxkUrlZYwITNV0pbVHgosCq9Y2BCbWdBciBgkawz9YrlhEa9Rd
	 AvAfhb5ClZvkqld3/OOm8cHcEM+KKbbBZ/E2IMcZcDAKO7QlwWdBI8+anN7eSVosz9Cyt
	 +FpTnyGZ/4nyqDGLVKt4fMFuFxUlUxGtfJ0H4NpZfKlYTqF+FNJBdOO+8CwShkqEsGJuC
	 vRFg7sAyasKFCOQhODjCp6rh7GfFpfyrm2Td8v2ri/eT2dyW2qu/LOxqgnD+nNC8dNA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794520721;
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
	bh=Uf3ZsVXUxrF2zWMmP4KCPRlK029X0vDUUFLXp2VRXHY=;
	b=DuKTV5ejO2RGUbYVyuJUN71bafdJrQn6mPbV85v1Ti2zxt0o0WCuJqYWXlZ4PbbpzjWS
	 sH0vMZuCom4wj+/D3y3eCAQJnFquYosruK8fDeypSr59SuQO8u4mNkoUkocef/h3GY4fv
	 nA5xHCoYYKr97YGQf4foBWMbUKCxdyjWW7gO0YxkIuY7qtgGSP8/uSTvCfzOJpqh5Ay7t
	 xJmBRlR9x7CR/xtnFvxYkGTQgJXuMr+6X+ED7tp75Zz/TvNfK0aPLAZ647KZtYkSR1bso
	 3ae/OXQzEdUzHdeTVaG01NLpq37NVKtsp6Bsds1pq3ff9e1YN/EO43o4ENkprJGkz9Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=POYV2qwB;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.159.17
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013017.outbound.protection.outlook.com [40.107.159.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A225606A31C;
	Thu, 12 Nov 2026 21:58:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7A225606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=POYV2qwB
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LNiSMf/Ia1mJp2hwgY1ZpJEWQ5Q20648H8//6TOW5dLMz1ptmNJ2n9bHmOLkIvRuqbTbIQQCuyGfGQhdi95K/gPYFlisy59EbTdUMCJsMglnRGtika6bRBlXXuFGyipFHJ24OsaOP+jSDTn0zM5I/DTOTT6Ho6+nwjxAD3UZDj2442QBga/9le2BpXvjkDebiRno+NjskTO1XT0JEjOxuKF00W5gQLTPTMrnFnpdQ9FYDU1SbK25CoZ48Y8Y09uT/M0QH2Ojc3bLLGBZi//MNC/7VceR91rrXMvcENXk7Pi0TsZ0Fx6NkciTcdAg5W+TfQmswTdUZ4vaLERxOLAv+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uf3ZsVXUxrF2zWMmP4KCPRlK029X0vDUUFLXp2VRXHY=;
 b=mf9rNhTceIwikYIw/K76akywJGpIJWqkiAY/sSnBW1nM8onJnmk73KcEEwg5yR8HRdH6Ya/T88R8+3xRZVu+MmIbktd1aB3ySdAb+aJ6YTFiybRX4TLVgd+BhOJebS9/V5rFWvhiiv3feO54+2n8AtBEgp4fR8qqencSTlesAti+W54ZdTXxQfGiuEKsZ8YtFhY5x86WC0oOE07MPpW4EXuesTu1bNU0P1iMFKlvSVXUCKPR/XXOg66zc8sYdr9o9hljlmbpODeSUhKpqSAIVHIJz+/O+9vCsqo0SaPPROjAedl1zJ09/mGZmJfYULpXuy0GPtcaffIH9gfT0Bsh1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uf3ZsVXUxrF2zWMmP4KCPRlK029X0vDUUFLXp2VRXHY=;
 b=POYV2qwB0Wnj3HAsUnfVL97nlad2xgfAaV6bo2kMPCSK3qZHAeS50JYLDfbuD/4LnOl8JaakdtFt7+79iJEiK8s0QmAfRb61VkgB+kWgi6SjTTiRtgNwp5QVWEXFaFMB3xoBt3n15yDoC/y2OS7qeIYWZ2izedez7osdsw8J0UFBw20ATIP5hsAC8HXkHK6NtO9PTz4gD07A6DhItllFnaza1GUbu3k+8015wZ2pq6mKG3Y33/oSC8PeAw3+SOti4KPLxiNgzZTP/hZfgKoNZJ4ZO2vrt0Ko2ctzqB+X4Kkps48BlPklrALuq59zkyTbl4yyo5UpgaXhHdhbw6hvhA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by AS8PR04MB8118.eurprd04.prod.outlook.com (2603:10a6:20b:3f2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Thu, 12 Nov
 2026 21:58:37 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%4]) with mapi id 15.21.0615.009; Thu, 12 Nov 2026
 21:58:37 +0000
Date: Thu, 12 Nov 2026 15:58:18 -0600
From: Frank Li <Frank.li@oss.nxp.com>
To: nathan.lynch@amd.com
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	David Rientjes <rientjes@google.com>, John.Kariuki@amd.com,
	Jonathan Cameron <jic23@kernel.org>,
	Kinsey Ho <kinseyho@google.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	PradeepVineshReddy.Kodamati@amd.com,
	Shivank Garg <shivankg@amd.com>,
	Stephen Bates <Stephen.Bates@amd.com>,
	Tycho Andersen <tycho@kernel.org>, Wei Huang <wei.huang2@amd.com>,
	Wei Xu <weixugc@google.com>, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v4 08/25] dmaengine: sdxi: Introduce submission queue
Message-ID: <avY2eoawRh4TaKu_@SMW015318>
References: <20261103-sdxi-base-v4-0-3668ccc7aab8@amd.com>
 <20261103-sdxi-base-v4-8-3668ccc7aab8@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261103-sdxi-base-v4-8-3668ccc7aab8@amd.com>
X-ClientProxiedBy: AS9PR06CA0346.eurprd06.prod.outlook.com
 (2603:10a6:20b:466::21) To MI3PR04MB12438.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|AS8PR04MB8118:EE_
X-MS-Office365-Filtering-Correlation-Id: b136c2c7-6a37-4808-967d-08df41081abf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|23010399003|1800799024|376014|7416014|366016|18002099003|22082099003|6133799003|4143699003|11063799006|56012099006|261021135927099003|10067099003|261102123227099003|261022105027099003|261026121527099003|261022113327099003|261022075727099003|261026130827099003|261022115727099003|261028144727099003|261021121427099003|261026140227099003|261021130227099003|261021123027099003;
X-Microsoft-Antispam-Message-Info:
	zzxPFS6ivmg2+Ukwn69udAHSgb+18i5lIFTDO+W3D0immlITo7iP9VpgDtidftWKdfHCFJgMugkc0vcIhWCGLbLDgbkdhHxQDOT5Bnsm3Q6OceOGNWYjAGrQsJ+/U+8pWn8NadWnlynZMWtx/U6rbZSzJSFpMeXpyzj4XZE8wwImdHyucJfm6NdEYq+L59JGvcfyGDC+/1r13L1ouNS1RcCmBSHstPsFXMzy58brvDIAUImlUWB1q6VMkmnuFRUjv2Li/URMNyn7byrOif2cwZABfIHyP+El2tgDpPUuMt0ShNwL+JcgtRB4pHkBfmxrujFMKWhy/gBp5s2YcGe2K3L9Ov258RkRKsrGO6//o8iUx66/zA/R12wq5AwKCvltzXIPc5rUKDipI6e12O0HGzdczEnh8U8O7eVsuAElHl7P5HIGRrfudREizvwmik87sbw6Vrc52qiRGJoCMAqkF14J/Mm9/MnN7OpXnNIwSUKvIql6yr4K1VAz0t3fnsZ17xIhAPg7V6Vev9FEHgst30sASnXNFYLI9sbAAcfLm3qNw/4GHsjxpfQXgy35wh1B3t3ZEkGZDNGmOdXLaC/ccFy/7XEOY+5DRBowNkxWmWQrPhQFGVwM3Fwj7QdjOcdNCUyOrM5FpZdocqme+NHmZqoWLTOmsUN3PA/vtNiJ8vs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(23010399003)(1800799024)(376014)(7416014)(366016)(18002099003)(22082099003)(6133799003)(4143699003)(11063799006)(56012099006)(261021135927099003)(10067099003)(261102123227099003)(261022105027099003)(261026121527099003)(261022113327099003)(261022075727099003)(261026130827099003)(261022115727099003)(261028144727099003)(261021121427099003)(261026140227099003)(261021130227099003)(261021123027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wyFvDN56uWJvVdMEZwxzyLbX2mzqPTFNoHlfT1hPaTHMXh5zMyqX6iQgsOAD?=
 =?us-ascii?Q?xbJzUwjOENOGgWbTgoziL82dK2pVu6SBd5su+dPWH38HSZINBfyRhUWHN76X?=
 =?us-ascii?Q?AKyRlq4KyyCcu3qBV2Kecb+8hJjg5sHM1iTS21c4FFiDh5PFvUS10dZLY37+?=
 =?us-ascii?Q?oPuwHizXcBTFaLWakj0ou6iRyh15bReZzXg6YlfVBz30CO0AMv9RDf3dfxn9?=
 =?us-ascii?Q?q3c7ayPwGy3K8yP9y44mDg5TuiiuzWz+1V++Py7I5cVI6kMobkkgPVz/tHOG?=
 =?us-ascii?Q?Lv/gLc/gJZ/vPiVxPCvJsvekK4h4zuN7qskxs5mwENA0P8z52AMGSK1mu3qi?=
 =?us-ascii?Q?fGod9K23ijTp7TvsKptrIpG/u6lLsKQfbqmWDdsTYK52VWr5GISVvX4fwinu?=
 =?us-ascii?Q?jBXmT3dKStwDcHxTyHeaoMxWyf/FIbqDm9My8L5MwIJkHiY3j4Byy98yFYub?=
 =?us-ascii?Q?gY93hhvwwm/HRUnn8W5aIQNJJ4D/gIWh1N289xXFi3P2t8c05gNNPRGqevSy?=
 =?us-ascii?Q?pKiE0sr9SmdjdRRWuo7c46qCC4ex31i/GmJZh5NdqAQHtDQ4QrWT5BJY+4jB?=
 =?us-ascii?Q?9qnqpRnr27STXcBiRdHDEq2P7K6gQbMndaB/uxfe4ce/jWYRMOh19HsXDEDW?=
 =?us-ascii?Q?/6f+Zoe6XS0Ut/7rgqoi4+NqZ9UnJ8fpQ3soBLzd2LTjNTr8Q2Nm1S16vL2U?=
 =?us-ascii?Q?d9Hf/ygJJvJEKRtTtZGa9aZEH91OD8O5QExWhWd7k9EjOfEiRCcGtyj9cr0K?=
 =?us-ascii?Q?488EWfkrk0VReqBW5/1oHDbFNhzuxeY6PCT0g/wSB62m6rq3j/rH+I1xZILM?=
 =?us-ascii?Q?zj6GHfq0h7uV5gAD2ij+5NJe4VTul2RqhdFeWm/3S+ETWWXbXz6Z2QKqoKsH?=
 =?us-ascii?Q?v7HWITK9RazojAczdwPLxpdFWIqxZGO3iAF8ugSuX2qMyfxANrrHgbaKk9db?=
 =?us-ascii?Q?OWR612xvkkpEaKl5w0z4OIrSc2J0RLzlsWqQ5nNnLS1awLV0PxqNtBbaF0z2?=
 =?us-ascii?Q?Zk99x89QOQ2GJRk4TuNnNW6RNpGJJxlCfHsLu57Gcn3mKw8YUQ5vmnX49Brd?=
 =?us-ascii?Q?fizN4pDjtYiQ96LUV/4BckAaP/ElCAIzTzUYQxZ40YKshqDrDRaGVnfm0+0E?=
 =?us-ascii?Q?bKVChl9dL7vL+w/kl7BwZhU3Jkwa351CVKJAZnBk/gWT35y/1pcBuZoXx20h?=
 =?us-ascii?Q?HQGPKEZubJn0scoWejkPpJBQt8Sok/AbWrJElI9P7epbsR0k8Yypmfaz0HRk?=
 =?us-ascii?Q?VTbDj9jghSgYT8cQJ3ct8pOhMnSz1U7MO5Oa8MNdA+6tN/0g+JJolbWiXkz5?=
 =?us-ascii?Q?ICGnnuXy9YutuTXDf2mcAUzuiC73h7jHX0sM0m5TxYor/iMQ7rOPdzlpAIe7?=
 =?us-ascii?Q?Avt0BeD6dfewc/0OIsJ+iEG3BsL0m9+GZEiEojb7a/Ly2UC+5Hwit6Ztz/RP?=
 =?us-ascii?Q?7N6fanzQY4kZf0CQKkKYHl/U+gpeCBcs/tzzAHzmWBkq7t4e8VmeK2cLAcmD?=
 =?us-ascii?Q?6/Y5gtwu2HUgBj3PN5HBroJ7Z2NrRzwHoG25Qq3jyHsYdreEdcUtezQ3MvE0?=
 =?us-ascii?Q?wjf83JTwrBo80Kb8QhaUmNgz2M+raqYAzzaWffUZDaKY6oY+eGTH24w16wxB?=
 =?us-ascii?Q?j+6nvZb2cNPb0855LPuAF/tGiIpQNV4HuD/d5k/v8Wb0g7EMZjxuqGahDjwg?=
 =?us-ascii?Q?ekbQ7IGt4eR1zgqncUA0Mwwe44GwVD6VWdAgrlKnEtVDgq1Z/3vh1KaziWEH?=
 =?us-ascii?Q?0cxkc5gb7zr8See40cqqYVLkm0AsoaKMhlKw4YWrjpK+t7Acp5cY?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b136c2c7-6a37-4808-967d-08df41081abf
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 21:58:37.5934
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cCZBgVMMrkJ26or5I3895nZqxMhWxkDbYISAIjbfefwt86tiD/eUBU88gdLCU5RpYjX/0rCqW88C+mQ4Wx06pB8Yvmj0NmgILaMDG2pTkzV+D868AXdBfzcLFSlGV416
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8118

On Tue, Nov 03, 2026 at 08:49:49PM -0600, Nathan Lynch via B4 Relay wrote:
> From: Nathan Lynch <nathan.lynch@amd.com>
>
> Add the sdxi_sq (submission queue) type and APIs that act on it. The
> sq contains three control structures shared with hardware: descriptor
> ring, write index, and context status block (which contains the read
> index). Define the hardware context-status and generic descriptor
> layouts, including assertions for their sizes.
>
> The descriptor ring requires only 64-byte alignment, so it's practical
> to implement it as a flexible array member. The write index and context
> status are small enough to place in the struct as well, so we have a
> single DMA coherent allocation to manage.
>
> Signed-off-by: Nathan Lynch <nathan.lynch@amd.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>
