Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 863633246F4;
	Mon, 18 May 2026 06:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779086832; cv=fail; b=V7Ot+6nANy3qiL7zaUlWABbhcXoYKQCHz1d+2ND3r3LhnoDOmUqea81YErwLJMMuwlMaP3qMlhFVA+x6bKBKwHOPOYnEaXXttKV8wLr/HzXiD3o0M45r2wWLB3HQMiFYzQVmgADufzdIvufM7ROGhvfveDDHb0IjQdywtQ3iZBU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779086832; c=relaxed/simple;
	bh=voRFDui54G0jjep6oJLXjGS3hq83yKFDlZDHp5/7Cp4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CV2etdsfVhPs7k13s7sBGSxD4ueHgOIXcgqEhVzMWGn0RJeJ9Rx9XhxxK281sFm031cvwERAI/i5M9pqtKVEhRJVlwWRctpxrVftCLt15sNRQF7EP4Eh3AZdKBPHb8o6ocKDuRZpFLt+kiAgvV8ma6FCeAzBKOubWORtH1l3oD0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OsRX1vKk; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OsRX1vKk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779086830; x=1810622830;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=voRFDui54G0jjep6oJLXjGS3hq83yKFDlZDHp5/7Cp4=;
  b=OsRX1vKkxbscKPiJX2Stu5FtRSTfS1whOh6OwBgvbDaw2S7GjSsV4EHN
   jhUc0ujCrdsQUmXZg63mOgVi9yf+pY4yl99UJ2SiArj889iTdotwZIonc
   NZPOt7+Y6+Xep/MKa3Y/l7okO6+aUQOhPMsC7K3q1k+F3seNETCGR+5k1
   8C73+Ktea/otQsRH8mWb0mJNduyZAOgaGOpb8r5ev3y8L87SgR9SwVay5
   6/rQDZCYezIdOZT3r3F7jxzQN4Y1R/u1TK/DbAlVDWvdwmvabc/CmpwY8
   WQC4A90G1raeTZ2JqGIXC+Mo+OhePtz4/zDZmVivwPwUEMXlIG0p2zLTa
   A==;
X-CSE-ConnectionGUID: /NH6e+wDTJqr5CNH5s2ZfA==
X-CSE-MsgGUID: bBvY87N5TMuVYTVKelDXhQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11789"; a="79831354"
X-IronPort-AV: E=Sophos;i="6.23,241,1770624000"; 
   d="scan'208";a="79831354"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2026 23:47:10 -0700
X-CSE-ConnectionGUID: DHA6ngw5TGaeXuJmyJ+6XQ==
X-CSE-MsgGUID: 3oty11D0TT6mYeeCaAt5EA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,241,1770624000"; 
   d="scan'208";a="238341579"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2026 23:47:10 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 17 May 2026 23:47:09 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Sun, 17 May 2026 23:47:09 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.46) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 17 May 2026 23:47:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XIfAPlAwnx4XFDL6z1B7a9UbdESwqblSq8RF3LnaRT2qhCwfe0zr5s61rmTj3ThE7MImoX0Rsg38rwTzabmJlSFzHL0b30Gigg3XDGbgYNRBccF+A+OSopR1WmVxILsYWwMqrOOhXAOP5A0FWYfPNG83PhiYnABgS6IcatJJBkogX9ft4MKm3cElqeMfvMIGTuiCtye1ORGivIrg8EMRWn1/1XCKH8KIyFzGh9y9a97d6IFKXAr07E7VwxJ9WjGCi/AglaYlHCm3hLanyYrHY96Nxy7zpElLmwpVMtQvDaZ+rosu4COqQ1/Ts8/qItZmxd0nVXEP4IKd7gTPYGPVzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S9Ik9YgQytnutLtc3aFSD9OJcPvX1TB69A3dejijhVs=;
 b=fodudrnkHj1BPAvDvpnCorXIwDwcR6nyl+Do3CXxyaYpsxyWlq3OlTD1OCwhJbT+S/MOxhdjeT+oMxQxPLP0CXQ97t/hk21vA1oHnR+i2DAZRXmPMoMmEB8IXL0WvxfnrMZtb138bFtSciDufXA8YJ8M4nOpVbVZiY2qX+OznZ39PHT/kja/vivsJ3Y8boptltAH4nicLKFeFz7Sdp672BEydLRE6aX15jmI36D9gKiBFcsyz9YLuW0psUS9FDGPfBSenlHppDNUCYul7xOujSxUjnuT4CyZ3L8RWqKFNKkOM9T4eCcABw8cWJr4s7nzYGZ8pGmdkgqUUSloaMtpDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
 by DS0PR11MB7850.namprd11.prod.outlook.com (2603:10b6:8:fe::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Mon, 18 May
 2026 06:47:06 +0000
Received: from SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::2edd:5c6d:169c:389b]) by SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::2edd:5c6d:169c:389b%6]) with mapi id 15.21.0025.022; Mon, 18 May 2026
 06:47:06 +0000
Date: Mon, 18 May 2026 08:46:48 +0200
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <andrew+netdev@lunn.ch>, <netdev@vger.kernel.org>,
	Tony Nguyen <anthony.l.nguyen@intel.com>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <andrew+netdev@lunn.ch>, <netdev@vger.kernel.org>,
	Phani R Burra <phani.r.burra@intel.com>, <przemyslaw.kitszel@intel.com>,
	<aleksander.lobakin@intel.com>, <sridhar.samudrala@intel.com>,
	<anjali.singhai@intel.com>, <michal.swiatkowski@linux.intel.com>,
	<maciej.fijalkowski@intel.com>, <emil.s.tantilov@intel.com>,
	<madhu.chittim@intel.com>, <joshua.a.hay@intel.com>,
	<jacob.e.keller@intel.com>, <jayaprakash.shanmugam@intel.com>,
	<jiri@resnulli.us>, <horms@kernel.org>, <corbet@lwn.net>,
	<richardcochran@gmail.com>, <linux-doc@vger.kernel.org>,
	<bhelgaas@google.com>, <linux-pci@vger.kernel.org>, Bharath R
	<bharath.r@intel.com>, Samuel Salin <Samuel.salin@intel.com>, "Aleksandr
 Loktionov" <aleksandr.loktionov@intel.com>
Subject: Re: [PATCH net-next v3 02/14] libie: add PCI device initialization
 helpers to libie
Message-ID: <agq12NHTD4Tz6kwN@soc-5CG4396X81.clients.intel.com>
References: <20260515224443.2772147-1-anthony.l.nguyen@intel.com>
 <20260515224443.2772147-3-anthony.l.nguyen@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260515224443.2772147-3-anthony.l.nguyen@intel.com>
X-ClientProxiedBy: VI1PR04CA0110.eurprd04.prod.outlook.com
 (2603:10a6:803:64::45) To SN7PR11MB7540.namprd11.prod.outlook.com
 (2603:10b6:806:340::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7540:EE_|DS0PR11MB7850:EE_
X-MS-Office365-Filtering-Correlation-Id: f7b554c1-5911-4b2e-e1a6-08deb4a94690
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|10070799003|7416014|376014|18002099003|56012099003|22082099003|11063799003|4143699003;
X-Microsoft-Antispam-Message-Info: LJzeUzXahDg9gRbASIXhebVbPEIIi0LqmL+BnT5fv0gBAH4AyHtHTTYCoFTsNVF6KpSsBK1t08/EhmOA1VDElDKgDGlMKkshQIEmzC6rG6TNLBJ0vqRAGajjSaPDDBQ6z1Lj3sa16cIu+DELvHAcCvmG/wBRbox+ynnuHanb5NMbCiA1IK2wIK0QBju3TlmkhI3cU1MRHiUtZg4XWFFmaIfdwVmDI9XQtyfzi/x1io5P78CEXeitOKhhx/ebV1fPOd3fzweEJWil0lEaRaT+AvevjEQDrTlDTSFix3sAia/EmG0ZmFDM/PnnP+KHsivhBBlIGg9tC5ccC69cNXaW25xNlSUeTueMao8MJGsh3pjUzgrKpou5rgFp9wp8RXvDBiiSNn17Q9238a+d2Q9fWUHq4fhn3qH7CLTTUOJjcd4Vtdh71NcOp1ttUsPics/D10zo+QcHp8J2auDVnxBfIATOHOuVRmLzIZsvWgqZmdAUUDCwob3c/9G5ktP+yn+6c5ooZsSUeeNy8hITocsWzx9JfcDZgSUr+7/63tALglSvvxEz0Jyvb1kZq1GwUdvoWxjtGWeyE7Js+zsGKdms1Bglz742paiRMnVGvUqm/IZC+MeEwst7nr2wilvH1iP5pL+hg622g6kZUbi78spE3Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7540.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(10070799003)(7416014)(376014)(18002099003)(56012099003)(22082099003)(11063799003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GUyyLUHhQw5FmZRwXJ65XuiDYg71MQo6KJxffwQ6FWTHdwQVzDZO+AtwZGsH?=
 =?us-ascii?Q?+xfDEVQ5rWey5anrofytRaEk6AbqBp9tKORfrOv4mszXgYqQkh+eLQmVIfRh?=
 =?us-ascii?Q?kk2lvxuSeYIhfFbMbkGlyaHAoflJkme5htsoP2L1ICYkbBaYCls1pf0pyCdt?=
 =?us-ascii?Q?WpmpeLvZi3GJw01UFEP6UK01TfKxAzt02HrYHM6OY3VodzihLkzQRqOlTkoB?=
 =?us-ascii?Q?uLL39BCppZUQYALhzWHegvtfa9FaI7Lhg6BbViUKJDRDUxOQbgpz+U8hxhiQ?=
 =?us-ascii?Q?1Po5hfzmu4DQshTLUcq6qM9dW853qk6U6Az0FP5Yk6UzTtRY4Xv5stmLo6ET?=
 =?us-ascii?Q?c3m4MIpkRcehcMWXkI4w3Pr7hisDbfxuwXnk5Gam7qpg6790ChYRA05PDqDj?=
 =?us-ascii?Q?igkxnJgH1SRxyxfYiBKx8nJq2wD3fMeGo4Bxf1BhJnYNkkX6NVdc9tc3s3C2?=
 =?us-ascii?Q?f/x5mR8GtDTJ4QQnMhv7AW5oSDS/ChOH1njpE6pAeTekP2yr61OMrPHs5kD4?=
 =?us-ascii?Q?A6kzLMoFEc8RSdzhWS/HsYeHgomDZA8XTUS5RaorkpbdemIggF6IwUL/xto4?=
 =?us-ascii?Q?+bLci8GjfhK/tERd2DxDhrqUl85YmWSH1QD2cWjGR2cq3SuRKMvOygcwCwL2?=
 =?us-ascii?Q?RxlkB6VockXdxYXsZ2wYxo+7+P5yl1cOnrhBmUmLNmYhizxsZx6cZOe16BF+?=
 =?us-ascii?Q?/+uu+TlID4FQrNX9A31BWL8NGcboPUAck6f8U0dhJqaq+8Y8NEEMxSRjpVYZ?=
 =?us-ascii?Q?zgzWAg6VmsJhHlukA3u07KNnI8Iou5q40yjKt7AZ5HWhdemfQKHqD2+vD/bv?=
 =?us-ascii?Q?md94yykivoucZ+4obdAH8kVJfo3IHQXGoFBEROCWU7Gshx/o1yYuOPwta6kS?=
 =?us-ascii?Q?sFDnygA65tFBXqYIcyVnC/E+YcgmB4PvZSFBHgKjCdhvUuL+J0ey0b+jnFQf?=
 =?us-ascii?Q?1lhksqPvUZ0kPrWkIhH449dMuSm+9ruG9LyfVvptrriKiPwBfbKe6UXEenM0?=
 =?us-ascii?Q?KZ8gOo3g1CM/rdPsBOPVfcugRAfTBjZvfJzKXliYk+mFjXgH/j3CWojqaJHJ?=
 =?us-ascii?Q?aHfavG6BMYguDORmfdhStIZ7MGqSo93t1yrhLI2zbfZrWlNGR4NdJW3Wi1NT?=
 =?us-ascii?Q?po6X6obHJ988+mruHC0wv7USghw+iDMTR1RRjhNpd/PDgSwbSlnfpUKZnlZ0?=
 =?us-ascii?Q?fYSk1OVwqb+yO5Y5o8NQQoy3TqG2csqO7bmKZETfZFiMepZNoRbsp+LMWq+m?=
 =?us-ascii?Q?wh3poVbYuliiHUxYB8jmPQQXNkSFGPvdUmVKha6xLSCzl2hyIZPCCOzyw9Em?=
 =?us-ascii?Q?RBConI6SArRexBtkt1mRTCub0HFyNZAcEPfFwxeSu88PLGHwKuSM18JrFKij?=
 =?us-ascii?Q?iy3mepo68deJXgj56WKp7zJ5o7xDhIlbD2wf41OYxmNqdMzgVlNzdz7pCKl3?=
 =?us-ascii?Q?rTfIpo6mAspe3IHUBKxhEhU50OwHz2jlxZZOqgP3bxBxKnwVa6xDrsSstp6z?=
 =?us-ascii?Q?RHXv5KChCGOISZivvFk/gL4XsyiIdnLlkfV1q6VYgyemGJu+mjgEkYq5rE+E?=
 =?us-ascii?Q?k+dnARJ2jxvCjb1ActxOnjI64Rb178bSAhl2H4D+CS91ju55qVtltcMozBbE?=
 =?us-ascii?Q?XY0gUiyCObx4mo1Au/z91grnBclnnJ1rfhuueiI8PhhLzmRLmQ5gcVprmNLC?=
 =?us-ascii?Q?YoJEIU/zag+ATe5WibNv6V089kPQK97P+Y8XyltqlxWbyxGQLz99TRV7Zw8E?=
 =?us-ascii?Q?2TQg7aBZZWzs2GpP+PgPZoT12x80Z4WH/BWHdNeDDll8hSJ7/bgn0XwUN6ea?=
X-MS-Exchange-AntiSpam-MessageData-1: FMJXVe5LX+LHCroF99dhPSBfv5vq79hBiR8=
X-Exchange-RoutingPolicyChecked: J/EJK8MKoAVlgOVKUlAGjtSuPFzOJPRtxiPBcXNIJ+nWq6AGva+fHFfmfRqpRdKaShy4LIb0SFUcGLarWKTQMCYWgufKgrakZB5MJrRLYWb3ZkA1W8RIeYgChuGMKWJBXDQddHqzoAJSylVkT6e8XVV0AF66fK241BQGldAU4YXDB3ntVGUpd7nQzZINFwqadhihROujW5ocTn2t+7Lk2Px/VowVmIz+tZJHKDygpc1n0xzavwQnOVp1IIafFUxqhkYuNHXO7hZ9PLKq6GdLq1qyct8B5XoGxoRUjwLhqitDO0dsjfqQlHEfcTM2q2jRLzDc1byP44wpufzks2C/jA==
X-MS-Exchange-CrossTenant-Network-Message-Id: f7b554c1-5911-4b2e-e1a6-08deb4a94690
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7540.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 06:47:06.2480
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pJSg1DEr1gaZuJZyd8/VtJb62C8QiNRe4NzemX5JOBXV8zbSIvxL+qzKu7PpiRafXaJJuvs3QNG3gAhQq30xXRW3Z3nbIm5mW1U7+iZDiHw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7850
X-OriginatorOrg: intel.com

On Fri, May 15, 2026 at 03:44:26PM -0700, Tony Nguyen wrote:
> From: Phani R Burra <phani.r.burra@intel.com>
> 
> Add support functions for drivers to configure PCI functionality and access
> MMIO space.
>

I had reviewed the Sashiko feedback [0]. Here is why I not find the feedback 
very helpful for this particular patch:

1. .config selection is consistent with overall libie scheme, so if it is 
   suboptimal, bigger changes (out of scope) are needed.
2. __libie_pci_get_mmio_addr is not intended to check read boundaries, this is 
   consistent with pre-refactor implementation
3. I see that none of the checks x + y > pci_resource_len(...) check for 
   overflow in any way. If you have a good example, please share.
4. Not using device resources for ioremap() was a concious choice, to simplify 
   deleting and adding regions at runtime.

[0] https://sashiko.dev/#/patchset/20260515224443.2772147-1-anthony.l.nguyen%40intel.com
 
> Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> Signed-off-by: Phani R Burra <phani.r.burra@intel.com>
> Co-developed-by: Victor Raj <victor.raj@intel.com>
> Signed-off-by: Victor Raj <victor.raj@intel.com>
> Co-developed-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
> Signed-off-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
> Co-developed-by: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
> Signed-off-by: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
> Co-developed-by: Larysa Zaremba <larysa.zaremba@intel.com>
> Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
> Tested-by: Bharath R <bharath.r@intel.com>
> Tested-by: Samuel Salin <Samuel.salin@intel.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/libie/Kconfig  |   6 +
>  drivers/net/ethernet/intel/libie/Makefile |   4 +
>  drivers/net/ethernet/intel/libie/pci.c    | 208 ++++++++++++++++++++++
>  include/linux/intel/libie/pci.h           |  56 ++++++
>  4 files changed, 274 insertions(+)
>  create mode 100644 drivers/net/ethernet/intel/libie/pci.c
>  create mode 100644 include/linux/intel/libie/pci.h
> 
> diff --git a/drivers/net/ethernet/intel/libie/Kconfig b/drivers/net/ethernet/intel/libie/Kconfig
> index 70831c7e336e..500a95c944a8 100644
> --- a/drivers/net/ethernet/intel/libie/Kconfig
> +++ b/drivers/net/ethernet/intel/libie/Kconfig
> @@ -23,3 +23,9 @@ config LIBIE_FWLOG
>  	  for it. Firmware logging is using admin queue interface to communicate
>  	  with the device. Debugfs is a user interface used to config logging
>  	  and dump all collected logs.
> +
> +config LIBIE_PCI
> +	tristate
> +	help
> +	  Helper functions for management of PCI resources belonging
> +	  to networking devices.
> diff --git a/drivers/net/ethernet/intel/libie/Makefile b/drivers/net/ethernet/intel/libie/Makefile
> index db57fc6780ea..a28509cb9086 100644
> --- a/drivers/net/ethernet/intel/libie/Makefile
> +++ b/drivers/net/ethernet/intel/libie/Makefile
> @@ -12,3 +12,7 @@ libie_adminq-y			:= adminq.o
>  obj-$(CONFIG_LIBIE_FWLOG) 	+= libie_fwlog.o
>  
>  libie_fwlog-y			:= fwlog.o
> +
> +obj-$(CONFIG_LIBIE_PCI)		+= libie_pci.o
> +
> +libie_pci-y			:= pci.o
> diff --git a/drivers/net/ethernet/intel/libie/pci.c b/drivers/net/ethernet/intel/libie/pci.c
> new file mode 100644
> index 000000000000..7276a3533b54
> --- /dev/null
> +++ b/drivers/net/ethernet/intel/libie/pci.c
> @@ -0,0 +1,208 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright (C) 2025 Intel Corporation */
> +
> +#include <linux/intel/libie/pci.h>
> +
> +/**
> + * libie_find_mmio_region - find MMIO region containing a range
> + * @mmio_list: list that contains MMIO region info
> + * @offset: range start offset
> + * @size: range size
> + * @bar_idx: BAR index containing the range to search
> + *
> + * Return: pointer to a MMIO region overlapping with the range in any way or
> + *	   NULL if no such region is mapped.
> + */
> +static struct libie_pci_mmio_region *
> +libie_find_mmio_region(const struct list_head *mmio_list,
> +		       resource_size_t offset, resource_size_t size,
> +		       int bar_idx)
> +{
> +	resource_size_t end_offset = offset + size;
> +	struct libie_pci_mmio_region *mr;
> +
> +	list_for_each_entry(mr, mmio_list, list) {
> +		resource_size_t mr_end = mr->offset + mr->size;
> +		resource_size_t mr_start = mr->offset;
> +
> +		if (mr->bar_idx != bar_idx)
> +			continue;
> +		if (offset < mr_end && end_offset > mr_start)
> +			return mr;
> +	}
> +
> +	return NULL;
> +}
> +
> +/**
> + * __libie_pci_get_mmio_addr - get the MMIO virtual address
> + * @mmio_info: contains list of MMIO regions
> + * @offset: register offset to find
> + * @num_args: number of additional arguments present
> + *
> + * This function finds the virtual address of a register offset by iterating
> + * through the non-linear MMIO regions that are mapped by the driver.
> + *
> + * Return: valid MMIO virtual address or NULL.
> + */
> +void __iomem *__libie_pci_get_mmio_addr(struct libie_mmio_info *mmio_info,
> +					resource_size_t offset,
> +					int num_args, ...)
> +{
> +	struct libie_pci_mmio_region *mr;
> +	int bar_idx = 0;
> +	va_list args;
> +
> +	if (num_args) {
> +		va_start(args, num_args);
> +		bar_idx = va_arg(args, int);
> +		va_end(args);
> +	}
> +
> +	list_for_each_entry(mr, &mmio_info->mmio_list, list)
> +		if (bar_idx == mr->bar_idx && offset >= mr->offset &&
> +		    offset < mr->offset + mr->size) {
> +			offset -= mr->offset;
> +
> +			return mr->addr + offset;
> +		}
> +
> +	return NULL;
> +}
> +EXPORT_SYMBOL_NS_GPL(__libie_pci_get_mmio_addr, "LIBIE_PCI");
> +
> +/**
> + * __libie_pci_map_mmio_region - map PCI device MMIO region
> + * @mmio_info: struct to store the mapped MMIO region
> + * @offset: MMIO region start offset
> + * @size: MMIO region size
> + * @num_args: number of additional arguments present
> + *
> + * Return: true on success, false on memory map failure.
> + */
> +bool __libie_pci_map_mmio_region(struct libie_mmio_info *mmio_info,
> +				 resource_size_t offset,
> +				 resource_size_t size, int num_args, ...)
> +{
> +	struct pci_dev *pdev = mmio_info->pdev;
> +	struct libie_pci_mmio_region *mr;
> +	resource_size_t pa;
> +	void __iomem *va;
> +	int bar_idx = 0;
> +	va_list args;
> +
> +	if (num_args) {
> +		va_start(args, num_args);
> +		bar_idx = va_arg(args, int);
> +		va_end(args);
> +	}
> +
> +	if (offset + size > pci_resource_len(pdev, bar_idx))
> +		return false;
> +
> +	mr = libie_find_mmio_region(&mmio_info->mmio_list, offset, size,
> +				    bar_idx);
> +	if (mr) {
> +		pci_warn(pdev,
> +			 "Mapping of BAR%u (offset=%llu, size=%llu) intersecting region (offset=%llu, size=%llu) already exists\n",
> +			 bar_idx, (unsigned long long)mr->offset,
> +			 (unsigned long long)mr->size,
> +			 (unsigned long long)offset, (unsigned long long)size);
> +		return mr->offset <= offset &&
> +		       mr->offset + mr->size >= offset + size;
> +	}
> +
> +	pa = pci_resource_start(pdev, bar_idx) + offset;
> +	va = ioremap(pa, size);
> +	if (!va) {
> +		pci_err(pdev, "Failed to map BAR%u region\n", bar_idx);
> +		return false;
> +	}
> +
> +	mr = kvzalloc_obj(*mr);
> +	if (!mr) {
> +		iounmap(va);
> +		return false;
> +	}
> +
> +	mr->addr = va;
> +	mr->offset = offset;
> +	mr->size = size;
> +	mr->bar_idx = bar_idx;
> +
> +	list_add_tail(&mr->list, &mmio_info->mmio_list);
> +
> +	return true;
> +}
> +EXPORT_SYMBOL_NS_GPL(__libie_pci_map_mmio_region, "LIBIE_PCI");
> +
> +/**
> + * libie_pci_unmap_fltr_regs - unmap selected PCI device MMIO regions
> + * @mmio_info: contains list of MMIO regions to unmap
> + * @fltr: returns true, if region is to be unmapped
> + */
> +void libie_pci_unmap_fltr_regs(struct libie_mmio_info *mmio_info,
> +			       bool (*fltr)(struct libie_mmio_info *mmio_info,
> +					    struct libie_pci_mmio_region *reg))
> +{
> +	struct libie_pci_mmio_region *mr, *tmp;
> +
> +	list_for_each_entry_safe(mr, tmp, &mmio_info->mmio_list, list) {
> +		if (!fltr(mmio_info, mr))
> +			continue;
> +		iounmap(mr->addr);
> +		list_del(&mr->list);
> +		kvfree(mr);
> +	}
> +}
> +EXPORT_SYMBOL_NS_GPL(libie_pci_unmap_fltr_regs, "LIBIE_PCI");
> +
> +/**
> + * libie_pci_unmap_all_mmio_regions - unmap all PCI device MMIO regions
> + * @mmio_info: contains list of MMIO regions to unmap
> + */
> +void libie_pci_unmap_all_mmio_regions(struct libie_mmio_info *mmio_info)
> +{
> +	struct libie_pci_mmio_region *mr, *tmp;
> +
> +	list_for_each_entry_safe(mr, tmp, &mmio_info->mmio_list, list) {
> +		iounmap(mr->addr);
> +		list_del(&mr->list);
> +		kvfree(mr);
> +	}
> +}
> +EXPORT_SYMBOL_NS_GPL(libie_pci_unmap_all_mmio_regions, "LIBIE_PCI");
> +
> +/**
> + * libie_pci_init_dev - enable and reserve PCI regions of the device
> + * @pdev: PCI device information
> + *
> + * Return: %0 on success, -%errno on failure.
> + */
> +int libie_pci_init_dev(struct pci_dev *pdev)
> +{
> +	int err;
> +
> +	err = pcim_enable_device(pdev);
> +	if (err)
> +		return err;
> +
> +	for (int bar = 0; bar < PCI_STD_NUM_BARS; bar++)
> +		if (pci_resource_flags(pdev, bar) & IORESOURCE_MEM) {
> +			err = pcim_request_region(pdev, bar, pci_name(pdev));
> +			if (err)
> +				return err;
> +		}
> +
> +	err = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
> +	if (err)
> +		return err;
> +
> +	pci_set_master(pdev);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_NS_GPL(libie_pci_init_dev, "LIBIE_PCI");
> +
> +MODULE_DESCRIPTION("Common Ethernet PCI library");
> +MODULE_LICENSE("GPL");
> diff --git a/include/linux/intel/libie/pci.h b/include/linux/intel/libie/pci.h
> new file mode 100644
> index 000000000000..effd072c55c8
> --- /dev/null
> +++ b/include/linux/intel/libie/pci.h
> @@ -0,0 +1,56 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/* Copyright (C) 2025 Intel Corporation */
> +
> +#ifndef __LIBIE_PCI_H
> +#define __LIBIE_PCI_H
> +
> +#include <linux/pci.h>
> +
> +/**
> + * struct libie_pci_mmio_region - structure for MMIO region info
> + * @list: used to add a MMIO region to the list of MMIO regions in
> + *	  libie_mmio_info
> + * @addr: virtual address of MMIO region start
> + * @offset: start offset of the MMIO region
> + * @size: size of the MMIO region
> + * @bar_idx: BAR index to which the MMIO region belongs to
> + */
> +struct libie_pci_mmio_region {
> +	struct list_head	list;
> +	void __iomem		*addr;
> +	resource_size_t		offset;
> +	resource_size_t		size;
> +	u16			bar_idx;
> +};
> +
> +/**
> + * struct libie_mmio_info - contains list of MMIO regions
> + * @pdev: PCI device pointer
> + * @mmio_list: list of MMIO regions
> + */
> +struct libie_mmio_info {
> +	struct pci_dev		*pdev;
> +	struct list_head	mmio_list;
> +};
> +
> +#define libie_pci_map_mmio_region(mmio_info, offset, size, ...)	\
> +	__libie_pci_map_mmio_region(mmio_info, offset, size,		\
> +				     COUNT_ARGS(__VA_ARGS__), ##__VA_ARGS__)
> +
> +#define libie_pci_get_mmio_addr(mmio_info, offset, ...)		\
> +	__libie_pci_get_mmio_addr(mmio_info, offset,			\
> +				   COUNT_ARGS(__VA_ARGS__), ##__VA_ARGS__)
> +
> +bool __libie_pci_map_mmio_region(struct libie_mmio_info *mmio_info,
> +				 resource_size_t offset, resource_size_t size,
> +				 int num_args, ...);
> +void __iomem *__libie_pci_get_mmio_addr(struct libie_mmio_info *mmio_info,
> +					resource_size_t offset,
> +					int num_args, ...);
> +void libie_pci_unmap_all_mmio_regions(struct libie_mmio_info *mmio_info);
> +void libie_pci_unmap_fltr_regs(struct libie_mmio_info *mmio_info,
> +			       bool (*fltr)(struct libie_mmio_info *mmio_info,
> +					    struct libie_pci_mmio_region *reg));
> +int libie_pci_init_dev(struct pci_dev *pdev);
> +
> +#endif /* __LIBIE_PCI_H */
> -- 
> 2.47.1
> 
