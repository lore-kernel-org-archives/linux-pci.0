Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.32
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793895185;
	b=N7Xx87PhMUDT03/5FEmF3ScJYUlSi6gUk3/wa6cmn/y4Yh/9yZiP1OWSk4nW1Apq0Er+
	 HFnSHq3EdOfQNL5MwGellUr3suEIRj6rnu9sM+4WmbFHXlC3KRjCtA84gbF1snUtip/a5
	 Vo3HBdaYkHDt4GVTn+QHIwHW225Czj4MGyA0tjMSxt38TiJ81tl5stUtpU/4h1s58A7mG
	 gHnnB/ik1q21QZW+DJ5AMaAIqRXr8/7QRqhN0YKc6xKeod0Z6CxXahWo+xINRDz2KlNJK
	 /Fgmj+pBoAs7f/6J+d5dLtbgt6dN1gAQqTry+dC1xynWKEe1iMM7s2EFWtivny8oP7A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793895185;
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
	bh=JoKz9JZSflI15yAAbzZ6tJBCrkw4uTC3Mv76en8hlbs=;
	b=ourJwIzeKALP2NfMTdPLoedG8V6Cvk0189h3d2VsFZgn+0OknXsHG1HiF3QnhS9ubSFx
	 naSjE0t32rq5oBiV3B59dKOgufEEUqYhvqQMLTVEIzUCG/aeqB4w1+GsQaLCItfnKKf3e
	 N+jTK4EqG6udXq0qGtgKhdVsEHjMEQUn8DOGLwT1TbX22lnY/lc/hssmEQFhUm39mIYXi
	 SZtCPLBLfJU1xYJ9yrhYTjkGXIKdDfnOAb5omdJZXNiLoq4Z1B0qZhe+yWeV7ix2Iagpo
	 vRLPo6tXpJ7unPVCA6DQWzTnGhuu79M4SEEAFjB1G1cOGlqGQjGs1SZSapc6Zm36B5w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=gGu9hUbN;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.32
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012032.outbound.protection.outlook.com [40.107.209.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC777606A329;
	Thu,  5 Nov 2026 16:13:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AC777606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=gGu9hUbN
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VZITaCIP8++2O4RCNssqNOdnkl5T1w+CU2y1W96qRs4Gss7brPVY5PGxeVKsEiu7BF/n3pKk1k2lYEFJjRUFf014T3wHICHlJsqbZDM17dcEJSuJN+J8h3O9SjYu3gM/hP78i6nTLDDJlQ2V6Fyw0zp49t5OASLC6K/lUVWj/X2ZRcO9d/4hMzLTNiYFq3YB6g0PpyXK7IGmAfBSxTKkIZhaeH30L+hpBtujnUyrnLEFDjSVGG4L/q/d/0+Pxy2r8DT5+j714zjRhTf8Q4UvPam/UtwraHE65It6uCeI9vn5RlMoR2K2LaBMHgM5unPCFPWjBpeB2y2buJhrYLFATA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JoKz9JZSflI15yAAbzZ6tJBCrkw4uTC3Mv76en8hlbs=;
 b=ySg+Zt+yX0Kc1T5mKQvQKWwSC0qfpSVY39gLWaXmDbB4H4ZqzltjiHcTRXUDX/8IqNnviNSg3BQGlS3x8upDUdanGr7JYqNjI2GBtHxbTA4y0J/o5qZOQUwHXsD4MNXPjMlXB0XYJzEZmXpBfhC5E9U418t1iq6bVNcxX8kJ/v5FSXR8G0i/W8bmxACuY8nnyw1Gp+q9kkTzLysoilmMVtb8j/mlOoxTMLMeXyQLzHg4T9IZsvyNcIG7yxyIN4iz2PEuNHPu2CCie4eYZjFjiXySjGgBr2xeEmey9T8zodI3nRFN5J7V4G5aKw1+H4HEOzEnUl0uwiOqimI9hLLKKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JoKz9JZSflI15yAAbzZ6tJBCrkw4uTC3Mv76en8hlbs=;
 b=gGu9hUbNAjGEhTTS7ehtmsF0WO1tA7uEfv5/E1zcfJwaOFbUuK/ZfJud3lFKdQrYy/Mrq2p6t/n2+NoskEgJC7JZGc2LJTqS7nfWo7c8X+UYD27xaMBXNoEKlMhQOqyHRp4i+u92EFCaTCfZ2RVNsB+yp1D3/SKdjfvi4GbmeHvfUhZSc4D3ln1xXI7PH0KZcrNoBgh4yDLvDSzud7CK3unVaZmx5/WF/QQvIT/Bo0tWFfUDjigkyk57XV87Mu00QGUoPC3IJD+HLvO+uKX+yEjAjNKiSFU0Qdl/x61i3Y+LIw8tAehHjwd12XQ5Q2JPCshRrTcc2IsO6vrQ6H8NIw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5) by CH3PR12MB8910.namprd12.prod.outlook.com
 (2603:10b6:610:179::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 16:12:53 +0000
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522]) by LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522%5]) with mapi id 15.21.0592.009; Thu, 5 Nov 2026
 16:12:52 +0000
Message-ID: <854b1377-9521-4a24-91fe-ea1d213403d4@nvidia.com>
Date: Thu, 5 Nov 2026 08:12:47 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 12/18] PCI/CXL: Add CXL Device Reset sequencing
To: Richard Cheng <icheng@nvidia.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Dave Jiang <dave.jiang@intel.com>,
 Davidlohr Bueso <dave@stgolabs.net>, Ira Weiny <ira.weiny@intel.com>,
 Jonathan Cameron <jic23@kernel.org>, Vishal Verma
 <vishal.l.verma@intel.com>, linux-cxl@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 Li Ming <ming.li@zohomail.com>, Alex Williamson
 <alex.williamson@redhat.com>, vsethi@nvidia.com, alwilliamson@nvidia.com,
 Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>,
 Vishal Aslot <vaslot@nvidia.com>, Manish Honap <mhonap@nvidia.com>,
 Jiandi An <jan@nvidia.com>, linux-tegra@vger.kernel.org
References: <20261029145703.2185231-1-smadhavan@nvidia.com>
 <20261029145703.2185231-13-smadhavan@nvidia.com>
 <auQC2UECQ8vaelPz@MWDK4CY14F>
Content-Language: en-US
From: Srirangan Madhavan <smadhavan@nvidia.com>
In-Reply-To: <auQC2UECQ8vaelPz@MWDK4CY14F>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0220.namprd04.prod.outlook.com
 (2603:10b6:303:87::15) To LY0PR12MB727857.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: LY0PR12MB727857:EE_|CH3PR12MB8910:EE_
X-MS-Office365-Filtering-Correlation-Id: 43888932-a74d-4385-423d-08df3b57a492
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|23010399003|1800799024|10067099003|22082099003|18002099003|56012099006|4143699003|11063799006|261028144727099003|261022105027099003|261022075727099003|261009223027099003|261026140227099003;
X-Microsoft-Antispam-Message-Info:
	Rhb7LogYsChvVEhQ5Th8E1zZwuaW4mM3DQjCx6JYz18pHrzlccZAELQws4to5nOacn4Z29YIQcCw1Sk16xFw9clzA8AftQPnc2Fuo2DNyJ/6iBtLIZEo5KIPAb2Sha4yUJe8Y8epNnJlcTti9kEOs8eUiX87qOwXybQLPo+AarrFn3RZbFtdqnSCpjHtIRo8b2MPapeqyMUqWMHSZ3dFAi96bdqZVKm3ygcZQE5rfWwEszHRVrXVr0ivR53XVBXzBIOtzECiOQT9qniIjwwKzGjnWNQVhqvRwpEim6IvWDfVq3BYNJHeJvsB+s/r3OsHacZRMah3MLcFaQyF7AsnTqFFvWKinsgrq51fmMMACWUt9bugoTMYN0F1i+dT8+1vZh2zQgvVLxTUZ9qEHVLVkztuSW8PgiAG1cgp92DgNww5stfl1X49/E86wonpzcXcIclW4RNgHCGu0wKVkyzPWVZ3Kz0hGc019bx47QE09igShc4JO3gBPB5Qets1HTAuRHlvD10z8psMmiruAtlrmJVjRsMtKAoR+E+ogmPCyXwn7kM+A9ZCsPEP5VnB67OkbxGtFuA9Dc0YIYkcsWGXjVEBzA6H2fMXrRrT81iqyIk4slbPVGaRKtHUqkYVvBIinboxVlbeSe2hpv09fFC5RESG9+w77ApRhKxC/n5F2Y4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LY0PR12MB727857.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(23010399003)(1800799024)(10067099003)(22082099003)(18002099003)(56012099006)(4143699003)(11063799006)(261028144727099003)(261022105027099003)(261022075727099003)(261009223027099003)(261026140227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V3Npd2hOMUJNTHBwK2RxK1ZhVTBQbWtGbWFrTHpVcUFvdWNLcXlGbDBhRXlh?=
 =?utf-8?B?WlhzQ0cvREVqUGIxM2xmd1RJUS8yUFJpNmM3UlAvWnpiSE9WSU1hRkNZemFr?=
 =?utf-8?B?cEZnM25VQnNZZjkzRlUzWEJnV1pUNENWTVIxbnlqOUJrV2ExMEFGWVVBclBr?=
 =?utf-8?B?dTU4Y1lPdVlNSFBZdnFlYkhLQWR4U0QxaFlEaStvakUycWh3YTZSRmZUczlp?=
 =?utf-8?B?cmF6Wk9GeVBuNjQ0RCtEVU5jUHFZOGxjckFYbkhVU0NXbVdrZ1Y4VWN3TUVX?=
 =?utf-8?B?aTVsZXVCT2p0Sk1nQllsanBBWjZSKzd4TlBZQmViNmF3bVI5eC9HcDZaVDl3?=
 =?utf-8?B?a2kxbWFwZFpCNytsbDdjZzZEeklxdTZlc2czMTBrU3IySnhIK0dsZDhIOVAx?=
 =?utf-8?B?NSs4Q3FGNDIyM0dJS3lNclpsK01Qajlza2VKTHFmdnJYeXNOb3RKMW9oR0J2?=
 =?utf-8?B?UCtoL2dweWZYQjVyNUR4cWJ4bEtpZzVHZVp3Yyt2ckt2MU00UTN3MFc5Nngv?=
 =?utf-8?B?UjBqSERSQnljakNHQzRlSzYxQkNZVTVJUUx6VmFpSlo2Q2szbzYwd2ZYb0d5?=
 =?utf-8?B?aCtJNTM3V3poYkwwNTg2MElZUDJGV2RRMkxwcTFxWm1XbkhUTEFnUkdWL29J?=
 =?utf-8?B?U21RT3E5VmR3MDNXYVhrY1RVK0w0VGt5WVlGaFJ0MGdZcHd6cDV5VkpPd2Zz?=
 =?utf-8?B?VVVDRnc2TWlUbnZpaU5qeUc1V2x2OWV5cnVKamVibWd4N3VTa1dGZ2dFUks4?=
 =?utf-8?B?MTl6emtjQUJldGFmUHNnQkVqTTNpcTNndHYzaTR1WkFsUUQrSmRINU0zb3RW?=
 =?utf-8?B?UXpQcEVuZkVubWk2SitsNjIxSU1HRDNqL2dQUWVSUDlCY2ptaTMwdUFnb3Bl?=
 =?utf-8?B?M1gvaGxSenBtdkRFZk84TkNsZ2hnalY5SDBMZ0JhK0VIK1JoSWhsM05vbXpx?=
 =?utf-8?B?RUdVU3NMMmk5eFVvdFlZRlcrNUthK1lwRHByWkRIR25rVVh5SjM4MkRsVHBi?=
 =?utf-8?B?aVdod3BMcXZ3QkxCQkU0bmpRb0dzcGo0TjVjcDJGZE1GQWRRNzU2VkVVS1Fk?=
 =?utf-8?B?ak5BclRQZWd5QkVkY2h1R2NuREFRZ20vTnAwdWRPNThUL3FZRktWeTNtbFlJ?=
 =?utf-8?B?V1dOQUxnU0RaUEg1Nmd5MTN3S2FHeDNhTjJrTVVHOGh1aXhCVFVsS0hheDZQ?=
 =?utf-8?B?Rm13RjBGNStGQlBkQ01HVldmb2xjR0xQWW9LY2MvTkxINEJBYlhmWkh0QVRm?=
 =?utf-8?B?YjJzbHF4cjZtSmhWbk83SS9IRllHdU9SalZHMXhmUmN5N2h3Z0VPOUZxQTA5?=
 =?utf-8?B?bGEyd1ZEaEV6ZC9WdmVwVlgwcmZpRzFySmdsa1A2eS9ZWFpMd05zNXFLYUtX?=
 =?utf-8?B?REJoZTV3N2xEY1NxWjdPTzBIWnM5M21uZm1ZNGNvV2d6d2dHUVJOZ080TVJT?=
 =?utf-8?B?MUN1OCtxM2kyZUU2NGJpTVFyWWJUNndmL1dranh0MDN1Zm1tbW44aFlld2Z3?=
 =?utf-8?B?TnNGNlJmZkhCS01WM3NPUU1IS1JGV2x1ME9zeXlvZFlYTXNOemRBa25wZHp2?=
 =?utf-8?B?UWtBQWw3NURZWjIzM0l4ckVmdnJDNmc3cTdTUmtKNlVkMmZaaExZRktuZzFR?=
 =?utf-8?B?UUY1OGJFTEE2NDdiL09jcVpvcFI0T0NOMEN3N3RNNnJmV1daL0NWZktxRDZx?=
 =?utf-8?B?NFBwWHdmTmF6SkJQZ0Fpc01URWJXNjFMMHFQU3VxcnhraytjZDVYdWhyN0x1?=
 =?utf-8?B?Q3d3V2lDSDJWU2VZRS9wVU9Mand4c0pDb3ZMUjA0S0xnRGNISXVydU1qZHI0?=
 =?utf-8?B?c0tuTDZ6SXNjZFlUdXN3RUsvb0JGUzIyWFh1a0FiQVFrMjVsaTNOUjNoNnho?=
 =?utf-8?B?QlJ1YTNHZHRkc1JhNDJxMVdoajY3MEhNRitiWDZuTDRWeFgxMk5qaitIVmdz?=
 =?utf-8?B?bW1aa0dGUnVGSktsVDAxNldhckh5bitkTEZrSEhWMXVuY1cxcE9lbjhzU3Z1?=
 =?utf-8?B?eWVyTGV3Um01T3gwcFROUlYvR1NDN24wVW5CN2NuYlZsUm9iSW1ZVTVtTmc5?=
 =?utf-8?B?Z044OTl4T2RtK3ZzSitTQWdMMEw5KzRnSjBQV2VRdkZLWGwrdmtLL3pGcWRu?=
 =?utf-8?B?ZGhpSzdJbS9NVVByK04zdC9rZUNpN2kvcklPNUFwNnN3K0RnbFVVenlPTmll?=
 =?utf-8?B?YTJLNGw0ejlZNDJFc2xQYWJUMzRhNThRRWRXOEJBdlBYM0w2ZXdydG9GTWNk?=
 =?utf-8?B?M3FvOWo5NkdJekY0b2MrdTJsMU5vM1hud3UyWHlMeGRtMlRqVlR6ZHMzMHRn?=
 =?utf-8?B?dTZ2VUR2UlNNMUh4R1dpUEZ0akN5ZHdDN2lLZlcvQXVzR2NmaERndz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43888932-a74d-4385-423d-08df3b57a492
X-MS-Exchange-CrossTenant-AuthSource: LY0PR12MB727857.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 16:12:52.0357
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e3R09Pkh+3k43smB6dmmWRCS10uM3VRprEcuSApnd5uz96vlIXvHVq/mV9gCMQx4ex+2XUkd7yhouUxyMz0oNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8910

On 10/29/26 8:22 PM, Richard Cheng wrote:
>> +	/* Allow one retry after the mandatory 100 ms quiet period. */
>> +	timeout_ms = clamp_t(u32, cxl_reset_timeout_ms[idx],
>> +			     CXL_RESET_RRS_WAIT_MS + CXL_RESET_STATUS_POLL_MS,
>> +			     CXL_RESET_MAX_WAIT_MS);
> This part will make 100 sec clamps to 20s if I understand correctly.
> 
> However the device is still legal to advertise 100s timeout according to the
> spec. If the reset procedure takes longer than 20s, driver can read/write to
> "Control2" register while device is still resetting, which is prohibited
> by the spec, software should access only "Status2" until completion, error,
> or expiration of the advertised timeout.
> 
> I wonder what's the reason here, if we really going to disagree with the spec,
> though I think it's not a wise choice.

Hi Richard,

Thanks for highlighting. You are right. The 20 second cap came from 
Benjamin Cheatham's v13 suggestion that a 100 second wait was too long,
but it let the driver access Control2 while a device advertising 100
seconds could still be resetting.

I checked the spec again and in v17 I dropped the cap. The wait now uses 
the timeout the device advertises, up to 100 seconds, and only Status2 
is accessed until reset completion, error, or expiry. Control2 cleanup 
runs afterwards.

The cost is that the global region lock can be held for that long. The
patch 13 commit message now says so. Unless there is others objection to 
using the advertised timeout.

-- 
Regards,
Srirangan
