Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010049.outbound.protection.outlook.com [52.101.46.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B23386548;
	Tue,  3 Mar 2026 07:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772522472; cv=fail; b=ONXZUtSyELj15XB4eSSWcjCLH5VqZrYNXpELDk46feXYfeizBQtLaysHohrxxyMIWfIPd/DnKaZ9GUn5hCHLC8LY/kS9Q/tR+hKUztaQVff5Ty6b3cKy0d9zEuj5G40EXXholKvyTaZPz1DgKA3+7VTgP3JsQlT7HdF/glAKJz0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772522472; c=relaxed/simple;
	bh=oGDixn+kP+NKlej2Fg5xbKeXDzV5G60CY01tn0PikOU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=piOL7KXOi227lqu2G2WVzkwqcBO/Le5hODXfozriM4glVuXYYhlcrzh+bVZENF9t2D0o1xatFIfH/Bgz8dKnuZdymsdYmTrWg7np4bcr1KQMNowvYzjjnWkHQj91FCy5aNSOwUB8e0POc0K4YArE4xldC3CF6YWjE6gFksQiVh0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XNC4jXRL; arc=fail smtp.client-ip=52.101.46.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XNC4jXRL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QyA74XoqwGwEHG1uL8kZ0tljKxzUzq+hFTAmqJhDzhvQK9FqLCmvCzAVllNumiQpyRNLZI8ViKizCUr8PUe4kJX9bp1qq20t2fnVmj6+mILxMelpxgh7/ZcG8hs7j3MUfwUl6sXZNp4qZ0dv2QZVmQxnKnnn4x0H9JqSN9AbWcxeFVwcCWULsLRiewE5aPk4q2unwFLPw0PXYCX8S/wUzECxzrWymZx9eCkzxd3642Z6qva31vLSFnyKdMD5LQitszF01AXzRLY+YEGcKsGBaFzsI2LvHr/pSUtIPNClNIOJkBHNDpwm2BV+2/IP4delqwPav+E6DkvXewOFXcMOZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m2mqD33/v05IO4vA5lT8vpjXoGq5mqBT3t94GL9DO4Y=;
 b=P7KmytM7eVbhCYTt/NOvdz/lY/1JXeJmqYzdM9ptBhL68Wvfelahf+Zszfv3DDN6L4Qn3hwUPquk0PZbi3qOcV+4rt3cwWvOeca54jw3j4jCxwlpjaYXqCNMRJTptIeE0qwjeYtN4DkIR4E6xIErLURD/MOoOVLiJiollO8C9Q6O+oxhWwmFZWGm+i+QJlLSHvid7LTKaDKnq8B8RzGWrySthDZ+cj2ZgII3Gcas/pKx3/K7LNrqiNErzLr+OsNEY7ZW7e/0kSEMiRSJefkbTtnoNz/C4b+ce1Pk4rI8DLJbQN0pRWSS2fbEgyI1aiQifFVFLhoWibIlHnuwR5M+mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m2mqD33/v05IO4vA5lT8vpjXoGq5mqBT3t94GL9DO4Y=;
 b=XNC4jXRLdfcZGktatKwgryGokE9UCmzPaJt8ixrct8iEkLOua6qM3FKVv6LhZulydzGlEotxP5PLfdurljW6c9oeFNuTwQkNgjrgO1EebH4ckgb5JIBqksVx1/3eq832E1Zro4qPnHCqu88w749h5U/YyLtDQu4OCg6xrZ9XhoLFt5OwhO1xy7q5SriHHUKX7uqaaRq4Z24uTBiYzRAflUBJJ2cgtAjQfKHKV7zTx9+8qaHTR6xK4zXxyoisMtzEu8ew9RhCmEQoEbOwCDFzz3c1NKd3MEUmEJzx0aGtyF0a5YWWMsOlKgJ9wSOWC2HtYnr6h5TEk90f+H7IOrXzXQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB8245.namprd12.prod.outlook.com (2603:10b6:8:f2::16) by
 IA0PR12MB8696.namprd12.prod.outlook.com (2603:10b6:208:48f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.20; Tue, 3 Mar
 2026 07:21:03 +0000
Received: from DS0PR12MB8245.namprd12.prod.outlook.com
 ([fe80::e7c5:cfca:a597:7fa4]) by DS0PR12MB8245.namprd12.prod.outlook.com
 ([fe80::e7c5:cfca:a597:7fa4%4]) with mapi id 15.20.9654.020; Tue, 3 Mar 2026
 07:21:03 +0000
Message-ID: <6e39e34c-e35d-4410-9d14-2c1db8dde190@nvidia.com>
Date: Tue, 3 Mar 2026 12:49:30 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] PCI: tegra194: Make BAR0 programmable and remove 1MB
 size limit
To: Niklas Cassel <cassel@kernel.org>
Cc: "bhelgaas@google.com" <bhelgaas@google.com>,
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
 Vidya Sagar <vidyas@nvidia.com>, "18255117159@163.com"
 <18255117159@163.com>, "linux-pci@vger.kernel.org"
 <linux-pci@vger.kernel.org>,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20260222193456.2460963-1-mmaddireddy@nvidia.com>
 <20260222193456.2460963-3-mmaddireddy@nvidia.com> <aZ8x80iu6p7XBD2W@ryzen>
Content-Language: en-US
X-Nvconfidentiality: public
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
In-Reply-To: <aZ8x80iu6p7XBD2W@ryzen>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0129.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1d5::15) To DS0PR12MB8245.namprd12.prod.outlook.com
 (2603:10b6:8:f2::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB8245:EE_|IA0PR12MB8696:EE_
X-MS-Office365-Filtering-Correlation-Id: ef3c5720-4aa3-43bb-3b25-08de78f56d36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	S5Y0p9AqEuY9P9F92k2s/rhIhKvkZPuOITTrGTuPM6Bfcpb00GbFc/U7+90auvPhLbYnoQEjTlM7eMPdutJZAHcdmV8sNDOYMdlCtle/tyY4lQhEEoc9IWnKzQAjJgEyNL1PgRLhClHL8ZuniKgrjavhcnw2Hu4mQaTge2avpYtSXin0bqlznrkejeASXwgdo4L6qlAkb5Lnht8fiYlj9c0d0z3uSql2mwCsfQy/4R+F1TDWm3O55VD8NiiwgXdaKAfGPjMYwl0e3c5dZZA2ucJI4iv7Il75LJn6C12GF9MNjfSvPxVF0rA07vssyFewy6xvbpOkKc0sgTABdVzupFZflS1H4g1Ngnno+WaxGHkACaciZSfeSx7Xx2gg7J0F0jMWM//ju4EuFm+Gp/y28FVGptYZsF8Q6cE1gPVStZQr2yX4ogocAkPALg2DlrYK0Ub6Z2L6QRUqDg89Irj+tpDV8oCRjZmwdCcKNq7DdRWFAzTIJwsqaGtuduYs2XTaLs/cOb0i19P1IGu7Ho9Mle6YJLlE7ySCyKqd58SfjGi20byEgfj2RdQTnbHZzjHGUdzWtq80Db4sKPOmVv3stjPUug+/j+ChZdomf0twKvBRv1Gl8aGap2reQNUHRaO5YbaVYAjHmb/VPXZebaFUguV5ChgpcZyEHUxsJWjFQ83Cz8uOWgKu8R5s7TyXFUDqCJtQUMfIAL5npbC19qVMSKvv037xT4zf5BLyosnDNcI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB8245.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?KzVaT3Z3d3pQV2FkcUowWWRNdHlHUlRSWjd1WTFoQ1RPeWgyQU51bkhJTUpN?=
 =?utf-8?B?NWloQW51Mk84SExIanBnZnpONmNkY2Vud0RVR2JiTlIrM3J6UC9LNWtKOFMw?=
 =?utf-8?B?MlNBbnRwZDk5c3FucVpPVzFsR2hWcXp0NXFnQ21UcGc4WWhDMUw1d2JTLzIr?=
 =?utf-8?B?clQ3ZStQUnJLMWkzUGZRcFRoT3dZYitTUXRTUXlvUUh5Smh3enBHaTlLOEd5?=
 =?utf-8?B?UXlLL0pkQy90Rk00QmE2d2cxYTQ5SnU1V2tyU2JFVDhDRHBaTzNmZUlWMGx0?=
 =?utf-8?B?ZEk1TjVNbm5LRGliY0diejRaNXV6TndFZTQyTEIxOHBkYkhBeXVvai9xTXFJ?=
 =?utf-8?B?SXp5dXNIOVArbDRuVVpoWXA0K3pNZ1VIZnV4QUpqUjdHYUFMZDJ6NjNBdHBT?=
 =?utf-8?B?QitBc2V1UXF1ZFdQQTRyU3dlbktHYjFVNFUwbDdLdGpjM25tNEVGcWJ0amcw?=
 =?utf-8?B?SHdNT1g3elVyZHhYcWJZeHd3eVJib3VjVDJwNGU3TkltUnN2aTVlemx3dVB4?=
 =?utf-8?B?WVFxR09qamw4RUFHaE1QYWh0NUNBd2JZSkp5Y0lGcnNjL1E4NnJkdGxGbm9T?=
 =?utf-8?B?dXZOL05VaGY1d1FOYnZZR2NtK0c3WkVXR1RmSnkvMEhTT2NuSzlGRnBwREsr?=
 =?utf-8?B?anZ4eklYKzRTczdIbFZsWGtndTRUWWQ1UHJJVXIwTUpDVUJGRFBMeGFlSjNN?=
 =?utf-8?B?SUtXUjhHdzV2MGFzNmtJeTRDbVErSkxDNG56bVgwSHlDUmNLa29ZL1ZsU3FL?=
 =?utf-8?B?bzFhUDRHemN6azRPUUFoTzgyRnhYRVlKVVE3V0t0QzhxUzEzOUFweHlZTVVN?=
 =?utf-8?B?VjAwRTRoM3MxU0RtVm5lRmxSYmdmdS8yWnRkUWpTbHJRcDdkbCtWZGVpRFh3?=
 =?utf-8?B?U0hNQ0syQ1JEbUVPbEVNK3poWnNWeHFjcHo1d3ZHaWJjRnY3THZWV2NGQVdG?=
 =?utf-8?B?OEFRRGt0bDJnTVRwVUtiaTdIOTNuV1g2Z3NRRXVlQkQyNkFsR0UvREoreDRy?=
 =?utf-8?B?NkxmNUh4ZWlOS0RnalkxckxBZGRxMG9PRlc5dGkxdEREZkp5aFMzcElxS1Fp?=
 =?utf-8?B?T1V0SDJoUERYejdZdnVhUVZ6bHREeXFtMzIzNVNOUWsxWU15RTBLdnIvM1pC?=
 =?utf-8?B?VmdUZUdxRGFDVy9FdGFPM21lSHJwVGlwNENibGN6TkFrU1BIVnZ6elFkL0lI?=
 =?utf-8?B?MlVyUXVHS2FZRVYrZTlFUVI1akhqR3hTakVqMVNGTVhscGxvZmNidWVPREdH?=
 =?utf-8?B?UEplUUdSMVlGRFo5UGtxOWVqR1dSOC9uQnQ3ZEhSeDVEV3JFWWxsV3VsNHlG?=
 =?utf-8?B?ZXU4WTJBbXlqOGF3RU5nTk4xcUMvU2VKWi9XZXhCa3p0dms4UnB1YThKSDJF?=
 =?utf-8?B?RENCWHJVQlRiZU1QL3RmdndPcjc3ZEJodmJZdXROYmd4NjhINGJOenVsMkRv?=
 =?utf-8?B?U3dqMTdPQy91YkNIL2wxY0l0Q1Ruc0daYlA1T2FpVzNTVjFwWmVRZU9lMFpr?=
 =?utf-8?B?L2tWMzN0MlRwcjNMK0FiVmFTOFRQMGlsd3k4MGFBYnM0eFNKTjZWVE1sSEpK?=
 =?utf-8?B?Y0xIZUVSUWRwSXJkV0FlV3ZybHY0amxEeXJ2cDNISFJVelIzQy9XaDZLaDcr?=
 =?utf-8?B?cUdoOSt1Z2IycjNJelFIS0s2dTNEbkhRS1lPTGZhcEFCbmV0d2ZsTE5EdUdG?=
 =?utf-8?B?UmFhM2ZFR01rdWJiMUxML256VjZoOUxORGVyRlN4blIxZFRLMzdiSjg2V0NC?=
 =?utf-8?B?Vnp0SXY4SkJNVlJKd3VTODBGT1hsOTl6VjB4ejRTOXZ0ZFg0UjF5Zm9IVlRH?=
 =?utf-8?B?dGM2S1ZQbnNkejBzWjYyTEVWVnVvRm5LTDUvS1JBRHY1SE9vUmNWbGttRUhn?=
 =?utf-8?B?d1VSeE9wQVFhUWVEMEpRU0FoNjdTR045RURleVM3SzM3K0haZFpKZXhqZUh5?=
 =?utf-8?B?a1I0SXU2TTI5cGdpL3JuN3dseFlYTlBUWlNyRVZxd050UjdodDFQQ3lPRlB0?=
 =?utf-8?B?dWJ3UjVCZm80ekw2Vlp4aG9BeXRUSyt4SEJkZ1pJWW5pQmpkRU8veUlKVXpM?=
 =?utf-8?B?Q3RIYkZRWnVqZUtaaTgvTGEyV1BXczl6QmI2YUlUVWxvVytmb3oxOER1elp0?=
 =?utf-8?B?NEV3V0pkcWNpdnFTbzRqM3FielJJQU52OWxPWFhXU3hJUnJBNENOWENYMGxB?=
 =?utf-8?B?cjdJQmRHeUJHbHJuemR0cnBnQk5BNkhsNFZBVTZLMEhEVDNNTGtIeFhvZXBS?=
 =?utf-8?B?MVFySVlINkwxOU40T2VGTWFtSmZDNHZyeFU4L2ovRzJKdzBOcFFWVTN0T3o3?=
 =?utf-8?B?d2QvMm0zRExBaFZsT1dMMk5jMVhtd0RBR25lRktUaGwyQU8zclA2bkUybWJy?=
 =?utf-8?Q?LzMXMvsUUOCeXQrM=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef3c5720-4aa3-43bb-3b25-08de78f56d36
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB8245.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 07:21:02.8965
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J4XBeozQVowfA8AOBJ8RSseVahDwlY5UYdIlmszySDQi3SM7UqV8BvYo5RKiu5Tl2lPsN6RZwlPRi964gRAqvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8696



On 25/02/26 11:01 pm, Niklas Cassel wrote:
> On Mon, Feb 23, 2026 at 01:04:54AM +0530, Manikanta Maddireddy wrote:
>> BAR0 is capable of supporting various sizes via DBI2 BAR registers
>> programmed in dw_pcie_ep_set_bar_programmable(). Remove the 1MB fixed
>> size from pci_epc_features and set the BAR type to BAR_PROGRAMMABLE.
>>
>> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
>> ---
>>   drivers/pci/controller/dwc/pcie-tegra194.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
>> index 4a3b50322204..3c84a230dc79 100644
>> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
>> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
>> @@ -2000,11 +2000,11 @@ static int tegra_pcie_ep_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
>>   	return 0;
>>   }
>>   
>> +/* Tegra EP: BAR0 = 64-bit programmable BAR */
>>   static const struct pci_epc_features tegra_pcie_epc_features = {
>>   	.linkup_notifier = true,
>>   	.msi_capable = true,
>> -	.bar[BAR_0] = { .type = BAR_FIXED, .fixed_size = SZ_1M,
>> -			.only_64bit = true, },
>> +	.bar[BAR_0] = { .type = BAR_PROGRAMMABLE, .only_64bit = true, },
> 
> If BAR_PROGRAMMABLE, you don't strictly need .type at all, as
> BAR_PROGRAMMABLE is (and has always been) the default, defined as value 0.
> (So you could simply drop .type from the initializer.)
> 
> 
> 
> Are you sure that the BAR is Programmable and not Resizable though?

Yes, Tegra194 PCIe doesn't support Resizable BAR capability.
However, during Endpoint initialization, EPF driver can set
desired BAR0 size once. I will update the commit message
with this explanation.

Thanks,
Manikanta

> Because historically, a lot of BARs were defined as Fixed size BARs with
> size 1 MB, because there was no Resizable BAR support yet
> (the minimum size of a Resizable BAR is 1 MB).
> 
> See e.g.:
> 6a6b66f7e607 ("PCI: keystone: Describe Resizable BARs as Resizable BARs")
> aba2b17810d7 ("PCI: dw-rockchip: Describe Resizable BARs as Resizable BARs")
> 
> 
> One easy way to check this is to just do (on the host side):
> 
> # lspci -s 0000:01:00.0  -vvv | grep Resizable
>          Capabilities: [2e8 v1] Physical Resizable BAR
> 
> Here you see e.g. that RK3588 based EP implements the "Physical Resizable BAR"
> capability.
> (Replace 0000:01:00.0 with the BDF of your Tegra based EP.)
> 
> 
> Kind regards,
> Niklas
> 

-- 
nvpublic

