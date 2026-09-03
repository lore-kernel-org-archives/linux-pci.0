Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0DE33F4103;
	Thu,  3 Sep 2026 06:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788417826; cv=fail; b=XKYcrK4+opwT5G5381yHaD533EgGa5uGyFTSxPGpZGMepzgNOnnS9/hqfe1pfutOZcC1f9ohQ2eAOGUBB+DzjtDhW5kEFK3TgIhgQjCE7Xz2SqtN/KxNR2tgf13VcK/Lfo+jV+Zw/vl1PPZgHxWkGAUP+C+jK1sLcUkwKsY4Ook=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788417826; c=relaxed/simple;
	bh=ymOjAtOwaMhAR5BRmQMtXuAv0UeAPHAkBmNGoLABc7A=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=m67Pyb79o9ureD9FY+4oBkvbn2rSv8wRP7LcpbZCznH4zvykXsZ4tYnnZ2qLDDI/blRhZcSdjqG3kNcFRiBxhRI14x0uSjrmAe4GGBhKymqy05MB1dIIJFLbboLBAZmR+TEQ5TfnB1vUlzJ30RBw+YW/u8pxEQtizsb0v/0b/0Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=khtPSSpo; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="khtPSSpo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788417821; x=1819953821;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ymOjAtOwaMhAR5BRmQMtXuAv0UeAPHAkBmNGoLABc7A=;
  b=khtPSSpot2nh90rwS8SCPm0lSsYHjLGy3vJLX4JnLW/Bg/9/wA3DQHHn
   h+CkjDtqh5IkUAoart5f1ISu2UCEWFlwppxKWYihe2fM30axOZxgUfJqC
   jOd+Mtv/XQ2Ths6+nxexqM9MIvC4FgV7Pf+t0g3O2cP01d9IMkLWyNgoM
   fyTXNck/2i06ht2E5VRei7nLN367rk0/95uR+9o1pI+6w10MtV1ydyyaA
   ma3z0wi4lcn1b+7AyOjcU1l8vxP8u5hO48A3Guu0s9+pm1rySDvpu4CAW
   rLJqeK9+778znilQnvI287+XEo8U7X7AoQt0wFjwFz6OXZHYsztDoy6Hm
   A==;
X-CSE-ConnectionGUID: Eeh1ZbnNRGCFWxlp4Tpiaw==
X-CSE-MsgGUID: /Eqi6VrYRhGWorAmD3vG9w==
X-IronPort-AV: E=McAfee;i="6800,10657,11894"; a="76444052"
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; 
   d="scan'208";a="76444052"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2026 23:43:38 -0700
X-CSE-ConnectionGUID: saceHqU1RteBOhrmnncSBQ==
X-CSE-MsgGUID: bCp7Vj0cROi0xL0EwdAn/g==
X-ExtLoop1: 1
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2026 23:43:38 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 2 Sep 2026 23:43:37 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Wed, 2 Sep 2026 23:43:37 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.34) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 2 Sep 2026 23:43:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ELnKMdRBr6LXWrWsbE6Io5cjsHVdveDj8N9sYTgqoasjy0G3/R+K8CI9lZbOWWWiKG3GDMc2w7iCI2hEpdnfVsGTvHolVr0qtH6BuJpXpmWBjTWOb9/zV73oesyQWaW6znOXUZbMBrQqqfVvBIzVPJyA6iUp5ZfMd2eNAkifHWB7YJC+4foChtfZPaq1HDK3EiRBXC4NHzIL0MYQMCEfxBHxzxNcItMswKYY+pUiSsyBaVUUPJKNQ8zR7oDza8zSyEWvhhvIrmQMwju1Cx6s27fnHTNpAmwZ2dUoHBiUP2GJxHaSo4AkJUzSBGsYBu6tKxx0vL+MrVGdZ/hjDgxFXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wqlJSaz1vZS6YXjCz2TDnoUkrW0p98mdEuvVuDgplLs=;
 b=fykW6xWULI9Ia/jHXGfmTiw5ovEh8/QQBPA2P966RZz/ee6fMIeAR7VhIjmwZ+hXO0onYxZ3Wl16+wF4djDpZ2ShY8qFvH/39Hre6OdBG4kz7yqhOzi+mAuAAR5zLZZ1H2iOFNM1YoR0BBIDff/cKkKMQLsi0l3qgCGym6EwNEk2YoqxH82jrjeUniWRZgi8mj9zhUiuw4EQmrv7BSlFrZa7KJky13Vb+TH0UvXvPb4ZC7txxBoG5pMrHdPLSlaITT5an9XxtFeEC5LoHBlQePIvDrNxMcuq4Sunp3zSWtLA1j/UwT63F4WiZntIWzzBqO3oNSdxa856GiyCAehrZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8695.namprd11.prod.outlook.com (2603:10b6:408:211::15)
 by PH0PR11MB5080.namprd11.prod.outlook.com (2603:10b6:510:3f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 06:43:34 +0000
Received: from LV3PR11MB8695.namprd11.prod.outlook.com
 ([fe80::ccc3:3fd6:58f5:927]) by LV3PR11MB8695.namprd11.prod.outlook.com
 ([fe80::ccc3:3fd6:58f5:927%6]) with mapi id 15.21.0360.008; Thu, 3 Sep 2026
 06:43:34 +0000
Message-ID: <37b7f389-d95f-4d0d-8bd7-85074f7c6122@intel.com>
Date: Thu, 3 Sep 2026 12:13:24 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 11/19] vfio/pci: Serialize runtime PM with recovery
To: Shameer Kolothum <skolothumtho@nvidia.com>, <kvm@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <alex@shazbot.org>, <jgg@ziepe.ca>, <kevin.tian@intel.com>,
	<kbusch@meta.com>, <michal.winiarski@intel.com>, <sonangp@nvidia.com>,
	<nathanc@nvidia.com>, <mochs@nvidia.com>
References: <20260901093217.8539-1-skolothumtho@nvidia.com>
 <20260901093217.8539-12-skolothumtho@nvidia.com>
Content-Language: en-US
From: "K V P, Satyanarayana" <satyanarayana.k.v.p@intel.com>
In-Reply-To: <20260901093217.8539-12-skolothumtho@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0028.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:17a::12) To LV3PR11MB8695.namprd11.prod.outlook.com
 (2603:10b6:408:211::15)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8695:EE_|PH0PR11MB5080:EE_
X-MS-Office365-Filtering-Correlation-Id: 75314edb-dba6-46f5-6831-08df0986acce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|7416014|1800799024|366016|11063799006|4143699003|10067099003|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: /0nI7IKmoxEhMmFZhzyjcPoUbWxvwE02i0Q9iv3+2tWmXKw1q3F2aRZWTZK+UO5jVyI9qrt6ZehP2yTI7iK2sxVrXiHSzJUPa4s1H9+QexGua8nStZxx+hJjLjgMmkKoe6+7MZMdw1oPCoN+NbrhL5CNGgp1DWg8hniJO/PiNrsiBZKFSe1iWQTJqPnHHyG4rjzbejKh9+fj1IKuhkZFoHtb/Zy33DdI2lliPvOtT4uoAUbDw6kwqo9IDVSz5auC6jrmbFE9DlxquCEGg9TtdYg2IBHjhWepy3u/VXh9RROp2EobJ2IU3G4y29k/VmXMtRsTABu0RwUrVBNkfYVl2WIgFzZVNQxWFqJM33VAhUaaqSjL2xOAAF0VJR6EJQUzJBYXA3/5rySKfnMzcF1OxNo/M39odFxzjgaN0pfcww0oJafCcVSUmZ1riUixLsIoRiLzgb7b1gXtQs+vREtPo8cj53I/Gu6UAtdbGdePNin36qjSJz5Dxms+w022MtDd8eURsZxpDKHWStYCPomU4IjR/VHdSNFzLUw2NFzXJvnznqCCDJJqVXCO9a1hkjSdN2rGzP+m+E1EYEZCYEVDc4BIy+RHenDOP1Hotno3QS2V6h2BqoKHmfIpgfLpleNo52XBc9A9Dq1VG13a/Tmj5Quakb4GKZaBzUbtLvBFUMg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8695.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(366016)(11063799006)(4143699003)(10067099003)(22082099003)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cHZjSVFaSUE3SUdZemVDQlJWdEJXNllZN2h5ZmZCV1FwaS9zYmF0cDh3SWxF?=
 =?utf-8?B?bmN0S2tZenhYbjFmU1JuRnliOWpHbEZtWlY3S0Z2UVFsV3FyaDFrRDduREZG?=
 =?utf-8?B?VXpUVGJxTmc1a0xmZDdLTnlYbFpLckxGUnJFQldHamVvcXN1OHZpOEJIUmxk?=
 =?utf-8?B?dFZ3RlQ1aU9GUEFJaXpsWHI0M3ppeVMvV1IyQTNaVVVWbEN6b1NwTVAraGVu?=
 =?utf-8?B?L0dvRGozNzdCeUtydlhCenNmNmhsTjIwaEptd2RHNkZoWjVNdHVzN3lQdnpj?=
 =?utf-8?B?U0Iya2dtcmpKamRXc1FRc2xwbmdNaTFIODBaY2t3VXJsQjkwTE1nRE04dFZC?=
 =?utf-8?B?dFJGbGtTcS92VXNCUG5FYThpL3plVzRUWjh3QVZub0NMMWRadVVib2NXVWJD?=
 =?utf-8?B?QnRaRXN1MDdFZUtIdC9OYUVrV1ZpbGFjRElLSXNyc0NiZ2owejc4UVM0azBE?=
 =?utf-8?B?cEw2M2hHTE5JYlE1Q2cwTnJFem9GSVZzRHR4Y2tIbThvSllGOVFldEcveWVu?=
 =?utf-8?B?RFhBK29FUGVUVk9OZVhZVVBqSm50bSswN2I4eVJMOURIa0kyWXFxdi9hT2Mx?=
 =?utf-8?B?ZnlieW8zSjljeXhiMFBRM2JYdWU4YmFWN2hDTjQvK2pFM1NIeXNkWVpwanlK?=
 =?utf-8?B?cVl2NlB2ZTlkemhLcVhMQnFzamJHV3N5Z0RTSjBqRCtxNEdjTWdzQisybFEx?=
 =?utf-8?B?QnYzd0txUzFXRFlHTHl2dlEvaVRzNzFzSmhmL21JQ2tCeHhPdnJ0c3FZQzcr?=
 =?utf-8?B?Z1hZLzBxRXFGWVRWV3F3NVBzWkFOTUVsZFNKUFA0TytURm1uc2RjYnVLZXpn?=
 =?utf-8?B?UVpkMGhhampXMlFGWHhZWVBiK29nbDJlOVdoUjRleW1QMUtjbENaVmlLQ1No?=
 =?utf-8?B?NDQ4VmVwWHRDS01xT0s3SzlMV1RmNGxyU2dpaEpNTDI3M080TysxQUN6YVJJ?=
 =?utf-8?B?cVhKUjFKeTJ4cjRsZEdwa2VpWDdtelk0RHpBcUtoaGVqOHFDeEhwcC9ZTEhN?=
 =?utf-8?B?UlNmaEFzL1JMZDl2bTY2cTM0SzlkbTdTZDAvVWVNSVVUZkpuV0RQNW1kVnlo?=
 =?utf-8?B?cHJTcFRubE9WeTY5REJYbzdtNFVxVzVNT2J2dnBsWmM3ZEtsY0JKMFE2dGhp?=
 =?utf-8?B?NjVHYmh3bCszKzd2VGZ6bGpuMUJYT21pL3g4RVdJa2ZGSytDS09QUzZKSmhG?=
 =?utf-8?B?L2hYSVh4dFViMGRtUyt0T0xENmtMZllnaHZLc01RZ0xReUFRWXFaRkc0QTR0?=
 =?utf-8?B?Rk5DdTlCWGJaZ3U1Qjg1R2IvdXA0UTB3SXNLZHJFdzRzcFdGVVFyUlVOQmln?=
 =?utf-8?B?V0Nvb2RseWZmaGFlNzhRaGY0QlZXOGFhS3RlMWJ6STl2ejczL0FOWFFSSGRz?=
 =?utf-8?B?UkFpKy94Yi9sT2x1TXlXQ09iK1dHbUJuWkZ4MmRFMmNxanVpYlMybWZFYitY?=
 =?utf-8?B?VHV6TlFHZlM1Qkdva2JKaDdZeTAzdkxvT1FLTXgxLzcwK1pTNDZ6UytsUXI4?=
 =?utf-8?B?MlF6MDNBdVcyK2RiNGVRdGdXaS9wMHpGcFpEMjF1VnI4MnlDbTV2WGxudURs?=
 =?utf-8?B?WUcyNDQxRnoyek9adUNGWEFENmRuZmh0Q3RpQ2ZnNDBBbFRjYmx0OCtpNmtK?=
 =?utf-8?B?SkVKeExZYU1zYklnd2hLYjI3d1NXd2JvdzhmQUxPZFJ4NElJMUdLd3dGR3dW?=
 =?utf-8?B?Yyt2QStFWEljbmVGVnpmRGI2dUVHVDF0U2ZyL2JHcEw2anRhcVhQNjFIQzI2?=
 =?utf-8?B?eVM4UWlldGhjTGhHRkV1Vnp5dGZLNW5sMGZiZGhmejNnN1pDbExNaDhobGJa?=
 =?utf-8?B?d21xbjJpNXNXNTU2U1d5eVIxNnZrTlhKM1dPRHZCa3BKeXNDUHd3TnFIM282?=
 =?utf-8?B?STlCU0RmMVRvcS9rZ1NBRWVvdXBxODU2SmIzbGpnUm9kOGdrVGMwMGNQTm9u?=
 =?utf-8?B?cnZ1TWcxMjJ5YUNkTm9qSTd5NVhWSWZXTGR6ekkyVDR1UVFHNCs0QW1iYk50?=
 =?utf-8?B?aDRMSjhoZUIyZ0ZwdXVyd2NpYU9iS1UzNFdWK2ErNVV0cXZwOEhLTnZsVWpt?=
 =?utf-8?B?cm1ISnUvYkFseDJhakxYdXIxdGtmVTIzaTM2MlRlMHNmMnpwQmVhcVB6cE9E?=
 =?utf-8?B?S3UzZFVuQ1ZpTVdSMlROdVJwZ05HL3BhUFp3OGdraE0zMXhDS0VyeEEwdlAv?=
 =?utf-8?B?dEhUY0ZzdEtybE5MSTVmSnliaC94M1lQU0F0MkpLbU9mWXZ0RzN5RDNvNzEr?=
 =?utf-8?B?N2I1ZlRzaFNBOEErTVgva25XL2EvZ1JqYk82bUV3M0k3NWkvS0tlSkZNejM0?=
 =?utf-8?B?RWJyS3Q1d2xueVV4KytOM0NBUHRDRERsN3JTam9tUGd2N3kwN21wV0xVUW50?=
 =?utf-8?Q?fColH61RbT7f3E5U=3D?=
X-Exchange-RoutingPolicyChecked: 3Or7HmjClj2LkIeQK3mD6b74xGrfBmW7BnAXDPH4tzpnMG/g89YE++Ks0nAf3IdJ67n9YlHkuAX6pq02t/n1P9IXnV9L+YfTxtfB13R+vUEObK3kp41PIeK05Ys/ltHEa95PF2dsGFal8JXq/HQODaAqzd8HDEDjw0y2kAz0N05vgUoOCtGbLybNah1BSDkfW8EZUVjheTlA9uFUBNGLo9DCplSTe+gMge9N7QEyWhgrdSTv+3HFnFCbD7wGzb8NxiTFoAlmTLYYuPXFJI7px26vNeQLGzGNGJ1KLK1J4tZtY6+uw0Xhp/D/N1a4clAm/ASLl4q7TKX3L8s3SrWWew==
X-MS-Exchange-CrossTenant-Network-Message-Id: 75314edb-dba6-46f5-6831-08df0986acce
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8695.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 06:43:34.0702
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m8+6Fzb5G6jO2Pj7xa0FRjZyLVHaZmM6u3EJkxi1eHbVKePMStqygrLOfJ+bze+Wt7AmhBdu9cM0Ywzn1d3Cjz4Vm3aiwVbxmiDJcN80yUk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5080
X-OriginatorOrg: intel.com


On 01-Sep-26 3:02 PM, Shameer Kolothum wrote:
> Hold recovery_lock for reading around low-power entry and exit. Entry
> zaps the BAR mappings and revokes the DMA-BUF exports under memory_lock,
> and exit restores the exports. Taking recovery_lock first keeps the same
> order the AER callbacks use.
>
> Neither wakes the device. Entry only decrements the runtime PM usage
> count, and the suspend which follows runs when the vfio core drops its
> own reference after the ioctl returns, outside the lock. Exit takes a
> reference without resuming. So neither reaches pci_bus_sem while
> recovery_lock is held.
>
> Check the recovery state before the runtime resume in the region read and
> write path, but do not hold recovery_lock across it. A resume takes
> pci_bus_sem, through pcie_aspm_pm_state_change() and, from D3cold,
> through pci_bridge_wait_for_secondary_bus(), and the error callbacks take
> recovery_lock from under it.
>
> The check is best effort. It avoids waking a device whose access is
> already blocked, and the region access which follows takes recovery_lock
> for itself. A recovery which starts after the check is not excluded, and
> does not need to be. pcie_do_recovery() runtime resumes every device
> under the bridge and holds the reference until it finishes, so a resume
> which runs alongside it does no more than take a reference of its own.
>
> Assisted-by: Claude:claude-opus-5
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
> ---
>   drivers/vfio/pci/vfio_pci_core.c | 29 +++++++++++++++++++++++++++++
>   1 file changed, 29 insertions(+)
>
> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
> index bd3d79d28f27..95884e713a4b 100644
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c
> @@ -372,15 +372,21 @@ int vfio_pci_set_power_state(struct vfio_pci_core_device *vdev, pci_power_t stat
>   static int vfio_pci_runtime_pm_entry(struct vfio_pci_core_device *vdev,
>   				     struct eventfd_ctx *efdctx)
>   {
> +	int ret;
> +
>   	/*
>   	 * The vdev power related flags are protected with 'memory_lock'
>   	 * semaphore.
>   	 */
> +	ret = vfio_pci_core_access_begin(vdev);
> +	if (ret)
> +		return ret;
>   	vfio_pci_zap_and_down_write_memory_lock(vdev);
>   	vfio_pci_dma_buf_move(vdev, true);
>   
>   	if (vdev->pm_runtime_engaged) {
>   		up_write(&vdev->memory_lock);
> +		vfio_pci_core_access_end(vdev);
>   		return -EINVAL;
>   	}
>   
> @@ -388,6 +394,7 @@ static int vfio_pci_runtime_pm_entry(struct vfio_pci_core_device *vdev,
>   	vdev->pm_wake_eventfd_ctx = efdctx;
>   	pm_runtime_put_noidle(&vdev->pdev->dev);
>   	up_write(&vdev->memory_lock);
> +	vfio_pci_core_access_end(vdev);
>   
>   	return 0;
>   }
> @@ -483,7 +490,11 @@ static int vfio_pci_core_pm_exit(struct vfio_pci_core_device *vdev, u32 flags,
>   	 * already signaled the eventfd and exited low power mode itself.
>   	 * pm_runtime_engaged protects the redundant call here.
>   	 */
> +	ret = vfio_pci_core_access_begin(vdev);
> +	if (ret)
> +		return ret;
>   	vfio_pci_runtime_pm_exit(vdev);
> +	vfio_pci_core_access_end(vdev);
>   	return 0;
>   }
>   
> @@ -1867,6 +1878,24 @@ static ssize_t vfio_pci_rw(struct vfio_pci_core_device *vdev, char __user *buf,
>   	if (index >= VFIO_PCI_NUM_REGIONS + vdev->num_regions)
>   		return -EINVAL;
>   
> +	ret = vfio_pci_core_access_begin(vdev);
> +	if (ret)
> +		return ret;
> +	vfio_pci_core_access_end(vdev);

Is it really needed? Or some typo?

- Satya.

> +
> +	/*
> +	 * Resume with the guard dropped. A resume takes pci_bus_sem, through
> +	 * pcie_aspm_pm_state_change() and, from D3cold, through
> +	 * pci_bridge_wait_for_secondary_bus(). The error callbacks take
> +	 * recovery_lock from under pci_bus_sem, so holding it here would
> +	 * invert the order.
> +	 *
> +	 * The check above only avoids waking a device whose access is already
> +	 * blocked. A recovery which starts in between is not excluded, and
> +	 * does not need to be. pcie_do_recovery() has already resumed every
> +	 * device under the bridge and holds the reference until it finishes.
> +	 * The region access below takes the guard for itself.
> +	 */
>   	ret = pm_runtime_resume_and_get(&vdev->pdev->dev);
>   	if (ret) {
>   		pci_info_ratelimited(vdev->pdev, "runtime resume failed %d\n",
