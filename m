Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.53.63
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794260610;
	b=bfGkrAbAsIFZYCEkWMQmysH7ogY1HVX744iEpXJCHKxDonfy0D2A+6rP4l3bDf8fzIUX
	 FZ3fCj/W4yswOEbg30rJNqBbN3APch6n8Kksg3SCjf9BrOTFU/gKRxtEi5UnNBABlA/4T
	 NXTsc3gb+qD4KF7CFQ7AdSPhqqpuUFwQzG5SjEJMGOmBv1iXyWPMx4YOYGCpeR5DEdnEh
	 SilacwKAADdtQeCGSib+fQn6PWgT8tZ+4hXhGrfBp61kh2xP11nVGVo8uNeqG1nWu8DJB
	 HZRzYHimF5vMrcnm8kVut8C0yCW3zS12Z6JI6L3VojspLCPxb7MBViZ22mrSdYYhAiQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794260610;
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
	bh=PlGzrMtpD+UPBXWvU1hbKX8PvUUjtFAZffIPjAKWMj0=;
	b=RLn2iX8JwFjJBaGdtMLGpWHWRkvFhvECiX/dx9H6gvq0m+PMAthumOfFJY0Tm3dvyyJF
	 yj2bn4HyyicZQRXORmXETOmsCG1Zvn2tKObQUWN3EZguYTSHwQa3vIZiKumE9dOlATzLo
	 PHWqjzSNvC5hSJlddZK2mn/Nt6aC4FC5Vhb6LyOQh8O+14CjLon1ngkfbIb00JDgNpLgF
	 1xi8KAGgaIP4WaTa3BnjSWGJRFnKPKSLdcBepm7W/aKWe8Mm/8BErRo+gyQL9irlUgnYo
	 j7cn2X72FX9jZLTOLz2JTXfI+axz1aq+YqKO4BwRagId/JbUzaELYXBj1gjYCUtDYAA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=gObiwgO5;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.53.63
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012063.outbound.protection.outlook.com [52.101.53.63])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E232606A31C;
	Mon,  9 Nov 2026 21:43:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1E232606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=gObiwgO5
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wf+9vKFH8/2Ig1GtNXEerr7B+i1qIy1tVB59lOOK2jeWWJmdK+AjG2IIZAXDBmWhepb8LqiBcy9/DRe/wC9SNKz5yhC2ONK9Fn45kRCvAb7w0BhAEbtmnWZZZ6aJCEfwq0ImtX0ATtj7AMtjjUuYI/5ixPfH4mDWbOhnTSaqLPZ/1zsdadUdTIZvfE3XJkmvTiCRO0uFNolE0/Db7f1+5EFgjD6/56cHRvq3ztty8Zn69LjvG4cxJpDFsF9vWCJiUS1+/dKcU0f+LrMt8xeNYfffKrFilxYLx/pHeZMPO5UbkkZaHkqn/9TaTAzePKZzdFY/zVY4AA2bpy7pmLRUOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PlGzrMtpD+UPBXWvU1hbKX8PvUUjtFAZffIPjAKWMj0=;
 b=y9BuQJZ455qJJb1QL7JEQXpWoY/WTNOjRyWhqSGLkZ8n1HptPan67+txiVqwBJ8raGW+P6CNQ0l6IEIt4TKMFfcrmMgreAvadomO5uEK1ZsoSRWetpdDmZBPKduf011E8EprflDH8lUMGb0avNqU8I8e/QgzOYln82E9jXt//zcDCUMXwSIcBlP0XwyLaF3D4JWJ7auFUf14q4hwNnoMzGSe31m/6jNz3r5VplTVu6/UkfBsqYH0YvL4mrxoHVkri/SbSyb4czxlB0N76CXWjMdTrIP9o5HEl2gBgjQMqWhZZV3sxWkvuoj7Eu9Fb4s0jXtFuw93G/lvOLEKxp0QuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PlGzrMtpD+UPBXWvU1hbKX8PvUUjtFAZffIPjAKWMj0=;
 b=gObiwgO5EIS2Qo8bQ+y1GkujWo7nU2Iotsadh4tzbOclaIi4yZYDL9gdAZnmBTZkl0H6DZbJGxg/tTbW5UxdwLq9arScPjF5bpm+1dIA1CZRmJe80q/PUMaPNy1/ttgVfvOBQudr+fSSv0+PJzM2IasUeug1JnngdYBdmA9omazzYPmBtjK15Wk8lqmg6u8aZuauny/HcTiq0Xl5ID2R0iCCda3Y6ABgvEEXPDRNnjBEb7iIB826WsLPaP0bAd1cC6u+54Qd82O14ky/6kzWxXdBv+oh/SRzLVp7fExEX7BFW7sxb9ucZ/7Nd3tn0SCOTVeGBa7xlb/DkVYltV1+vQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6549.namprd12.prod.outlook.com (2603:10b6:930:43::6)
 by BN7PPFA42F4F89B.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6dd) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Mon, 9 Nov
 2026 21:43:24 +0000
Received: from CY5PR12MB6549.namprd12.prod.outlook.com
 ([fe80::2cdd:a549:db13:202b]) by CY5PR12MB6549.namprd12.prod.outlook.com
 ([fe80::2cdd:a549:db13:202b%4]) with mapi id 15.21.0592.012; Mon, 9 Nov 2026
 21:43:23 +0000
Message-ID: <87abab04-2ee2-4765-b261-5268b0bc8bf1@nvidia.com>
Date: Mon, 9 Nov 2026 16:43:16 -0500
User-Agent: Mozilla Thunderbird
From: Simon Song <xinmengs@nvidia.com>
Subject: Re: [PATCH v5 7/9] rust: pci: add SR-IOV enable and disable tokens
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: dakr@kernel.org, kvm@vger.kernel.org, rust-for-linux@vger.kernel.org,
 nova-gpu@lists.linux.dev, linux-pci@vger.kernel.org, alex@shazbot.org,
 jgg@nvidia.com, yishaih@nvidia.com, skolothumtho@nvidia.com,
 kevin.tian@intel.com, airlied@gmail.com, simona@ffwll.ch, ojeda@kernel.org,
 alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net,
 bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org,
 aliceryhl@google.com, tmgross@umich.edu, markus.probst@posteo.de,
 jhubbard@nvidia.com, apopple@nvidia.com, joelagnelf@nvidia.com,
 ecourtney@nvidia.com, cjia@nvidia.com, smitra@nvidia.com, kjaju@nvidia.com,
 alkumar@nvidia.com, ankita@nvidia.com, aniketa@nvidia.com,
 kwankhede@nvidia.com, targupta@nvidia.com, linux-kernel@vger.kernel.org,
 zhiwang@kernel.org, zhiw@nvidia.com, boqun@kernel.org,
 daniel.almeida@collabora.com, tamird@kernel.org, work@onurozkan.dev,
 jgg@ziepe.ca, bhelgaas@google.com, kwilczynski@kernel.org,
 dri-devel@lists.freedesktop.org, peter@colberg.org
References: <20261030171230.196717-8-xinmengs@nvidia.com>
 <DMQNRGDHAK0A.3EZQZGAHKYF47@nvidia.com>
Content-Language: en-US
In-Reply-To: <DMQNRGDHAK0A.3EZQZGAHKYF47@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0P220CA0010.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::14) To CY5PR12MB6549.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: CY5PR12MB6549:EE_|BN7PPFA42F4F89B:EE_
X-MS-Office365-Filtering-Correlation-Id: 465c5c01-dc0e-48e1-f366-08df3eaa7a7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|366016|1800799024|4143699003|11063799006|261021135927099003|56012099006|261026121527099003|18002099003|22082099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	q8O1Y6IJr/I9y8km4x8VzbGqS15autLqCQN602FmISiQ904lnA/nZ5egkTsStYGghqvCtj0ldUpeAMPwYtIRxEbQmCcIVuzOVnnzkGiteF2vxsggpH9I2jSvC+vtw8fSO6WhZ75k04Oh/qXhCo+g8M5qsbIxWbB7Y3jBTDMUNPMGBSZ0/y93iFnZSV061tL5RWdWX9/4SZ9Wm9j5f8Yy3c98oZUDDfJl7n5WL3ZRYGlrMuH9d9yJpzR9ILP7XmibVS/IPt8sdbpAx+mcj7m0w5dtDL8u5Ly94AI2EErTro9ZfBwUHYRTsetK0MxQTW4eEy6kLl3xIbnbfQ0dGq/+TZFdgIzI6++de5aNVn+zMsCyP5MZ3PpEE2Gzs6b7MBW2igwvBs19y7TI8Wp+qG+WWhMezbahesEDxvRVgr+1oEz4k6V1cTw8DGi9vFUwZEHNcR4bxKJhlAnrK6mn2LLgldNJPasXGeO1E+5ZWdxHJSfTe6XVskLFDCz37k0N17Bws7j7dZmppKcyFI3Gmry1I1LjpTVkYrh6E1DyYAnfKCrHO7G4lCBqotlQAzea2UEoGeYLJvwMnvPGYLWc0ROx/OIFI7G78g3WfXOjmXGeF+eM6+b8qm8oV7rqsY7oglcXqxC9k+sGBS/d/S0RA1RzIi+5XMwtGIIudZQ5npz7gFw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6549.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(366016)(1800799024)(4143699003)(11063799006)(261021135927099003)(56012099006)(261026121527099003)(18002099003)(22082099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Mk1sN1U1Y3hFaURnNC9GSnpOWTJiYnpzNkYwRS90MzZTQlk1dkxQSmYzdlRm?=
 =?utf-8?B?U0ZtVGsxWEFqZU9TVVlFTkZrR0VhYTc5R1ZYVk92TlNiYVA3RDB1UTZLZ3V4?=
 =?utf-8?B?K1diZzRPS0ZwV2NVK3hiUlFXVWNpRGF1ODZEbW1IbkdFTDBXUE1kUWlzd1lT?=
 =?utf-8?B?K05KbWhOL0ZFWUd6UlQzenRWWERMRllYSnRvUWxHVVVoSis1RlBVZ2NzLzZG?=
 =?utf-8?B?ZnVLMmF5NCtKcG1mSWJKVjRiM1h1V00wTFY2czBiR0djVisrKzBrV1d3YUpN?=
 =?utf-8?B?a1hzYnRNTEd1cWhZTFFXNEdON0dCVmE4a0VDTitLYnhZMnJMSGUrbzVTN0JH?=
 =?utf-8?B?aHFUTWJZZ1VIOEdZR1NYYXpNRjhCUWtQM1Ard002VzBUM3d3bGUwV0xiTjdE?=
 =?utf-8?B?MHB3VjdMSysyVWcxOWNHalc3Q282cTlnRnZmRE9LTTlEOVFaNG40WWcxMldV?=
 =?utf-8?B?QVk0YVE2YkNHTmhjZnhjRmY2SWs2azJFOWxyRUpWSFJjdVAxVkdYa2RETSsy?=
 =?utf-8?B?aElReHBJa3ArU1QwVi9FTTI2WC8yVUJnNVRIY2RreUN4NVJyU3hiOTJKWit1?=
 =?utf-8?B?ZFBqY2RDUm5qcVM5VHdyQVhXbDJTLzZpYlZ5bUJmVVhzVkt1TzhPODFsKzdP?=
 =?utf-8?B?NHhJNDVxMWpkUmRGK1lZd29icmFES2g3a09EdEFJMWRsditBcFB4VVNMV0th?=
 =?utf-8?B?cFJ3cU5qdVdaS0tQYy9kNzBHbTl2dXdVekhMKytBYnZFbXE1VmFCNU5CNUMz?=
 =?utf-8?B?YVVvcFNkVU9HMFRHczZURjVDQU1yNURJU01XQ0tpVGtqMllHamY0MzBqQ0Va?=
 =?utf-8?B?VllrbXBUM2x6cWt5QkhacHgvbVdXaDVwaHJwQ3drSkRXSW5kaE85a0pJTzc5?=
 =?utf-8?B?RGdUbHhZd213WHl1VWlkSzI1NWhyamVWMSs3V2gyb0x6K1psS2gxNEJyMU95?=
 =?utf-8?B?YnhwdTdZTm5JeW5TTTVkTGJKTHZqbGsvNWVGVXdHZGRFa2hHNFNjelpteEc4?=
 =?utf-8?B?SVgxSDVHMkpGNXJjaTZMejNsOUFSZzZ2MEZpNGd4N0RoRDJUYkJyT1RVekJh?=
 =?utf-8?B?WE90cVAwVkxqQlZqaXd2ZWUzNENxd25MUTA4KzF6VmZLZzB6WGtaaU93bGdk?=
 =?utf-8?B?eDRNZXoyZzNSeHVSN1JCbjFnTjd2MnZEYTE4TE9kQ3ZCVFpreVZuVE85L2Er?=
 =?utf-8?B?Ukd6UC8xaXFaTEFRck1ZM2pZKzBoZ2k1TU5PMGZiM0lOQ1BYdzdycGdBQnJE?=
 =?utf-8?B?VDB3YXM2eG9MakxHVENXTEcyT2thczhFNkxUZnpmb0doaVlqV1dUR2RPQW81?=
 =?utf-8?B?R1NLYzlwUDFjMkRyMUlRMWNxLzUzSVBiNWR3V3pQMkx0cVBGdEkzSXkvME95?=
 =?utf-8?B?TGQ3V1hhRU9QUEZnKy9hMlFlcVNJQjA1U2lRZk5MTHAyZ2tOOG1UeE16TktL?=
 =?utf-8?B?Qmw3eUt5TEtTaENPZkIzb1Y0UjdZRWdLMFNVbTljR1RDdHFKUklRQlBmN2dU?=
 =?utf-8?B?YmdsNGxxQ0VKaUd6MDB3L0JSU3BibkE1NWNjTzQ0N290M1ErcU9FZWpGc0RI?=
 =?utf-8?B?WFQ2WGFkRmorcVhOVjIvdCtGaEUrVzNSUE9jMnU4UGdPdHRyempab2JkZlVP?=
 =?utf-8?B?OFlubjhHR0pKd2hvbnFqejZnZFJCTzVVQmZkV0IyaU5ZMlI4eHF6UUt0U3dl?=
 =?utf-8?B?akxXdkhaZHRIV0dSRTkvTjNqakc0dUxOR3hHbmNzSnlSU1FqZE5wT1NsQk4x?=
 =?utf-8?B?RU1ZVDg2VjRqS3FJUnZUVkE0SXdxVHRzSjBic1BZQ0s5MzNiZlh2cGJuTjg0?=
 =?utf-8?B?d0I5aER0MnpuYkZDQ2Vpd0tlcXRMc2lFTmFVcVpRT05mL1lCOGlaRE5NVk9q?=
 =?utf-8?B?eFg2NncrT1phNTZ2WDdDV0NVeWsxTXIrLzdUS1dMMCtkcTF0UU52eU1hMEF6?=
 =?utf-8?B?WVVoVHQrbzMzUUo3SlRUaUJ3bWxrZGdwYVcvVHVTck0wWFRxWnBWUlgvcUpz?=
 =?utf-8?B?NmNSS3AvL1RENGM3dTFxNWs0dnYzOXFGNkgxdksxZFRSc3Iyckhlck5EY3F6?=
 =?utf-8?B?T0psMk5NQXFBcG1wcU1CTmI5TG96MVlkcVRTbkRkR2I0Yzg3MVYzMHRsN0Q5?=
 =?utf-8?B?c29kZEJsdVVIeFduWUc0SVVUWnRkUTBmOGpZRkMwVVFwVDArSGUxTThWUHF5?=
 =?utf-8?B?ei9NemR6T1F1WlM0QWhnT0w2cTdTZnRzbEZBYlhJMTVnSStGYkh4SzB6Ymtz?=
 =?utf-8?B?cWhVdDhKZVpldlVkZDcwWlpDMU5GQlRxNER0eERwaHhDamJHZ01JcHpVakwr?=
 =?utf-8?B?bmt6WlNQK0NlY0xxOGVLaVpyOERiY1hFUk1ZdG9ZbEcyeklhYkhMQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 465c5c01-dc0e-48e1-f366-08df3eaa7a7a
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 21:43:23.6722
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wU7Fi0pSjGpeGTWOyMsjQQlpu2LASj+toDwVYi3Om+Vwhtum6GFQs+CDVwmCgJjlmCcuCd8iG93RJYu1lkDhWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPFA42F4F89B

On Mon Nov 9, 2026 at 8:53 PM JST, Alexandre Courbot wrote:
<...>
> Also it would be nice if the returned errors could be documented, as
> that would also document the conditions required for this method to run
> (i.e. a VF registration must be active).

I will document the returned error types in the next respin.

Thanks,
Simon

