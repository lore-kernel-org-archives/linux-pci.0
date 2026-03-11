Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012014.outbound.protection.outlook.com [52.101.43.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A13722C08A2;
	Wed, 11 Mar 2026 15:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773242471; cv=fail; b=Fgg1EKvFRZ25bt69ifSOSoYQaoAly04KxtxS2g6bzgsogJzjw61XfK+du2K57Kd2isY8uKTpbYSMGYaOpGOh3XJkJBExXNBnB+PjSR89itqRJb/tI/zlIcaqELpgXFDomaqte//mkoAFofM+q8KnwDbAz4/gK+1qXv31VnDX5rg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773242471; c=relaxed/simple;
	bh=jdQfU+nFBz2Q+tfRnro3sQ3CqPeOvIm0Sv5WUk/pSIg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FW/rCxyMoY3NMcdErrMc39vDM2q7uRczFnjqeGqA38AqQkSF4+sN84nfXNPZ8eEGXsRT7GYhsvBASXv6wVAWxm/XkUpcHwZ8s6UIfWWstdfATFDxp4KWOx++2diNvwUpWFC09cjAh+vjTGyAyenjQkdTV1fGNvjzlykoc6hPiSw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fMEbtLKg; arc=fail smtp.client-ip=52.101.43.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fMEbtLKg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nsKnmJWFnLDtpI2J73Ratc6O9ehBU2othqL8ko+CE549E25s5YmYPhtcVaMZT9MtzlFAzPJGWmIGXKB5t0WSMxNQyLDDvC30xKUSH+Y+GOczpUk+qsQgiCzRjKDV4bECiE06CFWutNn3JZQ388Ye1xh3kS9T2yHWi8SgH4yxb+oo9WGybEBE7cWoQOdN9GHu7ZUZINhXu3PgkTHoC+rQb+n9iAFafW/q2qMenZwowCiPiWcE0GFSq4yBYA+TrntkYag1NbJVWJGMwk08/WXmr6I1h2YVla6uNA/eScJr/QZ2a7ZoWwIYxH6PSZajeAMag90jkIzW6K7KtwKZAq5hfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DVx9puxPPo6tSCCKTwZWMRjcNS8mmYbo3oCi2AcDgxM=;
 b=ira2jfFLHWwgU6kdgwijWrhiyplUnf38V8Tc2VsjjophAlq65TvXgQmm4X4wLgNAokGtHm4COF5CFkPosAZsFvUaE0592GWiTafSPCzBJ0bQzRKpf/4Q0zmvs/xI0he455KRiDocWwMVUNeM4shpz2Yc1Y/Xp86KC/jgrWGnA1zeeDKuJJaFugnQGVoSeNkO7pHAiDauvTs0UqNEsDRWFm6LPSdLCjzWxu2Ga56/nR4H+twe0RBF7M5iId8teLMPKPvixqujvkILZ1eCas+/ajsaXQXJcriny+mzrVHsWAtYaUFVqi55Iu2opO5SM2KtkE3Omii2oRsdkmfbh1BqkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DVx9puxPPo6tSCCKTwZWMRjcNS8mmYbo3oCi2AcDgxM=;
 b=fMEbtLKgpyMHIb0my6LnOyvqDqY9AXjL4PDYlyCHSSHMVUWvlbywWgxnrDH6WIFQRISyjdLbkdQkkuTcMzx+gNDGfxu1hqzyTbNflPOH4GwsbQwrorspNSoTuo43t/9AxUOU8G+VMrf9q2lY+klW25GN8bMMLGP1xc4L7Mtxfoc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH8PR12MB9766.namprd12.prod.outlook.com (2603:10b6:610:2b6::10)
 by BL3PR12MB6524.namprd12.prod.outlook.com (2603:10b6:208:38c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.3; Wed, 11 Mar
 2026 15:21:06 +0000
Received: from CH8PR12MB9766.namprd12.prod.outlook.com
 ([fe80::be0f:431f:5f27:96d9]) by CH8PR12MB9766.namprd12.prod.outlook.com
 ([fe80::be0f:431f:5f27:96d9%4]) with mapi id 15.20.9723.000; Wed, 11 Mar 2026
 15:21:05 +0000
Message-ID: <e969000f-7683-4664-a47d-f0e7b3d0e082@amd.com>
Date: Wed, 11 Mar 2026 10:21:01 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 06/10] PCI/CXL: Add RCH support to CXL handlers
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: dave@stgolabs.net, dave.jiang@intel.com, alison.schofield@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, shiju.jose@huawei.com,
 ming.li@zohomail.com, Smita.KoralahalliChannabasappa@amd.com,
 rrichter@amd.com, dan.carpenter@linaro.org,
 PradeepVineshReddy.Kodamati@amd.com, lukas@wunner.de,
 Benjamin.Cheatham@amd.com, sathyanarayanan.kuppuswamy@linux.intel.com,
 linux-cxl@vger.kernel.org, vishal.l.verma@intel.com, alucerop@amd.com,
 ira.weiny@intel.com, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
References: <20260302203648.2886956-1-terry.bowman@amd.com>
 <20260302203648.2886956-7-terry.bowman@amd.com>
 <20260309140050.0000451d@huawei.com>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <20260309140050.0000451d@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0089.namprd03.prod.outlook.com
 (2603:10b6:610:cc::34) To CH8PR12MB9766.namprd12.prod.outlook.com
 (2603:10b6:610:2b6::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH8PR12MB9766:EE_|BL3PR12MB6524:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b206ec2-bd6a-411d-99a9-08de7f81d007
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	yT+7vXMtv+B2SaIdhnRXY5YFqDIsJCjVejkThSh+t0FM/iXWk/mHEfM++SDEnCa+R9jj0wnyfQKrpGUa6EE0VMeHHVRzvQNp3Mpam4d1uZbYyeSGNPCVjmU7yjzaLvcnyKPHYtcsvrq1zg+0YmHLQPnFSUM/UGVD+2hCO5tMZoa9Uzad82be+iQbLIsHeJ/Yvbi4AGvodqGxUBKec1XGPqcPMuLNpNQp2HhCU5Z56MyMN/lGICXJSzfxDA6ItFnUi1zQufGq+KKVijngXAAoTdYpRdkPKGsVvwcCUCBGxIJPTVVyWUh9j6PSI7dW7WVIpu2n3iNoHsLXb5iJMufqOxadXTpVf/VzBTGSlM7kWI6prBC2j4AtniTsEXS7UdNa/3TMNnbDoQcYsmbifK330u9DsVKdUjDtUSQKOyt7H4QfICdQWb7jjL0/h/uTnfiEK/MdnHYF0qUnPVpTZ5UqRwMRgW6uNZlRDFguF4tyBHBQnsOPKEdPpN4rTniq5kWIZAEkVMI3O+hCjQAoRWW5GFCBsZ6FiH3DyzLauyWcSOVv7NrlP5GKbULiss8pW6OEpBh5Xtsreu/v2gVAF4MJZwgm6/p0RVVaiAXwaxLpSkd7BPugOFcCHakw8SNRWQUGkM8/BD9ttXi4LfiMm9MqorfpyYZitUEd0eGNg4Uh7zHBv5qpaLu894HQcrg4BM3M/4BPNrlwwiDNFBTixMJODacI2S2D+gPFpfJYd3/CH8s=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH8PR12MB9766.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZStQak9mWi9zWmhiNTlUb0FOMTdXN012VTVkWERQaHV3M0hjUHJON3QvVVlY?=
 =?utf-8?B?UUxyTElBVlMvN3l6eTNoVHh1RUszYmI2eWhZWDNZZ3dYbmErRURMZnVndlBL?=
 =?utf-8?B?YTFnWGsyeGJCcEJnODJMc0U5OEQwc0YveDhRMlJFN3MyZHFsSTBOMTFwZUpQ?=
 =?utf-8?B?ZGhheXZJMDNlazVCamk1N2FwMTFieStBQjhrWS9lYnphUzRoRFUvZlZ1Uk0y?=
 =?utf-8?B?elZvODlkTlJBTnVnQjJqZzhUcDNsODFCZkpyaXpYZ0FmeDFxZmhBYjNuNE5O?=
 =?utf-8?B?Q1o0aW5wTXVBQThJTEg1R2RHNGNkRDkzNkltM2dWQUd1TmVvdFFCNUZWV2tS?=
 =?utf-8?B?bzdsLzhZaEp0T2xRZFlQR0M1UHB3djg4TkNlTlZrV2l2N05WMFc2OFUrOVFt?=
 =?utf-8?B?bUMyM0JGb0hwMFFMZDdPV29RaS9ReHBSc05yWEVXazlEeWxIbExDT2pnN0E2?=
 =?utf-8?B?UFk3YUErenNrY3NQbC8vZGpQWkU4SE8yL1NUMmdFZmU2ckJWR0VKZGkycXBL?=
 =?utf-8?B?UmNkOXN0Tm9keWhDaElaTjFUbmowcDYwY3dhM05meUVTNDd2UHpBcXJaeWFC?=
 =?utf-8?B?Tmp4SFhsN1AwMU94RC9KSE5pV1pyS042elQwWTl1d3k3ZnlIRkhEZzFNbWE0?=
 =?utf-8?B?K0JnNXVjT2pTQ2s1WXE3S0JvNWtWLzYrOERWWnFTa0RFakh4WU5iN0tPVVBx?=
 =?utf-8?B?Yy9yR2Y3OVFmSjBESlhoY2hVVkYzdmFyMlZISDBMK21TeWhuWWNhTkFVWGJw?=
 =?utf-8?B?SDl2dFRoMVh6TDRCN3IvdTRFMThjeW5iWVU3RTFqVVgrQWNYRTRlcGZ5R1lT?=
 =?utf-8?B?aXdWQWN3M1JTUUhIUGxpanZrOE04OXF0eXVYL3FpM3RiSnpyeFgzdC8rSC93?=
 =?utf-8?B?My9MenVJbXFTRytON201SVR0cDRQN3VaYlJ5TFRHcVc3Ry9zZU9WMHJNSjQ1?=
 =?utf-8?B?cUpGTXYzMmFrR1FPMCtMOEh3czFuby9DZVVLWUx1bitkK09XN3ZWc2xJK0hU?=
 =?utf-8?B?cHkvc24vOWJlMXBVNFlCM3VOeTBGYmtNTWJEa2dTdmduK1o0MUs1R1BEREhS?=
 =?utf-8?B?ZWdZTnZNbDlLSkx0Y2xCR0VJVWw0TVRaaWpaNmlTRDJ6Q2ZhOEkrakI5Sm9x?=
 =?utf-8?B?WnhhZk5hLy9DWTdDZzRFSXowR0RoVVRERXVzZ0xnaDYrQVNmNWZtTGRmOHBa?=
 =?utf-8?B?WkVtM2l6NjdXRytrUnZnOUJHeEdhUXlwcXlzZ2xvU01ZcXA0R1g1R1AzVklW?=
 =?utf-8?B?QnRDZEtBcmF1NmNsVjllVmxYUVg2LzVJQlZwT0NFOVIxMFhkVC9PRWJ2WnB2?=
 =?utf-8?B?Y3p6T1VLcHVUWjlndCtjTktKOXo0Unc2TktrU08zdElyYklDcmpkMW9pN2Nn?=
 =?utf-8?B?T3FNVzZHZlNyOEpWMytadlF1UEk5OTNvMWpVSTNuMkRXU2RNWFpKZTVLQ3hj?=
 =?utf-8?B?UkNHZUxTZHFON09QQk5JenlPTURjWEM1cmhDd1UzVXpDTkkzL0JBNkhaNmRK?=
 =?utf-8?B?S3VVc09oVGkyUFdBZDEzSW9Id2YzZ1NoMFE1eW9CRmFPeUp0c3Y3eWVEc0VO?=
 =?utf-8?B?ZzVva0hWZmdPOEdndFIzcFRucXVKNjFPUnZqNDNIQlcyTEtQTEFoRU54ZUxz?=
 =?utf-8?B?cHExa0t1Y0RIUTlsMFVVUWNTK0kvNDk5bDBwQlNqSzVBVFRkVGF4VllIam5x?=
 =?utf-8?B?Ulp3MDVrUzZBZUh3eDkweXJUTEFFcmxIYjMxaXpqbHBUL1ovb282d2k0c3RO?=
 =?utf-8?B?bVk4WXNkWjlpakFMYUJybkcxa3ZBeWZIRnV1YXFxS0gvdlNIb0NwRjRXcGVS?=
 =?utf-8?B?VE1YcjEyNmtoODc3bFc4UTM0b1NOQUVsaFBVUXhiSFBwOFNXQnlrSGczMkc5?=
 =?utf-8?B?cU9EWCsxeDNuYnA0dVNOTmZrL0lZeHZibDc5OUxVcDlhREdFMVVWUFZuWkJZ?=
 =?utf-8?B?S0JVQ25nOVNOZjJ2UEVtRUxKbW9NN0RnblhJMU5PZWp0NDZLaTM3YjFPU1dS?=
 =?utf-8?B?UnU0YmU4QVk4Q1dBSjA0Q3pzMmlwUGFJN0lzcEtJSU13bmJSQmpybDRCcUNl?=
 =?utf-8?B?UkRqaWdSUlhmQmU1UWhHVlBIZ2UvRzNTWGpBS0ZkNE5nNlk1VWtCczhGcFgr?=
 =?utf-8?B?RUxqZ0RwMWxWZTVEY3NuVm1BSWY3UHI1VHRTaFZYUFNEV2RuQStRc1N5Tk1P?=
 =?utf-8?B?ekZLZjMyMjRWMGdHb0hpTHZHYmR5Zjkra2h3WlMwQk4vK1ViZFlJVmVwZzJH?=
 =?utf-8?B?SDc0SVNYY0llMzZMOGowc3RSaU5QeFJtNDNOZlo0T2VZSDcreEwzcFZGN3I5?=
 =?utf-8?B?TE5zU3pMZmFVZFgwYW9MeGhBT3JBNEdQQXY4Z0dpQ2N2dktEcmVBUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b206ec2-bd6a-411d-99a9-08de7f81d007
X-MS-Exchange-CrossTenant-AuthSource: CH8PR12MB9766.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 15:21:05.2525
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oOVusi5eyC4qlAd/5pE9u9NZeOlVwrgb9x9Dm6kxe+eGUh1PxBSOKMzP+TjAqeozmcCCT2m5i1YDHtfL8JakEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6524

On 3/9/2026 9:00 AM, Jonathan Cameron wrote:
> On Mon, 2 Mar 2026 14:36:44 -0600
> Terry Bowman <terry.bowman@amd.com> wrote:
> 
>> Restricted CXL Host (RCH) error handling is not currently supported by the
>> CXL Port error handling flow. Integrate the existing RCH error handling
>> into the new Port error handling.
>>
>> Update cxl_rch_handle_error_iter() to forward the RCH protocol error using
>> the AER-CXL kfifo.
>>
>> Update cxl_handle_proto_error() to begin the RCH error handling with a call
>> to cxl_handle_rdport_errors(). This function handles both correctable and
>> uncorrectable RCH protocol errors.
>>
>> Change the cxl_handle_rdport_errors() function parameter from a CXL device
>> state to a PCI device.
>>
>> Report the serial number of the RCD Endpoint in the RCH logging. This
>> is used to associate the RCH with the RCD in the logs.
>>
>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> One question inline.
> 
> + a comment on a bit of neighboring code.
> 
> J
>> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
>> index 1d4be2d78469..48d3ef7cbb92 100644
>> --- a/drivers/cxl/core/ras.c
>> +++ b/drivers/cxl/core/ras.c
> 
>>  static void cxl_handle_proto_error(struct pci_dev *pdev, int severity)
>>  {
>> +	/*
>> +	 * CXL RCD's AER error interrupt is used for reporting RCD and RCH
>> +	 * Downstream Port protocol errors. RCH protocol errors are handled
>> +	 * using a unique procedure separate from from CXL Port devices.
>> +	 * See CXL spec r4.0, 12.2 CXL Error Handling
>> +	 */
>> +	if (pci_pcie_type(pdev) == PCI_EXP_TYPE_RC_END)
>> +		w
> 
> Maybe I'm missing something but why do we want to carry on running the rest
> of this function after this?  Superficially seems like we will be doing
> at least some stuff that didn't happen before.
> 

Hi Jonathan,

Before introducing this series, a CXL RCiEP's internal AER interrupt results 
in calling the RCH handler (cxl_handle_proto_error()) and the EP handler.
The EP handler was:

	scoped_guard(device, dev) {
		if (!dev->driver) {
			dev_warn(&pdev->dev,
				 "%s: memdev disabled, abort error handling\n",
				 dev_name(dev));
			return PCI_ERS_RESULT_DISCONNECT;
		}

		if (cxlds->rcd)
			cxl_handle_rdport_errors(cxlds); <== RCH handling
		/*
		 * A frozen channel indicates an impending reset which is fatal to
		 * CXL.mem operation, and will likely crash the system. On the off
		 * chance the situation is recoverable dump the status of the RAS
		 * capability registers and bounce the active state of the memdev.
		 */
		ue = cxl_handle_ras(&cxlds->cxlmd->dev, cxlmd->endpoint->regs.ras);  <== EP handling
	}

-Terry


>> +
>>  	if (severity == AER_CORRECTABLE) {
>>  		struct device *dev = &pdev->dev;
> 
>> diff --git a/drivers/pci/pcie/aer_cxl_rch.c b/drivers/pci/pcie/aer_cxl_rch.c
>> index e471eefec9c4..83142eac0cab 100644
>> --- a/drivers/pci/pcie/aer_cxl_rch.c
>> +++ b/drivers/pci/pcie/aer_cxl_rch.c
>> @@ -37,26 +37,11 @@ static bool cxl_error_is_native(struct pci_dev *dev)
>>  static int cxl_rch_handle_error_iter(struct pci_dev *dev, void *data)
>>  {
>>  	struct aer_err_info *info = (struct aer_err_info *)data;
> 
> Not related to this patch but that cast isn't needed.
> 
>> -	const struct pci_error_handlers *err_handler;
>>  

