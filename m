Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011066.outbound.protection.outlook.com [52.101.57.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D8F34A786;
	Wed, 29 Apr 2026 06:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777444719; cv=fail; b=OYIS6YWAI+0w06adKz44IBmJ8iBH/qGxm5+9BVbRQSk/K4Mx5hejI+4i/tS9lfF8j8t14uLb6S6Kl8/b08bx7p4oyy6bBOeMdsO2GJeCTWVeK0TuWCaYAwVi1cmeqS+Ua3za5YJfPD3XXBdc609oqrOSiKb+z8xHu/QHpk2aljo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777444719; c=relaxed/simple;
	bh=zSzmr+dZdKIjM1Uz/FYSxqvm70I1yrJJwu+eB2ym07I=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XAX113/lCuSUbm3d75/e5LUDqkwkJgkTf3Z5QxzCeYNMybC05J4Xs5LZEknVRwUwgn3X0dzL9jaiipzhgg4w22LpVtWoliafNT4eIV4h/yBAi7Lqi8Osb1Kgpu/zlmtzf00XxufWl+McAsykVkCZBDYG0bofw1G5yHTDZxWbWJ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FDKN+jgM; arc=fail smtp.client-ip=52.101.57.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FDKN+jgM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TJZtkq4ytWJGEX+hb9Kw6OUy5rMOIXSiwpBDY/+vtX+8rPL+H/DCzfBRM5x9on1G+1X+IQdwOyNXZOYPZLDNR0j/CWsSXBISS95FjLhEO3yap0mW9grTblQ+kewJWmANu5aOPea4KueeHJu+VQmoeXUeACxEIMXpRBF+nevfnd0syh54MBwAvprKbf8Mg0XyCQyHUqFJo8slkmqx6V/gjJYTbaMJlTuL5gNcEklOeKbX3sB/m23bhyR64tt9wCA3KuchBUPxZcGVMSL1Qx+C7GpF+7x3qunuyrVWZzTYXtFcdxwJNYloiSqfMlSGN5EKdavA9oRf2NyV6TJLPdWJZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FX6kWO5mhi6Wz+GxkOx93NQ8VRbvdwtAWxlLEM72WhI=;
 b=sX80PeOr3z2KzPfVD2+4SdhozK3/d+46pPnRsUNXbhnj4LiphZj0pwcC5j5qgn0NOSFFG8YMU8cP4MOne990VzM0XSQoKwcyS8ZBiBul+u+v6rtPX/IdIk7nJ2Tk2YHLoUs0/BKm3DHcdyGC5MtrdVrnMpO0fW+7uyzxbl6XMPU9NAr+EkzXIVSF2OdJ+FwSoq7dMShcW47fwFyLXKYwxNjJ9NQyHr9jPMgBXirwKTXcdrf16PUlE3B1P25n9IgOhk/eLSsrj4Dxsrm441aC12ftWR3my/n9PoilHKjrUMoIh2LbEKNxEDqyQMA3Mkl2MZZMnOahwG0BswnrX33Hmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FX6kWO5mhi6Wz+GxkOx93NQ8VRbvdwtAWxlLEM72WhI=;
 b=FDKN+jgMF+WLLD43XJ0gydMJYGSELXLE6RwvewbB+v4GRCq2mUekk7mmnZ5yu8UwKqm6h8tpIWC4ez/oGnHKR/cEtJGRjCRrJHGO0oflaWI9Mk5KAFViS+79FMoF7Tt6hwxO4nCTKR4lLo0AOyRYSg7WmjS0YRsn2a84sV1vqkLeQS+5Ux3z5Y3lEC8HQlZYyVQxKrW1yxqOcspFYxHEFg7jM2ejqMPWrHI3vLROvrOWGAJq/b0LmW0VJU2v5BXWcijqvnDy9O3aHFgzqULq8xtup0cb6T1uXY8ikA6uxLJ3z2i9fg8LXg5DVtPOPqY1t7lyjKUzrsbHd33m6ZhxSQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY8PR12MB8244.namprd12.prod.outlook.com (2603:10b6:930:72::7)
 by DM3PR12MB9286.namprd12.prod.outlook.com (2603:10b6:8:1ae::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.19; Wed, 29 Apr
 2026 06:38:33 +0000
Received: from CY8PR12MB8244.namprd12.prod.outlook.com
 ([fe80::d30c:fb69:3020:73e3]) by CY8PR12MB8244.namprd12.prod.outlook.com
 ([fe80::d30c:fb69:3020:73e3%6]) with mapi id 15.20.9870.013; Wed, 29 Apr 2026
 06:38:33 +0000
Message-ID: <1b622dc9-62b5-49ef-ae89-a3e10a8be77b@nvidia.com>
Date: Wed, 29 Apr 2026 12:08:20 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 6/9] dt-bindings: PCI: tegra194: Add monitor clock
 support
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
 "kwilczynski@kernel.org" <kwilczynski@kernel.org>,
 "mani@kernel.org" <mani@kernel.org>, "robh@kernel.org" <robh@kernel.org>,
 "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
 Jon Hunter <jonathanh@nvidia.com>, "kishon@kernel.org" <kishon@kernel.org>,
 "arnd@arndb.de" <arnd@arndb.de>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "Frank.Li@nxp.com" <Frank.Li@nxp.com>, "den@valinux.co.jp"
 <den@valinux.co.jp>, "hongxing.zhu@nxp.com" <hongxing.zhu@nxp.com>,
 "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
 Vidya Sagar <vidyas@nvidia.com>, "cassel@kernel.org" <cassel@kernel.org>,
 "18255117159@163.com" <18255117159@163.com>
References: <20260324191000.1095768-1-mmaddireddy@nvidia.com>
 <20260324191000.1095768-7-mmaddireddy@nvidia.com>
 <85a2e89f-8795-4365-ac9f-4e1b4c139dbc@kernel.org>
Content-Language: en-US
X-Nvconfidentiality: public
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
In-Reply-To: <85a2e89f-8795-4365-ac9f-4e1b4c139dbc@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PNYP287CA0100.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:2b9::10) To CY8PR12MB8244.namprd12.prod.outlook.com
 (2603:10b6:930:72::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB8244:EE_|DM3PR12MB9286:EE_
X-MS-Office365-Filtering-Correlation-Id: 1044622e-7a04-40b7-6599-08dea5b9ef30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	aQQ6B3gcsC4gphhsruTVOjO5XAXyh7Ent0ZSxhkY51dP9fudgbS73iPaz64+FZYC/1XGN4k5F5reSZdfCZkSE5/tYRi9ykv3Z2I+ERN/sO7k7NVLIlzAMpmyVBv4Orzs6Vjc1cO4mL988zYSqYnDhgOOTblQ935Bp2ivFd8N5sbO12WTinDnYqHhr2J5rHVeMeF+kgT2RJjoOIJOkerJaStf6ib2NIRArR7KQ8VJXeR3LnJrhSd4zC//YVqteeMhhIcToVjIzlurUGX06lqvAHg4cmLNx1q5fyDlEtju8aqrTfDe9M+RoeCqFIb8aBRvLuj6QByDZ8cpV+8xDHVu2kKIOxiFzlUbLxOn8mjTIsL0oUi0nL8XR1hQ3echBwpAvvg7iYxfjgZpeTNhnKabEJadzR8wx7tJgOGY4/iL1i/tk6kSu4fk0cY/FFoEnZca8HFnK9lopn3Bv74q4J+foSOGbBhWCdXPIbzoRvWk9WXOJw7vR9ViQs1oOF+LlivT+5JTESzNmcsGOvKbdoZXUulfWM14GmWEB3E24fib3GkwtOrflxDeFDoqaqBT9ayt6Yd2E0gby5x5XSuOE35d1oV6YXEq4x2+QqaqZHmbECwY+ec7WTqE7i4+q7ffEanCQT4BJPL9ypLG3WzRydAwumBuDT+6UsT6wJW2QWYbJylXb9+whYMgGocRtQnFa+f5bkG0Am60OdnY0Zcyl1hgonEWCrQ7rWS1fVsO5UPUhPM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB8244.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aUV3Nk9XOWo0em9CSmRNQzNZQ29GSW54Uy9zNHF6V2FaRzJvU0ViNTYyVmlt?=
 =?utf-8?B?b0hDZExMbTNGZ3llOW9RWHZzVG4rQkVORG41a3B6RXJhM2pCc3RWZ3MzUGcz?=
 =?utf-8?B?NTdKbzBnQ09ublJwNzhrY2ZRYWgyekszTzc4SUxvNzNEK25EK040VVhoUEo1?=
 =?utf-8?B?eTVTSWtEb21xczVqak4xWmRyWnVtVWYwMnBSVERHdlF2WWVsN1JnTGhUYzU4?=
 =?utf-8?B?TGJBVnF4VU9IUHU5TDVsTTRkMXp5YnJ3cU9YaC9IVU9WTG90YXc5VENHS0VL?=
 =?utf-8?B?aStGTkI0QklQVU0zc25VZGVaTW05NC9tWnZTZjlkSDVwVmFJVmw5TXFtd3Mz?=
 =?utf-8?B?bHFxck5LTkJBMWhiWW9zaE8wY1BUV0xKWHdPcVFGN29pMUZIL0x0cTlXUnZt?=
 =?utf-8?B?dmt5NUZwZmEveU8rSE52TERwcmg1SXNLRjhwWjBYVmVCYlFQK1FuVTdDS1Ji?=
 =?utf-8?B?SEJyV0NvenFYTUNud3RBVmhLRGpkYmtmSGJ3NmpoZWhnSGxZQkZjOWhiYVpw?=
 =?utf-8?B?NHVpTTFCSHBnTnFtcVVSSVY1djVURkE4L0M0ZFFPN2wyYzVTb1dlSkw2WVA0?=
 =?utf-8?B?RE9raCt3WVFReVdzR2EwQ2FYTEViTkFMWjI3UUZubXlDeEQ1UllBbEovMkhH?=
 =?utf-8?B?c0ZBa3QxSEd0aXR0VXRQWUY1cFpaS2p4ekppRTVmemNDQW00WThFVS9GZTMy?=
 =?utf-8?B?SFBQVjhjUE5IeE5ZcVBTK0FHc3hPTnExRDFaRkdpMTZUUGVLbU1GWFVQR2J3?=
 =?utf-8?B?dzN4b0cvZUFmYTVpNVBnY0xoSnRmME41S1BUdmtSMW03cEI3WDd3TVNuaVk2?=
 =?utf-8?B?ZitXL1BTMVp5UHhCVGpHenk4bkw2MjlTc2o0MGp1djEwV2t1SGlzSnBuMDQ4?=
 =?utf-8?B?dHUxVEcxeFhQSzhvUmM5bTZIYUhCUGxBZ3o5RUt6TVdsWTdhbERhTDFjSWJy?=
 =?utf-8?B?cUFmbmhreW5KeUlqRmJsbzFiM3F5dHNLWllsK2ZDbGJxaElHVGJlNitEeXcx?=
 =?utf-8?B?WVlLaHZkSHovMWxWcTRYZ0VUdWtWdElwTG9RZ0Fuc1pxVHdSaXVJSzNJMDVH?=
 =?utf-8?B?U2VhWGhvSFFabmFRNVFEWk1wSTE2c21ZSXlLakQ3blU0VTBmZzFwNG5hL2hk?=
 =?utf-8?B?c3F2a0kvM2JObFF3UTV4NFBzZW96ekp2ZitiK3Jlb0hwSFprcGx1ZWRreUxt?=
 =?utf-8?B?U09NNUczWE9CUnY4UFphMjJjTHR0b3NrelVPcFYySkZ3SE1NalRIb2tpMWVO?=
 =?utf-8?B?UXJNZmRzbEtpRk9iS3A5YVY4WlVER0w1WmgzZWloMmlGUlViVDkvc21wRTVz?=
 =?utf-8?B?Zm9wZG1ydkE4YStETmFWMzJHeFd2bE9nN3lQWXZxV01nT2tKQnkwZWgwcjBw?=
 =?utf-8?B?NHJzU3RXNWxWOUcxRWhjc2JyZ2VNN0NtdW9EZUwvT09nU3pXRnF1T2g2dXhn?=
 =?utf-8?B?M3JlRlduQlpLcENNQzVSd0ZwMW9xcithNGtsWEtDSEsyY01rMk1ERFZENkFq?=
 =?utf-8?B?dnNKbWdXQVNlSWdjMTBKYWlLVVBPU2UvY2NsT0hxTHpuU2VrUGNUWndOSytN?=
 =?utf-8?B?SmY2dThWbnZEa0hJVVRxeFZ0YVFKa3o1WjhtVklidHBVZmppZUdRUlpNLzZ6?=
 =?utf-8?B?YkxyVHlqU1IremZ3QVZGVjdYeERDZDdENkxjMURtaFB1S3NGaG9JOXVHK0lF?=
 =?utf-8?B?bE5ZdW9wRnlHbXVleXJpNmRUN3liYjhOTUZnWWRuUjExWVVqOGV5ZVZ1enlq?=
 =?utf-8?B?V3JrOGRWYTBXWDU3RC8vQ1ArS1VYUnRVNnFiWG9pOFBUeEdpemNVZGhSbW9H?=
 =?utf-8?B?M0p0Y09mOFV0K09CT0RRQTluNGN1UUp3UTY5VHNJWHBGNENBRithQW1xZWgw?=
 =?utf-8?B?SkQvQk9pS2ZibEVWOWFJVTBBNGx2ODNUUFFzMXhXNUxFdGlPR0lFZlN5Rmd1?=
 =?utf-8?B?OWh3MmNycDFoOUUvN0dmakFabFdRVUhTNGI4U2FjbnJmRjRRNUFKV1VYM04z?=
 =?utf-8?B?VlhUSUp2WUtSelRMM0EveXBnakZHano2SXU5MXZoQllDLzFTd0pUbGZ2amZ0?=
 =?utf-8?B?K1pobDN2Ylo0bVdKbEFsNmFKbVFQY21Nc3FXNHRMSFkvWkRTVnQrRFBrYzFW?=
 =?utf-8?B?N3prVEhXWDVTMHhUbnVkTk5DYkJiZlA1NzFIOTRzbk0xQ1prWVpOT3owL2tZ?=
 =?utf-8?B?c3VUNUJWc1VBbTY5U2lQM05xVVhOaE5JL1ByZi9iOWwyWmJ6RnlPSVZ2blJT?=
 =?utf-8?B?V1FwaDJFOXhKbjFPWHBtaTBKMWthZGRhaHVaZmFvbExUYkRpVTF3cUkxazdQ?=
 =?utf-8?B?SzRKNE16dG5xNkx5d2JJY3FXMTY0ZFk5T2JxVUg0WW0raWx0VGRGSHgxSEoy?=
 =?utf-8?Q?6MaNiWPL0Cuf8p0g=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1044622e-7a04-40b7-6599-08dea5b9ef30
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB8244.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2026 06:38:33.5573
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: znXz4xJj9Uhr1WDiztsITJNqF4nlZ/R7XW2ZP0hXw+O6Ko1E+6dKPPdR4kXN+5K2Rkmd6N2rhL/AzbIsKG5gcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9286



On 28/04/26 9:43 pm, Krzysztof Kozlowski wrote:
> On 24/03/2026 20:09, Manikanta Maddireddy wrote:
>> From: Vidya Sagar <vidyas@nvidia.com>
>>
>> Tegra supports PCIe core clock monitoring for any rate changes that may be
>> happening because of the link speed changes. This is useful in tracking
>> any changes in the core clock that are not initiated by the software.
>>
>> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
>> Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
>> Tested-by: Jon Hunter <jonathanh@nvidia.com>
> 
> Please drop the tag here, not applicable to bindings. You cannot test a
> binding on a device.
> 
> Best regards,
> Krzysztof

This patch is available in linux-next now. I will make sure not to add 
Tested-by tag to device tree binding doc in future.

Thanks,
Manikanta

-- 
nvpublic

