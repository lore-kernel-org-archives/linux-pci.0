Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010002.outbound.protection.outlook.com [52.101.201.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC3A2F83B7;
	Fri,  6 Feb 2026 06:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770357651; cv=fail; b=r6jQhxaPFZp4B4DdyRCzGMfp8AJ0Ho4Ri3pXYVrRNSUqC9z8I1o224gKCgresdActHhBA1WIh8Xb18mPWGbmcpe+9TpjudX7saD2ctszDLQZAoMWcZXo2L33LNDzgSW9IjBzg8efuMZrBWrNizYyWonzXaP1T6m5b7WUZ5DLFOY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770357651; c=relaxed/simple;
	bh=HnYHfVczE9TXuq49NLAPR0vIj4woj88mHngISn+J7kc=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=JOVXnZzGUCdNbHrxfkzvBANdJb+hqkynybi/fg5IhcuUcN6yDBnyE43iivLzWBzaTYvsuqCfPHoVJiNNY76KoO4tZ90yWV6KHdGnLo4DUo3b/sy5rAicZJ9bXZuiJAIsNTgRytqJD79K4nXWUkR37gWX6hnZwevfEYthH5bHtEI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kxukvf5D; arc=fail smtp.client-ip=52.101.201.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kxukvf5D"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tBSDAVOzF8DgfTP/+f2WYtWFtZoNSOKGw05MMWUrmULWRwz5w2kMtBBsFGSCbAxuVbw/a+AzU4TPzt5COoTbSnuWNxdLhqGpgSgZaRMzTFZNATSTWpCTAVWo6+smJsJuv7uk6yEiVNJ8sPzcm9IZi7aBgL1PZm5ajSUp83VVQd8vJJodM5Pw3fliWKi9rYVs0V3kAo73kH8VQGlv15ZmRn78VvaNpMqDfJT6gOgiaJwH3jLZDlmKtDA3N4dtL6B5L3ADbVvjA1da2MfUYTffdUDvgzMQ7vCgoccw6dxHPqYCLGCB+tYb5uI7oW2zLFbg7xTU3Mz8ChLbjY8O6dgy4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IKCU1z0MOX+UOzgLVfS8+ALxay6qL+SJ/Pb8iRiu/7I=;
 b=JOzLAH5yk6Y2yLIq1sGA3mpsFNLPNL2A6INPgPr8cNeM6Ykcl2UOuIkxK/fD2tu/Uqi3sMO2dZx0aYRLpNWz6SBWtZb5yKBWFbyYXY8uIVOKIoxfZlv6AiTNE689vXuUhb8wgKMu3hDlaqPIX1GFm3GoAUFAioeoZxVwCrMlEh2tjtiUNBZBDxa7GyxCJQ8KPKt5du0tLn2Mj0yOMSgZiDZ72gvNnI/bMJovBoMgxh3pKI00crT6I08gA9A4iof1mX6zuyW7VnLh/JcRfdkorO5I2PpS4C9lkhzBeoX46W9v7Th0gN8wkItmlvWsfYoTCT/joHUYJTI/jOpRV9iiHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IKCU1z0MOX+UOzgLVfS8+ALxay6qL+SJ/Pb8iRiu/7I=;
 b=kxukvf5DN7aKdMQAV7n0c66Qvujp8UmalOfBgriamGR2fy4cEJv0h1ZrPJP0aOIrUIOCKvTqbmwsJULeKTzcviuzm8f4cElLb7Q7hGT2C9mbC7HUklEX6ANcD8vKstbNv7+iZ/kLnQ0+zK064gxN9Xz+qJbaa84CZL+wMGWbuCkgnMz6o4C2S7DLffiylYPO9RC+UrzBEOtX82cijJqQC9+Hkp/sGm9Ktu9B0ZkQF7BprcvSdomAdr2052gBharp555KxN4N4W4MgtNbShrw6yJYcluSIevvh4zxtn+OgLkmyXqDHvSZVxqvhQB3heV930tovuN7Cf88O9Oqq2XqrA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by DS4PR12MB9683.namprd12.prod.outlook.com (2603:10b6:8:280::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.15; Fri, 6 Feb
 2026 06:00:45 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%3]) with mapi id 15.20.9587.010; Fri, 6 Feb 2026
 06:00:45 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Fri, 06 Feb 2026 15:00:18 +0900
Subject: [PATCH v2 4/6] rust: io: remove legacy relaxed accessors of Mmio
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260206-io-v2-4-71dea20a06e6@nvidia.com>
References: <20260206-io-v2-0-71dea20a06e6@nvidia.com>
In-Reply-To: <20260206-io-v2-0-71dea20a06e6@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, Bjorn Helgaas <bhelgaas@google.com>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Cc: driver-core@lists.linux.dev, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
 Zhi Wang <zhiw@nvidia.com>, Lyude Paul <lyude@redhat.com>, 
 Eliot Courtney <ecourtney@nvidia.com>, 
 Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: OS0P286CA0098.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:b1::13) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|DS4PR12MB9683:EE_
X-MS-Office365-Filtering-Correlation-Id: 63f1e119-df11-4ca6-b15c-08de6545115e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|366016|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RDR2dDBPVnFwbmtabFNneUNPams5YmtHUEQ2dGdnVHBVOE9Ob3hSb1FkbzUz?=
 =?utf-8?B?c3RlajRzQ29WaEgxT21YNkN5emZLNlB2N0Q1QmlrSkdOd3U2WVJ4eC85aWNk?=
 =?utf-8?B?MDFzcG1EVHNYL0pLRzJ4T1RBL1cyUkRxNFhBWnJ0WHdYaG9tZ3djcEZldWVF?=
 =?utf-8?B?dEl5WmJBNmpleXBiZFBTWjJsMFFFbUNzcDJOSE9CTlRpRmt2ankwQ1FtK1dR?=
 =?utf-8?B?M2VadGM3SHh1VGhsY1h4Rk8xdW5GcUk3RVFDcW1ITVkzQVU4YUVTSzN6TVQr?=
 =?utf-8?B?YzRDTjFYTzZid0VMOW9ocTIrQUczVkNpa2ZQQ2RnSXhaaXNxc2ZnZDBWd2ZF?=
 =?utf-8?B?MGlhZG5ITUVxQmpkM2dvc3FoVjZqZStucUkyUTFrM3VzazQrWE1oT2xqTElT?=
 =?utf-8?B?S1Zja3BFalpwdnVsb2lYZ2NiUTNYNkhObUF1SE1Nb2t0QzhnK0J0QXdKVTFq?=
 =?utf-8?B?OTlSV2NvMXF4K05sZjNqMmJ4Ui9wanhtSmc1dlJ5WEJGVGdNTEVxWldnNjNl?=
 =?utf-8?B?REJKU3dvc1FhaXZXdjE5Wi8yOG5KMUM0OWE0T1BYdGRsblJlaGJmZUdnUDVM?=
 =?utf-8?B?K3V2RS94ZGpzb3NIdnVKWTh0Z3l2MmgwNUU0QWF4RGpkemEzS3NzSzJWbGw2?=
 =?utf-8?B?ZTRtR2FJRWk4ck5LQjRuU0w4blU1eEx3aHFtRTZPVnJ1T1kvSGpZNzMrc1hi?=
 =?utf-8?B?enlpUXF6WVBBK3JYdVJjSWdQMkp0MkpNR0RNbC9SNnJvSi9hM1kvaEplbktV?=
 =?utf-8?B?VFQyMzZ2OGxsL25yTStaSzFEUi9BekhJSFkwNTJyd0tGa2pHT3VCU20ybFZY?=
 =?utf-8?B?Y3d1bWFRaFdwNG1WQWY4WjVhekhZcjVzYkxSMUxURk9GaTFaa2JkUTluQUdO?=
 =?utf-8?B?SnJUclByZnk1ejNOcjhadU5JbmxjcGhlM1NWV1RPSUowZW4rUDg1YVZWcG4x?=
 =?utf-8?B?Zll5aVE4Y0ZCVjRjZ0xKR2hxdk0yRXkrcnRRSVUwUGg1VjRIMmd5RDNmMitB?=
 =?utf-8?B?SHc4THVmT2U4OWl6TVQ1dkdtV0N6VXZDTkRwVjU2cFBLOEszY09zRm55bTli?=
 =?utf-8?B?VTFGb1ovV3ZRb29POHdLN2FXMTN1NHpaVDkwcm9YcXZXVmZjVnpPUFNNOXlt?=
 =?utf-8?B?Z1V1TFVsdzB6MitsNEZ0ci9wQWZWY0lOSXdPa0ZjTzZTSE1WRE45NlI1a0JE?=
 =?utf-8?B?eDFkK2toQUdhY2VZbzJRRHdhY3BkSTh1MnRaL1NlNzE3MkJqeEJPajNuajRL?=
 =?utf-8?B?NzFJSCt2OWhaYis0SXl6Q01sSnhLY1cvZVVwTEtmK1AzR2t2emZ6S3ZabHFu?=
 =?utf-8?B?Q2Q0ZWxMbzVBZXVsaE43eG9rV1RNUnVRODYrdm5oaXZ2UUlRVldka29xM2ov?=
 =?utf-8?B?LzV6K1RxVlpDZGtLRCt3THhYakVSS0YrZE80ZDV6Qzkyc2lCTzJwSmxVQUE5?=
 =?utf-8?B?VldXeXpFb2ZzTU55czdNcFNlRXlsN0NvN2NmT2xjOVg0VWUzbmZSdUNlZFcx?=
 =?utf-8?B?WW52OVBkMDJVc1FJck4xRGVTN0IyZ3NFSHhKY1lEaXBVV0dHV2FhdkJvelhl?=
 =?utf-8?B?RThPUjBNaVZ1ME16R25hVGs4R00vK3A0bG9nN1ExbklCdytwZ1kwazlHRUhZ?=
 =?utf-8?B?S2hnOXZ0OEhCYlArbFo0alNod2svakJvUk1rSmFvZE8xeFhOd245QmY0c08z?=
 =?utf-8?B?WWw4ekhSdGNHdXNxSTRSOUE5R05qZzVRZHlMdTFEN0h2VXBUd1lBYi81R09w?=
 =?utf-8?B?c1hHclRLSzMzb2l5RlBBVUx2Njd3ZGYvTHNrSHBtejREKzBwdzdKQVQ1c2xy?=
 =?utf-8?B?eTdtNHBsb1drd1RxTjJyZitVRXZmWjJxdTI2c2lTdjRXTVJxbGZFUnJSUDZk?=
 =?utf-8?B?blAxNDkvdC9xM3VFQ3VCb0p5RS9GTi9ZMUNzdkhOblRzUVZxOEwwRmVWZU9G?=
 =?utf-8?B?RWIreVY2WVNLVnU3TjBHaWJTbGRWMFc2UFc5V1RIQ0grVEcwNTc5REVLODJM?=
 =?utf-8?B?QUlBWnJuTjU5UFdRdW44UFNqZ296ZkRCN3BsU1pQV2d0Ky9jc0Z0cjlVTTRj?=
 =?utf-8?B?bkFVc2RMbjdaY0tmRk0remMvaTc0VHlZeTNoa2lVcVNrcmVYVGxBTVlHQysr?=
 =?utf-8?B?anFMRWJKTDNnWkdJYm01M1luUUhBZ0FLZlBhRlJYWmE4UDJteVNMVlRyM0Ux?=
 =?utf-8?B?eWc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MzVRYzB0Y3JSLzd5b083Sk1STmZTR1NaQThiSjJhUTRPOFoxbG5RdHVYZG9F?=
 =?utf-8?B?MkI0K0NIeGhGUnQ1ZkJHc1RHRFFDTDRsS0I4ME1pWjVreW1OUmJQeDNwSTJ4?=
 =?utf-8?B?VnRBYjZBTmtUUkdEaU9VWUtYUk8wMTh2Tkw2cmQzT2h3Mm9jYXBQaTNla2lr?=
 =?utf-8?B?K3RIZ2NaaGhOTDIraFoySFJuYnhiVlU0UFNiWXNXaU5oVHFmTFhsM2lkQnN4?=
 =?utf-8?B?VVJReUpsYnJURCtFV3l2SjdwNmgxZUpPMG1CdUtCRUZhb015QVJRNm5BSjZs?=
 =?utf-8?B?OS90ZFcvaXJpZjlmVFRFaEF1UWdibE9nVWRzRXlmUVNWZHY0Qk5Ec1JCbldV?=
 =?utf-8?B?K1RSV2w3WGpLY0g1dVFjUjg4aHFKZzRSSkFEQnFjcWZ5WklkRm5vdG5Ea0pY?=
 =?utf-8?B?MHNJd2lsc01kQ244Uk1lb2ttSnBhTWhEdU9xZkpZeHZ1RjRtOW9rMC9YNEVM?=
 =?utf-8?B?cDVma3hrcFpscEx4c29DY3I1VGgzblF6YnQ5Q3B2K3o2dHFtcU5IcTZYUjZz?=
 =?utf-8?B?cVZ6N1B2emFZOFQvVVIxKzJNS045RkZ1WnlYWkhrUFNONEFKM3ZGd2NwVjlD?=
 =?utf-8?B?dktiM1g5U3lnVTcwek9RU0oyRkV2b0dOTTBYekRUcDlLWXQwQ3NqWnQ0QTMz?=
 =?utf-8?B?REpEOUVPdGhseitpU3BBcHhCSTIwRUFWbGhhVTJqNnFkbU1qVEZBYkZMc0Ex?=
 =?utf-8?B?VXduN01wVlo1a1BiZVVQTzZUdkc3L3ZwczhGd1cvZFV0anZFNTBTRUhTMlhB?=
 =?utf-8?B?TjFOWnZqbTREYmhzbUhScHZKZC9JS3A2MjRrbjg5TVZrVHJkd3ZjbXg4NUl6?=
 =?utf-8?B?U1VXVmFUcXk2SXJIR2RRNDFnRFk5RHI3M0NqYStlZWNLMmVjUjUvcGRBOXFq?=
 =?utf-8?B?OGg4ZVhnSkdncUdQZHdhem5RT0lmekpOdlJRT0c1K2ljVVFKSkIxLzhCRk1j?=
 =?utf-8?B?LzBMT2U1cVpkckx3TFduS0ZBeFlzRVg2TlUzeE1EbjZPVUhZWDFQNTllcG1D?=
 =?utf-8?B?Zmo0cUpaM0RFZ053Mm1CTkNFb2Y5NHBmQWxEVmhOMThFQXd3Sjc3OVZRRTEr?=
 =?utf-8?B?aGVXb0MxL2tscHlDYUYvUnJCcG56cjdMYzg0TksreUNRWlZtN0Z0dkRLdlVQ?=
 =?utf-8?B?QnpaVnp1VDVEVEJQd0lxdG1abVBjOHlQdUZZSVJqelFiUjZhZzkzNXFQWFla?=
 =?utf-8?B?Vm1qZUdPd29sVmNVYUNpR0kvYnZYQjdPSkRaWUcvZGUvakxTb2JVZXhVYWxm?=
 =?utf-8?B?SDI2bzdVQkdLdW8wWVRQejcvcEdiSFh3alNwVWp1WVgvSGZrSllFNUZreTc4?=
 =?utf-8?B?T1BMckpwVXRFSHJHdnNINFNQT2xVMU8wY1dKYWswYW1vODIyQk9UaG4yR2pO?=
 =?utf-8?B?bVJWenRrM1YxWk14VTFxNklUdUh1VlZGTTY4bVlvM1FORGhFTmk2Mm11am5D?=
 =?utf-8?B?WmthWGhmcFNuUWQ3dlZPcXl2bE1kUk8yN0tJVWtubEVLcHRQaTNYTmdLYlo3?=
 =?utf-8?B?aWR0WksxZzV3eUZXaStKMTAySDhZUnZia1QzVEt6ek5acWs2Yk8ra2xMWlFC?=
 =?utf-8?B?MXluQ0JUMVFDMHlyb2E2ZVpPekp1RHFMVDBtenhEZ0t3NFdLbzRTWlpQVWFR?=
 =?utf-8?B?RXI5dklWWTF3MVBzZEpvVmtOWVdGVkFLcitqLzZha0h2ZDNxbm5mcFhZOFpu?=
 =?utf-8?B?ZnNOQ2laRXdOeGdVaWJIY3FkdHJ1UHBBazNDQVNpOThJL3lvTzRZc2t2UDh5?=
 =?utf-8?B?Z2Zmam9NMHV2UHVxVWdEcGM0NkJ4Q01ydWhNOGZqS2dnSFlMME9aYklveUJ6?=
 =?utf-8?B?YzV1K3NvRlZaQnFkWDRGaEMvWnJNVTFXSHhvN29kMXNvL1ZPWG90c29oYUJH?=
 =?utf-8?B?d2xEV2sva1JpV1FUaGUybXF1bG0rWkFDOFprY2orRjVuTXJZZEpTZkxxZnVp?=
 =?utf-8?B?dXFYTlpSVUl2dDgyVkRVSFlJcUhGZjdHOUtqWmRyZEFEMlp0ZHpXdHk0SDhX?=
 =?utf-8?B?dExKUkxlcFJSSXF0SUE2U1hGNkJpZFIxeXdqVHBDeFBhcW5PcGxQS3ZjZWNn?=
 =?utf-8?B?d0dZdUdUSGJvdERYR2ZaRFFDMTFSSkxaY01vaWhYUGxQbDFyUUdqUGh1aytL?=
 =?utf-8?B?eUJmSnUxQlJFMVBDTWdwMTcxOWlMY29jSUV4Nm1sdTZpN09qQXQ4YVpaYkZw?=
 =?utf-8?B?eHBabVRWUkdzeExjNWdmQWNPOU9GOHhTL054WWF3SmVIYzROY1ErK2pOOTAx?=
 =?utf-8?B?bHo3NHd6NXl0M2NLZHJrcFlLRWxNc3VpRHFKVGMzNzh4a1dGOE5BaFFFbzJM?=
 =?utf-8?B?RXpuMGNjdEFmcFFrZGY1SG56ZWQvRmpNTzN2aDNybVBWdVBkcnJ1UnV3N01z?=
 =?utf-8?Q?EREnEWZ0ZlWNoXxzaG211cCvkhaLOWPdu/kRq+IPDIODa?=
X-MS-Exchange-AntiSpam-MessageData-1: OjyJ5I4p36r5hA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63f1e119-df11-4ca6-b15c-08de6545115e
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 06:00:45.3321
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gRUapbQfXI6KzSFrZG9V+jrW6NCVjYbpvE4bv+SoqIIrAk9iBDRGFb37ORu9FI3dkkGCvRhpLTp/WC6LdO9JeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9683

The relaxed access functionality is now provided by the `RelaxedMmio`
wrapper type, and we don't have any user of the legacy methods left.
Remove them.

Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
Acked-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 rust/kernel/io.rs | 40 ----------------------------------------
 1 file changed, 40 deletions(-)

diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
index d5d6e9501453..06856d6a9b46 100644
--- a/rust/kernel/io.rs
+++ b/rust/kernel/io.rs
@@ -654,46 +654,6 @@ pub unsafe fn from_raw(raw: &MmioRaw<SIZE>) -> &Self {
         // SAFETY: `Mmio` is a transparent wrapper around `MmioRaw`.
         unsafe { &*core::ptr::from_ref(raw).cast() }
     }
-
-    define_read!(infallible, pub read8_relaxed, call_mmio_read(readb_relaxed) -> u8);
-    define_read!(infallible, pub read16_relaxed, call_mmio_read(readw_relaxed) -> u16);
-    define_read!(infallible, pub read32_relaxed, call_mmio_read(readl_relaxed) -> u32);
-    define_read!(
-        infallible,
-        #[cfg(CONFIG_64BIT)]
-        pub read64_relaxed,
-        call_mmio_read(readq_relaxed) -> u64
-    );
-
-    define_read!(fallible, pub try_read8_relaxed, call_mmio_read(readb_relaxed) -> u8);
-    define_read!(fallible, pub try_read16_relaxed, call_mmio_read(readw_relaxed) -> u16);
-    define_read!(fallible, pub try_read32_relaxed, call_mmio_read(readl_relaxed) -> u32);
-    define_read!(
-        fallible,
-        #[cfg(CONFIG_64BIT)]
-        pub try_read64_relaxed,
-        call_mmio_read(readq_relaxed) -> u64
-    );
-
-    define_write!(infallible, pub write8_relaxed, call_mmio_write(writeb_relaxed) <- u8);
-    define_write!(infallible, pub write16_relaxed, call_mmio_write(writew_relaxed) <- u16);
-    define_write!(infallible, pub write32_relaxed, call_mmio_write(writel_relaxed) <- u32);
-    define_write!(
-        infallible,
-        #[cfg(CONFIG_64BIT)]
-        pub write64_relaxed,
-        call_mmio_write(writeq_relaxed) <- u64
-    );
-
-    define_write!(fallible, pub try_write8_relaxed, call_mmio_write(writeb_relaxed) <- u8);
-    define_write!(fallible, pub try_write16_relaxed, call_mmio_write(writew_relaxed) <- u16);
-    define_write!(fallible, pub try_write32_relaxed, call_mmio_write(writel_relaxed) <- u32);
-    define_write!(
-        fallible,
-        #[cfg(CONFIG_64BIT)]
-        pub try_write64_relaxed,
-        call_mmio_write(writeq_relaxed) <- u64
-    );
 }
 
 /// [`Mmio`] wrapper using relaxed accessors.

-- 
2.53.0

