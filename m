Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.83.10
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794521424;
	b=YQ/+J8enY7KZo09Zx3U75JKGoz+9QyH6vLSDRlawDo9dK3OraXkbLXwbLTJ3TE/ywt1o
	 eqZewLRQegzOKsk+oYjK1YRS1QHuCC3HgTPLtUXT95N+pOUd5QRZZQsSt35F8k6fiGKow
	 bF/eCrkpuwzO5Dnt4Xw+eiaxKEnWJpw21xmtrZ/8LVG4Rta3kUiMVP3+6T9bglYaFd4OP
	 Ra7R8RqLxmJUORoDpmM6Aq0fYzFLNzh0eBhjgWAopoVk24hMDANnKbWIHbpdHydchn3kZ
	 xe6231vYh2giyD1XgeMCRrvUP+e2sR4mJlqyierbDDg2GiV0K0bOIadkhWSPdPNYgYQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794521424;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=81vchyFDVAw+aZI8kEK1CeLyNsMs6CEjyOAFlzuQ24Q=;
	b=YWnMvqYEF/DFTnEfXAZT7Jq6iT8Obdj/z/fkAOKLVeKApFj0hwKsZWCRuIDmxiArKa8G
	 7I3NQLi9o18Ld50vg1MUFwxKEj2y5JgfRngYKzyPfGBabLRbpI4JnBhqUwo5fhdezgCIy
	 mAwNRBv+MOlZk6vvvJ2jUMklIsFo57/rkozprrKyk6pqocmabbtAsHBM8yyZC84r8jq3a
	 WvT/GzI1d5oZdZ5wUEQgb1/TscLSVgkXOB8Zb4ctF80+8YG7GrV8IAVYRp0c786JM2CK6
	 hR/ynvVmfTiyWrRgt+/awfXzVt2rcYytqnr/QrastmcE6MoxN964l1GauglMy3sDaJQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=wawRojRj;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.83.10
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013010.outbound.protection.outlook.com [52.101.83.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49F30606A32D;
	Thu, 12 Nov 2026 22:10:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 49F30606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=wawRojRj
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HNp2K4uwl237ngyWptVLnWeVKEOZEIDziNWcEA+vcuKO3YtSrlRei7DcmhfzXxukKMjUShvRhTS9KhJgOYYk36Yvb4SbJTEg4QniGB354FdnzEuqCN2sZjn/yz+WJCPmUSKgBUnlCf7SnXcwdHfFRB5tyRgxFntHusfYvuMOgvb0yh383FCijSNU5nWzp2dXBlVdgOJgiilONtPWZrCUtDPoMT6FIzK7XWk0iLvBjFTTGnHMCsbFxgtknYn9/tCaGKMIyq/1mTTRIJAx+QhqiSHgL3hpGSw9yhaf4EobQJrZiiOcRR9lAMoP02hgmHrvjdppmPhULwkGWMBrzFzUCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=81vchyFDVAw+aZI8kEK1CeLyNsMs6CEjyOAFlzuQ24Q=;
 b=pN4SXRcaAJZxe3l1w/QGz+gKArk/58ALUd1azngs0P1k4yWPOdIyzgB1CXxrKI9g0YH9cA5k/sTnKd+eZPe21Lk/3x1zY8rZAbE/jQ/ZjoAEd0T00LrNx4j2pkVuUBAkXcDfZBvJuTXxbA8LQOB6QzwoZZJT9IP6gQsKf9Xln3o0uUFZWWQU1iHwQuyB0fKlsxEiI9FT8CNJlI7ba7T/jXgV/vD/vh0+IvFWwq734KPa2+BJni4M0GNCfKt2Ngs7uAldjzJlZoaJleSjJrxZMdWfDpvcrX3wg8r2e4qag0L7eZNLiTmU6OFWiYv5O8h0kevZWkakskakCEP2KRFh7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=81vchyFDVAw+aZI8kEK1CeLyNsMs6CEjyOAFlzuQ24Q=;
 b=wawRojRju8kZSQmX3hfALJH9zkFZAYgUQB9keWG9FbqBiytNw9m/HL3NEwh6RuKJiH5lXeoFW85hMw0Y7GjlXyW2Giz7ygPE/+7qi5HC3EQXbCz92XcgiPXbA/CpdTkPiAV4xJZjBlfIkbpbH/ett+/vvVJI2sbCOsrauzQSDS/BGbwyqd1mDswTLVOXdG1/M5QUqj4wdUWIoOqtOOrSuL9MffVJd14+1x0cKEEe+t4/9+qzwxuhohgyqCE2ZDQAQmi7Ug5l4wYvp8yp5WfTbbambHMRboJ0sgp+bPg9hy21QW7gokPVx0IP8jDYyNXVlM3O0TBt8XeNGxZ3NrYHHQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by DUZPR04MB9948.eurprd04.prod.outlook.com (2603:10a6:10:4dd::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Thu, 12 Nov
 2026 22:10:18 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%4]) with mapi id 15.21.0615.009; Thu, 12 Nov 2026
 22:10:18 +0000
Date: Thu, 12 Nov 2026 16:10:04 -0600
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
Subject: Re: [PATCH v4 09/25] dmaengine: sdxi: Allocate administrative context
Message-ID: <avY5B5Rifn-uSams@SMW015318>
References: <20261103-sdxi-base-v4-0-3668ccc7aab8@amd.com>
 <20261103-sdxi-base-v4-9-3668ccc7aab8@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261103-sdxi-base-v4-9-3668ccc7aab8@amd.com>
X-ClientProxiedBy: GV3PEPF0001DBCA.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::6aa) To AMBPR04MB12445.eurprd04.prod.outlook.com
 (2603:10a6:20b:75e::21)
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
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|DUZPR04MB9948:EE_
X-MS-Office365-Filtering-Correlation-Id: 7defa0c5-dfcc-4694-dd34-08df4109bc67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|7416014|376014|366016|23010399003|22082099003|18002099003|6133799003|261009223027099003|11063799006|4143699003|56012099006|261102123227099003|261026121527099003|261021121427099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	Hh9eTeLyyRrSUwVs85r1Q7hfY5jnVh9b3ejZT1pFq4GEEMo/0Yj8gEiO9+q2wtCgnULH6hYEj0Czxzlr8RUILbUQnEZ3dzEikqKKsLQvOqBp0Wk6efL65sZkxfOW48nMJExufdfuBfeEBi40WndaboCaPArgV+dhm9y98Oe052cmRarWV0k1cYdHVQP6H9PQg752zLlkNPi1/VrlFE2CtJ02DD948GQQqM4/t/g3C94nVLCNinnOYpRZI5UgGcb+wS9/hNXS11V9yIFkEiDHxJUwqqGt49AZS+Bra5xPAqDaxyA1KZLnf+YgQCOdT0VYyNWqNu35/wRYMLqyiaoHoXqtiNF9yNaxoGrYxqP9vp/HQTbRxS7xPkX/iXn9MYg91/mvU/wzV1Xir3WZ+6HVW7H+ElmG8ZXn9h921Zt+aRw9yhWD4bxS8LqmxUMsdEJD9C5RRTtB7CZvPaEUVtXtwTnshwrw2nJ77jialbrVvz8gLNDuv/8nexLpiwh8Y9VoRdOOy7AMt1ZJKx3a+WMPdeTGSzrsNXFWQePlCpPKFzRsuE4M9a0U2KYXc4oUZHOG27pnVpRDbE5LefqQLM/meZBLy6GuFwVl/JmxWRdkRkbaMd+VYRPH2/DJsajT7lzNqEczn8JFIhMh1kifygZHQY4axx0sv+ICK4bE3Ewq1JA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(7416014)(376014)(366016)(23010399003)(22082099003)(18002099003)(6133799003)(261009223027099003)(11063799006)(4143699003)(56012099006)(261102123227099003)(261026121527099003)(261021121427099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dWlHemNLMm5PU3dmVytMQlZsVmE4bkh6V1ZkQnFXeWhIdjZ2RGdxT1Jndm9p?=
 =?utf-8?B?TVI2OW9yb3RMRklwTTRqTENjUC9hOXVpcUZUeDRCM2UzeTd1d2pDbC94TnBB?=
 =?utf-8?B?Nk5rT3YyZFJZdDhPVjY1SHhzTEdWZk5uVUpINGdQREJocFBrUExPT3FyMmZP?=
 =?utf-8?B?RGlqSHVBNk0zdUpTaWZHYUt6Y0tBQ3BkMEFDTDF6elh5dFNkczR2T3kwRzVX?=
 =?utf-8?B?K20rVlhIRGpheWRjQW5HQ2c5MmE4b1JPRzBZNlJmZnlVWUkvaEFuTmJTakhi?=
 =?utf-8?B?TnpVd055MDVFNnlhVGNOMnFxZVl4bHlqS0VqeW5XZW1CRWN5ZnNHenhNTmtl?=
 =?utf-8?B?YUk1NUdVaGVqQnNEVUdISVdlaWI5Y2tRcFJMZzBjOEZWeTlFaUVPdW01SkN6?=
 =?utf-8?B?Y0FxdDE1L0RMUVBRdEdveDlsOFFoQVJyNlNKUU13MFY4NHhTcVpxYXBEekQ4?=
 =?utf-8?B?ci9IRHVHVVdWN09CSDJqbElhYXpacW9XV3JGcmtMa1BJdEpIUHJpMTJMWkgy?=
 =?utf-8?B?KzFQY3k3SGNQdTNSYzFHeCt6eEx6eitPaDQ0QlZlR2l1Y29BVmkvMFJJeXEz?=
 =?utf-8?B?dmk2MzFUckhBamVjbU10aHlEY2szemlwUXZJb3gxSTU2ZTliR2RTY3NBNDhU?=
 =?utf-8?B?UTNkNGEvOS9QZVBGS1dqNHhnR3A2VFluTjBDYWkyVmRSWG9tcno3QUFBdVA2?=
 =?utf-8?B?RjFLb1NuQmdLVk5rWnBwdDBQblVqMEJDSUVLSnRIeXo5dWtyUDJmM2xTQXFU?=
 =?utf-8?B?TGtObkxKWmdPL1loRjRiL0hhNzRrcEhRUmFSN0F3eTdERXBFWitjK3RDNWxM?=
 =?utf-8?B?QncvZXhkMXRvNkpYTVYyb2pVRHhCVW55Q1VsemU3NFgxOFM5MFZaTS9peTgr?=
 =?utf-8?B?bFVyZzFlallhNEkwUVNvNzduWGhIUVRaZGZ6bk84T3ZUc1R1T21zblpkK1Jo?=
 =?utf-8?B?b2F2RjRDNjdZTjc5R1NjTmlkMnZRK0tJT0tTMlJlbXdFNTdaZFBqNTNMV3Vv?=
 =?utf-8?B?UmlYbGhvV3pGdmFncEdPRjlFMTdDMmlVekZweTNNY1M3WnRGYXpoTzM0bEJH?=
 =?utf-8?B?VmtJR2o2aTJ6RkhQYng4a200UGhDSkRLZVovYlBxa1NrTGU2ZzNWTnArMmdP?=
 =?utf-8?B?TnlrNkx5S1pqemNXSnozU01LVUxORm9MZW9TTDNwSkovSTArY3VpZGNwQ0lJ?=
 =?utf-8?B?QmJzYkFRVmpvdnAzSjhMVGhoZi9Ea0Z0dnVtVDJVcHA4S2JVempDVmpKY2Za?=
 =?utf-8?B?TVExc2gwWW9KNDdrWWxhMTRhaDA4ajdUTjZxbzQ3cSs4MHhsZmc5TXBVY2Qy?=
 =?utf-8?B?MEgzbDFpaTNpaTJMc0FDMjRuWS80MEUveE00Rk9GMkxYbEZvMHVTVWRGbmM0?=
 =?utf-8?B?Vld3amFvYURDOE9IUXR5c1B5VThsbkYrTzltdkYzTWY3cy90eldKc21IMUg1?=
 =?utf-8?B?VzJzZ25ML3RxOEp6M2Z1UUE1OGZpMk1zWGR4Wk5iZVlTWnYzYXZHTFo3WDZV?=
 =?utf-8?B?QUloSXpwYTlEWERBQm8yK3dKZHNDNXR1L2JPcUNHM2cweEpBakg4eE1reFdN?=
 =?utf-8?B?eWozZ28wSG1nNkRsR1pyeHY5WFN2SlBleTN4alZOSTBLNXVmQ2x6UzlhdEg0?=
 =?utf-8?B?ckV5SzUvSFBXYU5laVlqcWoxcldLZWxuRHNELzFWT3VXZXJHaDkxL3d2OFQ4?=
 =?utf-8?B?Sys0RStuT3JjS0loVWFaR0hNVVZiYXRoNU84djVqdnBkbER1aWZJU0tGOXhL?=
 =?utf-8?B?VzVMcklRNFhLTDd1WUJXMU5NT3RTV0RiQVBRbVZOQnpReGpPb2ZvMyt3SWRT?=
 =?utf-8?B?VStVYmRZaVp0ZGNISFdVdkNSQ3VTSVZ1OHZEMGJEckNNWmF0OXlkQmttdm1y?=
 =?utf-8?B?NXpkSTN6cVhYdW5YeG9YL2IvWXpzUHNDSzVvdThxbzhyVmF6TUJqVHZpRGxF?=
 =?utf-8?B?QzhFR3Zvb2RtMmJ5MDVMUnppWUUzQ2tWUVJodVdtS20xbUxiSkMzUGJ4MUdx?=
 =?utf-8?B?M1E3QUZudlhnRDQ5bDJBVjRSTHdGSm91bmNNZ0Z6ZWR2QkJxUmV4eWxKZUth?=
 =?utf-8?B?SFFEN1JuUHFoMnk1L2lGejEyMEp5dTdYdkFkdlkxWG5JN3IwczJNWVg1NVVh?=
 =?utf-8?B?NnY3VW10ZzBqTjV2Skt4TXRmMDBLTGRDR0drSXQ2RithcG0zbUFjbDFMTFND?=
 =?utf-8?B?aG96ZHdPVU5hVUJGUlhhZGlGWmFiV2w0RllXQmgzeFF2T3pWd0RCWm1Wem8w?=
 =?utf-8?B?Y3R2ekhFSUFYWDR6MlpRV0h3TFljOUVZZk9GcUNRQjdUUW9VdEtWRUlFeWZs?=
 =?utf-8?B?Mmp2SEhyYWovakM1SDJNT0NVSi9BWUI1N1Jsd2dTcStJTGVJRVJ3SzhVT3FQ?=
 =?utf-8?Q?V9XZhRsnddoZgIgcfx30xG28qbv20dTz/CN91?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7defa0c5-dfcc-4694-dd34-08df4109bc67
X-MS-Exchange-CrossTenant-AuthSource: AMBPR04MB12445.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 22:10:18.7902
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bgvA3jzid0rQxbTxU8etsYL7Zlh/TObL/tO3x0dXPlwl9LhQCL4idRcQ41U11Cj/9zH82Cja4efBpfHtDpN1Hik+wu1lWwY/IodegpDIYSWZy1YfvjAEBY8gbBYE2d5W
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9948

On Tue, Nov 03, 2026 at 08:49:50PM -0600, Nathan Lynch via B4 Relay wrote:
> From: Nathan Lynch <nathan.lynch@amd.com>
>
> Allocate the administrative context’s control structures and register
> device-managed cleanup.
>
> Co-developed-by: Wei Huang <wei.huang2@amd.com>
> Signed-off-by: Wei Huang <wei.huang2@amd.com>
> Signed-off-by: Nathan Lynch <nathan.lynch@amd.com>
> ---
...
> +
> +DEFINE_FREE(sdxi_cxt, struct sdxi_cxt *, if (_T) sdxi_free_cxt(_T))
> +
> +/* Allocate a context and its control structure hierarchy in memory. */
> +static struct sdxi_cxt *sdxi_alloc_cxt(struct sdxi_dev *sdxi)
> +{
> +	struct device *dev = sdxi->dev;
> +	struct sdxi_cxt *cxt __free(sdxi_cxt) = kzalloc(sizeof(*cxt), GFP_KERNEL);
> +
> +	if (!cxt)
> +		return NULL;
> +
> +	cxt->sdxi = sdxi;
> +
> +	cxt->sq = sdxi_sq_alloc(sdxi, DEFAULT_DESC_RING_ENTRIES);
> +	if (!cxt->sq)
> +		return NULL;
> +
> +	cxt->akey_table = dma_alloc_coherent(dev, sizeof(*cxt->akey_table),
> +					     &cxt->akey_table_dma, GFP_KERNEL);
> +	if (!cxt->akey_table)
> +		return NULL;
> +
> +	cxt->cxt_ctl = dma_pool_zalloc(sdxi->cxt_ctl_pool, GFP_KERNEL,
> +				       &cxt->cxt_ctl_dma);
> +	if (!cxt->cxt_ctl)
> +		return NULL;
> +
> +	return_ptr(cxt);
> +}
> +
> +static void free_admin_cxt(void *ptr)
> +{
> +	struct sdxi_dev *sdxi = ptr;
> +
> +	sdxi_free_cxt(sdxi->admin_cxt);
> +}
> +
> +int sdxi_admin_cxt_init(struct sdxi_dev *sdxi)
> +{
> +	struct sdxi_cxt *cxt __free(sdxi_cxt) = sdxi_alloc_cxt(sdxi);
> +	if (!cxt)
> +		return -ENOMEM;
> +
> +	cxt->id = SDXI_ADMIN_CXT_ID;
> +	cxt->sq->doorbell = sdxi->dbs + cxt->id * sdxi->db_stride;
> +
> +	sdxi->admin_cxt = no_free_ptr(cxt);
> +
> +	return devm_add_action_or_reset(sdxi->dev, free_admin_cxt, sdxi);

If sdxi_alloc_cxt() only called by probe, needn't mix cleanup and devm
function

Frank
