Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011029.outbound.protection.outlook.com [52.101.52.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9AE403B10;
	Mon,  3 Aug 2026 12:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785760314; cv=fail; b=hfyPn9CY+vY4eyNqbCvv/uRqNXsJ60Lk9ZXsJ4ksM2dD/1ZuQVnqUht3ng82bOdcebBCz0hDG2rSieXCOT0Bj/c9LAs7IUQFQSZfLqEU2QpmulB/PHMF+WRHiRfJWFOjL5nZEolAgeeSXAjuUE2MNqdxUOA4wx9u5G4N94rA/vE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785760314; c=relaxed/simple;
	bh=duxUQ6kf5pSWBaClnoNaVYXvzkWp6y4Ep5EfIcE653o=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=avCrpyy7W5nNPXogiAiPWttX5XgWJ9doRDEMyCyjQcnc9dNjomg0sV927NI8ua77jef27kTwDhNphEDccPdC2c44biDS1NV8+g1i7wSA6a+/p88LX37vDyuhB6aYTvETz+Kr1sv6aZ6gCSOoHZx90HPg5lwrPQufuYl1uoGzZvs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=SkswMXaX; arc=fail smtp.client-ip=52.101.52.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SkswMXaX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nJvzcOmMWKWAhAxsVq/bmeQUV58SLLLQOT2PNokmMI/SWvQPTKELpt3ARNPhr6G1b/c0ciqo6p0WZuTPjsYSWSXV62DRnbVQ68kewPKh+Dl6AP+B8brq00MsR3oWEV9+Gp1a1dEBD5WxmmFSsmGOZXiBWCMwVRz6GUbOHWTFFWzwgozA6Ceqj1iqA/hCgdvWwy9RGUpgXWGiJnN0HLEaU4jSWXTZj4B7lM7dxMTH1mV4jA3/3/0ptjNa0pcfPGfzlp8ROCIyg79RYjjtWiD8fAnZ6515feiSzZa0ZWwXXboRvT5RorR3GAzsq1fRWO3ehZPqTpgV+nwvz7QZaH42/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uUS8n4p04F8A5rnHHHRw3MA7Uehci0BkRheKYxadbcg=;
 b=qTlzG3wcyNjf1GjwUho8eMbR3LnkxSo0x+Z0qO02wv1ik+gmH4VNmZZSKDdpOxPFWQmw1pZyhyUFcmdI93t9cP/oon3qyMmHFMUO3QDZxqmOo05aZF/TeUzNNeEinpVqyHiAtqwjaQvhKNiz+Wmpa+6FpM5sj/dfs/G/wfkCMY0unbfUzBUaYQ0kUUOSN31bUd8tdnn0ocHt3NrOcKDoBZRqZ2rAmwBNYByMvgihrpTpDcCZsLpPM2RKAlHGvO9mphUsc/FfvxDgaLKOjM7foXgwOaXKNhbC6aBKNg1Xwv/AMJid11EYxSPhT09AJbVgaxGiDtj8JrDCIyM3uB2eyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uUS8n4p04F8A5rnHHHRw3MA7Uehci0BkRheKYxadbcg=;
 b=SkswMXaX5KadzxLzXIzXDWmPp66+0lv/xpKOrvJQctg4hZ805VpKg1q2JmiO6KuPi7wQHX+/lFCIgTS7GVfKjYtxG5PHcelwDahnA+s9+0Mw3VF6eNBDNLjacpkgwi+5QS/jgVXsd1Z4WMnksk+ahClh84+ITf6jnywdFU+XPNE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL4PR12MB9482.namprd12.prod.outlook.com (2603:10b6:208:58d::19)
 by DS0PR12MB8575.namprd12.prod.outlook.com (2603:10b6:8:164::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Mon, 3 Aug
 2026 12:31:47 +0000
Received: from BL4PR12MB9482.namprd12.prod.outlook.com
 ([fe80::e4cf:3801:9631:2965]) by BL4PR12MB9482.namprd12.prod.outlook.com
 ([fe80::e4cf:3801:9631:2965%5]) with mapi id 15.21.0270.016; Mon, 3 Aug 2026
 12:31:46 +0000
Message-ID: <e3e87269-dd5c-4ef6-8361-6a9e010356d4@amd.com>
Date: Mon, 3 Aug 2026 18:01:39 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] dmaengine: dw-edma: Enable Chan Separation via
 VSEC
To: Frank Li <Frank.li@oss.nxp.com>
Cc: mani@kernel.org, vkoul@kernel.org, frank.li@kernel.org,
 den@valinux.co.jp, dmaengine@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, michal.simek@amd.com, devverma@amd.com
References: <20260728091744.1086942-1-devverma@amd.com>
 <20260728091744.1086942-3-devverma@amd.com> <amjLxoj9Ut84PDGJ@SMW015318>
 <e3fa8833-ce85-41dd-8b07-97f85d20b97e@amd.com> <amzAhe-YbGECDCZT@SMW015318>
 <d9ab60af-a46c-45e1-829f-72d6815f1946@amd.com> <amzyDsPP-H2M4FkQ@SMW015318>
Content-Language: en-US
From: "Verma, Devendra" <devverma@amd.com>
In-Reply-To: <amzyDsPP-H2M4FkQ@SMW015318>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0215.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1ab::8) To BL4PR12MB9482.namprd12.prod.outlook.com
 (2603:10b6:208:58d::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR12MB9482:EE_|DS0PR12MB8575:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b10604b-f8e8-4a2a-8f16-08def15b2ecb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|22082099003|18002099003|56012099006|10067099003|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info:
	jPUO5D4DEGXLDV0OxllSEcwdOI3L4FSMFMFNOFk1jIavKeDrxPALGlffKcQTdGIpnFKjeXMznGACZdLv84fvSx0A/PdzG/F+5/mTXGI7VmDScKjNELC755M4yGf9vjJE28DfVB6Y0t+Fsx3D6zMXTUEEIlmS2iY4Rvps2P9i1Y5t5rBO7YVxoLfGj7prysCwvDhuPiO67J5bQmH4Tb/Nn+4MIJqIHXPhyEq4Uf2slUbXShOj8mqaF8dMuB9ivRYMdkyIcGaahQzyEixm1BpTOpCDPu3gqId9/m5f/xhvzomAEU/6HUs2/fM4bWrYKMgR+FTyZCjJblvtpeYPGXL5xPVbL/qy2TI0NzzypZUWoUugQOGi45BSmRPmjEcmu0gvCfbR2jNBGk8e36DwNaCIXgd0kVjGhJtVOF3LLvBrrXLkCfYG4q5uhSCkt/s2yDkMhNys9ZYWQea73Jccj+3aGRfsyRQ5rodVCofGxuy9bd+dUJvEW2zzri6pX6hpN55KvTMf1dRiquP7s3BUuENj96qNZpYT+9Pp4e2FLL99cJk0olGSFltd5VV43F1JBLHSd0a0FTV2CpMC06+4svM9KDdL9u8P3GNSPQUuTOKmn1C5r+oJ8iZibAa++LMVe9ur
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR12MB9482.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(22082099003)(18002099003)(56012099006)(10067099003)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?THd5aVpXeCtkUjJpVXl5NHc2VGZFR1ZhMlZzSmxqMUUxaE9KVEFQcVIrNUpJ?=
 =?utf-8?B?ZDUwYndrZnpoZHhkcTkwTExBTlZHblUyTVU1YjJJdi9Cd1IrT2J0Z0pOV2I4?=
 =?utf-8?B?cFJsSFRKRXY1OXlBalVmNUlXeWx6QzZuSEl4TVA0MWJsUUppTlMrQlU1K1lL?=
 =?utf-8?B?T2JpRUVKYnBoaTBtY1FXd3cyeEt3TGtudnNuS0R1dHdOMW5qM3FzZkJMWWhP?=
 =?utf-8?B?UnlHTVlyZ2NlN3NhbkZKelZDQWI4VHp5blpickNZaUZLWFhOK3ZvUFM0L0c0?=
 =?utf-8?B?c0dRcG1SOU93K09HK2QxRVRhZFpVRWgwdkcwUUI4bHJhK3FyT1dVelFDMUg0?=
 =?utf-8?B?Q211L1N6UDdoUG0xZE9DeWQ1TTFtZE1FRkx1SGJpY0R5Z21jQTZSZ09XYkR5?=
 =?utf-8?B?L2Z5bGpqSnVTclFzNktKa2twSEcvWjFPUUJuMUFCT3VuYzdxcUFBWHBESG5F?=
 =?utf-8?B?a0pDdStzNzAwa1ZIbjlPZ2NJck50NGlzZlZQYmhGZXJ0ekJ0QXo3V2lGMjhp?=
 =?utf-8?B?eGc2VWVPRkhoT2E0WE5LcXhIenJYWitkKzN2YzM3VCtuWEkrdzkwZnByOHJx?=
 =?utf-8?B?cXlhTTdJWVBISS95bmNSMDNLWGtHQWQwMTdWay9icFlPZDlXMHlMT2YzNVJM?=
 =?utf-8?B?Tlc1S3VZb3dybnVhbzFXM0dlb3VvWmRwdVdmMDhSVkNmcDNEeHdlYTdKY1pX?=
 =?utf-8?B?S1BkVmxLSEZwQnB4Y2VZMGkySVdWdFBhcXRPNThWRFdBTnZyWExseEp1bGVx?=
 =?utf-8?B?eGhwSWlzSGUzVmYxMXptNTgvaU5YSWxwbnNQb1k1SmtlMVdYd0dWZ1JqQXJt?=
 =?utf-8?B?TnVXbE00d1RvSUVCVENLYm9OTkxSMU9EdGROSnFTNkovTVR5b2k3OXJtQnZt?=
 =?utf-8?B?RnVDcjVDTG8ydEgraXphU1NDRDZwaW1DcDBSTFpzVjB3cGNEZE1yNGoybitq?=
 =?utf-8?B?WjhBRFNrUzkzRmtFMEdDQ2NmakdLVFQzSE9TcUppNHNqcnJjcDVTOEgwTURE?=
 =?utf-8?B?YmlzdDFMRDhVU2xwOXhscXpCUk10R21SVUhTeElBQlV6aDZoRWZvN3BwR2Fu?=
 =?utf-8?B?d3dMOCtteFJqUlAzV09RRXE0M2hKdytoU3cyV3lvZnhGVWV6SkVsM0JVNHI3?=
 =?utf-8?B?VU0xNVNsTjVHMkdYZmtXNk1QK3VNWHFycFludytLcFpvdzQvRVFPZ0RzWnlN?=
 =?utf-8?B?elpIZEMxY1VteWpBblpGZE9jeE1sN2dVclZvWTgxTXZ3L0N1WFMxQzVXN040?=
 =?utf-8?B?N3Y1Z2FaTnlHLytzR3haTnlZdkJtOTRhbTBxZHFFSWRLNGtjcmhmNHRNeStM?=
 =?utf-8?B?Z2paRjMvdmpZMzZkRUsxa2pBeXJpR2tNTGduanIvQXlzZnVhNXEwMktUTHpm?=
 =?utf-8?B?SnBabnd1RURXMW0vS0RpTkpTcHZKdTZJeWxyaDRVUlhaQU9WVjNLV1VEb3Ez?=
 =?utf-8?B?MkRHRDI3c3Y3RUJiRFFuYU9QMkYvN1NGSkNDWnVRUzlHR3I3bFA4TFR4V2lr?=
 =?utf-8?B?UjZpZ2ZmN2tqZVNGYkRRSjVFelNjNEszWlh5b1pRZ0NVYll6RkRoZHdRdUZq?=
 =?utf-8?B?c0NUVENMem9BellXV2o0VDJ4dDRkeGxDTFdqUTJ3Z0IyUWRTODhNeVRlRVJo?=
 =?utf-8?B?REhRa0V1SWloc1dmbGpyNVBlU2pGMmZjMjFDQzV5d3lrRndycFBkbUovQWow?=
 =?utf-8?B?amEzNWpDTnM4WkRtdXh4azhHc3lwOWo1NUx5TUE1VDdMRy92L25CbVhhbE5w?=
 =?utf-8?B?VlBTekFOUFNMaE1nN3BNMW5VYVRIcGJkWGY2eEhtcnp1bGdTME5nMmdmVlZJ?=
 =?utf-8?B?d3ZXOStCYk03c3I2NnIvS2RsN0xzTUlGTDVaSUpMMHJYSjk2ZzY1a1BnMnRN?=
 =?utf-8?B?MEYwdWpPczlrUkExRmNmWlJhd2VWem05MXdwdktxREF2OCszNTR0N3NlVDZs?=
 =?utf-8?B?bERwSkNaSzNuTmlIQWhyN3dkZ1JGYWtmbk1EbjlIaC9LU2IybWhGSnk3aTBD?=
 =?utf-8?B?QiswcWIxb0w5TXU2bC9oc0lmMk5adlZmeVpDRmhjNzRwQ21DRkRxQUdsSXhw?=
 =?utf-8?B?WWQweFN0SXF2NHhMbncvRlRJTm0zV2FTMGM1Z2lZY1k3dkxJcUJqcU1Rc2ZN?=
 =?utf-8?B?OGRCUEVlWFpCZityb2puYjhoTHJHb2FFOVZ6Tm9ndXJwOEd6TGszZ2VZUnBZ?=
 =?utf-8?B?YTNKUW5VTm90RDB0Qm1oQXV1djhWb1U2czE1bGMzMlIxbmJhRXFJbENlL3hZ?=
 =?utf-8?B?Mmx1SCtSbEUwMDhYMVJPeVpuKzhoVTRmNHRzd20wUlNFdTBpK0hCMGV4OFpS?=
 =?utf-8?B?NHBqMnBzY2ZXRUxBWEhrUUR0dUVFNnRuRDBkR2JLYVNHbDdVeGtjUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b10604b-f8e8-4a2a-8f16-08def15b2ecb
X-MS-Exchange-CrossTenant-AuthSource: BL4PR12MB9482.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2026 12:31:46.6017
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AbaohlndruicoW4DuUFu1kVU3S1YzEsxlBlHSLWqgUu5tnvxuIP8Jg+iqd60yHkjo0Fa3At5vxEr6VebAkFGMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8575

On 01-Aug-26 00:35, Frank Li wrote:
> On Fri, Jul 31, 2026 at 10:03:10PM +0530, Verma, Devendra wrote:
>> On 31-Jul-26 21:04, Frank Li wrote:
>>> On Fri, Jul 31, 2026 at 04:22:22PM +0530, Verma, Devendra wrote:
>>>>
>>>>
>>>> On 28-Jul-26 21:03, Frank Li wrote:
>>>>> On Tue, Jul 28, 2026 at 02:47:43PM +0530, Devendra K Verma wrote:
>>>>>> As per, 'Designware Cores PCI Express DM Controller - Reference
>>>>>> Manual', section 3.2.34.3, VSEC for DEVICE INFORMATION supports
>>>>>> the channel separation mechanisms. Basically, the HDMA IP allows
>>>>>> the user to configure the separation between DMA channel
>>>>>> registers and retrieve it via the VSEC capability mentioned
>>>>>> above.
>>>>>>
>>>>>> HDMA IP supports the channel register space separation from
>>>>>> 256B to 32KB. Default supported size is 256B.
>>>>>>
>>>>>> Signed-off-by: Devendra K Verma <devverma@amd.com>
>>>>>> ---
>>>>>> Changes in v1:
>>>>>>       o Modified dw_edma_get_ch_sep_sz() as per review comment.
>>>>>>         The function now supports ch_sep_sz up to 32KB.
>>>>>>       o Updated to description to reflect the supported channel
>>>>>>         separation sizes.
>>>>>>       o Introduced the CPM6 specific macro for VSEC cap.
>>>>>> ---
>>>>>>     drivers/dma/dw-edma/dw-edma-pcie.c | 21 ++++++++++++++++++---
>>>>>>     1 file changed, 18 insertions(+), 3 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
>>>>>> index ec5e057a0f11..d0f209082878 100644
>>>>>> --- a/drivers/dma/dw-edma/dw-edma-pcie.c
>>>>>> +++ b/drivers/dma/dw-edma/dw-edma-pcie.c
>>>>>> @@ -31,8 +31,11 @@
>>>>>>
>>>>>>     #define DW_PCIE_XILINX_VSEC_DMA_ID		0x6
>>>>>>     #define DW_PCIE_XILINX_VSEC_ID			0x20
>>>>>> -#define DW_PCIE_XILINX_VSEC_DMA_BAR		GENMASK(10, 8)
>>>>>>     #define DW_PCIE_XILINX_VSEC_DMA_MAP		GENMASK(2, 0)
>>>>>> +#define DW_PCIE_XILINX_VSEC_DMA_BAR		GENMASK(10, 8)
>>>>>> +/* AMD CPM6 (Xilinx) supported cap */
>>>>>> +#define DW_PCIE_XILINX_CPM6_VSEC_CH_SEP		GENMASK(18, 16)
>>>>>> +
>>>>>>     #define DW_PCIE_XILINX_VSEC_DMA_WR_CH		GENMASK(9, 0)
>>>>>>     #define DW_PCIE_XILINX_VSEC_DMA_RD_CH		GENMASK(25, 16)
>>>>>>
>>>>>> @@ -73,6 +76,7 @@ struct dw_edma_pcie_data {
>>>>>>     	u16				wr_ch_cnt;
>>>>>>     	u16				rd_ch_cnt;
>>>>>>     	u64				devmem_phys_off;
>>>>>> +	u32				ch_sep_sz;
>>>>>
>>>>> ch_space_sz?
>>>>
>>>> In the document, Designware Cores PCI Express controller Reference
>>>> Manual, it widely referred as channel separation and ch_sep
>>>
>>> which version? I only find "Register Wire Channel seperation" at 6.21a
>>> Feb 2025.
>>>
>>> Frank
>>
>> We have the reference from RM - 6.00a June 2022, following sections:
>> - Table 1-4
>> - Sec 3.2.34.3, Table 3-276 (VSECDMA_DEVICE_INFORMATION)
>> refer to channel separation and describe for HDMA
> 
> But this is not register value, the register MACRO defination should follow
> spec.
> 
> "Channel Separation: Address distance between read and write channels."
> 
> helper function dw_edma_get_ch_sep_sz() convert register value to this
> field.
> 
> The field should use software easy understand/generic term, so reader
> can know what's that easily without check spec. Driver need do some
> abstract, instead direct copy from hardware.
> 
> Frank
> 

The other macros defined also follow the similar format as mentioned in 
the RM. I did not deviate from the rule and used the variable which is 
both understood in software and hardware context alike.
Please follow the discussion below.

> 
>>
>> -Devendra
>>
>>>
>>>> has been used so in order to keep the relevance with the document,
>>>> I chose it to be ch_sep_sz. The other name used is chaddr_space but
>>>> it is not used widely as the ch_sep.
>>>> With your suggestion, it can be infered to be same but relevance with
>>>> the document may not be established.
>>>>
>>>> In the past, a similar discussion we had for choosing the non_ll
>>>> naming and chose this as it mentioned and has relevance with the
>>>> document.
>>>>
>>>> Reference
>>>> https://lore.kernel.org/all/20251223162842.GA4022246@bhelgaas/
>>>>

Also, as pointed out in this thread, it was a learning how naming
shall be convenient and relevant to the concept being implemented
and that's where the idea of naming the variable close to software
and hardware was taken up. It kind of helps in relating with the
RM data.

-Devendra

>>>>>
>>>>>>     };
>>>>>>
>>>>>>     static const struct dw_edma_pcie_data snps_edda_data = {
>>>>>> @@ -127,7 +131,7 @@ static const struct dw_edma_pcie_data xilinx_mdb_data = {
>>>>>>     };
>>>>>>
>>>>>>     static const struct dw_edma_pcie_data xilinx_cpm6_dma_data = {
>>>>>> -	/* MDB registers location */
>>>>>> +	/* CPM6 registers location */
>>>>>>     	.rg.bar				= BAR_0,
>>>>>>     	.rg.off				= SZ_4K,	/*  4 Kbytes */
>>>>>>     	.rg.sz				= SZ_8K,	/*  8 Kbytes */
>>>>>> @@ -189,6 +193,13 @@ static int dw_edma_pcie_irq_vector(struct device *dev, unsigned int nr)
>>>>>>     	return pci_irq_vector(to_pci_dev(dev), nr);
>>>>>>     }
>>>>>>
>>>>>> +static u32 dw_edma_get_ch_sep_sz(u32 ch_sep_val)
>>>>>> +{
>>>>>> +	if (ch_sep_val > 0 && ch_sep_val <= 7)
>>>>>> +		return 256 << ch_sep_val;
>>>>>> +	return 256;
>>>>>> +}
>>>>>> +
>>>>>>     static u64 dw_edma_pcie_address(struct device *dev, phys_addr_t cpu_addr)
>>>>>>     {
>>>>>>     	struct pci_dev *pdev = to_pci_dev(dev);
>>>>>> @@ -279,6 +290,10 @@ static void dw_edma_pcie_get_xilinx_dma_data(struct pci_dev *pdev,
>>>>>>     	pdata->mf = map;
>>>>>>     	pdata->rg.bar = FIELD_GET(DW_PCIE_XILINX_VSEC_DMA_BAR, val);
>>>>>>
>>>>>> +	if (pdev->device == PCI_DEVICE_ID_XILINX_B00F)
>>>>>> +		pdata->ch_sep_sz = dw_edma_get_ch_sep_sz(FIELD_GET(DW_PCIE_XILINX_CPM6_VSEC_CH_SEP,
>>>>>> +								   val));
>>>>>> +
>>>>>>     	pci_read_config_dword(pdev, vsec + 0xc, &val);
>>>>>>     	pdata->wr_ch_cnt = min(pdata->wr_ch_cnt,
>>>>>>     			       FIELD_GET(DW_PCIE_XILINX_VSEC_DMA_WR_CH, val));
>>>>>> @@ -324,9 +339,9 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
>>>>>>     	struct dw_edma_pcie_data *pdata = (void *)pid->driver_data;
>>>>>>     	struct device *dev = &pdev->dev;
>>>>>>     	struct dw_edma_chip *chip;
>>>>>> +	bool non_ll = false;
>>>>>>     	int err, nr_irqs;
>>>>>>     	int i, mask;
>>>>>> -	bool non_ll = false;
>>>>>
>>>>> unnecesary change
>>>>>
>>>>> Frank
>>>>
>>>> Yes, it is an unncessary change. It was introduced by me in some patch
>>>> series and wanted to maintain the revers x-mas order that's why posted
>>>> it. The declration order looks in the patch after this change.
>>>> Please suggest is it OK to include changes like this or it is kind of
>>>> extra scrutiny for the reviewers? I will make the change accordingly
>>>> in next patch.
>>>>
>>>>
>>>>>
>>>>>>
>>>>>>     	if (!pdata)
>>>>>>     		return -ENODEV;
>>>>>> --
>>>>>> 2.43.0
>>>>>>
>>>>
>>

