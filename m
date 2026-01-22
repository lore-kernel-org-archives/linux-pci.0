Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011040.outbound.protection.outlook.com [52.101.52.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E7A022301;
	Thu, 22 Jan 2026 02:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769048662; cv=fail; b=WQ6xZy83ZejUm9ms7peCoCRS7/8zZrPnZdbbvKfxFfmhh+B3h7zyb6J9G+mpF91lizpBuAfMpPhHFUAfYyRd4ekv3Jmi+vsvJ0gp1cVJjqidbmxl+T6o+MFQv+9hIXxe2jqYqQcCpxgQ8Oh4xVAoHAe//6KKfzmIPZQ1wiYgBpc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769048662; c=relaxed/simple;
	bh=QLuJrL3SjuSWh0OHasjyh6fij/a/TabunhLUclBbivA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RVaYacw/UiOoQu7AX/+5NhOsm1xlKWADQ8H19navpUMmq5c3DeXHRf8RKMTBzbystKpISN9mWwoWxB4Y0ZUnsWeNFij7M2kO7OCZCJwQSQxzA5HG71627UxvGoyk5AqWGWStz5Zh4SrkxSoHKT0azKcuj8J6K8Pv4dhFFrkp3Wo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=l3R/Mrq7; arc=fail smtp.client-ip=52.101.52.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="l3R/Mrq7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b6j1tcE4XhhBfiVLNENp8UpJHaOs17ezLNtL+O2EODOwlw64LkN6fDxr8hX5DPLBmPgENrMDPUP6+eRQz3/VBeJ2fV+PTw38TBX68QCqOgFIe7EhiGm256azVGP2n87gcf1Y10aPRlvSjVVgVW4U3u8TTmLantla+u8ZS9llAl9kupUbq2toPZ4CqCp1hLApk+nh9A6yoOl1NgEA1w5Q8SezJaM9el5VypSIoDNDEiUBXfBEDFfIv8ZNmVt9AzQfVLNusPLi/eoqbMYjfOcf6lP7WABOpXIK2a/CGeV4T0Bk/c2Fm9YDTQFK9iIpXp1ANvF9L0ZzJgk+H1+gR9mkHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E9t9jcFUyu4KGp3LUqLpSNDcxZ3RBplvdO0o5FkfWLI=;
 b=o8qFQcttneey9wq0YS5c1nAfTLnMsMPjQpH+TadrvxhWIy28pNe0J+SZEkuKFnpA3nPI5bL8MUs0Zclu2wq3HGAS/5y9Bbu0Nmq4Y7e/zXU3vbUvNA4+QDTpoacK+Atgyw3/xr+ptYG/Pv/3LmZ3ngyornvNgSAvzmbXVcEIpU6qT9/YSmPPuAf0/+s1LzOf0UXd3hOp0DiXUp0C4DrfpEyFtsVmS2isWixeVy9Rsjk0eJPsSXj0/JDzLMAf277/1eKT7tBaOUtXXeSTsr35pWt8wrxKUHmUC2hrt9tN9ZKi1WSp6tZtiqNiyFGe6rRDMCQXZ+p4E0FkMapo2qNvag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E9t9jcFUyu4KGp3LUqLpSNDcxZ3RBplvdO0o5FkfWLI=;
 b=l3R/Mrq7Liqu3uLc2sNZc+0ACt/8SHv0sQ4A0g6xVq22BDxV7KkDZqBUydP9KQQUCWJ7umdwJ2xPy3/MtGl4o/9Qp5ZHONN4fFtKeplO7ZNda6PvRhcyEyJHw3MjFMKmAwHnymI47S2Nc32CTsjp33lKsR7RnT9teFGcrM0ObYy4C9qwDL1PShg8SPvHO79ydD8GRaesu6QoHoOEWQUHSiW3EtF1TGeE8QwdH8d64p5FRPQP+MbfK4C2hRVyc85kJw3hmR11l290FlY0Pumo0wVvssCya/upFgB4VZaOUX9McZQIErTDTfaPmqRKyTLxqIPT8oODxWuBE5F96PktHA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM3PR12MB9416.namprd12.prod.outlook.com (2603:10b6:0:4b::8) by
 PH0PR12MB7983.namprd12.prod.outlook.com (2603:10b6:510:28e::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.9; Thu, 22 Jan 2026 02:24:17 +0000
Received: from DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::8cdd:504c:7d2a:59c8]) by DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::8cdd:504c:7d2a:59c8%7]) with mapi id 15.20.9542.009; Thu, 22 Jan 2026
 02:24:17 +0000
Message-ID: <d0b6b17a-1521-4259-a1e1-3270af7f787f@nvidia.com>
Date: Wed, 21 Jan 2026 18:24:02 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 1/5] rust: devres: style for imports
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Zhi Wang <zhiw@nvidia.com>
Cc: rust-for-linux@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, dakr@kernel.org, aliceryhl@google.com,
 bhelgaas@google.com, kwilczynski@kernel.org, ojeda@kernel.org,
 alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net,
 bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org,
 tmgross@umich.edu, markus.probst@posteo.de, helgaas@kernel.org,
 cjia@nvidia.com, smitra@nvidia.com, ankita@nvidia.com, aniketa@nvidia.com,
 kwankhede@nvidia.com, targupta@nvidia.com, acourbot@nvidia.com,
 joelagnelf@nvidia.com, zhiwang@kernel.org, daniel.almeida@collabora.com
References: <20260119202250.870588-1-zhiw@nvidia.com>
 <20260119202250.870588-2-zhiw@nvidia.com>
 <CANiq72kL9xwT-wdyGNpekmnXioUhwLjcayE_pkmKEEw+RDCyrg@mail.gmail.com>
 <20260121112929.5497b997.zhiw@nvidia.com>
 <CANiq72kz9a=Hx_tWLpSmmQ82MzO98V8-i+91qSutJvgKU+d-kQ@mail.gmail.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <CANiq72kz9a=Hx_tWLpSmmQ82MzO98V8-i+91qSutJvgKU+d-kQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR05CA0028.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::41) To DM3PR12MB9416.namprd12.prod.outlook.com
 (2603:10b6:0:4b::8)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PR12MB9416:EE_|PH0PR12MB7983:EE_
X-MS-Office365-Filtering-Correlation-Id: f54c62f4-b6fc-4e63-3426-08de595d5760
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VWh4NUxRODUyL291NXhzalEvTkFMajMycnpBVUZ1NHZxVmZ0eFZCRTdOeGdD?=
 =?utf-8?B?dDB6Q29JMjZ0elVUaGRoUHNIcDcycTcyR2ZhSlcyeEp5QnNnMk9JaFR6aGVw?=
 =?utf-8?B?N2c1M3I2WW1JSW5LQkZ4NW92bEJ2S0JScWJzSW9rakRWMDN2dmRkb0ozMXlW?=
 =?utf-8?B?UUFtVjN4OWF2bm1mb3ptU2VaRDBlVGtOMkNiQ0R5WFUxL29NeVBFU1pac1hH?=
 =?utf-8?B?MGdCWk5yUGhMZmVHQ21VMWdHblB5NCtzdXR5MUl5aGZPbktkZXdqTmIrUENk?=
 =?utf-8?B?ODR5TmQweXRNQysybW5OaWdVZ1pOL1JkVWJleUw4RDBvRHJLZUxYdzQ3SWxt?=
 =?utf-8?B?T0FKRmFtL0tjWHIrVWZvUTBjVTFaNy9IMm9IdVVxczJ4U0t0U0pOQmpONVlu?=
 =?utf-8?B?TU5nb1hEaEFYbkFiaTMvYk8wRjIyUUVNejhlVTFYeGxwd0xwN2V1OHdraEZT?=
 =?utf-8?B?QUlWRWJJU3laM1V5YnVyQy9aY1R5T3FXRWdOdGhGc3Q1RnE4QmVuc09kKzJB?=
 =?utf-8?B?WEdVWXl3ZXQ0WjdXTHU4L1N1blRoQXZpZlRUT05XN2xWTlVOT3RNWlVDVGVm?=
 =?utf-8?B?MlNNUmJuVDhZaUNGUjFsdURCYk5HeWF5aUtHY0JMVXl2YW03Y0FaWlhWbnE5?=
 =?utf-8?B?Z3dPZ0FnNDdWTHliZUdiL0dKbFdxdGhINlJ5NCtsNk0yZVdBUnUzUDBIV3hq?=
 =?utf-8?B?UDJWVW9uV2RDVUdqYXA1bTJIdmIxR3pNbFYzYXpsWGlwVm5RczlRRVF1U3pE?=
 =?utf-8?B?REZUN3pqaHp1NDF2MjhWaVJua1pqVnhHM2czMjAveU1kMVJ0bGI0MkdRYXJW?=
 =?utf-8?B?b05GWTJ1aG5xZjRKWXoxU2gwelNOL0psR2RtTEpqaitMQW9XeVhvWXExRkx4?=
 =?utf-8?B?Y3IvR2lPODB6NXVsakFrSGR3Q1R2cnF1N1YzUkRYZElBU0JUSnZNVE5PdUFZ?=
 =?utf-8?B?ZTVJNlVEM3RrbC9IU2p6V3pQTjZrR01GeHJnQ0N5MW4wTXNqcDNVYkEzZDJP?=
 =?utf-8?B?Yk43OHpUVSt0SlpVMDZYZ01BcEczRmQybWRRbk1VNWZhaWZ0SlFMbE9nYWNH?=
 =?utf-8?B?SU5OTk1kaTVsWm91ajhsSW1STjhBblVRRVpLYmVEblVNQjIyMnYwWTlUVkht?=
 =?utf-8?B?YUNPWE4wZDgwNFgvWktLMUhUZGJubmdWQVlrcHRUWXUxdUVydlNjTHZjRVFG?=
 =?utf-8?B?eW5NK1ptRVd6UEtpYVhya3FFbWt5cG9mNXhlclVOSXcvRXkxYURvREpLME1N?=
 =?utf-8?B?aG42K29qa0JoNmdxTzc1VW1lOFQ0cXBIQkFFcHpzNVloTWVVRWhZS2gwTFVQ?=
 =?utf-8?B?OVQxVGVMTC92MkFpb0NocTNQTjBiT2ZGWllNdy9tb1dWR3dkeDljUHhSTXhx?=
 =?utf-8?B?aFA0VGo3akFSTGFZbWJJNFhzTkhxY0owbU1ESlVWN25lb2JMTlpnZE8yYlM3?=
 =?utf-8?B?MEt3eXAzZWJ6TEVOOTZxVDlBUzNxTjkyL0lMM2JXN0pMZGRUWkppOGhHN1lh?=
 =?utf-8?B?MHJ5bkthUkFLN3ZubEFVRExZdFllbUNTeERsb1lOTEMreXgvZzRscDYrZTgw?=
 =?utf-8?B?dlgvYmt5N2l5aFdjbUJCOE1KQlk3d3pwMW11b0ZEMkpWZ2tSaC80NTNKZUZM?=
 =?utf-8?B?Q1k1Y1QyL2J3d1IvL1psQVkyZkdFVHpMeFpHeHpUU0lDK0FIVy9QNEo0QjVD?=
 =?utf-8?B?MHBSTUNlWUxFS3JtTVA0eklFaG5qZnN3MjJ5TFoyR3N2SC9VS2VEUm5pUmwz?=
 =?utf-8?B?UFNjazBST20yR2FqcWYrMmE1NnFHaEJuaUQzYWZZRDhLYk1MWVc3S3M4Y29m?=
 =?utf-8?B?bGNzY3owTW9iRkhVenl3KzI1WTZCQ0VlS001eXY3OWludm94Q3NOWHU2Q0VZ?=
 =?utf-8?B?MDRINHg3clVZTjEwK0NXcVQyVnZBR1dpcndnM2pLVzQvK1dobmlzR1U2aHIw?=
 =?utf-8?B?S1J4VWdxRkNDbm5YWWYrNTVkK1NOSUQrYU1pd0ozbWtZNytnMUJaeXd3VUlB?=
 =?utf-8?B?Vjk4VHZKRmVacEVxUC9VTG9HRmN3SzJzZGxWbWlxcmxaQVl5MHlzbWZ2OXBs?=
 =?utf-8?B?NHRWcFFIRU4xekhsVUhUa2FGbE1waTlQeG5OSkd6eVlSdnJuOUgvb3hIZCtI?=
 =?utf-8?Q?Ayws=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PR12MB9416.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dkEybjdETXYrS1JzTXU4L21VeWFqZ1FLQXNUdXFRUVduSjIxcldYQldpb2o4?=
 =?utf-8?B?RFdCUlV6T01UVUpjYUR0K0k0bUdaR05iT3g4Vnd2YzR3ZWNqc2RNTDQzSS9X?=
 =?utf-8?B?RXFBZHJ4b08zdGZhSDBhd0VNcTVHM3UrL2o5VzQxSzI4UUpDOFNJcldhWmpx?=
 =?utf-8?B?cDdlcGltWXd0WUgxYmlyYzJzL0F3RDFPUkVIZzVoSEtKYUVsdTdZNVYyN24y?=
 =?utf-8?B?aTliUlg0b3NrVlhwS1ZSbVlKZkplaSswSDZtSUFCQXExUFlDQUJmNm9ueFRz?=
 =?utf-8?B?WW9wamp4NXI5NTZLOHJwcnlnNytGN0xIeHNNQVhuM29WcjZmcm1pNUhoakw1?=
 =?utf-8?B?bldQTVdOckNsODJOd0Zac2V2ZDlhREJrNEJwS2FYSHJtT3o3RTN6ZUl1R0Mx?=
 =?utf-8?B?QWttNS9QWUdXa0ZHendwM2ZGeGNVbTRaazFDSnBsTTlPbnhwbTd0R0NFOUVX?=
 =?utf-8?B?UjI0THluTFl4Y1E0bXNhaW5RcHBYYmZnVmxyR1lYWVYxU3BwK0ltd1lNRmQz?=
 =?utf-8?B?OU13VGdWWHZLUjVNRFMwRCszbmNVTzhBYzViQ3VYWm0ydXY1UUZIczVhV2g3?=
 =?utf-8?B?TlRsNHpKS3Bob1RqaTJ1YndneE1saTJ5R1lVNHlPSytldklQbGorbnlsbXk1?=
 =?utf-8?B?SUpHQWI0NE53SHUzcXE2RUpxcEZieURWampFRnVlbjlPa3lIa1h2N1ZlZ3NM?=
 =?utf-8?B?amFONk0yb01xbTB4VTF2K01tUXViNXgrZUFVSG9FVVpiV0NTZ0pPcWN3Q0p3?=
 =?utf-8?B?TnozZWROcklmSDh1ZUo3V2twUkFXc2htSldhMkl6YzJFMzZqMVpHUndvMUZE?=
 =?utf-8?B?Z3poTlBDbUxHcFQyemk2V1l1QUtybW95UUtDY1phZUxpS2Y0dzB2MDNXOVM0?=
 =?utf-8?B?NkJsNmozZlUwVmRpSW5wb1djNElpU1h3dmd4ZWtRcUFvL2tjVnBkdnNnVTYy?=
 =?utf-8?B?R2NBRkhkakJDVldLVXdUdkVFRzNvT3Nwa09iajZjWFVPeW9KdkQ1dUc4Q0Iy?=
 =?utf-8?B?bis5dlBIbENwMG5nQU4vS3BQOGJKdjZIbEFSdnlvR0JrM3NwblV4aHBDNlRy?=
 =?utf-8?B?OGtQanJsUlIwRldUWnZINnZVQUNnVW5POU5ncVZKUFNGTzlQQ29vRDcyNlhT?=
 =?utf-8?B?enZiRitOU3o2dWNJMFQxWnhodnhzN2Jnb0FjQm5VMU90Sm84dTFHR3VCUXBW?=
 =?utf-8?B?THZza1JjMVF5bHFVMzg4bWprRTdQdEVIRWdFN3JzZ3Y1ajNDdSsxcnVaV09w?=
 =?utf-8?B?S1NDTXlOeEtqTjcxM2w2QTdYa1FzaERvUFZoZWd4K3UxUXdjUDVQRGNrZ0kz?=
 =?utf-8?B?Um9jVnllbDBSOFVPVEdtQVJSNTYzNTB0enhxQ0lkU3ZybGkwRGVpOUFlb3Qx?=
 =?utf-8?B?WkRsYjBIK1p6SFhwQmo1d1dTSFBYTGZhdTMyckI0b0VoeGVGdVF4QkZaNXph?=
 =?utf-8?B?TUk5aFVXWEZVbExWZU5BMU9kbFVIWHdzZkxLalpRK3hOVXlTWW1CZHFsSUpK?=
 =?utf-8?B?dXdrUnlHa0pQZEZTSzEyOVBHajkxcVBzWjJJOFRtVnFNc202ellyT2hMMWZx?=
 =?utf-8?B?eUQzbEJJQmRmY1hyRzhRY1R4YjZxWlBuUU5QU2Fjc0VzTnRubVZlMThRV1ht?=
 =?utf-8?B?RHZmQ0NnT2d5cVZMVFZzazBDMW5iM0ZLNFlRSnBDUXYzL1hlcERmdmdJM2Zr?=
 =?utf-8?B?d0JEbnMyMVlnZ2NBSmxXK3dSZUlrVW9xSVVCY29JQ3RPcXZORkRFTUhVa1JP?=
 =?utf-8?B?S1JTMVJBZmVnNjBIUjRxSTloRHhaa2NydHhnRlFTeFNBSmRDS24xc0FIUG5D?=
 =?utf-8?B?MEY3dTFTVVZqM2d2UmN5bklKa3RQSWlwWnR5RnBDeWh2c0V4dWtPbWhUajNB?=
 =?utf-8?B?cGxGSW5qVi8rTEN1b083cHZwcGMwSFZ6Q1VEVlIxS3ZSVCtUMlNud3Fjd0w0?=
 =?utf-8?B?MlUyVEFVbVlhUWgvcFFUNTdOUDQ0c3pTeU1Vb0N4UE5aWmpXeldseTdMcWtF?=
 =?utf-8?B?RXdBNWYva3FKaUhURGxlN0Fvc1djK0VTMXhxZHd5Z3ZRZGlUbFFqL2dvMjJY?=
 =?utf-8?B?RU5YQlc3VmtRdmpmU3ZFN201UDJQMVlENVpqaldHMGk2Y0xML2VURGcyd2dE?=
 =?utf-8?B?S1hBTldRMkpiYlJ2bzNWdGljK1haQTBqdElCTjM3NW81TW9IL2QwOUlCZmg3?=
 =?utf-8?B?TXJrNm5uWS9iNnNEUzJOQkNzQzhSbVJad2VYOFlkMG5PVjYxRnREaGxFZFNW?=
 =?utf-8?B?WFVnNG5pVTk5STNtaHZYR0tEeXg1bW94TXg2Nm9aZWJwenRDclJ4QXpzSThP?=
 =?utf-8?B?d1FHcGFPZ3NubTY2ckE1SXpCaXhoREV1ekUvemxaRXpiTzI4M2pPZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f54c62f4-b6fc-4e63-3426-08de595d5760
X-MS-Exchange-CrossTenant-AuthSource: DM3PR12MB9416.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 02:24:16.8348
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +0WsMLpXdG8olIfwR1B1utabIkk2Mbj8Pcxcb56VpILvAE4HxsLRGaIo1YMv05e2AnC8rhprsrJ882P7bWwf0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7983

On 1/21/26 5:55 PM, Miguel Ojeda wrote:
> On Wed, Jan 21, 2026 at 10:30 AM Zhi Wang <zhiw@nvidia.com> wrote:
>>
>> Sure.I am trying to Cc folks who comments in the patch for crediting
>> their efforts. :)
> 
> Ah, I see, thanks.
> 
> As far as I understand the docs, Cc: is intended to document in the
> commit message that someone had the chance to discuss the patch.
> 
> I can see that, if someone gave feedback in a previous version, then
> it is a way to say that they had the chance to review the new version,
> so that makes sense. Having said that, if we did systematically that,
> the list of explicit Cc's would grow quite a bit...

Yes. But for smaller discussions, this is effectively a convenient way
to implement your guideline below, without having to spend too much time
mentally weighing "which of these replies is from a Real Stakeholder".

So it's reasonable approximate guideline to use in many situations.
In other words, "not quite systematically" seems about right.

> 
> Personally, I always understood the tag as meant for key stakeholders
> that you really want to explicitly mention in the commit message as
> having been involved (and that didn't otherwise give another tag at
> the end of the process), versus everyone else that is Cc as usual in
> the email headers.
> 

Yes.

> But I have seen it used in different ways in the kernel... :)

Yes, and in particular, there is a mini-trend to include everyone
from scripts/get_maintainer.pl's output, as a Cc, even on v0 of a
series, before any discussion. That can bloat the commit log really
heavily, and people are mildly pushing back against it. I'm glad
we aren't doing that here.

thanks,
-- 
John Hubbard

