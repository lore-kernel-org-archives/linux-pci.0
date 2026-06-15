Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012071.outbound.protection.outlook.com [40.107.200.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D883B2FCD;
	Mon, 15 Jun 2026 08:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781510959; cv=fail; b=skRN2vacjEc7mC/Wgbun4WcGCCjL4DYdhADmPD3z64/Wgf4bkHpXhvnFvcKqMzMFpFjt9WwMHqGsb7c4xmDyM+WmKLo6aumHMlRK7jYf+s6FDhfXq9iYqFDrJaDkZrTnxXQ6LPPIypcdU0AySiZhxNlewLsWm0Npi6RRwgyIbTE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781510959; c=relaxed/simple;
	bh=ICdNch8VN0g0vgoHGzvxMv+oA/shz/YZ99RbTuJny/Q=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=DJs+0GpGCwbGSmSUO0aredxlOtMWS/Q7ryqDJs6GaW1LwzCrsJpax+zB4EM9VYk5MAeUjZW1vlbJs3nbzQDqHEEV7ClZ5hLg8jxo189b7NS+ppySbO2sNmdVbukgjH6/Jd7zLCwtLcg8JFVE8C4RP6y9msHrjLs3zPfkwIPbnOQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fGOHfgsH; arc=fail smtp.client-ip=40.107.200.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fGOHfgsH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CZQfxO/MgrYC500yBwyuoJAtaQ3NnJ/t/lgkLo/UXth+A6/QxlFy8DZyteesWXFiIdBipWdMy1smAB/Fi/ur1P63VVYHAg5Y6sxJFFJb9MssIqbOvvFrORirNDsL1dvFtge2DlQMknsYUzzVWMWb5bNAh9qq1o1rU8KWBV98U9B7PYui9rSGNz9eOvwLYHSAdyCQjhbkg/6N7T0Z98f9LeNtxcH10m2nPcdfMQaH9/LBGQ3AaRwBq3TL+HDcDRKdNd+X9LabhqciSJ7mCh+rTwE9ao/gVZE59q4EQLQu0tY3WviG47/SV2KmAlASSz+8bYIKi0hCk2IaobfkTzN7CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ICdNch8VN0g0vgoHGzvxMv+oA/shz/YZ99RbTuJny/Q=;
 b=LALCncEO0kQxDFGJLi005o6NNzQNdI3cTjGNY3ojgjTU6qc0PL9QoHymIQbwU3hg3/jvY+6t/I0PXIafiEqqj5qsf8t/mbEMTbqWauuk6AXAOvBSK1YqQQ2s9x5V3Pn7XIPevelaqYVfMd6J5W2ZLn6nAcXgx/dG0VUoKsxFipdOxMnvgT8eAOB7UIxfUe+zgkH14PbUDkkHTAPL95ZpzrHvs19WdSrccqMWg0aCIXi5YL1J16AegSF9z2rCSgxjktEFBmOdWe3BhsUuZSkPkAbMCVJtC8QQmkTY330CcVloHhCbvvm/2cxliS8nqnxMOHPInaxmB7cLwc16niCq4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ICdNch8VN0g0vgoHGzvxMv+oA/shz/YZ99RbTuJny/Q=;
 b=fGOHfgsHsiHzsJ3r5FpHK6JvQ357LhT6a/O8bh//meBAKlj8vcJw4f3y+CCGH1+1atT+F5YTYcayeibz9CFmqqmVBUOEFh5IAZlaXBAOGyIpw8e2CZGKCP49YmWVgHH0mqbhAa0K1GVitBkTRNJV8moMqubsnWgqqE7EulBKekQjgdztEIPcsqqzlHthnDfSB7Igcu+B1MeuC20b2Wj8/677NqC0tsDvushjMZGDV+ThlP48RcRQrMM+g+w9EsSkglRLB6ovjx6oGJrrrTyHyZDHpoB3q9VS5Gx8j3VtpZ3PgjZ41M8ldHaUBrAMvpg/fi4kLVQL3+ijLOQOh+Vl1g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by CYYPR12MB8703.namprd12.prod.outlook.com (2603:10b6:930:c4::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 08:09:14 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0113.015; Mon, 15 Jun 2026
 08:09:14 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 15 Jun 2026 17:09:10 +0900
Message-Id: <DJ9GXCFN7W8Y.ZXGHXUQKPPTF@nvidia.com>
Cc: "Alice Ryhl" <aliceryhl@google.com>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, "Bjorn Helgaas" <bhelgaas@google.com>,
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, "Abdiel
 Janulgue" <abdiel.janulgue@gmail.com>, "Robin Murphy"
 <robin.murphy@arm.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Danilo Krummrich" <dakr@kernel.org>,
 <driver-core@lists.linux.dev>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH v4 06/20] rust: io: rename `Mmio` to `MmioOwned`
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Gary Guo" <gary@garyguo.net>
References: <20260611-io_projection-v4-0-1f7224b02dcb@garyguo.net>
 <20260611-io_projection-v4-6-1f7224b02dcb@garyguo.net>
In-Reply-To: <20260611-io_projection-v4-6-1f7224b02dcb@garyguo.net>
X-ClientProxiedBy: TY4P301CA0059.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:36a::12) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|CYYPR12MB8703:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e970a32-26f3-4435-8f45-08decab56341
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|10070799003|23010399003|376014|7416014|18002099003|22082099003|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info:
	vqoCUWY5DEPbSBxFYtDQe5h9nX8/XPUoFkYb4KGYSi8GiOvT7x8RYK27v6JUl2DzC7C7wRtxO9chk89/POz6MQSHri4xN1jXT2BKVqCf95OIPBHiKlg3Qx1q0c6mORfaWkGvh1loAFiY8ZWH3rnbKt5oO6rDV75itrLm05TjbcHfZd7rVbcMHzHs4fuat0u0SbtvZP9C3x1GYZsV1I4Tu9ECXKG0DqSajqW5jBEMBo6ay83hft+3j2KU+41nHvSoAyVsaxbwO93S6p3J9h1nvZi9UmJNhGzsZZzwQ8X8lht0/NnUEqbuDG5B67n2FTRzBKOJrA5s7rPUOEMnIqrHZ7fNocaUI01mGpnaGhU82aeXR2uHQci8wxlaos1ring0O5VZkZPFfqRKcFDOJ3ezHY6Ckv7pl5PlkCKcEwoL8A1y/3Cm+z2csuoeNhPsc48nwnncIeWRLaE7aimwf8ABUt8tZlGH2b6qP2A8fEiyXQC4pTSPDyriiRuwhJPyQzTvBJsPMpHlQNmdVzdm8ZyczL2WmL7UauOguA6o+tAle1mF3+M3/VyoZbGNMG6id8Og+C+FohW8iNe5ofIE0tp8SQhVcMYaq53zumZJ4pIQ2tW/uLdtQyHrT3bPfHXJ6P1BDP/HDmAkXP/uXjUKaSsk+na3Tr4rmaKSsgf9XMLQ0IUo41Rh0u/4vJQNrd6IF8GK
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(10070799003)(23010399003)(376014)(7416014)(18002099003)(22082099003)(56012099006)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MTlxZDB2N2QzNlBDUWd3UDZRMjFGKzBBRkVIaG9vUHBlVjlGUDB6aGRlR1FO?=
 =?utf-8?B?TEQya0ZGVzR4RzVDN1MyV2Nuc056MGJZNmNWVk9jcEJmRXdBMlpkUzlaMmRh?=
 =?utf-8?B?VjNFTlpqY056YklsSW1NQlVKc1RIUE1ORnlzejlqWk84blhISDhVOWZNK3ZH?=
 =?utf-8?B?dlNyci9FNFRvTDJoTE9Sei9BeHlMdTB5UDFNenFxdEltdGRwYjhMUFp4YVBk?=
 =?utf-8?B?RXBIR3BWaUVjRVplQmM5NmhMNzRTdmdoL0hRSGxnbXBFVkJyRHNnaXNKZUx2?=
 =?utf-8?B?QVZDaTZUQWxDcTN6dlRabU53Y0VsaHdiVzJFemNWUHpIRGVXZ2lUYkZNc0xy?=
 =?utf-8?B?SUo4NnhodElUY0ZwajRVWmJMME9hN2ttV1ovdVNIMDNJN2hTeFl3YmVpLzkx?=
 =?utf-8?B?ZDVZRGh1VVhOWkswZDVIbUNiUmVabDkzYWU3RXBlVXZwakdEQWNyUVo1ZWp2?=
 =?utf-8?B?akllZTBNTVpUNXFmcDlabVdhSGZma1RwUkk1QkJzWGNYbWNPNXFPT3EzVCsr?=
 =?utf-8?B?SG1RQjc4N05UNjhsTUJRTFB0ZGpYVWUrcCtRSWFQUHRIR2c4S1hhZHNkRFhp?=
 =?utf-8?B?ZnRsOUpsaVBjc3hjekZMSkJkVTlCbGNBWk9NVmFUMzlkd3FidlNlNmZTbU9J?=
 =?utf-8?B?MW5iMWd3NW1iVzhUdDUwdUsxTXVaS0Z0SHdGdzJqanV6RnVpbU96MEUzclFi?=
 =?utf-8?B?Sy9FUmx2anc4WFpCaHZGNXpSRHBkMzl4VVJVK0dFVWpWc0V6Q3p6YStLbTV5?=
 =?utf-8?B?a1dHckQ4eG5BZDlaTHVaWm03SG5sQktENEY0VGJ0V2MyK1JRMWRsS3Vzd2FC?=
 =?utf-8?B?dVoyYmRHUXpld2xuQ0FrTkpKYk82TGNDZmIwSXhPWWV5bHI2cjJjSFNaOVJG?=
 =?utf-8?B?SW0wYllPVFhBaDlkQWhWWThieExPSSt4T2MvR2xiNmcvYVBxdTlSSXhrSElC?=
 =?utf-8?B?MHFFZlNxRjkwUHRtU0ZUMitteksxam11V2RzMys0Sm5kem5Hd0FibWVIY2hh?=
 =?utf-8?B?MGM1YVFWcTNUQkR2eGtWS29ISCswT2MySXh6U29SREZxRzM0cUZleWRxeUUz?=
 =?utf-8?B?TUNTdTEyWGRKb2FNbFlmSjAvcGwzWmUwdFVoOWUrbTBxa01RWk12U3pqMG1M?=
 =?utf-8?B?SjhpZVp1aUVDeGdVU0w1eDFXUnFSTXMwemRyZ2ovblRCdE5NaWQxQit2SzJQ?=
 =?utf-8?B?VHBxckgvbUlMU1praDNzdlZHQUxKeVpDS1I4aEhkKzFGcS9uWU5mYzFxNE1x?=
 =?utf-8?B?NEg5MUducXRPNHRHT29OR1BzVEcrMXgvR1p1VnBxdHR4VE5RZEFNRXpYR21a?=
 =?utf-8?B?TkZybDAvLytiTWh6OWdLRDJ4NVF0Y2s4YWk4SWJQTndRNTJjdDhVbWptdlpP?=
 =?utf-8?B?dmZsY3hWSlBySlJLMzVaYllNQlRyNkMrZHBSaWlodDRqSktkbjJEam9yT2dU?=
 =?utf-8?B?SFFLR2hlZFdEK2RWTzliYm56QzR6cWpSdngwaDBoZzNXV1dveGlCV2pRZUxz?=
 =?utf-8?B?YnJ2OWQ4SXIzR2Zlbk5EK2ZxM0ZYQU9aZmwzaEVrS2NEMjllV0t4SnlpRGJ0?=
 =?utf-8?B?cmszQzdkc05vVU40c0kzWDB1dkhFNTVncFVYQlVBcjZDaHZmWTQzMmdWMm41?=
 =?utf-8?B?TnZTYWFnQmd4d2dkWUw1LzgyZXRaUGttZlBLZkhNV2dHL0YvNythcTBuS1Nt?=
 =?utf-8?B?ak8xZFVJSzIzcE9mdkRLZk5Ma015dXh6SGI0M0tROHNPWW1mTXlvVUwvZlJL?=
 =?utf-8?B?NzNvSlJaSFZLaDhOaTN4MUlNRVo3MmkrbGlSdjFCd1MxU2YrN3BXSXBVZjZP?=
 =?utf-8?B?ZGxxY3N0QjFHb0x4NjkxY24yRjFkamJTWjJCR0UraXd4SnY1Qkw5aGtQRGxH?=
 =?utf-8?B?bXU1QnUrS1UyUnRXZUczUjVGUWdEa0d5RlEzWUl0TzZzYmppQUlHRWFHRnlO?=
 =?utf-8?B?ZEIxM0lQT0psVTB6VHJkZWVDaHJLdTJnSmc0L0FRaDQyRENiMWwwTzZadWJJ?=
 =?utf-8?B?eUdaMDV3YlZtNW16UGp3b2VVVlpMdkdpVTc3U3RuZ0NxWjZCYytlWGt4bFZa?=
 =?utf-8?B?aThWZ2V1WGJNbE90NktnSG9tQi9mRzgzaUlZcFM4L1pOY1NuT1dza1dGUUtU?=
 =?utf-8?B?T1A3aWU3ajZmSFNTcUJnMDhFcHIySndZZXFOeUxTZzhlZk9CR0trRzRZRDRQ?=
 =?utf-8?B?bEUwQ1J0ZTZlNkszMCsrai9KaE51a0syWjZsMHRGQkQ4b05SQnV3aFkrM2xk?=
 =?utf-8?B?SVJUOExLL3pPcy9pTUZsU1BrQnJZbVhQYmREbGg1cFJFdFE3OEtNN1BReUtY?=
 =?utf-8?B?ZG5LdThhVUxDQXV0TVBqOG1IK3BFbDNnWDE0QjhMSWYxUTQ5RUIzYmYyYzBD?=
 =?utf-8?Q?1PugRX5avHTzc3lnbXeBvAuq173AQYAVK7TcdKIHS/BsX?=
X-MS-Exchange-AntiSpam-MessageData-1: hiLeFc+oIk55HQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e970a32-26f3-4435-8f45-08decab56341
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 08:09:14.0529
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LjkXO8WIskBYS9FXPx/ELPhLO46xBW3ke3OBtH0bWoUxAK44VAhQOtCpU+wwq2XrEO8ZqFmOwYeX2eqU7yae1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8703

On Fri Jun 12, 2026 at 1:28 AM JST, Gary Guo wrote:
> Most users would more commonly reach out to a view of `Mmio` rather than =
an
> owned instance of `Mmio`. Only implementor of `Io` like `Bar` or `IoMem`
> would need the owned version. Thus, rename `Mmio` to `MmioOwned` so that
> the name `Mmio` can be used for the view type instead.
>
> Signed-off-by: Gary Guo <gary@garyguo.net>

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
