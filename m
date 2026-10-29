Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.31
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793244902;
	b=kNVNa/9IS0ydowao6FssSApq83s8byALnP0lKaiZBAghHdhtClvCkt7q/Jgs6elyxcQq
	 OEImwFcWsh+VjdyESe+K80WN1ox5Y5TP4ZpqSjeUtCMNQJJ4Mjg1AObubXNgis+FuY88v
	 JG6CvRWr2SZLjQZNekDmiVaxoBGOc0Qd3HK0ACKIsvyiTbibrqyHW4UXGsTnve/WiGxKd
	 2rpeAQHvkdXq/XEQh4jTboxYRy7xIo59Rsf5HVk6VtTW85wVrFXiQ4zGqTPA06Nj0OL/L
	 AqWwls5RsEmIDnuifgse55CRe99t2FnY1DN7mLbVuaKED+fYmjGAr55Z7f82wvuPJgg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793244902;
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
	bh=ecb3mwMGaUVY7izvCKtb8aC3aqMMNcjavL0n93IKySs=;
	b=Vc+aTd3kvuRV8E+Uw2VRwudGAYQglg9YoN5FKhwyHYvqGTwDYWNdthQGPt5QbukKDp+J
	 2Ap23FQy08J+6nfw0r9PQPza91SDPpkDI0L+FxrFfpUcwTVT8jHjHyTIzekHj4F7ia4Zk
	 5NG4pvzgxb/q4aP3ZMdfqw2xcHQh8nRXAp/kvweFQcSkeDTfzFVKwm0Ufg4s9+hmFBavH
	 hxoxXJG+wj4K2ys12bjwSGhr8oF1Uzam1frEyFGZPaXbPwdtljpVDPGtOTERXmFW5Uec2
	 3ekQjgqMyB2HkXEew7iTU3VoqNsuipCNaIZJpQl4wftXncyCG4JopGIYIosT6xBdqPg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=LSY4kk4I;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.31
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010031.outbound.protection.outlook.com [52.101.56.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86FD0606A31E;
	Thu, 29 Oct 2026 03:35:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 86FD0606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=LSY4kk4I
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xlMPCzmysp1h5nWn7O9G5vN423E8OIuIcAlAC9aZGHGxOl4I5fGsj8NooLxYZSh+THLLNxbmzUKqcRsMGdDZC5jaTI65dj4v55Entnv2mlehfzoZq4aIPFMiAbDyZ+iQhACSioBEi4nVBivyP59bXFHxH05fJwjLrKSf6xRQTKwDpjhTYMR9LoMkUtbRrklVJQn3AKUJ1h9LVPxpWjtQWk8qLKKbUltgFZf0y8NEuKVmUnX7tTHDiWHG3bIvHO6vMhm6KAOEWOsLnFDNFBEnDq9Rwd8QGsyNgBgJl1EDuHLUIxvfFZ7k/FsDtnmTlCmUHgWcn+9GjQgana4hO2xl9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ecb3mwMGaUVY7izvCKtb8aC3aqMMNcjavL0n93IKySs=;
 b=jOsCB58DcyA6asuLuxFkVb8qFoTAlKPjkgVOBois+QNkoLkQ+4xqy83LijQWiZmII/Lc850Khz7AJwmWMhsP6ZLG+uFrUeHRWKMSSvneXOmX2woEymN2hf8yqnlNt8QRFqwH/KeTGaJBDEy9jQoRNDjOQSICKfV+oZroBikY//8FdV4Qs5NGPQLVsOxzYIU5tOBYJxFOkEZbxFpUpjvCLcmORkp/d8rDUyj5zdp1a1l95IK/OpGZhEI0eYyvYK0Ct+5zPJz91wMiCpYHEJ78SJQUWKUuk9J+R9KAw56WYCKQ39o/01JpAKzL2xFJsW5vG5hOTSf8+PSgggUSEVBbSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ecb3mwMGaUVY7izvCKtb8aC3aqMMNcjavL0n93IKySs=;
 b=LSY4kk4IqdYoMJ1MMbcaAqbMccWsUznTjeksFzCeiWjzxribF8sqRPtMLMTTgu2iYzrD6YFh2S6D1vRold8pN+GwnRm+UP+TcyJnNQV+/0SWMnsXSRrpXNmsS6MbIm0N8txblbzqWDTSLVjCFrP44Swnc1cJa/PNZD+EPrxtmBe3llbFMQC8HTR9DfDC3bRsKUpLwuDMBgnuaf2rNADXKJol3tn/Csd1egSryWzP8hBQpbfH8kU8cs3qVfT80YBpKZsBGX88ve5OYL57Q/yvwJtj0DsgA+tmz6LDlLM9rpe9uEjVbnH+YHXbmJjNbLopZuddz0mQLaNsHa24v4Cibw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9166.namprd12.prod.outlook.com (2603:10b6:408:19c::13)
 by DSVPR12MB922022.namprd12.prod.outlook.com (2603:10b6:8:3e9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Thu, 29 Oct
 2026 03:34:58 +0000
Received: from LV3PR12MB9166.namprd12.prod.outlook.com
 ([fe80::e46b:ec42:12f6:1350]) by LV3PR12MB9166.namprd12.prod.outlook.com
 ([fe80::e46b:ec42:12f6:1350%4]) with mapi id 15.21.0569.007; Thu, 29 Oct 2026
 03:34:57 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
Date: Thu, 29 Oct 2026 12:32:04 +0900
Subject: [PATCH 2/6] PCI/pwrctrl: Enable pwrctrl for devices powered by a
 power domain
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261029-b4-t264-igpu-pci-v1-2-4d843dda0b02@nvidia.com>
References: <20261029-b4-t264-igpu-pci-v1-0-4d843dda0b02@nvidia.com>
In-Reply-To: <20261029-b4-t264-igpu-pci-v1-0-4d843dda0b02@nvidia.com>
To: Bartosz Golaszewski <brgl@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Rob Herring <robh@kernel.org>, Thierry Reding <thierry.reding@kernel.org>, 
 Jonathan Hunter <jonathanh@nvidia.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-tegra@vger.kernel.org, devicetree@vger.kernel.org, 
 Mikko Perttunen <mperttunen@nvidia.com>
X-Mailer: b4 0.16-dev
X-ClientProxiedBy: TY4P286CA0126.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:37c::19) To LV3PR12MB9166.namprd12.prod.outlook.com
 (2603:10b6:408:19c::13)
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
X-MS-TrafficTypeDiagnostic: LV3PR12MB9166:EE_|DSVPR12MB922022:EE_
X-MS-Office365-Filtering-Correlation-Id: cb526525-8514-4de9-756b-08df356d9af0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|7416014|10070799003|921020|11063799006|56012099006|261009223027099003|261026140227099003|261026121527099003|261028144727099003|261022105027099003|261021121427099003|261021123027099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	EFKqQJclCJsumw1vFdh/G/duDrd9THmJbL23MmlPA6eoIhh+X/R+LC1nNfvHtaOdT+hoaYjvliWoytqqOSWpyGkqS4qtXTZT1RRYnFO+x2LVEEpfcUkLbqi/UODCq2uRyZqjjHe3WSQ9t4IiW9OOv6NHYLZENyenlPQtds3G84I+YgM1x97rfUEi2x/k5eLI+UI8yWt0TjF/kfrSaX+Ed4CSQ315Wn3KMPUOXdK3J6e+I6bWy1Ud4KZmCoydLNILBXoHJ2faylB9HPCG4R96wAEnT2yEWZZIw4exkMuVzwyqZDaGmo1jqqcXDfoentbUIlVL+gfNsWQg5/a8EP1gx5F2DU5MsepLOzK22Gp5PbzdKnQFql4msTDfG20ALbJgSQK0jtdTDFcxafFN55Lvth1uCfGFTCWNQN6F4BqoL34QWRJ2feOb2lC/BH1JC5LLWIJIjPPlOb7G5AcjDTx6z1aBK+MmReaEYJI8d6myfTrDjl/A4gAgjejGzBaXYUcGkEH/UGy5l/IBuL1eui9Vv4qY2kjtIGvNFPNhx6ACP7cxP1d2lvgYXpy+y2TyUsbco0cCiipE+dL30ncWe7TEX1we6eS0YN4x3KVpeD6ugCBpRNUALdGvppYa+2xWzXdQ7P8eUS9wxaPkJzNYn9+o8sNuplRYvW2wpWQO1At+LTtLKLanDmHTNpxu+DK9o4So+kcKWnikw4DX08ucjuC6xA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9166.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(7416014)(10070799003)(921020)(11063799006)(56012099006)(261009223027099003)(261026140227099003)(261026121527099003)(261028144727099003)(261022105027099003)(261021121427099003)(261021123027099003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aFVVQnVqL1hnN1FMenBPa21mNFJaWjIvNFAvTjduL0gwblNzY01mSjhxajlZ?=
 =?utf-8?B?ZXpQb1pOTVpoQnpySFdxZnQ1bGs5a0hVVk1aU05UY3Q1WGNDaEJTcUJwa0xR?=
 =?utf-8?B?YjN1bEdSZWlNcHNLWGRXeGdYUVpxR1NDZGE0YmgxT29xT1VCdDlBU1M4c1dk?=
 =?utf-8?B?RXBFc0pZZk1HYk5NNEhvNVFOYU1haW9ZdGxxOHJvUXNnR2lKTVV1TlRlYzdl?=
 =?utf-8?B?Nnl0d3lZSDdPSjJsVWRRUlIwRDJ1STFEWDV1S2FNVC9aYkM3WllrK1dhR2Zr?=
 =?utf-8?B?MEtwTHJaYVRZMGhOTXFWcGIxYkJjYlFTNkxXTVE3VitPQStMT0Z4S1VZNCta?=
 =?utf-8?B?Y0t2SjZoRWxwL0w4Z3JIQ2RtM2FJMnRmbkkvZGZXc1dQcVFpNFV6c3kyUk5L?=
 =?utf-8?B?TDFRZkpMZ2JEbmJzaXFxbHlhWGNRRXpDaG01VFdzaUJyNlBYTU4vYjJmalhD?=
 =?utf-8?B?SmF5RXlScTAzTTJjQ3Fkd2pubExpeHRiK2s4UFRRKy96eHhQNThsS3lNek1E?=
 =?utf-8?B?N1M4dnBvRDlCQ3c2bm5yT3dFazd2Uk1VRzJjNHFZUTFSM2pzY3ZQSEpUYW9L?=
 =?utf-8?B?NmJxOEZlVm91Mk5ITHZwNjkrMWV2eEZQMGVOaHZ2bC9iblBxME1yWGRRUVpF?=
 =?utf-8?B?b3pSOWE2b0tzVmFKSHZlbXFIQnAyMGpGNjB6dmJmMXVZYjUyTDhjeitRRlZ3?=
 =?utf-8?B?WHdKdEF6MnlMckVnbmdNeUxsd0ZZODZlaDhrR240R3dKQUp4K01HTWdNazlj?=
 =?utf-8?B?ZkZCSzNEMVhuUnNJUmp3Unh3Ukt6NHVDbGJwS0hvbzRCNlJwRXNuWVBGSk5p?=
 =?utf-8?B?LytqQVB4OGY1RTM0SS9BOEFqL0w0NXBTcG5OdTB1WUZnZW5vY3htOWo2M2RX?=
 =?utf-8?B?Y3UxRWV4T1RQZXg5NGk0YlIzalFsMmhpRnp1Ly9uMkthQktUR3RWVi9qZ3Ax?=
 =?utf-8?B?ckZTUlpBekVySWdqdkRSODcxZnkwUElXZzNQdzN6Wm5XaUttTExsWVlqTWVH?=
 =?utf-8?B?RGgxcENqYWZyVmt4M2RNUVhmbzM3eDV5NHl4SC9xRWFIdFB2T1ZjYjdyV1cy?=
 =?utf-8?B?cGRrczRSOG5BUG53ZEpWeUZlcGVwMzVudGZjTC9EWTgvNkdMWWxjNnRJUmZE?=
 =?utf-8?B?YkxsZ2s2Mm9yV3dUcHJkS2MybTVBV2liQ1IwODB3eG01SWpVRGFiTzdETTlG?=
 =?utf-8?B?TDR2ZUNBTVBmUnM0UitUaHRMZ2F3bjJzci9OSlNMUXpHUnUwU1oyQjV4SGwr?=
 =?utf-8?B?cVRqeld0eVlMa0ltRGN1d3lYK3E0K2hZUmcyQ0tja2dmRGFhdzdBTEpZQUxi?=
 =?utf-8?B?cWsxYU90dnhNT25uZ1FwVFhIb0Fxbi9HRHIxZXd6eXBKU3B0Y1o3OG5ueWRh?=
 =?utf-8?B?SkowVURMQzNHaHhzYVE2L1RCZVF1QkFCang3dlZDTHNRUjVSaFMwQWFCZGc1?=
 =?utf-8?B?Y1JySndEWERReE50WjB1MHdLTUkraVNkV1hJR1JYWllNMUdRM2lPM0h0T3BN?=
 =?utf-8?B?WnEzSUcyN2hHbEYzaCtRQ0RVM0VWNU84OTFPR3kwbk9BUTYwNVVsQktxYnl5?=
 =?utf-8?B?N1BPVm5vMW0xYmhXbGZ6c3J4czRHU25CNlduNDhmT3hUeG5QMUdIYTZ5RmZ2?=
 =?utf-8?B?RU1tTXh2VkRNME13akJXekJZbzgyU1o3RndqY2Q4RTRWTFEvNHVMamlFa1RJ?=
 =?utf-8?B?SDZRVlBmUnFNaU9JNUFkOUpkVVJtRmZxTzVqWGNEUHpDOWZFbnErYnZuOTNU?=
 =?utf-8?B?N1IydUpDN0MzTDBnVzIxR3RlUGFxNnZiWlBLVVdNT0JNb0M3bEVGc1M4NVhh?=
 =?utf-8?B?VW1GL05oMnJqbWZJWFBuZkVqRitpTnVxb29Ma3VBSnpFanNleW5xaFF4L3pQ?=
 =?utf-8?B?TEExVnVBYkhhZXh0endUTmszRE1CQVN0cmtWZVBCMEZzdnpkNDhjRjA4TCsx?=
 =?utf-8?B?enpmRkN5YXFYQi9NVUJQRG96OEpiZTVEYXpkaTBHY2hhMytKTzBqV2lwb2lP?=
 =?utf-8?B?cXZFeEFSeGZiamRNdjA3YUEzcGY3aml2bEtTTHFCQ1pNeHUxMEVKQys5Q3FK?=
 =?utf-8?B?KzBvT0d6dUttK3lvQWxPcHd2Q1d0U0lrQzNlWWxKVk5idjBNWHV0WGhKVjZp?=
 =?utf-8?B?Z2pXSlp0SitmK2E2TzBCdFk0R0ZZZWc2cnpSTW5Gc3V5WGVtM2VkZElMc3FN?=
 =?utf-8?B?TkZrY0JadFpFM0ZqZnkra3FscnM3bzBaSit6YjY2RWQwYVFHdjhzOHZOaGZr?=
 =?utf-8?B?aDl2QUJkUTVKVnVoU1FOYzJGQ3J6dXBNNjhIaGFqb3pVaUVNQm11Y0dKVDUr?=
 =?utf-8?B?a2JFaWZGbFpaYkJ4Y1dGeWt4ZUhtclFiZWpyNEhrdGZGWkc1ODVYVFZKNnln?=
 =?utf-8?Q?lb9Kcza5tUcEXSXedVKaMEXAvw9Cp12TKvg1GF7PKAEQL?=
X-MS-Exchange-AntiSpam-MessageData-1: GfLAuCucU2UJHg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb526525-8514-4de9-756b-08df356d9af0
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9166.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2026 03:34:57.8232
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MpS3HtGB4zRXSONfBLrm6aRWQot+0BF+bxa/Z6VBfQoTb6oJOfYIPTMRWlTX+FBlh5uRmdJOARpwubQDvSktfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR12MB922022

Update pci_pwrctrl_is_required to return true for devices that require a
power domain specified by the power-domains property, such as the
integrated GPU on Tegra264.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 drivers/pci/pwrctrl/core.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pwrctrl/core.c b/drivers/pci/pwrctrl/core.c
index 0e2387cf4657..437507699beb 100644
--- a/drivers/pci/pwrctrl/core.c
+++ b/drivers/pci/pwrctrl/core.c
@@ -146,8 +146,8 @@ EXPORT_SYMBOL_GPL(devm_pci_pwrctrl_device_set_ready);
  * 1. Presence of compatible property with "pci" prefix to match against the
  *    pwrctrl driver (AND)
  * 2. At least one of the power supplies defined in the devicetree node of the
- *    device (OR) in the remote endpoint parent node to indicate pwrctrl
- *    requirement.
+ *    device (OR) in the remote endpoint parent node (OR) a power-domains
+ *    property in the device node to indicate pwrctrl requirement.
  */
 static bool pci_pwrctrl_is_required(struct device_node *np)
 {
@@ -165,6 +165,9 @@ static bool pci_pwrctrl_is_required(struct device_node *np)
 	if (of_pci_supply_present(np))
 		return true;
 
+	if (of_property_present(np, "power-domains"))
+		return true;
+
 	if (of_graph_is_present(np)) {
 		for_each_endpoint_of_node(np, endpoint) {
 			struct device_node *remote __free(device_node) =

-- 
2.55.0

