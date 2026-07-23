Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011038.outbound.protection.outlook.com [52.101.62.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F85370D7C;
	Thu, 23 Jul 2026 19:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784836702; cv=fail; b=ZXitfwIUDxFZGF7hD+2dw+o0tVeZJaH61gsgO+ZvZQjv7tetIWs6rfVmULxGGBYCs0OVAddCClJ1MtvoHV+kc9leSEH7uwBEH9oGNXsU2G7DZJ2uPv4gpAbhPfuz8tblgaqwowsqXTGtFDpDh8uGtc8jte8VTinUYtC6aR1j0GY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784836702; c=relaxed/simple;
	bh=3+d2ldxroPQl4qiZQA7HBzN45QXT6J/QcRssOktBG5s=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PMAxvD4pWrPbeFLlB1tkrtnba0FxTVki39dAtUwIZMFN5czTiiVc0tHxmheaBmguhRk5E/JkVc4qWNLdCkNMV1SymAtByw4rPSG02beNxRoQktzmNiXoDCNcim/D2bRWapEdnBypLVK+7tjLdrGFodfUSprjqzI7n+fcCWJLdf0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=P1nPD206; arc=fail smtp.client-ip=52.101.62.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="P1nPD206"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JFI6SQOpfE8/2x+RZh+BdRuQq/+E12MeDs1RR11q9dRt0OfoROqYLMHlh58+Je26i75DMAbsXgHcaafrVP6epSzkqglic/GRpKPS6+c6oQyD9lx1Mg8NsH4IbnN1zLd4wEdWKUxXlSHiDooFo8oDx9kHdOLsuvbkspsNnheyd9UmfY8FNS/i+Izz+Gdw1KMjI0hAmlVHeMFaITuy5fadAgZ1JN3dZjUlg3qM2M/WWe6TOqyLgJ+2lXU3SX4klDwjJhOBnb/5+jA5IAnuUiWWa+epQT4R1MlyWETWArjbLRFn3pS+p9ILTDgYt/F+N+0sUM2rkFyz1LXwo1CJ+FMYPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ijOrKD1cEn2bwe4WGdOfMSam80quMtjmCSJRGKQqi4Y=;
 b=vgheWZg3RWQ1je92CzvluSG7aLgUvjIUNvSHWx1HF/FF2qmpC57++Uz7toMJuYseAn3K3X0hQSQ9P2gwMuRtve5TnnUB7LIYRWnRMCmWA3DxKJxPVwmA3bplMt14wltC6wI7jr/KvqfpwgVem0OTLR/eQQ12iiEBfMYQn05F00k0IPo0LqGnp2sv26PdGyQOkeoklzV5r78y5gp/u5wMYRcBBnEDbFsLc43FhHdcmfsAjCHVMTlIYIsS9RK/RouGjEbtgB71TazBKJbJoziGWW6+HLvtTurGP2Nnt0HMtXXU3Fa9MiyopldL2lMor4RkGe6tkLPuIXogNW8L/hZEcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ijOrKD1cEn2bwe4WGdOfMSam80quMtjmCSJRGKQqi4Y=;
 b=P1nPD206AhEixSuu9VZrHRaRLRBJh4xaPYRN/2et/tZ7Fv1i7C3cBkakKUu38emKcFbP+bdlRsTjRshCVNVZNPYy7yYTFdV7/+sdNxrmJHi5ic89HeQDFRBHGtBNIRtZVRz2EInLSgk/i5xOfOYjvoR7/hXsd0QGDPFi5DjXFNk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH8PR12MB9766.namprd12.prod.outlook.com (2603:10b6:610:2b6::10)
 by CY1PR12MB9626.namprd12.prod.outlook.com (2603:10b6:930:106::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Thu, 23 Jul
 2026 19:58:17 +0000
Received: from CH8PR12MB9766.namprd12.prod.outlook.com
 ([fe80::be0f:431f:5f27:96d9]) by CH8PR12MB9766.namprd12.prod.outlook.com
 ([fe80::be0f:431f:5f27:96d9%5]) with mapi id 15.21.0245.010; Thu, 23 Jul 2026
 19:58:17 +0000
Message-ID: <2aed15c5-dc94-4b04-acd3-b64f0ca697e0@amd.com>
Date: Thu, 23 Jul 2026 14:58:15 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v18 07/13] PCI/CXL: Add RCH support to CXL handlers
To: Richard Cheng <icheng@nvidia.com>
Cc: sashiko-reviews@lists.linux.dev, linux-cxl@vger.kernel.org,
 linux-pci@vger.kernel.org,
 "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <20260717222706.3540281-1-terry.bowman@amd.com>
 <20260717222706.3540281-8-terry.bowman@amd.com>
 <20260717224321.1BB411F000E9@smtp.kernel.org>
 <3ed4793a-b1a6-4459-b1ca-03979ae8af3e@amd.com> <amGWvnoT5XNIBMMb@MWDK4CY14F>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <amGWvnoT5XNIBMMb@MWDK4CY14F>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH5P221CA0004.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:1f2::20) To CH8PR12MB9766.namprd12.prod.outlook.com
 (2603:10b6:610:2b6::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH8PR12MB9766:EE_|CY1PR12MB9626:EE_
X-MS-Office365-Filtering-Correlation-Id: 96fd0b7d-09d4-4c4d-498b-08dee8f4bd14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|5023799004|6133799003|56012099006|11063799006|4143699003|18002099003|22082099003|3023799007|10067099003;
X-Microsoft-Antispam-Message-Info:
	DiwHcSJ3V5CHCV8l3sp9hLyKdQGNCwCFXUraNVW97Bq21SMyY31caydZ5oZ/Fwo9UGtlS2aBLFN1zQpekZHnqSygOz7FLnf8sPkVL5iYfRpsaUpYU1ICdIrrFeou7n9pLas+4r1TcZlZmGZ1OuM2saMmVcMiri5zN5z3t2oEuFsKT6ULo4nWDE9LOMyDuDYeEYCTHiq6tqMphdo2ZTxuHC3IxJebOuCB1wHBWoQvHhcjzk3FHzmqFVVklhQf4cKGltht40qS9Oo08nHhsRHDHSLxd+A3fnCfxdhd57tc/t5SxNoZFabgrNsIuzkhES+9h0qTO8bVLw5hmBBLJJ2Onq+zexf8yaIoLRTvqulO4AVOoZSDpm6EIBxuEnSS/6RMieJUcnwfVkvsv+fb9CrByop+eVsczvk+V5pRLbDdVXdWDwDiujszyLYjXAATlRG4RxyltDF0CulNKljRUoGQj3hw7VHTcS0jE9narKrwig0s7da4XEXHCb6aUmuRjTTMkPbf+Ynxtyjmdn23PTJZVZ65AxKRKE91qB8mgweEO+Pj2J4mBPjN4McHx7lpQ3olBjFPByS1Wz5BG9WRg/2YF1r1+GRIgCpuqfVwOHYB/54Q95aioLyvTonyqFhvz8OribBDKubxKzCfpPk8sDejpjP4Y2lqwh9CDqql9AlUgtY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH8PR12MB9766.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(5023799004)(6133799003)(56012099006)(11063799006)(4143699003)(18002099003)(22082099003)(3023799007)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cEZ3Y01GblJnblZBSHVpUUtkYVpQTTZ3RVQyUzR0Tjg3dU5KTG9HYWE4SkpV?=
 =?utf-8?B?TGxXN0REVWxtRXJvVktOSVBuSDBGUmhlekI2VmpmamVXc3pLb2VGTVRiWlQ5?=
 =?utf-8?B?Y2t0RU5kV1NuZ2c2VjhYZG9zVzNjWVJHRHJ1STl0NVZUK0wyZ3MzMzdvWDNX?=
 =?utf-8?B?UzM1M0tNbUtYaWd1dm9JN2Q2S3VJeHRjaU9haFdhN0pQUGdQUnlRSzY3VWZ4?=
 =?utf-8?B?SFU1T2xnVFM2RVNteUhROENqYnZWNVZHbm9Gc2tqRGdrNVg3aW9XdXRodndp?=
 =?utf-8?B?QWZWekRUTGxjU1RsNW9kWTR0eWYzN1BWeUtVMFBKRng4Mm1DajJWNlhkM3I0?=
 =?utf-8?B?dzdxak5taGdkZUNEVzVzcmtPVFJlTEptUjVvVkJLS2RDTEFrOUJNY1pxaXZj?=
 =?utf-8?B?aU9BTFhmdURSd2dWeVo0bFRUVml5Q0JDMUtKdmpBcHh6QWlqVUI1Tjk4KzVY?=
 =?utf-8?B?a3VtbGwreUs3K2hWdFhwZzF2RGlYYXFydm9xMTBtVFZ3Y2V0eFlobFNpay9H?=
 =?utf-8?B?RTAxY2h0bStuQkFObzRuWHVRblg5UDlaUGtMQXVTaEZRZW9kQW01dStQTzgy?=
 =?utf-8?B?cXhuOHliMThCZjdHSXNwUzd0Sm9ScnBPWTE2R05PcGlkclRLd0hUb0htcW4y?=
 =?utf-8?B?b3lFNXRHMXQ5WkhGODJvTTdOKzZIWXpQYno3ZWxUSDBITDRnVXFQclNMZ2lj?=
 =?utf-8?B?VGFDZzZZSmh2MWZxQjZhVkJoT0wwNVZIZ2pMbW1odlZXZmpXVC84bW5RQmc3?=
 =?utf-8?B?TUJJenJ1Ynl5TVZ1b1dGL0xXUWY5Y2JsNWtzUVJacDlTZ1RPTys1cHNYR3BN?=
 =?utf-8?B?WEZpTzI0K1BsekYySVlZQjdQcHcrZHJnYjk1TnF4RUo4YmpDK1dEci85amsx?=
 =?utf-8?B?MnM4M3huNDFIYzhMblpEYWVnQllIZ1l0NEwzek1KbnhjZ2o3Y3V6WWRhRm8z?=
 =?utf-8?B?cE5aRDgrY0U0VDZ4b0RFNmJBcS9POXRTeTEvV1REckxjSStmUzh4Q2FBMThz?=
 =?utf-8?B?S25MU21vZUFWazBXUHBob3VHQTBTQm1BZEVwOERtb21mdmVPZlppS2EzOUll?=
 =?utf-8?B?ckhpYUhJUkx1OS8vQlNwaHpoMkZBdFRvVlVKNDZEWWdaZlNxQTl1SDB5cytj?=
 =?utf-8?B?NHpzN3ZLakJuU1VSNFhqNXMyNWVvSzVEZFA0cHVHWmg3OGJTMWx0QWE5dkg0?=
 =?utf-8?B?S20zdjFQS2E4ZXBBNTFqTGFFYi9rTUdGS1FhSGZGT0FwUVpuZ3RJM2thT0NX?=
 =?utf-8?B?b216SmhKY1B5SFEzSkg2WWh2c3lIWjZhZ1dxMU9rdXNXTFpHcjZRMUpnYTBj?=
 =?utf-8?B?UkNlL1RkenA4UStITGFEN1E2V1R4R3JTVTZoaXpUWmRKb3gvYTZoMFZVZWNw?=
 =?utf-8?B?T1RiMW1VOEk1ZFgrRENMdGtBT1p2VWxNbzNma1NLdldRTEVzWkJ3bXpwTWNh?=
 =?utf-8?B?MndVOUNiL29xTHBnN01FMVBYdWJEWUpaV2hkbTlLUEN4OEgyQjJrQWphZ2x0?=
 =?utf-8?B?bVhTQk5VQTJOOU1xcHdic2F2U1NzUnF0S0VXUU5ObUlFR0FRLzVFKzJDSjNR?=
 =?utf-8?B?dURKdmZYQ3JaR0tSUCtvVzFmbC9Kb0VPUXJLM1JIcjdWRlBwU0NJSVJ2VWhl?=
 =?utf-8?B?b21aendMUWJZS3AwRkNFK3dLNFZlMEJnTXAwU0J3OUtnMURndHg3YWpwdG9P?=
 =?utf-8?B?U3JDU3RLSGZnTEUvNW03Mkh2Z2ljTFB2dk4yb2ZxV3dDVWJSSWJvRnEvWjRk?=
 =?utf-8?B?UEwrcHZ6Wm1BSnZnMkN1REJGUFpWYS9vay9GMnN6MEtoUEdRTS82WDViSm1L?=
 =?utf-8?B?TWxkUTBhK3pqNG5NUFhMaVVhemFQSnN4Nm9DYXRFSlhLOUtqVkJHVmdQc1NW?=
 =?utf-8?B?ZXU0M1ZoK2hlL0JvQm1KSzVPL2k0WVJBaGoranB4Sk8ySllUK09WZDVzTVh1?=
 =?utf-8?B?bVVCLzU2bzZQZTN1cUpFL2N0NlFBWnE0U2JEenlkYktud055ekk2RE5LMVVY?=
 =?utf-8?B?Y3BhV2lLUCs1NzB4eVJjVlppbW1BbWdMblRLWFEwRFJLUnl5aXl1Q2VWRE9I?=
 =?utf-8?B?OVlhZldsRkR4MDZLeWVBc2lEVCtMWHNXdnNFYUo3aUNLMk1BS2x2ZmxmVThu?=
 =?utf-8?B?OXJwaHlUbW91SlNYUE50OU5iVmE4S3NLeUl0bkZRRnZDVGU4cnlKdHM1S29v?=
 =?utf-8?B?MWV6eGNLNGQvcytucXlLeFVlYkR0YXRIeDMyNnlXUE5rb1c3UTM0ZzNLZXFU?=
 =?utf-8?B?UmRkc0VENGplYmVVQ0xlMitaTW1aeHl1dnpkTEE1VzVhLy9KRmtpQlNtUERY?=
 =?utf-8?Q?Q9KXU9sO3XAHoKVkwY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96fd0b7d-09d4-4c4d-498b-08dee8f4bd14
X-MS-Exchange-CrossTenant-AuthSource: CH8PR12MB9766.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 19:58:17.6117
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 39eC+mZBalQ/t7pgDHvIhoohe5mGzLGEX1wI0CQTz+R45oALnOA3MMsJpi4JE7uRtd5Q87XwkN66BBG0Y2H/sw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9626

On 7/23/2026 12:35 AM, Richard Cheng wrote:
> On Mon, Jul 20, 2026 at 10:06:34AM +0800, Bowman, Terry wrote:
>> On 7/17/2026 5:43 PM, sashiko-bot@kernel.org wrote:
>>> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
>>>
>>> New issues:
>>> - [High] Removal of explicit PCI error handler forwarding for RCH devices leaves RCDs bound after a fatal PCI error.
>> This is a false positive. device_release_driver() is called in cxl_pci_error_detected() 
>>
>>>
>>> Pre-existing issues:
>>> - [High] Preexisting lockless dereference of `dport` returned by `cxl_pci_find_port()` and `cxl_mem_find_port()` leading to Use-After-Free.
>> This is existing issue and is not planned to be fixed in this series.
>>
>>> --
>>>
>>> --- Patch [7]: [PATCH v18 07/13] PCI/CXL: Add RCH support to CXL handlers ---
>>> commit 6a99c70b18865d01d350aa367342e701ebe6dde2
>>> Author: Terry Bowman <terry.bowman@amd.com>
>>>
>>> PCI/CXL: Add RCH support to CXL handlers
>>>
>>> Restricted CXL Host (RCH) error handling is folded into the new CXL Port
>>> error handling flow. RCH protocol errors are forwarded through the AER-CXL
>>> kfifo, and the manual CXL.mem error handler invocation is removed.
>>>
>>>> diff --git a/drivers/cxl/core/ras_rch.c b/drivers/cxl/core/ras_rch.c
>>>> --- a/drivers/cxl/core/ras_rch.c
>>>> +++ b/drivers/cxl/core/ras_rch.c
>>>> @@ -96,18 +95,21 @@ static bool cxl_rch_get_aer_severity(struct aer_capability_regs *aer_regs,
>>>>  	return false;
>>>>  }
>>>>  
>>>> -void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds)
>>>> +void cxl_handle_rdport_errors(struct pci_dev *pdev)
>>>>  {
>>>> -	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
>>>>  	struct aer_capability_regs aer_regs;
>>>>  	struct cxl_dport *dport;
>>>>  	int severity;
>>>>  
>>>> -	struct cxl_port *port __free(put_cxl_port) =
>>>> -		cxl_pci_find_port(pdev, &dport);
>>>> +	struct cxl_port *port __free(put_cxl_port) = cxl_pci_find_port(pdev, NULL);
>>>>  	if (!port)
>>>>  		return;
>>>>  
>>>> +	guard(device)(&port->dev);
>>>> +	dport = cxl_find_dport_by_dev(port, pdev->dev.parent);
>>>
>>> [Severity: High]
>>> This is a pre-existing issue, but while this change correctly closes a
>>> lockless Use-After-Free window for dport here, does the same vulnerability
>>> still exist in cxl_pci_setup_regs() and rcd_pcie_cap_emit()?
>>>
>>> In cxl_pci_setup_regs(), cxl_rcrb_get_comp_regs() dereferences the dport
>>> returned by cxl_pci_find_port() before any lock is taken.
>>>
>>> Similarly, in rcd_pcie_cap_emit(), dport->regs.rcd_pcie_cap is dereferenced
>>> entirely locklessly, and then the function takes guard(device)(root_dev)
>>> instead of the required &root->dev lock.
>>>
>>> Since rcd_pcie_cap_emit() is reachable via sysfs attributes, could an
>>> unprivileged local user trigger a Use-After-Free by reading sysfs during a
>>> concurrent device hot-unplug?
>>>
>>> [ ... ]
>>>
>>
>> This is existing issue and is not planned to be fixed in this series.
>>
>>>> diff --git a/drivers/pci/pcie/aer_cxl_rch.c b/drivers/pci/pcie/aer_cxl_rch.c
>>>> --- a/drivers/pci/pcie/aer_cxl_rch.c
>>>> +++ b/drivers/pci/pcie/aer_cxl_rch.c
>>>> @@ -34,42 +34,37 @@ static bool cxl_error_is_native(struct pci_dev *dev)
>>>>  	return (pcie_ports_native || host->native_aer);
>>>>  }
>>>>  
>>>> +struct cxl_rch_error_ctx {
>>>> +	struct aer_err_info *info;
>>>> +	bool enqueued;
>>>> +};
>>>> +
>>>>  static int cxl_rch_handle_error_iter(struct pci_dev *dev, void *data)
>>>>  {
>>>> -	struct aer_err_info *info = (struct aer_err_info *)data;
>>>> -	const struct pci_error_handlers *err_handler;
>>>> +	struct cxl_rch_error_ctx *ctx = data;
>>>>  
>>>>  	if (!is_cxl_mem_dev(dev) || !cxl_error_is_native(dev))
>>>>  		return 0;
>>>>  
>>>> -	guard(device)(&dev->dev);
>>>> -
>>>> -	err_handler = dev->driver ? dev->driver->err_handler : NULL;
>>>> -	if (!err_handler)
>>>> -		return 0;
>>>> -
>>>> -	if (info->severity == AER_CORRECTABLE) {
>>>> -		if (err_handler->cor_error_detected)
>>>> -			err_handler->cor_error_detected(dev);
>>>> -	} else if (err_handler->error_detected) {
>>>> -		if (info->severity == AER_NONFATAL)
>>>> -			err_handler->error_detected(dev, pci_channel_io_normal);
>>>> -		else if (info->severity == AER_FATAL)
>>>> -			err_handler->error_detected(dev, pci_channel_io_frozen);
>>>> -	}
>>>> +	if (cxl_forward_error(dev, ctx->info))
>>>> +		ctx->enqueued = true;
>>>
>>> [Severity: High]
>>> Does removing the explicit invocation of the err_handler leave RCDs bound
>>> after a fatal PCI error?
>>>
>>> The standard pcie_do_recovery() on an RCEC does not iterate over its
>>> associated RC_END (RCD) devices, so this manual invocation used to handle the
>>> CXL.mem driver fallback. Now that errors are routed solely through the CXL
>>> protocol error work queue (__cxl_proto_err_work_fn()), the work queue only
>>> panics on uncorrectable cachemem errors.
>>>
>>> Does the work queue replicate the PCI recovery state machine's fallback
>>> behavior, such as calling device_release_driver() to unbind the CXL.mem
>>> driver on frozen channel states?
>>>
>>>>  	return 0;
>>>>  }
>>>
>>
>> The change to forward CXL errors through Kfifo using schedulable work is 
>> intentional. This series does not exactly *replicate* the PCI handling.
>>
>> The device_release_driver() is called in cxl_pci_error_detected() for 
>> pci_channel_io_frozen. cxl_pci_error_detected() serves as the PCIe error 
>> handler for Endpoints, including RCDs.
>>
>> Terry
>>
> 
> Hi Terry,
> 
> I agree with you on this part, but what I can't find after this patch is the
> path that invokees it for an associated RCD.
> 
> you replace all error_detected() for associated RCD with cxl_forward_error()
> and queue CXL RAS work, what if a fatal case where it finds no RAS UCE?
> 
> It'll return normal and RCD driver will remain bound won't it ?
> 
> --Richard
>  

