Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010015.outbound.protection.outlook.com [52.101.85.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33AEB1F4CB3;
	Thu, 19 Feb 2026 00:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771462581; cv=fail; b=PR595SQgcM1MvrR4Gw8nhgoSb2XjEMODzYcqRIILCpMtX2jwa3nVeJPYbwFAWm3C1tna6CxzhvtMnyeLBX4j68yM31evsfW2QYx4qU+45LegeSA6GNWZKZ4MNJLnS/VUckI72hImensbFRFHlJVdDmOwOteQVZrw2Eksf3yFuC4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771462581; c=relaxed/simple;
	bh=O3AFWz/Nbw+qI3Ub8rsSyXhM7RWGbkv+IzSPPkUM5LM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hAg0LcPmr6N9+RM94bTtfhyKHrkFu1QQW1SJKHeL2ExfROhS9iv8sc1Vekfp6SrxRAN/1CqOYbMWyKj3+nFV87R8h7hiVQil5Vl24YWOhbheRbnGEgbRsi+GlLfVVNeGqNdUiMqxWwxlPOaPYr63RJJ1SpK12Q4Me7Dqprn6Nj0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jU7NTRyf; arc=fail smtp.client-ip=52.101.85.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jU7NTRyf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bNuWusY0cfNamanKq4O0RbuNdhMThWIAoN0GXS60aj886JEBcoa2/sqnW41P+RDTL6cEA6T9bGjYcbvJUUfAY/d3r/8F6a9Rp1r/vrJ5eaxdFr6aTKXN2g+5J3rkejhEA8H7Rux1oe//yqm8+9g/1VtyWECS9vPJqzIED1iwTPjDCoZmWldKxaCQppqnFaOA8sQLczbcqhyHfkbV/Z7V834PJKM9t4erHgBeLXfNtWmU3Qb1P74nMZpZ2a7bwChc/ck7QMaVNY+F4WSubKt/115kG3mOR8pCKMY/JRbX8cIL7Eb7Sf8eDYUKUYoltRgYF5dsS3tZjd6fOo0L1r1FIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O3AFWz/Nbw+qI3Ub8rsSyXhM7RWGbkv+IzSPPkUM5LM=;
 b=vMAFw6s5WvNJnFfExYtgY7FDlmvUAe+Fra5+EcmTQwQHodi9EEdDSZOlF83v6K589suJSTLEV9K3hqD6Da/fdWUOPOYT7JG2VsheKTsUFLP0ApgZzME1LK7kR/WH0lRor0/3RcdIU7oepe3Oa3kzLsmkLzqP/kuVnNMLRJMnv2r7hg9Rc0mB4eqOabN7Y66X2djCVgM5MUpP7wg+yIpH6gg/M4KQuSM3a0JSScT7+cfE1ji9w2zQjhMxRFEJA5EICTp5n2E0p5ZMaSNB+fFrInHEiTmQuIzEYBaPFF9IDB3j+7zkJvIsFU2ceZ2tN6Sfy1URqTHtQp7zuLijwzaYjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O3AFWz/Nbw+qI3Ub8rsSyXhM7RWGbkv+IzSPPkUM5LM=;
 b=jU7NTRyfftIdaZqEj2T47X1abzN0lkVfLlJiwrW7pO/8hbTiPYRPu3zsaturOqQ3C6CzXG4Dy6JKpnrhPqNWSFYP5uKPGFDWgpm9/7+zqcJ1xaRvzly2sUplgpuuTb8gCTFRXuNmhcn8+ercuxa4XWbINrY+TlwyhsD0VbnJrblcd1NE2tL1+qSdGf4WaJ2AdOLiOMNFu13TkMaRx7N7STJU58iFAjDw9RLcXPzAhT2jADFUZq9hDpJmOEyWywBgSo7LutnuhtNZJcsIPFpDauSJ6o7q1A9H1RjHVyh6qgFSr6jSI56isyvcA1DjeD6h9x8ZQ8g2O0N3T9yQDRTTFQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SJ5PPFFA661D690.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::9ab) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Thu, 19 Feb
 2026 00:56:15 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9632.010; Thu, 19 Feb 2026
 00:56:15 +0000
Date: Wed, 18 Feb 2026 20:56:14 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: dan.j.williams@intel.com
Cc: Alistair Francis <alistair23@gmail.com>, bhelgaas@google.com,
	lukas@wunner.de, rust-for-linux@vger.kernel.org,
	akpm@linux-foundation.org, linux-pci@vger.kernel.org,
	Jonathan.Cameron@huawei.com, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org, alex.gaynor@gmail.com,
	benno.lossin@proton.me, boqun.feng@gmail.com, a.hindborg@kernel.org,
	gary@garyguo.net, bjorn3_gh@protonmail.com, tmgross@umich.edu,
	ojeda@kernel.org, wilfred.mallawa@wdc.com, aliceryhl@google.com,
	Alistair Francis <alistair.francis@wdc.com>,
	aneesh.kumar@kernel.org, yilun.xu@linux.intel.com, aik@amd.com
Subject: Re: [RFC v3 00/27] lib: Rust implementation of SPDM
Message-ID: <20260219005614.GC723117@nvidia.com>
References: <20260211032935.2705841-1-alistair.francis@wdc.com>
 <20260217235604.GA1595019@nvidia.com>
 <CAKmqyKNeyEN-h9tAnfM9j0GWiFU9idXheGQ1COCqT9MVZgsZYw@mail.gmail.com>
 <69964ddaa5471_1cc5100c3@dwillia2-mobl4.notmuch>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69964ddaa5471_1cc5100c3@dwillia2-mobl4.notmuch>
X-ClientProxiedBy: MN2PR14CA0001.namprd14.prod.outlook.com
 (2603:10b6:208:23e::6) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SJ5PPFFA661D690:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ed2aa37-e76f-4a75-dc77-08de6f51af23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?38jO3T8KXzqQAr1dB65b2NyvNmF29MTrSgoNCbZMNwVGmmLZWWbAt/x/25mJ?=
 =?us-ascii?Q?9Ma/gphHenHmWsxxw0odgTzDdsKf/8VVhdsfRui/8uBSDnJN05w2rVbbJKzo?=
 =?us-ascii?Q?4WJQWg7HxJa/0+48tQKUxoe2QIqVDN/VQVGSGbS+vyRYH777PhebfY1M7JZM?=
 =?us-ascii?Q?peBBgR9trQ5Srz1P3Qacn8nfXQ3TE6S1CowtFQNEN3lC8OMNyGeFgccZ+XNN?=
 =?us-ascii?Q?29bYo8zOshoGLvxs9lAabQLchcobJ7fZnUDKr9g2RaD9IA+MWUIwUYS9JClI?=
 =?us-ascii?Q?QN3SLLvZKCdMFB8lW3W5s8TISgr2S7sfwEfT9391SZDXWODGnOjGll634BA7?=
 =?us-ascii?Q?5LPQqrbUsHhOZDr29zjlNTiw7igGuRBNjPpFLI7oBqpfl0DTtfM8YiaBDp6a?=
 =?us-ascii?Q?KLW800IEonReE81QwRak33fFgOu+HSJjYObXffDzBP6lpDURSj0CunKCX9eJ?=
 =?us-ascii?Q?Rv3hhRMH4HdiX+Gs53Nex8EGAyaViAPclJ1oId+y37xK1R/Iw4XVCeW4YwFe?=
 =?us-ascii?Q?M5RPhhMTNoBAeCnc/mo7Pw9xbS7LbuhcZa4vNjp1nLmfke5y+io4xLeD/QSp?=
 =?us-ascii?Q?PeOzwxc3lfNztSOMB1vdPxEe6ucH8+m6kY3wjjcZKMKVuZjRpEQPzZE4Gh7V?=
 =?us-ascii?Q?gxjmOD0kHF1szvhPKor0kpSwRRN3+/a4h6hICQg4NzJP1CEQz69EdcYCqnFy?=
 =?us-ascii?Q?85x6gTJGpXwjQ8VpzkPqY0+WzNdWnfHKize9wPHlkwQeKy/T4ThyiCONpa8c?=
 =?us-ascii?Q?w5Jg6nHBsYboBh9+CkVrvE25ComltQWbUqlfZn2Q8g6U6Vk+iwW+XdB5jj8B?=
 =?us-ascii?Q?nHrVyMKjo+xQrZDfiZAG5LxQbIADtjMRZwy9Il2ykZGNinrrSzdhSFfHBJWQ?=
 =?us-ascii?Q?qLxEhSE99ylo2Q/d0D7ojuI73vOj8TKqmKZJGCtw9p6CjeqtfmZklJ6H+uHy?=
 =?us-ascii?Q?dkqoVAXFw05o8H5JzQ8ESoLZMDdOs50FhAl6oc7chx/POcLcxntqDerPD/dH?=
 =?us-ascii?Q?LBxtRQW4I+SbcMvscltLzghMuq62lJmBvHBG5q80fN3sjQqU6vs4/5dgMXjv?=
 =?us-ascii?Q?qfen9MONAAojBZz3wmA0GoAJ1XdYFSsL/7+NhcJWrHh7wk+8XFn7zZgr9jp1?=
 =?us-ascii?Q?T8L/JiZaMQIlFSLyAkvDGu0USa7Pz4zUHvAGTi0HOyeBVcKzRQYCOAfzmA3F?=
 =?us-ascii?Q?3QemiI1zXmGJTP/yYPiHHP1gnacxH41XESG+phWZImk9a/fu1T7FYEE3GnqG?=
 =?us-ascii?Q?fepkjS/WtmI7Dmn2JQ2/Da5iJppx0je+7o0pqPeXhYvSd4IKE1GnA6zpmDrw?=
 =?us-ascii?Q?lPbMd3S8SwJKZss02/A9Pu/sGQ5wDhNW8ZQmt1W8dEhhqQqI+emNiPb6gk97?=
 =?us-ascii?Q?0KDZ5+c5dpCvyyMaMGz/XGNsTcoLGQ9/xO226zp6ji4Y46JlUf8GZ8CjAY1Q?=
 =?us-ascii?Q?ZcCYcGWQtI6oZO7DNWqI84zWHFT43PtQ/Y15wGjt41uhPSGlRrwHPbRIKVeX?=
 =?us-ascii?Q?qIqe8Gj9uX2XG8Ip82ZfQj2b7ldIgBh5LvV9HxDPVt3qYsxTn1WWjRgtywSo?=
 =?us-ascii?Q?e2PG4pmcvf2g1FmOOoE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gdwox5iYKkvx+Or+NhFCGZTW0mpWsBm/Gcbnec7CvGTRUPuwghnH3PWMpZ0l?=
 =?us-ascii?Q?dgi1GbDQogYAJFeK4c7P07L1jSJ/Jvo1FgF9HH+iZOfFpLXxrq4cpcDM0iBP?=
 =?us-ascii?Q?tO6sTzJLu05bGKroXghLUln7aKowMJtfj2NgOUw0JM9wwP1F8XfnJk4L2kjJ?=
 =?us-ascii?Q?MieUd9hNYxRFbFf7g6dQnAnELTSzxSl9V/JaB3uLPY2BYmv1guyvqtc5ribx?=
 =?us-ascii?Q?D3dxJ09oCutCQQjPhR4eiwXIiSrGm+xOHa8k9VpFPidQbeKz2AJT6Hx+92kU?=
 =?us-ascii?Q?EEZp2icxuhI05BvF8Q1Jrro3qwumiq37uiF/jUMELoQ6KEpgMJnKzjNCQeGT?=
 =?us-ascii?Q?lUvHHSAD0PEzmrLWjbj4CQK4V7y5lrsO+1rdt8H1Ho4I5XZZBGbwcdQ4iq/e?=
 =?us-ascii?Q?2tKQ7fM5RRIzFudKrB4+1U/K9RkN+92jy1PH9ly4xNDDCdDrqXL2pwXAMI+T?=
 =?us-ascii?Q?Tk8la62bQulDDyJyrfk8Q0/iDs/2c5CIoOd5FB0iWdEGJ7BuQ/cZ8rBinFGP?=
 =?us-ascii?Q?QGT88ZTxeb3+NotVD1WSJIsL5+kfbKNhMGGy+AH8UJoyxZEQGuOKo5qeiY0h?=
 =?us-ascii?Q?vsueks9x0WqX4G7M0bH914uIGaCI+ZXJSfs5RT4X1HvIosCXV+3AfWfBhDOJ?=
 =?us-ascii?Q?r5P5raUhT43qb0TYs864dX3y2PXd9skXFYBfx+qJADjxwxZbvJPYHYllFGrx?=
 =?us-ascii?Q?J6SFl90cBvPPClVwEUKcgmrIYN+AWAJi+PU7NCW3Fb2MtDg0ZwSMckTsnEEU?=
 =?us-ascii?Q?xvkN2/kFFYHZKs7yAJLYBAeS8lGFK+E9OiyK9hC1tz8SyU4zd4qNsibtoXjF?=
 =?us-ascii?Q?7j0Xouda1dG0UvkzKe9mETGUtUsPCaKGHa+ty0hgxoMxkZLcZ6iRsBtsICx3?=
 =?us-ascii?Q?F4zKUEh8oD3edN9xfUdVvZ+men8Q6wcftax6CvS3BmoW8QFhvvg9tZz7eiUI?=
 =?us-ascii?Q?uOiyv0EOsbD3FwfKnTkaPZKds+8iyDZ/KDFRBojSidERZBQAWY3rxrzOCI3N?=
 =?us-ascii?Q?lhc8xx7m0U3zuSTdMpNp1Ek1jllEheY27LCfu6FDp9GKHRNbsSUZvi9NXPPb?=
 =?us-ascii?Q?A2oqupzHbk9QgnwRJP6V4yjTzy1I7uqRw9M80LsMFBmMNAb83ESbhu5LWz1B?=
 =?us-ascii?Q?+F37MJDJIJ9rrD9j+ZXz/v/97zL2YRlaFR3lBSPWC4ayq+0OvMgyGJIfguw8?=
 =?us-ascii?Q?K4I5GzkwvLtXTgD5uSQwcSyXfxgndG1sHE9lKCY79Qr2TBLmjqPPpG6bx+z5?=
 =?us-ascii?Q?/y1izccKNm8fJV2i2he3wjDuzroVcedujcTuD757kWoPgSztr0S8l4dHGfHP?=
 =?us-ascii?Q?i6xAqp1PsWyMcrQOtdgDId4wgB327PHFgV7GDBdZwpC97vwfJvxp+wwnDnEy?=
 =?us-ascii?Q?TBawxOvybuGGia80FWwC+tc4dmyzTXGfqZ1h+ae7Y7oh6qGCloWBvF6yR55r?=
 =?us-ascii?Q?4G32jy0NQ9KSB7u/kRkM3UMTPBzKhFAaT/2d+Bv1gCZs71/GafkMMjbMvfK9?=
 =?us-ascii?Q?me6lG/BuUJIUyM3/z6o4aiT/qmJKrwRsq9ZD6LtexA2/Ampqs4pQ0Co84j8B?=
 =?us-ascii?Q?xHnBdMja1X8OKqWex9LAnnlD34/aDQmtsX+ZLePNu7/BZ6ZpYVvxzoMq2Fxd?=
 =?us-ascii?Q?mcwcxqs5C7J9KrXkIhzA6rAiJmqqYk5zhOTJemTmTigjdxMecBdgPk13UDnh?=
 =?us-ascii?Q?+BKv1+wF8YdpvI8RZKkTImX2gxyj7VC/vt/smxwEU8Uf8ohJU4jBspbNjQDD?=
 =?us-ascii?Q?c+L4gmPW0g=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ed2aa37-e76f-4a75-dc77-08de6f51af23
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2026 00:56:15.5827
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yiV4ig1nFhWn/92tYop1r4SXfCgkDj1FiLsULb1Xx4uqNCvHQBpRhz8UnxOhDtBk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFFA661D690

On Wed, Feb 18, 2026 at 03:40:10PM -0800, dan.j.williams@intel.com wrote:

> So one proposal to get the x509 pre-work upstream is to extend the TSM
> core (drivers/pci/tsm.c) to export the certificates in sysfs, and update
> the existing "authenticated" attribute to reflect the result of cert
> chain validation.

Why do we want the validate the cert chain in the kernel? That sounds
like something the verifier should do?

And not sure we should be dumping any certs in sysfs if the plan for
the other stuff is netlink, it should be consistent I think.

Though it is a good idea to do something with the TSM too..

Jason
