Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46774290DBB
	for <linux-pci@vger.kernel.org>; Thu,  4 Jun 2026 21:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780607873; cv=fail; b=AKvaMrq6G26AqBREno72yhyWu31tAcKmnbHg8rnCZXWrk2h87tWWt4v4T7juXcvf4vdeAV2RKXYcI7/qYevS7+zWgUTfj6NPIN2vv+uef0Gw9oPy0qmP7hb6RZpCZIDtvTU9sHmvQriibdf0OYkvZ4Zngq3JkjFlcz0dqmvCx74=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780607873; c=relaxed/simple;
	bh=RVnNYNOJ1FTIsMw9RNesm8jAf8f6kcgDZRuHk9w/g6I=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GKZg2+icXCY6Z3vZslSTr2UCPlXudgQ18kbvt1vUmmrVtlpFqRGQ0cWoY4VP1wH0AS7Ez0sXWulFYtTkg1Kexg3E4JXFYNTmStlMKuqV4ER4mfBSOUqfWmJidYU3Kocex1AvTWZslK33Li79gyN+EFqlN4CVm2lrEd1UC9JZtcs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IUWP+aad; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IUWP+aad"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780607871; x=1812143871;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=RVnNYNOJ1FTIsMw9RNesm8jAf8f6kcgDZRuHk9w/g6I=;
  b=IUWP+aadfX04BRVrzePUJ8UeaaOo+g4Pt/yNIZZlVhtuJIigPSLwoQUV
   91KKNFALr45hE2w7sbxfCwDJ5/FbNeknvSBrqZE74kMlIX6ZixbIz8XHc
   zcIo2Mamy0I6N5h7LzpxsODCWSD7Kj63xUEznb8eoMXnSwvilIaiYjHR/
   iTbyT+jH22Vu9JA9EKsRVxNAZ4KpJ3Mmsbg1TdCrYbDUlNiS2lHA+xTSM
   FOFJaxhYO+CnXhtDSaw18WRPi4lEXtn27AcKFICvX93i2QK9CwlpBdk+l
   IAYzXIx7ZF39GmMk0tVkz+3tf3PQUyeUyG6Fm5tCSAgZyjR2bVk5Prlh7
   A==;
X-CSE-ConnectionGUID: xP4w244ORY+HanDJ8Ab88g==
X-CSE-MsgGUID: x1+w2XOkQ4WJacob8qPzog==
X-IronPort-AV: E=McAfee;i="6800,10657,11807"; a="92927257"
X-IronPort-AV: E=Sophos;i="6.24,187,1774335600"; 
   d="scan'208";a="92927257"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2026 14:17:50 -0700
X-CSE-ConnectionGUID: 2+oauu0fSFi7Q1QFV1gcPg==
X-CSE-MsgGUID: YRRGxNEkT1iV+5JoSyPbgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,187,1774335600"; 
   d="scan'208";a="246495201"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2026 14:17:50 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 4 Jun 2026 14:17:49 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 4 Jun 2026 14:17:49 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.11) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 4 Jun 2026 14:17:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fynLn/il5oGEk9bSpEQtllbIKudE5DKtHWOqRXoP9IWXxubpru3lsydH933s0D58YiT+m2zVv3TUQq4BN8/zRwjM4iFRVSw16Y1tm5NkoFjcd/YzdSOzyc0TWvj5egOFbewFN0hr5r0TMw3+tkk3CqZpg2pjiYXSmlq4O8fzpSVEs4Qk2ZDQNUTfsbpYTzU3GRrFzzyKqrNZ4s+c0MdRDwuMPUXBcuBXfdUkzY0o21XObGJ1uV1xI2PwsFDsgFqbYcae46vl7Iy/3oL1fH2+bT9/fFNvxwMW/wBILlFxjNJ4hRH+F2RanBoxx1P6Cktsm8se22zolCkyN2b5L+V82A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XoVz/cl5Rc3zDxn0n6Ky/UIi56Y+tt7ousXiSi3zBQk=;
 b=D+VgkQAIpwm1urfM1y7EkDePDCdMrRKdUV7gy2RYBdnfGXOLbUXsKukNLobSQ8cje7Hbb65p/x8hPvtlDzKs62i07R5vqWU5Ey/gOS0YGQ+MFZTejUViYq1CkHJ62zLEK3I0BI47RZTDJPghDiEBAy1JQwRDtlhhe+QUe+RbHhfemA7WWKQTFhb2XiHJmYdrxmbyfEFjCEMfeKNvq2rTW4ESyIARFpNeZLydINDoIDpF9a0oC4wYDDyX/voX5x9rZxDwLn3Pjr0UJ6tfk0ej27yLedUOqpPGwK3nojJBzEyWRP0xlSaIYqpBMU1heaXV1/b8FiaioKUk4dvTAj3aWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6407.namprd11.prod.outlook.com (2603:10b6:8:b4::11) by
 IA3PR11MB9086.namprd11.prod.outlook.com (2603:10b6:208:57b::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.8; Thu, 4 Jun 2026 21:17:44 +0000
Received: from DM4PR11MB6407.namprd11.prod.outlook.com
 ([fe80::26bd:1704:645f:7fd4]) by DM4PR11MB6407.namprd11.prod.outlook.com
 ([fe80::26bd:1704:645f:7fd4%5]) with mapi id 15.21.0092.006; Thu, 4 Jun 2026
 21:17:43 +0000
Date: Thu, 4 Jun 2026 22:17:38 +0100
From: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
To: Lukas Wunner <lukas@wunner.de>
CC: Bjorn Helgaas <helgaas@kernel.org>, Logan Gunthorpe <logang@deltatee.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>, <linux-pci@vger.kernel.org>,
	<qat-linux@intel.com>, Damir Chanyshev <conflict342@gmail.com>, Simon Richter
	<sjr@debian.org>, Tomasz Ossowski <tomasz.ossowski@intel.com>
Subject: Re: [PATCH v2] PCI/P2PDMA: Add Intel QAT, DSA, IAA devices to
 whitelist
Message-ID: <aiHrcj4TVkAEST5F@gcabiddu-mobl.ger.corp.intel.com>
References: <6aac4922b5fe7070b11874427a9285e42ddd05a4.1780585518.git.lukas@wunner.de>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <6aac4922b5fe7070b11874427a9285e42ddd05a4.1780585518.git.lukas@wunner.de>
Organization: Intel Research and Development Ireland Ltd - Co. Reg. #308263 -
 Collinstown Industrial Park, Leixlip, County Kildare - Ireland
X-ClientProxiedBy: DUZPR01CA0067.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:3c2::6) To DM4PR11MB6407.namprd11.prod.outlook.com
 (2603:10b6:8:b4::11)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6407:EE_|IA3PR11MB9086:EE_
X-MS-Office365-Filtering-Correlation-Id: 04ce1b79-5c5f-4287-47d3-08dec27eb75d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|22082099003|18002099003|3023799007|6133799003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: UEqwJuEM7oZdZoGW4+8I/oy1iplinKyRiC5g+fRjUNLl2JCtO23Z7I+wG28pRRR+rd4vAK2Q59c/boswog5o/vkRxSAzhB6E0fWTtG6j3uxzCbAGdqJZ+vBursZG+3vdzv/7YT2cXj8akhycQY+sEgHsJh1FziLK7NFLgPuDFnJemk1ONCFutFrzDQA+4G1F5FAhww+ywcJfsgDe3NEujYWilMCuYo6ht4Lau6PjNcvHpC1cokaKTPPcOjslSeFxhiyB+psHp3QkQhAgnhLjkJcuaRJCEovMjNTF8+8T1pmXLk7dNLC7wfe+X1Jm6EwMdmKDyfkM81R6opRetBw9WfSLGWp9vSFUA6zlfTgsWFVa6iomLAi1t9Aw5lCSDE5BpdYIdxRZx2Qswx4S9UIo0WvDcY5p8ecgskkMjHDeL153KULh9spbojFA+Nyy5OKzaHs+OVuQWWE+JzmAzRufxEE9/7MdXjKA+ZBVdSAnUkWTPBMTGMt8ZQ0v+klmHf3iPyCUQP3uXLGaGXVRqlC9MOYk7bBUtpaQfJJAG29YadEDZqdVi8lN21FuY6xa9/Z8e92Jpda0B+1q98N72PueRTBvnMTuoTSLCxLIVq7Op8w+iK8dOPc07DfgPDkrTeAKCwcB5NpxCW7vaYK1qztLYw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6407.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(22082099003)(18002099003)(3023799007)(6133799003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bz/h6l8LaDqHZ6EsPf1b5aaYrJ75awRWGo5zdOgnmLzq8OYtXstiWfPiEs7B?=
 =?us-ascii?Q?GCDKniD14ma0DeqOfFfO34uqy4XaXPB0egYaNv2pgQjEaA5zhW4zHt0lI0Jm?=
 =?us-ascii?Q?CMGzED5PUxvyaWsuU/xLDKoG4KdS4eIVUHMuj1SsK9jvBcmIgHBfXhX2yc1y?=
 =?us-ascii?Q?C7Chmj28owtTBp0JCKiZ+XQHTpTwVyHZuwEAISMpBBFzrt9jdDgbNn3MA5Pz?=
 =?us-ascii?Q?KjqJReCKQq3tlwl56XYwE49rwfCz4wxfwTUyQoaWUnmQpbEJFHRqFwzOQU89?=
 =?us-ascii?Q?afzin4kjwUuWyX4butzBYIXsWcQZqUlIj5a0f6I3RGS9Apz6CVkbGrJ2GVwU?=
 =?us-ascii?Q?Ypf7JyIz+ochwN6/F+u0ykFv4OgAFbwF5Zd3OFihK4LzyzjOl9AaZ6cj1pYn?=
 =?us-ascii?Q?1boaJht53/GKPACx7H2EOvqq5bZu/mPWuXKJZLHeit6kqh2HasgduK7dI1Im?=
 =?us-ascii?Q?1NFR5i9qLmMIMd+Oj036GebsVFE0a6pPmE1e/7/8SspzSUwEcoFr1iOD0SnE?=
 =?us-ascii?Q?XRSicL0RzDCfOaYAZ1NBENqikr6vord/Fd89CapqeQN7Dd15LSI0ZVPbYqor?=
 =?us-ascii?Q?xKFhjbzL8uKijojCR+6Ch0RyKXp1ju8RmPBRSdMsP45OIqw6kTv5o41yN/KD?=
 =?us-ascii?Q?LfvGNu9UO70+yU6myIT/H/vBIu7gmfteltGFIFZbiVjjFKxNHAsGfigbnSA3?=
 =?us-ascii?Q?QuUP1EEb5FdR3a3YJcc9JGtbRfz6pYA9zMHuXTRRRUbgdOFri60feiaTWIXd?=
 =?us-ascii?Q?mXV3g//rSFidlxtFqb/3dBOvj2wseZh6Q//r0spceOgWO2cqi5pQnf0YndBD?=
 =?us-ascii?Q?rSoTrIUCyTFfWLuIjhYf72ubbCkpJrGVHc/OoKXk5689AGlB8+Kxzi4hIZsd?=
 =?us-ascii?Q?HlbnOwYyeaPPorOOaOfPtvAaM9JI4cJZQAoRNXXuZQZio1cxmQ/Ym+XoinqC?=
 =?us-ascii?Q?UNwIFwNkPUOsh32V3k6nBV5QLcuLwawtmPzdRLqJ+mWbE/TlltfEIz7k3079?=
 =?us-ascii?Q?S4wj7QEVSXv53sqBA/rzZEsVF6lc+CtQXFUnTIGE+QyPxyqC8Eq4IKFzCRam?=
 =?us-ascii?Q?nG1Efil/39cPGneNnUKtt2xewvkzmELJkMG8rVTrRPjXiIhy1gqMH4Qyg6iJ?=
 =?us-ascii?Q?H5fn8EC0r+hjmlLCD99KyvTSHiAsNsO3DiHv8+eFDxjllIgdW5DuUu0m8fjN?=
 =?us-ascii?Q?lfdsG1FW6DamfG/0CmIFhn6T8J5MiTZMf3StN/FMpK6ORN83bk72EZFqc+4E?=
 =?us-ascii?Q?9q1EFj9VK7aXoXlhDSKpeQBmgQIeaTWbyTrxfsmDVwbcRgFEaKaD41NquI1r?=
 =?us-ascii?Q?U1z/ps90t0GjkAkdj3KBXRuIVvnxzHJlWGQgwzwUZKqW4icmecHwoPzraVlo?=
 =?us-ascii?Q?I3o7jv0ZSEeoi0fGMm4o2wSynERojncncB9qvvGyOD/hT9V+TVsxHEtcPCR0?=
 =?us-ascii?Q?+SKJ0J9g9GLlTt4hCbyfZQuXDfHkYRAZZk8riiStl+C37N/PSH4Xde0oE//A?=
 =?us-ascii?Q?j7j1xqC3tRiScEiPI3bic8mVovNJCdjXem1uBZKnckDzt0t5UymH2PO9is83?=
 =?us-ascii?Q?/LVvBbPQTNAgZm6jBJ2BDkMVbu6V34dLzqOpj+1aN9Ry6/p2Ifvi4UB5n0or?=
 =?us-ascii?Q?GIPAy49lT1vGDffHWZKka/kk2e6sm7b4OMifRyLSKapNdohaRQbVJurQbShB?=
 =?us-ascii?Q?6aDJwStIxCHeRM9/f+jWVj89ocPUT8USacnKzk9KVINivbU6u4K/WEjpYJKn?=
 =?us-ascii?Q?SxnNh6yuLKFcWt1xjvchW6J7lsZyS+w=3D?=
X-Exchange-RoutingPolicyChecked: kVPNBfGHJLUKud6RPkSaqVMBQA2jQRkS7804lo7iJoOOH9PW47mgWngHQ/jaBNWARjeL9CtY5IzQZpEimaBCOi5IrAXFtwCRhEFXi6TLOlxi/vfAD0P6pYqALmlQuFuhG0lCEgSrKXHt2YkIz4zSdzGpZBWvSxQsQzeEUy5YX0HU9IxVfAYMdpXZVf3285beYg5Nl5Wijssc/Sx1rmDojyftWEvnwjJ5GXVTJvopJ2i1Wf/WzNTs8MguoZzTMs7LlHM92JnmN2D1Hyad7lHQWWnb/C0jED/X/KO/16IiTvdtZggj8FWKq5gwZokFImIQ4bEPdb9UTMRWOzVfeWW1dw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 04ce1b79-5c5f-4287-47d3-08dec27eb75d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6407.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 21:17:43.3515
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HEP8m30MbS+dZQ6nh9FRXMKCY0vVRaeTqkDAu+rDH+97UbKSMs0zjKK99owMgKOikZdpail3z/9EPUUgUzBzSHDQPDzGL35ZxIOw936pypo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9086
X-OriginatorOrg: intel.com

On Thu, Jun 04, 2026 at 05:12:08PM +0200, Lukas Wunner wrote:
> The first device on a PCI root bus determines whether the host bridge is
> whitelisted for P2PDMA.  All Intel Xeon chips since Ice Lake (ICX, 2021)
> expose a device with ID 0x09a2 as first device.  It is loosely associated
> with the IOMMU.  All these Xeon chips support P2PDMA, so since the
> addition of the device with commit feaea1fe8b36 ("PCI/P2PDMA: Add Intel
> 3rd Gen Intel Xeon Scalable Processors to whitelist"), P2PDMA has been
> allowed on all new Xeons without the need to amend the whitelist:
> 
> Xeons with Performance Cores:
>   Sapphire Rapids (SPR, 2023)
>   Emerald Rapids (EMR, 2023)
>   Granite Rapids (GNR, 2024)
>   Diamond Rapids (DMR, 2026)
> 
> Xeons with Efficiency Cores:
>   Sierra Forest (SRF, 2024)
>   Clearwater Forest (CWF, 2026)
> 
> However these Xeons also expose accelerators as first device on a root bus
> of its own:
> 
>   QuickAssist Technology (QAT, crypto & compression accelerator)
>   Data Streaming Accelerator (DSA, dma engine)
>   In-Memory Analytics Accelerator (IAA, dma engine)
> 
> Whitelist them for P2PDMA as well.  Move their Device ID macros from the
> accelerator drivers to <linux/pci_ids.h> for reuse by P2PDMA code.
> 
> Unfortunately the Device IDs vary across Xeon generations as additional
> features were added to the accelerators.  This currently necessitates an
> amendment for each new Xeon chip.
> 
> For future chips, this need shall be avoided by an ongoing effort to
> extend ACPI HMAT with PCIe P2PDMA characteristics (latency, bandwidth,
> ordering constraints).  The PCI core will be able look up in this
> BIOS-provided ACPI table whether P2PDMA is supported, instead of relying
> on a whitelist that needs to be amended continuously.
> 
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Cc: stable@vger.kernel.org
For QAT:
Acked-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com> # QAT

Regards,

-- 
Giovanni

> ---
> Changes v1 -> v2:
> * Drop code comments associating QAT generation with CPUs because a
>   QAT generation can go to different CPUs or plug-in cards (Giovanni)
> 
> Link to v1:
> https://lore.kernel.org/r/4ea5265495876beb5fb5e6d479b2782f882bcbb3.1780570508.git.lukas@wunner.de/
> 
>  drivers/crypto/intel/qat/qat_common/adf_accel_devices.h |  5 -----
>  drivers/dma/idxd/registers.h                            |  3 ---
>  drivers/pci/p2pdma.c                                    | 10 ++++++++++
>  include/linux/pci_ids.h                                 |  8 ++++++++
>  4 files changed, 18 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/crypto/intel/qat/qat_common/adf_accel_devices.h b/drivers/crypto/intel/qat/qat_common/adf_accel_devices.h
> index 03a4e96..cbd1d1e 100644
> --- a/drivers/crypto/intel/qat/qat_common/adf_accel_devices.h
> +++ b/drivers/crypto/intel/qat/qat_common/adf_accel_devices.h
> @@ -28,15 +28,10 @@
>  #define ADF_4XXX_DEVICE_NAME "4xxx"
>  #define ADF_420XX_DEVICE_NAME "420xx"
>  #define ADF_6XXX_DEVICE_NAME "6xxx"
> -#define PCI_DEVICE_ID_INTEL_QAT_4XXX 0x4940
>  #define PCI_DEVICE_ID_INTEL_QAT_4XXXIOV 0x4941
> -#define PCI_DEVICE_ID_INTEL_QAT_401XX 0x4942
>  #define PCI_DEVICE_ID_INTEL_QAT_401XXIOV 0x4943
> -#define PCI_DEVICE_ID_INTEL_QAT_402XX 0x4944
>  #define PCI_DEVICE_ID_INTEL_QAT_402XXIOV 0x4945
> -#define PCI_DEVICE_ID_INTEL_QAT_420XX 0x4946
>  #define PCI_DEVICE_ID_INTEL_QAT_420XXIOV 0x4947
> -#define PCI_DEVICE_ID_INTEL_QAT_6XXX 0x4948
>  #define PCI_DEVICE_ID_INTEL_QAT_6XXX_IOV 0x4949
>  
>  #define ADF_DEVICE_FUSECTL_OFFSET 0x40
> diff --git a/drivers/dma/idxd/registers.h b/drivers/dma/idxd/registers.h
> index f954113..1dce26d 100644
> --- a/drivers/dma/idxd/registers.h
> +++ b/drivers/dma/idxd/registers.h
> @@ -10,9 +10,6 @@
>  #endif
>  
>  /* PCI Config */
> -#define PCI_DEVICE_ID_INTEL_DSA_GNRD	0x11fb
> -#define PCI_DEVICE_ID_INTEL_DSA_DMR	0x1212
> -#define PCI_DEVICE_ID_INTEL_IAA_DMR	0x1216
>  #define PCI_DEVICE_ID_INTEL_IAA_PTL	0xb02d
>  #define PCI_DEVICE_ID_INTEL_IAA_WCL	0xfd2d
>  
> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
> index 7c89854..206e3fe 100644
> --- a/drivers/pci/p2pdma.c
> +++ b/drivers/pci/p2pdma.c
> @@ -548,6 +548,16 @@ static bool cpu_supports_p2pdma(void)
>  	{PCI_VENDOR_ID_INTEL,	0x2033, 0},
>  	{PCI_VENDOR_ID_INTEL,	0x2020, 0},
>  	{PCI_VENDOR_ID_INTEL,	0x09a2, 0},
> +	{PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_DSA_SPR0, 0},
> +	{PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_IAX_SPR0, 0},
> +	{PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_DSA_GNRD, 0},
> +	{PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_DSA_DMR, 0},
> +	{PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_IAA_DMR, 0},
> +	{PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_QAT_4XXX, 0},
> +	{PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_QAT_401XX, 0},
> +	{PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_QAT_402XX, 0},
> +	{PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_QAT_420XX, 0},
> +	{PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_QAT_6XXX, 0},
>  	/* Google SoCs. */
>  	{PCI_VENDOR_ID_GOOGLE,	PCI_ANY_ID, 0},
>  	{}
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index 24cb42f..1c9d40e 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -2732,6 +2732,9 @@
>  #define PCI_DEVICE_ID_INTEL_82815_MC	0x1130
>  #define PCI_DEVICE_ID_INTEL_82815_CGC	0x1132
>  #define PCI_DEVICE_ID_INTEL_SST_TNG	0x119a
> +#define PCI_DEVICE_ID_INTEL_DSA_GNRD	0x11fb
> +#define PCI_DEVICE_ID_INTEL_DSA_DMR	0x1212
> +#define PCI_DEVICE_ID_INTEL_IAA_DMR	0x1216
>  #define PCI_DEVICE_ID_INTEL_82092AA_0	0x1221
>  #define PCI_DEVICE_ID_INTEL_82437	0x122d
>  #define PCI_DEVICE_ID_INTEL_82371FB_0	0x122e
> @@ -3052,6 +3055,11 @@
>  #define PCI_DEVICE_ID_INTEL_5400_FBD1	0x4036
>  #define PCI_DEVICE_ID_INTEL_HDA_TGL_H	0x43c8
>  #define PCI_DEVICE_ID_INTEL_HDA_DG1	0x490d
> +#define PCI_DEVICE_ID_INTEL_QAT_4XXX	0x4940
> +#define PCI_DEVICE_ID_INTEL_QAT_401XX	0x4942
> +#define PCI_DEVICE_ID_INTEL_QAT_402XX	0x4944
> +#define PCI_DEVICE_ID_INTEL_QAT_420XX	0x4946
> +#define PCI_DEVICE_ID_INTEL_QAT_6XXX	0x4948
>  #define PCI_DEVICE_ID_INTEL_HDA_EHL_0	0x4b55
>  #define PCI_DEVICE_ID_INTEL_HDA_EHL_3	0x4b58
>  #define PCI_DEVICE_ID_INTEL_HDA_WCL	0x4d28
> -- 
> 2.51.0
> 
