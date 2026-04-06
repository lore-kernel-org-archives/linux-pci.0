Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011068.outbound.protection.outlook.com [52.101.57.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96FBA30CDB6
	for <linux-pci@vger.kernel.org>; Mon,  6 Apr 2026 22:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775513396; cv=fail; b=cAq0MhHRMIYhsiuXcefZgm/jH1uGfboDa/Zt7XRuy4pwsi9NHp+zSWtvg32Jmeq/K9nfhhidTP0x765ou5KOD+4h088Wx4FXHKOsl6TlJu/V/o+ZR9P7x9ZsDAuHmpAfMo1X46ihXx6H0rkEu2j70d5tscnBZWBDaVlk98g+DNQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775513396; c=relaxed/simple;
	bh=s5+UlWCLI4h88B6vPUm6B9/5EDx48WrmgtwVvRTxwTQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cqystMHWRuhv1pTsjfLatiltDA57VPEbTYVjjC5OL7WZ3XBXwup0lCW8KPgl2+6TN8UCND2hctNpOVVJ+OJtqbI/AncOus5PwNIngpO7/n49b7QMottOcH9clE5JrV2rsxq4nsVlQgI2kTdNrhq9R9/c6TXPrUTeMmsKcdvWm5I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=cHT4xFgU; arc=fail smtp.client-ip=52.101.57.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="cHT4xFgU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bJDwPblIH2w6ZJpACRN0ayrxK8IkgEufjcCEPyf8Qr0F8cvXMyJgrytZsfU8+A4m0TiLvBv93RUparMGeMuRZT69yZE9xwdizeOdygb9CPf5bu2ijt3dtm7wPjfajGbKdfqemvw45vybqDn1ZoGBbzCm0H2FcsQNAFMIdYPXLnhI0vAvu/9Qfzt/uqRJjb/GOkj2GSRaWaE602fxrSzMIEyyZUYj0mmnMQRgeABgB1GTrWRrmdaT5NBgVy7Sh4wvuvd83e1R5oZs3Jji9kkoaVO2kpgbxRLZmEmWG5CKEgw+vwRrDP4/uM7PToJ02QROXOfwYCr/CZ3YhtQjt68XXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZpcfCfRvTTI5KPl5YE/KdZBhpL6I1bvPeelxgN5Lbd8=;
 b=K2JvqGzAi0Tb7qxEgGWFAmYptK+WOBKBpCifwgAVEoN6PUT1LIGRoo0NaYW1tsJBsT/5Z/QZ47C2mUXvimoIhKmTLNb/UWYecXiTEPB2H4oT9bsjYw9/LmV8QHxvphWyjEw/ujqz3RdE0yxCYd1LC2xY7vSvv/TmWLEgdFbiPVtzHQdrnpkNUBjibVGwJPNqnSZ8+fVMZpc8aWwISHWXW6RPjnGtSfZF5PrRVdeYy1Cy7H4EiQa7Vgxv1bEp89lIx/ROXEIAXTEyJyf0SK8lPt9YOFzEx5aN7LZae2maUppy+shU3IlfXW287AkLu/XWBBSGJXGpADQ4q/CtPkUJxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZpcfCfRvTTI5KPl5YE/KdZBhpL6I1bvPeelxgN5Lbd8=;
 b=cHT4xFgUttiGrORME/hP0m9YOgkxxBCc0urWIme7EZUjwXCJbpSMAnGvoJPjgFQQ97nQil4ScJuB0mkTlDtcOWg4OAESqeiLBZ/B8KK70ns6G+umDaOPXZd27xmH2CZv725PwJgQ8IcmHB61tPxIUHat1jCtViHqyykbqlsXe2A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 by MW4PR12MB7439.namprd12.prod.outlook.com (2603:10b6:303:22b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.19; Mon, 6 Apr
 2026 22:09:51 +0000
Received: from CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::1e6b:ca8b:7715:6fee]) by CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::1e6b:ca8b:7715:6fee%6]) with mapi id 15.20.9769.016; Mon, 6 Apr 2026
 22:09:51 +0000
Message-ID: <70912675-0737-4ebf-8ba0-ab9a2e493bbe@amd.com>
Date: Tue, 7 Apr 2026 08:08:51 +1000
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v2 09/19] PCI/TSM: Support creating encrypted MMIO
 descriptors via TDISP Report
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Xu Yilun <yilun.xu@linux.intel.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
 Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev,
 linux-pci@vger.kernel.org, gregkh@linuxfoundation.org, bhelgaas@google.com,
 alistair23@gmail.com, lukas@wunner.de, Arnd Bergmann <arnd@arndb.de>
References: <20260303000207.1836586-10-dan.j.williams@intel.com>
 <yq5a4imuanoa.fsf@kernel.org> <abPlt8oNUOqGvbA3@yilunxu-OptiPlex-7050>
 <228298b7-76bc-4ffb-bec0-0c35fd487c4c@amd.com>
 <20260323182014.GR7340@nvidia.com>
 <fa1c6e1e-068c-46d7-a623-58c225bb03f4@amd.com>
 <20260327114921.GL67624@nvidia.com>
 <d5059386-1ed1-4110-8283-16e3a8407760@amd.com>
 <20260330114902.GA310919@nvidia.com>
 <46de1d41-a660-460c-a49f-ae2d2ad7afe1@amd.com>
 <20260403140858.GJ310919@nvidia.com>
From: Alexey Kardashevskiy <aik@amd.com>
Content-Language: en-US
In-Reply-To: <20260403140858.GJ310919@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0090.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9a::9) To CH3PR12MB9194.namprd12.prod.outlook.com
 (2603:10b6:610:19f::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9194:EE_|MW4PR12MB7439:EE_
X-MS-Office365-Filtering-Correlation-Id: 59b530aa-2e13-4136-6934-08de94293937
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	N3ZmtBtACHULzcIsliS+NnLmg7A4uB9JHlEniYsGVmCdj29qHbMopsvHw/rZCpJMd21WhJXQ505mHJ6vD4RgYRXVl5r/o2EyrhhJHbW45etQF23KWtxw/qcK/vTwl43uJzJ7tyqsGvfDs9T0jRkY0LblEbHcPrEnEEHgsNmGHDzTSBKPlU811zA1hSBdWG61YjDC20ydHCbzPBs0I45mY4K+nSTL91PvIefHwybwyN4+00A8znZDrx9UX2mUUUynvRaQlYfXiJYhWVj0n6h7x4kUne/JOt6UXeVYNYJXy4QDgLmcTJnEnaRXVn0ehVoXxipz2Fwb3ytm6f1rtLs6o5XhL4Aq4AJMeWqDDKCtLetmwB7342G6xQ+8tnYtDzd3ALRGHOJcFCLglxAcNg7M7/szEiemNcHoUkvDQ37Yw5hD0aL7q1My/ugaFweO7Jo8c7IVSmenyscqne/IVRjliEw2FF4A6H5uUf4feGbVhd9eEFkm7fsYPDCjjIGjZgO4fiInv1DV6rkVOD5hAuke1cHvXAXhT+TvCoxdtAzFEK9HBkzYeiY/zVfSPgoosU8frJ5WsWINvmpSwtTg97h0/GI79A6FRNlYZ3TZiOYOZ19jRNZf/w511zo9IyvJnQHVjlnJr4tYiTd4TcRuKQP+0iF40Hq1qlEQCTEK7gkq9AoL9Q4oST6L7gP0CoM7X7WhBjAY7vXpUMCqQ/6rqSxBHAseI8NbYoYe7JMcu0rg9Eo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9194.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bEY5SEFRZFcreHV3cFM2RmpVR2tHYW95NEhiYy9LZE92QlhMNGpabEwzbldy?=
 =?utf-8?B?VEVPTWhYdmRadXB1WlJoelYxaFBZRjFtSjVnNmVmZ1hIaGRGUDhFdkJWeEZM?=
 =?utf-8?B?WHNuY0ZtTCtIankvcHRCczVGSzBQOXV5ZDZYQkpteTM0SDNoNEJ6T0kwRXd1?=
 =?utf-8?B?TU91am1ObEl2QW5McFRRdHM3Qm9DV28xbk83MWVPMDRwalFaUllPZFFaWTd1?=
 =?utf-8?B?Vyt0QVo3MXdlSmd2ak9tYVgrWVRUK3MvdWRMQlRJSTV2QzA3Rk1IMGU4ZFg0?=
 =?utf-8?B?V3dIRTlWWVZDenYvZEc5bk83akV5bnpXQis5T25uZk1PaW8vNk1NWXM2MnJL?=
 =?utf-8?B?dTN1WHcvQUIzUHQzaE1KZUs3Mnk2cWM0cm1aNFFyNzU4cEFmYUd0ZXlRNDR4?=
 =?utf-8?B?c1N3VEpmWDJxb2orOHJtdFJmeEZ3YzBtV1ZtSStTUk9ESUdmVVkwSEN2Wk1i?=
 =?utf-8?B?eGVlMGc1OVNmdHpKbFAzN0JmaVlQdFNFU214bDc3a2FlL1ZUQzMxcjZhUTVO?=
 =?utf-8?B?MFE4ZzNBUno3Z00yNWpiVUtkQWNwSEw5U1BjTUs4d3BSWE1XRHViWHQrQkw0?=
 =?utf-8?B?OGhsckZEUWdsS0NBL0hoUGllckF3Mlh5bGlBNFlzU2UzMHczbHRsWGI4Wng4?=
 =?utf-8?B?bUFudU1iUVE4aTdKRlFBNEF3OGNMenpCRFR2WjlHV0NYNFVZOEhVR2tZQlkx?=
 =?utf-8?B?dFlYL3loKzA5dmxUS1dWd3JPNEhFdVBJdWo4cnhSRW83aFBldEF3WkFsNDIx?=
 =?utf-8?B?cThVdDhZZXhDekFMRkVXMlhZQ3gwYlhXdmFTUmZJcmdkR2gyeDU4VUdFMkdq?=
 =?utf-8?B?WlNGbklPRUtwN2FCZ0dMOEx0UUE2K0xYYzFOSmNTeUhvRHNaRmR0VVh3aERG?=
 =?utf-8?B?Z0JLWXB1UDViaGNVaFltQXhDL0lYTnF5MGpWaHRkbjNQUUVpZElmdG5VSEk2?=
 =?utf-8?B?TjVsLzhDYVh6NlRHdzFyQmFucC9SUGhQcFhxb1Jxdi9aYkdKSmlhTW50UnhS?=
 =?utf-8?B?aU5kMlc2WGtUendUcTA4U20yM3JpM0tIQ2ZyVHZ3ZmhDbFFtbnU0cDhoeWYw?=
 =?utf-8?B?RnA4SUphS0ZZQXNGTEVrdWFORWtrTTJBTVYyQlNCUnB6RVJ4Q0ZFOXhWUFZT?=
 =?utf-8?B?VkxXd1NPbnVvbHFsb2lWTW5ldkJoaFpHbkdjVmJnb1BEVGlhWCtENWlOVGpa?=
 =?utf-8?B?WEcwZStEanNDbXFubFZhTFREcjgvbVFxdUFUaGdqMXdPM090WFp4a2sxOHJo?=
 =?utf-8?B?YVl5NVNFdzI5T0E1dWVxTEduNFZRYVFoUWhjcGlUYTBjSEY3RXJ0N0J5T1Qz?=
 =?utf-8?B?SzV2M3dkYzYyZVJ6azVsN3JDdWlrckNhbFVWTFYxUzZvVm9jZFJia2V1bkMy?=
 =?utf-8?B?bldsdkcrUXRpbDZtWEFrdFVtOVMrdmlTTVVEZEtUL0FTMUIxZXFidzdaTzMy?=
 =?utf-8?B?bTY3TS9EU1hEb0ZlUlVhVXpSejc0YkZMODdKd2tKdUhXZUVYb3AzSWhRODlT?=
 =?utf-8?B?QXNiVXprbEV1R29Lbk1xK21taDlFZXRUbm9ScWVVdnpWUEZvWm1xU1EvRWti?=
 =?utf-8?B?S3BEMUgyR1RuRDFrNWFvWmlKRmVVbnBXd09oNGcrUG9KU0hUQmlaZnowanRv?=
 =?utf-8?B?aWp4R21ZMWhReGFNdmVuNzdmZExqalgzS09SUmw3WXhuWHZuTG93bGpXVjlp?=
 =?utf-8?B?b3V6dE92OERkSzZsQmVQRGhZQjJGTDZxeXBJTnltSTJZTHJIWXZEMHN5MFVU?=
 =?utf-8?B?eTF2QVFlN01oVW51SEpNL3dqWTU0dGdySTZwcjRnbitNQWdsRVZ2clFFL21W?=
 =?utf-8?B?NEhlSHM4ci9nQzc5K2djVXJHRy82WHVadElNcVcrNmNwU2dqS3owQkVEM1Fi?=
 =?utf-8?B?Nkdha0dwUlZwUlVWQndlRFdJQnMzbUlnT3dzWkhVdHNMaDA3dWZaS2F4VUlW?=
 =?utf-8?B?RkZHWklCaE54N2JlbGI1TFNVTjNwWCtwWWl5OWxZa1BWZC8wRUdCRTJqTlBy?=
 =?utf-8?B?eWplZ0oxSGNScHN4R0lqdHBDQjZ2cmlNb29vVkc2WkNTalN5MjFYdHRIcGd0?=
 =?utf-8?B?aHpBeDBNdFp6TGlHUzNQWkl0QzQwdC9pYjU3cWdYRzhJVGJNSWlnZHZibzlG?=
 =?utf-8?B?elVERUlwTndCNmljNURpaHFVUDBtcFI3WVFTa3MvWmYvRWxjRmZBZXA5cVpu?=
 =?utf-8?B?WmoyNHhxRnU3ZXlwbDV4ekEzenJzUmM1Ukc4RlFPMVFoVUsxYW5JRmdKamlL?=
 =?utf-8?B?SVVUNmpwR0VQb1o2eC9xbVZOcUM0OWFPRnlkdzRsNzlDcTF1ZklLQVkwREUy?=
 =?utf-8?Q?FiS1s065GMKq6sBZQT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59b530aa-2e13-4136-6934-08de94293937
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2026 22:09:50.9832
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FxFKBITCLqNuzzRHefmoZCOqqsof+0PCPK8N+ann0L4j5XiDw8W72P8JHK5qnHKHzFlMwLLKP7F70neKVdVObA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7439



On 4/4/26 01:08, Jason Gunthorpe wrote:
> On Fri, Apr 03, 2026 at 11:41:25PM +1100, Alexey Kardashevskiy wrote:
>>
>>
>> On 30/3/26 22:49, Jason Gunthorpe wrote:
>>> On Mon, Mar 30, 2026 at 04:47:44PM +1100, Alexey Kardashevskiy wrote:
>>>
>>>> What do I miss? Thanks,
>>>
>>> You can't tell where things start so there is no way to relate the
>>> offsets to something the kernel can understand.
>>
>> Reported ranges have BAR indexes and start addresses (with the
>> reported MMIO offset added), and the first reported range starts at
>> the first 4K of that BAR.
> 
> I was told this is not the case, the first reported range can start
> anywhere in the BAR?

This is what I am trying to clarify - if all ranges must be reported (as some think this is what the PCIe spec says), then no, not anywhere.

pcie r7, Table 11-16 TDI Report Structure, MMIO_RANGE:

"Each MMIO Range of the TDI is reported with the MMIO reporting offset added."



-- 
Alexey

