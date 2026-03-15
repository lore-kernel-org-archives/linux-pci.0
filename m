Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012068.outbound.protection.outlook.com [52.101.48.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3569A125A9;
	Sun, 15 Mar 2026 13:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773582269; cv=fail; b=VA+Y95lLZqsyTxcUDYCUqOyDt4z0yIIUvLjDuRAIXXOA8G0xFYH77s2+WpMpNWfH6j8WQ3rLoItItyhwiotlErrAv41DnnmqFwdpX8zogQ2ZJnr0B8JL+tro9KmU7Ee73QPMQqUbq6tnu4t9WDMPKJELirnciBXef4/ggCPvSZw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773582269; c=relaxed/simple;
	bh=alV+rO1TDRRaOxYIyV8fdviBfLQKNTG5xI0vEroAnGk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dArBYUKErmiRaBRidteFYlDdD7aMXdk/1gU88NFTLHh2zKx2A2tAOdwzZWcvJONDmku76AmBDZdrcwUDw+hDQGnpGkQrgZo/BIPZcnWt9plU0DLGsDcbe/65pD6fDDoE0takymdhRr2ge+30QzrPjHqtv73dfaYGTapt+waL6vc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=R3nePbyZ; arc=fail smtp.client-ip=52.101.48.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="R3nePbyZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ffEDXxhxSFVFr/9qWVc5tXqaUjzBCU5OgtumRW0JyRzQUbW7o1TIBEK4XgNw3VqUFNRDsJWvJDuJtzWFYlt1E9BOmuiEI67VIbofAx0OQ+TK8jXgeBhTYCGEeQIPhgSvG/Sg3ddTslfxvBo2apq/gXUw0mJjye7gcng6nyzolwv2XoAFeE5arh2nLS8I8vbD4f/hhtPi3Ydyhma7nyhk0Tcw8o3tNBOta+78shWjxaeWRSJJLe/Ui7FxSoH6+Lwn/M8E3x8xJcrCifvCk5+lj21oMeg5Nfz7TAbS/RsjXJm7RRX9Vr6byN9IkP6p5RkKtz8ZSFUwObHXYWarT5rINg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=voYjQpl0iKfvojekfjSuKBPJH+BkN94JZvB0nslQxGo=;
 b=LeXy327Hj1KrVxwow7D36611X0k7tUgo4sNl8ab36or28ezjjhk4ZUvV0H8XReI08NsKHm2qNLrT0Lo6DOFlJXF13a0xXiMOPhnfuRiBzcR5MjM4u2+yaEMDOSL8/GUBFTTGxsbnEHvTgVTZuEMcA0Xfa571jlzfCTqqz4a5tPcFzUt+sqZHB4zI2tbvPxkhZpkAsaNV9kXNnk1m10VOUUV55mAbg6SGWJXG66D/roeW4biIpkBJ/Ht3zPKwNqkDPq+SOrFaZreu2k3PeJMcnUJnI77Y5aOt+bC4UJoahFFeA/TmxKIHGlh+ljgCcL66PHFBErilAq4ErEeShYQxIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=voYjQpl0iKfvojekfjSuKBPJH+BkN94JZvB0nslQxGo=;
 b=R3nePbyZrYNnW2KDL5RZkOsqvpfhr3zjh1mWtOX+elY1ILNNVxiEPoqESdOE4UcIRoW0qLTF68LNPMkUMbV6YR2kazTIwhhcwwRyOknU/J1wnOrVg2QMLr1QK0Y+O3IccqAJNd2cjwnEhLmpQpMs6VfJa1JjsfpQr5wo0gEkjRhNGdimRa+UAUMX3P4iXLFXRqV3GypqQWHvvf7YamZl2HhsFfSFR9L+QBptpg79cxEiZ93Lg7lI94RIW1QVY3C6sYLozL5BIq93MjdMVLPVj8a0YBCX4/o7CdGYwsdo1Xf/gG9nnGU1rXroflg8Uad6nndOr3g3K3cifIm6DCIKpA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY8PR12MB8244.namprd12.prod.outlook.com (2603:10b6:930:72::7)
 by SN7PR12MB6816.namprd12.prod.outlook.com (2603:10b6:806:264::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.13; Sun, 15 Mar
 2026 13:44:25 +0000
Received: from CY8PR12MB8244.namprd12.prod.outlook.com
 ([fe80::d30c:fb69:3020:73e3]) by CY8PR12MB8244.namprd12.prod.outlook.com
 ([fe80::d30c:fb69:3020:73e3%5]) with mapi id 15.20.9723.013; Sun, 15 Mar 2026
 13:44:25 +0000
Message-ID: <4db20e18-c34b-431b-b65d-c94312d73335@nvidia.com>
Date: Sun, 15 Mar 2026 19:14:14 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 06/13] PCI: tegra194: Disable direct speed change for
 EP
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: "bhelgaas@google.com" <bhelgaas@google.com>,
 "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
 "kwilczynski@kernel.org" <kwilczynski@kernel.org>,
 "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
 <krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
 Jon Hunter <jonathanh@nvidia.com>, "kishon@kernel.org" <kishon@kernel.org>,
 "arnd@arndb.de" <arnd@arndb.de>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "Frank.Li@nxp.com" <Frank.Li@nxp.com>, "den@valinux.co.jp"
 <den@valinux.co.jp>, "hongxing.zhu@nxp.com" <hongxing.zhu@nxp.com>,
 "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
 Vidya Sagar <vidyas@nvidia.com>, "cassel@kernel.org" <cassel@kernel.org>,
 "18255117159@163.com" <18255117159@163.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20260303065448.2361488-1-mmaddireddy@nvidia.com>
 <20260303065448.2361488-7-mmaddireddy@nvidia.com>
 <4zxcmzsm6l3zbz4pblp7c67xpn6q6okpqcilupv6l22ce4gcno@b4htj36ngr33>
Content-Language: en-US
X-Nvconfidentiality: public
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
In-Reply-To: <4zxcmzsm6l3zbz4pblp7c67xpn6q6okpqcilupv6l22ce4gcno@b4htj36ngr33>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0140.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d2::10) To CY8PR12MB8244.namprd12.prod.outlook.com
 (2603:10b6:930:72::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB8244:EE_|SN7PR12MB6816:EE_
X-MS-Office365-Filtering-Correlation-Id: 3148f738-b05d-4afa-e031-08de8298f89b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	KI/TpHLn5vS6c1RZhLajK5pbdxSRgG1ikUcXuW/SFQuST+dykcfZBFJhkgUOfb+hrMklpRbZGu38xw0r2JaM66CFjBxWEBdGb4NtshNPzhFNb1RhYZjHLEUwCX/N+6JgmbFvXb90QThUL+Xn64x/jkb+NMHv7PUcXNjRNoSgtvT8Koa2byPPUPqg3RVV/6hgSCMBszDUsqK2pyXm+wZLJsp31BVyS6WpHZLT8Efdd04TaG58y5vJVZEVTDiHgD2oVyEn8SkcUA97kOTBfrmnpUzhNS/MK844FtOBk7ZErHILv6+AJSeXUUbADmtNPOqUttsCzSC7KO+cZgHgh4CNxZMN66m+JpNyL2EumCk/SAaeBfz92GrLWXUkx4COlZzMeabHP1mqN/afyGtjv6jbEnu+lTDtuk6qiue19HGAlhAXrS/ZHrWywgCtZlWjFUq4mBUv5qoL144BN3X0Edq8bdwMDIIFuG+/zWCSQtZaiIu24ARmcEmJOvfRiomx4OU8av09UPelDUL6kmS93JXn+cs764CBZ3sOTR5oWPCiBcUAp9trLtoxxWA2Jby4TK1WLbpbOjXVOg9DeugxUFtBDM2kouiyDwB3thSyIS+gcIxJHLUJeuf3+4H9EM90AoWfJURoFfb0/Ga72+R1FSXN0t533dUAlfvqLyYSILssAhIiHA8fn+h16hS4QARKl14orBsd4VS/K9i96FoGS/UU8m4AamUlivzfLQ7f4Feu8yU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB8244.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S3MxU3RqeGNVU1BsNWI0eENLNy84ZXNBcDFGNkd0bG9wMlpFdkhBLzZ2VFRO?=
 =?utf-8?B?SG4vT3VBM29TeFVITXc3cmU3Q0Zwb282cmdJUWkyMUdKZUNZam8vczVpajNW?=
 =?utf-8?B?Vm9jQjNJOTBrNC9DK3kxOEN0amFPYjhQcDhYMk4zdHNXYngxV3g3RzF4TWQv?=
 =?utf-8?B?ZHVKVXpoU2dVQzJqVmZhQ255T3U4YmtxTExvcmpubjAvRVk5cjltcmhwUWIy?=
 =?utf-8?B?dEJsNEkxOG1qK293ckRaWVphQWR4ZzFLd3lkYmE1SjJaczNWNFNLNlA5MjFt?=
 =?utf-8?B?ME9YUWZBZXZNeHA1U1NMSDNQbzBkNktGK3cxRVc5d1Qzek10RzZJcm5FVFB1?=
 =?utf-8?B?NW1ZcSt2ZncrekxNQWpGYXZiOU1TVTcyNzFCRWtobUg1ay9YTHlPMHEwTVRU?=
 =?utf-8?B?MHpTVnpFZlF1YWx3bXZmMUdwUkJ4UUtIdTk3U0RVUjNNU2RWUWR1UWh3N0ZJ?=
 =?utf-8?B?K0t0elRzNWVGL2JxN2JrRW5oNHdOeDdQWFRGT3hQUnJ0R20zL0xCaFRrYmhF?=
 =?utf-8?B?ZExVWVNxblFnZjB4K0NyNUtwdWZ3M0VLUGJnaERHL3YrZ2wzQklUMTFNdk82?=
 =?utf-8?B?SVZLNy9jNjVwN3EvYXBvaEFPM2pxZDFyU1ZvY0RVWkEyVFlKeVVRMExEcm5m?=
 =?utf-8?B?N29WdVNnVWxnYmRVVlRQUm5mSkNxWmViL2RjdXkwVkgwNFdqYXNYQ1o0d0Y2?=
 =?utf-8?B?S01GNWdQaUg5RnUzRTF3U3ZySDhkWkoyU3B6cVBKTkJ3WjlUMnNQVXpWSXBC?=
 =?utf-8?B?dHVnQUxNaFRTd1BPWGgzMzF6SjZnUUNJcHoxZlZrSFRYTllTSTdsY2FuNHd0?=
 =?utf-8?B?Q0VlbUg4Zm9QWUl4bmNQWUliVXhrai8wVmJQQXpRc0NucnI4NHdiMTd4NENm?=
 =?utf-8?B?bXo3aXRhd0FPdDNPaWpRRFRJU1F4Q3RtbG1MUW9XUXUrSTNzLzU1TnpLZ2xV?=
 =?utf-8?B?S1dQbnZwU044NHhqU0ZpSWJmTk8wRTBhdmVlOTdoUVZEd0VoRzZyVHhTMjRo?=
 =?utf-8?B?SmMvR0xZT1p2WU80YktxekovK1lyeEtIOFJab2dMZklwMlBvZmhXSldJalhj?=
 =?utf-8?B?R2ZMQksvVkk3TXJLTEFKZVpUbmVUNW9JYk91aUJlcTZnZ3lPT2thMHlvbmpj?=
 =?utf-8?B?TFZFTUNSazVGWWhmcW9PYjU1K1JtejBjQlE5ekYyNEx2RWN6V1U3cDNYKy96?=
 =?utf-8?B?ZzgvNjlaL1hvUnlTRzg4bitEUkxpMHBsMkxQbkc4eFRGZEVrWThNdjhxbU5K?=
 =?utf-8?B?dmRuaWhYUTZvSU1tZ0VOYWUvMEJhSDBXMS9acTdTZXVyWmt1ODJJWEk0eWNC?=
 =?utf-8?B?aUM4cnRKNXByamxNT3lveXVuS09oYkJNdEhZeFdmSmthb09MUlVqZXh6Tmlz?=
 =?utf-8?B?eHRKL0tvZlhCN1BRTDBvREp5TUNHaDBtOUVmMDhBeld4Y1QyRG01NnozTDVm?=
 =?utf-8?B?aG4rTkJYdS9qUEpMOHovMTNLN29sK3crRGFMay9ZdVI3c1FvVVY3YStJNVBl?=
 =?utf-8?B?K2R0cGsxVUdKOXdFQURuZHRZZHdxRFAybS9XWTMxUnU0cHRpZWFWcEhGbHd0?=
 =?utf-8?B?Y2ppa3F1STVoRGNIVEkwdGJUemZlSUprWHVZQmVDM2Joakk5V0NZTEc5dEVr?=
 =?utf-8?B?N2dTNUJrS0N6QlBRS1RrNHkzczk5TW84dC9za0FnZFQwQVV3NXUwcXBFdjdu?=
 =?utf-8?B?ZEl5VzN2K2NuWFpiR0w5N2srcGlpZmw0L0VtV1lzSnZLZVpDdXU2cjRBSS9w?=
 =?utf-8?B?T2w0VmRUelpKbDU2c3htZ2ZmNDZKZHczZDZzQnlZYndRcUdQRXh2MldORGlJ?=
 =?utf-8?B?a3BFUTRIbzM0RTRkWFpDUVZlWlpwRXZyTDRVVzJXa3A1akczUnNFTC9oQmsr?=
 =?utf-8?B?dFhjclhjdXlXRm5nOHdkdVBmRXAwSkJoT0VtN3FzMUkxSEJnZ2RDeWVzWUxh?=
 =?utf-8?B?ZHFyK0JVbm1OOXFwOUE1ei9JOHV0ekZDVHpMY3VtY1VKMno0TU5zTkZrYkkw?=
 =?utf-8?B?VDMrNXBhTlhVQy9PeTNLY3JSdG1ndG1icFBENncwemxBRk40bVEzVUpFRU1B?=
 =?utf-8?B?ek5RMVNzZGZhdGh3M0FIcFRaaUFKbGt1WlVvTzVhYWdzT1NoNlJQcHNBS2xT?=
 =?utf-8?B?cHlBYmdVQ2dja2VNcVZCdVdzWVVvMyt6UlBCU0NZY2MrTHRhRnZTRUcyaTBi?=
 =?utf-8?B?OHhRU0IwVHRCeHEyOFY4ZlA4all5WEhQWjMxbnFXaG1RZithbFdteFFoMVJa?=
 =?utf-8?B?cDVXa2pvVEtsb0FLb2s1V3dzZFE3Mk5RejhZZlVNUmJJZ0gxSzlNcU1FQ0pU?=
 =?utf-8?B?VDg5WHJGU1BlenNIdWhjdmI2KzQ1aGZ4RnhRclp3SjBrd1ZEd2NvZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3148f738-b05d-4afa-e031-08de8298f89b
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB8244.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2026 13:44:25.2158
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SjhTV2JRmalfp9TnhIYTqGL3fD/F11l+BP54MdlDxn7aKzoFmjOnqSh85XKh9s979uRLocD5iUbhij5sij9awA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6816



On 05/03/26 3:13 pm, Manivannan Sadhasivam wrote:
> On Tue, Mar 03, 2026 at 12:24:41PM +0530, Manikanta Maddireddy wrote:
>> From: Vidya Sagar <vidyas@nvidia.com>
>>
>> Disable direct speed change for the Endpoint to prevent it from initiating
>> the speed change post physical layer link up at gen1. This leaves the speed
>> change ownership with the host.
>>
> 
> Why?
> 
> - Mani
In pre silicon sim tests our HW team identified that Endpoint is trying 
to initiate speed change after secondary bus reset. So, our HW team 
recommended to disable direct speed change feature in Endpoint to keep 
the speed change control with host.

- Manikanta

> 
>> Fixes: c57247f940e8 ("PCI: tegra: Add support for PCIe endpoint mode in Tegra194")
>> Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
>> Tested-by: Jon Hunter <jonathanh@nvidia.com>
>> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
>> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
>> ---
>> Changes V1 -> V7: None
>>
>>   drivers/pci/controller/dwc/pcie-tegra194.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
>> index 7dcf3e3596dd..2da3478f0b5f 100644
>> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
>> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
>> @@ -1805,6 +1805,10 @@ static void pex_ep_event_pex_rst_deassert(struct tegra_pcie_dw *pcie)
>>   
>>   	reset_control_deassert(pcie->core_rst);
>>   
>> +	val = dw_pcie_readl_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL);
>> +	val &= ~PORT_LOGIC_SPEED_CHANGE;
>> +	dw_pcie_writel_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL, val);
>> +
>>   	if (pcie->update_fc_fixup) {
>>   		val = dw_pcie_readl_dbi(pci, CFG_TIMER_CTRL_MAX_FUNC_NUM_OFF);
>>   		val |= 0x1 << CFG_TIMER_CTRL_ACK_NAK_SHIFT;
>> -- 
>> 2.34.1
>>
> 

-- 
nvpublic

