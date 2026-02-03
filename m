Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010019.outbound.protection.outlook.com [52.101.201.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38189364EA6;
	Tue,  3 Feb 2026 18:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770142927; cv=fail; b=q0H3dC/mvDAqmkwkHRMZFCnpi0XovYFK0ihURZEip3ZyAJOFMJwu5B/o6nR2o+jN8G5uDT0rQ0q09tJSGavnK6CacGUDfpL4A8d/MuANGHaVGJ+89NA8Q9fg/WlbwSFVQLyVVj6boeuCunkn+KBcWSIJ8t2jQtR0H9q0zVIF4r8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770142927; c=relaxed/simple;
	bh=xTzSrv3mwod8xG+X+PffoZfDmIdM1/dtY2A4K/b5GgM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UyOVtmR3fd/8oPylNia6yvxwYtoAE7k+PpA16B7RJL9khUqpgX1JnGRrRNq771Y8xtEVSzoNMn9YTMZb+sPW2zREbsFQqBPHHsiSK6IAauydj3EhVY0sr6Ksa1NvMmkJ18uRtuyy42A3v0KJLZx8kNDohIVkS0riVgBR/zpsV6U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=PDjXclGn; arc=fail smtp.client-ip=52.101.201.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="PDjXclGn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AGGPTTCqzTjYIJ8L4kQGCufKDFDZX8zZPOy84APgTVdwKcbGnLmFdCcZh0OY3lveBNGpjFEW4DSpQro4fKUxK5z8mLBnUD7lIk52ZNTo6MZ2cfkQfwo8W5TV/6K9Xb13M+Tbn1WcB+fof6LPU93/Gc2jqw6Lw1ZInHJoNwIjSYIdPNoMvRgLHNfIFfFYjH9DnRwvDnY1R71tltM6Z/Zzgj+YfmHHgP7HrCXwRHcwUsww5g+8AAHoY5+pGEa16XvPgqii5Yqxj9B8lX7JARS4oC96jlWS4KqrjAd8DSla3Gc9KDGRoI6Eg0WTgYN40BiTe0LY9u9JYNflBp7A3IxWhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6nF+W7/rbir+UmmcO0deM4dxXfs7M+vjhIZ7EN85Kwk=;
 b=Cxc1+6tnNqENEHgtSuBYtV1FeMR3hi2c0Hr0M5WPO367Mm05WrTPCOkAgHiC8re4p7extklBumv22AfXPTJXyOkF6KlZn3ZD2H80GZZFjJtK/ZNkasBXK9arCwhehOioO8q+gT8dRa8mUrcXwBpoubRoUCR0uaIryDayBf3H1I73o/WX5QNOEahXs3ukIKZU3pW5adTEVeZ2FOoZbhNmUT/hHZrHRI/h99rmsYpEuVajHPcVRr7iHvsagnAwId6C4PrX99xt1nxC+kdo+iowNi119VfeJN57rzNy5fZ5FwjOnod3hIHyrHVb6vCRFNKuuYUFzVjwceQBxaCIEyo7Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6nF+W7/rbir+UmmcO0deM4dxXfs7M+vjhIZ7EN85Kwk=;
 b=PDjXclGnMxl8G9CplkGtx3EqyQDXLfpyX0nAYu0eR6p+kDyv+s5x60ISGFKdVRmkFlTDqKGNMAwvYf3Jy400/L19R5wcG6DEWtwKDOJO51iHH1nhm1vMRlAuLzY7ETIn3hy0YIhFiThZhSlQz/EHlDQZXHi+q3g7TOyGaxRQeh4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS2PR12MB9749.namprd12.prod.outlook.com (2603:10b6:8:2b9::14)
 by MW3PR12MB4460.namprd12.prod.outlook.com (2603:10b6:303:2f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.13; Tue, 3 Feb
 2026 18:22:00 +0000
Received: from DS2PR12MB9749.namprd12.prod.outlook.com
 ([fe80::ad8d:e59a:e61:4e9e]) by DS2PR12MB9749.namprd12.prod.outlook.com
 ([fe80::ad8d:e59a:e61:4e9e%3]) with mapi id 15.20.9564.016; Tue, 3 Feb 2026
 18:22:00 +0000
Message-ID: <e296e48e-40d1-483b-9f49-78e8bd3b885f@amd.com>
Date: Tue, 3 Feb 2026 12:21:56 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 5/9] PCI: Establish common CXL Port protocol error
 flow
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: dave@stgolabs.net, dave.jiang@intel.com, alison.schofield@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, shiju.jose@huawei.com,
 ming.li@zohomail.com, Smita.KoralahalliChannabasappa@amd.com,
 rrichter@amd.com, dan.carpenter@linaro.org,
 PradeepVineshReddy.Kodamati@amd.com, lukas@wunner.de,
 Benjamin.Cheatham@amd.com, sathyanarayanan.kuppuswamy@linux.intel.com,
 linux-cxl@vger.kernel.org, vishal.l.verma@intel.com, alucerop@amd.com,
 ira.weiny@intel.com, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
References: <20260203025244.3093805-1-terry.bowman@amd.com>
 <20260203025244.3093805-6-terry.bowman@amd.com>
 <20260203154039.000001ae@huawei.com>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <20260203154039.000001ae@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR02CA0093.namprd02.prod.outlook.com
 (2603:10b6:5:1f4::34) To DS2PR12MB9749.namprd12.prod.outlook.com
 (2603:10b6:8:2b9::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9749:EE_|MW3PR12MB4460:EE_
X-MS-Office365-Filtering-Correlation-Id: 9076799d-9107-4843-736e-08de63511f61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ekRJc3JtYU05N0JmSWtHd0NqaU5Xc0dUQW1uUWRNNVRxRTRFL1czWllpOWlr?=
 =?utf-8?B?eTdqR1hYZVZha1VtNzMxdkpKbzA1MUFnRmxnZ0ZYY0Z3SXNEUjNLZW05dnNG?=
 =?utf-8?B?WlBpYmtoeWNXaGZJbEtCbHI1cGJ5VHRzRW1GYnNSV2RhTDRuUzE3MTQ2ZW1i?=
 =?utf-8?B?ZDdKTTVWRVZmUHhHTmFiMjlBQ09ybnhFOXZDWDZCWlo3amFSUEk3N3BlRDJz?=
 =?utf-8?B?WkdGRXc2Wjd2ajY4NEp2UmxDUlZhMGFkQTMxbDZwN2k1T3NzQ0ZBMXZvRGl5?=
 =?utf-8?B?UEd1bGZWY2MvK1BVRjJScHIvbVhoc0FrMWczcHo1dksvRkQwWncwNVdYb0Ez?=
 =?utf-8?B?bWhDZmk1NGpjM0xvNFhIUWVyMEhtKzNZWlRYemNhL05hT2ttOFVITW1kQVF1?=
 =?utf-8?B?LzFvWDY4ZTJHQVh4azlhZEQ3aEpWTjVZaW9vUGRJd1ZYQVhDUGlPRU90bWxi?=
 =?utf-8?B?T0xOeUJRVTdVdStnckcvMUwyWnl1UDFyeWxrL3RGMy9aS3VMRnRLSitvWE9G?=
 =?utf-8?B?ZWxFbE9DUGkxY2lzcVpjYXZ5WWFlcEVQRTBWMXBVUTViYjJaUTNKamhvSTZH?=
 =?utf-8?B?RkJZS281dGZ3UGxYK3g4Z0ZaeGNPZU1jNFNvVHdsVjk0cjg0YzVFdm9Uckxz?=
 =?utf-8?B?N3o2S2tLcGpLN292Sy9palA5WDV6RDVYbnY4bnBJSjVmUDdINjRKNGxZajhP?=
 =?utf-8?B?M3ZBbzNMSTN4QUhUbEM0aUZsTEk2di8wV0ZRM0NtOG1JSTZiSjROV3h6UStD?=
 =?utf-8?B?NllWUXllakd4MUFEbUxLNTAyS2ordUR1dm9XdVhxVFZYVzZLd1VONXZSUUNR?=
 =?utf-8?B?SFUzVElWREpTSE1DdXpEcGhFUGJwRW1UYWdRTHRaWmdlUFVXOWdYbThzaWJ2?=
 =?utf-8?B?NDZwOURFWW5iOTg2cFFrMnNiVlFiRlIyZXE3MmNNditXMjFjY0Q2dTFhakxi?=
 =?utf-8?B?eUZESWdnY1huSmxvYUJCMWV2eFNBV3lzU0QrcjFGVnZZY3p6U3ZxTTlqVW5K?=
 =?utf-8?B?b0RyenVmdGM2WU1hOXk2dFEyWEVMeE5mYVcvM0EweDF2alFsMEFHMTg0MDNx?=
 =?utf-8?B?Z0ptc2pSTzgxS0FBK2IzQXpsS1lWanJTNis1SHRwRmlMb2ZlVW1CZWMvZTg1?=
 =?utf-8?B?MExRczdYU3VKMGJZUlAwL0FBVnBVNllMZ2hMS25RMEthaVRKTGtwcTVoaElL?=
 =?utf-8?B?cm5TZTVlRm44U1EzUy9kT21qN3BNK0laT2JMcDkxL2g0Wm5RVWtpQWhXU2xU?=
 =?utf-8?B?V2FOdTRtcVo3SFlCdFYvTDU0Y2RyY2tPeE1GM0lzSUxVaWZsTWUvOCsreDZO?=
 =?utf-8?B?NGpNMmNtalJRRjFJdzFnQmNNOE5hbmMwVUJtTzBwQ1V6cU1SNS83ek1MeVNF?=
 =?utf-8?B?Tm5RWEsxYW50V0pqWXlZVlJ6dGIyYkU2S3RjeWFzVzIydFRsekNFeTg0WURM?=
 =?utf-8?B?L2NRSkZRb2lxd0pES1hXbEVySWxJdUtXdGZzdWtsOHhuRzRFWEU4WlpZRU5w?=
 =?utf-8?B?cktvOWl6OENpeXFKU2szd0p5ZnBCSUovL05PNTR1dGFBRG10d25WK3lnRU92?=
 =?utf-8?B?NGFGbG9rRnZ1SWcwdjlidVNPQUtnd2hDcUMvWUZwMEt1Q2FEOFY2UVRhYTYz?=
 =?utf-8?B?UC9yWUNkaUl6RmlLVUhTczJFdUNKQzViUjYrK3Y4bk9qVEtGMkg0cGVva0VB?=
 =?utf-8?B?Z0xyNVFqa0p4MVNVUGM5Yk1rcG91bDhqUnVQTmV6Q2E1elpBVHBiOFB2OVZ1?=
 =?utf-8?B?dENmdFV2OFcyQWUzd0xCNmNrS2FmTWFMNm9jc3lBV3EyeWdnVGlqTGZoMTk3?=
 =?utf-8?B?M1l5SkJaWHIzTkdHZ3Z1eWlVcGFzQzhUVEFtKzg5QURLREdUTW1NSkZ5TUxW?=
 =?utf-8?B?azFzQjgzQkYrR3Zwc3ZMNXRxN2pScGlHdWlLN2lrL25FT0JIL0d1bUJod2U5?=
 =?utf-8?B?ZTNlNTVhei95QVBTalRvQU5ZS3pVSVZKbG9Pem8vMmlZM09lUHZSOFVPWDdD?=
 =?utf-8?B?K0ZING1xaE9iZi94SVFnVjlDdGVtVjh0R0JKYTkydXRmRE9QeUNzMHNKZS95?=
 =?utf-8?B?WjZvWkhDZFJncEJzZVB3b3hHdkttamJ1QUQwcW5ibUJLVnF0TkFOaHlHK0VN?=
 =?utf-8?Q?UDdc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS2PR12MB9749.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VU14NnpWbmRKMFc1aFhUb1R2MFR3Ry9aeHhRaDM3NjljaUwydjFibjFzNWRh?=
 =?utf-8?B?aHNlc2dYa0FWTk9NTlZvSENrS3NzUjRaRkVvbjdFck5CNVFOQlk1V3k2OWoz?=
 =?utf-8?B?bjJSbVh5dmxUWU5ZZGM3dk9ROURhTnQ1NHNoVXdOVDlYbFA3bllXSnBxaVFR?=
 =?utf-8?B?aFZUcTc2T0JFa1h5UTNBY3JBQ0pCZktsRzArUUZId3F4RWtUYUlhTXBqQk1a?=
 =?utf-8?B?dlBSQTlCWkNYK2RlaHV1WGRmWElTWk44M0I1VHkyekw4UHk5dlJpYzJRQVlV?=
 =?utf-8?B?a1p5WUFXVWFiajRzNWxmV29yaFZNWk1oemlCVHcwamxXbTZrQXUyekhRc0VR?=
 =?utf-8?B?RVhDcWZUb2VLVUh4aW50K0RIeGdBK1ZkRUJrK2pxNDl1dk9aRzJWYm9GZUZB?=
 =?utf-8?B?SkdXK2MrT2hQZWRGTU41RE0vQjlpTllkbXJFU1dITEZMYktUU3JRbjdsOUxp?=
 =?utf-8?B?U29QazBrdWtMY1NvQUVXT0tzcWlwYk5ZN3M1RGFGcnVQM1k2cGphT040aHB1?=
 =?utf-8?B?QVVyTTZ1OUIrVXFneUcrT29qdGQza01Pald6NVV1NVkvTmZWa3F5SnNnUk55?=
 =?utf-8?B?cnNRK0pVU2F1ZDJ1Q1Jhc1V1a1Y4Q2VYb0J0bEJmcFAwUTd2WnNEelR0VGlk?=
 =?utf-8?B?bGh4MVJ6Q1doWEtkUVp2eHRIZEEvSk1WU3ArTzdZWWQ3bXFDZkR3bFB1R3Vh?=
 =?utf-8?B?d2NlbUpyU0p6MWRid2lNQmJoZ2NBUjhJd1FiMktQVGNWVHZ2MFVVZ1puUUcw?=
 =?utf-8?B?TCtNSjhGVE5pbzcyamRPUEVPbERmY1FpYWppSmdGSVFWUllzZUdkcXlGWXFq?=
 =?utf-8?B?V2g2NS9EMHFtd3YxTHF6NjlYRm1Ba1RPSm8zQi9pK05GZUpzTzJRVzBFckdq?=
 =?utf-8?B?aFdWR2xRbFB2VVNLdldPVU8yQ2tGTkJVbFRSVGpZeitxeUtRMUw0b1ZLZ2Rx?=
 =?utf-8?B?RWhuek1KaDJBMGk1dEtKS2pVci93djhGRVVaWTFiNDFJK3pEajRjYndMOEdT?=
 =?utf-8?B?cUJCT2xtTWR0QWdza2JVNGloU244Zmp6SitWVE1tVU5FU2lkdnNSZlI5K05p?=
 =?utf-8?B?TTdTb1Yzb08zVEhlT2JLVUp2QSswVjgrYnVjdVJ6MUJxWlo0OXB4RXB5a3RC?=
 =?utf-8?B?RnYxcFYzSWQwV0tYUVd5UVY5KzY3UkFURHVWUG40WlN2S1ZKMk5KQ3hLQ0g4?=
 =?utf-8?B?RXpMZGpIdFpJMVhOTjZtcjZxZWp3ZHlYTEw5eTdvWEhZc0xCM3lQdVJSbGg4?=
 =?utf-8?B?ck1Kb0R2bEtsN0JSNzlrMUFkaXo5UWRKaFozeTlSTjdnTGU0S1VTZHBxYUFZ?=
 =?utf-8?B?RHpYdzJRdUFBZkJTUEx5eURsUnpOZENCVlhSaWM2SGdUckhGZnkrYXhWbnht?=
 =?utf-8?B?bk12aG9SemtJbkJzdlNQKy9Ud09IbWtDZGNiMzM0TCtzZmdMYUM3OGNDSjVr?=
 =?utf-8?B?Q0VxN2htOXZRdzJET2xKTm1zcEE0a2dSd1hJRThzM1JFdFR6OTNJQWlYZWdq?=
 =?utf-8?B?cWpvdkUxdk16dk94MGVlYXpWNnJTNzJPUmczQklqNnlQeWRwaHlIRUhlb3dH?=
 =?utf-8?B?c09MRTFDbzZCL3p1eW9ZMldudkk4blBlT1g0Q1FTUitwZmpTMGpDSWpaVHYx?=
 =?utf-8?B?ME1pb0VLR1ZZQjJPSExjaldYekJWVnBqYUNXLzk0VlJCM2tuSHQybkkyVlRT?=
 =?utf-8?B?MGZoNGlmL2dVaW5IYzIxWlNKd0dVWTg1VGpiR2NJbDNYbUtNUVMvZTdEejRZ?=
 =?utf-8?B?VHZlUnFGam1jOHg1dHI3SU9hZEdyc3F0Z1dMU3Z1VGZ1WTc4cy9NckFOT3Bn?=
 =?utf-8?B?YXRSWnRkZVpXZ0ZCcnUvYnUwb1RsaEJwS1EveE9RMS9kcWxmZit6aTNtc2hr?=
 =?utf-8?B?R2J2cWEzcWIweXljbUQrQy9Nb2tHcXVmK2tqWUZwNCtXUThtQWxFZEZKRkM4?=
 =?utf-8?B?YnpGRUZIMzdOODRid3c5QmpWV1VReEZZcFliU0FXMEdaZmVhZDlySGFXVk5z?=
 =?utf-8?B?d2dpVzVFNjh0aWd1dDRHSEVNaE5jUXF1bGhJK2UzRE14K2NWeGlGT2JsUlhE?=
 =?utf-8?B?eEJVVVU5RmEramJ6cnZRbFJxZ0J6NEhUSUJJZVVmMFFQajB6QlQ2ZmdBRUlk?=
 =?utf-8?B?TXFWYmZzSm1zOU5BeXBJRXk3THE1VlcyamFRYmFKNDVBWG5DUjJISzJpWWR1?=
 =?utf-8?B?blJRZmdjdXhSNE5Odm9QamxlaVpQQUZZeFNYUFkxYkdmb2FSdkZwd0RyUjBk?=
 =?utf-8?B?aThmNnJweGFaNjdqRWVibUZMWTJ3dmpSV0tLNWJzSWNTREI5RGs3dHVOZjRG?=
 =?utf-8?B?RTFmUkRwL3VNcmUrdEp6bkpUQ1UySWVEbWtDZ0thMjBHbVc0RFRyQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9076799d-9107-4843-736e-08de63511f61
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9749.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 18:22:00.4467
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BBBMTv8OI/3T4yWVNQODH7dM2hxkXgNHAImO+Mr9zHWh+c38Qc49KdtlxB+jU7pyNw729EvVuq/JLHlm+X7OQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4460

On 2/3/2026 9:40 AM, Jonathan Cameron wrote:
> On Mon, 2 Feb 2026 20:52:40 -0600
> Terry Bowman <terry.bowman@amd.com> wrote:
> 
>> Introduce CXL Port protocol error handling callbacks to unify detection,
>> logging, and recovery across CXL Ports and Endpoints, including RCH
>> downstream ports. Establish a consistent flow for correctable and
>> uncorrectable CXL protocol errors.
>>
>> Provide the solution by adding cxl_port_cor_error_detected() and
>> cxl_port_error_detected() to handle correctable and uncorrectable handling
>> through CXL RAS helpers, coordinating uncorrectable recovery in
>> cxl_do_recovery(), and panicking when the handler returns PCI_ERS_RESULT_PANIC
>> to preserve fatal cachemem behavior. Gate endpoint handling on the endpoint
>> driver being bound to avoid processing errors on disabled devices.
>>
>> Centralize the RAS base lookup in cxl_get_ras_base(), selecting the
>> downstream-port dport->regs.ras for Root/Downstream Ports and port->regs.ras
>> for Upstream Ports/Endpoints.
>>
>> Export pcie_clear_device_status() and pci_aer_clear_fatal_status() to enable
>> cxl_core to clear PCIe/AER state in these flows.
>>
>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
>> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
>> Reviewed-by: Dave Jiang dave.jiang@intel.com
> 
> Hi Terry,
> 
> A few comments inline.
> 
> Thanks,
> 
> Jonathan
> 

Thanks for reviewing.

>>
>> ---
>>
>> Changes in v14->v15:
>> - Update commit message and title. Added Bjorn's ack.
>> - Move CE and UCE handling logic here
>>
>> Changes in v13->v14:
>> - Add Dave Jiang's review-by
>> - Update commit message & headline (Bjorn)
>> - Refactor cxl_port_error_detected()/cxl_port_cor_error_detected() to
>>   one line (Jonathan)
>> - Remove cxl_walk_port() (Dan)
>> - Remove cxl_pci_drv_bound(). Check for 'is_cxl' parent port is
>>   sufficient (Dan)
>> - Remove device_lock_if()
>> - Combined CE and UCE here (Terry)
>>
>> Changes in v12->v13:
>> - Move get_pci_cxl_host_dev() and cxl_handle_proto_error() to Dequeue
>>   patch (Terry)
>> - Remove EP case in cxl_get_ras_base(), not used. (Terry)
>> - Remove check for dport->dport_dev (Dave)
>> - Remove whitespace (Terry)
>>
>> Changes in v11->v12:
>> - Add call to cxl_pci_drv_bound() in cxl_handle_proto_error() and
>>   pci_to_cxl_dev()
>> - Change cxl_error_detected() -> cxl_cor_error_detected()
>> - Remove NULL variable assignments
>> - Replace bus_find_device() with find_cxl_port_by_uport() for upstream
>>   port searches.
>>
>> Changes in v10->v11:
>> - None
>> ---
>>  drivers/cxl/core/ras.c | 134 +++++++++++++++++++++++++++++++++++++++++
>>  drivers/pci/pci.c      |   1 +
>>  drivers/pci/pci.h      |   2 -
>>  drivers/pci/pcie/aer.c |   1 +
>>  include/linux/aer.h    |   2 +
>>  include/linux/pci.h    |   2 +
>>  6 files changed, 140 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
>> index a6c0bc6d7203..0216dafa6118 100644
>> --- a/drivers/cxl/core/ras.c
>> +++ b/drivers/cxl/core/ras.c
>> @@ -218,6 +218,68 @@ static struct cxl_port *get_cxl_port(struct pci_dev *pdev)
>>  	return NULL;
>>  }
>>  
>> +static void __iomem *cxl_get_ras_base(struct device *dev)
>> +{
>> +	struct pci_dev *pdev = to_pci_dev(dev);
>> +
>> +	switch (pci_pcie_type(pdev)) {
>> +	case PCI_EXP_TYPE_ROOT_PORT:
>> +	case PCI_EXP_TYPE_DOWNSTREAM:
>> +	{
>> +		struct cxl_dport *dport;
> 
> 		struct cxl_dport *dport = NULL;
> 
>> +		struct cxl_port *port __free(put_cxl_port) = find_cxl_port(&pdev->dev, &dport);
> 
> as if this failed, dport is not written. Alternative is check port, not dport as port
> will always be initialized whether or not failure occurs in find_cxl_port()
> 

Ok.

> 
>> +
>> +		if (!dport) {
>> +			pci_err(pdev, "Failed to find the CXL device");
>> +			return NULL;
>> +		}
>> +		return dport->regs.ras;
>> +	}
>> +	case PCI_EXP_TYPE_UPSTREAM:
>> +	case PCI_EXP_TYPE_ENDPOINT:
>> +	{
>> +		struct cxl_port *port __free(put_cxl_port) = find_cxl_port_by_uport(&pdev->dev);
>> +
>> +		if (!port) {
>> +			pci_err(pdev, "Failed to find the CXL device");
>> +			return NULL;
>> +		}
>> +		return port->regs.ras;
>> +	}
>> +	}
>> +	dev_warn_once(dev, "Error: Unsupported device type (%#x)", pci_pcie_type(pdev));
>> +	return NULL;
>> +}
> 
>>  void cxl_handle_cor_ras(struct device *dev, u64 serial, void __iomem *ras_base)
>>  {
>>  	void __iomem *addr;
>> @@ -288,6 +350,60 @@ bool cxl_handle_ras(struct device *dev, u64 serial, void __iomem *ras_base)
>>  	return true;
>>  }
>>  
>> +static void cxl_port_cor_error_detected(struct device *dev)
>> +{
>> +	struct pci_dev *pdev = to_pci_dev(dev);
>> +	struct cxl_port *port __free(put_cxl_port) = get_cxl_port(pdev);
>> +
>> +	if (is_cxl_endpoint(port)) {
>> +		struct cxl_memdev *cxlmd = to_cxl_memdev(port->uport_dev);
>> +		struct cxl_dev_state *cxlds = cxlmd->cxlds;
>> +
>> +		guard(device)(&cxlmd->dev);
> 
> Maybe add a comment on why this lock needs to be held and then why the dev->drvier
> below needs to be true.
> 
This can be removed. This was added to ensure the EP's RAS registers remained accessible 
during handling. This was when when the mapped RAS registers were owned by the CXL memory 
device. This has changed such that the EP RAS registers are now owned by the EP Port. And, 
the Endpoint Port is already locked in cxl_proto_err_work_fn() before calling this funcion.

>> +
>> +		if (!dev->driver) {
>> +			dev_warn(&pdev->dev,
>> +				 "%s: memdev disabled, abort error handling\n",
>> +				 dev_name(dev));
> 
> Same question as below on why pdev->dev / dev_name(dev) here.
> Maybe pci_warn() is more appropriate.
> 

I believe the driver check can be removed but would like your input. The check 
for the driver is another piece of code specifically for when the handler was accessing 
the memdev's RAS registers. It was a last check to make certain the device is bound 
to a driver before accessing. EP RAS is now owned by the Endpoint Port.

Ok, I'll make these a pci_warn().

>> +			return;
>> +		}
>> +
>> +		if (cxlds->rcd)
>> +			cxl_handle_rdport_errors(cxlds);
>> +
>> +		cxl_handle_cor_ras(dev, cxlds->serial, cxl_get_ras_base(dev));
>> +	} else {
>> +		cxl_handle_cor_ras(dev, 0, cxl_get_ras_base(dev));
>> +	}
>> +}
>> +
>> +static pci_ers_result_t cxl_port_error_detected(struct device *dev)
>> +{
>> +	struct pci_dev *pdev = to_pci_dev(dev);
>> +	struct cxl_port *port __free(put_cxl_port) = get_cxl_port(pdev);
>> +
>> +	if (is_cxl_endpoint(port)) {
>> +		struct cxl_memdev *cxlmd = to_cxl_memdev(port->uport_dev);
>> +		struct cxl_dev_state *cxlds = cxlmd->cxlds;
>> +
>> +		guard(device)(&cxlmd->dev);
>> +
>> +		if (!dev->driver) {
>> +			dev_warn(&pdev->dev,
> 
> Somewhat circular.  dev_warn() will print the device name anyway I think and
> this pdev->dev == dev here so might as well use that.
> 
> Or was intent to use different devices?
> 

No. Same device. I made a last minute change to "make logging more useful with 
device name" and the change wasn't necessary here. I'll use pci_warn() as you 
mentioned above.

-Terry

>> +				 "%s: memdev disabled, abort error handling\n",
>> +				 dev_name(dev));
>> +			return PCI_ERS_RESULT_NONE;
>> +		}
>> +
>> +		if (cxlds->rcd)
>> +			cxl_handle_rdport_errors(cxlds);
>> +
>> +		return cxl_handle_ras(dev, cxlds->serial, cxl_get_ras_base(dev));
>> +	} else {
>> +		return cxl_handle_ras(dev, 0, cxl_get_ras_base(dev));
>> +	}
>> +}
> 
>>  
>>  static void cxl_proto_err_work_fn(struct work_struct *work)

