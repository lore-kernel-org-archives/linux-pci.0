Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013059.outbound.protection.outlook.com [40.107.201.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7440F49CF23;
	Mon, 21 Sep 2026 13:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789996941; cv=fail; b=aBWElYBUkKxi2D8uaHvrQN5K9CX+cQ//2hNF4AwbLFsL8pwEkKdrtkHPy7f4vCaIenV4+CByHHi0Ew7ZEtXuDACyldfdKJo6es4eKR1J+MA+BdPvLIPIhzgbBAJYeltkdjttQ1hYr4GeWRHTpmjp6/rH9LEYmjlPFsrI+2SJJ8c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789996941; c=relaxed/simple;
	bh=TfpkoRB/npy1EU+v09lXGscw8Z15Lh0P6hFuNuTJFbI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pEIoiI27l4rBuHUtoiYdAarr8knbrz9nRyhSSXlNB3LymGKS46DDlAQUd4WwBG9yThbxT/s+tV8MRkZyBUJxR8hKe7a8T1wa0Bp2V2co7hDz0aNwU7/sJh8GWcMEQyhbf+xN5mSSVukhHW0ikRIe72nKHTleiofd6V91U24wbBc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=J+C0MHsf; arc=fail smtp.client-ip=40.107.201.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="J+C0MHsf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bfFh45LQSV/TG8V2mAd8TepcLEfeAiZS2JQp6Gx24uQmLlgp5C4olded5L059t/BRWXxmIZnSdO6YeiAWhieZSoFvJLalqgx9hB7YZkl//nfbt7ZiqP067P73oMvccTfai47envexpmEZ2/eU9ZqHfdRCYQ0ZizpuX42Z1xuXXyeG9H63wMbbIdOq2qLG6ZWeZvusXNA3DuTMNPPmyongl5iBOVGnkqr+g08+CSrcDg2u+/f6AFwMYeMk3AHqzdW+SBkWymabCdaiTSxq+Z9PT8bJdu+OMqlX149TFIZPBnWmUiAChA0lItXtJkKoQpnasNlQ4YgIPVKphuERVyMag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZZ8IAe0dgRPsOfrvFdgsI8QF+bvxn4P2m1c3OjPc/4k=;
 b=hl/X3gS0Poh7UBzuRhvHXInQEzeNhb8MpJRu1GVZyPdnqM7ytHIA7IjFmYiy7J3uAlN2zCYnzGv5OmRnYx8kC6P9QqcRRqbEiTngnooiJ7xgf8rpkOYS/kbIROKCD79Gmj4J0MGx4CnsxbaVHhEN+HN7pRE7Bpo5EWDmzOKm88RjB0A3AfF/fYX5EF3+/NveBLYCQJnkC3Is04laQsBqW4lx8kFCHeYPKMZGcB10j6xel+ERwURTKZXqLucj/abd/6vGmP2ahcnYiVZrmEJZaqcg2LDwtF1qTF2iJxM0buVhSVtdmzuWm/u58JHmBrZYV/7LRm5X/Y0Qf/odNIqaSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZZ8IAe0dgRPsOfrvFdgsI8QF+bvxn4P2m1c3OjPc/4k=;
 b=J+C0MHsfO1vhVh/lKqA+GgY0AbktYZcBHQkyQw1gcNE6CLT9APKyPdkwxM8m/6cFk+hW0cC/qooe+a4NprDWySroN9l9puHVvR+Wh7OzE/xWK9Wt57JeXGucvrsCHouXkCjORkf+nTFHIr5kkHvdD0t4fMmvCcK3ULzlHOjsos1UK9/Ak2ol6bjn3m6R3I0GGxjTBABl//LIlydtKRXN4CP352NWmhEAUt/+OkMMIVyMY5WAPqmcm9NJ3jCP8PHNnD9RXSDsl6rNg0uGmWupc9oyZAbxsdUqI8YF2qrorMJhI0XP5FoSQx2WMPAeF5tmh3k3XihlASCttsAEEzmfTw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12) by BL4PR12MB9536.namprd12.prod.outlook.com
 (2603:10b6:208:590::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 13:22:09 +0000
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d]) by CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d%6]) with mapi id 15.21.0428.015; Mon, 21 Sep 2026
 13:22:09 +0000
Date: Mon, 21 Sep 2026 10:22:08 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Matt Evans <matt@ozlabs.org>
Cc: Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	Leon Romanovsky <leon@kernel.org>,
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
Message-ID: <20260921132208.GA1507824@nvidia.com>
References: <20260911214200.33793-10-matt@ozlabs.org>
 <20260913165244.GW13683@unreal>
 <20260914113647.GL3968357@nvidia.com>
 <20260914115456.GY13683@unreal>
 <f21c409d-5675-4c87-8b16-850bcb9474df@ozlabs.org>
 <20260915072002.GD13683@unreal>
 <cebfef6a-88c6-4753-a0a4-87445a72f885@amd.com>
 <db61e755-73ce-4dd8-94fc-e7287db963d3@ozlabs.org>
 <0fdfe19e-f8ef-47ff-aa99-66adbc524728@amd.com>
 <23a0ea30-c6dc-4b8c-a0a1-89e9f912bf37@ozlabs.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23a0ea30-c6dc-4b8c-a0a1-89e9f912bf37@ozlabs.org>
X-ClientProxiedBy: BL1P223CA0027.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:2c4::32) To CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CHBPR12MB731189:EE_|BL4PR12MB9536:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e66d3e3-6cf2-4879-0fb9-08df17e35706
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|7416014|376014|10067099003|56012099006|11063799006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	hgatWZio0IrdPHflRKDpb2YZuNGhQyw1VgsbnNKxnNIC0ZdQ4l9hyKjggEXb+J2icGHlXxxHXXLPJvpU/XG5DkvrxyGjDPYrsQmhhRBeW5zPPCTF+q50hhoEzgsgEHcKB+9bVS9nPsJKEmLeqWfw/WPTYUiLMaABEv99f0YwQIyHMz9ydCA3E2+vPbEYdR0VO4F2jNspFEaMfvNeVLsiS1NTwQYNoxhIO5OtLgv6iJXzmp2gTqjaXV9eO+6ul8lVe+N8YmGNGgF5rUHGx8DcXx+p/FnwQwmmIj/RIlEZCKIEGfxLDZ0ZuIyFiyN6PfKc+ruyNCQLuuBORyW3csHrGl2bor2mE/g6LD4Aa9h+jz0fclBUbljYo/CKUUzZRNJBxvY1cs/ES37SKZHj3kja3xkHyR4onlTKFEvAZ4Hynz6K9/b7op2qD2jB2fJIp1haRy6KYn1SCTPjh3IV0byVBIAnNLZjEQ1o1Zi3Y3ZU08yj6TNswdVj2x1DF6VgqF1faeazPTSAJ0MKUf+jFF6QNTsMtxKuvcTAeIeHhZ3+PF3p+b4n0tb3EEGEuLt4+saXBzGIINQ1v8297AWiwOKriHPN6XZ8Su0vKS7CCVVqzwcFhIbIf0GwuwinCphfAushuXo0USPBgz7dalv7CR11HU9f2Qd8lcEDzUHybZe6f7s=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CHBPR12MB731189.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(7416014)(376014)(10067099003)(56012099006)(11063799006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ptOcSKYHybIeOxFzxm6vawnzp4sNlFbNPIPoFt2+qO1QSiIDy+QetZ9YiX+A?=
 =?us-ascii?Q?HmYOvEXsmtHE31eUGY966PgB6+Qv6VxT8p7md+LYul0EVvrskM1XchLWAn+v?=
 =?us-ascii?Q?62XBEMhK5ct/8qaZ9XJSgamhVp/xLpOfIoXW1FpFnPX+/2XJoRuTWhjSKT9T?=
 =?us-ascii?Q?kNta9z78l0BNn/xo8hQSjH2wNzYGoGSS8oQEqaJ3gnOWSqie8Q/55PE3Ag4l?=
 =?us-ascii?Q?TJTcNTPvQpeG1odrMzRIhIl03g1fWIDHW+oe8BytqQJ3pa9nebF7yCJ7USua?=
 =?us-ascii?Q?XiL+XBwXHExtHuMaA5DWef5+T6TDuLh/eKyiar9Ij/Gdaa4Xo6mIQuSPzn5D?=
 =?us-ascii?Q?AId+ChdRAvp3I6C1CBzVCom+pKKYXeR6qI40TsH1i5+gj/gsgp/4ci/bt56z?=
 =?us-ascii?Q?teRTsDxvdNVEg0iZw3B8a6qU3bFqqeZFQcp+6ajW493rZCcLKW3L4jLR3Ib0?=
 =?us-ascii?Q?ygo7ismlFaeJS26GqvFW7bhPtQ2GL5y4WySUcufomxHdwWg/dOIxvii4z1OA?=
 =?us-ascii?Q?EVaxkyk1GQjFpgo/5s8okYY1ExsIJt2ifUURjp+OT0QgTfMpJNncsPZZ0qJk?=
 =?us-ascii?Q?L1boil3d8TyGs79ahL/Bz0knZHu1pb6lBdbtrOdrqMLAfHY8LJjGyTCE5h23?=
 =?us-ascii?Q?0eHpox3AmITBBZ1K/BqDzzavPAJdvbg51EKDOGaDW+Hz7JvTw72exRzpIVf3?=
 =?us-ascii?Q?GRQjazdo/Jxqq69Jxsx+sC+rHhZenOzmJ0z97w0YPuawuYYUkGG7f0HvGMQ7?=
 =?us-ascii?Q?1Z/CwDEqmxLDKrUkwWW5HqzhTU+utNuZHGGjw5rOaaGd+ioLTuhVviPf0bu8?=
 =?us-ascii?Q?gwfvxitAw+F3LxfE4kYX1/3NgBiAbTea3ig8UC/g92/5I+ED8MpmiKciwvdz?=
 =?us-ascii?Q?5hswa2NNDOZu3/rTtipTHzE49Lf7vLOyP3RwGIIf+PmKj/bcU3ciTgzdBEWc?=
 =?us-ascii?Q?m5W8FEfkqdfdijU9MslRGorTt2H7UmNWkbM+g7iWjD0tbhwa270vcM4rc+V3?=
 =?us-ascii?Q?vOVFfLSZlnTmoBxMY+ijnbz0P0IT2kxLCdCcdU9ua3SbZ+AujFWZV8CiXZjw?=
 =?us-ascii?Q?imFjVuC6kcGnDgXYYrozleYg/eBiOWyuZTze2YG2/stguJ3PsITN4t/9hoRT?=
 =?us-ascii?Q?vj1FMTMm189KCBpM7aDeWz24cRDIKdPg209SxyadgHUOXesY5v3HnwRjHbBM?=
 =?us-ascii?Q?Ed2vFcelbqLGQFwLvjfDyZdOlH602U0SX0L8J8f8d/4Ee4TbCpuKQoFFuL9P?=
 =?us-ascii?Q?O7u241RsY+wcs2nTKvWMB+FvWFlZYHW2UbWRa6lv7Isa2+8kIQ3CyB1oIH14?=
 =?us-ascii?Q?Bicx1xr2npfSMdYOLUhrwWg/vlh3RgpA9cLGD+O2u1az9nCwsCTL5z+b/WZy?=
 =?us-ascii?Q?bGNMADHziL/O1F9lgfGakzhvoX0sgWTIvNSonga8yBasYECPCi+Fn4inQ7Gf?=
 =?us-ascii?Q?rorhKle8Ei6KMFQfwZj0U2NBq+I28mePXTUfze0UgVeUv7DDXRl1yiuOWam+?=
 =?us-ascii?Q?DKyaLtDk+kce4fsAsCpxWdGwFRz7HM+kkX8bJdys7QWclABTcmSQwsoh6gWJ?=
 =?us-ascii?Q?apwVwEMGv8tDhk+wTDOg9TGDDK0hzkNJ1uc69WblUyUmIEAQm/9tKNM9IzOF?=
 =?us-ascii?Q?X4evL/AP6d6RQMkupsrJvxK38pJbpWkjQ4JAK+TUGVJXZOqw8aqM1hxkWz1U?=
 =?us-ascii?Q?KnlgJ/XLGgBUawFvd67k/Qmp4/wVvM0lptc+OWnC6lUFYQR+?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e66d3e3-6cf2-4879-0fb9-08df17e35706
X-MS-Exchange-CrossTenant-AuthSource: CHBPR12MB731189.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 13:22:09.6033
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eFTg/pXhDSQ6v9MK+ofYJRfxvMfOvIXDSCaNO3/4T96C2TG54JitTLr1wcWy7G9u
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9536

On Mon, Sep 21, 2026 at 02:08:47PM +0100, Matt Evans wrote:

> Not quite; the priv->revoked flag tracks temporary periods of
> inaccessibility.  An example is VFIO resetting a function; the BAR
> mappings as seen by the CPU and DMABUFs made from the BARs are all made
> inaccessible before the reset, and made accessible again after the
> reset.

From the importer perspective this is a permanent revoke.

The right way to view this flow is VFIO permanently revokes the DMABUF
FD. Then instead of forcing a new FD to be obtained it replaces the
existing FD with a working one.

From an importer perspective it sees the revoke happen and then that's
it, the dmabuf never does anything further. The importer has to unmap
and start from scratch, get a FD and map it.

That VFIO re-used the FD to make a new live export isn't visible to
the importer at all.

I think that is where this "temporary revoke" language gets confusing.

Call it "VFIO reuses the FD to create a new live mapping" is clearer
than calling it "temporarily revoke" which sounds too much like move.

Jason
