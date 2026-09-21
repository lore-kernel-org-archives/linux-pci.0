Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012066.outbound.protection.outlook.com [40.107.209.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07DAD262FD0;
	Mon, 21 Sep 2026 13:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789998570; cv=fail; b=h2GSwHW3sx2+uc3GH+i+bG2IattGdrHpPzZQlXbtN8eiTNUWqqg8Qdstux2k4p+qXgtdL3QhVl1yjg2mRuAVZvZs+KLVHomc9VI12Qqb4jKL7gtJFD5KHrkA/qBDFGHvbQPr2Zsg9s9K6lwqCTjQKZZQax5o1pAVopk5uPvSGOs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789998570; c=relaxed/simple;
	bh=+O+mQpf7WWKgVnn8C3N+w9AP2bDc+TwIVLzhoFU85hg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=T88oDx2S+4tX+41EegS/B44NE5zCAOcbpz/BsdLN35lRxK1EzruqYE9PE2GzZ+F4AciNmBg9pKy5FMtf2J5RUI0khs/+fencKrg/hw5KoKVaE8SlWRppnL2MmLhtYFBrxhuSjaSqaXg5War3O7POO7208IVfX6U7eF67+2fg8MQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tXOe3cEX; arc=fail smtp.client-ip=40.107.209.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tXOe3cEX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OpUYw/UChdX8/57lpFPuXqInxEwiN18hjIkUfLargLwXXuOsz9TctmCffK+wJpbi6DQNEgiEtB+wWpnx8iPxDxR5Lj43hB5/XNKJ+pidzJkWAWNvRpY2M9B5Tf/kpmMCRd7YPozIDra/etQVoc4M6LqH2Zcb2eQrQeumlhnq6OP+lQDXLdgQNNFX4ouZJBR2Y1U8G63z8M8RgCtu0ICz2NEF9HFyeyhSp3X0xpnCwZjnWkKF59iL85hfAgmjhABmofJrI9RrcxFHr4JizzG/mhJ7zT87xJ7zLp1z8mdbIZMn90C+FYe6wCcGM4BMqoVYmjT1ttmd7RIPzhPFzVeMng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/qLjRc0/14EL6+dH1oO5oELmGUj70+onMtdo/22Th44=;
 b=l2B2HIAaR25jHECtGPs3qz9GZngr5m9J3MOCeEFW4g0fMeW7HmXlUIrLSgKlG/BAmuLt/a0hKGoHq1Nrjzmx5o21W4XjvJJvfCpCfGxTQO1hLGWzysnuklBIQOZRSrq8MyTWI6q7hJ7R9Xtc5+oEH9Rs4vq7fxm/PQzBmPxHQJD9W1OngAiRiIXka5PPLd7WNA+TufPqMKZ1iBWVExXNvVDeORjJe5GR6X4yXFN40rSQwxV88kpdlbB4GfS0zlAgsmoLu4+g/mB2ABBgmnULXtscKpLR0FBNVo+aeq9k7mLjHhG4YiqpTzvfPz+SRzG2+Ab8fQONwTY2Sb5CuYC48g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/qLjRc0/14EL6+dH1oO5oELmGUj70+onMtdo/22Th44=;
 b=tXOe3cEX83GLIh8XIjqLj9ItOGAk1B/EXY3ZD4cadG/HH5PX4M36dCdtdrH/FTfsLXn1auVSe52NHG7u6ANQXa043DBSXEmeYy8Tzcc5BbpHW60Jd9X63gHcKjPpMOie9GXVjkt8qNuflGjoWvO8CmfEbK+tdCOgyqDQFw4FpctPbJ6gz5BAVVm0eCZDjFhWUxHVZkTXPh8ntHmq/Sc/jd7UiK1gpf85toI4WvAAaKnRs0Frz2JFb6KyaMg8LiKPi2oWWCfl06X3tLQZvzpygKdRXMjjZllWQvGrTnYGmTJnKpC5CI+76BwMG5dNsRUiiihsgDg6JXUkBJotEsDZKA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12) by PH7PR12MB6719.namprd12.prod.outlook.com
 (2603:10b6:510:1b2::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Mon, 21 Sep
 2026 13:49:25 +0000
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d]) by CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d%6]) with mapi id 15.21.0428.015; Mon, 21 Sep 2026
 13:49:25 +0000
Date: Mon, 21 Sep 2026 10:49:24 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
Cc: Matt Evans <matt@ozlabs.org>, Leon Romanovsky <leon@kernel.org>,
	Alex Williamson <alex@shazbot.org>, Alex Mastro <amastro@fb.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Pranjal Shrivastava <praan@google.com>,
	Longfang Liu <liulongfang@huawei.com>,
	Mahmoud Adam <mngyadam@amazon.de>,
	David Matlack <dmatlack@google.com>,
	=?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Ankit Agrawal <ankita@nvidia.com>,
	Alistair Popple <apopple@nvidia.com>,
	Vivek Kasireddy <vivek.kasireddy@intel.com>,
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
	kvm@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v6 9/9] vfio/pci: Permanently revoke a DMABUF on request
Message-ID: <20260921134924.GB1507824@nvidia.com>
References: <20260914113647.GL3968357@nvidia.com>
 <20260914115456.GY13683@unreal>
 <f21c409d-5675-4c87-8b16-850bcb9474df@ozlabs.org>
 <20260915072002.GD13683@unreal>
 <cebfef6a-88c6-4753-a0a4-87445a72f885@amd.com>
 <db61e755-73ce-4dd8-94fc-e7287db963d3@ozlabs.org>
 <0fdfe19e-f8ef-47ff-aa99-66adbc524728@amd.com>
 <23a0ea30-c6dc-4b8c-a0a1-89e9f912bf37@ozlabs.org>
 <20260921132208.GA1507824@nvidia.com>
 <fa5c7fd5-f24a-4ca1-89c3-9ccd9a728fb4@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fa5c7fd5-f24a-4ca1-89c3-9ccd9a728fb4@amd.com>
X-ClientProxiedBy: YT3PR01CA0114.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:85::31) To CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CHBPR12MB731189:EE_|PH7PR12MB6719:EE_
X-MS-Office365-Filtering-Correlation-Id: fc4f96b0-10ee-4224-5569-08df17e7260d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|7416014|376014|10067099003|11063799006|56012099006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	mfBWOZz0uoSEF5/K4Mdb2LVWokd/7t3kjUjpR/7zpEbVe8HBltIHnadNp6QZE/JCVXzn7A9A+3W+C66X7BGRq0XSpdsrFkKH7ntMl3kb2v9kYB+m/MVbzdUvjkxFzbAM1QbNtJurLG/w42kSQyD+ApmEYigTaAGnEAbmIqrQ68K43AZHfNBgDZfqlRyQCigkti3sYOHn/cFhc0KU1crI+uRfS28Se3caT1B5h/cKcyM6E/aNIJAU9XCvTcgLWMeaENwIPUbi7k4joUa0gwmH419C++BcI4Qcue1OByOCn+dPVUbgyBtqStWjL/wmdeoc8HeSN+aeD2mGiuR0RNzK4Jb5CWYn/hL6MQMPXNE6kBL9PwDct5CrDaLOCfOcEqYO+WwpTa0sZnHL5jUepxhbU1uasuR2axgdS6CtXMiKoxRZGHj3Jx6Xv1eaTrj/ky6Nl79ilDy2kG6I9Oxm8RA5bYdNxuq0y70egZhwJypan5EN65jUqBgcyEzRZ2s0sd8vgJuzkrWaL9Or28Qy95gRiEarn5T2K++F9xkobki/o8RKeDBGhgAx8aKjLa07Ndh5KbEKcx6t5YPV0O25sg/g28mMk/FfT/GvdBYzQpI+y8QKCdfPY5FtCP6XPqdtgJjGgGwGqbZrr/bK+XRBPtb5ajxpLNU6gbgsFTR7aF0s18c=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CHBPR12MB731189.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(7416014)(376014)(10067099003)(11063799006)(56012099006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UGtiWUYyNFFFTUNnMHFLU3puZ3BDRHpFQ01zak9mQnJQMllUdGwxTjBJT25Q?=
 =?utf-8?B?RURPd3hCY1FpTWlDUk5Ga3EzZzcyZFVlOUtCZVF0bXRxSGdZRUpCUmx0QUhU?=
 =?utf-8?B?b0gyai92bzFiSWRGYk9nTWxmajRvZzl6anMzSVJFQ3dsK2NhRkVXb3dTQVVo?=
 =?utf-8?B?VUc4MFY5UTNFZEJzTERyelA1RUovR3NySUhndlJTaFBqUkluRnVxRE9nMVlX?=
 =?utf-8?B?bVNVMDFtczZXd0QrTXljMVV3d0N1Nks0NE1sbTlyYS95ak1aRXN3Z2FxMUZ4?=
 =?utf-8?B?Sm5xQzlvdjhqUGp3amh1T2VzYUdZT3ZSb3MvUkxBUnFXWjF3MnY1SkxRTmpk?=
 =?utf-8?B?cWpvSG1yVUUySStwdkFGNWxuR0J3SWswdDQ1WEVRaktPUHI3RGtGRHFBZnlp?=
 =?utf-8?B?aVRwZ2FYeVNvRXlZOUFOZDBHbkJRcnNzOEFEVnlNWDk4cEJXUCtBdU5lNnpl?=
 =?utf-8?B?SG9VUkpkNk5iOU91L2pRM2daU3FKM0pib0k2MHVGRmJuRmZNMndld2diWmVH?=
 =?utf-8?B?SU41dEFVZS9JZTRCTFBVM2U2dVFxdEhIb3B0elZ3OVptTWdZeHJaYnBJMlFF?=
 =?utf-8?B?M2k1dEtQUTNXZys5SHYwN2h2czhpVVpyaWRoNVE5MDBkamp4bTRGV3BjRW5v?=
 =?utf-8?B?dUJzSzYvWHRacTRlZW5NcjNKd3dGN2tOd01uVE5lRXJQaWV1WEpwUk43ZTRy?=
 =?utf-8?B?OUsxKzVQdzRuOXZ1NzdBTWR2dEllZGVzK3ZPaHk5eGYyQjRoSlB2NHpnN3lL?=
 =?utf-8?B?OFQ4RjY3bnVEVlVXSS9Na1pPZDVhUGVOeDFMOTBFMEdUc09oK0dzVnF1dmZL?=
 =?utf-8?B?a2ZyR1docFkxck1MWkdyVkJvTzdkVE00Tlo2V0I0S3g3LysydWJESjJxMkFK?=
 =?utf-8?B?MTZrMEoxUnFVYm9QN1BNcGFFbnYyZW9KSVRXRTN2NTl6ZmIyb3VablFva1J1?=
 =?utf-8?B?dTRDaVlCOGR3bVNaU2YyNGxsUVhFR1Jldnlkd3FYM1J4UGZkWTVsbWFyVmE2?=
 =?utf-8?B?VXVpYmNwNW9DbGtoRlhNY2NrSmxXL3NIVnozY3doWnUxT1Nuck1DTExKWmJK?=
 =?utf-8?B?aktobVJwUHJ5ejFJejZVYklCNEFRNGpzYmROT0NlNE4xS3krQVVUQWxuNS9Z?=
 =?utf-8?B?cTh0RjRUenpNYUVvelNkbmZSN3IreEVFTGMzb0kyZFhQWGZEQW1UeVUvT3Ju?=
 =?utf-8?B?SDIwUkR5L1ErTTZ2RG5PTDZWOHMxejAwUGZ2bTN0aHZTeFo5K05Pam9YYTI5?=
 =?utf-8?B?MWR3Z1FSMGNVNkdKbkNGRTMvbTFYRnU5blc0cEJJRWlDaDBneXlGVklpbVlH?=
 =?utf-8?B?Kzh4QktIRG1uN3FGQURtTWlyMXlRYkU5S1FZQWJFcW5CVWtWMHFlb0J4TFJm?=
 =?utf-8?B?dkxjOVBTUE81ZVpxYjdGL0JCSDZDc2V3bFcyUnN3SE43NmFyTmtyS2w1aGQx?=
 =?utf-8?B?WXhuZ21iQlpEOGx0TlZpQlZEdDc5c1dzNU9uUzBoZHJ5ZUZvOVptZzkvYnAv?=
 =?utf-8?B?anVjdGhNdmlhTkhNaVpXNmZna3I4U2VQWXVSL0ZES0V1WTYxTzlwSlQ0M2dp?=
 =?utf-8?B?TlRpTTB4Wm1nNWFBc01BQzU5d1lEaHVUbjNMSytBQ25XbVNlZ0txMkNYVWtD?=
 =?utf-8?B?SUNocDFZWFZheHNUWHUzN093K1ZJQmxaV2tzYzJkRFhpTlIxb3RQL1VaK2w0?=
 =?utf-8?B?bytTVGpQaXZ3b0ZWR2RPMkNKSFNIbWJLUXBjYmt2akZEYXFvdUdIVGFQdk1N?=
 =?utf-8?B?QVloVVh4Z2p0SFlldFVtOTFSSnNnNFhMYW92dWhGYjBOWWJlbmJDKytpdk9B?=
 =?utf-8?B?RnlQRjlqNmZnZzJKQXEzUk9rRFpkMVArZ2UwRm54VXp6dlBxdzZZQzlPVU5v?=
 =?utf-8?B?TXFFcGd2eWlnaENkcnVCVzczSXlFWFBUSkpBMENvNzg1U3V3Z3JEZEQ5Umc4?=
 =?utf-8?B?aktMeDBLUkZBMWNwdmg4T0UydjhnYXk2MHVrMEhUYVUvU2gvYUVoQzZVNGtT?=
 =?utf-8?B?WHV6dUVLeWd4cCtUWWRJZk9OYjRSZjZYYlhMYkJHdUZLeWlidUkrUTU1cmJI?=
 =?utf-8?B?SlVhT0pQN2RvMGM0dTFNN2VSTnp0K2FOamhrNDBzQlMvMzBqc2k4RUlXQmkr?=
 =?utf-8?B?bm5reW8wVUsvNHlDdVRaTzhJOWZSaFBqbVNHVDk0ZXNCOXFOYXoyS3lmNkNR?=
 =?utf-8?B?ZGl1MFE3VEZWdTVkY1hNVWEraUIxN0lhMXZPdjF4eEtkaGxpT2hadFZkWVZy?=
 =?utf-8?B?VjdjSnVTWW1mUEtLVGY5OFhJNEFLdyswR3JORklEYUI2ZHZYamhWc21FQmVY?=
 =?utf-8?Q?CwkbEclI8urUtA6t0e?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc4f96b0-10ee-4224-5569-08df17e7260d
X-MS-Exchange-CrossTenant-AuthSource: CHBPR12MB731189.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 13:49:25.4141
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j7pQEgB7z4O2k2SYAGhUXNOirollT6xsilPYPtP6dHh2DRCXg+CL5aA/vnllMZ/+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6719

On Mon, Sep 21, 2026 at 03:45:28PM +0200, Christian König wrote:

> > The right way to view this flow is VFIO permanently revokes the DMABUF
> > FD. Then instead of forcing a new FD to be obtained it replaces the
> > existing FD with a working one.
> 
> Well that is a little bit problematic. It could result in a race
> when you have multiple importers.

This is all a "kernel protection" scheme for VFIO. VFIO userspace is
expected to have unmapped things and is not expected to do mappings
while also doing FLR.

The only kernel goal here is to maintain kernel integrity, not to have
well defined semantics for illegal racy userspace behavior.

So from that perspective the races are OK.

> > That VFIO re-used the FD to make a new live export isn't visible to
> > the importer at all.
> > 
> > I think that is where this "temporary revoke" language gets confusing.
> > 
> > Call it "VFIO reuses the FD to create a new live mapping" is clearer
> > than calling it "temporarily revoke" which sounds too much like move.
> 
> I would avoid that and just re-create the DMA-buf fd from
> scratch. The extra overhead is negligible and one way state
> transmissions are usually much easier to handle.

Yeah, maybe we should have done that. Might be too late now.

Jason
