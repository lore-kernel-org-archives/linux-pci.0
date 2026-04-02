Received: from MA0PR01CU012.outbound.protection.outlook.com (mail-southindiaazolkn19011034.outbound.protection.outlook.com [52.103.67.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98C93A4528;
	Thu,  2 Apr 2026 12:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775132816; cv=fail; b=CLl1o3YWP4PdVlPi1rBwi5pHdei2cyYsuO/+06MGt0cwM0/a7DUCsRfbqmjcijw9Hralwkx8tiZtHSCtZObJ7y8zOm84htla48sKKmu7te6E3dZA28cpag/EbPdVldPPVnDDAwihSjqVPSa5CSXrA4rF2GXZhgqB0HieMOR1kAI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775132816; c=relaxed/simple;
	bh=gz+4OkhC0y/aAX6JADn2I/yoVRc3ktnzkV2f00iYLWU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HGRGs9FbkNOQZkgb0LSE8cZOZrMgfcCfgGwvodsvlo36nMwCSPyPMOHN9wLKzNFWBJlbbESTyRRDbolv/NZwQqt+7K8jfVhfCkf5Vgn906M27V8Z30xhhCMa1DniozzsIFzFVrkcInmIw45MBQRaMor1CeaogE0Iicrzo6GcYJk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=X2oI37X/; arc=fail smtp.client-ip=52.103.67.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="X2oI37X/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j/kKN5jz2DJgWPunTsZzW4CkgZh9LgAb16xLxNFcyOxtwfwNpYfAbvNZy2u1t/kN88UuOgC6aHUHeVn9XRzt+MM1UTQHHN546yHhFxHu0s7VGCjmPll6jaOqPdKOg3SDb6A1pCNiXsiHtx4oZTA4qagSqZTljKtc+57bKKOd1EkxWwCR4gq40ODXSzenMxHLnEoAwxZBR3ASPkWK96UieKFBkyHEz34MPWenCxvZIpo26PsK2rIq4Q3xNo4mH0i/X9fERsqwULsaxM44piUxL3Mcqnnk/FUF5NeC0d57UGXELJjaIWLf6xT66WQBq5FmomR7VMMmNUB2MKR2ZT5GCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iuKRMVYH9l9O6NgkOG1ASb81cbX78sU88JhsrqoVoeg=;
 b=lJyOgeRw34dJs5bpsLb0LYGI7q4+/ioJ6jdSPetmsuKshdWKL4u6K3nV/HXfpHMZhRpaoxUncmGWwX9Xcv0oz7xvwpSw19XdKnwGv7Xgm7BVabHDFxqlWy0W5rJe1COnld/ZfiudEvITCpayyGKFnGHPVzuk1Qium/UnRJsMHqRrX1w96QXx6K590DaQvvCSz8+SnrWbgq2dG4tGF5FFoG7fLlHvzt1VnvSGLhj8iSfFFk9tqGtNt5DIXSdUkIhmaXUHyhdrhkMWdVI22U7gDIT7N3BRQnI/oLZSOLIl9oW8SZK/G8CIw9W7aAPMqSqy+iunrB2Jb+NaR5gd/BdTHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iuKRMVYH9l9O6NgkOG1ASb81cbX78sU88JhsrqoVoeg=;
 b=X2oI37X/tQcm+pTpzBaPJuBAwHsOnUDNaoSd9FNP+UNGIzlxVZ9r9tWv2YXEMOB+A62NqiMVUPSSG2U2jeG5r4izgHRYfQAy/LJBaNnseXSGiVdmp4oen7ILxeytXQdmtv3Lc1OJZWq5fplHzmRHHbaXtIJHV6FkZySmXnHtfx+PJSv3zV5aRYcpk5cBo1Vx+8m93+OcSWyySg307v8uKXoxWRyP7hYZVkfx1evT3CysPk1UnGaSovUwqtnpOVgJwidTlnVgsV59jJCX9CkRfpxJajQOTdJqCY8vQ95a9/FsWaWtdb4bvy59ZpqxtEtuvtYfxTl25dFbQ1w/1deNfQ==
Received: from MA5PR01MB12500.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1e9::18) by MAXPR01MB4327.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:3::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.18; Thu, 2 Apr
 2026 12:26:48 +0000
Received: from MA5PR01MB12500.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::8a6b:3853:1bc:67e4]) by MA5PR01MB12500.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::8a6b:3853:1bc:67e4%6]) with mapi id 15.20.9769.016; Thu, 2 Apr 2026
 12:26:48 +0000
Message-ID:
 <MA5PR01MB125004EEB0476CC599978C844FE51A@MA5PR01MB12500.INDPRD01.PROD.OUTLOOK.COM>
Date: Thu, 2 Apr 2026 20:26:42 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] PCI: sg2042: Avoid L0s and L1 on Sophgo 2042 PCIe
 Root Ports
To: Yao Zi <me@ziyao.cc>, Manivannan Sadhasivam <mani@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Siddharth Vadapalli <s-vadapalli@ti.com>, Hans Zhang <18255117159@163.com>,
 Kishon Vijay Abraham I <kishon@kernel.org>,
 Manikandan K Pillai <mpillai@cadence.com>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 Inochi Amaoto <inochiama@gmail.com>, Han Gao <rabenda.cn@gmail.com>,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260227181925.52475-1-me@ziyao.cc>
 <20260227181925.52475-3-me@ziyao.cc>
 <wykv2qz7lt3v67n3hjjqlprjbhlv7eur5wiw2reagvu2sq3dhc@4y5x2yok4kho>
 <acY9kUDAuexKy19C@pie>
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <acY9kUDAuexKy19C@pie>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR03CA0085.apcprd03.prod.outlook.com
 (2603:1096:4:7c::13) To MA5PR01MB12500.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1e9::18)
X-Microsoft-Original-Message-ID:
 <5d268df0-1d7f-4771-9b37-352b9c053889@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA5PR01MB12500:EE_|MAXPR01MB4327:EE_
X-MS-Office365-Filtering-Correlation-Id: 633feed4-bef6-4c89-c330-08de90b31c35
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|24121999003|8060799015|23021999003|25031999004|22091999003|15080799012|1474299035|5072599009|6090799003|461199028|51005399006|19110799012|440099028|3412199025|26121999003|40105399003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SlZBR3UwZzErcE1vMTB2VmNuQjJuNUZnYStoYjRqQ21taW9HK1JicC9mNUFO?=
 =?utf-8?B?Q0V2b2pwMDBMOW95V3dML2ZnQlhEMklteklMbHo4VU1MUkxvaHFJa2VHc3pO?=
 =?utf-8?B?d0w4SjVqcjZXeHI5RGlMMHpuV0hvYTNaWVdwOTJvTHQ2MzJpejQ3WkdWVDFK?=
 =?utf-8?B?VXd2VVhSeXlnMUV2ZW5ISjhTWFpINWw4VHV4WmFIVFhvRGFiSWVBc1lMMGdY?=
 =?utf-8?B?OWVWbnFqWEJ5K0xzbkZLSDg2YzVsdDJ4UnhCVGNKUUlmdlNaanROQVhEMTlN?=
 =?utf-8?B?WEhkemNUdTBieC9MTVlrMHNqMzM3RXpTVTgvN0hsWFRuNHJEUXBKdkhGOGU5?=
 =?utf-8?B?Q3hWa0lOUHVxZHhNZFFsL1FSdjN3WjA5K3NwWFlXblJOSE1KeUpBd0xDdE81?=
 =?utf-8?B?cFFoNzhPMVFhK29ZbjBTUGc3L1BFbjlrUjl1cHJUS3BLRlVDcDBDUVpWenhj?=
 =?utf-8?B?UGxUdGQvYU9ucGJMWmhkNmRtY0xmcWhVNWVVZjdreEtOTDd5ZE5rWnUyTlhE?=
 =?utf-8?B?clR5dGUvVkVVOUF4VnFXa1VvM2VLc25OTDl0VmhkSjlGeURDVU51dnBjVFpy?=
 =?utf-8?B?eG1xd3d2c3Y1cytoY0RPaDZDSG9PMTNsdk5nUWxoRkZoOUpRRVdOWHVMZTAx?=
 =?utf-8?B?SmdUQXBCY2d1ckY5NG9jVWFjYlZUVUNaNi9nYnlGbXNFaGRLOUkxZUJWTEtO?=
 =?utf-8?B?VVFCNEcyVk1PQ3pZQW13ZFdWRFRuVk14UG1TODRnNHBBZk5DcVdMTnpnc2FV?=
 =?utf-8?B?Vi9vanpBUWVrV1dHT255NEo5RlB0bndEUkNrSDdLaURUY0xjaXNwWkhzaldX?=
 =?utf-8?B?TGgwZy9WNjQwVTlBaDBvMHZHUjNwMWphaStzZjFOMGtCNHVsaGxCWGZ0Nkwy?=
 =?utf-8?B?VmRtZGVZMFhJWWVvdzNXQk1EbldzS0k1NCtCem16b0s4UTZVTmIyQzhZTlFE?=
 =?utf-8?B?R2dUcDhCVERuUlB0WE9YLzZ0WXR1V1dGMU9JN3VYWFVlR2VVdWpsUzFUSnNq?=
 =?utf-8?B?Z0lWbG9vb1pUbnVSNGQ1bXRnVUdwRmRPdDN6dHNZbFVxNGI0RTh1ZVUyZUpL?=
 =?utf-8?B?L3E2bkxBR25mMzhTMFlyMFh2Wmt5cVpPRUtoN0JpaWU0RzQxdFVQckNFWC9a?=
 =?utf-8?B?WEhnNmVEQnJqWFRJUytXdE4xVVpQa0xNU2dLaTNvTjc3c1IvUGlrbnNidklQ?=
 =?utf-8?B?QVlrNElKVzVRREZnWWNqWjgrZU1YOUp3ZVBIM3dCV2xYbU81TzBYaHE0a1Bi?=
 =?utf-8?B?TUwxZktBcEV3enBaaHYzQm15RDgzUzhkcTJtTUl4aW1KMkgwb2dtKzZGTzdo?=
 =?utf-8?B?TkpuR3U2U1hNMDRlbWExTTVteHU3OHBhd1hQSzlDMHoyWVJ3S2d2THVUOTR5?=
 =?utf-8?B?TmVtQjJpWWJTVlJ1d0Y5c01PbmlSVm9aZng0d2FtUmhoVTdEZ3NyczZCejla?=
 =?utf-8?B?ZWpmK0xMTUVnOURpenZraU5Oc0xNcmM0ZEdVTDJRPT0=?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eUVYZXJoM3Nua0F6MnhvWjZGY3lZYnBKN1JJYnM4VDNscVppdFVrM1ZISHpt?=
 =?utf-8?B?U2dQNUh1ZUVwTTkydms1cC84bmJyb0gwbkxmTVhQL2VVMzhEMjcvRUNmT1p4?=
 =?utf-8?B?REhsclVpVHRzaElCbEE2WHE3WGVrR3JTVERHZGlnbGtJeVJUaERZTFRXSitT?=
 =?utf-8?B?dmY4TE44TFFPWUh1TWFvM3lsdGdFbE93TlFLa2dPb1JzclNQQnc5RUs2U3g1?=
 =?utf-8?B?a2FrbURjMWY4cWZDd2dJeDY5c2IyUW5KMHQ1cmFrVENXTS84bFBxb3lXSlY1?=
 =?utf-8?B?bFY5Q0E3Mituc1U0WTRaS29Ebmc3UEN3bjROVTJDRFBWeGtoaCtrME9wd1pB?=
 =?utf-8?B?MXNKVm9udmNOUWsrYkxIeFdzSXUwaEJZNjRzMmFEUGtjajIxUEFCZWpGYlRh?=
 =?utf-8?B?azhJem9kVE9NYTkyRytIdVR3eDhpeWNwNHd5MlV3dGd6QlQ2ZkF6WnpHT3BO?=
 =?utf-8?B?emRXWjYyTDBxdHhoUlV4cjM2VXJKc3R5WFlUYThJZ3I0U0xFQmZQcVl1WjVx?=
 =?utf-8?B?OXBmd0RYK3NGUlVBMUFxaGdPRlBsYytLclFWZmpiai9nbldqenR3NEg0emE5?=
 =?utf-8?B?anFXMkRHSWFmbnVoNzBsMldYaUx3dmVIckt1QlpWQ3k4Y1ZJWHQwb2NlNVRz?=
 =?utf-8?B?REVUWnRwRnBvWHJxTVd0c0lmZldBYmx1SmRMZ1ZWSFg3M240dTRJWldFRGxJ?=
 =?utf-8?B?VWw1M28xd09xTGRBZzlxc1d6Mzk2UXlSMVBvZ3JZYklETGpNbFYxa0NWaXdQ?=
 =?utf-8?B?bUM0MHBEYlg2UEU0Q0k1di9MZGk2YVBUaW1Ya0xsRm5lNy9MbGp2cExqMG1x?=
 =?utf-8?B?U1ZNRmxVR1cwYUZ5eGFCUEd3ZXdMNXpuZDBuVDJEbEh3T29xVk85SVFueXZr?=
 =?utf-8?B?NGhsYzhxOWhKM1B6eENDRzNrOEtzZlhsUGZPbzg2WUhzUHQ4ZEZIQ0tOZncv?=
 =?utf-8?B?alR6d2JKa3ZQYXFoSHFjeWw3eVBMdnRGaTB5TzZZUlViZ2VwSTNmdkQ0VXpY?=
 =?utf-8?B?N2lLSld4NU5wK3JNaXBNNk95c0pIL0Rtb2QyRUVoQlYxV0g3eC9lYTIxNnVK?=
 =?utf-8?B?bzAweDNnSGx0OVBBdU95czNzT1V6ZjA1MW5nYkQvTEw2VUVpNlVuNFl4S05K?=
 =?utf-8?B?OStKTmxqL2lsNnltanBVSEdKR1FjRnpHNnllNkdaaVhXUUErSnRCdGZINWFx?=
 =?utf-8?B?RU1MbnVBbjM0U00rTFpXNDh0TzBjaksydm52WDJpR0g0MGM5SnA5Qk93Q2Iw?=
 =?utf-8?B?NGtsTFplVjlLVXlGeE5UdGVXVzZpd0xvblBOMzl3OUgxRG5wSmE2alJqT29J?=
 =?utf-8?B?ZkpIWHBTU0ZxNFN4NU8wbGxRVXZSSTlkdTNBbE94TVplY015ZDRDYjBwUllX?=
 =?utf-8?B?NzNZZ2JSUi9jR2xGUFNNWXlHZGVNWWxxaGM3Nm84T09wcXAwNU4vVkxRYVIv?=
 =?utf-8?B?QlVYYStHQ00vM1BzeHJYaTgvYzJSQSt3MnFCbkdBU0REL3NVTUtldlA5ZFFi?=
 =?utf-8?B?WlJUcDBFT0d6R0ZxMVFySEs3em9MRisyNDUxdUc3NHBaVmpvakZjYnViZzVE?=
 =?utf-8?B?SXJRK2FUeU5hQVNjelRQVlV3a2h6OExic09ZY2Q4c3N0MW5XSng1aC9GVDBC?=
 =?utf-8?B?VkNFTjR6RkpMVG5IcjNhZGJkNytOQ0FIWStzNjFkaUN5UEsrQ3FMREdVOGNj?=
 =?utf-8?B?TlRiTGViSjBiVnpvL3c0WGxIWXJqUlgrUWkwQVdmSnZtODZhR0RudmdJVXBj?=
 =?utf-8?B?QVl3YldZdDlwVENmNzdRY0labEpVOStRRnZqd1BCdXJKZUZjbWc2V3pPSDV1?=
 =?utf-8?B?UDZ6TmpYNmhDUjB1Z2NRMjJxcnhmUEdtc2hJYmtnRVRvVDNBWWloNk1Cb0Ir?=
 =?utf-8?B?eC9uK2VGYi9ZZm52bWxLY1N2SUZialBXdzdVQWpqZEFWY2J4ZDU4bmZhaWhL?=
 =?utf-8?Q?YOAIPXcb+K+We3E1Oz01B0VarEOWXP5p?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 633feed4-bef6-4c89-c330-08de90b31c35
X-MS-Exchange-CrossTenant-AuthSource: MA5PR01MB12500.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 12:26:48.2187
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MAXPR01MB4327


On 3/27/2026 4:19 PM, Yao Zi wrote:
> On Thu, Mar 26, 2026 at 10:15:16PM +0530, Manivannan Sadhasivam wrote:
>> On Fri, Feb 27, 2026 at 06:19:25PM +0000, Yao Zi wrote:
>>> Since commit f3ac2ff14834 ("PCI/ASPM: Enable all ClockPM and ASPM
>>> states for devicetree platforms") force enable ASPM on all device tree
>>> platform, the SG2042 root port breaks as it advertises L0s and L1
>>> capabilities without supporting it.
>>>
>>> Provide a platform-specific initialization hook to override the L0s and
>>> L1 support advertised in LNKCAP register of SG2042 Root Ports, so it
>>> doesn't try to enable those states.
>>>
>>> Fixes: 4e27aca4881a ("riscv: sophgo: dts: add PCIe controllers for SG2042")
>>> Co-authored-by: Inochi Amaoto <inochiama@gmail.com>
>>> Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
>>> Signed-off-by: Yao Zi <me@ziyao.cc>
>>> ---
>>>   drivers/pci/controller/cadence/pcie-sg2042.c | 20 ++++++++++++++++++++
>>>   1 file changed, 20 insertions(+)
>>>
>>> diff --git a/drivers/pci/controller/cadence/pcie-sg2042.c b/drivers/pci/controller/cadence/pcie-sg2042.c
>>> index 0c50c74d03ee..3142f82bd393 100644
>>> --- a/drivers/pci/controller/cadence/pcie-sg2042.c
>>> +++ b/drivers/pci/controller/cadence/pcie-sg2042.c
>>> @@ -32,6 +32,25 @@ static struct pci_ops sg2042_pcie_child_ops = {
>>>   	.write		= pci_generic_config_write,
>>>   };
>>>   
>>> +static int sg2042_pcie_disable_l0s_l1(struct cdns_pcie_rc *rc)
>>> +{
>>> +	struct cdns_pcie *pcie = &rc->pcie;
>>> +	u32 pcie_lnkcap_off;
>>> +	u32 lnkcap;
>>> +
>>> +	pcie_lnkcap_off = CDNS_PCIE_RP_CAP_OFFSET + PCI_EXP_LNKCAP;
>>> +
>>> +	lnkcap = cdns_pcie_rp_readw(pcie, pcie_lnkcap_off);
>>> +	lnkcap &= ~PCI_EXP_LNKCAP_ASPMS;
>>> +	cdns_pcie_rp_writew(pcie, pcie_lnkcap_off, lnkcap);
>>> +
>> cadence-host driver already has cdns_pcie_host_init_root_port() to initialize
>> the Root Port. Since your intention is to modify the LNKCAP field, which belongs
>> to the Root Port, you should do that in cdns_pcie_host_init_root_port() instead.
>> I see no sg2042 specific registers used in this patch, so just set a flag in
>> this driver like 'broken_aspm' and clear PCI_EXP_LNKCAP_ASPMS if set in
>> cdns_pcie_host_init_root_port().
> Okay, it makes sense. Will do it in v3.

Keep it up, Yao :) I'm looking forward to your v3!

Chen

>> - Mani
>>
>> -- 
>> மணிவண்ணன் சதாசிவம்
> Regards,
> Yao Zi
