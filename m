Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010039.outbound.protection.outlook.com [52.101.61.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A6B33F5A6;
	Mon, 30 Mar 2026 15:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774883751; cv=fail; b=t5u4rjvLRJLf+lMGT1bIdi68wnDD9usVCMbz2ygIHrzCbkHTt+4Bp3heutj7UuWViw5fstE8pLavQdSr5A3rDDC2Ag3L1XtJft9uHiWHu/dK9GCe7z0qWyjBABT7QHw3s6XwlCgTKEeLQO0miTFyNoN6nifI02rIa1EpitkDPhM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774883751; c=relaxed/simple;
	bh=YjH9CuHHw8xo8LnXmAWYThvnXvEZziM4AlBRpawGHnY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PqabUh+yWRkvi0ReNVFY+Xqo4Xej6Sas+s70voAtHI2+9V5LUVipNdCpq0psjtqoBEcOjDHbNLa5tnRIhqTNnnCIoPK8yarvfBkFaPBNtLD1N3hypHLody0FM8MM6hk+zkzyIOJXTJ9PtgwYt1bBumy8nXw7uSpoMnu79XwOkts=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=h61Fq0tK; arc=fail smtp.client-ip=52.101.61.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="h61Fq0tK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M/WIn3rT6PcV+bCn5XOt1NEIleP9QF7opLMOZBrBv/wf2SQKieMvomkvIcodac/kzCskytF41gdDiNxCQvJIQF42BRogsCFApngMIOAa6elsRqigBFy+EIYJsGwUqvRDrenyBan4uQ/AGEZAcRGETrRcPb63/cZi4uEqXhRLKcG5Ru2bQjpxg6PcbH34YDItHNKyvPcAdMFr2xDyruGv1PkCezKZz008Nq4nmLv4MFHWQvaXVAKyemdxnyHs5/Ty6o1OnS+O3mPhrUaki0jCbIjEKuA1cw3w8XpkL9EF7FSxCQ03XxEsJ4/Jegi48hs5HS7Vc7Ghk1C88/b8WozamQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FSVnaWXIZxeP+6cgb0HEYjokAZ8TMEICd9dhKamWnPA=;
 b=jyOLpEiDorfPKpRMn7YZdgNmrHRQUMkmoS12s6nTp2yiQEYqIkxuFeg7C6H/XQnBlRj06FSba9btiAqLAiCdu5J1BOBm6ngxQF/eyN05Gg3gqJ8in8LP5BYBqndZMWt8qpCmAMaIJFAtTKjOckFOmOYg6ZAjC1YsbwCkVlR8zjJH4rDTf6rla4RGS8UqE+wK+NsAHOZTHmLzeTO8j11c2iIfMY9gNGggu68ej4L1PcgkBbtzXF856TuGT+XCXFYyZi1UEzX3xQbunto6jSwR9u/MrPT0ECE8otBlvEHlmb2OaiZfEAkL/rivdo5fGdlxWPrcwUF2QNGeItDkXPVNAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FSVnaWXIZxeP+6cgb0HEYjokAZ8TMEICd9dhKamWnPA=;
 b=h61Fq0tKYQwh4hOdkvIiIBCqcetc7nKiKumugFXAFPSvR1taQZolzbb1V5Pff6a0htI57Im52e3wh996J1yd2pCOwPkYgWzZVzkAc4aLJen+YhSRi9KMpmgY69ykDehIV7U1XN5h27/M+6vFkGV37ELJdU53RBv7wnBtv7t08Xo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH8PR12MB9766.namprd12.prod.outlook.com (2603:10b6:610:2b6::10)
 by PH8PR12MB7230.namprd12.prod.outlook.com (2603:10b6:510:226::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Mon, 30 Mar
 2026 15:15:44 +0000
Received: from CH8PR12MB9766.namprd12.prod.outlook.com
 ([fe80::be0f:431f:5f27:96d9]) by CH8PR12MB9766.namprd12.prod.outlook.com
 ([fe80::be0f:431f:5f27:96d9%3]) with mapi id 15.20.9769.014; Mon, 30 Mar 2026
 15:15:44 +0000
Message-ID: <ed968225-632f-4998-809e-c515d28852dd@amd.com>
Date: Mon, 30 Mar 2026 10:15:39 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 01/10] PCI/AER: Introduce AER-CXL Kfifo
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
 <20260302203648.2886956-2-terry.bowman@amd.com>
 <69c720adadcd4_1b0cc6100b4@dwillia2-mobl4.notmuch>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <69c720adadcd4_1b0cc6100b4@dwillia2-mobl4.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR02CA0002.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::15) To CH8PR12MB9766.namprd12.prod.outlook.com
 (2603:10b6:610:2b6::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH8PR12MB9766:EE_|PH8PR12MB7230:EE_
X-MS-Office365-Filtering-Correlation-Id: 9517d359-2d56-4bfe-d46d-08de8e6f366a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|921020|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	sirk6v1IBJYSQov+3u+RQdbqEj1MTJVqYul6/6bVtnsOIvSRDYZdv+gQughvElHYmfwQ/+JWxPtZZ2CkdyYo8g4yeyBqtjWL0KhpP7kN9+x3cgyWnlsIS3qbWCOvQlqSS4exTxd2z2q0qccXjG6eHUG+n19R+t0dMPUc6/Olz1lASSm9x/ljfa2xmyt4uT7GUsU5w8PutXuO0YZ6biF6yDgtgcNzyC/0i3RxhoUd0gkyeA1UjxLkNtMZhWlQWrR78RI5OLqQsnKP6TXpA0sZJzfxGGs9p3Y1AZp1Hs9piP/Pt8ud/2PjjbA//cPEHDQlbUmWTi4iVce31jIyHkDPDuMruS2OyaN4FCvVYBQTGHYUeUmJ5fTfpwgmcBa2HYj6buKHYj9VmzlaQmc7g0l73NYEp1OxJdhpCh4wO5OutBAYzx2ADl/CN886eTzEg4hXZV5NAYsVhX7zta4xbgEnElhDqo7I8EbCBcLeQq57gPlRE9Ud6QGlj0/voaF9I8qusFvAJ2b00nHqmUSGDpQnGpZ3RfvfjHTWTggQZkX1CmY/c2SEe3gb5duCugQy0TtC9+iqXE14GRwWx6gkYtTLrPkouLP5V8kO0ZclFWUnEIQiDnTPbRH/g0LWm4Z2MQKWT8TqwHJOPLEdPUgFcvtoBp0dnUQ8lfjyjeOz1mszk04Qiq0ZPwW05FUF9ZQq3Hy5wcGGP0WMYmCpV9NfJ2EyIiBxDS+x7ptAnnO4p/GvLfFH6J1oTzO9nFiNrwyZVagmqG1wsMkH0TJSrmFTO6HZVQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH8PR12MB9766.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(921020)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QjdZOWU1c1pyWEVwdElLdUtDNHN3VG91UXFtajlhRzR4blVLN1JEVVZsK2NY?=
 =?utf-8?B?alFpL29zZk0rQ2tSanlwdWx0WE5QQWgvUkhjc3hPc0tacmg5d3JUK3dMUU1p?=
 =?utf-8?B?MnE1VndQYWlROEZ6UU9OR2ZUMHVUNlp4UysyZURCOGZGcTV2UGcyYUhWMXJy?=
 =?utf-8?B?dkhLUmpSNlcwbXhYNlpvc3hGUnJqQVVqdy9BUmZxclFlTS92QmlGd3liNXE2?=
 =?utf-8?B?dmRKaUtPU2tvZkFtVXJqemxJWDU3ZzdKM1d4dGZ1NEcydGRkbTJLYlV4ZDR0?=
 =?utf-8?B?OFUyVUxDb05tbVNzSkZkSVA3UVNjYjNNZzErUDBicXo4WnRQcjdQSlFYVWd5?=
 =?utf-8?B?Qk9QU01HTy9Fby9DZVNVeHFTMGcvOWYwT1h1YlpVTWJ4OFFxbGExelhQcGhB?=
 =?utf-8?B?V0w1ekxJa1NHN20yVmVPK1owNEpKM21Oc2EvdDlGMUpGRFgzTFBOOG1YWUM4?=
 =?utf-8?B?NnZXUFdyeFhSVTBzZjVFOEp4ZHlyUHZlckppRnVBM0dnZkdHcFJpaTBZV0tT?=
 =?utf-8?B?eStYYWlOMW53Wm1KeGVCSjJZaDhkQ0xIdW4zRnlzVkJlaVZaQ2VrMm1Cc2Nz?=
 =?utf-8?B?Nm5uVFI1NlVPdGVad1NlS3d2blZwQmE0ZzFjVjB6UGlPa09kSGNSR2xlcWgv?=
 =?utf-8?B?QzQ1cXRNNEhXdFJFMzR5RUNPaWV0WjNBTGlZK3BVT3lSdXdrZk4xcDlCd0o3?=
 =?utf-8?B?UElkVklwVzBFWHg0R3VqUzY2cy9yMnFENU1DWUQyeE9BV01EMDZLenFaZFJl?=
 =?utf-8?B?ZHozSm5TUVVzSkpNY21kKzJPRC9maUJydk5sUzhRNUZvOHVQOW9uOGJna3pQ?=
 =?utf-8?B?TXJMak5naFVLcnNjYWNidUpCUi9XZWFOQ1pPamtYajBkM0ZzS0JEeUh5Ritz?=
 =?utf-8?B?T1ZQZVgrc0pOK0lwSG01UFRsYzRQaFR1MENxaitUY1VyTkU3aFRmK0hIOXR2?=
 =?utf-8?B?M0g4eEZEaWhXczgrRVl5a080ckZjQkVBYWREN0NxUm9jcXFNZFZVRXI3dmF3?=
 =?utf-8?B?aUsrNFdVS094VStUL0FNanV1TTFMV3FsNW1RRTRCc1F2TEJydXVlZ0loT09p?=
 =?utf-8?B?dFlBSHd5YW1DaitzNlNTMzlqaUZ1MzZsWDFJQ2NzbVpmVnlyOEZLZnFVQmFS?=
 =?utf-8?B?bm9Mc0xHYlNYSTk5NUs2QXhSQVNsblZqbDF3ZndPOVhvay93ckg1Q241Q1VT?=
 =?utf-8?B?c2VkQmNpNU8vSlNpQmUwTFBJaUwvcVNHNW9kVDFvTG81L2h4UlVLZUJxeEkv?=
 =?utf-8?B?R1FsMjdRNzVPWlNJU1RURGFtU1kyVHhrTHptSWNySndKclZhR2xZQllCN21Q?=
 =?utf-8?B?MTMxek9vdUI2SDNVdVh5ZmhSZDZmeVVUaDEwblNhUk0yVGp2cWlLcWQzVUdO?=
 =?utf-8?B?ZDZzR2cydXBsbC9XTHhzNU1aMUNvNHpHOG1GOGVpSWVkbzQyZnVQSnRIdkd4?=
 =?utf-8?B?RkxoUkZOZnVYU3ZXR0s1aVhMUGtkMFVYNWY2dzdZckIwZmhKN1hzUmJvZ0kv?=
 =?utf-8?B?NXAzVzA4akJnYkFCaXByQklRdGFoODUwK1VQcnZpclA1TUpaejRlNE5pZ3JJ?=
 =?utf-8?B?S0lwbXhDaTFjdzRzUUZWN01XVHN4T3kveXVoZ1ZYYUZzYUdZTmNpUFJ2WHI5?=
 =?utf-8?B?dmhVZW9ONDJvZU45cUZicFppZUl4eit1NjZlWUpmUmQwZlJBQzFRUm9zMkFs?=
 =?utf-8?B?NmxySlgrS3d0VXA0anNiZlNTZ1dybEZOaHFLVjZGL0dUKzl5c3VIbFRyeHlW?=
 =?utf-8?B?cFFNNDUrMFFHUnNaRkxrM3NQWmdDQXpnaXZGMDE0Tk5IOHhuamgwRzZJWnl1?=
 =?utf-8?B?REFzVHJvdy95R3RLT3hMSkpDZEdxWGNMZFc5SzRvRFk2cktxaWhkWEpkbzhR?=
 =?utf-8?B?c01oZ2tGT2ZVd2JtVURmQXhHRkU3UUpNd1NUandONkJOckUzRXk1VmVPNHFw?=
 =?utf-8?B?YVozRWdGVGxrVjI4Mm9lelcvMWIreU02MSt6UTJMVUEzdDJZZ0tRTXdGSm9N?=
 =?utf-8?B?azFoSWgveUZseXBTQlUxVzc4Z1NYd2g1SmVOUmdpVHlab3g5YjlqRm5VcnZy?=
 =?utf-8?B?N21zWnA2bWJsK3ZPOU1UM0ZyUldCVWhjZXRRME9wNnpzT3RNUUpRMXNzajA1?=
 =?utf-8?B?dUxZb3N2djlsUWRub1ZnSEZkMEp3UDYrSENiWlFXRCtxaVlPZTNGV2Vac1Rn?=
 =?utf-8?B?bTN4MlNhV2NoQWovQ3lDUEg0cFdicXI3a1ZQY0trYlNKZXJRRlA2aG9aVHp0?=
 =?utf-8?B?VWVxUmoxdlE1Q3NlalRINDVDUU5jdkFaRXp4eDF2Y2s1YU5Dc05ZSGIxb0NR?=
 =?utf-8?B?YUtNQm9iMSszRmFKU1JaYi9naHBJZjBHSGhWZHVDZXkyVlJORnpvZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9517d359-2d56-4bfe-d46d-08de8e6f366a
X-MS-Exchange-CrossTenant-AuthSource: CH8PR12MB9766.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 15:15:44.0235
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uDjwCJOPtBKYOH08R7wFd5fFS3FOu9+U7OJWxfN6jkghmB7WZvymigyySWZvYknfW+abd+OwJF+3OEjJFDrNSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7230

Hi Dan

On 3/27/2026 7:28 PM, Dan Williams wrote:
> Terry Bowman wrote:
>> CXL virtual hierarchy (VH) RAS handling for CXL Port devices will be added
>> soon. This requires a notification mechanism for the AER driver to share
>> the AER interrupt with the CXL driver. The notification will be used as an
>> indication for the CXL drivers to handle and log the CXL RAS errors.
>>
>> Note, 'CXL protocol error' terminology will refer to CXL VH and not
>> CXL RCH errors unless specifically noted going forward.
>>
>> Introduce a new file in the AER driver to handle the CXL protocol errors
>> named pci/pcie/aer_cxl_vh.c.
>>
>> Add a kfifo work queue to be used by the AER and CXL drivers. The AER
>> driver will be the sole kfifo producer adding work and the cxl_core will be
>> the sole kfifo consumer removing work. Add the boilerplate kfifo support.
>> Encapsulate the kfifo, RW semaphore, and work pointer in a single structure.
>>
>> Add CXL work queue handler registration functions in the AER driver. Export
>> the functions allowing CXL driver to access. Implement registration
>> functions for the CXL driver to assign or clear the work handler function.
>>
>> Introduce 'struct cxl_proto_err_work_data' to serve as the kfifo work data.
>> This will contain a reference to the PCI error source device and the error
>> severity. This will be used when the work is dequeued by the cxl_core driver.
>>
>> Introduce cxl_forward_error() to take a given CXL protocol error and add it
>> to a work structure before pushing onto the AER-CXL kfifo. This function
>> takes a reference count increment of the PCI device. The kfifo consumer is
>> responsible for reference decrementing. If there is an error on adding the
>> work then this function must decrement the reference count.
>>
>> Synchronize accesses to the work function pointer during registration,
>> deregistration, enqueue, and dequeue. Further synchronization fixes will
>> be added in the following patch.
>>
>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
>> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
>> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
>> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
>>
>> ---
>>
>> Changes in v15->v16:
>> - Add pci_dev_put() and comment in pci_dev_get() (Dan)
>> - /rw_sema/rwsema/ (Dan)
> 
> To be clear I asked for s/rw_sema/rwsem/, easy enough to fix up.
> 
> [..]
>>  drivers/pci/pcie/aer_cxl_vh.c | 87 +++++++++++++++++++++++++++++++++++
>>  create mode 100644 drivers/pci/pcie/aer_cxl_vh.c
> 
> Bjorn, do you want this additional burden to fall on PCI core reviewers,
> or perhaps make this change to the "COMPUTE EXPRESS LINK (CXL)" entry?
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 61bf550fd37c..1b46ac52839d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6438,6 +6438,8 @@ S:        Maintained
>  F:     Documentation/driver-api/cxl
>  F:     Documentation/userspace-api/fwctl/fwctl-cxl.rst
>  F:     drivers/cxl/
> +F:     drivers/pci/pcie/aer_cxl_rch.c
> +F:     drivers/pci/pcie/aer_cxl_vh.c
>  F:     include/cxl/
>  F:     include/uapi/linux/cxl_mem.h
>  F:     tools/testing/cxl/
> 
> [..]
>> diff --git a/drivers/pci/pcie/aer_cxl_vh.c b/drivers/pci/pcie/aer_cxl_vh.c
>> new file mode 100644
>> index 000000000000..7e2bc1894395
>> --- /dev/null
>> +++ b/drivers/pci/pcie/aer_cxl_vh.c
> [..]
>> +void cxl_register_proto_err_work(struct work_struct *work)
>> +{
>> +	guard(rwsem_write)(&cxl_proto_err_kfifo.rwsema);
>> +	cxl_proto_err_kfifo.work = work;
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_register_proto_err_work, "CXL");
> 
> Probably more appropriate to make all of these exports:
> 
> EXPORT_SYMBOL_FOR_MODULES(..., "cxl_core");
> 
>> +void cxl_unregister_proto_err_work(void)
>> +{
>> +	guard(rwsem_write)(&cxl_proto_err_kfifo.rwsema);
>> +	cxl_proto_err_kfifo.work = NULL;
> 
> Where is the work cancellation for this?
> 
> Oh, patch2 has it, that should really be in this patch. I would fold in
> that fix... but it needs a bit more, see below.
> 

I thought that was requested to combine with CPER change in following patch 
but unable to find the comment while searching. This needs to be squashed. 
Thanks.

>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_unregister_proto_err_work, "CXL");
>> +
>> +int cxl_proto_err_kfifo_get(struct cxl_proto_err_work_data *wd)
>> +{
>> +	guard(rwsem_read)(&cxl_proto_err_kfifo.rwsema);
>> +	return kfifo_get(&cxl_proto_err_kfifo.fifo, wd);
> 
> I just realized that this reacquires the semaphore on every invocation,
> and leaks stranded references.
> 
> How about something like below which I think also address Jonathan's
> concern about the awkwardness of the consumer needing to manage the
> producer's refcounting. With this change all the refcounting is internal
> to the producer, and it is properly cleaned up as to not leave PCI
> devices with dangling refcounts if someone unloads the CXL core. The
> rule is errors are dropped on the floor when the work handler is
> missing, and any errors that race unregistration are also dropped on the
> floor.
> 

Yes, below prevents an orphaned reference count by using a cancel function.
Thanks.

> diff --git a/drivers/pci/pcie/aer_cxl_vh.c b/drivers/pci/pcie/aer_cxl_vh.c
> index 348374859ee4..cc4e443511d0 100644
> --- a/drivers/pci/pcie/aer_cxl_vh.c
> +++ b/drivers/pci/pcie/aer_cxl_vh.c
> @@ -72,16 +72,43 @@ void cxl_register_proto_err_work(struct work_struct *work)
>  }
>  EXPORT_SYMBOL_FOR_MODULES(cxl_register_proto_err_work, "cxl_core");
>  
> -void cxl_unregister_proto_err_work(void)
> +static struct work_struct *cancel_cxl_proto_err(void)
>  {
> +	struct work_struct *work;
> +	struct cxl_proto_err_work_data wd;
> +
>  	guard(rwsem_write)(&cxl_proto_err_kfifo.rwsem);
> +	work = cxl_proto_err_kfifo.work;
>  	cxl_proto_err_kfifo.work = NULL;
> +	while (kfifo_get(&cxl_proto_err_kfifo.fifo, &wd)) {
> +		dev_err_ratelimited(&wd.pdev->dev,
> +				    "AER-CXL error report canceled\n");
> +		pci_dev_put(wd.pdev);
> +	}
> +	return work;
> +}
> +
> +void cxl_unregister_proto_err_work(void)
> +{
> +	struct work_struct *work = cancel_cxl_proto_err();
> +
> +	if (work)
> +		cancel_work_sync(work);
>  }
>  EXPORT_SYMBOL_FOR_MODULES(cxl_unregister_proto_err_work, "cxl_core");
>  
> -int cxl_proto_err_kfifo_get(struct cxl_proto_err_work_data *wd)
> +int for_each_cxl_proto_err(struct cxl_proto_err_work_data *wd, int (*fn)(struct cxl_proto_err_work_data *))
>  {
> +	int rc;
> +
>  	guard(rwsem_read)(&cxl_proto_err_kfifo.rwsem);
> -	return kfifo_get(&cxl_proto_err_kfifo.fifo, wd);
> +	while (kfifo_get(&cxl_proto_err_kfifo.fifo, wd)) {
> +		rc = fn(wd);
> +		pci_dev_put(wd->pdev);
> +		if (rc)
> +			return rc;
> +	}
> +
> +	return 0;
>  }
> -EXPORT_SYMBOL_FOR_MODULES(cxl_proto_err_kfifo_get, "cxl_core");
> +EXPORT_SYMBOL_FOR_MODULES(for_each_cxl_proto_err, "cxl_core");
> diff --git a/include/linux/aer.h b/include/linux/aer.h
> index f351e41dd979..8d60fd97ed67 100644
> --- a/include/linux/aer.h
> +++ b/include/linux/aer.h
> @@ -79,12 +79,19 @@ static inline void pci_aer_unmask_internal_errors(struct pci_dev *dev) { }
>  struct work_struct;
>  
>  #ifdef CONFIG_CXL_RAS
> -int cxl_proto_err_kfifo_get(struct cxl_proto_err_work_data *wd);
>  void cxl_register_proto_err_work(struct work_struct *work);
> +int for_each_cxl_proto_err(struct cxl_proto_err_work_data *wd,
> +			   int (*fn)(struct cxl_proto_err_work_data *));
>  void cxl_unregister_proto_err_work(void);
>  #else
>  static inline int cxl_proto_err_kfifo_get(struct cxl_proto_err_work_data *wd) { return 0; }
>  static inline void cxl_register_proto_err_work(struct work_struct *work) { }
> +static inline int
> +for_each_cxl_proto_err(struct cxl_proto_err_work_data *wd,
> +		       int (*fn)(struct cxl_proto_err_work_data *))
> +{
> +	return 0;
> +}
>  static inline void cxl_unregister_proto_err_work(void) { }
>  #endif

