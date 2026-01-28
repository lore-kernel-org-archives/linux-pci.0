Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012009.outbound.protection.outlook.com [40.107.200.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C435B2110;
	Wed, 28 Jan 2026 00:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769558658; cv=fail; b=ujrtdhfg1ztjuLCWnI89UHu5cCxLM2ONeOcH4ZgaJyvXHqm5COAB7ZZuM82uN6g+VkYmdXGRGsswvcANsX5YfPdYbyECmjOeaupgK7mN27PXTMyfDBQgGg/N4bMEAcoWhsxrzAZuVISTD25/Ehs67uYPySjDI3MTTQ9tlr6qZS4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769558658; c=relaxed/simple;
	bh=vhrM+x7CrXp5/FvnvkzsY+GtfXJatRfN3dVIYRmJM0s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=C/LS15G2TXFXSz5lU026Q5diLMSIaONhh16sW3XbvM59xcX6lkqCvFh0Lk1dLk8BqZpYt2czpbQxDrd4LZspPdERkhF981HTNp6b8ZkBWZ3dL5kuTFzs51dfbT71Iu43emk6WMFQPyzvYqCGBBUSW86i8d3PmSILK0u5YD3W3DA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qhxRFr32; arc=fail smtp.client-ip=40.107.200.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qhxRFr32"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dh07+LV55yakxEeLQVSlSa2WTb1/Jyq+qRg3QTzhGWgPYm9jZgAFGB/Ulselr3UqWrrk7u9UH0vAPPOLi5FvKnB2q4RSy+bXtEEAXvaxrOAJ+90z3F5fqL8xDcIq45ZnaDhdk3NaeKF/ZCcDL4aPSJjewSbkChTWXAsCf4j13keKDkrEVNtHBDO3adilGd+csVerqt2fIUo/l4fbnTbhl3y5fs/Ks96npWd4tW1x/QuRVDfzcHyq0y/PyBdIoZk/X7MZWpfPRWM8QgrL30qY5SJhg67HQpOhi9RILNo1njD5jug8MovPhnmyh9HSvJjtRl7v7/pCsUZG2jcmRx/aAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hzlJSgXYJji+oUGU8O4wMAH4moa1zTJNbEk33WXzlh0=;
 b=QadBOEGpgoT6zWk2fojNWijcqIePhKYaGbuVLQ9HD1hQ2/2vUWE3AUeNaWGwgCK2Vy1f4pzNdgvn4TN7+KuGEShalECJ0M/DhOIbNRONzNh8FoWZDtq7Dn28vu1zc8PzU73I7Eu4ozlcyFhYFHgus9P06cYCaHWfhRkI2XKV7tDyVkp24kTKRQEJ69CepQeWH4MoOX4QoSikLTknVvBswZd6WaUcUMm4puk7IikTxZ8GsUsgTw+PYlHAt7f1IlwrqvjC9DZF1MHEbZI+8o1/tK6itf1D0ckRt0hkuyKDdBNUp6981yLHtG3X8JXgmwfaOE5dkEUu7r/sLHxYrePnwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hzlJSgXYJji+oUGU8O4wMAH4moa1zTJNbEk33WXzlh0=;
 b=qhxRFr32Dw4ExMQ44MVnzWes4P3lfnt3SJCIDfQENymxabRLC1ljhK37fSDPDdPWJYkA2CcbtuvkKdes4VW+BBZZyyNyHgyjkI4NHK5/gzHj25c7vVNT1RaLfJawsWDe74bUVWMxk4UWid7nZh2x35Y3TaCcTTITHJHn9t7ZTSl45FHa6KBVhSSbWjmRnjuTPczIMnhljZ1iS+5pE0ArHNtcgpNG4Uj9cKn6gxN5YWfoSrBN+lqnwtXy9AtlHr+e8V0BVeANbwIa2TJJjyBdLOTMEfQzKbbjP7BsXpAzrJte/U1vlf7+zqZqvzba5bJRcgi2TUD5QXN29xUj6zeFyw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by BL3PR12MB6618.namprd12.prod.outlook.com (2603:10b6:208:38d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.10; Wed, 28 Jan
 2026 00:04:12 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9542.015; Wed, 28 Jan 2026
 00:04:12 +0000
Date: Tue, 27 Jan 2026 20:04:10 -0400
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
Subject: Re: [PATCH v2 1/2] rust: introduce abstractions for fwctl
Message-ID: <20260128000410.GT1134360@nvidia.com>
References: <20260122204232.15988-1-zhiw@nvidia.com>
 <20260122204232.15988-2-zhiw@nvidia.com>
 <20260126181912.GA2131321@nvidia.com>
 <20260127215744.332380fe.zhiw@nvidia.com>
 <DFZN5P8G6MQG.2DYXNFSRIL450@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DFZN5P8G6MQG.2DYXNFSRIL450@kernel.org>
X-ClientProxiedBy: BL1PR13CA0120.namprd13.prod.outlook.com
 (2603:10b6:208:2b9::35) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|BL3PR12MB6618:EE_
X-MS-Office365-Filtering-Correlation-Id: 3aa56202-32b3-42f8-3613-08de5e00c422
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZTOoIpCMUNAXME/xD+EthSCb175JLutqSjxshAdtlHNXoiPOfccVbdUE6a8M?=
 =?us-ascii?Q?3B+g7u4yuyYraz9Og9rc42+gv3oGoR3aJsyg1/JijIv4kxN+5SqHs8m2vB0u?=
 =?us-ascii?Q?teQSt3E4diwMM5ZPmkvI5UgSZgDOq6gcDIN260n6icS2jRLiJiL7rfv8aSRF?=
 =?us-ascii?Q?V6PNBN1s0H6QpmKhq7iaklcbQA3ajfW5FphhWF0q5YipuKpHG5HC5odCTa7+?=
 =?us-ascii?Q?YgtIqHVe8/vfT1ZShdtBxa7A1dh1duLpxX5r3gHCYhJnJB2mWTTs+9jsUl4C?=
 =?us-ascii?Q?2E8lPf0PgBM/ntXAjINXhIXowAPXp3Fi8oWQY6ZowyOTEh7sl/dSCwOBJn26?=
 =?us-ascii?Q?dW7alYm8rO+5PbU7abVnM01aeiJFMKYEjpMTPtD6B/Luz9eKAQVjivPKOavH?=
 =?us-ascii?Q?+zphFhaCp7y4uV3CBYqyuyk+y7TuR1S9Aex6Mq6ssB6ZIefqbf6i+nOzyZXJ?=
 =?us-ascii?Q?nszTFMDEVXS2Ulx6jZzgZVep214FXXREKu8n4lLebzsoIZdOMR4bclXLzDu/?=
 =?us-ascii?Q?/BpiMbIzMizCWvy0PG/rHo9zQNVwkRkLCVIBuBNKmfrHhYsVD7W7YzweU6ce?=
 =?us-ascii?Q?XIpm5HcKYh2gBDgWtPbzr87CLQ3Q9T7fCPm58eH4UU/ihQJeEX+n7/IJSNIA?=
 =?us-ascii?Q?GIm7o/b8g/r872xs62DEkWzKCryelj6IH1K051o1y2fwjs0ini2Cv1WzKxIt?=
 =?us-ascii?Q?EXS9Yt7PL36wGARi8eoCa68STGXVZyz5MMF+dVKxbLjJdKC3lcqTTs0jdYG6?=
 =?us-ascii?Q?3M5OEEOLXVymhpWCG7vlor7xbNzVp6Enz+bwmmpNq3Ldsu/rCNpDPG8FHah/?=
 =?us-ascii?Q?T3xWs/ab/4pvBSq1LHRpjC3R6wUTNPIdTgFCpIYur/Z2Blc7ZDqJAjKW5vNr?=
 =?us-ascii?Q?MfdMnA4vNozOEIrjEqdIasecjgOTZFkXDKMUOp0QEN6hhSChNaWwlZUJ59ao?=
 =?us-ascii?Q?t323wzfDyX6M+HZ064QWcPnp9iXcBVYcvISrw1onsiP1/o/3sbGFQBva9DQS?=
 =?us-ascii?Q?Hs0sBg9hQ412VgpVFNw0Pejx164FE7EnWcPpQGj0HlcTSp3kRpj0JUhlOg2O?=
 =?us-ascii?Q?FHgt974RW3PXKCyEyhIN9VoNwXmIh0NIx68ZcjoXDP8f83QiQVrIXMGfu8nv?=
 =?us-ascii?Q?HXdABiXC936ljneya+oYDNHr7YkIdyRFlC6Xe1OidFTa9LEvlxJiMuqHmxZ0?=
 =?us-ascii?Q?4JXrbHgd1aHFBVwSae39vhsc8lyhHyjHKrNG3JxoRXKE4+OgD+RtHwwKuEaq?=
 =?us-ascii?Q?EISSlm8aNii/4Wh7+/4qqs+1MZCAPazTw0T22VGBHLxzzxydnCXsJku4EnMs?=
 =?us-ascii?Q?d84BlisdFyy4R04BpWdN7dQi1r/wshn2cGV2jkEJRYFZQPXgoyO7llr1fjC4?=
 =?us-ascii?Q?GwDc6ZUX553ZBfwMZAFtRnyuncXGo+mlh4tx5+0Sqipc3ocnZP3Ys8IevYEh?=
 =?us-ascii?Q?Q52MVnGFe2usSG8G9fH2cDjjLFRjaiqVF9Cwk46hYqXwD2Z2bX9kjQhpSIp8?=
 =?us-ascii?Q?Sy38iYSDhJPrGgIWlk3Br08gxDsh3oJMSsbCg0D3pi3Of2BBMfMEEBybOG0x?=
 =?us-ascii?Q?qnN8jNTXQVo6nXhsQ6g=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?L0+JAjShdALSvr4GodfMPX3v0ZcupSoOAsYR8Auq8zn3nm7DQqzAI14WwPWA?=
 =?us-ascii?Q?bN5cqmFMHza7AKTxc7zzgoUn+l9n9c94n0QA8m1P6Nl5q1p94iKl/0/gw/n0?=
 =?us-ascii?Q?kd+fgolhqZxFbqygFuvGUyKs9M5S5/mcPwE7Uy30fD5sqjthbgYKgsMnqcsS?=
 =?us-ascii?Q?/WVRpOlSVR5QRgRrXFM9PR/DBKpVfuZl9lQ2mwxqE0hXdN4FrjEqLfuI6tK1?=
 =?us-ascii?Q?Xe253nbv+ozVoV37cOmcng41OZP20x/DNl6bRFIWBWMZpw0MS8inVzvNeCnU?=
 =?us-ascii?Q?GbclYtUdGHbiLanvDh7/M3FfkFU9baNr1UEqHrdK+teAeJ8flkvj4TaX4Rj3?=
 =?us-ascii?Q?ktcHjQXcG8hIHzo/NRhLWT0arw689Nr/zFIBKknwG+l3hhsJNkFkUu+d8GWJ?=
 =?us-ascii?Q?g+crYkCmvaQC8+Q8dSuMCBON0yKwye9yS4xQR3VUNUgmyvfrNpVLfXT1Pu2X?=
 =?us-ascii?Q?odgiqlzrwMP8eplC0sY4cvQjK7e5AGEuxnlIALYnzlW0WXP5k3scSrCqwJsp?=
 =?us-ascii?Q?3DVIHZs1SKNCBQZOeD3d0OgBkEjYQizFW8luimht3Nk2mf7IJgLKL0iLBI2u?=
 =?us-ascii?Q?C6gA9jLZUPjoM2+lmZy1piMOPAM5ArS6rbOKDQCWd52r8gpCYRZacfDdcq8E?=
 =?us-ascii?Q?5ZTwyHDoyI8bnsEooPQqr2KqOZgFPm3Yqw4SdiHJ/7ONqg1rNzWeNpVWlUGW?=
 =?us-ascii?Q?AMlYc/38KY3qkNMqjIv2E1p02TlPwS66DIUdC5R04WqAvAG5Qd1DOSwBwFAb?=
 =?us-ascii?Q?drMQy04vzqZsVzMO5cE/r9kvIG9Bp4Bt8tmHZr5F/f68j7aFVvBAqxEYRH04?=
 =?us-ascii?Q?T2k9WaGSehJZPsyy/LGuTTtJhj1wDAumedLsHOeG97W7iJea2Aj9I73svr1U?=
 =?us-ascii?Q?yrtMACZIJS45CU4+yQtPxU1nHXD8Dbgf0AoTwEJhmjE18lUaDKh/p/SVqp7V?=
 =?us-ascii?Q?ITwgEc+5VD5CVPPMRz3sRb7PdrQ47WQXwQEa5nfboS13oEoB3MOVLHh/X7xs?=
 =?us-ascii?Q?+cjrT0Qgm2dIGttWr+Sm8Z8FwXiA2kIKP7wtoXrxZBAl47Gvu4SIfwyA3UB8?=
 =?us-ascii?Q?ezw1tZ3/bq8YJHrLTgFv6rpaKX/Be95Iw4ZCYM6qLhzNEDiHUgr32T4y/3Y6?=
 =?us-ascii?Q?hJA2Ce233DZQwOx0b5o5ZDh+SapeaqrkXg4vXyUXw0cDYsILqFjFN0P16XSG?=
 =?us-ascii?Q?QMr6Z4vSsqcKD4RjLdNYGGLoSo8Qm4Pyu4lZ3BiOvIK8x/XE7Ryu9QOIGCGd?=
 =?us-ascii?Q?XBjR+3TLNYrxCuos1Rw5jHUN6MCkfv5VWAOx+4RfDVi1+p+MPPS0rXChGYUs?=
 =?us-ascii?Q?G3abqRJgScpuHCzbSXErBgfoAV5EH5zTh1TG7zUxACqVv8WMklTADjbFTh99?=
 =?us-ascii?Q?A55gC/vNWlUuGRBtRW/RP6dy9mQrOWEx2vFqJHPPZR6Vk77LBPtnryYktRY/?=
 =?us-ascii?Q?+LfezPuAtmtggPL7DBPew1BGX01mNo/oqmz3ovrVo6DZOUppImKHjahfMc/H?=
 =?us-ascii?Q?g5NEsmDeRB7f0pSueth7rbFicqSo9xo1yocRPQvjuvv+jSLxToiWPr+5TK95?=
 =?us-ascii?Q?YhSPYjqXLMBPBxtWMofNpNUtQWhZlARZqKV2vZmpOJGbtNx5IUW2t1s9hFft?=
 =?us-ascii?Q?sogb5a0HvF1vkwoV7FoGt57fnU/K1r1aGyqNKqDbDP8qqsWIpJplItdLqJoT?=
 =?us-ascii?Q?i/Ryuc7SHGWxfhlDsR+gH7XJwbSXxKyiCwQFiGGiFIJLeNPqrfA+aEnYbmx0?=
 =?us-ascii?Q?1pslUAWBmA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3aa56202-32b3-42f8-3613-08de5e00c422
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 00:04:11.9399
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1XqV/4Jrfq9elWLZxUvnP3EXrpaYhNPnkWAUyGf2JQRpqRcJtJ4h0MOZE1KZBbUg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6618

On Tue, Jan 27, 2026 at 09:07:37PM +0100, Danilo Krummrich wrote:
> On Tue Jan 27, 2026 at 8:57 PM CET, Zhi Wang wrote:
> > The fwctl_alloc_device() helper allocates a raw struct fwctl_device
> > without private driver data here. The Rust driver object should be
> > already allocated and initialized separately before reaching this
> > point.
> >
> > We rely on the standard dev->parent chain to access the rust driver
> > object from the fwctl callbacks.
> 
> (I will go for a thorough review soon, but for now a quick drive-by comment.)
> 
> IIUC, you are saying that the user is supposed to use the private data of the
> parent device in fwctl callbacks. Let's not make this a design choice please.
> Instead, allow the user pass in separate private data for the fwctl device as
> well.
> 
> This serves the purpose of clear ownership and lifetime of the data. E.g. the
> fwctl device does not necessarily exist as long as the parent device is bound.
> 
> It is a good thing if driver authors are forced to take a decision about which
> object owns the data and what's the scope of the data.

I'm not sure what the model is in rust, but the expection here is for
the driver to have a window between alloc and register where the
driver can fill in any information into the core structures that is
needed before calling registration.

Think like the driver core - the end user needs to be able to call
dev_name() (and lots of others!) after device_initialize() but before
calling register/add.

I don't think we use this right now in fwctl, but I'd rather it not be
erased from the rust bindings entirely. That sounds hard to unwind
someday.

This is pretty common subsystem design so I'd think there should be a
general pattern in rust as well?

Jason
