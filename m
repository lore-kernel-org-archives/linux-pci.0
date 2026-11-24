Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795511994;
	b=pIAodCmV9ekR0dIZlyRTnVa+f3ouoCR6THnEZdf30YNdgGG9jB3xBE2Bgx3bv9VUVr+r
	 tdAl/3aoaJ9MRAtH8mrWvMUOvCyLTXLNWlDlHs3EbFTG0QUH7RSllpmS9dc9z13WwpxxZ
	 65peQFVZ+wxgv8qq6Wk27jX61uUwIZR0t5PDjvUW9df+TFvrwusRnLcyw2HzRh72crinA
	 vsvzrY5rm/cehUEH2efetDivpj5uhl/ar1oo+JnFW+tUaNElVR0yti58w6d8FQ2lXgQNE
	 7ncsLeQAh+pOjvKZMzmMV4cjsfbnR79nxsMd/Yqua747Nuosrc/EFQq+6AOjBFrZPdg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795511994;
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
	bh=aZ4pxcaq3MlXEwX9BaxhSYpmr3lby8xLBeOUw+2Qtco=;
	b=HUrX++TunxaDJ3Ymeeum//uhgc82iy/IwhqqHqgApdKg0sFyQJ7uYWbNJh6IOLTlihHD
	 ZmZyz1C6Eqkyx0kRJlrbhzCyGYnzoBb44ngX7KunFsLX3NolDKDbdp2Nin8xXrtBG/CXf
	 PAELqPkPitQ9I7LrpuTHc97ReZjdtPinyb3Ut3pVqwaZFVhJQF34ut/3h/KhJHIa2OZ4I
	 /usMLJRzZwlnqR4iIW9uChO6JaWPTkdpOpmVGpZ4zY2wHnwrV6+8Mk+H16Y0YxtVLDC4J
	 2kNXrd+PB1368cVnXiU4wB/y6wPONZcoT60TOTxjAXVOJOl3GGwxPZ3l5Y1xGRZ6Nfw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=rAUAOulv;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.52
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012052.outbound.protection.outlook.com [52.101.48.52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B59606A335;
	Tue, 24 Nov 2026 09:19:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 30B59606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=rAUAOulv
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AKitACNCPxIF5bAAT5qfKWkQHe0YXbD1EIHFtxOBiqU7MqAqTgqX/3/2MHXzlODqHAPwrJp7DlTb7WvECllOOp1S8EX/QuBDdZ8KiyytwNQxqu2KinHXLkZ+hlTTzHYdvwnoXNtwoiLcqgHsBT3YKWQAyUOu7dPFBhdDQ5SPD/XP0FbFtCY4iDpY0J++JOj44WLueZE7lThqEDhdi6/4mlYewbtmDVwmYtGss59GVKLDQ8+X9tms+mwJFjnhr2BRT1ZULDPuhn9+ywkbccbNZ+40wuJhlXAR8IkYLRp28SDxNZfoFQ3gMHiB4ouHMHjxpDrP2Gloz4e+X0dLhE4nKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aZ4pxcaq3MlXEwX9BaxhSYpmr3lby8xLBeOUw+2Qtco=;
 b=ApafPbbnsrM5+WD8RFQfoPCNgqI2zu1/n+Mr7wDCLEutGoRSlFlOQpWSsFhBbjgTdWJ5xRLrzwLQ04q5Axb7jx8DFCyj8zXNkV0qA6PsOk6A+kbg9DfDxORC9Nz5gCDHaaSTtN0PbuhRKxIcoGGNRAsY096oUdKSF8dF8sQqSTRPzpi+a2lVrOT/yWTvJlYCHtMunNj9Uw0beaIus+EL32/hGAj0LckNjeaOVrqagCqc0lz48QHoAzoMawHJPeRmA+lcOm+W8udyq2ODjClqoPYoOBECRaZGsoK8LfoL4tz3Zt8zhmrRY3lLZHJJv7EgnYNYPNcmqcQREInmxA/Qiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aZ4pxcaq3MlXEwX9BaxhSYpmr3lby8xLBeOUw+2Qtco=;
 b=rAUAOulvAfwyvb/gPABKUEKxZjTvjoqSTwDybRhe9RnZgCN58qGKKIe4QOdfLis1cFwljAw0QKANDFjzypfHTdKGHFFX7Esaj1jgTvdu47CQs+dyw/r9QRILV+425AjigMk9RxSSPzKDLC0wCnpGV9p3Wp80lOdka4NywgYbtYa7UFSdnNhpsSnQNjnx2TxBzYOmxekDzcCFG2QzV5c6IGYBNohfTe76s0rd2zyB3VWFWD89mv7c0jjbIqwSyIk+kNN612wYjyh9K/VjjyxheBouFAvhO1KSSaFhsn3UuCDcXFS0bWj1ODsmh8Wy6nCAxaVdUkBkwvYNHolwwdr8kw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB903269.namprd12.prod.outlook.com
 (2603:10b6:408:40f::22) by SA1PR12MB9001.namprd12.prod.outlook.com
 (2603:10b6:806:387::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Tue, 24 Nov
 2026 09:19:51 +0000
Received: from LV2PR12MB903269.namprd12.prod.outlook.com
 ([fe80::29c8:652e:e2b0:4dd1]) by LV2PR12MB903269.namprd12.prod.outlook.com
 ([fe80::29c8:652e:e2b0:4dd1%4]) with mapi id 15.21.0639.012; Tue, 24 Nov 2026
 09:19:51 +0000
Date: Tue, 24 Nov 2026 17:19:44 +0800
From: Richard Cheng <icheng@nvidia.com>
To: Joshua Machauer <machaujo@amazon.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Dave Jiang <dave.jiang@intel.com>, 
	linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org, 
	nh-open-source@amazon.com
Subject: Re: [PATCH] PCI: Skip the CXL state update for a VF
Message-ID: <awVWhqBe62XZ4ICF@MWDK4CY14F>
References: <20261119164219.51540-1-machaujo@amazon.de>
 <awOxn3BcKl8Ru-QS@MWDK4CY14F>
 <20261123161956.72689-1-machaujo@amazon.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261123161956.72689-1-machaujo@amazon.de>
X-ClientProxiedBy: SG2PR04CA0199.apcprd04.prod.outlook.com
 (2603:1096:4:187::13) To LV2PR12MB903269.namprd12.prod.outlook.com
 (2603:10b6:408:40f::22)
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
X-MS-TrafficTypeDiagnostic: LV2PR12MB903269:EE_|SA1PR12MB9001:EE_
X-MS-Office365-Filtering-Correlation-Id: ab9fbb13-0315-44b1-c086-08df4a0c17b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|22082099003|18002099003|56012099006|11063799006|4143699003|261026121527099003|261026140227099003|261022105027099003|10067099003|261028144727099003;
X-Microsoft-Antispam-Message-Info:
	KV19BG0P1qSIMBHKny0CogCxf33En3k7dpTX4TI8VV9tJxYeK4ZFufsWc/YDsoBXjOCee+TOZca1cc8P18n7a6BGDxRMYUmLlLsWMhijPCraOM9pf8aarEMtW8Wd6BA+4ejjGD+mV9xuzH/DZwYEHwsOygz8zI/amLdL60riqegKlnMtWj64oJq6kQQcibQ9yizEiV3lijq3IwTSHqZFWp2d3XQa627UgG2raR9pfV+IFCujpbsMzXTrB/wlhWhW1EWziKbyfJsicaDG9iMIIY+unbzxS2FCdVUKw9Yfq5A25U17SWV+RO5hB6dXbbpeaxF4S71z9YH7mPw3p6zm26krhsnQWQwlou3OF/4ULEYjMsamrR4qf24dEMzwJjc7XNRdoUclOO5EhTmfsTWLIPLeJINYNNCN5Vh7PHq0w9WmJDIdvu7zk9+5T/CLnbLycRc4fIZjAE4AFxwlEO09Dalz7h2tL5+fX/gIiUKHE/G7k/X2ldaJ+5foGuwoBFuCke+ln585YCF41c4hE9RtnNT02Nl6V/m0G3YPBODbayDIEwHJLRR27eebH81fLa9wETl6JgzSaVdo27WSH5s3Ect3dMwC9LnsJr6/31s/enlgpJuDYok3VlUR0JO9n1sc6rPQ15dhjP826Vl8ApYjAg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB903269.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(22082099003)(18002099003)(56012099006)(11063799006)(4143699003)(261026121527099003)(261026140227099003)(261022105027099003)(10067099003)(261028144727099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BB6bw+nE8EfYjP8WJpo64KrboLIhb1djN0WQvr1G54lJYS8uoJIOrI0Ryg69?=
 =?us-ascii?Q?AJag0cIR2rjyUcdyawrd7QxOEXGjfMQVXqd4ELDJQJPPvoEvY2k1qbAViCAw?=
 =?us-ascii?Q?IZHzplGbAh3d6avL8D7tBkU+O7D0lAuC0nQ9WQiuC7FyVh+3KICN8sjTOg6g?=
 =?us-ascii?Q?z++bfjzWBvyoLG/5JgaM1di5gH/9PwtKQh33XW0+v+ieWKBTE6/08A/a8CWA?=
 =?us-ascii?Q?RAh/A3m1p/gVh50nRt/EMzErMTwUKee3bue+V4mJjd36oQVkMBy57NF3NSzq?=
 =?us-ascii?Q?cshrw/8QK6bexMhDhrt3eZGK9jwidhnryh3jI3Wr8HrRSEWgfQhA1pBDbJfk?=
 =?us-ascii?Q?35d6qsoYYfE1deOQ6oIBI3jrb0vzV2DBOz/yWzUh7eNSxhHRCTH0ddW4XbSu?=
 =?us-ascii?Q?1W+tmFVIdgaBYoUadATHBV87JGa7LyOBwMzpZrFCLHRyFy7ZUQ7vfu6wOyv7?=
 =?us-ascii?Q?TxtF5SP47gDor9f9yX/TEO4pqMfIlqCGEqJTJmRbJEzs963hWE2hK8ZQhCt5?=
 =?us-ascii?Q?ZTc0LQT6TnIXSt/uVkKO+pzh+JBLVsbETm+GbFWsv/uGa256N1f6o2OJl7Zs?=
 =?us-ascii?Q?3TgW6+nGyfn5NNLI1eI/51f9cvRXUZkcIJRv3cp5MwDMz7Vmav93mxj61ITD?=
 =?us-ascii?Q?TZ4C0s4iT1u3RiODubrusub7HmkzkVYWhnuMWUsO8rRCRJwKVNk8XxOTkniS?=
 =?us-ascii?Q?ATIpyNfKT+Jll9hV4GGi5BIaqFSlgqpYL3inoQFSvbXFrEEjenV9ZnVBQf4D?=
 =?us-ascii?Q?Mv4Kr8W5mmdP6WDs2o3cLNFdUGAM/bb0HoSlKqd8QMvf/4M8zwVRNYLYIa5/?=
 =?us-ascii?Q?Pts6YxLNSu03ICnqyvs5z/Zi/o/05orafHcAq04FZRdn8t6YAUSOuB7D65pm?=
 =?us-ascii?Q?qWPfvmtPsXSaiKy3h+KN7/QZ/TuN6+SDYLfxwr6tW4qq501P7pNf26XUJgxD?=
 =?us-ascii?Q?yvVH6Pke1eSGRb+3qHiHHo4PPokjixGvJqvStL02vdOI8MvFrX43Qd1fQKbp?=
 =?us-ascii?Q?m+1gA01HOMD2ua1OC3Gb5+pO5EDHaRuS9jZ/3YhJHT3gFfpzW0UqpyoUWRYQ?=
 =?us-ascii?Q?Lihfhu2OFTKTTE5IKtLKjdg8OHnis5nWBJShSbMtws1zIbgnUZR8rVPB0oB7?=
 =?us-ascii?Q?C4Jf08ccVqyefYXxV9lx+ESvhzdRzJneU0dh3Hkp3KTqRD/0iCcsRQgDJfPf?=
 =?us-ascii?Q?xIkS+tl6pSa9VHCSOULBeUunYrB/7Q9Za0+6dxPNGN09HX9+Hp+KUHX/a52N?=
 =?us-ascii?Q?vGT7V12gg71f68pdZzmWtdKU0uOENqrrRViKA9Ql2uFjfmvJ+n2JcdWgDrCt?=
 =?us-ascii?Q?9o+6NjnTT3N0rRX+/menNK+X0gAhff6mYrO2MEwk230xq2HUr0hOXDh+7KUp?=
 =?us-ascii?Q?4OLjI6BTojM61E+QSvKeg3Q5Vsbd57jli78PIL59/o7QU1kWOm1thJI+Cq3Q?=
 =?us-ascii?Q?JJkcBzlpozlHcharsyljxQprF6NIboatLVaLxt7ILkfa9Lw60uhVG5hy9O+s?=
 =?us-ascii?Q?1Kx4FfTIGH15Jm36G55GIfuFyeYzJrG5LR7vRVXK0/au6cuni6N88xny5BuG?=
 =?us-ascii?Q?b0dHGuHkKHTIAdoZ56yQMsNnE+fY/WVPF9hfCbREyvr1bjHDM8zpSwZJ+D3c?=
 =?us-ascii?Q?wQYzMIKQs3zoj4kMIKl7Kv172Qx8Y9eURWYtQoCw3PWAeM4zXxWuwLqalBgb?=
 =?us-ascii?Q?6AkQ8jvuOYOPeiMTyql2ijMfw2jrHCGUk7/CCjBzBtzI4k6TILyUd0hd42dx?=
 =?us-ascii?Q?Jfvy7UsKAQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab9fbb13-0315-44b1-c086-08df4a0c17b8
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB903269.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 09:19:51.0725
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gZaYCsmieJR//7SHVjZezbG4D8WzsFz6yLnsH988MLykIYuR/Ld/k5bwplR5rtnoob3DO42imoydBhZ74tsnOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9001

On Mon, Nov 23, 2026 at 04:19:56PM +0800, Joshua Machauer wrote:
> On Mon, Nov 23, 2026 at 11:29:10AM +0800, Richard Cheng wrote:
> > One nit on the sentence above, before this patch, each VF add also re-read
> > the Flex Bus Port Status of every bridge above the PF.
> > That refresh is now gone. I don't think anything depends on it, but
> > it is a behavior change, might be worth to mention it.
> 
> [...]
> 
> > I would like the spec section to be cited here, CXL r4.0, sec 8.1.8
> > "PCIe DVSEC for Flex Bus Port"
> 
> Thanks. v2 states the dropped refresh and cites the spec section in
> the comment.
> 
> > Is the walk to the RP needed, or would refreshing only the immediate parent
> > would be enough ?
> > If it's the former case, we can cut more cost for non-VF devices too.
> 
> Refreshing the immediate parent looks enough to me. A device is only
> visible once the link to its parent's downstream port has trained, and
> the links further up were already read when the device directly below
> each of them was added. The link speed in pci_bus is handled that way
> too: it is read when the bus is added and updated on link events
> (retrain, bandwidth notification, hotplug), not on every child add.
> 
> I don't have a system with a CXL switch to test that change on, so I
> have kept v2 to the VF case.
> 
> Joshua

Ok, makes sense, thanks for clarifying this, I guess I'll work on this myself.
I'll cc you then.

Best regards,
Richard Cheng.

