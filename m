Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.72.10
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794592219;
	b=y9t7MQD/X9EJL3ecttYmxvVTko3612AH3fGmycQLKbOOciRhsQuqO2M2Q/vhzfsq8j9z
	 RfxOCo+RsKiUJn5FUjUb39quiH0ziv/IhZpRgb8IRvtswuraSoXJgt5ZYr0D9bOzKpLSh
	 uSbh767RynFi23wsKsEPcZ+hI9uF+snBbiLpyvmBhT3Z3TugilR3TxxXhcNSvu8AH0Xo/
	 JA34qdtWRMoYMavQuGagKZQ8ZvtWO2rJ8MId1RyGMDJB+VjrPtRx7v5+TZDnw1QZrMuIq
	 PMDekBznzOPUgTaYoHCw+qofu4Oe5iCk12eWNbn9OPvGyuTsdcZ/J6uVNx1COS1oU0A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794592219;
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
	bh=Dt+ji8sd8nM1vmQBG/dBACEOsg14d0UUVH8o79hqlxI=;
	b=tGZHSp/6OwfIVlHRjl9t+GJYu/QeA7VMPNJFgnU9toL9JTky3Tc4fCOEeNC8QO3zSpJo
	 H4n+X8yp23q5o6s5nTzWrr0g3P75syW+3uQBbk6tPqAdXA0Wq3NKzXyZ8L5Kth67U1/1b
	 6dKgvkLTXYwpz90SeutE5tBWOrmhUB0UMXd3Pg5nCOuPL5+KltXUNKUh73gXBne4ECspz
	 ++L6luB76phYVoGrhu0wA3Su4qvD185lDvTn+/PJGm9KsnaPEMkbamLsFQKfhumquU9iU
	 2gWawYHQuzTZhLmhFldHTH9o9dca7jJ5/Ex+QWdngQd2K7d3JhVfLFnK9nC8RBpAPlQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=Em2NO1wS;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.72.10
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013010.outbound.protection.outlook.com [52.101.72.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7473606E202;
	Fri, 13 Nov 2026 17:50:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D7473606E202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=Em2NO1wS
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ePca871bwiPSkhwMO4D0H38ihLOqDJ1AG5jxtho36isWl39kpCutwoKe8IoPU9mmKHUM3ZtbSVVx2ZLeP8qd+84Ohvcli8I0JucOQ0Dimso9SbDrWg6qpdlODNvQPzfM6B9pn8VJs3b3Znher3tzBcXBMixwQA6e6Zv0XfTTmpile49TGzWvJ6zSuQFY3MZTPvOZkextl78UT7puLQo84eTigaZKrj2HNmRQBgwbvdFaccSwGRTOkcAo9PzmgnJNkgiKJX+p+d2AvDwRU8gzZUbq7RE/fxCJq0kCF4CYxfCSbIDeIsJhaE8gIcK7ENTvgh5LKcPz/o4vvWZHzZ6l2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dt+ji8sd8nM1vmQBG/dBACEOsg14d0UUVH8o79hqlxI=;
 b=IUoG39oS59SUFRGWyKhcsXQvsIuCUoy8lZ8tavc07EZsCLUQLxpdvBNfO8qD/CBY6FrMvL1h1hFyWijZXXzN8XW0Eb2avtaZ0DFpPt1JYFTQw6TjPklOnn7QISACw7iiJoTYL5Eg5ye05u2p8Wqg5oChurxdQf/aWuv7mlOqNjX7xv7CJ6AHWpMJAa1VFoWnHRC8dHiIcUYHOLRPsxVwIxKz73GfQsLbGNkbs50rwzzNnJ0kq+UpMwjEHqOAvLnl5rCjOWJetUluwwt3EihzbJXMhCFoVNJAWsXo8ok1sOPRpyJ56LGKTWzdd+yNI+Uu9RVqMeB2RyMVOcacRUJCmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dt+ji8sd8nM1vmQBG/dBACEOsg14d0UUVH8o79hqlxI=;
 b=Em2NO1wSfR3icHXmyGUkpr+J2eIAxUUZzl0BaWYyaTztnzl+139Akvn18heVpo23alRL5gyuhLs7Gh5RJgzv6Ad60RPPPVDPadefLWI0Wl22OU+RlVf541twzzzyZZ3xIOhfQGMLAtnlKiJ420HoFDmEZReFYcybEIroqzxXzxbo9hMhd1GXBm/JE3TKxUZxnvWjUCCU6FZVXwartL9aX8zMo9amePtxk5nCaeLiB5zh1/kCygIemtDnxGkG5ZcQch1nulsgTsjUraRCKVcZo3Y0JXC90HBpvtYmu2eyRv/uQGXTXApXtfOLx3Coz1o8eMqznmL5YgObv5K9BZXm7Q==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by AM0PR04MB11915.eurprd04.prod.outlook.com (2603:10a6:20b:701::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Fri, 13 Nov
 2026 17:50:14 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%4]) with mapi id 15.21.0615.009; Fri, 13 Nov 2026
 17:50:14 +0000
Date: Fri, 13 Nov 2026 12:50:06 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Nathan Lynch <nathan.lynch@amd.com>
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
Subject: Re: [PATCH v4 25/25] dmaengine: sdxi: Add DMA engine provider
Message-ID: <avdNzgMDdDrcioVf@lizhi-Precision-Tower-5810>
References: <20261103-sdxi-base-v4-0-3668ccc7aab8@amd.com>
 <20261103-sdxi-base-v4-25-3668ccc7aab8@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261103-sdxi-base-v4-25-3668ccc7aab8@amd.com>
X-ClientProxiedBy: DM6PR04CA0006.namprd04.prod.outlook.com
 (2603:10b6:5:334::11) To MI3PR04MB12438.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|AM0PR04MB11915:EE_
X-MS-Office365-Filtering-Correlation-Id: c25b19de-db08-483d-9573-08df41ae9273
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|366016|1800799024|19092799006|261021133027099003|10067099003|4143699003|11063799006|56012099006|261022105027099003|261021130227099003|261022075727099003|261026140227099003|261026135527099003|261026121527099003|261022115727099003|261021135927099003|261021121427099003|261026130827099003|261028144727099003|261022113327099003|261102123227099003|261021123027099003|261009223027099003|18002099003|22082099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	D+/Z1CO3+e8x9eyMT+oQdNxG4SBo+Ix5FMrLey0I0GRi76m7bLFPQOFAihLBG0SyqYDean5lfNcOZnxBbVNEFJ2GBLMbfhLtbTJfKCJInkI+lb2Cow/qXqGmP6lbOQpnXoOCYwKEVk9/gEIa4fRNcn0dL7Ec2nEsiLJNeMOgnxIE2Anbgx+vh24XSQMfnndSBtUeoEtPEyjPWlDSfJBH4o7kaTMVzBBu7+UKsCB8usddP/VyLeO+iAH36NrzcPvQt0k/nX3MwoPjzJiqW1TYjN6UpWPLjwpQZT75s9y6vMI/0xlgH2fycMNYfdlEHI05G9tYN0nH2Y80ySSzoodSQcX0KLdQkPM2ZR5xajvTQrcPafqJFlQpg+t31bKxzRhCKA6CAP9HkmvtBx0/PCAhFKVhTi8qn+dSS83s/QnPxqK+KGvBbIOr/h4/r7R8Yb0mDErWXZyLkF+WKsWzAZPNp3sP4NG2GY7xpd8fmS1msKi1hM86nUvH5ktyC3+5w0/dHHS/k2o5DYMUlP+Mnf1XdzUNw9Y3y0wXQAu5lcPm09DU6l2UycxJVEjRfD+45jTBhdwVj8htiyo+L0PNCmE1cRLfKVVI68CJv9Z1fJcth+pylxS12Iu3KE59vsX6wOT0zhGUHdSikaPGmZBkwglnX/XevCCb2RuSmEVdnkjY8pI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(366016)(1800799024)(19092799006)(261021133027099003)(10067099003)(4143699003)(11063799006)(56012099006)(261022105027099003)(261021130227099003)(261022075727099003)(261026140227099003)(261026135527099003)(261026121527099003)(261022115727099003)(261021135927099003)(261021121427099003)(261026130827099003)(261028144727099003)(261022113327099003)(261102123227099003)(261021123027099003)(261009223027099003)(18002099003)(22082099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+ST8afYnnh8abhcVQlw90hSINyS6cMcvyFViAB9sHJkHB277WjCFhBbSXIDO?=
 =?us-ascii?Q?uLXok0LMffjV2B9ry9f/zyP6Se7/kniLpdDu7RJ7Tr3eAQDi2i9gUXph26xM?=
 =?us-ascii?Q?4I796HH3ZdaU+7PCffjxTIPb2zKGrPB0kqqqDN1KiY9EmDLeiEEptJpmZIrC?=
 =?us-ascii?Q?a6vSxcJO5JfiH8vyntnVyLzPrBgiUhc2zhWqncpjq5UAvUK922Wlzm0viGy9?=
 =?us-ascii?Q?azx9FU/GgHANxHvJkPhLaRVbTF8EDXnjohowxUmAFPNUOpyfFJHbURzzI0hd?=
 =?us-ascii?Q?2NjhYr7CmEX5v2fd/kmY4wEN24kpm7GTdm5QJxn9wqd9d+TouX+8FHFCD6bm?=
 =?us-ascii?Q?RMQjFnZQ+JW+TCwY6TfY7NgvRnOmwg73JRbVcM40sxDoVGOdg7dxS/JHyG2L?=
 =?us-ascii?Q?Mc8rEHlQ7m1aMqwgAObwhP/23Qq6H3sdK1uAtzYekGK7rQTtkAgpVjM3aJo7?=
 =?us-ascii?Q?wBjXM64vVbSV6EUx694uEoQs5JI2LI9byTGSR2MlSVehqYaNj4jpwOxxNdso?=
 =?us-ascii?Q?9M/74k9gG8HitJvt/PlbH689K56mRPLhuF3cW9jozSGNNUC1WfMLfgSkghvC?=
 =?us-ascii?Q?dC5RDugF21ruZ9IHK/92zgFgRoCfW52P2bhuh87NXH2P6OQ4mFIX2bsWoiLC?=
 =?us-ascii?Q?AdaJPqJFFT0Kv2zSILj6qJvmbNm4Z6Ncxm87cn3ITR0CVclCgSPVkzlERHed?=
 =?us-ascii?Q?UN5G86eKe/Xtu0jfLm4YElNHB7Kh1JFIkayEVeThRmXZ6R0/4ymoOH2kwL4M?=
 =?us-ascii?Q?E3mKOr3ufW7wWPDOzOG+Jo7ihr5i7ZJxjfdIk1RpZq6cIbNFiTzjIOgFvi6p?=
 =?us-ascii?Q?UQ+fEz7mOJO0lnkGekS3lFJjvyiuKzSeE/uI8KMwiRv5Q+UMA5auPGgda2nv?=
 =?us-ascii?Q?v7ROPY8o66H3mhjUtQKsc3O5r18zoyyYEiAdFrQ5ZpAAbeMpXkQj3RUU8cwh?=
 =?us-ascii?Q?jV6J/a9aK8JyCba5rnhvrpaRNd3W1Bm6aV/LtaXaeOXbCsB9GTyJ6TLOBCjz?=
 =?us-ascii?Q?iYsEnarnaxLF389DSE/E3AogQFfuqMvFMVSM2j37oGE8rYU7061N2L9AqyrH?=
 =?us-ascii?Q?wafucgUnEqMXGfv+nIHHJMFZTSzTkkImHBS0uTNkKRaH1stU5RYsdfeHphZZ?=
 =?us-ascii?Q?/CtoYYme4VHjYmipuCJ0yyGKSqQhNJ2NKZvE0pSdNauP83OPumiKAtjVAb5e?=
 =?us-ascii?Q?BSVlFIAdSS2dK/A/GU/Bs7KGX0E6QEWgj8c2iU49vJ2binzbkGuLJ+Bbgrlq?=
 =?us-ascii?Q?KPufrHwdcCZFD0eHHVcrlTkkfw8cNYUBZ2LOwnZIPYpuMnYMOAO7ndn3ZPmL?=
 =?us-ascii?Q?/3HftmNHsvCV7e4GOCVPN+G4j9pEX53sykpSmK7hn2gteCTHwIjFiiu5NxxF?=
 =?us-ascii?Q?eiG2gyVEYpjgxlcuEND60QzT9+wj1TKWIk1qGqNKdby1CUq2MFwlZiEjKL9d?=
 =?us-ascii?Q?EpDxCK4MBb9JglfprqlsDaCjOJYgNKE3L5x0FzhNzQfoppx8lulW6BqHoiB3?=
 =?us-ascii?Q?4aFeW/XSLSEyfn0SUoJWrJZ3/BVjsJkD6rIgIC4L+i/cknLxIvup9tolTm5s?=
 =?us-ascii?Q?DvDdGNrTzkE9ojhLk58MA9tlEFkG3QDrWfAuQLwRb1AcVNf8WO9yxHayTEtu?=
 =?us-ascii?Q?UHQq/FImbkKha8G/Gn5RN4sWJGQ5Vj7zqKr+nWTM6kUb9jD+h9OC/mkhCXt1?=
 =?us-ascii?Q?J9YFyvsZojK0B8DM9MNmGuE8nqp282Tt1pH4OapomYLaTGevMez5BoNal9yq?=
 =?us-ascii?Q?MZyJtj0wlEn5T3Vnkana181+TWC8fqjTHjk9DhmjNMo7lhbC0SJm?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c25b19de-db08-483d-9573-08df41ae9273
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 17:50:14.7905
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 275j+3MHFUMsxb9ITofbsjUoXTtrGjOt5HSn/qnCCGCviWLdybjT1FFZ0LpSQHN8R6QWA0cj7jnc45f8rEx7hRU1cQqB8hJpDH3lsLl5mnEiQ/rXP08Qu84DZi5f2bQ2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB11915

On Tue, Nov 03, 2026 at 08:50:06PM -0600, Nathan Lynch wrote:
> Register a virt-dma memcpy provider with a configurable number of channels
> per function. Publish transactions in cookie order, batching copies behind
> fenced completion interrupts. Keep transactions pending when ring slots or
> completion blocks are unavailable.
>
> Published descriptors cannot be withdrawn. Termination frees submitted and
> pending transactions and retains published transactions for reaping without
> completing cookies or invoking callbacks.
>
> Synchronize by polling and reaping transactions under the channel lock,
> then flushing virt-dma callbacks. The wait is uninterruptible and bounded
> to ten seconds. On timeout, suppress remaining callbacks and retain unreaped
> status blocks until context teardown; this timeout path does not establish
> hardware quiescence for client buffers.
>
> Co-developed-by: Wei Huang <wei.huang2@amd.com>
> Signed-off-by: Wei Huang <wei.huang2@amd.com>
> Signed-off-by: Nathan Lynch <nathan.lynch@amd.com>
> ---
>  drivers/dma/sdxi/Kconfig  |   1 +
>  drivers/dma/sdxi/Makefile |   1 +
>  drivers/dma/sdxi/device.c |   2 +
>  drivers/dma/sdxi/dma.c    | 509 ++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/dma/sdxi/dma.h    |  11 +
>  5 files changed, 524 insertions(+)
>
> diff --git a/drivers/dma/sdxi/Kconfig b/drivers/dma/sdxi/Kconfig
> index 314b3e725ccb..85e23608405c 100644
> --- a/drivers/dma/sdxi/Kconfig
> +++ b/drivers/dma/sdxi/Kconfig
> @@ -4,6 +4,7 @@ config SDXI_CORE
>  	# SDXI 1.0 9 MMIO Control Registers.
>  	depends on 64BIT
>  	select DMA_ENGINE
> +	select DMA_VIRTUAL_CHANNELS
>  	help
>  	  Enable support for Smart Data Accelerator Interface (SDXI)
>  	  Platform Data Mover devices. SDXI is a vendor-neutral
> diff --git a/drivers/dma/sdxi/Makefile b/drivers/dma/sdxi/Makefile
> index 1e261fb03225..3a1d36997b44 100644
> --- a/drivers/dma/sdxi/Makefile
> +++ b/drivers/dma/sdxi/Makefile
> @@ -5,6 +5,7 @@ sdxi-core-y := \
>  	context.o     \
>  	descriptor.o  \
>  	device.o      \
> +	dma.o         \
>  	ring.o
>
>  obj-$(CONFIG_SDXI_PCI) += sdxi-pci.o
> diff --git a/drivers/dma/sdxi/device.c b/drivers/dma/sdxi/device.c
> index 30c4e687cedf..265ebea1e350 100644
> --- a/drivers/dma/sdxi/device.c
> +++ b/drivers/dma/sdxi/device.c
> @@ -23,6 +23,7 @@
>  #include <linux/xarray.h>
>
>  #include "context.h"
> +#include "dma.h"
>  #include "hw.h"
>  #include "mmio.h"
>  #include "sdxi.h"
> @@ -424,6 +425,7 @@ static int sdxi_device_init(struct sdxi_dev *sdxi)
>  	if (err)
>  		return err;
>
> +	sdxi_dma_register(sdxi);
>  	return 0;
>  }
>
> diff --git a/drivers/dma/sdxi/dma.c b/drivers/dma/sdxi/dma.c
> new file mode 100644
> index 000000000000..512855c83da2
> --- /dev/null
> +++ b/drivers/dma/sdxi/dma.c
> @@ -0,0 +1,509 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * SDXI dmaengine provider
> + *
> + * Copyright Advanced Micro Devices, Inc.
> + */
> +
> +#include <linux/cleanup.h>
> +#include <linux/delay.h>
> +#include <linux/dev_printk.h>
> +#include <linux/container_of.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/dmaengine.h>
> +#include <linux/iopoll.h>
> +#include <linux/list.h>
> +#include <linux/lockdep.h>
> +#include <linux/module.h>
> +#include <linux/overflow.h>
> +#include <linux/spinlock.h>
> +
> +#include "../dmaengine.h"
> +#include "../virt-dma.h"
> +#include "completion.h"
> +#include "context.h"
> +#include "descriptor.h"
> +#include "dma.h"
> +#include "ring.h"
> +#include "sdxi.h"
> +
> +static unsigned short dma_channels = 1;
> +module_param(dma_channels, ushort, 0644);
> +MODULE_PARM_DESC(dma_channels, "DMA channels per function (default: 1)");
> +
> +/*
> + * Each channel owns an SDXI context. Transactions enter the ring in cookie
> + * order. Each transaction produces one copy descriptor with its own completion
> + * block, and batches end with a shared fenced interrupt descriptor. Each copy
> + * owns its completion block until reaped. Transactions awaiting capacity remain
> + * pending. Termination retains published transactions for reaping while
> + * suppressing their callbacks.
> + */
> +
> +struct sdxi_dma_chan {
> +	struct virt_dma_chan vchan;
> +	struct sdxi_cxt *cxt;
> +	unsigned int vector;
> +	unsigned int irq;
> +	struct sdxi_akey_ent *akey;
> +	/*
> +	 * Transactions awaiting ring slots or completion blocks; protected by
> +	 * vchan.lock.
> +	 */
> +	struct list_head pending;
> +};
> +
> +struct sdxi_dma_txd {
> +	struct virt_dma_desc vdesc;
> +	struct sdxi_copy copy;	/* Copy operation parameters */
> +	/* Completion ownership is acquired at issue and released after reaping. */
> +	struct sdxi_completion completion;
> +};
> +
> +static void sdxi_dma_reap_locked(struct sdxi_dma_chan *sdchan);
> +
> +struct sdxi_dma_dev {
> +	struct dma_device dma_dev;
> +	size_t nr_channels;
> +	struct sdxi_dma_chan sdchan[] __counted_by(nr_channels);
> +};
> +
> +static struct sdxi_dma_chan *to_sdxi_dma_chan(const struct dma_chan *dma_chan)
> +{
> +	const struct virt_dma_chan *vchan;
> +
> +	vchan = container_of_const(dma_chan, struct virt_dma_chan, chan);
> +	return container_of(vchan, struct sdxi_dma_chan, vchan);
> +}
> +
> +static struct sdxi_dma_txd *
> +to_sdxi_dma_txd(const struct virt_dma_desc *vdesc)
> +{
> +	return container_of(vdesc, struct sdxi_dma_txd, vdesc);
> +}
> +
> +static void sdxi_dma_txd_free(struct virt_dma_desc *vdesc)
> +{
> +	struct sdxi_dma_txd *txd = to_sdxi_dma_txd(vdesc);
> +
> +	kfree(txd);
> +}
> +
> +static struct dma_async_tx_descriptor *
> +sdxi_dma_prep_memcpy(struct dma_chan *dma_chan, dma_addr_t dst,
> +		     dma_addr_t src, size_t len, unsigned long flags)
> +{
> +	struct sdxi_dma_chan *sdchan = to_sdxi_dma_chan(dma_chan);
> +	struct sdxi_cxt *cxt = sdchan->cxt;
> +	u16 akey_index = sdxi_akey_index(cxt, sdchan->akey);
> +	struct sdxi_dma_txd *txd;
> +	struct sdxi_copy copy = {
> +		.src = src,
> +		.dst = dst,
> +		.src_akey = akey_index,
> +		.dst_akey = akey_index,
> +		.len = len,
> +	};
> +
> +	/*
> +	 * Validate now, with a throwaway encode onto the stack. The real
> +	 * encode into the ring happens at issue.
> +	 */
> +	if (sdxi_encode_copy(&(struct sdxi_desc){}, &copy))
> +		return NULL;
> +
> +	txd = kmalloc_obj(*txd, GFP_NOWAIT);
> +	if (!txd)
> +		return NULL;
> +
> +	*txd = (typeof(*txd)) {
> +		.copy = copy,
> +	};
> +
> +	return vchan_tx_prep(&sdchan->vchan, &txd->vdesc, flags);
> +}
> +
> +static enum dma_status sdxi_tx_status(struct dma_chan *chan,
> +				      dma_cookie_t cookie,
> +				      struct dma_tx_state *state)
> +{
> +	struct sdxi_dma_chan *sdchan = to_sdxi_dma_chan(chan);
> +	struct virt_dma_desc *vdesc;
> +
> +	/* Under the lock for a consistent cookie snapshot; the IRQ reaps. */
> +	guard(spinlock_irqsave)(&sdchan->vchan.lock);
> +
> +	/* vchan_find_desc() only returns issued txds, which own a completion. */
> +	vdesc = vchan_find_desc(&sdchan->vchan, cookie);
> +	if (vdesc) {
> +		struct sdxi_dma_txd *txd = to_sdxi_dma_txd(vdesc);
> +
> +		if (sdxi_cst_blk_check(txd->completion.cst_blk) == SDXI_COMPLETION_ERROR)
> +			return DMA_ERROR;
> +	}
> +
> +	return dma_cookie_status(chan, cookie, state);
> +}
> +
> +/*
> + * Fill capacity with complete, fenced batches in cookie order. Return true
> + * if descriptors were published; the caller kicks once with the lock held.
> + */
> +static bool sdxi_dma_drain_locked(struct sdxi_dma_chan *sdchan)
> +{
> +	struct sdxi_cxt *cxt = sdchan->cxt;
> +	struct sdxi_ring_state *rs = cxt->ring_state;
> +	bool pushed = false;
> +
> +	lockdep_assert_held(&sdchan->vchan.lock);
> +
> +	while (!list_empty(&sdchan->pending)) {
> +		struct virt_dma_desc *vdesc;
> +		struct sdxi_ring_resv resv;
> +		struct sdxi_desc *desc;
> +		size_t claimed = 0, copies, i = 0;
> +
> +		/* Claim a pending prefix, stopping at a flag boundary or capacity limit. */
> +		list_for_each_entry(vdesc, &sdchan->pending, node) {
> +			struct sdxi_dma_txd *txd = to_sdxi_dma_txd(vdesc);
> +
> +			if (!sdxi_cst_pool_get(cxt->cst_pool, &txd->completion))
> +				break;
> +			claimed++;
> +			if (vdesc->tx.flags & (DMA_PREP_INTERRUPT | DMA_PREP_FENCE) ||
> +			    claimed == rs->sq->count - 1)
> +				break;
> +		}
> +		if (!claimed)
> +			break;
> +
> +		/* Ring reservations cannot be undone; acquire completions first. */
> +		copies = 0;
> +		if (!sdxi_ring_try_reserve_range(rs, 2, claimed + 1, &resv))
> +			copies = sdxi_ring_resv_count(&resv) - 1;
> +
> +		/* Return claims not covered by this (possibly failed) reservation. */
> +		list_for_each_entry(vdesc, &sdchan->pending, node) {
> +			struct sdxi_dma_txd *txd = to_sdxi_dma_txd(vdesc);
> +
> +			if (i == claimed)
> +				break;
> +			if (i++ < copies)
> +				continue;
> +			sdxi_cst_pool_put(cxt->cst_pool, txd->completion.cst_blk);
> +			txd->completion = (struct sdxi_completion) {};
> +		}
> +		if (!copies)
> +			break;
> +		for (size_t i = 0; i < copies; i++) {
> +			struct sdxi_dma_txd *txd;
> +			struct sdxi_slot slot = sdxi_ring_resv_slot(&resv, i);
> +
> +			vdesc = list_first_entry(&sdchan->pending,
> +						struct virt_dma_desc, node);
> +			txd = to_sdxi_dma_txd(vdesc);
> +			desc = sdxi_slot_desc(slot);
> +			(void)sdxi_encode_copy(desc, &txd->copy); /* validated at prep */
> +			sdxi_cxt_attach_cst(slot, &txd->completion);
> +			sdxi_desc_make_valid(desc);
> +			list_move_tail(&vdesc->node, &sdchan->vchan.desc_issued);
> +		}
> +
> +		/*
> +		 * FE waits for all copies before notifying and before parsing
> +		 * subsequent copies (SDXI 1.0a 5.3, steps 7-9). One terminator
> +		 * satisfies both flags and supplies internal completion IRQs.
> +		 */
> +		desc = sdxi_slot_desc(sdxi_ring_resv_slot(&resv, copies));
> +		sdxi_encode_intr(desc, &(const struct sdxi_intr) {
> +			.akey = sdxi_akey_index(cxt, sdchan->akey),
> +		});
> +		sdxi_desc_set_fence(desc);
> +		sdxi_desc_make_valid(desc);
> +		pushed = true;
> +	}
> +
> +	return pushed;
> +}
> +
> +static void sdxi_dma_issue_pending(struct dma_chan *dma_chan)
> +{
> +	struct sdxi_dma_chan *sdchan = to_sdxi_dma_chan(dma_chan);
> +
> +	guard(spinlock_irqsave)(&sdchan->vchan.lock);
> +
> +	list_splice_tail_init(&sdchan->vchan.desc_submitted, &sdchan->pending);

why not use vchan's desc_issued?

Frank

> +	if (sdxi_dma_drain_locked(sdchan))
> +		sdxi_cxt_kick(sdchan->cxt);
> +}
> +
> +static int sdxi_dma_terminate_all(struct dma_chan *dma_chan)
> +{
> +	struct sdxi_dma_chan *sdchan = to_sdxi_dma_chan(dma_chan);
> +	struct virt_dma_chan *vchan = &sdchan->vchan;
> +	LIST_HEAD(head);
> +
> +	/*
> +	 * Prepared descriptors remain caller-owned. Free submitted and pending
> +	 * transactions, and move published transactions to desc_terminated in ring
> +	 * order for callback-free reaping.
> +	 */
> +	scoped_guard(spinlock_irqsave, &vchan->lock) {
> +		list_splice_tail_init(&sdchan->pending, &head);
> +		list_splice_tail_init(&vchan->desc_submitted, &head);
> +		list_splice_tail_init(&vchan->desc_issued, &vchan->desc_terminated);
> +	}
> +	vchan_dma_desc_free_list(vchan, &head);
> +
> +	return 0;
> +}
> +
> +/* Bound the wait for issued and pending copies to complete. */
> +#define SDXI_DMA_SYNC_TIMEOUT_US	(10 * USEC_PER_SEC)
> +
> +/*
> + * Reap without relying on the completion IRQ, and report whether the
> + * device is done with every txd that has been or may be placed in the
> + * ring. Pending txds count because dma_chan_put() synchronizes without
> + * terminating first.
> + */
> +static bool sdxi_dma_idle(struct sdxi_dma_chan *sdchan)
> +{
> +	struct virt_dma_chan *vchan = &sdchan->vchan;
> +
> +	guard(spinlock_irqsave)(&vchan->lock);
> +
> +	sdxi_dma_reap_locked(sdchan);
> +	if (sdxi_dma_drain_locked(sdchan))
> +		sdxi_cxt_kick(sdchan->cxt);
> +
> +	return list_empty(&vchan->desc_terminated) &&
> +	       list_empty(&vchan->desc_issued) &&
> +	       list_empty(&sdchan->pending);
> +}
> +
> +static void sdxi_dma_synchronize(struct dma_chan *dma_chan)
> +{
> +	struct sdxi_dma_chan *sdchan = to_sdxi_dma_chan(dma_chan);
> +	struct virt_dma_chan *vchan = &sdchan->vchan;
> +	LIST_HEAD(head);
> +	bool idle;
> +	int err;
> +
> +	/*
> +	 * Callers cannot handle failure, so the wait is not interruptible.
> +	 * Every completion was reaped under vchan.lock, so the tasklet that
> +	 * runs its callback is already scheduled for vchan_synchronize().
> +	 */
> +	err = read_poll_timeout(sdxi_dma_idle, idle, idle, 100,
> +				SDXI_DMA_SYNC_TIMEOUT_US, false, sdchan);
> +	if (err) {
> +		/*
> +		 * Suppress callbacks for outstanding transactions. Completion blocks
> +		 * not released by the reaper stay claimed until context teardown.
> +		 */
> +		scoped_guard(spinlock_irqsave, &vchan->lock) {
> +			list_splice_tail_init(&vchan->desc_issued,
> +					      &vchan->desc_terminated);
> +			list_splice_tail_init(&sdchan->pending, &head);
> +		}
> +		vchan_dma_desc_free_list(vchan, &head);
> +		dev_err(dma_chan->device->dev,
> +			"timed out waiting for DMA channel %d to drain\n",
> +			dma_chan->chan_id);
> +	}
> +
> +	vchan_synchronize(vchan);
> +}
> +
> +static void sdxi_dma_reap_locked(struct sdxi_dma_chan *sdchan)
> +{
> +	struct virt_dma_chan *vchan = &sdchan->vchan;
> +	struct virt_dma_desc *vdesc, *tmp;
> +
> +	lockdep_assert_held(&vchan->lock);
> +
> +	/*
> +	 * Terminated txds are still in the ring. Release them once the device
> +	 * is done, without completing their cookies or invoking callbacks.
> +	 */
> +	list_for_each_entry_safe(vdesc, tmp, &vchan->desc_terminated, node) {
> +		struct sdxi_dma_txd *txd = to_sdxi_dma_txd(vdesc);
> +
> +		if (sdxi_cst_blk_check(txd->completion.cst_blk) == SDXI_COMPLETION_PENDING)
> +			break;
> +
> +		list_del(&vdesc->node);
> +		sdxi_cst_pool_put(sdchan->cxt->cst_pool, txd->completion.cst_blk);
> +		sdxi_dma_txd_free(vdesc);
> +	}
> +
> +	/* Reap completed transactions in cookie order. */
> +	while ((vdesc = vchan_next_desc(vchan))) {
> +		struct sdxi_dma_txd *txd = to_sdxi_dma_txd(vdesc);
> +		enum sdxi_completion_state state;
> +
> +		state = sdxi_cst_blk_check(txd->completion.cst_blk);
> +		if (state == SDXI_COMPLETION_PENDING)
> +			break;
> +
> +		if (state == SDXI_COMPLETION_ERROR)
> +			txd->vdesc.tx_result.result = DMA_TRANS_ABORTED;
> +
> +		list_del(&vdesc->node);
> +		sdxi_cst_pool_put(sdchan->cxt->cst_pool, txd->completion.cst_blk);
> +		txd->completion = (struct sdxi_completion) {};
> +		vchan_cookie_complete(&txd->vdesc);
> +	}
> +
> +	sdxi_ring_wake_up(sdchan->cxt->ring_state);
> +}
> +
> +static irqreturn_t sdxi_dma_cxt_irq(int irq, void *data)
> +{
> +	struct sdxi_dma_chan *sdchan = data;
> +
> +	guard(spinlock_irqsave)(&sdchan->vchan.lock);
> +
> +	sdxi_dma_reap_locked(sdchan);
> +	/* Consumed completion blocks may let stalled pending txds proceed. */
> +	if (sdxi_dma_drain_locked(sdchan))
> +		sdxi_cxt_kick(sdchan->cxt);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int sdxi_dma_alloc_chan_resources(struct dma_chan *dma_chan)
> +{
> +	struct sdxi_dev *sdxi = dev_get_drvdata(dma_chan->device->dev);
> +	struct sdxi_dma_chan *sdchan = to_sdxi_dma_chan(dma_chan);
> +	int vector, irq, err;
> +
> +	sdchan->cxt = sdxi_cxt_new(sdxi);
> +	if (!sdchan->cxt)
> +		return -ENOMEM;
> +	err = vector = sdxi_alloc_vector(sdxi);
> +	if (vector < 0)
> +		goto exit_cxt;
> +
> +	sdchan->vector = vector;
> +
> +	err = irq = sdxi_vector_to_irq(sdxi, vector);
> +	if (irq < 0)
> +		goto free_vector;
> +
> +	sdchan->irq = irq;
> +
> +	/*
> +	 * Note this akey entry is used for both the completion
> +	 * interrupt and source and destination access for copies.
> +	 */
> +	sdchan->akey = sdxi_alloc_akey(sdchan->cxt);
> +	if (!sdchan->akey) {
> +		err = -ENOMEM;
> +		goto free_vector;
> +	}
> +
> +	*sdchan->akey = (typeof(*sdchan->akey)) {
> +		.intr_num = cpu_to_le16(FIELD_PREP(SDXI_AKEY_ENT_VL, 1) |
> +					FIELD_PREP(SDXI_AKEY_ENT_IV, 1) |
> +					FIELD_PREP(SDXI_AKEY_ENT_INTR_NUM,
> +						   vector)),
> +	};
> +
> +	err = request_irq(sdchan->irq, sdxi_dma_cxt_irq,
> +			  IRQF_TRIGGER_NONE, "SDXI DMAengine", sdchan);
> +	if (err)
> +		goto free_akey;
> +
> +	err = sdxi_start_cxt(sdchan->cxt);
> +	if (err)
> +		goto free_irq;
> +
> +	return 0;
> +free_irq:
> +	free_irq(sdchan->irq, sdchan);
> +free_akey:
> +	sdxi_free_akey(sdchan->cxt, sdchan->akey);
> +free_vector:
> +	sdxi_free_vector(sdxi, vector);
> +exit_cxt:
> +	sdxi_cxt_exit(sdchan->cxt);
> +	return err;
> +}
> +
> +static void sdxi_dma_free_chan_resources(struct dma_chan *dma_chan)
> +{
> +	struct sdxi_dma_chan *sdchan = to_sdxi_dma_chan(dma_chan);
> +	LIST_HEAD(head);
> +
> +	sdxi_stop_cxt(sdchan->cxt);
> +	free_irq(sdchan->irq, sdchan);
> +	sdxi_free_vector(sdchan->cxt->sdxi, sdchan->vector);
> +	sdxi_free_akey(sdchan->cxt, sdchan->akey);
> +	/* virt-dma does not know about the driver's pending list. */
> +	scoped_guard(spinlock_irqsave, &sdchan->vchan.lock)
> +		list_splice_tail_init(&sdchan->pending, &head);
> +	vchan_dma_desc_free_list(&sdchan->vchan, &head);
> +	vchan_free_chan_resources(to_virt_chan(dma_chan));
> +	sdxi_cxt_exit(sdchan->cxt);
> +}
> +
> +int sdxi_dma_register(struct sdxi_dev *sdxi)
> +{
> +	struct device *dev = sdxi->dev;
> +	struct sdxi_dma_dev *sddev;
> +	struct dma_device *dma_dev;
> +	unsigned int nr_channels = dma_channels; /* writable module param; snapshot it */
> +	int err;
> +
> +	if (!nr_channels)
> +		return 0;
> +	/*
> +	 * TODO: Require IntrGrp support before registering the DMAengine provider
> +	 * (SDXI 1.0a Table 6-1).
> +	 */
> +
> +	sddev = devm_kzalloc(dev, struct_size(sddev, sdchan, nr_channels),
> +			     GFP_KERNEL);
> +	if (!sddev)
> +		return -ENOMEM;
> +
> +	sddev->nr_channels = nr_channels;
> +
> +	dma_dev = &sddev->dma_dev;
> +	*dma_dev = (typeof(*dma_dev)) {
> +		.dev                 = dev,
> +		.src_addr_widths     = DMA_SLAVE_BUSWIDTH_64_BYTES,
> +		.dst_addr_widths     = DMA_SLAVE_BUSWIDTH_64_BYTES,
> +		.directions          = BIT(DMA_MEM_TO_MEM),
> +		.residue_granularity = DMA_RESIDUE_GRANULARITY_DESCRIPTOR,
> +
> +		.device_alloc_chan_resources = sdxi_dma_alloc_chan_resources,
> +		.device_free_chan_resources  = sdxi_dma_free_chan_resources,
> +
> +		.device_prep_dma_memcpy = sdxi_dma_prep_memcpy,
> +
> +		.device_terminate_all = sdxi_dma_terminate_all,
> +		.device_synchronize = sdxi_dma_synchronize,
> +		.device_tx_status = sdxi_tx_status,
> +		.device_issue_pending = sdxi_dma_issue_pending,
> +	};
> +
> +	dma_cap_set(DMA_MEMCPY, dma_dev->cap_mask);
> +	INIT_LIST_HEAD(&dma_dev->channels);
> +
> +	for (size_t i = 0; i < sddev->nr_channels; ++i) {
> +		struct sdxi_dma_chan *sdchan = &sddev->sdchan[i];
> +
> +		sdchan->vchan.desc_free = sdxi_dma_txd_free;
> +		vchan_init(&sdchan->vchan, &sddev->dma_dev);
> +		INIT_LIST_HEAD(&sdchan->pending);
> +	}
> +
> +	err = dmaenginem_async_device_register(dma_dev);
> +	if (err)
> +		return dev_warn_probe(dev, err, "failed to register dma device\n");
> +
> +	return 0;
> +}
> diff --git a/drivers/dma/sdxi/dma.h b/drivers/dma/sdxi/dma.h
> new file mode 100644
> index 000000000000..d38870ea7d91
> --- /dev/null
> +++ b/drivers/dma/sdxi/dma.h
> @@ -0,0 +1,11 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/* Copyright Advanced Micro Devices, Inc. */
> +
> +#ifndef DMA_SDXI_DMA_H
> +#define DMA_SDXI_DMA_H
> +
> +struct sdxi_dev;
> +
> +int sdxi_dma_register(struct sdxi_dev *sdxi);
> +
> +#endif /* DMA_SDXI_DMA_H */
>
> --
> 2.56.0
>
