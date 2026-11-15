Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794784792;
	b=luP8zJOJigGdZUkxuRweZZJWDCwdXdT4rsqShO6jDQkagQsZrgAVjGyN0WjgBpbrpbuj
	 MSDudYsOtwCc7ymFcuL84q6WVJheSlHp+8/OriUtCp99GZdVk7x9gGp3plkqyk6QQLjKV
	 aPcMik+prOUuxguaMpprG5bvDKCiay60rFW9hDsDsGwbSQwUEX8cEqv2B/LrL9SqAkQ7z
	 lVggEZfmPHmDZ4N/sm+CGJ41R6YgltSgLoCUMhueQIzOBr0GSFEY24az+y/whz2YmC9EU
	 LkOJXVYgmO0o+idmJTcH9UefeAcyOYrvOOdZLiwIbxUjLUwIrLVqaiIziVlOfuZAsAA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794784792;
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
	bh=CQDshkWrg2xvNz/o9nwO/xdioRBlLozjNnhWFG+VzNk=;
	b=pmJIeiNwHmlIOWAoboPaKGsbKAGbTk7NJridMvGYFkloQYTYjYjhKn9HKipsm4pdP+0Y
	 3HNEfGYYRayafVD1b/ILsRJ6G+NwoXhlX6AGZ1V4FRcelV9z3Xkooszwm2EaauJKluKYC
	 xtGmn/UApStVOEC83kNKj39lOqZcbSE1pA+zlaDL3KyhY1TBbJtAZ1pSP9UZ+CkHoldPk
	 VPybVoJ2ASusfg7Hy4YtrTRhFBYXbAGGdSaj8dFheEZxrAKiguXBx9No+LBxBCZTNm/2D
	 /woH7sT1GY6lkzvRYJQPokJ21YoUyPgcAAvA1iA9BOaPWlKpfMvSKJya68gYqvodavw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=iJZ083kd;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.42
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010042.outbound.protection.outlook.com [52.101.201.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B1CF606A329;
	Sun, 15 Nov 2026 23:19:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9B1CF606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=iJZ083kd
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=duOmq+LlxK3TsfSnL6dSXdMU297qCynlYz/tJp8hyDUPZopXQ3s7jrpMehozjaiiYDxdsvhG6WAKXppxzowYZgZ8yHIGw/Biys8RDGFKwDIdvG7chsGdQXnxO/ct5RxQgwL0W96xJ/q34OVXkWfet4OJqvT9ESy5CWKqZ3N6PZqMsXRhHjpLh9GuHPU0JYJU3FeFkpKvTvGNC8IoV8VFKyMTvCrEzyX7YrnYzKMcoBSNQ/4xHVaj5ctu6H5SBgmrkleI8Dfp9AFwX50adVMIx8FtnsRj4arpzkrNcd8oQDTC+wnwFBxqsb/wSINRAddoxe7lo19QkOIEioLyu2Zb2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CQDshkWrg2xvNz/o9nwO/xdioRBlLozjNnhWFG+VzNk=;
 b=Ngc5uROCvndur3MGkIFfo2Pas5gllgczZ342/tUqMORXI3vGAeHaInkIDl6o7C20LYFmAeYjDeCzcnOlTIYFAvTSXlBWjGk/vrC/zYPmZOBuE5tLStQ39YRiC0M1bM1e3m5ZlgHysEpJOWekLcP6eHaBlHVl/XDgU2hlwaOjTlqnsZS17uXqxYYahYpnT1w6KRmUb84WNVfUQq8F4jtLP5WAtvQFyPplN9HRhFKdbaYgoHqLVQAZMsbL+8u5Um0G5ct6jp87fU16E/hJBWZZIeIrw2T0ZeoyZuDQLyTVNWfwTX5awsp7KX/01h3UutA+uq5ycdWIUzBohWLlj4gd4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CQDshkWrg2xvNz/o9nwO/xdioRBlLozjNnhWFG+VzNk=;
 b=iJZ083kdPg3DmuOocSvrM7LKl0tX1zLjWkQ6IL4ztMliEcLTeZTsPpMfKBCNu7mi1wdajQ8F5Hspku/a4nZ5NpzwwzUvvwvzsQwZt0nf0l0E9uij6cKSZeIK5YKLCGOf4PuDo6vhSRFb7CQv/E1P36wQRk5r9cwoCWIfPw8fMI1UVF+Vomwo5l4cQokd9uK5FX+8dt/UFylYXHmxZWsM7fSBulZ03mC6V8b4YrBDed0XVU6aGdZoZhPavJyuutj7EmGv1072xJneLiUHTt+zJ8CYPfsiI/a37UZOdIv4Ze6QZLKA/vcq1Hn7WY+LIjIqaCfju7SdmsBaQcHhrtjy8w==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12) by IA1PR12MB8358.namprd12.prod.outlook.com
 (2603:10b6:208:3fa::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Sun, 15 Nov
 2026 23:19:48 +0000
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d]) by CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d%6]) with mapi id 15.21.0615.013; Sun, 15 Nov 2026
 23:19:48 +0000
Date: Sun, 15 Nov 2026 19:19:46 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: David Matlack <dmatlack@google.com>
Cc: Alex Mastro <amastro@fb.com>, dri-devel@lists.freedesktop.org,
	iommu@lists.linux.dev, kvm@vger.kernel.org,
	linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-media@vger.kernel.org,
	linux-pci@vger.kernel.org, Alex Williamson <alex@shazbot.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	Josh Hilke <jrhilke@google.com>, Kevin Tian <kevin.tian@intel.com>,
	Leon Romanovsky <leon@kernel.org>,
	Logan Gunthorpe <logang@deltatee.com>, Matt Evans <mattev@meta.com>,
	Matt Evans <matt@ozlabs.org>, Mina Almasry <almasrymina@google.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Shuah Khan <shuah@kernel.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Vipin Sharma <vipinsh@google.com>
Subject: Re: [RFC PATCH 0/7] vfio: selftests: Add peer-to-peer DMA selftest
Message-ID: <20261115231946.GB1239159@nvidia.com>
References: <20261111192411.4133780-1-dmatlack@google.com>
 <avYjFfqr3T/U7lvn@devgpu015.cco6.facebook.com>
 <DMTK99TDM9AM.SAM3Z4COP9WS@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DMTK99TDM9AM.SAM3Z4COP9WS@google.com>
X-ClientProxiedBy: BLAPR03CA0018.namprd03.prod.outlook.com
 (2603:10b6:208:32b::23) To CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12)
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
X-MS-TrafficTypeDiagnostic: CHBPR12MB731189:EE_|IA1PR12MB8358:EE_
X-MS-Office365-Filtering-Correlation-Id: 4eddf9d5-5adb-4301-bf32-08df436ef103
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|366016|1800799024|10067099003|4143699003|11063799006|56012099006|261026121527099003|261026140227099003|261028144727099003|261022105027099003|261021121427099003|261102123227099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	JhoFb36PtIVj6z9C5Z9MR2yO0VVQY4W8/nlnRoG3Hd6/YO4TthKII04UMCIhST/o6PhO6gh3qpj51r8hSFQNp/GcQNsCDSEzv1FoTenTq5GkYrK9m207tBqYZMqWouRzUiyQMzvW/FYtB+8fppaYsR0Lxde2bWHxy4m0v3wti0WTaqz0hXZAsJYmynQMGkEQwa5KH/w2c0p9EC2yQFjoviW8cJzyIq7KhAKfrFBJ/X7ANdeev7BKttLunVFkXEuLZNTtN1pCSmw72iKd2eIJ1FLLoVW26Tiwk9sQSwOnLiHYqP8DwIuPHPd9ZalineUvRZDVCNqxsMm9sY6gzHW+pS3Q1w2xAUO4IPTjHs0cWyaO9bMY0DVPoOTpM0/xInn/GlRgnHYHmlJ0PgR9a8NDBsiFZfbUhTVxZm73FtX09J+36HFccEmOYTdtED0oBThGncojGRponkI20gxkU6M/R8zKD6G1bXQsBxnaSxcNBVQB9o459uducknCD5pKt6Zb/nxmtpiUYk/nljWu+P4Pt4yHXj43zey4qZzFbYHp7TYFgs77RMH+KHO4aM/JVkLKqH19EcRQDOGKg/4BjrRiaNIFZvAog3cPtSVH5jc64z3WQjmmfoCPGdU7cOTltxJDpkn4/6ucPvUAlDIh9SMVxndq3b/y7lIYW/6DJuT7QJo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CHBPR12MB731189.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(366016)(1800799024)(10067099003)(4143699003)(11063799006)(56012099006)(261026121527099003)(261026140227099003)(261028144727099003)(261022105027099003)(261021121427099003)(261102123227099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jqEiX6U4/Xm4mu1KaGqLjqmancI01nlcuh7jGbAmM7zJzQpz56eFzE/CwL+/?=
 =?us-ascii?Q?LXZvEl9xpN7wTRMAbxfzOwC5LoRT6lvLhujDCxev3CIOFFYnFMW5kahDgr7n?=
 =?us-ascii?Q?gUpO6VrWnpyMzES2PjN3cqREqB9721J+g697M/bmU4cil0C5AQbBU4qvz4xh?=
 =?us-ascii?Q?wRR2cAGNjzr1SXfFMh/ud3LPKasmIXzA2TzfZm8Z6CW7iKe871iCEM1aLxEL?=
 =?us-ascii?Q?rmxIyTKRK4gvKa6XBhZigxjnP4GCrsiWv1FAKclQ8yr52FS5ByZvm7o2sxeh?=
 =?us-ascii?Q?FJeOaEv57JhuR47oRa3iQpqJbt9TEPu2jD3jpwgEvtwfvL8QVUDmPbWRB7/Y?=
 =?us-ascii?Q?LPTr+fr0X/pj9u7U7sca1uZHMqmS4W/8KUgaYhXsM56rhSTm5TtgnuH+zDH4?=
 =?us-ascii?Q?XKyO9sbTqra+pC+re3zNPY/+nbu/iC9xwN2gc+xo2IcOS8s+u4XfuEB2UCww?=
 =?us-ascii?Q?EMFUAOnTVynPTra2YizigW3t3SfWyi+idbDIZpP7bkyKsDQMJKqIC7OfABAy?=
 =?us-ascii?Q?DaxkulFNa4bln11coaPHHjQmzCx/gA8z9eRxpJLqdath0YgQK9iZtcHWwVAv?=
 =?us-ascii?Q?Ef1dfQRDGdwhsRVfIM4eoiNbT87B9Gsaq5j2kxxtw5OPa8eqenYM7HUqGBuh?=
 =?us-ascii?Q?nZ3c/7kWMgZinKTBqwP4S2nAFhxOyPHpCtVcarmKyfzZb6rhkLjUVyJ2TPjM?=
 =?us-ascii?Q?zoSw2Yk+Zi7PTXVlGhaCb8XsCPo6bPxQKJQjTrPxfJ5szSQq61Zug3PabaVc?=
 =?us-ascii?Q?57MQ+EFcded415dFCGi8BD8F9RSljng2RO//3X7FhpTNevp5NGzS0lZj0v4+?=
 =?us-ascii?Q?HksCl4McfHlCszIova1zrFP3wGzD03h/FChYRUhlWF+Nohj43hz/hhL29gSY?=
 =?us-ascii?Q?dwV/Sd0tt7zU/IwOCOqhZYovwemyFxFr4kaqePHyXCt8pW0hLtcmL3LmyaxN?=
 =?us-ascii?Q?muAWrCUEnQNCfVnvThx3ULfFpWU97z7G2VNYnDL1DKRTgZFtec8XMGootZaf?=
 =?us-ascii?Q?/i/Re4muqiECYD3lBVKKrUnHzdXQblHNs43hB210+3TpLpp/jjxbZuXekB5Z?=
 =?us-ascii?Q?x2pF3epAVZ2kwORSkg2l9mGg9FkP3JiiFQRMazZWU+Bpkt1NIoIL9HTna02l?=
 =?us-ascii?Q?9rSnJBoJIV2Et0I4kuSGffDPXfAwNUt9Ie2vrPICW9Kt/6ea9XDV5prrLm/W?=
 =?us-ascii?Q?OiW58OP+df8PmNZFV7XItDbeYs7AS/zZdOeCckRyzXjxyZRy516JvT9YZJqY?=
 =?us-ascii?Q?WzysKlM0UJyp6RLNUFy6YRXBa6J4sz3V5bXBwRxvkXA34uRDDQ7JdMjKtPns?=
 =?us-ascii?Q?N+cnQTY0zO+654ib8VFXvzOn7C9MbVXFcStjVA0Toqt1gV3FxQDcNdaQel2s?=
 =?us-ascii?Q?PvibBwtkeCyJZmCN1qRB+PxK2Hq1meWpTQtrpFuFiITeXPlaZyWpGPq62m1y?=
 =?us-ascii?Q?dXO3jmDpbrBjK1T7PXlbk3MAUmwZL88Vk+pzqcvJH+w7IGKnMRwZ8gbnyQyY?=
 =?us-ascii?Q?IMnOqWleeompnUWMw+NAI7eRfbgrmL2vgGX9YQIDEOymfWqPd6ETyghYzN+O?=
 =?us-ascii?Q?M5xGogtkhXBj0RAheE3C80btPJ3iGOkdlBxviIglOY27p1CmPMGAQUJ8eZer?=
 =?us-ascii?Q?U3JvLVf1UwMsoTl7TMWo0DjBmB6CLLSNp8BhdJ0ti56XhlAeDTnCIDkYv3IA?=
 =?us-ascii?Q?CaFhJrbwft8dSk8G/eJmx/uBJKDRJ4iG7qjP86nL1U8ZQRTH?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4eddf9d5-5adb-4301-bf32-08df436ef103
X-MS-Exchange-CrossTenant-AuthSource: CHBPR12MB731189.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2026 23:19:47.9915
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KsF86QSTiQr8xbwXdlEQZqAN7rPK08z2vrxIZK8Sl0lSReqlU1KMnqRx64EIksMu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8358

On Thu, Nov 12, 2026 at 01:47:03PM -0800, David Matlack wrote:
> On Thu Nov 12, 2026 at 12:35 PM PST, Alex Mastro wrote:
> > Hey David,
> >
> > On Wed, Nov 11, 2026 at 07:24:04PM +0000, David Matlack wrote:
> >  
> >>     Is requiring userspace to re-issue IOMMU_IOAS_MAP_FILE the expected
> >>     uAPI behavior?

Yes. Even if we wanted to the locking is doesn't allow trying to do it
automatically.

> The way I designed the P2P selftest support requires 2 things:
> 
>  (A) initiator: A device that has a VFIO selftests driver.
>  (B) target: A device that can provide a memory BAR (vfio_pci_find_mem_bar()).
> 
> So far I haven't found a single device that can do both. But you are
> right that theoretically a single device could satisfy both
> requirements.

mlx5 can do both

Jason
