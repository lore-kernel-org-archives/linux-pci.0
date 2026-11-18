Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.55
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795007674;
	b=wOAB78Vy4hyxbTyd7F+u8WkC+ibrsjiBVqtqPXXbZW3S5P3e4SuXu3yMSRv7xzoyGV6g
	 0T/wxiSRu4/IJqgIWact8b0VWPYG02JpHgz4hVTagy89O1ZkKWHFkCRmn07oap/yd+XtR
	 1K1ih/HGA8xV90UqJgLV82FkK2BvdSqAE53pTtn6wbYpMPD2XKvGaUeM0DWycvxxRNpgW
	 XR2El4Ue1OxAKzm8Z7AeZboGD0R4hAlQvcaBdWWGpHZWMwOZOEEJjXr9Xb+ZCYPvXzK8s
	 SxNlFjl9Xda2+u/Q9/jZoIZAqDbli4zuv62MkkEg+/b7bVFN8+2qXx1m1Y3zm/W+DAA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795007674;
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
	bh=N/Gm3MFH76KL6I3rB/x/8jlc4xyUaMY5igz3LL8kxoU=;
	b=sV8xIdioREbCYe+zARg9ZBuwXRN6tROdLF+/NqOaG7CCEB1oRSo031R06Bn/4yvh4TRj
	 V4sMdIr6J9FXQZ77bIDanL9t5+KooOdgBPupNvUHwBz+8RPT8oa5WIs0ytFyxmKPv6J9s
	 zkIGSzDf1Lddg9eJR1EnLjcNQs0pwXZLX7eCtjW1gIi1++NrHqYbuWqZ1sP63P4eENbS4
	 n2Ec0QftfSckFThhm024IavbSci1Y5e0ExTEkaBeUb7GTifkMiD0i9nJpzDm9LeQ6AaGY
	 4i/r+gNGeDqn+aRhda3dK50zbMC68uNK0xFus8SmxBAtQk2KV3jclzmI2PqdwO2I59A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=AD4Dh5wX;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.55
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011055.outbound.protection.outlook.com [40.93.194.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACAD1606A31C
	for <linux-pci@vger.kernel.org>; Wed, 18 Nov 2026 13:14:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ACAD1606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=AD4Dh5wX
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oi9LD0ZRshFdNT8DdprNfFXe0RL40AMNMAtgrUSLhQMrIdPFRvNFlxFpU9106yfEgcx8UlxrDTomRB7Vij9wZ1R2OEZOARNfS6osV8wn7bsoZETTnQWR0DXD87gjE2Mc3ycLZWISauXzp4AfNumIe6UVJeci5WB4slJzb1KMjVq5zUlN7KU+2ZpBcLXkh5GUQK5lpuWdZdY9/MHpjFbodvios3O25/Bs4Dm3OdBGsrQFSsidrtVGM5U0NXQsuWoJQvA4Rm6AmYJMMQfgWOahbsWP6PBQYYC4eGBRhV7VR7ZT74ByTvnIwmdUhF4ZX+MoQob3CrYQuUql9WGeB2PbAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N/Gm3MFH76KL6I3rB/x/8jlc4xyUaMY5igz3LL8kxoU=;
 b=IRPAWvgxALcjxvXLWZayuD3Afw/MOXZCQ7/tPYY0ZpmqoP3OCDuACypTNZwyDimvHGfdFr+xjrExrY6t+ciJv7czwYy9zJLVdCvvI18jHJ9UWBJyS61N7Dk0zR10078a5MjGh7aUp0LPkAn6cf8JXJfRQHbq1iIjOFWJAI7I7+8HrPDDHOhY1AEqsYqBlKrV/XIY5ImkRBky4WPF+Miz2woiP31rPh9L+rAcy3nAVNN63qNd/uehwwd7i/L13VlOdUIChbZv2hJJKrVU29cB9okWy2bh5eI/Hq4IQN2gPL2F3TCZNPdK45vDCDHsiSRR//m4lO9RWzwp+rirGmZWKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N/Gm3MFH76KL6I3rB/x/8jlc4xyUaMY5igz3LL8kxoU=;
 b=AD4Dh5wXDocIlR1XBGctfGtJUyFzQAcCbccG+bX/5i51VfBbkj7L3UYkM2dR9ZEMQ3O+hBnqACcp683ppeT/YuuSEYFFTplMjtIZ0wgmP8fn7eDZI4Umk7KpTmstOvlUYoJyWdak5CPCaMrpJUpEVpaTuMxOoqBiu9DVC2hTXhhoU4MWqRRLNoYcgEzRFFWuEiFUHJIQ0oSTt7f0Xf02LNfZvwnBcZxAOgUXNARcJJgtsVHs6BGVd/KdtYNU2JBEs7Kjen1KY4OLtWiAG3bQI8pVVTs8SZDHDW83B9BxSp/lgg4HX6DxfuelXqRvi+W7oMoWu5ge5gTOf8MGY2FmJA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12) by SA1PR12MB8697.namprd12.prod.outlook.com
 (2603:10b6:806:385::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.13; Wed, 18 Nov
 2026 13:14:28 +0000
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d]) by CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d%6]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 13:14:28 +0000
Date: Wed, 18 Nov 2026 09:14:27 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: linux-coco@lists.linux.dev, Alexey Kardashevskiy <aik@amd.com>,
	Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH 2/2] PCI/TSM: Move core code into its own directory
Message-ID: <20261118131427.GM2245175@nvidia.com>
References: <20261116075420.76205-1-aneesh.kumar@kernel.org>
 <20261116075420.76205-2-aneesh.kumar@kernel.org>
 <20261116130055.GB1850935@nvidia.com>
 <yq5ajymcyl2g.fsf@kernel.org>
 <20261116131959.GD1850935@nvidia.com>
 <yq5aecckyhdn.fsf@kernel.org>
 <20261116144237.GB2245175@nvidia.com>
 <yq5a1p8iy4c7.fsf@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq5a1p8iy4c7.fsf@kernel.org>
X-ClientProxiedBy: BL1PR13CA0097.namprd13.prod.outlook.com
 (2603:10b6:208:2b9::12) To CHBPR12MB731189.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: CHBPR12MB731189:EE_|SA1PR12MB8697:EE_
X-MS-Office365-Filtering-Correlation-Id: f9119eb8-cc63-4c80-b321-08df4575e032
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|261026140227099003|261022105027099003|261026121527099003|4143699003|11063799006|5023799004|56012099006|261021121427099003|10067099003|261102123227099003|261009223027099003|261021135927099003|261022075727099003|261028144727099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	8L5psXwJ2xRSk2taKHLRkUmhIzFiUWUjbWsVldUTSxjuOXbLvn5MFUJlbrARgrQsxokY2XQZ9wRTbTTaMb48ezabgMKoMfpxgY3crVk26g9T9fQZdVLEGFV6ux7NK4s5BtO41C4tlV5wYjVEUxXVjOGA1DH1o2rAm1nbM2btg+36Ojg2sbs+E1v748v4nqRxSTGit6Udt4QbHZoZbvftJwJU7lpWOsdsew2FU/9qP51C3GbZevmHHf4LsOCRIHQ+GdD4DIh1pV8J3hpCdpP5ggJPdc39s3PWuvRHpH99NMKCfM3kxFrZT6UcyRyMUitl9YEVuq19oGMzLZ2nEtXnZSkweWyTTXt41FBl732MJmB/15do9768qa5tm//U3g+GJCDQBunZlBXlo0l1x/j2Npxea4FMNss3/smxWoEveTKm7k8Pi1/QvhCUysmVyNIdaOY3BMRJnpkTJJYV+Xet7Mo4OZa+D+u1h/9w9FRA5062aK6ojajC77lLQEV1urf3TKdglFmgsIYMMhgg4182Sy6QQTm/Nj4tVlj8PINduFYQ7QaPbDyYLG4n/e1+MBrkQpRGeytWTbzAn0oTPi9Yorh+X9cZBbctSW4w0deZkidStUjOBAQia2L50jO8WYZZ/vuv1CpYIhxB8slvYTCCm8RXsxuUdkwDEGkw57fqDHY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CHBPR12MB731189.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(261026140227099003)(261022105027099003)(261026121527099003)(4143699003)(11063799006)(5023799004)(56012099006)(261021121427099003)(10067099003)(261102123227099003)(261009223027099003)(261021135927099003)(261022075727099003)(261028144727099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?f4ba6nMbvb0ICFFnAra+3GkLChgMJk6tc0Ccbbjs3xY4Y4A3EElAEz6YF+nk?=
 =?us-ascii?Q?scwQdil8BspS3IxVFhk0hIKnUxGrs6B7w27D7iLBFU++g/x5vm4BbBB0mcDP?=
 =?us-ascii?Q?R7HDWcx+DAmvircSADaRdVw/qs3g/tb9A7C8uAGxpDr4QcP9zJC+MePJW3nL?=
 =?us-ascii?Q?dor3mOeBpd1uStzUAgzIExxqE8C7msilrsZ7//Jm9FDUdocUt90LqvY2rTQ5?=
 =?us-ascii?Q?FCdY4bo0HhBkWIHSfTAKpPNKmouMAhm8UA2ArTHhgVVes8XMpEDn0YGoj1FY?=
 =?us-ascii?Q?Dz8w5SltqBDHLeirWskiJH4YBPx7a1lnbHe/cMHOx8CCHK1RqDaTiF4FeLKX?=
 =?us-ascii?Q?3l0NNREsb/4stazqpgtNb7sD66mpdONNEZ4HqkXcCIwS+BPOJSv623/z7DDu?=
 =?us-ascii?Q?nJKpZYbkK+eWbTSK6rJdY9awPEbKLnZZDbNWYCSs5lFW6xP39OL/a32xDNZk?=
 =?us-ascii?Q?9ywGjj3yinnrPZ1fG3WaoQggjn+WBfDaxN3XKGQbYUIuK+OnCisf0he4m7dc?=
 =?us-ascii?Q?RtjKwnYuD3aKP09zkTmKoP5FTYKBhkv80p/U3qFb8b7ggBlH8hhyr+e3I72j?=
 =?us-ascii?Q?184VHieL9sQBvswk8LJnGFcanTG2aJqQ4klRfOWBYBN78WrGIumb/o4l5Wae?=
 =?us-ascii?Q?pBmD1F4lVVQA4W0KgD24GbMxE5x2tUSHIKkxE725ZPwpLPqZYtuHzFQH7SLR?=
 =?us-ascii?Q?aidQ36gL+/CbaITtruUw3aO4CZzIoNoxBIc3GaKMyuHWSokAxxyzo9GTxEOY?=
 =?us-ascii?Q?2rJ44wcNmQaLhnbjrLB8K68aGvVSgfjRchhm9Wld7ejHKIsJTsYa+GIW81xf?=
 =?us-ascii?Q?CF3gdtAAtmCgQIfFSyEAhaj2AOLeO9O3T/8P9USknB3BmNAX+BIzNEhqZ0Nj?=
 =?us-ascii?Q?Z2Ft/YzhHTra2QU8EdeMM4Abmd42oL8ukuls8PncziGBZiUo8YmhEueeXIbQ?=
 =?us-ascii?Q?cBt/Fyx3QGa/ClryPzjr9ZdGeZFap76pClUYWzCTO3FqpY24JeiIM6qNE8aw?=
 =?us-ascii?Q?3ObBKugDkkCSkQZy2dA2sLwO1eIyem3mblk7/kaC4Ps7FLJWEEX/Ear7Lf2r?=
 =?us-ascii?Q?2U4w3/axzs59/ANzVfMQtGF6z6cbvKnwQD1g/cJH2HLwqi8UnYUvtunqKiBn?=
 =?us-ascii?Q?2mPPJ7dzV4gaymToEG0NGFBNPAtZHKR3rZXlv3f48C45muToxkfbrsBeXw77?=
 =?us-ascii?Q?RwhZ+GHbAe73i7gRSQ0lRdVkHqcApZFg7HNVzTnRdkGk5jciI1qFu7deN8hx?=
 =?us-ascii?Q?asIoQ4xv6Xl6dwCvyDIEqLn7RoI04gGEYYK8DexluozkXrZa1/1+DQsmz5sM?=
 =?us-ascii?Q?oozL2lSSLBrTeNFZKMu3Y7+Up7Dbu9dOSqawX4XFhKVzSJFfZ6slZp9u1hP7?=
 =?us-ascii?Q?t1NTHgkujUsEi70eibtfwoAmQbhMAkYSV7W8br5TfTPe2zQGc2xtYk/URV59?=
 =?us-ascii?Q?c4Mp2NLYY5jVekKPeWJaihGz5R8f/gKBM0hit4fgNup/uSirBVfwLdyYW2Jy?=
 =?us-ascii?Q?Aa2kS4RCVYi9hV6Gk9sb+Dxtk3YP24Dk7DnHH8fqTpdJzR25Hsgycqgzwjwb?=
 =?us-ascii?Q?6SdiJn1IgmXFJTPFC0QszUnZfcVZMDBmbfJNIZEmGjYhMqp6KTQZtY/PsdCI?=
 =?us-ascii?Q?6U0EgpmKBX9/KPT2PGrmJyL0lQDg0YWg1Us6Kz9VTlv5vT8F/UXW3j337Kq3?=
 =?us-ascii?Q?330fer7VO7P9/sH1EwWA3PBOzo1qaosFWBj8XlwKbKIRdkv0?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9119eb8-cc63-4c80-b321-08df4575e032
X-MS-Exchange-CrossTenant-AuthSource: CHBPR12MB731189.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 13:14:28.6815
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 28WDDJU2MsZPxd+1+9PvxQvf4I+XF6i/TIJOf8hOKj7pfhyRVVxcgkSV8vSsMhrD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8697

On Wed, Nov 18, 2026 at 01:10:56PM +0530, Aneesh Kumar K.V wrote:

> PF0 owns the PDEV state and resources used for authentication and stream
> activation. vDEVICE operations also depend on that PDEV, so a live
> vDEVICE must keep PF0 and its resources alive. Restarting attestation
> must not destroy a PDEV while active VDEVICEs still depend on it.

Yeah, you'll definately need some kind of "core" module that handles
these issues. Due to circular module dependencies it has to be
distinct from the tsm:

rmm_core
tsm_rmm_host
tsm_rmm_guest
attestation_rmm_host
attestation_rmm_guest

?

The module graph is
 tsm_rmm_host -> rmm_core
              -> attestation_rmm_host -> rmm_core

> Placing the attestation backend in drivers/attestation/cca/ makes these
> checks and locking requirements span two drivers. The attestation driver
> calls PDEV_CREATE and PDEV_COMMUNICATE using the PDEV and communication
> buffers owned by arm-cca-host. arm-cca-host uses the same PDEV to
> connect streams and create vDEVICEs. The two drivers must therefore
> coordinate access to these objects and their destruction.
> 
> My first attempt used pci_tsm_rwsem to serialize attestation operations.
> That would require TSM callbacks for the attestation driver to acquire
> and release the lock.

Why callbacks? The TSM driver should create some kind of "pdev state"
when it attaches to the PCI device and link it into the pci world so
we can find this object from pci_dev.

The "pdev state" is an object managed by rmm_core, has a lock and a
refcounting scheme to ensure it cannot be destroyed out of order. It
would have information about the one and only vdev, if it exists, as
well.

The TSM driver triggers attestation creation and passes in the "pdev
state" pointer. Probably through an aux device scheme.

Now we have the necessary shared state between three modules to have
locks and some lifecycle rules, without any callbacks.

> I also tried introducing an attestation_connection object with its own
> mutex, reference count. Each vDEVICE then had to hold both its existing
> PCI/TSM reference and a reference to this new object. The stream setup
> still requires pci_tsm_rwsem, so this approach would also need callbacks
> to acquire that lock before accepting evidence.

Which stream setup do you mean? The device to host stream can be
locked by the pdev object.

The future P2P streams.. IDK how we even do uAPI for that, or cross
lock different PCI devices.

> I am now considering implementing the CCA SPDM attestation ops directly
> in arm-cca-host, similar to the viommu ops.

I really prefer we try to avoid this. At that point you may as well
give up and just implement one giant uber module.

I don't see that needing to get a lock on a pdev is so serious that we
should give up?

Jason
