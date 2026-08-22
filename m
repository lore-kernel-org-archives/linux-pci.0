Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012052.outbound.protection.outlook.com [40.93.195.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CFAC3C3F7F;
	Sat, 22 Aug 2026 13:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787406975; cv=fail; b=AgdepVoWJ+BL0xApTdSBWz1WQqMttUwmzGB3+ToLQJ2N/ROXREdJb/tHAz+jqlHKhx81Iqh7F56pgJSUgqlyNWtCtlsx5J8B7DJVj3z9pHjLq9oL5juleY/0BT2Hu9QCeWiGmvfAEkydUdEqGBy4b6yuN5cm9yJqZGlnwvelutk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787406975; c=relaxed/simple;
	bh=4/4nJ2IkPCOfBHwUEc6sXxSSSA3hGqfItDzeB3VUUNw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UR+RLjWmZSj51TKXcXdABR1bHFHRbaOZtsdQ/j2VXdhx8fr8CaH1luMXebZZC3xPKgyU8W3/PhQJHudhrblZwVwLzQ0ul0XK3usrOyUONJVH5jR+EF8WGbT4f0T8gcNqrTZEbtNyPKA6bWJ1NGZJdxZOgBI0M94lXvK9mvHgIgc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KtzCTKsx; arc=fail smtp.client-ip=40.93.195.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KtzCTKsx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oY/2M4+PUx7MQhliGIleDtu/R0IwZKZJGsDAiHwhLQCwUYqQfHGw0tdDbMQNLdw7H/CZ2vtr35YZx+/oQ/WjfSMQ58RJU3ngfcYuVIwCHFny6C29dzoITHN9tKyc9+dXW1ZwsDoN87zGJQsynvU7mJIjlbmMOSVblXbEuMAjXqkDJG3MnwD/7Dk77ZBq/f8ZNfFbF2yCN2VSCIRdXLpj/ihe7a/VoChw8x4bW1SlKRZMwvrUbXkNXT/tD2cZDqseY0plWBdhjV7PZdFX0ncE4+z/RT/r4kEjS3cqRFi+3syx6xwyAJTPbvZyOE/dNyARmKHE+zlelSYjs5m3UgCTKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WpT8cG+7p28vAbQVl2PRZDkyP/kHecKyZq1u85woY5E=;
 b=S+P07xW8PIyLYsGUvAnAoQ2JbgleGMRUzNAARDUMYqtp4bXhf4SCKnl+HsaB4CzuU0cZqf0Hfh0CCG47O/UfgrmRLf4fLhJR5MvfXRpmDpiIWMGzac94LxXO5pZjJxHNPxApQQqimlqLWcSFhPPZpBBs1X93WQtR8za1ee2kyj7kY2HFwyim4Vqd82vk+bE7O/Af29TFV/1u5zzEHRQ9T2b6knKFuZmXtY8C4QFpFVedVTItdE55J3QGy/laloqnSZaB7N0rGM79ML8oqZOXTT9YEpojlWgLnGfL+YRvGLrVvRJ6U4akJae60pmXqZMcJ6LpEBWYMfrnLd1U16Negw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WpT8cG+7p28vAbQVl2PRZDkyP/kHecKyZq1u85woY5E=;
 b=KtzCTKsxeGWf4jbbPHdtEcvCI34Nq6NaUS67A88VO1XYzIVJdTzvRAYbpXOTRB0b1GCrp9CezbcGHK19lq7AQPp67RjpVXj8n1hYnZ4cIMmaJHRz70Hqvv8G+xFbbnlucfJvtlwdd4OqIIkv18I+FFxYyMtLjB/rgGIAxxrpKR4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL4PR12MB9505.namprd12.prod.outlook.com (2603:10b6:208:591::16)
 by DS0PR12MB8367.namprd12.prod.outlook.com (2603:10b6:8:fd::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Sat, 22 Aug
 2026 13:56:10 +0000
Received: from BL4PR12MB9505.namprd12.prod.outlook.com
 ([fe80::73aa:eb8c:a86b:5a83]) by BL4PR12MB9505.namprd12.prod.outlook.com
 ([fe80::73aa:eb8c:a86b:5a83%5]) with mapi id 15.21.0339.010; Sat, 22 Aug 2026
 13:56:10 +0000
Message-ID: <3488c164-4920-4557-a794-1ad5714bcb1c@amd.com>
Date: Sat, 22 Aug 2026 19:26:04 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] iommu/amd: Split probe error paths to preserve IRQ
 remapping
To: Pranjal Shrivastava <praan@google.com>, iommu@lists.linux.dev,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Joerg Roedel <joro@8bytes.org>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Ankit Soni <ankit.soni@amd.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Samiullah Khawaja
 <skhawaja@google.com>, sashiko-bot@kernel.org
References: <20260814015647.3370124-1-praan@google.com>
 <20260814015647.3370124-4-praan@google.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20260814015647.3370124-4-praan@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0198.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e9::7) To BL4PR12MB9505.namprd12.prod.outlook.com
 (2603:10b6:208:591::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR12MB9505:EE_|DS0PR12MB8367:EE_
X-MS-Office365-Filtering-Correlation-Id: 91241d0b-31f1-4999-ea71-08df00551f36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|6133799003|56012099006|10067099003|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	fOBOagdDcjzGshjNOsaivFiy6iaodCrJOfzIkLWyY//fMelqAfeKNpuWExw+CA00xgZg8XlAEv/U5zA0IErt1vBm9xYxDj+hNwxHeO/uEEUtLRAjANKfnLfU1t4i2InmS3DArEWCCZm66uF0hJ9A82DWsSSt7qO8+12gKwu0+qXYUJ9zToNWafX6QYaXP7OJx+KgmO8PKOqnm7Bb52AHkCJD6qC1Y4Syrdu823s4EdkS4ZvORKO8JCCMueHBpI0IKS5MnWzYyaB2yec3Wdb9mWGw2lQm1Rrdq8RHZCjEOSizV3kFtIXbAKanaKITjcChPYkL4m0BwnzQXcx37JNEFt6f8YSdqUAVippawsZlSAWw4jxX8F97f+tfRDpLI/I89AT4wjouQIo76QT8Q4ZBscRu7fgdvhBXk6YzV+4sDXq1v2qMinTsPi+yWCEDlZ1aqF2C4nEetve1+p9+YOY1M29SVZXFI+eAx1iWLImXm7LwURz7sFujpXPQIBKdJF1DLlH90uLEEmVE7sxuaYnY9+71NIBL1xAsPkDyeawE4ocu2CoGD60DrOkf+OZ+/BrAXRgSFc0EMTwuIY7Ecw1bBFIElvT4VN7g1zOybLMVwQz5KcLua4SsRbCYzm9d3ZFkXTF4gqqJ0GmuAw6W8Ya+TujqO58Vt5IkQWfwSqz/j7E=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR12MB9505.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(6133799003)(56012099006)(10067099003)(11063799006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SjN4NDExOTZGTitPVkkza1AzNkJsUTdlRmV0TEt6S203WUs4bWp2QWl4Z01p?=
 =?utf-8?B?d3lUa1BjOGtjOEdDL3REMlI2MHBQdm92MXlESUdLczJ1Mm0xUk9YaHo0UWhP?=
 =?utf-8?B?OStEOXA5dzRSeHdwUWw4dXhSMUVXV0Y1TTdwbGxhaFpJZFB0bldlUFhhSlFT?=
 =?utf-8?B?d2ZXWHc3UnN4NzZIRXRTYUROaFdGeWlGSW0wcGczayt3d3pqemd3bjVPYWxt?=
 =?utf-8?B?WmpXcGVMMlFGU1AvRWJTSERzcmRrd1VuT1JkYit3c3FzNzl5ZENtaFBxR3pK?=
 =?utf-8?B?SGZHSlpjQ3pucWV1bkdNdlE2T3Z0TDhNVlY5TlRPMEdFR0w0Tm1sOU96d3ZD?=
 =?utf-8?B?ekFlWWxTQzMzSWpSYy9BQkYrcEZ6STIvV1FRN2p1cGd6VDJIeGJaMXZsSStx?=
 =?utf-8?B?Wmx5ZWF1MG4yK1VveEloZU5jOHc3UjdDcWgxdHhOK3Z4YXpWWUl5WFk0SE9B?=
 =?utf-8?B?UG1uSVkwTWxLdDhLcCtVb004dUNtUVdHYUNtc2hLUVBRRVlkc05xT2F2NjV0?=
 =?utf-8?B?bDJOZWRxSkRUZlBBRTk1eGlCK2krMkhlazlENVA1dHlGdFdYOFkvaFlxTDBZ?=
 =?utf-8?B?RlNhZWtyQ25wUE5BYXU5VFM2SnU1YXk4R0M0TDVJaGR4ZG41RzAzMDd6aTUx?=
 =?utf-8?B?OE9kUU1CR0RUS3BDeHkzOWhIRVdNeXVpbkZHRXQrQUtqZDRSOGd6aXNTSVBn?=
 =?utf-8?B?aTRjSkkrZUZucnR6SUwvTnRmUGZ1d29CdFVYRmNrZFJBRlE2QkVqblR3SE5r?=
 =?utf-8?B?Q2o3U2tNbXg0SGtTeEtoTHhJV0tzS1pKSVZyWUt2UC8rODZOcEx0S0JtTWkr?=
 =?utf-8?B?dEV3SFJaSVNienlTdXJLZ2FVb3ZHeEFkSUl5dWE4NWQralhqQUxndnZ5UGs0?=
 =?utf-8?B?blBsbWoxcjlxZ1A5anlpZUJMK3VZcDZLVG94ajJkNFc1WnJkdVkrOHJML0Ev?=
 =?utf-8?B?bmZYdG4xVngvZEZNNHNuV2Q5L0ZtV1BBdWd1cjZDRCtGTlNTQzhwMWd2Zi9T?=
 =?utf-8?B?WlRzcml0Z2xhdE9HVWpUMGovVFdYWE12SGVMbkJERWR0SGdxYXFHR3BJRXRV?=
 =?utf-8?B?SGRzV1VkU3oyamZ4K3ZyNEpRRmYvTVMvSllmZVdVK05pNUI3aTVYYzJsQmN3?=
 =?utf-8?B?NVo1ekdTemcxRzhWUnJycjQ2L09yZ1R2eGtXdHQ3WVBjdkFYd0ZkQjJBUlUr?=
 =?utf-8?B?d2x6YU5CNTJIWUpKRzNxMmp3QjF2dGZoOUJuSnBpTG56UDRKSTZDaDVtRVd1?=
 =?utf-8?B?eHJteS90aGNsYWVsaW5hVTFyR2ROSHQvMTBLaGh1c0J0YXIwNlhjMFBoRG5M?=
 =?utf-8?B?U1RxLzhwazdjWkFscWhiV1IvM0NwellCOUZreHlNZ21BWWNGS0V6YTB1MlVj?=
 =?utf-8?B?SmtpbmFLM0c4ZGNIYlU4VkR1WWR6azNnb1lqUWtDYlNPRXptNURwaUZ6SkU2?=
 =?utf-8?B?U0J3ZE1aMmVBVVJmNkx2Q2ZSb0x6ZUhPY1AvclM1QlpybkRYR3Q5UmlHTnVV?=
 =?utf-8?B?d0p3My9WVnNNeXNCMzNETFRaOXpuTFZaSFJONFI1b2FtWXJiQldwQU0vc2Rm?=
 =?utf-8?B?V29ZNDVESlpXVXFvd0pZbXFtelRkbHdWTlZFY3A0V1FpQVI2U3RNMGw5VkFR?=
 =?utf-8?B?RjIxYjZvUFJtWStsSWIwQk1hd0tTUVU5N0NXOTh2RHVreUVaSjIraTRad3dy?=
 =?utf-8?B?Yld2SG5DSk16K2tzVEtTOCttTHBTUDdBTXBwVFpXanp4YmN6d1d0dGNuOU1R?=
 =?utf-8?B?NTU5eTBVZFJRaHJ6bWdQYkdkbmN2YUg3cmtjeXhVbzVoNGdyVHozZDB6N0h0?=
 =?utf-8?B?MHVkckdrQ0FnSnVOZE5QZEJsd3dKR3BhMGRBNXdYU0lrWnVDTWgrNHZ4SGpH?=
 =?utf-8?B?VllhNmhVakp0WHFieDFZT0hVM2x4QUZTYmJpMUtpR01sS29RQ2pLaE00VXFW?=
 =?utf-8?B?VVhHMDdtL3ZmejBrQ21IV3RLU3lrN3hWTThablQvV21VbUVnMmtyRTBycXRI?=
 =?utf-8?B?Ymd4QmNIenFUK2tmV2tpZzdOSlBMYW1xUjhIaGpncjBMbzJvZnlsVmxNbytP?=
 =?utf-8?B?TDdzc0hCRWlkTGEvU3VJUHRuRlFXc2hxT1BxUzhOUVJ2d0xUbERHYW10UVZR?=
 =?utf-8?B?cEFNWUFXS1g4dlNnQ3RqWkYwdG9GczBWTExEbTN4N0lsWDl3dGtjSEQ1TnBH?=
 =?utf-8?B?MmtvbkdQQmRxdkkxckFoR3kxUzhkU0ZmcTBTRThNNEEvL0F0TWM2Z2daVnVa?=
 =?utf-8?B?NEdwdXl6VGFYQ1E4dmZ4ZTJaYWRzOFVIdGROcEZET2xtaitRSW5NQzRSRG8y?=
 =?utf-8?B?ak94dnNRN2N0elc0b3EvZ2xJNFNUZ0tTZUlwUzZIcHE3VmZ0TFVyUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91241d0b-31f1-4999-ea71-08df00551f36
X-MS-Exchange-CrossTenant-AuthSource: BL4PR12MB9505.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2026 13:56:10.6492
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bKMbDOlg2A4fIrqopmrj0eRjv3ovoXDEgj8/v2WLgblPwYTqCY2NY3NYqts+TbcxUgoueaNB6pwYEqBO6TG/CA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8367



On 8/14/2026 7:26 AM, Pranjal Shrivastava wrote:
> Split the amd_iommu_probe_device() error paths into err_deinit and
> out_err. Proper init failures continue to call iommu_disable_device_dma()
> while configuration failures (like PD_MODE_NONE or ATS mismatches) skip
> it to preserve the rlookup_table entry required for IRQ remapping.
> 
> Reported-by: sashiko-bot@kernel.org
> Closes: https://lore.kernel.org/all/20260529153216.2AD1E1F00899@smtp.kernel.org/
> Suggested-by: Ankit Soni <ankit.soni@amd.com>
> Signed-off-by: Pranjal Shrivastava <praan@google.com>

Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>

-Vasant

