Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010052.outbound.protection.outlook.com [40.93.198.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76ABC403B00;
	Mon,  3 Aug 2026 12:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785759331; cv=fail; b=d0/dry9hoVx45eclzvWgLKDVYUmrl4lPzo33spHidV6D4D6tEq0rLZGGeMFNskwIbLhqiOtO750cEPW6YjUWysqdnbGIsqXZZPfO2fCs9/plSDj3BraBxGAF/nr6mEtkiE0dRBPO4rogOVnOuGAeo4ytJbCKLwOk9Wmpy8O90SU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785759331; c=relaxed/simple;
	bh=jLVLNnsXf5uMgfr8hAmi774PG+3EHpWqiTSzTrqhR3g=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=chWq4wsHp1G8nxkKfuApoLLvVbmx6j0Cx1qtU9qM3SlZfhnkQe3P5h5JRWOsPDaXsWcYfyN1td14NmcG1TyGcw+b2seWIpjiZ6WO4gG6ADDAqh5CHsewhIMgLouAwAIGCkLrW/sYqCI1p8H9SCo+/O6ljHe6U9OU87luU4P0Wrw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Fh04UPLg; arc=fail smtp.client-ip=40.93.198.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Fh04UPLg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OCVgb2mivBJ7OemVTXYj2yCoC4ZYLsI6AombAj1aYM2jfXZEnXNUTKS9Evvx5ixJnkmKmTfm/xjiISwNvppyjRGMlThRc8DSrJuB7BOxkBUBJQu/RRH2LriAAAJR5u/nrhLdNWJZ+p59AByM51iLcbp2ry9d/rhgKTAH+U1QpyTLDC28GiSnY9ESpLb08UMMYCTWH4BQr9oKcuUkRGVBuRzZwWCQfVXOysVVNPZX81efqBkuqOjXVUH2wb6C5XSYTudnLk8+VXutCVWeojodchuj2nNlEA/Ig7XdkzvcX+GMYzvKyGKtudokBCmLQ5Fav7gYxeYthY9Wocz6cIKIyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=az2fhp+2+l2tcdjXC5j9XmB009zv1eJSG7Ok2eU0pOU=;
 b=Kh+GLo78e2WvZqNeZylTyTaJz3iB71sd8Li0UqWUMIdqZrzsmWdZGQOBwEpGP6dOtpZHe6AyKieIiRAC6JL4TTa3UnLSnofxZUjIAJlVaUOzKu8yfUnwYEF1YZ0FwLdyYdhTixaXn7rdKmnHeUYU5QCUd8mBNUlzYCp+1Mbp1Ue1E2ealoUKb3PWj/aGlz/a+Mnwcv2bfwbAkuCKXadp5/6GUsAUuGO/LCeID2m/enB+seGMfjH60xW3IVCRP/4nflSHchhbdjOLtx3X285jElnmNLU4+zd9JtAHixJW/8Vj5Qi/f68Pn87IYuf/AD+z5Bfz2/vb6g0j38bChcADRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=az2fhp+2+l2tcdjXC5j9XmB009zv1eJSG7Ok2eU0pOU=;
 b=Fh04UPLgv9dSC5Fu6K3s7H45Fre/O/lKsqhWgiFaV2JDTPyyHiWpQ4I9z+qghDJ1yDg9Xfao5Tmcr4UsQwUIbt9E8eF+Wy+073JMt+b0CZBcnPWFahqVKZMz9vSZ/7h2mmOxcx7IAdbMLtO8tsLGZAoOTMM49MFlUK4bIBPMwq8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL4PR12MB9482.namprd12.prod.outlook.com (2603:10b6:208:58d::19)
 by MN0PR12MB5907.namprd12.prod.outlook.com (2603:10b6:208:37b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Mon, 3 Aug
 2026 12:15:19 +0000
Received: from BL4PR12MB9482.namprd12.prod.outlook.com
 ([fe80::e4cf:3801:9631:2965]) by BL4PR12MB9482.namprd12.prod.outlook.com
 ([fe80::e4cf:3801:9631:2965%5]) with mapi id 15.21.0270.016; Mon, 3 Aug 2026
 12:15:19 +0000
Message-ID: <c771a891-8924-410c-8495-eb91304531c2@amd.com>
Date: Mon, 3 Aug 2026 17:45:14 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] dmaengine: dw-edma: Make Xilinx Macros Dev Name
 Agnostic
To: Frank Li <Frank.li@oss.nxp.com>
Cc: mani@kernel.org, vkoul@kernel.org, frank.li@kernel.org,
 den@valinux.co.jp, dmaengine@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, michal.simek@amd.com, devverma@amd.com
References: <20260728091744.1086942-1-devverma@amd.com>
 <20260728091744.1086942-2-devverma@amd.com> <amjLTTa-OYtjiP1W@SMW015318>
 <a80a43ce-a291-49f6-baf3-aa1340a3aca2@amd.com> <amz1amHpAjxrlwiq@SMW015318>
Content-Language: en-US
From: "Verma, Devendra" <devverma@amd.com>
In-Reply-To: <amz1amHpAjxrlwiq@SMW015318>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0279.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:21d::11) To BL4PR12MB9482.namprd12.prod.outlook.com
 (2603:10b6:208:58d::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR12MB9482:EE_|MN0PR12MB5907:EE_
X-MS-Office365-Filtering-Correlation-Id: 83d1f1af-1407-4f87-fef1-08def158e2b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|11063799006|10067099003|4143699003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Sf+Z4MXFy6YND+Jh1/gcF9BFm0+/rocpTRYzwPZ6qrAxohwj+p/WCDVD/lyS0D8SiF7mXL1ilMqqqhLfUVspwzgRvC1yQv2uLuenGaf6/jAb7B6KOvk2U0vi7aj1LmDlMq91JhrENpqCLUQB8QUvYaRR+OD/ntMDx+awvsnobM3/ut/lu4yZ7oX8Qs0eAB0FgDwhtigRQHcQoWFKlfvKsj+m91XXM+X0tssRC3StgmghG1pmtOmPaKeWv+OqLdNCMwiIOUcQVTzOf0vJeQBJx1vmbcJVZrld93mrlxrDyNWjR4efEHBpYvJhm3UvE9HW18CXC5z80Qo9C7K5uDVU6mVuWEISx7yA93foPHZUS5124+UlAJOAlaVhCTXNkjuLZPQ3ch+VoHFj7SJ02RZ6PZr2beks2slcj6263XlqsrcpmdiAxosyj3tP+P65iePzjmV2g0K6B+rRyMFxOwzxldL+wz+au3j5idNVz1YBAeDe6JK1uZJSJUHNDTWYS4zP8KZPwW5FX51b0qTDQ3H94yfSBbqo/+0N4FxHbRkZtXUp2gczyLSK2P4g9q79una+YSE0+M3LXrBplykDN0KHXWmYh62IDK0QoMMmLxQ7YbE6jEvPsS9Ij9vNCmvz7oTv+UhEoVd7DNK1KpsCvMUymNQLOGuBYV2vDErN7SySC+Y=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR12MB9482.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(11063799006)(10067099003)(4143699003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S29CSXJLV3ptVGVKNjZHOFRFL2xkMWI0MkYyZnM2Q3dHUTJZNW1tdmt5Skhl?=
 =?utf-8?B?eEJZU0dqUnVMSU40bUhscHF1MW5CaGt4S0t2T29NVnMzaDZsRTBqTkJPWWVP?=
 =?utf-8?B?bVZZaXZTaitIbXl1aS91dW9sSVpLSkdqdmpvbk1QTFZOL3NGOThDUzVxYWlV?=
 =?utf-8?B?QU5aczk4U211SER6REtNNGdxWjdQeUdqODdQdWZySk16SlgxcmZBMU1JVlpR?=
 =?utf-8?B?NndlKzhnNVZDdWo4WndLVm8yN0hDRmJGdUkwdmMzdTdFem5TM1NLRFR5Q3hB?=
 =?utf-8?B?Wm1YK3JoUVc5WVZzVFk0bXlOMFZJZ01PUmVqbkptdU5LSnZQUzZTUTlyNkxM?=
 =?utf-8?B?alhCV0dlU3VKT2VvT2dxdzBuQjZaeFRQWmUxb09OK28vZjBQYmtUWkRhMUVQ?=
 =?utf-8?B?cXdyUzFTTWsxQUQ1am5JTHVPQ3BKWERSbmc3S1JZQzMwalc5QzZWL3NRWXJz?=
 =?utf-8?B?K0kxY0RJSHZmRmNncGdqWVVBeXEzODJ3TThLWGsyTUJxTFY4Zm4xMGZQSDYr?=
 =?utf-8?B?VDg5bUw1YjhZdk5DajBOUlMrWnMvTDIzc1JPeG12amZZM2ovUk5TR0ZpWFJL?=
 =?utf-8?B?R3FiN1hTTW9ueUN5VFlaMTgxaG5COWtHaDdmc05rTkVhVEtqUmgyTjJqVXNL?=
 =?utf-8?B?SDdlRUgvNy9PdGZsUS9Xd0FobDk4SHRNbTFIU3JnTGVSRjZUeEJlWFhVYkVo?=
 =?utf-8?B?S0tLTjJpNGUvaWtOcUVockNFY1BwVGpuNEZNVWFOekpDOTROdy93YmJCY0R1?=
 =?utf-8?B?TmtHVkFSZW9QM2JOU21KWWVvK2lQLzlnUms5cXdPc3ljTW5qbkhyeHlPalNq?=
 =?utf-8?B?dHNoelo1cnltNWljTE0zSnJNQStkdzJ3YWpSK3dzQnZDdkVoN3dHTFI5TFda?=
 =?utf-8?B?WTVNa0NlVFRQcEs1dWZOQ3V6c2M5ZjFQODFBQld0MW9GcHZLMHhTT21vb2Y4?=
 =?utf-8?B?cjZXRERsTWUvcDJ5YWQxM2RWWEM2U2VHdTdVVGZiV0pacUpPQ2JBcnFMT3Bh?=
 =?utf-8?B?c1UxSUR5MVdQQjNyUVg4UzFPWHo1L0lCK3JOcVBYNGdGVzFLS29CSnRQZHll?=
 =?utf-8?B?ejh2SkhaQXp1V0h6d1VydmhLTkwwaEZka0hYNjlKaFVwWlFzVldGTDBCek1W?=
 =?utf-8?B?d0JSc085Y0luRHNHM2lVTVpLa0hpOXZ4cExxVVB6RUc1Uks4emQ2UURwL3Fq?=
 =?utf-8?B?b1RaMEk4amVLdWJnb2tWV01qSXRReElPZ284WEh6M1J1YmVmY2NhVHJwTlh1?=
 =?utf-8?B?MUhrL09ra1RYMjROakExdjRPdTd5QjJoOE1vbnRkY1NPa2FhckNQb1MveHlt?=
 =?utf-8?B?VXJGMTVZcHRQNGZWamo3cy9ucStPWlMwc1NJUDVaY3dXUkNUUExkZjVSQkh1?=
 =?utf-8?B?ZTRSRGJFc0ZGdUhxc09zTkI5ZEUySkVITlhMVFBlcHROQURtZ25YM0g3QzRV?=
 =?utf-8?B?bGtnSWZkbWVpZUdhYm5UUVpKbm5uZ2kxbldXaTFpSzFoc0RrRHFGZ0dmUllP?=
 =?utf-8?B?SHQ1VXN5OUJOdlBLU211dHNxREk3UUlVeG1TVDRwUFF1WmxSRG9xUG5qaGp3?=
 =?utf-8?B?b3VkK2Q0c1ZvdTF2MHRhSzBHbFVCQXF2dms4SVd4dkJ2ZEsyV2FqakY5bFk5?=
 =?utf-8?B?TUY1cUJPS3RGelAvRlZCUERERFhDUVBhTnNSb1R1czlkdmZwMnBWaFZvanJN?=
 =?utf-8?B?RWNJbThPNlNiYm1CMU5xanY3WEEvdTdoUzZhVTErZExEV05sVDhGTHNhMVQ1?=
 =?utf-8?B?MFBCcVFoV1FMWVZkODBBYTZMMUtKMHl5MFBQd0gxNCsyTERxc3Y0RzEzS2tp?=
 =?utf-8?B?RTVnVzVlVFBvSW8zZFZxR2hNMVcyaXVpelluZnZPU0hOSlY1V0MwMmVTT0RF?=
 =?utf-8?B?TVlxZm9aT3B6cGk5Y1kzWHI4cVMvVTlQcmJuZW1lNVFsdkRPRTVPTVNsNTdZ?=
 =?utf-8?B?L2l0K2pkMTFmK0p0RGN4WjFXeDFCWlJXV1hDd2NKR3pNY1RYeFNxK25xUjRX?=
 =?utf-8?B?T2dJbmNGREU4U1IzRytCWDh1eUtyU1JZTUNDN3IvVTFKOGhyRFNiNTNSQ3dS?=
 =?utf-8?B?d1Y4SjlUbDNOVjUrdVc1dTJXbEs0b25vT015d1VXUVhDWXdjSGdVejNvMWgr?=
 =?utf-8?B?ZFFXUnlMU3NISGduSzFnYkJ1VkQrMU9EM3ZFRG51eDd4dnAvSkp3UTJINXgx?=
 =?utf-8?B?c2M3b0JOU3c2NW9yTGp5ZkV2eVo0Zng5aUQ3aDlDSlNrZXRZa3RZWVF3alVq?=
 =?utf-8?B?VVRIU24yWXNJMGYrWUtNdlpPVDVQanpqN0JmaWROSStKLzRadDFmRWtPcUFC?=
 =?utf-8?B?VWNYSDdiWkVDVE9xcElXNThLN0dwdVp1S3R0bUttRTBJVmlwVUVXZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83d1f1af-1407-4f87-fef1-08def158e2b8
X-MS-Exchange-CrossTenant-AuthSource: BL4PR12MB9482.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2026 12:15:19.7564
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fh8DyqTa9Vszhh5biFZnPPxhItu59ZleExqXZdPSFw9uT01t5gBnvSSw0w1fcwwrp9FlZGOv/L1NmUFyqhRs0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5907


On 01-Aug-26 00:50, Frank Li wrote:
> On Fri, Jul 31, 2026 at 09:54:01PM +0530, Verma, Devendra wrote:
>>
>>
>> On 28-Jul-26 21:01, Frank Li wrote:
>>> On Tue, Jul 28, 2026 at 02:47:42PM +0530, Devendra K Verma wrote:
>>>> Xilinx specific macros for MDB device can be reused for the
>>>> Xilinx supported other similar IP such as CPM6.
>>>> Renamed the Xilinx specific macros in a way that can be
>>>> reused for Xilinx supported upcoming IP, CPM6.
>>>> Naming is in accordance with the naming done for Synopsys macros.
>>>>
>>>> Signed-off-by: Devendra K Verma <devverma@amd.com>
>>>> ---
>>>> Changes in v1:
>>>>      o No change
>>>> ---
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
>>>
>>> v1, you agree keep use old MDB ?
>>>
>>> Frank
>>>
>>
>> I followed the suggestion you provided at the given link at the end.
>> Talking of Xilinx based devices, the channel separation is fixed for MDB
>> but not for CPM6. So, I have have renamed the specific functionality
>> specific to CPM6 in 2/3 of the same patch series.
>>
>> This one cleans up the MDB references and makes the functionality generic
>> for all the Xilinx devices.
>>
>> Suggestion: https://lore.kernel.org/all/amI09ZcfhX4SEPIH@SMW015318/
> 
> Maybe I have not said cleanly
> 
> Actually you only need add one macro to for CPM6, other use MDB macro can
> work well.
> 
> #define DW_PCIE_XILINX_CPM6_VSEC_CH_SEP                GENMASK(18, 16)
> 
> These rename are totally unnecessary.  It is quite popular that new chip
> reuse old chip's register name.
> 
> We rename it utils we really can't handle these without rename.

You have pointed out the issue in the last line. For the upcoming
support we anticipated that it would be messy to use the MDB related
stuff for CPM6 and that's why wanted to clean it before introducing
functionality for CPM6.

The MDB works, no denying, but mixing the two creates confusion and
requires the understanding of MDB first and CPM6. For that reason
the clean approach taken is:
- Add the generic functionality supported by MDB and CPM6 under the
   name Xilinx
- Add the MDB and CPM6 specific functionality with their own
   associated names, keeping it clean.

- Devendra>
> Frank
> 
>>
>> CPM6 specific declaration:
>> https://lore.kernel.org/all/20260728091744.1086942-3-devverma@amd.com/
>>
>> - Devendra
>>
>>>
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

