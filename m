Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010044.outbound.protection.outlook.com [52.101.61.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20DEA2EA171;
	Tue, 31 Mar 2026 13:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774963884; cv=fail; b=cXVUXlrVDXtlf1aLXqb43x0bDvLoIT8hIH7VcpW6B3M3mxvfGA9YQeG7qWa9EUOATPZDszlAEFeQ+bIn5B990uEEX9Dy+XzRNoerdX72nxZVwL4cSw+ebKxwyhoJmibzkEHwlBz3fwT+/U557OmGNdXabwNCYCxSCRwqn0Eyirg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774963884; c=relaxed/simple;
	bh=baRkUo1lSEXkHGTEGIvX1E/45oXXCpTDFcr5pNPcp9s=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pDwlA9Y7zTUY09qHGdlCS1Fiwp5qhgtJJGm35zWBoFP6gfGW8yWlEociuImgrWqYbbUNnOvDPPW9SFex61aQGgtQIN4ywYmWFZx/KYURdbwix2HIRwbYehY+8T+ZU2fOKeRJ02Ld7husY43g6WK7P5J9DTkqP/WuTe88rTOMY2c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=WSQfx+X0; arc=fail smtp.client-ip=52.101.61.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WSQfx+X0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DUQEs4RwP5UDWCGUP0TkdC2QH5ztmLJtNUaPlRJQU8ytv93jVDsZcQ84+skY+2f0GXxJPHlOy88YdpXhu5kwJlbPIUDiisFyLGvVgevl4twebhctyGXxPXPVnKhjwSiDshC1HRJ4JkKWuRaZ97jVeoVnbFejTDeCZ+nzk9ARJQSuQyBG1sqGH33tYBsC+01bk377V9PwusiED+uoiMduhdSl/u4z5Hjpaek/EzeJ17QysTbASStVE1ynWnEL0kykN+G1tDg5BtjxR2Ltwv6F8vj5I7Qx+mv6+lRr+EPGM8zn0yf/gYUowwvX9Wpi2oCp9Tu2dSLpQy01LKZgC7f4gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j4abGYLvD8/iWplAp4wZNEE1+c0D6J0RSxxzlRBYwtU=;
 b=EqnLu4mSDB3+68pCzhQLS3TWhtmvMV7itWsRQMKy+q4A7UW15A8pnKo+VcYB4GWrlpRu9Fmljo54vawA74cNn0iUuFGNwYPaZDdv6Ke7YczcXJT7bKvxS0XZym4Q6Oq4Dt8K1LtPC6NlCexCarEpOz9UCbenbF0uktbwhY1cyXrt2cLjPTwNaoPWYvPFD49DZ9BEtwXmmuPUedzXSOIEQ6Iqe9FDiFyuVTS5FBbAz8Lpzrj4nCK6w/9lgIOmXZ17e06py+46PZRbUpabfitgyOcZfUxV9MDfEV5+RiWRfIIqjC5urPPP3qtDg5kcy1NuXohS/WftqlGuQyxDHAElgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j4abGYLvD8/iWplAp4wZNEE1+c0D6J0RSxxzlRBYwtU=;
 b=WSQfx+X0hkFQchSa7LUq8RSs39JEHwszXR4Y3IsAJ56LmNatQIyCR/+xObDqsUgpLpRfUp71p8DZz0tyekF3wyoCtq0aTCn0byqDU2jLVClaVQzOpMM+lMnQuQ2toU9hPlT454jR8HTPMP/bmUrSiTFKGu12v9Ulh35vD1XPtkk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH8PR12MB9766.namprd12.prod.outlook.com (2603:10b6:610:2b6::10)
 by SA3PR12MB9105.namprd12.prod.outlook.com (2603:10b6:806:382::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Tue, 31 Mar
 2026 13:31:18 +0000
Received: from CH8PR12MB9766.namprd12.prod.outlook.com
 ([fe80::be0f:431f:5f27:96d9]) by CH8PR12MB9766.namprd12.prod.outlook.com
 ([fe80::be0f:431f:5f27:96d9%3]) with mapi id 15.20.9769.014; Tue, 31 Mar 2026
 13:31:12 +0000
Message-ID: <e2583442-55a8-460b-90a0-7b56db0722dd@amd.com>
Date: Tue, 31 Mar 2026 08:31:07 -0500
User-Agent: Mozilla Thunderbird
From: "Bowman, Terry" <terry.bowman@amd.com>
Subject: Re: [PATCH v16 10/10] cxl: Enable CXL protocol error reporting
To: Dan Williams <dan.j.williams@intel.com>, dave@stgolabs.net,
 jonathan.cameron@huawei.com, dave.jiang@intel.com,
 alison.schofield@intel.com, bhelgaas@google.com, shiju.jose@huawei.com,
 ming.li@zohomail.com, Smita.KoralahalliChannabasappa@amd.com,
 rrichter@amd.com, dan.carpenter@linaro.org,
 PradeepVineshReddy.Kodamati@amd.com, lukas@wunner.de,
 Benjamin.Cheatham@amd.com, sathyanarayanan.kuppuswamy@linux.intel.com,
 linux-cxl@vger.kernel.org, vishal.l.verma@intel.com, alucerop@amd.com,
 ira.weiny@intel.com
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
References: <20260302203648.2886956-1-terry.bowman@amd.com>
 <20260302203648.2886956-11-terry.bowman@amd.com>
 <69c9d4b8e08f1_17890410047@dwillia2-mobl4.notmuch>
Content-Language: en-US
In-Reply-To: <69c9d4b8e08f1_17890410047@dwillia2-mobl4.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0159.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::14) To CH8PR12MB9766.namprd12.prod.outlook.com
 (2603:10b6:610:2b6::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH8PR12MB9766:EE_|SA3PR12MB9105:EE_
X-MS-Office365-Filtering-Correlation-Id: 92ed50e4-a41b-4b09-a4d7-08de8f29c665
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|921020|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Q8XM4JCESdXkI8ssaeJHO+gbn9Y9pjDLZQSrbDEFNv9QrSS6xQSF7Y8TqF1D9xPl75W8HO8JwOZtJxkuHIw4fPeV/rCLD+RGStUlspojzfSp06b4Ws+KRzQLGNcWdHyKM1SuxUMq16Pb3Uyg0pcb3pDoTRWHBkaquQfTOCQzjUmz/Zt8a0LjtREvVqjZ3NHGSZUUOJDt90BpiOySJMSyk5osRt4am3BVmi4ksqpDjTX4By/H5NZ/YLRycz4B9/+pL2pwzRVGAo1Kx286DMpjASN13v7UcknUlmTmt7OES43ua/Z7HauciZhTBCnHjIeN1+U+9UYnPd71G7RofvdD0aNECz5V85pyifDQTuW1Muom4VU1AHsC1/FmFA+0kC26HHRFCXSgFPhtTcZLz6V8g+5NQJPxhGfElUIr4MvzS0uBi15nNuxTBqRV7mKv5ddIrhWffzK6rfRzRyPzeCLjNyBqp2LKEGhpGnR09bqNO8SWU8OV9enfKBEK/iml99f7UN5aIkgjeCTciK+Mq5MWS9cfHQg9bkhTpMy4QW+iIDLSGBzo8y+8OJJkGSRdJvxQdO2lnqdOGxJoSJIkD/O+tnm0OOf3gOa4aJJhDFw14zUbNujHnh13oADNuqGt7ZA4lnLi1r7n2NZh5qey91ROZttl4bSGsCSSDB8N0SEIuSnT/gS3iRc8RXfIoLfWCpPmPLJeCENHiropq+Konfc6jXeXAJBb0DarjKdsm19nLcoat80j8Cd1sM8aIWV9bxlQPh60zfyTBtozsxyNE4FNPw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH8PR12MB9766.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(921020)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cDR1cUFiQmp3SUwwUlgvUGZxQW5CNlBTeGowWkgxbjBLSFBjUmNlM0MyZVN4?=
 =?utf-8?B?VlNWcEFkS1BNbTJrblZURXQ0di90a2wyM2R3ZUU0WGIyTUpRbnRPVjJkQzNz?=
 =?utf-8?B?ZTdBYkcxZVpMa3QySUdlVnA5d1pCVzNwWU51a2VBcGt3ZDVaNW5QajN2bGZJ?=
 =?utf-8?B?UDdXN0ZvdEhDQXdyMGtkUnhhNC95QVl3cG5pNnRPaWZxYy9WallobGVFaEo2?=
 =?utf-8?B?UTJ4Skh1TVZoTTJWMXd4TllXbTd6aW5odlFiTFdMelV6V2Ria0dIeG9pYUxI?=
 =?utf-8?B?cHhjMFNzS3VBWWgvMGR6N2dlTlV5NVhGYzlRK0E3emtzelI2eUhLZTJOUFht?=
 =?utf-8?B?WXZrdW9xRENLN3hVb0s2M0dTdlJvb0JrZGgxUzYvaFVaUG5uUnQ2dVF5QWpm?=
 =?utf-8?B?VUJqa0c1blp3QkFFeThHbldETlJGL2tIRmlJYnN1ZnpCK2F5dFpFcVdjV25W?=
 =?utf-8?B?OUFLMFh0SzhuT3o0Rk9oa2NJRVVNWFNiREsyR0FvRjZrMFB3bW5NRllub3VK?=
 =?utf-8?B?aUhXM2pGV24wV2tkWFlHVEdEMG1YazFzaUkwRnI1ZWFlQjY4VkYvQUc1REVO?=
 =?utf-8?B?WGpHUlJWYjBEdFAwbHVZT2JucGUxT29TMm45QVpNZjNycWw5blRDQ253TkFt?=
 =?utf-8?B?WldvZUR2L1dsL2NGU2ZIalUvSzFhNW5JZVlQTXdVU096WFBXN0VYRE9tczVP?=
 =?utf-8?B?aE9HWFF6WTBNeXpITm42VlVhL2MxSlhDTjMwdW5aRHhLcWM4MVdSM2tUV1Fy?=
 =?utf-8?B?SXppYlZDNWJqRmFyOUdxOG5kSTBWUzM4aGk1eWFabkhIdjNVZk0zNXd1Z2Z5?=
 =?utf-8?B?cHp3M2FJaHdLUS80R3duYVdSYlcxNmFwRncxSksxa3FDVWV1MXZKU0lHY2JM?=
 =?utf-8?B?V0J1d0lBT3RhTTdybEN3aW5KdGlTblBFT2xLZHlvRFJmMFhxN09WVFNNK2Rv?=
 =?utf-8?B?UjdNTXhqRVJRSS9qZHR2WGpSOGNoSGlRME9PUEMxZFZ6MkhuUkRwL0xEbGw4?=
 =?utf-8?B?VEtqWmZ6MncrTkhBUlBieUJhMVE3dzhrOXFURVAxaFB0YXlyZmhQbXc0N2s1?=
 =?utf-8?B?UUkwcXh1L2pKbDFzQUVFTktsR3NIMmdpbjZZQTFuK2QwLzY2akFwOE56dE1H?=
 =?utf-8?B?YzI3b3VmWnVta0RNNUo0MDd6bzlMVE1ublJJOUtRNGl1R2pkV2RrMDgrSXhB?=
 =?utf-8?B?S0dGR0hia0Y3K3YybS8yUGFrNlNUR24zY0tmWUhVYWZNa0x2QWpTbFlqc3Fl?=
 =?utf-8?B?UWY1ejlVZzRjQTR6aHBXY1VBRjBOc2FQK2hONG1sbDB1TlJhTjZ3TFVCOGI4?=
 =?utf-8?B?aERlVHFIei9qVjZ3RU5UOTFQQ1J3MFdHUDMzVnFuWHkrNzFWSDFjNDlQaGlp?=
 =?utf-8?B?OVAvL1Y5OEtidkRWbGNOeVJrTERzUzJwOXBsMlEvSnFwRXAxTDdRb1pIMGpZ?=
 =?utf-8?B?MVFzM1hId0dFdzk5SXE5d3pCeW91SVNQeTFtaDlwYzBhU2tKOVdmYjU3YkRR?=
 =?utf-8?B?K05tQVZLRDM2STRnaG16eTIvd0xpZklmVDRnTVZuVmZGbXlBQ05IYmJrUTR1?=
 =?utf-8?B?a29XUTdiRWxQRGlTUUI1Q3J0M3lodlVLbnBDRGNLRDNObGRPTXJ3UFo2eHRO?=
 =?utf-8?B?Ri8ySHVxcDVoMFloNUMrRzFwOUkwQnI5NVAxNHhtY2JPU1U5VWJ4Um0wb0dy?=
 =?utf-8?B?Q3ZmaWlmdTJBRHBMRTUxOThyU05lUHljYmZvR3pCcWlublk1UlBzbFRWYlov?=
 =?utf-8?B?STZvYlJ2UnNsL2JJNW5zWEMvOTZNRGdJd3k5VDBLZ0dyOWxjd1c2akJXSEJj?=
 =?utf-8?B?TVFSRG5YVTBIY2NPclpGTkJEdWFOZzBpS0x3UGQ3NG5NVEZnYjlqa2lLeWRB?=
 =?utf-8?B?YkxjWkhtSGxweUd5V1Fud0tLNzA1YWl3cDZIN1lKek14ODJMOG5sWDNVamhB?=
 =?utf-8?B?dUkrWVhUTWU2bE5YQm55L0dzRTJXclppaDJDOXJRcWFBNEJyWXFTdmJITlZZ?=
 =?utf-8?B?NndKTVFGRmNsY1BKRXRCZVhQSkRUbld4elZuNnRuNlVBbTJmcVNYS05aVThI?=
 =?utf-8?B?VU9NVUtiMHRSQmh0a0RZUXBodmYzb0VjVVJ3cUl0bzdPd2N5T2FwNmNzZFE2?=
 =?utf-8?B?Z2hDNEdKaUlRbE5mVVZMNy85dHpDa1RhWnNSaEJMYnhMOEhYTHBDQ0dINE1u?=
 =?utf-8?B?ZmwwdXMyRDJUaERjUFlSWnNVREdXOVJEcUlQd0d1R0s0UTJTd3Z1VWdSOHJI?=
 =?utf-8?B?R1puSHVadi9ERUhROWYrejBDV2RaVFVNK2lQUnlTeUR4NFNYemVvaSs2UTA0?=
 =?utf-8?B?MGU0N24vOUp4aGE5UGRZZEFYOHNPMWdRUisxU0I0dm84ZGlqQndSQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92ed50e4-a41b-4b09-a4d7-08de8f29c665
X-MS-Exchange-CrossTenant-AuthSource: CH8PR12MB9766.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 13:31:11.9555
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tVnvI+TPK/1x60Sna3sHDpxax2PbjPkxkby8lw4rpKW+LIBkugEd7WWt5i+PB6lfKv2LmEcEQeMA2edzaC87Vg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9105

On 3/29/2026 8:41 PM, Dan Williams wrote:
> Terry Bowman wrote:
>> CXL protocol errors are not enabled for all CXL devices after boot. These
>> must be enabled inorder to process CXL protocol errors.
>>
>> Introduce cxl_unmask_proto_interrupts() to call pci_aer_unmask_internal_errors().
>> pci_aer_unmask_internal_errors() expects the pdev->aer_cap is initialized.
>> But, dev->aer_cap is not initialized for CXL Upstream Switch Ports and CXL
>> Downstream Switch Ports. Initialize the dev->aer_cap if necessary. Enable AER
>> correctable internal errors and uncorrectable internal errors for all CXL
>> devices.
>>
>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
>> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
>>
>> ---
>>  drivers/cxl/core/port.c |  2 ++
>>  drivers/cxl/core/ras.c  | 22 ++++++++++++++++++++++
>>  drivers/cxl/cxlpci.h    |  4 ++++
>>  3 files changed, 28 insertions(+)
>>
>> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
>> index 27271402915f..c33d58fb7264 100644
>> --- a/drivers/cxl/core/port.c
>> +++ b/drivers/cxl/core/port.c
>> @@ -1852,6 +1852,8 @@ int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd)
>>  
>>  			rc = cxl_add_ep(dport, &cxlmd->dev);
>>  
>> +			cxl_unmask_proto_interrupts(cxlmd->cxlds->dev);
>> +
> 
> Why here? devm_cxl_port_ras_setup() will just redo it, right?
> 

No, I found this change is needed otherwise injection fails.

>>  			/*
>>  			 * If the endpoint already exists in the port's list,
>>  			 * that's ok, it was added on a previous pass.
>> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
>> index d6112b812c82..bfe6cb35154e 100644
>> --- a/drivers/cxl/core/ras.c
>> +++ b/drivers/cxl/core/ras.c
>> @@ -119,6 +119,24 @@ static void cxl_cper_prot_err_work_fn(struct work_struct *work)
>>  }
>>  static DECLARE_WORK(cxl_cper_prot_err_work, cxl_cper_prot_err_work_fn);
>>  
>> +void cxl_unmask_proto_interrupts(struct device *dev)
>> +{
>> +	if (!dev || !dev_is_pci(dev))
>> +		return;
>> +
>> +	struct pci_dev *pdev __free(pci_dev_put) = pci_dev_get(to_pci_dev(dev));
> 
> Why does this need to hold a reference for a simple to_pci_dev() conversion?
> 
It is unnecessary and can be removed. 

>> +
>> +	if (!pdev->aer_cap) {
>> +		pdev->aer_cap = pci_find_ext_capability(pdev,
>> +							PCI_EXT_CAP_ID_ERR);
>> +		if (!pdev->aer_cap)
>> +			return;
>> +	}
>> +
>> +	pci_aer_unmask_internal_errors(pdev);
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_unmask_proto_interrupts, "CXL");
> 
> Why export? The only callers are internal to cxl_core.ko?
> 

Export can be taken off. This was changed to export when this was called from 
another CXL module in previous iterations.

- Terry

> ---
>  drivers/cxl/cxlpci.h    | 4 ----
>  drivers/cxl/core/port.c | 2 --
>  drivers/cxl/core/ras.c  | 3 +--
>  3 files changed, 1 insertion(+), 8 deletions(-)
> 
> diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
> index b7cf9d6137b3..184a95e96ea9 100644
> --- a/drivers/cxl/cxlpci.h
> +++ b/drivers/cxl/cxlpci.h
> @@ -82,7 +82,6 @@ void devm_cxl_dport_rch_ras_setup(struct cxl_dport *dport);
>  pci_ers_result_t cxl_pci_error_detected(struct pci_dev *pdev,
>  					pci_channel_state_t error);
>  void devm_cxl_port_ras_setup(struct cxl_port *port);
> -void cxl_unmask_proto_interrupts(struct device *dev);
>  #else
>  static inline pci_ers_result_t cxl_pci_error_detected(struct pci_dev *pdev,
>  						      pci_channel_state_t state)
> @@ -97,9 +96,6 @@ static inline void devm_cxl_dport_rch_ras_setup(struct cxl_dport *dport)
>  static inline void devm_cxl_port_ras_setup(struct cxl_port *port)
>  {
>  }
> -static inline void cxl_unmask_proto_interrupts(struct device *dev)
> -{
> -}
>  #endif
>  
>  #endif /* __CXL_PCI_H__ */
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index c33d58fb7264..27271402915f 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -1852,8 +1852,6 @@ int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd)
>  
>  			rc = cxl_add_ep(dport, &cxlmd->dev);
>  
> -			cxl_unmask_proto_interrupts(cxlmd->cxlds->dev);
> -
>  			/*
>  			 * If the endpoint already exists in the port's list,
>  			 * that's ok, it was added on a previous pass.
> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
> index bfe6cb35154e..1f688110f0f4 100644
> --- a/drivers/cxl/core/ras.c
> +++ b/drivers/cxl/core/ras.c
> @@ -119,7 +119,7 @@ static void cxl_cper_prot_err_work_fn(struct work_struct *work)
>  }
>  static DECLARE_WORK(cxl_cper_prot_err_work, cxl_cper_prot_err_work_fn);
>  
> -void cxl_unmask_proto_interrupts(struct device *dev)
> +static void cxl_unmask_proto_interrupts(struct device *dev)
>  {
>  	if (!dev || !dev_is_pci(dev))
>  		return;
> @@ -135,7 +135,6 @@ void cxl_unmask_proto_interrupts(struct device *dev)
>  
>  	pci_aer_unmask_internal_errors(pdev);
>  }
> -EXPORT_SYMBOL_NS_GPL(cxl_unmask_proto_interrupts, "CXL");
>  
>  static void cxl_dport_map_ras(struct cxl_dport *dport)
>  {

