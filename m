Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.70.57
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794588713;
	b=jXWeCPlU/NX7w7ey78nkVMzxGlCy0S1fhS9zKrbLNuhzBCZbfmuOVZ9GLheH6L5nIRk3
	 bBvddopxz30La7njwKc5sVUliu8Y9bWOxesGA/MPeB/KWInaXFF20Bu26lvoN7105nU/8
	 jTnqeUjFtx/Em/DpXldn0KeGyYXONxUDjIyQBhUrV/0YA/xGKcCVdf1eYNqw7KeTBqPn/
	 xEv9CQseuYdBCP0QhoapEA98KmvH78PpeogMI6nQb5V/1sOfj80mZOjL4He6akURnKmTH
	 F5fivjOT7Us1n6h1VM2Es9jluqR75TuPO0QfWA8rdfXnXaI4CutlvWTuVZmqBre8kfw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794588713;
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
	bh=UcZnuw8Ae0n9OvDtsEkkELPCmyhU22gFVg9hdvz9HvA=;
	b=RLKIFL0j6FZPmxZrsaZjMu9QWTecR/dSYNABtfg+0W8wUkuVP+YE3cz/JQkJmcQiiZ1r
	 SG5zG+gbb7eb4j8lY8bL8Go5gyJ2dSFuJCzIsIp+vMaIz6K2YIwdCXRaQ12PSCytGhIoe
	 /8DVHDXzO4q6KPajScIk2rklwdCBPOfyssGAiQhdr1GhqXzCj9q6TWM5Oro1kRb77k24T
	 e8m1rdCji9nRbaEYWQ3tMNKLyUCsUl9XQCF7IsqrkF7Has/gbhXF8t2uEttZq26wu6U6K
	 ULBGI4nyGLF2iBdX4lRZecysywdpQTVd/Q/47tBSYfaTv8MkUs9qRcqhiC9nbB6zUdw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b="oirN/89R";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.70.57
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011057.outbound.protection.outlook.com [52.101.70.57])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2CFC606BCA9;
	Fri, 13 Nov 2026 16:51:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F2CFC606BCA9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=oirN/89R
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FQuTRhPwS3nyhApnnhdvSG5GnKnaKhyL2XuHDVfBVzmPDOEhjSUcCIqaK2bkXFj9xM11e2PkM9cpTqCYljZkWgOMAlMfLhQy0HPEVoFwzv4rXfUAhPxKFCk9b99EvJLP5Qx/0hYTdzGdSZFC8mlglKSKQnDYOf+yIf0roAjvcrVr07leXb22bZDGLRwStYGEpf+m3cqrpmL6kMAbf3Jw/zuqFLPP/O9vMtjxvyw79UT82h4f8ABATxsnBzHfUnApp0G0EurJZRU3YWPFCEdSn4svfKah+40/rfdyKavYtPC/f15oxzyEF3/qCZCJsHWMKxjQTvA/sa6lfj7+e8Nh1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UcZnuw8Ae0n9OvDtsEkkELPCmyhU22gFVg9hdvz9HvA=;
 b=l9ue38f8MRRAA8dMXPGeh5MRW/J8R03b+uk9REITlWupxzBkKXT5ZPa+pX42/usctn8J5WAXt0xl3fo82GXYxg6djBnqOtjnEZhYcT/7GD77NQy5h/CdVgjGFxGQ/coEft34VSPXX1fkq8S1n8tBHu1X0usJnQJ074BVfGckoXGSPq7knJqUxBDXSGZqiPdekMzxNKVNlqM+g03geOsNac+WjgNPmX9ysVRgxfivLuh75SuvoDZ6Ia2tLa1hVwg0jwoi0fnBHKPRUjx77uJAkExLPCbCejn0UlL8Ag7desZuGf7Tw5oxFCPUpdZdOjroqy7Cw8k36KrizywXVm8Vmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UcZnuw8Ae0n9OvDtsEkkELPCmyhU22gFVg9hdvz9HvA=;
 b=oirN/89RFqz0W3CLI65okHXkZz8c4FCdzBf9TrqwY5ghu/lDLGotPCJikz0Dc3Ky4LuNUSr4FEqfwZW5kWy715oJ13yxx/rYwkxpqkIXTMURlPnEfL6vTvl64tKgdNcy7qyoVNgiCOyvyAAqi8bvRlX9eS5jlskyXRRyVLQHQ5wlUv0MVUkm+NjFsBBXPn2P3+2r7TWB9403AZe/BtAFGFLHrxM3ApQlRYKLniC8UZfitLoiR9ZAzVGom1FO0yXwTWfbE7A8O5f+03YIF5OblMJgiVnmHmBR1mNvgh5UNC8vVqZrurjdVF7q3zu2BItsSahbyJaQGPKmKUS6aonJLg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by DBBPR04MB7689.eurprd04.prod.outlook.com (2603:10a6:10:206::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Fri, 13 Nov
 2026 16:51:50 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%4]) with mapi id 15.21.0615.009; Fri, 13 Nov 2026
 16:51:50 +0000
Date: Fri, 13 Nov 2026 11:51:41 -0500
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
Subject: Re: [PATCH v4 13/25] dmaengine: sdxi: Add descriptor ring management
Message-ID: <avdAHZ2ZmupYG2Dh@lizhi-Precision-Tower-5810>
References: <20261103-sdxi-base-v4-0-3668ccc7aab8@amd.com>
 <20261103-sdxi-base-v4-13-3668ccc7aab8@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261103-sdxi-base-v4-13-3668ccc7aab8@amd.com>
X-ClientProxiedBy: DS7PR03CA0183.namprd03.prod.outlook.com
 (2603:10b6:5:3b6::8) To MI3PR04MB12438.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|DBBPR04MB7689:EE_
X-MS-Office365-Filtering-Correlation-Id: 445c6fc2-e341-44d6-3fdf-08df41a66968
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|376014|7416014|23010399003|1800799024|18002099003|22082099003|56012099006|261021121427099003|11063799006|4143699003|261102130727099003|261028144727099003|261026121527099003|261022105027099003|261022075727099003|261021123027099003|261021135927099003|261102123227099003|261009223027099003|10067099003|261026140227099003;
X-Microsoft-Antispam-Message-Info:
	hO+FIWtxN57e5KFm6ALKd011TRxO6QtcrFLUHLQHQ00yUG9kbKd1rLAC4JGvpLSPlPDAvpz9swq7izwhy9eHOJluQnhjZbpYK4gY0Ln1mmOht681fUY3ItoIvsbNTiBnGShroYHAEACnWp8lPSZGexDRg16XXfwMXcBmqFx9d3XtwwElxKcf+pDdKHZsdepiOh9/FdRE+kTYiG1NfaDvZRcaWjBrl/8QNhD+vFY8yJIEix+lAKb8q+uKq82PgYUP48yZOsmP3V5D4gviv29SyQlGLgm7PdyBQl9ks8K5M4VbcN84/IVhxJNzH5dZOGL9tjxsOL97zVpkukENbHLyucZnB7VKUki3MN+aub9LSecOkxx3gQLI0rZKiUDSSJ/0x+rEyRK/vqIWfzwucM/2PYBxqWWl7HRvhLvTL0w1WjmRBT+ALjDHQ/1OmZ/JmOmG5VY0qFbzbyovXcMi2CaZsRzt50ekcmpVK0QT4fiUwQP3vFcWxurEqoJFUhlR6RtFSxjjBjXQEuAcVmXw9otonRLbAFbJQ/oV6WD+oK4F9GWFTI7K+2mekRV/cjX168PYpmUFZQP/fPP1qpSIdr0LDh+3HX+ZbcGZVjJw72+yFEwSjkZFXJJhe6OQ6CAUfWblasfHxExdRW7iIqu/ycW2wDsTZZAXPO4nOgNW1MHhpBU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(376014)(7416014)(23010399003)(1800799024)(18002099003)(22082099003)(56012099006)(261021121427099003)(11063799006)(4143699003)(261102130727099003)(261028144727099003)(261026121527099003)(261022105027099003)(261022075727099003)(261021123027099003)(261021135927099003)(261102123227099003)(261009223027099003)(10067099003)(261026140227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kAw7+U/DoHSuyyLs9SUHwzJTJ6FVBS3QUx2rCmy01G0mwuejKLhdn2xGeXlp?=
 =?us-ascii?Q?puiGML+3Yglb+9VHfOOs4hhpJTMYy1mDi74FL2ycbaml90YsL79C6bBb4odL?=
 =?us-ascii?Q?vU7F45s8ELvR07zYsSbzjXMUL2TOT3h8Ve8wh138jHrWTXNIW8XXaRdQsuOk?=
 =?us-ascii?Q?Uc3Dx2HCSFp7RMTvJ4SZ5camrKEMw2EsSjNUUwA8Y1ZB6Idq3aig4e8PFXsl?=
 =?us-ascii?Q?e+PVKb6nGCqR/dKYEd4+2/kWyr6vbbnDCcLwEW0iCLEpU+AQq+U1ekjQ3b9O?=
 =?us-ascii?Q?O6wF14Y4ksEuLvlZlcYHJ6NOPf8p5E3LV9wyI9usN61WuPfKGF0cXRsCpLy8?=
 =?us-ascii?Q?/RT/vwA9sCgBqBPBU/PR6YqJY7DszKe4f6Oz/RyRoWltM1/1zXapHlrsRmKy?=
 =?us-ascii?Q?W3MqC5/hoUVvN7VTajlOrt78xvX96qYqnbqSX6mPtH8UntpI9ewuch2X90w5?=
 =?us-ascii?Q?Fa50hHMYy1o0175s+3SZwCl795p9ipTlx5HQCmnFr46H9lwx5FEUSRStk2m/?=
 =?us-ascii?Q?cC4nsqb8xZ+7ozyfcMQuZmwC4yp6eKWjTHmusDtd+WQBTzUQ9z/r1ntFhlOu?=
 =?us-ascii?Q?nUdOW+fMdYO6NYBAskrFNG0fem/8dBKgmCwf+Sk/Gq3TneVfzMa9DG/z75KN?=
 =?us-ascii?Q?YdKJWjGroi+lX+Hmj200Mj5Rg/+nNDF24Fel824e79H3nr3jdMDoVKMjjrQ2?=
 =?us-ascii?Q?YmD6WCZR4QhEJtX3NXbQF5M+DGJJsUbcovq3B1k/I2F9ZwuIlxZW5Jlz7CNc?=
 =?us-ascii?Q?dKFP4R5RcNRs4iMoTJTUc81/uMPCBtBeWN4Nyfd50y5wDWR0Z9KWsavZUjBd?=
 =?us-ascii?Q?6PuZHVlrLORvD5NjNPzvLGwsf/uYXURcXw3noqEUOzun9j/7B5BbVGk5jdfl?=
 =?us-ascii?Q?AKO6S9NwqPIva+8TEI8kMgUykpSY2Iz4DgMJl1Hs8zgfW5d8sbAZw+h0aEdZ?=
 =?us-ascii?Q?v3Hc6E8pfbkwDawL7wzGONH6b29oj//f2dkn6Xdkt4DyAxV8L338VTGoC7bQ?=
 =?us-ascii?Q?gtGp2MOWJ7qhiAKYUXiOY1+Z8ROElebDJ8Eb8Hh+OG0voX7hTF+M0CeB26/Y?=
 =?us-ascii?Q?g1FtugyuSOh7gUCn1t0lmFYJyE203cfXltFfth4GoVAODdrzQTSYIRMUndfd?=
 =?us-ascii?Q?pZPoFHo36dqdiqNI1nq77/OCKndsbVlqMtXfKrzAW04VMsDevv21LhwsunEg?=
 =?us-ascii?Q?GE7egzFyke14ZhluCfRYZMO7FGoBoOaCBwWoCBj6+oc3jVA/yHArnJDXnMZ+?=
 =?us-ascii?Q?qm3KqzTa/zi1dW0/lZWm3jY4TFDwoi+IW7iNC22rhPmOBvjTxazMr+SI7JuW?=
 =?us-ascii?Q?zy88WzAGeacpwO024exbFFjLYw6qHhfAkFDL++ckdHzE6FJ4HkqBbxJI5e74?=
 =?us-ascii?Q?Vvf5iezYpwpBDyJv50xvvK+7YYi/w3uRW23mKy7SbjleETjy14MH6DKWvDt/?=
 =?us-ascii?Q?gW7y6UdcSuEHLHM6oLo3YjU5o8yNXWPpiHGiCdrjb9RZjHj9sH563npzEO4p?=
 =?us-ascii?Q?BHYh0EL4D9qaWD30rmpkQ8VXjMdAOey+J4I80CYeyIdvdX54b76UG7XeuV5r?=
 =?us-ascii?Q?d/m5TfJfVr935q/94tXPS7/znMFQxbFu9ggwi0UW42ECfy5M6GXaFLmmJBOL?=
 =?us-ascii?Q?Mi+r0s2JVoUPXLEu4Ya/OZMTOKNarm+o8WAvEaydoUXijg/MFgzVznwz7XSO?=
 =?us-ascii?Q?oa0fRMjNVDbJftWwHZpp5ySC0zD2q/LWSzDF+nRvI3Q1kqzrWY+PyBvwS3FB?=
 =?us-ascii?Q?edWoPoR+wciN9E1uOISMttBVR7Yu1LhrkvdOXNVpEqulINTtm5h6?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 445c6fc2-e341-44d6-3fdf-08df41a66968
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 16:51:50.0566
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T5riN6DDnPB28f9zLvOFaNLBBiTDCIF6kkxxULOLXZeGJe0SpveSzGsh5gh+0iPM5enpVDDstPp890j0dl6MMyCOqVrJhbCRZHRGTWfQYLMCNibbT+hPoCLcGTy3drl8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7689

On Tue, Nov 03, 2026 at 08:49:54PM -0600, Nathan Lynch wrote:
> Introduce software state and reservation helpers for driving an SDXI
> submission queue. A spinlock serializes space checks and write-index
> updates; blocking reservations use a bounded, killable wait.
>
> Provide exact-size and bounded-size reservations, with descriptor access
> through a ring slot carrying its index and ring state. Reservations
> publish the write index and cannot be rolled back, so callers must
> populate and publish every reserved slot.
>
> Allocate and initialize ring state with each administrative or client
> context, and free it during context release.
>
> The hardware read index bounds descriptor reuse. Completion handlers
> wake blocked reservations as hardware consumes slots.
>
> Co-developed-by: Wei Huang <wei.huang2@amd.com>
> Signed-off-by: Wei Huang <wei.huang2@amd.com>
> Signed-off-by: Nathan Lynch <nathan.lynch@amd.com>
> ---
>  drivers/dma/sdxi/Makefile  |   3 +-
>  drivers/dma/sdxi/context.c |   9 +++
>  drivers/dma/sdxi/context.h |   2 +
>  drivers/dma/sdxi/ring.c    | 143 +++++++++++++++++++++++++++++++++++++++++++++
>  drivers/dma/sdxi/ring.h    |  94 +++++++++++++++++++++++++++++
>  5 files changed, 250 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/dma/sdxi/Makefile b/drivers/dma/sdxi/Makefile
> index cdf8a455077b..bfcb443f1e64 100644
> --- a/drivers/dma/sdxi/Makefile
> +++ b/drivers/dma/sdxi/Makefile
> @@ -2,7 +2,8 @@
>  obj-$(CONFIG_SDXI_CORE) += sdxi-core.o
>  sdxi-core-y := \
>  	context.o     \
> -	device.o
> +	device.o      \
> +	ring.o
>
>  obj-$(CONFIG_SDXI_PCI) += sdxi-pci.o
>  sdxi-pci-y := pci.o
> diff --git a/drivers/dma/sdxi/context.c b/drivers/dma/sdxi/context.c
> index f52479ecf96a..b26eec3805fb 100644
> --- a/drivers/dma/sdxi/context.c
> +++ b/drivers/dma/sdxi/context.c
> @@ -23,6 +23,7 @@
>
>  #include "context.h"
>  #include "hw.h"
> +#include "ring.h"
>  #include "sdxi.h"
>  #include "submission.h"
>
> @@ -56,6 +57,7 @@ static void sdxi_free_cxt(struct sdxi_cxt *cxt)
>  				  cxt->akey_table, cxt->akey_table_dma);
>  	if (cxt->sq)
>  		sdxi_sq_free(sdxi, cxt->sq);
> +	kfree(cxt->ring_state);
>  	kfree(cxt);
>  }
>
> @@ -72,6 +74,10 @@ static struct sdxi_cxt *sdxi_alloc_cxt(struct sdxi_dev *sdxi)
>
>  	cxt->sdxi = sdxi;
>
> +	cxt->ring_state = kzalloc_obj(*cxt->ring_state, GFP_KERNEL);
> +	if (!cxt->ring_state)
> +		return NULL;
> +
>  	cxt->sq = sdxi_sq_alloc(sdxi, DEFAULT_DESC_RING_ENTRIES);
>  	if (!cxt->sq)
>  		return NULL;

Is it possible embedded ring_state into sq or sq embedded ring state to
alloc twice memory.

Frank
> @@ -243,6 +249,7 @@ int sdxi_admin_cxt_init(struct sdxi_dev *sdxi)
>  	sq->cxt_sts.state = FIELD_PREP(SDXI_CXT_STS_STATE, CXTV_RUN);
>  	cxt->id = SDXI_ADMIN_CXT_ID;
>  	cxt->sq->doorbell = sdxi->dbs + cxt->id * sdxi->db_stride;
> +	sdxi_ring_state_init(cxt->ring_state, sq);
>
>  	err = sdxi_publish_cxt(cxt);
>  	if (err)
> @@ -324,6 +331,8 @@ struct sdxi_cxt *sdxi_cxt_new(struct sdxi_dev *sdxi)
>
>  	cxt->sq->doorbell = sdxi->dbs + cxt->id * sdxi->db_stride;
>
> +	sdxi_ring_state_init(cxt->ring_state, cxt->sq);
> +
>  	if (sdxi_publish_cxt(cxt))
>  		return NULL;
>
> diff --git a/drivers/dma/sdxi/context.h b/drivers/dma/sdxi/context.h
> index 28cd7ed401f8..14ce4f5f9b74 100644
> --- a/drivers/dma/sdxi/context.h
> +++ b/drivers/dma/sdxi/context.h
> @@ -36,6 +36,8 @@ struct sdxi_cxt {
>  	dma_addr_t akey_table_dma;
>
>  	struct sdxi_sq *sq;
> +
> +	struct sdxi_ring_state *ring_state;
>  };
>
>  int sdxi_admin_cxt_init(struct sdxi_dev *sdxi);
> diff --git a/drivers/dma/sdxi/ring.c b/drivers/dma/sdxi/ring.c
> new file mode 100644
> index 000000000000..a15c8751a7be
> --- /dev/null
> +++ b/drivers/dma/sdxi/ring.c
> @@ -0,0 +1,143 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * SDXI descriptor ring reservations and write index management
> + *
> + * Copyright Advanced Micro Devices, Inc.
> + */
> +#include <kunit/test-bug.h>
> +#include <kunit/visibility.h>
> +#include <linux/io-64-nonatomic-lo-hi.h>
> +#include <linux/jiffies.h>
> +#include <linux/lockdep.h>
> +#include <linux/range.h>
> +#include <linux/sched.h>
> +#include <linux/spinlock.h>
> +#include <linux/types.h>
> +#include <linux/wait.h>
> +#include <asm/barrier.h>
> +#include <asm/byteorder.h>
> +#include <asm/div64.h>
> +#include <asm/rwonce.h>
> +
> +#include "ring.h"
> +#include "hw.h"
> +#include "submission.h"
> +
> +/*
> + * Initialize ring management state from a submission queue. Caller is
> + * responsible for allocating and initializing @sq.
> + */
> +void sdxi_ring_state_init(struct sdxi_ring_state *rs, struct sdxi_sq *sq)
> +{
> +	WARN_ON_ONCE(!sq);
> +	/*
> +	 * See SDXI 1.0 Table 3-1 Memory Structure Summary. Minimum
> +	 * descriptor ring size in bytes is 64KB; thus 1024 64-byte
> +	 * entries.
> +	 */
> +	WARN_ON_ONCE(sq->count < SZ_1K);
> +
> +	*rs = (typeof(*rs)) {
> +		.sq = sq,
> +	};
> +	spin_lock_init(&rs->lock);
> +	init_waitqueue_head(&rs->wqh);
> +}
> +EXPORT_SYMBOL_IF_KUNIT(sdxi_ring_state_init);
> +
> +/*
> + * Non-blocking ring reservation. Callers must handle ring full (-EBUSY).
> + *
> + * Reserving publishes the write index before the caller has written the
> + * descriptors. Callers are required to publish every reserved slot.
> + */
> +int sdxi_ring_try_reserve_range(struct sdxi_ring_state *rs, size_t min_nr,
> +				size_t max_nr, struct sdxi_ring_resv *resv)
> +{
> +	struct sdxi_sq *sq = rs->sq;
> +	u64 ridx, widx, available;
> +	size_t nr;
> +
> +	if (!min_nr || min_nr > max_nr || max_nr > sq->count) {
> +		WARN_ONCE(!kunit_get_current_test(),
> +			  "Reservation of size %zu..%zu requested from ring of size %u\n",
> +			  min_nr, max_nr, sq->count);
> +		return -EINVAL;
> +	}
> +
> +	guard(spinlock_irqsave)(&rs->lock);
> +	/* SDXI 1.0a 5.3: Read_Index advances at execution start. */
> +	ridx = le64_to_cpu(READ_ONCE(sq->cxt_sts.read_index));
> +	widx = le64_to_cpu(sq->write_index);
> +	if (ridx > widx)
> +		return -EIO;
> +	if (widx - ridx > sq->count)
> +		return -EIO;
> +
> +	available = sq->count - (widx - ridx);
> +	if (available < min_nr)
> +		return -EBUSY;
> +	nr = min_t(u64, max_nr, available);
> +
> +	/* The device reads this; it must not observe a torn value. */
> +	WRITE_ONCE(sq->write_index, cpu_to_le64(widx + nr));
> +	*resv = (typeof(*resv)) {
> +		.rs = rs,
> +		.range = {
> +			.start = widx,
> +			.end = widx + nr - 1,
> +		},
> +	};
> +	return 0;
> +}
> +EXPORT_SYMBOL_IF_KUNIT(sdxi_ring_try_reserve_range);
> +
> +int sdxi_ring_try_reserve(struct sdxi_ring_state *rs, size_t nr,
> +			  struct sdxi_ring_resv *resv)
> +{
> +	return sdxi_ring_try_reserve_range(rs, nr, nr, resv);
> +}
> +EXPORT_SYMBOL_IF_KUNIT(sdxi_ring_try_reserve);
> +
> +/*
> + * Wait up to one second for ring space; return early on success, a
> + * non-transient error, or a fatal signal.
> + */
> +int sdxi_ring_reserve(struct sdxi_ring_state *rs, size_t nr,
> +		      struct sdxi_ring_resv *resv)
> +{
> +	int ret, left;
> +
> +	left = wait_event_killable_timeout(rs->wqh,
> +					   (ret = sdxi_ring_try_reserve(rs, nr, resv)) != -EBUSY,
> +					   HZ);
> +
> +	/* success or hard error from try_reserve() */
> +	if (left > 0)
> +		return ret;
> +
> +	/* timed out */
> +	if (left == 0)
> +		return -ETIMEDOUT;
> +
> +	/* killed: -ERESTARTSYS */
> +	return left;
> +}
> +
> +/* Completion code should call this whenever descriptors have been consumed. */
> +void sdxi_ring_wake_up(struct sdxi_ring_state *rs)
> +{
> +	wake_up_all(&rs->wqh);
> +}
> +
> +/*
> + * Map a logical (unwrapped) ring index onto its entry. The ring size is
> + * not constrained to a power of two, hence the division.
> + */
> +struct sdxi_desc *sdxi_ring_desc(const struct sdxi_ring_state *rs, u64 index)
> +{
> +	struct sdxi_sq *sq = rs->sq;
> +
> +	return &sq->ring[do_div(index, sq->count)];
> +}
> +EXPORT_SYMBOL_IF_KUNIT(sdxi_ring_desc);
> diff --git a/drivers/dma/sdxi/ring.h b/drivers/dma/sdxi/ring.h
> new file mode 100644
> index 000000000000..fb6c7ab36b57
> --- /dev/null
> +++ b/drivers/dma/sdxi/ring.h
> @@ -0,0 +1,94 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/* Copyright Advanced Micro Devices, Inc. */
> +#ifndef DMA_SDXI_RING_H
> +#define DMA_SDXI_RING_H
> +
> +#include <linux/bug.h>
> +#include <linux/io-64-nonatomic-lo-hi.h>
> +#include <linux/range.h>
> +#include <linux/spinlock.h>
> +#include <linux/types.h>
> +#include <linux/wait.h>
> +#include <asm/barrier.h>
> +#include <asm/byteorder.h>
> +#include <asm/div64.h>
> +#include <asm/rwonce.h>
> +
> +#include "hw.h"
> +
> +struct sdxi_sq;
> +
> +/*
> + * struct sdxi_ring_state - Software state for driving a submission queue.
> + *
> + * @lock: Guards the write index.
> + * @sq: The submission queue being driven.
> + * @wqh: Pending reservations.
> + */
> +struct sdxi_ring_state {
> +	spinlock_t lock;
> +	struct sdxi_sq *sq;
> +	wait_queue_head_t wqh;
> +};
> +
> +/*
> + * A claim on a contiguous span of the ring's logical index space. The
> + * indexes are monotonic and unwrapped; sdxi_ring_desc() maps them onto
> + * ring entries.
> + */
> +struct sdxi_ring_resv {
> +	const struct sdxi_ring_state *rs;
> +	struct range range;
> +};
> +
> +void sdxi_ring_state_init(struct sdxi_ring_state *ring, struct sdxi_sq *sq);
> +void sdxi_ring_wake_up(struct sdxi_ring_state *rs);
> +int sdxi_ring_reserve(struct sdxi_ring_state *ring, size_t nr,
> +		      struct sdxi_ring_resv *resv);
> +int sdxi_ring_try_reserve(struct sdxi_ring_state *ring, size_t nr,
> +			  struct sdxi_ring_resv *resv);
> +int sdxi_ring_try_reserve_range(struct sdxi_ring_state *rs, size_t min_nr,
> +				size_t max_nr, struct sdxi_ring_resv *resv);
> +struct sdxi_desc *sdxi_ring_desc(const struct sdxi_ring_state *rs, u64 index);
> +
> +/* Number of slots held by @resv. */
> +static inline size_t sdxi_ring_resv_count(const struct sdxi_ring_resv *resv)
> +{
> +	return range_len(&resv->range);
> +}
> +
> +/*
> + * Logical index of slot @i of @resv, suitable for passing to
> + * sdxi_ring_desc(). @i must be less than sdxi_ring_resv_count().
> + */
> +static inline u64 sdxi_ring_resv_index(const struct sdxi_ring_resv *resv,
> +				       unsigned int i)
> +{
> +	/* Keep a caller's mistake inside the slots it owns. */
> +	if (WARN_ON_ONCE(i >= sdxi_ring_resv_count(resv)))
> +		return resv->range.start;
> +	return resv->range.start + i;
> +}
> +
> +/* A reserved descriptor slot identified by its ring and logical index. */
> +struct sdxi_slot {
> +	const struct sdxi_ring_state *rs;
> +	u64 index;
> +};
> +
> +/* Slot @i of @resv. @i must be less than sdxi_ring_resv_count(). */
> +static inline struct sdxi_slot sdxi_ring_resv_slot(const struct sdxi_ring_resv *resv,
> +						   unsigned int i)
> +{
> +	return (struct sdxi_slot) {
> +		.rs = resv->rs,
> +		.index = sdxi_ring_resv_index(resv, i),
> +	};
> +}
> +
> +static inline struct sdxi_desc *sdxi_slot_desc(struct sdxi_slot slot)
> +{
> +	return sdxi_ring_desc(slot.rs, slot.index);
> +}
> +
> +#endif /* DMA_SDXI_RING_H */
>
> --
> 2.56.0
>
