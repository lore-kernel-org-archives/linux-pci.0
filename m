Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013040.outbound.protection.outlook.com [40.93.201.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 579E32F1FEC;
	Thu, 23 Jul 2026 10:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784801981; cv=fail; b=EbUyZo+kejEygwgZzecmBtPR7gWMkpZpOxU99towSE+LLiIL0eJ/7D2B7iWO/HFNCviT8s1YikMH7mpAuOr8tpawC6gsOoYakNn+n8DrpmztHJF0g39NMkrjITsuCXYzyGiWtqWi4uPTJ+RqBcNBolYEcanSzSam0XH4T+GeoZk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784801981; c=relaxed/simple;
	bh=eiiDEu4v2aEtSBKxPSsUr8J66Z7d+JKjnCtBfoe0Fe8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UKH4GdvC9S0g69bTGbL5oWOu3TKmB1JcITP0UXg1UOvnIXtlBJl9gIwrYvMqP6hMVrfBVq/L6zcIVRGInkJVfH0iSWBpvGzfbOGIUd/3uBXvvssit3e7M7UuA41M26KmTPvZF6z98rk8+dJR08SP26omDTqVNx3lCsCDWbCLOzs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=16Fst+PL; arc=fail smtp.client-ip=40.93.201.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="16Fst+PL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HI440e6MFXoKgayAnHcLYJlI5q9IVw8TStXSgbflqNI4nBuQA2gfYzrUnUGbe02OGYpMTfC6g+NsT8hciQiC9ZWtwJZyRcFTTVVDp9sSSKJf591WCAw3awU/UE3If9VYYVQOJJCQ2u8OztNKpXKvVDXwPfFEDKHeeF70QDXwFGCFDMk1HAmKR13OkpfjHJPqjROofVd3QNIQHizn2JII8lwtEA2v2i452k/VL6LoXwrp0KcsUMbaR3bXlaiG2IcHOfG762p5QGEuHpHq4mOlB3TWNKvCUtrQRz+gPA5QpLXFZ4KrMlISbdtb+xdluroPqBdydHyHO4yGPth4xaUcYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dxt9PH3kIGwyJixFkB7QmNUaW/k6zlaup5DCE6H3frk=;
 b=sNjgHLnshIAKlRGRjxTxFFRAp68U91nde1kUHo03SXCUZxJk17FwmnvPIiFaWjwJpe2H7LNm24xc43nnyvy2cSHZc6uMRs4WJz7ns1fccHju1pwoWKjyIeCkhZylyLpHWyH9gLSIMkzXuLS5viJebDriMY1dsJuBfD1+J4u78apFd5kCDSPDcMI8D0FAfP6cn4OYqwqER3Uo1K23fI/ef3jQENkxj1EjFQ6dHwc7UiEMJwlOGcy5LPpy33GZArWyH8w+kIGOjh1m6+9tnwQE7tqv9/DECkVOPQgYra1l93NfFcqyRi/iObfCoBQIXQrvor+ceVtX1pNEg48KJ0Dcgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dxt9PH3kIGwyJixFkB7QmNUaW/k6zlaup5DCE6H3frk=;
 b=16Fst+PL2UDw07XVdNywczs3e9OEZLySKOAkiK9JIXMwbnQMUJQDFIpsjTUsxh2xXEaMhLW75pCLdi3ySuSDX+uwxksEQ1ZD1sa92hbYnl28FGvDmWgPOOHd0J9NUaDcHhj+f0PtI25QlCIeXbvKgKNTcB3tFesS/ff5cU+t2w4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL4PR12MB9482.namprd12.prod.outlook.com (2603:10b6:208:58d::19)
 by PH7PR12MB9103.namprd12.prod.outlook.com (2603:10b6:510:2f5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 10:19:35 +0000
Received: from BL4PR12MB9482.namprd12.prod.outlook.com
 ([fe80::e4cf:3801:9631:2965]) by BL4PR12MB9482.namprd12.prod.outlook.com
 ([fe80::e4cf:3801:9631:2965%5]) with mapi id 15.21.0245.010; Thu, 23 Jul 2026
 10:19:34 +0000
Message-ID: <c21dfef1-9de0-4e37-97f3-b7dca0bf8c3a@amd.com>
Date: Thu, 23 Jul 2026 15:49:27 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/3] dmaengine: dw-edma: Enable Chan Separation via
 VSEC
To: Frank Li <Frank.li@oss.nxp.com>
Cc: mani@kernel.org, vkoul@kernel.org, frank.li@kernel.org,
 dmaengine@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, michal.simek@amd.com,
 Koichiro Den <den@valinux.co.jp>
References: <20260722111640.1146212-1-devverma@amd.com>
 <20260722111640.1146212-3-devverma@amd.com> <amDbGHRbObX-lt5F@SMW015318>
Content-Language: en-US
From: "Verma, Devendra" <devverma@amd.com>
In-Reply-To: <amDbGHRbObX-lt5F@SMW015318>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0145.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d7::15) To BL4PR12MB9482.namprd12.prod.outlook.com
 (2603:10b6:208:58d::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR12MB9482:EE_|PH7PR12MB9103:EE_
X-MS-Office365-Filtering-Correlation-Id: fc95aba2-29a3-4ac0-27ec-08dee8a3e4b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|11063799006|56012099006|4143699003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	vY1N251I5K0n6BcxcCquKsSNpBaX3EHU/Bnnc7R2tvQ1ICnI9qnqE4tODhjncQwp4Xp4KG+w5gigmLrysJ2ToF4QRHfIclpqJEbY7kxyndP+LncBoRqHHXpeVuwPWG9s3FCGbcF4IiZITtvJlJrclobWdLE4iaCoXcYqCJgGexdKmgDZXXR52F6RjVBwZG4G3lrVBOAj3HRq72wyirjYKX8QSQPRgIMhTpoHJbWup/Zi1yV4ldHomEKxz0JhpMY4hWJamyy+ZEwUmy3FWhbVQR0dYdCVordyVgpOwK1s6qQEuQoiT4E+SJgLfHvMbs+6zXxbFyXEc1sIthGbYQz/xos9qFfGWQgLPsUZHbTqzcGbYNgfsj465OT/B/rUcc3yG3l3mnEoz0ooSi9algZt1XVkG7Kh5GjCxOuczSHByGBz95wOfjoIBvz2HdC4SxK46xR5cWfUwN4Ys2O9aeCa9wcreXBXbpl0sEEwfIS1iyfu7hY3nkpOgi9hmVrXQfmYhLPABR8u8AMxgtR4Nxv14zjWe9WebfMRVr7RRebm0NLR1CSU1BaIwzrlLaWV0R7AOZR85Lte+zBz/aO945EFPlVK6tVYMWpf4WDERJpk1PDmSpreyciEkV0+NMVjwjI1BPztRpO3NBqOLYmKofYfOG7hyCeOQPQlJHcsvQIiBT4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR12MB9482.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(11063799006)(56012099006)(4143699003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SC9wVi9Jem5YR0VKVDdEUmNWUzl1THRrNHBuOTJ3bUpxcGlCMXlQdTlxenVW?=
 =?utf-8?B?SndLVUpiTm1JRVc5Z3IwY09nS3lWbytudmp6cDlrb2MwV29xd0pDbGwwejNn?=
 =?utf-8?B?ZEF6V2c1eXFjNFIzUytpc2pxeUc4V1BVckZON3EwWGVweGFEb3JoV0tJc3Jn?=
 =?utf-8?B?bmhXLys4dEhRSEg4VG00R0QzVDd5MmsyeW0vTkh1YVRDVWRFNy91Z1BBMlBL?=
 =?utf-8?B?TGVIbVIvcno3WVRLRWlWZGRNNzdLK21NejR6L1RGZDRkSFNrZ045NzcvL0Nu?=
 =?utf-8?B?N3ZtK2tuWnZxNnRUTXFrZEJMeThVSW1ITnNYRTViakwzRjFiVUxqR1N4R0E1?=
 =?utf-8?B?TXM2WDR0TU5URmxnaWUxQjE0dWVnTTdvenpiV29sdHI3Vy9Fa3pqNmRiWmsy?=
 =?utf-8?B?VjZiL1FVUmxHeTBLVDRoR2JKL0ZvdCtzMVdCWjE1MVdBaGkwLzVaczZ5OFND?=
 =?utf-8?B?SmptWG9zdm9BWE9uRXowTktNT2pSWmR6SC9mMFNhai9mYXVxU1YzYWU5L29n?=
 =?utf-8?B?cVNSL1M5N2ptNk1WVWtieDQxaHNHSG56LzF4WW5rMnIwSlhuLzJTdU0renA3?=
 =?utf-8?B?WlBGVUhiS3I4MzZwMnRQTFN1dENJQ3d0SlBueGRzeC84ZUV3UEJ1NGFGSHVJ?=
 =?utf-8?B?NU9GdVBlc25HSEpoVElYMzR4VDFPcDdJOVpNam44aFc0ZEhTQnh1YnhSTGx0?=
 =?utf-8?B?cndsVkJraVE0VHM5WncrYlRvQ0RWLzA0TXFmdXZQOFE4QTdJcjFNTTlTRlda?=
 =?utf-8?B?WEtsWUZhSnErcHJDODMzN3FjY1FIamRUbk5scjZFYktFQ28va0RNRzBGckla?=
 =?utf-8?B?UVJEUnkwak5oL3hwYmFDU1cxOUVGVzZRMm5qTFFKUWVSU1hjcmpDNm1XVjYz?=
 =?utf-8?B?b2gwZEJqdWNmMjhENVdXNytwN3dQdU1uZEY0NFpGTDF3bk8xbGVOQ3hLdmZG?=
 =?utf-8?B?RDY3TkdUQ0JkcXpLRTNwV2lmK1duUHJuWUprajNTOEhielFqMHRsWjRZSWxI?=
 =?utf-8?B?MGg2WjZRRkJLeGs1dG9hOXNWODg4VHI3aEorL1ZyQmo2aWxvckxQbFJxaEYz?=
 =?utf-8?B?QkpCZmlqT0t4Vk02b04rMy9OcUVlcjJmOGJ4REFNYjB2Q3FxcVByaFAvdnFQ?=
 =?utf-8?B?M3oySWlFRmZlbUp4bmJxOTloTWhpM2dKNGdLMHFzczN2VjZIanZMbG1qazM3?=
 =?utf-8?B?QkZWQ0x4SUl1TFZ1RFlPQ0ZUZDhCTERoS2R4azdQTUZTVDdZb1dPWUR4V0My?=
 =?utf-8?B?ZVR0V29ESlJFOGp1OHNaanVmWGp1SEI1S2tORDlTSEZqOUsrcXZvZG95dUlk?=
 =?utf-8?B?RVlRTElTM0lRaGt5TVFIaURGMHd5V3dZUVloYzI4R0xsVTBMWnExcDk1OFlD?=
 =?utf-8?B?K0duWm9CRkdCcFU0c0MyNS9GUllTTUJVWE5BdW1KbElJN2xScm9PZXJuYzZV?=
 =?utf-8?B?VXE1N1ZiMGkxNFFoZzFnbWVYMU5tbC9MaDIzZDN5bUxPcGp3ZzdVdDVOM2Y0?=
 =?utf-8?B?bkladGNpODc5MUROajJ5YjhRbFdHdW9BbFZtRGkvaWpIWkhXMm1hUEhtQk5a?=
 =?utf-8?B?bjN3djFSMmZuT3owQTl0VzF0bVpnd0R4dDkrMGtQN1dhb2VST3F3Ui80dm9j?=
 =?utf-8?B?d0RSQ2YxenEvZzh3aUxrT0xEVXMwUmVmWUh1RGczb3BTT0NwUnFqbnlFN0t1?=
 =?utf-8?B?Y3RlOEQ0cEdRS0VvZ0I5SXhmdUoyMEw4c1lvcXpSNDNxLzNiRCtyUHFuU2da?=
 =?utf-8?B?dC9kSWFOZlNKLzdxQWo1aXNaQkMxY0hPdCtjeW9QRUNmaENCTWtsL2JRN2dk?=
 =?utf-8?B?enlGM2FqdHZ1OXlsQ05yd2dzYlM5SWRnRnVvYnhKajhFTlltRmhUeFlaNVNs?=
 =?utf-8?B?clFEYk1PVWRjUHhobFplVU94UkVqVnczZ3lVWHovTEpiYVY0UFFtSDRmYjZq?=
 =?utf-8?B?ZUpPeVBVK1dyUE82RE1tR0wzaU50N3RqQjltckp1U05PSFpJQjZ2b1JkS1lX?=
 =?utf-8?B?ZWszSHNqWk9sSjRXT0F6WDlBTzRpdzl1cjN2cmRaWVBkd0lTa28razAxYURl?=
 =?utf-8?B?L2M4VG5JWTRpNVVia082cVVYak1BL2R1WkUwVzY4UTRTTmdNOW9hN1QwQm9t?=
 =?utf-8?B?NDl4SitzWDlxTy9rdEszc0JLajhNc0hZYzl5bjMyZGtHenFGTUxNdDcwakxH?=
 =?utf-8?B?eS9qY0R3K0Z3SUd5MnkzR1ZReWtvY1QrOW9ncXlERS9RV2tWL0J3TjlqdTJQ?=
 =?utf-8?B?MnpZc3BWRWlicjdld1VvWFE0N1BVN0huTUNIWnhoTUFUcWh1NCtVWTFPcEVz?=
 =?utf-8?B?OTZoakdjUjZTYWtrTHpwYWdVTDRlRnNQRkwvTFEyV3VuTUZEMktrQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc95aba2-29a3-4ac0-27ec-08dee8a3e4b4
X-MS-Exchange-CrossTenant-AuthSource: BL4PR12MB9482.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 10:19:34.8768
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fz84BCy+Z8X1S5ufq8L+Emlbrz754HjSFtrrtbO0choIt2MHkoJ1DVlOtkujGM0GMy6+5wLTbXiaF0HKXyIIgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9103


On 22-Jul-26 20:30, Frank Li wrote:
> On Wed, Jul 22, 2026 at 04:46:39PM +0530, Devendra K Verma wrote:
>> As per, 'Designware Cores PCI Express DM Controller - Reference
>> Manual', section 3.2.34.3, VSEC for DEVICE INFORMATION supports
>> the channel separation mechanisms. Basically, the HDMA IP allows
>> the user to configure the separation between DMA channel
>> registers and retrieve it via the VSEC capability mentioned
>> above.
>>
>> HDMA IP supports the channel separation up to 32K but for
>> the simplicity channel separation support has been added till
>> 4K. As and when required the function can be expanded to include
>> the higher sizes for channel separation.
>> Supported and missed out sizes are:
>> 8K (0x5), 16K (0x6), 32K (0x7)
>>
>> Signed-off-by: Devendra K Verma <devverma@amd.com>
>> ---
>>   drivers/dma/dw-edma/dw-edma-pcie.c | 25 +++++++++++++++++++++++--
>>   1 file changed, 23 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
>> index ec5e057a0f11..6295d01ba2f7 100644
>> --- a/drivers/dma/dw-edma/dw-edma-pcie.c
>> +++ b/drivers/dma/dw-edma/dw-edma-pcie.c
>> @@ -33,6 +33,7 @@
>>   #define DW_PCIE_XILINX_VSEC_ID			0x20
>>   #define DW_PCIE_XILINX_VSEC_DMA_BAR		GENMASK(10, 8)
>>   #define DW_PCIE_XILINX_VSEC_DMA_MAP		GENMASK(2, 0)
>> +#define DW_PCIE_XILINX_VSEC_CH_SEP		GENMASK(18, 16)
> 
> Can keep as bit pos order for the same register?
> 
>>   #define DW_PCIE_XILINX_VSEC_DMA_WR_CH		GENMASK(9, 0)
>>   #define DW_PCIE_XILINX_VSEC_DMA_RD_CH		GENMASK(25, 16)
>>
>> @@ -73,6 +74,7 @@ struct dw_edma_pcie_data {
>>   	u16				wr_ch_cnt;
>>   	u16				rd_ch_cnt;
>>   	u64				devmem_phys_off;
>> +	u32				ch_sep_sz;
>>   };
>>
>>   static const struct dw_edma_pcie_data snps_edda_data = {
>> @@ -127,7 +129,7 @@ static const struct dw_edma_pcie_data xilinx_mdb_data = {
>>   };
>>
>>   static const struct dw_edma_pcie_data xilinx_cpm6_dma_data = {
>> -	/* MDB registers location */
>> +	/* CPM6 registers location */
>>   	.rg.bar				= BAR_0,
>>   	.rg.off				= SZ_4K,	/*  4 Kbytes */
>>   	.rg.sz				= SZ_8K,	/*  8 Kbytes */
>> @@ -189,6 +191,23 @@ static int dw_edma_pcie_irq_vector(struct device *dev, unsigned int nr)
>>   	return pci_irq_vector(to_pci_dev(dev), nr);
>>   }
>>
>> +static u32 dw_edma_get_ch_sep_sz(u32 ch_sep_val)
>> +{
>> +	switch (ch_sep_val) {
>> +	default:
>> +	case 0:
>> +		return 256;
>> +	case 1:
>> +		return 512;
>> +	case 2:
>> +		return 1024;
>> +	case 3:
>> +		return 2048;
>> +	case 4:
>> +		return 4096;
>> +	}
> 
> 	256 << ch_sep_val ?
> 

Thank you for this suggestion.

> 
>> +}
>> +
>>   static u64 dw_edma_pcie_address(struct device *dev, phys_addr_t cpu_addr)
>>   {
>>   	struct pci_dev *pdev = to_pci_dev(dev);
>> @@ -278,6 +297,8 @@ static void dw_edma_pcie_get_xilinx_dma_data(struct pci_dev *pdev,
>>
>>   	pdata->mf = map;
>>   	pdata->rg.bar = FIELD_GET(DW_PCIE_XILINX_VSEC_DMA_BAR, val);
>> +	pdata->ch_sep_sz = dw_edma_get_ch_sep_sz(FIELD_GET(DW_PCIE_XILINX_VSEC_CH_SEP,
>> +							   val));
>>
>>   	pci_read_config_dword(pdev, vsec + 0xc, &val);
>>   	pdata->wr_ch_cnt = min(pdata->wr_ch_cnt,
>> @@ -324,9 +345,9 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
>>   	struct dw_edma_pcie_data *pdata = (void *)pid->driver_data;
>>   	struct device *dev = &pdev->dev;
>>   	struct dw_edma_chip *chip;
>> +	bool non_ll = false;
>>   	int err, nr_irqs;
>>   	int i, mask;
>> -	bool non_ll = false;
> 
> unnessary change here.
> 
> Frank

Just wanted to maintain the inverted X-tree formatting.
Missed this in the previous submitted patch series.

>>
>>   	if (!pdata)
>>   		return -ENODEV;
>> --
>> 2.43.0
>>

