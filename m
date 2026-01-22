Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020086.outbound.protection.outlook.com [52.101.228.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 817FC35A953;
	Thu, 22 Jan 2026 01:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769046758; cv=fail; b=dcKlk0ZGHDrwWpmXH3hGKUqo41PYBKWY+6XrbLvLocFr3jONdvwie93H8ixivLpKUfOHvyijVm34R30qBAEAf9j2vH/IdjHCMcJMEcshSRVegcMelWh/fUNxVAGeXz8oVHlUNwkqL5TUQ77UIbhGo6dGIyb8lOMJoZIX9DUi+6Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769046758; c=relaxed/simple;
	bh=mcllWZbgflzceVq1IFKGgBN7PN4jZt070zYM1vNl2sY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dl6dvG0tkY/h6eJ+WkZsEebWd4rFhueMD9ACL/D2wuk3rPUNwwRyRGSRR44yqQGEyAu/00jS920Bj/hEE3NwYwVHJ9a7gpOaxPTNFNozH7Dg63g9/DH2OFGdFfGrsnD8IY9KkHetguQKsa9acrggUoYWCXMuB2LeyMeeNhRxVVo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=T64d7G+1; arc=fail smtp.client-ip=52.101.228.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="T64d7G+1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NWjF+gxm50rxr43OeLlQV18+cfCkDfflM12ZGvbCZSQoyuMXJFfrWkqtGZKx7wXwDomUJHnDxs6OLK9EgE8etkA9rz/nh76Np3CtHZyM0d3afi7Ym7MeV8IJaeLyWS92xH92hzGTr5rvYf0xWjRZJmxX3xuj6qRROh46PDHelhMRqXbYNjTwJuflv3p6/cgxI3t+gP6geEEDbmKwEa3fszpg9IIrSdcCAXfKC4VzDC5et/xjDZeYc9Oh8ZWsm4dFnqoq70e24QblHkP5AkzLLNtVWH1LlSxEJ8SQipKZgngf9brQPJfchiX+jbn0arXC5snYkYh8nP1CS6V2164B0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w1zjde6ZxMiCZXJ/arRSZXpjKlVVYeiUTi7JNmFmNUs=;
 b=qX2fzakuzqOWstT++sxdtr3+WflIFBOQOc/OQuI8yH+00zXKU36hz09IEyeYij/TEhn2fpWYKxFvXEgfHjEkBOqKaYl+X9gWzBqFOLotumDvldGjvAwBYq1PAEhtpd+REZfi2mt6LEuBiBj7dL4pE7EFWwRR6/6yC/JWnnZGswooOy9uFZdHFwes905ZsPV0lXGvQ/PvFsq3OBSgJHO+5f4wuywkOWwxkO9NIxERsOsboYie4xcB1mCglzAq8o1ItnU68JhXKzvKBe2NFbSX7thCm9syn48PlcgLFBzC0HMc02FGiZAZu3tElqu5Hnopx2Drpiv3q3Te5fP4sI/VAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w1zjde6ZxMiCZXJ/arRSZXpjKlVVYeiUTi7JNmFmNUs=;
 b=T64d7G+15y+bCwkDSqjuogfEoFm/T0uoN2xaJcRMU24xdcBk29Wui+N1GKZE4bnKUxc9AkXlVSXMHWDGrPZYVMFuyv9erUcwovvp2Ypxs1uKJI+mk/VMfFw2bM9Znmr8xr+JDLAk+1XhHpzMes3kn93rmrp/O6+6ppn0eoata/I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYCP286MB3798.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:37b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.10; Thu, 22 Jan
 2026 01:52:33 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9542.009; Thu, 22 Jan 2026
 01:52:32 +0000
Date: Thu, 22 Jan 2026 10:52:31 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: bhelgaas@google.com, kwilczynski@kernel.org, cassel@kernel.org, 
	frank.li@nxp.com, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 0/5] PCI: endpoint: BAR subrange mapping support
Message-ID: <waapztvy6jyjqtfcoo3rbgvagi4z3p5afw6x2acgf5bxatcui6@nkodhtqqtetr>
References: <20260115084928.55701-1-den@valinux.co.jp>
 <x64g63zkz5t75vxxlzd7rhbvpus2mmhz2phyvxykuax5wm5cnh@zgpomauf75pv>
 <ugxohcm4tvtjwnhkkz7jw226upm7o5hihohzn2f4eoamhkd77v@mjefdgxneghm>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ugxohcm4tvtjwnhkkz7jw226upm7o5hihohzn2f4eoamhkd77v@mjefdgxneghm>
X-ClientProxiedBy: TYCP286CA0225.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c5::13) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYCP286MB3798:EE_
X-MS-Office365-Filtering-Correlation-Id: fb7d721e-7dfa-4b88-5a97-08de5958e887
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|10070799003|366016|27256017;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dEJyUnNsdkdzenhGcmpqbUM3ZGE5MzVaYUVxTlpyK3JrQVdQbjFjSGw5MHZm?=
 =?utf-8?B?bWJ2aEx3MkNlL29ML0dIQ2Z2NldDN2oxR1V2TnVmckRiNlJLTGh1T1h0V3NK?=
 =?utf-8?B?bHRjM2Z1RitxclFoWlNVZEZ4ZmNvaWhJSnNacVNRN0xNc3d0R2JhektBY29w?=
 =?utf-8?B?eE1vQ0gvL09JcHM4UE5CM1ZrL2E4VWhhNGk0bmQ5MG1XTGZURkE4ZkhBakdp?=
 =?utf-8?B?MktFYjJoZFhadWR5VFpXY1hPNXVCQUtzVlNWUkhKc0xsTXlIK3dsdWxOMjVP?=
 =?utf-8?B?NmJLTmxJT05hbTMrUm00L0o3TXg5b0hwa3c5eUJkNGFIUmpyNENNMExYQllx?=
 =?utf-8?B?SmNJRDRBejA1WjE4cCtMK2JzeGpxZXhSNkJFUnhOd3NHSFZCMDBFMG03WDJl?=
 =?utf-8?B?azNQL2dlVnpGd3NTRlErSjRValdNUGN1SXlKYlFGbFlMbWRHcUNNbTF3OUVo?=
 =?utf-8?B?N2tiVHZlbGJqUVJYQnFZNzRISDdTbnJpeHJzbmp0Nnc2UFNBWmNRNE80RUtY?=
 =?utf-8?B?M3lYYjFXakExYi9FcTc4dDdtVEp2YXhlNG4yeUFpM3hNM3pFQWQwQ2R4Q29n?=
 =?utf-8?B?WWhtZGROSkRUekh4WXpPbElrL3NnK0N2enF2K0Y1aFN4NjhUV2w1YW83Ly9j?=
 =?utf-8?B?SGdUaDNyZkxaMkdGZk5IOWU1bENiaGU5Mm9EWDdnamh0UzJ5Z3lEenFEc1E1?=
 =?utf-8?B?NUtNNzdEVithZHRLMmp0QjBlWFVlT1dBZmJjcGMxWmkwdk1jbzFQekpRNk1l?=
 =?utf-8?B?U2JZdUZrVVpURjFNVkt1eXRackhVMDNQeGZ1ZlBjcnFwSEY2WkNHZUliV2NZ?=
 =?utf-8?B?MHptdEpFL0VkanlFZjhydEx5dDBlUGpyTC8xRzUrT0xnc0hoSENYemhlWTlV?=
 =?utf-8?B?K2VqLy9LNE9qb25RV3JuS1pGeisvQXE1TzdYMWxHaXZwcVBQWGxzYW5BSlli?=
 =?utf-8?B?QkRBT3U4MnhWRTBnNzd4ZUNGejdXSFdhbHFvbHdEUzBQV01tZjJkVmp5RkF2?=
 =?utf-8?B?QUgydnZJVmk3L2FSMTNhdDZ6ZFo4Vm13NHlRS1Vka3JiRXZXNUJBRkQzZko4?=
 =?utf-8?B?bDZhM0RzMnBpVTYycTl4U1RVN1hDcWNIRjdTNnZlaXJGZ0IwMy92aWxmN2hp?=
 =?utf-8?B?a1daMzhRRUdWL1ZqRTZybDBkNGF0aFdPMnAvVktYeWlPenlDd2xhaGMzWGVB?=
 =?utf-8?B?TkJheGF5QXV6bjZDRUV6YlhKQzFBcFNUdVNkK2RRbzBTeW44T1YrNmtTazZW?=
 =?utf-8?B?WG1wZDNhWitnNSsxRklmM0drYktGa1lZNFlFZ1YxczRsa0pvejFEM29mcU5v?=
 =?utf-8?B?RUNEbTk3MW5ZcE1KUFhIL3p3dGdpNWVqYUwzcVJGQ1hUbzRlNDdSK20va0pE?=
 =?utf-8?B?SzBVeFFhNjhRRzZsL243U2h6TFFpVG0wdXBNa2ZVMWh3T0NHY3M5cmFWL2Iv?=
 =?utf-8?B?eWliWEErNDBvZk0rbDl4U2pndUFmaS82U2xzenZMZ2k3cmUxaGplc1dycEdO?=
 =?utf-8?B?TElOcjRlKzYyQTYxS3RTdGplOWEwWFNvRlh6TzlTNkZweERGOHFXVm1DaDBD?=
 =?utf-8?B?RUNqRStQMmQrS3pTRncrRWFjenhTVWZ0dm5xaWZ6TEFwcUJsN2t5WTBzN05X?=
 =?utf-8?B?bXFCOFF2ZWQ0elFJeWNmZWZRWC9HNGtDL09pRUhEUmhHWjV3MitMdTlJY21Q?=
 =?utf-8?B?V3pqR09xK0dUNjNxQlRTcTFEUEtpYkFJbEtJSC9GSXA4MHl2QSs1VCtXOGVD?=
 =?utf-8?B?cU1CUGRnNkVSQ0JFY09VZkZ6NEZ6cjhNVmhxR0lvYThpMEV5Y2ViOHFvdXFp?=
 =?utf-8?B?UDkrSC9qbml6dWN2SklqME8rOGhNVmRjY0lYZG1RVStLcnd5RUtPeHE1Nm1S?=
 =?utf-8?B?RUNxWmUrWWF3ektpWGRyZG80b0VwdkcreElNdkRwZnN1VzhqRlpzOVBINzRY?=
 =?utf-8?B?bXdZTFAvSjQ0M09Id1A3dGhyTkF1eXZqc0NoUzRMSXVtUFl6eHdtbGZUd3hN?=
 =?utf-8?B?aGRqMDhpeXVZaUpScHNMdmxweUxnQ3dMajVUaEFsV3IxSTlucGswdWJnemJu?=
 =?utf-8?B?RGwzY0tvSlJ5Wks3SnRpNndXcXErNlB2amQ2UzVCSTJadUp3L3ZDR0JsSjlW?=
 =?utf-8?B?cVhFL0ZRTy9jSlpzTlU1WjRzQ0VmZVlHTXFubUk2R0NaK3Rxd3NYSzBZOEkx?=
 =?utf-8?Q?wvWD69e5LWsBVSVnkzz6cKE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(10070799003)(366016)(27256017);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dkJGOUcrOXFobEdhRkx1TDhXZzFLVlNHNEMyUUJVSDVlNXllaWcwSFVPb2Fy?=
 =?utf-8?B?aS93SUFodFYzQzlwd2xiajZSdXRPSDFwM3FRdjJ2ZHMvTFZTdThXRStjWkkr?=
 =?utf-8?B?OXYzbDZyaVNMQ0dvV2NFVWVnZ2ZqSlhEbWVpWjVsTUdhTWVwRGpMZHc0NVRw?=
 =?utf-8?B?R1JkNlBWV1MzVEZuVkxkUG53U2huaGYrR1VIeERlL2lNZ05Bd2M4dHpsN3RJ?=
 =?utf-8?B?RFFhZjdOSitkU3FnVWd4MXppUkx3NDFLYWFnNW9qY2tvZkowOFpNTkx5Q2pD?=
 =?utf-8?B?SnEwMHNpSE5jajdhS2FmU2c4Q202RG1aTEhTaHZOWUdEV3lJa1k5anRmQTNP?=
 =?utf-8?B?SEQwTTBSbTVKcUN3VTdkTUtSVHFQbGtod0p5TUorUDQwYXBodVZBM1hsT0p6?=
 =?utf-8?B?SGpBVE56TG9iWEdOY2N2RityMFJVRHk0TEc5Q0pHbnUwekV5N2NWbEdzSXRL?=
 =?utf-8?B?TjN5YzEyWU8rYzE5S3V1SXRDdVNyUnI0R1lFY3lpNDFVKzlBL2I5RGNuMEQ0?=
 =?utf-8?B?Z05pU01sZDEyZlpaZmllN1JlZG1LLzk5a3E1dTJoRmY0eUFCaE5td0VCWGhW?=
 =?utf-8?B?dk1nR09rN0RJUnJYckYyR09wVXdrbkQ0d3BBSytVUys3ZFFWdkhXU1FZNUNG?=
 =?utf-8?B?OXZCTjEzZWRRYjdkdC8yYlM4a0p5WVBwLzNScWZGWXNETWY0cU9aY2FSVmd2?=
 =?utf-8?B?L3JmK09KOWg3OXJrWVFsb3FRZnlYdWZKL29QTzljSXVseHQzcS9tUDdySUZ5?=
 =?utf-8?B?ZGJtR09EdWxmOGRSeDRlN0NqVzJLbnlwWVhaNFFzUzRDNGRsQmtHRWM4OCtF?=
 =?utf-8?B?bXk0dk5pL0R0Qng0WCtkVmJSZThSK2hSZkRpdmQ5NmNDQkF6L3ZxRUNsSWFD?=
 =?utf-8?B?ZWxWTmtYVGViS0RJK1E5bUFma1VTR3FqUUxiamVrNkNEWEJ6NW52UHBUOU5q?=
 =?utf-8?B?bi9sR1pQWk5udVBERlhTVWp0WXlXelpISjBtTzJZSGx0MThHdFdlY0JZckM5?=
 =?utf-8?B?VmpWL09tRFluTVBGU0pDNUs4eExvQ2d1UVQ1Z0lObldCNTlJTTZkMnVvTnda?=
 =?utf-8?B?VzNwYlJJZHhicWUyWFAybEJiT01WNzByYklsemg5M0NUdVVmZG5ib0I1alJN?=
 =?utf-8?B?MXQ2K01GSVRqb3UwZGpSbWV0OGtQUy9sYU5PQ2R1ek1yNm9iZGs3Zjd6NXE5?=
 =?utf-8?B?Zk1vdGVoV1RPbW03VTZsY0Zqd0Z0MFdLd1gzYTdPc3FJamdya0pSbTgxRHZw?=
 =?utf-8?B?VFh2Y29qdUFyWTNySGlMdVgwZ01YS0FrdzVUdWh0TE5jTTh0bGI3Szh3L0pL?=
 =?utf-8?B?TGpuTy80UDV0OEFPYzBWMGRlUi9oZ3JSTUFNTGFVUU80bGpTYlpERUQySmtC?=
 =?utf-8?B?ZlJxK0VjZVRUWG4rR0crVnBQNlN1dld2Z2IrSnF3T3NSUXJGSjVORzBVUFRm?=
 =?utf-8?B?OWFUcmZsSEF3MzRMQTM4T1hZZ1hFeEVldE13TmQrNmttQkNPckpocmlWYUFu?=
 =?utf-8?B?ZXNCbkNBR2tBRG1WNWcrdCtlUzFFYllEZk15Mk1raFgrNjFicHdwSTA5ejlH?=
 =?utf-8?B?dnp2WlhqT1NPN3RzLzljYWlIZkhMc3NqQUJLZlJibGx5OTNib3B1MnYreGdK?=
 =?utf-8?B?ZW9JRnpUaVF5V3NmcWdvQ3dsMkhHcmRqWnpyME80am02b3B1K25RdGFWdGxq?=
 =?utf-8?B?bGJKZFBobjhDYTliL0lNS04xTlFiV3B4SDBadTlFdGx6ZDN0MU5HT3NXQ1lK?=
 =?utf-8?B?L3J1eTJyMWM0SDdzY3ZUMDlYTXNjNWt5OGU1a0s1bkhxZHVsaFhhQzlvN3hJ?=
 =?utf-8?B?YmxwMGtSOXo4UTZBZHEvVGwycm5KZjZHZ2dNVTdSMmJQOFVFMEVCVzM5QjVF?=
 =?utf-8?B?ZUlxbTEzd0ZlaGErK3VISk11bDN4MkFteDVTQ3p5M0FkMGt4ZVVFa0pGdjgx?=
 =?utf-8?B?UWJNVmpWK0FiKzdvRUtzOWJoZjg5NjFIVE9wZzloNjhvbDdhRUZib1FkVE5B?=
 =?utf-8?B?dDZjMFNIaUUyUGdJVkNmdWVmTkk0dVB0L1c1T3dESEpHSENDUWNRRG04bXJv?=
 =?utf-8?B?WjlzRThmV1JibHJwUU14VE1RT1ZJQlJsQXpzVmEzMG9YTjVSMWNIVURZQjdk?=
 =?utf-8?B?emVyTE5ScVU1VzFLdGpJK2s3bjU1M2pqaXdZZ0ZxYk1XTGFTR3ZGQkwrMjMz?=
 =?utf-8?B?N21vTEltS2s5ZzhvTE1YUkpNTW5FMHlGR2dPTGpvNlNZWHk0ZW5MNWJwejlp?=
 =?utf-8?B?Sml4RTkrUk5idGNBUnBTSjZ2SDFxUWkzNjZ1SVdKZERtdStmejJIS2ZtanVX?=
 =?utf-8?B?YTlhS0NTN3p5cXhVWlUrTjZHOEZZU1YwdHJOYWFoWFo0Wmd2M2lzUDFVajlF?=
 =?utf-8?Q?zlUl7hfOIqqPIuvScDbh2dql0c9Y30IYBuvyL?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: fb7d721e-7dfa-4b88-5a97-08de5958e887
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 01:52:32.7336
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: myiZtCMYoyPDNG/suREq1fd1cbyERD3LoP0ABA3ILo5ssFagtnbWLSEnkdseYCjnzHxOJ8zAims1TZaNJ4Cp5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB3798

On Wed, Jan 21, 2026 at 09:08:34PM +0530, Manivannan Sadhasivam wrote:
> On Mon, Jan 19, 2026 at 10:00:38PM +0900, Koichiro Den wrote:
> > On Thu, Jan 15, 2026 at 05:49:23PM +0900, Koichiro Den wrote:
> > > This series proposes support for mapping subranges within a PCIe endpoint
> > > BAR and enables controllers to program inbound address translation for
> > > those subranges.
> > > 
> > > - Patch 1/5 introduces dynamic_inbound_mapping feature bit. This can be
> > >   used as a safeguard to check whether a BAR can really be reconfigured
> > >   without clearing/resetting it.
> > > 
> > > - Patch 2/5 introduces generic BAR subrange mapping support in the PCI
> > >   endpoint core.
> > > 
> > > - Patch 3/5 advertises dynamic inbound mapping support via
> > >   DWC_EPC_COMMON_FEATURES for all DWC-based glue drivers.
> > > 
> > > - Patch 4/5 adds an implementation for the DesignWare PCIe endpoint
> > >   controller using Address Match Mode IB iATU. It also advertises
> > >   subrange_mapping support via DWC_EPC_COMMON_FEATURES.
> > > 
> > > - Patch 5/5 updates a documentation for pci_epc_set_bar().
> > > 
> > --(snip)--
> > > Koichiro Den (5):
> > >   PCI: endpoint: Add dynamic_inbound_mapping EPC feature
> > >   PCI: endpoint: Add BAR subrange mapping support
> > >   PCI: dwc: Advertise dynamic inbound mapping support
> > >   PCI: dwc: ep: Support BAR subrange inbound mapping via Address Match
> > >     Mode iATU
> > >   Documentation: PCI: endpoint: Clarify pci_epc_set_bar() usage
> > > 
> > >  Documentation/PCI/endpoint/pci-endpoint.rst   |  24 +++
> > >  drivers/pci/controller/dwc/pci-dra7xx.c       |   1 +
> > >  drivers/pci/controller/dwc/pci-imx6.c         |   3 +
> > >  drivers/pci/controller/dwc/pci-keystone.c     |   1 +
> > >  drivers/pci/controller/dwc/pcie-artpec6.c     |   1 +
> > >  .../pci/controller/dwc/pcie-designware-ep.c   | 203 +++++++++++++++++-
> > >  .../pci/controller/dwc/pcie-designware-plat.c |   1 +
> > >  drivers/pci/controller/dwc/pcie-designware.h  |   8 +
> > >  drivers/pci/controller/dwc/pcie-dw-rockchip.c |   2 +
> > >  drivers/pci/controller/dwc/pcie-keembay.c     |   1 +
> > >  drivers/pci/controller/dwc/pcie-qcom-ep.c     |   1 +
> > >  drivers/pci/controller/dwc/pcie-rcar-gen4.c   |   1 +
> > >  drivers/pci/controller/dwc/pcie-stm32-ep.c    |   1 +
> > >  drivers/pci/controller/dwc/pcie-tegra194.c    |   1 +
> > >  drivers/pci/controller/dwc/pcie-uniphier-ep.c |   2 +
> > >  drivers/pci/endpoint/pci-epc-core.c           |   8 +
> > >  include/linux/pci-epc.h                       |   9 +
> > >  include/linux/pci-epf.h                       |  27 +++
> > >  18 files changed, 285 insertions(+), 10 deletions(-)
> > 
> > Hi Mani, Bjorn,
> > 
> > Based on the feedback so far (thanks to Niklas and Frank), the design seems
> > to be converging. At this point, I would appreciate confirmation on the
> > following points before proceeding further.
> > 
> > 1) Does the current (v8) approach for BAR subrange inbound mapping at the
> >    EPC/core level look reasonable?
> > 

Hi Mani,

Thanks for the question.

> 
> In this series you didn't add a consumer of this subrange mapping, which I
> believe is the epf-vntb driver [1]. Even so I don't see a justification of why
> the BAR needs to be split into multiple subranges. Can you explain that?

Yes, the first consumer I have in mind is epf-vntb / remote eDMA-backed NTB
work referenced in [1].

The motivation for BAR subrange mapping is that some EP platforms
effectively have only two practically usable BARs, while needing multiple
logically independent inbound mapping.

For example, on Renesas R-Car Gen4 Spider, 64-bit BAR0 and BAR2 are the
only practically usable BARs, since BAR4 is only 256 bytes. epf-vntb
already needs two separate regions (config+spad and MW1 for the
data-plane), leaving no spare BAR. Adding ntb_msi requires yet another MW,
which simply does not fit unless an existing BAR is further divided.

In theory, some vNTB regions (e.g. config+spad and dynamically allocated
memory-backed MWs) could be tightly packed into a single physically
contiguous BAR region to barely make it work. However, it immediately makes
features mutually exclusive (e.g. ntb_msi / ntb_edma cannot coexist), and
the layout becomes extremely fragile.

Similarly, for remote eDMA-backed NTB transport, the host needs separate
inbound access to the eDMA register block and the LL regions, which are
distinct local address ranges. Without subrange mapping, the only choice is
unnatural layout (e.g. dedicating one BAR entirely to eDMA register block,
and another one to everything else that can be packed into a single locally
contiguous memory region), even when this is barely possible.

So while some cases might be made to work by aggressive packing, they are
already at the limit on platforms such as R-Car Spider. BAR subrange
mapping allows these features to be implemented in a straightforward,
loosely-coupled, and extensible way on platforms with severely constrained
BAR resources.

> 
> > 2) From a process perspective, does it make sense to continue this as a PCI
> >    endpoint subsystem-led series, with the dwc-specific changes layered on
> >    top, or would you prefer a different split or ownership?
> > 
> 
> Is is OK to have both controller driver and endpoint changes in one series.

Understood, thank you.

Koichiro

> 
> - Mani
> 
> [1] https://lore.kernel.org/linux-pci/20260118135440.1958279-14-den@valinux.co.jp
> 
> -- 
> மணிவண்ணன் சதாசிவம்
