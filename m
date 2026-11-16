Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.1
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794834064;
	b=GdMw94bbMuxHHDZJ6umQxhdiIXLktNT0gkLaCU28geCaz2C7ajUPktliohRab/b/ZfGk
	 vhwvYqcdmX50UnaI1GsPqA3wF8bTMsYyjh91I/Rj9HYOIXnUlDNsPOA117RJ1kCURvsTN
	 pyb0Ua1RIbldBiUONT44NrXU5gFMtQp257c36LVVRzY3E2opQfTdA+/Mq9EmKdypDydo4
	 CuTzfruwf7qPokJtVYRgIv4yI7eFvrlr+1CChTzQ48pxdJ68bfl70eFIE9gGGbAjDBw8y
	 FUZ+IDzs8N6vOdpMNLPrMD+3UhaCBC8JKI+yrEwwIlnXoibVaw6RvdERU3nhZA5v1kQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794834064;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=97wFEUDIQVDxHvljtqzPfBxhwFcxCip8CCg09n5TtB4=;
	b=mQ6bxYBr0KViRc6ieupYW9tQvnS+NMdTufaC8P/uXbUi4B6NdBkK9YDtVjuroT8ka7ll
	 QzVe4RBUFeFA9zTL2wGFgny/1fkhp/QNILHxKwldyt/f4Mv8kRxH3NzclnKaT01d90Hyx
	 iSTwhryBJ+JH/Z7X/uP/zpmU3iM1KXsq0IypbYk4gcOwuAVbDKUioXNQOZYtHkFTT9U3J
	 3/yGF5+t/hofMlSiSVc5NtVGzH7JUMHU4xVR1IKwZejKf9HhagltYdIxjhQ+0cOXtwpaz
	 jHY/+aBj2W6uDg8phqDigQe2FZ7cDdTaVKWILmW6bVW3k72B0RkJfFZsI8KU5hUnx/w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=XE5DvEQd;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.1
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010001.outbound.protection.outlook.com [40.93.198.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D24C606A31C
	for <linux-pci@vger.kernel.org>; Mon, 16 Nov 2026 13:01:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3D24C606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=XE5DvEQd
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X2kSDKaMrIb4d354MpsJjqk8L2Hn+hijZ+nfAVSH5/kgUk6GgJ8TzxWAaAJ7srHINh/zTyzaHZ/R6nx0XdEd+Ek4N/Oi8+SEnoxy9FjDdLe0Co4QbEtYare1xZcwYoQSlNuWes8AS3GPTJltRaOK92jvtIZZ/LpFF5HVy6crtsWn9MPLrhGZ521+1P+gtlujsENr7sg0zbwsNLb8uAnmELEKaHC8eGpYtZtjCMaRSjQcohOfaQUFjPEALIXhz26hKjFAzXiOTTRt4VB9VhUmpiUAvV4IJrhLkTgXmKpMyZyBvpiSWh2FOA+A8lamdNCTPy4a9iWhe2RcrGoUrbaGoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=97wFEUDIQVDxHvljtqzPfBxhwFcxCip8CCg09n5TtB4=;
 b=u4GlLsL1b7sWy5gvLAKjgrHjrrSaqfoBTpKNAmt/cDcroz4cuzhpXCKHn/DaRTiY/pOMKJpXNhvtXDswZmHyOikFznOyQJ60Yc+5vG071OvtGRcYILs+7tQJLS1vb1bYNWAopdAaSnhb+540nE/dkUnkopyvCARgWE2O88/WAnaskRQj4UmQ9w58K88DXjkqYGwYk32gRjKXaT9cceWY/AP/6T1v+U44iCxBa7oHfcmVwKliMwqla1Hb+Yn5mt90y3CZdSgTYmhKYhR8DqBIwsLtPGJSoySjsfpNe4Watsy3jxTRmOrK+imH8dJA8PGXoRPGAZbGVqn0gvo9fo9tbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=97wFEUDIQVDxHvljtqzPfBxhwFcxCip8CCg09n5TtB4=;
 b=XE5DvEQdGqnCxZN4x963zjZRS3oyAZnLjGn+i28EBFgNrXU90MdYMq1COkpaBhJS58u6XY24JNcAovB/Q1Wgqa9MpFTweo8NWnEpohmSxbNeUxz7aVa50gYWI8HT5185BgYlebAlsieqm4iPCwMS+A4LZGu5gQFbmgOsnaTaxJPYZduJFVLJq2Wl8v3jlP1+0QpljQjKC5fc3Y6yk65Yp/bQ3X/tN7aarJj4KauxbRw00BFd1Oy5B3Sum7TM01Y4GDyZBQEb5aLCUNnf0j2GGwNlglTvIZbNRtMrXR5bJ2K5BK2kNEOde2b1BK7SFthbKseSNXaBpuOPv+EEVkgd9A==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12) by SJ2PR12MB8831.namprd12.prod.outlook.com
 (2603:10b6:a03:4d0::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 13:00:57 +0000
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d]) by CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d%6]) with mapi id 15.21.0615.013; Mon, 16 Nov 2026
 13:00:56 +0000
Date: Mon, 16 Nov 2026 09:00:55 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
Cc: linux-coco@lists.linux.dev, Alexey Kardashevskiy <aik@amd.com>,
	Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH 2/2] PCI/TSM: Move core code into its own directory
Message-ID: <20261116130055.GB1850935@nvidia.com>
References: <20261116075420.76205-1-aneesh.kumar@kernel.org>
 <20261116075420.76205-2-aneesh.kumar@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261116075420.76205-2-aneesh.kumar@kernel.org>
X-ClientProxiedBy: MN0P222CA0015.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:531::24) To CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12)
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
X-MS-TrafficTypeDiagnostic: CHBPR12MB731189:EE_|SJ2PR12MB8831:EE_
X-MS-Office365-Filtering-Correlation-Id: 97144304-d6c4-4e35-d8d2-08df43e1a740
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|11063799006|4143699003|56012099006|261026121527099003|261021123027099003|10067099003|261009223027099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Jsn63dTjUv61jDWWnpNAepr3h8VdLF3wqQOoQskYsaCsAU+PPQvdH68bVmAqprCreTRiw9izwEsPhxmjRXDXjmSKMaWVoRvKT6JL0fzSWa1jvZKm3GsE/uUY2S1sZzz2NHg6xXx781VsjH5xx2pzufBkHaTrOoTiDumMg+Uk8uXmD96Gm8tIaqlcjml2UPRxbFl5RVG9Cfd+Bl0qCJNgFAU7kkH/RxnJ8tABme8ouE5OSoaCqxCpupv6wmqoO2MlHo/PahaiWUncmvjUTKFVtg/aX1HqNAwmJUaLCAFp0fihaczdFBgZc5FoOQI6UhEmiu5ezdWZUAQscdBNaUjvKSefCKbreJ9tm8Ukfh9J0IQWk+9mZXdVXhJnsXlhD6SieMw65Bpg66L119cRqp/oi/DfYBJVijAqF7ACxrs4fQbUqkN32PjUkUReUdoaqDvWz367IHzlhW2WfJEzPp8e7+6xCJYvDyWEuuuqjGXvQ6A5KrGifNqj2Ivm2yosjAnECRZWzbFoNrnRFz2E0/kXznf5gJS0KLAYExquLMxGliY6l4yTpHpo5koCmx5Y9Loseohp/QDRfAJtOtZ0S6d12OSThBewnhQgPnGT7M9nI0fZa/dNVWlgb1K4xmwTMkUHvcffCu1PRlT/rQvEOA4h4HSYu41JVtvHx05ePOU1NLs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CHBPR12MB731189.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(11063799006)(4143699003)(56012099006)(261026121527099003)(261021123027099003)(10067099003)(261009223027099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TcOFdHD1zEhaQ8Y3KOrOpeWjGcO8Zkh3U7G2UOGRF2cMVOT+7DEDd0Jmw4IV?=
 =?us-ascii?Q?CQq9BqUq0qI5YyUkcj+l0iQzaH+SMAJKrtc2I2nKbaGYQWWIHwzB8nTEMrjG?=
 =?us-ascii?Q?tUIfA/bElcuE3/a1p0yYKT9nQPREZ2Qq1Nsn/qftApln62rSTISmkj6QCWsN?=
 =?us-ascii?Q?7n0N1K+w+rLikUR/m7wLo/Gxx3gQY+aDSml+1GZ5apahfH62DgUoFL8+5h3e?=
 =?us-ascii?Q?wR1EKNRWYUNfTdiowl2cIVkXdTo8s/PafTB8bDyERQcZKtvr8hDAaZndORHS?=
 =?us-ascii?Q?PGGIW2ifmbS4aI9RLKc6bfdlmtW286xBqVeZkuFSOkUN7l/isjgUSzIEvNlh?=
 =?us-ascii?Q?U4qyQoTUSltsHj5M3Ts2g/qj2721AbE15Fs0yawsfjLn31MunseeX50FXtOg?=
 =?us-ascii?Q?D6v1w78pG0IvuUwOnSbQaZmzYHF+tU9nvgEF2trGMbnmG5+hQW68XlZ8kHn7?=
 =?us-ascii?Q?ouklhzxMCZPdloEOo+LD4QRXr8y6LHTn5j/Vrmw/hT8Vs4RVDBn1TETigBwg?=
 =?us-ascii?Q?JDFq5NoesxEryeloSjoc9X+OS4SLyKh2z4ZDkszHmi/k15+ZqlnNsle9Rxaa?=
 =?us-ascii?Q?6WRQ6/xuTdbIapCnF13AgocGKHVCF4vVMIz/tMIanNnqRRaKxxc1613TbNZD?=
 =?us-ascii?Q?Zhn/RBxhRFvef2UbX8yrphTx6KRUodLGX4WGx96hMFwakZOFtJyrOElXE98E?=
 =?us-ascii?Q?tMnC8IInBQaM0y0vzYmfBknI2TJqI8o/sfYuX1eXmpBsAVcP7l01mjIXxjau?=
 =?us-ascii?Q?EiLI3T8VrOyUfX18wzgYpimH9I8y58WAKLL5Ceiih14VbnhNKCHA8I8DsKzq?=
 =?us-ascii?Q?ZJ1IZ9kAx3ZCmN661WkmYWjthZ6AyosVJ9ZoKyCQjSRBv5lLHkJW+ECzMxqx?=
 =?us-ascii?Q?nsaN4LsXjsSZ8FGY2sA3Ef3h809AT1RGuNWiUJadspTMdTfRqgVSaaFYhsm6?=
 =?us-ascii?Q?nl4MlZvUPl4jsrKcZnHDsUSm3qIjkcHM25nFwTSMLYKTNu16n+O1xyzYUiql?=
 =?us-ascii?Q?Co3jdqgt6fAK5uCTc2LFOis8+NEvOcvudIBHaDh44gi5xTe+Q2PfOoPOztJf?=
 =?us-ascii?Q?DzUNZ5ZuIaUOI0MWx3VCaEJzJ88cab1cEXZmnuUIjmPN/+g2o3NS/tZ0nkIK?=
 =?us-ascii?Q?wJ21LYpXfPSV6ZC2dhPD90jrVssyraCp4ABou5bLnTMSqS3g01VVKeDDq2+h?=
 =?us-ascii?Q?fu0KxuH1KUKb0ujsPzlO6YKhHN8ZrbTT3s5qstaf1xQK5IjhaLdnsBjj70oO?=
 =?us-ascii?Q?PZs3qBA3ssS2qYIBL4aSM2jIJhYKE6WagAKMvFjb5kD22/P2nPnhP/qMqDW4?=
 =?us-ascii?Q?l1SqZG+dq6eoo68YE6IgN2RkHTsp5lVuuAzqT0A1ye2WynZ8IaWYIAac7Uus?=
 =?us-ascii?Q?Cd6IIwSQTBOJa8gz6PWbMP6tXqypShs4XmDphxZNZLItPZEiHRKo+Nf4otno?=
 =?us-ascii?Q?sgEG0siWlUvKwpYaxfCFkDZ+MWWYRiaIj8RUfm7YHSdB6f7AgDxia7XgjhnK?=
 =?us-ascii?Q?vJ9vBpKW27u6K7uP02cV1WXF41f2DxQQULxAiQQaNJ87SSHBjPQgCNxqOPqO?=
 =?us-ascii?Q?Yu0DeBIOci5yERt+j3BqhwaT1ggDnPtt+FuLRgzg/PBaX21fIPnt35kUJV//?=
 =?us-ascii?Q?gE4yH67h0bawvuEFz5J5xpAdYP0lhAY1+s8z0NB4+rj/NUp5qdI0QOR+GYe7?=
 =?us-ascii?Q?+enGUMThiKh3odyx/KivUwAStxZpOIhpC5xm0NWERKK+m+MO?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97144304-d6c4-4e35-d8d2-08df43e1a740
X-MS-Exchange-CrossTenant-AuthSource: CHBPR12MB731189.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 13:00:56.3569
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zb9Ab8AS+qNwK3LGMJ7yR7us3Qss0UwWQFfYjlIZn2ThB//zysQxUJ8KKz6XsHsf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8831

On Mon, Nov 16, 2026 at 01:24:20PM +0530, Aneesh Kumar K.V (Arm) wrote:
> diff --git a/drivers/pci/tsm.c b/drivers/pci/tsm/core.c
> similarity index 99%
> rename from drivers/pci/tsm.c
> rename to drivers/pci/tsm/core.c

What's the point of a subdirectory if there is onle one file?

If you were to move it to drivers/virt/coco/tsm-pci.c or something
that would be more interesting..

I think we are going to delete most of this file, right?

I'm also seriously wondering if adding sysfs to pci devices is even a
good idea. If there is only one left we can just not do that. Then we
don't need most of the file..

Jason
