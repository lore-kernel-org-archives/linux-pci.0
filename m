Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795505696;
	b=c7wyb5Ur0NuGZro6DNDAlIXEzMcleW2qrYnoBuPsRedUeLICdyo88jNyNXzN0ay7e3U0
	 8+08x5g1tUvYVwAfXtLu4+TFWoGCsu59bZ8RiIRgFo5kgGL2CPuAp2bXUYaYfCxAtsrt8
	 vsDrfyPk7kNa+oHAh3c0ufCJgACZKSRZtLDlZuRrQld7W2c6Q9t4c2cgnL+8NmMFo7iTG
	 Mjp2E2rlYVRkzt+nCmPn7Ek/oaEHyEUSAbJyYq3ztz2DQ/+CFUxExX++SSo7N6YoL+V+K
	 g2SWa1J5lnVjqFosA/8W/7L10ShcOlyQclGeDtCCHNwDdDKaVpaisr+m46YfUzwGODQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795505696;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 Content-Transfer-Encoding:Content-Type:Date:Message-Id:Cc:Subject:
	 From:To:X-Mailer:References:In-Reply-To:X-ClientProxiedBy:
	 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
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
	bh=fdcoAsWvWO2jv/aSRfq0/jxWCaYSsP3r7HcxpZ/ZI1I=;
	b=LtJaQdFsBrSQ56DldHXm12hv1ZVgaeLX6WBYoL/UBG/FRtKaBg57+kMYr5b3d3LZKbM6
	 llkjYpY8jOBbJvVdfDxJQ74BHT/bSlGr0CPlNu2TN4Uvs2w9SONda8HdzRqStUZmdK83+
	 Gtg2xEW9K9wT4SOz3pK1/TrBJmG8wFIdInF30AUZjwz+4WvpicjhbUXMx7Plrj8dbC6gM
	 VdrMI5m9Gk56lRKfANSCX0rO47JWqpwEWMa5IAX4BxL1Hr1cdb7YfttPeQi23JWqwrgzf
	 TX6X7N0SBscxrWvDu+q3BL7i7Nw/7TQvhPqAGPN85/GZywDlkijw4dlrO1h8DhijBOg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=BAP+vGUu;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.42
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013042.outbound.protection.outlook.com [40.93.196.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE595606A31E;
	Tue, 24 Nov 2026 07:34:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CE595606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=BAP+vGUu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qg8DXoDM3HITqajZ28yUfNMbkqPYW70/0Do3iP6stpXH0o2oeh9POS7brQdD2O/HPENmi5mDUJy+8ZijJwoUMoZ9eHIYKgSZhx3YQgixXxZ/yFHqBz0fREL5ld0TtycORwalAmbOnyp0rNlQj5ei6oeiFvCEfTvSsfNh6J8UtQAnPfYhgCpGteWj61EkFXlcFleA62B9d1uE6j/NhEnIKxx5whx4S5dpXiSlLRx+ED5OmQjQF7VSqKf91hFhOBItPS064Yj3TKPYGtiKT0ow3/qgj8Xocis2yq8jT2yPYGMqwU4lkGBtpsHCsDcXC7F3POYQe2NebgDb+sp8iUa9Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fdcoAsWvWO2jv/aSRfq0/jxWCaYSsP3r7HcxpZ/ZI1I=;
 b=wwAe1ORutq9depjzO8ahMU3YkSLqjntjnnYd06WOBjMxb1Mjb/BsFb7Ue9aQtFg0z4FCCe0dgO7wu14BeOKDKfW7PLII0V9KF779Usvofclq6I8ccPWsTC+AlISJfHJ51/kQdEdh2Ep55c3Xob/HtVuJwAF9Gbb6TSjaVRnw83AUi84fphS41RK8LW/5mWw3sohXE/NXsK7mipyB6FBYfeRCaO7zpeAL3fGxrD3PjIOUXlOPAppc5CJhMBRzfVhuI8s9RuBOtT+uiKYUgrhZnzEgA7HgmJLpqrvR365gQwgIX8oDiJ7VOvEEnomFdwF+Pu6wegniFF5UQWcht4LUIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fdcoAsWvWO2jv/aSRfq0/jxWCaYSsP3r7HcxpZ/ZI1I=;
 b=BAP+vGUuDRIOSKrV7ewThX8+zOnDmroapFu0p2G1BSEmrm1zUlPMgD2vTao2zYLg5EtEzsKhRInFjuTrnr9XJRo/TV2hoE9Znc4cxN2RRp95c59v/pr9/I9g41WNQEbngg9bhJE+CkkGEWLZJbMDbgYKjVL5BLAXghjlfck5Ek6NQTL6rg6cRiN0gNSbAMtQTF85Eyu5LYmmgIY2cHHbb2vbF0FAvvczn4vOzet2T66pGJdqKTJZVdFp4BMz8vShs93bWwpQcv9KumjXv1tVKa/hvOx0DQZt2dbFBl+JlWobdcAXrw08GumwuYyrVdpDygDFgydkIqcBOfyfSi1nRg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 SJ2PR12MB7868.namprd12.prod.outlook.com (2603:10b6:a03:4cd::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 24 Nov
 2026 07:32:51 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%5]) with mapi id 15.21.0639.012; Tue, 24 Nov 2026
 07:32:50 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 24 Nov 2026 16:32:47 +0900
Message-Id: <DN39LQHCKTBT.22ATMR6WVSY2W@nvidia.com>
Cc: "Timur Tabi" <ttabi@nvidia.com>, "Alistair Popple" <apopple@nvidia.com>,
 "Eliot Courtney" <ecourtney@nvidia.com>, "Zhi Wang" <zhiw@nvidia.com>,
 "David Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>,
 "Bjorn Helgaas" <bhelgaas@google.com>, "Miguel Ojeda" <ojeda@kernel.org>,
 "Boqun Feng" <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Daniel
 Almeida" <daniel.almeida@collabora.com>, "Tamir Duberstein"
 <tamird@kernel.org>, =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>, "LKML"
 <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, "dri-devel"
 <dri-devel-bounces@lists.freedesktop.org>
Subject: Re: [PATCH 2/9] gpu: nova-core: falcon: factor out the wait for the
 GSP suspend
From: "Eliot Courtney" <ecourtney@nvidia.com>
To: "John Hubbard" <jhubbard@nvidia.com>, "Danilo Krummrich"
 <dakr@kernel.org>, "Alexandre Courbot" <acourbot@nvidia.com>
X-Mailer: aerc 0.22.0-0-gc2f86b7abde3
References: <20261120044704.165223-1-jhubbard@nvidia.com>
 <20261120044704.165223-3-jhubbard@nvidia.com>
In-Reply-To: <20261120044704.165223-3-jhubbard@nvidia.com>
X-ClientProxiedBy: TY6PR01CA0035.jpnprd01.prod.outlook.com
 (2603:1096:405:3bd::7) To DS0PR12MB6413.namprd12.prod.outlook.com
 (2603:10b6:8:ce::10)
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
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|SJ2PR12MB7868:EE_
X-MS-Office365-Filtering-Correlation-Id: 70df0661-949b-434d-b5bc-08df49fd24eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|10070799003|1800799024|376014|366016|23010399003|4143699003|261026140227099003|261022105027099003|11063799006|261026121527099003|56012099006|10067099003|261102123227099003|261021121427099003|261028144727099003|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	RV5Tklh9NpNlnnsFtd1erUo4dFwDkcmfKD4s0Zsg3Jw1m3BTFHdtgf4bxcXBwVAwof8mSmpcm3/y+ew/MyEl6KHKgc4tjN4952WZouQ/NUCfjskn3HL9L/FAJFA6rnTkkzYxxWS+ub+VMe8I/Iz+RinAuvNpEWnFVDWuGQwTqpBBcSY6PfsBPTe2BV0dltIQSvK2wJOvEbuusAISG8qNn/B4Yd2wfslMtKGn2Xk8Zqz9KT5q7VxfLb7wPXBXOYNcDMesCV+VnKZmMJVh+Gdwt/xsCLklT/8+6gfh2lb9wzJ8pcHD7cEmGnZPJPm2xq6E3Lh1Hg5M/7Z+GV2muqsxK4FPjPWFOzue9eg9DCKo4YAs6O/7DQIEHuszsTpqw7/ZdmoHnXMWuHTw8pzRFimUo1GXoIw+tZrDM6xZWTcxcq1qkiHEltgb8feIPMPwyX0/izPtpvZKs2SP7nNsSidE2KgqM8Kxd0khMpL7wsZklta6Sd3xCYN8ig6zIWwY+/5rCoHgchTV751P1p0oxegyoyoNESbvWql1w3ERs2A9thnbL8BfOJxUdHvx/x18Y9ex+GblQ5i9MYpaUss5+zG+VWgw9TnfMA8IQYN3EHe8xgmde+wsRmKu71HrGMBx+JUgBbpmKbdruxbUYa44orZtvsclBiZ07sF7XDYO/YBjaAY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6413.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(10070799003)(1800799024)(376014)(366016)(23010399003)(4143699003)(261026140227099003)(261022105027099003)(11063799006)(261026121527099003)(56012099006)(10067099003)(261102123227099003)(261021121427099003)(261028144727099003)(22082099003)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bW1mOS8vVEZidjN5Z3FSZ1FNWXZBYUNDYkRhYTQrQnRFTnppQ3pjTldJWEpv?=
 =?utf-8?B?OEZqWXo0bU41OVJrelNxV3JTK0xpOXptMVVDM2tJSmdhQTREWHBUcm1jRXNu?=
 =?utf-8?B?MjRwNkpmdTZPOTNzN2w3Nll0TU1YNmllSGJ1YUVsSEd5endzRkVYbTE5dE5u?=
 =?utf-8?B?OXN6MzNta3J1Y1llWmVDNkFZQ3VSS0R3MFJrTlY0bWVNbEt5bEhndzBPakdI?=
 =?utf-8?B?QTl0SUs3bU9td3Z0YU03c3I5MWhXdlBGdkoybzRBQWt0ekdmM3V5Zm5QVmxS?=
 =?utf-8?B?RmtHN205bFZWVm9RYitLNGNBOHNBSHFYU1JwNHd5cDJzL2dwZjNjVDJwakhR?=
 =?utf-8?B?ZlJkRHFDWVZUelhnWWFwMzB0anZPc1ZkOGJCelZaZnQ2SFB5cE9ROGE3Vm5X?=
 =?utf-8?B?MndNMldjOGZJRnVFOUk3SFZKZ0lOQnI3VUFUV3BSdnEzSjZPUElYaU9hYlFz?=
 =?utf-8?B?TU9zUE9OYThvV2dLa014OFN3MDlLUFBjUTdnMGNBVDhISjhWUGVFV1NMQ2g4?=
 =?utf-8?B?MjU5aDI0cWRwVEpzVXk4NFlISDdDZ2xUKzRiK1NVK1lCM29zNDZnQkJyNjJ2?=
 =?utf-8?B?VkE1U05kTFIvclhrR1NhZklROHI4OXp3c0hQSGxBNkw0Ym05TXZpT1FzT2ZU?=
 =?utf-8?B?ZmxGUFJFWjhvcmZ5eVdXRnFjN3dmMm1DNXpvWXpEYjZXbjF6QlhhbGJyeXNq?=
 =?utf-8?B?S3loNExJUGhWS2Fjblo4QWhmN1psNDR2Wnlnck1BYmNXYnBvTDdwdEJ5N3Fy?=
 =?utf-8?B?T05DdDdMZGQraGxCOWZKOW9MSjFJeFVKUjU1cFg4M2R1cGVTb3doL1ZHQkh6?=
 =?utf-8?B?REVsd0NRTXFjL3JaYTVmMmEySnNMSlFoUjU5a0QwdHAwVUZkZVUvWnpGQ250?=
 =?utf-8?B?aHJhUXR5VCtjU3FxZjhGT1pHSXVDTXo0aDViRVIvSGtJUUJvU0QrRm5pWStT?=
 =?utf-8?B?SXdiMkNHVlZ6QmNLVHI4ak5VT0EwVTVXaEZqZytnK1NiNnpUZnNYZktnY1BD?=
 =?utf-8?B?OVZjYnZETGlUUWxLQ2FVZ1dtMnJzbUhUVVByVlFrcXFXNUNWKzRxRklFSzNn?=
 =?utf-8?B?Y3FSRTVOWC9KWG1DL2s2bDVWcTNqTERZNUk0azRmVmFDMWFZbFFBRllJTjVk?=
 =?utf-8?B?ei9kWllZUmR2QXBGOTJnQnFhS3MyVHZySXUrL1lJcTVDcXV5ZW9sMnB4by9t?=
 =?utf-8?B?QWlXQlBFNEpBOVpDaStsZ2FFT0twaFMwRkduTmtwOGNsVW5rQkk4d2xZaXJK?=
 =?utf-8?B?Z21yRURMbkVPSExVT2pPWDlHWUpOWlNtSjAweDNoaVBFSW5iSm5hMlZMZDRU?=
 =?utf-8?B?Y085YVNveDlWSkRTZ2JtM0kyNnVmckR6ZW5vWDFNTmJPbGk2Mmh1UXI0ekVy?=
 =?utf-8?B?bFJUY3JBVGRuYklSTUY0SjhobFlEeXJsV1pVbHllMXo0Q0NnbENoS21jbk5o?=
 =?utf-8?B?czNuZHF4MDV5eUcwc3FKdWh2Y2FqUXVlY0dkdVN3Q2VjMUNlcUg0MDBwY2Zh?=
 =?utf-8?B?WFBSZ1h2dks4SS9YaGtEQWZ4K3pQWDI2R2h1WGZ5bTJXUTRPN1J5M2JsbjVO?=
 =?utf-8?B?NG94Z2xtRDYwMXFPV0tPNjA2QjlRcGMrY1VrQ01HYU5qWU5WVUJXNmJ3aFlY?=
 =?utf-8?B?aGJUWFR6eVNqdnk4dzk5M0l0c1BTdDBDeE5oNkJFd0Z3YXRKUnVYQmR0QU11?=
 =?utf-8?B?ZVNmS3JTVmV5bnM5NWxiYWJQVnY1VlcydUoxNHRaWFRXcEkwcTdsY1hHdUNW?=
 =?utf-8?B?Y3R6d1RwMkRwQ011c1kvNU45QW5SUS8yVnhJMUsrcUl0emRoOURsYXNBOG5n?=
 =?utf-8?B?Q1JFK3Vwa0N0YXBOZGx6ZTJwZ0pCYXVEQ2FKcTJSRzlvb1VQS3IvZkdRYUxN?=
 =?utf-8?B?V3h5d2NLR21ibVJXek5YcGJIakw2OXpzTUlnTFJ4cGN3VzY3cVJuRlUzLzZT?=
 =?utf-8?B?aTJkVjRqVEppMXFURW9IdGt3V3JMeTd4OXMwM0NhUDExYTlSalA4QUdCSGps?=
 =?utf-8?B?YTVhYmpXNFcwamVOUnhTK2h4ZmhkZldoS3QyZ3JkRW1PNUNQQ2QwcVZoUEhn?=
 =?utf-8?B?TFllQnBJRmt6VDJpYzRGY1MwYjVHSXFpWHBwTmpnV0NicjdINVdKdjk1YUM3?=
 =?utf-8?B?eXVYT0ZWdlFmUmJCcnlPRFRkcWRmRUNjV3ljRWRMUGdoWFV2V2JtdzZZNUNH?=
 =?utf-8?B?M0RMRDlvMStDdnQrNVRKZTBVd2UwZEFmMzBsN1dIOG8xT3VMa3FRY0tTR1lz?=
 =?utf-8?B?Mmd1ZG9SU0dPNGcxaitiUjNDenlQb3ZndzQ1K1hDZHVsUE1JWW8rd3pYdGRw?=
 =?utf-8?B?OTlIaW5Ed05kNFN0WXZRb25Wb1plaXJuYTVFMUl2Z1IwYVRyNzQwc3dlT2Ex?=
 =?utf-8?Q?izkY/6NFXwxtDDxm1FY/B0Ll0EvZJLFt9FGHLYFEFCXfz?=
X-MS-Exchange-AntiSpam-MessageData-1: UKLwqge+IlyFJw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70df0661-949b-434d-b5bc-08df49fd24eb
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 07:32:50.7561
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DgOtr6rscBJo8jkxlk7ydg0y50jNFCaxEOZnLRisP02GCJzeWiy7fJS3TLE6d64MBKdsiM/kZBsClw1SuiIElQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7868

On Fri Nov 20, 2026 at 1:46 PM JST, John Hubbard wrote:
> The r000 boot protocol requires the driver to wait for the GSP suspend
> bit after each load-and-execute event, as the shutdown path already
> does.
>
> In order to make the wait available to the boot sequence, factor it out
> of the shutdown path, into a method of the GSP falcon.
>
> No functional changes.
>
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> ---

Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>

