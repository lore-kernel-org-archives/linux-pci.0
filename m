Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013061.outbound.protection.outlook.com [40.107.201.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C2FE33F8D4;
	Thu, 19 Feb 2026 14:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771511495; cv=fail; b=Y4JXia+gehADTneOdXZEDXLqhe+krNRXWemh9vGK3orCfxz0wN1DBVcYx52oqal4d+oWcklJvyuNW5iU6fmSrtvkKFyMpyyMiNpW8k8pWAbfjApqZ5S/7rHkCLxJphNJpQ5WLYO/2/0kAK8WQlaVwaMChMbn+ah1TJqf27Ris6I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771511495; c=relaxed/simple;
	bh=+gXb7rFonSC5OYifzKsqfpjECH9vhl4jNWO4YGAkZY8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=I9WMvXGP79boy41PVkR7lwqva9pr0gc/yviN1Xk2y/wae5lpjlezL2kBoKZ8/ww50gDc9Jz2WA5WXvFqdWnyPMDWCsVeMZZUBrtM3j7PgYiwKo962KXoz0UaLyPB3JrMU77O1CvZjPcNGZ2F59q/rZd9408MlBjF70ZDULr9b3M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JcH+ZjOe; arc=fail smtp.client-ip=40.107.201.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JcH+ZjOe"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vUSFnNiXEbW5vsnxKh2siwHadh9V36IMbgyNnw68gUSXa9sNGxkvxSc+G3T8rDwAwXguNhzbgFFZxcIexhpgH2CLp/jwswUkk0o99trSh2MR3Z9A9UHXRmoUrWaUiuFE2kwOjNFJQTTQbNagly6U2AKEYlBbnMhlF9x0xEMncN4vGj4DipM9uIuUtZhk3/41pFlLvQW2+ikbfr1xi3hOkNrEdVrL4gbm1dtqy/rrHghfw+cbBcyyl2C3mn4IT1CRGP8jGsYCr9PE4BXPfEWDrHV8J0rNJzMaTx4kFzVdIec1QGRONcU5BzpLhSD16+iw1GVbLtulDkOI8O7qFsuFog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kn9CqlpqOYn9repU2w3b1oDbi/GEqg8VjJ6ISGLYH7A=;
 b=rE+u7SDICQIUF+besBRUW0PtBvLlHX1VZbzoYYJen0uXdK/jEksllRkbgdTqve00c1OueCqk+7kHMNvdjsep4ruDTrj6uF45OB7dyZ7s2jBq1djZpobARkdF3WnTxLlS/zu3jYYqK4oUZZYrz8qt69VcNvtMifBQY0bkqFtc1qS55wnxWMfItGlVl4GJKGiQ/mGtU+W72xumuTPraAccfWBa2oWfwZ1EaGEG1QM3YyJONqZPct+n1QAbE99yQ7Mwc8dooBJZuu9k58fDJ1858Ym8Ku1D/3wwE0vvIc3KLbpF/+812p5OK8hV8TVkdzi3keuHMAPwOZk+UwXDePwyMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kn9CqlpqOYn9repU2w3b1oDbi/GEqg8VjJ6ISGLYH7A=;
 b=JcH+ZjOe2ri0ykQMgygInX74gCFFwNLU99AuXvX82kXoovGfkrDWv1GQOm3scukjKVKTaRRK0o5jxJADaaDPjbXbjKRDXXfsKVk/LdIioZ2wcy7iwKIIyAjhiuJEhUmY+cdbD96gknOGU+DwcwgfH71/z6kNDtiMkoDf633BPf4WyOEJTJsa/hpHO9Gd2poMwONFBFszxi8b0ahQWWxThJlwGNPst/uVK6NPpaMj/WhfZ7srJ8c7j/fSMFG1/CwgBPzzg4bAlNjk3qoQlbTnqhXE9/3VEjlBQyzy3yMKQzXu+OFX77tTV5mjjGWCurjSm4qBpxcitidvUIWX4u93ZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by PH0PR12MB7863.namprd12.prod.outlook.com (2603:10b6:510:28b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.16; Thu, 19 Feb
 2026 14:31:30 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9632.015; Thu, 19 Feb 2026
 14:31:30 +0000
Date: Thu, 19 Feb 2026 10:31:29 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Lukas Wunner <lukas@wunner.de>
Cc: dan.j.williams@intel.com, Alistair Francis <alistair23@gmail.com>,
	bhelgaas@google.com, rust-for-linux@vger.kernel.org,
	akpm@linux-foundation.org, linux-pci@vger.kernel.org,
	Jonathan.Cameron@huawei.com, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org, alex.gaynor@gmail.com,
	benno.lossin@proton.me, boqun.feng@gmail.com, a.hindborg@kernel.org,
	gary@garyguo.net, bjorn3_gh@protonmail.com, tmgross@umich.edu,
	ojeda@kernel.org, wilfred.mallawa@wdc.com, aliceryhl@google.com,
	Alistair Francis <alistair.francis@wdc.com>,
	aneesh.kumar@kernel.org, yilun.xu@linux.intel.com, aik@amd.com
Subject: Re: [RFC v3 00/27] lib: Rust implementation of SPDM
Message-ID: <20260219143129.GF723117@nvidia.com>
References: <20260219124313.GE723117@nvidia.com>
 <20260219124119.GD723117@nvidia.com>
 <aZcbBt7OmNeH3oA0@wunner.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aZcbBt7OmNeH3oA0@wunner.de>
X-ClientProxiedBy: BL0PR02CA0130.namprd02.prod.outlook.com
 (2603:10b6:208:35::35) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|PH0PR12MB7863:EE_
X-MS-Office365-Filtering-Correlation-Id: 65c36efb-1848-4af3-1694-08de6fc39252
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mlsggWa595hoMWRW0X/Cc2mjzS8b1f3Ve4pTatVGsTyMlUKzqc7zrTlI0RdI?=
 =?us-ascii?Q?Ltm7bLtHRYYeYGNWH9+6efx5ksqKy0sMRsNSKuS6dyLzzEN8Ha9kImMNw036?=
 =?us-ascii?Q?93OmEF1x5B/LazjPaPWYm+7z9cSXmYmXmpwlvgMT8J/YEpAAsoDMy2ljussL?=
 =?us-ascii?Q?SFW2q2NYeBCvFyT4WcLWJHRUR2pNDwenlk+LAf0OzdekXik8tT4pEzOvF24v?=
 =?us-ascii?Q?ZlphBebyRTaiJ6Rtx5cOmF25LALImZiBQpRAYb5Oz0XJPLqG9WBMQPLdOtp8?=
 =?us-ascii?Q?2YOMPFRxB4viWrx03b+9jK8esU3SmxdX48B8AHPmhpsxHtNvfGoRR3CO92BU?=
 =?us-ascii?Q?s5LpxU5l9fX6M5ACn6HGrdKXl8vwUg18CNehRGVUnsdYQAooFpZgySvZdqt8?=
 =?us-ascii?Q?GsddPiCDWuJQbE57HvMwu3iyPaIluZwO09h3w0tMzbAUlM/ywX48oXLS7YwT?=
 =?us-ascii?Q?S153wSUHx+RbFzfuPOUZO/v8CfufZH+M9GufdR1cohNx6l8L19kLl9rs3GmJ?=
 =?us-ascii?Q?V19H3aT93jXYHHsj4kI8ovOoVzbAV6y6SJ2sg9KMUJK/yuk5o4NLJC0XXOGd?=
 =?us-ascii?Q?tqu9qiN2Qzro55MBgnC6UPJAA4SM/9kc+AJo2lpAgJZhYikQZ7+9Olv5I6Lp?=
 =?us-ascii?Q?YTf2/T4oQAsA0vgE3XP7So3IJ3IdobXuaGOYskff5wqFdT1n+Dn1FXX4ZSlr?=
 =?us-ascii?Q?YaYrrxxXUp4B5U2izMJiub+7qJFcfqKeBZ/1R5+MSAG2LQonh2Z1HOsEqPS8?=
 =?us-ascii?Q?fX/7Stj2WDbThNGgHDjYTT54Ae/ww5FuNcarLUpXKPqvAh1bYs0NFCdQTq6+?=
 =?us-ascii?Q?VqnRjYHRePCDHShbNXXwGb1NbiF81/xMpj821GT1bPxHSRmz2rDxpvL6uFMy?=
 =?us-ascii?Q?HnLAw7ybUT6pyv3EtRokAIMgVu38ihZPcvB6UNKBTYt/EcatR7wDjWkq0xXG?=
 =?us-ascii?Q?RNSnpQztkLXnsTogAiBX4ISi6cxAGNV6/LdoWb4REM2uXwPX/BcUdDo1kCVo?=
 =?us-ascii?Q?7yDFVqkmj8zUrAucNP1lolsr0AqRYRSMQs3Q4tvdMyATONa32kSH3xrWpUBu?=
 =?us-ascii?Q?535syVme+2pnSXIVpjpbhX0e7sy/gK6yFOTNUs/OGzDEYlE7JT5Nj7rJ1xF2?=
 =?us-ascii?Q?quJbjkOUjhT8gD1pLlCMjJMwmharpFqWK79am5ktN6wnMpAz6Gz9Dw4gzHuZ?=
 =?us-ascii?Q?ERj0NSiIbAazaIIV+llmxQVVrw6aau0QFlEwDn85F0UspTIjWDmT9qeUpLur?=
 =?us-ascii?Q?96ZtFXTwKlbl3zID0AEeCBm/gWix6VABrBBZSAvsrAYLBYnN5eT+PXIMQxC4?=
 =?us-ascii?Q?Mz2j2M2UIuhR/7XAXO1yr3u2t6ttgAEHCYCGRpH3RuTzKpy9RfCl7CuK1NVe?=
 =?us-ascii?Q?KjPkPq90UXqMSXuGTFvSQT/p3kbZVf0Blna3b6rkwQL8VCGPpS5aIw+oyS1V?=
 =?us-ascii?Q?eo09otaqHGDY/BaChIkIwWUH2+ZpZz7a8WNDUUGrPb4HbaGUp7yW9soVkFLL?=
 =?us-ascii?Q?a2oU6XGOLR8RAJZkyBhm/KA1x7pLJdTHXb1A9/2gZrKn0BTahDxNib1Qb9oU?=
 =?us-ascii?Q?r6hgMtdlJb2z+5wt/Gc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YHTR1eW+3IEUq5zW+dsOapO7GX6yELFZnuFRtMKzbDUKwktV8+v4Fl4JZv0a?=
 =?us-ascii?Q?R7JxV+iE2GDnw6jc7fVSaMgjm0Vn1bKNwjM4kkPURrQAIU1k95MEFghIbmLF?=
 =?us-ascii?Q?akHRESnPNOR5ZZnVBEoJgCwlGKzL2f30GhoSVXc2Fbz6qSZyPevtriBSect6?=
 =?us-ascii?Q?x0mUe0NXIXjdJ0PFnsTHKvLbrc9STzTda3g7v5nwz1u+hfM2mA6lhl6oCcbh?=
 =?us-ascii?Q?hV3Qw5XJJv9tcBLdUil18OPcXlCb5Wa2Au7zkx5YJfCVuCHy2ouJ3VLmT+Ym?=
 =?us-ascii?Q?eGA2PziKVEnrDfAK5/qcCv0TgmBBYMLur/ObsS+XNnsUqljXA/nhdXrYQDUt?=
 =?us-ascii?Q?YXMOfl6jqTrAGVbNVsQ7NC77/kkDjmQ1TKyC5y9TzfpH3oLW/+au2CLd6q0I?=
 =?us-ascii?Q?Hxg13pldCAYgm8ghmlfMKz9IZxqrccz2+bZKcV+vvqvadEUK3CCJTia71yF1?=
 =?us-ascii?Q?Un5U03J+4lkeDiYVxDfvMrOJxfjozXWwakVdOH1bBa/kMcxJlw2QmBetdaHE?=
 =?us-ascii?Q?J6VlKxVtLB7NtGaANm5Q4hveYuUIuKUwEkCVUPf5XIg7JJffYDhc9oewVRjz?=
 =?us-ascii?Q?x8l2LRr8GhwmZTVJTO1Wu0CRfRcJlXClbhKltU5Ds+yMyn7AW6nXQhbCnCpy?=
 =?us-ascii?Q?1PDTOwpN8SG+RXHsbJ9voct+MVtbP9cMUTlebBJ7RprE+pJC5045nx2IrSth?=
 =?us-ascii?Q?v2eI0O11SyPR23eXkTPfWeFvX4lf0Fd7ubMmmYZpLD4zCCIAQVWBIOXKTbWN?=
 =?us-ascii?Q?uhHX8UvtC92Y9K5xRFZIXBAifP1o9IJQ1mE5lOb1mNQVz7gIZnZjQZfCto9S?=
 =?us-ascii?Q?6fPsCBvcdx5ZGwVxLYxF+pS1JPzUUR60aG7ad5Gy/cPQXSJtXQMPzR8iDKaP?=
 =?us-ascii?Q?ZEebSsEaB/Ay516Ay0MxwBjmm7NCQ1gd/Y5bzcRkyynbAnyiMPAg6quqRkmP?=
 =?us-ascii?Q?kdbfYZX8e89pPyl4BWle4l53/wBKk1bfLr/aBedU/VPlGZMPM6nSZyMADnfW?=
 =?us-ascii?Q?JovwHVCRnk/s+/7hZmrRC2eKiK6BBsjPQxOyqUciZVEB0lGJ7WzKpotgum0n?=
 =?us-ascii?Q?DKfmuOee5GndhY8NaTYzOPAcfPAARdJT0FVdsyhIa8qjhJRT9awDJ98N29jZ?=
 =?us-ascii?Q?3uH4H2Ugv16NceHL9xiiy95oWoMPnhTEpwShufxtDGjjD0TLdZVt4RscLek+?=
 =?us-ascii?Q?IrkXOxgQjtYasgO+9aPMcR5j4dTiPlINF28EgpzQ1w5Oli3wdnc1d9tQm4vr?=
 =?us-ascii?Q?hwv1r20c1o5ih6HM2PDlxp5mKhrKL6V6YQHNPY8kyV8Q2WWImKcHs8S+h4hA?=
 =?us-ascii?Q?eSQ4VwoNjxNtLXPVpF6JX2ZqYpeERtexRMsg4BLhAaGUHjdzpHpn/XXehhIM?=
 =?us-ascii?Q?bn3oR1clkg3rOeZtdJwF/5wq12zJgAqOe79/fsaXfvoi7KDDZzv/lR4Taj8X?=
 =?us-ascii?Q?UOi0pkFySL+d9l1th2aWYao50mYbPpaC3yECCx/uke7FmT31a0dQMoJnPJdk?=
 =?us-ascii?Q?ZqmiSnNJiRttxaXs2lJbXTZbpAnZkQ7ZIQaIZykONRT6RGY88ty9lIUJ5ADa?=
 =?us-ascii?Q?EHdYG/0zDf8lynsL5K9EXIeuSufsID9xYoD/SEa1fz9UsOdze891P8SPfjUx?=
 =?us-ascii?Q?5WzDFZNH0eIoIzXwYAi8H3B21Rz2vL2lETfCPt4+slYPsrJZUBILV0l9Cqfc?=
 =?us-ascii?Q?AyYV6oU1h0plsFfwyAZuLJsGDU7iC07vEWkNJk609k9wlHYp21wj2MYESJm8?=
 =?us-ascii?Q?iwKxXzSMSQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65c36efb-1848-4af3-1694-08de6fc39252
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2026 14:31:29.9661
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3B3X44LUZbsVQfBjAoc6/Oyajnws0LNVwHa3zcZL0AdynN1iuWZLySt+h89pNYiD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7863

On Thu, Feb 19, 2026 at 03:15:34PM +0100, Lukas Wunner wrote:
> On Thu, Feb 19, 2026 at 08:41:19AM -0400, Jason Gunthorpe wrote:
> > Kernel auto acceptance is not desirable for the same reasons it is not
> > desirable in a TVM.
> > 
> > If we do some automatic re-accept for RAS/resume it should be strongly
> > tied to some target pre-set by the userspace acceptance process - ie
> > "the device must present exactly this specific cert chain and nothing
> > else", and probably more too since we may want to exclude swapping out
> > device FW versions or similar.
> 
> The way this works in my series (and I presume Alistair's) is that
> trusted root certificates for devices need to be added to the .cma
> keyring.
> 
> This can be done from user space using keyctl(1) or some other utility
> that can talk to the kernel's existing keyctl ABI.

I really don't like this from a verification perspective. We don't
want the kernel checking signatures, that is the verifier's job.

And a general keyring based proeprty is not at all the same as 'this
device must present exactly the same certification and attesation
after resume'

> authentication.  These are existing, well-established roots of trust
> in the kernel that CMA simply inherits.  I think it is reasonable
> to base auto-acceptance on these existing mechanisms.  No need to
> reinvent the wheel.

It depends what you are building. We've been focused on external
verification so this is not at all desirable.

Something else, maybe some kind of internal verification for embedded
is a quite different story. The two cases still need to compose
sensibly within the kernel though.

> > Having to find/remember some baroque openssl command line with a
> > million options is not reasonable for a production kind of
> > environment.
> 
> Personally I find something like the following neither baroque nor
> unreasonable:
> 
>   # What's the certificate chain in slot0?
>   openssl storeutl -text /sys/bus/pci/devices/0000:03:00.0/certificates/slot0
> 
>   # Fingerprint of root cert in slot0, does it match what vendor claims?
>   openssl x509 -fingerprint -in /sys/bus/pci/devices/0000:03:00.0/certificates/slot0
> 
>   # Looks good, let's trust it:
>   keyctl padd asymmetric "" %:.cma < /sys/bus/pci/devices/0000:03:00.0/certificates/slot0

That's exactly the baroque I'm talking about, no server admin is going
to want to grapple with that..

> Device authentication is currently trickling down from server to
> client to embedded/edge devices and you don't want to require users
> to install a tool suite on space-constrained embedded devices where
> busybox + openssl is otherwise enough, doubly so with skyrocketing
> eMMC prices.

Maybe, but is this a real thing where someone would run busybox and
want some minimal self-verification?

Jason
