Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012011.outbound.protection.outlook.com [52.101.53.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB4E285CBC;
	Mon, 27 Jul 2026 12:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785155021; cv=fail; b=JNINGeVG8SSL+Yj1JZgFZOEwF+1JybylJtH5p9dtNrHtOoPYqjcvJLBfg9XgFujpHmdj3SYwRmKRJEAJH5vpNwoslAZ70gg7mmV+xn+Yi/PbrZy3HmQbL7R8djm79SeAMYFwLQ9sYCZ7PiljLIF3772/xKD0Mm7VpXhTN+22Z8Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785155021; c=relaxed/simple;
	bh=1mc2N0H9Qc34ZQJSLsYzd2YZTmxQR2trZC2jjFUVQ0g=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Sl8KpHU5WoyeBculYakgyh5utBr2dYCID5FBqX4cEJjGmd4SneRYIopm0/tMPXBB9FrIW4j0C3mTG4ip3OR0oSvvRgkA24bdmSpJYp5IYHG9bAlP+b4UZCv83JLPZ5l8Zowj5TkJOBl+FMiTZpEtqjkvhCoxd8wyPkuEQitfvmw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=F5xB3Dnz; arc=fail smtp.client-ip=52.101.53.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="F5xB3Dnz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tNIU9Ru+8YT01xD2R0i5Myn163QmRjzc6K6acppcUiVJ/FckMn3qrU2r/D4eiGjB7Gown1vIEBwAfgKoLwJoQb1eiyk/6CYD6cilue9v8xCk9toQVq/mry6d1Bc6bAbVpvd8K/Qv1HMmoNsAsZQkJsq1EscBSitAqV2AjGtjLlqPiODVt+icxhXfAaZjMKh1FL1wn24s265aQby8M++nf8ThziZJ1QF2ZqukGn09aNg+8PiBFoYOd6BmqIVRfhexsbbdB030sCTD9Iai90Xlhmokv+54exJgS2CAJE7S4sDFSzchy7goNLYUpdhxaJrPvan2lvf9b2YKDah2zoqMCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8fpw9F9BYbUc3nDf2pZzpcTCLUB05w0UjuA8eFrOUFQ=;
 b=ZISlvBC5sI/fSh6FpH+xtzfyqTC/iG9YeIbd61u2DTGM95Rtjfqf/e9m/hQSC4fvx8mvin+NakhMXPt92WnscIdCK8Irc8Za945mE6c24TIzl/bQaFH0qB7D2BwQIGeWUyaxWgAOOlXAILd+cs9+exTbAVmp1eO+7ytR75FFYFEsc9ZFMxdHtcC31J0x+Sv5LT7hm+gsLi8LjjWINMmmyf76QliAt7o69xeP9lZpN7yCmCgsvrhE6kjG7y1kEbArFkh0c18DTPIgiLBzAbj+bV84c+g96eDS+i2jg8ua2++qTJKNjt4E85nTNU7iMwp8A99P1ytA6kwP+8KVQHv7RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8fpw9F9BYbUc3nDf2pZzpcTCLUB05w0UjuA8eFrOUFQ=;
 b=F5xB3DnzrExZTJSKymNETpUQaOCO4G4+qEUYDz2cJ+m+q5/vjyfxueLGbCQtYjjDEcuz78o0NqMxDHoNXWaDj8+SsPLlUVMRU0X3fV9K8Pq2sisvfWo0alk0cR9U8QuDMCwgyYcDpbfc0lqgxctsBZMjxTcF50UyXjBcZCpwPys=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL4PR12MB9482.namprd12.prod.outlook.com (2603:10b6:208:58d::19)
 by MW4PR12MB7384.namprd12.prod.outlook.com (2603:10b6:303:22b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 12:23:36 +0000
Received: from BL4PR12MB9482.namprd12.prod.outlook.com
 ([fe80::e4cf:3801:9631:2965]) by BL4PR12MB9482.namprd12.prod.outlook.com
 ([fe80::e4cf:3801:9631:2965%5]) with mapi id 15.21.0245.012; Mon, 27 Jul 2026
 12:23:36 +0000
Message-ID: <21d1c6d1-c84e-4351-aa30-dc49ca3b5ef1@amd.com>
Date: Mon, 27 Jul 2026 17:53:29 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/3] dmaengine: dw-edma: Make Xilinx Macros Dev Name
 Agnostic
To: Frank Li <Frank.li@oss.nxp.com>
Cc: mani@kernel.org, vkoul@kernel.org, frank.li@kernel.org,
 dmaengine@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, michal.simek@amd.com,
 Koichiro Den <den@valinux.co.jp>, devverma@amd.com
References: <20260722111640.1146212-1-devverma@amd.com>
 <20260722111640.1146212-2-devverma@amd.com> <amDY7rTS06xEfFxu@SMW015318>
 <58a5b255-778e-4b57-870a-ef5ec1bcb72e@amd.com> <amI09ZcfhX4SEPIH@SMW015318>
Content-Language: en-US
From: "Verma, Devendra" <devverma@amd.com>
In-Reply-To: <amI09ZcfhX4SEPIH@SMW015318>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0091.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ae::14) To BL4PR12MB9482.namprd12.prod.outlook.com
 (2603:10b6:208:58d::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR12MB9482:EE_|MW4PR12MB7384:EE_
X-MS-Office365-Filtering-Correlation-Id: ce66cef8-f875-4d06-8d14-08deebd9e1af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|56012099006|10067099003|18002099003|22082099003|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info:
	Spy/axzaxW0+HA+cLIfm0vDv7b4yeV4rPS8y0qVRZ9t61hgNtgAchyvgtrneLylOckI3l330s/xowjLRpFUZKX3v5T8ucHvkziNRXxkEVauadYAWqpEH3JiBFKINthXIW8CFX0aAR8bDCQnAm5Kvh4TefxDYIu7tEBO23RZ/4w/0QGk59XiyxcaKSN7y3Tdr9pr68RBvqoJX4+zukdtjODWMKCFKa5JDqiQWkO8d3DJmKIEeAyaPE6GDPeZqZPi+OThBqFt/QzOffcANXD9VY7qT81oWSUILiM0y64gRdq89N7mK6oOGrS2X/FKY6GK6yLMEN6/MxVR8L4RIv3VVfx0SNbw6oytzfz11lrO3TMaxZKrdrL549RhjJWMV3QH/X/kwGfU5PuYWTKnN5Fy0CIN9lJNBwCCr0SmixFeRp/Tmy3tZa8fovr2jRyeuK9zH0CfdJwBsgQ5BSh8sElMhktwFHu9dwo1DhkbVQ2KiAOB6lKS4Iizxps4g8LT81mhRq7/dbV5UXlfrK33VhBHgrJIIAYJ4VEhUU/oe0vaVJcdWi7J6V92+zeY36koGMSEC59EgSbzxZ72gMq4X/XPYX7tnTqsi6Il6OpJEsnPohwSdWA2frAqqnsbFnJzCZqHgYDog+6z6hnxvB/kzp/q+tED6P3YyPxdy4yhyJtOMij4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR12MB9482.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(56012099006)(10067099003)(18002099003)(22082099003)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cXd2a3hQTHlCc21KQVpsbGloZEx1VjB3MURyWFY4YldockJMNjBRUFNZRklv?=
 =?utf-8?B?OEdNRUh6am5SeG1QRXg1eE01Yy9VemxqUlVCNFlkK3VFTEx3RWlqajFTVlJW?=
 =?utf-8?B?dVprL3JUK1p5OW9DMmhhUFd0L1lXWEpkZlZxSUE0TmFzcW5iMUVQMURxczR6?=
 =?utf-8?B?TmhybDdYWUZMbVRSUCttbWNHYTBXOWJPMHl3bW5VL1JLRkdwYXRlYmtrY3BB?=
 =?utf-8?B?YzlOZnh2Rks1VHZnMVpkVi90c3lQdjFqOVlPWk9xb090dGJlQlZjMzhMRTRq?=
 =?utf-8?B?alBPOGdYSTNSWUxqU2JXdGpUMk1mZHR2Z1Y5SHQ2MWtuaWY1UTBtNDZicFJE?=
 =?utf-8?B?V0JEZ2JxbHFYdEtGQjUzUUhlSDNFcmtxYThsTm90dEdDL1I5bExtY2Vmb3d3?=
 =?utf-8?B?ZDJXR2Y0NjdLODhXZy82MEl3WjJpQlBXRGxQTWVFTXRQTlNQVUJHV1lrVmNx?=
 =?utf-8?B?T2U3UVdGeUxNTTlHU3M5QTk2bkY2S2ZEOXNQNDVWRGZhZ2dZY3g4RGcyUmF5?=
 =?utf-8?B?UWNWcGk1NGxjdTV0VGp6dWtkQk5BTkZCS1R6M1k1RHZob0Z0UjRtVFJPeHlL?=
 =?utf-8?B?QlliczI4VjdqWmFDR1BiLzUzN1E1bzRiREs4bnkrbEpVYmJSWWJUY00rNlZC?=
 =?utf-8?B?bklVbXVYNmw5UUY1YW9rN0ljQ0FUVm5wVXZneW1QbWs4U0luRG9zbmhXVUpq?=
 =?utf-8?B?Tm1WLzFmalJZcFZpdlE1SVdlV0E5QXU3eTladzkya3dNd25DV1NDTlFZUWQ5?=
 =?utf-8?B?VTl6V21rb2FoM0Vhcm1nSldybGtVVGVjWXNnYndzU3d0WmFWMFlTck9YYkUz?=
 =?utf-8?B?Q09jeFptY244YjQ3TExXUmw0djhYbkhQMzNETTFRMHorWlBkVDdESTBleGla?=
 =?utf-8?B?NXRERm0rN3Zhb0owSjM4V0V6cHMrbUozWitiemVIaFJqZXlodm5KYnJycUdV?=
 =?utf-8?B?cnlmazlhSlFrVW5LWnpjMnllb3ZkRExDTW4xYUFCYWNmSmlLeVpNVkxJNmZQ?=
 =?utf-8?B?UDVWQ2tQY0ZDVTFyRW96bWUvazh2ZHJ2Wmhlclo5YWlKS0ZvazNNekM2dEFL?=
 =?utf-8?B?eXhCT2d3amUzSnYxOC9Sd0pienlMVEcvZ0RkMFVZU3dCdXpzcHE2Y0xTTEt2?=
 =?utf-8?B?MG1uKzBSdXora1ErcG1qeFJiazVMM2xldGdPYkl0bkdJU013Z2NVa2RISjdE?=
 =?utf-8?B?ZkQ2T3NBdkRMY0l3LzZVcHJscGZlYnF4YXB6Q3pHTlMwWjVDRG1hdjhPdWND?=
 =?utf-8?B?bFB1Zk9jMEt3Y0U4MFlrWVpMdEtvb0VuL1NjdzBGUmh4dFgxZUd3MHFoLzQr?=
 =?utf-8?B?NTlHcEVwdkFUbVlteENjYmtLRzVMVFZkaEpjbkpQU0VNOXlQcUhVUTBtZEc0?=
 =?utf-8?B?Y3VQN1hZeWVEUGtPOXRnMHZjVysrTG9EdHBMWVo2SUF4ZFZzOWE1V2kzOU9Q?=
 =?utf-8?B?eWh4b3A3OFptWXhtMGRPa2RYeDJXMmhYOHlZYUFLZVNGSEhxcXhsRytPOUUz?=
 =?utf-8?B?UTBQNkQzWlFuWjNLLzNCalF4Ny9sV1c5MUpBUHZCeEVmYzYvMmJvZFh0WWRQ?=
 =?utf-8?B?cWQ4a1RmRlQ0YStuVDAxWktRVnJ0bk1SNWVMdnc1SUR5NHJMRDRTamlacTZk?=
 =?utf-8?B?MDJwd3Nqd1BWT1EybVNuOXZxRnhMRldyaDI1ZVIybFhsNkc3RmlwSjF4MEtI?=
 =?utf-8?B?am1YWUJqMTJhaFBKY3RBOVRTOEY1akRWRjRwL2o5Qll5b3hMMWNrYWpOUVZm?=
 =?utf-8?B?T2M4WEhSWS9FcC9YemljMElwQ3FLbXZHVWVjV25rMGg1bEExSjQ0ZlFJa1p5?=
 =?utf-8?B?Rmw3MGJBeWRhRlJxZkdSbXdsdm5kS1EzcmNmbjlXOXFYaWFtcU1wMTlBN2Fq?=
 =?utf-8?B?ejkxczRNcnhCemVkaGQvd0ZhVHUvcEROdTFOYURTeGkxYktLbE4xbDdtT253?=
 =?utf-8?B?Tkc5UlRYSFhQcHMrRmN2aTFpNjZDaDM3MkhvVVFmbVNySDg3SzN6TS85Mkpw?=
 =?utf-8?B?T0pNV2VzMytIczJjcGUzblNYdGlSQmswemJ6YTdLUU5IN1ZDaE1lNi9HbWZw?=
 =?utf-8?B?REJWVWNvNjJDUnFMTHUveXFPeWU2aGpnV3U2SnZyclFiN2NSWDJISkRMd0V5?=
 =?utf-8?B?ZDUvaTE3VVRlR3ZrTDU1WnhjOUo1bytvb1NzWkFDWXRhaHVqRzBiSHp2QVNR?=
 =?utf-8?B?ckRyMXZHeWQ2TnNMSjdNQThocWt2QVNIMW5PK21FSzV2b2UrWnQ0ejFoNndr?=
 =?utf-8?B?Snc0Y054b2lOUDM5TTVrSVBTUUFPSDl4ZnpwU0JsamFkT0dCWFNoTXY3aWZy?=
 =?utf-8?B?Vm5WMTgrRng1RjhtMm5pQk5EM1ZjNzk2anBtWnh6U2VxT1lIMkxZQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce66cef8-f875-4d06-8d14-08deebd9e1af
X-MS-Exchange-CrossTenant-AuthSource: BL4PR12MB9482.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2026 12:23:36.3274
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XR/fDU9ACPF7hF0zZy5Z5MOgylgevs5gcq4Rj9tGPp5EFOPz3cP+JhDr0HYgLkJj0rkTW2WZeNdnYGvflkMpdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7384



On 23-Jul-26 21:06, Frank Li wrote:
> On Thu, Jul 23, 2026 at 03:53:13PM +0530, Verma, Devendra wrote:
>>
>>
>> On 22-Jul-26 20:21, Frank Li wrote:
>>> On Wed, Jul 22, 2026 at 04:46:38PM +0530, Devendra K Verma wrote:
>>>> Xilinx specific macros for MDB device can be reused for the
>>>> Xilinx supported other similar IP such as CPM6.
>>>> Renamed the Xilinx specific macros in a way that can be
>>>> reused for Xilinx supported upcoming IP, CPM6.
>>>> Naming is in accordance with the naming done for Synopsys macros.
>>>>
>>>> Signed-off-by: Devendra K Verma <devverma@amd.com>
>>>> ---
>>>
>>> I don't think it is necessary to remove MDB. You may mention somewhere
>>> CMP6 compatible with MDB. It is quite common in driver.
>>>
>>> The major concerns is that if a incompatible devices appear, such as CMP7,
>>> which have special registers, need add _MDB_ back.
>>>
>>> Frank
>>>
>>
>> The MDB was used cause at that time only Xilinx MDB was the IP to go
>> public.
>> I agree with your suggestion but the idea used here is that, for the
>> common functionalities use the names which are affiliated to vendor
>> that is Xilinx and can be used across the IP having the similarity.
>> In case specific functionality is required for MDB or CPM6 then
>> it can be associated using vendor + device name, that way it is easy
>> to identify which ones are common and specific to the IP.
>>
>> Currently, if any functionality added for MDB ONLY then it would be
>> assumed to be supported on Xilinx CPM6 as well.
> 
> Rename when this case really appear.

OK, I take this suggestion. The channel separation is supported for
CPM6 so the specific macro will be associated with Vendor + Device
name. The rest of the macros could remain generic.
The macro name was kept generic cause the ch_sep_sz for the other
Xilinx devices will always be 0 (256B).

-Devendra

> 
> Frank
> 
>> To remove the confusion
>> extra comment would be required to inform which functionality is
>> supported for which IP. That is why the removal of MDB appoach was taken
>> to reduce the confusion and work. The first approach looked clean.
>>
>> Please let me know your thougths.
>>
>> -Devendra
>>
>>>>    drivers/dma/dw-edma/dw-edma-pcie.c | 58 +++++++++++++++---------------
>>>>    1 file changed, 29 insertions(+), 29 deletions(-)
>>>>
>>>> diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
>>>> index 791c46e8ae4c..ec5e057a0f11 100644
>>>> --- a/drivers/dma/dw-edma/dw-edma-pcie.c
>>>> +++ b/drivers/dma/dw-edma/dw-edma-pcie.c
>>>> @@ -29,21 +29,21 @@
>>>>    #define PCI_DEVICE_ID_XILINX_B054		0xb054
>>>>    #define PCI_DEVICE_ID_XILINX_B00F		0xb00f
>>>>
>>>> -#define DW_PCIE_XILINX_MDB_VSEC_DMA_ID		0x6
>>>> -#define DW_PCIE_XILINX_MDB_VSEC_ID		0x20
>>>> -#define DW_PCIE_XILINX_MDB_VSEC_DMA_BAR		GENMASK(10, 8)
>>>> -#define DW_PCIE_XILINX_MDB_VSEC_DMA_MAP		GENMASK(2, 0)
>>>> -#define DW_PCIE_XILINX_MDB_VSEC_DMA_WR_CH	GENMASK(9, 0)
>>>> -#define DW_PCIE_XILINX_MDB_VSEC_DMA_RD_CH	GENMASK(25, 16)
>>>> -
>>>> -#define DW_PCIE_XILINX_MDB_DEVMEM_OFF_REG_HIGH	0xc
>>>> -#define DW_PCIE_XILINX_MDB_DEVMEM_OFF_REG_LOW	0x8
>>>> -#define DW_PCIE_XILINX_MDB_INVALID_ADDR		(~0ULL)
>>>> -
>>>> -#define DW_PCIE_XILINX_MDB_LL_OFF_GAP		0x200000
>>>> -#define DW_PCIE_XILINX_MDB_LL_SIZE		0x800
>>>> -#define DW_PCIE_XILINX_MDB_DT_OFF_GAP		0x100000
>>>> -#define DW_PCIE_XILINX_MDB_DT_SIZE		0x800
>>>> +#define DW_PCIE_XILINX_VSEC_DMA_ID		0x6
>>>> +#define DW_PCIE_XILINX_VSEC_ID			0x20
>>>> +#define DW_PCIE_XILINX_VSEC_DMA_BAR		GENMASK(10, 8)
>>>> +#define DW_PCIE_XILINX_VSEC_DMA_MAP		GENMASK(2, 0)
>>>> +#define DW_PCIE_XILINX_VSEC_DMA_WR_CH		GENMASK(9, 0)
>>>> +#define DW_PCIE_XILINX_VSEC_DMA_RD_CH		GENMASK(25, 16)
>>>> +
>>>> +#define DW_PCIE_XILINX_DEVMEM_OFF_REG_HIGH	0xc
>>>> +#define DW_PCIE_XILINX_DEVMEM_OFF_REG_LOW	0x8
>>>> +#define DW_PCIE_XILINX_INVALID_ADDR		(~0ULL)
>>>> +
>>>> +#define DW_PCIE_XILINX_LL_OFF_GAP		0x200000
>>>> +#define DW_PCIE_XILINX_LL_SIZE			0x800
>>>> +#define DW_PCIE_XILINX_DT_OFF_GAP		0x100000
>>>> +#define DW_PCIE_XILINX_DT_SIZE			0x800
>>>>
>>>>    #define DW_BLOCK(a, b, c) \
>>>>    	{ \
>>>> @@ -258,10 +258,10 @@ static void dw_edma_pcie_get_xilinx_dma_data(struct pci_dev *pdev,
>>>>    	u16 vsec;
>>>>    	u64 off;
>>>>
>>>> -	pdata->devmem_phys_off = DW_PCIE_XILINX_MDB_INVALID_ADDR;
>>>> +	pdata->devmem_phys_off = DW_PCIE_XILINX_INVALID_ADDR;
>>>>
>>>>    	vsec = pci_find_vsec_capability(pdev, PCI_VENDOR_ID_XILINX,
>>>> -					DW_PCIE_XILINX_MDB_VSEC_DMA_ID);
>>>> +					DW_PCIE_XILINX_VSEC_DMA_ID);
>>>>    	if (!vsec)
>>>>    		return;
>>>>
>>>> @@ -272,18 +272,18 @@ static void dw_edma_pcie_get_xilinx_dma_data(struct pci_dev *pdev,
>>>>
>>>>    	pci_dbg(pdev, "Detected Xilinx PCIe Vendor-Specific Extended Capability DMA\n");
>>>>    	pci_read_config_dword(pdev, vsec + 0x8, &val);
>>>> -	map = FIELD_GET(DW_PCIE_XILINX_MDB_VSEC_DMA_MAP, val);
>>>> +	map = FIELD_GET(DW_PCIE_XILINX_VSEC_DMA_MAP, val);
>>>>    	if (map != EDMA_MF_HDMA_NATIVE)
>>>>    		return;
>>>>
>>>>    	pdata->mf = map;
>>>> -	pdata->rg.bar = FIELD_GET(DW_PCIE_XILINX_MDB_VSEC_DMA_BAR, val);
>>>> +	pdata->rg.bar = FIELD_GET(DW_PCIE_XILINX_VSEC_DMA_BAR, val);
>>>>
>>>>    	pci_read_config_dword(pdev, vsec + 0xc, &val);
>>>>    	pdata->wr_ch_cnt = min(pdata->wr_ch_cnt,
>>>> -			       FIELD_GET(DW_PCIE_XILINX_MDB_VSEC_DMA_WR_CH, val));
>>>> +			       FIELD_GET(DW_PCIE_XILINX_VSEC_DMA_WR_CH, val));
>>>>    	pdata->rd_ch_cnt = min(pdata->rd_ch_cnt,
>>>> -			       FIELD_GET(DW_PCIE_XILINX_MDB_VSEC_DMA_RD_CH, val));
>>>> +			       FIELD_GET(DW_PCIE_XILINX_VSEC_DMA_RD_CH, val));
>>>>
>>>>    	pci_read_config_dword(pdev, vsec + 0x14, &val);
>>>>    	off = val;
>>>> @@ -293,16 +293,16 @@ static void dw_edma_pcie_get_xilinx_dma_data(struct pci_dev *pdev,
>>>>    	pdata->rg.off = off;
>>>>
>>>>    	vsec = pci_find_vsec_capability(pdev, PCI_VENDOR_ID_XILINX,
>>>> -					DW_PCIE_XILINX_MDB_VSEC_ID);
>>>> +					DW_PCIE_XILINX_VSEC_ID);
>>>>    	if (!vsec)
>>>>    		return;
>>>>
>>>>    	pci_read_config_dword(pdev,
>>>> -			      vsec + DW_PCIE_XILINX_MDB_DEVMEM_OFF_REG_HIGH,
>>>> +			      vsec + DW_PCIE_XILINX_DEVMEM_OFF_REG_HIGH,
>>>>    			      &val);
>>>>    	off = val;
>>>>    	pci_read_config_dword(pdev,
>>>> -			      vsec + DW_PCIE_XILINX_MDB_DEVMEM_OFF_REG_LOW,
>>>> +			      vsec + DW_PCIE_XILINX_DEVMEM_OFF_REG_LOW,
>>>>    			      &val);
>>>>    	off <<= 32;
>>>>    	off |= val;
>>>> @@ -360,7 +360,7 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
>>>>    		 * address use the non-LL mode or simple mode supported by
>>>>    		 * the HDMA IP.
>>>>    		 */
>>>> -		if (vsec_data->devmem_phys_off == DW_PCIE_XILINX_MDB_INVALID_ADDR)
>>>> +		if (vsec_data->devmem_phys_off == DW_PCIE_XILINX_INVALID_ADDR)
>>>>    			non_ll = true;
>>>>
>>>>    		/*
>>>> @@ -370,10 +370,10 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
>>>>    		 */
>>>>    		if (!non_ll)
>>>>    			dw_edma_set_chan_region_offset(vsec_data, BAR_2, 0,
>>>> -						       DW_PCIE_XILINX_MDB_LL_OFF_GAP,
>>>> -						       DW_PCIE_XILINX_MDB_LL_SIZE,
>>>> -						       DW_PCIE_XILINX_MDB_DT_OFF_GAP,
>>>> -						       DW_PCIE_XILINX_MDB_DT_SIZE);
>>>> +						       DW_PCIE_XILINX_LL_OFF_GAP,
>>>> +						       DW_PCIE_XILINX_LL_SIZE,
>>>> +						       DW_PCIE_XILINX_DT_OFF_GAP,
>>>> +						       DW_PCIE_XILINX_DT_SIZE);
>>>>    	}
>>>>
>>>>    	/* Mapping PCI BAR regions */
>>>> --
>>>> 2.43.0
>>>>
>>

