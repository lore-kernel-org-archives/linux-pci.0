Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011018.outbound.protection.outlook.com [52.101.62.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627873859F0;
	Wed,  2 Sep 2026 05:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788326268; cv=fail; b=TkWBvuGWZSLJJVc15XhcTgByBiqaYgo4VfrKOejOHia21LgsXssR91BACA6bb+apien6hR6iBkHcvhkIEGQNhiP1d/AChAnzz1w8aqYr8YMAUDkr2Ydsw7EPQ4UE9jbppunZWnll6eDdYDXZGJo/GP6Vdgjzun71Ejkg7d5ilbI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788326268; c=relaxed/simple;
	bh=nwYeJ+LU0e1ieLzJwjBUoBxoHWP7sOQU/UVr/0IH8ww=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kUWnU0WYebLWKrd9Usp/aFNLo5ZbRkaC1NrOjoo9lvXTC+JdMmLJi5TeaXtrMYtb5IXzpkOAsu3K5pn2iYx+LBHPAz+h9g3M5svs/jnzT3PcjNvUdB+PKPeQqtbKroo2+DpWz9VI5gUpVhwVDRdXhMbdwUpuLWsE4+29rL5K9c0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Rkq/rtxR; arc=fail smtp.client-ip=52.101.62.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Rkq/rtxR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sZDtskyRDX06Jk9x0njkhx7zprHH+Id24F43Wz/TuuzwYSsoG7q/3RlSTYx1IImx/pohnCYU2326qQyrr6BHpnjiIahQMIPYNT0UMwUoN6ppUdx4dlJ4gV3zhs9CSJsnWk2LWYmpMRSz1y4NPZIvOU7N0MUmSbRhLemfpMSHh/NXJdHv2UiOqux7gobPSj2+slGeOjsslEqWLyzrk52YorQY6n0e05U2qNaJ8uRvEuBaidMySFqpZBp4rpTCUhxal3nj5llRzias+DAbk+PY/eJnQDW+cFFZCcGk2C5KLl3aTL9JEvtR9YePmKRuOJ0N6fdHSVjP2AK+ujc3GSyRsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pvQa2s9kse89oJNnUotPiZugLcWM0BrMrvxcJkgwm28=;
 b=ko/9fIJw8EImgJAPswRZy/HePl4X+nkL4Gn+UAS4DuSy2pY5YbCvco16QMA2PvXaOvlL5vfZixzi2+hI7AcBUvSnGg7alLsuFP/Ee3y515Rx6UKJ4smHfsMoT7wBoM09ThCcHSRbKBOOvGsYszPpmJRk8CpzPvDbB1w6IlTRGtJJjAnTDy5hMlW0+yusgDtQ8QEVxDxm+O21vL5TbfXx56i91FNa0dZf1VHnP8ELx1ArHV6Z1gfEl4ca6RRGgkfAYCPgAFd1jnxRMX//G14PmO5pV4riZiIbiBUhjleh6wAnoM1f3Bbzf/X5cZHpwH4AcU3+qCiZLF4mzhG8FgXlvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pvQa2s9kse89oJNnUotPiZugLcWM0BrMrvxcJkgwm28=;
 b=Rkq/rtxRGpVrXPJzkSC87gh/qwgQwojRIwxC3hJUfZcXLdqRC7PNVvdjZ8DIDi8cV/RJ4xBVMW63r0P8PmwKD9RubJP7t96DL3Y8opGzQQcllQzRs/bBL7/oLTbeXXFw/xZhXtUD0fahTVTjHicDFK3DWPqmmfVDfbtfF9bisgCzItJxmEqlJIjbXeMTMSD46uwYILp17BDWIxpKbSM/yHP78RQ6eQMDNXTF+yyAkSg/dtjb+CyOZuRchpUadLQo2O8DgagUxZPs4xcm84FnXU6UlhVYhN2bI8p2i8GnLem4fgDv4JXixCIcpao1nbmEnh+xUPRTg8ioj3vOrNdY6w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9474.namprd12.prod.outlook.com (2603:10b6:8:252::17)
 by DS0PR12MB7803.namprd12.prod.outlook.com (2603:10b6:8:144::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 05:17:42 +0000
Received: from DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7]) by DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7%4]) with mapi id 15.21.0360.008; Wed, 2 Sep 2026
 05:17:42 +0000
Message-ID: <cf6b6a2b-0b45-4bb8-992c-cc63235be5b0@nvidia.com>
Date: Tue, 1 Sep 2026 22:17:39 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 09/12] cxl: Restore CXL HDM state after PCI reset
To: Richard Cheng <icheng@nvidia.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Dave Jiang <dave.jiang@intel.com>,
 Davidlohr Bueso <dave@stgolabs.net>, Ira Weiny <ira.weiny@intel.com>,
 Jonathan Cameron <jic23@kernel.org>, Vishal Verma
 <vishal.l.verma@intel.com>, linux-cxl@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 Alex Williamson <alex.williamson@redhat.com>, vsethi@nvidia.com,
 alwilliamson@nvidia.com,
 Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>,
 Vishal Aslot <vaslot@nvidia.com>, Manish Honap <mhonap@nvidia.com>,
 Jiandi An <jan@nvidia.com>, linux-tegra@vger.kernel.org
References: <20260804192958.1823952-1-smadhavan@nvidia.com>
 <20260804192958.1823952-10-smadhavan@nvidia.com>
 <aoKx7q0baAPJt2qP@MWDK4CY14F>
Content-Language: en-US
From: Srirangan Madhavan <smadhavan@nvidia.com>
In-Reply-To: <aoKx7q0baAPJt2qP@MWDK4CY14F>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR04CA0022.namprd04.prod.outlook.com
 (2603:10b6:a03:217::27) To DS7PR12MB9474.namprd12.prod.outlook.com
 (2603:10b6:8:252::17)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9474:EE_|DS0PR12MB7803:EE_
X-MS-Office365-Filtering-Correlation-Id: 50c54a88-2013-479c-c0c1-08df08b18379
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|7416014|376014|6133799003|22082099003|18002099003|3023799007|56012099006|10067099003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info:
	hEesTVO/coraxI9/4MnOSICe2kEkBYjmensSJLokw/XwN5cfMJv7l9zNJ+W/hbUykW1e6Ad57xuXP0GOk87+tmsks1mJteJwaJboMCKzApkYjCgcL6jcaJWxx/wQw1w0fn17FdW4HcRxRE2Vh7JoeGn9JkJUzPFgtgaUbLEJUCr+w+FW5CFVBmn2RQ1JW/ubqjhCNY4hRix/+OBtphWChMr4jJGpDkzi1VZdU1T2CKVZHPLeXJRko7vrwFLTTTczeH/KI8x3RbrM+rhAZ3GOQfFm/qT5UtYFQ2vIeIg2vWyBeHOGCTNhrkB/ATjQ0CkujqWEqCc5M2ITIKaqJCkQ4tj/GbP1RBMRsDzeKAgGGFwNQv/NBmxLnB7IEN/fQY+2JNG8EGf19j6ayBzw1Ofwz9q8N/wrT77dK14CQK3RW2SXJGG2YjJo5hR4zvW+a0wxkd2DY7HaUkNzOFtAg2YS/gNCHBt4vsIG68yjPtAHHYOQNS8tLqFtcfLcyNpp9h/ZTvKSaq56+FINIz09yDyfrsnhEhLgcX8PM65xLsxuIy8i4sTagMAAeGMFqzI8MY04b5doGaozrf4WrlWq5nQzJZl/8lIgc/+ixYhFI6eTY8/dBCAdETh7/45sKaDZ4L9eagwhLugA7f+OUAa63jvOqXOmPh1H4BpMZfQkBalCac4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9474.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(7416014)(376014)(6133799003)(22082099003)(18002099003)(3023799007)(56012099006)(10067099003)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cjRIak96dXF0QWVyKzNLTEJXZmxESFpxRXA1UXZkZ1FoaG52NjhoYlFXRjFO?=
 =?utf-8?B?YUxzUktSSURyR1dwWjFMaFVQQ0UzU1Y5TmNBOFNSYWh2aFkyK25QbW5ic2dm?=
 =?utf-8?B?eWs5ZC8wM3o4eWFIM2ZHNGd1TWQ3eGREbDZMRlJFQjN6NUZSSG85aE40MnJu?=
 =?utf-8?B?aVVCMXFGcUtLb1A4a1Q0d0xiU0Z3U2QvWmc3NHpFWG5ObkZnR2IvdzcrS2xK?=
 =?utf-8?B?aCtub3pzRXVmU3V2RFZxZGowYnNINU5QT3J2dys4akxXa0haN29GZGY5SzFi?=
 =?utf-8?B?UkRUV0dJKzZqeHdHbkpSay9rNy92RThFczJWck9pQ0l6SHFwV1dDdk40b3M2?=
 =?utf-8?B?enBGTFF1bmtHZTNLMmFJT3BwWlhobzd2WXNjR1RWeDBOREEyYlo2bUF0R01L?=
 =?utf-8?B?cDFobksrZzJBSWNoVTk1Q3lXTmpFRmkxN2hMdTgwMDJFSHg1TzMyMklJaTdj?=
 =?utf-8?B?MmYwa2tmbjF6Z0ZWcldMa0ZaQU1Xd1pyL2xJcUJ6dUc5VGhBSXhNbTVPMlJH?=
 =?utf-8?B?UjM0R1VlNHlUdzNmRDJpR2EyRFFkcDcxZ2R1U3N5Ukk3YjNITnJ3cG93dHVn?=
 =?utf-8?B?WUpDYytDbHRvOG9FOWx6Z2RTcGZQQ2YraEpLOFkySkxOS2RsdDFBUzU3eC93?=
 =?utf-8?B?TnRPYWxWaFg5MElWZTFsdGZTeHArY1BUSHBPdDlKU0psc2huZ25yQmNXWDBo?=
 =?utf-8?B?RzdhbW9YTHlxN2h6RDNweHN0Z2pkbVY0ZC9ucFMwVEhWc2pqbDM2bHFuV0lm?=
 =?utf-8?B?ZTU0cDJRR2d4WnlURFlNbkpBVSs4YkRnNEdoa3F6UVRKTWlHTFU2blZzOUow?=
 =?utf-8?B?MG52L2hZb2cvRmxUZlE0T2N2ZGs5RjI4bFpsR2UyNFBLZE9ZclRraEk0ZWli?=
 =?utf-8?B?ellqNWdHaWZGano4QUhvT0xnOUFzc3dQSmRrZjJWZS9WQTdJM3pxenlKQ0FX?=
 =?utf-8?B?N3J1b3lRU1FVU3ltQ1hyU2xwUnF2b0gya1hjWlJkZHlHUGtOdkVQQThqSENu?=
 =?utf-8?B?TTJFWk1zZW9iK3NteHg5bURoNTZLL0R3WHBRaG55NzlKSGsrY084RmY4Sm9Q?=
 =?utf-8?B?YlNPTFB0T3V3LzZ5K2kxYmNMS2xHY2JUODBoZ1h4WjdIR2YyYVJDSFc3ek53?=
 =?utf-8?B?V2F2dm1ISjdWb2hNRkp1ejBIZU5sTjlhNlZwd1FqWk04L0JyYVdWTWgyeHJX?=
 =?utf-8?B?bm1LREZvbXZlYlF1OHhUNjVvbHdSOFdBTU15MnMwaHd1cTBUR0NlRzVoK2lm?=
 =?utf-8?B?eU56d2hvaG5MdGlJc0FhR3R6aU83cENNUFJtZ2ozNFRHaU5sQzJ2K3NONDNB?=
 =?utf-8?B?TFFtWXpUcm9jRE5sOEpBMmo0Z2JXTWRYdUdsNllta2FHRkdaVVpCRGxQSXdX?=
 =?utf-8?B?RXFZd25KYXpDbS8xUG1ydVFpRHZWVXhaUThydkpuUnBKelJqMm1nT0Ywc1ky?=
 =?utf-8?B?VWQvSWlqcE8yS0lQOVhtZ0oyRHZsTHNYTjVFV2dFdmdGL2dPR0crT25GdUtK?=
 =?utf-8?B?WFZuWnFIZmpnL09hSjBKSmE5bGJvMzl3RTdiZWxaSW1NenJYak01cUtOZUxj?=
 =?utf-8?B?anNMSHc3WjZKMkFlVGdhbjZxZ1ZnR0hsTHVHV1hLTlM5ZFpGSmNjVUgzdnBZ?=
 =?utf-8?B?bys2b3dwTkVrUy8wTWVGVjQ4SEF0VC8rajF4ejhSeExKL3FwNkJjREI1WUxo?=
 =?utf-8?B?TmFHYXBTM1BYZTBXT0JCUkpuQ2l5SVNLVWYvU0xmbkQ4ZXcyRXgxS1FqMmdV?=
 =?utf-8?B?QU0vZ2xDcFQydWEwU0RlcVZyS0tKeEF3ZTB0OUNrdG1EQ0xabVZseTYwSFJI?=
 =?utf-8?B?M0h5OWhuMXYvUkxLOCtQTWhKem1SRFRpTWk3djVVMkdtbjFQYlhIK2JQZ1oy?=
 =?utf-8?B?dlM3a1JMSG93RVVuV3N2blRkUHROaWJ2NmRFNGtBT2QvTkxXcWVzRGRKTHBW?=
 =?utf-8?B?dU5QY3RtYlBSSXI5Nm1ST0F5SmMwMkZjdDVIcW52SzJZMlFIYi8veTlFLzlq?=
 =?utf-8?B?VnFjTXd6NVF4RGZoeHJrRUtiTHo5L3dHanpuOWRlekhybEpZWHpveW14eDZh?=
 =?utf-8?B?b1RQcFZpV0hQUmVOcDh3RFFicVovZlJrUUpGajBsNEZVTG9xMWorSmU4OHJm?=
 =?utf-8?B?djZSazYrSUFzVXptUC9PUEl5ODdDRDRhNGVEeG1oYnIrU0tzN0g4NzNldG9D?=
 =?utf-8?B?ekFTV045Q3J3a250WGJTUXBJdWx5VHRkMUNrQmUxNk50azZqWUJ0ZEI1cVl2?=
 =?utf-8?B?TUQ4azFXcDM1c2w0MC9rbnYwcmxFVllKY0VCd3BuejJIcklTV3JFQ1NhVHpG?=
 =?utf-8?B?NWxLVVRhdlZIUm5QbjdXbTdBZEZZeStCbWI5dzJRcHVzNXJCcWdJUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50c54a88-2013-479c-c0c1-08df08b18379
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9474.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 05:17:41.9130
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4zRnXSWIT4s1wvTyvNPChZRJ+oeoYrOy7l3N2sj6ae/3F+84rnLwcgoP/6E72ZMgFDasRQHw8fqlCuGUd4PtSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7803

On 8/17/26 12:12 AM, Richard Cheng wrote:
> Hi Srirangan,
> 
> I don't fully get this part. Once cxl_reset_initiate() succeeds, cxl_reset_execute()
> can still return an erro from cxl_reset_wait_done() or from re-enabling CXL
> caching.
> 
> It that case the above condition will skip PCI/HDM restoration.
> 
> However, cxl_pci_target_reset_done() is still called later, and the generic
> PCI reset path subsequently calls pci_dev_restore() regardless of the reset-method
> return value.
> 
> If the reset actually occurred but completion polling timeout, or if the
> post-reset cache-enable operation failed, couldn't this restore the IOMMU and
> PCI command state while the HDM decoder state remains cleared or otherwise
> unknown ?
> 
> I am thinking maybe this path need to track whether CXL Reset was succesfully
> initiated and then maybe save a disabled PCI state so the generic PCI restore
> path can't reactivate the device ?
> 

Thanks, Richard. I've updated the error path.

In v11, the reset path tracks whether CXL Reset was successfully 
initiated. If completion polling or cache re-enable subsequently fails, 
it saves a disabled PCI state before releasing the IOMMU reset block. 
The generic PCI restore therefore cannot restore BME or MSE over unknown 
HDM state.

> Btw, one small question, I'm unclear about the ownership expectation for
> FW-programmed EP decoders. If a decoder was programmed and locked by FW, and
> CXL Reset clears that state, is the generic PCI layer expected to replay the
> cached configuration, or should FW or the owning device driver restore it ?
> 
> In particular, cxl_restore_hdm_decoder_state() removes the LOCK bit before
> replaying the decoder state. Is it guaranteed that FW-owned locked decoders
> retain their committed state across this reset, so this reply path is never
> used for them ?
> 
> Best regards,
> Richard Cheng.

For locked decoders, v11 checks the live state first. If a decoder 
remains locked and committed after reset, it is left unchanged. If reset 
clears that state, the generic PCI path replays the cached decoder 
programming with LOCK cleared so the registers can be restored.
I do not assume that firmware-owned locked state is guaranteed to 
survive CXL Reset, and the generic PCI reset path does not reassert 
firmware ownership by setting LOCK again.
-- 
Regards,
Srirangan
