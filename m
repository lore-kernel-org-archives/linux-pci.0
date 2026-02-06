Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011004.outbound.protection.outlook.com [40.93.194.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3831F3016E0;
	Fri,  6 Feb 2026 06:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770357641; cv=fail; b=L93NzKpLmoK/eVcLCebeXXYtdyox6ywuJFF5NWbq2uGgW3LM/0s57Pk2Wzlc+SNQoB70qfu0DE3oh3Iz8NNihgFv75X+uuzgoIzjwJbSGSueNUSB/4eysQXFdm/6aWMwV9TwjcgsXOKNF2xJ202Uj4xtzHGbhqXQNdoWetJVJ1g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770357641; c=relaxed/simple;
	bh=JPoWQhaEVZNzqfMDoq9VnolxyexZXDCG4B+OV/pmgL4=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=iHKqYYlDvXb7quoGF/dKpW8qXzKALCMD9gp6fyZojmPyhR7hEOsvt6xESkTXGX9DLajzUeYevDsLrMSvusPc87x0nIcO/kJcmTCRnNDCh6xV2QiPf7O7NDBP4LRTXeA3bIXGUmg2ilJEp35E8knDbnw04C4icWgOChSiWDK35jU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=J0Vzqmv3; arc=fail smtp.client-ip=40.93.194.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="J0Vzqmv3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kzbfedcGc6uU6h/cpSrXsnBq6sAzOjmA2b+YgS0edkthPrZCGMrd1k0f8Z9CoEdPuFPrzwQchdzDRiFWVUou8nxjGivatPYoGjHTXkUPqKOSfw4a9wUSrH5Qh4su31cxkxgPY98RVEuYM2gvCTa/VwYzSXq3kARGFWxrJIsJPLX3vyFSBsMHLX3TQ8SKLjhX+T5zZCPv3PXsBeldVf8zZV0V0rhm7Bm1TkGoibD9/qY0kNF9wKISjYTWhy4kVSC3KhxQ1tApZJ4KWnHo19+JgTT1Dz8eSDBgcxfhHsHF5jVzh0dzacYOIZw7pyR5XnkYh888oIaePNuEebwIx/QOLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PGgJb5P5Q0BGM4/Fv8fTpXJebWQ9y6tWRf4ijiLBl18=;
 b=Z9VWCk/i4qYDphHzfDt3pWEZI/ZDNn7m/HzVAJVTASHAQlTUBEh5iFLquL6MqozpVXzAWYMT8YmR0wfqn9dlMkYdg6pCJT0/WYUhNUM92A16yKjuLs1/lSbahhUZIDuMxOKSZvmDf969ylKbZ892JaQugRBTFGD4mi7bsopoGu0VLWT5U7WNeK+PwIhTA9pAcsQ9d7vmtIZstpF3i4VI202mtCuW8T5yrlwUdpkCzVMbygFUUX5yaGhuHFh5wCetGq67GmsvHysEsUEmaC//cYC48NcpNLUfoCE6c0uu60sWHkcubjgvMsT51xYr97qaBJgbJ1q6b9PnLpdGZUEKPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PGgJb5P5Q0BGM4/Fv8fTpXJebWQ9y6tWRf4ijiLBl18=;
 b=J0Vzqmv3vrXvAl12UDcPUC/41YHukWMSMUn18vA0NWHZ9jlvU6kgxELr9nV8n9RSd2ofzW0U/f7jagD4Eo1qVgewVqvC5WvKbY3oti08LGdaqruaHJjhHWWsNc8R7DsaK/A2xbXikG4W4Bkqp8K1WXQMNMC6usv5vurm+S7zNJLVfftnx4ydgTZEeJNIjFIeybem9PM0PZa7y9UPerXE1FPpZmVuDvCDEl9XBPT5qlU4WG8K3ef3RPZ7GmXCW+63Y0bpHCHHHoXJztrqRWudmNnMhQtSwKR2U3R2hWzw9QjlUcKVvAyIsjZTfcj10tfFThBMSCZXflg6tocrXqUnVw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by DS4PR12MB9683.namprd12.prod.outlook.com (2603:10b6:8:280::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.15; Fri, 6 Feb
 2026 06:00:37 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%3]) with mapi id 15.20.9587.010; Fri, 6 Feb 2026
 06:00:37 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Fri, 06 Feb 2026 15:00:16 +0900
Subject: [PATCH v2 2/6] rust: io: mem: use non-relaxed I/O ops in examples
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260206-io-v2-2-71dea20a06e6@nvidia.com>
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
X-ClientProxiedBy: OSTPR01CA0078.jpnprd01.prod.outlook.com
 (2603:1096:604:218::14) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|DS4PR12MB9683:EE_
X-MS-Office365-Filtering-Correlation-Id: 2410c613-a678-4358-c88c-08de65450c52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|366016|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R0dzdUd3M09ENjY2NEN1enNuT0xkb3FHVU5JZ1Vob3I5aTVMendWaFYxbmNI?=
 =?utf-8?B?ZGZtQ2hhZXZPRE5QOHVnako0aDJnU1BMaERuY3VKazJSS1gvdVpLM29WS2J2?=
 =?utf-8?B?N2Q5SklaY2FwU0wzdm5zd2JnclV4NEVteHJUNTZpbU5GS2FDa0NZeGg4YzNV?=
 =?utf-8?B?TmVNQXRCamNJNUFIc3cwZVdwVC9hL2pGcU8ya2JnREZhNGF1U2U2OVZnYkFB?=
 =?utf-8?B?M2hVODdiWFpCa29SVU5QSDNscFptSHUwU3BQb2xydGZJS3V0M0lMMHd5RTYw?=
 =?utf-8?B?NjBKekNiMnl4RmcxS2ZNeFFvak9oOVRyeW5XSThMOXBFSUx1UzFXMDhMaWRx?=
 =?utf-8?B?dTIwaWVMWVVIMHk0OEYzYkpRMVJuOE81TDBNY3FKUG5uRGtIRzdSVVlsRVpS?=
 =?utf-8?B?dHJJQ0Y4NUlQMWV1eFFJd0ExUUxKdWJwUndGZ0FsZ01pL28yUk1xVWY4TlBu?=
 =?utf-8?B?SXZUS3dhS3htdG5MRGNCZ0hWZ2o4U3FITVM1c3U5OWgrN1h4YTl0V3Y1ekFE?=
 =?utf-8?B?NjRKSmpuMXdNN2hvWEI2QXl3SnI3QU44aENraHI1Y2IybTBOWDBXaWVVajc3?=
 =?utf-8?B?YzJNS1lYSWJUaVIzYnRzSFl0dVhXNnZrZi8reTliMmlpYWtoaXl0a1Y1Z3Er?=
 =?utf-8?B?dHFGVnJDTzVVSHdTa2liSmpsekZsOGlaQVJ1ZHNsMHB3VXlOVTkzcSsrSnNM?=
 =?utf-8?B?MUM0Sjg4STBaNEg2ZDJxM0hBMXMrR1d4bXRNOXN1Z240MzVzNkhpbXdWTTBo?=
 =?utf-8?B?Rklhbm1ReFkxVUpCMFJCTU9aMEMrcHpSdGIwWmRkbTlPU2VycStOTGxSQWJm?=
 =?utf-8?B?WEFXWWYrK2dHczNhZkFGYWtyRWpKd0VoZGxsb1BkbFFMUFdRcU9KQzVFSTBM?=
 =?utf-8?B?S3ZDN05BbkYrSXZpVEZPVWxTSUUva0srNkoxakgxT0dkMUp3RjFkNzh1U2V4?=
 =?utf-8?B?L1RTZGNwTFhCbldURlFFT2J2dUhjL2laVm5kREozblVXWEVZRS9BNVBIcHVp?=
 =?utf-8?B?T0x1Y0tJK0JtbjJPTE5FMzdEbEdZLzhNaS9EUWNvaC9SY1FreC9RNWFqVXNG?=
 =?utf-8?B?TDR2eXYyN0dFRHF4TEd5NVdPbDRCUHJzc3hOcHR5UUcyWDc3QmpYeGdqZ2RF?=
 =?utf-8?B?TzZiK3dxdWk1NEV1emlwdG5ZWTlZR3pxa1B4U3krbnpyL3BKTE1uczB5Wml5?=
 =?utf-8?B?c3hLbGliK0UyVHNOcyt1SW9vZnUyYzlxZnp6SWFQb2Jlb2VONkVvcHljbDl3?=
 =?utf-8?B?cWVheldPUzlGV0VGVkJ5K0FodEQ5K3Bjbm14RzhQdENJSXlnT1E2WlQybnJo?=
 =?utf-8?B?eE9oOVJPVXN3QnBmTlhsYUVMMGY2Lzh1SkxSdG1nUW9GY3hYbmdjOC8yYk5U?=
 =?utf-8?B?MlpPTzZJSE82MU5WWUVUbm5UcGt2SDJGZllDUWRsYnY2bmZXMkpEdVJzRC8x?=
 =?utf-8?B?UmcvZms4bTFoTERVRk51WVNWYjlCdzhuTXUwWDhPb1g5M0JLR1d3RFVnVlQ1?=
 =?utf-8?B?ellrMlBJV09PNGpGVUxlTGdZNFNMWWFGR3B0R0NROVU2eXZlK2QxaFBmQk83?=
 =?utf-8?B?VGw1SWZYd3p5RmJZTXdKS05MZEU5WDlSZEhsWEM0dWtyams3WHdheXBCZTNG?=
 =?utf-8?B?VTJpNXlMbld2a2FnekVueTc2d3puSThQOUMrR2daZkduRVRHSE1wNWoyNzNh?=
 =?utf-8?B?bmxJVjBDL0hkUmtnWjJSZENXcCt0THQ2Zjh3RlhEa29uRWI2MVdrc2NVNzhE?=
 =?utf-8?B?NmtkNkhGd1Q5aGdXQWM5czM0emhwWjJ0L0U1R1pSRGc3MEVHYWNtL1dPckpv?=
 =?utf-8?B?MC9iaTNPcWNLUW0yb2ZOeGw3V25oTkZ3RWtVUW5zYWZ6L0pjVmFiRkFDMVU3?=
 =?utf-8?B?SHRFSU55L2thYnJRdEZHOEVMa3NNTFYrd29xQ1R4L1VadlZlL0R0Nngxb2N3?=
 =?utf-8?B?NHF6TC9QcUZhNHg0VFpDRGJ2c0JNRVBqWGtIWmJSOS9VQ0hSYTRQMG1NbW9n?=
 =?utf-8?B?ZVI3MjQ1NWw0YktVV3FuNThMNEZnRGxORE9HT2x0S3dlamlyVTBMVkxqYnQ3?=
 =?utf-8?B?ZU80ZWd3RmZILzNTZEd1TFdkZm1mS0FTeXVENU9Ed0kyajhabmN3MGI4alln?=
 =?utf-8?B?VS9iK1RySEsrK3Q1Z1QrMXdIWFdvODllR01oZ09lY1ZsR1cvU3FtZzRVeGx4?=
 =?utf-8?B?dFE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RzB5SWZQT0d4YXdsTHlzQUZtWEdONVV4dkNmMmJJd3ptcnZJd1lBVEJUY0lX?=
 =?utf-8?B?SXR4SGM3K3AyVFVJTWxEOHNEUEpQQU0vSUxZbUxTSFlUd0lGWWs3Wm5FSjZx?=
 =?utf-8?B?Q1lLSm9KK09pNmp6RTBuMlBrOElmT2UzampiN0p5RU9aUEoySWg2azZKSm85?=
 =?utf-8?B?UVZ0WE9qN1o4OEgrREdTYmhQRjE4dHRCdzhVYk5zRmRseGMvcXBseWx1TWg3?=
 =?utf-8?B?dHdzSlZ2Vy9OTmJScGlBblVkNE0wSEVXRy9rNmRUbTl1dVdFRkpZTWVxTWdn?=
 =?utf-8?B?eHVIb1ArNkdIU2d5Wmp2Z1FWNnYxYTNxOGt4T1hnOEVEQXVKRnRza0FQUStG?=
 =?utf-8?B?a0pYcVk3cHRhTzFvOUlMaWRUQStBUE02MHV2cVZXd1Q2eXlNekZIcnhBdVdZ?=
 =?utf-8?B?MzEvNGtVYlJOWVZjT3Q0N3lOQWF4OSs3aFl6WHM0ZUQ2eEhoMXpQREhWM1g0?=
 =?utf-8?B?ZjJJVFB1UXVtMVNpeHFRZGcxWUE5SjFjOXBQMEgyUkRmeUFyTUxRL2lxZU1I?=
 =?utf-8?B?aHZFUVMvZzhOeEtHOG5hZGZqSkVWb0ZGYkRmaGFiQW1PN1l1Nm1rd21NUTFp?=
 =?utf-8?B?Q1UxcnJMa05pMmplWHZWSXE3N0NvWC9PQWh2UVNqajFyNTF3ZU91dGJ6NmRl?=
 =?utf-8?B?NGZVNFJXVlpoc1JLVGg4Z3lDa2lJWE5HcU5YdGxaRXY1clJFVlRhWkJONko4?=
 =?utf-8?B?K1lwRk4yY01kcEVGUWMybDdDdS81U1ppUFZub0UxemZlZmF4Mm9US1hOaHZP?=
 =?utf-8?B?UUs0TjZMTUVxTHQ2elJXUGc1S08vOVVNSGk3dTkxVE5QKytlck5IRW9iQkFH?=
 =?utf-8?B?aXZncVN6YTluL3IvRDVBbzZQTGRYS0hkbDR3SGp2cTZ1N1gyM0dRWTRLNWVq?=
 =?utf-8?B?S1N2bWQ2TFcxVjFwcmRNQlUyeWVJQ2plS2VmeXV5QnBJL1NsQTUwSmV6dUEr?=
 =?utf-8?B?MC9wUkh3S21CZFo3TDJ5aGRRb3B1aWZGUXJTT25kbHdYaFR2RjZULzhNNmFD?=
 =?utf-8?B?ZUV4aS9FNS85NXN5VmdzcHhpL2JZb0ZOQ3pveU9CQ2VDVG9uZTRPYWEzQk5I?=
 =?utf-8?B?VVM2V3ZPTzI2Nzhwa2FUcjVxUTkyZUpia2NtWVA3NWxKQ1MwQkVSLzM3b3hk?=
 =?utf-8?B?SWM3Z1pkMGNXamduNXpoUG1WWHRYMVFZZEhUM2g3ZWY5dkhxaTd0ZG9JcUZV?=
 =?utf-8?B?SkpiZ3QyUnZaY00rdlUxS05Rbk40MU9VM04xQXIrd0Z6K3k2SVdlWStCSTg4?=
 =?utf-8?B?OVczdDQ3NjBaWmtqZU03OS8yL3pzNHorLzJKN0xDdjlwZkVsOVZObGZoSVNT?=
 =?utf-8?B?c3owbkZGWWFtYUxyOCtHN2VEbm1FMU5TRnFlMGtURThVc1QxUUVJekNnOHN6?=
 =?utf-8?B?VEpRdHpZNHZrMTRFdnJSdlp3cnhyWTlVWkZac2FVRDZLSkFBQzZac0tYanV3?=
 =?utf-8?B?YnlpWVFIeVBHdzErdUJQV0ZhWTVtZytFNkIvRldlVE0yWFNvVlMrOXFuTnF2?=
 =?utf-8?B?TWFWYk1YM0R3NGs5eE40LzlOZkJ3QVE5d1M5K0RmTEs0L3ZPOFN2ZElDSHlP?=
 =?utf-8?B?ODRJcWxGVkN2YmhOc05zQUVKQlo0eFVoeFROY0lERnp3NlVjZGhpMktNSnRF?=
 =?utf-8?B?WVZ4dnFobmdtQTI5K2pEOWJjaUQ3NFlhQk42OGFrM2k0ZENLQkpadmJnU3Vw?=
 =?utf-8?B?WFlOWmNCY3VKRGl5bzBuOVNUUjArMEpyRThhcjVNdkw2Ti9kaUxGY1o2Nld2?=
 =?utf-8?B?Z3dHdEhwck5pVzJ1YmFIbHlKbzZMMUZQREh5U2VTWlVUcHRkL241ajRmekQ0?=
 =?utf-8?B?YWIzRFNYb2ZJVGdWcW9NVzNUVWxsNytaNXRtRGo2MXZ6a3V0VnE1L3NFTzFD?=
 =?utf-8?B?K2xCUEVjMUhUeE10dGgxYVByM0p5VU9qdEllZEpYUTF0QnkvdlZRUW5pM1Bo?=
 =?utf-8?B?blhSdHpBQlU1RGxyeU1xOE1qL00ySHUyaWVTTjBUQld5eUNYR2Qra3IzNHRu?=
 =?utf-8?B?TitwTDBIeGg1QUx6REFXVHlscFJpOHZJdnEzb0w0YUJjQmFwL3Ftb3N5L1B0?=
 =?utf-8?B?cno3b0ZEYU81R29CaVhDRjRwcTVLeHliTWRlc0FRTDVxeHBOR3BvcG51a1pZ?=
 =?utf-8?B?aWRwR3VrRnBBaDNBM1dOVjRSenRuR2RBYzJCUUJOTVpzb0FXc1pDZFpEWk1H?=
 =?utf-8?B?UDd4VktzYVdkNGdNK2U4TDFYZTY4NnpBZWFIbmZGdWVSbzJEQ1hnMjd1VVNG?=
 =?utf-8?B?djNiSm5uZ0luVENpZHFPUHlBaHdmQTNEdUpsVEVFUjhFVDRyZy9mWkFLaC9Q?=
 =?utf-8?B?QStyMHprMHlUa0hWd0xpZlFjc0VxQWVoclVlTUg0eUlPUWJ6eXZEMmd6UTZv?=
 =?utf-8?Q?+u5Ujqh0jzXA7SnYmVh/9BRoKzb+kOG1OtJEJ7YaTpVMU?=
X-MS-Exchange-AntiSpam-MessageData-1: QysyQYddmURywQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2410c613-a678-4358-c88c-08de65450c52
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 06:00:36.9337
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KtyZAMAKlzDFPljgAdFVNcaBhYKOk9GXoDqhjRPoabtb04YDQnrKBUzlIdEfHvi1vySh2nSf8mgxrNqWjqJikg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9683

The `_relaxed` I/O variant methods are about to be replaced by a wrapper
type exposing this access pattern with the regular methods of the `Io`
trait. Thus replace the examples to use the regular I/O methods.

Since these are examples, we want them to use the most standard ops
anyway, and the relaxed variants were but an addition that was
MMIO-specific.

Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
Acked-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 rust/kernel/io/mem.rs | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/rust/kernel/io/mem.rs b/rust/kernel/io/mem.rs
index 620022cff401..7dc78d547f7a 100644
--- a/rust/kernel/io/mem.rs
+++ b/rust/kernel/io/mem.rs
@@ -54,6 +54,7 @@ pub(crate) unsafe fn new(device: &'a Device<Bound>, resource: &'a Resource) -> S
     /// use kernel::{
     ///     bindings,
     ///     device::Core,
+    ///     io::Io,
     ///     of,
     ///     platform,
     /// };
@@ -78,9 +79,9 @@ pub(crate) unsafe fn new(device: &'a Device<Bound>, resource: &'a Resource) -> S
     ///       let io = iomem.access(pdev.as_ref())?;
     ///
     ///       // Read and write a 32-bit value at `offset`.
-    ///       let data = io.read32_relaxed(offset);
+    ///       let data = io.read32(offset);
     ///
-    ///       io.write32_relaxed(data, offset);
+    ///       io.write32(data, offset);
     ///
     ///       # Ok(SampleDriver)
     ///     }
@@ -117,6 +118,7 @@ pub fn iomap_exclusive_sized<const SIZE: usize>(
     /// use kernel::{
     ///     bindings,
     ///     device::Core,
+    ///     io::Io,
     ///     of,
     ///     platform,
     /// };
@@ -141,9 +143,9 @@ pub fn iomap_exclusive_sized<const SIZE: usize>(
     ///
     ///       let io = iomem.access(pdev.as_ref())?;
     ///
-    ///       let data = io.try_read32_relaxed(offset)?;
+    ///       let data = io.try_read32(offset)?;
     ///
-    ///       io.try_write32_relaxed(data, offset)?;
+    ///       io.try_write32(data, offset)?;
     ///
     ///       # Ok(SampleDriver)
     ///     }

-- 
2.53.0

