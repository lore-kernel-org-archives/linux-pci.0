Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012010.outbound.protection.outlook.com [52.101.43.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2538829B8D0;
	Sun, 15 Mar 2026 14:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773584228; cv=fail; b=jbcN4WGXo7FijMDYPNfRCBlM2LO6rxN/6+HV6Bsnjoaq5rdt3ce3bbH2PPdAFGRTFe3cpI2n3SMxa9dGoKMTNmUJDZObz99c25Pg+WW+tLKa9P1X/P6AJATdfaVmwtYGHtaDSUPXTLR2ViqUIBv3T3HNnvu8HH0J0cH5rxhiA2o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773584228; c=relaxed/simple;
	bh=TQfb/mmDSNGa0j/MdCOAmwzi6lFRvdpD6IIVzLS+5vM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DosTxLkDlVBBTDfpUeNtJzOgKlbEwP/2i0vbyN6xThWwxabqa/UQRifZXN9123lWRYUFyNm2NGag9+UFkhlJMH+fgXHoxirR7yv9jAhjzOUSDtOEeb4SYIibcV+GhoAXL7vgkASqi8bcnTFkPp/Zc58J8O534hmo8M8a5XoYLOc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Q+B67ys6; arc=fail smtp.client-ip=52.101.43.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Q+B67ys6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WmW3BiAl8/oQ0XzdkBtRBb/AIOWDkgrZZkmqcpxDrqbLtDSrwFujmEss3gO0eL2IMV2/F1x4B98TxjBGJ9bzR8repYGAlRvb1uRGavAOz2NBmw7iNzD64pgSU5dRQ6IiHaaxKfnbRnHMmKpgP7f+Knc/yOe+l9sJoP2Hhu034d90oaeLIqh3IAA2hWxU6sSQ0Fy85BtfC3KGkOoBTq1SY5UP1mss4iM5QxvMKUonXiy/LM31lVJfd/MMaW86ZUYZCG5OuDwj+FuWtGigxl/VpExqxgFKo3DzH58SzYQrX6q/WTa2mLz7c8Ayhai0Ep3bXjH5I17qMzBSoA4GeDYhqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OxAaJ4l6f10Bv7/8q+W7HnGxObaiNO9C8yRu701OZKo=;
 b=b/0GrS/BrJ0aDNeifQZ1LD+vTTWDO7mNafuXIWGFZTGIu5xjC097e9hi5XBHDSKiVNLTYNjQ/DewGyAOac2QwPLFgIzYhxZL5+O9t4ySXdBXxlu1PxIb6Oh1X/YoIcVDddisLP2ASHHpLLPoUc8iaVu8WgZojsWM9DEjgwgS4msgC1xr9l8SwR/rnYXNgjOFQex6F9CS/xroHb+SStIp/RdSg47z9I7rQuTNILQ0wF/zI/vabvZ+unI+A82IJT1CnPWtzQz4hcvwKUlMDQYI41y23NnwWWD9jgxKZSpqTemXXYHM7vXda4FrbLtlRJQH6jO8b0s5BM0Y0kejc4p6OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OxAaJ4l6f10Bv7/8q+W7HnGxObaiNO9C8yRu701OZKo=;
 b=Q+B67ys6k/NggZh8nWRl6EUbZFl1O/ZAsjts0xacZHcfKLN1RulGWTJq0sPH2Y+/uWnwN3j+hmliXeMrtz4vgFnQDy/GUb9SI/3c/OJ9SI4naE4QeKTQ9zaDdE5FGdmhbTunHZqpSqbZrmvTFHp14XhKWt7GaaNiynItE767v0RaRhsXMDJsZR1cc7kDscWSwQT2QgrPZLkr9l2HWB5jQCORI9EMxUt75gE4oIdy55dCcbraMvXDA1lt4EdlvBRW/CGUDI2ahSxdZy94TwI+M7IUSG2VUCTMYqcxml2UqzBQ05hVvghLoPs7QNQNSIxAmZNgXSKmYU1yAB5cdyH7YQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB8245.namprd12.prod.outlook.com (2603:10b6:8:f2::16) by
 PH0PR12MB7861.namprd12.prod.outlook.com (2603:10b6:510:26e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.16; Sun, 15 Mar
 2026 14:17:02 +0000
Received: from DS0PR12MB8245.namprd12.prod.outlook.com
 ([fe80::e7c5:cfca:a597:7fa4]) by DS0PR12MB8245.namprd12.prod.outlook.com
 ([fe80::e7c5:cfca:a597:7fa4%4]) with mapi id 15.20.9723.014; Sun, 15 Mar 2026
 14:17:02 +0000
Message-ID: <78c52693-daa9-4a47-8c9d-bb3f4734c293@nvidia.com>
Date: Sun, 15 Mar 2026 19:46:49 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 13/13] PCI: tegra194: Free resources during controller
 deinitialization
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
 <20260303065448.2361488-14-mmaddireddy@nvidia.com>
 <bbv5jceuy7vj6t6h6ncxfaxgmrb4acuhzkazinwhyf2zru7pvi@f7maptqx6jqr>
Content-Language: en-US
X-Nvconfidentiality: public
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
In-Reply-To: <bbv5jceuy7vj6t6h6ncxfaxgmrb4acuhzkazinwhyf2zru7pvi@f7maptqx6jqr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0175.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1af::6) To DS0PR12MB8245.namprd12.prod.outlook.com
 (2603:10b6:8:f2::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB8245:EE_|PH0PR12MB7861:EE_
X-MS-Office365-Filtering-Correlation-Id: 330c3c28-f54b-40fd-d860-08de829d8700
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	pctaYJ0ZepWfj+rAJ4Go6Oss33Dx70FC3tgoQFfewF5T9T3U7X1LL+EzUYzCmDUickoqS89Qr9S6UCWIXODHyRt7va9NSCodyXdUmPvUAnz/YWZVvZ/91ykh8OxdIKF3mgxJYwHChZfSylu+WGLRfQM3vk36g1f1NlJxCjlB3a/jHZe33ZiV5FjNLl8hwKN1H0HChqxWDD7/0y88ZxfCRWa9T4i7aIRhgX2dsVnGwuaxhc7xu6HCKYsKLj+cOAtEbXGJjKgoFD1VtYCs5FVDH/kFp4wh1SmvY0jYtBAlc2A1IU++jS7yglJ6n1/DkbN7U8cEgD/3IjH2Es+NfeLnAhS/hH44srLJCE+61Ng30/fX7p9k7iBIQAjNZ732y9ldXF7PqyJniiadQSY4cW8mpGZB0EaPJNJa4yrIPtxVmWKvbAxCqSr5RWgVGXi5yOrqZ0YXEIodwV/hWS7n7sjKn/JNyIWtJua/g7f9Cgb7ua9g3dcHU9V5UAYKYCBdLO0mskoYyiXF3p1OFAkQMorPyxfH1D4U6diDg4FDtb7FgiyWbphlWxkKh4OcR874McMqEEzq1AgS+0JNYk9HY21eoHPxX6hsXDyiGZrpmg952B0ZMvg9MT1LQmD/D6C6CJ5RDQi0gxiWPMELpiPY4uaNiJuFZ4hSJ+cAo5fAVJKwifgW1TZkJaiwyOqr+4Az4wc3o4HZl/aDinu3Kk0SHSF25T+W4QUmwB3rwNq+m0xnItI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB8245.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?KzRUUFBqSkczTkhhVHJydWY3SVIwUzR2Tnp1UzNMRnJScXZSRGZmZi90M0FF?=
 =?utf-8?B?aHJoaWd5WHk1amlQUk5YVFVrSkRyYSszSkFUajIxYittbjA1bmZOQmI3dGQ5?=
 =?utf-8?B?aWtjWkNKWUZBNVc4MnBtY3lvL2RmVmE4OEV3WUtOSFIrUkxOckdRZTl0cDhs?=
 =?utf-8?B?UHpjTFRrdUYxaERCTmpycnRBcTIwZXh6RVM1V2I0SkIwNm9LWk9HK0pXVmlM?=
 =?utf-8?B?UW15OENHQVEvTEE0OVFDbFNPTnhTa2l6cFNhbGt4cUN2d285M2Y4MWxvbFVr?=
 =?utf-8?B?dGk0bGN4cmxOY202OU9TdG9yS2N4RkUwZDFIcHdDNWJjMnZCMUtGNWJTYkxL?=
 =?utf-8?B?bWlxM3ZJRUtjRG9LVnF5QWpySlJ5YzZVOGtQY2FKMklKejFSSW5zMytjcnFw?=
 =?utf-8?B?OVpYL2Jja3VBaHpEbGd0cHh3NlRrdEgzQk1WTWxnK1pEU1FtcWJLZDQzRlpV?=
 =?utf-8?B?MjNIaFhKWkl3M1NiUFdXYlpWL29JdzZCQmFvQnZWL2s1Q2M2cnk2eE83aU1V?=
 =?utf-8?B?a3JUeHBNYkUvc1ExNnAzK1Vrb1JFaCtTR3U3OFpGTmlLckk5UGYwQWRENEFU?=
 =?utf-8?B?ZVFrRXpwUkpsOTIzeUlqWUFVdVhCYjJOSVZxOUhob1V0VVdQNmQrelIxWnJZ?=
 =?utf-8?B?UWlXOW10SWU5cERnU2hEOXhwWURHQ09sSTJUTE5TdXFwWW1IYi9pMkoxZ2lG?=
 =?utf-8?B?djFac1NqS0xOcjdoNWlXQU03TVZHZTZpVUlUWjEwUHZaZ3NJNWNUSUFrTkI2?=
 =?utf-8?B?ZnpqdFlzWjdsWFdXTXFHcGRNZmVpbHA0MkZ6bDBudDNXY08wdGp3VUFkZkVS?=
 =?utf-8?B?SWpmOUFNdTZjMk9oZ01WbnJjM1cwY1FlY1k1WExKWUkxbGVzNGQ5TUNuWmdN?=
 =?utf-8?B?bWlSMDJhTGZFc3Z4UE5OMTNDUE5uNzdKQWhmNnE1ZTB5aVZqNCtjZk1uYUZQ?=
 =?utf-8?B?aVVrdjFaS0lUR0RDMkdEbVRvQ0pMbTFJTmdrNUpiV3lzNEZXMG9VNVA2NzZm?=
 =?utf-8?B?Q29YL1R4MG5CWlpsZ2srM1lvM1ZLc2JCd29DZkNERUs5YUZWM2gxQnpzcWlw?=
 =?utf-8?B?QUZzeEtsSjduem92V0lPRTBuQWRXYjFCUnhBcmZxR255NTA1Q0xzajJCQ2RV?=
 =?utf-8?B?S3lSdHdaNkk4bnI5bU1xNUdocHJiN09uYVppSWhUQUw0WUthdlluQVg0YWZJ?=
 =?utf-8?B?LzBzTDd5bU9XYWZBVVN2YkZQMVFkQktZcld3MkJtNm5DNnlUTHo0NjZwcjUz?=
 =?utf-8?B?UVVqbFh6SVFOWFRXOE51NTl4alR2VUR5WG1nUmxWMUFqaE5mVVhTQzRmcUhy?=
 =?utf-8?B?WG9qQ2k0QWdyMENzT2NGUG9rNGF3N3VjZWRmK3IvandRZUtad25xdFFXYk51?=
 =?utf-8?B?Wk9XS3RGeEV1NU1lZnlFcU5ibVBsTXhKSkRMaWxCWEtJbDZ0Q0p3YXBWQ1ho?=
 =?utf-8?B?aXF2ckg0KzcyU1ZoUjdYK1BibjhYZWlLUzRXejRRODlIeVhsSG9oY1k1Uk96?=
 =?utf-8?B?Z2lJNldsdWppdHV0SzFXd0JTOGVnOTg4QVVjb2IvT1R5QURVZXRRSWFLVmdx?=
 =?utf-8?B?a3J2TTluNklkZWgvUGREY0UrUGxWV3VtaFE0VEJ3QW11VisxcHZ5NUhjQmtF?=
 =?utf-8?B?c2E4YzM0NnNKdHM1RVBKZE5tc0xhdGlEbHNrUWM2eHNXSTducEpRTTNrdXo3?=
 =?utf-8?B?TkVoWm9pUVY5TGtFTWFwbGlPbkp4MzA5Zy9RRjQveG1vWTRsSXk0UCtmeGM0?=
 =?utf-8?B?ZXZiQU9FcFcwT2RVc1AxV1lpWE9NU2pVRytrKzBxOHdxS0l1WE1WU2JtU0Vh?=
 =?utf-8?B?b3l2S2lUVXgzeDlNeXN5dHQxOXVFRkhkbmw3RytZY05MUnJHZnhRbTBab1J1?=
 =?utf-8?B?OTNLeHlMVzU2NTY2WDF5MmZQTFpDM2lQL0dEQy94SFdmYmFwdG5jeGxndjgx?=
 =?utf-8?B?aXBLczBoM2lGL0UwcEc1UjNET0l3QnR2QUZycTBTR3crbDVSWEtUYlhqUlI0?=
 =?utf-8?B?QUJtMFUwSVhJY2dsZCtkdFBIT0k5dTJqYkgvd0JPWnE0RHlVK0JYRUlOSzdo?=
 =?utf-8?B?bGpLRyt5cjNXWmhkYXQ1YXJGN2VwZnpNWTN6cWtLSEVLZmlOMThPM2Zwd1ZF?=
 =?utf-8?B?UzZBVmJndU5DS0FHbm9uQkFKaW9qalZPcGp5SjBDN21VOVIzcmR1TDNkcU9w?=
 =?utf-8?B?UWZqY1M4c3BZL28xbSttSGhEYlc0WHNkYmF5Y0ZFeWlodnNKakU4YVFkSm1y?=
 =?utf-8?B?dkYwM3FGT3l2OXY4WVQySjVLWUZqZGpKckJ0V1ZsRFRjU0IwWkovaFJHVjlT?=
 =?utf-8?B?bjhiczU0b1ROWFVKby9oWDJWeW9aa3MwdjhsMU5BTHZkeGZ4a0Fvdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 330c3c28-f54b-40fd-d860-08de829d8700
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB8245.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2026 14:17:02.1337
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ldTDKsHQGtKwQ+RGSXAMcjWS/6PfyT1KTI2HrI9Euqxa/44E0isvj9lXMYJSZph0bY79DcEGiMjzIw0GH1/tIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7861



On 05/03/26 4:13 pm, Manivannan Sadhasivam wrote:
> On Tue, Mar 03, 2026 at 12:24:48PM +0530, Manikanta Maddireddy wrote:
>> From: Vidya Sagar <vidyas@nvidia.com>
>>
>> Call pci_epc_deinit_notify() during controller deinitialization to free the
>> resources allocated by Endpoint function driver. This is safe to call
>> during PCIe assert sequence because we don't expect Endpoint function
>> driver to touch hardware in deinit function.
>>
> 
> Are you sure? The epf-test driver itself touches DBI space during deinit.
> 
> - Mani
Ok, I see epf-test is doing clear_bar which access DBI space.
But, I think we should give give a chance to EPF drivers to clean up 
resources and stop using them in PERST# assert. Let me know your inputs 
on this.

- Manikanta

> 
>> Fixes: 40e2125381dc ("PCI: tegra194: Move controller cleanups to pex_ep_event_pex_rst_deassert()")
>> Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
>> Tested-by: Jon Hunter <jonathanh@nvidia.com>
>> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
>> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
>> ---
>> Changes V5 -> V7: None
>> Changes V4 -> V5: Remove pci_epc_deinit_notify() call from pex_ep_event_pex_rst_deassert()
>> Changes V1 -> V4: None
>>
>>   drivers/pci/controller/dwc/pcie-tegra194.c | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
>> index a311c31109e3..b1ae46761915 100644
>> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
>> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
>> @@ -1624,12 +1624,16 @@ static int tegra_pcie_config_rp(struct tegra_pcie_dw *pcie)
>>   
>>   static void pex_ep_event_pex_rst_assert(struct tegra_pcie_dw *pcie)
>>   {
>> +	struct dw_pcie *pci = &pcie->pci;
>> +	struct dw_pcie_ep *ep = &pci->ep;
>>   	u32 val;
>>   	int ret;
>>   
>>   	if (pcie->ep_state == EP_STATE_DISABLED)
>>   		return;
>>   
>> +	pci_epc_deinit_notify(ep->epc);
>> +
>>   	ret = readl_poll_timeout(pcie->appl_base + APPL_DEBUG, val,
>>   		((val & APPL_DEBUG_LTSSM_STATE_MASK) == LTSSM_STATE_DETECT_QUIET) ||
>>   		((val & APPL_DEBUG_LTSSM_STATE_MASK) == LTSSM_STATE_DETECT_ACT) ||
>> @@ -1796,7 +1800,6 @@ static void pex_ep_event_pex_rst_deassert(struct tegra_pcie_dw *pcie)
>>   	reset_control_deassert(pcie->core_rst);
>>   
>>   	/* Perform cleanup that requires refclk and core reset deasserted */
>> -	pci_epc_deinit_notify(pcie->pci.ep.epc);
>>   	dw_pcie_ep_cleanup(&pcie->pci.ep);
>>   
>>   	val = dw_pcie_readl_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL);
>> -- 
>> 2.34.1
>>
> 

-- 
nvpublic

