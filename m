Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013020.outbound.protection.outlook.com [40.93.201.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 192F74B4892;
	Thu, 10 Sep 2026 16:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789059337; cv=fail; b=t9vYp8y5t2pjhHQxHhmKKepd0ZaNFlpy51rzt1GcXYV+mwHU5GY4LddlbJfWYs6bwxuFb7jbJQJIvXcSbtj2WM63Y1uSNZs4xME+L2MqTmIs6NIOB2BD4cpuAt4rnbnvyealIQjs6nMZT2bLXZMULRMi2d9MOG06VSQk9yXxrac=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789059337; c=relaxed/simple;
	bh=xT8v7Zla/zU/cmmlWNNd6nZHDVSivBolR60kg/eQ+z0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fQfpHqTfLeJkYWBrXTN8Zxg2rSFCCZ8df4i2BegMKBy98PQ5EoIcDZ3Il4tJSruTDOz5E9ITkOQDFabHMkPzugCvlPtgbYX8xu6PVygJJf/OPGK54bTUFTLMKwNI1CqXBSAO5xSELOPXNxgmnA0UJ6ttL/D6UlUggbV7xJI/JHM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=LGzfE6dd; arc=fail smtp.client-ip=40.93.201.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="LGzfE6dd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gf3G8BHu68P6QSbzXMoRPYPlNp+pWt4fVv6JtL2FgyZx0z+hIZERnfyq5sXTP4CSWr1sReImsSz9dazqhIS4GKAdNbLE8ZU+AXfLCg2YUWKN9YHM1p9aSyHDcI/uASLaVyGguqshgAQapbd2auZesWjYIBb0jIQl1cjRtKxVGG+AJAzgJQoarRY9dKNXZpWIdy00kvhnBszmU/McblPzHgERB5X6CryYfJeQnfwCe8cYLmsd4frso2QAGBkWtj+hap64ajdatPl5P368nycEPhqQxJAbwU3+jaaJuS8d7hpHnG8Imu+Exoj7KrNouzlxT9kKp+VNGT+tQNikfiPw9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/ywRwTT4PsKJKKqeOBaSA8/1H4gM7RNZ5ERTbFB6V+g=;
 b=geQZ3erZGE3U8EmHfv0ttcuJT+h6NI3ahcZlvH2nOC4L7E9gxzrDelT8SdpSD5B58AoT1QkXPZ4POWrXa6Tqil3LZgtAnROEo+MJqoW2r9qMo+X8Tdm1ONddgKhkEe569weu/swc8tnJ6kK9Pn4m4xTRiJ6qZsEh6yflvZ+Wsha64OvtdLAgnPZcqjhwCN7jRNvAelE4N6OY6kx5JC2ebbQrmlRJyBUcAJmtC7tW85ntRHYbt1Ap+q+L9WTDh5kxDdwGXmUNBgxPEyUJhJEpD3BbRwJrDjOa97bPHhsKz7FPx7t2+upMZIB43tJVlaxgVuC7Z1ruP8HUxVWoGEhpqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/ywRwTT4PsKJKKqeOBaSA8/1H4gM7RNZ5ERTbFB6V+g=;
 b=LGzfE6ddSWHZQ5ftfxte8L+gUTDdFldE++peczKNJwA1NUTcirIZxym2weQPoa6XGibeiZWD/fNkJwYnGMgK26kOLbF2M0yhWTLwu6S0+rAfADXQw8qfiuHiXNdzfVtkHa3saYnLIwbGKIid7ZnA3Xdd77ozXTUnseOy4Eamqqc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH8PR12MB9766.namprd12.prod.outlook.com (2603:10b6:610:2b6::10)
 by CH3PR12MB7570.namprd12.prod.outlook.com (2603:10b6:610:149::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Thu, 10 Sep
 2026 16:55:30 +0000
Received: from CH8PR12MB9766.namprd12.prod.outlook.com
 ([fe80::be0f:431f:5f27:96d9]) by CH8PR12MB9766.namprd12.prod.outlook.com
 ([fe80::be0f:431f:5f27:96d9%5]) with mapi id 15.21.0406.007; Thu, 10 Sep 2026
 16:55:30 +0000
Message-ID: <90b550f6-bca9-4bb5-b38d-b4577b03ba1d@amd.com>
Date: Thu, 10 Sep 2026 11:55:26 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v20 2/9] PCI: Establish common CXL Port protocol error
 flow
To: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>,
 Jonathan Cameron <jic23@kernel.org>, Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Davidlohr Bueso
 <dave@stgolabs.net>, Bjorn Helgaas <bhelgaas@google.com>,
 Dan Williams <djbw@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, linux-cxl@vger.kernel.org
Cc: Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
 Hanjun Guo <guohanjun@huawei.com>, Mauro Carvalho Chehab
 <mchehab@kernel.org>, Shuai Xue <xueshuai@linux.alibaba.com>,
 Len Brown <lenb@kernel.org>, Ira Weiny <iweiny@kernel.org>,
 Li Ming <ming.li@zohomail.com>, Shuah Khan <skhan@linuxfoundation.org>,
 Richard Cheng <icheng@nvidia.com>, Robert Richter <rrichter@amd.com>,
 Lukas Wunner <lukas@wunner.de>, linux-pci@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260902133933.2992457-1-terry.bowman@amd.com>
 <20260902133933.2992457-3-terry.bowman@amd.com>
 <a8ea024b-a608-4eea-bbdc-cba37b2bf2af@amd.com>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <a8ea024b-a608-4eea-bbdc-cba37b2bf2af@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0034.namprd11.prod.outlook.com
 (2603:10b6:806:d0::9) To CH8PR12MB9766.namprd12.prod.outlook.com
 (2603:10b6:610:2b6::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH8PR12MB9766:EE_|CH3PR12MB7570:EE_
X-MS-Office365-Filtering-Correlation-Id: cd70682b-88f3-4827-097d-08df0f5c5216
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|23010399003|376014|366016|6133799003|18002099003|22082099003|3023799007|10067099003|921020|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info:
	o0hzWeSzqcKr+9mS9KE7rMzFKkguvm5fOoIhyjEtN+4usJ3seZwrKTJCoQbMHaLrmAHCMDEnWN0y4sbKbFqRIisppeyZjAK2vQvLFuzQZwi4C6Xx9jKlIEaQYi4x7fHurIPlppVD2a5NFfg19EG9hOYlu6mIi+qkCR0i68TGC+SSbYesbjX0XEYqObv6aSTk64hqd5WuDOvZp2hUOxQ+auMUbFGPCED0JO/4Qfgp+VqAj8eF/ubuB7Iezzht0M5NXjcgoUNydQfTzISeJcjpY9KG1nBYAQkOKuEzClBTnw38gdzlyKPcZ4064dq7CuHJOI+jcXlqYJTqYSSZ9Xd7jj2jHPVaGyW7nFEp03+S7E3aZ8dNJ4QNIjl51cXbVfIPwht0KclXiFFNBJ3qIw6oKa7YJTlm9cXzLEZjl7UN0ISKFGjQXp3Jrfmdb8zg653w1lx01YEEFXFOvK6IbFOVL6XXiIodW2qbOF5ItHCnN3gLPSu8lk6zjDPLphWOh5BJVYvM/rhyNBy/a1wL3Ty67a1cq0Lf5CzWriwDQOVgCaBN+3Zmc88fmezOrjE67r1FxIRwcF5lPB0Ppu1W/aBe/CkXB7LsYsaLOlKLwwEOromOS22O+DqmtS6wkKvJILPpah6diUEEQ3ecrrxgV1moYumfh5loUPNZ5dHhrXdWrc8qv0kQGiQQOYQx6Bbhkr6omeNjvXfeGvMmS8FbHlh6uw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH8PR12MB9766.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(23010399003)(376014)(366016)(6133799003)(18002099003)(22082099003)(3023799007)(10067099003)(921020)(56012099006)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QUlyc2RJWkJXNzZUY3A2REFuZTdXanEzdzA5emJVOE1sYjlpNWlkZ2t0QU9W?=
 =?utf-8?B?bkVRTHRJbHNSQWdoaEVnbks1QmNQTWJnQlhESkZRSnYwOVNZMFFTUXppNkpO?=
 =?utf-8?B?SWR6bjFMN2JPdms5NzRVWHVoR0VlcW1leFkwVnlEbGdiUXhVY2pmNzZLRlFC?=
 =?utf-8?B?YmxHMWxLTEp3ZDA4M1E3VjYvZjVMS09PUWNZRjFBMjVRVURDa0tjNFNkRHYz?=
 =?utf-8?B?R1RVd2dJQnVadnltcW1MMUhKOHdYTWZESjNQcUNRem9CdjFqYzlab1VLSnRI?=
 =?utf-8?B?MVVYRk5jeCtFNWMyZXJ6UmNOb3lPTWZXZTluRkxLdjVWM3NjZUY3bnI0eW5G?=
 =?utf-8?B?eTkrSy9NZEg3MVhUcXc3Q092OUZVWjNBSllLQ0oxbWlLUDIyK2xNSnkwdUNv?=
 =?utf-8?B?dTVTNXp1NHZOdXlPNy82UWUxMGNqOTVYbEhOSytDSzhsQXQ0T28yN1RXWTBN?=
 =?utf-8?B?V0tHcTBWcE05c25VODZ4OXE1QzRMZ3gyR1BxNDM5blNGL2FZandRNU9qS1M2?=
 =?utf-8?B?Y3BlVnhrQmZ5a3IrcGRQTlNnVWFKRW1EZVFRS0VONWZOdjF2RVRZZGVmaXRm?=
 =?utf-8?B?UUhod1hQb29CVllCdlEvVWZqdUFtdUUwQ21hM3ZPbkNBU0M4NGpsRzh3YWdK?=
 =?utf-8?B?SlBTUlNLWEh5OTliZnJQL01FcFFsbCtJZnM0OU51akg2ak1BWUk3MHhBemJr?=
 =?utf-8?B?bEI2T3lyZXZOTnlzTjFTcXdZeWdva3UyYnBRMEp6dUNGMm5NYkY5dzVhQjkx?=
 =?utf-8?B?L0ZHRzZBcU13TXBWM0xvQTcrSXo2bFNDYWtuSW8zcmp5MFJzTk1DRENYT25y?=
 =?utf-8?B?Tzl3WmJXKzl4cUh3Ny85NS9ZUjdUVzJpcDRlK1lrc3BpZmJmRkxydGNtUlZm?=
 =?utf-8?B?L052Z0s0OGZSaXFrd01xT1NvNmRWdXFqbjRkM2xtc3RMQUxUSWtsU3dod0hB?=
 =?utf-8?B?YzVKMFoyQ2FGV0tyVHM0UzJPdjdnSWpmRHQ4ak4vam02ZC9qZ0NHbDdFSzcr?=
 =?utf-8?B?SzdtcWhPbjVOaitSQ1BwYkVSM0RpUmpsK0FSZmFwNlNMbXllVkhhTVQwbmhR?=
 =?utf-8?B?cUVLUkUrc2x5VGdNRWxLWGxvVmlVcFlGM2x4QkZPT2lnQ0J1SnNKSCtzWk11?=
 =?utf-8?B?QjNVS2p6UFZmbzZ0d1hoU3lLemZyUW03cmlMZTdCS3dkTm1lTVM1NW4xNGJm?=
 =?utf-8?B?ajFsU2YxOFArTjU4M2dJVlF2Zmh1U3BtTzhTRElSWHQyWGNnbkFYazBnVDA3?=
 =?utf-8?B?NU5LM25OTEZENVdFOVhaUFZRcEZFaXVHVTBYMG53WThMZm41eVM4Zjc5QkFD?=
 =?utf-8?B?cHNLYU9hTk8vSVQxSDVGNk1Zb0lpY2xwL0RZcmthQzMzZHh2dlppeFVwbWE4?=
 =?utf-8?B?Z0xmcmMxWDhVNmJkMGpPUkRYYUJRT2tyRzd5ZS91YWFtdzJ3a1pMZXNsb0Rp?=
 =?utf-8?B?NGV1R2V4ZThQcXNKckx4Mm13dld4L3pZZ3NGSG5mNGlFZDhyVVUxT21JS21j?=
 =?utf-8?B?S2JJQ1ZBS0pqMzFnS0NZaTJZVFo1MU4wb3JBNzRVeUcvaDRPNEI5Q3d5VmNh?=
 =?utf-8?B?d2R5ZERjV3RLeGNNRmdKY1JDeDlTTzQrY21KQkJCWGdtcEpLZzBvNENsU3BH?=
 =?utf-8?B?dlU0Z0FubkpqSkhoMnpIWnBmaVF5eEYrakM0WGZWdGRqYjNoa3g4Mk1hNFk0?=
 =?utf-8?B?NjZXTkx1eUpHNU1BTXZSYzRjRmRiVm5Yejh5M0dYRnZBai8rdzJtcUFRSHJh?=
 =?utf-8?B?aEpxdTY3MmJneThLVG5LNkFDMks5TCtkMk50SGVsVC9xV3lWb09uMEl0Z0xZ?=
 =?utf-8?B?OW14aTRWN3NVY0U2MmlrSnhDRE92a09OUWo5M3J6WkhQU1hrZnpPS2VSUGZr?=
 =?utf-8?B?aFJ2TklGbWVqRC9oRE5Cd3hxbFZ6b3lkYzY2Zk9NaXBnSDJCa1NWejJKZEt5?=
 =?utf-8?B?TzV0bkFueFA4UUFpSzNoVWxQM3NqNnA4aHVCOWxvQTBLUGhBc3IzK1ZFSUdC?=
 =?utf-8?B?dFRTVEJiK1FJOWw4Z1JtanJ6NUpiT0FVMUF1M2VvNmJpNzBTSytQT082RXU0?=
 =?utf-8?B?cUpZdnE4MGxKMU5BRjNibCtQTG9zVjV1aXBNN0pwVnNibWZ3ZzlwUE1EMnZk?=
 =?utf-8?B?ZGJKcDYxeDg4UXNJY1pYaVBPT0syVk9RV1VIaW03aEh6VGpTT3BWQlFkZ2NM?=
 =?utf-8?B?Z0xBakNldU9Eclorc3AyUWVWUU9GeWVueEpZTGFTZTZvbm93RHhBV2VPd3Nu?=
 =?utf-8?B?UUMxYU42bC9RRVNHNzlTbEJMZXd3M2tGcUtKME9zM0taN0dnL1U1V0FSdVI3?=
 =?utf-8?Q?p4+PjLICO3veUnLeJV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd70682b-88f3-4827-097d-08df0f5c5216
X-MS-Exchange-CrossTenant-AuthSource: CH8PR12MB9766.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2026 16:55:29.9483
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EZiEuZ3ZkL+3v89CODu8lXOa6bMsMExuye3Gl4FGm8kaCRLxEkiIbvrBfsKQwpkOg6STorFPP+5ITBDLBpLxEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7570

On 9/2/2026 3:57 PM, Cheatham, Benjamin wrote:
> On 9/2/2026 8:39 AM, Terry Bowman wrote:
>> Establish a single CXL protocol error path shared by CXL Virtual
>> Hierarchy (VH) and Restricted CXL Host (RCH) topologies. AER dispatch in
>> handle_error_source() routes CXL protocol errors, gated by
>> is_cxl_error(), through the AER-CXL kfifo to a cxl_core consumer for
>> logging and recovery. Producer and consumer go live together so no CXL
>> error is silently dropped across a bisect.
>>
>> is_cxl_error() expands from Endpoint-only to also cover Root Port,
>> Upstream Port, and Downstream Port. RCDs report on behalf of an upstream
>> RCH Downstream Port and instead reach the kfifo via
>> cxl_rch_handle_error().
>>
>> For uncorrectable errors, cxl_proto_err_wait_for_empty() drains the CXL
>> plane (RAS read, panic policy, state clear) before pci_aer_handle_error()
>> drives PCIe recovery, so recovery does not tear down RAS iomaps while the
>> consumer is still reading them. Correctable errors run asynchronously.
>>
>> Panic policy: cxl_do_recovery() panics on a confirmed UCE, and also when
>> the RAS registers cannot be mapped -- an unconfirmable UCE is treated
>> conservatively as fatal since CXL.mem coherency may be lost. A
>> mapped-but-clear status is logged as spurious with no panic.
>>
>> to_ras_base() centralizes RAS base lookup (dport->regs.ras for
>> Root/Downstream Ports, port->regs.ras otherwise) and provides an
>> injection point for RAS status simulation during testing. The
>> cxl_cor_error_detected() AER callback is removed; correctable Endpoint
>> errors now route through the kfifo like every other CXL protocol error.
>>
>> Update cxl_handle_rdport_errors() with locking to prevent dport from
>> being freed and RAS from being unmapped.
>>
>> At this step cxl_handle_rdport_errors() still dispatches a single
>> severity per pass (matching the pre-series baseline). The following
>> patch, "cxl/ras: Handle RCH correctable and uncorrectable errors in one
>> pass", processes a simultaneously signalled CE and UCE together.
>>
>> Co-developed-by: Dan Williams <djbw@kernel.org>
>> Signed-off-by: Dan Williams <djbw@kernel.org>
>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
>>
>> ---
>>
> 
> One small nit, but otherwise LGTM:
> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
> 
> ...
> 
>>  pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
>>  				    pci_channel_state_t state)
>>  {
>> -	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
>> -	struct cxl_memdev *cxlmd = cxlds->cxlmd;
>> -	struct device *dev = &cxlmd->dev;
>> -	bool ue;
>> +	struct cxl_port *port __free(put_cxl_port) = find_cxl_port_by_uport(&pdev->dev);
>> +	bool ue = false;
>> +
>> +	if (!port)
>> +		return PCI_ERS_RESULT_DISCONNECT;
>> +
>> +	if (is_cxl_restricted(pdev))
>> +		cxl_handle_rdport_errors(pdev);
>>  
>> -	scoped_guard(device, dev) {
>> -		if (!dev->driver) {
>> +	scoped_guard(device, &port->dev) {
>> +		if (!port->dev.driver) {
>>  			dev_warn(&pdev->dev,
>> -				 "%s: memdev disabled, abort error handling\n",
>> -				 dev_name(dev));
>> +				 "%s: port disabled, abort error handling\n",
>> +				 dev_name(&port->dev));
>>  			return PCI_ERS_RESULT_DISCONNECT;
>>  		}
>>  
>> -		if (cxlds->rcd)
>> -			cxl_handle_rdport_errors(cxlds);
>>  		/*
>> -		 * A frozen channel indicates an impending reset which is fatal to
>> -		 * CXL.mem operation, and will likely crash the system. On the off
>> -		 * chance the situation is recoverable dump the status of the RAS
>> -		 * capability registers and bounce the active state of the memdev.
>> +		 * The CXL RAS read is unconditional regardless of channel
>> +		 * state. Any uncorrectable error bit set in the CXL RAS
>> +		 * status register triggers a panic below because CXL.mem
>> +		 * cache coherency is already lost; continuing risks silent
>> +		 * data corruption.
>>  		 */
>> -		ue = cxl_handle_ras(&cxlds->cxlmd->dev, cxlmd->endpoint->regs.ras);
>> +		ue = cxl_handle_ras(port->uport_dev, to_ras_base(port, NULL));
>>  	}
>>  
>> +	/*
>> +	 * CXL.mem UCE means cache coherency is lost. Continuing risks
>> +	 * silent data corruption.
>> +	 */
> 
> Don't need this comment and the last sentence in the comment above.

I'll keep the panic-site comment (it's the "why" at the point of consequence) and will 
remove the duplicated coherency/corruption sentence from the block comment above (done 
in 2/9) so there's no duplication at any point in the series.

-Terry

>> +	if (ue)
>> +		panic("CXL cachemem error");
>> +
>>  	switch (state) {
>>  	case pci_channel_io_normal:
>> -		if (ue) {
>> -			device_release_driver(dev);
>> -			return PCI_ERS_RESULT_NEED_RESET;
>> -		}
>>  		return PCI_ERS_RESULT_CAN_RECOVER;
>>  	case pci_channel_io_frozen:
>>  		dev_warn(&pdev->dev,
>>  			 "%s: frozen state error detected, disable CXL.mem\n",
>> -			 dev_name(dev));
>> -		device_release_driver(dev);
>> +			 dev_name(port->uport_dev));
>> +		device_release_driver(port->uport_dev);
>>  		return PCI_ERS_RESULT_NEED_RESET;
>>  	case pci_channel_io_perm_failure:
>>  		dev_warn(&pdev->dev,
>> @@ -335,3 +371,82 @@ pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
>>  	return PCI_ERS_RESULT_NEED_RESET;
>>  }
>>  EXPORT_SYMBOL_NS_GPL(cxl_error_detected, "CXL");

