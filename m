Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011050.outbound.protection.outlook.com [40.107.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D85C4322FC;
	Wed, 19 Aug 2026 09:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787131085; cv=fail; b=k6o/Dqss1JRpr5mPA79XWUDrs9db1TNA2KyPBSxIisLVlIP23NGAg5K2lN2fh+hTsGgisLBPpdpS+scyyNysJgFE2JdFyvSjoof2qvuHRNKtfcRm1/z5ywFjWjF62YmFcHBHsHOGC3MRZ+gWOXtS/qjUXbPFhosAuMSE/wasQtw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787131085; c=relaxed/simple;
	bh=yfG05sX6lz2l26yolTsz/Y2jv8euwZlLrVF8koMXdY4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=F3bJ9DHnMsfgNPZmyCjHSD208qeAs3zOdB4PuTOItqUi7EPO7WagpLzfrktaFCBRrUdsyFMBypPlBRLhdijRpJ6gSgS1F39jKftQS7x3ztX+l/Vd4ug5VIJ3WP2j6nmDp9bUdniE4olhCVN2MP1BeuDA6wEIoCe2blg0mk8weUs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=nbpQgiQG; arc=fail smtp.client-ip=40.107.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nbpQgiQG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o6og4obSiDPIFu7aWiikECmag5+O//cxo+osDvR9WT+Sc3Nht9ObuoKZv5bNSYWmUYfE+8MtYgFw6oWurEMbaRwlX+x7J0HXk4iMTVO7pdIO3ak5zVjOkN3mj9HWl0yj1T4tibZd8QTr65ZHIrhmoq+St1o9qkV9ULPIzO5lQxmG916SY5+KfDRTicgKUpdWkEXQkcAxCkDdYl/GwcFyvtCCi2nM2G63m2UM8qjIUYoX30LU7l3na+yB00VnqND67Do6+zGYc0UETyZgb5yf6U7xjMXiZwlYvDmk5cA65H/Sy6saAHKdlSOJeD87lu3wN9dIXcFHUDP/F4VC7mmzvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mqQNkdFR+8h/Ij4mcIscV2qqYR1raOO/RqArRD5Rk3g=;
 b=XtgqE2Odisfub/IUOit/xlV/VCVuC6459vVCmtvAiEzPgxaD9URiAoYC/5a3rlfGraSIW+ZCeeSnCcKVLVPbPLU1SUiyXNjGKj6k7H10ZiZVyQsoBAymmfodscLAMAlyMh4ZjsrK0AlMYXSRv1BFjvyJvQsDf0UsqveEn2FyMCZVmJsGVboSocjQvIdrH/yIZvbakP4t684gMpzsmdBbhDBxr4J2ZZpANAb5UAYyIxkyoB7SiSx1jSJ5/OUktBD0Wna4oPQ6aR3dgJgR6rZiVjjBjuOIgMRSBDJk3dHDPIS7DMkrQR5WLcTwDSGyU6lKiAOwIk08micF9q5e7CIC0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mqQNkdFR+8h/Ij4mcIscV2qqYR1raOO/RqArRD5Rk3g=;
 b=nbpQgiQGxOuX63X+DGyh6687z13afVnKbJefJCY3aVrFKYMYWmziRw/Lyryw9TEpaqWf5Xja8HZzlGOKLFmYYB+OfFHOeWONHLi0eT3jD4po/xs/kzy3m/jyY/ClOhRNaJvfElnGVu8cIv+op6zITHH5/kO0lvtHCxZI0sSSvjE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL4PR12MB9482.namprd12.prod.outlook.com (2603:10b6:208:58d::19)
 by MN0PR12MB5905.namprd12.prod.outlook.com (2603:10b6:208:379::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Wed, 19 Aug
 2026 09:17:44 +0000
Received: from BL4PR12MB9482.namprd12.prod.outlook.com
 ([fe80::e4cf:3801:9631:2965]) by BL4PR12MB9482.namprd12.prod.outlook.com
 ([fe80::e4cf:3801:9631:2965%5]) with mapi id 15.21.0339.007; Wed, 19 Aug 2026
 09:17:44 +0000
Message-ID: <82f00288-596d-4445-b40e-abe54fb5195e@amd.com>
Date: Wed, 19 Aug 2026 14:47:37 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] dmaengine: dw-edma: Enable Chan Separation via
 VSEC
To: sashiko-reviews@lists.linux.dev
Cc: dmaengine@vger.kernel.org, linux-pci@vger.kernel.org,
 Frank.Li@kernel.org, vkoul@kernel.org, devverma@amd.com
References: <20260819070947.4080389-1-devverma@amd.com>
 <20260819070947.4080389-2-devverma@amd.com>
 <20260819071954.D79D01F000E9@smtp.kernel.org>
Content-Language: en-US
From: "Verma, Devendra" <devverma@amd.com>
In-Reply-To: <20260819071954.D79D01F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0330.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:222::8) To BL4PR12MB9482.namprd12.prod.outlook.com
 (2603:10b6:208:58d::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR12MB9482:EE_|MN0PR12MB5905:EE_
X-MS-Office365-Filtering-Correlation-Id: 62805b26-e289-4dd6-3880-08defdd2b9e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|18002099003|22082099003|6133799003|10067099003|56012099006|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info:
	QON1utmoTXhP4O1o59Ru0RsSvETaExM/77yekm69vh9DwmH7k0hvCjp5mT8sDYf2IcHjJuBUH7WnT+Ji0x90JrjgbMQgoHY0cEdEW0qNo+hTTdv/f0u6hCvtY/sY4eXDMfkphLrJhXMkyPzA257Wn6OUzXWnblyTAofCytzhT0DCKQXgYSj0KH8CnCnvwYsCq+m4O/c2/Fdw6sw+3JQMsVJ/g8tV0GL1uiYbV5/7NIsy4lIernXPBcKH+6IzV1eGOV+P6nIc9+COjeYeWbNqy334WPlVYTJVDNytNmozopTWk5VBWqJiFs+J4YzXGLbyGIqOohqu7VM6ETRLelopTn9VirpsKwbwnBh6Bm9eSHqheGogiPKoLA6TcNW+BbKYabkHPqqJAnUg9sWIe3pVRP6N94EJrjF9eOtWIO/fkGxv6V+8RwyPNkDdfC8SQousJ4xppJIfBDq0EF7YbZ+nPPknvluuU050Ccm7FH3Sfd17Y+ZEe//8aSIRS1r12N8udhFHv2N2UpboOEH1xDMRAMleDX4MiTQHHdSzgivPnzMQTPbp59QNzUSsfjujBsiJIHFSkmW5MKV6A+o5ogRuMgOWRlby+SVtDRmMReG8oU0d4uku4Ykd/mheoBuT3Cecuq3gplQydW6i4IFWfapWEO8MEhRoJHS92NES+xjh7qQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR12MB9482.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(18002099003)(22082099003)(6133799003)(10067099003)(56012099006)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c3NGWnF4NE9XL0lCdEx5eXRjL2tka2JVVGp5dDJBSHBQblJmdVl1UDlaY0lI?=
 =?utf-8?B?VVRoTVJCcStBVDhLVHo3empwMy9lK2h1VHBGdlllV0Y0ZWtsK1phNmNOY25y?=
 =?utf-8?B?NDdBNGZKUEJPSmQ4TjQzcnhiWnNKR2ZldnNzR3VWeXIyU3ZUa2VIN0xDQ3R4?=
 =?utf-8?B?ZWtoUlNYejZnUmcxNjgyTlNOUk5RYnN1UXUyVzBMQkdiSmNma0dZUWpCb1Vs?=
 =?utf-8?B?ZXliM2pQMGhUZ3JxTG85Wlg3TGFZREtTRkZBdVZiZm9lL05MazBHeW5PWHZi?=
 =?utf-8?B?b0EzZGFBMnlVNmRwSWI2cXIyMUU2ajhQZk8wQ1h0Z1Fsdk41cjNTUDE0VUV0?=
 =?utf-8?B?NXZIeHRJL0k5N0ZuNDIvR0Jwc0RFZ0VraDVFV0FiREZTTk9BRERFcmg0R2xs?=
 =?utf-8?B?T2JPdUthQjJLN3NXc2RkMkFtblR3T01YQTBkUFFVLzF1TkRoUUsyY0wzTFR0?=
 =?utf-8?B?NWoxYUJjU2l4elBsUVVZNVNrTzY3bGZRV1dzTWRJNHp0aFBtS3k3bm90SHpS?=
 =?utf-8?B?SFRFSGo4dWs2RmJGY2V1bEkwR0MvVHBLNFAyWWk0bXorMmYvRDRuV0x3WjVv?=
 =?utf-8?B?NHFmR3c1WTVKUThMUGtzVC9wczFmRklRUzBYTUt2ZkdnTHdMM1J4a2s4ZkFz?=
 =?utf-8?B?NGgxdjdlc08vOS9lUnNTaUdpQWU4eGprK1JCeEpMczFBSUlBYXpCSWF0ZmY3?=
 =?utf-8?B?akt0enlNRTB1Y2VLZ3JWS1FpNTQyVE1HRFNYTENtSzZnYmh2NG1RZTdqM0Rj?=
 =?utf-8?B?VWZneGQ2TS8wVnhpcnBrbFZJUjUzbnRXanpEU0FaOTAwVlMzdnFaazA4eTJI?=
 =?utf-8?B?OS83VmZFeHQvZTZMUEtqV2wrNlgvL0cyblNZRHlWSk1jUmNxeXlMNytvYzJY?=
 =?utf-8?B?RUtudjQ5NmNSZUoyc0twdVRCZ1U0WGUvUmw4QU9UazJ0L0tIN0dJUnJ6UE5M?=
 =?utf-8?B?UzQybUN6N3lWSFhac3RhMzNRUFc5bzJJK3BMRzZSVVNYMXZZa2hsY0tnck52?=
 =?utf-8?B?dktsTmRzdnBTK1gzVlpJYXgwN0NzV3J6dlZLdmRqdGNvZnZhTC9va0o4eDhs?=
 =?utf-8?B?S3Z4SnBIZGs1QjBZcS84dnlmM1RTZGNvdTRORElQUS9XYlBGQVZyVS9vQzFn?=
 =?utf-8?B?OXpTdld0a2VwblJjWm01Q1g1amIyczRCLzN2Z1lsVGR6bnFoSmUzaHdhYzBw?=
 =?utf-8?B?dHY1Tmk2YzJXcWIxOEdjdHVZNmJLbmZaNkIzcjB2Sks1cUQ0QXNiNUpqck5a?=
 =?utf-8?B?cmpaWW5MMEg3QTZ6WWo5VWI1aHNtZUpxMjVuRlBOYnI5Nm0rNkRCK0NmM2Jt?=
 =?utf-8?B?WCswZGg0WmNhcVE4WUxwT2tmelRUMjRZb1hzcEduMFdPbmxRejlua2NEN3A0?=
 =?utf-8?B?dGE3MVlCS2s1YUkxa3dBNFkxZmFIbEhaUEw4WjJzcWVUdWxZaGtCZXA2R05M?=
 =?utf-8?B?TjJENTdMUUExYzR3VWtVRXZFbVhYcklQWUpFTFZseXM0Rm9JSVArUkZQRTA2?=
 =?utf-8?B?TzNIM1gzK3RrYVViYW9CVVA5VlRiTE1lTmVXVTZKMElDeGxaaTM1OFhrUHpw?=
 =?utf-8?B?bEZDMmJsTEJHSFJwUDY1N3ZGeHpvL0tjcitmWWY3eS9xYzQwcCswcGZ0RjBj?=
 =?utf-8?B?K0NDbzdWR0I0WXFUVysxVGxDckU2ZzBrMmsyUjRmWTRLUTh0ZHFzcXJQT0Ir?=
 =?utf-8?B?ZG9MYjhMLy92R2RFdjFqQTBHMUNJWTBvbGY1YWkyTjVJUGpZS3RTTVBndjhF?=
 =?utf-8?B?clQ1SitqdFlrN3FocE5ScVQ3UC84enNhOEV5bjJBeTM0d0JndjBQeENUNFF3?=
 =?utf-8?B?SFkvMmxKZjE1OWN2YnlKMmNQRE8waEdYM3B3TU5sNGd3d21KbjFqWTdtcGt0?=
 =?utf-8?B?N1RBczQrc2VzcStaeXJaUzZRRGdOTlN4U3R2NVFOVDZNWE1LOWgycGNWYzg0?=
 =?utf-8?B?cHhLN1cvb21CMWltaFA4c3VnTHE1bXk3eE00N252emNOWTlWcDAzL2c4OHBJ?=
 =?utf-8?B?T3B5d2VSTVZPRlV6QnRhbVJUSXRzWkRLVFl2dHRvV2dmMFRqS2xvOVNSVzAz?=
 =?utf-8?B?VEFBSUVyTjlrMG82bTFmMUJ4c0lkTnUyT0NyUGV3aXo1SmNIOG5UWmdNaWcy?=
 =?utf-8?B?UWZkaktPVXNlTXBXcElFK1o0NzQ5RW1zdEZQSGVhbFp0ZGJGUmJSZlFkaCtm?=
 =?utf-8?B?aE9DZEpUSnF5QWY2dmxaZmRqUGlQRzNyd1lMaHRGUW1HUTBhVEsrMzNUK2NL?=
 =?utf-8?B?aGNDZVUreWhuM2NNcmZrTXRaVDNDcDZNMGFNUjF5aktURmlNdUpPNTBvTS94?=
 =?utf-8?B?TTc4RTVkVFZHMHRKM3VWMGlCR2NZaHUrZ3VJdFo5Q3dOU254ZHFqUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62805b26-e289-4dd6-3880-08defdd2b9e6
X-MS-Exchange-CrossTenant-AuthSource: BL4PR12MB9482.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2026 09:17:43.8487
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6YqdtamrUjevxaxT5Zgs/y7pY51aSnm+FiogfEoXXaHrjDY33nnVWergLSNTzMTN1Hx/ERXXDcwaVNfN7EHQsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5905

On 19-Aug-26 12:49, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] The parsed channel separation size (`ch_space_sz`) is extracted from the PCIe VSEC but never read or passed to the DMA core, resulting in dead code and an incomplete feature.
> --
> 
> --- Patch [1]: [PATCH v4 1/2] dmaengine: dw-edma: Enable Chan Separation via VSEC ---
> commit b605eb99c5a71a0d4b5d7b6b4068f555cc7fee6e
> Author: Devendra K Verma <devverma@amd.com>
> Subject: dmaengine: dw-edma: Enable Chan Separation via VSEC
> 
> This commit extracts the HDMA IP channel separation size from the PCIe VSEC
> capabilities. It then stores this parsed size in the driver data structure.
> 
>> diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
>> index 791c46e8ae4c4..f287879b2cb9e 100644
>> --- a/drivers/dma/dw-edma/dw-edma-pcie.c
>> +++ b/drivers/dma/dw-edma/dw-edma-pcie.c
> [ ... ]
>> @@ -279,6 +289,10 @@ static void dw_edma_pcie_get_xilinx_dma_data(struct pci_dev *pdev,
>>   	pdata->mf = map;
>>   	pdata->rg.bar = FIELD_GET(DW_PCIE_XILINX_MDB_VSEC_DMA_BAR, val);
>>   
>> +	if (pdev->device == PCI_DEVICE_ID_XILINX_B00F)
>> +		pdata->ch_space_sz = dw_edma_get_ch_space_sz
>> +					(FIELD_GET(DW_PCIE_XILINX_CPM6_VSEC_CH_SEP, val));
> 
> [Severity: Medium]
> Is the extracted ch_space_sz value actually used anywhere after it is stored?
> 
> The commit message states this enables configurable channel separation, but it
> appears that pdata->ch_space_sz is only saved in the driver-private structure
> in dw_edma_pcie_get_xilinx_dma_data() and never passed to the DMA core.
> 
> The patch changelog notes that the first patch of the original series was
> dropped after review. Does this omission leave the core IP driver using its
> hardcoded 256-byte layout, making this extracted value functionally inert dead
> code?
> 

This patch series only implements the extraction of the channel
separation size code via VSEC and function to convert the code to
actual size. This change may not cause any impact on the functionality
of the existing code. The patch 2/2 of this patch series utilizes this
implementation.

-Devendra
