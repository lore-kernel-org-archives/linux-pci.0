Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.17
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794962174;
	b=liHWUlVsevOWwu21+FPVyuAslqADUxhO+mqcTFopLJUuxfnNlRLz5Z8lUcqt+OhsB7dF
	 leXUBn1/bRl8+38lVj2X8LcOqnpmv/elsmoc2cNbuBFZ2TJ5zDOZ5XkSCuhg79ldGOsrl
	 7NzHDJCWM53HSu5z4P/awPEIFyijoRbBwxD/9AqMnI3zCnbw62fZUy8FsYomM8/WdVCS4
	 KtZVF6sEHeR9FaASCI29/E4ZnCO90r4gau36rJ2EmQiz/3616Q5faPcNJwHhsVYfts/WY
	 JeFZbI11AN4cOQBJ4/+l8F2PwhVBbv0djspvCQNVnDVlw3/sgRRxhpErUFVJVZsS0HQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794962174;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:In-Reply-To:References:Content-Transfer-Encoding:
	 Content-Type:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
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
	bh=7gSg1Qn6Y+3Wjjevl3h6X8QNm4qsYhjadX/BzzTiITc=;
	b=KHPCUVV2TyLMFH9eqQIpAWB3OnAvQv/aJl08osdaqKIsm+unx1kfqxCsAKJ9KhtnZ/h4
	 Mpdsmq3OIujDKZ3yDciU7PCKRhYZudTJurH861J5jTa6/gHR1MYQfrWh44cpuycTx8Oq8
	 ODk///31/dli7U0ksNtMKr2YQyjVBIW1roIIwXVEVshKadmoaGixrcePAI+MPLcjq9qVP
	 FiAH2O2MIojHuFq17zTzNYZZdwpN4VowoAombu0yGnT3G22R2jraT8m64mubzcGbJMnGA
	 UaqBjtToawYr9C96esUqlsUXSnsOkYxkci5piiymuvLs7hWUhjjXUeyQ04JGWo9p3ww==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=rS2CVaOG;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.17
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010017.outbound.protection.outlook.com [52.101.56.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8141606A31C;
	Wed, 18 Nov 2026 00:36:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D8141606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=rS2CVaOG
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TI+ReZEXOS+JSJnYBIDvF4OQrzhJaktpZpaf0vLWlYbn5t/YUGVIC49rXb1bIOXClT8q1LElWH3aThMx35LbX0MqvuFUQ2nGr1G8i7O9bt/Q1RAyU9ZK/BlrMEDUA82yJwmViyvUlMg9nQ9C8S/ok1Wd0vGYC/AhpDWi5M06kVH0p4RYK3GoBUc/Fu842Bsk3xcaRFGOfLWyzb5LlZ1+kwZTNbTi/3zqg9SC4xdk9Wx8+CLVR/ykh4ddcLasF6HqhF42pWh+rB17Wk7f+5Rgzrki2U9FPR+t22k53q2nN4K1qFNRbqYBggayNRWOuc7RgZ3Bn78Y7nOXUI36fsgxjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7gSg1Qn6Y+3Wjjevl3h6X8QNm4qsYhjadX/BzzTiITc=;
 b=LqAxFw5CX/RolmpkhsHponkLakW27FtbdbuhtIApxj6RE4CqcZ2dsl2iM341qW/xkuM9yWKIzgvHOq9iuJ3a2RPCx4P/pOecX+UC3j9sl/ig0/vlEZ4nAxqEIL9V4xRbJUJe8S08CtXhrF7I1ribLSh/wn2iJsIgVBFq931R348vBJJVh91tditSc+NVSCTpsA1wzZMTk+fW0vbqW6FI1NvqSMoaTLTe+T7VQSIPU89zoTsTz3zCZJsx5v84+g1GRIT8Qabgdj47tKNTmw1xfoCauaElOYUdO9fUy3MO8GW1WULENIXvdCgYKaeTkX5GmEDpqtz2ODDb/hloBnX1FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7gSg1Qn6Y+3Wjjevl3h6X8QNm4qsYhjadX/BzzTiITc=;
 b=rS2CVaOGsBgUOl2rqrTib9UkpHfors+a1BbAVn/9qE8slip+89F1xyu8TQMfkhf53y15Okktyg/arLbX+H2WMM32U34TBdJIRbg7NkbaXgqqOTjJtCiObh+g2/kbPy1Y9QocWCwHoL8VHu2fyQYVJOtCXZ4a7Bwb6BjulculOynM+6xHGWE81SQcEByIB7bdaKmw4RRO2AGbYDJFbN++goamabbDDYKnJ6UZ4AUUeKM743/1+0FnPVOTG6p87fHINyKi7yN2oFFM+ikCu8ewUpZJN4/2i5aT5EXHbefg0ZtZ7pLP4h530V9lHbAWaIwJ4es1FpYi9yG9xCjIOM0OCw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by IA0PPF84D37DD5C.namprd12.prod.outlook.com (2603:10b6:20f:fc04::bd6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Wed, 18 Nov
 2026 00:36:09 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%5]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 00:36:09 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
To: devicetree@vger.kernel.org
Cc: Bartosz Golaszewski <brgl@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Krzysztof =?UTF-8?B?V2lsY3p5xYRza2k=?= <kwilczynski@kernel.org>,
 Rob Herring <robh@kernel.org>, Jonathan Hunter <jonathanh@nvidia.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-tegra@vger.kernel.org, devicetree@vger.kernel.org,
 Thierry Reding <thierry.reding@kernel.org>
Subject: Re: [PATCH 5/6] arm64: tegra: Add node for the GB10B GPU on Tegra264
Date: Wed, 18 Nov 2026 09:30:59 +0900
Message-ID: <IOZkShOKS1Cv0Px6mU4F6g@nvidia.com>
In-Reply-To: <avxBUt6Yo3oKbEZI@orome>
References:
 <20261029-b4-t264-igpu-pci-v1-0-4d843dda0b02@nvidia.com>
 <20261029-b4-t264-igpu-pci-v1-5-4d843dda0b02@nvidia.com>
 <avxBUt6Yo3oKbEZI@orome>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-ClientProxiedBy: TY4P286CA0028.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:2b0::10) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
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
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|IA0PPF84D37DD5C:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bb909cf-3e88-454c-f6fd-08df450bf03a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|366016|1800799024|23010399003|7416014|22082099003|18002099003|261009223027099003|3023799007|5023799004|11063799006|56012099006|4143699003|261102123227099003|261026140227099003|261028144727099003|10067099003|261022105027099003|261021121427099003|261026121527099003|261022075727099003|261021123027099003;
X-Microsoft-Antispam-Message-Info:
	9+MBwGRFhXo6aOR//JLLvRGS38LlPKpN49hjUygDhxDzZxvPlpEh2Lp1a+tTu02zORhXbslFPolLSzT1W4HboTUk32uKInbKdbSkt9bauH6UNpBXZTMDFzOkCH8OV5VtWSsGkZ+YIiqKqPwu7FG3UsQ85sM4fjTUwafDQZrOs76XoitKq72FtPrSnhaBkRXc/Cz5IO8xrJfDLYKeQKvQ8JYMaU5RkelzChZqOJu7NaRIQpjX0nlfoHtvL5jxoFUqDumvuLNhwYuLGRXSK1BGCSB7I4wLI0gDtSSIBybe5IHKnviM/9PdlfMvDWlIiJ1TJ4sWuyf18DN4v7HV+sPrDh0Q8H14aut61tJLscLbz5PWJ75CxHPhkI8RO5xEEuLainrya8WfRBbDPrwUYQhxwXegdTCcfCETU3r2wnX3/NGJeSLIuI8Olw95ELLGmfjmGdEwjN8ttkFi3scTGQKtvvliO+JG1gEMy06aV48H8TyZlTyd1WmwRqnWxzFlPwlaiOtah32BZ+/5CFWceTjCy6magvselXM/5zw45YYF4gw6rS0Ve/F0aoT+eiHePTRewv5qX1u38d1hfrHZus57SSGuKCZBqyr8qFpuPrr44YtvrAo5EPNK5hBj0IPFl3Y+aUfOdenb5rcptBJ6eby2eo5SC/ejDjcwVNkz+ItQ/DU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB9161.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(366016)(1800799024)(23010399003)(7416014)(22082099003)(18002099003)(261009223027099003)(3023799007)(5023799004)(11063799006)(56012099006)(4143699003)(261102123227099003)(261026140227099003)(261028144727099003)(10067099003)(261022105027099003)(261021121427099003)(261026121527099003)(261022075727099003)(261021123027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UDFmOFg1cE8wRWpxMVJXdUJnNjRHeFJ0eDF5ZDdMK2x4UWUwMTgwSnJ5WDR2?=
 =?utf-8?B?cGFuRm9QWlZWd2VuSXpBNlVwQjNyUVdybmFIVGpZSHJpdnJSYjVrQ05BTTh0?=
 =?utf-8?B?cUE4ZGJFVW0zR2h0Q0dRN2lqaHJCeGl1NFg1RHR1TGF0RjIxdVRCcU1oajJl?=
 =?utf-8?B?OWQzMWlzU2w1ZWVIM1MzK2VRbS92cmgyV2o5d2w3c0hnNW5NckFUNWdIN1Ex?=
 =?utf-8?B?WHVPMEZxT0s2WGg0VG5CMGVxbHNEMk9mRW1GcDA2bnVnb1BvdDJYLy9hNUFK?=
 =?utf-8?B?cVNaZVNWd0Z6Yk5QQUJLVTVUSlVsTExiWnJUUWM2ZitKZXNwUWRTamhTQjVF?=
 =?utf-8?B?YkcyRDROOUorYmlXc3UvMWFDWTY1M0gyT3ZKTVhpQ1JMSGhlZHQreGZPR0xK?=
 =?utf-8?B?Z0ZOUFR0MVhyRDFFc3ZKQWszQW9QU1RrMGlHTWd1SDU3OXpQbmFNd3YzOE9R?=
 =?utf-8?B?dWp4bHFpMThNWE5vZmVLd2FlSEdqbTBYVWQvdjlSbUYyMWR1RzdoNDJuNElI?=
 =?utf-8?B?bjhINW5qSHRqNjVZSHRIMk5RRnRNYnNMY2Y2d21sUm5SalFVaTZQODYxWnJz?=
 =?utf-8?B?QWdPSVZDaWYwSHZESDF6R01XRzI0NFkzci9XTVlFelQ4Wko5d1cxYmRPVVMw?=
 =?utf-8?B?Qngra1R4eUJ2TUU4NHdjNFN6ZlVYM1JqYXBxa2VWRWt1bXV6YjRwU1F0NFdI?=
 =?utf-8?B?ckRSYVl3cUFKeGZtaWp2WmcxZTJFczQxTWxLV2xJMDhwajNlSEw0aHBHVmJ4?=
 =?utf-8?B?ajd2YTNJNENRL0txTEV3YTd5aDJHSmV3djhTN1FNdHNIdWlxU0Rybkd4bTRo?=
 =?utf-8?B?N2FuOWhIK1hVdDM2OG15QS8xUG83T1dIdzZnR3pzWG9WQTVxWk9zNkU1YmQ2?=
 =?utf-8?B?eGdjNWlRQVBPc1pqTjkzQS9Mc2FleUZqNkdSTFIwNklzV054QU5EMm4rcVht?=
 =?utf-8?B?WTJudW5RREorVHVVNHJJMlkxZFUvdWRlMjc3bnUrT3F2MHpQd1dQL1E0S3cr?=
 =?utf-8?B?a2JTVmtXa3FQNURFTGVkdWsrRUR0NHp2cVJ2T3A0WkxHcDNKS0pSQXNhZVRK?=
 =?utf-8?B?dHJRMVV5Qm4zT0c3TDBieHZKMkFQUkM4dXg0TEw5cW82bCt1ZkZWN00zSDlv?=
 =?utf-8?B?MjZ0cmpUTGtVaGlZYzlTeENDTzVZUHpQVFJXVERLZUxYN1RFalBCSG4yQU11?=
 =?utf-8?B?aFJyRm5rZjJVVGpjOGsyYytaSDVCK1ZRQWFWRzVhTkdrYUNmdnVRRnYzbnhy?=
 =?utf-8?B?Njc4dWNwQTdDSkZjTTQvQmFQS1lXVW5tSXRMdDhYbkNYMDhJcWlybHVzVlpW?=
 =?utf-8?B?Qmp2ZGYwbXQ1TzIySEhSNmp5STNwRURXK0QwRTBqaDRPMitkS045U3l0S3Rp?=
 =?utf-8?B?VzdNUlN2WW5Cb25MV2JxZ0d4UkVQb3o3RDFsMmRTb2RadGRHaHRrOWlBUExm?=
 =?utf-8?B?aUdCTnM4QVlOREEzd0ZWRW10L0FFNVhkQ1V3NEE2aXpueXl2cVZtejRINEth?=
 =?utf-8?B?a1VHVEVhWWQ2blZsWXJZNGdobE1GVEowdk5jL0w0SE55VHNDTThxV0xPRkdz?=
 =?utf-8?B?Mld5SXA3b1J0c3p1MWUvVkt5aU9MUkdqY25MbVpuZDFtRHlYYU5rSzQ0WTg2?=
 =?utf-8?B?WHdOcGhuVHM1MDM0UDRSOFhiL0lGeXE1SElUaFNxeXcrOGJweVBpclpQUHVa?=
 =?utf-8?B?ZGFpOWppKzlQTXZhNjNWc3pXU0hKSjJzRUFmSU9WdkpHMmdTRUdNQnl0WE52?=
 =?utf-8?B?VFpKcVlDWnVMQ3dROHRCU0ZpZ1lYM2tDOWQ5QXFkYTgxTnNiVkRoM0RYZ2Qz?=
 =?utf-8?B?NFJWY1Fhd28rTVBvZzhoWWlrY1l0U0R5WE1RdmlnWFBTYWRrVGJoTE9EM2Vn?=
 =?utf-8?B?SW1VSWJ2SXlyTFVuMGFzMVRNMDF2L1lGb01tSC9kaEh5MFhxa1VsSk5yaHpo?=
 =?utf-8?B?Y3JxT3BWNmlvWDBhZG1pTWNGQzFXeDNza2NXR2I1MGZYYlJweUJHM2gybld5?=
 =?utf-8?B?L2tJdXNuTWJoY09hZHZoZmNEVjVkMGVGVnBTbGgvaTRRcHg0dldOL2FBNFBY?=
 =?utf-8?B?QlJNR1ZrbGxLU0t5d3lDbzNUMW1sVXdTam1NY2ZXMktDZE5XMUkzQTBZblhF?=
 =?utf-8?B?SVJPZk5FQjdwc3lhaTY3VXB2RWMvRVlNR2VCSTQvQ3FUTGszZ1JoaHlnVzZ4?=
 =?utf-8?B?Qk40S0d5a2s3Z1U1eVY2c2crU0s1dXpOMGdEaW5vd0svaUVuUzlnT0xBVURN?=
 =?utf-8?B?TmxSYXgvbExINHVXMUZnV1VPQVJiWWROV0RYMUlOUGlpNmhxTzJEZGQrVmY0?=
 =?utf-8?B?ZXY1S3ppc1JnZUE0T3dQVTVyMWFjRE9PeFQyWjRtOC95b3JRSlVuY0xHTjJM?=
 =?utf-8?Q?qRtMJ+43kygvr9V448o7cWN4chWTpQaJYG4e0JbNndzVw?=
X-MS-Exchange-AntiSpam-MessageData-1: aQbNJn9WsULoFA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bb909cf-3e88-454c-f6fd-08df450bf03a
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 00:36:08.8962
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zk2oXBhwV+XcIWktGrL2N0AZ8uuw/+UMAHkvZlk18xNVcQxDHhfbyIb+ZoWrhoyz3z4N7VC1SGoDEM7rWU1xiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF84D37DD5C

On Tuesday, November 17, 2026 9:17=E2=80=AFPM Thierry Reding wrote:
> On Thu, Oct 29, 2026 at 12:32:07PM +0900, Mikko Perttunen wrote:
> > While the integrated GB10B GPU on Tegra264 is on the PCI bus, it
> > requires a BPMP power domain to be enabled or it won't enumerate on the
> > bus. Therefore, describe it and the power domain in the device tree to
> > allow the power domain to be enabled prior to enumeration.
> >=20
> > Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
> > ---
> >  arch/arm64/boot/dts/nvidia/tegra264.dtsi | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >=20
> > diff --git a/arch/arm64/boot/dts/nvidia/tegra264.dtsi b/arch/arm64/boot=
/dts/nvidia/tegra264.dtsi
> > index 5ab34cd09a3d..4c8b320ecc40 100644
> > --- a/arch/arm64/boot/dts/nvidia/tegra264.dtsi
> > +++ b/arch/arm64/boot/dts/nvidia/tegra264.dtsi
> > @@ -3597,6 +3597,12 @@ pcie@0 {
> >  				#address-cells =3D <3>;
> >  				#size-cells =3D <2>;
> >  				ranges;
> > +
> > +				gpu@0 {
> > +					compatible =3D "pci10de,2b00";
> > +					reg =3D <0x00010000 0x0 0x0 0x0 0x0>;
> > +					power-domains =3D <&bpmp TEGRA264_POWER_DOMAIN_GPU>;
> > +				};
>=20
> My understanding is that the GPU is the only device on this PCI bus, so
> wouldn't it be simpler to add the power-domains property to the bus' DT
> node? I guess that's just another interpretation of how this hardware
> works, and I like how this power control for PCI devices allows
> individual devices to be turned on before the bus probes (there's a case
> like this on Jetson Nano where Ethernet needs a GPIO pin to be pulled up
> in order to start enumerating on the PCI bus, though I don't remember
> how we ended up solving that, sources don't have any indication of that
> GPIO being permanently set high or something).
>=20
> Thierry

The bus itself appears (at least to the point of showing up on lspci and=20
kernel logs without any errors) to work fine without the power domain,=20
so I thought this the correct way to model the hardware. It seems pretty=20
straightforward like this anyway.

Mikko



