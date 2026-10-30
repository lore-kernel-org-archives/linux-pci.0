Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793392518;
	b=CjFpWp1YgH8R9RSR6DcjTr6NzFCI1Jmx1esX11Smf83dkCJKJV71vsaxoDdVOBecg/U6
	 81Y0m4Qgn+nfxxlsSXj8CSqNKKbCKaoPpMPrZVv+S70yP8VhVEG6hyCQ/xVL34INiVk/x
	 tSNF8z2Zw1eOKUFXPD/dhu1KM3ImzoTLylWybLS+VvZ2zoQnUBIM3VHFimTIM0c5eCJTL
	 lEuDlOw355AbSAt4BMjaazBqKmdfw3hoe4MD2S1ERFlwl7WyyvpGCukkKLuHX06lCUiy5
	 hWfOnaITfsLMUreOCoX8qiGxQbxiknE7uh1dVebt/qx9f1v2pXHnXLI0eU8kA3tvt3w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793392518;
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
	bh=YpI7mQ/BWLqe8gBmrG9DIETD244hod7Fk2Gt0VtBeHM=;
	b=1oi+bcGvJiOfQZx5YrRTKQQ13HSyJJWCTpRdJnc0In2BNAXvHghozJqUu6qEmGSClvXF
	 RIPwS6FUf7cUjRaMUTvX/HCV4pIfjgJR4nLaLGBUZo6SNlNEi1IUUDLDS1ZyPkjJuDURC
	 UCBRILq5FS/Vz0ki7d7cwYV+80d9MnYoqi0FlA5a8LOtVykTvCiUtvf6+DEJxF+h7cSfH
	 869rwL/VPpGYG0NWd8RJsSk3zdSiSRfgbqK4sIMSz/9xidwTmXoAA9HRyRjLEuVJc4Dny
	 rcUCeA9bPu75j41Mlytweg/oGjDTLofAjjLAf1jY4sc7zqXjyuzyg9lcxyfY/ZnCxcQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=TlFHs3Ml;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.18
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011018.outbound.protection.outlook.com [52.101.52.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8786E606A31C;
	Fri, 30 Oct 2026 20:35:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8786E606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=TlFHs3Ml
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=prznGsQY7f/nBnmLjQOQ2zvHyzo/zBlNLLMMexhdnpZWv6191XCqYzgEYYDPFlwEWmFDgOl1CTi0qqYONCe2ljKX1RLa0XEqZjd7/1veqqhwuqV2ZQEfNGSKGSfCGWu2WSX9cecMod/1jMJmxAs9VPI0MRMpu6Jdqj/bXfbAS+BjbF2LsUU7gL3HG5ds+FAqeBn/q2Myj4kwQnTwOCwZih/OiBPx1g1DI267yvCjVaDcEm06NDens0ZnADOMrsgohAZWfFbSRaqoIlssIw5azC3i2F/7JtlrkDu/V6DyrCB5EhBz6IFKQjMhgC03FkChs4fGV5XX0b31WWaePb7Vew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YpI7mQ/BWLqe8gBmrG9DIETD244hod7Fk2Gt0VtBeHM=;
 b=tWm8s8YqsjlNEIn7Lu6qysRpaHco+SJKVWdVK0WWVYWN0XZFXRlGb+/88QWTut5iJ+ZF5Q6DC5fFMN9bZs5s/Z6h0n7dlPXikM1r/yyl16kP4pAZ1wwXuYizWGnoBPXc63yZrDEWVRmTTs+ezd153bT+wl0IkW2ukDWIdwiqY9yDPqVJnphdqvDYBkwS7Evn1k2u/+ZWkli6Isfk6oLHLX5BVjumIzg3kdM8UMu7G6hep+QBXSflOANgPz/zMnA3EhAGBI1PQ3m/JA5ao7X/JyDeIwLVOhGz2cy9CKB1dlG6wxmdtoqUp76nCUpGsyPe+1/m/gFPOF3D60WIiTu/WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YpI7mQ/BWLqe8gBmrG9DIETD244hod7Fk2Gt0VtBeHM=;
 b=TlFHs3Mln9Ps79zRajaxzQNBrrBm6ffs9M3FybUPJHAYHRn/lttuytWX4XpgeKgDiFNTbJZblPUcl3CAb6EHqVEZ/FER+JqaP8FGhVVkmhRhz2ouI2PVl6s+wAgpLlXS3XTUfiENp5ZLS0TVH2AzvvRRDQFu733GrYtHgVoo6R2T4ndsXogROHq6RzX/ICnKviw+MUmr5tl8nlk5xkOsfEsY2hfnnTKMRPEFcgod0yLzYFlkyP6lviC9dA5skvNC7kr7i4Sd5LSrIjzV9Hu0W+k26o5mlLBLMkN9SHgRhWtUiMq2E80C07u+JrQUXfgek7afUJ9XSrUx5cNOwVds5g==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6549.namprd12.prod.outlook.com (2603:10b6:930:43::6)
 by DS7PR12MB8346.namprd12.prod.outlook.com (2603:10b6:8:e5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.9; Fri, 30 Oct
 2026 20:35:03 +0000
Received: from CY5PR12MB6549.namprd12.prod.outlook.com
 ([fe80::2cdd:a549:db13:202b]) by CY5PR12MB6549.namprd12.prod.outlook.com
 ([fe80::2cdd:a549:db13:202b%4]) with mapi id 15.21.0546.021; Fri, 30 Oct 2026
 20:35:03 +0000
Message-ID: <fa34aec0-08a7-40ee-b2b0-468bbffa3d27@nvidia.com>
Date: Fri, 30 Oct 2026 16:34:52 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/12] rust: pci: add VFIO override device IDs
To: Gary Guo <gary@garyguo.net>, dakr@kernel.org, acourbot@nvidia.com,
 kvm@vger.kernel.org, rust-for-linux@vger.kernel.org,
 nova-gpu@lists.linux.dev, linux-pci@vger.kernel.org
Cc: alex@shazbot.org, jgg@nvidia.com, yishaih@nvidia.com,
 skolothumtho@nvidia.com, kevin.tian@intel.com, airlied@gmail.com,
 simona@ffwll.ch, ojeda@kernel.org, alex.gaynor@gmail.com,
 boqun.feng@gmail.com, bjorn3_gh@protonmail.com, lossin@kernel.org,
 a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu,
 jhubbard@nvidia.com, ecourtney@nvidia.com, cjia@nvidia.com,
 smitra@nvidia.com, kjaju@nvidia.com, alkumar@nvidia.com, ankita@nvidia.com,
 aniketa@nvidia.com, kwankhede@nvidia.com, targupta@nvidia.com,
 linux-kernel@vger.kernel.org, zhiwang@kernel.org, zhiw@nvidia.com,
 boqun@kernel.org, daniel.almeida@collabora.com, tamird@kernel.org,
 work@onurozkan.dev, jgg@ziepe.ca, bhelgaas@google.com,
 kwilczynski@kernel.org, dri-devel@lists.freedesktop.org, peter@colberg.org
References: <20261023154009.2246627-1-xinmengs@nvidia.com>
 <20261023154009.2246627-2-xinmengs@nvidia.com>
 <DMCHLXM8XVPO.3UDJN1SJR0JHY@garyguo.net>
Content-Language: en-US
From: Simon Song <xinmengs@nvidia.com>
In-Reply-To: <DMCHLXM8XVPO.3UDJN1SJR0JHY@garyguo.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0176.namprd03.prod.outlook.com
 (2603:10b6:a03:338::31) To CY5PR12MB6549.namprd12.prod.outlook.com
 (2603:10b6:930:43::6)
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
X-MS-TrafficTypeDiagnostic: CY5PR12MB6549:EE_|DS7PR12MB8346:EE_
X-MS-Office365-Filtering-Correlation-Id: 74228fcc-8070-4da3-71e5-08df36c54665
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|23010399003|22082099003|18002099003|3023799007|56012099006|11063799006|4143699003|10067099003|261026121527099003;
X-Microsoft-Antispam-Message-Info:
	UKGbyhdLp2nTBdBVdqIPT3ntkOEvG6Fh2hrEPCoXa8Cx0X8pWyrqgpHmVjVqmaxr6EUXEqzr3rs+/WubOEmJFk3/0ODBdjG353FY5BesMchS0pNwEwvAlnE6XNXhcouUZG6jAwVEyGtLh7Nra2qpAzFETQzrd4NAGOfpeAKhmUvuVl9ZKlPZv/u5GbZVMWp9hO15bfhM0PeppLEXML6AeK3aaAMp4faPUTMqMEOHyq+LFVgm0bAd4vsPVKfC96UK3InwI6GhH4qqTSo+IaZd7tKaZUSQDqLIQ3kxsk2TR12Zz2ffwU13ajL2fCyyprbSLDtueJCtpFqpCw4rYPCGA9qHKHqIoTrWCJ0lzAAagIHpwJAtK7WefD2r+AjeyiqCm4ZttfUjqAcK6aEHz2y7ovDeNNc914th0lTdU4p4T1zqa1kRkg2IyijArKBX6RUJ2ACDZG+SIeP4L2QmzMeD6fDdQuQObE0snTLMXbqN5Id+sBn/L9vfPVsNBZBWmQy9A4SCtlWktAkQBv+3Cn1Vj4SqUF/F+rNe9WfmydGUcLFoBJIw3awijQpVDqqdH5Hz20XxYzpJqdbhARnanUMDIGPjcI3CwReIBYavQVlyVKhimR4x4IN/hVFWz/T5MmoOj/PvlsxC9v5QIIRDmQVZO/tsQkC/eqoPxSVQPyZEvg4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6549.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(23010399003)(22082099003)(18002099003)(3023799007)(56012099006)(11063799006)(4143699003)(10067099003)(261026121527099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RmtEUWlCZWlnbWpMb3FnQ0ZLZHlJRTZCRFRybnZIVWZkWUZibTgrZUNFWlBj?=
 =?utf-8?B?WWNIRUV5M2NEa29xQnhlWFc0SkhmcnhWMUFaNTdZVERVbkNUM1VvZ0Nhajly?=
 =?utf-8?B?UDJrTnQwb2ZUK1RJNmRvYWVJOEpTYmt2N2NuNnJNZ1NNb2RvVUlxSHBzWWU3?=
 =?utf-8?B?OFNiSDIxVXNBU0dmRjg1SVpaVUlDYkJXdkxGTVVBSStUdFI2VFd3dmoxUEZK?=
 =?utf-8?B?V2RIenJwSTFmMDdPZXpTTlhQUXpyN0pLbjVvOHpZVG5SQjVyZWVDR0FtMWlM?=
 =?utf-8?B?TVdZZ3Y1TXdHcnJVSjlOTW9sNXhGK0dXM21YOVlGQ1Y4MW10cnBJUkdqa3Jk?=
 =?utf-8?B?VzFhRE4rMEZ2clY1RHVOdDczQm5oMkFDb1Q3aXN1L0FzVDVqUlNWVmpzckpi?=
 =?utf-8?B?bWtOVmhFQzZYZ0dDM1FiWTZicDVTNGg1NDJWSUxXUDhsMzJhcVdYWDh4Z05T?=
 =?utf-8?B?eCtGSlRYSGFjN29lQmEvSzMrNU1TVlBQeWtCWUJnWmRyRDVuaXdEM3p4TytH?=
 =?utf-8?B?Uzh0MDBSeGlnK0diMzF5Q0tiSEZCTEczdzRBSThpb21ucGFiYnN0SGdKeXox?=
 =?utf-8?B?ZkNoVFJpWm1rR0FvdmRUdG9KLzFzdk9EOUZ3NG5xT3prdS9KRWllSHRnR2hD?=
 =?utf-8?B?ZGhRRkxoVGNuQjcvN3JoWTZjeDBLeEFSNG9Keit6WndocUFLWTU2dklOaVJP?=
 =?utf-8?B?UUoxUlFObm54Wm0zdXVTbHRTVitzMER0ZjhtMk0xdkNVWWhESmtTelp4dDJ3?=
 =?utf-8?B?UTdybUlmak9oVmY5WmN4by90OXNWR05aRlNNNzF2V2JucU9pWkxEWjhRemZt?=
 =?utf-8?B?eVFZYzJhMzcrcVQ0T0ZWeVR2dktDTWJKWVZmNkxNaTNzMks4azVQODJSWVBE?=
 =?utf-8?B?ZzlyakljNklRRWF1K2g5d0E4ek5mZW9hSTEzRDIxZzRMMlp4cmY4Rm5UNHlj?=
 =?utf-8?B?YWpVYWpFb1J5VzlDay9LdzU5T1ZXREZSZFo4cCtCa0t2d2dUNzVBczIxejlB?=
 =?utf-8?B?WEhZTXNRNGJXVEZ5Ykl3YW9jczVBSUFoblpmMFJFQzhjQTZRbnJFQ3V1MVZo?=
 =?utf-8?B?US83VExyd3BHOURtYkVIUVN2WUVSS0l6M1JHUG51OVFVMC9vYUdhRGJDVDZL?=
 =?utf-8?B?MndJM0RDVmZnNnpXSkIwU1JtMUJVaVA1OTBxN3EvWUlaRXNYdEVhN2FlTXQ5?=
 =?utf-8?B?UThyYTVoN3RPRUF2OHhyLzMvQ1R4dXBUbGNpeVZsYVM3WlVTc3F4SmpDQVB1?=
 =?utf-8?B?ZXI4MDNFTzFsNDVqNVV0Tml2VE9UWGZLand2MkxPc0Vxa0IxME9CUEQwNlRh?=
 =?utf-8?B?RTBITm9IYzV5NjBwVUFqaWtNTHEvaUc5TEFGd01SN2tJaGpjUklIV0JJclQ5?=
 =?utf-8?B?UHdoUTZvWUJFZlh3Z2FHMXlMU1lrMnArc0cxcXp0cld1NEpCUjlCU3RTak1q?=
 =?utf-8?B?TjhjNG5WTXFveTR6WXpkSmFGcnRFb2xVQ1dZV1pqZ0ZVYkpld3dGdGdHUXNL?=
 =?utf-8?B?ajdvN0VGamNINmlKUVdSMCtuZG5LNVA5OGdSSFc3WXFZeDlTbDk0NERaYmNt?=
 =?utf-8?B?clV4UC9YQ2FFRjlWYitsbkZjcGRHZXRiZThoanJqcWh1ZzNHZ1pXUTU4VzI2?=
 =?utf-8?B?NDNFMWE2THZxbEFvaGZKekRzd3R6andDazE5TEFtU09jY2xuTDRaSDRsbXBD?=
 =?utf-8?B?VktKVlNlN1ZzYXZIWFRVeW4xZVl3SXRQaTBUd09PQ0NJT0FhVFlIMnlza3Ny?=
 =?utf-8?B?aWlETkxUTGFWUlVzdnBlZ25mSXRBL0d4L042amJFa1FSODBTbHhEelRwMXFM?=
 =?utf-8?B?SDdSRmo3M0kybTc1b3VUczZuS0ZpMWZQM3hhWm93UVg2S241U3pKYlJaVnk2?=
 =?utf-8?B?dmJVcERia0N6bnNhdmJibWMvdzFnSjRyZjU1ZzNtb1M0b2NOQVAzZ011S3hi?=
 =?utf-8?B?UG9VQzRDanpheHRIV0VQQjlKaVI1aVMvRjVScVVQSWduRlNHMEpLTWdkUmov?=
 =?utf-8?B?R2taajdDeldmdml3aTFyUGlRbVN5OTB3WlpIZEhYRjJoUllVbW82RHFPWTNk?=
 =?utf-8?B?Znpmdlc4T0tqU0MvSzRvek5BSkxDYzA3ZUpqZGdWQTV4MVlLTjRDM3Z3bDFy?=
 =?utf-8?B?UnpRMkRQR1hmM3grTE9WaWs2KzN1ZDhHaFJweGhISkExSTNRU1ZxVmlESUsv?=
 =?utf-8?B?dGxWNk9XcXFnRlRZMFhZbFEzVlkxWEhKTktyZU8wMEFmRjVISjU4cDAreTl1?=
 =?utf-8?B?SG54RHZ6MlZybEo2Ympvdmt4NnZwQ01oSUFvait4amhndjdQcHBXOHJlWURi?=
 =?utf-8?B?SmxPMy9oQnh5UlFPak8vUi9ad3Uwa0VkcnM5VG9PdVhkdlRmV1Q4QT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74228fcc-8070-4da3-71e5-08df36c54665
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 20:35:03.0264
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2Uyzl+nTr59WjLbE7LL35NjvZpLYALGlFXb/KR06yv9tSPmJNXWO76k9n30EnLskAMJ8pq0LKELV/zhgdkOpKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8346

On 10/23/2026 4:07 PM, Gary Guo wrote:
  > The documentation should primary describe what the function is.
  >
  > The C equivalence is good to have but should be secondary info.

  I'll describe the function's matching and override behavior first,
  and keep the C macro reference afterward in the next revision.

  Thanks,
  Simon
