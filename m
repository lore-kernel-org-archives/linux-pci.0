Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013018.outbound.protection.outlook.com [40.93.201.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DECD47012B;
	Tue,  4 Aug 2026 14:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785852626; cv=fail; b=CD7IlsxxxjlL2fkc2sky6y7ju4a8dkeICbGnFQ2Btrt83fb2D3iLeijb9Ma5uqqIOPIun0rt56eAgyVqb4C9v0TrfgxYNaFebat0imt2FU1Mv54T0inMAE0IaAQJTu/GAv5k+hMLSMSZMtJUjSCn1G2b6Ob0Eh6YkFutXgLrxmI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785852626; c=relaxed/simple;
	bh=CzY6xFIP0SDsZ7srVvnQskFh5PkbPhcYJBaMHOG8juU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Gtu6YjlPQHt0VnhmOFunTrXEpVyvTI+AegvD+DHo74qjkIphhIuprshAYXq4MTzWQc+GrAjox4qFB6n76UXTXLEcgA7qgQkN5cDJffkKjhm1imLlMPbppxtMIgwbQ0sWrX5krTD1I6anSe43QLs+xj4FtprCoqDCKW9xxoXO/ec=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=CExXZwln; arc=fail smtp.client-ip=40.93.201.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="CExXZwln"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tRjAo0QysbrPXHILiy5tJY8/wc1t1rsVRR+bX4DSAOMYFW2Y0aP85AR4qA7zpK2s5LtAEWh7BH0oH4Dsu5bpKsd08R0cyMD0qVCnDRXMaFDqUELYtHe/rK0ky+tn7yeT/atNuM9/7jQw05vDGnrO7i6W9VmlEsijB7v5VEuThIWzoVOWRoMtGS7azFbWzqv69vO3Omtdspu4Kits6iiWJHS7Objv44tVr/8RGa4V8seViGmWf4+Rn636LnF3oPQU8M4mBXomvOGFly8qCvtjpq1iu8DTi862ypPtyfeAZCYbADJZaulDCq7Q7tVfOzfIzYIaEU1W5SYjzAvLwcvjxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YR0GaYGD9sdYpS0MnW3rn/vaFRlUMd5EqxgBPLFzSmQ=;
 b=qQkNTR5morHV2G+m8sFLcPMUAf47homG4RXX2hvnASCJ3XSnvYq7xX0oXZsuvmpimkFa3rZuwf4YYv4TRdytrqx0uUcOR3tde2Qs4yX6UDsAsW5Wrw+GDYqBt3GN/IMgHjZLhnZ3sfw01UT4Bbr8yD6NtlGMYEMv7yofcPwWYYaBrWyWrLsoTWwXVIQhug++nRFjEgvj/Ci8QXB69btZTCC9/RRDO2J5tm4wc8vQL4wkTk8DOaPr1JltGMzzQR6I357BHN688lHQZaQwXPPvGedXsjBpFukqLgZ+M5JbdNFxOWmXJIjo+F6DpB0Y86ROMYQkdhcsnLvuPu7UPdIl9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YR0GaYGD9sdYpS0MnW3rn/vaFRlUMd5EqxgBPLFzSmQ=;
 b=CExXZwlniS+i9zRzqkexoqArzJc1q/obygiNKAxJhQkRGXwbVkbxrz7ARgg61l79IK/oadCOo+YQfZiNq7wgQb98ttsVdncA8/qnmjZ4w9eb7DTZXm5oypryF5rvtkTl9UKLRSQTN2FkVeVgI33zL7YjaW6JCHks0UHwu13ni/Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH8PR12MB9766.namprd12.prod.outlook.com (2603:10b6:610:2b6::10)
 by CY5PR12MB6621.namprd12.prod.outlook.com (2603:10b6:930:43::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Tue, 4 Aug
 2026 14:10:08 +0000
Received: from CH8PR12MB9766.namprd12.prod.outlook.com
 ([fe80::be0f:431f:5f27:96d9]) by CH8PR12MB9766.namprd12.prod.outlook.com
 ([fe80::be0f:431f:5f27:96d9%5]) with mapi id 15.21.0292.013; Tue, 4 Aug 2026
 14:10:08 +0000
Message-ID: <26d1a846-4405-4e5d-9e6a-0638fb0d3bcd@amd.com>
Date: Tue, 4 Aug 2026 09:10:05 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v19 06/14] PCI/AER: Introduce AER-CXL protocol error kfifo
To: Richard Cheng <icheng@nvidia.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Davidlohr Bueso
 <dave@stgolabs.net>, Bjorn Helgaas <bhelgaas@google.com>,
 "Rafael J . Wysocki" <rafael@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 linux-cxl@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
 Borislav Petkov <bp@alien8.de>, Hanjun Guo <guohanjun@huawei.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Shuai Xue <xueshuai@linux.alibaba.com>, Len Brown <lenb@kernel.org>,
 Ira Weiny <iweiny@kernel.org>, Li Ming <ming.li@zohomail.com>,
 Shuah Khan <skhan@linuxfoundation.org>,
 Ben Cheatham <Benjamin.Cheatham@amd.com>, Robert Richter <rrichter@amd.com>,
 linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260803221810.3685703-1-terry.bowman@amd.com>
 <20260803221810.3685703-7-terry.bowman@amd.com> <anGe95AFo-98IbO9@MWDK4CY14F>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <anGe95AFo-98IbO9@MWDK4CY14F>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0189.namprd03.prod.outlook.com
 (2603:10b6:610:e4::14) To CH8PR12MB9766.namprd12.prod.outlook.com
 (2603:10b6:610:2b6::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH8PR12MB9766:EE_|CY5PR12MB6621:EE_
X-MS-Office365-Filtering-Correlation-Id: c777f211-6043-4479-c356-08def23216fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|376014|7416014|1800799024|6133799003|56012099006|11063799006|10067099003|4143699003|3023799007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	xpjcPJhMhXr1uSKTHFoqIDgzPg38qisOqpe5K9huK1G0nCifdjh2JzFOOIQCHvDN8iQkqNP+XqSSqAZt2Wlu3UxDyQ0Va+g4WdDDTC2D5ycTLX3zwHXLAGkEZJhet7y+m9eeSxq8AEb4XCWvaYwGPJbEACFo6kSBRpctSGv9nI59gNUFZh/rBpNcP5Ldya6zciICKaa0vZ4yaz6K9XUc/oRa/IMRiocgYz9SE6xpZyUQ3k7jpmLy9cQZLdCkd/65mzz7kMpgPR4I01nGm+Vai2pWeylrzb/Pk7rtD4wu17XPpH44Rs9UarZdhvBXfalwM7rqkFYC5lRMCCyB6+CzcXdCWtgquZRift/rajsLvsTbyQd8M47JWkTZSSIvkZ1RZrk/C2ZCJw+Fo4oFNwB1L2prgqJxbSX6MOY3fcKN8p7F/ha0eGR5CJF69ZuwSnXuQS/wzkp63LaWmSU/6iwysYKifoeCIGksM3Ve8Gi4hdvN9KO9aYmm/5BxkT+HuIFJhIg6GChhpIdBv//z7yvkVtO4VGidnoULVKqeUdPoohmhHOz5wKrxkvdRrgRymRp2CDC5DUy1Jy0PognJg564HrG2qajso6mRJiOhEIp5eXfAFgjadNnB3L+EiJPtU8yWyvWBMjV/3H6BMJuqBCPG+L9ONEy8Aud76ot/QqefPmg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH8PR12MB9766.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(7416014)(1800799024)(6133799003)(56012099006)(11063799006)(10067099003)(4143699003)(3023799007)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VWVEa3Z6QVNPU0V6V1d6Vm1mSDMrekpjWlhOTnhwUnJPejZvbE4xQVFMeDRy?=
 =?utf-8?B?QWphYjM2Q3dEMG82dzBCVmZzM0Zyc0lRWjYzaWhxaVUzSGp5cldqTnlIbllW?=
 =?utf-8?B?ZzdOak80ZjJzZmJnc1NsZDlReXlRMEJXOXlKU1o0ZTV0Q2pUVDJTMXNNQ09R?=
 =?utf-8?B?ekhzeU13Wmh3RzVXaDZwYmh4T0Z0cE5nMitWL0s0UFFPMTcwWW4yY2xSbm9Y?=
 =?utf-8?B?R21jdEM1QTB5bXN5QkdmczU2VVlFTDdYR1NsTjQrSGQ2cFJKRlU3RnZZWVk2?=
 =?utf-8?B?ZVdhQnlYSk1vVjhVeGxDWkxDK1pWeXhDUXlaUndWR0w2VlM4Z0dQTVdQSUg5?=
 =?utf-8?B?QmpmajIyQkVmbWYwTTM0d3dYdWdmcGNIUit0N0VWTzdWNVl4RmxXQk92STAx?=
 =?utf-8?B?ekdMdFlGUmUyMHdIZE8rY2JlT3o0WkREMHdtOUpLYThjVjh2N0NLbGp5WHB5?=
 =?utf-8?B?VWJqYVFmaUJjekxmT3J6RTVXUGhKNFl3VVVveGp0M04wMXh4MnA3bktSTzNO?=
 =?utf-8?B?d2tYUXpET1pSZVNjWGhVdCtUZUZYajFrZG1QMUJwVGRiSkNNOVVXMEwvUmdQ?=
 =?utf-8?B?MlpxRW1BTXZkWEFnVTBnblovMnE3V2JQRmFnQVhUQ1A3c05sVzFZeGxnQWdJ?=
 =?utf-8?B?bDBMdUwvd2E0Y0lhcE82UDBQdFE1a3p2MFhxbG1KYXlRY3c4SXM2VnpkV0Yy?=
 =?utf-8?B?bnpDTkxNNVRxbzcwbXBYaHMwdElkNXFZb01Fb2FueTZuYVJZdVJyQTV4OThM?=
 =?utf-8?B?azZhL0FoR1d0ZlpHYW9OekRqUHQ2M2dGL0dRaUplWFc3T2VDa1Z3RVpCcU5k?=
 =?utf-8?B?ZExVN3V2OUdMZWZFd2QwVWJrSUlZWHFhb1NUdWIrUUYxM0tSUEZtRHhqUzEx?=
 =?utf-8?B?Z0laZkVPZUJYcWVkaGpwKzBEelBBVEhNak5zNkxOYy9kY3RsbXk2dlZqayt0?=
 =?utf-8?B?UzgyQjM4Y2RYSmdCS1pFV3dWUHluU09Od0R6WFJhQm9vMUZSYU5MZEQvL0tR?=
 =?utf-8?B?TGtGcHJYTXh3UzRkb3dCUXZodVpGN3YwWWpvZUpHSkRJekZQUWNWM3lMVWdF?=
 =?utf-8?B?YmxPeU5TbVFQSjY3SklkMDdCSS9IVGI1dmJQOHN6ZHMzeWYyaVNZUjJvVlNr?=
 =?utf-8?B?L3YzcUh3TDJCN0twajdOcVdUMytLTWlqOUNtcFFHS3NtL3lXbU5HQm1mV2Rx?=
 =?utf-8?B?T2I3K1pERURFWVpXNkRFaENzdU9pdytOU2ZYQThLTldZeFlYUnVrd1EwTnhl?=
 =?utf-8?B?WDBzUG1XOTIwK0E1NzZBNkFmdlFCTkh5dUpYVFpTSjduVzAvVVlzODUzV3ps?=
 =?utf-8?B?ekQ2QWZ6UWtPWVRpbGh0OHFoL3BnU0cveE5lRWFrdFlPUTRLOVVuZk1TaC84?=
 =?utf-8?B?a1RHY05nUlhGT3VSZG1nYWFiQ1RnT0hmbEVEdktKdGNkVkd1NFZSUTEyU1Z6?=
 =?utf-8?B?YmFuSCtCK3o5dUphR2FKY2plRmk3YTJBYkNYNG8wUjFYN0xMWDVQUGVhcDVB?=
 =?utf-8?B?SHRQTTVDcGYxR3Z0M1dxYjBKWDdScnNYMnVESENvVWhaa1RDMGpwWVpIdDhv?=
 =?utf-8?B?cDJIQkdjUjVLancybE5wbmw0VVNiMmlSSnhzS29VbzU0V2JkankwY3h2cFJR?=
 =?utf-8?B?L3V0NnNOaVE3LzcxWVo0V2FFMXJzVG9EVnQzWGdpcWRnYWdtYUhNZXFvaTJx?=
 =?utf-8?B?Yi9LZXFlZHV1UHVuN09xcmhDZGdhUVFYdm03aWViNTZUWlErK1JjbUwrcldj?=
 =?utf-8?B?ODhucFNBTnpIVWF2cGFWWEQ4R1JzdHFmbmpvVzZCVnlFcEgydmsyMGV1UmdY?=
 =?utf-8?B?bFlVRUwvakgxS0l5cUdrMDd5WG5CV0dydG5NcEgrYnZRdXNPdnMrb0lNUG1u?=
 =?utf-8?B?eUQ4UzN1ZzBndndlYjlwVTZWZ1pDQ1g1ZFM3UWdDOHFkNkdnV3pTT203bXNj?=
 =?utf-8?B?OGh1bTcwZHFXbUdrRVRwelE2b2g3NEljRnRGTkFzNFV3dHVIY2tZQjlzZ0pv?=
 =?utf-8?B?aVRVeThVNzlzSDZTYTZTNjhjL3U1QXRadzBYTGNJYnczOFFJQW9nbDNZMkRi?=
 =?utf-8?B?R0ZUMmczdkhYTC9tVUJueVM5NFZ2NWQ3R1JIc2hrWGM1K3Zpdy81K1FsK0x4?=
 =?utf-8?B?dUhsay9XUyt4ZFFVWG1yeS9jTXBxaGFGRjlIRW14N3l4MWxJeWRkS2NyanZh?=
 =?utf-8?B?dithYnErL09ESjNpSll0VmRoSlIvOFpnTVArWFBaNDk4S2NWTTFJM3U2ZWJB?=
 =?utf-8?B?UWRKblhTK2RXVmpXdmpKamNCbGd0QUw5MWFLMTBwbGs1dTMrR2VMc25oRjFT?=
 =?utf-8?Q?hOCjm6sQEgrf6Paema?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c777f211-6043-4479-c356-08def23216fd
X-MS-Exchange-CrossTenant-AuthSource: CH8PR12MB9766.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 14:10:08.2502
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jkl7wzwSatLNGOLr6UOK2Md9x6P4IQw2vOQN1LQkymx39mV53W2Vo+yHjQtfQQ8EpICXGBNJwsDROFkwuTroSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6621

On 8/4/2026 3:15 AM, Richard Cheng wrote:
> On Mon, Aug 03, 2026 at 05:18:02PM +0800, Terry Bowman wrote:
>> CXL VH RAS handling requires a path for the AER driver to hand off CXL
>> protocol errors to cxl_core for logging and recovery before PCIe AER
>> recovery tears down the device. Introduce drivers/pci/pcie/aer_cxl_vh.c to
>> implement this handoff via a kfifo-backed work item.
>>
>> Move is_aer_internal_error() into this new file. It identifies AER internal
>> error status bits across both correctable and uncorrectable severities.
>>
>> Introduce is_cxl_error() to gate the VH kfifo path.
>>
>> Introduce struct cxl_proto_err_work_data to carry the error source PCI
>> device and severity through the kfifo.
>>
>> Introduce cxl_forward_error() to enqueue a CXL protocol error. A reference
>> is taken on the PCI device; the consumer releases it via
>> for_each_cxl_proto_err(). On enqueue failure the reference is released
>> immediately, the error is dropped, and the consumer is scheduled to drain
>> existing entries. A subsequent patch wires cxl_forward_error() into
>> handle_error_source() where correctable and uncorrectable status clearing
>> is left to pci_aer_handle_error().
>>
>> Introduce cxl_proto_err_wait_for_empty() to synchronously wait for the
>> consumer worker to drain the kfifo.
>>
>> Introduce cxl_register_proto_err_work() and cxl_unregister_proto_err_work()
>> for cxl_core to register and deregister its work handler. On unregistration,
>> pending kfifo entries are drained and their pdev references released before
>> cancel_work_sync() runs. Export these and for_each_cxl_proto_err() via
>> EXPORT_SYMBOL_FOR_MODULES restricted to cxl_core.
>>
>> Protect the work pointer with a rwsem to correctly serialize
>> registration, deregistration, enqueue, and dequeue against concurrent
>> AER IRQ threads. Serialize concurrent kfifo writers with a spinlock.
>>
>> Add MAINTAINERS entries for aer_cxl_vh.c and aer_cxl_rch.c under
>> the CXL entry so CXL maintainers are CC'd on changes to the AER-CXL
>> bridging code.
>>
>> Co-developed-by: Dan Williams <djbw@kernel.org>
>> Signed-off-by: Dan Williams <djbw@kernel.org>
>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
>> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
>>
>> ---
>>
>> Changes in v18 -> v19:
>> - Rename cxl_proto_err_flush() to cxl_proto_err_wait_for_empty() to
>>   better reflect that it waits for the kfifo to drain (Jonathan).
>>
>> Changes in v17->v18:
>> - Remove correctable status clear from cxl_forward_error(); the AER core
>>   clears all status bits via pci_aer_handle_error() info->status writeback
>> - Schedule consumer on kfifo overflow so existing entries can be drained
>>
>> Changes in v16->v17:
>> - Reword "kfifo semaphore" to "kfifo spinlock" to match fifo_lock.
>> - Defer the handle_error_source() is_cxl_error() switch to the patch that
>>   registers the kfifo consumer to keep each commit bisect-safe.
>> - Rename rwsema to rwsem
>> - Change CPER exports to use EXPORT_SYMBOL_FOR_MODULES.
>> - Add work cancel function.
>> - Replace kfifo_put() with kfifo_in_spinlocked() for multiple producers
>> - Add fifo_lock spinlock for concurrent producer serialisation
>> - Initialize the embedded kfifo with INIT_KFIFO() in a subsys_initcall so
>>   kfifo->mask, ->esize and ->data are set before first use.
>> - Clear PCI_ERR_COR_STATUS in cxl_forward_error() after enqueue so the
>>   device is acked for correctable events even when the consumer drops the
>>   event. Uncorrectable status is left for cxl_do_recovery() to clear after
>>   recovery completes, mirroring the AER core convention.
>> - WARN on double-registration in cxl_register_proto_err_work() to make an
>>   unintended second consumer visible at runtime.
>> - Add direct rwsem.h, cleanup.h and workqueue.h includes for symbols used
>>   in aer_cxl_vh.c
>> - Add MAINTAINERS entries for drivers/pci/pcie/aer_cxl_*.c
>> - Update message
>> ---
>>  MAINTAINERS                   |   2 +
>>  drivers/pci/pcie/Makefile     |   1 +
>>  drivers/pci/pcie/aer.c        |  10 --
>>  drivers/pci/pcie/aer_cxl_vh.c | 227 ++++++++++++++++++++++++++++++++++
>>  drivers/pci/pcie/portdrv.h    |   6 +
>>  include/linux/aer.h           |  24 ++++
>>  6 files changed, 260 insertions(+), 10 deletions(-)
>>  create mode 100644 drivers/pci/pcie/aer_cxl_vh.c
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 5114e6db7307d..3a1f1057a21e5 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -6527,6 +6527,8 @@ S:	Maintained
>>  F:	Documentation/driver-api/cxl
>>  F:	Documentation/userspace-api/fwctl/fwctl-cxl.rst
>>  F:	drivers/cxl/
>> +F:	drivers/pci/pcie/aer_cxl_rch.c
>> +F:	drivers/pci/pcie/aer_cxl_vh.c
>>  F:	include/cxl/
>>  F:	include/uapi/linux/cxl_mem.h
>>  F:	tools/testing/cxl/
>> diff --git a/drivers/pci/pcie/Makefile b/drivers/pci/pcie/Makefile
>> index b0b43a18c304b..62d3d3c69a5df 100644
>> --- a/drivers/pci/pcie/Makefile
>> +++ b/drivers/pci/pcie/Makefile
>> @@ -9,6 +9,7 @@ obj-$(CONFIG_PCIEPORTBUS)	+= pcieportdrv.o bwctrl.o
>>  obj-y				+= aspm.o
>>  obj-$(CONFIG_PCIEAER)		+= aer.o err.o tlp.o
>>  obj-$(CONFIG_CXL_RAS)		+= aer_cxl_rch.o
>> +obj-$(CONFIG_CXL_RAS)		+= aer_cxl_vh.o
>>  obj-$(CONFIG_PCIEAER_INJECT)	+= aer_inject.o
>>  obj-$(CONFIG_PCIE_PME)		+= pme.o
>>  obj-$(CONFIG_PCIE_DPC)		+= dpc.o
>> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
>> index c4fd9c0b2a548..c5bce25df51cb 100644
>> --- a/drivers/pci/pcie/aer.c
>> +++ b/drivers/pci/pcie/aer.c
>> @@ -1150,16 +1150,6 @@ void pci_aer_unmask_internal_errors(struct pci_dev *dev)
>>   */
>>  EXPORT_SYMBOL_FOR_MODULES(pci_aer_unmask_internal_errors, "cxl_core");
>>  
>> -#ifdef CONFIG_CXL_RAS
>> -bool is_aer_internal_error(struct aer_err_info *info)
>> -{
>> -	if (info->severity == AER_CORRECTABLE)
>> -		return info->status & PCI_ERR_COR_INTERNAL;
>> -
>> -	return info->status & PCI_ERR_UNC_INTN;
>> -}
>> -#endif
>> -
>>  /**
>>   * pci_aer_handle_error - handle logging error into an event log
>>   * @dev: pointer to pci_dev data structure of error source device
>> diff --git a/drivers/pci/pcie/aer_cxl_vh.c b/drivers/pci/pcie/aer_cxl_vh.c
>> new file mode 100644
>> index 0000000000000..cd921ade1a38f
>> --- /dev/null
>> +++ b/drivers/pci/pcie/aer_cxl_vh.c
>> @@ -0,0 +1,227 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/* Copyright(c) 2026 AMD Corporation. All rights reserved. */
>> +
>> +#include <linux/aer.h>
>> +#include <linux/atomic.h>
>> +#include <linux/cleanup.h>
>> +#include <linux/init.h>
>> +#include <linux/kfifo.h>
>> +#include <linux/lockdep.h>
>> +#include <linux/rwsem.h>
>> +#include <linux/spinlock.h>
>> +#include <linux/wait_bit.h>
>> +#include <linux/workqueue.h>
>> +#include "../pci.h"
>> +#include "portdrv.h"
>> +
>> +#define CXL_ERROR_SOURCES_MAX          128
>> +
>> +struct cxl_proto_err_kfifo {
>> +	struct work_struct *work;
>> +	void (*flush)(void);
>> +	struct rw_semaphore rwsem;
>> +	spinlock_t fifo_lock;           /* Serializes kfifo writers */
>> +	atomic_t flush_inflight;
>> +	DECLARE_KFIFO(fifo, struct cxl_proto_err_work_data,
>> +		      CXL_ERROR_SOURCES_MAX);
>> +};
>> +
>> +static struct cxl_proto_err_kfifo cxl_proto_err_kfifo = {
>> +	.rwsem = __RWSEM_INITIALIZER(cxl_proto_err_kfifo.rwsem),
>> +	.fifo_lock = __SPIN_LOCK_UNLOCKED(cxl_proto_err_kfifo.fifo_lock),
>> +};
>> +
>> +static int __init cxl_proto_err_kfifo_init(void)
>> +{
>> +	INIT_KFIFO(cxl_proto_err_kfifo.fifo);
>> +	return 0;
>> +}
>> +subsys_initcall(cxl_proto_err_kfifo_init);
>> +
>> +bool is_aer_internal_error(struct aer_err_info *info)
>> +{
>> +	if (info->severity == AER_CORRECTABLE)
>> +		return info->status & PCI_ERR_COR_INTERNAL;
>> +
>> +	return info->status & PCI_ERR_UNC_INTN;
>> +}
> 
> Hi Terry,
> 
> Should we use unmasked status here ? just like other consumer does.
> aer_get_device_error_info() gates on "!(info->status & ~info->mask)"
> "info->mask" is always populated on the path that reaches here, so it's free.
> 
> Does that make sense to you ? or any specific reason we don't need the mask
> here ?
> 
> Best regards,
> Richard Cheng
> 

Hi Richard,

Yes, we should and it is available. This will prevent further processing 
when the event is masked. 

- Terry

>> +
>> +bool is_cxl_error(struct pci_dev *pdev, struct aer_err_info *info)
>> +{
>> +	if (!info || !info->is_cxl)
>> +		return false;
>> +
>> +	if (pci_pcie_type(pdev) != PCI_EXP_TYPE_ENDPOINT)
>> +		return false;
>> +
>> +	return is_aer_internal_error(info);
>> +}
>> +
>> +/**
>> + * cxl_forward_error - Forward a CXL protocol error to the CXL subsystem via kfifo
>> + * @pdev: PCI device that reported the AER error
>> + * @info: AER error info containing severity and status
>> + *
>> + * Producer side of the AER-CXL kfifo. Enqueues a CXL protocol error work
>> + * item and schedules the consumer workqueue. Takes a reference on @pdev
>> + * that the consumer releases after handling.
>> + *
>> + * Return: true if the consumer workqueue was scheduled and the caller may
>> + * need to drain the kfifo before AER recovery; false if no CXL error
>> + * handling was initiated due to an early return on error (e.g. no kfifo
>> + * consumer registered).  Note that on a full kfifo a correctable error is
>> + * dropped but true is still returned; this is harmless because the caller
>> + * only drains the kfifo for non-correctable events.
>> + */
>> +bool cxl_forward_error(struct pci_dev *pdev, struct aer_err_info *info)
>> +{
>> +	struct cxl_proto_err_work_data wd = {
>> +		.severity = info->severity,
>> +		.pdev = pdev,
>> +	};
>> +
>> +	guard(rwsem_read)(&cxl_proto_err_kfifo.rwsem);
>> +
>> +	if (!cxl_proto_err_kfifo.work) {
>> +		dev_err_ratelimited(&pdev->dev, "AER-CXL kfifo reader not registered\n");
>> +		return false;
>> +	}
>> +
>> +	/*
>> +	 * Reference discipline: the AER caller (handle_error_source()) holds
>> +	 * a ref on @pdev for the duration of this call and releases it on
>> +	 * return. Take a fresh ref here so the pdev stays live while queued
>> +	 * in the kfifo; the corresponding consumer is for_each_cxl_proto_err()
>> +	 * and will drop that ref after handling. On enqueue failure below,
>> +	 * drop the ref we just took to avoid a leak.
>> +	 */
>> +	pci_dev_get(pdev);
>> +
>> +	/* Serialize concurrent kfifo writers: multiple AER threaded IRQs */
>> +	if (!kfifo_in_spinlocked(&cxl_proto_err_kfifo.fifo, &wd, 1,
>> +				 &cxl_proto_err_kfifo.fifo_lock)) {
>> +
>> +		if (info->severity != AER_CORRECTABLE) {
>> +			/*
>> +			 * Unlike PCIe AER, a dropped CXL.mem uncorrectable
>> +			 * error cannot be treated as device-local: it may
>> +			 * signal lost cache coherency over HDM memory in
>> +			 * active use. The error can no longer be confirmed
>> +			 * via CXL RAS, so collapse the unknown state to the
>> +			 * same conservative outcome as a confirmed UCE.
>> +			 */
>> +			panic("CXL: dropped uncorrectable protocol error\n");
>> +		}
>> +
>> +		dev_err_ratelimited(&pdev->dev, "AER-CXL kfifo add failed\n");
>> +		pci_dev_put(pdev);
>> +	}
>> +
>> +	schedule_work(cxl_proto_err_kfifo.work);
>> +	return true;
>> +}
>> +
>> +void cxl_register_proto_err_work(struct work_struct *work,
>> +				void (*flush)(void))
>> +{
>> +	guard(rwsem_write)(&cxl_proto_err_kfifo.rwsem);
>> +
>> +	/*
>> +	 * Warn on double-registration to surface driver bugs (e.g. missing
>> +	 * cxl_unregister_proto_err_work() on module exit)
>> +	 */
>> +	if (WARN(cxl_proto_err_kfifo.work,
>> +		 "AER-CXL kfifo consumer already registered\n"))
>> +		return;
>> +	cxl_proto_err_kfifo.work = work;
>> +	cxl_proto_err_kfifo.flush = flush;
>> +}
>> +EXPORT_SYMBOL_FOR_MODULES(cxl_register_proto_err_work, "cxl_core");
>> +
>> +static struct work_struct *cancel_cxl_proto_err(void)
>> +{
>> +	struct work_struct *work;
>> +	struct cxl_proto_err_work_data wd;
>> +
>> +	guard(rwsem_write)(&cxl_proto_err_kfifo.rwsem);
>> +	work = cxl_proto_err_kfifo.work;
>> +	cxl_proto_err_kfifo.work = NULL;
>> +	cxl_proto_err_kfifo.flush = NULL;
>> +
>> +	/* rwsem_write excludes all producers; fifo_lock not needed */
>> +	while (kfifo_get(&cxl_proto_err_kfifo.fifo, &wd)) {
>> +		dev_err_ratelimited(&wd.pdev->dev,
>> +				    "AER-CXL error report canceled\n");
>> +		pci_dev_put(wd.pdev);
>> +	}
>> +	return work;
>> +}
>> +
>> +void cxl_unregister_proto_err_work(void)
>> +{
>> +	struct work_struct *work;
>> +
>> +	lockdep_assert_not_held(&cxl_proto_err_kfifo.rwsem);
>> +
>> +	work = cancel_cxl_proto_err();
>> +
>> +	/* Wait for any in-flight cxl_proto_err_wait_for_empty() calls to complete */
>> +	wait_var_event(&cxl_proto_err_kfifo.flush_inflight,
>> +		       atomic_read(&cxl_proto_err_kfifo.flush_inflight) == 0);
>> +
>> +	if (work)
>> +		cancel_work_sync(work);
>> +}
>> +EXPORT_SYMBOL_FOR_MODULES(cxl_unregister_proto_err_work, "cxl_core");
>> +
>> +/**
>> + * for_each_cxl_proto_err - Call a function for each kfifo work item
>> + *
>> + * Single-consumer invariant: this function is only called from
>> + * cxl_proto_err_work_fn() via a single DECLARE_WORK.
>> + *
>> + * Holds rwsem_read internally; fn() must not call cxl_register_proto_err_work()
>> + * or cxl_unregister_proto_err_work().
>> + */
>> +void for_each_cxl_proto_err(struct cxl_proto_err_work_data *wd,
>> +			    cxl_proto_err_fn_t fn)
>> +{
>> +	guard(rwsem_read)(&cxl_proto_err_kfifo.rwsem);
>> +	while (kfifo_get(&cxl_proto_err_kfifo.fifo, wd)) {
>> +		fn(wd);
>> +
>> +		/* Corresponding ref incr taken in cxl_forward_error() */
>> +		pci_dev_put(wd->pdev);
>> +	}
>> +}
>> +EXPORT_SYMBOL_FOR_MODULES(for_each_cxl_proto_err, "cxl_core");
>> +
>> +/**
>> + * cxl_proto_err_wait_for_empty - drain pending AER-CXL kfifo work synchronously
>> + *
>> + * Ensures CXL RAS handling and panic policy complete before AER
>> + * recovery proceeds. Only needed for UCE; CE runs asynchronously.
>> + *
>> + * Snapshots the flush callback under rwsem_read, then releases the
>> + * rwsem before calling it to avoid deadlock with a concurrent
>> + * rwsem_write from cxl_unregister_proto_err_work().
>> + *
>> + * The flush_inflight counter (typically 0 or 1) prevents module
>> + * unload while a flush is in progress outside the rwsem.
>> + */
>> +void cxl_proto_err_wait_for_empty(void)
>> +{
>> +	void (*flush)(void);
>> +
>> +	scoped_guard(rwsem_read, &cxl_proto_err_kfifo.rwsem) {
>> +		flush = cxl_proto_err_kfifo.flush;
>> +		if (flush)
>> +			atomic_inc(&cxl_proto_err_kfifo.flush_inflight);
>> +	}
>> +
>> +	if (flush) {
>> +		flush();
>> +		if (atomic_dec_and_test(&cxl_proto_err_kfifo.flush_inflight))
>> +			wake_up_var(&cxl_proto_err_kfifo.flush_inflight);
>> +	}
>> +}
>> diff --git a/drivers/pci/pcie/portdrv.h b/drivers/pci/pcie/portdrv.h
>> index cc58bf2f2c844..357310916088f 100644
>> --- a/drivers/pci/pcie/portdrv.h
>> +++ b/drivers/pci/pcie/portdrv.h
>> @@ -130,9 +130,15 @@ struct aer_err_info;
>>  bool is_aer_internal_error(struct aer_err_info *info);
>>  void cxl_rch_handle_error(struct pci_dev *dev, struct aer_err_info *info);
>>  void cxl_rch_enable_rcec(struct pci_dev *rcec);
>> +bool is_cxl_error(struct pci_dev *pdev, struct aer_err_info *info);
>> +bool cxl_forward_error(struct pci_dev *pdev, struct aer_err_info *info);
>> +void cxl_proto_err_wait_for_empty(void);
>>  #else
>>  static inline bool is_aer_internal_error(struct aer_err_info *info) { return false; }
>>  static inline void cxl_rch_handle_error(struct pci_dev *dev, struct aer_err_info *info) { }
>>  static inline void cxl_rch_enable_rcec(struct pci_dev *rcec) { }
>> +static inline bool is_cxl_error(struct pci_dev *pdev, struct aer_err_info *info) { return false; }
>> +static inline bool cxl_forward_error(struct pci_dev *pdev, struct aer_err_info *info) { return false; }
>> +static inline void cxl_proto_err_wait_for_empty(void) { }
>>  #endif /* CONFIG_CXL_RAS */
>>  #endif /* _PORTDRV_H_ */
>> diff --git a/include/linux/aer.h b/include/linux/aer.h
>> index df0f5c382286f..8eba3192e2d15 100644
>> --- a/include/linux/aer.h
>> +++ b/include/linux/aer.h
>> @@ -25,6 +25,7 @@
>>  #define PCIE_STD_MAX_TLP_HEADERLOG	(PCIE_STD_NUM_TLP_HEADERLOG + 10)
>>  
>>  struct pci_dev;
>> +struct work_struct;
>>  
>>  struct pcie_tlp_log {
>>  	union {
>> @@ -66,6 +67,29 @@ static inline int pcie_aer_is_native(struct pci_dev *dev) { return 0; }
>>  static inline void pci_aer_unmask_internal_errors(struct pci_dev *dev) { }
>>  #endif
>>  
>> +#ifdef CONFIG_CXL_RAS
>> +/**
>> + * struct cxl_proto_err_work_data - Error information used in CXL error handling
>> + * @pdev: PCI device detecting the error
>> + * @severity: AER severity
>> + */
>> +struct cxl_proto_err_work_data {
>> +	struct pci_dev *pdev;
>> +	int severity;
>> +};
>> +
>> +/**
>> + * Callback for processing a CXL protocol error from the AER-CXL kfifo.
>> + */
>> +typedef void (*cxl_proto_err_fn_t)(struct cxl_proto_err_work_data *wd);
>> +
>> +void cxl_register_proto_err_work(struct work_struct *work,
>> +				void (*flush)(void));
>> +void for_each_cxl_proto_err(struct cxl_proto_err_work_data *wd,
>> +			    cxl_proto_err_fn_t fn);
>> +void cxl_unregister_proto_err_work(void);
>> +#endif
>> +
>>  void pci_print_aer(struct pci_dev *dev, int aer_severity,
>>  		    struct aer_capability_regs *aer);
>>  int cper_severity_to_aer(int cper_severity);
>> -- 
>> 2.34.1
>>

