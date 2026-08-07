Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010039.outbound.protection.outlook.com [52.101.201.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA52C2E762C;
	Fri,  7 Aug 2026 14:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786113283; cv=fail; b=djfKU3JxrVJzJniLbwo6PoeeARQ3KpHXT6nBQyaev0/u+A8ccQqSGg6paZp+D8b7wE9/f+jT2+pHzOHartM/1DO4chJ552wjwizSoK9/eKUohfMZpV2q/S4hbybqxDQ//bTi0rrnezBpRrvDFjc0srhxUUG6EOz3+cohe8LRFZc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786113283; c=relaxed/simple;
	bh=/KTU8b+uLhcg9X3+Zj2qiUFtUwnnHpAY70P4UO4+6bk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nFcpaQ2gsadOfYcx8SO1ORPZMPl08anjQ7I3nhwachd29fDYVgfGD7ksi3KG18xyzFAIGmDTxZVfNSfbUCfZyN7Eu9GoS4Sv3bNdRlNdvKaDSX8ZgmiNqBT7uze1DRqTAK1pe4B32phNUr50G6CmFmTTYo7fKdsckBn5M1/sP+I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=nqiAHBLS; arc=fail smtp.client-ip=52.101.201.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nqiAHBLS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZeEgij7SFL3YtfJDR6vGQriLx9EozgqHn0aFTHIW697c1SeQAiw9d8xBVmfaSNAJxCSizwrv3JRJezTWphURBj1dg41JNb+qXqOO/z/4uaeD+rSzLpcBHT2dDOCqaRW+Qm8xDAgo7yMsRezYRWU4L3tGkcO6CKYB/nI5skTw0KIC+mznzkzMk2Sd3/JNTHkBnehCFp7Pzs8NE7hUy5Tv5pnIJAlOd67UU7E2b0SZxjgVJV3Mak0g5n61cgx6Y0PAujrFuWbHUvD46NUS2r+3X1VwZgNEgHiep4yQTVnRZI4t2WdD3foW7nL5RkoCMe5rWtTDJEumAU/m3GAgArDK2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W9BzQNm9hh9w8iwmMbNZJ/ddZhoPAF+se/elL+sdRJc=;
 b=yRivHUb1evt3LhuzkMeYgQNyFHc/WcK82GMDs/G2S4RItJx6VQTgfoezsNcphWbUErHixWRxE1rmPBRkieOmQeA3CBGPwW8aKMRG1DcOE1U3jgc9txxJK9cAb72prdisHfF3vEVsYdsXSXaj+7f2oIZefOqJlDdv/eZiLSZ4lAgi98zOFYKTeDgBIi7c083sMAyuaTpRu4qpEd4Fwl31ceP16gCAbynYhdBCcpZtkpr/aikT8G8B4/GUaDT9iNWZ0URe07ClnA9YwO8CUqmG18W9pcyWGUvHp4q2dVVW0nCI/JZOjdSp7pQ5YTzjRXx3BFJR1psYg6AQG92GVU0BKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W9BzQNm9hh9w8iwmMbNZJ/ddZhoPAF+se/elL+sdRJc=;
 b=nqiAHBLSPey8o/lUXwKwLywmqdGjIohoGxBK7AjiS9iOadLPIShSHnvFrq74Chp0Lkz39UBAwA0uTzyCnvD2XEaP+mM53hH8V49X3sRAaesHr3ChpPoztVaerxGuBnvKLVBxAcL8UNlnMp0zOisDXiEh+XFjOHR+XZuy6NYDpEs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL4PR12MB9482.namprd12.prod.outlook.com (2603:10b6:208:58d::19)
 by CYYPR12MB9016.namprd12.prod.outlook.com (2603:10b6:930:c4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.20; Fri, 7 Aug
 2026 14:34:37 +0000
Received: from BL4PR12MB9482.namprd12.prod.outlook.com
 ([fe80::e4cf:3801:9631:2965]) by BL4PR12MB9482.namprd12.prod.outlook.com
 ([fe80::e4cf:3801:9631:2965%5]) with mapi id 15.21.0292.013; Fri, 7 Aug 2026
 14:34:34 +0000
Message-ID: <64dc49f2-69ee-4752-8555-35a1a5478ed3@amd.com>
Date: Fri, 7 Aug 2026 20:04:28 +0530
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
 <c771a891-8924-410c-8495-eb91304531c2@amd.com> <anJrAuO4Kh2Q2L9B@SMW015318>
 <c9fcb0cf-7deb-4038-8041-99242e5499bc@amd.com> <anSn4nqVZmxapD3R@SMW015318>
Content-Language: en-US
From: "Verma, Devendra" <devverma@amd.com>
In-Reply-To: <anSn4nqVZmxapD3R@SMW015318>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0244.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1ae::10) To BL4PR12MB9482.namprd12.prod.outlook.com
 (2603:10b6:208:58d::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR12MB9482:EE_|CYYPR12MB9016:EE_
X-MS-Office365-Filtering-Correlation-Id: fca2c5e5-b86e-40b1-80f1-08def4910011
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|18002099003|22082099003|4143699003|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	TPsi5crmsFaUVg7AavlGKHMMVeT70dLNcuCY8soCH5NVhZouSo1y5Cx6TOVqvzE9HykHIVDtSZ/nYdewWpOVNW0vHDY37q7dN8B75Fq99V44fkmItYeHufxuP8ztFXDKxSdXeCzEZ+Rh8Q9AUZ5ravpbxn+H7rDcpnSDAozSlPuhxeO3Mu9A3pJEf6avce6cGl2NSyigGtNkCdIwARn3J8gPsgkqx18+DQJTgO7nHDlXYEYzEp4ubgTN1TOTK1QrPopz7Lj40mgTaCOaMX9ULrKNBkrCUJlU08f59EyeMtl9/wBIIOBSsq2Vhnbs64NPMlNjVMk6kvg4MTOrczuYSnu/biSorEybQgw0k7F08X1Ariwo2zZ8q3/FI9k3CntXDYPQsp+Rf8kS0j/IVKTUwOWVlLKrcvnR0fhHM/fwefuiI10xUx1snGPoH6GMtjxtRRLHsZlh0uxiWK3GbFiAF3nV3gw41YsvqHpyr/U8gPktCo+wgdBQN1yjVm3Ex7krQJX/wYgXVTmD+Ui1V3uWf2axwm3XzGXkAJw4ddSHuT5bqu5LPVaqj3FprJQHTyEWweCbKfZY4mm9gibC8WmhhohcgyY6kTRp/9YRJ/T7PuP8xdPpeyPHFbDyPNjaz2oByi/6DczpFhEviKZgWlltmDVfprgyZyWoFEmrCPl4cGM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR12MB9482.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(18002099003)(22082099003)(4143699003)(11063799006)(56012099006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N28yM1RhUmVPV2I2VG9oVC9oYkNmazdIRVlrbmJYc09LTmtacWpvSkl3K1l0?=
 =?utf-8?B?WHBEM3BFSHlYM2tLa0xaVVFGbWlzTll4Z1kxdkFVSHRJUlR6KzRNV1dFMFV2?=
 =?utf-8?B?dkprOXMvdlg2WDNFb0tZcmNaTGFHb3MzNC9ZRFNOZDB0elZhRGpueExSemZa?=
 =?utf-8?B?VEdXWmxhcndXL2FBTWtJL2k1OTZYYnhUajYwNTNTY3dRWGo4bjJFVWhTZ3ZJ?=
 =?utf-8?B?TlRsM05JZ2xoK0dRSTRDTDJCcU9ESmZLWWlRd3cwUmhGaVNGM1lGaUNMMEtx?=
 =?utf-8?B?cnpwM2tNdFRSQmdVZE96WTVTNEh2Mm5ueFo3dDlJQlVzWjd6RDcxWHMrdmNU?=
 =?utf-8?B?ZHhhb25zdE83SGVLR3RmL00zS29FRWxVMzU4L0xQaE8xa01oZEIxOTNjVFV2?=
 =?utf-8?B?RlRVeUY3NVFmbHZrMTliWEltTWRZMk5GeXJKQ0ZVN21GN2psQjhEd1JyU2RE?=
 =?utf-8?B?NEM1UWJZbGtsRWRMODIwMlMvQm01S2JhdmZ4SHhiODJpRnlKWk1zZzZSYTBL?=
 =?utf-8?B?ZGVMbE02L0Z6b1NPdTdOM1ZGeWljMURuRFUzclpQYlFBK3NnOG4rUm01bHRT?=
 =?utf-8?B?Z3Z3N2dWazhtTU1LZ2liRENHaFlVbEExb2ZLbHpvOE5IMWVtNG1sS1l3M2xI?=
 =?utf-8?B?ZEtmOTY1My81ZXFoN3pNRnpiNmJzeTZGNVBobnZoa1NnSE0vSmFyZzZHSmd5?=
 =?utf-8?B?Y1NxSlVQMFdLZlF5QkRrdVZZR3Zqb1RjZHhuMUVrL2pQYTgzWGhobHVEMHNv?=
 =?utf-8?B?ZGZybEsvdWM4akFic1N1aFl1UzRiU1RibGV6N0VVaHdhVlJvSXYrWFlxK2pG?=
 =?utf-8?B?NlRjdFZRUmhVVUpqRGlYbmtuWjd5bmxBWXRYU3VxeXR5bm1MdnExeVh3VTcv?=
 =?utf-8?B?TTRkSk9ob0NLNW9vR25EYjZpUXJTRThXMUFTNG04T2JSMzdZZFFUb3BvdTBM?=
 =?utf-8?B?Y1ZGVFVXOHFMWkxtbnNJRDUzN2ZCK3FrWDdZMlJLV2IwSE84cGJzeDcvbCsy?=
 =?utf-8?B?MzI0YXpXbXVoNzBWQUhZc290V0YrVXE5NjVBOFQybTVIdDZDeGs0cy9HblRp?=
 =?utf-8?B?QTVnUHJZQlE0OXFleURNMmN2dnZqR1N4L0N4RkR1MXRpOFFNSzFpUWdzWWdz?=
 =?utf-8?B?V0pIVzhnRDIxaVBmYTViOHNvY1Y1ZktQN0drSGp2UXhCRWN2alJxcXVGWFhP?=
 =?utf-8?B?WVU3SnZqTzVPTzVxa2Z4VHZXRmNIK20xdnAveE9ocE5LT3gwN0JpM3IyMmhN?=
 =?utf-8?B?d3lMN3FESGloajc3Uk5IeHREekVSMmtYNysvWGlZTXo4NVJLWVRMaFpWb0xv?=
 =?utf-8?B?UnNoWUs1Vno3OGw4aml2MkhMVktNRmhBcmVKaGNIaWVRZUpaS2tGNEhJRkp6?=
 =?utf-8?B?RUJSalROaXBNOThMY3dIUDdKVDhnenY2WWtVZkt1UnRwcHdNbHhBSzJOaFdq?=
 =?utf-8?B?QjNnQ3NyNDFReUI0cFB6djhEYzBkSGd1WURqRURUT2o0TzdLcGFQVkpBa0s3?=
 =?utf-8?B?L3NSMmpkSXdjOFJBQnl5UWU3N3VoQW5tSzQ2K3BsSXY5THB0elV2b3pJdG1o?=
 =?utf-8?B?QTV4dUlQdnBnYlY5L0hkREx5QWptaU5jMGFYbFFSWXZOSUxxVWg5eWY0NXp5?=
 =?utf-8?B?VXRSbkdQLy9lYnBFbjgyVitRaE9uL3lDMExnVzlQWUVMc01temVEWmtVSHQz?=
 =?utf-8?B?QWt5N3Z5U1JleHl2NkRFNzA0emFyT1JWUDB2ZlRwYjF5U0Z5c09TUndTYlFy?=
 =?utf-8?B?SzhYeWxsQWJoTDExYnA5SDlEMWI1ZXBBOXhJOXBNNGY3NFpFcisxclJBTU05?=
 =?utf-8?B?THh4aCtZbjlvSWxHVUVhTEhCdXZNZFVPZGQ2bEdJWnRudndqc0ZuYVZUUVRI?=
 =?utf-8?B?RGMwWFRRU0FtL3pSRGtDL2xKd05ycWRtM3NhbTRQclZUYjg1c1dWbTlnY3BY?=
 =?utf-8?B?dFZLRGZTNUd1eVY3bVhpVENZNWpqNjJFWWxRSVNTUlBDaDhZWjJiTjRIUk0z?=
 =?utf-8?B?TVJoRWNhY0RiQ3NYcFVkRnJDNU9KNHdWNm15NVBwRnpobVptY3hvN0dRcnNr?=
 =?utf-8?B?czdNVG8xbXV6cGpLaTh5aHpzUVhaMU14RDYvVDNzWG9wSkwxcVkrM1RMVm5R?=
 =?utf-8?B?TGNrbEp0V1J6SmVFeEpSamVEMndCbG9PT0hqSTdyTzc3Z0VoNUlBZjlXcitn?=
 =?utf-8?B?RWdwcFIwWHQwSXhQenFmRWxYUHdIdWx0eHdxN1NiMDJ4eUVtZU15L3FoUGx6?=
 =?utf-8?B?Zk5XL2hnUW5aN01GaUlPVWI2dnU0cW9sdnlBd245N2EvQU02Q3hGWkt0aW8y?=
 =?utf-8?B?ejFlM1YyMTR4KzlhYSt0eTh5Z1BMNGdTRW9PMzJBSEFHcE9FbTh5dz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fca2c5e5-b86e-40b1-80f1-08def4910011
X-MS-Exchange-CrossTenant-AuthSource: BL4PR12MB9482.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2026 14:34:34.3269
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gGfdrdfwVRVQxNzuK+Fghm0DKAoX9D3NB7cY0JwPGtb1JT6LVSxqRAKpGZ6P4j5rnHN90pubNPwSI/FMa9uR8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB9016

On 06-Aug-26 20:57, Frank Li wrote:
> On Thu, Aug 06, 2026 at 06:27:17PM +0530, Verma, Devendra wrote:
>> On 05-Aug-26 04:13, Frank Li wrote:
>>> On Mon, Aug 03, 2026 at 05:45:14PM +0530, Verma, Devendra wrote:
>>>>
>>>> On 01-Aug-26 00:50, Frank Li wrote:
>>>>> On Fri, Jul 31, 2026 at 09:54:01PM +0530, Verma, Devendra wrote:
>>>>>>
>>>>>>
>>>>>> On 28-Jul-26 21:01, Frank Li wrote:
>>>>>>> On Tue, Jul 28, 2026 at 02:47:42PM +0530, Devendra K Verma wrote:
>>>>>>>> Xilinx specific macros for MDB device can be reused for the
>>>>>>>> Xilinx supported other similar IP such as CPM6.
>>>>>>>> Renamed the Xilinx specific macros in a way that can be
>>>>>>>> reused for Xilinx supported upcoming IP, CPM6.
>>>>>>>> Naming is in accordance with the naming done for Synopsys macros.
>>>>>>>>
>>>>>>>> Signed-off-by: Devendra K Verma <devverma@amd.com>
>>>>>>>> ---
>>>>>>>> Changes in v1:
>>>>>>>>        o No change
>>>>>>>> ---
>>>>>>>>      drivers/dma/dw-edma/dw-edma-pcie.c | 58 +++++++++++++++---------------
>>>>>>>>      1 file changed, 29 insertions(+), 29 deletions(-)
>>>>>>>>
>>>>>>>> diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
>>>>>>>> index 791c46e8ae4c..ec5e057a0f11 100644
>>>>>>>> --- a/drivers/dma/dw-edma/dw-edma-pcie.c
>>>>>>>> +++ b/drivers/dma/dw-edma/dw-edma-pcie.c
>>>>>>>> @@ -29,21 +29,21 @@
>>>>>>>>      #define PCI_DEVICE_ID_XILINX_B054		0xb054
>>>>>>>>      #define PCI_DEVICE_ID_XILINX_B00F		0xb00f
>>>>>>>>
>>>>>>>> -#define DW_PCIE_XILINX_MDB_VSEC_DMA_ID		0x6
>>>>>>>> -#define DW_PCIE_XILINX_MDB_VSEC_ID		0x20
>>>>>>>> -#define DW_PCIE_XILINX_MDB_VSEC_DMA_BAR		GENMASK(10, 8)
>>>>>>>> -#define DW_PCIE_XILINX_MDB_VSEC_DMA_MAP		GENMASK(2, 0)
>>>>>>>> -#define DW_PCIE_XILINX_MDB_VSEC_DMA_WR_CH	GENMASK(9, 0)
>>>>>>>> -#define DW_PCIE_XILINX_MDB_VSEC_DMA_RD_CH	GENMASK(25, 16)
>>>>>>>> -
>>>>>>>> -#define DW_PCIE_XILINX_MDB_DEVMEM_OFF_REG_HIGH	0xc
>>>>>>>> -#define DW_PCIE_XILINX_MDB_DEVMEM_OFF_REG_LOW	0x8
>>>>>>>> -#define DW_PCIE_XILINX_MDB_INVALID_ADDR		(~0ULL)
>>>>>>>> -
>>>>>>>> -#define DW_PCIE_XILINX_MDB_LL_OFF_GAP		0x200000
>>>>>>>> -#define DW_PCIE_XILINX_MDB_LL_SIZE		0x800
>>>>>>>> -#define DW_PCIE_XILINX_MDB_DT_OFF_GAP		0x100000
>>>>>>>> -#define DW_PCIE_XILINX_MDB_DT_SIZE		0x800
>>>>>>>> +#define DW_PCIE_XILINX_VSEC_DMA_ID		0x6
>>>>>>>> +#define DW_PCIE_XILINX_VSEC_ID			0x20
>>>>>>>> +#define DW_PCIE_XILINX_VSEC_DMA_BAR		GENMASK(10, 8)
>>>>>>>> +#define DW_PCIE_XILINX_VSEC_DMA_MAP		GENMASK(2, 0)
>>>>>>>> +#define DW_PCIE_XILINX_VSEC_DMA_WR_CH		GENMASK(9, 0)
>>>>>>>> +#define DW_PCIE_XILINX_VSEC_DMA_RD_CH		GENMASK(25, 16)
>>>>>>>
>>>>>>> v1, you agree keep use old MDB ?
>>>>>>>
>>>>>>> Frank
>>>>>>>
>>>>>>
>>>>>> I followed the suggestion you provided at the given link at the end.
>>>>>> Talking of Xilinx based devices, the channel separation is fixed for MDB
>>>>>> but not for CPM6. So, I have have renamed the specific functionality
>>>>>> specific to CPM6 in 2/3 of the same patch series.
>>>>>>
>>>>>> This one cleans up the MDB references and makes the functionality generic
>>>>>> for all the Xilinx devices.
>>>>>>
>>>>>> Suggestion: https://lore.kernel.org/all/amI09ZcfhX4SEPIH@SMW015318/
>>>>>
>>>>> Maybe I have not said cleanly
>>>>>
>>>>> Actually you only need add one macro to for CPM6, other use MDB macro can
>>>>> work well.
>>>>>
>>>>> #define DW_PCIE_XILINX_CPM6_VSEC_CH_SEP                GENMASK(18, 16)
>>>>>
>>>>> These rename are totally unnecessary.  It is quite popular that new chip
>>>>> reuse old chip's register name.
>>>>>
>>>>> We rename it utils we really can't handle these without rename.
>>>>
>>>> You have pointed out the issue in the last line. For the upcoming
>>>> support we anticipated that it would be messy to use the MDB related
>>>> stuff for CPM6 and that's why wanted to clean it before introducing
>>>> functionality for CPM6.
>>>
>>> Do it only when have to do that. Now only add one macro
>>> DW_PCIE_XILINX_CPM6_VSEC_CH_SEP to support CPM6.
>>>
>>
>> Here also we realized that using MDB would create the confusion later on
>> when more features related to CPM6 will come out.
> 
> Do it when you post new features. We will make decistion at that time.
> 
> Now only one DW_PCIE_XILINX_CPM6_VSEC_CH_SEP is NOT enough to support
> rename now.
>

Could you please tell how many changes are required to have the renaming
related patch to be pushed?

> Unnecessary rename will cause meanless conflict when back port some fix
> patches to stable tree in future.
>

This issue will occure irrespective of when patches are pushed.

Anyways, I will be changing the code as per recommendation.
Here we were trying to reduce the misunderstanding but it is not
recommended, for 2/3 of the same patch series, the variable causes
misunderstanding despite reasons/context.

I will push the changes, please review them. Thanks!

> Frank
> 
>> We are trying to contain the issue early, that is why putting up the
>> effort of segregating the macro names.
>>
>> As you have already suggested that the names can be changed but when the
>> need arises. We see the need and handling it early.
>> Request to consider the approach:
>> - All the Xilinx specific macros, providing common functionality,
>>    applicable to MDB and CPM6 are made name agnostic. The macros will
>>    go by the Xilinx name similar to Synopsys declarations.
>>
>> - Macros used specifically for MDB will have MDB to specify the
>>    association with the IP and similar approach for CPM6.
>>
>> Also, as of now, as we are aware of both MDB and CPM6, they look
>> related but there would be end users of these IPs who would not be knowing
>> the MDB if working on CPM6 and vice-versa. This distinction
>> helps in easy understanding rather than creating confusion due to
>> naming dependance on MDB.
>>
>> -Devendra
>>> The prefix "DW_PCIE_XILINX_MDB" and "DW_PCIE_XILINX_VSEC" have not bring
>>> much information,
>>>
>>> The most important part following part after it.
>>>
>>> Frank
>>>
>>>>
>>>> The MDB works, no denying, but mixing the two creates confusion and
>>>> requires the understanding of MDB first and CPM6. For that reason
>>>> the clean approach taken is:
>>>> - Add the generic functionality supported by MDB and CPM6 under the
>>>>     name Xilinx
>>>> - Add the MDB and CPM6 specific functionality with their own
>>>>     associated names, keeping it clean.
>>>>
>>>> - Devendra>
>>>>> Frank
>>>>>
>>>>>>
>>>>>> CPM6 specific declaration:
>>>>>> https://lore.kernel.org/all/20260728091744.1086942-3-devverma@amd.com/
>>>>>>
>>>>>> - Devendra
>>>>>>
>>>>>>>
>>>>>>>> +
>>>>>>>> +#define DW_PCIE_XILINX_DEVMEM_OFF_REG_HIGH	0xc
>>>>>>>> +#define DW_PCIE_XILINX_DEVMEM_OFF_REG_LOW	0x8
>>>>>>>> +#define DW_PCIE_XILINX_INVALID_ADDR		(~0ULL)
>>>>>>>> +
>>>>>>>> +#define DW_PCIE_XILINX_LL_OFF_GAP		0x200000
>>>>>>>> +#define DW_PCIE_XILINX_LL_SIZE			0x800
>>>>>>>> +#define DW_PCIE_XILINX_DT_OFF_GAP		0x100000
>>>>>>>> +#define DW_PCIE_XILINX_DT_SIZE			0x800
>>>>>>>>
>>>>>>>>      #define DW_BLOCK(a, b, c) \
>>>>>>>>      	{ \
>>>>>>>> @@ -258,10 +258,10 @@ static void dw_edma_pcie_get_xilinx_dma_data(struct pci_dev *pdev,
>>>>>>>>      	u16 vsec;
>>>>>>>>      	u64 off;
>>>>>>>>
>>>>>>>> -	pdata->devmem_phys_off = DW_PCIE_XILINX_MDB_INVALID_ADDR;
>>>>>>>> +	pdata->devmem_phys_off = DW_PCIE_XILINX_INVALID_ADDR;
>>>>>>>>
>>>>>>>>      	vsec = pci_find_vsec_capability(pdev, PCI_VENDOR_ID_XILINX,
>>>>>>>> -					DW_PCIE_XILINX_MDB_VSEC_DMA_ID);
>>>>>>>> +					DW_PCIE_XILINX_VSEC_DMA_ID);
>>>>>>>>      	if (!vsec)
>>>>>>>>      		return;
>>>>>>>>
>>>>>>>> @@ -272,18 +272,18 @@ static void dw_edma_pcie_get_xilinx_dma_data(struct pci_dev *pdev,
>>>>>>>>
>>>>>>>>      	pci_dbg(pdev, "Detected Xilinx PCIe Vendor-Specific Extended Capability DMA\n");
>>>>>>>>      	pci_read_config_dword(pdev, vsec + 0x8, &val);
>>>>>>>> -	map = FIELD_GET(DW_PCIE_XILINX_MDB_VSEC_DMA_MAP, val);
>>>>>>>> +	map = FIELD_GET(DW_PCIE_XILINX_VSEC_DMA_MAP, val);
>>>>>>>>      	if (map != EDMA_MF_HDMA_NATIVE)
>>>>>>>>      		return;
>>>>>>>>
>>>>>>>>      	pdata->mf = map;
>>>>>>>> -	pdata->rg.bar = FIELD_GET(DW_PCIE_XILINX_MDB_VSEC_DMA_BAR, val);
>>>>>>>> +	pdata->rg.bar = FIELD_GET(DW_PCIE_XILINX_VSEC_DMA_BAR, val);
>>>>>>>>
>>>>>>>>      	pci_read_config_dword(pdev, vsec + 0xc, &val);
>>>>>>>>      	pdata->wr_ch_cnt = min(pdata->wr_ch_cnt,
>>>>>>>> -			       FIELD_GET(DW_PCIE_XILINX_MDB_VSEC_DMA_WR_CH, val));
>>>>>>>> +			       FIELD_GET(DW_PCIE_XILINX_VSEC_DMA_WR_CH, val));
>>>>>>>>      	pdata->rd_ch_cnt = min(pdata->rd_ch_cnt,
>>>>>>>> -			       FIELD_GET(DW_PCIE_XILINX_MDB_VSEC_DMA_RD_CH, val));
>>>>>>>> +			       FIELD_GET(DW_PCIE_XILINX_VSEC_DMA_RD_CH, val));
>>>>>>>>
>>>>>>>>      	pci_read_config_dword(pdev, vsec + 0x14, &val);
>>>>>>>>      	off = val;
>>>>>>>> @@ -293,16 +293,16 @@ static void dw_edma_pcie_get_xilinx_dma_data(struct pci_dev *pdev,
>>>>>>>>      	pdata->rg.off = off;
>>>>>>>>
>>>>>>>>      	vsec = pci_find_vsec_capability(pdev, PCI_VENDOR_ID_XILINX,
>>>>>>>> -					DW_PCIE_XILINX_MDB_VSEC_ID);
>>>>>>>> +					DW_PCIE_XILINX_VSEC_ID);
>>>>>>>>      	if (!vsec)
>>>>>>>>      		return;
>>>>>>>>
>>>>>>>>      	pci_read_config_dword(pdev,
>>>>>>>> -			      vsec + DW_PCIE_XILINX_MDB_DEVMEM_OFF_REG_HIGH,
>>>>>>>> +			      vsec + DW_PCIE_XILINX_DEVMEM_OFF_REG_HIGH,
>>>>>>>>      			      &val);
>>>>>>>>      	off = val;
>>>>>>>>      	pci_read_config_dword(pdev,
>>>>>>>> -			      vsec + DW_PCIE_XILINX_MDB_DEVMEM_OFF_REG_LOW,
>>>>>>>> +			      vsec + DW_PCIE_XILINX_DEVMEM_OFF_REG_LOW,
>>>>>>>>      			      &val);
>>>>>>>>      	off <<= 32;
>>>>>>>>      	off |= val;
>>>>>>>> @@ -360,7 +360,7 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
>>>>>>>>      		 * address use the non-LL mode or simple mode supported by
>>>>>>>>      		 * the HDMA IP.
>>>>>>>>      		 */
>>>>>>>> -		if (vsec_data->devmem_phys_off == DW_PCIE_XILINX_MDB_INVALID_ADDR)
>>>>>>>> +		if (vsec_data->devmem_phys_off == DW_PCIE_XILINX_INVALID_ADDR)
>>>>>>>>      			non_ll = true;
>>>>>>>>
>>>>>>>>      		/*
>>>>>>>> @@ -370,10 +370,10 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
>>>>>>>>      		 */
>>>>>>>>      		if (!non_ll)
>>>>>>>>      			dw_edma_set_chan_region_offset(vsec_data, BAR_2, 0,
>>>>>>>> -						       DW_PCIE_XILINX_MDB_LL_OFF_GAP,
>>>>>>>> -						       DW_PCIE_XILINX_MDB_LL_SIZE,
>>>>>>>> -						       DW_PCIE_XILINX_MDB_DT_OFF_GAP,
>>>>>>>> -						       DW_PCIE_XILINX_MDB_DT_SIZE);
>>>>>>>> +						       DW_PCIE_XILINX_LL_OFF_GAP,
>>>>>>>> +						       DW_PCIE_XILINX_LL_SIZE,
>>>>>>>> +						       DW_PCIE_XILINX_DT_OFF_GAP,
>>>>>>>> +						       DW_PCIE_XILINX_DT_SIZE);
>>>>>>>>      	}
>>>>>>>>
>>>>>>>>      	/* Mapping PCI BAR regions */
>>>>>>>> --
>>>>>>>> 2.43.0
>>>>>>>>
>>>>>>
>>>>
>>

