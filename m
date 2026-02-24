Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010031.outbound.protection.outlook.com [52.101.201.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1187C39E198;
	Tue, 24 Feb 2026 14:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771944670; cv=fail; b=NNA6qnkD3LyUJhA0wydt1Epv3c7UwDhFYloVICaYNaDsNz6JJv9evBDw6TkDOzWyJoKh7KaL3+DxRf8ywq+ommMMU/9zbZ8jfwg5S+bW6Xj6WzF/CgCVLzMz1SIsruyZZTnedmsjlEmaacL9ED6fzYYwoClnL50dNn/4yE13MmU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771944670; c=relaxed/simple;
	bh=dHMjZ2x/sjPk0VuHIk0IDQUOZpe1HCT5ozpylIYm/bg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TCqOFXa8qwLugPas5zry3lm0UR+3td7b1eKE/E7VfBC3dmAyui8JNsYJc45sT95ap+v3iV7XOgF/6K0rQ0AAPWQMfPKeiLMvvnjZEpsB2eKkXbkRzkxbQ5AcZKt4yBcZZzI/uM1gZQJKZmRrUdycW4xOM3XQFko91X4z5bXJfv0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PiU/Uv/X; arc=fail smtp.client-ip=52.101.201.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PiU/Uv/X"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n2aM/MjBKD705bgueQdlYERjQYB3Wl15+dMUNGyGdtlaZ3NFmdEqNKSPnXQQouCbhOaM+9ojUBMt4KhYTnOPRf7QOvVrA0DBJUZsp02I5BIV8A2xmOvZ7anAMjgpjQKifc4jusbB01nzERIKJMmxuXWeZwJn1fN2jAc46OakbWhI3aBvQ+dBRu1Yg70vLGyzaogbbKVxEgr2+7nQZL9VmV8dDrbmsSu9x6aTrMEGbnmPdIwt7bAAj0f3xn3K7r01xsWxvQsAZ2sso9JxBCapiyE02v/Cr2MabVmqgz2gWFlxX5KAUnRSb+OmlC68ciCKI17F5IGeFhz3Ju8wRNUARg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=URVR2eb0JVB2lQYqB2FL0otjvF3QOQrY0QfKjC870ak=;
 b=SAtA8/xyH5l6jAQGXNVZiLo+OlY11U+yuJSHhip57RwDK/hG3KFxJtUGg4/Z/LruOt8UlhYZyrCOQ2cc7tkeyRg6CeG35GSjmNZpi+9NdIoSIXZytX1C55Gchcuxahx7LWTw+k8l3s7a8yJnIGI+K59Py8gDfwQvJFeTL0Jdzod7cOkqCeCkRyiQCnKy56bRlALSxp3peaEIZx6H146yImWnkQ0QzUJwjhh5Bn0tHggl73pbtUqtpyt/1+NaticoP30i57bbzfiA1dK8XotQY+S65FVzjRuTQZ6oJEW7u9PZlIurgYSZSN9+9a0/TOVXmtE3e4xryRE0flRWt7UCFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=URVR2eb0JVB2lQYqB2FL0otjvF3QOQrY0QfKjC870ak=;
 b=PiU/Uv/XhLwNFyAJJbpisMX9+oU9O506RkKJrp8AkWDqhwOzcmzItVom6WnbzPXJoQ8e92OLydA+OPSZDbQIEQBUMJN6TXdI3VcjC9FVSHcSsSqzjXisiYMDWLKNYQbbXsX481sVI4FFTvt1wVwSQFmFV/fPnQvpJr8BTcUJ6K569a6winkE7nFenaOFnbnpMPDrQaIQcJclGeGXADYlndlKSnbdkBoXG3/FZfnmXm2QxAwe/YTOxdvVXK52oP6kKDKKoTylKxlXZ8gmuzMTSrheziPZQM7GAl/9Z+4TI1kVkUPhjbSnPCCpaLz7Zfaoko4cLvES1VCDrHSWmRsLJg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by MN6PR12MB8543.namprd12.prod.outlook.com (2603:10b6:208:47b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Tue, 24 Feb
 2026 14:51:03 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9632.017; Tue, 24 Feb 2026
 14:51:03 +0000
Date: Tue, 24 Feb 2026 10:51:02 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, will@kernel.org,
	robin.murphy@arm.com, bhelgaas@google.com, joro@8bytes.org,
	praan@google.com, baolu.lu@linux.intel.com, kevin.tian@intel.com,
	miko.lenczewski@arm.com, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, dan.j.williams@intel.com
Subject: Re: [PATCH v2 3/3] iommu/arm-smmu-v3: Allow ATS to be always on
Message-ID: <aZ261odHq5gwQYXg@nvidia.com>
References: <cover.1771886695.git.nicolinc@nvidia.com>
 <bdeebd35e81cfa5f76d16706a775b23ee1f01fdd.1771886695.git.nicolinc@nvidia.com>
 <20260224120615.00003ad9@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260224120615.00003ad9@huawei.com>
X-ClientProxiedBy: YQBPR0101CA0120.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:5::23) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|MN6PR12MB8543:EE_
X-MS-Office365-Filtering-Correlation-Id: 034f7a0f-acf9-4a2a-d746-08de73b4220e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nI9s1PAQca9Pu3LozJY7m3AalOC3Ay9KaSVZ5ImHuAuw7l8+9D+peifI/2BR?=
 =?us-ascii?Q?pql1VnWzifobrKJiYd7JJljJnwftgC8ByLGabXryj9poab2qFkuLGZ41vHVi?=
 =?us-ascii?Q?smPZeXpqqaZIu02Fadw6ttTCdEQOVbt1qZZ0fwwXiKTeyVnpryjCuFV21Dxn?=
 =?us-ascii?Q?rl4PkgNEbS5jD62iTuOaNouG5kdUU8+NQ6weBagxQCAK1AenybX7u/y78PP9?=
 =?us-ascii?Q?KtnYhw5uPRJYJu2LsvWxo7aVYcdzMDyse/ndKAK4rv50p59FzYqGiQqncESF?=
 =?us-ascii?Q?rOwAyFs+AXdpZpCsVamdBD4UsFwCGt0JRWQ9udcXpQn1CyqGqvRbWSx5lOwF?=
 =?us-ascii?Q?cRiG6HLB6ebj1zojKvewEPTy/NWOPNrM3+gqHdW8zKlLy6lr7qTSxlXsJWgn?=
 =?us-ascii?Q?tbS3vteKV3NkOgx1zFtHne5Eq5NHEiuDcsZZhA4eXDjFJCYygdtusc0fW6lQ?=
 =?us-ascii?Q?quHBanSZtU8k92mVep+cgMLc3Lz/01XI+MKhmqzhP0O7D33tq7mzVhw3wez9?=
 =?us-ascii?Q?fO0+ed2Jav2bK3dscY02vu2FZ+HpnNBsADsoygTqgVfzbWI0oQSbVCFOFSNR?=
 =?us-ascii?Q?GUGFGTbgODFeFw4WIrv0zvqC0Rdr/Mp+V9g9LqN0yNFgx7O1VF5ib2Uu+JdZ?=
 =?us-ascii?Q?p2gXJ8WhRNn4OIBMdQkQy6K9fVvISxZLmP/d0XsgQlMcMahy9z2MG5SZ09uT?=
 =?us-ascii?Q?/zuCmCntRpLJqEzmu8AHrBcgAkwLmW4TUvgHKl0xNWtTO37S0SF8fSAioMP/?=
 =?us-ascii?Q?Ni4Rxk8gAsO08ufDGhaKUbDzMfQiClcj5VhRSGD/ib8wiOv6Csb+T54LNvzO?=
 =?us-ascii?Q?vaE4H3EoD1/AVenb90z/1UDBVc1/dk3LGOm5O6obC/LNfxY+ykiQBbNmrCUg?=
 =?us-ascii?Q?saPfvCGv5YSq2X62nsQNMfDMo4tLf1mKek/HwKKy5J5dVmuVa9n7Huip5ZzM?=
 =?us-ascii?Q?7J6c//ZyDIsbBI1fzJ6SMLuU7rXXdfQGyCBAJa50TF4nSHvLf3MjQkaObRNW?=
 =?us-ascii?Q?cBRDsLepPqTvo0dRK7J0EOU0hEzdp+W6fEnafcGxAy5cHVVTU9aomCh+zq+V?=
 =?us-ascii?Q?a70GJ2v8C0pMIellQN75igdKMaEJAOU9lAwD8Y3DoH6HcdJv+brj1mIsrA3A?=
 =?us-ascii?Q?ajjNaxXAfvRS4xUJDs8skfTSC25k6Ru4L4mocomPzqFlnOEI5mxkb1qAOARs?=
 =?us-ascii?Q?sqXts8AjugCh59sYbJbBv4Zjzb8uCr2PGiVRYX2tEVIQWlb1pN/lz/I43E08?=
 =?us-ascii?Q?qMNf+cLvyKmAs/7phoXtarU9zpDf7c72jGrkOLDw0MKOm7a0hxJm2OFHmjsT?=
 =?us-ascii?Q?1JIloEEBF201r1Vkj+d8HnezkcA0PH/YwdquQv6eHPVoIn5L+b2gLMOl+Pu0?=
 =?us-ascii?Q?e32QtBlTcmVvprAZOyGE6/XvrIyzFoFT6/Z7fCsyzg0HIxhe4twy5Yjh3pBw?=
 =?us-ascii?Q?b5ZZ3fFtLZoQkAGbirOJ2XXkceKn9CpOUYF+99ymA39FjcAc1WQKHG3KUnHV?=
 =?us-ascii?Q?9qGpdHdI92Ux394cbI1qrrAgvyr11tFHpHKAKqwx38lsIy0g9mWPxWejxy2T?=
 =?us-ascii?Q?IkQirv9X+RXm0s+pCQ4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TXPXha2KV/XqFzqOFwBfxzW628dnjy3QSNctvw5Ql1TD87Be+g8BVTpXl8a5?=
 =?us-ascii?Q?c6IqnwlYEEFC0L+2AF5UzUBVXsgfVmC/qgWflKClJhP8P0TiLkhQQftJ7FUg?=
 =?us-ascii?Q?UWzMJHZzHPvo6vDhhRMLxxsgrq334q/fOFsEwdmRcGyeyv5Gl/s+8OrIl325?=
 =?us-ascii?Q?zRMo/8G3H5kOnCY50GhE6kJlSXLNlwNuGwyb5onv/ZXlm0f3fQCn3EOcRJgP?=
 =?us-ascii?Q?Wp9DinUEqM09CAz1HdWj616bc7WC/jgtnDteYPcnUyQdGb4zWh5tX/zl1wUj?=
 =?us-ascii?Q?RbKMf80Sk+a9dyuW1tne/PYPM0TbSJd1k6mmcIAyPs0gYrpP/3FmtJUYSvHO?=
 =?us-ascii?Q?ImtvsGfr+/OFhhD9CakOQhkYI5tGeQ3VK9PgIYlBMShP8PeukHQ61vodAmkG?=
 =?us-ascii?Q?A4NnrDAAGymBG7B1DM3t84ro0gyCHND2vciGEdOnmfmaQ30r+F2giBVZd9rr?=
 =?us-ascii?Q?WnnXRexwoSLJrqRqUqCseZS5AGDqn80SlRk8qV3gZDpWOtXL5w8eyyEsaGRT?=
 =?us-ascii?Q?spztgMUsi4D74FhfYaBhn/wHeYrr9eckFV5E7gk3Z0m1YZ3CrGSwQaFapSyl?=
 =?us-ascii?Q?rB+IzuhLD5ON6e6rU/maqxyU8e1oLTFFIlKmRuR48dPl1gVh0w6Ba/keCQHF?=
 =?us-ascii?Q?wp/MHwK7UnYLITqy7QShzSsmE/HpaHtK+lsgoE8tQ//GPC2c4V55XNFWPEfV?=
 =?us-ascii?Q?tyzMYrvd989bpKej4tWmfBz13PpuTR0NkR2ZEAAXQhVg6sBe1Pd1Hml/9BLe?=
 =?us-ascii?Q?MXyZL4m+b2f8qm4T9kQnCXh6YKbzC8G3O/338jXjUn33Sit5VxAnH1x5lYJY?=
 =?us-ascii?Q?67CNgtn3m1Anu4fWkSJHPv1jG7+iXgfVbuLCplePKqy/TYwXG/atIMxyGLGB?=
 =?us-ascii?Q?Y32GAEgynj9o7RQjT/odl4LCChgKStRcox3tEhaChg6fNJf8zZ7wkd2jTbMY?=
 =?us-ascii?Q?YmkHeY39JL4n8JzTedGmGL0EvLiPu33vNfJYAfZuq1ZjGyIXtlHLbH+il5uI?=
 =?us-ascii?Q?pfdIqCy/R9uFcLysb4ycSWct9CvMNU/w42tEb6jOoRl0nUkT9zKtB868K9yh?=
 =?us-ascii?Q?ruy3vxuqFhqQrsubrs6W+0RrJOBB2eBTSvCExZZKfNz47Qdlsc85df4lkaCy?=
 =?us-ascii?Q?elEDWpMnGbqPuQ22EVwek04ixRkv/KqhJNfq49ICf22UlAbOJPCON1KU0sJr?=
 =?us-ascii?Q?8OSxsnV3TGQdbB7fpvfR3tIOOI7b8el2VF8MxQc9ZBQIR8X+qD3m7i6H1swc?=
 =?us-ascii?Q?4x7I24dUPxBdNJpPzVpFi+fnarqng9wjuuAFVmVn2joQgLARzWAlOVPF3Ma9?=
 =?us-ascii?Q?VLYjZ95I98IwPAivwfes6JU9d1+0l0URftu/eh5sFUbXMCdAOS55yVlsY/ew?=
 =?us-ascii?Q?ZmiVPCi7RUtHLY0kFC7WJFK3nnGsDrTY1PzhQbzH7xMaFuSqUttKSOteKSyi?=
 =?us-ascii?Q?UrndGwlnmJYrxdjDzTiNYzs2ZCHnXNQoy8XFd0X874xWb/iwM4DqDSFUrw+C?=
 =?us-ascii?Q?0D7T/+kC9bm71B68WrZCUt2uJr2c5Jywd4VBxSxqHpqLfpAaFFi5dTKkNCC3?=
 =?us-ascii?Q?xgQAP8TwHMxQua6zbzbB1rFJJmwFgIKiNlineKRty6JVHK8dX5H0IopxRLUQ?=
 =?us-ascii?Q?Q7NPAO/SbpRMIz+/QibYyLccHsWHjR4tqRtRafE+43kRsfnLg/5WsL8ojxm5?=
 =?us-ascii?Q?SasozTLWgMd9rA/a6buIabju9Dv6eXMOam536j6e87ufKPI8xZvOgkP57Iy3?=
 =?us-ascii?Q?6YBnoK6MXA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 034f7a0f-acf9-4a2a-d746-08de73b4220e
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 14:51:03.7966
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rjhx/SQMokLGzuu6Y1QS79j0opOt9mbdDsG3Ezvl6v4b8fJEADPbdcT/g8a9ARzM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8543

On Tue, Feb 24, 2026 at 12:06:15PM +0000, Jonathan Cameron wrote:

> In my head at least, it would be nice if a driver had to explicitly opt in
> to this behavior. The presence of CXL.cache support for instance doesn't
> actually mean the driver is going to enable it.  However it is probably
> harmless so lets go with this as path of least resistance.

That same remark applies to ATS in general, we have no idea if the
device is going to use it when turned on or not..

Generally Linux has taken the approach of almost always enabling ATS
if the device offers the PCIe capability.

The purpose of this series is to close of the few "almost" cases so it
is always on.

Jason
