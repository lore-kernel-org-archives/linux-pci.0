Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012001.outbound.protection.outlook.com [40.107.209.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBE8E2D8DDF;
	Wed, 23 Sep 2026 00:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790124676; cv=fail; b=XwtJE5cfFYHgsCitO9ngKOe7SfNYGE+lOQD0bP2cL3MEOckBBm9ls0BaE/UB2yyW+G/tSdPK2coaUjchuQb/Q7aWz76C4yXEZLqB6QS+0KlY/Uq9uH3wtDE+Qly2G46hRJwKk1CjPrnid5ToNA/4l8eKlQnDpDkftXfRSapQCyo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790124676; c=relaxed/simple;
	bh=XpJei10QDPZqtDaJ7YqXR2/ZP2SfpzQSwoGSAH29gsM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rdkU/bGBjsvoied3nWbMNAQHdkxTwEiR8H/7Vr0+mqLbcoH4BJA6YaJeAE+53ZDVtZdMfB+7k43EQfjm4R2+R9OciZqenpaxMjq+Lpz0FoMPKHT2ZVqmwmmv84r8JjLNoVI96gUBMUv902lZPuEAHGNzPCLmOj1Evhj17c8d30E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rrbSKMl2; arc=fail smtp.client-ip=40.107.209.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rrbSKMl2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jddQvNeTtG6GC30gC+goKuQ0lhKBV35bSwW4OjKuCM8PnCjxXVSRLknQoAN76CVvAxBVuT0wa9UfXG4uDgzCUMrmZV1f8ugxdj1+o/EveC+NVyjWOeiy6gBDuDeNh1pKp0qCGePzv0mXhh1pzt4Ku770vxqq869htvtNcHlJO2PEroae9wpH/eyJ04H6BF/MbdISrP7jIVXX+donkAG0+ruOb/DOSSXYZqeajpjV3EpGOa0OID2Nk2n0MvFGMP4k08wl6pULETnaLS+P5IFyvdAmSMlXgyJbyCTYL5RDX29sWZiPc4J2+Ntv9y7vSjR7BKm6BNT/XCSCsUBpSV1V/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1UEcRN04xEKGeR3L8658EToKCL1oDoLPNg++77spFj8=;
 b=l9lMCRI7XMzozEKs3GAexVW+aEKZ6zAOKuR83+TwusyPVHXP8AmQmDFPDLQgiKQMKoww9PNrXYznIDLK26yAeC6Yu0kKazQiR6RfbWTCeTHfPN18Q2WUT52IFFbhONCc5gqlNBGFK4l6BzNTZholko4riero2JFZKT2GjReEr80isZtkMQ2Aso2GPhHTQNfUfST+w2NwBh+aOmewwB5rBE94OsCGymLRXgsZ10OwskGU8ekDm5moH83LZwztKw8I8e67MVGOk/0saxWuATgQa99S34eBkBkj/WEYyC9cFf2U7rskmztfWyI6/olc7K8ueT1gMlEQLB0QjO9bZeIbaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1UEcRN04xEKGeR3L8658EToKCL1oDoLPNg++77spFj8=;
 b=rrbSKMl2qxouZ6CHlJVv4+HVA+X30ED5jHlcfkhLQIrj2P8fwj6/o0ZP9lC9ZQJY8f8Bn6ckh4ZroyHPfJRalLEBkTpQXYLWGn7zx4cIFUHZ20I0Xoo/CCx6xnODMcYHqn9zQp/uV6QFMkAApdPuPyQGmm2eqfXftLLH85EzYrJlcY4WXlSor+tDWJ/y6TnUCrs9pu08nObOURHU1ndoEdu2V8YN+ohBIvvY5mt2a9q/OKI4bHqLMyltQYYyqiieFuz3dkGFn3svSLKLQx9AixO50KfaTv72EszH9FLIeplT/S5BQg95Xq2u2Pi69/84R2tE7SfGWytQhyidcHu3rQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5) by SJ0PR12MB7008.namprd12.prod.outlook.com
 (2603:10b6:a03:486::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Wed, 23 Sep
 2026 00:51:07 +0000
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522]) by LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522%5]) with mapi id 15.21.0451.014; Wed, 23 Sep 2026
 00:51:07 +0000
Message-ID: <d9f2efb9-83e4-420f-9d87-452c1e8b490c@nvidia.com>
Date: Tue, 22 Sep 2026 17:51:04 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 06/12] cxl: Add CXL Device Reset helper
To: "Lucero Palau, Alejandro" <alejandro.lucero-palau@amd.com>,
 Jonathan Cameron <jic23@kernel.org>
Cc: Alison Schofield <alison.schofield@intel.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Dave Jiang <dave.jiang@intel.com>,
 Davidlohr Bueso <dave@stgolabs.net>, Ira Weiny <ira.weiny@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, linux-cxl@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 Alex Williamson <alex.williamson@redhat.com>, vsethi@nvidia.com,
 alwilliamson@nvidia.com,
 Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>,
 Vishal Aslot <vaslot@nvidia.com>, Manish Honap <mhonap@nvidia.com>,
 Jiandi An <jan@nvidia.com>, Richard Cheng <icheng@nvidia.com>,
 linux-tegra@vger.kernel.org
References: <20260910070808.1444264-1-smadhavan@nvidia.com>
 <20260910070808.1444264-7-smadhavan@nvidia.com>
 <20260912022617.47860862@jic23-hlaptop>
 <cb9f8b99-93ba-4b76-9537-8075eb697fb0@amd.com>
Content-Language: en-US
From: Srirangan Madhavan <smadhavan@nvidia.com>
In-Reply-To: <cb9f8b99-93ba-4b76-9537-8075eb697fb0@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH7P220CA0135.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:327::35) To LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LY0PR12MB727857:EE_|SJ0PR12MB7008:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d7f8a2b-d0ec-477b-6c10-08df190cc0bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|23010399003|376014|11063799006|56012099006|4143699003|10067099003|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	qQ1Gz7DNL/EMjJPQzpQJ/BomVQbmQ7EPQPLdBOIZfWv6CiW9RZIQTAZPX6/BoVObk/9xTv0mkd3/h7avEbeA2uozRcP8H+UEBw7h6k/sQyezy3zEUV2C0VX/ECh8WaV8Q9yfM9YaxgACMXkUMPLdHE6MsIhIJUy8XdlS5SlB5yurlx2LQy/ZHxi4xQfpgrhwEf89A4EQ4GFnveBzuavaIXoOaPk8+D1ZYSBmNHn+IuASl14tz5iB5vMeS13ptaI3fdizj44nbPNaU0kXTjnl1zOeSP8Quio6oUKyeBb3sFhJQlq0BW5UvI4h4xyf53llab72li4pnigLMjKoz/zO+uhlNHPyP/ZzlWSfPP6+qHHlxJU15thwx/78HGNhzB5W2ot4J3ygM097YIt2910IIVXHvjyCzyzsFCdFE6evx1Z4ry0Tye2QsP+PYGIY/REHGDBMOcFcM4aocfHdubSULOAwx4Iha/TVjWwA8jwItcvP0VchDooJ6Xrp9EACw4mykQSdLK7sKpzbEuPJz87gkwQXoeQiqd6jDDAStlqH7hHHiGhFmWSkSwM12tI4WeyNYOoiXiAxRQQTUp6b4Zwz4P810NZlWEf4pF56o2Y5rEQlEfuzmzSm1UoCV/J2CBSprnhrpzGE3VkIzG101pahpXuwy5anAZSf2d7gZMJSmN8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LY0PR12MB727857.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(23010399003)(376014)(11063799006)(56012099006)(4143699003)(10067099003)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZDZwS1BQekZzOVRVTU5JUFBmZFBMWWNla1hiam1NTTRkUlY2ZmlPaXd0TllO?=
 =?utf-8?B?dW9NL2VRYmNxZ3hlN3ovcGI1MUN2OXA4alpIQ1JVR0doNE0yWWNDSnFFZ3Nr?=
 =?utf-8?B?VGRFTlNDMzJRRlNPeHVWUnBkNHRCWWJIUnppVEEwdVlsL1JNRTUxSmtFcVZl?=
 =?utf-8?B?b0toQ1VsTFpwWDFGcStvcU9OenRMUkVnYlAvdTJkRXRDeTR5WFB6S3MxVGNM?=
 =?utf-8?B?Mi9SZnp2VFhMQ2lDa0hwaHdqUktVNzFVOS9ud2tLS2w5M1JESVZJZjBWNTdP?=
 =?utf-8?B?VnE5VmtXTDdQR2Q0bEdwcDBNWCsrZEpIaEtXRHd0c3VXaVF4ZWxlVWZhOERK?=
 =?utf-8?B?YzlXSHplY1NhK2gxOG5XS0FxOUE5Q1pnM0IwUGtvZWY0UG5xQnVDUllHNmZ0?=
 =?utf-8?B?OW82a2c1ZnpjazFydVV3NDFBdG5lR2psdVFhWmRISTc4TGZNcVZKdEp5MENM?=
 =?utf-8?B?TVM0VE1yeFRVUkxrdFoxR25WaU81RE9xNmN1QkpSRWFES2pITW4relJTenVQ?=
 =?utf-8?B?VC9uWThsa1FRK09BQisvN0NQcVZ0cWRvcUtiTEc2VkV5cDI5akkrUjFzT20y?=
 =?utf-8?B?bzBBVVZuVUJuZkdEeHJJeE1keXdvUis0UERnVndBQ0gwbWhDU29KaVNUM1pi?=
 =?utf-8?B?QTRFeVA5Z2lLc3dvMDF1WHJaZHBYV0ZtQUhPM1dFVEZWVExHWEF2a2xtcDNJ?=
 =?utf-8?B?S0pNRG45U0dLQWt1emJvL1pldm5pMWRUVUFMODY2Y1NveWJ1bG8zaEw1bHJH?=
 =?utf-8?B?dzNRdmFXY0xudU55dXh2TVo5ZzVWY3NTM3dYV0xqTFV1OFJmSnJqaDJmc3N0?=
 =?utf-8?B?Y2MwZ0R0MnFqZDZUcXg0cWNrVHBDWXRDQXRHSlMvelVuOFAwZnZwbDNoSWsv?=
 =?utf-8?B?ZFhyTGxGa2Q1SERxb2orZDduTjNLWTBsSjU1SDQ0ZjNodGU1cGRLMW9DVmNZ?=
 =?utf-8?B?N1dGZmVuTGYrd2ErVFpzZ2RWQUZ4ZjVaKzFsK3FLT3RyM25zdTJxdGZYbkl5?=
 =?utf-8?B?dzdrMkJGQVcreTlNcnEyeUcwWXFpTVpKK3l5aENDdWUvOUJEUGVFTFNyeDdU?=
 =?utf-8?B?bmROcCt4UVZGMDNBbkVCL01qWGtMNEVETStIdVE3anJEMitJY29TdW13T3hk?=
 =?utf-8?B?TW9tWm4rU3pPeGl5VGtRY3RKdlVYNzNNQTUxRFAxTDZSdFExbFdKc1JWS205?=
 =?utf-8?B?UERRWGlrZDYwRStlbERwL1YvKzhhdXQxeHcxUmtmQ3k4VlhyejNsUVBkQ0RW?=
 =?utf-8?B?cU00R05RMjY4dFNndU1Dbll2M2lNWTN3OU1INlUwd0dNVEI2aXA5TUtuQjNm?=
 =?utf-8?B?MjJhYmpjeXRXNlVPdlphN0x2ZTZIbm1TQTRHMVJ4di8xNkFpVUMrNzExdVdV?=
 =?utf-8?B?ZXJnQm1yaTc5S0tqakRmanI0NW82eUtvVDdvZFkzM2lpTWpIZ1dqNzB2dWIx?=
 =?utf-8?B?WGpIeEEvMEtIWmQwY0F6aXFnamU1blNMeFZWcjBCUC9WU2pQYWNuMkxVOW5y?=
 =?utf-8?B?dzVVUE9iQUl0cFNDT3RyOEVuSjlVYmVRWWRlZXh2QnI3Wmw5THhBdnRxN1hO?=
 =?utf-8?B?THJyT2QycWFNRzRPUjVVaDkwNVVibjhyVjd4R0NGaDU4MkhHMjN1dC8wVzlW?=
 =?utf-8?B?MjY4VVdRNURXcWtqTjVXQmlFRTZSNExsVDNjZGJYNEN3NjhHdHgxQTJtWjhJ?=
 =?utf-8?B?VkU2UjJxZjd2WDBpVW5qZk5mTURSREVybEVzUTloQlgwTndVclJCbXdwT0JE?=
 =?utf-8?B?SnpXWEtCd0pydUZtS29GQW9MS25PTGJHbGRMQVRzTkxsb3F1U21jOEtQcDF3?=
 =?utf-8?B?Q2pEMWc0NzBiQkdMMHorUXk0ZjVDN3hwZnFPTzVNWXFqblpuRWM1MUEwMm1x?=
 =?utf-8?B?d3RKM0dJUkVCc2ZWeE5waUN2L0NNYTJUcGdKK3VLeTdCaE5jNmRIWElBaTVS?=
 =?utf-8?B?UmY4bytUNTROTGk3UmhmNElCTXliS1VzbG80WWlHVVRSUXZ5WG9kMEJoUUdq?=
 =?utf-8?B?NkdZSTFLTzVqb2I4cDNMRTRoUWVobXpxQTVZajBZNDFGanl6WU1HVHdQS0Ja?=
 =?utf-8?B?VG5xaUJKLzd0Rksrd2gvK3A5blFXNE05TUlnY0w1TjJqWElkSzlHbG1mQlpz?=
 =?utf-8?B?QzFJT3dsUE5JYXJNTVJaU1BrQVZjSDdOdUM4eXBtZFBzL01LOGFpV3l1NnVM?=
 =?utf-8?B?SFRRWTFlU3VVQVVWaVNFWU9GZ1FkeGw1R2FqdlRPNUNlYjZVVStQeTgyZGVG?=
 =?utf-8?B?dVZ1bzhwbkkvdmFFTVo5L0JTb0pJdThKZTBIL1pXdXN0L0xMU1NuNC92eCtm?=
 =?utf-8?B?OExqRUlhNDdpc3FrYXllQXl5YmxocGxxTk1XaERDSTVoWXB3WE1HUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d7f8a2b-d0ec-477b-6c10-08df190cc0bf
X-MS-Exchange-CrossTenant-AuthSource: LY0PR12MB727857.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 00:51:07.5095
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V2/ZelLyVsU9V5rPjN5ZzR7dZQJ2XABxYQ8kvHs4DFAkaTDhrP0thpa2wFSfIf7xvqV7RFvBFJvYrO4TKExYrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7008

On 9/15/26 6:56 AM, Lucero Palau, Alejandro wrote:
>>> +    rc = pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_CTRL, &ctrl);
>>> +    if (rc)
>>> +            return pcibios_err_to_errno(rc);
>>> +
>>> +    if (!(ctrl & PCI_DVSEC_CXL_CACHE_ENABLE) ||
>>> +        !(ctrl & PCI_DVSEC_CXL_MEM_ENABLE))
>>> +            return -ENOTTY;
> 
> 
> Type2 cache support is coming and it could be CXL.cache forced to
> disable if IOMMU enabled and the device not supporting ATS nor belonging
> to IOMMU identity mapping (Benjamin Cheatham will send this support
> soon). In that case, I can not see a reason for not allowing a reset
> assuming CXL.mem would be still usable independently of CXL.cache
> functionality.

Alejandro,
I forgot to fold this into my earlier reply to Jonathan.
Ack, on the requirement.
But before changing the eligibility check, I would like to confirm 
whether the existing reset policy around cache invalidation & memory 
handling otherwise applies unchanged to this configuration.

I left the v13 checks unchanged for now, I'll update based on the pointers.

-- 
Regards,
Srirangan
