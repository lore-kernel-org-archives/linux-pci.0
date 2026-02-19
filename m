Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021123.outbound.protection.outlook.com [52.101.100.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A5C271A7C;
	Thu, 19 Feb 2026 14:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.100.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771512635; cv=fail; b=qEm6rMS//BILq267InmrCyQOtz483nThsiKbwjQstRM3aEqtvLrSPhdA3nQdtE4jTI5LodlZ1+uPUG/UxiADik6Y5dreA8SE9VLJ45svg6GcM4URM8HewzNsIzwC2LTlr+pm0es4mU37vbSzTvTM2Er8x+cvMuFDkR1BZlnxP3Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771512635; c=relaxed/simple;
	bh=PGBRKQt/f5Q1sRCQPaaysIFj5pnx6Tra3sCP7QrkgJs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Message-ID:
	 Content-Type:MIME-Version; b=M12kYzBDU/Lja26aHMHBOTrDROjRS6UzBWlJOyyzpu+5S/h88E5xUsP0ix81UtpHBnRS45nMW9tvPE1JOVO0zRGrZAPbqHznUJP4IM7VaF9US3b+iGhowNM1jsI75g5axBYtcvmrqC7C3WxR5BDPsOYr7WP4JAm774TTRwBEbDY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=aytld6SC; arc=fail smtp.client-ip=52.101.100.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="aytld6SC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xFvD3ID8EiW/5qR7imUIsoW3X+OBzRVMXl3T8ttSuFKc2RSJY2G6kb4dz7fitFPIwLDNep3g2g9OSsOdMvHnbJpit3T57kqd+PoP6dx4rsYImAoEqS2xgS1nVp/NHEmakTP5VnM0OGskETpMfPB28tbeUvBeHR0vQktN2UFd40RDJfsgUNq5/6ryfPNpHl3a2AHnat1r0ApTrWjUvq+zpsiEE5Wac9aG1cY35FR4YSqGhzxlo6FEHFAGtm8NWwGz7BR7ruRIvWmq7qgWl6h7t/EJ2bmBZTXYe8Pl01XpX54utWwspEh1YU34LTnJJTf10BKLfONLRKpnA8xbdauhmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mJTMEVDPH5oAA2HwL3MOcfeezXNQyuGz50U2YYOij+o=;
 b=SxAzKrnxn2IaiVvTdGbJbRmil2q5/O72C+64QuO/+p4xP/rtgSnhrSYPmQaHylk9FyzKU8zxTJqR3MOmwPvmg7n8Wa5CrQC2xgCqJw7vhJ3lQStNyc+8mpnbyUNBTTOC9vPgXBb1iOVwjofk1qsmH4el7GxfsGnuoAmt25eg63/qCbLpvTvLNhkt6j5HPoa0+EzYFmd6od6prdUZ0/75FYYs0Xpo+Xa1BiGsPhHa8UGZh72N9fE0uKUFfWOs915e8D10ZQFKx7e4NQmKlNcYw3qA57s5uWf0/XJh29HT8LhbeAN8Lkj4IxGp3auFQR23/tw9IXHQdg9cqWVyybGKUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mJTMEVDPH5oAA2HwL3MOcfeezXNQyuGz50U2YYOij+o=;
 b=aytld6SCimJ+6x7rkaEMTSyXa/SK9Lx6Isp9liKLOHPf8GzhkrdY8KSnwebjIpJisor1GWN0n/KmgKNvRalJQQlpK5JpBVS6QVICE+FkIT1ZFJUbsyi9Z83CzkmhGVmZjcUcQnXI8ENVmH9r4rRgOy2Il4sPC3dNyJQhJHopyOQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by CWLP265MB5608.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1c2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.15; Thu, 19 Feb
 2026 14:50:30 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%5]) with mapi id 15.20.9632.010; Thu, 19 Feb 2026
 14:50:29 +0000
Date: Thu, 19 Feb 2026 14:50:28 +0000
From: Gary Guo <gary@garyguo.net>
To: alistair23@gmail.com
Cc: bhelgaas@google.com, lukas@wunner.de, rust-for-linux@vger.kernel.org,
 akpm@linux-foundation.org, linux-pci@vger.kernel.org,
 Jonathan.Cameron@huawei.com, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org, alex.gaynor@gmail.com, benno.lossin@proton.me,
 boqun.feng@gmail.com, a.hindborg@kernel.org, bjorn3_gh@protonmail.com,
 tmgross@umich.edu, ojeda@kernel.org, wilfred.mallawa@wdc.com,
 aliceryhl@google.com, Alistair Francis <alistair@alistair23.me>
Subject: Re: [RFC v3 23/27] rust: allow extracting the buffer from a CString
In-Reply-To: <20260211032935.2705841-24-alistair.francis@wdc.com>
References: <20260211032935.2705841-1-alistair.francis@wdc.com>
 <20260211032935.2705841-24-alistair.francis@wdc.com>
Message-ID: <3681dacecefcfc5102bcd7854b3f4c87@garyguo.net>
X-Sender: gary@garyguo.net
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0224.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:315::8) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|CWLP265MB5608:EE_
X-MS-Office365-Filtering-Correlation-Id: 4da1751c-ca33-470e-7be2-08de6fc6398b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|10070799003|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CThki+IiyAk91Vm+WfQ863MGwkBZIL+sHJ94+1rUEHrZZvtktD64B5stNOOM?=
 =?us-ascii?Q?xsIbevEX2Z1bUHRPlHIze3uyPllGKdxf77GX5suCBAt91wigMKJxCMFYBjIj?=
 =?us-ascii?Q?eg3aze1IgYNis/nhaWw6yTMggfW+M8DyqMqmNosZRsXcrnPf5XWd3+WVbeIk?=
 =?us-ascii?Q?GEV0DbX79/6IV3B7xeCNzEvFd5qmlik+Ac/C1bkllNcX5txaZ4NJVgG3LQtc?=
 =?us-ascii?Q?VJ5S4unX5fiLKQfK9U2J8eSZdK3jArP7AeYovn0E2xvL9PQ65FGFJvUW6Kes?=
 =?us-ascii?Q?I1A7KsS8cDMofnLMgCNUM8G5XmGjqrCfi1SmODZk0pIwh7IERS3g24Pp5XGZ?=
 =?us-ascii?Q?XCuFQ8MH0usUB6JcEJJQgst0zQCg2GoNDxyph1DZxvVx9Gjcbp3BUuzbFg7L?=
 =?us-ascii?Q?8QQ4OEjvSffNTv1Rb8xc1uxoRy4BDSPUlKoioPV2zwha9iCcsfS0w7Z9UwIB?=
 =?us-ascii?Q?7sAf+OxmWT9v56K3ClO9nSk9OJIgdDB18yTFYP1l3p+z/iYtsT5pUJ5uM7hm?=
 =?us-ascii?Q?mUrPlFHfojFOOgarlrSNAQMVPLpVwKefcQq8H96YCZUALa1VH+H6dGfF2QuR?=
 =?us-ascii?Q?VZoCqrE+1WDaiaxd6hY0q1NJDUGMV6eOoQgLTWVn0IDUCIElF2O8dJIgYggt?=
 =?us-ascii?Q?inCSxfRX4NT2ADMHrCP9dOop0t2wSVPR6KPO4KLgzF6yxdkgktXW/ZlfTI1f?=
 =?us-ascii?Q?agPoIIxFKQbc0RwurcFc17gUs5gsMsvcEPXWnxH44jCJEOH8VeZ9Gdx4yE2p?=
 =?us-ascii?Q?5rXh86KVRDNFdJ0Lr1ROu8oDumNjLWKiw7ElfbYXrYUEc/vWw+ltFOsaz5+j?=
 =?us-ascii?Q?0QOnztt6G4E8Z2i8KFw5u+SfP2fS1Rxe6w21Vu/v4yrGuACUG3Hg3BpDULFr?=
 =?us-ascii?Q?A+ZezxZMQeto//QdXknhTgaP4wHrOLBsz9NbN0Hgq6Bk1as4I09iVb1WL6GT?=
 =?us-ascii?Q?wIp+Rqpf25UaV/lp68NzTu13MRNdXe9eygHODmprBfCooKYcsoPnFaA/P1A4?=
 =?us-ascii?Q?lcHjovLn3Dy5TY7ylsgdRsk6zcqQFZtkDZhVGNcuqvTj0Ql8Elk0ZIPrsX75?=
 =?us-ascii?Q?qt+FA83Y5aFz62mAo8inAgDJvXir9KLtZ9FxlpZxdC3W6XCVNy86E1P1wRNU?=
 =?us-ascii?Q?ydOCPusZ6f+SwGonByta/wndue4vAg8lEcKV3xoGr6NdEvPjlZZJ3l3LkvYB?=
 =?us-ascii?Q?dvrK8tPt7mwdMSmUgJETAXUafZz12EQydo/SA+A3SsjOKfc7N0Onw7uRXLX6?=
 =?us-ascii?Q?HKFBERWBPz9zqdHF5rzOBb0vtZ2nX94WW+wI0AQIf1J+4IgQlzEFnSrOKIFe?=
 =?us-ascii?Q?pZmg+no0oeG1RcTJLyPUiGIVR+vcp7En2d/lhRuhC3Y7+4e//8P7ykl8MdEc?=
 =?us-ascii?Q?IAa4x3YhG9xc6vAClY+Xm3JbXB4a8bmzDDbE6KEzqPbZP2FGIQP3OxxJOxet?=
 =?us-ascii?Q?97oE0s/qxxlTz9BbVtLTkstNA01n/JMni0vJGjiMhyvsSywN2KxU4qm7mBDH?=
 =?us-ascii?Q?yaaJrjHb0gbGSMIUC4K6wQB9usqrwJ9WuEiG84F5rDcZcAiWrGj97z/Phw3y?=
 =?us-ascii?Q?pkOn9DslIdtnt9i7JcI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(10070799003)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?alFgX2iJX88Aoh9jW9otPhRsWEHcl8/xASswPYZv/ghA0BMznG8zSQYdVtRS?=
 =?us-ascii?Q?+55ehpwUoDgk/GgzwtS+ac4oa3iRwDIaFEkS+ZtKFnqKo4CqeavKx+z4SE/i?=
 =?us-ascii?Q?Hxf3pZGnyxNKZXigwNrwipLz5ItYvBL1xhTpZPULcaEgKYideKspD/d0VC1e?=
 =?us-ascii?Q?KisCPjOLqB5HztaZT+0RUm01OGIJJwzdPfanxpNibnQLInsJwaPw9llVuTd3?=
 =?us-ascii?Q?ZMBwwlRmC3lGO4tSmPQoPFievD8y1lTOvcMI32ysuGNp7jYeksGUWxdzl++O?=
 =?us-ascii?Q?/jQTi+K3Pyt9OULNpVKyK+NVJU0EZULBOA5J7NudzYvgyokvEqdOxPMOZIDJ?=
 =?us-ascii?Q?hJJxsJJ7CzltiryyYz55ZWVUDoWRmxRmi2hpgqdXvaP6giwOqpgvfSj137jj?=
 =?us-ascii?Q?USY7i9gYttnhpqaqfmP7MN7FfNVb6MyzIK05F3CaeuMJtuIKH7DjFUPnxR6V?=
 =?us-ascii?Q?iW1oGDMqSXoadnYS5u4o7VXsyi2uPRCf4dcvdc8sFtmUVxN5AFkZV0WghsLE?=
 =?us-ascii?Q?jIRtjMtZbq49MmY8U0xpxqyw4MqDCUHuhe5/S1id1lV92o5IdZP5tIpIOgYR?=
 =?us-ascii?Q?PxMxapij+br73MHWCV5IInLn/zZzukM/D7xVb9p7t6hAJXV1WhyZPlK0pMib?=
 =?us-ascii?Q?HT7eCKt1PQaUHb71xvKpYShaPt665tFhHjo6MKbOEjvWAexM53RxQQErTJKY?=
 =?us-ascii?Q?gh+fHNv0KU4rJi33X6zoMyYPWNjw7H2TSUhWfwRNbsGDnvIfCu+FHyGVXAzg?=
 =?us-ascii?Q?/H0WOwl1Sty+seHhQl4r0jm4900IeDNkLKAx9aO+Yt8ofmXj1oY5I4q7Sokd?=
 =?us-ascii?Q?ZWYctHqhSz+suZw4i00AOBbgX7bBqkW7cUQkeZdDtwNujwxqNcJVtJQ8HrIK?=
 =?us-ascii?Q?B5EJpfpALAiR0Vqdvv8inW9/KdlbDs40NUHHL8ellKcsNjJ06QL4chGvCx7p?=
 =?us-ascii?Q?rSYHqj7zidMZ9bnEoJaB7sjVmGC3M5/+d6tJ0jHzCKpPg6l+EV4mKbHwQ2OF?=
 =?us-ascii?Q?Zv6ZlRZinvDDlInq5cncVc2LKPBiXw4W0Tz2oxdFKZoXUKOKmH5aOytu8+KT?=
 =?us-ascii?Q?C87nHMh1tLOvPvCyROuCPxwyZayCaTNhUBw12FC/xusSI4FKNnVhj2eS3IR8?=
 =?us-ascii?Q?xmSYaaxqn1DcF0AIG3LtK/cmKTkBCQr/A9Im2z2UcfCV37HFZNj9hu2cVNRR?=
 =?us-ascii?Q?nSBCynKCqPlVLFP6I7IwDTE9T3J/NyES42NG8gu0ll/OxleOKwOeQgyrF5rA?=
 =?us-ascii?Q?0Rw7onXBUfPZyBYuWU0REu3Y8KsZAoO0NP/3GT9GkZZ5ZaSMDbm5YC2qYlr+?=
 =?us-ascii?Q?KRUJ9rAGy1dn/Jq0r+y3/6vpzY+BSBgzDy1lRwFmOjbDv8nTThUj+OXIh909?=
 =?us-ascii?Q?PcDKx3sItFx5v5yKEsa/GTxLgWiSwrBNaDGeJqlTE53fAwalkjxRHy/Hm7Gp?=
 =?us-ascii?Q?ReoQhaa+2hQ6VY4b82uhy4uhVwIPnmVfWYTClufRYgWaYMy6pjMrMGhglZuz?=
 =?us-ascii?Q?D2nZdbB+vj936QLu6YuBJE84vbUrUr9BJf5AWOHWMm9pGIGg1x/I5yJJrRYD?=
 =?us-ascii?Q?qWLCGVvLuke7+rWAbxDto6zgTy4ycHcpo+Mdd0WUPownYqAWya+wjuJ1o+Cm?=
 =?us-ascii?Q?4JBPo9RFTMXLtHirmmXA7QuBtpNRTeC+eeh76w38hzWwwf52lSkdMqR0hAZE?=
 =?us-ascii?Q?ei+nyReaGNfkDHxlv+Vsvk8K5jcsYU3rWYENNjwa7z8O+miqRd4PS1Veiay7?=
 =?us-ascii?Q?420kJTe4sQ=3D=3D?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 4da1751c-ca33-470e-7be2-08de6fc6398b
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2026 14:50:29.3705
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N9wCFnSXe+w1J6dCLyXEMHJkzhkpQJZT8zR9mVh4nO7k3d/OfdDZIvnwkbczemJynia9xEwyePt0jjTRs1WOzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB5608

On 2026-02-11 03:29, alistair23@gmail.com wrote:
> From: Alistair Francis <alistair@alistair23.me>
> 
> The kernel CString is a wrapper aroud a KVec. This patch allows
> retrieving the underlying buffer and consuming the CString. This allows
> users to create a CString from a string and then retrieve the 
> underlying
> buffer.
> 
> Signed-off-by: Alistair Francis <alistair@alistair23.me>
> ---
>  rust/kernel/str.rs | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
> index fa87779d2253..17426db83c9f 100644
> --- a/rust/kernel/str.rs
> +++ b/rust/kernel/str.rs
> @@ -844,6 +844,11 @@ pub fn try_from_fmt(args: fmt::Arguments<'_>) -> 
> Result<Self, Error> {
>          // exist in the buffer.
>          Ok(Self { buf })
>      }
> +
> +    /// Return the internal buffer while consuming the original 
> [`CString`]
> +    pub fn into_vec(self) -> KVec<u8> {
> +        self.buf
> +    }

`#[inline]` here, too.

Feel free to add my R-b after adding it.

Best,
Gary

>  }
> 
>  impl Deref for CString {
