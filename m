Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010018.outbound.protection.outlook.com [52.101.201.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 141E8305E10
	for <linux-pci@vger.kernel.org>; Thu, 23 Jul 2026 19:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784836709; cv=fail; b=u0bALjeSUQUXl79EHrjLMJCMXxrnq/uYxqBqtEFy2oLPF6vTQVEMumAcGQW1DNV2r6qPpbIMpnJOGsldNnee9rrFD8aV3H2mCv55tqNPR8u+Nb8LSzr5rQN29/znGr9g3BWcCNRo4oN2TxtHZ7N1TsZJNTd6ftTr15yfLUJB3W8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784836709; c=relaxed/simple;
	bh=TLglGUuZSb6rNFa9bj8YjwFFuotI3dJdBPGNTtvMH78=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DVUFEzHPxOze5ndG8OTv5d/OYgethJfC5KNYUmRCrEj213sEgSbLzLzBqQkmeyQ8JFNGJ8KGLbKQGvx/t1znCVGdA2rr6QZE534MllsnhTFSdOZC8BvLZ5OA/vhGMnhp7ww2xiPZlEXtVJXA4iV5UJLXFardksjuBe4uNv9WVQk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NGKUMLj5; arc=fail smtp.client-ip=52.101.201.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NGKUMLj5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x7TwkZ+09dEWjhbg6NFT46mzS+QWTgxqUrtBaqgbzJ68d5oWEqvF61aPN32o0z1SDL7hg39JSpRdEUQFzy3x6pCz7hCm5Mgf9Hxnar2p1aETHT423Ifdm1eKJOkZD5KQnnOtl4hZWrDTIxvnXMGIUPEQCU+x/h5udjp2ZHBzhobqwMwji3E4q09M5fTks+62TR3AWZL+C6nHuYg2LoMBS5we/SO1Q9cwJ2S5aDIbVYafrWlm2NcT9VRPw6UsTSWJTTNmG3DCMXSGR904gJXKTmPV8lwXj1BvD0hD0Bt41TqA5X+FMHlctFqxmjWQn/lbf+m06VyiEY9XLyhlNdgiQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ap/Ue/OZ+oW3FAyvGwqQwF+ahrzVShqb259F7//T1UY=;
 b=JPYbd90aoVMMEKtn4IzQw5mcTw4qoceUH2ES7AeR0QOmBAQNA3r+rt5qykbozGGr5WAROmsRx+OwSdtMWlO9os3KVe+VWIAVlA0REDRS38dhA32bCzky29NoM+Tu/prWXCctQoUuw6e7hklQpl8c41B8cK5W0Jxz/PbkVVCAK77lXUv9WPdTn/ajztvpInlIrPZ1NRjoNaZ0l0EI0cIrCAvu6dAJwy3KM+FnQHh4fXaJU2pVYnxvW4HL5pUQISzKLdrj3prbW2K30i+2xXt++S/VAszhK0NBpEpwlECEB7xAC7t/l0yt9SihSqoESGwDpR4kdFgIOPjcEnbeHFqf8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ap/Ue/OZ+oW3FAyvGwqQwF+ahrzVShqb259F7//T1UY=;
 b=NGKUMLj5ysnW2QIFxHAVQs17fB3mZ2AkRk3sJsbnhFPH6IgmJphIBN1bv0QrTIsHPQeDJmTGsvs+OVcWI6ZwdMS6oKR1pooTKPHjSeQqrjQaJiHP04oXn681GlW47htHOuUIoNAfjcPgaq47rDAo0Jr9EAksWrZ8NXAiT2cNzXY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by LV3PR12MB9216.namprd12.prod.outlook.com (2603:10b6:408:1a5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Thu, 23 Jul
 2026 19:58:23 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%6]) with mapi id 15.21.0245.010; Thu, 23 Jul 2026
 19:58:17 +0000
Message-ID: <70e6d40b-3e13-4efd-b1e7-62195ff66e91@amd.com>
Date: Thu, 23 Jul 2026 14:58:14 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] iommu/amd: Force identity mode for selected GPUs only
Content-Language: en-US
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Vasant Hegde <vasant.hegde@amd.com>, iommu@lists.linux.dev,
 joro@8bytes.org, linux-pci@vger.kernel.org, will@kernel.org,
 robin.murphy@arm.com, suravee.suthikulpanit@amd.com, bhelgaas@google.com,
 alexander.deucher@amd.com, jgg@ziepe.ca,
 Amandeep Kaur Longia <AmandeepKaur.Longia@amd.com>
References: <20260723195328.GA852751@bhelgaas>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20260723195328.GA852751@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS1PR06CA0023.namprd06.prod.outlook.com
 (2603:10b6:8:23e::16) To PH8PR12MB6914.namprd12.prod.outlook.com
 (2603:10b6:510:1cb::21)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|LV3PR12MB9216:EE_
X-MS-Office365-Filtering-Correlation-Id: e0719eca-1e58-4db2-46fd-08dee8f4bcef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|56012099006|10067099003|5023799004|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	g+KeJNk2AETlUxha87+u2jzgkeWdasxNYwW9SGTzJK+PHhTbTaHeKuwxJC0iQ6pQBsgCwoi4VKRVEl+zrTP7+HLwU31Y2/ZYsRqomSR3RFMhywGoPNVmOq8grbfThfYyjU9JzJ1tG09F0v2x9L9Hwd9g1HCJjNE3hg2jZFmub9h2CYxii8/IFzV5SSPyc280TzIMStXUZqPxFS+KET6dOLEg0a/HjVjgWrTriZtpfoTJZST1iUIGW88yJkA8q/tg5AjMsvL1izaAzso/VMuRBp2G8Hn8S/o2hJDLGeSZ4IvYfuwAeDQrmj2Qpuyp2XeCv1fEwd/zB5mJctv2Dmhle/Wc5YnvZBev53VsnuV/80RwE5Gxzi5y9/CMu6Jgniy3D+FnKJ/zx7tkO3PbehRrVPEw2Vai6BcBzToRTnGuOwPqHk1zK9BNSGWI+FzLZzR2ETR26HhTBjRjv1kmWbAEDjP3OaT5PPUVLTP0J61mSb1Mtse3KkfD+K52W+lRdKLoolLmbScL6dxOm4FAgtEMLJgrAIkCXeYU8XoV446YQVJnQTf4OvdlHiq4kWmXkHBIfPjdlZ3wvsFua1vOMx6pv4X/QVYpGmYhiDWU0861phZEINQ9aTXKXXf28jFS/5TX4p5qvFMcbCHij1x07cmY2WF5WN6rYiYnIjAk1E9DWUM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB6914.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(56012099006)(10067099003)(5023799004)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NnAyY3dNMWtOcDVkZUFzZWpuc3hKTE4wcFVZMjl3d2wyUk1XWkZLdWdGSXpJ?=
 =?utf-8?B?SmJCSnhiWDVadjVkR3JIMlhOWXF1cllvN0c4Z0QvWHBhMG5yR1FneC9IdENF?=
 =?utf-8?B?V0hteTFSMVoyRmRTSXVJRURFbkUvRlQ0WHZuak53dXlPKzBEM2dOV2dKRGMx?=
 =?utf-8?B?blBJYmZ6ZUlsd0lldjhlRlZ1TFNEZGRaVmN1SzR1SjhLbHBUOTNSVnFCODZ3?=
 =?utf-8?B?QVBXMTdmSGoxOTM2QzZ1eUpCaVI1ZEc2NHVOY0xWR0dhUjgxTmdZMHI5ZmRH?=
 =?utf-8?B?MUJ6cjVOQjNCUVVOc2FBNEYvWEJHdDFEY3VybXRuZHZHUmxQVDFJaU9RM1Ru?=
 =?utf-8?B?S2xlYlhIRjZwZjcxZVFHUW9DdEhJNHYrRklhdm8yZytWZ2RzdDNFTUJZOTll?=
 =?utf-8?B?cThuUXNzUklaYkk5TjVDeGFBWGNUcStzWjRjejJNUGE0bGk3SmVoU25XQlUr?=
 =?utf-8?B?ZTlIR2gxampJSjM5dXU5cStNNlV0SUhJdExmM0pnVGxMb0w2STVMVVB3Z0Z0?=
 =?utf-8?B?NUlMVlJyK0oySkthMnFtM3BMdE9BZDhZWk5KcjhxTXFtNDc4YjIrOEgzaUZR?=
 =?utf-8?B?S3FvTFU1N1FzUUowcEVVUjZCa0V2UHIxeTRIUkY4ZnRRYkRmNUxIcnZxTitP?=
 =?utf-8?B?Ym9YRXhtWHlYTTJyaDNjWjN5NVR0ZTlkcVl1dm5WMUloOG1nM01vZUxXeUgv?=
 =?utf-8?B?NFNxT3V2c1lVcklsbS91cnZzNCtselZtTUFtSG9CaHFTUGNuenMyOE1TNVJ6?=
 =?utf-8?B?WTdGaXdrN1BQVFJ4bWQyQVZRL3Eva3cvb2xhZkZ6ejBXblBZYlU4K2l4d0Vk?=
 =?utf-8?B?bnJZeGlNY0pmemNWdytETXoxU04xU1NJUnI5cjNhSkhzT01JQnBNTVAwNUhW?=
 =?utf-8?B?bzcwTWZyR0lyUmJ0WW85TzhFeGp1bFFJOTY3bkd4TktobC9mbkVGUzdJb2pM?=
 =?utf-8?B?a2JNUC9YeVNVS0NURHJ0d21vWUlSOU9tSFdNTS9obG5Ed3ZWbGVzazhTbUZR?=
 =?utf-8?B?Y3JxUHlUWVQ1ZTlxNEJBWm9jKzFnZmVtUVVocXYxSCtmbGs4UHc2MVdXVlM5?=
 =?utf-8?B?MiszNFlkVXI5RTdTSWRDanVTOVRLYVhpMmdDZ1pLeGJZOElRZXVVcU1WOHNY?=
 =?utf-8?B?bDBRWjl4ZzhmRkNiZW9WVGJwOGsxRzMxTzE1d1QybGRwSmxUd2dBOG1vNVM5?=
 =?utf-8?B?dUNNNW1pZXMzVTVZSW9QaG5GWVFtNUoybWRiZXhZTmhVMG5nQXVjMkFaZnZP?=
 =?utf-8?B?S0RpVXZROUVJcXZsbjZFcS9iR2dOZVFmaTFZNTdVSHptcncxdGNiMFgvSVdp?=
 =?utf-8?B?U2lraER4c3IrZmtyMTdEcWt0T25HQ3hsQVc4bTNkby9UNFFLK2F2NkVTRWRN?=
 =?utf-8?B?d1NDOFhpUFlscExpclJsdHgxbk9sZFVzSFl4dWxqTGlnYW5oMnBMdFNlRitW?=
 =?utf-8?B?SVNQMTE3V0JOYmRyQVZPYWJLZzY4b2RsS0xSN2w4SE1nQWZYWjNqYnFMWXBy?=
 =?utf-8?B?aXp0a05TbEw0WlE4cm1ZcXN3QXFyYnhvTUVkUjdFUmVvUXJhVnhwc1dxL2JY?=
 =?utf-8?B?eHNXZVB1NHAvQ21qNnZ2dDYvUUhuZ3FBUzBjdWZnWmNISE0rSCs0RWhRSGE2?=
 =?utf-8?B?SUpjcUVTOGxsY3preFJYc1V2MGU1T3BuSENVcTA2VnRxVmdoazh2RGR5RHZi?=
 =?utf-8?B?QkkxZU51bTRGSVlhY2M1dmNmK0pBb3drRG14b3hPQ3lFL21JQVpha2Y1eG5S?=
 =?utf-8?B?TkVoamlSMUJVWkxjUjFPMU9oQ3AzV1ZYVWdtdE91VEpiSkRvSG5IcHJLZ0Jp?=
 =?utf-8?B?VU5xUG5Rb0liakFyaXMwcWRBTWhibC9MZURNbHJObWhNSThYYkxuU3hGNkUw?=
 =?utf-8?B?ZUVhTFhlb2ZiZzhTYjRNRldYcXJURHF4NmZtSG9kTGlIYmVvZmFkV2poRzk4?=
 =?utf-8?B?czFVT1FwN0ZmMUpYUldCL0Jmb3V0RnRZV2pBb2Zlc1hzSkw3cEV5S0NCZTZw?=
 =?utf-8?B?OStSajNoa3dMRjk5TzZ6V2NXRHduZEZnazFuVmdPcDZubWdqeGl3RGlCS1ds?=
 =?utf-8?B?MS9WV21LcE0xTllyOVg5SWNTNjNlVkliakxkbGRnZjBiQXo5OHNJQkx6SFJo?=
 =?utf-8?B?QVljcFdZUlZVQW54ak1RTGFhc0ZyZHRYMVlsMkt0cENFcXpEQ0dHYVNXZFRB?=
 =?utf-8?B?YUszRHNHQjY3Y1hnTCtGYjRzcUoyRUVKcTJYQS8zQkdtNWNLV3ZrbFU1MGVk?=
 =?utf-8?B?NXJiVGZLQVRDTVBIYjFxbjg0bzJMdGRNUVVmSjhuVXJqbWRJbHFzQkNmamtz?=
 =?utf-8?B?Z0M3YTRobXlzYURBSnFqVXk1NWxSOXBLa3JuaUlsUURQaVo4T0Y2Zz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0719eca-1e58-4db2-46fd-08dee8f4bcef
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 19:58:17.4691
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uWdSL3qHWyI1aVj1MXcDZjsn/zHsr3Xg0blkABQ49SZ01AsVuFoLfrkkY06Guh86Mq0EyruA3riEKaZaeg89xQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9216



On 7/23/26 14:53, Bjorn Helgaas wrote:
> On Thu, Jul 23, 2026 at 11:32:49AM -0500, Mario Limonciello wrote:
>> On 7/23/26 11:23, Vasant Hegde wrote:
>>> On 7/23/2026 9:41 PM, Mario Limonciello wrote:
>>>> On 7/23/26 10:59, Bjorn Helgaas wrote:
>>>>> On Thu, Jul 23, 2026 at 06:15:48AM +0000, Vasant Hegde wrote:
>>>>>> Certain AMD GPU's must always be in identity mode. Currently its enforced
>>>>>> using PASID check. It worked fine as most GPU's has PASID feature. But
>>>>>> this means, identity mode enforcement is done for all PASID capable devices.
>> ...
> 
>>> +static bool quirks_force_identity_mapping(struct pci_dev *pdev)
>>> +{
>>> +       struct pci_dev *root_port;
>>> +       int class = pdev->class >> 8;
>>> +
>>> +       /* AMD GPU vendor ID */
>>> +       if (pdev->vendor != PCI_VENDOR_ID_ATI)
>>> +               return false;
>>> +
>>> +       /* GPU class */
>>> +       if (class != PCI_CLASS_DISPLAY_VGA &&
>>> +           class != PCI_CLASS_DISPLAY_OTHER)
>>> +               return false;
>>> +
>>> +       if (pci_upstream_bridge(pdev) &&
>>
>> I don't think you need to check for pci_upstream_bridge() to be
>> non-NULL.  You already checked that it's an endpoint by looking at
>> the class.  So an endpoint will be connected to a bridge of some
>> sort (either a switch internal to the dGPU or to a root port).
> 
> I think devices can be passed through to virtualized guests with no
> upstream bridge visible to the guest, can't they?

None of the GPUs in APUs support SRIOV, so there isn't a VF to be passed 
in to a guest.  But I guess you could pass the whole endpoint in.

When passed into a guest doesn't it end up associated behind a root port 
in the guest though?
