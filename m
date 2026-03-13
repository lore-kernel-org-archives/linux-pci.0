Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB6C3C6A2C
	for <linux-pci@vger.kernel.org>; Fri, 13 Mar 2026 18:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773428004; cv=fail; b=pfU+iljWHVHlepW877YzA7GsMtREeNV0nnzXLO29hZqsHBLuB+YBNuo5C21buVvKjN48hc6uwmIWHEUE6UQwQZHlXC5QHULuD570BUyIVmE079Hkk0sA8Ga36NYdFLM3jk/yk5OixUi8BVB/QqrzK8Rqjx6cLAsIVjiFokfGWjY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773428004; c=relaxed/simple;
	bh=Cmlqv1RUMAmzXpgj3zjpIKWB0sjUO8zdQ2OcfdFkDDk=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=Xf5EuRwWnjJFJHdHuZw53xjEXhcSs8dltJsRFJAqvyaFCCgveVKprUvnS4rBWV19zC/+AJej1CS+SR02/fp1r7QfUFWv9W+FPik26L7SNrLvDix1VNVpRbbfWgqigLjhPEjE+/h/P4tfbu1/SKS6RM8vIKT6APxP6rlhUZF43YE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ifVynoyw; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ifVynoyw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773428002; x=1804964002;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=Cmlqv1RUMAmzXpgj3zjpIKWB0sjUO8zdQ2OcfdFkDDk=;
  b=ifVynoywN/jh+BZbdZMByrCWKUICL34bkajl/k4aJINEV0lchWoz5ucy
   7guLSjtW9x3chpiOtju+m5opfsy42urEAvib0oFmodpt09mhYeIFbNIpX
   1KJi1IOsPrgEGUSPCCb+Oq/e6UuSO6YNHZTJqXQhfmlQeK9xndzKmYwH9
   3vFepQ6mJo+5KTgFROnW5IRUphYK6HNgMmjsLvoB7lO80t9rHpmcDyhbr
   0uj58LiECDTSDFIfaU1JuGGfzim+m9S0kFpYpgm6Gy5hcogHbvV54AV2E
   fexQSR5BWL00Gfi5fJ97BBA9K/BMBOK8sG/2XrFbjz7/tcgCi3Dvhmilt
   A==;
X-CSE-ConnectionGUID: YEJT+EBFTcqbcbo4imm6Bg==
X-CSE-MsgGUID: txvy+uNqRrSqJgTAjprlCA==
X-IronPort-AV: E=McAfee;i="6800,10657,11728"; a="74513109"
X-IronPort-AV: E=Sophos;i="6.23,118,1770624000"; 
   d="scan'208";a="74513109"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2026 11:53:22 -0700
X-CSE-ConnectionGUID: ko22Iqy/TVu2bUs8AzvL3w==
X-CSE-MsgGUID: 7Hv3GDl5RfmBYj4Mo6v/MA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,118,1770624000"; 
   d="scan'208";a="218569497"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2026 11:53:21 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 13 Mar 2026 11:53:20 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 13 Mar 2026 11:53:20 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.27) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 13 Mar 2026 11:53:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dFSa5HhAUd/+8xnbx2H60fY/EzlyG3nlWYutNde9OdBG4pWD2vUWuQySbvJz//JnYI5CatNGiPUWtGBoK7rlve5b4nNXNcaO9Zc9LYdQJ70nK7SjXtvMH1jvW0O27mhvpPJdtiA9WyzekHYBgykNEzSLrqLMDchHPMOcbxa2sRGgnvySmZ8R7PVGauxwcbjr4/NXomU/ctqclHCxS4q56iWnqoOeoh1tMaDwnWDH0RtMtKJleeKitek5gdyWhBYsPKvivnIbDQmGy5U6w6UMpL3nwDHe0ptaFt1BlA9i/CKnwnZkg83T9BIeQMv8i9H/YD7i/V/psSzdFtePzBJUgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O/PTHQ4SRBF0bGi8SaI6xCZX+QzRwNH9JI4The1h76o=;
 b=jHAZKMtOpVEU3yOgOG0Fiu2xBNIbvbCVAQ30C9OMz/viNUMygckkc04FjGuc2uko8ykjh7GAORl1uCK/p23kw/8Wwg4rJmE7ipGk0jCaL1HqFm+opskVb8nJSsHBMciVWgtBURDYvwT3Jy2/Rq4xe6PSeFxxulI+uvwTzOdo0pPzZcNWIYweUC6HZcdwjcs8b1cLSDmszHx0nF5/C8CjrBXOuiSjK1bWyap0B/OoTmsiq3vtV+tjKLAaujdwINL2EAHA59YWiTkd42cA2w8IOENhuqyugW5/WyhaZ+no3/C6oVbx0BEBrRZHDyv3zuCLDH3k/HaTY6EU1d1gUp6/fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ2PR11MB7670.namprd11.prod.outlook.com (2603:10b6:a03:4c3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.8; Fri, 13 Mar
 2026 18:53:13 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%3]) with mapi id 15.20.9723.008; Fri, 13 Mar 2026
 18:53:12 +0000
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 13 Mar 2026 11:53:11 -0700
To: Greg KH <gregkh@linuxfoundation.org>, Dan Williams
	<dan.j.williams@intel.com>
CC: <linux-coco@lists.linux.dev>, <linux-pci@vger.kernel.org>, <aik@amd.com>,
	<aneesh.kumar@kernel.org>, <yilun.xu@linux.intel.com>, <bhelgaas@google.com>,
	<alistair23@gmail.com>, <lukas@wunner.de>, <jgg@nvidia.com>, "Christoph
 Hellwig" <hch@lst.de>, Jason Gunthorpe <jgg@ziepe.ca>, Marek Szyprowski
	<m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Roman Kisel
	<romank@linux.microsoft.com>, Samuel Ortiz <sameo@rivosinc.com>, "Rafael J.
 Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>
Message-ID: <69b45d178ae17_b2b6100f2@dwillia2-mobl4.notmuch>
In-Reply-To: <2026031319-payee-photo-bdd9@gregkh>
References: <20260303000207.1836586-1-dan.j.williams@intel.com>
 <20260303000207.1836586-4-dan.j.williams@intel.com>
 <2026031230-mastiff-create-7593@gregkh>
 <69b38e7427a61_b2b610073@dwillia2-mobl4.notmuch>
 <2026031319-payee-photo-bdd9@gregkh>
Subject: Re: [PATCH v2 03/19] device core: Introduce confidential device
 acceptance
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0070.namprd05.prod.outlook.com
 (2603:10b6:a03:74::47) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ2PR11MB7670:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e21d793-e5dd-4aac-aaa9-08de8131c71a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: yRyywZWWbUAbvPFrmAgCtGnV0moIie1LstHUG2v9Lm0oCmiOK5FJ+/wlruxombs2okrs6m4knXn1RlZF2jZ+jNA7x+puBCGoxLqjmu9jdwEUbST3UJAqbwqT4Ljt3UB5ibX+LVN2bcAhvjkM/iaS7JI7dTcjrl+g8MevY5Ux4ZgvDMPmOYYEGsZpetjCtGeR7UZmn7iusnByLZI3Y5fFe8nM/PoRGEJo4AKWqPTEA2X4rITPOB5Pe/pKQcVFv8f14D77xC4pKim1DdF5qlgbK8YQHLJZT4PRtM5W1w4zelolPP+QO2X2RJKwkQKixxDcY7jfEhWOOnczjooQIhDe+bIaixJKLZYlla+4VoATJX/7xHNTspx9eynoMAdoEN9rypbyf/tkJiwdF+eGhNAABatPKLAkkEaObuYX+0KjKYWM5SeKCYQZdSOd2faonAjWzcddd69SaoOKn8vAzfmzAhK6vj/3VvCwWr6knUeaoGb/cLWTPEvdR0wAcRfp+38uWCO/3Uk09DXLGSzI9TcSpWqf6K7s5XTprGz/ktUEltJ8JOsP4hWCqBrClCmM6KjDVJB54bls5WDb6jAETc1IohOvJEwzOPiWYGmjwvmGJ89oLtgR0e4K+fORy8oEKaM7Vn+n5OsMF/DxXo5jpg+mIJiXD0hxivuB0/w32UaO1aHmt9v00svVYPHW0DU1UaPV9tIMWPUmttIw8ODN0+2zopnPT/SMpy49UJ8w0qiZjwc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T2xjUFNzdjYrOTl1bG12a1QvOFZhemRhQ05wUlNEZnNBZVlFcFhnS21QdzN2?=
 =?utf-8?B?eFpMYnpkU1ViRmw2US8yME5pcGM3MW13MThXN3dVWndobG9ucXJZdUN5QjdD?=
 =?utf-8?B?T0l6Y2FwdkFEU1VMODV3cVBvNjhKNGtGWTVvWmVzNHFzSjJaRzA2cHJiL3RR?=
 =?utf-8?B?Zzc3OEkxZGxCNzBWZ1FGbU5XQk56N3VSNFZHNjd0NUZOMm4xT3lqMVFWejFU?=
 =?utf-8?B?VmVZYjUyVTB3YmZsTGNQeDdLZ21yN2tsTnZNOFBXQTdSQk1uR0laOGFIazBI?=
 =?utf-8?B?TXlkYkZnVFlDMVo3eU1hY2Qrb3V1ci90NVBXM3J5cE1meHdyT0p3cmxDby8r?=
 =?utf-8?B?ajRYMlU0QWhMeUFmQjgxY1lJbWpJeFpyeXRTNVVabWF1bTFXQ212S0grUkh5?=
 =?utf-8?B?ajc2WGNkZElWQ3NPOEQxalN3Z0lLZWY4N1o2eUlhSGU4NUZnUE5IZjl1N0to?=
 =?utf-8?B?TkJHWGpmek55SFNPK3ErR0FYaU5kNUhIb0xTNExTaGVhc2Q0U2hDbFgrWjUv?=
 =?utf-8?B?YUc0b2Ixamc4YmhVTktXQ2dqTzZBaktYMDhIMzZLNUZTUlBNMHM0TDdKKzF3?=
 =?utf-8?B?Y1pVellhT1liVUxlRkhQbnVzdWcvSGtRNVlROFgvUndkUDhBS0hCS0hPc0FK?=
 =?utf-8?B?MS9GaFNNUWtzaG4rQzNxMkZ6cXd3SFpVTldwRnRrWkEyQVdxYlpwZTFxZmI2?=
 =?utf-8?B?SGNVdm5zNUJMNFZpaXpoOFlqMjF4RzNSMVVxR3JXd2JFZmRZSGdyWURUSUJu?=
 =?utf-8?B?NDlsL3ZYcHNPT1FjKzlrWWhrbE5EbmJCSXZnY29kaS92MlRyRTNLUjl4aUpJ?=
 =?utf-8?B?L2FYWEFpVHppSkVjRDFRT1ZJUHIyT1cxUU9pcDdkR3cxa1B3U2toOWk2Qk15?=
 =?utf-8?B?V3NnL2NMNTFmN0dvTENOeDExUDhYWnFtNWlneGY0QVRLVW9rWWJuY0Fmelcx?=
 =?utf-8?B?SmRyT0krVGIxUThOY0IzSk9adGpRYThqNURQQ05kajZjRURKUFlFSUhyR1ZP?=
 =?utf-8?B?bSthbm5udVIrQ3dhcURvUThKMFRlTnJBZE9NbGUvbldLN0dOOGh3Y3V4UDJp?=
 =?utf-8?B?bFNMTUpramNycmJ6NURPSnVzNUVIYmxsWThiQThpK2ppT1VTdy9WRkFvejM1?=
 =?utf-8?B?L1RQZHNJNVg1aFB0Q1YxZllId3Vzd2dTd0tNMUlKWUM3V2NnS3dqS0w2dW1P?=
 =?utf-8?B?KzBsdjFBZ1A5dDhjYUNCUlFKMDRRemtzV0ExUWdOOEFmVkduamlBVkEwQ1kw?=
 =?utf-8?B?aWl0a0c3aUl5M1ozdnBENVR0VFBCdEpha0pTcjZWUVI1ekFFMUpXdEZIODNY?=
 =?utf-8?B?b241YWdoenFCU25ISER6a3VUVWp0SVJlWjBHV2dvRHVIQzcrQWFUd1ZqeTM2?=
 =?utf-8?B?dUtvbzVDR3hzVnZKQ2pzSnd2a3lOSXZSKzRkeXNWa1NQRm1lWFlBcHA1aU5u?=
 =?utf-8?B?ZEk4UzZadmJlbzVnQzBGOFJDTWFjU01YbTR0WUhwVFBWRjRWdmtqNkNDK0kz?=
 =?utf-8?B?QnhhZ0VuQ0hLcEUwTDMzekZnQ1BQOEZvQUhIK2daQ05wbDFRcEd4Ny9qM3hJ?=
 =?utf-8?B?cDNFbEhFbnpob2ZvbjFuNDZPMVNBWmdtVHNySXpUbkRBckNRSVBVRVNYRXA0?=
 =?utf-8?B?YktzT1J1NDBPTU9PRHd6MlRTaG9CdnVTSXk0TmpqRFJ1OU9xdGcvV1NubTZv?=
 =?utf-8?B?MVRDQnZlUEVoVDJwSVdDMVdZTkZUTE5FeFh0Vnc2SXNWbWRSOTRLOFZPelhu?=
 =?utf-8?B?UlREU3NrZ1kzSXdLYVQ2eGRHcEMrb1UzUDNDakg5S3daeGpWRjdGSnRjQnk5?=
 =?utf-8?B?dXdMYm5waWZWM1RPMEtUM1BiV1BacUkzOGJyVVlBR1hjUmFEMzl2aUVGMHV3?=
 =?utf-8?B?ZnNEeVZEbGplTWVuZkowajdhdzRaZWNERE5SZjFXQXFGRStGbUYraElKWEZz?=
 =?utf-8?B?VUdwR08vVVZRcDBMbFJXMW83cExHckZIRlI4UzBld3orckpVUlNFVmVkZWI3?=
 =?utf-8?B?LzBrekVtdExwbnVsS1pjWWZtQUphL2tGM2VYbFZBTVZvZnB2QkVMMjRaQm9h?=
 =?utf-8?B?V3paN2orS1o5a0ZtWVorMDBJV2hUbGY1dWE1RVFOR0Zib1ZWVW4wS0NUK3lp?=
 =?utf-8?B?eDBlYzZTTG5TQWppUUo2UHBLQlY0L3BWai80aWJGeXZoQVpDeXgvZzlUL0Yr?=
 =?utf-8?B?TkFBVy9XN3hUNjFEMVpVNFdncytKNllWNlIxUm12ejhPSGNucjQ1NDVUTVE3?=
 =?utf-8?B?SmpMak9OWVRCc0pUaVRUUTFZTVFDMzl3RGRSN0NRaURGM05RaFJPaFA1VmJI?=
 =?utf-8?B?VjdaV0cyOTBaYk5UQ0ZpNTMyVkJxVFhhYmZiMHMwbHZxNEVuNzU3ZnlxSVM2?=
 =?utf-8?Q?kATqKl5KQijNfARk=3D?=
X-Exchange-RoutingPolicyChecked: Hy9B1XbPBfFmcR3sK7OsGa7HiPqAKJ2YDVjrdrubOFkY5sdpxoFoYEN+6DVa0KJqpoowZ3tEcbmfx05sxg1G2ioxrkTOLL+yGFBNMxWZDPe6exFAi6+ylb8b0C5q6WnaWP1p5DwnJSDWR3X08rMBN0SuJtg+xokBGxOhG1YEZR/UaE9fY0DJmY2qwpNyZPW3BC1s86R/tfMGKeC2O7oQ9e8UlXRAOqrxuKWW4IOPyckRg9jDSY6zj9c+Mj2YtwvBz/FaXLgsQS3zaotQG+MPFCfNLaFw7Mmj9cryi+gEm9G6jocC6f64BH3Uo3ozDpWFI5J+G/WcErcsrc7r7hd3dg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e21d793-e5dd-4aac-aaa9-08de8131c71a
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 18:53:12.8297
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SneSktsC9rLEGq9XLIGfquPRAyiIMxiJ/bt0pAGdYf9dnIkkilMRdBjMTvlRwGxI0vcGAh+8fiepEeIvPkC0AFUbdmAlDw/GYYxke13G6/0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7670
X-OriginatorOrg: intel.com

Greg KH wrote:
> On Thu, Mar 12, 2026 at 09:11:32PM -0700, Dan Williams wrote:
> > Greg KH wrote:
> > > On Mon, Mar 02, 2026 at 04:01:51PM -0800, Dan Williams wrote:
> > > > An "accepted" device is one that is allowed to access private memory within
> > > > a Trusted Computing Boundary (TCB). The concept of "acceptance" is distinct
> > > > from other device properties like usb_device::authorized, or
> > > > tb_switch::authorized. The entry to the accepted state is a violent
> > > > operation in which the device will reject MMIO requests that are not
> > > > encrypted, and the device enters a new IOMMU protection domain to allow it
> > > > to access addresses that were previously off-limits.
> > > 
> > > Trying to mix/match "acceptance" with "authorized" is going to be a
> > > nightmare, what's the combination that can happen here over time?
> > 
> > I do think Linux needs to mix/match these concepts. "Authorization" is a
> > kernel policy to operate a device at all. "Acceptance" is a mechanism
> > to operate a device within a hardware TCB boundary.
> > 
> > So, the truth table of combinations would be:
> > 
> > accepted	authorized	result
> > 0		0		logically and physically disconnected device
> > 
> > 0		1		connected device, DMA is bounce buffered
> > 				and loses confidentiality, integrity,
> > 				and performance
> > 
> > 1		0		logically disconnected device, but a
> > 				relying party trusts that the device is
> > 				not spoofing authorization.
> > 
> > 1		1		connected device, DMA is direct and gains
> > 				confidentiality, integrity and performance
> > 
> > To say it another way, when the above distinguishes "logically" vs
> > "physically" disconnected it is whether the device interface can be
> > verified to not be under adversarial control. An unaccepted device can
> > do limited damage, but still can bounce buffer secrets out of the TCB if
> > so directed.
> 
> I really don't agree with this, but I can't think of why at the moment.
> I feel like you are looking at this purely in the TCB point of view,
> while I don't feel that is something that should be considered "special"
> at all here.  Linux has, for the most part, always trusted the hardware,
> and now you are wanting to not trust the hardware.

I think framing "trust" as an enum rather than a boolean better
addresses this problem.

> for some things and parts of the kernel.  Which is great, it's
> something that I have wanted to change for a very long time now, but
> let's do it right if at all possible.
> 
> Give me a few days to come up with a better reply, let me think about
> this some more...

Sure, but I also think we might already be converging, more below...

> > > We need to either "trust" or "not trust" the device, and the bus can
> > > decide what to do with that value (if anything).  The DMA layer can then
> > > use that value to do:
> > 
> > Trust is separate. For example, there are deployed use cases today where
> > the device is trusted, but unaccepted. Acceptance support for those
> > cases is mostly a performance optimization to be able to stop performing
> > software encryption on top of DMA bounce buffering.
> 
> If "acceptance" is just a performance issue, I think you all need to go
> back to the marketing people as that's probably not what they intended
> to have happen here.  For some reason I thought they were selling this
> as "security", not "speed" :)

Do not get me wrong there are several threat models mitigated by having
hardware assurance that all communications with the device are
confidentiality and integrity protected. Hardware assurances that
attempts to subvert those protections result in hardware error states is
part of the value. However, you can approximate a subset of those
protections with high overhead workarounds.

> > > > Subsystems like the DMA mapping layer, that need to modify their behavior
> > > > based on the accept state, may only have access to the base 'struct
> > > > device'.
> > > 
> > > ^this.
> > 
> > The DMA layer is not operating on a trust concept it is effectively
> > being told to select an IOMMU.
> 
> Ok, then that's independent of "acceptance", that is "use this IOMMU vs.
> that one" type of thing which is just a "basic configuration for speed"
> type of thing as you mention above :)
> 
> Let's not confuse that with anything else like "acceptance" please.

That is fine, and I think you and Jason may be hitting on the same
concern.

> 
> > > > It is also likely that the concept of TCB acceptance grows beyond
> > > > PCI devices over time. For these reasons, introduce the concept of
> > > > acceptance in 'struct device_private' which is device common, but only
> > > > suitable for buses and built-in infrastructure to consume.
> > > 
> > > Busses are what can control this, but please, let's not make this a
> > > cc-only type thing.  We have the idea of trust starting to propagate
> > > through a number of different busses, let's get it right here, so we
> > > don't have to have all of these different bus-specific hacks like we do
> > > today.
> > 
> > The conflation of "trust" and "acceptance" has been the main stumbling
> > block of past proposals. As you have said before "kernel drivers trust
> > their devices". That precedent is not being touched in this proposal.
> 
> Ah, but I WANT to touch that.  Let's FINALLY solve that!  Or at the very
> least, provide the infrastructure in the driver core to allow busses
> that want to do that, to be able to do so.

Jason's framing of an enum rather than a boolean for "trust" seems
workable to me and melds "authorization" and "CC acceptance" into one
concept.

> > Instead, give userspace all the tools it needs to deploy policy about
> > when to operate a device. When it does decide to operate the device give
> > it the mechanism to add confidentiality, integrity and performance to
> > that operation.
> 
> Yes, this is a policy decision, and if you are only saying this is about
> "which IOMMU should we select", then that's a dma layer configuration
> option.  Let's not call that "acceptance" please.

Done.

...and there is precedent for a "trust" enum, lockdown levels. In that
case as well there are a menu of priveleges that can be incrementally
enabled by a policy.

> > This is a "CC-only type thing" because only CC partitions the system
> > into two device domains. One where "trusted unaccepted" devices can
> > operate without CC protections and "trusted accepted" devices can
> > operate with CC protections and direct DMA.
> 
> In other words, it's an IOMMU switch, so why not use the switch
> infrastructure?  </me runs away...>
> 
> anyway, let me think about this some more...

Will do, however in the meantime I am going to speculate that this "trust
as enum" idea is workable and start drafting some patches towards that.
