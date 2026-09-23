Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010038.outbound.protection.outlook.com [40.93.198.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F00563FCC;
	Wed, 23 Sep 2026 18:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790188650; cv=fail; b=f6o6GnIMLmOJBwCpRa+uDDADHsvPxJ9g8qwEstOl1ETVMKp1KdUsI2zx4UyzU/MEDwqqmeGRT3qO1vebZdsDg6EgS8xwc0qTKn9UzSanLSDD8iLh7QS38Dhso9MsfLoX0PH5vC7YrTOTjMK4qMOyI0sKJ2K1+FbMbMniI7Qz1qA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790188650; c=relaxed/simple;
	bh=WVzxk1ixA8gqf/p7zEzG8TzrbaWursiMN8mHhIGwnCs=;
	h=Content-Type:Subject:From:To:Cc:In-Reply-To:References:Date:
	 Message-Id:MIME-Version; b=f+uUBAnY/ksLBX1XuLoakcoKxzu0x0lgfCvoJ9JecnI0eHRuNuOF91vqK2t4kXujVF+Crd0pz4YfIeA9v8ZecH47AvMxfPr6oOvgJNC1f/Pyd6E4F/6Py46C3fiEajdWwNeKqNMiZJRKk+keD6C1oKvAwr/aGhn0gMGoRtUUiEg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=X14dAxpQ; arc=fail smtp.client-ip=40.93.198.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="X14dAxpQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ga8HDCNazoMixtFHgukGobI+B8xEtPG9Mzb94CawPafcpHyi/J5wgAu0/c2QLfjHTl5eNmmrOD+LYQPPQRSXSJ8EG1Z3dx/CuAFXB5wdm3UcUuCmqt2NFgskwju/x09R/+pJv+NT2xhlQOqR+W1Eeva4WI3NK+kgT4KsqviLKLkjYyWVhgGqzIofz/OPTHArOAF9XOtxODpTLsHZaEYtiJMFLyvjj2qGTGdoVpM6v78Tl/hkjXfRaCsWpDgugU/Mvf19zrDrS576X6RYUOmgPmJvEAV9Jh8Dyf7tWSSYTX2oCOf+qzNbUHLMctoAlXIqmO9jvKD0MYX+JIR0MErrRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EUUI0Whk6fK/7L9g1nCNpZoeRNV+wFr4K0OvdrxcDyo=;
 b=ZY7Weqp8I5uUz2TrsvtVSwTSeV8whDluFl81xf4iinzXn++pGdWdSLL7nKPZ9f5S3j5/qpkSh358Odxx0E7LVFf4xoQ+uixfb4d6NGqIwOo9zG1Xs1swONGCbXSVyms2CtAjygS8ppQ9zEKBCE95fIhGcRg6jRkKUoy9XGeQPLwOz7G8q6/6LhCHngRSx4NbVGm3vvrBTu7tQAuWNOfnCSsCoMeomod3p6CiBiCcBCbm4qpbsKxancYbWnV8iAP2Ychy51+IP1HHrONcl24d8OkKuGcUXMwr/921zGSd6SAToAfCc4EDfODHYv0pUDCWVw0rPvA2odf627K5gkaScQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EUUI0Whk6fK/7L9g1nCNpZoeRNV+wFr4K0OvdrxcDyo=;
 b=X14dAxpQPTDTXLJUM8vCFMedORfBPU49zwAdKwOjI1Hvq+FAgETnGAch113N2rys0uBPhVzGqWEU0xRcdegiuCkFHC8pe2hH1BiLzCW4HiytyvlX11kQgUKR5sI/Dg7saNFfYe16fl84481e5ixMzhhvo4OVRr/1S0o/L5Fhy4GL0z5gd1y4JGAUadImvvynHBdg3SE8E+2qo6xKQKAIzHXr0q2VdXsKPkJKXsZ8VOi9kqDhIndSorsyY3bb+4HEGyc5+SF2SGA+qwZpmWwfxzE7BaPm6iefxDtk+sDmMPHFTLpCk3oPjyKrEsdyxVyO3luqKIDOHmWMq0O1+C0NMw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LY0PR12MB325698.namprd12.prod.outlook.com
 (2603:10b6:408:3bb::14) by CH1PR12MB9646.namprd12.prod.outlook.com
 (2603:10b6:610:2af::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.17; Wed, 23 Sep
 2026 18:37:13 +0000
Received: from LY0PR12MB325698.namprd12.prod.outlook.com
 ([fe80::b65f:1548:5b35:e2b5]) by LY0PR12MB325698.namprd12.prod.outlook.com
 ([fe80::b65f:1548:5b35:e2b5%5]) with mapi id 15.21.0451.014; Wed, 23 Sep 2026
 18:37:13 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v5 12/15] iommu/arm-smmu-v3: Allocate IOPF queue for
 ARM_SMMU_FEAT_PRI
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, robin.murphy@arm.com, jgg@nvidia.com, 
 Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>, joro@8bytes.org, 
 bhelgaas@google.com, praan@google.com, kevin.tian@intel.com, 
 kees@kernel.org, smostafa@google.com, baolu.lu@linux.intel.com, 
 Jean-Philippe Brucker <jpb@kernel.org>, Eric Auger <eric.auger@redhat.com>, 
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
 skaestle@nvidia.com, mmarrid@nvidia.com, skolothumtho@nvidia.com, 
 bbiber@nvidia.com, harsha.v@oss.qualcomm.com
In-Reply-To: <28b828e4e1368d95b57aa231abab2194f397aae5.1789446520.git.nicolinc@nvidia.com>
References: <cover.1789446520.git.nicolinc@nvidia.com>
 <28b828e4e1368d95b57aa231abab2194f397aae5.1789446520.git.nicolinc@nvidia.com>
Date: Wed, 23 Sep 2026 15:37:05 -0300
Message-Id: <179018862554.3334538.3417890067243679890.b4-review@b4>
X-Mailer: b4 0.17-dev
X-ClientProxiedBy: MN0P222CA0017.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:531::22) To LY0PR12MB325698.namprd12.prod.outlook.com
 (2603:10b6:408:3bb::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LY0PR12MB325698:EE_|CH1PR12MB9646:EE_
X-MS-Office365-Filtering-Correlation-Id: d97a9e20-0787-4396-6084-08df19a1ad61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|7416014|376014|10067099003|11063799006|56012099006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	FCDVfCwXuwl9qPpfWolYBBymiirWBaNgNhL8JPAbuZ970G1dre5JZheRzEJivh3cks1LftzN1Ii4gJiT/0O4jAxOEhC1j+FN0B2SU94z8kl9rcMyoi0htbKe06B9DSQcQoD0pNG295PNK4VjU5sMSkwht8cWj26Qde9LnEoeU4MzX5pSi+HLhOZZXQbAMVvVeRg/mTTjq2LWvbYX2LCBHXf5JcPLI9yjs4Wpyus0h11ZKtm/b/qhVQArKFra4QBJMZ8vqzDfKe1yTNJL5JX+pFDJAVepZT+VJfTkFUOu48f3ha5u21UNn+qpL8cJDBidlfM/UqmU1HRpVqYnFptycMUeFTHuCRFPRasl9LMl6dnmWjyeJ1Kb3HGvXguXzEKAuVstdPJuMgpKngtctKFRtcERlEmgmtOH3KPhW7s5/+S3ZO5x9FgsLkPIxBEb8zzZNizCVmabivWnLxrB/l08OaL7LkqSIas3Zo6BiplPj8GYCEgP9iwC7d7MH0pp3o6C4k/jmSY/L+DoiyPDW7m764ADa8U2BnnBvqlLXrJe3WI5bo1k3p60neFsJxedoCKlsYGuk/zTpzVoIw+kBX3buJI3GgG6/KVQv7LbLTYHsFD9sSsbbuofLAh2uSYBzagRbhAOgV1nTiDGYrF1S8fLbc4uzDyc5KKr/wCf8idGsAg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LY0PR12MB325698.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(7416014)(376014)(10067099003)(11063799006)(56012099006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QWMyZGpqcldxM2YxSE1Pc1MvTll3S1dwU1M0cHBVek9EejVucDZpSGlWNWw5?=
 =?utf-8?B?VndaU3RyeVdhYUVsdlBWWE53SFBpUzJta3BNNFFBOGQ0R25MWHA3RG1wTjNC?=
 =?utf-8?B?ZlJYV2pXcEtoTVJnNTNVL05lNHVacUZrcWxHb0w2dXU3MlJrR2dVRWxlMnRj?=
 =?utf-8?B?bG9WM0lNZmhqeHAyRVU1MGNIQWI5TWQ4MWpqc3g3dEd1VWdjOUwwS1hJRDZw?=
 =?utf-8?B?dmpBM01hVzkvbGlML1NRT2tGdGxyTmxRdG9xTVpuTmV6SEtISHViSStKYTZS?=
 =?utf-8?B?dXFKUWtQUHRJTENpbHJHc280WnVhdm5PVk1YQTN1YkMweWtsYmNURXFBVEFC?=
 =?utf-8?B?d2l1L1c0ODJpaFNCMTlzQ3V1UzR1NWYzdzhpRTlFWVlQY3pJaHhLaGtYVE5D?=
 =?utf-8?B?TjIxbjA4dnpEeG50QVFEcVBYK2syVFpQZFVWTk85dzhuOWhmeWZMRUFqd0RI?=
 =?utf-8?B?TUhRNWtkMlU5dUl3L0VTWmJNaEZCQkRQM0wwR1AxWGlZYnB4ZmRkQ3BkUUVr?=
 =?utf-8?B?Q3RmY0U4eDd6OEN6ZlJMUTdkaHVQbGlUZFJ1THlxM0JnZVA4V1d6dStBY0U5?=
 =?utf-8?B?ZkVyS0F4OEM4M0ppZUw4b3E3NEpLWDBzYWcvQ2t5c0E0TnZLdlJxc3hqcGx4?=
 =?utf-8?B?ejd5Rk9ndEw5THhEdks4UXNDQWJLbUVDTTZDOHRxVFUzT2o4VUZRTVFJdE9C?=
 =?utf-8?B?WnpXR3VCODBxSjc5SUV1V1U5ZE0xNmErNFg5ZUJpVWlyME1IWFBvMVZYSnVH?=
 =?utf-8?B?Umdwdk1ZS0Y3WHJ6ZmV3RUhnR3BkWGt5dEh0Y3krRUdHRlErRGZtMjB5YUMw?=
 =?utf-8?B?WnBIc2FRUDBFbDcvU1RqYmttSllpT3BQcXRheWlvYzIwc3FCR0VTazNmU1pr?=
 =?utf-8?B?d0dVOUtmSWFaNlVtMFRtT2dkb05FZzVDRytZVGJwZTJiQ2lLWmoxQk5DeEx6?=
 =?utf-8?B?SmVxcDg0OFpTemloU0VuV3J2UFNYQ2lRU05WemFtNjMrRWpCUHMwNDdUQTRt?=
 =?utf-8?B?R3ZsbmdzM0lRa0h6aUZZa0VaOXlrOVFybTk3RTNXTWxkKzJhMzlLdTBNd0Fi?=
 =?utf-8?B?eFRTNGpuL20xSEViRGw1em13eU45akI3ZWtoQllJc2Eyayt0amtZOWRaRzRn?=
 =?utf-8?B?YzM1dUh5c3h3ZGlVakR4S3BSdjBtWmVYZjRscTl3Ujg3RExpNVpHUVJaQXlr?=
 =?utf-8?B?ZXBxZkcvMy9mMlRFYUVaOU9BMXhzNW1RT1c2Wi90QXljVnl4cjhvS3N5TjdI?=
 =?utf-8?B?ZDRWbzE4cXlJU3VWOFl5VUtsankxd3hzbEVYWDlsVC9rdjUxZWtVS2VKc3ha?=
 =?utf-8?B?V21tdGNkZGxkL0lJcTFvQTh3SnYyT1VETERqRjNRQ1ptanluR1c1cGUwY0dv?=
 =?utf-8?B?eURXUGwzcjRiMVRTTzZ1MTAvZU11dyt1STBvWFdiSUUzTEZ5clNlRk8vbDNF?=
 =?utf-8?B?UWJ1Mkp6UEgzOHdrVmQ2aWdiQkNTTXRWeHlicHRPN292YUtsUDNrbkhJWFhO?=
 =?utf-8?B?MlZWa05UTWg3cjNsTitzWHJZVkRWUnVxMC9oQlFidXhyWmZEL2xmbkJSQTBj?=
 =?utf-8?B?TEMyZlFXYTNWYVA1RFA1NEFHM3NEQ3dEK0tZWmdSY0hXdUxGNHA0US81VmpZ?=
 =?utf-8?B?ZzBnSUxSL0dhNys5RjR6SmhGZE5ZeTdrMmY4czEyeHlMNnM1RXc4UDlzcjlp?=
 =?utf-8?B?cVFRY2dyYml5QjkvUXltNGM2VWJuMXR4RzB2N2trdGcyT3BwdTZxU2ZyYXZ5?=
 =?utf-8?B?VW41Nk94WkhDSGtNZjJsMXJNTEJvUHcrYXZEUWdvU1JDRXdEelh1TVc1Zk5Z?=
 =?utf-8?B?TDlNb1NjVzNPS015Q04wZGs1RWxORXQ1QmZpdVF1SHZCRmJraDgxMjJ6MGhl?=
 =?utf-8?B?VnRDTDlkOW83OTlYeXBjUnV5ckErZ1FGK2dtSkZBdkRwdjY5Y2YwVDVCUmRr?=
 =?utf-8?B?MVIzcTlqVG50QmpFS25EZkZDRXJxNGxEbmlqWlZkS3dVTlI3VnA1RSs2UTJE?=
 =?utf-8?B?bnJYajFIeGhLRnRtU1RQMmZBSFEycXBpRWpab084T0tNWDRkQjNNWkY3aDVH?=
 =?utf-8?B?dG82OEUyd1dnMmRzOUZlWVZBNndTcWR5YmNkaW5sSVFoRjJuSnhQNHNodjdn?=
 =?utf-8?B?K1VObGxRaTZlQkJXQUdMVjB2K1Zic3Fnclh3ejJrc3dFRkd5OGUvM3p2RjJ1?=
 =?utf-8?B?WDJkWmhEYnFCSTZGS1Bid0F4d0N6VHpwV2pmenZPdm1peFNybUJzNnpLQUNn?=
 =?utf-8?B?alhMVDFzQVFOY1hFYXFtZjRDN2l2TjBNc2U3T0V3Zld4bWRnRTdZTUJveXN0?=
 =?utf-8?Q?oF6t+HQH1Npa7JmPUM?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d97a9e20-0787-4396-6084-08df19a1ad61
X-MS-Exchange-CrossTenant-AuthSource: LY0PR12MB325698.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 18:37:09.9700
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5B1zSKAhaCT9x/zRTHcUh+YDC9LxZ9YFqyzFK40OSCulrF3OEBOCdoF+tATm1eGw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9646

On Tue, 15 Sep 2026 09:38:24 -0700, Nicolin Chen <nicolinc@nvidia.com> wrote:
> After the previous change drops the FEAT_SVA gate, arm_smmu_init_queues()
> allocates smmu->evtq.iopf when the SMMU advertises FEAT_STALLS. PRI support
> is being added on top of the IOPF infrastructure, so extend the allocation
> condition to cover SMMUs that advertise FEAT_PRI without FEAT_STALLS.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

-- 
Jason
