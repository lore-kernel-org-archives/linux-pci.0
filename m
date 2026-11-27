Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.57
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795779992;
	b=5AFQoObu9gdEkHNuv+dIJ0dBgvMtmAEGLtUi5LKRT+sWLE4DC+SQY8Kstwkfoc0OiQY+
	 Aum8M5NatVnugn+sAo9IvOa1c579uwo3J64lai4wrYzkOVsVWxIkdLeewS2DtBtAGWnrn
	 LL/zYvtEHh2BXtAPzLDquHwdbBfZLVzy5/WJAFldPLsbOgq2WtBPYvGKAwl9WqhR3eabz
	 vKkC3mWnUzXtDVNTKyKa51t1qGD+sy2bu6S+BNRYh5t9MXb23iK1mKW7oyMcWV1hVpHMQ
	 6OgeEP5Kwob6mlSwNB4Mxb4kCmE70EUAta/5VV2pcfGFiubakPpwHHKiqdgoSWoy4Og==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795779992;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:Date:Subject:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:
	 X-MS-Exchange-AntiSpam-MessageData-1:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=N4gLEj9PqYodz2V+78IPQTPkyrVH4L95iDJ+13o63Jo=;
	b=McELvGlhi73GD4H4qTHAHeYuJukHgEXJ8tWduNx4vW0AlW/j2kpAYhAWQXDmEU25aw57
	 R1/SQOFVW5/1xAe360ESEM9TjwvAlGKGXYFugLHeDwSLu9ZtMwD87QwoCheDNcfE5kd15
	 nNLJV09CuMnMlv0EcIyNgRgCqt+hvyDpOkUb4BcA3EQERX7DeCb4fiPzm6TIj860qXkAf
	 LOk0S3QIgQFyABWbuyfR2mUW5biYk4Ul74k2j7YCxanUYos9qwybs5hTo25gHM/RyLVbJ
	 LRJVJxpGZfaNwizh7D/aZaQ3bSnUcaspz9kHhomkhhiBJE6YDTmuPy+807AO5RP+L2A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=ArgVMwrs;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.57
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013057.outbound.protection.outlook.com [40.93.201.57])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DEDE606A69A;
	Fri, 27 Nov 2026 11:46:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4DEDE606A69A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=ArgVMwrs
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a/dOlfWrH4RRDHSDz4FomuILVqJetu/6oYzbizAlXSGAQs3hOfyvcTfsM1UdtxWi82b/ffFEJ6TQ2LdhHBzMXXLSyUXGQSNFE0ivmEmek0//30XJ7Q4XJYurvtLSqmykF4x9zhDWFEfT62VNqJiP8YngoEzRakQNKd2L7lOhG1S56hzuIjOGHnNdf726ppRXLQimjBeEQ3hEZQSKQHRg/sguBtV6qcOIcPrWA/mCPio/n1cSGg9tOe1GMrfhc9NgT9sRRCdW2nFcIiBMzczltQejkjg3UZcHj0kHPDv/ze7x8aY8yDPY6qM/2hRa1DxMoM8kDETUS7kDmlCP++N8aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N4gLEj9PqYodz2V+78IPQTPkyrVH4L95iDJ+13o63Jo=;
 b=cfWIbDTN9fnuwcO/jfwDuuOUhfCCRlSW3oMvXC5KjscQ6qndOUz6JaxVG8wUphDSp5sxPI4rDvh5gweGQJ87Wm6vzrRyv65OgOCHQDVygU5W+/3xgV3YpzH0W/wY+CZpuywIVN/AX4o9XP2VimcQqqfwSfdaJhq9dvbTbikHfeiyOy+COjjKLCZWVnvcONoo2+Iq9krn1mn3YDzcZ+nn7H1lKY5J/2T/arnMCpLxX/OmqIYYqTtkFe52T+/FtJeP9wbnjb3ijpQyDDVtxNcd1K1j1lN5lF7osUpcqYOlLVWYR7huZxRxZfOv+SU5js487dVIIy2tOe7U40T12wQZ+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N4gLEj9PqYodz2V+78IPQTPkyrVH4L95iDJ+13o63Jo=;
 b=ArgVMwrsySshc56dFYo3ZkExx5h0abmcafbsMoNvSGfoGr26hGvdKoH4B/e3Vy4uOkwxxUebA7y8fPaBr3sTs0YIwoigNHnXyzhMqLOkITtZ0MOItVqsob3f2ZRFjj2bxBcpHe7ftdOWfyLls6x/v/DkEBqohdnnGTPNlmhHzDGfNtPoKf5IeFnPKbjbbs8sBBCEZi/5SjdVbjRW7km4GzLWM4Y1HajcVsUbdZDtiYrBIM27aFQ0sNU+7IsBnUsUhUY0r4LnZAappxgRnlUt/7lajySRLL2FqNc/8RQ918Jq0RMWulqZXZ+kUKn2yALGujAFbT4paVdVkmNCj6S+Sg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by SJ0PR12MB5633.namprd12.prod.outlook.com (2603:10b6:a03:428::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.10; Fri, 27 Nov
 2026 11:46:28 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0662.001; Fri, 27 Nov 2026
 11:46:28 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Fri, 27 Nov 2026 20:46:17 +0900
Subject: [PATCH 2/3] rust: pci: return a bitfield type for dev_id
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261127-nova-gsp-dbd-v1-2-0fb5f7c2ce63@nvidia.com>
References: <20261127-nova-gsp-dbd-v1-0-0fb5f7c2ce63@nvidia.com>
In-Reply-To: <20261127-nova-gsp-dbd-v1-0-0fb5f7c2ce63@nvidia.com>
To: Yury Norov <yury.norov@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Alistair Popple <apopple@nvidia.com>
Cc: John Hubbard <jhubbard@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 Eliot Courtney <ecourtney@nvidia.com>, Zhi Wang <zhiw@nvidia.com>, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 linux-pci@vger.kernel.org, Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TYCP286CA0164.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:383::16) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
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
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|SJ0PR12MB5633:EE_
X-MS-Office365-Filtering-Correlation-Id: 36ea8c33-ea72-4e6f-5b5d-08df4c7c1294
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|10070799003|1800799024|23010399003|921020|10067099003|56012099006|260925021911599003|260925022911599003|260925021311599003|11063799006|261021121427099003|261021123027099003|261022105027099003|261022075727099003|261009223027099003|261028144727099003|261026121527099003|261026140227099003|261102123227099003|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	YsjSQLtPJiYHTnKdSKoKr09J75tNYizYl9PXpUJ+78BuM9U86dgddOEYMSjX3lSlcANPORvXLX6LtXXw6G7ayf50z0vNeWt53BGBFsieURjML+bISfU0E3CHoAYUs9JQuUvBuStnqOzEPrrRj80J8rembjfAwZgq/uBGZp5oBeHaWEhHoo91QBfTYQmJKHwGDFxHIHQZ2mm0peC9M/EpEpO0P8E1GQ1RvC1FlJh3f4EVaCgjRd/maO7vSBxXmfEvT20xhqoxy4o6WUtXg75E7CFstDMxwMnGzPEV0KueTjbz3oNR/mzoM32SHD7TUvtB0GGArcF9RpkbCEzTF/Mx9p2hMArAQ3l2H8jDjFABKpN1CD7fY7sKu2BijoBmZx3euuXAzVl5aQEmfG4xyPe/DZoTj9ETlPlr5fN5Z0psOnwudREDyKYLYMvD5L1IhMUrQDBQjEePSkebdX25H2bbZ+vBICSi7wvR6uPi+dbnovs1g+B363+PoWkzxpDlykBN3eDl409tWTZ2dUgKCz60WdxShiRIYOXdeIKYAxcj8bmm5xrqzOF8gf0MQK0j+kwUbClu/ryORmcP68Jf4H53QxOF+9hErcSxRh85cj7pW2vHL8F0bxTBlLJZJd3ime8op9/XsFQwj27J2fP94C88T6n3MsWVu8M2JFrZ48RTitDq2yH2GRreVZo93NxkpnWrnaDt0nidCOEOs82IJ8E8Bg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB6873.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(10070799003)(1800799024)(23010399003)(921020)(10067099003)(56012099006)(260925021911599003)(260925022911599003)(260925021311599003)(11063799006)(261021121427099003)(261021123027099003)(261022105027099003)(261022075727099003)(261009223027099003)(261028144727099003)(261026121527099003)(261026140227099003)(261102123227099003)(22082099003)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cnFGeEdxcko2dDlMYmt3VXM0QU40bUtkbXViSndZZlZuRHZKb2xnYzRqKzFW?=
 =?utf-8?B?eEloM3VsNzlGdzNCekdrOVl1Y1V3SGk4VFVTa3Y3VXVTSFRObmsveDI4RDU0?=
 =?utf-8?B?bitDSkJ2M2NuRWozTWZtSzhET2x3TTJnNXo3aHZ2NG04bVBBcDVTMEczTnAz?=
 =?utf-8?B?MlRFb1d0T3pSQm9ZeXNTdWw4U2ZmcTBmYXpPaFdkbS81bmVlZnhucmg0OWZq?=
 =?utf-8?B?RHd3UFZBZzZ0bzdSYktxUXhIUVlJR0VPamxYVkhNVVM2dkNkSHJrR1BrSXpl?=
 =?utf-8?B?VzZJRDJndjhsWjJoaDJ2VE92cnBaZzFRODdpeG5tRjhHaVl4RDNRRnZibnUy?=
 =?utf-8?B?S29MR3NpQ2NoaWZ5ajRzUk5QUEJLNEU2Um1ZdzNBd3ZwVzRFcVIrOXVBcGYr?=
 =?utf-8?B?TWw0djZkbk5iODRzeFl5YjB3VUNWUXVSeXpZbU9sb3NMUEpnSWpRSkJnQlg1?=
 =?utf-8?B?c3lMaWR4RFhVbGh4WjRFUWJZc2lPYTZJQjNXTU1PZVpqZ1VINmk3NmYraTVG?=
 =?utf-8?B?MVJVNzBWOGhPRGptUmZkRFJuK255NmtYUjdBOWZRY2ZBeDdHRGxKdDVNN2x4?=
 =?utf-8?B?eThQL3lwUHFEMVRNeUFRUUhiUlRtSGQ0THZnZmVValE4ejlDU0MxUEdncXV6?=
 =?utf-8?B?aXFaT0VYYzczV0ZZYktRbytqU09Ib0cxVVlYT3h3cFRuckxTcWxBbGYyenF1?=
 =?utf-8?B?ZlgwSmtuS0V6eHRmSCtaQVBldFByTU1KVUVjM3JaWjR6QUhLOW4yYkpMWXZv?=
 =?utf-8?B?M1NCRE1iRnZ6Z0JPa25vZkxGU2QveTBpY3V6ZlBIOUdhZkNaY2dicStkNkhL?=
 =?utf-8?B?Q0VWUDFGTFZWWU1UUHZhMEQzODJuTEcvYlN6TkhuazZxb1Jmc1FpUklLQnU3?=
 =?utf-8?B?NklTc0J4dnh6ZnhHd0xFU3ZqbUx2dVpITGJjZWZLc3JHdWtPdTZGTmEveVlL?=
 =?utf-8?B?SkVQY0sreGtKYXlIaGpEeENMQXUyMHNSOUtCb1hmSVFGS2l6dzhMVjl3WkUw?=
 =?utf-8?B?R2oyS016WDh0Qjh6WndQOXc3a2Q2ZmZwK1ZMUGJ3RmQzdTh1UFJOajdxNVha?=
 =?utf-8?B?UXVBUmJ4SmtZa1ZGUzc4c3NUTXRHYk9aY05XU296VWd0UWMyVGtPZUpwTDVI?=
 =?utf-8?B?bENYeDB5d29TSTFSS2k0aXZoSWF2K0loalZHUkRoVlpuMDNZbk9Nc1RzbG9Y?=
 =?utf-8?B?VmYvQlYwcEkzQjFxZU5NK3NiM01UZlRJdXExR3ZIVFBpa1JiZWFrREo5Z1Iy?=
 =?utf-8?B?aHJTMlhKZFc5RWRMdGpUc0VYR3RYQlJlY0hGZUZxMjMwK1VQWjRqWjV0eXkx?=
 =?utf-8?B?eGsvUUVQdVc0Um5pQjV4Z091S285TUIyWG80K1NkNjlwZnFKWXJReklPR0dO?=
 =?utf-8?B?RlBHT21uZFpzVFAreHd0YVZRQ3RRZWd0Q3BiQnN1ZE9pZ1Q5MGR4Wk1kYVpB?=
 =?utf-8?B?V3VXMW8yYzgvVUNRV0M3d1k1U1V0cmRhTXR6ak1rbWxzci9LRnAxa2hQL1hZ?=
 =?utf-8?B?MU5PRU83VkUrWk5Ea3g3NksrWERvRnFZSmtRVUNOdE5odlFYV281bDFydnVZ?=
 =?utf-8?B?eGRyTkxRZUZEamMwbWdQY0ZBVFFzWCs3M1RNSFdIaUVLVytQdGxGK0l5STYx?=
 =?utf-8?B?S3d5WGt4NmtEcWVYRTFqR1crQjBhN3R1RHZsdksxUWlZVi9KcEdHOEV1NURR?=
 =?utf-8?B?bHJhYUtlTnY2M0ZFYWhjaU96TFBkL3ZkNXh6TlR5TUVwTjNHU3pvVUxwcjdw?=
 =?utf-8?B?Zlc3bm5ZcDY1TEdpMjR6WGZtZ0F3V1VaUE5nNE0yOFlscVcwOWdxZ243SGVY?=
 =?utf-8?B?MFZISm9CaUxDUThwM1BhbnJhb2dLUS9MR2pjbjg5VVl4dDdrcjEyZHNqbWNT?=
 =?utf-8?B?akxOKzhuK1hndHFzNS9CbEZDTkoyeFVaYzQ4eS9zUDg5ZHlkZU14OHk5MW10?=
 =?utf-8?B?cmJGb0NMRlVnMVp5Z3VnajFmaXNEeGwzelVidU4wdlQ1R2pFN2gzUzRrL3VI?=
 =?utf-8?B?cVFLRkVLR0tLbXpCU0VUS0JrWmJiN2Ztd1RuRGZHQnppRGNlKzFOVlhUaG45?=
 =?utf-8?B?NENKZ3pIZjl1Y2JYSncwRkNXc2hhN1I0bHFMc0srQXYzTDNRL1hIOUw1ZnBU?=
 =?utf-8?B?eEtmSUtGaFNWbDFXd2R4QzdCVGdQaWFTcC9OMnM2bHRZUExiTFZBcGdXdEN3?=
 =?utf-8?B?dEJVbWtBeGVOcnA1Y1BhZVdxeUxiZU1hSkpMOGwyYUZ6bHZUZDB4YWNSQkdj?=
 =?utf-8?B?b3hweEJrT0RwNU1KRlN1U214YkZ4elg3QlBXNEk4T1ZodzVBVE9KM1l4K1VL?=
 =?utf-8?B?NzJYN29Dd0QwaktxNnVRWERNK0dYTXFvWWMvT0wrU2U3MUQzdW9EVkhXelVj?=
 =?utf-8?Q?mtTR2vIYqS7q7w8UeAmvz1+GTqnJ+75IEJfRVJnHxyc4r?=
X-MS-Exchange-AntiSpam-MessageData-1: 9ExL3youm9/gIw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36ea8c33-ea72-4e6f-5b5d-08df4c7c1294
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 11:46:28.2767
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p8dmkOe0rE46zdWCtltOqAaGrwAFEEHZUty/P+BjA1a3GJxUTi3k1b/tao5prYxI/7b6LW98RiP7s/+gN6scUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5633

The return type of `dev_id` has a well-defined bit layout encoding
the bus, device and function IDs of the PCI device. Add a `Bdf` bitfield
defining that layout and make `dev_id` return it so users can benefit
from it and are not tempted to define their own BDF type.

Also update the current two users of `dev_id`.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 drivers/gpu/nova-core/gsp/fw/commands.rs |  2 +-
 rust/kernel/pci.rs                       | 33 ++++++++++++++++++++++++++++++--
 samples/rust/rust_driver_sriov/pf.rs     |  2 +-
 3 files changed, 33 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/nova-core/gsp/fw/commands.rs b/drivers/gpu/nova-core/gsp/fw/commands.rs
index b4bdbddad79f..37b89e62387f 100644
--- a/drivers/gpu/nova-core/gsp/fw/commands.rs
+++ b/drivers/gpu/nova-core/gsp/fw/commands.rs
@@ -88,7 +88,7 @@ pub(crate) fn init<'a>(
             gpuPhysAddr: dev.resource_start(0)?,
             gpuPhysFbAddr: dev.resource_start(1)?,
             gpuPhysInstAddr: dev.resource_start(3)?,
-            nvDomainBusDeviceFunc: u64::from(dev.dev_id()),
+            nvDomainBusDeviceFunc: u64::from(dev.dev_id().into_raw()),
 
             // Using TASK_SIZE in r535_gsp_rpc_set_system_info() seems wrong because
             // TASK_SIZE is per-task. That's probably a design issue in GSP-RM though.
diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index 04a6d240afb2..0592b220767c 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -6,6 +6,7 @@
 
 use crate::{
     bindings,
+    bitfield,
     container_of,
     device,
     device_id::{
@@ -17,6 +18,7 @@
         from_result,
         to_result, //
     },
+    fmt,
     io::resource,
     prelude::*,
     str::CStr,
@@ -279,6 +281,33 @@ macro_rules! module_pci_driver {
 };
 }
 
+bitfield! {
+    /// Bus-Device-Function ID of a PCI device. Equivalent of C's `PCI_DEVID`.
+    pub struct Bdf(u16) {
+        /// Bus number.
+        15:8 bus;
+        /// Device number.
+        7:3 device;
+        /// Function number.
+        2:0 function;
+        /// Aggregation of `device` and `function`, which are commonly used together in code.
+        7:0 devfn;
+    }
+}
+
+/// Formats the ID as `bus:device.function`, like the corresponding part of C's `pci_name()`.
+impl fmt::Display for Bdf {
+    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
+        write!(
+            f,
+            "{:02x}:{:02x}.{}",
+            self.bus(),
+            self.device(),
+            self.function()
+        )
+    }
+}
+
 /// Abstraction for the PCI device ID structure ([`struct pci_device_id`]).
 ///
 /// [`struct pci_device_id`]: https://docs.kernel.org/PCI/pci.html#c.pci_device_id
@@ -700,10 +729,10 @@ pub fn revision_id(&self) -> u8 {
 
     /// Returns the PCI bus device/function.
     #[inline]
-    pub fn dev_id(&self) -> u16 {
+    pub fn dev_id(&self) -> Bdf {
         // SAFETY: By its type invariant `self.as_raw` is always a valid pointer to a
         // `struct pci_dev`.
-        unsafe { bindings::pci_dev_id(self.as_raw()) }
+        Bdf::from_raw(unsafe { bindings::pci_dev_id(self.as_raw()) })
     }
 
     /// Returns the PCI subsystem vendor ID.
diff --git a/samples/rust/rust_driver_sriov/pf.rs b/samples/rust/rust_driver_sriov/pf.rs
index 8f9958683528..c367c891abf4 100644
--- a/samples/rust/rust_driver_sriov/pf.rs
+++ b/samples/rust/rust_driver_sriov/pf.rs
@@ -34,7 +34,7 @@ pub(crate) fn submit(vf: &pci::Device<Bound>) -> Result<u64> {
 
         dev_info!(
             pf.pdev,
-            "Handle PF request {} from VF devfn {:#x}.\n",
+            "Handle PF request {} from VF {}.\n",
             request,
             vf.dev_id()
         );

-- 
2.56.1

