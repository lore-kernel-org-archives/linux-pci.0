Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010049.outbound.protection.outlook.com [52.101.61.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9116F5CDF1;
	Mon, 16 Mar 2026 03:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773632527; cv=fail; b=huuFpw3Nmv4vSgihSe/E1lUvQ5PybPslMtuibLXFKPjFZJBkfOBXAaMcNqAXOv/V3H/5YwEC4iN9j/iV4hNQrNj5Y9KKdlP9f47EtmqjYs6E1BbIPCCQonk+RpH4NKDz5+9A5+/ssfUAmxunxtOBUw3U7RRyZfQlfXOUIeVyG5s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773632527; c=relaxed/simple;
	bh=kvUjXLA37RD50GmS5JnAOZKMNbde6ldWM0SNaxn8bLc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WXRfhrSM5gH+8MUK6PSyVoeX0OxyC2+lZ11oweIrBGT3kHfEJH7YbqSzBqHhIIib8E3xcajjSOHK+GMxqKQTilV+7WPrSM+akUpAkl9G40Ep46rNlQDVmb3GURKR0fvsMeXfQE/qJ4Bdw2tzxivTBODA5qAZh2DqIPWUh/NAO8s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=upqr2tMG; arc=fail smtp.client-ip=52.101.61.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="upqr2tMG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HubDIVJn322t+CfzL4VLPxKsNY0QWGU3JK/fc59hooXup9q9WB3ahJE63BwLkEunAKfvYihZb58Z9staD2q2M8eB49Bx/comOnErujjQaQVwErSDtAg0UwT/cjct5znS2Qt5Gqqy5T8fLDCfne3g+mPEm/rLj/meeBpcUjhUrcR/EFuZjDf/DOBcDYKJbMH+U6LuAl+5yTkn+y/4Caod4ROJsY1YknWh+HjOMSUl6p2ACjpwAfyuitm6qUVllmBHHiCK+Y+Hr6UJtqC9e4Fjpm8qlxUqqibRKhBpH7m0HAKCZ3OGTuYFtsTHe9fFgsQJ5YWfJF6oSTklzMg4f779wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KMv3hauY9HdUVGkcf/RDPssaRgIT1AL3mJsTT2Pu+ZE=;
 b=Xjx38SZ4rb+qTA04+pNRDH85MmmyAsouVN2JBaNQegUyrWCiJBqL0PIspmL3LIs62ljatLAmTn4HUewCpuV3J25jdSnHt080bdyDN0to/pdzR7B4vTeWeY48lOyq7dqrG5N6m+7gCRqkCeJ9PgL6hi9VSPLVy4EyevFT/pi5xc1Kx3Rf/ZAc00p63YqdLY1kxt5jwASetiDe/DYJrVyfVLDhFpqFdOpeWKgGYY2uFEFvhDFTBDOEjVdpskimNB1LDh9d+wkWSKKwc3Us1ff/eNXTpc2hpImZhZWOLy8I+FLxoxQZOJK0x0yfesjYX71WzZGBV7XT7px8PvjAgdJKFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KMv3hauY9HdUVGkcf/RDPssaRgIT1AL3mJsTT2Pu+ZE=;
 b=upqr2tMGAAbJQP6JHghbvb0gy08geeV+MTBiku9MPlmv/SO5N6PoPaWNFeDmaZJP+xlq9elttnWjyXaGS1620BdcOLuYwmlWPazFMbHLc0J99Fms6aLVYUx/stoF6DmfwknYdcm3NiOagbTLlJhdFOzp4t6SWnbAeAoRO/E03A33WqJNnjzqvKACvzN3Z7hWEhKCQqhePOWhIv0f/Te/k0UCMzUI+ec8zhEZSCWirJHO0IHubo9lx64Rg+v7iKcGv1llkQ7OmcKzBytk0UM8YqZotAAC1+sK2q+FOuVIVktF+b6NEgUdu5QxZSiJgqjS/hNLuyDkXQ3YG62XJZVvXg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB8245.namprd12.prod.outlook.com (2603:10b6:8:f2::16) by
 CYYPR12MB8853.namprd12.prod.outlook.com (2603:10b6:930:cb::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.16; Mon, 16 Mar 2026 03:42:03 +0000
Received: from DS0PR12MB8245.namprd12.prod.outlook.com
 ([fe80::e7c5:cfca:a597:7fa4]) by DS0PR12MB8245.namprd12.prod.outlook.com
 ([fe80::e7c5:cfca:a597:7fa4%4]) with mapi id 15.20.9723.014; Mon, 16 Mar 2026
 03:42:02 +0000
Message-ID: <b60bd5ae-eeb7-4e17-801c-5791f6bbf0b3@nvidia.com>
Date: Mon, 16 Mar 2026 09:11:53 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 08/13] PCI: tegra194: Apply pinctrl settings for both
 PCIe RP and EP
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
 <20260303065448.2361488-9-mmaddireddy@nvidia.com>
 <gui4y7vjc4f5brtjgsfvqdn2ig6kw3tsiinrijweltgeukiwdy@2zqe2orx6pas>
 <0471cc77-3173-4987-8d9b-fe089a038bdb@nvidia.com>
 <gnescgbeasa6x5orwtji76qia4e7pwmjsjiehq6ox2a2apzpxq@cfwwzkyjmdlo>
Content-Language: en-US
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
X-Nvconfidentiality: public
In-Reply-To: <gnescgbeasa6x5orwtji76qia4e7pwmjsjiehq6ox2a2apzpxq@cfwwzkyjmdlo>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR03CA0341.namprd03.prod.outlook.com
 (2603:10b6:8:55::23) To DS0PR12MB8245.namprd12.prod.outlook.com
 (2603:10b6:8:f2::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB8245:EE_|CYYPR12MB8853:EE_
X-MS-Office365-Filtering-Correlation-Id: df325c7f-9717-4c70-3125-08de830dfc84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	qsuOv7KP+fcKZuAXZfHtiIJtfMGR6qjHPNpeJuqp4jAkwtYMSr5H82Me0IDZ2RGkwDAvPFOEcof7P0LzE8lf59tu3Jh7uJs7Uyjaeh7th8vsuryOxTRSIzHHKvhYj5VV37uQu3qL4csNVJmDK71qcuRsrGRjxHgT+h07llbDu+vlJi4YXg0HTqvVD/8tgU1ZAPDtLflcYOm2dSZiK7TilZQH3McTr4LHY41gKQ4CM//R9/488sJz7tQubDkUl9KxtbQyMP75dMBlgqyVYBFKxABFc4ehoc32+yLeYdI+uVQlqs4uTuoVwiqjgqu791s4gj3f9KTTWGsZZHi3jHX0xjF75IA1Mgpj5hSG5gceTvceYVxiNeOJTT0clq9gLUUa6YWkcfe2Uf+TIWLJTNANb//kVijX+wV/m5kyv3RmR/Q2O642+VpVoqY3OwegZpoCJEGbYxk5tbn70132Brtb/xDQ/UHwkO68mwYuQJenMlu3oOAxDE90mJDwj5ZNtdggSS9dcMlzSAy8ta9M1pfoNKufsD0DETflEbpHy5Ca/f2ieIjDs4eibZFz+PYe16qIkrgFxuL9m4hC5Mnic199ws3LCVZSwBnaGz2QftPfDV3gp6pq60YurnkwBBMEP8DQMDY1yZgS61dA7GbmqMWbrWcW2M5hiSBiX3Ag0ApzD6g7y/jE0rDzs1gAiVLWIYUhR24TxtVxivYAs2uVqXuU5jZ7cqHTJgY5Isx5Ol9RJls=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB8245.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bmVJU1pPOU56RWlFU3dud2Q1Qm5XOXFvdnRFY1hoV2NJdUNFSk54YTlkelpI?=
 =?utf-8?B?U2xBNHI2V1hHbCtScG5yM0h2SGpDZXdPWHNvMDJFWWhqdDl1NEZwS3JyaW5w?=
 =?utf-8?B?TjdzQlhEVk0rVEQ0TldXaDJIa0VRNzArT0R0bUxPamFtNStoV3BEeG9kTTd4?=
 =?utf-8?B?UXl1a0JERGxNeFovVHZZU3FiSytFejAxblVJem9uZVBYQzJEdWhHU3Z6TWRM?=
 =?utf-8?B?WmxubWlIME5uRVQwZE9PcUlzSzlENjZXdGhJZ3ljNENHVDhVTEE0OXdnNEc1?=
 =?utf-8?B?WWtYM1VBbzBLMTFzOVBjVnEvejF1V08yZFFGUXYwWlVTL1p1eEJ0M1J5dkVi?=
 =?utf-8?B?ZTE1YVdGZHZiSDZMUVhYR2c3NFJOajBCakhyQmdYYUZIZkFUdi8xSUxubHNt?=
 =?utf-8?B?aEhjSElWeUZneXRMUFlQQ0wrd1hzQjMrZUZ6T2N5clR3VlpnTjN5ZUZzSXNV?=
 =?utf-8?B?NWhjNEhOUFdJWEVPcFQrSEE5QXlzQ0oxYm5qcHJ4d01RSExoSU1NMnhETCtx?=
 =?utf-8?B?RW1YOVc3R3MyYmVYL0czdVlaYTV2QkhTVkdZMDN2YW8yUzRWdlJVUUFtWEZG?=
 =?utf-8?B?ODNFbkRBRlZndlM5KytJQkVlWGc1VzQ3TjFGbVZPK2l6SFBSai9kdEhBVTBP?=
 =?utf-8?B?SGdWcGhXaGxoQm10NmVXMlhHajhDWHZML3hWK0dvOWRsdU9WUEsyMDlSWGd0?=
 =?utf-8?B?TkJpUFhERnlkZmhnbkpPNWtQWE5YMlF6dDExdFM2WHovTDViaHE0dDZiWjhE?=
 =?utf-8?B?cGRzSzdwLy9XMWZTNWwzNW9zeUpQTnZFWGgySFY3TkF6Nyt0MUUwSkdkcTBM?=
 =?utf-8?B?S3ErbXkwQkI4QWZud01zZGlDcU1pSlkrb2JEMjNra3ZaTm9abHQ5MnVQTDkz?=
 =?utf-8?B?Nm16bExqRERuWGptT2daOUFWM3F3aHI3MXlyN2dJSFY3MU1tN3FYMDVUd3dN?=
 =?utf-8?B?dFZQbHpVRU1ISms3eUVZV0E2YW1IVkdXRm9wTXJ1cmxSbW15dEtxY2hOenpN?=
 =?utf-8?B?ZmZYbURoOHg0R3dKOTJpdEpRSkZYT3BJbTR5RVFQOUtJVnhsK2ovTkVXUkIz?=
 =?utf-8?B?aWZrNG1RSUtpZXpua0xvZm02TG9lZ2lpQzJlVXRRVVRKUnNFTlZKN01uTVpx?=
 =?utf-8?B?Qlp0cWtTelJLR3YzaHRiL3pVblNpVFhXNUV5bUpqMm5JeUd1NWZOcEllWWlO?=
 =?utf-8?B?ZHMxS0trbGJGUnl1dDhsTFlSQ05oUDRzTGxhYmJPV2tyVHBGMUZJb3BCVFBh?=
 =?utf-8?B?VnQ2aXlxN243R1dlVFV5Q1VCcjNBTmIvbDJPWFRjNnR4UDhBWFJzYjNkYnVI?=
 =?utf-8?B?Y0tjQUNPV0FrZXJnUXg0eFo0MmNFN3Azc3RHR3BOSmpHQ2RGSmF5Q2NBMzJu?=
 =?utf-8?B?RUlTazVmTjFkUk5lZ2FQUEEyMGFXNmVuMVpsV0pwdEhTU0RITlJrUyt5TUYy?=
 =?utf-8?B?TGQ0REt6a2pWbG1tYTlOMURpcHZ6K3dac200RkZnUDhRTGhyamRadEpPTHRt?=
 =?utf-8?B?TlJxSDhDc2kyUlp4OEdVSGVzMEFVUjJTYUtZWHhaRHUwQmVmMkdWaVFsbjI2?=
 =?utf-8?B?WEcvMi9HWmQ2aWJpTHhnVFB6WjRKMkdtNHpMWVQ1WG52VGpMbHFZZ291bkUv?=
 =?utf-8?B?ckowSktWTjNnMVZjMHNHRlZmMVJ4YVBNenZ2WVoxQTZ3SHNXck41MmI5SHIz?=
 =?utf-8?B?blZwajJ1TTMxN2w1WndueGZseHF0SCswVDNVZ1ErZ2crUDFIV1VhR09NSnBp?=
 =?utf-8?B?TFg2SEt0M1V2dFp6VUM2UC9sSFBSSnpOazR6aUM4dnk4d1M1NTVIU2xpdVky?=
 =?utf-8?B?di9RV3VnNmtnQUxEYnVOZC9iRU52TXlpQmJTWjk5S2RqUWlNemV5V0pEd2Jx?=
 =?utf-8?B?alVvVkFFSzlnektXV0dxQVo2WlFEVC96SzYzMlZhZzBKcytZM3p3enFCclFr?=
 =?utf-8?B?SlhNNFNLeXAxUkNZeUlnWVV5YjAzbUxpVEJsRkF6RUVPTmtYT2hUOTRyM1Zn?=
 =?utf-8?B?amlWeW8wREswQVMvVndudUJlenhzQTZlRGM1VjIrVmlCWDdDdzNmMG5Mb2hX?=
 =?utf-8?B?RjBabkk0NEJub3ZidzBiV3VQNjNiZGhtSHlPYnRQYTVWYSsvOFdOcmJmckxC?=
 =?utf-8?B?cU95UE8xaE5kcmFFQk5BVk5GeFZ2Mi9YWGlFS2lQR1RlK3BUZWdSRXZOKzRU?=
 =?utf-8?B?ZFV4ZHU4dk52cnJreWZacWdydkZlS3R2K054bklsMW1SWm5RSnN3NnpOTzQr?=
 =?utf-8?B?M25Fc041WWhxQTdBVjFuYlVCeWFJa0p6cGF4VWF3TklHbTc1b3hkWnBUTHZx?=
 =?utf-8?B?Z3hxZng0Wi9xMGk4Z1NtV2l6eDdVYnRsTW9kd0dhclBVU2hManpiZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df325c7f-9717-4c70-3125-08de830dfc84
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB8245.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 03:42:02.9035
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j/GmcMVF5b1qzi1yQov5G/2lgR7Jn6+HyabG4lkGd62lro1RTxbYk90zsPQAF04B4cAPWDSX/1JfWoAZNRtStA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8853



On 16/03/26 7:01 am, Manivannan Sadhasivam wrote:
> On Sun, Mar 15, 2026 at 07:24:48PM +0530, Manikanta Maddireddy wrote:
>>
>>
>> On 05/03/26 3:49 pm, Manivannan Sadhasivam wrote:
>>> On Tue, Mar 03, 2026 at 12:24:43PM +0530, Manikanta Maddireddy wrote:
>>>> From: Vidya Sagar <vidyas@nvidia.com>
>>>>
>>>> PERST# and CLKREQ# pinctrl settings should be applied for both Root Port
>>>> and Endpoint mode. Move pinctrl_pm_select_default_state() function call
>>>> from Root Port specific configuration function to probe().
>>>>
>>>
>>> Why should this driver care about setting default pinctrl state? Why can't it
>>> rely on the pinctrl framework as like other drivers?
>>>
>>> - Mani
>>
>> pinctrl framework doesn't know if PCIe controller is going to be configured
>> in Endpoint or Root port mode. In Root port mode PERST# signal should be
>> configured as special function IO pin(SFIO) and in Endpoint mode it should
>> be configured as general purpose IO pin(GPIO). So, PCIe driver should
>> request appropriate pinctl values.
>>
> 
> So you are saying that irrespective of board design, you can configure the
> controller in host/endpoint mode? Is it possible? Dual mode controllers are
> quite common in other SoCs, but they rely on devicetree to either configure the
> controller in host or endpoint mode.
> 
> If the devicetree enables the endpoint node, why can't it also define the
> pinctrl config?
> 
> - Mani
> 

Root Port and Endpoint role switch is through device tree only.
pinctrl settings are defined in Root Port/Endpoint device tree node, but 
to apply the pinctrl settings respective driver need to call 
pinctrl_pm_select_default_state().

arch/arm64/boot/dts/nvidia/tegra234.dtsi

                 pcie-ep@140e0000 {
                         compatible = "nvidia,tegra234-pcie-ep";
                         ...

                         pinctrl-names = "default";
                         pinctrl-0 = <&pex_rst_c10_in_state>;
                         ...
                 }

arch/arm64/boot/dts/nvidia/tegra194.dtsi
                 pcie@141a0000 {
                         compatible = "nvidia,tegra194-pcie";
                         ...

                         pinctrl-names = "default";
                         pinctrl-0 = <&pex_rst_c5_out_state>, 
<&pex_clkreq_c5_bi_dir_state>;
                         ...
                 }
- Manikanta

-- 
nvpublic

