Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011037.outbound.protection.outlook.com [40.93.194.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 981E54A32;
	Wed, 20 May 2026 00:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779235511; cv=fail; b=FEDi717Navnq3WXwOqZIDnxPGHWQ0GkP3jknMwATThhiO6QcOmbJqLxIJYOCa3K01lJGEI+OH7mXrM5Gscg5lB3THGAlj4oJjwdrLjV46IhXWtEChSiJgRdMB8vnpCmdL7H4i7+4T6/ebxHXomNdEVM/N1pl3tRQtlo2JjXFwk4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779235511; c=relaxed/simple;
	bh=dO0dRJlmWlX5vDIMSW4ivVDyghkYwbnZ0HbqOi2GtcI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nduoeHPQWES47B9C403ejX8vsmfyYhJRcd8RvwO4JNhR+gq9zNwAftKi0YoU4yD9XUM9XbmaWo1xcehAdXcs9Wv5OckzvS35lbtCtF2QbYcccFZ2p+O4TCOrTGtJNpQKkebVv1BESecaFePGfGuSt/f6VKyyK2xb2JGV1Tpi6Ck=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lwKLXipt; arc=fail smtp.client-ip=40.93.194.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lwKLXipt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b5rKJLYC2PaZPdowtFjoF3qRNR4H/J3WYBgkmvJ4xl/DM9+m0uvWAfDtgp5Wl81I9R/3iUUwOdD1wb4Nw8zKBIQcNFeGsQAtnGJ4aSbU5OFkvhVN7nrz5bEmx0tKETiiXQY4hz77dpT6XqMaCdWCfd9UgJsghrAAR2UPFaapOyMFUiPp7VAiRn1Qgi9orZP0nwd8vm3xCrRaGLzbr2uHBPOeb+O5KOhOjLFQ7rG9R3vSZNVmHf/3wIwOX4etR6X0xvzqx6IJEOJ8AENjGxM+QVtPEQMnGivADGqJu5e744rdAETFsdpzG6c3BLN+V10Gm/p4LE5WpXvfiPkSlULTeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OFUwlIjwayIxqo3eLAki9eLwlQ2Jo83n/CqnQNZk4SE=;
 b=L+f/K6AvASsSQcjxaa981MiKDJHry/h3jWxhdQaKI7KYqLKhN5yf8ajf7WV5I/Fr59RkPxJY84p5cNSBpGa1ky9tmPtaIjnykO9rvhEQmIAwWciZkqQP4KCGFPJFwTt0DCWLVTbbxBrIh1IQ8OlqZUrgws9oUU2nD9w0l6PpuKCw22IehR4z/FwsCwy5mm4xp62RBXobLPKadbOkzQ91cEt4I+mxF1MWYwbH37MXObGx1Jui0hrBs7ngLADMnCPlKaFWLyeJRxZw+fjci6JeqWqekFnIhiYXzTpFHl+KQHHQnvR+gRQT1iG9VeKpkKtsWbH2xIdifMB1xCT7whrN7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OFUwlIjwayIxqo3eLAki9eLwlQ2Jo83n/CqnQNZk4SE=;
 b=lwKLXipt/Bw+l1sQtxGHE88sGkwOYKYqexkHLV3VkWjYb+1pum2si4R004Z2LY/iSfXl1ck7Rdl2ILpKk/q4Kzmaeuo9VrVH/vVNUu6NPONzP6Kn+g9DG5jdQZa/2E+FS1FrxSEgfyqo4ONVUBMbhdzvtU65g/K4CGXU6p5cJExx5TjPEilT7iJL0iLQVJPaqNgOieaxFocaU4OJzh6WPJ2YzDmNI9U/23bhJL3dhJHQ7qjcRUUj0xHKSZq5yd346IgiMW7PiPyRi5Yp2DBrvCUG0G+XCblhxYvggw1krGXSkY4tTUKhdNae8uswjJCk/TsYmdDHv6UNgdTDtl3ESA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by MW6PR12MB8951.namprd12.prod.outlook.com (2603:10b6:303:244::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.24; Wed, 20 May
 2026 00:05:05 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.21.0048.013; Wed, 20 May 2026
 00:05:05 +0000
Date: Tue, 19 May 2026 21:05:04 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Nicolin Chen <nicolinc@nvidia.com>, will@kernel.org,
	robin.murphy@arm.com, bhelgaas@google.com, joro@8bytes.org,
	praan@google.com, baolu.lu@linux.intel.com, kevin.tian@intel.com,
	miko.lenczewski@arm.com, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, dan.j.williams@intel.com,
	jonathan.cameron@huawei.com, vsethi@nvidia.com,
	linux-cxl@vger.kernel.org, nirmoyd@nvidia.com
Subject: Re: [PATCH v4 1/3] PCI: Allow ATS to be always on for CXL.cache
 capable devices
Message-ID: <20260520000504.GQ3602937@nvidia.com>
References: <20260519222335.GK3602937@nvidia.com>
 <20260519234801.GA21369@bhelgaas>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260519234801.GA21369@bhelgaas>
X-ClientProxiedBy: MN2PR01CA0054.prod.exchangelabs.com (2603:10b6:208:23f::23)
 To LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|MW6PR12MB8951:EE_
X-MS-Office365-Filtering-Correlation-Id: 02c5494c-017f-4d5b-f4c6-08deb6037285
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|18002099003|22082099003|56012099003|11063799006|4143699003|5023799004;
X-Microsoft-Antispam-Message-Info:
	bU3/KAzCKNHeK0mK+5TngzPkVst4rEn69/+Tnjm44bAq516U6YQdItQaIq/PUWxLIzrXfTxgjV0Expt4WR9W1AKo1yPfktmRiigVHFZ+N7epBAXoz349HdO8In5BeOO3Dx64b2QqtZzIlYBDro3Nt6RokJkLdmMf0BHZh13a393KF6wYO0Omh3BtEXshzz1UzNdBn87t+r72iHUVvhBeBaDuzj4dk/mxKc0ORzfE80qlL7bfKmsmV7f++Mz2Y7TPhk6aFNmpiiwRAKdRyuZ+6UHkylqoudiG4+qtG+t/PiIrivBjxmD0fMSjfWu5/23OTFvHHDZwVd+kDHnXgL4w1oW72d23tKweqj6V39FJ0hvOJ6Ad5sOaHaaN4p5Oyi47mVexULeSSAKG1T3cBocUa+fe9Zv9ZYuaYKhzcPtNir9cUV2mMVTewmUBgDx1AT431OUhmDIccagNfSjW/CmTNJyGBMvWedYq4mUryGn0rLoDSwcAYqGL49vLjjmodTXJqyyzcMHAVRfivHVClD7O8V+c/Qw1SU6CYNzLz01TncWWfq2zxyPsfiVuJL4+ehgkU/W9q8ui8UL7C3oS1Yc8dWeBxDz28QAeSXcPjc3RCfUfp+ArkdVY+JzRBTe+nQtK/yQbkmN9ODv4ErUMOeTsHl6LXRXf5I2jH4p2nKk7HTUX0vb3ieOhF4yeClTTCoe0
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(18002099003)(22082099003)(56012099003)(11063799006)(4143699003)(5023799004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hYCtZAKBTPwH2KPRG/tWpdmwcxow69cqH053YJ5jyVqY8Z1GPAI/wXOTVKaj?=
 =?us-ascii?Q?Yxp6ENfg5Eb1DfOdWWyO+AsX2jWE8QYZXDh53hWriUAL8SglC5NNMIqCRxg8?=
 =?us-ascii?Q?qJV3TaLVBAHMzW3tNUCQg6KnJXPDp27CAmPjNYNTdaIpUpoLDGsLAhfIuZhY?=
 =?us-ascii?Q?yyPsuR9d1lwL9mW/xBj7BqB4oYnuQB28tFZ2JaBc+w+YsnVxWfABflzd9sB2?=
 =?us-ascii?Q?ih1Dvr0aDwHTvYDiWXve8q+KRLTJpSUIyaQOM9J753Y3zS8EkwWqrZDzJ+9Q?=
 =?us-ascii?Q?xYPSJM4/XX9RfVWQzCHR9qw/o//9U3Y8XmtspqiI95vugTzUyfIps1KY8zN5?=
 =?us-ascii?Q?4h4V6W/udiGuvUSm/cQYm1KBise5+AWRx0sKQ+TiEBn71ukIINqxdm1SsgjZ?=
 =?us-ascii?Q?wwl/LLtoMz+e0O+ordm/CKc0agz3+uEH6qt8FkYyc8O6J7HrT3vPd5tTJl8Y?=
 =?us-ascii?Q?Xy1wiInUOVS9BDRo90KMLHq6CePI9AZAFk/ET9cIasFotLMhmdKrZ2TcewLI?=
 =?us-ascii?Q?J+CobZsUGxkj8rS6QOnvA/2HHpmB9WmyOv9uspk1yWVv4emCccE91z0N+eeK?=
 =?us-ascii?Q?n9hnhFlZ2SHJIMK2DDecpC/aOF8/Xy6pxa7t7elSTGRf9JPMQuyoZKfPR+79?=
 =?us-ascii?Q?FT9StAZr/9QWVm0Kij9Yc5N4z0gfnoq04svenSCtNMt39+5yn5OtVlCWVtlz?=
 =?us-ascii?Q?XDDEqM+cDGFbs2Bi6TLJS0Ws4255zgACGsQGUMwMhc+ILvDUbM54HwE1FdV7?=
 =?us-ascii?Q?5/URFUur3n3zAkb9olbvba+EWf1B1FH8S8jZS6SYGyfNTkmihL9avO7n/wm0?=
 =?us-ascii?Q?CqMB8nQkejScRBdpjyoCQE9ShiFrkiDfE+FFicTjPErQOreGZKRuO5h8gxyY?=
 =?us-ascii?Q?1HJN64+wO6RkO66wirxkk01w6AXJ4E/CjESXhSbClp4QhV1A+nBytJFXfxtV?=
 =?us-ascii?Q?pYr+Buhu4QU7nydFhgeqyjmUF6ubFa4+Coj3Txjs8QxwX/E1JOXhZqOpHAC6?=
 =?us-ascii?Q?V6clGhAfhao6W4lDjv+k1Uyi7KlK8/WFtAcwRwjHoy9JQ8wFAVMtxow6rnSF?=
 =?us-ascii?Q?wCpPkK2rC1FPUMx520cddQoxz0Vqjv5mqkdCNtbVAGYLKxGmzgj1uTgvWvrW?=
 =?us-ascii?Q?VdT+WMAy9i+5ZCS3L9Bbkbe7616uP1Fc94hhMJYTJw4B4m6TM32kpSZvhBKG?=
 =?us-ascii?Q?uXvwmXYAPPKnJdVC/l0k6jeah88Ak1me81+SDmLePIGA+BFlPOXvW07IwYjX?=
 =?us-ascii?Q?PZOhNxz7wnPg/TENw/BHv/9XbikK3Dh/ZR6tQwu3agWZx1pDQ8JTrgRn1GKA?=
 =?us-ascii?Q?6kC1WPJyjlzO7uGHc0N3KEcj/wtwhvnc1XcNIcrP0plWMoDuNro1M3wdYgLx?=
 =?us-ascii?Q?gjdtZeRhy0oY1pab8E9wC16v95Qlce1/PakpiB+O3XXN0Jg2ZqGqWk9uWXjm?=
 =?us-ascii?Q?Ob5waRLJi3uG1gVkffkWXBpXCJMkYW8KYo5xX4kqgSWPOzmoIE+EJbYmcFrh?=
 =?us-ascii?Q?jeh+tzKVo87aRey4GWP3Lvsjh4GAK/LL62ZyTMuTbhAO9f3PQJuQKsDbuloy?=
 =?us-ascii?Q?f9Zs+vZKk8yQBQhtqL66vsFD966pYuldPFTN22CNVeHknyNYN44TxUxn9IYT?=
 =?us-ascii?Q?b4PY4ZktJku+U284PoVEKck0NA44u4s4056GMrRDn6n3x/6ff5io++xQ3zIk?=
 =?us-ascii?Q?FwfJdNHND6LEZ76lSvoY7aUx85n8Fy79E2pPXebkXm1EPOet?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02c5494c-017f-4d5b-f4c6-08deb6037285
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 00:05:05.7006
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X3Bs7IsQZPKsI6S1xXW6Lqbaa180mnqVJejhRErTPTPYAYkiEZ4v+z2cGz6/EG3/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8951

On Tue, May 19, 2026 at 06:48:01PM -0500, Bjorn Helgaas wrote:
> On Tue, May 19, 2026 at 07:23:35PM -0300, Jason Gunthorpe wrote:
> > On Tue, May 19, 2026 at 02:36:49PM -0500, Bjorn Helgaas wrote:
> > > One motivation for putting this in the PCI core was to use the quirk
> > > infrastructure, but this series doesn't use any of that.  It doesn't
> > > declare any fixups, e.g., DECLARE_PCI_FIXUP_FINAL, and it doesn't
> > > update any state cached by the PCI core.
> > 
> > It works like the acs quirks that are in the quirks file, which are
> > also arguably only used by iommu too :)
> 
> True, although ACS has a lot more PCI-specific grunge in it, including
> all the "pci=config_acs" and "pci=disable_acs_redir" stuff.
> 
> > I'm not keen on spreading lists of device ids for PCI quirks to iommu
> > files, but it would be OK to move pci_ats_always_on() to
> > iommu_ats_always_on() that calls the PCI quirk function.
> 
> Yeah, I guess it's fair to collect the device IDs in PCI since this is
> about characteristics of the device.
> 
> If we leave stuff in drivers/pci/, I would prefer that part of it be
> named to be purely informational, i.e., "CXL.cache_enabled" or
> something similar that would also cover the NVIDIA devices.

Yeah, that's fair, so let's rename it to 

pci_translated_required()

ie the device requires translated requests to function. This is what
CXL.cache implies (IIRC I was told the spec specifically says this)

Requiring translated requests implies you have to enable ATS in the
system.

> function doesn't actually turn ATS on, and it looks like the question
> of enabling ATS depends on how the device is actually *used*.  E.g.,
> if Cache_Enable is not set, is ATS required?

We have no way to know..
 
> That raises the question of whether this is the right test:
> 
>   +   if (pci_read_config_word(pdev, offset + PCI_DVSEC_CXL_CAP, &cap))
>   +           return false;
>   +
>   +   return cap & PCI_DVSEC_CXL_CACHE_CAPABLE;
>
> That just says the device is *capable* of CXL.cache; should it check
> whether CXL.cache is *enabled* instead?

No, we talked about this with Dan in one of the versions... it is
better to over-enable ATS than under-enable. over-enable at best is a
NOP, or maybe a tiny performance loss, under-enable is a functional
failure.

If the CXL.cache is not enabled right now it could become enabled
later, after the iommu has already called this and made its
choice..

Thus lets not try to be too narrow here..

Thanks,
Jason
