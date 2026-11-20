Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795160060;
	b=FeMEg7FkYHwimMvuOxWwfQTaZMTdDpcliZiaM6zPrnD0Rdp9vf2C2y8msd1UOdcn7wo4
	 ixwOoferNfwkaJYul3w/Kt/Fs2hWif6sVZ0hmT/6eGxm9+6KLJXBGUlDsddYueL+BXZSB
	 o9zCSkQi6Lqsxp7mK3x5svOl1iUIvUdRE2rM14PmozJ01m+hl3Z1XZgV0Al2prOBPzY9N
	 NuISSYAka3DRvBKkca6nAkXfyf2cULHzwKRhDXIG0XCAE3pn1k7VqdhR9qhCSelsbebmc
	 /+2yAO6BuwuO80Y82swx/CRr9RMwGFy0OJXcE+ySVnUgaNzHkJGL3TMmL32eJUPPZXA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795160060;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:From:Subject:To:Cc:References:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=6yHRPJ6+EYtegRtGLqFU1k1xjMRGPza7UNlyCywY2hc=;
	b=vnP7W+BrtlQIvePfvw21vXd+fU/+Hy2FAPABBX8okO4Ak4YfwYKo2ozwnHM/M8bqW5Ty
	 YvR8K18XvbmIHbiDAuSrOrQtuTZCMudpfdsr6RJSyOOaqxWrXWZCuBtFH7v+/en/lYqSB
	 BJS95SXUKL1Dgfwqy2j+AcPBRtz8pVpzNjA64UbUhU2RyTA6dGLz/bJR6nckofqBoK07x
	 uBX14ghPiXsysoXvJj0p2O60OWcc2jubVgrzi1oS6B48i/tC4xMs2q+3r4RG9kQjXDDJD
	 L6ydhYI7hQsALoS2bm+5E0gT4P+UfiDpax2zGDDgBiFwFbyM25RjqBzMUKhaaFSxvCw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=LOAlr27Q;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.48
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013048.outbound.protection.outlook.com [40.107.201.48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 479CA606A330;
	Fri, 20 Nov 2026 07:34:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 479CA606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=LOAlr27Q
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Oec4J8SffHDbG/hc7i1vRBUPfP9b83ijTxd8ty621B0oHgxcC74B2mfLoBAWukE/KUjJOjXKnhcXk5imCOT2LbFWUD+umUDCy6U+SPEUPshcAMCAPQP3mmRaOCuyfrH/4iOpLQ1xsEh5OdbV4sVu5D+tgkbP4tdwFhGlzJAvxteqkFmAAO1Fv55b8NL3lth1S8mZ6gH4Zdh9DUfSozo5Diiw8ftmmZxb9liBHtAKuooMeiL7K+eryYF8urqF/dmKhclXcQIrDrk9zqvQzb5byf4vjTA/v+gck/xwVtghivha0ZwrKKaDvkzcTQELGQ0/uIgnfysQ7N6vHACZFn4ejA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6yHRPJ6+EYtegRtGLqFU1k1xjMRGPza7UNlyCywY2hc=;
 b=Si/1nxdaamTUcCALZgASdQVXhOb3tbk+F7//2zfFpwk6sMzgGrvuLo+OE1PUraxIuKWD2RoKZ0oOVvlqJek91+fcM7G5G+zLSr+ZxCdbzYfCyzRkf4x+ETAeOrOS40mjR/xgBv29IkfeqXQXOsTy6gENcg6qukMFitPlkDmkfHtuawEy9TV4yrDx81S7NbhMJwBGjD1etrOkqTLmmVvt9/MnOyz87u58Fzq2Wn5MWVuSGeMpEY/BceaJmrOmsiDsW+JcnJ4zSUE1czo0O5aq2nytrdIB3NmrFJiakppHnnmUDN0+5KFEuwvD0rXKhpSaZyH+I9QVOyzynONUeKGLNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6yHRPJ6+EYtegRtGLqFU1k1xjMRGPza7UNlyCywY2hc=;
 b=LOAlr27QtShP9WfX+rySn618ab+t7bve5EyIkAqN1Vg1UscLZnQZHf+LIS7Mn2S3TQWqiTVUkiTEW1x9I+0Aq1AXTAnsF8puKB42SIk2SlwS4N+vp6Nl9/9xOBzValBULDMj0e+onKFNNYPCuSbcMymyQnExcKj1OB924rYT0FGWXUoW6SoRMqFCGLgPMasFHqnQlRcslro4hgO38wnjegSqNJE76ydGuH0RKDoZ23rAR6lrkNOe3xL2bgJjaAq7lw4rG6FkQyuo8BBw9LYXnG6cwXB03YrwDMxMM3YPP/Ca3wQJF14c6YwwD+OU9OPhFO5EZpsWKWDz2PGngrW4RA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5) by SJ0PR12MB6966.namprd12.prod.outlook.com
 (2603:10b6:a03:449::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Fri, 20 Nov
 2026 07:32:13 +0000
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522]) by LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522%5]) with mapi id 15.21.0639.011; Fri, 20 Nov 2026
 07:32:13 +0000
Message-ID: <b35bcc93-9fb0-4fa2-a432-857eaa4dd31b@nvidia.com>
Date: Thu, 19 Nov 2026 23:32:08 -0800
User-Agent: Mozilla Thunderbird
From: Srirangan Madhavan <smadhavan@nvidia.com>
Subject: Re: [PATCH v17 00/19] PCI/CXL: Add CXL reset support for Type 2
 devices
To: Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Davidlohr Bueso <dave@stgolabs.net>,
 Ira Weiny <iweiny@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
 Vishal Verma <vishal.l.verma@intel.com>, linux-cxl@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Li Ming <ming.li@zohomail.com>, Joshua Machauer <machaujo@amazon.de>,
 Alex Williamson <alex.williamson@redhat.com>, vsethi@nvidia.com,
 alwilliamson@nvidia.com,
 Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>,
 Vishal Aslot <vaslot@nvidia.com>, Manish Honap <mhonap@nvidia.com>,
 Jiandi An <jan@nvidia.com>, Richard Cheng <icheng@nvidia.com>,
 linux-tegra@vger.kernel.org
References: <20261105185917.2667656-1-smadhavan@nvidia.com>
 <5616c825-454e-4eba-9352-b06d98dc123a@intel.com>
Content-Language: en-US
In-Reply-To: <5616c825-454e-4eba-9352-b06d98dc123a@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0188.namprd05.prod.outlook.com
 (2603:10b6:a03:330::13) To LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LY0PR12MB727857:EE_|SJ0PR12MB6966:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f0163e2-d024-47ae-3069-08df46d864ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|23010399003|921020|10067099003|4143699003|5023799004|11063799006|56012099006|261021121427099003|261021123027099003|261009223027099003|261102123227099003|261022113327099003|261026140227099003|261022105027099003|261022075727099003|261028144727099003|261026121527099003|18002099003|22082099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	GPNuZT6lXDAlqgN4+iIJVXNkjKhFdtLOSohLRXvFPkGroRE88wDkJ5sYdrnaM9hqIRRc69YmkWEyBiIdU1V/ZSwJMAtmiPpgFIQ5C5XOzA1ureO3DjB/cTkGVEq8ZjLixoub2O/yxbWU0Kx9Fq7YoUhVW8jFJqe1fwwGTxPu3VVeGZUhxYwNIWOQmoVD+TTs0VOnkldEkzWqY+aNH/sG17krzfghaeOWEOBMXYjdVF6amWq3KeRG/0qpA8bI4sZO+Qapr9DixPsFbwDxDANrRv61H0m3dkTXX+xaU8pvLPWLsft/UkpLDIem7BfXrKOMCPHH3BRqToz7buCgzPxfCQnLNR/Rc8h2g80Fi9beJzVVSlR+BbsiAD3WX7UzPlCXnWU4WJx5StpFHwqWFrunCel/IguUHyNGujgYZ6d1nevpedwyC+BXw7QUp4EfySWeWlKG44NUFtG/bsQ/0DkxTW6+gKkicAFNFrkDbxJjbu6XT+OW4uIW4fPk9VxelI8OUiu+GtmBnxUEMjOcKpdJMlXeOU2fclxAcYPWtV3T4agDFVp//r+OsMtw/qLVngpVGzCsxascHDdCVTwOUdtYfiIR0n5oX9QTt2t+70REP6X0EdUuqw7p8jVmkNipjTqL2wOjr3FGmuaq/Z+v5Cs40CRnBHEtl1eWh84bVRHrlPZ7mn3QT+ao4Cmzkbt7XBcdZCLVWtRrLSLYn3nucaNCnQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LY0PR12MB727857.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(23010399003)(921020)(10067099003)(4143699003)(5023799004)(11063799006)(56012099006)(261021121427099003)(261021123027099003)(261009223027099003)(261102123227099003)(261022113327099003)(261026140227099003)(261022105027099003)(261022075727099003)(261028144727099003)(261026121527099003)(18002099003)(22082099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TkVuZzZuMWhETlhieHB3bFZ6SDJwc2VkRUpWWlB3SmFoVG5jSzZPRUdob0Y0?=
 =?utf-8?B?Zm5hb2VEbXlDTjV2RDZBRFdKQVhQOXF4cGlEc1lOd1VhUFBHb2hxR0hXRU9h?=
 =?utf-8?B?RHBrcDFGNWtsMzA3a0lreEl5YmRwZGZwUjdQeStaUittOFdpYTBEZUF1aFRW?=
 =?utf-8?B?bzMxRjVMenJXS2RCZm9KUlcrQi9PUG9DejNzamZrdnNsY2hRaXFGd25MVlll?=
 =?utf-8?B?TlovYzZUNmNJemxQa0U1ME5oNUMxdWZDVisrQ29aZ0hWeDFMYWV6dENoSjY2?=
 =?utf-8?B?TXRGeG9HUUJhSXdvckdIK1Q3ZEdRRkdKWjcwWG1vMy8yeFFPdXRTMXArL0tV?=
 =?utf-8?B?cWRFNCtyYzNqNSs2SzNZZC9YS0NBWkpBWldCWjZQRCtoeEZMaDNPUmozcEQw?=
 =?utf-8?B?SlFVb1FVMmJ2SmI3bzdyQm16cEtwSWN1SFE5dDlzQkh0UU1WenJ6a1JzdTQ1?=
 =?utf-8?B?Y05MbU80QVRsbzZqeFdUTWU4UjQ3TmhwWGxzRU1oQkdFQ1Z4QlVaT2J0WjBR?=
 =?utf-8?B?Ky9BaDRTMGdKL2praUNvOFlhWnFJcEk5czhlS1JNWjZybk5uQ1Z5U0UrRWFW?=
 =?utf-8?B?NXJHOGk4bzZUOEtuYzNaNmVINlpjSW10Q3NBdjgrZnJXQlNkZ1NKb2ZPblEx?=
 =?utf-8?B?cmx5bGdOVHh2RDZFN2Nma1ByNE83MkdGVFJsVWtFalBhdjVEcjlwV0JkODVs?=
 =?utf-8?B?eDRlVk9COVRXTlh5dmhoVUtCNXBPTjdYNzAyZUhEZFBCaGpkaEVKRjlpdmRY?=
 =?utf-8?B?M2orZDJtRkRUajBCV2hFTkNnc3duUHY1c05GeHlqQlBzaVpsdDhNYy9iV2VU?=
 =?utf-8?B?ZHd5SjVreU9hU1NLbDE3aVpLYlNNdHAyRVRFRGhjSzJEVGtIb3pwQTVUT3hx?=
 =?utf-8?B?enZXQ2UrSzhyWUx0RDBRREVKNkE0dHR3MU0wTWI0R2FrZGIyK28zRFZxbjBL?=
 =?utf-8?B?eHJaUU1DYjJuc0dudGx3Lzd4bmUvS0VLNjJoQ2gwaFEzYWFWQnhQeHRDK2Uv?=
 =?utf-8?B?bCsxbnFVRHJXdSszcjhPREp6RkhPUGlEZThiMmtJODUvVXJNdUJNNzE0Nk1M?=
 =?utf-8?B?NEozczVoR0tZZFFJRWg1TStNSDJRVVlLNHVpV1k4OTJNeVp6Y2JXYWpvcVlP?=
 =?utf-8?B?QWVJNVFZMWorS2l1UmRKZ0xjMDRGRVZZSmE1aWZjVTJHbFdicWZwWFBnVDhG?=
 =?utf-8?B?ZUVvZWpHZXEweVU2OGFJZGpJMlN4cG1TMlF0aGcxdklselhmSlhXRW0vaFZ6?=
 =?utf-8?B?VnBMdEhwUVkxWndvdlFoMCtHaW9YNi9WQ3JLY0lmRDF2WW5UZzdEYlgyeTh4?=
 =?utf-8?B?VmZVdU9OMWM0ZjhURERvV3lZSGtub3NYYSt2Ri9Zb2t3N1JBRXArMVA0U2NF?=
 =?utf-8?B?L3ZidU1YSGdTcXhkNUV5cnI1bkNnN0U4YTBTOTh5ZXhMVjRXenVwMEpFT294?=
 =?utf-8?B?N2ZGbHhad1dLY2F4Z0djcGJYa3dmUEhuMldVQURaMncySDVNQW81Z3Y1YnU5?=
 =?utf-8?B?SzBXakxRN3pPZXNzK29nQnlEbEFmeWI0djNQcGdOV0w1OGt2c2YzSEVBZUQw?=
 =?utf-8?B?YVFjYVlRRjdKTisrdEtLbUp5UlFpK29KdUpmdGNoM0pzNEFqY2hWdTFuNFhU?=
 =?utf-8?B?WTdCSG1WREhtSElRaEZmeWppcnpMdFhRVmFsQ2xqaCt3ZVRoZ29zMFBuaUtD?=
 =?utf-8?B?Vk5Kc01tMi9WMlQ3RExFWWJmZm9VSUhWcHVINW1qMlQ5UFdTaGczK1dST0sr?=
 =?utf-8?B?ZThZak9mSUxLc1JqUDFsUHJ0VHRFYjNkUUVJQ004WTlXUVFGUzNBMG10cmJ4?=
 =?utf-8?B?YUNwQWxQUzdvYmR0SUxMdUU0TGg3MEZLVHQySTVBdkxFcW4wODhRTHJGNHlE?=
 =?utf-8?B?MEJnV0Z6RFRKUm5xcWl3aVhzallvck9JTDRVdlY4V2xTeEFTZmVuYlpnWlRp?=
 =?utf-8?B?UVlJZG10ZlJMMEFvNTBocUE2QkNBbXFkaGpFalNRTWtwdG9sSjVKWHBSWDdk?=
 =?utf-8?B?cW1GdzNGQzA3U2Q1azJWcU03b1N2YjJJZFQyWGVHQ2JYT3pFS09FemhRQ2Y3?=
 =?utf-8?B?ckNDUWI5amgyVjdqcld4T1hCU2tUblZxSkZtVXc3K2hla0YyNUVueGVaU29u?=
 =?utf-8?B?dHVGa0tTRjhIa3JadTVlbGFXODl3VVlrczEwWE5CUlZPT2Nza3FuZnliek1S?=
 =?utf-8?B?R04vK3pmSFYya1h0Z3BjSUxQVXovcEdCV0p0UGxjZk5pRDUxOVNHN0xtL09n?=
 =?utf-8?B?cFlvMWxsL2NCQjRWeUpNZ2R6ZEU4TlZYWUtkSDcrSXhMeU1DNzBUNUVSakc5?=
 =?utf-8?B?NE0xOVR0WWdqeUlpUGpnSUpJY3BLUVdqaVU1Z2Uya3Z4OEpieldydz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f0163e2-d024-47ae-3069-08df46d864ed
X-MS-Exchange-CrossTenant-AuthSource: LY0PR12MB727857.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 07:32:13.2038
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CB+OCEW0G4pK93VEfN1Pxc3Jzz342e6bbls4h3l5s1R3IIchDdnQpKQfbN3aPeNUMjB9z7zlpbj4XuuoEnJxdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6966

On 11/16/26 11:11 AM, Dave Jiang wrote:
> External email: Use caution opening links or attachments
> 
> 
> On 11/5/26 11:58 AM, Srirangan Madhavan wrote:
>> Hi folks,
>>
>> This series adds CXL Reset for Type 2 devices through the existing PCI
>> reset_method and reset sysfs attributes. It disables CXL.cache, performs
>> supported cache writeback, initiates CXL Reset with Memory Clear, and
>> restores cached HDM decoder and CXL Device DVSEC state before PCI use
>> resumes. Active HDM ranges are reserved and CPU caches invalidated before
>> and after reset. The method remains limited to eligible single-function
>> devices with both CXL.cache and CXL.mem enabled. CXL bus reset restores
>> the same cached state and flushes the host and device caches around the
>> reset.
>>
>> The reset sequence follows the CXL 4.0 specification [4], including
>> CXL.cache disable, optional cache writeback, CXL Reset Memory Clear,
>> ResetComplete polling, and ResetError reporting. Sections 9.7.2 and 9.7.3
>> define the completion timeout encodings and reset access restrictions.
>>
>> The userspace ABI is the existing PCI reset interface:
>>
>>      /sys/bus/pci/devices/.../reset_method
>>      /sys/bus/pci/devices/.../reset
>>
>> Userspace selects "cxl_reset" in reset_method and triggers the reset
>> through reset. Following Dan's v6 feedback, this uses the PCI interface
>> instead of adding a memdev-specific sysfs ABI.
>>
>> For sysfs reset, the generic PCI path invokes the driver's reset_prepare()
>> callback when provided and disables PCI I/O, memory decoding, and bus
>> mastering. The CXL path reserves affected HDM ranges exclusively and
>> blocks IOMMU translations where applicable. It does not offline memory
>> or revoke mappings: userspace is expected to offline CXL.mem users before
>> reset. The reservation enforces this for claimed ranges by failing the
>> reset while a conflicting resource is claimed [9].
>>
>> The global region lock is held from snapshot through restoration. Memory
>> Clear completion is awaited for the timeout the device advertises, up to
>> 100 seconds, so the lock can be held for that long plus cache flushes.
> 
> I think holding it across the bus reset can deadlock with pciehp and a
> PCI remove. I tested in QEMU with two cxl-type2 devices from Manish's
> RFC [1].
> 
> For a device in a pciehp slot, pci_reset_bus_function() ends up in
> pciehp_reset_slot(), which takes the slot's reset_lock. The reset still
> holds cxl_rwsem.region at that point.
> 
> Two other tasks can complete a cycle. pciehp_ist() for that slot can
> hold reset_lock and wait for pci_rescan_remove_lock in
> pciehp_unconfigure_device(). A PCI remove of a second Type 2 device can
> hold pci_rescan_remove_lock while cxl_decoder_detach() waits for
> cxl_rwsem.region.
> 
> On v17 as posted, lockdep reports the cycle:
> 
>    [   60.891789] WARNING: possible circular locking dependency detected
>    [   60.893014] irq/24-pciehp/103 is trying to acquire lock:
>    [   60.893367] ffff888072b4f128 (&cxl_memdev_key){+.+.}-{4:4}, at: device_del+0x8d/0x580
>                   but task is already holding lock:
>    [   60.894498] ffffffff84699e80 (pci_rescan_remove_lock){+.+.}-{4:4}, at: pciehp_unconfigure_device+0x93/0x210
>    [...]
>                   -> #3 (&ctrl->reset_lock){++++}-{4:4}:
>    [   60.916794]        down_write_nested+0x80/0x170
>    [   60.917826]        pciehp_reset_slot+0x6c/0xc0
>    [   60.918893]        pci_reset_hotplug_slot+0x5c/0x90
>    [   60.919928]        pci_reset_bus_function+0x161/0x330
>    [   60.920951]        cxl_reset_bus_function+0x1c6/0x280
>    [   60.921958]        __pci_reset_function_locked+0x96/0x170
>    [   60.922990]        pci_reset_function+0xc8/0x180
>    [   60.923977]        reset_store+0x84/0xd0
>    [...]
>                   -> #2 (cxl_rwsem.region){++++}-{4:4}:
>    [...]
>    [   61.013490] Chain exists of:
>                     &cxl_memdev_key --> &ctrl->reset_lock --> pci_rescan_remove_lock
> 
> With a test-only msleep() after cxl_region_quiesce_lock() in
> pci_cxl_reset_prepare(), it turns into a real hang. The reset, a sysfs
> remove of the second device and a power off of the first device's slot
> all got stuck.
> 
> Two region reads blocked behind the reset as well. A read of
> region1/commit timed out after 5 s, and cxl list -R stayed in D state in
> decoders_committed_show().
> 
> To reproduce, I used Manish's RFC as posted. It allows one cxl-type2 per
> pxb-cxl, so each device has its own host bridge and window. On q35 with
> cxl=on, plus the memory backends:
> 
>    -device pxb-cxl,id=cxl.0,bus=pcie.0,bus_nr=53
>    -device cxl-rp,id=hb0rp0,bus=cxl.0,chassis=0,slot=0,port=0
>    -device cxl-type2,bus=hb0rp0,volatile-memdev=t2mem0,id=cxl-t2,fmw-index=0
>    -device pxb-cxl,id=cxl.1,bus=pcie.0,bus_nr=191
>    -device cxl-rp,id=hb1rp0,bus=cxl.1,chassis=0,slot=2,port=0
>    -device cxl-type2,bus=hb1rp0,volatile-memdev=t2mem1,id=cxl-t2b,fmw-index=1
>    -M cxl-fmw.0.targets.0=cxl.0,cxl-fmw.0.size=4G,cxl-fmw.1.targets.0=cxl.1,cxl-fmw.1.size=4G
> 
> The guest kernel needs CONFIG_CXL_REGION_INVALIDATION_TEST=y. Without it,
> the cxl_bus reset fails in an x86 guest with "failed to prepare CXL bus
> reset ranges: -6".
> 
> I drove both devices with a small test module based on
> tools/testing/cxl/test/accel.c. It attaches each firmware-committed
> region with devm_cxl_probe_mem() and has no reset handlers. Then, with
> lockdep on:
> 
>    echo cxl_bus > /sys/bus/pci/devices/0000:36:00.0/reset_method
>    echo 1 > /sys/bus/pci/devices/0000:36:00.0/reset
>    echo 0 > /sys/bus/pci/slots/2/power     # second device, 0000:c0:00.0
> 
> For the hang, add msleep(10000) after cxl_region_quiesce_lock() in
> pci_cxl_reset_prepare(). Start the cxl_bus reset, remove 0000:c0:00.0
> through sysfs two seconds later, and power off slot 0 two seconds after
> that.
> 
> Separately, pci_cxl_reset_prepare() returns with the quiesce held on its
> success path only, and cxl_restore_state_after_pci_reset() releases it.
> With Clang 23 and CONTEXT_ANALYSIS=y passed to make, that gives five
> cxl_region_quiesce warnings in drivers/pci/cxl.c.
> 
> [1]: https://lore.kernel.org/all/20261106035911.1280066-1-mhonap@nvidia.com/
> 
> DJ

Hi Dave,

Thank you for the repro. Please let me know your opinion on the following fix.
It also covers Alison's lock scope question.

Reordering the locks won't work, since pci_reset_bus_function() itself
takes reset_lock. So I'd like to drop the region lock before the reset starts,
and take it only for two short windows:

   pci_cxl_reset_prepare()
       lock(region):  cxl_hdm_cache_snapshot(), set reset_pending,
                      cxl_hdm_ranges_collect() + cxl_hdm_ranges_request()
       cxl_hdm_quiesce_flush()                      [no lock]
   pci_reset_bus_function()                         [no region lock]
   cxl_restore_state_after_pci_reset()
       lock(region):  cxl_hdm_cache_copy_decoders(), pci_cxl_restore_state(),
                      clear reset_pending
       cxl_hdm_quiesce_flush()                      [no lock]

   cxl_decoder_commit():  reset_pending -> -EBUSY   [next to sanitize_active]
   disable_hdm():         also update the cached global_ctrl
   cxl_reset_execute():   same two windows for the DVSEC reset

With this,
  - If a region gets torn down mid-reset, the cache is already refreshed
    (cxl_hdm_cache_refresh_decoder()), so restore just re-reads it with
    cxl_hdm_cache_copy_decoders(). Patch 17 had that call, and patch 18
    dropped it when I moved the lock into prepare.
  - A new commit mid-reset gets -EBUSY. Regions committed before the reset
    shouldn't be able to come online, since the exclusive
    request_mem_region() makes the kmem and pmem claims fail, as far as I
    can tell.

Questions
  1. Is reset_pending in struct cxl_hdm_info, checked in
     cxl_decoder_commit(), OK?
  2. Can I keep cxl_hdm_cache_copy_decoders(), now used again, instead of
     dropping it?
  3. cxl_hdm_ranges_invalidate() and cxl_hdm_quiesce_prepare() assert the
     region lock is held. To flush outside it I'd relax that and rely on
     the HPA reservation. OK?

If this plan sounds okay, I can implement it this way in v18 (and rerun
your reproducer against it)

-- 
Regards,
Srirangan
