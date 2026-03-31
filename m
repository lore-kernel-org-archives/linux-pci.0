Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012035.outbound.protection.outlook.com [52.101.43.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 645BD18859B;
	Tue, 31 Mar 2026 20:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774990216; cv=fail; b=jE9r0RjGw9XZQUyjaOTBCNRv8WySLcilakNRWsSUALF+iHRW7XD/RepQpkfqZhOY7TOq18MZurPtFZNoZUrSOUhqPl/Vj8m0vjmgHRyOd1TdGRpo/qzNpeYudhT9oDfubTSro0N2x6WaA/lFe6iSaw0NPRbaliu5hIgq5oCSfCA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774990216; c=relaxed/simple;
	bh=GxO0HI7c07hUBRlEtwSuz3gnA92iLPhK1BzQw1rzbrE=;
	h=Content-Type:Message-ID:Date:Subject:To:Cc:References:From:
	 In-Reply-To:MIME-Version; b=CSEUDpsVB8AlGlm+ErdWUIFJFHn7YZYCYVuuQLUqyIJ8YsspYIdZw+JkatJFdFkkghR0T8RDEE2y17jRHE12yR637sjY4ZA0hnXH9wZ66oY90qOIIDfYsvfz967SRxTF/WtVycH57OX/2wx9wn8YpRhlOJRhBKfJQM53vYD0gcE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=XvNjDOaU; arc=fail smtp.client-ip=52.101.43.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="XvNjDOaU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iMRpQHiawcAWt6Yq7K0HQyK429le7p0xNOIwBGfLN/rOHFYqlFlEqZzF5p4ywwsY3NCbT4H2rO/GVnRzvnypagSmY4SNBYqzJRX8R2r4ExPBPn3Lrlm6YxbHcgDHMEcDP4BAp0TSvchIZRLbKfppU/PS3O7JeCp40T1LJ+MjgqBs3ECNIlJw4QznH7iFnbOirM5NF48iv7hPGuxfv/eUs5P1AqNXwcjSGz2y9JeVC0uO7MHfE0BviBXojgY8QU4qpY5L4gtFt8mGPrE38ihe5lE56AyUeK1L4FqzlKKZWPdsGl21Hf4I7jieVn7Dhs/AMm+hghmpNF+g7qICxkQkOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4TvQf3hOOzEljeSd9JcB8t5FsfQISbuiBkR1lk9HVjA=;
 b=nf1O8J77E8ETV1rOIA34PNObtA9GJi21xc3OeJTqWNfkBzkFnJoNBeExlLH4PfpIiYdLMqIH0Z/pp3cci/d64RDtxHJdtkSr6SJvcAeEyGG1F7Euz1LiupqxkQlCyDSCAGVLQqAHVYatzsjRR04VcO5MrG2PprGGhvUqD+EbX7fd1uR0kEUhu5yrU3DYWR9fg9x9B1xNajrG7xXjFcw7M0/YP7weqFPdNz+vw4Whg9znMnVMrugKsQp3SKl93p0j5WExtZjsV0bJBROgysvQ0K/g6tgNrkJWrY37Vck+lh3fxrGeNZtVc+ci54Gb6/26idKYuBSw1WegFDSzGWNC0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4TvQf3hOOzEljeSd9JcB8t5FsfQISbuiBkR1lk9HVjA=;
 b=XvNjDOaUojsDn7/eL8ys62Ft3kOVZb0pZVKXi2iHwhE1BDAdX3EFMQDUR9jzuSuk3t2fc6gI6oompei4XCt9aCDgaduGGq//LBO5Q/v7zXZMoafS2kjtcKgv2G6XkU2EsAMXvfHBcevTSaVvIkfx/nEhuFHN517vzDdPzbycE00=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH8PR12MB9766.namprd12.prod.outlook.com (2603:10b6:610:2b6::10)
 by SJ0PR12MB6925.namprd12.prod.outlook.com (2603:10b6:a03:483::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Tue, 31 Mar
 2026 20:50:11 +0000
Received: from CH8PR12MB9766.namprd12.prod.outlook.com
 ([fe80::be0f:431f:5f27:96d9]) by CH8PR12MB9766.namprd12.prod.outlook.com
 ([fe80::be0f:431f:5f27:96d9%3]) with mapi id 15.20.9769.014; Tue, 31 Mar 2026
 20:50:11 +0000
Content-Type: multipart/mixed; boundary="------------Y4emQod1pN2PdpbDZVvp7nnr"
Message-ID: <2ffd2cfb-2a17-4b98-ab37-baf755a9a726@amd.com>
Date: Tue, 31 Mar 2026 15:50:06 -0500
User-Agent: Mozilla Thunderbird
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
 <e2583442-55a8-460b-90a0-7b56db0722dd@amd.com>
 <69cc1d7ee3088_1b0cc6100c3@dwillia2-mobl4.notmuch>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <69cc1d7ee3088_1b0cc6100c3@dwillia2-mobl4.notmuch>
X-ClientProxiedBy: BYAPR06CA0059.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::36) To CH8PR12MB9766.namprd12.prod.outlook.com
 (2603:10b6:610:2b6::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH8PR12MB9766:EE_|SJ0PR12MB6925:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a472aac-7c0c-4cf7-c6eb-08de8f6719db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|6049299003|1800799024|921020|22082099003|18002099003|56012099003|4053099003;
X-Microsoft-Antispam-Message-Info:
	EsI8htL/4eyNIM2lAbKp9/CiP7GsrtHcq/1hPT0luVLuC1mYXGeTDBTHwZOFZnsgFkUqBYp/058P3mhm62pvQh3iZBSkc6OJJdiY2NaKguVZTogxNsbAIRocNnHYgtFy8bMoWkLgqKAx6xdNbaHFO5KkcUOi27N54D1wiWyvdT/YNgO/rup59R7NVKJ5LiolkMKwpp1V32IXnwOVdSt17OEJmFv/qHKchOoAqlaTAtpOHp0atqwK9u6pNymeAgg22/5Nf8Pd0KnhCv9nRW9FJVc2qtrcsIvWGs3sZ1U1WUHGbwszZTQ/AyjIrdnghaEVhezlRkHx9w3ZShVMD1FmdtBQxkO2O61vVD2P4T3rYtSXgUfh837dt6uREpbIQOfG6YJK64Xpyw3vYJV4hVJlZaOua/gneLfVlHzRSG2G2L6/EihNGqrmT43zJkAei7gsWywMJb+V3FD0SLdE0Wk4HcVOG2LHu5JxivcSZR4fFowr3wfW0u3iMx9VE83CgGZWoXX9dwNH4bhbdAJ7doJVjuEgBmRK6SUV+gblFDPxpRso7Y4viLK0nSJ9NQa6FJaovQzZAFcbRMnvL963LdTYD9KPQVFK7+4v6K/56mAtp2RICDqchN3Aaq8Ml5CoJvKyuQa1zc5eMxb9gwydpNPlMtIA5O90s5ksyBO8CpqOQ+IZa4WAuves0nUieRw9gGlcGiLOnz5ikmkX5gEJrogBair1enbEsfXL4t9TqIjvCLg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH8PR12MB9766.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(6049299003)(1800799024)(921020)(22082099003)(18002099003)(56012099003)(4053099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZXQxUG0yQitvazZxalAyNHE2dE1XK2V3VStkOENpZUZuclVjS05Idm91WG5p?=
 =?utf-8?B?azZmRFQxMm1CYnE3cGRvMWZ5VzBpeXVsZkQ1VUhFR0RBOFNCYTFpSnZ2MHdI?=
 =?utf-8?B?Mm4xQjJUczNjejVKdnk4WGgyVnpBQm5oeWFEOHd6M3hXeFI3TFY2WmwyUDhl?=
 =?utf-8?B?Q1JDdWZjV1hWVm5OVWp0cVEvYmdiU25wRkhsbGdUQnhGQSt3UkhObmpGNW50?=
 =?utf-8?B?ZHpQQjYyWk9pK21ycXp3NWtkMnhRR0xweEdxbkNpVytRM3dYZ2pCUmNXb0JX?=
 =?utf-8?B?dUQ2WmpLMWR0M0VGVGR1S2hTNDJaY2xkZ2p1eFZmaGVSak1EZFM2SXFHaDlN?=
 =?utf-8?B?ZTd1LzVkRzFRL1NzSStzS1RiYVZJM21PZzR6dHpnWnI3Y2gwMkMrazlmUFlR?=
 =?utf-8?B?QTZ4dVcyWlJma21hdUZXNWFUV2V2djFqMlU3VkwzZVBlVUF2a01HWVIzbjN5?=
 =?utf-8?B?YzVjTGh1UGdGOElhN2lLcjZFVEdUdkFiSEdmNjI2UmlMTXFDTGNVc0xHUUZH?=
 =?utf-8?B?SEJWNXh6Q0ljeFdVQlZIOEgveHJEVUM1REVqOUFQZzNWY3N4aWNPZUJJTGI0?=
 =?utf-8?B?TWVsc3BOQmdtaUtJMGp3aFJhRVBsRXc4bnBPb2ozRC9Vc0VTQ2pCRnZmcjU1?=
 =?utf-8?B?RkRSR3VEUDhOeDV1VDB6MFhKbmJJRmVwRkYyaE5PampidEdkTEt3YWdoZHU3?=
 =?utf-8?B?ZHlxWG1EcmJ0V0pHRVRCMUtpeVh3ZytLN21VTFdXQUR5SE53Y0QwRys0MGpL?=
 =?utf-8?B?SWEyTk5LcTFZcWVmUkNYQjFnaHoxcHlOMDJiTklJdjNFZXFCUCswOW5Damsr?=
 =?utf-8?B?RnZzcnE4ZkdpOUpUblFkSWVQbUpPKzZCR09ZTTBJZTNnL3dIL2xtSlZNM3ZW?=
 =?utf-8?B?OXFRNTRwd1JWS0txL3p0LzVTVlB2eDczK0N4T3hQM1JoenIxQmJnSEx1dnJw?=
 =?utf-8?B?cDMvaWZXUGlDQ3k4bTlhVWg3RVIyZVRpOTJJbEFyWFNEY2xNeFNOemNpdHRo?=
 =?utf-8?B?cEVacVFDWStMNkg2RGRLM1BCcTlEcWFwMGlLZk1zYTNBVUplaFNaMmpkMkxZ?=
 =?utf-8?B?VUpkTitOMnRtb3hJMjI3UGdScytGNFErSDV3TGdZdVFFa2Y1djhheHYrR3hH?=
 =?utf-8?B?VXB3VHNxaTdsWGhPSmJtVjE5SkRjQS9za3RXaWpoQWJiSjZ4Nm1iWTVkak5O?=
 =?utf-8?B?K0thNDd1TmRiWkxsTEZXRWVjUlJrcW1iaGQvRjJrbUpiUm5YVUxsOERyVWw3?=
 =?utf-8?B?ZVlMcC9vaklUNDJlUW5Zd2VYQW9pR3hmSFE2Wm9YK1J0TjE3emlRaGEwK1dH?=
 =?utf-8?B?SVZFWFI2cGlUd3RiUmRLYnV4aWZvSndpQ1RhR0VsVllFdlUrbGgyS05LQ213?=
 =?utf-8?B?ZWFyb2xVRHNNeEFxYWE0b3YwbVpFU1A1MXdDdzgwL0JuYkRzSkwzWjdxTElm?=
 =?utf-8?B?YytSWjlaQ0VHWnZaajlkVURlckhXcGhkUmdTV0lRUXNOb0YzZFIyTVQzTXNT?=
 =?utf-8?B?U2FTdzhWYURubEc0VGNBNzNmZG9vcTl0dy9uNkgzQ0lsdWtkNEpOeWk3ajls?=
 =?utf-8?B?UUJxUGxKK1lNV1dqREJBd2pBclZ4MktjcDZDUFZJVjErVW51N3FsS1ZoN3Vo?=
 =?utf-8?B?UVNkampsZFIyMklkM1dvSS9pdDhtdmh1VzFaNlljR2RPTXNNMlpTVStMeUZD?=
 =?utf-8?B?U2ZVTGpEb0xGMndveVpSRzAwZWdyZEZuTFRBZFJzM0NlZW80WGZBYXRZR05E?=
 =?utf-8?B?NjhVR0dibUh6SkJQU0hEaW8xdDBMNWNVUFJsNG1iWkdoOU5ONU9ZRTROVno3?=
 =?utf-8?B?YnF6REhVemQ4dW1GNWZjNHNMM2kvbDNYUkl1b3EzbVYzN3hWeGxIMWRzbURy?=
 =?utf-8?B?ZVVoVXdTRW50d3BFWjgrbHF2VHNyNHBkcnA0VFZqVDRwNnhKRERnUGJQRi9L?=
 =?utf-8?B?K2RnT041L3IwajZ3MHBZUVdJby94aE1sMWFmN3hWdGk5RElwSVF4K1lJTVlq?=
 =?utf-8?B?VGVKTUpld0Z3eE0wbTZKbW4rMXNkbXFtY0lBd1B4NFRsakowUmlDWFBkUnBk?=
 =?utf-8?B?V1REcmFsbVdtaHlMUmdmTnF4NFdlNUg4aFVIRnBYS0o2ZlNCRWFsQjQ0STVl?=
 =?utf-8?B?eFdRVWN5STBvbFV2MitFUzU0R1pkL3dTRkc3aEtleDNTZ2loMnV5ZHlleFB1?=
 =?utf-8?B?TytNRm1KZHpJbThkTGhWMWxrNC9mY0xyN0lWcy9FYmhRd2F5T1JzbWVWWVAw?=
 =?utf-8?B?aGdIUWNSbFdxL045TEtxUS84bXVSUFlTS1lBdWEvaG9BSGhXMTJyV1Z3aG5K?=
 =?utf-8?B?dHV3OVRNeDdLS0dKOXEvOTkyMi9iVGVsTG43eHU1aXRCcGVMNWpDZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a472aac-7c0c-4cf7-c6eb-08de8f6719db
X-MS-Exchange-CrossTenant-AuthSource: CH8PR12MB9766.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 20:50:11.3051
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q9gb3yFQSKor2b0BLnPI7VsWlRPmniTKtSiTYA+ed1/uelcE26OvOtcNRj/YWsrqaMN7bJmqsBjM8Nutiy3C2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6925

--------------Y4emQod1pN2PdpbDZVvp7nnr
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/31/2026 2:16 PM, Dan Williams wrote:
> Bowman, Terry wrote:
>> On 3/29/2026 8:41 PM, Dan Williams wrote:
>>> Terry Bowman wrote:
>>>> CXL protocol errors are not enabled for all CXL devices after boot. These
>>>> must be enabled inorder to process CXL protocol errors.
>>>>
>>>> Introduce cxl_unmask_proto_interrupts() to call pci_aer_unmask_internal_errors().
>>>> pci_aer_unmask_internal_errors() expects the pdev->aer_cap is initialized.
>>>> But, dev->aer_cap is not initialized for CXL Upstream Switch Ports and CXL
>>>> Downstream Switch Ports. Initialize the dev->aer_cap if necessary. Enable AER
>>>> correctable internal errors and uncorrectable internal errors for all CXL
>>>> devices.
>>>>
>>>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
>>>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>>>> Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>>>> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
>>>> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
>>>>
>>>> ---
>>>>  drivers/cxl/core/port.c |  2 ++
>>>>  drivers/cxl/core/ras.c  | 22 ++++++++++++++++++++++
>>>>  drivers/cxl/cxlpci.h    |  4 ++++
>>>>  3 files changed, 28 insertions(+)
>>>>
>>>> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
>>>> index 27271402915f..c33d58fb7264 100644
>>>> --- a/drivers/cxl/core/port.c
>>>> +++ b/drivers/cxl/core/port.c
>>>> @@ -1852,6 +1852,8 @@ int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd)
>>>>  
>>>>  			rc = cxl_add_ep(dport, &cxlmd->dev);
>>>>  
>>>> +			cxl_unmask_proto_interrupts(cxlmd->cxlds->dev);
>>>> +
>>>
>>> Why here? devm_cxl_port_ras_setup() will just redo it, right?
>>
>> No, I found this change is needed otherwise injection fails.
> 
> Sounds like something worth fixing rather than sprinkling an out of
> place workaround. Port resource acquisition should stay logically
> grouped. I am also missing where this masking is restored on exit?
> 
> I have asked about your test scripts in the past [1]. Those scripts need
> to be integrated into cxl_test proper, or at least contributed on the
> side such that anyone can clone the tests and run them. It needs to be
> the case that incremental refactoring work can move with confidence by
> simply running the tests. 
> 
> [1]: http://lore.kernel.org/68815a66459e4_134cc710012@dwillia2-xfh.jf.intel.com.notmuch

Hi Dan, 

I'm attaching tgz with details how I tested.

- Terry

--------------Y4emQod1pN2PdpbDZVvp7nnr
Content-Type: application/x-compressed; name="cxl-aer-einj.tgz"
Content-Disposition: attachment; filename="cxl-aer-einj.tgz"
Content-Transfer-Encoding: base64

H4sIAAAAAAAAA+1afXPaRhP3v9aMv8M+dTq1AxI6vdpukynGuKWP3wZwmjydDqOXw6gREpWEbab0
uz97JwnEm+2kKW4adjwGnfb27nb3t7t3h3PvixaNxMiKK1t/E8lIpq7zT6T5T/6d6MRQZZUoqrIl
E2IYxhbof9eEijSMEysC2IrCMHmI77H3nyk5BfsPrMTp0U/vBx9if3QAtL+qEm1j/3XQMvujPYhY
dV0xHg4GYZSI3TASh4ETRhF1Esv2qegFCY0CC/sGrjh5IXEJC2MwAxuatsL+RDY1A+0va7KmGQpr
V0xZV7dAXocCvnD7n0ZhH7TD7qFCZUPtElfTXOKaLtUPta7uGAcKJYpm6l1idymchwG06ACICbJ8
xP8ALUYEJuYI2jSKRvBdwj4kO7zrW8H3Vt+VnLD/WjixEoosvWEZiAqn1Maeig7EOFIOj2QCJeYM
Qmto/4a+dAS/XFXbtR+BVMivgL4ImS8C+iLM+CLkvgjoi1B4IUzeCEKtwM/YVkjAiYdRPBnLi6Hv
xbEX3IA9TAR8DCh1qcsnkdA4YW9qb89gEIVJ6IS5AInPOOlRuG7UK7VGfSoxEFhzEoZ+ypQzeAEu
+z7xUMFdj08J6L3VH+BX12MTDVGlgtDybgLqimG3K9qjXOHHXNOr9C6KogAIcakHq2gMoECplLL5
9P4pbKOHpB0gW6kk8qGzZcSVgsalicbHzBlKRSr06FqJ5U95c/GLPXSutBicnhXcULcMqoYajGnE
FBrvlfbLoIFLfZo+i/sCOBFFh4R+6FIgPD49PNOHe8zOVBBcr9sFUbzxErAqqfLt9FPwAhc1bMmW
S3RFkqiuW6ZKMonMWnkPAZc26fX99yCqcpkgTtiHCtgQJ9HQSZg1OtzvOuhEAuy6tOsFFOCq1ujU
m83O9UWtc149O+20z6625XtEmcagtl15CeeWj67cR4/Gd/CysqJ3vdaspT0P8p6sCepsVGglVjKM
V/e+vmhdpwMTOe9+HWSIwKGb9PchYokJKC0V0Lho15sX1TM0PpPCZy+nzoCiGjPgXT6N2mWz06y9
aaaL4FmHzaJJHerd0ugJC2ESjqsnUx1yNTIhx1aqvaf0PjkrdD+YdGfNj/Zv1q86zcuzs7w/STWJ
zWfVd52L63Nohr4fsuU8KKPdOK/niiCZOZp04FsjaHt97M3+h8MV9mBSarlBMilaJmWJJRiYWSPc
hp6LkPSSDrrr3jLPhZf4df/b2R7x0O4/oc8C3FgQs/NvGeQMohCqUUnSupbrynQRcox3Cjr2xGB3
oHDYsY8MdlbiOTn63tMR/CHA9n/r795Uz/ZyoJWXwm+/POVkCCovwKzIwYFTXsQS8pRyntwU5aWI
KUpj/l9eQESRI/Pv8jKnn+djLrvIyFpnxsx8trzUk+c5uWcusvLm4ppri4uecUsm989vmfNlpsK4
DE5/0EFb7TmYAJLUuV5at2UoPtu3+4uuNMrcYZS5EdWp45iuJOmy7DqH5qIbjQpONEojt1bGlMj/
Tx1oAok99m2fT/jrJHxPA6jWm3ByeV5tXMDxdQtO6m/g9IIvtnECaGBcbatdbeOrwtcf69WTerNz
dvnDRM53wbD/GtpNJugEY8zVZaN1ecHsCae1K+x8nqo3/VY9vmy2UfzbDnuE5tvO5Zt6UxBnhOWu
nGYA7o9zHMytIHMbyL0CcqPDxKRC6THBkFt0jvWpI8DEJeY00np3fnx5Bhg0j3Eek3cI6deZllGp
+IIbzzTLRINS+oENvHbsxDxcd3wvxmIVgx/tD5IRxrzt7e0/4MULeAXyt/AnOji3a7HPUWaQMTfJ
uGiUMTfLuGCYccE0grg9nppnnBsIv010N061N870N86XWPrwnpOsOxGSreWDVj+eZy88T3hfEBzk
hTLVl1jUFrf2eGLv8dTi46nNxwWrT1f9F8XUVurg669hNlI8XOXaD78XAnqXlv2F4jILN1m9glmL
WLpsqjzOVFx6WwmGvp9FmoelMyeWyzKUSJrBMK1jrmbbLLCKGyaws1Imzd/YP+SbGBzMcyjceUkP
etRysUbwwxsm5S6M3BhkILgxUCVsYY115EOWeEAdrzviEhBTgMEONzfsCbclfXZu4LPKIhzwTU+2
q+v3KcZqtkOjrpcwaVl3Fvg4v0398A6GfFOWCuPz50M0TvI5XIRYqSc9K4F4FCe0j9qN+ndWRCvH
jcsW9LHY6Vvxe3Bwi2CxvVa68cOBKziTIEwgoqw8ZbKmS07Xm45RZf61m0/tl5+Rjn59+1Z69076
n1AqRuhpEJtG6FxnK5xobuNjr3rzJMfRD1RTcx9xnDm5D7lMMLt7TruiOotbiaUexD1m1on+bR5U
zragTLCHK6BYjnvJiAlc8K2PcqyZ5P+gZ6G1BUVSDyVFEFaf/6w4/5MxAuPURdwxo0esONd7Kj18
/icTjZD8/M+UTWNLJqaqGpvzv3XQs5z/KRr8NPSz8z/9SD440g5WnP/J+flfflCWRiEG+FZ6giAI
x5EVOD1+WmchVCPoskVhBKHQS5JBfFSpYHztDW02kcpviLnIc96z8lzkx24oIp35Htk/EuAjjxsL
p42b47Y1H7cJthVTkQV/D13ngJgycWxblamqW8QyDUc9MI2urhuHSveQ2K59aOrEfmKI/FdTMf6j
wt0+lZL7TxzoHon/CuHxP73/k1V+/2fom/i/FjqhWL34MfSwJGLFGjuIZTcazWorK5GmYRLBfLQj
7AhtLJqmrfwyA9yQxsE37ILD8YeI2GL8nLteKUOtzoPnda0updLmL2CwzCpeteQTyq9cbOpYw5gX
WSPOiw/ujoDzx6DDD3SZeKy08uqRCXAj9kYCPvsksbDUcSErecDBqtbG9sHA97A5CXcEK7vCmU52
bpqTNc7pTVqlozvP97GC9UeQtyITO+pJxbFROAsrEXM9TmW2e5jg8G8QhRgo+/wIKVcEoriDsdj1
aQeBvLef5qZpI9sHpy/YADuCSxM2vgzp5piz+9S6pUCtyB9J0GAV6XvUbTgMmBpwXHuEZbXrcpdA
PdvDm1R7qHdWJfesyHUwVsd8VT4mYm6yTFN8GBSbfBOny3Mp29cMUaSP1XhcvFHb4VdkrZ+Z+F7M
tfkSriJM578PvdhDrh1B5Mql7Ai4y0uPJYmeWcsvZHnWi901eBFa+D0akvrs9K/r3aBX1y4vThs/
dKq1q0anelVvdOqNi59ejSYv0A4dXE+hBQv0Ohqvg3z1Wpu94PNMHWpHOOWaw42BlNfVXMvoKzN+
VnCSMrAsVihjbF7X7Ah7WULb586LLDTgBUcRY86HXHBKkE625UTeIIlTb0W/uvUY4uK0NfNFRCEM
B67FgcetVNgyHZ+cpgba+VLz5+dOxfyfGf6Zfv+T/v7DNAj//Y8pb37/sw5aZn+2VNGhWViS4o/f
+af0mP01WdkiuMc0iKzjE9rf0DV5U/+tg3b/U7G9oIKZpycIuzxl8yzEIv0x+8IMdCQ7uNOXZJab
5HvZye6fD2TsgWVRVkRE9MbjeQu5sCAoMBJkFHYldvjYp32l+OpQhjt87iIJuzFNBo4HYjw7qnxP
iCz5r+R7dtMsCFIlTYBiElkOldjMpUKeX+j/8EbzuS3wvLQM/3Pa/ctjPIZ/VVMZ/k3ZwK2gyeK/
oegb/K+FZvBPnV4IBF4DVOJRXElr5Aqv9SvMG7AErNBbGqCPoN9kfjLt9aRObFfCfsNRwGL6e46/
Jm6m3p0V+Nwq/kfTUvwPPmX2f0L+V3We/2XNJLqhc/zLm9//roU+x/xfYOumHArR2PsPKA26m9KA
0zL8D2Nx+CkDwGP4V9L6H9O/YRDFZPhHQ2/wvw6awf8S9Owuh487Bx9+IbMCakt5vyiQ/YNpBf7X
mv+JYWT4V4lOVJ7/ySb/r4Uew/80ZXepMZOvn4j2LzWxfia0DP/umvM/UfQp/vn9r6Hq2gb/66DH
8L8c5HST0v8ltGL//xz414miqBgFUvzrG/yvgz4O//O75w3+P1dakf/XW/+n5/9p/lf4+R8xN/v/
tVAR/7bbffVVltu/elI0ePEH9vlzU+x/vrTy/v8TVgCPn/8V8G/IDP+msvn951ro4/L//MX6/O+x
V5waLu22iQ8b2tCGNvQc9H9qRFIVAFAAAA==

--------------Y4emQod1pN2PdpbDZVvp7nnr--
