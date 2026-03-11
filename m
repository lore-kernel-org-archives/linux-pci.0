Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011019.outbound.protection.outlook.com [52.101.57.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9441434A3C4;
	Wed, 11 Mar 2026 15:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773244705; cv=fail; b=q5O0V3cYf122I0PHHn06q+aSvtZ23+LhyB7oaFNE0G7mb/kJuvoMSwtraD16Wsx9x7lTQxExTc5A7TrOqbw9WRVdM2FE3o9otD6tCWgPCgIxTYqcqoPXNnQed9oYqGPvS3gezh7BBA+XyG/BjiVnDcz61VR2KkWpbbmi7QtWAsU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773244705; c=relaxed/simple;
	bh=ZxhrpI1sNdxfvNyF7sw/XEevHJujMOj0+xMf1RFRLnY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sq9FDa81+XluaURLX+TePDU3pulwjwYiu/445DdgFBHKIZtNIMiOl/lEfRLERBCGqRqm4ltNt7tpWTxJ4w4029Y5qXJbGAcZl8on6GBMzDrJDVNRK5z07tpQm3t0+cSXwE1PsZafbJlLs6UI6HaVkqas4ZIEpZ/HnbAAcqmnNoQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QSYYZYjG; arc=fail smtp.client-ip=52.101.57.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QSYYZYjG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NIRPIJa0QDhPqzJWMXLRMNa2F4rYeAQbXvVPVMUFdSH1KvQeVf94WnKr6atjzORPdH0NuCPoq8k1iLjh2Wud9uj1HmJ7gmaQm1d8sDpOC4xu7Goo33j1BWh0q+mcPuZqnwQ24rXNHX9BsKjZ4IfSXfngQaCgJlw1nfSxVK91SLT07Rxm8Mz8QIGti/0mA/IDsqdfHLrOH9gAmoWtq2jmg9In3bXsp0OK0oGYUG5e0ErdmKb+Cf08+9CLcWE6kb4x9B3mg6Uly1xLbU6EJn4/a3V+EnDMib/KqVq8XoXFHLlvINPmawb89LoaIt1bvY0V8bs2ZTw8xBE5PCoWNVcTBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aZuPkJZtuRKQlaf7I0yoedEQ/oPRcVE7rrANlB23b7E=;
 b=m4K5x+Z2FqkyCTUu4d+bo7r5fBrvFPbZi7zYR5XwVazx5g6afC3VYDPCPBKstz7rD03HfmjbxWpN7aQNid+9lj7oJFjQtYPlWPfC13r+Z0yOo08t0smomLMzrewOgEGRLAoS5Uula5LEJ05Sk5oo2vhjfFQVkvncFF0KjprZvC+a4u6yOVK2qebi3wc2/AfNinXy3+WDEWx0dYWoPEvQx/ihhb4GXWoKrrKwk3X5OUAQI7HN050nqBun5PwXGkqu3dh3keE0Y2wxKX/s2xlLrJ+GcKKpI7Ol71TtaofwpPC1iplJ+9tDcrMo9EUAkEdgXUmHCZIsXYhDTEu2LV12tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aZuPkJZtuRKQlaf7I0yoedEQ/oPRcVE7rrANlB23b7E=;
 b=QSYYZYjGtNmX96raoeg6ocrEUC0Qi2cGsMx10rAg1PB+0qtpmXwaDAeYyyC1kES0rWJa22E0xispIXL/2qVdoMuLRIISXv2a2yiGPImM4T2XYw1ULRfNSeb512JgaMby/Ncp5kabrg13KuKlSkPG28QMGqr7Q7WW6mOolXEVQ5I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH8PR12MB9766.namprd12.prod.outlook.com (2603:10b6:610:2b6::10)
 by MN0PR12MB6247.namprd12.prod.outlook.com (2603:10b6:208:3c1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Wed, 11 Mar
 2026 15:58:17 +0000
Received: from CH8PR12MB9766.namprd12.prod.outlook.com
 ([fe80::be0f:431f:5f27:96d9]) by CH8PR12MB9766.namprd12.prod.outlook.com
 ([fe80::be0f:431f:5f27:96d9%4]) with mapi id 15.20.9723.000; Wed, 11 Mar 2026
 15:58:15 +0000
Message-ID: <5f5f5cbe-1a6c-4833-9d31-ca8df454a5ad@amd.com>
Date: Wed, 11 Mar 2026 10:58:09 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 08/10] cxl: Update Endpoint AER uncorrectable handler
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
 <20260302203648.2886956-9-terry.bowman@amd.com>
 <20260309141215.00006968@huawei.com>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <20260309141215.00006968@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0065.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::10) To CH8PR12MB9766.namprd12.prod.outlook.com
 (2603:10b6:610:2b6::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH8PR12MB9766:EE_|MN0PR12MB6247:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c5413dd-e351-4211-d243-08de7f87012e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|366016|376014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	/9xlUfeXkXL2Damj9UYfFRuaqw+erE09Ju+PUtNHZRRIx0ecQrSJLEHTEEp6lf7M2T7MrrfAgdNzvGK/filc+z+EW3xuc5jIiszfQR6Iyteqiqrij6/0EGyzkWOXsVziTbRITsMsq/1r5LaB5b/WeVf9EdNNufFBXdNYGVcZcqg+xEqJBmK2oMii2uPy533/8LWI9l+KzkQoZKjw0Tsa66PGqxmpORY9++4edi5e00V0Tq6QvEPyHPuDIgt647UA+C9WX5mXBLWlVZzJaAf4wwqRpcpNfB6TK8Ov/QdBQfFhcxA9yDOLjHUQn/2MReAGi2d8f7msnriOo6Ncxa4dH68NLCzU17qTIDH4XwZXm5G5BVotr4AC6S5Br74ultyySQNhFXgzAQUkg2RCk8pOlq3Ga0THK6u/kA/iSYUJRKdsQ+gXLVkYqEQaPnhQEVOJw0mndvVwAF0FhP8PN8lLCQwJxU6AXekh8S/bgwUomX/6UByy3/H7i0yfyOOh/YCVnebxjHbQLouOVS2R1+9rYyYevXVYFkM+WYH9OG3F/OY6GoO6mA7iApDYnnFLyw51OollcZQW5HIvZ4Rd/Vq0X9/V+O3XTAbdNKbTpklsTPEIhDd6q7AEuCrvZyeXcN/hDSYkL9475EhI/tdtdz8IVccvsgT8un6TtipDgzy4NMIiX9rrk9ZZnLdbQb63JL4YCIVbDxCHpGNtuy6JsTsB+khldWnIbfngsey8eHbbuQQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH8PR12MB9766.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZUoxMmhQcHN1Z25wbEE5VGh2NjFwZkRGYjhHQXVIZVdyV1JnZFdIZzM3a1lV?=
 =?utf-8?B?N09DWTlRV2hzNTJQYkwwRDZ2d0JtL0Zpb2lsOEp5czhoQmRaWWhoQlU3YnlS?=
 =?utf-8?B?YzV4Y3ZiczhzZmNFejNqQk8rb1g5VmZiZkU2bHl5WlY0dWd2aHNoS2ZVOENz?=
 =?utf-8?B?QkJYVS9FbmkzbVVMUkthMlhpNkZKVHEyY01zRW1WVC90aFlHZS9MMVducmJu?=
 =?utf-8?B?SldHZUxaTzFFOCtBZFBxaEoyS00zWEt2TERtMmkzaE1TZTV0Q1dMbzFCc1Jk?=
 =?utf-8?B?cCtWSkR5TU11aEptSldJaEpRUldWUEh4SGprVUpQMG91NGVMbXZmVmtEUnIr?=
 =?utf-8?B?Sml3OW4vMXRNanFYYjJhQU1OTHdUTTU1MTVmQkVUdWUwbXE0TzNYM1diNkh3?=
 =?utf-8?B?U3JoL0xreUdtU2p4bnhVRU42dmVQT0FlcW1objVDcHpyQnJheDNGRkpEQTNq?=
 =?utf-8?B?TVJPQUVZcXlSTklZMWNUUkRDbitleDIwNHkyRExRL21jYnoyR25XYkozMjEr?=
 =?utf-8?B?N1hCckp0dDdxZDZ1RElHZ1Qvc05xbXM0QSt5aFRnWlVNUnFuSmx0YThTandV?=
 =?utf-8?B?VEVWNFU3NEVMTzE5cThzRGthM2dOa3A4R3RtaDZjeEYvMUZ0bzNpNHp3WDNE?=
 =?utf-8?B?LzhpaW1kU1FyZHVOUGw5VjNxTXp1b2tOc2MvUUh0bnBxc0dEVmcxVlJ3V0JF?=
 =?utf-8?B?OU9XdzR2REhoVEhsK0dzbE00dVRUTzNUNU4wNXpNc2FqMDJwY29NOU5nRi9J?=
 =?utf-8?B?MENCMWVROE9BTFFFWldGb3BiK00wT2JhcnhJZTY5RzlTMjNpdGxTRG1ETE0y?=
 =?utf-8?B?Smp4TStyZVNzM1VKdnhYSVptSHExZWdjUERES1ZPUXlzOUFwRW81My9UcHB2?=
 =?utf-8?B?SUR5R2lzem43cVZQNFd4OG1oOS9TNzkyQm5TU2QxaXdPaWc5aS93VnVWSENM?=
 =?utf-8?B?OEVjSE9ycFFYbVl6cmFseU02NnJKeHU1TytMbG92UHFaVnE2cVZQLzQweHcx?=
 =?utf-8?B?blFNclh0MVd1RFBNaktUODZlakk2emJQL2FwY2RrNURyMlQydmhPaFlpT1pP?=
 =?utf-8?B?NGFpTFFXQ0RzZm5mSHJRVE84Uzhmbm9Wc0ZwSytQRFpjTFJzRDlaTVVvVnRC?=
 =?utf-8?B?NHZTeDd5QXJENGUya2hjdjRWeW9LQnVBVGRHZUV4RFZmZjB6ZlBCSXJSaGFZ?=
 =?utf-8?B?WWtYb3RJUjNpOW9ETVVlV3RvZjhUcEYyU1BieFJrZDBISHNuTXpIOFdEVGI4?=
 =?utf-8?B?K3J6Ync0bUFKSDQwY0loRzBPZC9XNW5KWUd1SW1zaUZPanNVWmh2S0hXUDhH?=
 =?utf-8?B?MkpyMzVRdHYxc3JBVDc0U2xyRnI1eFVEN1gyakJvTExNS2tjVGlSWE5xZXI5?=
 =?utf-8?B?Y1Iwdm4zNmtHbzRsS0toVUFheWZyRDdiMjM2aGdkTUJPaWc2NHFobTMzbjFv?=
 =?utf-8?B?NnkxUXVZMmlvQTVqd1E3SXFYRGEzRnpFRWpJbDltWTdmK09CMzlBUHI5RTFz?=
 =?utf-8?B?c3lHNndZVlZHd3drTHJ4ZFE3N3cxbENweWozTmlaT1gxeWpYRVVjNDVqeEpn?=
 =?utf-8?B?b255d2dWNkp6TVo4ZlZ2UGlaeFpObDlnZnMvdEFZQXU4N1Joa3lDUFJzUzZB?=
 =?utf-8?B?blpublpYM2JyUWMzdk1GZFpkamRoVldMbkhVQXZ2VVRIRXcyOEVMZkRFZG1w?=
 =?utf-8?B?eFJFM2RZVWM5dzRCVGo5amJ1RzZLRERvM0tGZldleDZUUnVsaHJ6cklmeEZT?=
 =?utf-8?B?VEYvYkRkK0F5YU8yY2JGUDZYWW1YVm00WC9IeEQ0Wlk4T0lzNmF4VFAzY0xE?=
 =?utf-8?B?dEd0cG9LSUVLalNJREkycjJzYlBKdmVwajJzS3RGRDY0QkJxKytFRWNlR2FE?=
 =?utf-8?B?c0pJUk1xS0NrYVh2bVBERFhDcHJMVkdFVGFDbzI3UGg0ZTZSbzlidkFPVEdx?=
 =?utf-8?B?K3JVM29QNFE1SzNxa3VJa3hiZHc2SG9LUjJ5VG9pd0ZMelAvb2tyeHl1NndQ?=
 =?utf-8?B?L253NUV0WGFnWEdoVkRKT1h5WGdHL0xUUlJLbEhoeG1LcnZxbjUraDEydG5l?=
 =?utf-8?B?cmNOVE5FSGJqY3Y1RWFSSytEYm5lc3RKeXMxMGgrM3lGSlV1cE9uNUNmY0dn?=
 =?utf-8?B?N1U4eUFTYlZBSnNjcWFtdnVPQlc2QjJlWmhncy9LcDFNOHkvSVdXNldCUEZ4?=
 =?utf-8?B?YnN4VGhFTDFDQ3JpQmJselp0UUpHblVjNXA3NXJUcmIzUUg2VWk2ZHFVSUpD?=
 =?utf-8?B?bTNNY29GOXVtVVJUZ1loamY5aUNodWx2MjM4eVpxTUEraW81RTFuNjk1OXlP?=
 =?utf-8?B?Ty9FWjBKZG81T3FhOWFvMk9GVE1HLzVNTmlnRXZLV05YeTFsWHg4QT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c5413dd-e351-4211-d243-08de7f87012e
X-MS-Exchange-CrossTenant-AuthSource: CH8PR12MB9766.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 15:58:15.1686
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X5TgnIBSWydIacmHJdmgLsJLjT0skpllm1ZwIz8JrOMub4DMaij0OKw1mE51tSTh2/r2oRkf8zPnm50/sdMfCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6247

On 3/9/2026 9:12 AM, Jonathan Cameron wrote:
> On Mon, 2 Mar 2026 14:36:46 -0600
> Terry Bowman <terry.bowman@amd.com> wrote:
> 
>> CXL drivers now implement protocol RAS support. PCI protocol errors,
>> however, continue to be reported via the AER capability and must still be
>> handled by a PCI error recovery callback.
>>
>> Replace the existing cxl_error_detected() callback in cxl/pci.c with a
>> new cxl_pci_error_detected() implementation that handles uncorrectable
>> AER PCI protocol errors. Changes for PCI Correctable protocol errors will
>> be added in a future patch.
>>
>> Introduce function cxl_uncor_aer_present() to handle and log the CXL
>> Endpoint's AER errors. Endpoint fatal AER errors are not currently logged by
>> the AER driver and require logging here with a call to pci_print_aer().
>>
>> This cleanly separates CXL protocol error handling from PCI AER handling
>> and ensures that each subsystem processes only the errors it is
>> responsible.
>>
>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
>> Assisted-by: Azure:gpt4.1-nano-key
> One question inline.
> 
>>
>> ---
>>
>> Changes in v15->v16:
>> - Update commit message (DaveJ)
>> - s/cxl_handle_aer()/cxl_uncor_aer_present()/g (Jonathan)
>> - cxl_uncor_aer_present(): Leave original result calculation based on
>>   if a UCE is present and the provided state (Terry)
>> - Add call to pci_print_aer(). AER fails to log because is upstream
>>   link (Terry)
>>
>> Changes in v14->v15:
>> - Update commit message and title. Added Bjorn's ack.
>> - Move CE and UCE handling logic here
>>
>> Changes in v13->v14:
>> - Add Dave Jiang's review-by
>> - Update commit message & headline (Bjorn)
>> - Refactor cxl_port_error_detected()/cxl_port_cor_error_detected() to
>>   one line (Jonathan)
>> - Remove cxl_walk_port() (Dan)
>> - Remove cxl_pci_drv_bound(). Check for 'is_cxl' parent port is
>>   sufficient (Dan)
>> - Remove device_lock_if()
>> - Combined CE and UCE here (Terry)
>>
>> Changes in v12->v13:
>> - Move get_pci_cxl_host_dev() and cxl_handle_proto_error() to Dequeue
>>   patch (Terry)
>> - Remove EP case in cxl_get_ras_base(), not used. (Terry)
>> - Remove check for dport->dport_dev (Dave)
>> - Remove whitespace (Terry)
>>
>> Changes in v11->v12:
>> - Add call to cxl_pci_drv_bound() in cxl_handle_proto_error() and
>>   pci_to_cxl_dev()
>> - Change cxl_error_detected() -> cxl_cor_error_detected()
>> - Remove NULL variable assignments
>> - Replace bus_find_device() with find_cxl_port_by_uport() for upstream
>>   port searches.
>>
>> Changes in v10->v11:
>> - None
>> ---
>>  drivers/cxl/core/ras.c | 57 ++++++++++++++++++++++++------------------
>>  drivers/cxl/cxlpci.h   |  9 +++----
>>  drivers/cxl/pci.c      |  6 ++---
>>  3 files changed, 39 insertions(+), 33 deletions(-)
>>
>> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
>> index 254144d19764..884e40c66638 100644
>> --- a/drivers/cxl/core/ras.c
>> +++ b/drivers/cxl/core/ras.c
> ...
> 
> 
>> +pci_ers_result_t cxl_pci_error_detected(struct pci_dev *pdev,
>> +					pci_channel_state_t state)
>> +{
>> +	bool ue = cxl_uncor_aer_present(pdev);
>> +	struct cxl_port *port = get_cxl_port(pdev);
> 
> This got a reference that wasn't (I think) previously taken.
> I'm not spotting where that is released.  It it is somewhere beyond
> this function, good to add a comment saying where.
> 
> 

This should be using the scope cleanup. I will change. Thanks.

-Terry

