Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.61
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795162897;
	b=wHX2L9d/OIgaHtR5J+r/Q5EdncqAS0iAl/DKPkLXu5inhx7W42u2ABV6c8gwZZRHIjXf
	 VtGkF9ZkdJPsPv7IWOrUUXm7fp2olOhN/CZ2Rf1OJ/mX1WdIfus9UKXvtYTRCyjjRgy9u
	 dm/jPpL4uScAyZhuf4Fs7paYeRZAXCBq4namnJVJFs6rA2vf7/2RsqlOLppJwrtQ8sXne
	 X1L8HAs4UD0XCz4J+RYTheHDfJZyUjKooRkqCJZRXZxIeJX4iZXQXigow8HqXkzNpYkN8
	 iLg1sqK+r3LdPy1nMc8qgzGpVZ9/UBfT9rmgNtMSf7Pk317KDwZfqjV/atcQ8DYjyNQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795162897;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
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
	bh=P1qpI66a+ZO8/fk6whHKo5R+7lWaihL0OJqCjEWZDGc=;
	b=HWzLhVft64IhPwdld6lTJUInVhaypiwnNzelw5iqgStdvcXqkUT5i3bTAiIYSahDwZBB
	 7u8sxN38CYhFDRmqf1JO+CVIueFpoI3SwC4rBXFQ7pD90IQD4Mu/ab+8T/pVhfWdqEdP5
	 4zZRkI7fgzHujwvPuzn4OB+YNQByqXYqXgG1r9kKCKo6OfIMRo5cKuRMUrL1+7eQLRfD+
	 4y8FfOJj0I4Kz2tacgEJt6ZKVcz1xXVKNwGuHe+ZIV30dt2MGjftYfCW+ajVdN7vytwFC
	 O5lvSbwn1VaX7AhmBBvL3XUZPXhV6+cEwnP+b6YL5XHD6j18EfcU0biitizZhREF5Xw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=ES2OoEV1;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.61
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012061.outbound.protection.outlook.com [40.107.209.61])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D4F606A325;
	Fri, 20 Nov 2026 08:21:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 21D4F606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=ES2OoEV1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gY0NKzWjJVIEtboSVSod8Yhzu8lJy9RP8gK2dm7xNKprosQugINKE2zMD/mKuUGG8Tz15kdvw94v/n7nXpusKX3dO7+K3yC9+85BywGW3y42dphEg6AE8xx7Jvg2FOlqqIRg6arNJ0zo6UkMr/AG2oCq4TPjb3Ip0SRr5fZ2kHsx0JLx3DovtuGuTIHMT8orVYN9uRIbqEP9s12xurEBNfhp/SGWzzCt7VRtddrEKNpaLBQPPVk7+W5nrKJ3CmpNWQQK1xdIM2uxiPnpu6ADgNjNS902/WtJppa4+ZrHFCRicpQDafYlp0rhCv7GTcBUhvWPiZ9O1SfcX3nXDEu76A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P1qpI66a+ZO8/fk6whHKo5R+7lWaihL0OJqCjEWZDGc=;
 b=oGso1JBQlIdyNnvRvrkxKGrj6C8//c3aCzBEYM3lhaxN1r/E81j+U7S+0A6mJoCxBbWYF+vIdnbAtKnxlxb/ZVgMNxP7hbyhzwzJBLPd0gvK6Iy1RJpwmpEROrgTLHnolsa2Ov6eMNQmJ6GUWH4zmDjSoD14so8xbAKPZP1VKPvLKQClNH6lwhOc+pylxc1KdMJkmPcuJ6hf6baG1T2A0UU9LZ31ZmJ4UwE91I2Hy0tSqr/WQYxpwgLs1j5uEjd4XwhCmvJbs4ySqNVhibLlZnuZE9t14m3srHxn14zb7UXHaIFd4YqmZb9r1Z4HLlNYhK8xqNLWMl+0QF1VWKv02g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P1qpI66a+ZO8/fk6whHKo5R+7lWaihL0OJqCjEWZDGc=;
 b=ES2OoEV1O9Uhz1xRB99Y9EY55BL5u3+AklPRiREit1O9iD5mpBfHASjfDuk/MYn7AS8KT03HJDlmqPF+hfndphuskZ1BiC1Cb9RB2tflXS/rhQUKQt2AdPE/alPE8w2ZWK05j62rXkmmU+Y/pGjWsouMDgkBZ41YxKQ36K+odJI95dC9hp13ddoqLX8kROA7Bemt+h/Pz1k6XFvsNeGH76zpNMWLL6/Wc2bN8UU20cWI8ltcP0j1rS4aJmK3S+us2YLD3z+M41BEJdxcXmqdDoY3uHTCfpPmA52U4mhGSomKZ00UnojHKeWD9HRe4/DrPQChWkTBFPsHPgdXDkDCbg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5) by IA1PR12MB8360.namprd12.prod.outlook.com
 (2603:10b6:208:3d8::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Fri, 20 Nov
 2026 08:21:33 +0000
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522]) by LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522%5]) with mapi id 15.21.0639.011; Fri, 20 Nov 2026
 08:21:33 +0000
Message-ID: <5955f76c-4c69-4a3a-85be-a1c382e5e0b9@nvidia.com>
Date: Fri, 20 Nov 2026 00:21:28 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 16/19] PCI/CXL: Expose CXL Reset as a PCI reset method
To: Alison Schofield <alison.schofield@intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Dave Jiang <dave.jiang@intel.com>,
 Davidlohr Bueso <dave@stgolabs.net>, Ira Weiny <iweiny@kernel.org>,
 Jonathan Cameron <jic23@kernel.org>, Vishal Verma
 <vishal.l.verma@intel.com>, linux-cxl@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 Li Ming <ming.li@zohomail.com>, Joshua Machauer <machaujo@amazon.de>,
 Alex Williamson <alex.williamson@redhat.com>, vsethi@nvidia.com,
 alwilliamson@nvidia.com,
 Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>,
 Vishal Aslot <vaslot@nvidia.com>, Manish Honap <mhonap@nvidia.com>,
 Jiandi An <jan@nvidia.com>, Richard Cheng <icheng@nvidia.com>,
 linux-tegra@vger.kernel.org
References: <20261105185917.2667656-1-smadhavan@nvidia.com>
 <20261105185917.2667656-17-smadhavan@nvidia.com>
 <avyQ2sXKfvdz9SVs@aschofie-mobl2.lan>
Content-Language: en-US
From: Srirangan Madhavan <smadhavan@nvidia.com>
In-Reply-To: <avyQ2sXKfvdz9SVs@aschofie-mobl2.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0342.namprd03.prod.outlook.com
 (2603:10b6:303:dc::17) To LY0PR12MB727857.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: LY0PR12MB727857:EE_|IA1PR12MB8360:EE_
X-MS-Office365-Filtering-Correlation-Id: d76db521-7328-41c1-b8e0-08df46df497e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|23010399003|56012099006|11063799006|4143699003|261021121427099003|261102123227099003|10067099003|261009223027099003|261026121527099003|18002099003|6133799003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	R6yvtsPpP7NHJINPbKFFQ6IMaXHXGJ5TSKM5iLMxgOh0PnrK9iH1BL/F4Yx4393b6IB+EEcj0DuQaOsNarR3W0URauA/ZJBvnp1b9nz4JWCpqSd3+GExBLVvCxxCwcHjFbF6Axzh/Or/epxo/wa2/9aE2yDWRgaIMeUJhRJMgcj05E6csAkepKyyDzM9Q1brs3L2UuceO2xe6w5/94ZZtGbDcqe/CwRHgHSApWwzuloe1oJ9uiXkFaFrjLpYHqpsRbaM5S+VgoFNdnxSUoCB2DFDbI81VTS9rr+bdrt/q7791zURUbb0H2sDTIyyBXmx/ib7Zggj1gDxcmNf1LWbEtVaooJfHFX7bhCNO9e5+5VPIHjS4KoxTPRQwY7/kgBirh5il4B7VAb4M+VQs1Dg+Gu4HV7qQgkzMidqu/vLYS9lDZ4nUKgz11ao2Ag84RRIUmtqP8hFJXLCihrxwKkQY/2HnKC8NApkzP6gftuA3OHPOh3+vdiTJEf1q1LwJN4D3x6deGnQtlUoy86rK6R7JhP4oY82vNr+qs8xf3m+t25rq/CnqjKigkhe280I3VzA8Dp8UbPBM0FGalln9fhc5MNrNQQWAKSVG4+mqhm2D2IfXtbjeZD9N7vJc1pb/QCZa7GUzQoZGeWtlAxW2/5A7co2CCYK1UCLgH/kI3r2xQg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LY0PR12MB727857.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(23010399003)(56012099006)(11063799006)(4143699003)(261021121427099003)(261102123227099003)(10067099003)(261009223027099003)(261026121527099003)(18002099003)(6133799003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YUJPQUVzb0JiS3NMc2Z5UXpjS1JiSnAyNmErLzlIWCtyVnlLSlNROUZPRlpi?=
 =?utf-8?B?TWVHa1F3WU51ZFVlMHNTQkNwRzRUbTArc2I2SUJsSTcwN0YyemRBMzltQzVa?=
 =?utf-8?B?aTQ2MWlYYVpBZU5QRXhvbnk3QTF1MUpYazFLanBvVDhlaGVzc0h4U3Y4MXhQ?=
 =?utf-8?B?WStMTGpqYjhJTFc1NG5SUDhwZzBPWFFqWmFYWGliWUxZSDB1bzl3UzRRazA3?=
 =?utf-8?B?bDNrOGlHb0I4ZGl1aUVVdEdjWUMzWUlubFJ5S0xoRU03QzdtbWNWa01KbG9Z?=
 =?utf-8?B?bm5wSkd3Y3FMUXlTSlpvdSsvczJnSnEzejYvcE9EdFFxeHQ4UmRHdytqU3dS?=
 =?utf-8?B?MkRCd0RsK3pNMk8rcWc5aEhIbHFXV1lYOW1CcTFkT2hmdmtBSmJSQlpSWDhB?=
 =?utf-8?B?NFBJa1kyS3NpdjRxNTNLY1EvamhSei9vTmtEbWRsNVNVNzMwMzUwU3lDQ2ln?=
 =?utf-8?B?ZThTQmlXSG1EazlwQ2tYZFBqcnRTMjlrNnJxaFl3L1hEaHF2Y2FvNlFIV3Vw?=
 =?utf-8?B?T3hwR0p1dkx2WnZmWXcyOFNKQUdSUEI3NGdGaVdqMTh5eVRUKytKZWlOZVZD?=
 =?utf-8?B?QjZDN1dwc2Q5RjlGakFyWm1KOHJLSDZZSzdMRHlobTRLSHFGck85ZktNOTl4?=
 =?utf-8?B?ZGJIVFE2dDEwZm5oNEE0eEVPS2pHaWlZaXhlN2wrTHNwU3dMWHJvbEk0OVI0?=
 =?utf-8?B?WWtwdlVvd0syakJQTHNqV0M2SjNzcGRTRm1FVUV5M0NwN2NyUllhQ09QMUw4?=
 =?utf-8?B?anREUlJ3V29ackJpcjUxL3FLek9XeUJJb0pLd3h4WUE2akNZalNpalBGTDAz?=
 =?utf-8?B?REJxcUU0MkEvZDdiNnMwRkRWQzJGRzJoRDdTMjhaWTdMOGs2a1VDSXBNTzFI?=
 =?utf-8?B?NGxQTXU1a3pRVGJrZTVTUFBRWUx1L2JtL0tUVXljOFdhZHNPa3hWenZ2UzN2?=
 =?utf-8?B?RW1mQzE0a2F3MGJ4RGl1cFRhMEQybmtnZDVyQ3p2RERtblZwL2x1b2pZNTZ6?=
 =?utf-8?B?cXZGUWN1ZG91amJURmQxWkUzSlhYT2szaXZJbFdEeXVzS1VuK2JQOFl6b2NG?=
 =?utf-8?B?eFpOUXg1K2gvRDVETE9QSXlLT2Y0T2czZUUrUW42czdjT3pTMHpLdGtsc1Vq?=
 =?utf-8?B?Z3FLM0VGeHAyUnpJbk9vWEZtZkZxWXZNd0UzRG5GVDY1Qkd6VktIS2NFSnlZ?=
 =?utf-8?B?ZWErU2praGtUVE1KV3U2YWNEODRubWlJMk00ak9iazd5OWRWelh0QlEwWFJ6?=
 =?utf-8?B?SmZoVGhvSVA5ZGxDRi9xQkk2Z0ZKNldOVkliQjB3aDR0VGlQSllXNGZpcEpa?=
 =?utf-8?B?aHRpaDk4d0czZlNyeVltWUhycm9RU2YyNzlERkthYXprMjAyS3ZNS0E4SXRX?=
 =?utf-8?B?cGNmWTRTSjhPQzZWbkViMTFQc1pRSm9mVkRZSE54Q0ticjlQL0RjNmQveng5?=
 =?utf-8?B?S0Q0cFBMRWV5dFF6MndFZkJPRVk0MXdNWEJLVHRCeXM4NVhPQXhYdVB0ODZ0?=
 =?utf-8?B?SUFPQjdkQk5KWWhrN0pxQzFFR3dLMktyVnhUZHVQNGEwTDVXcThtRlRMdnJm?=
 =?utf-8?B?b3V1Q2VYNkZncFFJZUljVVRsV1ovMzE2ZGpubm53ZnRaZzArWk1EdVdkcTFV?=
 =?utf-8?B?UW0vT3lhaElFVEgrRFI3ZnVVamlha2pjL2tJV0pTb1FUdXB5Z2oySUU4cUt5?=
 =?utf-8?B?MG4xT0wyZW5wLzRMZ1VJNnJxL0U4cWZoM3ROR3BZYkdLWTZZSktpdGU5Uk9B?=
 =?utf-8?B?YTlhK1YvVGJPT1FkUWxzRlBpMEZCM2xFTXVrVlhWVThoKzlqRzZzNTNQVmxQ?=
 =?utf-8?B?L1gyOThadUlVcmQ1VW1BQVJhbUMzMUwyVjNSTXJLbTVBdzk3L0ZwS1VUbWh2?=
 =?utf-8?B?dTJpZEpQT0R1bGpnNTcvYlNHUWFyMWU3WjZ2UUtvUHg1T0YrTXFuQnJwRHJH?=
 =?utf-8?B?dWtjTE1DeXpIVmFZT2pjL1VWdkFjY2JjdTVMakVTRlZ6YlBkZlpkbzRHSWd0?=
 =?utf-8?B?MDE1cjJxcTZmMHVGWEs2KzQ5b21oWkJpNjRpMDAzU3F6NVJGV1BCbGgrWG9I?=
 =?utf-8?B?SWpvNTBzc1padjZPbWxER3R3OEx6UXFlZGVTT01pRUJsWklPcERqQzlKNktN?=
 =?utf-8?B?dkc5UmtPU0YvR0hWNVJRN2xuT2U1OVF5d1JrZ0YzYjVZc3dSbFBnNkQ3eXE1?=
 =?utf-8?B?MS8wd3hhc1VldDRQVEhwa0VoWlVsNkQ2Z2EraXlRUnBXRkh5WnBGVDNxTjN2?=
 =?utf-8?B?bmZibVNNNVRQam5nZjk4ZDRUMVJzMHNCRDV1aE9EMzIvOEtZRjFvMi9uOVZz?=
 =?utf-8?B?dzcwWGZwWlRYM05GbTE3MjUvRWJMcHM4eGcvbk1DOVdtUVZGV2lQdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d76db521-7328-41c1-b8e0-08df46df497e
X-MS-Exchange-CrossTenant-AuthSource: LY0PR12MB727857.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 08:21:33.5736
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IGb+hi5RWaS87GO/6XTspMrfqf5T2DXTqi6Cu14Fw5F9VsH26yZLB4hy6IfkeaJoEOTFf4NAR9y1UjdLvdV7Dg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8360

On 11/17/26 9:37 AM, Alison Schofield wrote:
>> Register cxl_reset with the PCI reset-method interface and place it before
>> FLR, which does not reset CXL.cache or CXL.mem protocol state.
> Same theme, trying to understand -
> Can you clarify when cxl_reset first becomes visible in reset_method
> and when it can actually execute? Can userspace initiate reset before
> endpoint and region discovery have completed, and is that intentional?
> 
> -- Alison

It is listed at device add and can run once the HDM cache exists, so yes,
before discovery completes. That isn't intended for ranges discovery
hasn't resolved. Proposing a fix in my reply to the cover letter: 
https://lore.kernel.org/linux-cxl/20261105185917.2667656-1-smadhavan@nvidia.com/T/#m82b76ee0215d67d91f67ec6fa72036615f1adb4f

-- 
Regards,
Srirangan
