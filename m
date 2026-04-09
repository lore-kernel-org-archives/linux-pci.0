Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013008.outbound.protection.outlook.com [40.107.201.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C91D234D395;
	Thu,  9 Apr 2026 06:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775717968; cv=fail; b=Po3rtn6pze/aE0XVjzo4Y/VlJsux5y5cbBKlfpxNFFBLIYLWShN7AANLXe9Y/xlAjXK+FG+0QT37n/ZsrjEak81KLosKDF5F9s/yq7VqOXyO3WxcdLOn/MxiKdLOoYR5f14dejHjInYeAbjslXRqkKdADA0KTLlCITLC6at+J9Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775717968; c=relaxed/simple;
	bh=9TCJsPD0uBgQodMuURcvx0ySc1pBY7SLj3zMBR6ZDiQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uSiIepBCR67lOPg6xCxR5R9nxqPjT08PrWES07dZsw38SETbHWkDfuioZKv7+Nmf8sUSy1zO+5eoZ3ldZajknQ9j8d9Jb6EjcczA5Rn8ngFlhjER4+AuPFQDIb+PiBau+3icAZK1EIK7UyGoOQT8qy0uHsWTy9e5VPdcIAq9hmA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IES+r5Q6; arc=fail smtp.client-ip=40.107.201.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IES+r5Q6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pXPw3rx8cmMiY0mxca/plIePw9GXP6GoxSiyz1eGk5YkwDcZfHYJNhgE6ff7DWccGJHH86RW6td9EgO/U2kfut575G3NewCnafvY2lUqLSs9oZ3NRw91no/eH4nZyra1BVJ1EfnHPYCOHLsO9Kpeov6t2mbKBLjDBaKVI1pVrRZoL3r6hspl3j4QrHSYZu1kCMPEp5mlVBQ/KKD1mtJH//5fPUOB3Iz3XA/mxV4hbZDsFrhp4pcKrQWlkYO/+69/+rVqKV7T3XlcbKBG04BS7VtjtAONqMNE6azJaGevZru91sr+LE1uWPZYqmz/zpL8p+7VZdK/6+N69aZZMPdP4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bWAeImwzF6TAYm4lrInnOUJ3iy4lnoDMDwtIb0vo7wE=;
 b=aBcrxCMNxRG09/h2LhF60xe/dp0EDcaFGCarXVG3Yf8I8HaGyjfwX+x15lCi0DT3i9GOaVjnM+apVN08uQBPLGSY2+kjWCs1J2x0xAYJtIHslsImd20Rt9O6CKEFwpR+AkSAmjYTUFp3vC8UPhyYbfv8lRUyJo78sOaxSi52+OxzQDC43nZdfYiVJMxdRucWxzbQE7RHx2/y5TEWZIMaifwG4m8VWdoHaFTV1p1vjhXMs9VX46O3u37UzKXbWNSkRECT8BGIxmaFdH64U89ZZdV7j310Zp3a7XwJHE8Ibp3W5B4rOPXnsSm//lvc8H7pieiyEFYkgpcFOruxBjTxtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bWAeImwzF6TAYm4lrInnOUJ3iy4lnoDMDwtIb0vo7wE=;
 b=IES+r5Q6wWV0JV8U4GLcjCunQXA5gBd0WtkTXZG2s85ztBBeCS+RZmrZYrk0pao1Mn1GIHYVRDT/Drat1POws1vg1ii4rSRRk8xF0WPRnTT1A6hWjHmMB+5d2XGG+c+wg4NWW51S8k+EVcSQPgqqLyvB9RL0NWRkhrYxEk6y5PKRpSdqp3Crfz03plKQf+c03D7ZzWMvOsmErTEz6HEiHpHFJS8t9S0T1Qk2pzZuL99+u/25T1Zros2JAsqyJ+JZysEFi3b0EtbXGmb7XxfXrRn2BXD2I7SrIDQBRjM3JbgsUFeZF99dYLAM1Uf+IPJdLL8qI0/dj53xcaPoClbPFA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB8245.namprd12.prod.outlook.com (2603:10b6:8:f2::16) by
 PH7PR12MB6884.namprd12.prod.outlook.com (2603:10b6:510:1ba::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Thu, 9 Apr
 2026 06:59:20 +0000
Received: from DS0PR12MB8245.namprd12.prod.outlook.com
 ([fe80::e7c5:cfca:a597:7fa4]) by DS0PR12MB8245.namprd12.prod.outlook.com
 ([fe80::e7c5:cfca:a597:7fa4%4]) with mapi id 15.20.9769.017; Thu, 9 Apr 2026
 06:59:19 +0000
Message-ID: <05cfa409-1386-42f2-99f2-2cced8f8f320@nvidia.com>
Date: Thu, 9 Apr 2026 12:29:00 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 09/14] PCI: tegra194: Allow system suspend when the
 Endpoint link is not up
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kwilczynski@kernel.org,
 mani@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 thierry.reding@gmail.com, jonathanh@nvidia.com, kishon@kernel.org,
 arnd@arndb.de, gregkh@linuxfoundation.org, Frank.Li@nxp.com,
 den@valinux.co.jp, hongxing.zhu@nxp.com, jingoohan1@gmail.com,
 vidyas@nvidia.com, cassel@kernel.org, 18255117159@163.com,
 linux-pci@vger.kernel.org, linux-tegra@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260408210323.GA316307@bhelgaas>
Content-Language: en-US
X-Nvconfidentiality: public
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
In-Reply-To: <20260408210323.GA316307@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0169.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1af::13) To DS0PR12MB8245.namprd12.prod.outlook.com
 (2603:10b6:8:f2::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB8245:EE_|PH7PR12MB6884:EE_
X-MS-Office365-Filtering-Correlation-Id: 26f3feaa-d565-436d-1a78-08de9605856f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	yvqHrlrT47zA/FGewMtTnnBFfrpMCX9Rqs6FmPD9L8JPkNp8jgRakkXq8YdeYU6IhpuKuBCDOBkPejwEcrS3i+WfP2q0SaNpCQ84QVZ0O11gtoE3PIHOT9SxYG0xDUmmyvtPaqvCx5k3tJUpXoVompXW4vD7csIuh9hXab/VPra8Vm8D6BEr6MWn3HWbfM+esIEYkyhsMTb9mUMHIBCliZqOERAyB4K2eLhSdGzgoO+xkqTtPvF2p5myJ3so04aCdkVxDJ4joD9syGgYvE4mLBi8SAdSbH3ol8g9r+6/WOZ/F+xjd+szJVGOtLsAukkd22eyyWyBzAhszcPwaHoZTE8FEJSGhIVY9PBD7IJuLlodTAfNyEBvuxKhz+eyzFbtvEtQEb892y/bJq0GcKmvJTC6aBaTZq+V9N0zetY97xTRDBOtWp5GQXeFseXAk6swOaeD3j2Wq3aL//8HzydEFEZPtAnBYQP040xpUyV9CbrnHN5yT6J0z92kPUP8MDLsTgv7zbInS3B68WXe3b7eCyATt2fewd5do0BGf06JDR3tdv+IYWCZh9BUhRlz+fQWjDsNTSCTES4z4nrATxXCEQu6vyV/3PCMGtiHNljy7IKX+Qi2dQvOlI5eTXWHvonBv/DWFCQbQpmdPfOvAMkCuHAYiCqBTR/wT5nCTyu+q/oTwgwFIHD41IbOfEd4JQ5erOy1hOFjQVBdXUHLSYj5RP/Nvmw8LW4hsmZP/84DZe8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB8245.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VVNlTFdGVW16TkF0bUIwKy9OOG9iWEU3eHZ3WVhWZTJsaCtuMGF2Y2hsVDU1?=
 =?utf-8?B?U1p3bEkvT21KK1l1QUtNR3dmK1NNWVZ4YWhPa1VrUGxFTHVoTE5nMTdBZ1Jx?=
 =?utf-8?B?aE5IRkVwUlhCYVVJbjFxbE5ncWJyT0pqK3g1T1h0Q2tnU0ZBYk5sMm5lVDdE?=
 =?utf-8?B?aWhTZjE4aWJ6UjM0TFFjUnlJczNZQ2pEbVRPZmxNMDBtdjBncEU2RksyeXlY?=
 =?utf-8?B?S09ZSGRDM0Z5cDRERnhZWGdoY0pEQS9CQi9qRnRZZTBBTXJlUnZFaHlDdDJs?=
 =?utf-8?B?Q05ENFNYU2Nqc09oeWF4VWtzbkhsamYvR3JsWkNPQ3plZlFSZWFMbGYwbURu?=
 =?utf-8?B?RVNKbEJLajNyTlkxOGFkZWJtMFpDUnRBSFU3dUNQd2FvdG9XbVc2TTBJSzV6?=
 =?utf-8?B?VGxvYnVHRERQaHlReEI5bXBwT3lRdm9nUmlTSHhzUTduREt1UnZ2Y1FvZnJY?=
 =?utf-8?B?MW1mS3ZJditPbFVPWmtTc2xYanFDcGFDNEJkS29neURJb3ZGVXM4bFFETkhu?=
 =?utf-8?B?K1lqQ2FGWml1a3p3R2Q5LzluS3hDb0FoeS9PRnlrWmVMY2VtN2VPSDRMekIy?=
 =?utf-8?B?UXV5aVc5K1N4U3ZYWmt3UVR1M1hVUHFGWTI0bGoyd3lTR2M5dW8zZ1J2Mysy?=
 =?utf-8?B?cUpDTjJhcDdlN0daNXZlT0I5TzFYMXVkVnQwT2pqK1VuYjZMMnpzbERnQ3l4?=
 =?utf-8?B?QjlTRjVNK3MwT3p6ZThwdFBMSnNhVEVjdit0TDM4NU5OUDJiLzRDU3dqRVM0?=
 =?utf-8?B?YWo0Zmljdk5ycFBRZncyTzNySWNYTlBybXZRd1JLMFpKOW9jVGVvU0VrMER4?=
 =?utf-8?B?Vk11bFJ3MWJkTWdXSmpmYzRoMDJocHZqVkFkT016N0w2citmWkVjZVFNL21U?=
 =?utf-8?B?blZsMTIvc0o0WEUzcEVsTlljbHNVeGpxZW9rVDh1TTJFUFVLejZ5Zmgrd1Ew?=
 =?utf-8?B?ODJieGFTcjUyNi81TVU0ZFFBc0kzQmhiZVltd3VuUlQzNmEyQlBwL1FpTFBR?=
 =?utf-8?B?Q2YvQjFLRStLb2hCT2FoR1pVazErMFJ1ZUZwck0vcmFFMEpzWHZlWERRUWdP?=
 =?utf-8?B?V0VlZ3FHSDR2RTQxZkFBV2UzRzhCUnNxWDhRbjJxQXNCNUJQTFo4SjVxNGN5?=
 =?utf-8?B?MWtVb3RLakYvWmJOenV0VUJRQjhZcUFjMnlzOWJLZVpUS3pwalNQT0ZxeGNm?=
 =?utf-8?B?U1hodVlDYksvbklrT05NcFJsc09UbnBsSGY3eThPMzZ4TUlLcEFqN21RNnZ3?=
 =?utf-8?B?c0djOEgvWHM4YWJpY1JxZWJhczgvaEZ5S3JmRDV6Y2FnUUJpcStqTktkT0lh?=
 =?utf-8?B?VFd5Wis5UFhFakZwa29Ub3k4REswdzZDWkx4N09Zc1RlMzNQQTB0NE91Q3Jt?=
 =?utf-8?B?RzFkc0hyMEhkVXFSckxVclJuOXJVaXViZFM5T3A5c3hNelZDL3VaN1BKRi9K?=
 =?utf-8?B?WXZRU1hpTU16YU12TG1JWXRXL1VBYnExSnVQK015aXJzbmYzcFdMZmYxaG03?=
 =?utf-8?B?N0hXVW1tQ05WN0FkQWYvL2s2N2c3WldCZzhxbVpjVHhjdzN6dEFDL01EL2x6?=
 =?utf-8?B?SDZWUm5rNnROS24rWkd4NkdleGdFS3MvR1ZOQmlkWWJEWXRyNWR2VGlSb3lC?=
 =?utf-8?B?RU83WUIvTDc5cSswZ3A3TnJyK3VuM2gxMTFDMXpoYkFYaS9yVWlqRlVLTzBW?=
 =?utf-8?B?dFd0cGVCUEErWTBQTmZFSm5haEM2ZFhQOElaRU9nQVZFcnJWMktDdGFDNkts?=
 =?utf-8?B?Ulh3UDdJSFEzSS9wdGk2d3pXQ3MxZi9sUW1FZE5iOEs2cWtVYTRxVmRZWERD?=
 =?utf-8?B?aVVNc1pDZVV1ZmgrblB2VjF2THA5SUNNQUlENnA1SS9QcTBYS29Fd1V4MVk0?=
 =?utf-8?B?Ykt2R2xOTjBOZnR3OEhVeEJvYnBLTi9hWlZoVmRJdjU3T1VtbTBXWXBNVkE1?=
 =?utf-8?B?elQ1RkJIY2QyS09ITS9neVNLaDN6cG5TTElONUcxcWhPYmJQSEtVNm52VWVu?=
 =?utf-8?B?SUJhdE9DdTNEOHdFdURnV3BpbWdFWHVLankrZ0c5MFlJWkhqU3dhR2FERzIy?=
 =?utf-8?B?MlFQMzJOTmZ3TFNDcWN3TWJheTE1bEExUWZyNjF0S2txbmFGbmlncUJWaFdt?=
 =?utf-8?B?KzBkcTZVOHN5d2hhNDZiMkRsYlFpajlUK3hJRzVKdjlFS2JxODJTUzRmM1Va?=
 =?utf-8?B?QTQ4dWd4MVozeGU4dS80amhCNG1heFErTWpmdnNzcHJsTmhsQWZIR0tMMmZi?=
 =?utf-8?B?RlZsSDFCbEdwWFJHNk90MDhNWmlsWTBra3hET3VDZjJ6c3F5SCtyQkRFNGpO?=
 =?utf-8?B?UjJ6RnFWQzJ6b09xbDNyM1lGYmhpOXZSQ09CN3lSMitIUkRSVGRpdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26f3feaa-d565-436d-1a78-08de9605856f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB8245.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 06:59:19.4903
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lM7dTqrQkqN8M4XJsPlnkk6Wc7/Ci8Lyhk1hfxvHElTa8iI9IQrViki7VXHTyXC0XVni/Wiq6blFxgLGQcaAwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6884



On 09/04/26 2:33 am, Bjorn Helgaas wrote:
> On Wed, Apr 08, 2026 at 03:59:59PM -0500, Bjorn Helgaas wrote:
>> On Wed, Mar 25, 2026 at 12:37:50AM +0530, Manikanta Maddireddy wrote:
>>> From: Vidya Sagar <vidyas@nvidia.com>
>>>
>>> Host software initiates the L2 sequence. PCIe link is kept in L2 state
>>> during suspend. If Endpoint mode is enabled and the link is up, the
>>> software cannot proceed with suspend. However, when the PCIe Endpoint
>>> driver is probed, but the PCIe link is not up, Tegra can go into suspend
>>> state. So, allow system to suspend in this case.
>>
>>> +static int tegra_pcie_dw_suspend(struct device *dev)
>>>   {
>>>   	struct tegra_pcie_dw *pcie = dev_get_drvdata(dev);
>>> -	u32 val;
>>>   
>>>   	if (pcie->of_data->mode == DW_PCIE_EP_TYPE) {
>>> -		dev_err(dev, "Failed to Suspend as Tegra PCIe is in EP mode\n"); > -		return -EPERM;
>>> +		if (pcie->ep_state == EP_STATE_ENABLED) {
>>> +			dev_err(dev, "Tegra PCIe is in EP mode, suspend not allowed\n");
>>
>> Should this message say something about endpoint suspend not being
>> allowed because the link is up?  IIUC, the endpoint *can* suspend if
>> the link is down.
> 
> Oh, and I forgot: the subject line says "allow *system* suspend", but
> it looks like this patch is concerned with *endpoint* suspend.
> 
> I assume that whatever an endpoint does, it can't prevent the host
> from suspending?  I guess I'm just confused about the usage of "system
> suspend" in the subject line and commit message -- does "system" refer
> to the host or the endpoint?

Hi Bjorn,

System refers to the SoC which has a PCIe controller configured in 
Endpoint mode.

Thanks,
Manikanta

-- 
nvpublic

