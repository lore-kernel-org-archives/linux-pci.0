Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012037.outbound.protection.outlook.com [52.101.48.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B73E3BC4D4;
	Thu, 22 Jan 2026 21:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769116625; cv=fail; b=aFBU5glyV0gLxkTeBjqvmjDZdlJTAeZ8IxOOgjV8FA5FoOii5yp8g09sJF20i0h02dyNiAAPFU0NRCPELHyfYOYydKEVGzH0wGBRfj9Kv5810AqrjeE6qzmoO55i2Szy6Y+0m8qVV0SV86Sm7RqGcfK7fZYWf2chV4RivsPDyYw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769116625; c=relaxed/simple;
	bh=BcL8wl7P6UjdC+voKqrjLjZlA7Bt4aCFswn2Luu8LrM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Q8GtoDbR2ZS85glRKyZM3MQWfZSG7sAbdYJlqS7F2QsmZUXUeUX7kUqwremQXfyyOef5xPlSnVcGQMjxS3EoQ40V/lo5H+78np1QKbq+kSYLyuUi59fCMI8vA877bVn+RagYvM9mpCyNPJh+EEGhTz05fbmCkliEkUdLE99R7zs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rbu8FAbZ; arc=fail smtp.client-ip=52.101.48.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rbu8FAbZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k38bekuH8tqjKG/u+sjzAQ92i3RfDauBBMcbLFkhSKDQ1LAQ3Bse456UKrLnPvP0T7tyWjmroPhk//rI1oTTzOPWSI8nde8D/lxAI5tENx413v51+9roZ46Wgz8CkXzZ8DbdKNw7n4IDGgCe4KnpFcpuXe0uPMzkxGllbwiXQngWmM44nVPiOTs/pBNZ3qrno+aUIX+XkuslP6zyDPsoLZBpLZqxZcptwsc497TkulSOGDz1I+f8Uon2rqF0BmHtQE9HrmosuAFowfk8681B8eVWtYE/D1HQVB7f53MQdEC1bVBcwqZhfIisluia/mUZz3SldzKMriscuWnRCs55QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TE76JjzV9mDwR+H+PKk5qn4nnU5rECzvvfNu7XShQfY=;
 b=f/qj3H69avIDygCRXl3jnlMEYJLJyxE1t+Jy6668o+hL4/ixM8FSKNGwecQLvVAOGIPqEX5trbtpDbT5xYVWMqd/BQGaPXBYj3JlPMR+cV05DefFq3eHE/CDLNe/86wiIaOKxhiZ70ABkLK5YJIl6LqRnc90VIkdTDJi0bO7PJcdKoSDdEIFs/oinwgSWIqoOQiDY8OBIOTFy/nSZsIK6XGthLbsz4zgeLaEW//dpUtwrzjv0aKcNoTbw1hAevKdkYNvKugszMYoMZRP4xUKHW0PVJ7+YNNPJANsu8adfh5nVHTKu0et2hDhgHtXwKxPxDwMjyvnKh9Jv0SrOSK1NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TE76JjzV9mDwR+H+PKk5qn4nnU5rECzvvfNu7XShQfY=;
 b=rbu8FAbZuIzdIb/M47IQ8Iu6cZE/li4SaecOsG1q4HxNaBhSfxjy0PAwDx2RayfVTEDvvdbp7Or4I42VXInTM17PIjoZLaOF0QTpM5CI47qiITd3Dl40qPo2x/B9y4/siwK5Oi5iH9zywcJqUIkdpRBkDNN4ro8ON2INom5BZKBy8dcYvFLHvw4uI50JKrRvfnwFg9ZDWmO287N1O4IUIdGAaHB4HR0mcjZncceE4Vw3CsyOxRE3vMPZ6SLj/KNKpqh+hRgLUBugAIvuCalirN6KrIS97XFflXHJ0wI7WPoqa0WOyWDDQVTJo+tVeGOpYZZJlMS6g2ZILvqt1X0/3w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM3PR12MB9416.namprd12.prod.outlook.com (2603:10b6:0:4b::8) by
 DS0PR12MB9446.namprd12.prod.outlook.com (2603:10b6:8:192::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.10; Thu, 22 Jan 2026 21:16:57 +0000
Received: from DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::8cdd:504c:7d2a:59c8]) by DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::8cdd:504c:7d2a:59c8%7]) with mapi id 15.20.9542.009; Thu, 22 Jan 2026
 21:16:57 +0000
Message-ID: <e1dcd6ab-ab5b-4974-bcb7-2af59ccd2920@nvidia.com>
Date: Thu, 22 Jan 2026 13:16:29 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] samples: rust: fwctl: add sample code for fwctl
To: Danilo Krummrich <dakr@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>
Cc: Zhi Wang <zhiw@nvidia.com>, rust-for-linux@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 aliceryhl@google.com, bhelgaas@google.com, kwilczynski@kernel.org,
 ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com,
 gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org,
 a.hindborg@kernel.org, tmgross@umich.edu, markus.probst@posteo.de,
 helgaas@kernel.org, cjia@nvidia.com, smitra@nvidia.com, ankita@nvidia.com,
 aniketa@nvidia.com, kwankhede@nvidia.com, targupta@nvidia.com,
 acourbot@nvidia.com, joelagnelf@nvidia.com, zhiwang@kernel.org,
 daniel.almeida@collabora.com
References: <20260122204232.15988-1-zhiw@nvidia.com>
 <20260122204232.15988-3-zhiw@nvidia.com>
 <20260122205806.GU1134360@nvidia.com> <DFVF9XC0S46O.V7YN7L3QWB3M@kernel.org>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <DFVF9XC0S46O.V7YN7L3QWB3M@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR06CA0065.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::42) To DM3PR12MB9416.namprd12.prod.outlook.com
 (2603:10b6:0:4b::8)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PR12MB9416:EE_|DS0PR12MB9446:EE_
X-MS-Office365-Filtering-Correlation-Id: bcad0a6b-89d8-47fb-23ae-08de59fb92f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RzRjVzFjRkE1Q1N6aVErTy9ueUVzMTUvSHFNU1NRKytxUHg2OGxtaG9aQjF3?=
 =?utf-8?B?UmF4YS9KQzlXVUs0c3VUTzJJQjRrLy9aWjNZREhmNTNhWDRlMmljTnhFWXhZ?=
 =?utf-8?B?b2tIRjJ0a25Fell2RDhtSisrY2p3NGRqQlo4QWJKcVovMm1jbXk5aXBNdmlu?=
 =?utf-8?B?MDdPb1lHU0lYRDRmUTlWN2Uxc0FxTlNGLzQzRlFReFNhYTM5NzBtbDZuaWF0?=
 =?utf-8?B?RnVNZHNvbHFQUll6V0kycDd0UWNpWVNKaGQyYlZGTW42R1IwL2pZaUZTeTdM?=
 =?utf-8?B?K1FjUHBJaG5HT2hxT3N1V1dvLytIZlNXR1dhU2x0WlRzUzZuK2k4blRkalV0?=
 =?utf-8?B?RVdwVHlCZ3YrQWdHY3hVYzY2UmNMOENGT2d5VTV4NUgyc0ZGUXZFRjlEK0Vh?=
 =?utf-8?B?YzJ6Z0t4bll4RkZtUGpiTyt1SEdsZmRxM0VweUhuQjk0Z3p4ZThNcnNYWGQ2?=
 =?utf-8?B?RFFqVmg3OXJrcEVZRklzTjl6R2YwZWZ1Zzc0WGh3OFhTUnM3QkZ6Zjc2ampQ?=
 =?utf-8?B?WTV2TkE2by9rTDFRRlJ1SW5kekR0T2s4WUgxL2NOT3ZyOVhkdUNpTnRmTkJs?=
 =?utf-8?B?aHVYM2pRSDFZblpKZW1sQkdpTWJaRnNDN3NTZFNoeXhJZVdmTXVZMVBjZWJP?=
 =?utf-8?B?MWtlTVBZUVh2Q2RhNWFPYjJGWnFqWkExVWVYM1Zvb2FFeW9oYVFlTG12OTA5?=
 =?utf-8?B?ZDNSbnUvc3lmYm5nVGFPbFhDemt5UzU1eGdRMURVUEZJQ1U2N3d3ZldGbW9M?=
 =?utf-8?B?Y2xSSzlYVnZiTmZCWlFseitQMGNrU3kzeWE0S21Udis1dlZBM2RBalRtdzFD?=
 =?utf-8?B?V095ZTNtK3MrNm93aHZTUExPbmx3cldOS3dNbmdqcG9GaTEyR0x0Sk9teVJG?=
 =?utf-8?B?ZExLeU1wR20ySGI4WG9EUVNwaHI2ZmNqdDR3UFdOY2FITHFRRFIrK1liUHky?=
 =?utf-8?B?SDdOWWJqeGUvMEhJa05aTTJuQlJtZzdUeWN5VzJUVTF3SU1lNFFqeHVpOXJS?=
 =?utf-8?B?NlNaSGlUNzlhTUgwa3NmclpJNUFjNTZ1bUhiU282M1drQ3BsTWhvalNFdVZ4?=
 =?utf-8?B?YURFQnc3N3ZiS1FCY1hxWjI0MWtMd0libVhQOHV1di9OakpSS3pGYks2d2lQ?=
 =?utf-8?B?WTNacnpUc1E5SGJvUHRuWFZVVElydFY4SGk0dFRWUEJnRFBWS3VoVzVHWXcv?=
 =?utf-8?B?amJleDNzaXJsVWV3N2hzeUZRdURCUnNmckhBMjhROXFzTzVFQmhJRTg5ZG1S?=
 =?utf-8?B?VTJ4bGpoSXF4cG9PMDlxQVIwdW43ZzVZTDcxWWdxOEVuVGJLanBiSGJSb1Vv?=
 =?utf-8?B?Nk9pajF6MERyeHR0dEoxRG9PUGhXZDlKRkdRS29oazJlZU1ZcXpYTG9hWFNV?=
 =?utf-8?B?TUdPUDEwKzByZWQyVlhablNyQXdCaStML01zaXlwSnYyVWFRN291djJEQURU?=
 =?utf-8?B?Sng0Nkl2dWpNRXQ5N2hxdDJYVTROZWFpblN1L01vTG15Z1ppRzZiQnIzZklq?=
 =?utf-8?B?MHdkNjNDUnpuY1RCN0g0SVFldGpQdnFhZDJ0a3NpZ2VVMGhxSEtrdmZaMURi?=
 =?utf-8?B?V2syQjY3WFlIV3l6Wlg1YUVWSjM1M0NYUGpjcytHRzhZUGdPZGhFUjN6c3J5?=
 =?utf-8?B?dnJCU2FQMnR2cVFVK21zTTE3QzhuUTFMUHBSYklvN2l5YXNHZWFLZE5nR1VP?=
 =?utf-8?B?WFhFYXhGWlFQTnJydmNIU3BxZjdML1pqZzFhWHVHS2ltVVI5cDQrL29EUE5w?=
 =?utf-8?B?YjZDR29WbmJQL2NidXFaMzRRYTdWMGxHUS9DbjJ0NFRnVFhZdUFDQTJoU0xu?=
 =?utf-8?B?Z1NPN2hHSGJaRmRjSitjQUFOMU9kTHk5QzRsWUFrQUp3Y3ppVm4xQUdPaGlH?=
 =?utf-8?B?cGhVSUpVa01MZmJTdUhia29VaHVSNWFKYUE0NzJIWHB1aW94R3Y3a2pFVWFC?=
 =?utf-8?B?ajhJaWMrYW5IMFhPcDZPTFNFMnNhOGZvVk5vUjVRSFhhMFVwRWdtZG9NNjNC?=
 =?utf-8?B?ZVVqUGdQczArZGJKbDJMa0RIeDVwRWFkUk53NjFnTytORTd1cS9SdkN6Y1JR?=
 =?utf-8?B?THhWUkdRUlE0bjUraTVGNDMyN0tZL2ZCK3NKQlBwVVQzTnlaSFY2ZEltMjUy?=
 =?utf-8?Q?J7QA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PR12MB9416.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VVpzaEJMM3lLSGlWRUNxUTNGZnRJcmFNSmZpd0pZZUlETkZDRXZ2cVlxS0lx?=
 =?utf-8?B?RnhxSmlBd3B4UmpxL1NoWDYxQjNlRUdXaUwrNFlpbnEwelAwYWNXSkw2RGdN?=
 =?utf-8?B?dWNhUDZQWU0vVjZBUWs4S1lWbUtacHVUUW5kT1V3MFhOck1reHRPRm1saFA5?=
 =?utf-8?B?R210S0V3ck92NExpUW9HRVF0aGRYUnIvRno1MmlGWWhpQU9JU1R3cEd4VGdI?=
 =?utf-8?B?c2tVMmtROWd2MWQwN01wSXZTaHVSWGVIOHcvWnFBUUE1NUV0MGlBZ044QlVD?=
 =?utf-8?B?WGxrN3pCTjI2UmtaOExwc0JOeGNvZzhvWi81dFpLN1pSYlAraDFndENISWE5?=
 =?utf-8?B?a1QyWlI1elc4aXY3RkRwZE4wS1h2Y2Ywd1k0bWV3eW1ob0RsTGpjaVcrTnd3?=
 =?utf-8?B?T21QMmdvbDd5azU2M1dIZmVDbTRoZmM5VzZEQ0Q1WmpoY2RtSHNZWkluNGpa?=
 =?utf-8?B?MndaZjEyTXcyTUV3cnpQZThrSHlXazVCWHJSYWxIRmw3RG9kNlpGd3lqOENl?=
 =?utf-8?B?eUIwdml4NGZjSWJSWEI5dFZvOHY1em9zb3Z0SmFTajk2Wkd4azN5M1lHbUlB?=
 =?utf-8?B?STNjeWI1YlQ1b1lLMktqWEZ4Y29SdDBqVzhFS0syWUlhNnQvOHB4YWRGVXBq?=
 =?utf-8?B?SFk4dXpNdkRZT1NEYXh2S0dvUEplZ3dXd25mTU9USE9SRmpMMlAyL3ZIOWZO?=
 =?utf-8?B?MTI0aGVpaGJEWnpwNC85dXBldEJSZUFtRlBSS0RFcURzcFlXZEVSWE40MVVu?=
 =?utf-8?B?RitmcXpXYlBGK0tQWnFSN0RScFVuQ29JS0ZocEloUzBQUG9tdGoyL0xNZGtC?=
 =?utf-8?B?U3ZNMWJnM0VWYklpaG0xalZhMnF4RXRrc01xMG1lck9TZ2JvRmVIbGZLd25E?=
 =?utf-8?B?NGdkYng1aTR4aUZydDZ5SkVqSEYvRHQ0MFlmQ1R3bFpCc3hqK05Odjg1OXRX?=
 =?utf-8?B?OWY1QVVjUUpiL2ovYUFOTmJ1MHJzb2FmTWhJdXQ5bzhkRkJSck43c0l2RDV3?=
 =?utf-8?B?ZzdzbEIxSmpmQ01vL01ESDliL1JQSEIrcVNyY3pCaGxTUTBnQ281bENSd083?=
 =?utf-8?B?R0ZlVGVTMnRKK21TRnRoaTFaMk5VMEE5azYvcVRYQmREQmxVL1lOMXZDYWgr?=
 =?utf-8?B?NUJCT0ROOW5mTENXbFNWUjY3NFdsTVdtMGFqVXBRTHptVkgreWR5QVdIN0V2?=
 =?utf-8?B?L2Zqc2VITno1UUQ2WWEyK0l4MkJlS0Y3eVVOc1JFUXJjQ0NreThRSlRQL2dl?=
 =?utf-8?B?L21uWmprS2lHY2I1QTlhRGEwbWFWcThMUzROLzhQYWdTVjYzcmFNTHV1SXNT?=
 =?utf-8?B?UHYrYXZhUmUxSU5ZYTlURHpQYnhvL0pETGhzSWJuZmtUV0RjeEdubmhuQThu?=
 =?utf-8?B?N1hoTVFXb1IyZXdCZ2Vxam9NM0N6WjE0QzVXQlNOSUlNRkp0dEhMbUYzR092?=
 =?utf-8?B?VVoxMVBrMEtHbFZoVFJ4bTdiTTRUTmhFTzZ4T0lUUmFWSDJVRENZcVZhRnFH?=
 =?utf-8?B?dzdrN1NlTExvbkVFZHlXYWFmWENoZmw4d3Y5Q2tCbG1OUFBWUk84SklqK3ly?=
 =?utf-8?B?cTF2aHIvcDgzZEcyNlJ2a0V0NzhIQnVUZXJaOVVYcHA2VUhLdWQ3SzhuMnB3?=
 =?utf-8?B?eGtBKyswTDlVeFdzZWRIb01ETVBQSHJLS2RwM1ljNGFGM2ZaRWxmTUtXVStW?=
 =?utf-8?B?d0JHWW5rOE5GQ1BXazdoM0lFT2Zkbi9zbHpSZUh1S3VZejc1K0s0cmlicmdO?=
 =?utf-8?B?Q051UitQaVVybFUrRGpqNEkyaEdyeDR2WjJoZXV6YnlTUUgzOUttVFkrTWtV?=
 =?utf-8?B?N1hjZi9kT2JWUnZ4Q0NBYXNNcVpGTkZVTi8wa1d1N1RtQzNZbWZhUU1YQnNy?=
 =?utf-8?B?d3E2Qkd3d2dtR3RnWGtwS25xOTUrT3pISy92NGtYek1IeVI2Ly9zZzYzZTR1?=
 =?utf-8?B?UzdETzNBK2hCNUtOa0dMMUFjb0habVdtVml2YWRGa245Q2w1SWExZC9NRExH?=
 =?utf-8?B?THdlRTFqZ0Nob0FQZm5CQW4vRjBCazd5cjl0d1QwVG1COWlQNnpQQllzZGpF?=
 =?utf-8?B?eUhwMWZCUkcvTGhJT0w1SGN1UFkrUUIwbFZPZElSYkUyeEhzRmFzREpVOU02?=
 =?utf-8?B?ellpRkswTEx2Sks1VkZ0V0tqRG9ZSjlUMVJSNy9xbDRkWFltYXhZVVEyeFp6?=
 =?utf-8?B?RG00VXdPOFJrWW9xWEQvbW15cUtXRlh6ekx0MHhGT1hJWlFNRDBzbGk1WTZo?=
 =?utf-8?B?YXV2NVNqVXRYRFE4V0t0Qys4UE5lOFQ2UFZRNlpIK3h1S28xSE1QQmdEUkM5?=
 =?utf-8?B?ZHZKQlB0UUdpSzFmNTlBdTdQRjM5VmFpc3pRenh6aHh4MWNaOVViUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcad0a6b-89d8-47fb-23ae-08de59fb92f4
X-MS-Exchange-CrossTenant-AuthSource: DM3PR12MB9416.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 21:16:57.2217
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WZApQ7hbw5ou2mjSEBWFLS2EJMCiMkKXs3xuV02mALOD4LOAhwysAdMI5WBXj/Kc02EOBkUXDzwXswPNJtvXBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9446

On 1/22/26 1:06 PM, Danilo Krummrich wrote:
> On Thu Jan 22, 2026 at 9:58 PM CET, Jason Gunthorpe wrote:
>> On Thu, Jan 22, 2026 at 10:42:31PM +0200, Zhi Wang wrote:
>>> This patch adds a sample Rust driver demonstrating the usage of the fwctl
>>> Rust abstractions. Add sample code for creating a FwCtl device, getting
>>> device info and issuing an RPC.
>>>
>>> Cc: Danilo Krummrich <dakr@kernel.org>
>>> Cc: Jason Gunthorpe <jgg@nvidia.com>
>>> Signed-off-by: Zhi Wang <zhiw@nvidia.com>
>>> ---
>>>  samples/rust/Kconfig              |  11 +++
>>>  samples/rust/Makefile             |   1 +
>>>  samples/rust/rust_driver_fwctl.rs | 136 ++++++++++++++++++++++++++++++
>>>  3 files changed, 148 insertions(+)
>>>  create mode 100644 samples/rust/rust_driver_fwctl.rs
>>
>> Is this normal for Rust? Can we delete it when a real driver is
>> merged?
>>
>> I'm not so keen on sample drivers, I've spent far too much time lately
>> touching sample drivers that nobody ever uses :(
> 
> I think it is pretty useful for review purposes (at least as long as the first
> real user is not yet ready) to see how it turns out from a user perspective.
> 
> It may also be pretty useful for people starting out with Rust in the kernel, as
> the samples have a very limited scope compared to real drivers.
> 
> But there is no policy or anything, i.e. no need to keep it. There's also no
> need to even land it if you prefer not to do so.

Zhi, the real code that uses this for vGPU is going to be posted soon-ish,
right? So we could use this patch as a review assist, like Danilo mentions,
but not merge it, because the real code will suffice to exercise the new
fwctl functionality.

thanks,
-- 
John Hubbard

