Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013010.outbound.protection.outlook.com [40.93.196.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE3AC3876A1;
	Mon, 27 Jul 2026 19:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785181190; cv=fail; b=kgPfHXwwogwn5kNRZ/BeJgz2J8v2N6oSfLV4v+wAX8NijoB3rbgiALqmDCwceLcggqaqirBs3L5WhKqwMRZD8gmEvuJZwNUuA/+qNxfNwGTC/XapE9oq8zZ6Kh7g/ikyBDjzuSW4IRo25/JZe9Ms5oHZbbjpHCrSlZVY27+Y60Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785181190; c=relaxed/simple;
	bh=MbBRtjTLulI9MgTZRDGHetVQg3FtCuatCa9INDsSrkw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lK7kvGeW+34Y9YK8jtvPzWFQ8V0MF+Ap+UKpdwPB/APzGHGVR5BniJpW9FseHRv1o8tKMVEJ5Ea/C6YVyq2aHc4N+ZdmVXko1NGnhpzrFitGoIGkWX4vwHH/b1b37SLAdfxA9LMUDv966rkePQnsvPfTzhk86AM3UcZtcr6/BVk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com; spf=fail smtp.mailfrom=nokia.com; dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b=CLlLF5nR; arc=fail smtp.client-ip=40.93.196.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b="CLlLF5nR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KgpF4jQ1dgvkRe07RuR+KjMBDJsP9G/kE5HWWAxaKHDasbV3vc16dZ4aK5x9eVnFeR1Q9O2elIh+cLfEhcNVZPzBUcEnC39FZzL/v6YLGxqy4cAdn7Jb99o/e5+JXN7LmYziYO1xjrt9o135OlA/6Mp8N3/elCmnOOSGrdaHyeAG2fxNvXPD/Nnh6WrH8xzdjbJt8m7t1l2TqeHmGAXlnWCtQQ/SRLp40I8UWGWqwD9rxflY1C0RIJTBadfH3tG87udFcdiHOxFIJ5c35DV1Vvn+1zy708UMJyhbQ9hZ7r/jFJqi1Rxyx2rNsHUdYB9hXuO3mP7AJmF3VPRa9yJGJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0OzRrKZSbirdSBG/85gDiQ21QxQyKdKyTri7qhnOw+g=;
 b=bsbZJlxzEr6ZwccjGErIC6IXxol78C+Z+eL/C9r5/ZKErgM8F6Wc9mUfHIShG/0LmCp0D+mQ1kSIRagsUP9YNNuLm7TtUTcKc5PcUHElA7ue6vuMw7LFE7R0wNG9lrNdCUAvBEQ6RZOG9MuNIIvcueTjWra4ln4TbEBrIf7FHEE06cKGc+2+4F7LE2SqCDTHBeEVsPCWfX6AnpiEwYww5UMwo3FIEVS7fQQvCGwAIMACsDnurx2Pi6iDzbGvmQo9Mv3jIdiV/V3zLM1uYufv3FUHambIeMyTvN2GUWMp9wu9HU7gVyUDNY6BnyLT5OvAI52Xhu7VQYet+3V7NDfwkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0OzRrKZSbirdSBG/85gDiQ21QxQyKdKyTri7qhnOw+g=;
 b=CLlLF5nRX+pMyXiVBjj/hrJGU4VnUjEz9U6aJchMk1D+BnoDgVLX/CfnWI+gOqVixaFZB7LZNgFbxJYVQz0nZT8VGBLeHh62B3+J2ZiTxxPfpgKAqPr91jn7t2xZdFOqWaJw6Kyqp+ArlLHLk+VUxfK6WawO1nzumGYlZQKyDNsesmHU+ZUQ8BFIIPOIbQ/Ub4WnnFbe09LDNslU+oSASnkedt2VQnhsztMhwF7u4I8g/TBXk93D6763kg8lqPg679I7wC1kNcQ2p/hkmyD+uM3hxrBTtfIY3ZR9ShnaJgTnUjx5EHhv0+jAjnuJj1UkSpqIcke+ebVNA8wkkqsgaA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
Received: from BN0PR08MB6951.namprd08.prod.outlook.com (2603:10b6:408:128::14)
 by DS0PR08MB8726.namprd08.prod.outlook.com (2603:10b6:8:163::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 19:39:44 +0000
Received: from BN0PR08MB6951.namprd08.prod.outlook.com
 ([fe80::4dd1:e1e:56b0:b178]) by BN0PR08MB6951.namprd08.prod.outlook.com
 ([fe80::4dd1:e1e:56b0:b178%6]) with mapi id 15.21.0245.012; Mon, 27 Jul 2026
 19:39:44 +0000
From: Anthony Pighin <anthony.pighin@nokia.com>
To: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: Don't report fully optional resources as assignment failures
Date: Mon, 27 Jul 2026 15:39:02 -0400
Message-ID: <20260727193940.599340-1-anthony.pighin@nokia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <0d249665-2d76-7609-f78b-71ec1a94b507@linux.intel.com>
References: <20260717180029.1829888-1-anthony.pighin@nokia.com> <0d249665-2d76-7609-f78b-71ec1a94b507@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR02CA0023.namprd02.prod.outlook.com
 (2603:10b6:610:4e::33) To BN0PR08MB6951.namprd08.prod.outlook.com
 (2603:10b6:408:128::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR08MB6951:EE_|DS0PR08MB8726:EE_
X-MS-Office365-Filtering-Correlation-Id: bcdcb387-2e44-40db-b12f-08deec16cf63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|5023799004|4143699003|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	aqOfUzQU+OSDsiXrpPBXDX9Z2SQbunInS7E2VMtUDJJtKrP63gFzBYnlfJVZaLXjf0vstLfvOJ3FU9zz3WbzHzu/aKtETRr2UDvCHtZnbHUm+i08jPBxMD+S2+RDPYgrh922Lqhlpxqd5gd842rx66icxV1R3n7vwHwI6NYPtT/KrHG4RonqU240w/iQzJ6DqykYayHV+fxcIhjZs1y6riSfCMSJZ0xhTi+JurIDEyNtoHX29nlOa13aQKQNK9oDoM8jL+oHLfUvxvZQSyN/ekbL29GX+NCcrLKp9kIMbFPv5aZeu6feOId828ayQvpaNsq+O0vUtPSzV5e0soYHGk0LVm4toEhkRvZwYgOBGMEQyIjWUbwxHeBGQCGvNyOOgJmfW0XXt2kvHQPOv5F41tpVQGe3bYTtxy9Lz/6KRWdPwfcpd2rcfGrqHIlL1+A27D/K0oZph8qjVLHMWl8nPMcXo1LS4Bk0/VPZboj/p/VH/35C4+qL4EhEF+OL0g83LLQfJSFoslTOfAWytXw+d3gZ5frYZ4dYPilzv8aQYqv0pA+ZAnR3JCvopLZVegSJLleRMpb7Vr7YDJL50HUGjIPxu7KTfdi8gX2s4fdd635cWSIXqdpf20M+HCCIq3+7LMk4ShVoYew5zPTEQ6vpLF9VB2EZUdu9W6tQfac6gI8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR08MB6951.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(5023799004)(4143699003)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?REpqRmN1bDZlSE1OUTZweE9LS3I5aW5CL2N1SXlsKzRZOWxxVGdkazUzSmpo?=
 =?utf-8?B?NlhDNDMxcmtuRS9WWjhEUFpHdW94KzBtNjFEazdLY1duMStINm1ONXAxNlNh?=
 =?utf-8?B?S3dkSFRINjdjZDd2NnM1R0FhN3pFYTNGYU8xYUpyRi91L3Q5UUVEMjZkdThx?=
 =?utf-8?B?bkhlektVM1dwQ2FlYWtCMGVGRm9TSzkrb05uQ2RPdCtyRHdJUkd6cm5QdEcr?=
 =?utf-8?B?Q3IwQnQvN1hETmZGN254SExveDgyeUsyT3hCUVNHbGdCQStaSDBMdldKdnQx?=
 =?utf-8?B?clpJSFBpRnhuSHU4K3MwaDRzRUxodnJKcjFjWGpQdk5OaWw2emZ4TlVybVpM?=
 =?utf-8?B?cFdOWlZ2ZGpxTkZWM1JOODRtUG5QOXZ2bUNGbTFBNGtUV2JxTDgxaTg4M3dm?=
 =?utf-8?B?bTZGS0x0ODJMUmt0TTZ1YUNKQTR5cEtnbk9sREhNTnE3VkZQK0pWYWNOQzh1?=
 =?utf-8?B?K1BsUW1uOEk1NVVaUWFmejFTMU1OSHk3eDVhRlVVYzFWS0JWQ0tJcnh1SW43?=
 =?utf-8?B?bCtPMkY1RkE4YmVsbGtpSmVpQVZKYThuUjh1a1luYWNxTHpldXZQd1RsSmdO?=
 =?utf-8?B?eURRVkJBYjVKNmxleExaeGtZTGljMVc5eGtXSTE0L0hkYjBEa2szS3dwbzJY?=
 =?utf-8?B?ODlhWlpYL1ZRb21ESm85T0hMMWM5czJWZGJ2dTZLRTFJU2tJTU9JZkF5MkZF?=
 =?utf-8?B?d01CNmp2UncreFNZSVhySy9QeG5HcGRiZkFXNnRpNEpNbzBaVHVUbjE5MkU0?=
 =?utf-8?B?UnRPQ0lPejl6WlNhR05tY2Z6VVQrZGFyZkhNVDVSbXVvWmM2eHUyZU92cFkw?=
 =?utf-8?B?eXJIdjBrV01RTTMvU1lWbXBKYnR5b2JkeEhJODVLZnAzVkcvbUt6WWIrUlJH?=
 =?utf-8?B?RFBFY1o2V1VUcTZwOWFqQUp4ZjZ4Q1JnaXJwZkROWnV5b3VUSjVIK3k4Uk5m?=
 =?utf-8?B?R24rZklYRXV4eGZja2RDZU9IZEorRVpnTmYzWjVEQW15WkZjZm1FTzB5M2NN?=
 =?utf-8?B?cmc4YVlGQ1lIVHc0YjZtaXMvTDhNK0RPemZTSGZDNlIvamkzcVdUTyt1Zkpa?=
 =?utf-8?B?QzhHZlliVXpqZGQxZW9LWU9mWFpuYmYrREM5WGJ1N0NVMGl1NjJhUXlFNUpz?=
 =?utf-8?B?dnQzQVlLT0dIenltTTkxY2c5OXltRUFBSUdFOUR6NHZldnpDT1hDOG1KVjV1?=
 =?utf-8?B?N01vZnVEcmhOMk5EdDR3cWp3VVozZ0ZYejROcnpWNHVCOHEwZndzNWRvcTFm?=
 =?utf-8?B?K2hvbG1TcFIwazBoTXRpekZsVy9lZWhaSDU5K29GZHNQbEo1bGF5R2FzbWp2?=
 =?utf-8?B?NFlLNGRoT2Rxc2lucDlkOEpqdWtPVjh4c3pXdURxSnBEdEV3OTRpazRZQlJW?=
 =?utf-8?B?SE1JcGdldzEydEZBMW93bTE2bGo4VDZOUmhnWWsrQUJTREw3Wk5BVlMySlk0?=
 =?utf-8?B?b1YwTERZbzBwQkpRYWJBYkNDbG41RVNtSmpVeDM5Q1VaUnZ6Y3dlcDVnZEUz?=
 =?utf-8?B?R3J2OU1HcVdXTktodjJMcEhjdHN6NTBJa3E5NUhqbHMvaXlaVjFqVHY1QnRP?=
 =?utf-8?B?K3dBQjAyY1h2aFppSFNmZGs3Q1ZJS2JDRE5tR0pSMXZsb0poNW50TjQxdTlC?=
 =?utf-8?B?U1RjV2lGVFpiam5JU0RaSVJ3b3J0Q2VNcWRWZU9wREZGQ05GMWZnQWJKZEQy?=
 =?utf-8?B?NWZGUmFmTkMxV3FMeUM1TFBQQlE2dG1xODd2VU1GZm54V0NpRnVwY1QvdTc4?=
 =?utf-8?B?a0ExOS9EQkcyejF2d1EvL1BkUFZjNktWeFpWdjRNMlRwaXd2YXlza0I4WE9Y?=
 =?utf-8?B?TkQzbUVyRVZJT3JpTU1NM0pCYkFIbUhQclQ3SGREN3J2eFN5RCtKWVpvWmdW?=
 =?utf-8?B?WnliY21HREdsbjBRR0hyeE8ySlI3ZFI2cWxrWWpLb2V2TkpJd0oyMDhDbWVP?=
 =?utf-8?B?SituRWdrbklxandFWUJrQXdjeDdMSmRHTlVLcnUwejRaV1IyVjUzVktzenZm?=
 =?utf-8?B?ckdYai9CWGxyZzgydXgxcXZuR2gvWlk3OVgranlRM3RtdEZtSjFnbW16a2Fo?=
 =?utf-8?B?SUgydjQ1NzE2Y1pjclkxcFE2VEl4b01oQUV6YlJYQ2NITHMvcWdsTjVLRjJr?=
 =?utf-8?B?ZGxJRFdXRll2ZDFwUFZxMFRta0pxSVlockRVV1RZMktpU04zWmlBWEJTbm4r?=
 =?utf-8?B?QXVEWTFsdmNlR0xFYzd6TmJtWDZibC8wbzRkY3ZUSGhBYU54NUs2TWVMa2M4?=
 =?utf-8?B?MWJOWU41RTZzOWdSc2x2WVh0UkVlcy9kajNaVjlMcnZ1THo3aXZzVkFmYk9a?=
 =?utf-8?B?S2NPbjhsSnphVlJZYW16aDZWblVKaHk0cDhsRXg3dW91Zmx2eFVzdz09?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcdcb387-2e44-40db-b12f-08deec16cf63
X-MS-Exchange-CrossTenant-AuthSource: BN0PR08MB6951.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2026 19:39:44.7611
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aL7lTCZlJohjGMPsZsssZSqbxSEORxmPjV5nuyQhQC+WW2EHxUsquvsdjUMmHvmz/NETzM0b+MH4dQPTd52UCV1KN42IqeZbC9mWcnenye0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR08MB8726

v2: https://lore.kernel.org/linux-pci/20260727193714.598562-1-anthony.pighin@nokia.com/

On Mon, 20 Jul 2026, Ilpo Järvinen wrote:

> This part seems valid, the resource should not be left into enlarged
> state if the assignment fails.

Kept in v2.  reassign_resources_sorted() saves the required size and
restores it when the optional attempt fails.

> > +		if (fail_head && resource_size(res) &&
> > +		    !pci_resource_is_optional(dev, pci_resource_num(dev, res))) {
>
> This, however, will break some cases I think.
>
> We first want to try fitting also optional resources, if those optional
> resources never go into fail_head, there won't be new pass and not enough
> upstream bridge windows will be released so the algorithm won't really end
> up even trying to fit the optional resources after this change if FW left
> some bridge window too small.
>
> Only after that has been tried, it should try to fallback into fitting
> only required resources.

You're right about the pci_resource_is_optional() check.  It also covers
IOV BARs and disabled ROMs, which have a real requested size, so it would
have kept them out of fail_head and killed the release/retry rounds they
depend on.  The effect is worse in the root bus path, where a pass failing
only on optional resources would break the loop before the iteration that
passes add_list.  v2 drops it and keeps only the zero-size check.

The case where FW left a window too small should still work, though.
pbus_size_mem() sizes the window from the required child resources, so
such a window has a non-zero required size and still reaches fail_head
and the retry round.  So does a child BAR that fails to fit.  Only a
window with required size 0, where nothing downstream needs that type at
all, is skipped.

reassign_resources_sorted() also still tries the enlarged window where it
always did, so the optional fit is attempted as before; v2 only restores
the size when that attempt fails.  What v2 gives up in the size-0 case is
the extra pass, which releases live sibling windows to win headroom
nothing requested.

> I don't even know what that issue is since you don't show what happens
> with the extra pass after release and why it fails.

Apologies, v1 omitted it.  v2 carries the full sequence.  The extra pass
does not fail to assign, it succeeds, and that is the problem.  The
failing reserve is on 00:03.5, but pci_prepare_next_assign_round()
releases the window of its parent bus, so every non-prefetchable window
on bus 00 goes with whole_subtree, along with every BAR below them, and
each bridge is reprogrammed right away.  The reassignment only covers the
hotplugged bridge, so none of that is restored.  00:03.5 ends up with a
2MB window nothing asked for, and the igb loses its BARs while its driver
is bound.

Thanks,
Anthony
