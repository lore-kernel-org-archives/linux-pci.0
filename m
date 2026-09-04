Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010001.outbound.protection.outlook.com [52.101.193.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC6848C8D9;
	Fri,  4 Sep 2026 14:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788531970; cv=fail; b=cO1SKDIoVvu38xg6nJkndkgPC5Ofw3Itq0xyiCAwK04Kxq0liUtfNTmBXWDLlmibulIGRkKeBKKeHXEgpP2pWpmgHj1/xizjxuwnPUx2RlVoSQpJXHxhk53ZL79PynaH9D4BcRnX1Qpsar4DJQ6tNc7FPJQOCAkuicFErpVrtKA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788531970; c=relaxed/simple;
	bh=LBvQcoIMpmvbduZYR+OAu4FY0F8x6CueI1yEFCAo3Gw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=O5lx++AYIbwbnwkSI2e76l+RnLRiDFqOhD/eXPIVH2fNsox34sVBB0MOCkX5z7DIiefY1tqM/JHK7QDVnteHHjqhoBTWNENI65G/Dp4fyHuVkCsYLXRBk7KUYZWEF2gSkDT2K5UNltxk98MBILcJYPJfHUS7smXIBonmPTg/0t4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=P1vxoYnw; arc=fail smtp.client-ip=52.101.193.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="P1vxoYnw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xg3ABCO1iPYgzDpFLOF1L1yoO5L+geo9EsHIkbgBPBxIHHBV5pZENPB1QPwacDQVAYUGX0cJyoljxam8p7w3y3souGgAoSaGJE4GCuvzmNZde7n9AaDlZN64iu+wd+SNFkHINPIB5+LcXlJXjM3ecmDTWsZzbOiMVOVw/eeZCTleclvUOJjDsdxR0GFcej5O9XMWxUsekt5PAAUVnV/BBo49qwgVYLJ21Fs6Ci0qxJz987dqiSbS+DuqMmaRFNuHXVNMfRwrwTLSv1Dlg0yve0qS6h9hiPy0zEsdORjUaYBmiBfyxe+Go3BclfLdxqn5e+KfI7gTNX0OcVgVhS1rnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z0P7iuHsW0Hc2gsMz0nOgFJuIxnGcpmhta1ZJYie/PQ=;
 b=pIgo6q/b/l8HM/+P7UO4RLw1DWA+YAuQc8YfpION8E8ffwg2NJaG1Yp5y7gskkJ9fkuEjNJRdC6op51bdiza+X+r2BsruaBn7SJb0LMkw1n06QjYgE9jn7dQEZyettLU3b4dwAawCfNGcSazMuBbeTrHL6cSL3ah6e9ViUK6dtwHptbk8Z+7NTyVDUhs6N7o6mdXPlZNsXCHxI4kOFsyAI4+1KnGBMkQZ5xWVNtAvH908YL7jiAWFhg5SfL90C95xtq4lBqJfVKbQKO4SJl7jvadpdIczm5ewwTV7xQib8qGp9r8W9uLlJkFSHsIy/6wLSO75qxxC3rF2v9xBZQWRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z0P7iuHsW0Hc2gsMz0nOgFJuIxnGcpmhta1ZJYie/PQ=;
 b=P1vxoYnwKhmU0e49Kgns5WFVEHnWgCZn3FWmOXqFS6AvuTrXj8z65klSW4mmuDVA3p6ZDaf9aQneNRUVNh/rdHcKae0Iu1FLzx59XTY/o/aj+JGCYv3tUrOtes5T9bk6qt9QnbyifT3yX/bJtfQ2pQp7r8BD0++j72NbdekH1GIAVQby7GcG5EeckMo0oYaX05pxgvUBXhEy2on29aerIYmrxSBogW1RbfRJVXdL3ti3XzFSjYFJHZQWVaBQAcRdf7pZuhMtG01kCw/82E43v5mprhqyYIupPYfmQRBDkgi8rMrg16kpS06ft9dxwunHJ9K3+tC0Ts/Sfyo4JZ9sow==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SJ2PR12MB9212.namprd12.prod.outlook.com (2603:10b6:a03:563::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 14:25:49 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0360.008; Fri, 4 Sep 2026
 14:25:48 +0000
Date: Fri, 4 Sep 2026 11:25:47 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: Pranjal Shrivastava <praan@google.com>, iommu@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Joerg Roedel <joro@8bytes.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Ankit Soni <ankit.soni@amd.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Samiullah Khawaja <skhawaja@google.com>, sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/5] iommu/amd: Fix DTE clearing and rename
 iommu_ignore_device()
Message-ID: <20260904142547.GU4157646@nvidia.com>
References: <ao1vJxkZsJpr1qXG@google.com>
 <20260825114916.GT244917@nvidia.com>
 <ao3RF0w_AXo5EXxv@google.com>
 <20260825175315.GD3325090@nvidia.com>
 <ao3oHn8HiXIx5Wrl@google.com>
 <50ffc453-f918-47f8-9556-9813308690a9@amd.com>
 <20260826122147.GA3666382@nvidia.com>
 <bfb7be5b-2da3-4bd3-8146-9bd079011a75@amd.com>
 <20260828115331.GC3922654@nvidia.com>
 <399db967-050d-48dc-afb5-5c77ee9cce65@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <399db967-050d-48dc-afb5-5c77ee9cce65@amd.com>
X-ClientProxiedBy: MN0P220CA0011.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:52e::23) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SJ2PR12MB9212:EE_
X-MS-Office365-Filtering-Correlation-Id: 098afffb-9dbd-46d5-a85e-08df0a906a78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|7416014|366016|6133799003|22082099003|18002099003|56012099006|11063799006|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info:
	Nw1mekvIZbPVk+DwnkgSL+JIB30u2vnZH3KPfKowWN2iHAp1W9oDh6PDDvir6lL6zPgBh2MPgEWSKuXW+TVrK+UlVe/yldkazuHt5dbN2ZJrpnPYV6FZ/u2fEjs3mzQskdb1qgwR5jVmluTsWKdWFG1EyxAXyXN6WkWQN/OICwUm7N/ygyZxrj2NYk7IwpXp/scbJR2L5iWNmn2rJqKbGHOLaPIB5bdSgfUzqiahwYzitJNfasenZzQ2czh3HgTuBff5i9OmWI27iNEZd0gBdJ1JnFi0ATWByXsNpHsoZNMHWwy3nm/z+z9AUPXvag//CThSH6T0YvaQ0HFwMoqvCpdkxYKPnBs5vSfNERqlOmrGp27qSfxkxg3IBu/7ytOLzfmzoWnajYRFy6UtwiuNINIbvaC4ITIhJwiDM5XqK7zq6k+KNiybC4YRDThJSpulmwKCRjaaVIw98wR3Let8Y2PiITdNuq2bc94XR3F+FqdFxV+1jlI9jgZhEqPnSDJOVxZAyccQ1cJ5UeYeiUH1zOpcU/ZMFOMcfm9+Rkp505tvkTiamoomZl8GNZHln3U75noEBIhPtrdE9ZmElE3uigI7UafQPrjNQNlDSXulAX6Q8u1NghoxUs3mxmUbL5970ovuynNcd46hjknA8g/Rno7xUCT50msFY1RdvdVPEJg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(7416014)(366016)(6133799003)(22082099003)(18002099003)(56012099006)(11063799006)(4143699003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TTC897bqFbTfTsDw7K1xcvReormt/VeiH+VeyFzt4kYqUBx07patCD/Zegul?=
 =?us-ascii?Q?XQ4gHu+56DFgtI27YHdk2qdByYgQ+CTrtLLecsoK+ADTaLgaIkiIl50WUM2b?=
 =?us-ascii?Q?cIsXScbYj6ZlcZsycEgFIt9Ox62XKf7dtSGd14uofNtNbG3njrcch0Di/u8G?=
 =?us-ascii?Q?O91wx6yVZI9BMOgZLNgAHvmKIq8tKjk3XWVqQaeIlTqc5k6ZJui8XlOwI2iB?=
 =?us-ascii?Q?1wem4xjoQmGdncHMRtwaJZl8tU3XdLqZtcSk/A48uFp6Ua7C5qLzi5q2mKMm?=
 =?us-ascii?Q?JkDTMh3wLzhhrYY5VR6FgTwd2o58MMNqUS5SDAoABPRD9FQSwowBdJLWIXzZ?=
 =?us-ascii?Q?vKsiUlqmlIiDNwJAMvtngdcZ8qcTAABYXjX2vRHwjj5axooYnAzyttx+9QZg?=
 =?us-ascii?Q?wOkhnunzfd2aNThAKbKg5wsPwSgh7bULPTKCxA927FI2iTfa5R1LJo9R8KWE?=
 =?us-ascii?Q?cB3ZnOMSBlYVEsghWbwYf1ytTEDS+jVAA4/J+kJ1uZyVnqkBHNX9gliMVUsO?=
 =?us-ascii?Q?DQahW0yEHXXDVrVt0WXsWeHk+HTD4ZSwW3JjJ6rpInUguxZBkoGDUyvH/gf/?=
 =?us-ascii?Q?wFUdhEJbTY7O160g6N1SjUGsSFmIsnyz9bWnvELXmzr+2tYNYPk9+v7q9XKj?=
 =?us-ascii?Q?x/SMgOJFunFUaC/Gprnj4mdGXBMaDfO+Kxy5gUKRhMdTRGyMgmJgi6hldDpQ?=
 =?us-ascii?Q?8FYWy0fXmet2X5XzTVOu2fC/tTCT/BPjERPHuawB4syQ29I0BDdF4qulilA7?=
 =?us-ascii?Q?YsAtiENSY/UZw+KhzDu62Gn2WRQdHGwcg5HvCrxV25pZfB/XzFSqK/EpPCPs?=
 =?us-ascii?Q?kG5NGcma0gNa/he51jCIi1CTWT7IkL5lwrljyQMfBX41KGKIoGgRJcqDabq6?=
 =?us-ascii?Q?Wti7FYylpviW4IbZk3Q8ty1QtK9v0NkGKbfB8xMXfBSkLJsvUbdbjb0IyXQG?=
 =?us-ascii?Q?NN8VSEsJKxmZUzN6NYDjNjQ8pmqSfkjNHAsVZXer826vcK1E1j7QMrp8SADf?=
 =?us-ascii?Q?I7iPUGOlishQKFz1ECJwn+RTCXE+verij5lT5j/WkVTEhpRi41pK2HCXcajQ?=
 =?us-ascii?Q?5+B2qf/V3UJCuld4oHdHsqxtbCWHjlpBx58hBaBWa0jyYPOHfvfHYvfzlqRw?=
 =?us-ascii?Q?qmNdG4QQte4/K5Cu9gCODP2MzSeKaz1KXKSSmH2LH94/MbpJG67/Kma6OuyU?=
 =?us-ascii?Q?fvH7Ha8OmmP8bN3fP6dFLSdBkC7CtNv9UyfBiXHVZOcqnPj0pc/U1N7qrvKM?=
 =?us-ascii?Q?JVqDRxdgUQkapJeyMfMPedrKnJ0/8l52gW/tqKxanlw16+En93ow5msAMTfs?=
 =?us-ascii?Q?le7e3j4hcuBvo2N4QNu0LdLobXR/WmJlLaYyWbw9iLxC0NTT729uwefALSdi?=
 =?us-ascii?Q?eeSbeTlimCXKIKR0QE/dYJz4sARioqPcUKa8O6Hv/d7B02RuCpL1TT6TdzIa?=
 =?us-ascii?Q?LUb/SYhyGWu4VTkybPSroBxlYpCUiBNlJl6oScacvVohmGK0VEN+FRLpzFM7?=
 =?us-ascii?Q?ycyw29OnGl/vTZUeM2v7aqmTSfOmb4F4GLwRgd8jupLxjrJJRouxr/c6Rmvj?=
 =?us-ascii?Q?ieW86XXIwNlRDLQquwUMTZO7puTuVkgItIngauelK2qxOpSFPSQ/mDqTTPTh?=
 =?us-ascii?Q?NSo2pC5VwJVHaA+McVZjFXKrgqFebUzsgOelAJic5bz2m1TKSlzws/vDC5ZA?=
 =?us-ascii?Q?cupYiQMCri7ABcKzAtGp+4f931hrm2lyY9biSokEa4MTfjyC?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 098afffb-9dbd-46d5-a85e-08df0a906a78
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 14:25:48.9291
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GBnxAp+04J2QkfphuHFZejSH0yQHP/9JueJld/5AcsxI1M8QktuX99ElqUXGJ2kd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9212

On Fri, Sep 04, 2026 at 03:43:01PM +0530, Vasant Hegde wrote:
> Jason,
> 
> 
> On 8/28/2026 5:23 PM, Jason Gunthorpe wrote:
> > On Fri, Aug 28, 2026 at 10:46:48AM +0530, Vasant Hegde wrote:
> >>> Having the driver boot up with all DTEs programmed to identity (eg
> >>> 0'd) and then try to fix them to blocking after the iommu probes
> >>> devices is security backwards.
> >>
> >> During boot, it only sets dte.v bit.
> > 
> > First it clears it to fully 0, what does 0 do in HW?
> 
> IF DTE is fully zero, then all requests are blocked for that devid.
> 
> > 
> > It doesn't make sense that you'd pass over the DTEs after
> > probing if the original 0'd DTE was actually blocking?
> 
> During boot, it sets certain default values includ dte.v. It doesn't
> clear everything.

?? It starts out with a 0 DTE table? There is no inherited DTE table
except for kdump.

> May be we should just remove ignore_device() completely? as
>   - normal boot, its not yet configured, so no DMA is allowed
>   - kdump boot, old DTE is still valid and let it continue?

Yes, that makes alot more sense to me.

But this comment is also wrong:

        /*
         * Order is important here to make sure any unity map requirements are
         * fulfilled. The unity mappings are created and written to the device
         * table during the iommu_init_pci() call.
         *
         * After that we call init_device_table_dma() to make sure any
         * uninitialized DTE will block DMA, and in the end we flush the caches
         * of all IOMMUs to make sure the changes to the device table are
         * active.
         */
        for_each_pci_segment(pci_seg)
                init_device_table_dma(pci_seg);

The DTE starts out with blocking because it starts out as 0. This
isn't making the DTE blocking, it is doing something else. And it is
very suspicious and racey looking to me.

The DTE should start out in the right state before the DTE table is
programmed into HW. After that point the only places changing a DTE
should be inside a device attach attach callback.

Probe and this global scan should not touch the DTE.

Jason
