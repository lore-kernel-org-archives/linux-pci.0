Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013061.outbound.protection.outlook.com [40.93.201.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A328175A85;
	Sun, 11 Oct 2026 02:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791686134; cv=fail; b=i1/qRcWh+wdo39jIyqjwmEcA/ntz4Whl0nDXXJ+K4eWx7f6IfvXykkogfP5yypDb63FNdIVWpVYuRifpLmXDfk/AAkVzCqmsqXPpjPhIrfMwrbG9iFKWBuJea/u1fRTZxGjlB25sZV9fHXgKGyMCw8FRAElkphXx9QqfCqqy9EI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791686134; c=relaxed/simple;
	bh=TSP0xGI2eni4MC3iizBwye+pSeG/UtFfhEAscC1RXsE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mGJeb+6Yg9Ku80DEWUCoHGvIcADcn7aRrDZz9X3wQA2vUmLPEtAsFQs25ZW6FlefFELfu+WC0ET3Gq6DMkHoLbMH7S+7plQ52XwVoRD7gsdD6/oEjbnPw1brpr2apC2Mv3U1W9+PmPqXC7PQCUkRsV5kszWU1yy9zF/0Uj/lphI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OUqYPyuD; arc=fail smtp.client-ip=40.93.201.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OUqYPyuD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ES8MIxiY2AfXCLh8phW/3B16CokaB73JCvgAHbT4EO0Zp7lThuwWDfCPRuCSLGhoqKYhie2bv4/hRPhMP93qO5/lTsB8K3+QAdG+686xIb24eEG5jDrJAx8EPcphOKnrK6H7GHE3CuNftwZ6/1vl47FksSjLuh+aSoGgFLjkN2A9xFyqvr8kPW/msZ/z+wq1/IqVnOR17po4YImOe1+uFLwrZA0GaU+Wej212paj2j2aI6m7ccbjbIxrUZn89x5fjQjCeOKEnlN868QhzfI4iXC7AsIhLokriqkGE2Ucn6UwIkZuPKKqZbOPAAG5bNEpT1ICiN7a+kq0z6Bp9X+zRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Mu0YmOtot0vzpqXQCdHaVQKNyVVHqpabhYSdz56HKY=;
 b=e8+FuEqe/NfGe5ALus5LDlSoj/kAZO1e1a9gbaAW/WhNyOZa/CoL9t8mLq6u1yqCNthNY9DqVM4RASxyTEgFuQjJ1EtHv73SQhTY8eQPU6hhvWKjh87a7UE/D8NrYruSkZefl/LyWRNYOJIkaI/Dv87TQt4HPJNwlrB64UBO5YQtMmkThyQhifTHE4ec7eY9+wtKiVaXI+T66VA6YNVwOv3en/qNuSal4tn6UsuzYxL4wvntL6tPobBEaWKvbx8dgGWCZITMxnkflY9RHFVIzRslIfzQ/NT2gXK1SNgo5KVKY0t77fTjyg+aILkER9iXSkvkWEXqk6h0JQgm+dxZLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Mu0YmOtot0vzpqXQCdHaVQKNyVVHqpabhYSdz56HKY=;
 b=OUqYPyuDSwD7V4TC1kurEAxgWcXn594gNRHzjqZ7sSblPyZu5yLpDIkhFdvva65BiFyefqaw83s8EQJagbdhmVkaOML4qsZwl7RTXzbebt0erCYpiE17dXEPvVQ4LiHR1IDBfdkZ+5Ha4pSBiOIfjlNIqkSOHjWJKHCJTn1Jmt/5IJnRslczFM2j5XU/pyNIUrVmUp0uKg8snrPNo1aqnBnxe3dp/S49lYX18sikja9/e25fNtW15jKDpEUZucmNQa34Ts44XbmXsUlr4FEsjWR0/+AqZVAU7V94dQsmVbiidfYFVirGusSOtJnrWC/Zp/wwMB5EigPYHWS/9WIyjg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5) by DS7PR12MB5838.namprd12.prod.outlook.com
 (2603:10b6:8:79::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.20; Sun, 11 Oct
 2026 02:35:27 +0000
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522]) by LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522%5]) with mapi id 15.21.0496.019; Sun, 11 Oct 2026
 02:35:26 +0000
Message-ID: <d121416f-fe83-4afc-8831-d643cbee63c6@nvidia.com>
Date: Sat, 10 Oct 2026 19:35:23 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 12/16] cxl: Validate and synchronize HDM ranges around
 reset
To: Richard Cheng <icheng@nvidia.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Dave Jiang <dave.jiang@intel.com>,
 Davidlohr Bueso <dave@stgolabs.net>, Ira Weiny <ira.weiny@intel.com>,
 Jonathan Cameron <jic23@kernel.org>, Vishal Verma
 <vishal.l.verma@intel.com>, linux-cxl@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 Alex Williamson <alex.williamson@redhat.com>, vsethi@nvidia.com,
 alwilliamson@nvidia.com,
 Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>,
 Vishal Aslot <vaslot@nvidia.com>, Manish Honap <mhonap@nvidia.com>,
 Jiandi An <jan@nvidia.com>, linux-tegra@vger.kernel.org
References: <20261001092227.3004747-1-smadhavan@nvidia.com>
 <20261001092227.3004747-13-smadhavan@nvidia.com>
 <ar9k21TsVTXmW5I3@MWDK4CY14F>
Content-Language: en-US
From: Srirangan Madhavan <smadhavan@nvidia.com>
In-Reply-To: <ar9k21TsVTXmW5I3@MWDK4CY14F>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0173.namprd03.prod.outlook.com
 (2603:10b6:a03:338::28) To LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LY0PR12MB727857:EE_|DS7PR12MB5838:EE_
X-MS-Office365-Filtering-Correlation-Id: 17a407ba-cf0c-449c-b620-08df27404ef9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|7416014|376014|366016|22082099003|10067099003|18002099003|261009223027099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	UgJrt21RprSqzyOskoqLpIYYrMoDOIVngBfy/AjDzCyer2zfafw5zOI8AJEu3LDxe0NVnx4lky+LC1B/IF1Iw5wl4gyrYQhrZwWXlkaErV9+4BqWPveh/a/BQfaqPT66ORT2AwqbdbSgOsBoEoquROrqD4um7C2Kg8OgP0/g20iwA1bUBzIh4PNfzBZUm+Wq1EWyFM4+mQOnO335kdkP6v8Ed2Tck2MaKBTHEspevrE+TLqDTtD004T3+XYVPFyhDPL4ixEVHfSZ3uTGUmeVBr7bOALKW4QbmhrP8NATJbhiqVzT0DBUBpSq0LkPgxNFFEY81SiQb7xeH6JCwwky5iajH4F/UAK+OQ7wURNobQS3cTxZD30xun6q5TXeVZPjbFjUWY5mXoPPF/4nAQCS9O+QZ+TEbiZRf9BrBTjxxnI881Y4iASX9kSl+oR9idDGWFWWyvD912giOKVxSSGULK6wSlGKndJQc3aZ6eDMTdPmWdsllBgdcq01en+jDFgRDEPG+zQhkvyL9HUh3Uq+hxYQPbxUbsqEE82lBC/DyWUoVtQZG7/c47DiWSitJOASHdbKJtmcJLGtLVhkDc4sFFi6valzk3gmoytNz/1pmXwUPBu/7ySb12LQSS9kXoi4CoNq4Z20p930qNPKa8cE5AD4EfxCGx6PNZ0cOB9OiZ0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LY0PR12MB727857.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(7416014)(376014)(366016)(22082099003)(10067099003)(18002099003)(261009223027099003)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aitDRFhSVDhiWTJJdTJWdkhpMGRPQnFmRGxidW1XWVJubVZMZEVyUDJvM0dZ?=
 =?utf-8?B?ckJpOGJnZEloS0NpWVdKTnZCS0RPV1BOT3VhSEtSYWFFckIvTkRvbFVTTTZX?=
 =?utf-8?B?VWFVNEM5L3hwRXdsQ0o3Q2JGQk8yM2Jva0dVVTVIQjFNMGViVnQvUi9Lc21P?=
 =?utf-8?B?a3BJRk4vSHdEdGg3WFJoZUdZVldlY0VIZ3JNYUIxWWtXTXBTOTNTL01GM3BI?=
 =?utf-8?B?NCtKb25yMjFiRy81SUR6RzJHUW5PMXFPWGdYYnRMVzlRV1BJaUI2N1JRZFlY?=
 =?utf-8?B?enlLRm5qbklaS3QrYThNNUs1OWd2WXhwejF1bHM5TjhXRHVnRWk1YnkvQlZN?=
 =?utf-8?B?emxWZmRzdWx3K0tyWHVmMlRQd0h3K1czVWhLVVoxN3dWWHl2dGhIMFg0L1p3?=
 =?utf-8?B?UU1YVE5XN3Y0dnpGTVYzMnMrU2wzZ3BNN291T0tkWkw0ZUExSWZRa2M4d2d6?=
 =?utf-8?B?cDVoL2NiWHVYQzhqdE5rNDFvYy9ETGFZUnpBVEIzN2U1TVRwK21NbzdsMFh2?=
 =?utf-8?B?Y1VjQXM0WkZLT1RubzMzTGNNK1BDMjV4bTZSRS9raDRhOW9KemZOZ1lGS2hJ?=
 =?utf-8?B?NFpjWlVCZ0Urby93WGpNTldqM1BGdHpKaCtDdDRyb0wyTS9CSjdKbmRUcHhC?=
 =?utf-8?B?ZHJsNVNBTkM2ZFptV0t3MHR4eU9BRzJPelFobDRHbWZQdGtJSEZYSVJCR0tI?=
 =?utf-8?B?OGJHRWtRakZmZ0dTN1lnVkhrWXVLNmZkYjNGMGZNSlo5N1N3SStjczhiQVpO?=
 =?utf-8?B?VmxJRlA1Y0dqWms0a2VEYkFvYVc3aVJjVkJQMHVPczFyUDN6dStHVmN4dndw?=
 =?utf-8?B?YWJYaEdBcEdqcUljNmxEb2J6bnBvbzIxc0cya09KR0tVVEN0YXlVVVVqRndO?=
 =?utf-8?B?UEZBWDB3d0w3UU95UHJpcTE5UHE1Q2dJYXU3SmRuMHFSc01QWGZvVkFkU3Zm?=
 =?utf-8?B?WW1vU0dpM0JlYUZ1bkNEZUg0RUhNaVpuYTlySlJSempjTllCRGlkYXl1SFN3?=
 =?utf-8?B?K0FnMG10bDR1T2ZZVmJ3MXRZOWFxcEFtVXFHL3FlS01kb3hCU2FrQlZ4SERq?=
 =?utf-8?B?b3RvRDF6WmlBQ1FMRjB3UjNZK21MeitPZmViS3lyaERFWHl6bnhGUTlhcmxk?=
 =?utf-8?B?ek5wWCt6R0N2RUJOZ1FoVmhBdisvT00zM2tnbHR3OURjSWdSSXlJTXdrZ3pz?=
 =?utf-8?B?R1RTWjIyT2NtbW9tOGh3NExnc012UDBZVXZXOE0vNkFlSnlING9POVVjUWVY?=
 =?utf-8?B?TU1qZnRMbnNvNlNwaENzRWdHSHJYdEFHa3VKa3dteG1oQXVOWlFQdUdGaHJm?=
 =?utf-8?B?ZUtmOFVCbFoveTFtN3g2UmRZaUJNVHp3KzcrVzJnRU50N0JWbit1YitHRU1V?=
 =?utf-8?B?VE1EYzE3Q1pZTXprN09IaDVEdVBPWjNremNPd3RqL2lMWEp3a1M1MjlHYXpE?=
 =?utf-8?B?bEJMVHRyZC9WdllSY2RKVHg0b0VMMDd2Z3BlSFd4QkFQY1VPQjN4QXBWUWk0?=
 =?utf-8?B?OGZzQVVXd0NyckRwZ0gvL1Y2SjJ2M2FaSFFQeXVKRnFiL09kRjQ2anRVVlRI?=
 =?utf-8?B?dW9jZUNXVWxRYWluQ0Q0WEpmQ2p3NFNyOGFKZHQyczFNM3NmRnZHeUdlN0RT?=
 =?utf-8?B?M2Npb0Q0MjV0U1lmQ240MURFbkFkNkU3MWcvbWZwYzBycTd0eVAzdnNhaU5B?=
 =?utf-8?B?bWlLUHozT25kWHJ4Ynk1T0YzTzZzMWpTeWpzMUx3UEppWXlsMnByNmlLR29C?=
 =?utf-8?B?d1locnl3NnJtWDB3a1JXUG5heHhqTTdNN1JZVnhzS3hCMkdBRmF4UnN6bmFD?=
 =?utf-8?B?Qk0rOTVHdFAvUTFVZHFic1M3UzZJNzZsNVRRN0xIMnIxYWQ5M01yU25NQ1dW?=
 =?utf-8?B?WWlCallRMG16dGFMNXdmVCtkRVNZYzFBcGZVc2RRWmhpaFIyb0pJV1R0emV3?=
 =?utf-8?B?SGk5MUZlWlZPYjhNUDBhV2VLRjh0R2t0cWNyK01jRmlMY3hIQmh4ckl0Vjkw?=
 =?utf-8?B?Y1htb0dHMU9qUENWMmdUK3Z3ZXljS2dyaVpFREl5eDlKcEQ2WEpHTE11eWYr?=
 =?utf-8?B?U3pLYWEza1dNb2grbVVLaWJzeTE4WVdnQ0EySzNMYWFDbDdUajlSM0F2bTc2?=
 =?utf-8?B?bkwrOXl3aFZaUHp3SVNGSlcrWlhFRExEdTBtdmVReWNLaFprRklYaTRIbDZn?=
 =?utf-8?B?YWZ2Y29mcStHU3NXelc0aExDU3R1a0REdjZFOTBUNGtyK3ZVWm5RZTUwVTdH?=
 =?utf-8?B?aCtJeDhSOFgvTFRRNmtKUEMwZXpZbTBBZjVHOE4wNW83QUdRZnhsM2t4VnFQ?=
 =?utf-8?B?N0pORUNpQ1c0WEQxWHgvNWFidXVzM0g5ZXhUd05UV3NQMGV6VDNydz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17a407ba-cf0c-449c-b620-08df27404ef9
X-MS-Exchange-CrossTenant-AuthSource: LY0PR12MB727857.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2026 02:35:26.6882
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xx+zY/Nw5wxKyMcHcpe8VLJrdYBMxhkAVZKaB/4yunz3pxxewo1sG2S0XGWODNpgaxzfHHUEzpWt5LoIHAN1wA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5838

On 10/2/26 1:06 AM, Richard Cheng wrote:
> 
> Hi Sririangan,
> 
> I tested your series on some machine with CXL type 2 device, those device were
> unbound and no VFs enabled.
> 
> After executing cxl_reset, all type 2 device error out with
> """
> [Errno 25] Inappropriate ioctl for device
> """
> 
> Execution stops at the above CPU cache-invalidation check. Since the registered
> cache-maintenance provider list is empty. The earlier check
> "if (probe) return 0" succeeds before checking this one, which explains why
> the method is advertised.
> 
> Is CPU cache-invalidation provider expected to be on standalone driver or
> something else ?
> 
> 
> Best regards,
> Richard Cheng.
> Hi Richard,

Thanks for testing. Yes, CPU-cache invalidation is provided separately 
through the cache-maintenance framework. Apologies for missing this on v14.

On arm64, the SMCCC provide series is here:

https://lore.kernel.org/all/20260910082142.1522865-1-smadhavan@nvidia.com/T/

It also requires matching firmware support. I've documented this 
dependency in the v15 cover letter: 
https://lore.kernel.org/linux-cxl/20261011021422.3428136-1-smadhavan@nvidia.com/

-- 
Regards,
Srirangan
