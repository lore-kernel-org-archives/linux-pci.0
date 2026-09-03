Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7720B3EC6A4;
	Thu,  3 Sep 2026 06:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788417272; cv=fail; b=Vriv0Sx5VGciEpuefEU+aYaei4jLO/F7l/65Lk39tizK7cX4LPrGEOWO8/tmt1BJFWCubksvoUAJnV5YU31VROF4K5ltWXymVI+0BaEvOP05rO63TsWjo3OI7Exdp7kZR2V0/wpw3/I+gedkaIx1Y75Q7axwt3uIz2O3fJ4ob1U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788417272; c=relaxed/simple;
	bh=msPnrr4CwXwyKBOGXbtBS8+5Tf4Hpd/jG/pnNV0TeLc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YuuSSaItn6dyPV8bqwBG5NDzVAuFbKkbfc959pFGNE215wwFBli+xgQ5WjdcNZXV8JJdcMyfUZLqFltP2Zucfn7NtZjMbi93pF94nM4Ndgg7mALf5NU6ziH1ytkfiX/M58FD4e2uKvjaKhpkcBB8y/UPocoYR2qop4NIZQdlAco=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TAM6djCC; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TAM6djCC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788417269; x=1819953269;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=msPnrr4CwXwyKBOGXbtBS8+5Tf4Hpd/jG/pnNV0TeLc=;
  b=TAM6djCCkbxJXcGkjeNDrB7HfVecCjK2JdBJvFwDn44EGf/8/jtaGnph
   7EDp4p/5XatYe7xFTHNmG5pCj2swQ6nbAyv4d4w+c8ORF71BMus1JW8lE
   7djmsV5AeNcP5gdYD5adQTqbYGQgdpzT97IaRkL8IIlQFovGn1OsmXx89
   PdVhcyyqKRKEWW0RIv4oDknGN/X2Nb1Rle7M+pZmkuxg/eq7wnWVt/8Nr
   1IonBnSaOkB+SEiYWKPAcfGeJN0SUMzWNPZhap5OZsXT6jdpm1p3lCuwZ
   CamegSXnL3sGax96ciA7jlV1DS8cj3nmuR83YO45pc2u9+mVzchwqbm9D
   Q==;
X-CSE-ConnectionGUID: KFHMNNvCS/aAiiETVtYsUQ==
X-CSE-MsgGUID: +wUiGBxLQeqglj4pGokfng==
X-IronPort-AV: E=McAfee;i="6800,10657,11894"; a="100244271"
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; 
   d="scan'208";a="100244271"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2026 23:34:26 -0700
X-CSE-ConnectionGUID: +jrXDgxBQvOgvVAVcZqU/g==
X-CSE-MsgGUID: dtDBUd3NSlG0cQTdft1vLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; 
   d="scan'208";a="266377396"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2026 23:34:26 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 2 Sep 2026 23:34:26 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Wed, 2 Sep 2026 23:34:26 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.35)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 2 Sep 2026 23:34:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b6NunqniWUoDsDHhX9P2fbo3RUp8XCdNo62IULNK876dug/C9W3CUNIuHyx3BIY5lqsNHHJeJbufl3Qe1rmfr2wBPo/6R6W6gQb0FzVQ6pXI+3u50F4AMtByvObSVRoP4I4feIetE2t1Aa+2kpcbV7iy7rGlGaQtgkW3gzcWphHnXHKQyi4kuTpaOmevVqiy2CIh6oitd9PvV7PbjhkW1xrpkK9GEnxVu4RLCNo+mfqSkRnQjSofZjPk3YaH6Gvr/GqrK1dVKh5A1nKAKeBwDFJsZNt09hPmcWONd4cCCsCeW2xv2+HpBUpSJur78qlPSbmaL+oAYvAjkib8OfbQJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UgVa9Xi4hR6NJqrV0o7By+C073/208BHo0iLj3rIpv0=;
 b=GD2GTUhPWwWtkrPpdt+nYwu8wb/2m89u8NWuhfOAQGzVlBQfVcobKp6Ct8AkIUqcfFb/htnCsADDm4lPVtvmM0G+TEHEhY+i6n7CAKSYGGSCRMxfduX3Nm1zVvtBczY5wj/3OyrO9WdWjWkuWf3CivOC/JdjCfVP+uACo551v6dBwbe5DLJZxDes8kASCLWIDjDExWzYlDa5ATL4ekIN1lMTE2HBT/qxzrxC6x8ZKDE5Fh870ufaLy8uWdNam1n/bxPzawpc2ofT0GCs6y0s12OvhUBU7nGYp5i8Wx7pJEPYZLuFRgHyQkaiU+szypA2xzmao0aI1CXJueVb/eFLYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8695.namprd11.prod.outlook.com (2603:10b6:408:211::15)
 by SJ1PR11MB6106.namprd11.prod.outlook.com (2603:10b6:a03:48b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 06:34:22 +0000
Received: from LV3PR11MB8695.namprd11.prod.outlook.com
 ([fe80::ccc3:3fd6:58f5:927]) by LV3PR11MB8695.namprd11.prod.outlook.com
 ([fe80::ccc3:3fd6:58f5:927%6]) with mapi id 15.21.0360.008; Thu, 3 Sep 2026
 06:34:21 +0000
Message-ID: <1ccfa114-c09e-4d49-a071-c38c8fe4c9b2@intel.com>
Date: Thu, 3 Sep 2026 12:04:12 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 09/19] vfio/pci: Serialize interrupt operations with
 recovery
To: Shameer Kolothum <skolothumtho@nvidia.com>, <kvm@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <alex@shazbot.org>, <jgg@ziepe.ca>, <kevin.tian@intel.com>,
	<kbusch@meta.com>, <michal.winiarski@intel.com>, <sonangp@nvidia.com>,
	<nathanc@nvidia.com>, <mochs@nvidia.com>
References: <20260901093217.8539-1-skolothumtho@nvidia.com>
 <20260901093217.8539-10-skolothumtho@nvidia.com>
Content-Language: en-US
From: "K V P, Satyanarayana" <satyanarayana.k.v.p@intel.com>
In-Reply-To: <20260901093217.8539-10-skolothumtho@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0025.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:17a::15) To LV3PR11MB8695.namprd11.prod.outlook.com
 (2603:10b6:408:211::15)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8695:EE_|SJ1PR11MB6106:EE_
X-MS-Office365-Filtering-Correlation-Id: 50a904ba-1a34-4be0-d27d-08df09856373
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|23010399003|56012099006|10067099003|11063799006|5023799004|4143699003|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 7Hnw6YfGSRUUM8RAD9bZrjdGHYM3W5cY6/cbRaS1VfK7TCH+Zvn/Xe4m6aFtv1yE/XDqp58S5mWC8E0U8HB2fNGV0embKZZvspngavPE2hAfE88+s3WyBtqX9jxgTVxov6jFtAwbjvrgtjJNC4lDziZDymL+4Hj8DqeI0Eu+ZfChMLeVpAUDil8FM9piuCF3AXyDBqZeEtnlOy/uTBvmsZZcOdhGg0b0EKdkk4vVmb72QkbUj3VCj3lSuVE/9bJq5TfB/HS24ygnm72UI5OC+ey7ZOnzzv/9eMSVb3tSeopLu1mM4Af4IhPzJHuJT1BRo2KSDBizpfTLyeP74ELMi3navE7Q/OGtqLHsBnhCRfKFd932HPVRqWqCdP+ciFW5peq0cNbhPAfEIi6yIPi/6bgp0UfksPmu+GZNVia6+m/hO/UuMK8jDwhkCZSxZcKDKd2YebVu2vhFrSaYzgAjxypEpO0o+yt3XTm7afRHaBSRJYjMx/GXjXvaHWpyF0FowdhOvBnmRdncWhV5XnAJOSWLd9y/DbUS9Xko0G7GpGaiUXdv/QG6M+IQyDDlvM5gXfpjL/cVrv6X1gHbqFdkKr9GLZlBpu62U5/PQ/KpieJr4p56XqrlpoD40g+ag9csyIjSQLvLq1JY9K3/bTUSGP7ndZpLYjfhpxEpwdckxdM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8695.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(23010399003)(56012099006)(10067099003)(11063799006)(5023799004)(4143699003)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RUVTRDlxTXFXYjQ5Slh4d01Dd040cTdJTE5uYW5PZ3VZSDhsRjZvdW9BL3Fh?=
 =?utf-8?B?WEJWOUlFZ0w1TnU0S2VPdkdYdXIwc25xcHR1aXlwUkJ0cWxOS1VvTXdNZGJE?=
 =?utf-8?B?Ri92bXJqQjA3MktPcHFIVVRTQlIyT3cvZWg4UzZDOVpoaTdSVnJmR0dwdEdL?=
 =?utf-8?B?aFI3ZVAxNTM3YVlRcGlyL1JpQjFaTElxcEFzSGw5dytMaEtiYlpIWDJUcTNO?=
 =?utf-8?B?dnk2Uy9zYlJMSlhjeEUzb2tmYTN3Zk05NnJuVlliT1JiZ3pyd2pPSFVDU0RI?=
 =?utf-8?B?aU9QSWZ2TElBTmVaNVpwTEFCS3NCaStHN3Q5eTZNYXdYRTBFWEo5VDQzUFpC?=
 =?utf-8?B?aWZ5eTFmN3V1RHpBcDY1M0dnOUxWeFh2MkhUcUQ0THFUVllydkVKL253Z0R3?=
 =?utf-8?B?bjB3djdNbzdtLzdKUFBvK0M2Qk9Bb21GNEhLVDFQZnBHTk55RlpRdnVWYlVl?=
 =?utf-8?B?WTkvaGJRT3Z0ZC82UVhydzBvNjZBNzdwZmVVaHdTeHI1NzVhYVJYc0hrNHZh?=
 =?utf-8?B?SmpWdU1PaTFpZU5MdHRUM0FDSkpNQWdMaENmcGI5L1VKNS8zekhPM3IxL3RY?=
 =?utf-8?B?NEV3T1RiakduSE9PRGF5TFpBTGk5dzJ3c0RrV0RicENGdkNuQk1Eb0ZxN3Vv?=
 =?utf-8?B?SnVhdUNVZnlDZmwzQ0VCeXRHUkxadUwrZGVSNVV3bEJyWU0rVEZocmw4cnJy?=
 =?utf-8?B?TWo5UGY2OXYzaTZMUmZHNS9zSERTOUNNNW10Qm5Gd3VLS29XUFBHOXdtV0U5?=
 =?utf-8?B?aFNteGlydFZxa0ZxSkFEbnV0VWNnaXNMdUpyQzNMaUF6K3ZPbnNVUS9oNFh3?=
 =?utf-8?B?UTBGY3duTzRpeDN2YWhXQ2N3d0dpa2N1K1dlc2F1TGdyc3phMlA0THNaZWNU?=
 =?utf-8?B?WUdHaXZ3NFd5R0xnV0dkRmFsT3lIWlFvZjQvSGtQaVdZMWppMmhweDNSNHNr?=
 =?utf-8?B?OU1VWk5kUUw0cFNCemRBMTlSVzNGVnVtL0V2WnhlUTZ0bVZ6R1M5RDkxTkhV?=
 =?utf-8?B?b1l3MWJGb1BsSUhVcVBVTG9Ba2ZPbWUyQ20zT1JFWGZoU250b0hRYkhzaUhC?=
 =?utf-8?B?K1lhM0EyNmM1UHdaUXNGUU9ScmE5eEpxNmkwQS9EUTA2UlRoSXl3U2ZrdXZR?=
 =?utf-8?B?UXpRS2ZiRnZwMnZiT3hvVHVZSEh2QVhEM1dJa0NDbzlWanBhUzdZeGE0Y3I0?=
 =?utf-8?B?emIzSEUwdFo0Z0R4eE9wOU9iWUhqUzJldThyYzJWUjdNWnhTYkthdWtSbnFS?=
 =?utf-8?B?VkxDT2pteFhMVG1kNHQ0Vzhva0RNYlh5cWNZazMwQXM4Q0xJMTMwZEs5cWxa?=
 =?utf-8?B?ME56RHBOWXJZVDdIblNiT2FmQllJMm55aHRScmQ5VDBQdkt3N3NtMDJsakdT?=
 =?utf-8?B?ZWd6VXNMQmJHT1g3NUYzTFpUdjA5NG0xZC8yU3IweGhSSDJjeFVGY2VjQzdZ?=
 =?utf-8?B?NHpMT294UFRKVFFqVFJ3NkdleUErQmxUVFhiOEh5OUZZbXVBZ2E2ZHd5VE9y?=
 =?utf-8?B?U0xGc2lIemFMcFRIanh3TVI3a3lDM202WEJtQ1AvYUZ6aVF0eDZham1vNFpm?=
 =?utf-8?B?cWc1U054c3hhT201MWtlRFdzakFWQjBvbkdBeXR3d3hUTlp1ZGtwOFd0NW9a?=
 =?utf-8?B?ZGdjb29nSnBCemxlcFMxYmlvdS9pMHJST014S2tnWHU5Zkg3aUV5b3ErOEI2?=
 =?utf-8?B?NWphVGdwMFpkcXZHT2o4aHc0clZwN2RxWEE3L0FENW5ySUNHWWZ5a1RhZ2hn?=
 =?utf-8?B?UkhxMS9pRHpNbm0yeklZNi9SazloU1p3SjN0OUNuT3RURW9HcWRwaTFTMjZv?=
 =?utf-8?B?Nkl0UUVYOWJLK1NRcjRIV1hYT1VGdDdwa1dUeVNQcW12elhGR0tvNmp4aFpz?=
 =?utf-8?B?MEFQa0ZPbnJjUEZDYkIwaTdGN3hHQmJsOWdYbHZiMUh2YUFFYWV3ZmJSUiti?=
 =?utf-8?B?UFBBemhlbWxEdHBuU3R1cU1JendnSjJKRVE0Y0ZmSzBvejV1UEJuSU5oaEN2?=
 =?utf-8?B?YUlvdXlFY0VWNHdZOHVzRzRCc0pMVmxsT0Z6aGhPdnZnRlozQkVMNWNtL1Bj?=
 =?utf-8?B?ZFNIbjNmRTZkMXorVkVqbVk3a296NzJvaVVrVVJZQjB6NGRybEYwVWdZZlRB?=
 =?utf-8?B?bnZYZlZ2eXQ3eEo4V3psR0VWUExXZVp5eG1PWWk3d3hqK0ZXQ3UxSGJ6alMx?=
 =?utf-8?B?R0tGNzlucUphWkxQRjBuWGZTRXdPeENIdE90OWVQdjRsc083U3NJSXo5cDE0?=
 =?utf-8?B?eURmYTlKNnRvNVVlTE11dDc2Q244Uk9uTmJuQkcwcEFYa3N4WnkwV2M2L1FX?=
 =?utf-8?B?NC93bHdCT0JHTVg2S3o0THhPRmd4SGdrVktjeXVRNE5YOVRRU3Z6OEdZMUFR?=
 =?utf-8?Q?v57uDGtHcheOKClI=3D?=
X-Exchange-RoutingPolicyChecked: p6VrRF4Iwq+zAbcx/rUZIsDM9tJaoL5cGCvUwqp/mPWZz6jTp0V/oXDVnO6dHtc+H3QyptjEvDkdIKcQUYNKq2wQbbX6e3EzlSQz+Jj6QcoVxpDbhBuGY2naegcpO6PUqdqegcegphT6IOd75NImaJkrXyi4OhjPG4xkNTuy/obl8L+Twyi6vcBiCixHx1csdtLXSaC3eqIpmnSK1q22YoKp3c6cije34xpJ5ozVbafXnB0q4cIvvuDgkt0NbScgA60EkcCJKsvHO1At1tKhUct0J02vb1DmYU2G1zGy/DS28D9q8CV9k/YPN91UFQLkiRkNJ3rCQZACMO+VcFToOA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 50a904ba-1a34-4be0-d27d-08df09856373
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8695.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 06:34:21.7747
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KJsllLvJd9Yt4ypVUlLk64FGjr9ZMqN0m5vTPhMFnCZjCyYmGijxjPNlYHhfsyxvM62Vo70o+RtYCaJ+DSJvkAniiesA7qXgFZjf2kkC0Zc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6106
X-OriginatorOrg: intel.com


On 01-Sep-26 3:02 PM, Shameer Kolothum wrote:
> Hold recovery_lock for reading around INTx, MSI and MSI-X capability
> queries and configuration changes. ERR and REQ are software-only indexes
> and stay available while recovery blocks device access. INTx is covered
> by the same test even though its count comes from the virtual config
> space, so that one rule applies to every index which can reach hardware.
>
> The test is on the index alone, so a blocked device also refuses the few
> requests on those indexes which would not have touched it: signalling an
> eventfd for test purposes, and adding or removing the virqfd behind INTx
> masking. Both return -EIO until access is unblocked, which for a
> non-fatal error is the time the host takes to log it. Reading the flags
> or the count of a request is not enough to tell whether it reaches the
> device, and refusing a few extra requests for the length of an error
> event is cheaper than getting that classification wrong.
>
> Copy the IRQ payload from userspace before taking recovery_lock. The copy
> can fault, and with userfaultfd the fault is serviced by userspace, so
> holding the lock across it would let a user stall error_detected() for as
> long as it likes. The count read and the interrupt operation each take
> the lock for themselves.
>
> Assisted-by: Claude:claude-opus-5
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
> ---
>   drivers/vfio/pci/vfio_pci_core.c | 55 ++++++++++++++++++++++++++++++++
>   1 file changed, 55 insertions(+)
>
> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
> index 0b1b2398dc88..876ff51d6987 100644
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c
> @@ -1313,11 +1313,29 @@ int vfio_pci_ioctl_get_region_info(struct vfio_device *core_vdev,
>   }
>   EXPORT_SYMBOL_GPL(vfio_pci_ioctl_get_region_info);
>   
> +/*
> + * Which IRQ indexes can reach the device. ERR and REQ are software only.
> + * An index added later gets no access guard until it is listed here.
> + */
> +static bool vfio_pci_irq_index_is_device(u32 index)
> +{
> +	switch (index) {
> +	case VFIO_PCI_INTX_IRQ_INDEX:
> +	case VFIO_PCI_MSI_IRQ_INDEX:
> +	case VFIO_PCI_MSIX_IRQ_INDEX:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +
>   static int vfio_pci_ioctl_get_irq_info(struct vfio_pci_core_device *vdev,
>   				       struct vfio_irq_info __user *arg)
>   {
>   	unsigned long minsz = offsetofend(struct vfio_irq_info, count);
>   	struct vfio_irq_info info;
> +	bool device_irq;
> +	int ret;
>   
>   	if (copy_from_user(&info, arg, minsz))
>   		return -EFAULT;
> @@ -1336,7 +1354,15 @@ static int vfio_pci_ioctl_get_irq_info(struct vfio_pci_core_device *vdev,
>   
>   	info.flags = VFIO_IRQ_INFO_EVENTFD;
>   
> +	device_irq = vfio_pci_irq_index_is_device(info.index);
> +	if (device_irq) {
> +		ret = vfio_pci_core_access_begin(vdev);
> +		if (ret)
> +			return ret;
> +	}
>   	info.count = vfio_pci_get_irq_count(vdev, info.index);
> +	if (device_irq)
> +		vfio_pci_core_access_end(vdev);
>   
>   	if (info.index == VFIO_PCI_INTX_IRQ_INDEX)
>   		info.flags |=
> @@ -1353,13 +1379,23 @@ static int vfio_pci_ioctl_set_irqs(struct vfio_pci_core_device *vdev,
>   	unsigned long minsz = offsetofend(struct vfio_irq_set, count);
>   	struct vfio_irq_set hdr;
>   	u8 *data = NULL;
> +	bool device_irq;
>   	int max, ret = 0;
>   	size_t data_size = 0;
>   
>   	if (copy_from_user(&hdr, arg, minsz))
>   		return -EFAULT;
>   
> +	device_irq = vfio_pci_irq_index_is_device(hdr.index);
> +	if (device_irq) {
> +		ret = vfio_pci_core_access_begin(vdev);
> +		if (ret)
> +			return ret;
> +	}
>   	max = vfio_pci_get_irq_count(vdev, hdr.index);
> +	/* Dropped for the user copy below, which can fault under userfaultfd. */
> +	if (device_irq)
> +		vfio_pci_core_access_end(vdev);

Can we have some thing like this.

if (device_irq) {

access_begin

max = vfio_pci_get_irq_count(vdev, hdr.index);

access_end

} else {

max = vfio_pci_get_irq_count(vdev, hdr.index);

}

>   	ret = vfio_set_irqs_validate_and_prepare(&hdr, max, VFIO_PCI_NUM_IRQS,
>   						 &data_size);
> @@ -1372,12 +1408,31 @@ static int vfio_pci_ioctl_set_irqs(struct vfio_pci_core_device *vdev,
>   			return PTR_ERR(data);
>   	}
>   
> +	/*
> +	 * Interrupt teardown reaches vfio_virqfd_disable(), which flushes the
> +	 * global virqfd cleanup workqueue, so recovery_lock is held here for
> +	 * as long as work queued by any vfio device takes. Shutdown work waits
> +	 * for its inject worker, and an ioeventfd inject takes that device's
> +	 * memory_lock, so the wait can last as long as a reset there. That is
> +	 * only a wait. Nothing on that workqueue takes recovery_lock, which is
> +	 * why the ioeventfd write path reads the recovery state without it. A
> +	 * callback there which used the vfio_pci_core_iowrite*() accessors
> +	 * would break that and deadlock against a queued writer.
> +	 */
> +	if (device_irq) {
> +		ret = vfio_pci_core_access_begin(vdev);
> +		if (ret)
> +			goto out_free;
> +	}
>   	mutex_lock(&vdev->igate);

We are using a semaphore wait in vfio_pci_core_access_begin() and 
immediately after that using a mutex_lock().

Try to optimize this if possible.

- Satya.

>   	ret = vfio_pci_set_irqs_ioctl(vdev, hdr.flags, hdr.index, hdr.start,
>   				      hdr.count, data);
>   
>   	mutex_unlock(&vdev->igate);
> +	if (device_irq)
> +		vfio_pci_core_access_end(vdev);
> +out_free:
>   	kfree(data);
>   
>   	return ret;
