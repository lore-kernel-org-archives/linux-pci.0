Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010023.outbound.protection.outlook.com [52.101.201.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F2EA25783A;
	Wed, 28 Jan 2026 17:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769621972; cv=fail; b=Zc8nnEnZD2FJb37YFuPJfBZ1g4gwUakqLZTllvunyCjGnYI071Ku08myGlE/SfTZ6GRHQwN0Cotl6Fe+yPHfNYh1TZXWh/WTdanEA166reTwadMsk3776cpur1cJEqA2f6p7nohYYkrCDoqWvRu4QfGT5Wu5L3V/+cQCVhHBSxk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769621972; c=relaxed/simple;
	bh=8apGEbE0GNNlWVWr579aTOoOIJ9lGpeOeY4kkP0QDaM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WbfoX9XK5voZNsbFQZ45i1+nDH2d6XJgeKPbUcwcB2AAy0IZNGs7ScSaXyPrWMzbldIAmhYlpgMOuTePkL9LOxPpIu+BcX3vAxCuK3A9iHprBHNy+o/BKJfOtp3NdtENFbWZSocQrBQX3au9CGKj2dnKK3D0/vaIJ1RcK4PB+S0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WoWmUGKk; arc=fail smtp.client-ip=52.101.201.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WoWmUGKk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D+I7YRs2Z4qEjcO962jS2p5fk7K9BkVu9BwNP3afc4eO2DLaPoWLQ0slzrF/aI4DmDjvNFWSWbJDpUQIbFmpw826l02Px7dIM0DcrcWpKcYhsB7VfZyziVL4dUrlDEYZ78CQDATzP1gEimoVojasoJ0mm4REShEyiH0f1ToPqkEYzJ+cP00PO6cyzdYbTUFn14J0sqld0b2qwpGavtpfB9RAwH8h/jqnH1pEq5Y0KznWyTFIbRiwKwCIJ29LDqmS7v77agK384fxXsKNhN81IE+ceNnPx9TmdvMO0EURVo6zL/1p0gRAymIi54rWxAVOqGzCWai1asv3vflEoG6krA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xCCSjM5lFIlEoWij0rP8vf4+B/NeKxUMG1R1dn6JHCk=;
 b=bciTI/y4QOetEfAl8nJBJoDGPpVaZfamlm4RTNk5vUdEB6PmdUjCdfGYbSvV5g5kowGm9GqXKf48Lxkl98z/z2zMXP0XFE5yXLs1eSJy5IdFWQai7LCTTqpNM0GaU08Q6s2cLDCxqUfbVB1gpM6pNeQVRENrVJix/U6dJOQAdWYqLRd8cBe4LILzf4f1iRsQcyWdGGsy14Cz9/H7/OU9496gn3rPPSkybXRZhjmmZEfc36fhjc35aiB8xK6WqonMJ7xJQ4N9w0OIAjKuJ3xdxGLZMgaOV3Pm7n8Pay8XkqDRAUHHaCSlRU+k7isymjB4YZOjvxs5Pfe+bAD/3qwFpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xCCSjM5lFIlEoWij0rP8vf4+B/NeKxUMG1R1dn6JHCk=;
 b=WoWmUGKkqSrQy0NgbtVwMae/M3YsteSysDEiSNk7CdjP45Lou3mxk/eulQkevjbefBykaUBbMpF+qd90xGyfjOJfdgMvcMc/FrSxQFw0Csr4qgl1I/FsJorYA4qZqxcWyFhmAkWT/COhT3RyOtfSPeI7+JPW5kBoW/P9tbv35s3j+HOW+6j+A7Ar0H7jXsnNslWbhO0ntu9XaBRY4/wbPyS5QpMQzBI3tDjEnSVKWa0+uj/xZUHsdqvB0lajM+jba5hDJbVCFTYMii8ku0rqRCAA9wVdAfdREvr+HMMEWm56sw9dahHSy5zHiG/HcQNyCk1VkoEQ2SQmYXrt9axDWA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CH2PR12MB4198.namprd12.prod.outlook.com (2603:10b6:610:7e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.8; Wed, 28 Jan
 2026 17:39:24 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9542.015; Wed, 28 Jan 2026
 17:39:24 +0000
Date: Wed, 28 Jan 2026 13:39:23 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Zhi Wang <zhiw@nvidia.com>
Cc: Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	aliceryhl@google.com, bhelgaas@google.com, kwilczynski@kernel.org,
	ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com,
	gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org,
	a.hindborg@kernel.org, tmgross@umich.edu, markus.probst@posteo.de,
	helgaas@kernel.org, cjia@nvidia.com, smitra@nvidia.com,
	ankita@nvidia.com, aniketa@nvidia.com, kwankhede@nvidia.com,
	targupta@nvidia.com, acourbot@nvidia.com, joelagnelf@nvidia.com,
	jhubbard@nvidia.com, zhiwang@kernel.org,
	daniel.almeida@collabora.com
Subject: Re: [PATCH v2 1/2] rust: introduce abstractions for fwctlg
Message-ID: <20260128173923.GA2223369@nvidia.com>
References: <DFZN5P8G6MQG.2DYXNFSRIL450@kernel.org>
 <20260128000410.GT1134360@nvidia.com>
 <DFZTU4ZFFCM0.3N8LJ8XBN3DF@kernel.org>
 <20260128132029.GX1134360@nvidia.com>
 <DG09ZUY530SW.K62KDIT4LIXN@kernel.org>
 <20260128145906.GZ1134360@nvidia.com>
 <DG0CABK2DQE8.1TDN35GOJ0DYI@kernel.org>
 <20260128155646.GB1134360@nvidia.com>
 <DG0D9I9P5BO9.6Q9H2BQN5AWU@kernel.org>
 <20260128193011.3294f41e.zhiw@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260128193011.3294f41e.zhiw@nvidia.com>
X-ClientProxiedBy: BL1PR13CA0365.namprd13.prod.outlook.com
 (2603:10b6:208:2c0::10) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CH2PR12MB4198:EE_
X-MS-Office365-Filtering-Correlation-Id: 37085ac4-2006-4667-9527-08de5e942d63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?f8Oopr6b7YUla5iDt2MKotb8Ep4VcCeZ2hDa9aUuxkZRY+akYv3Usi1eFu/y?=
 =?us-ascii?Q?sYmKF4XN6VMJRwsRnyt880T98c1KYuRsX0vbGtJnP4J7Ib8KlpIe+089jAqE?=
 =?us-ascii?Q?rkcMrMHsPzjAW5Gqe9BqDCvdMdF5PgoDGkaQcrhAEKGaL7glYSQqbDxYk5Cd?=
 =?us-ascii?Q?Ndnb/YKyymM/tCfBGSRX3MWDvTeCbYQ1wNYZ5QeTUbzE6McuFEo6zWf9e8Pl?=
 =?us-ascii?Q?XM4P4QdMVHbQ3ZsnWq66VG/wVnM++K+SkxbA55scj5mMNDsMeZfvaoSkgf19?=
 =?us-ascii?Q?KRRhlEPjzChAG6qgFTVIoYEClKg7qZ27v8lOEWpxKWvEteYFiD6DiERYwR3z?=
 =?us-ascii?Q?d4QpdcZP8YtzdJBbflNGjRvSn2hFosvT3b4oqWCo1PTGDKSlHAd3eU3aeXFP?=
 =?us-ascii?Q?Ce4vBaqWdY5M9vyELJmoCEX760gBGEiQQu8W3Ap1nAhNo9cj7kGOuDjCSiAY?=
 =?us-ascii?Q?CQCSLkEs/6Tf3SdNUOHet9MHoFTCMOx3uijy33jCvOCzSPo4mV6ZklhJ8mvQ?=
 =?us-ascii?Q?gIyvfDNTTepvadr6Y0jMluiZUrNMQbuRbzmV+p8gakWlLxpRVOuUPHBgJ8RQ?=
 =?us-ascii?Q?jl+qlmwkWeHQUdwSmQjvJuYs2aUvJ7NICJs8Pf5Se1qnI5C1tX74+Y3AydLs?=
 =?us-ascii?Q?MIXowthBwKeMKxEIUTNpUMgC/FQ8tHl8vegFNRVri6jj54HysaslnVGNCmHP?=
 =?us-ascii?Q?tPT80CBbqSsnF8o+9mM+sXJf4RhXzKrDX/rOmFNmqIli815scNl2eOtUunoG?=
 =?us-ascii?Q?jyDMcg4SBk+dW6VaMIlWosohAbKbGaxBURY291Db1KxIBtg9kD2GTdXPDKns?=
 =?us-ascii?Q?rcWckHPqAi4DTueb/Ya++AgiUuA/H1m4K52y6QjS/PICSH158USoo6mWSXL7?=
 =?us-ascii?Q?HCq/hwv+c5GkvS0ZHlecH3xFFCUju6bJ7xIsnMFeIHCsyMK3xfJMLZKrn42b?=
 =?us-ascii?Q?ZKtdJFYcmW3hlF+J6hny3JzclBqwVAWjVdRxbot4m34R/PGT/pKmDiPKOtxI?=
 =?us-ascii?Q?9uFAc+XsurZi8HlQFh16ivz0EHXuhX7Z0AHTG1VO8S4A9eYTrBURJzIa87GF?=
 =?us-ascii?Q?Y03MFOcQ2NhHZep64LgAq4HyZn6KJXZ8NmqRt03Ia00IMGihhuBWFSwbm6x+?=
 =?us-ascii?Q?ZBEnDrHRFC/n/80NAsBVsewrFnLu3LVgwrDek2km4/ddBowHjlnKa/YPTOgM?=
 =?us-ascii?Q?nu2Qf8YTYCjBbm96XAHylMJjVXwdzQ/Tw3t2Ic/5pd2ydOvQHotgaXtcCRfX?=
 =?us-ascii?Q?SUI7wbbU877CSW3dsJHE70EbllzCnbkranajPB1KYDpl/1rjs1xoSoE19Lo5?=
 =?us-ascii?Q?pF348o+gLPCa5V+GMsG/Vv4ygndzV1dkM2uuZzxE4IFZ5jW4I7uxuiuu03XB?=
 =?us-ascii?Q?1rsWJ9Y5Tm1fZSnrkrkRgWBS/6nANQr4WdvyoHrK4P00kCYvpiWEtAFVP/Z9?=
 =?us-ascii?Q?Z7n9vB73ZpsUNxcRNDe0d+Y3hNHb8HV+TRy74U453OhdBZd0/m4He7GgPdrI?=
 =?us-ascii?Q?ldpIbWmt+L5QtA2ZmdX3elEuhX5StWTQMLuqlIdrm+MRTe3o4fTc5CeYHTUk?=
 =?us-ascii?Q?jBGrFOaTneM3aMPfeNQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?M6PucjKgtCJ2Nl5NF9YU7Ez3KfmT0ttVp6YE6UKQxJTIT9wpeDyJZjpO59Z6?=
 =?us-ascii?Q?8W1U1JI2X7hiM5vTO6PlQZH+Lp89dKYxwkr7wHcjJSI1g7T6zyBXzASnO1KS?=
 =?us-ascii?Q?4IHQrDMjEu/uSl10/2FRxbkLwOq1mBYXj5UIYaU/17/9uV71xfF9xQIAsan3?=
 =?us-ascii?Q?mdeuzKDCyWq8YIaFFocxF9ZeykKkRKxiGlSgdVljjaZ2wHci3bnboAFqqAJa?=
 =?us-ascii?Q?TO637sjJkTZbwKO7IAdNYmMUyjQ/ZJHuoG/4K+wjjJZs0aUN0DgOlYvYiyRs?=
 =?us-ascii?Q?6A1kYC8AwFC77IyfGANA4LmYmioB3aRinh9Zn671+9a2nfPIkNRE/+y1yni2?=
 =?us-ascii?Q?vrqCc54SGqwGbtEa5Weh9bYbL4we5M1P/CYiz8ntOP5xgD0V8StMRiEZD5zJ?=
 =?us-ascii?Q?r0q2ELFaebSbADOpEC+ZjhwgifR8mMlJewYDZFrjtf2gYq65HaBTcvE2Suap?=
 =?us-ascii?Q?jLn4EtoeVw/zRoW0NCHpsJ9tTCeOhxCdXhporaV3K+D/xcudgMges+0ItdWp?=
 =?us-ascii?Q?r3Oo+d1etstuiyAdaBcfyIHhm3wIIevZne9QjvP5n21d4L5rRlkl2j8P6szP?=
 =?us-ascii?Q?IJcRUZbJj/VN7x5BGoQDTEM2zxplrzJhTRNJZblPHoxrTg83C5TXuD8aWxvT?=
 =?us-ascii?Q?cA/h0poOVXv9n6b2JPsNhsVxhLMecvLRRaxCjvIfq2wa6W9afK3O4aX6M4ro?=
 =?us-ascii?Q?oQRYrD35xDUSzpE0zQ/zgpTMwSzr8FAgLq2WHsfsnTeByZFGlveMTCpImsQ3?=
 =?us-ascii?Q?CW7aNozdHe4rPtxltU4zwuC+p8pfgjDW/55U3VYZeWVDAWQv/9C7jHs5afm3?=
 =?us-ascii?Q?ftOOn2InSfvTt0jkrrlvuxV6HbMgvqAUubNFtvorYYKGJ2sVk6o1g5Dl3mM9?=
 =?us-ascii?Q?W994BtzWdW08fnXXmUvth6KgsafZCH9RKtpuqTnLsjSVEizEyo1mcpP19Zmt?=
 =?us-ascii?Q?f7lw95ElrKDxn9CgWN2RZEkFwdm++EsZJ+qAbDttA3cR947by4zxY0GQTN6H?=
 =?us-ascii?Q?0zLLFE2wWJFrxHlTy1Pt7pWYUnULso49ZE3zt8UEnCDKoclWBkcWZ6FmhjID?=
 =?us-ascii?Q?WZLvTo6k6oXpweFAsIJIzXsRgeEptdNuR51kgDD2Uekip3wYkGGinS4JTsg4?=
 =?us-ascii?Q?UC9zxqUZijXdZWPCVliBGSI+hmC9E7RqRRl14SyGo87Qb8w+5gPCsztbfuUj?=
 =?us-ascii?Q?veljcmZDO83UjoMj/T2LJQjWE+yTrDmss5ik7YEHYrU4ACPGRh3EuTWOa2Q/?=
 =?us-ascii?Q?MG5gsrTi1HIca6tepvNDUh7tBlOae67i7MAd2651cMYHIn9jzPJV31qqPAtO?=
 =?us-ascii?Q?sUpuWfkFcARYdqAVmN48lWrtH0d+x0m5Fkn9/1MC4AikoyAUcx0XdecpNCcA?=
 =?us-ascii?Q?19iJg7n0SnwMF2t00iq0h8Y2gTdRdmfmkl3csHCZjmGyMV0t0NFzfZqTtEFv?=
 =?us-ascii?Q?zi5f0gKp7kQcOs3gIQ0ti4+iaCuiAkVLCbQT4kaE6eFLWWXJ170kOY/qI/cT?=
 =?us-ascii?Q?Rrr6vSQjkR5E3MZYxCMN40Czh/5ldHTkckfh10oENC9eW6JuKNjTsoQQvVbo?=
 =?us-ascii?Q?0vhGpxMvDST0CSPBKPz9gAFqBy2imBpJhQ6YRu6dDFE5/bm7OzR2fuVYc4TG?=
 =?us-ascii?Q?ahxG20T0d07OM7PkYlXAhpqdaSbNRmACjyl6HNeqSdCzpTyy33BfyDFUDikR?=
 =?us-ascii?Q?klaQGW7AnazC6hTZsvT4n5RCg+ujeGwDFxKM3ZCWDHf5/QsU/cVEvgv0qsWj?=
 =?us-ascii?Q?K5qnsPp4GA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37085ac4-2006-4667-9527-08de5e942d63
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 17:39:24.4312
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wXk1f1xKGFp1dt2JwUFhprcpZRzAyzgldkaBcp+bOhDAWyfQkKF1AlVhP3lfT78M
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4198

On Wed, Jan 28, 2026 at 07:30:11PM +0200, Zhi Wang wrote:
> On Wed, 28 Jan 2026 17:35:04 +0100
> "Danilo Krummrich" <dakr@kernel.org> wrote:
> 
> > On Wed Jan 28, 2026 at 4:56 PM CET, Jason Gunthorpe wrote:
> > > On Wed, Jan 28, 2026 at 04:49:07PM +0100, Danilo Krummrich wrote:
> 
> snip
> 
> > > Or is it needed to add the typestate?
> > 
> > This is something we should consider when a fwctl::Device would have
> > different states it can be in, where calling certain methods of a
> > fwctl::Device is only valid for a certain state and would cause
> > undefined behavior if called from the wrong state.
> 
> Are you saying we should define typestate like Device<Bound/Core> also for
> fwctl device? I haven't thought about this and some design consideration
> would be helpful, as the rust PCI subsystem has it, while some of other
> abstractions don't have it. I could start to picture about this if this
> is necessary.

I think it is not necessary right now

Jason
