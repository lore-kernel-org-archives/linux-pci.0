Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794225170;
	b=JIOtqglJQnrGLo3wy60tXWJn8lhe8tmT1iTS8V+ehpIJZFyH7udwEQ/CXtxNfPtEhKgw
	 /ESCqZbrzTxi/U15Qg4YUHv5pw+WLol9Y09GVnL1dd8TcEHHba0wQI/bd/Q2MY/ox5MLm
	 Smu8lpClcxp6KhbO5EgjXBOVGPM+JtXRaCS8crX3y1lMEq/pN9m9xGRqKGc4Af/72Qabv
	 yN56UetUUH7xEaI9755TmmiYzzID9vGR1oV+cbDW3V1N5TN/E8MHTOjPU/MdMwnvFTBxl
	 VxOnNN0Q5IXSXPx+xj6LnvEDLp2zCh/rwCA8b4ngJYKKafzOueJvaTs3IvZ8d7SsduQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794225170;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Content-Type:Date:
	 Message-Id:Cc:Subject:From:To:Content-Transfer-Encoding:References:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
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
	bh=6QzpL0g8z9bS7RE0/qjXvS3AMH2NIGaqGEcTDCO/PQg=;
	b=kNPAizwzjMGIkaHI83NxV6odiegHr9O+um9dCMz+5SEpA5B98rCiPS4l1PNk5itEqpFT
	 c+8GBiGAa10GcgcaDfov7oPKegp631SY6GfA2SqUb2/r7Uvu4EasLvynasXDjtxAIJ+pw
	 saJs2iggdAnizG8jxNjfHHHVpORf6LuUERIpTz/DEePLZDGkSk6g6p5/0B/rLRtpiMFah
	 cBHrljWOyqYA/rjScfbYj75YpZjtpdoKKrW+TiSU46mI8+FpjVjcEZ6c9zI+09mzfND5R
	 nimoR0IpHaKiiI+49l/0w+APKcl41kixDw2axZZCil/S/TT7KdX0JW/ipHwmcmY3lnA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=U8Nxj9Pe;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.42
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011042.outbound.protection.outlook.com [52.101.52.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B4E606A321;
	Mon,  9 Nov 2026 11:52:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 04B4E606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=U8Nxj9Pe
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B/iZOORejtaFWixUEjjvqE34oJmsBL6Y79Kt0Dws9nyo2oibSeiW0IkRVRwyAkEfB7ciODTKUL0fcQuQGN9kQVmN0zqVGj3bWryZPRY3qzGyeXiXNJOE59kHinu9euK7ZgmPDUxKKqUZ3xPWyUycqNR3RedOsGDRVklEfXJ5l9rEFvE9TyOlRSWyWRl/6UjrZyzFwn8qe7s+uDbs98h4zjc6CLvq/cch+OMmX1GOby4taaIFymPdWee2JUuBRzdrFz+AJn2AGZIxCQ5rok8YX2+MpdSVwc0Z9AQa5w4Fq7A5t9vYr1Hdac/WI2B4kUhIo2/qMa7T9CoX3R9YVSJvbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6QzpL0g8z9bS7RE0/qjXvS3AMH2NIGaqGEcTDCO/PQg=;
 b=u0ROis2z0/PDOyRh9aLj2OAECcloHGq74ila8LaorBbcnyf9DVR2/gDRU2N463W4Qtfq6oo7ZZBa/vGyyteCyE9L4lHc4DOl80Udl8JDqNajhQ8KwkRm3iBEmCOMcB4wYqVLl12PN82QpVjR8CegTJ43ksYnL/PcesWzalQgDIMbtukfMnLQSY2Jj2FcRtBbn9+ii/GiHQZHPAQJxzm7mKX2s4otTTXq3ckfmokDIwwhbTAxahM/53DyRMYqeA/91Kx6BrHqTl3I+YwIOxJypLyDu7m40Bc+3dgq6PZmTOeo9HxBY5iaU/EPeNPgIOHuQOvHWN8/4Y+ce9kr5IgQQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6QzpL0g8z9bS7RE0/qjXvS3AMH2NIGaqGEcTDCO/PQg=;
 b=U8Nxj9PerxqKg6NkyYzwhloR+QCZq5E5bPyesmjlSEfLfE5QoH1mRPkETbsaRE/atTdzmmu3Lh4/6OpmjEZ6PN58o9nXYaOZsPOSZA1jcPGIehXyogGdrJPeZvYH58B8VfgTIb/B6JOxtAkK/TacQ+lHAcosDa0bvI0J5rUlFha4hNgpw6tpm9zJWJK6Likk+Po6rGy97kRWov/1ji/IKTIeaWf9IylgTYBez7UrhVSjdkoPZDsfsmFOZ/coLDlvU9LhHVX44YvwgLx/wP/b6xZsPvgCffeSbGIh6C00yR13MdnAeHNhGOcM2q4BbXWLjcM7NTcAsE9V4PEMT+EEWA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by CH3PR12MB7713.namprd12.prod.outlook.com (2603:10b6:610:14d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Mon, 9 Nov
 2026 11:52:43 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0592.010; Mon, 9 Nov 2026
 11:52:43 +0000
Content-Type: text/plain; charset=UTF-8
Date: Mon, 09 Nov 2026 20:52:40 +0900
Message-Id: <DMQNQJRORDDH.2NFX9UZO7SAK9@nvidia.com>
Cc: <dakr@kernel.org>, <kvm@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <nova-gpu@lists.linux.dev>,
 <linux-pci@vger.kernel.org>, <alex@shazbot.org>, <jgg@nvidia.com>,
 <yishaih@nvidia.com>, <skolothumtho@nvidia.com>, <kevin.tian@intel.com>,
 <airlied@gmail.com>, <simona@ffwll.ch>, <ojeda@kernel.org>,
 <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>, <gary@garyguo.net>,
 <bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
 <aliceryhl@google.com>, <tmgross@umich.edu>, <markus.probst@posteo.de>,
 <jhubbard@nvidia.com>, <apopple@nvidia.com>, <joelagnelf@nvidia.com>,
 <ecourtney@nvidia.com>, <cjia@nvidia.com>, <smitra@nvidia.com>,
 <kjaju@nvidia.com>, <alkumar@nvidia.com>, <ankita@nvidia.com>,
 <aniketa@nvidia.com>, <kwankhede@nvidia.com>, <targupta@nvidia.com>,
 <linux-kernel@vger.kernel.org>, <zhiwang@kernel.org>, <zhiw@nvidia.com>,
 <boqun@kernel.org>, <daniel.almeida@collabora.com>, <tamird@kernel.org>,
 <work@onurozkan.dev>, <jgg@ziepe.ca>, <bhelgaas@google.com>,
 <kwilczynski@kernel.org>, <dri-devel@lists.freedesktop.org>,
 <peter@colberg.org>
Subject: Re: [PATCH v5 1/9] rust: pci: add internal SR-IOV enable and
 disable helpers
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Simon Song" <xinmengs@nvidia.com>
Content-Transfer-Encoding: quoted-printable
References: <20261030171230.196717-1-xinmengs@nvidia.com>
 <20261030171230.196717-2-xinmengs@nvidia.com>
In-Reply-To: <20261030171230.196717-2-xinmengs@nvidia.com>
X-ClientProxiedBy: TYWP286CA0025.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:262::13) To MW4PR12MB6873.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|CH3PR12MB7713:EE_
X-MS-Office365-Filtering-Correlation-Id: eb9b3222-9fcd-4688-a765-08df3e57f6b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|23010399003|376014|7416014|366016|1800799024|18002099003|22082099003|6133799003|10067099003|4143699003|56012099006|11063799006|261028144727099003|261026121527099003|261102123227099003|261022115727099003|261022113327099003|261022075727099003|261022105027099003|261021130227099003|261021121427099003|261021123027099003|261026140227099003|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	woPwEWUrTNk7P6wakLiB/imQwNutBVgVy/mGm5wM6plxDWWvkLFWG7UllKpAeugY2mAbQ0y9cUU0Tlt6h1eWRsbsS9XLAzYWKRCz/B22xfAaO8YzNU+/Q8kt6i2bIz1+oMNckjf3DZeJp/2aDn/+RFE2mzywrAQJrwwi3eFwjNJh7Wikv6zLyTFvePubLJysmw6TEGFChyoEohCh0fREVwekw57gGSNv8HnJOf2zYUO4cqrS5gFcgFgjNakBru1mA7/UlGKpWc7u4bC6r9plusS5PlwbVTcDxUAqQab2e5XD8tP37G8dOc0kqWEyikIxcZb3mu6vxeR6zuB/o3ItH+iuBuqoTU3LJTdQU3hxjYAGkzCM02U6FlVV+D+SSh+0ZOWmddyBHhcN125ynoO5HZzcSIGfUVY59dcHBMYRdl1KbszyxpS5Dy6oC4D/rpRuzRYtus5q10H5QcTjn04PzFqHuqC6qvs4eLlV4eut+cHrR17/qdW4fewqt/7gAQomASWR+4z4A33TnMh9DpNi6XO8DQPI4OdYmG7QDjyV6iaCN5QuPdv1FeKY/GXK7igRXtaQaXMnMuZRt1lSa4/ZD7Rz7G5SqaJM8cpG0xSeWUoL7EqJDteapcMusKd/dYl3kGY56E9SuNWqid8EB0tPcafnYfTjeMy07LmIJtU1N9E=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB6873.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(23010399003)(376014)(7416014)(366016)(1800799024)(18002099003)(22082099003)(6133799003)(10067099003)(4143699003)(56012099006)(11063799006)(261028144727099003)(261026121527099003)(261102123227099003)(261022115727099003)(261022113327099003)(261022075727099003)(261022105027099003)(261021130227099003)(261021121427099003)(261021123027099003)(261026140227099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZWh4WVRaK3NPQlFxaHc3QUpUV3VpS0RoVkVuT3RTenBmWG42S3c0WFNrcDhU?=
 =?utf-8?B?empQVEYweEdTZHo3MlNnZE94REdqR1BEMHQvSTJjNDF3eURvdUVhcm9seEF3?=
 =?utf-8?B?b2hsbnY0OEtxS2puSW90ZC80QmsvcVVPRkliZzZOMUExSkhrQmJQRThHZE56?=
 =?utf-8?B?aHRNRk13UDNRNkZxNzhmNExPT2xWZHc0d21mMGZwQ0FvSXdjT3NTWWhtWk1Q?=
 =?utf-8?B?OUtCWGxrUG8rVG9DbXh5Ym4xanN0MzZsM1h3eldUc0NlVGdpdDBwd0ZEQk5r?=
 =?utf-8?B?ZnV1WGQ5TzJuUjgwWGMycXkySWNmY1lhbE9aVWZaSXcvWmhVTG1vRi93QTJI?=
 =?utf-8?B?T0ZnN2lybDlRMHVUMTdySi9kc2wrWnhPSUVhc0E4U1JpSkM1aVIvMnc3SnNN?=
 =?utf-8?B?MU9ocmtQMjZZcHZlOWtlRzg2OUN2aWcvN2VGNEduaWE2S3J6Qm92YUg4Z0Ex?=
 =?utf-8?B?UXRvQUZldjJGaGE5V25Zc0hJY2YrRkVsbVpFYXZqNjRFQjNYZUJoZU5zSkxy?=
 =?utf-8?B?RWJtYUU3MnB4U1IwSndmK1BpZXI0QU9QeEk2Y2cva3NXdjBCanNWUjN3V0I4?=
 =?utf-8?B?TEU4ZDkrSHd3UzNoRUhldUh6bHZZQlFIUFN4dmNiTXk0a09HRzU3R2dJRy9L?=
 =?utf-8?B?Z3VmVkkxRXBReTBxTitCYUFiUGpUTkhNaHNab1ZsdFVIMVN3aE5abEpnVGE1?=
 =?utf-8?B?eGhGQ09ubjRUOVh3c3Z5MTU1VFp0NVNuT3VvMXdXZmVRTXoxSU03MHhwR2Yr?=
 =?utf-8?B?Nk54b1lac1RVZERpYUc4RUNmUGUyaDc2Y2p0bVdZNWtuSC9XT2x3aVEzb2tP?=
 =?utf-8?B?UndZdGx6L3VNQTkwbFdrVURUd3UzVWl1TGM3NXpkdDluU1N0YnlrM3hzNXZj?=
 =?utf-8?B?ekVHd1dJZUlKZEJyRHoyYSt0NTZ0RVp6MEtvb01hcEJxT1VzVXIrVzlwOEdq?=
 =?utf-8?B?dVNxbDA1Mk0vN2pSSnBrTmp5QVpVVXRDVzI0RnNlcXZxb3VNbGlaZkVtb3V1?=
 =?utf-8?B?WGg1MGhrUVNDYVN3UTh1TVBNa090ayszQmk0TkJYTVNDR3Bnayt4RFN2K05u?=
 =?utf-8?B?SzJCakV2WktJRkpLVFdFalRkQjRLQUJ3NE5TaURrWm91bDRzK1dqalJnMC8w?=
 =?utf-8?B?M0tSUWZkM3RXZEhLZ3Q2NU9RTEo1VzI3NUsvd2RPdGliUlROODZDcUdVOVFH?=
 =?utf-8?B?UXd6K3g3cXl4YWhmRStNWjNQbXc1aDZvMDE0bnhFQnBqWXBxaE1aRUc1MWZ2?=
 =?utf-8?B?T1VyTk5MZnRVYjlRVTdkS2FmM0VjK3h4L3F4TUdwMWQ5QW9LbXpJcGtFM2V0?=
 =?utf-8?B?MzNrNzAyNDZodWdSK3lUWCtwRGF2Z1d0dVVPU0ZrM0RIVDJlcFNlU28rdUNy?=
 =?utf-8?B?TnBUSzM2R2tjSzBJMTZ4dkNmTlphTG1OVHUyMkpJUlRQODBya2c0ZDZOSFJL?=
 =?utf-8?B?aFpjcDIwV2I4UU0wYmZSbXdaOFZ5RGlFQ1E3UEtieXJsNkVidHZqNnZNdjVL?=
 =?utf-8?B?WXNNMDBzOVRNSE5kSTBTcmxxUEhoVk1HZDBqV2xkRWh5RGlKMTRmb05EWHFR?=
 =?utf-8?B?YmJjSkpWdjJtaE1kSFNEY1FPbXhrVWhJbjlsY3MrMGVoUElKdzJJTnVWVTB2?=
 =?utf-8?B?bW8rMnUxV3MyaHJaczYyTStTVnl4c3RJL3ZGb25MMTF4d2JNbVIwOHRBMkdZ?=
 =?utf-8?B?WjBYY1d6NWVNRXFvVXFtTm8rR2dodXV0RUV5VnBqT0hiTTRIRitjUHN3VjZs?=
 =?utf-8?B?N1lqVnBPNmFYWlVXTlJMZ0dWZkF3YzlBRGIwV25tVEFZZFNwZ3h0ZFVPbU1E?=
 =?utf-8?B?Mzloa0t3NUMyVmloVWJ6WTIxQU9zTkxtdktPY0FIUVE1Tm5KV3JxL2lxY2tZ?=
 =?utf-8?B?VjQzNXYxOENrQXVNOUtSVmVlbVU4aXJvN1NHUHBZWDdWY2ZVNHhaL09kcVZP?=
 =?utf-8?B?OU52amdDKzNEV09td2tMbkFvMjM4RzVCMmxYMEVndUR6RE9OY3EwZjh3cC9q?=
 =?utf-8?B?d2NUSUQ4RVByNE10dTFkRHRmR0lXM3FuN3MxUklkTVkyVzR4UktSNmtEZ1lK?=
 =?utf-8?B?UkZmZzZUVTdoL1VTNGxRUXgvOG1RUHJXUWFYTjIyS09ER005ekxScmJFSVFr?=
 =?utf-8?B?RncrQ01YSnZwd0M0R01adFlnd0RNa2NxY1BqUjdVTDZHUFpZbzYzcFNjUnAy?=
 =?utf-8?B?ems4NkJQRmJrSm5udzRiKzdzRFBXZjIwUUlGcVpaSks1KzRlOXhxOG9CUEhL?=
 =?utf-8?B?SmdNRlpGNHJ1TEdUSEYvQ1NtQmZjTDVpUm50dnJvQVRXNkZpNWNxc3pJOGpF?=
 =?utf-8?B?b3RuQW15a0FBQ1U5THZpa1Iyd3NNQnNsa3QyVW5OdytqQVo3K3FaRUxINnd3?=
 =?utf-8?Q?44G/LpDg5QRjTygfwvXpwJrIqz6kTSXamRtQ4vTFwMqok?=
X-MS-Exchange-AntiSpam-MessageData-1: NOV8XJ7KQEVdiQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb9b3222-9fcd-4688-a765-08df3e57f6b2
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 11:52:43.4448
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CoLVZU+Qonnb2V4fJYbvIik/mg52Nc8DU0me0SYEYX91/l+4xONwl0V1itvtVoSgYCBtSr03njWq6uUU2ys6cA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7713

On Sat Oct 31, 2026 at 2:12 AM JST, Simon Song wrote:
> From: Peter Colberg <peter@colberg.org>
>
> Wrap pci_enable_sriov() and pci_disable_sriov() on Device<CoreInternal>
> for use by the SR-IOV callback tokens and their rollback guard.
> Keep these operations internal so drivers can only enable or disable
> VFs through the callback-scoped API introduced later in this series.
>
> Suggested-by: Danilo Krummrich <dakr@kernel.org>
> Signed-off-by: Peter Colberg <peter@colberg.org>
> Signed-off-by: Zhi Wang <zhiw@nvidia.com>
> Signed-off-by: Simon Song <xinmengs@nvidia.com>

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>

One tiny nit below.

> ---
>  rust/kernel/pci.rs     |  2 ++
>  rust/kernel/pci/iov.rs | 48 ++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 50 insertions(+)
>  create mode 100644 rust/kernel/pci/iov.rs
>
> diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
> index f47974d3e76..e522fdddc34 100644
> --- a/rust/kernel/pci.rs
> +++ b/rust/kernel/pci.rs
> @@ -36,6 +36,8 @@
>  mod cap;
>  mod id;
>  mod io;
> +#[cfg(CONFIG_PCI_IOV)]
> +mod iov;
>  mod irq;
> =20
>  pub use self::cap::{
> diff --git a/rust/kernel/pci/iov.rs b/rust/kernel/pci/iov.rs
> new file mode 100644
> index 00000000000..6f8f95ed618
> --- /dev/null
> +++ b/rust/kernel/pci/iov.rs
> @@ -0,0 +1,48 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Abstractions for PCI Single Root I/O Virtualization (SR-IOV) drivers=
.
> +
> +use super::Device;
> +
> +use crate::{
> +    bindings,
> +    device,
> +    error::to_result,
> +    prelude::*, //
> +};
> +
> +impl Device<device::CoreInternal<'_>> {
> +    /// Enable the Single Root I/O Virtualization (SR-IOV) capability fo=
r this device,
> +    /// where `nr_virtfn` is number of Virtual Functions (VF) to enable.
> +    #[inline]
> +    #[expect(dead_code)]
> +    pub(crate) fn enable_sriov(&self, nr_virtfn: u16) -> Result {
> +        // SAFETY:
> +        // - `self.as_raw` returns a valid pointer to a `struct pci_dev`=
.
> +        //
> +        // - `pci_enable_sriov()` checks that the enable operation is va=
lid:
> +        //   - the device is a Physical Function (PF),
> +        //   - SR-IOV is currently disabled, and
> +        //   - `nr_virtfn` does not exceed the total number of supported=
 VFs.
> +        //
> +        // - The [`CoreInternal`] device context inherits from the [`Bou=
nd`] device context,

nit: since these aren't doccomments, you should drop the `[` brackets as
they won't turn into links.

> +        //   which guarantees that the PF device is bound to a driver.
> +        to_result(unsafe { bindings::pci_enable_sriov(self.as_raw(), nr_=
virtfn.into()) })
> +    }
> +
> +    /// Disable the Single Root I/O Virtualization (SR-IOV) capability f=
or this device.
> +    #[inline]
> +    #[expect(dead_code)]
> +    pub(crate) fn disable_sriov(&self) {
> +        // SAFETY:
> +        // - `self.as_raw` returns a valid pointer to a `struct pci_dev`=
.
> +        //
> +        // - `pci_disable_sriov()` checks that the disable operation is =
valid:
> +        //   - the device is a Physical Function (PF), and
> +        //   - SR-IOV is currently enabled.
> +        //
> +        // - The [`CoreInternal`] device context inherits from the [`Bou=
nd`] device context,

Same here.
