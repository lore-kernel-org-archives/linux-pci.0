Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011019.outbound.protection.outlook.com [52.101.57.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B27C8397944;
	Mon, 24 Aug 2026 23:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787613791; cv=fail; b=X5SQ/64Q5eKPEQxyht2Qhc/OxsgrpjFugOatzdCvV34Wj2nF9Wyy6DLRE7XI/+nzr4/+XKjSWRFdbYMczj4ia55U+ZPNXxtjd5PEqxN3TPxRh25cJmjMWXsfLLxuH/U/4Nd+oNMHZVgWA9gl/RzvRTpQ/VFhFqTcgSFNsBzjW0g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787613791; c=relaxed/simple;
	bh=npScJv0mk7l0GQ4KqMptVJ7upHpJhh6Jy4Gm/EN25yY=;
	h=Content-Type:Subject:From:To:Cc:In-Reply-To:References:Date:
	 Message-Id:MIME-Version; b=k8CKiU7cQ9U2VcIvpMY0CCG2UARUqthaMZ1kit2ScxAXKGCuYYl2rDKq8+2drT3ZYU5IyXB+OiHXGazs8Emrg4soYWzWAYgbzzll1d0S22EZ+fpOFJwNEO9lbjbDiMlzjxiT3jAQ5GmkzmGG3sQ7cVNZo2SC5mmqwfJHP+1zwcA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jyGzUfY4; arc=fail smtp.client-ip=52.101.57.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jyGzUfY4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fftnIyFEB3zEX7DUl71eDejj6jqmDDF4g6QR2cFHHL/p8Dh34kCEsWALhGm8wMLSMwkzWyDS1L2Minm6VNiUCpDi8H+CGgRhqwdtIgn8/wWAEhv/dXLCw+jZAPyAtU7aUm5Em+FYNdATRUazJJIoWC+0Hj3l0hIumMlnF4eCLuWL9ShDKJUcNaaJuXEakeYGfoibr5UfhAb7RptJIROk2hj/p0oi+1r0CneFPA+uQPZP4phylL0fooaGDoXvARKloIcV50F4ii2iL9FtHsFnKPOhzdNv/1H5xjevVVs3MZ9pWanM6P+nRcb9E/apNn9PrpcDrCJ4qCCQDko5KN8/zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/5i08KbZS6cXWZztMcWMDFQJBeCIfdg0ROHwl7TP4nU=;
 b=ySJfDtnxfVhWzxE8hMS5WM/MGyC6XawsTdXsmB3z2Eb+OpwGDC3brbuZeG+69CbNPInB9hvsxoplRtqyCQDsFIBNG2bPzqW0fgp3Yud5T6vN3gYVRbO+XY3mu9TDd98DS4pN2+gl3UtbLTzzk2HdK9lRqXIc6fziHmKATN1NE8QM27itYX0t7StMI+PEWEtrCGRFc/GzmUvOwWj5r24brspVoA59+7THoy7a1kwX5ba0EED2HX2fy4RFCr9sSn7vlH+bFgPWV164LNIucfcOURS/TSz8UCgHJM63SzhEooHvNsK1ErkD0P2Db0N9QsyeT0Ed2VyG29u2dxZNy1X3KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/5i08KbZS6cXWZztMcWMDFQJBeCIfdg0ROHwl7TP4nU=;
 b=jyGzUfY4OHxxaPdjYZigfRblcHRn4BYdBPx6f2Qxszc9RrcGvfhiLsd9vdt3Z83bgBa3kUF8v2rGjnhwiNcY/hV/tA90xpVQLKafjbaGgZt7zjj98zBL7LqdVjLmfb36O2C5rveafP1zjqCZvbAe5BzJdctSolU1m+uV0ueDUBedLcfbUE4Ly0OUZ7xpancb6XCIOoRj0M4CmcFlkR71x3FVPOTF/7fC1Fpe/UtyMWDMgf4Y2BhvXIH9I/+DyTgzejdjDDL7d0OxjYC6MYcAMkSoziTscAKF7os6LyrpWg5VCqLeAGOHdjebSyimpbYqrtA1FF/AUwciyjCh10kvbQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by IA1PR12MB6386.namprd12.prod.outlook.com (2603:10b6:208:38a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 23:22:56 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0339.012; Mon, 24 Aug 2026
 23:22:56 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v4 02/18] PCI/P2PDMA: Wait for RCU readers before
 freeing state
From: Jason Gunthorpe <jgg@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, 
 Logan Gunthorpe <logang@deltatee.com>, Chaitanya Kulkarni <kch@nvidia.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jens Axboe <axboe@kernel.dk>, Alex Williamson <alex@shazbot.org>, 
 Ankit Agrawal <ankita@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, linux-pci@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 iommu@lists.linux.dev, Tushar Dave <tdave@nvidia.com>, 
 Matt Evans <matt@ozlabs.org>
In-Reply-To: <20260821-fix-p2p-acs-v4-0-v4-2-94426b96de73@nvidia.com>
References: <20260821-fix-p2p-acs-v4-0-v4-0-94426b96de73@nvidia.com>
 <20260821-fix-p2p-acs-v4-0-v4-2-94426b96de73@nvidia.com>
Date: Mon, 24 Aug 2026 20:22:50 -0300
Message-Id: <178761377034.3197084.18004935510651805366.b4-review@b4>
X-Mailer: b4 0.17-dev
X-ClientProxiedBy: YT4PR01CA0317.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10a::10) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|IA1PR12MB6386:EE_
X-MS-Office365-Filtering-Correlation-Id: 77280206-d003-4af7-d772-08df0236a0a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|23010399003|366016|56012099006|10067099003|11063799006|18002099003|4143699003|22082099003;
X-Microsoft-Antispam-Message-Info:
	WMCzGSKQUHq6OlolC9DBYop4EqTLH11i7AEgoeNbI5jStunxsNAQrnm7PahZXG6AcGObvqvsAJg7mH9Fs1/5MN4KrPo1BkJxJ6ZYEiGCLxa3xhFDwU37sbUbCsNtDc/3dq28GMYVs69061VxVbp+I7LArGRPUyGSc3RaUrGMI/LasdXjfbmt5XVa/Y8HUjtd01Pl9H6JvW2ATcGkT8zbjZYspMxk9AFOMd+SEYgTU/WQVACvnc9ohNsdsgAYQ5k1+WLeZus2FbHrDdJUrFNRlnEEkaRGuQs/AUrnHQtgjcKANQCopoZ6Asp1ALUCZrIVghuGXhIOLyA0QT+9AGnCExbSn1kRISpMDTrGW38p9rPb5kMj6nbZa/8QBfJ0PpJ2q4q/GLFpMgwnDhbpLjoxaaWDkbQt6tT5KOz2tHOIEpaQvffY+0tBycTrv9i4e6ScfBM8qKPlGV4jU6UgYsl3Zw62NMPKUwiSf2LRv3mKCd8/tCHKJmAmcAoDLFWeU0Bl0GpIHv4KjNMK2VhwuUnkTiCeBEqw0A9M0lIqSH6jSR4NkSSg/ocZytEA7CGDHTRBMknstcQJxSxZoH5XfgONy64wJCfuxvV18w21QPa5biWjvYiZOkBlJPjrz/FvYvlgUcEcVbbIvebSNl/UD8apGP/seTQTKqGJBaewz8M+o9o=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(23010399003)(366016)(56012099006)(10067099003)(11063799006)(18002099003)(4143699003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZWJ4K2ZodXBRNFhRcFZxQU53SENuT0FRcWNmcEpCUFdwMWdsVWZ5bUhDWFBz?=
 =?utf-8?B?V1VWbXNmL0VaQnVIZ3MzVllWWGVtOVBYd1E2dkR6WlN5RXdYbk91U2NuQ3ls?=
 =?utf-8?B?Q0FwNm5GbFV5Mmp2U1c0SldiU3BIVnZBTllxRUY2ZnhiSElRWk5uTWNWQ2R6?=
 =?utf-8?B?VzVmSkI5VFJEY3JTYWtTN1BoSU1wRGI1WHR5S0l2WGRuaUs3cmg5TGY2ZHpR?=
 =?utf-8?B?YUFaaGlmUklUWVRzQmpnaXpSb2Fjek9iUlA4cEs3aVlmZVdKSTcvNG1uY09F?=
 =?utf-8?B?bjVsN0xURkZkQjRva2ZmeDg1WnV1TFhIMXR0enhFMVo5VCticUpTaSsvUkNP?=
 =?utf-8?B?SmQwb0hId0NtcVIwTHBSTUtmTE8wOFZQUU5ranlZaWViZ0dlK1dKVkh1QkxE?=
 =?utf-8?B?NjhxSnQ5UnFIV2FveGhTby9oR0kwMGE3N3I2enlNVlFST2dleGhoVCtJM3Zq?=
 =?utf-8?B?L3E2ZUZiSjhhYWRIekFIRDFoby85bitoSXVZeHFwZUg1YjMzdVFnMndVUmx4?=
 =?utf-8?B?aEhlbXRhelF5bVYzS3YvS1NnK0R0cDhIQnFHSitOZjNMd0RSYjFWNGtWUGpO?=
 =?utf-8?B?bVhyTVZyeHlZMjhpUUpnV2ltRGZnNmFtS0tLck5HL3lHR3BXZXpub0FScVM4?=
 =?utf-8?B?UzlxNWpsUHVVWXRKVk5aUE0rd3M0bmF2ZzBpcWhpc1ZtYUM2aUtNUzVDcVdr?=
 =?utf-8?B?WFdEYVh6NjhoUGoweUh6aitYUjNDRlN5U1NhS1RRZlBBRVZWY21sa2NGaURF?=
 =?utf-8?B?ZGxMWG40NVdCUi8reDhoTXBNYnRyYmlsbWplSWVGL2hyMzJaejRKR1FicXB5?=
 =?utf-8?B?bkZrODFZa2hBS2FyajRZMGNZYkx5bnk2alB3VDQvUHZHWS80bTY4NGYvQ1h2?=
 =?utf-8?B?c0JvVmdlamRRL1hyclpwMUV0aEswMm1BMVVXM00wNE5BYzhwUk1uaS9YZ0Ji?=
 =?utf-8?B?aUFmZHlGNjU4TEN4UHI0S2crSHgrWVhxWWFMVENsZXROcTN4VGNBYW80YTRG?=
 =?utf-8?B?ODZuNmVrdWx4RVNORTN5MWNaYU41enNxQWdpdFY3RUFCb1ZyYXZNckdoWHNy?=
 =?utf-8?B?L2w1Tmd5US9nd0ZjTVZ6WThvSk1XUzZWSStkMXlBaWtwUzB4YTR4OHM0S2tQ?=
 =?utf-8?B?bmpjc2Jia1BRbmdJRHlnTWwwRktVTklwRnNKOGF3dlh6OGxraW5yZmhmL2ov?=
 =?utf-8?B?MXZUdElMT2Y5S21tdHhYUWpmY2s2c0tXYitra3ZvUGNtWjZsR0RKSyt0YVND?=
 =?utf-8?B?cGZtUmp5SDk1QWtsQ2FiS2RuSDIvMTY3aWV1VjIwTFFqVzA4WXJQUWltSWs3?=
 =?utf-8?B?YWhlYVJFczVyUDNXdmNsa3FEeHVJVFdIbzRGa2FxRXdGLzZWUC9uQkc5MU96?=
 =?utf-8?B?OStKV2Z5b0hyU3ZpZnlEMU8xWExsNmhTbXM4VjdrNW5lUHBFNWd0dmRRQ0wz?=
 =?utf-8?B?c1VDWjQ2T0dHOTlSMDI4OEU4Z2ppOU9tK0IwVklzajJseUhXZTNYQ09kOWlS?=
 =?utf-8?B?MUZkNURzMmVjWHpvYmVtRE9vSDhkTS9GZ2E3SlBVUWphd3FrQnNVSE9ldFhp?=
 =?utf-8?B?S2ZmZmpsSjZIZlVNZjJwVXpncmJsaFk5SzZWSzlnbmlrblZIRmMvSlUvMlZ3?=
 =?utf-8?B?UEVWWUI0NVorQlR2ZGl0RlIxclRUSjM3THpjNWNRaVdBdnVyWUNydFQ4YXVY?=
 =?utf-8?B?Z1dKT1JQVFVxV093NW1wbXl5NFNZWGdaakkyVUxMVzhIU2tyQkxnWDhwVzFr?=
 =?utf-8?B?NlJsSG9XTmFTWklXREdCN1ovTjZ1bnY3S0g3VVVpelpFbTVOUTA0enhJYW5t?=
 =?utf-8?B?Y1dNUWNYK3JPcjdyVXJjcEpHZ0ZKaXI1Q0hDWDB2VkQ2YmVudmVONG9GajBO?=
 =?utf-8?B?SjFlLzdZalB6ODN4cFRUVExwUUdkV2J0eVBqV0pHMVQ1SFZuK1VIaG5LRlMz?=
 =?utf-8?B?eU5GaFg0bFVVc0sybnQvWThjeGJYTHQwbjkzcmgxdkVLZXN6RlRiUHhKaStw?=
 =?utf-8?B?ZEJOaFF0eFdKTmFoWkpja1dsYXlCRXV6NFVKVDJYOXNiNnZHNjZkcTJHdk5h?=
 =?utf-8?B?UHlpT2dtbldxZVlUdlRMQTZIZERvOEtoVlN3QWNLWmhJZE5NYit0cjNmR3BJ?=
 =?utf-8?B?T1YxUmpTV0ZHVTk1SDRCQ0wxMWtjY1FmQWM2aXNYUWw1UllhNVBWN1FETDRK?=
 =?utf-8?B?eW9DYWtFcENMTXJSM3ZwMDRXRExQUSsxRThQeFlHWDI2enZrYlZhcmpVTDYr?=
 =?utf-8?B?TW0zMkVrRDl2T0IwcUpSSHB1SE9xNFNrM2JUaDhGRkdYcU5HOXAwU0FERkdN?=
 =?utf-8?Q?WGXBdr1RCEIeUBpvok?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77280206-d003-4af7-d772-08df0236a0a0
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 23:22:55.8795
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n0aBJx0Wdv33PMnGU7d5VxjZp+9rPcY/t/aDxsasvQ2drVPgqPq4d6ZDHgsSPw49
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6386

On Fri, 21 Aug 2026 22:38:33 +0300, Leon Romanovsky <leon@kernel.org> wrote:
> pci_p2pmem_find_many() scans all PCI devices without locking or
> protection against driver unbind, including devices with poolless
> P2PDMA state. pci_has_p2pmem() may observe pdev->p2pdma just before
> driver unbind clears it, while pci_p2pdma_release() skips the grace
> period when no pool is present. This allows devres to free the object
> while it is still in use.
> 
> [...]

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

-- 
Jason
