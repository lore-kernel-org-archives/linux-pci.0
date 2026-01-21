Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E29E02E8B8D;
	Wed, 21 Jan 2026 01:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768958406; cv=fail; b=rNDGDzbPjBO4VDGvIiWQMtiy1DNEymBd3GbXFiJBLI6Lsfk4n9CudIG+S9t0hUIJnYbm4pidOiZaw1eJkB62YzXUR9dPLbpHQ6/KIDWXvsJf312LYBpjSmh61TnAf5p7aRZBRVBc9Qw/4QPhFnLxUqX+CV+Jah/2tyAsTnDHmdg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768958406; c=relaxed/simple;
	bh=Tn1mzhn7x05JuaFafiCYxOuMXxMDQrUyRFno65lwve4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bKs/P1kjONaaTpEGMPzz2UGEhfg/4mshlLuGtD/PzCfkmJsa2H9IkT7SPrnbsr/CpyUs4pw9TZ/+DXiwE2OqDPZIGnq3dOMDkMOpeg0+h8MhQSMUpnUpyY6e2DevsFaQZKeK4myLeM2LdTu1TluF9Od78T916VrbBsFZYsY/WjM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U1oyvZMG; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U1oyvZMG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768958405; x=1800494405;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Tn1mzhn7x05JuaFafiCYxOuMXxMDQrUyRFno65lwve4=;
  b=U1oyvZMGwvdrB/bYr4uGwJ4V3vAMkkAI7FBJ9Eyv+mRdyro3tUy01txh
   gaNizC0y+JtqdT/f5UZrWN4Y/Br6Y0dcrPfVIkEIevB7Q1ksL48xWjskF
   OUfygRNRaqcdNnj2scdvsng/l6/Az+f1r0Cqg+iywbXk8SGVClDRjpKg2
   6W28Ma342xk/kyhJw5/I8M5djnwxZZv1qMKIe6ua9sL3ekPWsRTAxd8bK
   4APpWhvjdzcWAO9rFYcrEAn4XHozhnrq5pQ6C6lwacPqANt7WeIdE2dnh
   WFKmM9aORROhbQusdq5Sk6qspVM4vOnNIsjcymRLwYzXZ8b1R7VPOX6s7
   A==;
X-CSE-ConnectionGUID: XewUdM9ARO6W+uqJncWoTQ==
X-CSE-MsgGUID: N6SCNdGYTNeeeGrGWoC5qA==
X-IronPort-AV: E=McAfee;i="6800,10657,11677"; a="74049001"
X-IronPort-AV: E=Sophos;i="6.21,242,1763452800"; 
   d="scan'208";a="74049001"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2026 17:20:04 -0800
X-CSE-ConnectionGUID: /4HQLl9sQ2iRPZgS22pfbg==
X-CSE-MsgGUID: aUa9DZzAQj2+KmSfaE/gnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,242,1763452800"; 
   d="scan'208";a="211296511"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2026 17:20:03 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 20 Jan 2026 17:20:02 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Tue, 20 Jan 2026 17:20:02 -0800
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.63) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 20 Jan 2026 17:20:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OXCpWdnu6kRCx0NBfQI7WC189NIhgxLTp7ycdsT7uks9Fx6D8fU3gmj5aO5dUenDWu4QUgoVg9wqMXDjCsmIb9PvPYLsq7Lf/NeFXoDtIOGBrQpjp2FzaKKd73Kug0XSFVSp3LXZReKjvwezEZ+Umc44gdwc/OLj87XIERye6pITKTqU626DuatKHdT8c3V66vn/Kv26pYqeLilNLYj6tYEaT2PK/HAs8OTPNzYOhVdeS7ec576Hg4hvYwX3BYnxiGYZDvVNzFb1HuER/KU+VNLoaAr+pkG/yyy2mYCoKZJlYIaWU6kDgWR4hQ4pZmZX6iEyrTntY77KB4tE8Qprug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zHEP8KGdz+eUMNimEpHgyaVDyasRKBlaqoieB3sbYio=;
 b=S+hoa7PbNlQ8yrfUKSYI9grKdoO6UFawOiy6nUNaZITQiePq9k9jB7XxG0zT0/dGUaQEHjHmYOqNcOVkeBsxPX7NpP76nJPp4PgMTHE+g9OnmI0p3PIIynlo2c6lhEqQoQyNXYm3GIyNXNWykLT31ZezP2vR7gKhntB4DtMWfKqbRNw2byL+1P1HFHPYFyxMtD+dT30XSl4C+GOW9ptft+YP6K7kYq9f8j7wCMDvj0LN/couinE0edIYGlasCfuD3te0TCuvQM7wYFFbzB4KWzDJHeSFO9U5TI8MMzdmF1hWKDPK0FYl6eb4NU0qKJs2Pue9/SfX1jPo8MaPZWvNTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by MW3PR11MB4620.namprd11.prod.outlook.com (2603:10b6:303:54::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 01:19:59 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::46c9:7f71:993d:8aee]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::46c9:7f71:993d:8aee%8]) with mapi id 15.20.9542.008; Wed, 21 Jan 2026
 01:19:58 +0000
Date: Tue, 20 Jan 2026 17:19:54 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: <smadhavan@nvidia.com>
CC: <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<dave.jiang@intel.com>, <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <ming.li@zohomail.com>,
	<rrichter@amd.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<huaisheng.ye@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <vaslot@nvidia.com>, <vsethi@nvidia.com>,
	<sdonthineni@nvidia.com>, <vidyas@nvidia.com>, <mochs@nvidia.com>,
	<jsequeira@nvidia.com>
Subject: Re: [PATCH v4 0/10] CXL Reset support for Type 2 devices
Message-ID: <aXApuuLZOiZBGVtJ@aschofie-mobl2.lan>
References: <20260120222610.2227109-1-smadhavan@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260120222610.2227109-1-smadhavan@nvidia.com>
X-ClientProxiedBy: SJ0PR13CA0213.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::8) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|MW3PR11MB4620:EE_
X-MS-Office365-Filtering-Correlation-Id: bd89bbf8-4a3b-4018-f66a-08de588b317b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ATIUSWIBUbFxnmmjx8emTsFCnggcU9ll4JouhKRiwtdIDHrT2sN6GDRdXfSB?=
 =?us-ascii?Q?Wcq6921sBnl7/5R7nR3BVSbNGzdvbG5WBXIRV1DbNkMdLfJ4ryJbdIqU+un/?=
 =?us-ascii?Q?LMhkDSzcFZurK3IaBAHMenTgE7IQk3vq9pqIQ5ExJnP7LvkzTNmwJ6rpPD0y?=
 =?us-ascii?Q?SN0XuRyUNZTtEvHf40Yus/jBqZreHFJmu4X9RLDdRgmyXln6URdTrEJh7fSI?=
 =?us-ascii?Q?p6ysDToAVM7rfclYsz3y7Y8bvU+TFPzLzpw6HcNJ05BRb9QgY3nD6z6/5JGV?=
 =?us-ascii?Q?1ziLAkQGq9DsSdJNdB4ORLvUE/6kBTQF8FVPs+WHNbR741aWfyUVZ32CegOf?=
 =?us-ascii?Q?GXNs4P5IMVPrGDvTtyxmfMWfF0cgddAUbIJzLxDTb7A/CRSbuIMDkMmRbfp3?=
 =?us-ascii?Q?BR3Aj6qXw9XMSVwFf9qr+BcV/bCkkQRlka5zSWdL+iTf7stU5LEm94AMJ0XH?=
 =?us-ascii?Q?MUglce0aqIMSCqluJKzgUMpY6kEcUwo/5OQkJbfXvk1FgQkXE4+/R3BGdlxM?=
 =?us-ascii?Q?xkp2z689a/W1KARkVJOaO+GnO5mlBlBzBkRJ26FZE9o1V6Hd4DGAAIuCQjyv?=
 =?us-ascii?Q?peFDO5ZMfpGkbwbsIKG642gLUwlpHHllYycm3JONvyyMlqsT5VNYxK57m/Fo?=
 =?us-ascii?Q?1DUvM3eMURsmRjKjwl16bZKbQRxVEN20qI0HO+DYIVHV+MDx/NQpk5gXIbBL?=
 =?us-ascii?Q?Mh8q3q7e0GEbd+9iiOPQgYVaIV31O3BofNUtpooKT15ZMLBtKwPSqXFOWKK4?=
 =?us-ascii?Q?mM4Bub2p1EvV8MdVa7sakPbz3Wqqo8kBch63UYWr8641gId1MSMRNaAV11vA?=
 =?us-ascii?Q?EsVSFGuh1NXEMfylWOC6P63DNY2PsvopMArYFFzYqmGHhEMrK3sJfcUbQ2Cv?=
 =?us-ascii?Q?35cpKQEfYJnJvlHBmA+L2p6+Ki9AAION4oX7vhzaOmm9bP+oaL3NyJjrMAUh?=
 =?us-ascii?Q?d1BStUVoh/O9ihof6mnqIDIvsU/sChZ92gFPVM9lCBIJBbVTKYa+mao9itJC?=
 =?us-ascii?Q?IPp1cHlcPcwU2uG3u5CkW+Y6zL17Cg8blstM3C8hwl8Cn1au/JSPu/h1+Pfm?=
 =?us-ascii?Q?46uuOc9kQq7c1IX9COxcQOX3JvZJ8sMO06SAg1pYrLiH/4W2bcdEWq/Q8TfP?=
 =?us-ascii?Q?ccJeWffsw69kJyUc5p6FXiFhSuFVUGT3KlcWoZVLoka1FupkAijYDO8J1YB0?=
 =?us-ascii?Q?tC0VAuHhjajwlswGopiP4W7yk9dbvHerX0k5/P/D49XtrTKpApleVHJUaOd3?=
 =?us-ascii?Q?YOtQKUb9YyRj5yTGfRPtzwlJIz3BodwCbkFARBEEDhDDZPwQm/fazwpMtil6?=
 =?us-ascii?Q?caWnkhb+wVj+EZkP2VtJ4rlXHInj8XFqHsQ9m7eJOXpHwWC74q8YLvJtFhqI?=
 =?us-ascii?Q?EgyYc5PbgJ4nF2GsRpZ7k9EduCCdBigHpkkfNcnLXD8Czl25URPSIvvk9Loc?=
 =?us-ascii?Q?YxDFH6G81G6ZBLn1FlvoAQH6y6q7dhcjBYz7OO8QtHH6HLfvfiHfLuhMpxL7?=
 =?us-ascii?Q?RsYjfERC02zeDrkREdA34zzAGODGGP8q7xmzwMnK+dNxOWsuNocGGxqGntws?=
 =?us-ascii?Q?XAbLxUJnBytlA5o1xumvXCaXt+7Bj9OWLSXKlDt2?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rhg9BtCWmu0k9z/LVZIa75y1OTcZG1pAgM0XuxYkY624f8in7Kwhx/I2gTfe?=
 =?us-ascii?Q?LRaGz3wWpYCzVorMV4xslyBSp333DoS04ffD2jHJ7kNv/RrWIsSoViMuCy32?=
 =?us-ascii?Q?is6Jo92jbcVdKwUeCAkWlrhSdphQHkM9+/EtVE1LllBRjn4mycp2dl5tunC7?=
 =?us-ascii?Q?bPOPGsx1nsoNW+0N7QOJevDNK5ShgJngVDVzDANQJ74RrPAyMjGtD6wgxIZz?=
 =?us-ascii?Q?wrmyIUrjO2F3gPyceyh2FgPxY+GpnmK5qL39eWQpRW1rYLcBQ53wdlnW5sdR?=
 =?us-ascii?Q?CCc0X/UqDcNN7zxqNn0IvN37fMdTn2K9REdaC5SYmIjG9lGcJ9EUC+GCz1u1?=
 =?us-ascii?Q?DXvLbMjnzMV5Vi7cmCEyRzm4Nq8XPQUL0P2LQHpNLPeBYbqO0789jMYUG3QU?=
 =?us-ascii?Q?GnRxSGx9GAaB/PLhBwD1Y7JxkMmvZA8vUO7UWrFcLUOtx0Q3RpWWJK/YSDgl?=
 =?us-ascii?Q?f4jS+EqEKVHF+GD7MzQtx5eE8MttPk61wxURpC6CcuYJ/JmlNlFUt4Vtk2ls?=
 =?us-ascii?Q?g0wlLwV5euKwygA+Jg2WrxRnFOdOl0rvsiByvuHZDaOzkCnAyHdlZ/u0Cna2?=
 =?us-ascii?Q?AmfVsv0CYb4h47jTkZOJKEVDQRNEvouZcob4+2GGqisJUeD0l2JoZ88ZRyzo?=
 =?us-ascii?Q?3GA1Ls3YxI7ZEfV+MCpdM9S81+YeIELFl6kAaH6EHzqkMalpJCw07i79SXeA?=
 =?us-ascii?Q?IlLJSX3IqT87M2TqwKiIBBPJhmU1ht6cxPUQUXUPpUMW3YDF5+dMhT8xXJMY?=
 =?us-ascii?Q?xijGuOmCMVCC2i5ib4hWdPijUkl1hJd51uWc63me/F9Y895dxMXYWm84mTid?=
 =?us-ascii?Q?2ax4tYk7Mur1iJ7GeOXWSnOCi7ufSu4PnOhPMH65YgpKerHpgvU06rugd3b8?=
 =?us-ascii?Q?e5bglpHTxsOhL8qFVO92JDScpBGaJg9CVBTwe3K8Br70mEHt3nJ1u/wjspGD?=
 =?us-ascii?Q?FNEA4AAZ7K6TCCTDiTDNI7Ri1J6BWLcZ+CF9xNlZAqbojuD0sT+c0QAIqTys?=
 =?us-ascii?Q?y6W9ZAdaKH4dH6xY2xh0KaqY2leeT74fNeOA40OO1bD2MOIB6QhcixbonXDp?=
 =?us-ascii?Q?evLn2jppJayk56lJmdTDgTs58Q0Hrgrjdy4WkwtR6Q6OcergLvsbGj6VADea?=
 =?us-ascii?Q?O/FDFxEdG5CnvAUE3Yy5onsb5CWlGnVbJcVw8s8qbqN5Lv+ZZ3lC59/8J/zR?=
 =?us-ascii?Q?upf3wolbC0ZrfTUYzvL3ljaWK5jNuSWTu9yBzHuEkiOphTef+cJ96Uvs1Mdo?=
 =?us-ascii?Q?5NgY6TghspN3KOu2ko3vcpv8ksQeW4wA8vW1x1dEa+oRAb6kz2Q/8Re0q4+M?=
 =?us-ascii?Q?BEW2e+KYRSSIBQTFvtzmdcOvOE1rLtOVsKKbpTTj2VaODbyyK/P1Wfd7D2ni?=
 =?us-ascii?Q?Tih/GPnAnnBwpNRlXqf3qCuP/yjbAhvj4mYdd8pcHP6/s/aPfrak6snO4gA6?=
 =?us-ascii?Q?pyv4yt0cn3EENvJdnq83A+D3O2K6/700LO9pVgqSQQthMAUrPrJ+WZXLBDaJ?=
 =?us-ascii?Q?xopifZm6CAfAWrajY04yCM3r5wzpfxCjyk3vdF+r7UpwF4hah2VohabpJFUe?=
 =?us-ascii?Q?q+BBbkM5JCuFvXvJHiEYa22ChyS8CPDJaQgNdvWBErNP/UCASxM0Pf8R08Xn?=
 =?us-ascii?Q?RTvZNkqZ9i2FAcLucy8cZd3s1rE1cH0yBATP9mWiE33RdyzuDzfLyeM+Cixy?=
 =?us-ascii?Q?/D1nK37kapMcEo1a5dHJEEs01pyCEku8lVpDvhzlHLc984Pk1802d+ATgVa8?=
 =?us-ascii?Q?NQvZzAiCIzhPdgi9kQp7AoEtrHpqNrE=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bd89bbf8-4a3b-4018-f66a-08de588b317b
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 01:19:58.8752
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P34unqcZlbwHw88ZRSZEWn7xqOy0Kfy301PlcStGbKXcNvtt5snLJ4x4f6c+ykNgVB2bQJHs5uldJ7eHZNgbAsrdwB9b/zkwoO/5NyZEeUI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4620
X-OriginatorOrg: intel.com

On Tue, Jan 20, 2026 at 10:26:00PM +0000, smadhavan@nvidia.com wrote:
> From: Srirangan Madhavan <smadhavan@nvidia.com>
> 
> Hi folks!
> 
> This patch series introduces support for the CXL Reset method for CXL
> devices, implementing the reset procedure outlined in CXL Spec [1] v3.2,
> Sections 9.6 and 9.7.

Hi Srirangan,

Following-up on the base commit for this patch. For the cxl subsystem,
a patchset today is expected to be based on 6.19-rc4 (or rc5 or rc6).
We get to that because our cxl/next is based on rc4. We ask folks not
to base on cxl/next because we want to see conflicts between patchsets.

I like to use the base commit option to automatically append it to
the cover letter, but you can just state it in the change log if your
method of sending patches doesn't support that.

With this set, there is something else that you are depending upon.
Please call that out and point to the commits in some way so we can
build on 6.19-rc4 plus those commits plus this patchset.

Thanks!
Alison

> 
> v4 changes:
> - Fix CXL reset capability check parentheses warning
> - Gate CXL reset path on CONFIG_CXL_PCI reachability
> 
> v3 changes:
> - Restrict CXL reset to Type 2 devices only
> - Add host and device cache flushing for
>     * all sibling functions on multi-function devices
>     * all sibling devices in a given region
> - Add region teardown and memory online detection before reset
> - Add configuration state save/restore (DVSEC, HDM, IDE)
> - Split the series by subsystem and functional blocks
> 
> v2 changes:
> - De-duplicate CXL DVSEC register defines under include/cxl/pci.h
> - Fix style-related issues
> 
> v1 changes:
> - Added cover letter and dropped the RFC
> 
> The RFC patches can be found here [2]
> v2 patches can be found here [3]
> 
> Motivation:
> -----------
> This change is broadly useful for reasons including but not limited to the
> following:
> 
> - As support for Type 2 devices [4] is being introduced, more devices will
>   require finer-grained reset mechanisms beyond bus-wide reset methods.
> 
> - FLR does not affect CXL.cache or CXL.mem protocols, making CXL Reset
>   the preferred method in some cases.
> 
> - The CXL spec (Sections 7.2.3 Binding and Unbinding, 9.5 FLR) highlights use
>   cases like function rebinding and error recovery, where CXL Reset is
>   explicitly mentioned.
> 
> Change Description:
> -------------------
> 
> Patch 1: Move CXL DVSEC defines to the CXL PCI header
> - Consolidate DVSEC register definitions under include/cxl/pci.h
> 
> Patch 2: Switch PCI CXL port DVSEC defines
> - Use the shared CXL PCI header in the PCI core
> 
> Patch 3: Add Type 2 helper and reset DVSEC bits
> - Add helper to identify Type 2 devices
> - Define DVSEC reset/cache control bits
> 
> Patch 4: Add the CXL reset method in the PCI core
> - Implement cxl_reset() method with capability checks and reset sequence
> - Restrict to Type 2 devices
> 
> Patch 5: Add reset preparation and region teardown
> - Implement region validation and teardown before reset
> - Add device cache flush for all sibling devices in a given region
> 
> Patch 6: Wire CXL reset prepare/cleanup in PCI
> - Call CXL reset prepare/cleanup around the core reset flow
> 
> Patch 7: Add host CPU cache flush and multi-function support
> - Add host CPU cache flush (x86: wbinvd, arm64: dcache_clean_inval_poc)
> - Add device cache flush for all sibling functions on multi-function devices
> 
> Patch 8: Add DVSEC configuration state save/restore
> - Save/restore DVSEC registers (DEVCTL, DEVCTL2) with CONFIG_LOCK handling
> 
> Patch 9: Save/restore CXL config around reset
> - Save PCI and CXL config before reset and restore afterwards
> 
> Patch 10: Add HDM decoder and IDE state save/restore
> - Save/restore HDM decoder and IDE register state
> 
> The reset sequence: validate device type, check memory offline, tear down
> regions, flush host CPU caches, flush device caches (all functions), save
> config state, initiate reset, wait for completion, restore config state.
> 
> Command line to test the CXL reset on a capable device:
>     echo cxl_reset > /sys/bus/pci/devices/<pci_device>/reset_method
>     echo 1 > /sys/bus/pci/devices/<pci_device>/reset
> 
> [1] https://computeexpresslink.org/cxl-specification/
> [2] https://lore.kernel.org/all/20241213074143.374-1-smadhavan@nvidia.com/
> [3] https://lore.kernel.org/all/20250221043906.1593189-1-smadhavan@nvidia.com/
> [4] https://lore.kernel.org/linux-cxl/20251205115248.772945-1-alejandro.lucero-palau@amd.com/
> 
> Srirangan Madhavan (10):
>   [PATCH v4 1/10] cxl: move DVSEC defines to cxl pci header
>   [PATCH v4 2/10] PCI: switch CXL port DVSEC defines
>   [PATCH v4 3/10] cxl: add type 2 helper and reset DVSEC bits
>   [PATCH v4 4/10] PCI: add CXL reset method
>   [PATCH v4 5/10] cxl: add reset prepare and region teardown
>   [PATCH v4 6/10] PCI: wire CXL reset prepare/cleanup
>   [PATCH v4 7/10] cxl: add host cache flush and multi-function reset
>   [PATCH v4 8/10] cxl: add DVSEC config save/restore
>   [PATCH v4 9/10] PCI: save/restore CXL config around reset
>   [PATCH v4 10/10] cxl: add HDM decoder and IDE save/restore
> 
>  drivers/cxl/core/pci.c        |   1 +
>  drivers/cxl/core/regs.c       |   8 +
>  drivers/cxl/cxl.h             |   4 +
>  drivers/cxl/cxlpci.h          |  53 ---
>  drivers/cxl/pci.c             | 621 +++++++++++++++++++++++++++++++++-
>  drivers/pci/pci.c             | 150 +++++++-
>  include/cxl/pci.h             | 134 ++++++++
>  include/linux/pci.h           |  21 +-
>  include/uapi/linux/pci_regs.h |   5 -
>  9 files changed, 929 insertions(+), 68 deletions(-)
>  create mode 100644 include/cxl/pci.h
> 
> --
> 2.34.1
