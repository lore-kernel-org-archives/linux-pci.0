Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021098.outbound.protection.outlook.com [52.101.95.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D090C239E75;
	Thu, 19 Feb 2026 14:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.95.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771512590; cv=fail; b=Lxy7ErqzWJAF+dA2YBN5tM1E8cMz/9n4SVdmYeYZUyzeJ1+yf4uO95C9nzYRZEV1MaKO6AOjJAYAYSER6gV++6q9k4CBzwUjDTO3tyZ3INQgBZryBbByaUwpeuXLzX0qmX+aTRtkGxc5BOnMeJDdp7FdIJZAOlZACUJ1Jf4V6Tk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771512590; c=relaxed/simple;
	bh=JjjUoZ4tVZUyS/PdEYfw1GN3Qrk8vIxGk/IzKcvjEG4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Message-ID:
	 Content-Type:MIME-Version; b=ja/RKy0Eo4i3DYCuxmzZQ6zzg2teA+EiGvcmryOH/nT2Ito5EgSA080Lf3dyiAEo+XiRgwfcQYk1tRcWOmP7AW9plMo5eWcfNWrrPmG4zuX9xK5IwPQsMC656XDVrOTAZxkaYvR3rhMoAa0lGELc2zJDEU53wrcyzHe5h0NPRHM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=QE12bhse; arc=fail smtp.client-ip=52.101.95.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="QE12bhse"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lc1RQey1yVCGat0pREPQy0ufwXGizy8CuV8rYIVzy0HPQTJwV53zcwbKOliYuPPfvmiwdGtSjCMrIiM1lftyCsHWbRiiYGTjYS9hNBuAFcyyvyn963B513vk+kmTV3Yevlrp93NgzWIhxaizAdLg/fVRBLDezYwPW7F7rRCmuNLtpsjo9jLTtchGuKywT5sEX0t64QyU8mk8aGQaJv5iZYITzpXBHxl0alPqWmwrAa0BR85iUHKgs+hxWqhTUr93L3sT8FAfC4rlLTKju4p0IYpo5tPZuHBhmzuOiy8Fm2m60VFyqHZdDk+MRLAhGqAHrZvOUMYIBkcJTXY/AhjAZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dUn0+rDCX5zDDEwzOX35VgndBpzOXo4rA1wDC+pmBjA=;
 b=iXaeshirKPh3ELKDJkPAUTmGhzX652o3Bm7xxVAiASg+aqwx4/xU57CkS4V0jw0DVoE+HlDfekipmF8r7OdBjZ8tavxekMBjM7aZDF6mk7EP7NntAONCRaSUdjEjIxgHLWaYcSUWVp3IzR1OVtT1FoZS45oAobpcsshYjxFO14Ojnxg5pHzQuWhbM8aNOKZXaMrrPkUvWD6sa8jG1l0TbcaQaBNgHZLQTvInT8E9Ox5rT4BUPi4oIENyHbrYJmwQCiH0BRq030JZIURq79EDkuw/QFFwfTe3RAvxhgF9ZFbJ+2RP85rQAtYA1oQec4Ig+5OFNHDup1tZxot+ViU2DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dUn0+rDCX5zDDEwzOX35VgndBpzOXo4rA1wDC+pmBjA=;
 b=QE12bhseoUE+tchIOStl64qMvMS5W8L8o+/QFSzHeYHwMXCUNs1zOehTOd7WuWo1x6Rn0xzavanzUlpN8mbRczXIJb89nJmuzv8WeR+17B38JwWkuO1YqlXimgngHy0CHGooAvadX0z9RqTQF7lI1SkOeum+cjBvjjlf0LzB6nA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO4P265MB6983.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:34c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.16; Thu, 19 Feb
 2026 14:49:45 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%5]) with mapi id 15.20.9632.010; Thu, 19 Feb 2026
 14:49:45 +0000
Date: Thu, 19 Feb 2026 14:49:45 +0000
From: Gary Guo <gary@garyguo.net>
To: alistair23@gmail.com
Cc: bhelgaas@google.com, lukas@wunner.de, rust-for-linux@vger.kernel.org,
 akpm@linux-foundation.org, linux-pci@vger.kernel.org,
 Jonathan.Cameron@huawei.com, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org, alex.gaynor@gmail.com, benno.lossin@proton.me,
 boqun.feng@gmail.com, a.hindborg@kernel.org, bjorn3_gh@protonmail.com,
 tmgross@umich.edu, ojeda@kernel.org, wilfred.mallawa@wdc.com,
 aliceryhl@google.com, Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [RFC v3 07/27] rust: error: impl From<FromBytesWithNulError> for
 Kernel Error
In-Reply-To: <20260211032935.2705841-8-alistair.francis@wdc.com>
References: <20260211032935.2705841-1-alistair.francis@wdc.com>
 <20260211032935.2705841-8-alistair.francis@wdc.com>
Message-ID: <8403c8b7a832b5274743816eb77abfa4@garyguo.net>
X-Sender: gary@garyguo.net
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0482.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:13a::7) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO4P265MB6983:EE_
X-MS-Office365-Filtering-Correlation-Id: 36b5ddb7-428c-41b6-7b38-08de6fc61f81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|376014|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/S2s4teXFqReSz3Ea7vKmTNc5b1183kh/bqeiaLcdrToM0l4rfNOyTz5Pn5X?=
 =?us-ascii?Q?A/Ij1oGgdBIrwENbKwnKBLHVn2T3aAaL14jwU4a2gaMIg4t20bVOiy0KWLdx?=
 =?us-ascii?Q?+LLGtUdF712jBq6hrzFXVo7odfUaIR/QV6b8fxKfKM0ODDknjL2a9q4BddLA?=
 =?us-ascii?Q?ZMT0Iv6+VYU1Wv0cjRGvf9hNqhA4JC0zLciQ6vH7nkPg8R2JqztamerZ1LgP?=
 =?us-ascii?Q?2zlG1ep1fv3wUaFhezMHGhjz8tIchI7P4VGdKn+Ep4Fh0NjMmkCshU5+omdr?=
 =?us-ascii?Q?NnOWrYFl4/9PLIhEAgxmkrmnArFQ72lvOJIVQE/J3zZZbPGxR/mH4Yds6uCm?=
 =?us-ascii?Q?S1K67gTlTmX2FYJwW2dN/UUzuKtdtfX8uvuQcfJjhQ1Lm0SvBHHPgvgxRA4M?=
 =?us-ascii?Q?EwmkZOvKrVACYeeGcsWUpTP8EDiPmpiQTEPwIGhEGs5XbeAyI4w8JAd3kRaz?=
 =?us-ascii?Q?RDpGH0wwTSSTycnnk3T19GlzaHPw175Sge6g1akNM5k+vYLENAd1q4KDW4cN?=
 =?us-ascii?Q?cLFwJu1C+pE2OcRK3yPnmO3WN0pL70kO4bS7ZgpmAO1UtwvGRM2jerJp9mNc?=
 =?us-ascii?Q?l1jJ7hp4mgzdpVCDbI+I7vhl7vNnMm2uE8iBoHy1sTiHRrvhMCAW387u7M+/?=
 =?us-ascii?Q?sVbfujmoYWRtkUcajmfM7SWWWUPoZ7mo3np8THRtn51OCOsxyOJbU6eiJSrc?=
 =?us-ascii?Q?ftj1rKEIRjUIUkefjrkbotNCekR+rx8UIWaUMnnlu5/isGU//QYO8abFgtZ1?=
 =?us-ascii?Q?/r+ajh7pymoHum+g4bsWODbIGKs9e4oRokDzpdO8jJ6vorFIE9fTCwEwftoD?=
 =?us-ascii?Q?TIsHRIsNT+0lCGUv/x63sw8fc/50Zr6NKOMfnphBvLv40oUrQe5z+N4kObkn?=
 =?us-ascii?Q?pXyjJvQgilXigNVXJ/Wq0qR2/7uP+Dp7jHGZuWVj9xvzxUF0o3jckK1k9OTg?=
 =?us-ascii?Q?PCgOPcu3pQbHPqzo4P1b/4FxU+kurWTF2LXz97C7Tm14bQFtRrXnMPh1Da6e?=
 =?us-ascii?Q?wJ5+cG9VAZjgIZTH5emy5KYfYZLzFBlwh8j7e2wfuYMhaOIcgiaZsMM/UyWx?=
 =?us-ascii?Q?Pol99o50TAulQtE1RUHt/iTHHq1qDYh6chM7cYstJm2k8KLmcGXStzcF4knj?=
 =?us-ascii?Q?K6ECEgncYI+can6spcjfPHSDToKuVe3RnxtUGU+BF5936LOrGeqnvNeYRxaW?=
 =?us-ascii?Q?ALi0dI1mVcaVGdww1iVlcQJW5QuGmdSbj+tCpIAtyjc9SH/MK9RHfD6CZTBb?=
 =?us-ascii?Q?P3FOiXNyOzfQpGic+T+xQXwA2jA3sDJlXnFg9McP7NPcYFKl2slLmiL2jW1a?=
 =?us-ascii?Q?RB0rEfCd6dwDQMMs0JqgaVyd8irvoSD23I6uQl83WCDa/0c7NWdi7e3l3GAF?=
 =?us-ascii?Q?F2ivpIl2RbasiljmYxk1NIltRQjOICMM3dsYIDsNgv5pru6vmc4idaz+8kl5?=
 =?us-ascii?Q?X3PoMRPdtbJCYq7MRhbYC7+61VQnMv8Ke8b3mWa20tzvaRvxCaTCWls3gpA5?=
 =?us-ascii?Q?uDcO9RY2RBVObP4XIRkgFOBrh5PTBbBVLgHtMblc4t//wwKCFgmzwwNyCwGM?=
 =?us-ascii?Q?wMiteUIombJTA/a43fo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(376014)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?s4RSNcRdwfSBNJ3cKyvvd09YD1RImzymxudQOsmBrNSwvx7qT59y3Zexs1hJ?=
 =?us-ascii?Q?ah0eyz/UJIrlwukHW8KAjjByd4E9vLJY0zwzxUpCBl46fHXyv6WUctkmPHrT?=
 =?us-ascii?Q?+MumL4ogTwbPIT6h8qegfkFJ+x1B4fV4lNd/Mer/AfppO+qOBAr5RFth45h/?=
 =?us-ascii?Q?JcrJAKOoRi9+EtBNEmslZKv0L7IWnnVStQ1ZYV64cdoFh0JzScQHhXZRLSmA?=
 =?us-ascii?Q?pUrzvbOi1OJiDoTktckbJEz+nq2HKK71lqw+IEVMJMPx25WLRKS4w2MdStGH?=
 =?us-ascii?Q?b4mn63uHm2jnkU2v3LfgnlUHGm9GDfV84Sfn20KucSXkcmYadBlTD7PlEK28?=
 =?us-ascii?Q?NDvI+2EBq726deEDr+9KoSw00S5IwqOUNEz6SEXmR4A5iICwL+aXX5vJCgew?=
 =?us-ascii?Q?PKZWWLIV1pecBGZNUdGKRkHjU2rmFVYJ42P2Yce7pBmQmzwlgfbhNy8IrnI4?=
 =?us-ascii?Q?cQdqrGDix7nxaC3GXLNARHsFQ7YKPyxUuZu28r13DUJmvJ/nHjcK/q1BrEDz?=
 =?us-ascii?Q?GCcxKMq8aX9cbJ19ObwMhwlL7N9OPfH6BW4+c4VwzNcM3MijbaBhpkr7hyfK?=
 =?us-ascii?Q?CFtmadQOswuSph0U2pmimmvWsQDsdIqR3+Tv8NdYKgopVKgHqTwtdyiXErrP?=
 =?us-ascii?Q?6a7dHM5oS5XoZguK2H341CwwyE/c5WfYaZgQwMwI8M247qQzUz0gxqRYehlC?=
 =?us-ascii?Q?/lN0HGHz/U7nZohDbHr1uVw2iAGCgjKfelQvS0zm3JRl54nCrCDhNf5yDnEE?=
 =?us-ascii?Q?QDQTOztJplnkSFDuCsuhgtsKZ/ERimncr9XTOCVbEa2ERBCdXllHItgEdzGg?=
 =?us-ascii?Q?YgvUI/+3GBV2sez3+mXw+XN8VkTvS42NZKuXJwt19VSm8wKf9DdRJg8rx19m?=
 =?us-ascii?Q?k9EsS7Mjax77u1KynCynL1MioCA3RFZlun9p00IXgy9K559XgOcti1y4w7CK?=
 =?us-ascii?Q?otwrE4T0Jhk4qpSCNX3RRqyr5yF5+62/jfEXw4G2F5WifwLSMru8oJB7i7nm?=
 =?us-ascii?Q?ktnB4z6PlnEj58fxwqgmIubVBy3Nyl6D+5z+SwoF+PqKMghcQ6de38UXGnGf?=
 =?us-ascii?Q?fATshThQN8pTa9YbkmrAWI7CfKzKT9i8ISxLATdeJB6+ea+vkgc6fLXAQYu4?=
 =?us-ascii?Q?QpwVlSBq3Bwj9JJLcW7OdKWJVKk8BI0h3DmI+/YxoSE4v4cPUyGyWxagYZ0u?=
 =?us-ascii?Q?Kyo+yeu+DgVtN+wfB+Y8Llji4jFtDVhD6qhRLt17DvGMTJnvcH0N8lnBmHiL?=
 =?us-ascii?Q?kT2vXUKfubOhAKHTu4gTuBFeWMFxkh/980XA1V5IaOgFmRzUr1a0HGwxIKqA?=
 =?us-ascii?Q?7uu+V4Rcvu7fEacaozOtZEqBOuQe3kdRIfu8wlmERiduaVpytBheJDMuX6of?=
 =?us-ascii?Q?+1nE5Hx9hyC2LFrf26KaSwEdT3ypnfgm6zCfFsFMVKQEiOWLi+r7X/+QTA/7?=
 =?us-ascii?Q?5IROLVjmojiInU0v4dhncXyZrfegBK3I9AIV1+Z9ozPvvfmxxQ4TLuamaEgs?=
 =?us-ascii?Q?rsFXXT8j2QjapTdDsr6QXYzk0g4+9FiR/c9XXkHm76h22+aTubI2jdZ5UGNa?=
 =?us-ascii?Q?41vrRLTeiyMXgyyDxtalf6OMvwwXFilKYKy+GTLT/AFzdgNdzL6QoTFMAJ3h?=
 =?us-ascii?Q?9mJHi49/9OkdLbU6YX0F9GTrF3RWmxdAlbyqnVwyKRLYsIDKJEvjDVGq7KMt?=
 =?us-ascii?Q?0G5sWKlxgQkwwW6krEhohcHfQv2+at0ZOj9U9N0rAIt5SmS/LDPDTGqSsDyZ?=
 =?us-ascii?Q?ssiuyTv7kw=3D=3D?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 36b5ddb7-428c-41b6-7b38-08de6fc61f81
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2026 14:49:45.6660
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WpewnIT5KhNR/8KB3QBQGBcIrRUkAvhUsN2A3umLxELDP3T8K2YcrVtAGQf2gCkUbKRj3E0mcr5sjtp/oRLlWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO4P265MB6983

On 2026-02-11 03:29, alistair23@gmail.com wrote:
> From: Alistair Francis <alistair.francis@wdc.com>
> 
> Implement From<FromBytesWithNulError> for the Kernel Error type
> 
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  rust/kernel/error.rs | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/rust/kernel/error.rs b/rust/kernel/error.rs
> index 258b12afdcba..569d9d032ab3 100644
> --- a/rust/kernel/error.rs
> +++ b/rust/kernel/error.rs
> @@ -12,6 +12,7 @@
>      str::CStr,
>  };
> 
> +use core::ffi::FromBytesWithNulError;
>  use core::num::NonZeroI32;
>  use core::num::TryFromIntError;
>  use core::str::Utf8Error;
> @@ -251,6 +252,12 @@ fn from(e: core::convert::Infallible) -> Error {
>      }
>  }
> 
> +impl From<FromBytesWithNulError> for Error {
> +    fn from(_: FromBytesWithNulError) -> Error {
> +        code::EINVAL
> +    }
> +}

Are we sure that `FromBytesWithNulError` maps cleanly to the `EINVAL` 
error code?

Anyhow, please add `#[inline]` for such simple functions.

Best,
Gary

> +
>  /// A [`Result`] with an [`Error`] error type.
>  ///
>  /// To be used as the return type for functions that may fail.
