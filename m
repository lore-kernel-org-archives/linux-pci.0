Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013040.outbound.protection.outlook.com [40.93.201.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB291367;
	Mon,  6 Apr 2026 03:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775447352; cv=fail; b=TZe52o4/LxJZogIVQIegQM2gu/DZH106j5gAXeMVKSH8C4vw3NU/BkHglbZuFd61n2PtlT2QiwypvRhViXyC3t2b6j7jZvZwPleBHfHk8AFT5aJ0/EbQWhSs9UlKcj06j9gWegjhv+uxzhMJ9xecZYJeAX8xn7o5+14TYL9nRLk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775447352; c=relaxed/simple;
	bh=BdvIW2Qz1eNlOzDF+ShufXb+6ps3RSo/CaAwS9aYPds=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=mcuQRNysUGKh/MUhU/lajvYQbUt9iC5BWOnLCkkM6tJYWmbyfmd41/kPBlBjEF3DZAk7dfdBe47CKfxDcyYoKpawH+icA8bhQDEop0SpGwUr1j7eyXV0RZjX3Y39zlqWf/a4GMc3XaMM426uL34CfHsR/C6+As0qKV2Nu3cQWQ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JzKol3Au; arc=fail smtp.client-ip=40.93.201.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JzKol3Au"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PNAkXV3JZylCIbMnteFdH55TB6+i0OhavO11L3xYh7HxgjK0mhxhR5DE4G6cdR5vkewmjZqGfH4vb1g1rn35eaDbvQ5+hHyBP6D97nU6AjTGYccVVtMi9rIyMebt+Y8bd9ZxuId6ir/ixaM30A5av26IZtXjWJCDM6uR4e4YqK78HjHyT9OKVl5f+79eiHN5NkR/gmQ5YVhDOT3SYKmFvD7su1vYKWpN/UtxoOSibvW0j/D0L27aVeinxXTjnS5tdS60/qBu0QwmDRF3FW3+7MbPXs/TWUikqUn1DgrTJ32L+qd1pqLS2r7Wp9yI+ffKpj5JMf6DtMhB9eN+a2YoIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BdvIW2Qz1eNlOzDF+ShufXb+6ps3RSo/CaAwS9aYPds=;
 b=Ic2Gjj49RZLZvEuOqIBKMkYifdffZZ0aVYkl9WSfsSnUiSdkGk17ZaZWktQN9GenhQ7h2/ow8Lh/5t82lMPPTVbuqTayai+s5Yvlj+QX4mlHxIzbiNlLbmpoc2AFTLI0EQR1LrSSrCekdDOw5ZNgXdzqm6u59LoChKCOpJxKMTnEdoh7xYXUhOOsDPFJg3KVVP/ANJPz0PgpoFpYH3eLVB/YpF6aaFKPKIc+ycSdf8G5cwuyvS98Gs0S1xh9QJPfRWkudavHa1d40TGn0M5a89ULwP8ya4kkHyJdia1uPoZE/d7Db6oQMlZRlVIH7sIU1Tcn6DCEgMuzcZuXS8SfuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BdvIW2Qz1eNlOzDF+ShufXb+6ps3RSo/CaAwS9aYPds=;
 b=JzKol3AuDHQ35ZQsUMhxvSdT3Rp4gNx+IRIil3FPyIYfOU7I3RtbXyk7RvcRkf3mEVK/gBuF64j50x80aJC6cNaOR0d2XaI28YWiTpJ12lMXrMpG1J4pbV2c8Jc8IalXL9eckOX8bhBjEWsCWQGcXceHpy5VECsy+cH/zF19LOpKDKrjPm4Q1Wt5Pk+nVRyoqn/ltE313HBkMtJxf1vHhYOXMsVwR8LCJuqpFPYBVorcbO4stT59opgQ7omFHutofAbXMXM38Litf627KggfEppDN5mG/2vqmJohg2i3jQW74c3QVtz03vFb8QisHnKzJVzUIBlccolEaeAQv3rXlA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by PH8PR12MB6913.namprd12.prod.outlook.com (2603:10b6:510:1ca::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Mon, 6 Apr
 2026 03:49:07 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.20.9769.018; Mon, 6 Apr 2026
 03:49:07 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 06 Apr 2026 12:49:03 +0900
Message-Id: <DHLRK1N13KX9.2Y7CVTJLPMOWF@nvidia.com>
Cc: "Gary Guo" <gary@kernel.org>, "Gary Guo" <gary@garyguo.net>, "Miguel
 Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, "Daniel Almeida" <daniel.almeida@collabora.com>,
 "Bjorn Helgaas" <bhelgaas@google.com>,
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 <rust-for-linux@vger.kernel.org>, <driver-core@lists.linux.dev>,
 <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 3/8] rust: io: use pointer types instead of address
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Danilo Krummrich" <dakr@kernel.org>
References: <20260323153807.1360705-1-gary@kernel.org>
 <20260323153807.1360705-4-gary@kernel.org>
 <DHLB4703ZJUX.371TA9OH871FG@nvidia.com>
 <DHLB7ORTXAI0.1K0ZOL37E6PI7@kernel.org>
In-Reply-To: <DHLB7ORTXAI0.1K0ZOL37E6PI7@kernel.org>
X-ClientProxiedBy: TY4P286CA0067.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:371::19) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|PH8PR12MB6913:EE_
X-MS-Office365-Filtering-Correlation-Id: 26eed5cd-c278-46c7-6c09-08de938f7437
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|1800799024|376014|7416014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	p5FVogjvCFSIvc5HpfwL79IZ4JwvB7BD4po4jsWtOTvLMR4bNDE87NoWRjp5twdaGncemxIFA7Uccp9fe0jNQvyrb0fiX/zGN3mG4bYG6IOpv/Mb7uDSDmsoLMVddT1oijWXGYMSTQQKNMuQuZHX0gPyFEoRCtuTI7k3RzU/AA5GpyxB8EHIv1wWJaVG7ygbV3kYr44xTHw75LivNR9Jh9mnxAQupEKZt91Hsib2VUiIaLonJ/OeAgBkvvRoHwvpdFN1Sl6xR9vnovtUtOalJMMYMs9in/rY5LDLjulfk8tdxffus+Q9e3/J6BUH+2sFWGMih8XdmtbSDfWkH/A0AKeGkNFYJlyIJF49ygh3JRe1r8ZWwllVjmmiIeSRhT3k29IaRzzO4zycyauMjH74t+BbVPAEXDacdAawt7HgDKdmNZaAFleYmpuL89Ruj079mKN5qC3nyLoyendvjU0SrPUG3ffrmEuUYhfnlJ5mdxp8BdXdZRXRowm5jx3hC2gDeH1p8N7L8jlGeruEeJmsO4qaWt75bi/zNAWn33rJEso8P+EsLn2GFsLly/8ajbyc2jYp5U0iHtycY1iuX1BOO0IT9mAMY/R4rshhKaN+Ac+rgpma20aSuqwQQxM7yadoGwOzQrbKWtjyD1Yu8tHt6Fi2MJw6qo6xOP9QdtFKZRDRKMvGouNvhfh/uGGJxS34GiYaTBHP7udhfBk6F+6t4z+AZHdNjl8VVY5oD3syl98=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(376014)(7416014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VEZ5Wjl3dGYvakFVNnA4WmFpS3F3VFUxTW94MWpoclpVQkoxejQ1S1pvSlVL?=
 =?utf-8?B?TFhzVjd4NERPT1QrbE5zRC9kZC9BWFNkQ242SVg1dHpweWRwMys0R0pIVnhy?=
 =?utf-8?B?UDI5VEs3SGt3bkRtNy9BRnNFYzJKQ2lXYTNkOFNQcnNEMVBPeUxRUEQ5eE9N?=
 =?utf-8?B?NjBIYjJBbXp0OU1ZOHRJVUJpNWtjL2VvcVlRQmQxeko3WVBjWFRyc21rTkhu?=
 =?utf-8?B?cTJuWWwwZDhDMmlEUHRWWmZpbTFKUEJYaWtmMjRlUDRSWjVvcnJ1UDJ6UWM1?=
 =?utf-8?B?eDk5R1hzNndna0FGNUVsaWI5Z0RFVUptSkF6cWtKNXpmbm1rUUR4RGVMTThy?=
 =?utf-8?B?THpSdlN4ME02c1VEckFjT0dkSW5jYWtWdVRmb1F0QS84UDdkQklNQ0tWMnlV?=
 =?utf-8?B?QzdhUVZ0MkM0TjF6ZGsxUWNGdTUwVWlNWmhzVkxoTU5lemZ3K0FBbGZ2ME1H?=
 =?utf-8?B?bktHSUVhQ3NmNkJwRE5kbGtGaEtQOE9oQjhkaFFITjBlb2diNkNQTFFXcmcy?=
 =?utf-8?B?Mmo4OVNKdkpDWXNMTm5KT2FhVEtLVHltSElNWHRRNHhoK2tJcEp2MCs4eWhV?=
 =?utf-8?B?OWErWE5abGg1em9ETU5kZE1IcGgyOENPUW5OdVNnRmpGRFh2ZkNGUnE5UjJH?=
 =?utf-8?B?Z1Uram1aeW9mN1BhdW4vQjRKd21hdHc0SlM2cDNQbXJhdm5pMWVrS0V4Vm1v?=
 =?utf-8?B?MXh6SjhORnpOcldpZVQ1bENwc2V5bldiMkx0MXd2V0UzUGNwWVF5ZmszVk16?=
 =?utf-8?B?a29DTjUwY2E4bnRGa0piYkM0QlpVM2pUalphdTNyMkdZeG1LVkl5bmt5RlZm?=
 =?utf-8?B?NFM3T0hiZVp2eXcwbWowd2lvVVRPLys5UHdwbXFTakRVenBxdThjOFNJbUtC?=
 =?utf-8?B?RzRlaE9TajRQYzBwVTkvdFhLK3U3N2QxZEhDV3ZxRFJTSmc1YlAzdURWa0du?=
 =?utf-8?B?Mjk5enhRZnVXQzZtZWNYYThVVTF0U1pYazIvSmtMZ2EvM3lTRTNlMnhJb0Fo?=
 =?utf-8?B?Tk1USmt6UVZtaFRTbTVpSk9KQjVObklUTmE5SWxVUTVVL0VwM0NjOFlLNExa?=
 =?utf-8?B?TUlzd3lNV2tWeUsraFcvRk9oOTBDbGIrVFRScjYrNGlXcG9nNW9jVWhKZTB6?=
 =?utf-8?B?c2p0Rmc5VWgvM0FZeS9tZ1pXSm92My9ndkpOZU9KWTdMd3QrS1hxbjgxNWdP?=
 =?utf-8?B?a0RNaGkwOVRWYmgvZldtajhuekxXQkVIZTMxalZqUENpUU5MWFRRSGkxRDlk?=
 =?utf-8?B?WFhmQTFWNitMZkNVNEhmeENFNGp4Y1F5WURsTjNVRVJsQ1dOcFh4MUlUQWh5?=
 =?utf-8?B?eElwWGxVY21ZaU1xdDBKNnNyZ1pQajRQTGFod04yNnNjaGFHNHBMa0NEcFFI?=
 =?utf-8?B?NHdOVGpZbjE2SG5qMVl2b0tjWTNtbHdRZThyWS84bEVYRWc5ZjRRVUNaQWg3?=
 =?utf-8?B?TG83N2dBUkI3eFkvM1VaZzErOWgrbkFtQ1NFOFI0VG52T3dQb1RJS0NlNFFJ?=
 =?utf-8?B?Q0d1ZlRLM0QzOU5WeWZQN0dEdUZDakZ5bGc4WUFLaXhJM01MaEZNcjcxWC9n?=
 =?utf-8?B?OXR6K3JuSFhOdTVvNHFFZ0Zjc1BhM093VnVmSjQxVUN4cjJZV215bExuZGRx?=
 =?utf-8?B?T1IzMVdQZldpdXQ2SWY0UXpLYi9tMlpTNERmWkpUOWd5QUdodk5YRGNvdWdY?=
 =?utf-8?B?Qm9lMUl3T2dmYXBpZTVuS2prZjV5dHN0TThBNEhLUjBVMnpJOXRkMmw4eUVy?=
 =?utf-8?B?a0tvbkMwN0NGNXBDeTcwQUordSs4UUFveDhaa1pab0ZHa1JoWm5wekRqUWRB?=
 =?utf-8?B?OFNCc01YajNxNkJEYTNtYVZSazc0VDBDUXRKTU5Jc1VxeWpUZ3NsSmk1cXFR?=
 =?utf-8?B?eVBINVVOOFhUb1ZLa3AwdUxNdWplalNkOFROWUNkSjJ1aE81Mm93THUrU3Q0?=
 =?utf-8?B?NjNZR0Q1YnN3a1FEUVZiQmJpZW5kUzN4c3NPY1ZEcmVtUmEwdGRpcXk4c2ZV?=
 =?utf-8?B?RTlJcU95a2V4b0RlbG0wL3BhVHNEdk9UREVwRXRrRUlOVFVCYVBzYVBhRTFT?=
 =?utf-8?B?elE4OXE4OFlpM1RxSGJabEc0M09vWkg3YUtpYks1OXVxZHZERWhGRG1jVDlW?=
 =?utf-8?B?U0Z2WUNLSHg3ckd2RzRjSEl4NUlaYXhCYlUxb2lubGZ5TDVjRzNwbmZXT3hO?=
 =?utf-8?B?c0pmaDRiSVJlWHJLb1lmdUNBL3haNG5zbVZabUgxdElucW9OY3ZOd1VNSVls?=
 =?utf-8?B?NE43NWpUN2RYMVdaZFhNM2Rma0xJTzVFY1pqbGlnclVXYlEyQjhrOGZGTGVh?=
 =?utf-8?B?dk5VOXd4RnhFUEVqbmdiYnRpYi9yODRGckdyZGc5M1RrM05EVlRhWFdESitP?=
 =?utf-8?Q?5Qf4P9nm3fBPsP/e+5CiB2qzK6Hww6GdtQEULA9RpqX11?=
X-MS-Exchange-AntiSpam-MessageData-1: UA2XsyskUgByjg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26eed5cd-c278-46c7-6c09-08de938f7437
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2026 03:49:07.5808
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wc7X4m+/cGidsQvrC251ggm0X0mQ5/tL+LCEl1t5dFUBYlFuQdF/3BtdanY8IRKNehLGiTgy5m0uJJtsTOkyoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6913

On Mon Apr 6, 2026 at 12:00 AM JST, Danilo Krummrich wrote:
> On Sun Apr 5, 2026 at 4:56 PM CEST, Alexandre Courbot wrote:
>> Do we have users of `IoKnownSize` that we need to keep it around?
>
> nova-core has been a user so far, and since the patch series targets the
> driver-core tree it must be considered.

Ah right, in the nova-local register macro. Makes sense then.
