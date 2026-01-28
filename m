Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012061.outbound.protection.outlook.com [52.101.43.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C44361DDF;
	Wed, 28 Jan 2026 14:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769612355; cv=fail; b=MYX5aC9czvegUSDgZ9CRwAyUCL5o66lUEG93o32N/xkyYiEy+YdUQUJzd7DgOklTy2oD25R/hna4+telwW2b5+tx7vNXRI6A6B5ovHaftJKWeWmltZxiPq0o/lzFWrVXsYYH3hJFs5IPOHx1toAg7Rxio0yPcwcl1YijzABV9t4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769612355; c=relaxed/simple;
	bh=xdCImewoo/iTSMJ2rFFctkcziC/mFygCHxbrMjH82ps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Qx74mmmJY3AH1zfwxjzYEykF94v8/1YkHBAFOikXsf6UZjWAT0x/IBLVkvuh7uI9/AZNgq+DH+9cRCOuPcIhmAYyQvHXnpSlx3VMnl+AewKXK/8jdqWwDknqMWrFbQnFqLUo2EMpEA2ekj7OF3xeebXyUVB2y0Nyq0QlOxc4a+s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=svmKzlhO; arc=fail smtp.client-ip=52.101.43.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="svmKzlhO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B7ntfzupkut9xYWQNg6p3h355xUsIdUCogqiw1kSRIKsm2euU9fAltJ91beAAB7waMpvt2iB7YcSU/YWNqJQ+KrmqU9DVru9AHVVEFdi6+Xj27hBL8f5mGQ8g6tjLzblzTQxQ8sKmJOOVKLkTAjVb/N0/lRUXL1k4m4+fYkptlpGo3AOo9PUKNctJ3TCod6Zhu7pttFXU9gp17z/LvcCjFWT6fDxZRskqsClJRqaao4wX2YbIL0cdDfhiWcv0hgKYVtFArB/FcZ3sYCPeMJ4NaRbfNkepWT0fUaD86GaPpD+IsafMLfA9FjhdNHgr5ZabStwzqBoo41XrOrWR3Zd8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SiSzgLlIFHwLmhCa8wS5kwNKKj8PVeYclFl2nK4RIVk=;
 b=gUxPNyYYeo9l906ung7+HBle0SCPw956w5QM8BjWVnbI+zkuTxnMIy5CSLT07V2aYyQzg8V0zZZWICd5rHtZX8HmAxUfp9RRpPjYyfJi+jxZEGgBzW/AS4pDuIjdD8/fLHVePrQrEGBznPQXRPobqkK5P1DYhsTk2RlhMtQd5Cnzj7o/xyAElRPQEPEUTFsQhQARuvUudzAsJLS/crukzya8V/iwugygUzlLEgzVq/YrpPa+qPTEVnSDL+SSnXAjNFUxLpEZj3JqWpg6nlodWTinD0/wryvrGfe7a7tdpWck3fC75Cb5FCBVjrERkuOZiPXITfFDodORNdJuueiruw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SiSzgLlIFHwLmhCa8wS5kwNKKj8PVeYclFl2nK4RIVk=;
 b=svmKzlhOYjCq+VvzgBgdLjHjTj6SR94e9xyk8klq6rHTU+uMSxMgZlOzDHESTcSHQwbM2jK45mHbe+KFr/MKT1McTOZ2C9LLepau6FZcJTpL8TLJ7TeHplgD4WScIWICF6sgcDVEkTsq5Lzi+oObDPDCsHZv/Q/UHjQ2eFYLCC0GnWA+AGWQ4tOg/gInOJDzgu6DPZmha7Y18h2+YpEqhQNqocX5ApchWaugIRLQkikdkcPbSvNPIkLbWPQaUYIFQvMBi0WtNvZIqcEUdJjkUGQvJzkZl/WscCqNIF0+9IscVlHfcAGEdy6NLUIdJScCL4ESh2eLxbdzecD6Hwi00Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by PH7PR12MB5925.namprd12.prod.outlook.com (2603:10b6:510:1d8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Wed, 28 Jan
 2026 14:59:07 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9542.015; Wed, 28 Jan 2026
 14:59:07 +0000
Date: Wed, 28 Jan 2026 10:59:06 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Zhi Wang <zhiw@nvidia.com>, rust-for-linux@vger.kernel.org,
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
Message-ID: <20260128145906.GZ1134360@nvidia.com>
References: <20260122204232.15988-1-zhiw@nvidia.com>
 <20260122204232.15988-2-zhiw@nvidia.com>
 <20260126181912.GA2131321@nvidia.com>
 <20260127215744.332380fe.zhiw@nvidia.com>
 <DFZN5P8G6MQG.2DYXNFSRIL450@kernel.org>
 <20260128000410.GT1134360@nvidia.com>
 <DFZTU4ZFFCM0.3N8LJ8XBN3DF@kernel.org>
 <20260128132029.GX1134360@nvidia.com>
 <DG09ZUY530SW.K62KDIT4LIXN@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DG09ZUY530SW.K62KDIT4LIXN@kernel.org>
X-ClientProxiedBy: IA1P220CA0021.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:464::14) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|PH7PR12MB5925:EE_
X-MS-Office365-Filtering-Correlation-Id: b94ab512-0897-4060-4f2d-08de5e7dc956
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2yvLZhii7W//FYYUoVbnNtGQ7hAsFmUTJV/fv7arKmZiWTwJC2Vm5ZQvpnDA?=
 =?us-ascii?Q?8iTT/fdJlewESY5/g+Pinh+of86KVGB/zMKYOPUxZfv3sB7Bfa8lwp/eAB1n?=
 =?us-ascii?Q?dOHTYexBRzt+7EuAgI3M6dNxfpyBoYGWfool6bU2skDIKub4M+K+UrhBZ7xT?=
 =?us-ascii?Q?s13sG2QBU9kov83iIkWsDpXOhjXIyK7zOrP6hxeo6PABlBAi+dj12X9M65/t?=
 =?us-ascii?Q?eFCR7pp+riurGhvo57waVscHytMi8JQR53bVsyueZDqtTKr+6rI0h8TG5+09?=
 =?us-ascii?Q?2L0jaFdJAOIQukP5uaipgFifVN2UcmMAGisUsl4e4B9eUqsM/x2HtucRYybm?=
 =?us-ascii?Q?fbYSzB6Vf7eb/9eYjVCZ2rSYiEbY8nM5kzr1Rs8maJj7IUZmV8PyLOigGAgK?=
 =?us-ascii?Q?HVxobC0La9uOo9Na5ZxEoYXSH8RGc8XBm0PK3Vd+Nch4MOY38DoZ9QBC1XXX?=
 =?us-ascii?Q?pdaj1JIIlRG+DF/cVt1zfUgWDsPKRYL79IugmfolSGBjoSlJaoASJYaOIFsx?=
 =?us-ascii?Q?+LKf0NAsNFflN32nEFgtUgeTKr4nKKBLT2JeKmY413qrY08hx6lGuzWs9KVR?=
 =?us-ascii?Q?I98AyDCzWJefsW+hpOfVl3Z3WCXwI5zvm0/NyQoOgOF1iPKNXx5QP0KFeEUv?=
 =?us-ascii?Q?p2bOIrifT/XwKb/zCEmm8rY8o7DIiZ2067lECYWD+8iEQQK8FJ84l6Fmjqx1?=
 =?us-ascii?Q?cCeC/I4dDUvtoNBj0AH+YL4vfrCfmq1BV5rLDd2hFVz8f8mQYqVUHJhuzE+x?=
 =?us-ascii?Q?0z0qlwTP4qiumORFGlbDOKVTT5qkrcLQpjaisG3yeMxD2ZVEBeiDa67ycHyb?=
 =?us-ascii?Q?QJfx5cDvdVUtR+qDqAzXb0VekjbKDpYvuGTXGFcpztCWwyPq1NN3EP88gbTJ?=
 =?us-ascii?Q?DVTohDIfyLMsl0a9pb8Se2EgS9OytrXRMJp7a87ulIZtBXuMhj4yS+YmmL9+?=
 =?us-ascii?Q?WFecbJ4mgM4YASFFx2nPNHa0VOBl2p6TT+WTlneURsOe1FzxNe7tsWEg3S3b?=
 =?us-ascii?Q?OtNUA46xUSAkC+7arzmWltVNEoEFHYl/f6vhmEMabJzaFUVeL97l+dgZ/VZO?=
 =?us-ascii?Q?+Fhrn4LOWyc3qr4paNHXoQfEvte7+wrzghGdpsEOQyOoFayS3MuZSj5nnx1n?=
 =?us-ascii?Q?Uu+ZEOWIeBSJbySwZfTCbhNMwzKH6GknOPScztkVVwLsf5nxcAPWzKla5MKU?=
 =?us-ascii?Q?cGNgUp5CnXWK5NODDhUgqPSYcAeaIHcg/cwaviGzWxFq5/dgj3DgNuoGzMde?=
 =?us-ascii?Q?xbDAa1wgmy7K+j/JsaEe/v2QK/LHHuVEXCje1wv5W6ZXpztF378b9+Ar4o1x?=
 =?us-ascii?Q?uI7/KlRb6uPWqJgKqtAGvWYLEVM3udsc60WVNTZ+tF8G52VSce1E7nnI17q0?=
 =?us-ascii?Q?Oy7GhkNUYwBVkR4LcgWVfcWX/vBnbG7UxNDtz7roQY52tZwCGh/oCqcB4bbj?=
 =?us-ascii?Q?s1B+KigUqlm8oWUjA1OHR+cqEl1wMJzrN+dcEwo3axKpldloxDGWtUK90PpX?=
 =?us-ascii?Q?fB41Oz/rEXE0q7MpxmDX4G3991rEqI/rc/hgpPWaKBzOz2tvdFScBvcpOJrO?=
 =?us-ascii?Q?HgCijXN81hJj/t+aiaU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?az6gIMFpgJT8mk+8iwFECNDuoy4WDYbk3LevkXeQI2U0rVjFRc8nvoADpZks?=
 =?us-ascii?Q?OVN/p+2Bz3v25xiUj2b2FAfRvhgd7Be0bBqA5TGg6dISnclOzh2l83D39t65?=
 =?us-ascii?Q?Yt5tqifJKYNYR/vwxotyfhWXaexO4Tt6T4gw4+q3dGZ4JNC7t0OkVtnd26GN?=
 =?us-ascii?Q?aSDTp3KvA195jVLeP9E4UciLTuSgchWtYPh9zw2sTRf3yqElBJnWB7smI+xj?=
 =?us-ascii?Q?ggIr3cGqzLYijkphzbpoAZWYPzVir0Zb2wMWWGpkZTb125BGW8QoC3JQI+Wv?=
 =?us-ascii?Q?RD59FqsRfPJbhGFVBHNtYc8OCTr07RBBea4uxxXxc7PeLAdpML/XyywZvHde?=
 =?us-ascii?Q?kMlaQeohgW7gCmU1lEXTYdQzX9JZUNeaWqqhBD0MvMa+xjpDXtPYgl0tgL1F?=
 =?us-ascii?Q?mOA1jQofVUa/mPptzbyhKJGHQJN+V3Sgw6h3UX4tO0empuxqihVNEfAhq1la?=
 =?us-ascii?Q?FOaxmp3TXC2+lxO1Ygp1P46a1d4zh0+BNZ8VfEoJo0RjvwPKpgpQ2yW5+Mkb?=
 =?us-ascii?Q?2xDK/C3iB9z5svEpmtTlDdkp7lP23EyROkd+tXE7IolSFgVdrUcrZMqDZXm/?=
 =?us-ascii?Q?bAb2t4xir/t4Zvu1l1uf6Eg3c8XS/Gxi9rRG5gVLkTeUo0vcx21mA9EdvPbN?=
 =?us-ascii?Q?HisHW87cPoOzXvMF+i3knbg6KMMvrOd1uPJJCK8DaUajjcdOUimWMOTm7oUE?=
 =?us-ascii?Q?0WRV/mmE36g9ja8QtVLYQogdpvWPOPJ5Gc5bt+KgdaRLrEA2nOs24oSnag9s?=
 =?us-ascii?Q?QYd7W+rfzf30dX6hUL4kTlovvxueRSdkIQJY54U5DDPNDoEvW6TbeAxMoriJ?=
 =?us-ascii?Q?X+dWol2mXLFK9xpQqdZ3WuycJkupcja3aALaxF/E3lp/YUdKD7zcCBulKnhp?=
 =?us-ascii?Q?GN6RVxw5HnC1N4fz3D5H1N8V3dDVW1m9Zfdl2P7Ut+KVRkSL27JZ6TXs+eFe?=
 =?us-ascii?Q?JQAMBk1mAu3t9+wEq+pgXUxrXJ01BrZQjbJIqBKYha46LdRRpwf+Ap3rg8+7?=
 =?us-ascii?Q?n5qL4o1Ehwgb0htjy05EJYTtsDybYYs9YuJl7rYf7pWzUfb71zFoEW1LvUBY?=
 =?us-ascii?Q?xUfWIFXH8Z0vfJvrcZnstm+yhQZ7MbaptXKyftbVXSnmOKLUcpeqrsVARCfF?=
 =?us-ascii?Q?kQR9w2i+SY/5jLqwP6miVXi9PJcJKFP5FaT8Pi0+Coi7yLjncfboEOmlJ2Ao?=
 =?us-ascii?Q?zlQ1wVzUwkbZvzAVpArJmV/7JrH4Qc69RODsDvTedJWibXMGvLH9Va3fyM1m?=
 =?us-ascii?Q?kdQvu6vLM9ED38LKqsXof+mHlhjqtBYPMgTrsdvkKwZ1Zx1/9gUd7L2AzcqX?=
 =?us-ascii?Q?0stSxhb4uUgLxTqSu1o8+zzu4NAC/dMeQBHbNwCt4gGcXPUoBRfXYd2eKOHh?=
 =?us-ascii?Q?Nrb2To/bpOU/+lZkzXVo4hm+eOfegZOTjzx4twSQBGyayWLSzmDvCf6NR4KG?=
 =?us-ascii?Q?Z/xzAqCWwSmGm+s+Db66cgDR0P3UTeNUayGX5ZvI8m+pb1He6dL2HtwNg6lF?=
 =?us-ascii?Q?hzq0/bcKNUKMhccsodvYlLtjXWBFzdWQBM81e8+2vqkSsQ3FMp0TAIqcDSLC?=
 =?us-ascii?Q?nnb1HuK/v+glm5wSO6A4G2MXYN/kH8vKCKBuvx6gWG2SyClPHXeNnCUC0FqK?=
 =?us-ascii?Q?FrrqMnPnRPw6QcaKZbOcKhAmI5T05B53y/RZE5YAj1m/N/jwjSihPHKMW7u2?=
 =?us-ascii?Q?Q5lnvilEo7cp0W/E9ymQudxs0FFF6muulsQpIT5tHIt+0eWfXlRFpyRFD0b1?=
 =?us-ascii?Q?ZMHmctBu1g=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b94ab512-0897-4060-4f2d-08de5e7dc956
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 14:59:07.6509
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BcTbPPMQdxlttTcV9VaPtq4mvns/yZxPllHsyGDhraoVOsLWTuBFTTIEzMOLY/Ar
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5925

On Wed, Jan 28, 2026 at 03:01:25PM +0100, Danilo Krummrich wrote:
> There is no second memory allocation. In the implementation of
> fwctl::Device::new() above we call _fwctl_alloc_device() with a size (and
> layout) such that this allocation is suitable to initialize the second argument
> (i.e. data: impl PinInit<T, Error>) within this allocation.

You are talking about your suggestions now right?

Because what I see in Zi's patch doesn't match any of this?

+                bindings::_fwctl_alloc_device(
+                    parent.as_raw(),
+                    ops,
+                    core::mem::size_of::<bindings::fwctl_device>(),
+                )

That is not allocating any memory for driver use ...

What you are explaining sounds good to me, though I don't quite get
the PinInit<> flow but I trust you on that. :)

Jason
