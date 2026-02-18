Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021080.outbound.protection.outlook.com [52.101.125.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E722E8DEC;
	Wed, 18 Feb 2026 15:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771427667; cv=fail; b=V62Neutk1CM9wklTAjYCFXTblCCwcn2pd7yFZU1gfexylpbdzOn/XdLgB72xasvL8YQx9GiYvaSwH/FdLfxpFEGzCEAmvJ/kqYks+ht/50Iv1o1CCveHY1Oq4m/OBb1ZkWJAEy1h5gYk69l+31CmZ8Yvwb09SN5ZHtcD8eMZONQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771427667; c=relaxed/simple;
	bh=4W1YvqRfuypLL2qK93y+GisF1qNesW543K0V4a+J6w4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=T6gUjOuHU+FNnzr6fZxxu6vMkHYE2WeQPVtpceKsaEXj4EJMlAlvm7buvYQ3ZbWeRmYoonx3PuRvFoLEu2GoQjnu7MCHJW7FG3QB6ZIfUCBwZY3vSjzPCeZc2gmKtIp8+w6EXBJaqJOUBiYXlwqHKFwt/tqfp18gm4MEamtXB+Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=O8izLfV7; arc=fail smtp.client-ip=52.101.125.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="O8izLfV7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jJDVX28v8h18sL8z084gSWgStY1H9ewGaZ9H7d8JyXDn9u7hK8nA+373QnpcGlzwObLEN3gfR+tn45Ugdjyl3kLy0FOeprnMxiQo/B7D1J+KnjxCzX0oT5gpFEoekZXqZttnMOd6J4BANAxdAhMHgseLEnwvT4c15pzTV5kPxEzXwMCcYU6cHN/z5vUzfy+Rn1JP3MX38r0ZXkwg0Vv+x9DDxMrga8XHsHX5tHnHi8L1LYP0nqSzFlQ0jvY/B/gJh0FT3XKPlWPZadBsO46GhqneBriQja9GxQ5pktGAVpJ5SVKcNPfQ4IfYWAuz5PU77fgTDfZxw3+ZjqttsA50yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vl4Y3mgz7zrqBs5dOmg8MlLE26z+1A6V15x3o9ygC2A=;
 b=xc3WQrgCuH+kVaH+pC3slGmvdXeG/8hS2uzWC9wD0d/tWg3ix9fjFqRSP1i0I+QzLpCGVRnynmMp+Pffo4SLB/ZZCM65g7OWSPIIBLDahdjv8S/cAKsWCP8iRecKxvGoJqaB6V80P7+9PzrgeJgKW6tTgzZ9sd5yOAftcSJM/dJTH3O+3TpXN0taH9Vh42SaPGKJW2appTDmKvwfJF2gpmhR2Siluda6YEkRAFl+PS4OyTiFcPFCqgkJVwE7Nqs9UUIuQwEx4EsmnTGm7fCZf5A/n5yu2pYmnre+Gefus35VA9XzuOkY6npz1eaOlj9nPGYCkuCqI7hgjBGM3t810g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vl4Y3mgz7zrqBs5dOmg8MlLE26z+1A6V15x3o9ygC2A=;
 b=O8izLfV7Rd72ED7HeoEtS6P9cG2X9NT/yM5BTO1nxHCMfR90VshJNyA82a9oQ70xPcFQzDhtIFmoMxR1/dKrayEiOCLA3mBMoM7DNrCAACHTSWlywAFHv14Vbs7xiosAyqUhlaQygvnHN1kB9U4SFqmCnknHnKFc3MIbOB0HrFU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS7P286MB6521.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:433::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.14; Wed, 18 Feb
 2026 15:14:23 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9632.010; Wed, 18 Feb 2026
 15:14:22 +0000
Date: Thu, 19 Feb 2026 00:14:21 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com, 
	kwilczynski@kernel.org, kishon@kernel.org, bhelgaas@google.com, ntb@lists.linux.dev, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: endpoint: pci-epf-vntb: Use array_index_nospec() on
 mws_size[] access
Message-ID: <xhtf2c4guarsgi74bieelah6zeyhfzt7l6fryi7yuq7lplhac6@q3harp75htlw>
References: <20260105075606.1253697-1-den@valinux.co.jp>
 <n7griejk7mlutc5mdi6b3ysedn2dgcius43urhxnfohjeo32fc@d5gymxxhrutw>
 <zyaurygtzi4qapq3n4lfcae7uahqumvdni5ojwcexpx2rbmbde@rzol5arwg7l2>
 <5k5u7q52fjizewleteru2tz7g7yqyq4ycik66aenw3xrdpo6ea@jm5mfjb44bre>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5k5u7q52fjizewleteru2tz7g7yqyq4ycik66aenw3xrdpo6ea@jm5mfjb44bre>
X-ClientProxiedBy: TYCP301CA0027.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:381::9) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS7P286MB6521:EE_
X-MS-Office365-Filtering-Correlation-Id: c1e1c269-961d-4530-415d-08de6f00654a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dHVzRTBkcGxqSFZ2dUVyQ0hLQm5HbFhRMjhNemRzUytTWFFOQkljTE12cEpw?=
 =?utf-8?B?NnIrTURyNURlYXQ0blR1TlhpSHIyMzZCbnBmRDZtcXBiSVgyZm9jSFNVYTJK?=
 =?utf-8?B?dEhiMHIyMWVJeUxtdTA0cjhjYU5ZR2hHZjlsa0g0Z3FhV2MyNEFFUU1TNWMv?=
 =?utf-8?B?dUFGZ216akpxSUlMTWl1RHVVOEY1M3dNQXNzNTdTWEFpeGlFNHpLMFI1V0VG?=
 =?utf-8?B?SFFGYWRkRUJyaHgyZUpLU3lWbFpKUXZOTndzZ2VLMkFUZUwvektYUllQN0R5?=
 =?utf-8?B?bFZSTUtWeDNlclhQVHpGUFlJRnVFTmhsWFMzZHFqbERnQk1DcVhNbHl3VVNu?=
 =?utf-8?B?a1BObWNQekk1N3h3allNTTlmL096L2JZN1dJR1NIV0dkK21VN3dwb0Q4SEdj?=
 =?utf-8?B?YS9nRS8wTTlBYnBNSVVBMkdVSmpNWHFDZDllcFZEWG5yVHNwM0UxNGw0Sjll?=
 =?utf-8?B?VVBBUVl5cmFBS3ZLaWV6bG4yaDFQekFnQmxFZndLVnBYTHp6Vjlsa0hYMFFJ?=
 =?utf-8?B?K29wNHNBUlExQVdubXk5SVVmSkNBeEdBYVY2ZE8vNjdSeFkrb3lYSTFRVUtT?=
 =?utf-8?B?M2JSS2wwOWt0alpDL0xyMTVicDRyUUlBZmNidmE4cDFHM3pIN2c2eUxFVzBQ?=
 =?utf-8?B?dkkyd0N5RHVEdWEwemRReG1NNVZDOWd4TTh1MUcxRG9HT3RkS3dlY1ZLdnBP?=
 =?utf-8?B?RWlWSkZrczVORHRpQ281UXVtOGI0SVJQcURVOUJZbnV0WGNZVmpvdjI3VEZo?=
 =?utf-8?B?eTdtZUJvV1JCNXBDUkhTOHlWYlozcG5ucmdSMFovbmtVU0M1TWJXY0gvRGhZ?=
 =?utf-8?B?RTNlUWFONHhNaUFhdTZxczl2Qk5zaEtyc1ZuK2lNTzljbEN2SXI5anBiajho?=
 =?utf-8?B?bzZXWlZyVjY3OGc3WHpncUdtamlybEx0K3ZSOWQraWc1L3pSZlpPSGozM2RD?=
 =?utf-8?B?VlliNVpuc1FzN3V4Uk9tdWNxazdVTGRkRVVkWkFPNFdRU2dTNURCTUNMSW5u?=
 =?utf-8?B?eXpjZlB3ZkdBVU9nU0s1cVZ3d3V1Sk9CZVozNHNBaFRheEZjQWN6NGowS2Mz?=
 =?utf-8?B?RlJKNGhtNjE4bzhobzJNOHRpOElRNVF1WDRXdk1tbjFXZ0lxRVdoM1VEbHJE?=
 =?utf-8?B?TE52dHN0aTBNVnppKzFpV240MENqVGVnQ253b09zT2ZBc2xBK24yY0ZIZS81?=
 =?utf-8?B?eTFXd3h3bEdTcnVKeTNkV3pGZTZkdXMzaUJCUGEwWXRKbTV1Q2xQMmlSWnJk?=
 =?utf-8?B?OHlGRXh0QUVIdi9VbC9tSzViV21LOUxvblV5Qjh2SzRyOTkxOFM0R203NFg1?=
 =?utf-8?B?bGJBbkxlMWc1anVBVWw3VU5LVUlGb1NtZjE2cy80aVJ2bzM0U2RQLzByL215?=
 =?utf-8?B?eEFDbmhHQzBJb1Z3QXM4WmhUVlU2Ky9iWW92djBSdjcxbnJWQVpEeW9heVZJ?=
 =?utf-8?B?LzRZZDlEZzRFQVYzOCtFTnltTnU5Y2FxMWFDalBsaGJob1RhWjZJNklyTVpw?=
 =?utf-8?B?UEhTTUU3OGpWRTgxZFpNMk1LNkZORjIzdEtwVFgxd1cwam8rbnNsQjZZTC8w?=
 =?utf-8?B?TEpRWDlibG1ZNVRKNjByYTNXY2xCdjFqZVBiYkVtK2piY0kyend3c21UNGdp?=
 =?utf-8?B?Ym9wcllpeUFzQjFDOTBEVUNvNGlreEQ2bTZ1U01pbmRFVUdQQVlNZVZTMEZq?=
 =?utf-8?B?c2NuUEFCMlNpRjNyMncwU0ZjNSt1Q2NTekhjNS9QNlhzclJPNjlBcG5zclhy?=
 =?utf-8?B?bVcxR0g1UDZVZkpFSHNlcGhqdUhJeXhYWXdodlVobmtEaXlFdklMcVN3VnJp?=
 =?utf-8?B?dWZleDdPT1VnYXJScVhNSG84Tk54SnYzVTlPTUZWWnNPZm96eWMybDc3L0lp?=
 =?utf-8?B?NHdOOXhUSHZDU2VtMFhkcXBSbkdVTUk5SmFyRVhCM1ZKNU5JSFBVVnplM01G?=
 =?utf-8?B?eFgrZ0dVMHY2QVFkbXZnK0IraTBsTkNHTTNMdkJKZGxRTHhSamo5NGdtbC9V?=
 =?utf-8?B?bzhHa2h6QkpONW9EeXlIL2ZTa1hVSDRVZU1lRG1YcXNMMlBXWVFMUVZ4R2lE?=
 =?utf-8?B?QUI1ZlRHOUIvUlc5R0xUaVltNWJFeDJWVzBMN2dreUpYcHdXN1FTeTNjK0xs?=
 =?utf-8?Q?IdyQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(10070799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VWlETFF5Q3J4WGpjNlE3RHcyd1pyK0U2M1FNTGVmeWptQnhVS2ZsQkU4bHBE?=
 =?utf-8?B?b1k4VUVtdmF0RnVwVmhQVjNkRmcwdC9ya1NNTFpCeElLQUF3dXAvb0xlcGd6?=
 =?utf-8?B?V25xdDlUbEpaRU5rNnFldDhJbk01NkNMVDR3S3lkOFdwWTVrY01IeFdWWmNN?=
 =?utf-8?B?aVc3VjdUWVQvUFYwOC9aa3hUcmZFak45bitFMWlWNU4reUxJRzBES1pUbTBi?=
 =?utf-8?B?OUZBT2Y5WE9ySmVYckdFVzNLblJhOTlscklZTUJyaEF0Z1YyQVZORk9DOUgw?=
 =?utf-8?B?WlRCNUNZZHNLaVZqRVVIaXB2OGdqd0pnSTZ5QjVtQXVNRWJRVGtma2ZIUHZi?=
 =?utf-8?B?UXRmTlhKckNDK3BuRExteHlSVVhUWDNXbGhJdXVHRGtFdjFlZ1MxWU4zQjhK?=
 =?utf-8?B?RGhtd212d20vTlJsNFR5TmZqNXlNZGxlclpaa0xJN05rWXVWcEZPaFJuQ3pP?=
 =?utf-8?B?Z1Z5dFM4cVhxbTVuZEZDMGx5eUVJbHhEdWRSbkw1VS9qQVhBRFh4ei9ZRUR1?=
 =?utf-8?B?aGtZV3BubjgvOFp0UVNxNTNHWkNKU3hPQWxtaGVPaHhjZGowU090dUFzZUEx?=
 =?utf-8?B?RXpndTQ1cDJTUFlLcE9jWE0vcllTNW51VkJES3JzWVZQdlduVDNrR2U3VHdO?=
 =?utf-8?B?Z0dMcTZSWENETXcxWFRnbThvZ2R5aC96Q2xqUUVRcXp5R09wVzRQUFJNUnBJ?=
 =?utf-8?B?S3d1NVZZL2pYc0g1YTBNcmQ1b1VGcllVRWxwYUlOb2xvM3d0VU1nem5YdDZX?=
 =?utf-8?B?YTBiemY0SFE0d2R3czJ6WXhIakFuWm1tYitkdm9WcU1tR0tPZjl6bTd1dEc3?=
 =?utf-8?B?YURzeGNOZEJ1TUFwcWtpVS81d21ucnpvaEpsb0xqbi93Sml0VlV4QlFEV0VP?=
 =?utf-8?B?KytFOEdjNGZzY1ZJRlh6MGRoSE1MSWUzZFFpZW1ka1pnRmhCeVBJREdNckdB?=
 =?utf-8?B?Rk8xMmRpU2xiVityZENMN21GeEVLNWtyT1pkelRGakV0MjE4ZFRHbG9nbUhW?=
 =?utf-8?B?Y0RTNEZOWDJUVUZjOE9IdkpSeGtkekNtT2t0NDFPcEQ3SUh5VWpOd0ZpSWM2?=
 =?utf-8?B?a0NUTzJUUS8ybzQ5cGp1UWNnVHlpTlp5a1BEZ0FuV3ZwYnh2Zk82eEU4VXlB?=
 =?utf-8?B?MFd4eFY1YldDYnZDdnFYT3VBTCtFR2plV3c4Syt3QVNBckwyNDVJOUFaYXpw?=
 =?utf-8?B?akdEL2ZGSXNmRHZGQnpYUE4yT0tBNFJ3a05MbU54UEVZOWtmQjBRZ1kzcHpS?=
 =?utf-8?B?ZUM3c2lMRkR1aEdKNXpJRUxXOW5leHh0aisrTklHQldmT0tQeTBIOG02NTdB?=
 =?utf-8?B?VXpKUDdtNHlxTDRRbm12dW5tSWRoYnltRStoamxtK1BPZWE2ZnpkZytyajR1?=
 =?utf-8?B?dXBFTnBybTd0eEZCU2dTSjFNd0lXRDVhVWViSE1paTAwdDgrUUtOS2p5ejNP?=
 =?utf-8?B?dFRYMmFIS3U3UUx5emdjbzR1ZWtQVWxFSnU3bnlyUnNCTXE4Sm15SnlOY1pO?=
 =?utf-8?B?WlZyc1BQUlhseG8zZmRGZHpKTmFHVkJYN2p2bUpESWJnVUtpNm1QVzJKMUpH?=
 =?utf-8?B?Qk9GakMxQVhidWhsaXM5MTZKQ2ZJVmgvaThtcm5PM1YxaHF3T1QxZFlNcitQ?=
 =?utf-8?B?S3J4TFBkQUFINmRoMDVPUkE2WFhYOFZqZEJGcUFzUkpzL0dDTW5ENUM2VjAv?=
 =?utf-8?B?QmtUZzZTRWZ5aHRrNWlBbmUxbUpWQTlsM1lHK0VSekRzRENHYjgzd2N3Z3pY?=
 =?utf-8?B?dFVuTlIySUJlSE9qb09qSWFpYTJKQmErQzVnenIxVVI4Y0dsWncwSXdjRXlU?=
 =?utf-8?B?bkVSTUN3MVNQa2V3a3F2RjVnd1BYeHpMdUJEQnZXZTVYUi81R0duVUJETHJy?=
 =?utf-8?B?TU1kVW5RKzU4dFM2RTJBelVVSWY1QlZJcyt2WGlNQnRUUEpQbVJ1Tm1qMFhs?=
 =?utf-8?B?cHFrRlBrenV2aU9TY3VIN2dYV2RDTG1ya2tDdTVVNWpYNXd0US81NUJJN2Fr?=
 =?utf-8?B?YUVFbWdtWDdrMDNaczA2QWVuQjVwSTNHVGRJYzhuZUI0aDRFOGhTZVFQeEFX?=
 =?utf-8?B?VVNYNnNxY1c4RVhvM3BuVlF3NHNjbkduNXYrekMvbWRCVGdxUmZIaUZzWWx5?=
 =?utf-8?B?U0pkdk94b0EyclZwcUwzcTNLY1htc0JRSEYvcE1ZdlM2WWdPeFgvNUovb2RS?=
 =?utf-8?B?V0RSRy9xWllrZTRPVlRsYitlUDRnclM1SGJDYldPK0k5MzNzb3U5Q1ptR0Fq?=
 =?utf-8?B?OHM3VTRtdElyK0FTbGVTZzRvUFlwZkc1TEdCMHMyRm9kdWZweEdINGF2bmNz?=
 =?utf-8?B?dkNYSHp4b3hjWW9XRTFnclpRQVpURmhNMzRKb0UzSTdMc0dyamZTWFBweVQ0?=
 =?utf-8?Q?bbESxazi57gDZeZQyigUhzQCkCMuurIJTuzl5?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: c1e1c269-961d-4530-415d-08de6f00654a
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2026 15:14:22.3886
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FB+7Ztf9oyy8s0x1FhXIsGkwvgNg0mTcor+rPo9bTL0VLhOz3HSZIn8ZKcUugQ2A412VXz4vQWTgCu10dZuKWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7P286MB6521

On Wed, Feb 18, 2026 at 07:31:44PM +0530, Manivannan Sadhasivam wrote:
> On Wed, Feb 18, 2026 at 01:47:33PM +0900, Koichiro Den wrote:
> > On Tue, Feb 17, 2026 at 07:20:23PM +0530, Manivannan Sadhasivam wrote:
> > > On Mon, Jan 05, 2026 at 04:56:06PM +0900, Koichiro Den wrote:
> > > > Follow common kernel idioms for indices derived from configfs attributes
> > > > and suppress Smatch warnings:
> > > > 
> > > >   epf_ntb_mw1_show() warn: potential spectre issue 'ntb->mws_size' [r]
> > > >   epf_ntb_mw1_store() warn: potential spectre issue 'ntb->mws_size' [w]
> > > > 
> > > > Also fix the error message for out-of-range MW indices and %lld format
> > > > for unsigned values.
> > > > 
> > > > Reviewed-by: Frank Li <Frank.Li@nxp.com>
> > > > Signed-off-by: Koichiro Den <den@valinux.co.jp>
> > > > ---
> > > > Base: https://github.com/jonmason/ntb/commit/68113d260674 (ntb-next)
> > > > This is a spin-off patch from the following series:
> > > > https://lore.kernel.org/all/20251217151609.3162665-2-den@valinux.co.jp/
> > > > 
> > > >  drivers/pci/endpoint/functions/pci-epf-vntb.c | 24 +++++++++++--------
> > > >  1 file changed, 14 insertions(+), 10 deletions(-)
> > > > 
> > > > diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > > > index 83e9ab10f9c4..192dd4f4de8d 100644
> > > > --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > > > +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > > > @@ -876,17 +876,19 @@ static ssize_t epf_ntb_##_name##_show(struct config_item *item,		\
> > > >  	struct config_group *group = to_config_group(item);		\
> > > >  	struct epf_ntb *ntb = to_epf_ntb(group);			\
> > > >  	struct device *dev = &ntb->epf->dev;				\
> > > > -	int win_no;							\
> > > > +	int win_no, idx;						\
> > > >  									\
> > > >  	if (sscanf(#_name, "mw%d", &win_no) != 1)			\
> > > >  		return -EINVAL;						\
> > > >  									\
> > > > -	if (win_no <= 0 || win_no > ntb->num_mws) {			\
> > > > -		dev_err(dev, "Invalid num_nws: %d value\n", ntb->num_mws); \
> > > > +	idx = win_no - 1;						\
> > > > +	if (idx < 0 || idx >= ntb->num_mws) {				\
> > > > +		dev_err(dev, "MW%d out of range (num_mws=%d)\n",	\
> > > > +			win_no, ntb->num_mws);				\
> > > >  		return -EINVAL;						\
> > > 
> > > This should be -ERANGE, but in a separate patch.
> > > 
> > > >  	}								\
> > > > -									\
> > > > -	return sprintf(page, "%lld\n", ntb->mws_size[win_no - 1]);	\
> > > > +	idx = array_index_nospec(idx, ntb->num_mws);			\
> > > > +	return sprintf(page, "%llu\n", ntb->mws_size[idx]);		\
> > > >  }
> > > >  
> > > >  #define EPF_NTB_MW_W(_name)						\
> > > > @@ -896,7 +898,7 @@ static ssize_t epf_ntb_##_name##_store(struct config_item *item,	\
> > > >  	struct config_group *group = to_config_group(item);		\
> > > >  	struct epf_ntb *ntb = to_epf_ntb(group);			\
> > > >  	struct device *dev = &ntb->epf->dev;				\
> > > > -	int win_no;							\
> > > > +	int win_no, idx;						\
> > > >  	u64 val;							\
> > > >  	int ret;							\
> > > >  									\
> > > > @@ -907,12 +909,14 @@ static ssize_t epf_ntb_##_name##_store(struct config_item *item,	\
> > > >  	if (sscanf(#_name, "mw%d", &win_no) != 1)			\
> > > >  		return -EINVAL;						\
> > > >  									\
> > > > -	if (win_no <= 0 || win_no > ntb->num_mws) {			\
> > > > -		dev_err(dev, "Invalid num_nws: %d value\n", ntb->num_mws); \
> > > > +	idx = win_no - 1;						\
> > > > +	if (idx < 0 || idx >= ntb->num_mws) {				\
> > > > +		dev_err(dev, "MW%d out of range (num_mws=%d)\n",	\
> > > > +			win_no, ntb->num_mws);				\
> > > >  		return -EINVAL;						\
> > > 
> > > Same here.
> > > 
> > > - Mani
> > 
> > Thanks for the comment. I will send a separate patch for that.
> > 
> > Before doing so, I have a quick question regarding the routing of pci-epf-vntb
> > patches.
> > 
> > Commit e4fe2a2fc423 ("MAINTAINERS: add PCI Endpoint NTB drivers to NTB files")
> > places pci-epf-vntb under the NTB subsystem. However, I'm not entirely sure
> > which tree (NTB or PCI EP) is expected to take changes to pci-epf-vntb.
> > 
> > Should updates be based on the NTB tree or the PCI EP tree?
> 
> There is no specific entry for the VNTB driver and we usually pick this driver
> patches through the PCI tree. Initially this driver patches went through NTB
> tree, but that got changed long back.

Thanks for the clarification.

Understood. I'll make sure to CC both Mani and Krzysztof explicitly for future
pci-epf-vntb related patches (e.g. the thread below).
https://lore.kernel.org/linux-pci/aqxjlfdqincb4yszn3ngjzvyiuybeoo2pyno4t2iz6ant337n4@bz37hl5nofzy/

Best regards,
Koichiro

> 
> > Sorry if this has already been clarified and I just overlooked it.
> > 
> 
> No worries.
> 
> - Mani
> 
> -- 
> மணிவண்ணன் சதாசிவம்
