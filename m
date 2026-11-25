Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=2 smtp.remote-ip=52.101.69.67
ARC-Seal: i=3; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795599594;
	b=al0sA7u5e1OW7PwLDL4P29W85WjmL/cUQ0zi8QPiqrtuLlqkp0ii+X+9cmKaBzxVMJag
	 iGm2TYzpvrVZO6qxX3ivIyKiOBa6/Wd8/l/mIpvKtBbLWOylrZJDvGSduhrz6MkFjy3rs
	 A5xbC0kgn+tLVrJaGCSlFIX1BpFQ/6WAEKGpZN/eYDYLEkOHAR3dVw2+QD281opfDrqXy
	 nQOmczlOajTxcb/CdocGSON+kvKNLa6ZUANIsbmnjcZXGt7he6IOjQvxlpuFfa4fx2mmz
	 4C3VslpxqK8PEzFkIOdSH8vynaAvOa+ukR1KNq6PpjI70B5+oQxY0ATh+HVOF8eeFlg==
ARC-Message-Signature: i=3; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795599594;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:
	 DKIM-Signature:Authentication-Results-Original:Received:Received:
	 Message-ID:Date:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-ClientProxiedBy:MIME-Version:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:x-checkrecipientrouted:
	 NoDisclaimer:X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam-Untrusted:
	 X-Microsoft-Antispam-Message-Info-Original:
	 X-Forefront-Antispam-Report-Untrusted:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-EOPAttributedMessage:
	 X-MS-Exchange-Transport-CrossTenantHeadersStripped:
	 X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id-Prvs:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=/IoKp3p2fNWfiEhsj1mrgYTfa4Qr9k5HRicIBJVa//s=;
	b=qk6wXwK2SO5N1sc/ffKmbhtXHPTaXpET1jInc+CqR/OALIvzPBJ85mbT9wxUrcQH/Rsz
	 Lt9h2QCPseGeI+BKtVOr459jYac2sWwxssBPPQCYWVrD0sijiMwvEMyQ973PitphpbJVg
	 pZeL9x6AyPM35orOVGCkL2s5oat7d9Rf7LrLjWqZhOPFgtugTQnwi7P/eBZulLsVEJKXY
	 fycW2ACeD5vlX1pLz1BreAdXMIb726QWnJFdQ7PJjcK3ltwtohIwskpQrKKNjW3U+m43v
	 oLVHklme6FukmWiKhLqXGWx1q6nnMly4abPXqdVN4CP1Q00PQJDps4DKyX38vIW8cGw==
ARC-Authentication-Results: i=3; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=dlNKRSCz;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=dlNKRSCz;
	arc=pass header.oldest-pass=2 smtp.remote-ip=52.101.69.67
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010067.outbound.protection.outlook.com [52.101.69.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20FC606A321;
	Wed, 25 Nov 2026 09:39:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F20FC606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=dlNKRSCz;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=dlNKRSCz
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=KrN/N635dcNol3PzgFTNVyGklmI4vZsX0of94NNC5ek43tISj+7buo2/8AmakFfz48wTtLP9IFZdn/6xmb0MIqtIdQ7D2dCdnI+jHEzpODCnZkubY7RMc48q8SCuyhQdOMov5a7DLO/Z4DEMnzmeG2XaRYhCJNYF+ZtMZv8fgsqfFxLRZ0b3tLSfaZTQlMO94Y7Gb2ihE9DfJXaFbCmRqEBf1SWutrtdp0vBMuQyVwqvbuKPASH0HZotAhQDWvR9IYq5fpmuJWXxWzIHRH/L7cL0Gz2DOoC2UfEhEc/NYXWLgt9WBJgmU4M8AoxyBckC+0nqvgpDzfgkST4DIibx7w==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/IoKp3p2fNWfiEhsj1mrgYTfa4Qr9k5HRicIBJVa//s=;
 b=nRY3re9p1v68IPWI2mmU9kBMDGktkbK5kgknAuYtvpZzpJYE4Zl80+DbLjlBRZaGwKTpuUZyK51pYpnCKzmuTZlg0tAkGFJnrPuxNTgErlA0rac+vga5vJ64t1dO61WKQ5lGUBFReEVDdCJE76Y/XWr7LapMYWwA1BUTRFBjm8eZJo2GSACCBFaWszXPB8UAIZ1S3tTASnBPN00SeJLxCq1UgkmtR8EtniK9M8VoUa4AvFEDdp+Y28Ihd1KHDzJ8wQzoYzCTEQ1ypNU73cG6l+K3sLmXn0GnpHMGkT96SeQ/LqRJec5swe1OEsYsrK7b1MN7d/4pofjYc43jp0koRQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=nvidia.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/IoKp3p2fNWfiEhsj1mrgYTfa4Qr9k5HRicIBJVa//s=;
 b=dlNKRSCz4jm0mVlHn3kHOwQ2BEjk0d9vropoClj7FwGIPPWvWXX2cl2Id/LcTX8Bhi5uuJHHBansof9aB3XFrhRU2bUsN7Mypr2j2WzpM3ZMfk20OPq9Nq8YqrYi8zBIZZBSVp4Dat447BvDIwkuk42o6Eu5HuK+mFxe0XyQHrk=
Received: from PR1P264CA0126.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:2cd::20)
 by AS8PR08MB6310.eurprd08.prod.outlook.com (2603:10a6:20b:292::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.6; Wed, 25 Nov
 2026 09:39:48 +0000
Received: from MI3PEPF00008494.eurprd03.prod.outlook.com
 (2603:10a6:102:2cd:cafe::39) by PR1P264CA0126.outlook.office365.com
 (2603:10a6:102:2cd::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.7 via Frontend Transport; Wed, 25
 Nov 2026 09:39:48 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 MI3PEPF00008494.mail.protection.outlook.com (10.167.240.155) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.3
 via Frontend Transport; Wed, 25 Nov 2026 09:39:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=esrsQfJ8IzMhRYzt38msvr7ZySzbt8wVxK34vxPAd9FGXyXQqAVwnxaDeQd/sHvKK7NJxzw0mFWNoSUqBgEUFEfUfFxatC5rZ/siq9MjJP1zPyoVqlJScVChMzxUbJt6LCiZt57eT99mTfRsg2H+fSLPBjYcNNRDXVvPBAGBhGz58maXMpO420Q6ipzbwftioA/W5F2Telng+cJgB5fKnojRNqAqSqNP6+2/iYRtoYRGTt4Cv5KaNo+sRTs4oQURvXmlgG2FNKu9OdGaAUpEWw1FoTsvJ7yovFzdtCFCmbA/X6eGDPtTM2ZQQAT2Yvy94moapT9Ly3Zh9dfSobqSZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/IoKp3p2fNWfiEhsj1mrgYTfa4Qr9k5HRicIBJVa//s=;
 b=bqmD6ZrqdoSi2v9k6rqx22KwZcJZXmp3xKmfmUxsT7sMlo555gCkUTFUf4iId8gzXkDk7YLVgnKSB9JEIobG29pjjqsKqDaGPplGyG9Blz/v0LvQPjTg2QB784IjAhVpSaQCG971mo7yNRKF01coGgbpb0q60g09SuW91N3byKouwoXJw1L9oqJXShIlmIgo87w4u+GWbA8bBEgTsvlFGH6mi1j1PB6MlVbhYFHYCIB9VLmCLImxdevmNZiJscduEL2NwRl5MwG/6GrTT+0U3IakpZXlmCWMdBQW+Humg4xRFEnS/nKpYSc7vU+jc5tZuidGEMNqc4hN4tp/nNg+nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/IoKp3p2fNWfiEhsj1mrgYTfa4Qr9k5HRicIBJVa//s=;
 b=dlNKRSCz4jm0mVlHn3kHOwQ2BEjk0d9vropoClj7FwGIPPWvWXX2cl2Id/LcTX8Bhi5uuJHHBansof9aB3XFrhRU2bUsN7Mypr2j2WzpM3ZMfk20OPq9Nq8YqrYi8zBIZZBSVp4Dat447BvDIwkuk42o6Eu5HuK+mFxe0XyQHrk=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from PAWPR08MB8959.eurprd08.prod.outlook.com (2603:10a6:102:33f::15)
 by MI3PR08MB147672.eurprd08.prod.outlook.com (2603:10a6:290:96::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Wed, 25 Nov
 2026 09:37:03 +0000
Received: from PAWPR08MB8959.eurprd08.prod.outlook.com
 ([fe80::71d3:7b21:3594:e33f]) by PAWPR08MB8959.eurprd08.prod.outlook.com
 ([fe80::71d3:7b21:3594:e33f%7]) with mapi id 15.21.0639.012; Wed, 25 Nov 2026
 09:37:03 +0000
Message-ID: <f0cc8236-d06a-4f2d-a9fd-e60977017979@arm.com>
Date: Wed, 25 Nov 2026 09:37:02 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 11/16] iommu/arm-smmu-v3: Add CMDQ_PROD_STOP_FLAG to
 gate CMDQ submissions
To: Pranjal Shrivastava <praan@google.com>
Cc: iommu@lists.linux.dev, Will Deacon <will@kernel.org>,
 Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>,
 Nicolin Chen <nicolinc@nvidia.com>, Daniel Mentz <danielmentz@google.com>,
 Ashish Mhetre <amhetre@nvidia.com>, linux-arm-kernel@lists.infradead.org,
 Thomas Gleixner <tglx@kernel.org>, Radu Rendec <radu@rendec.net>,
 Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, rafael@kernel.org,
 Danilo Krummrich <dakr@kernel.org>, driver-core@lists.linux.dev
References: <20260929034510.2023173-1-praan@google.com>
 <20260929034510.2023173-12-praan@google.com>
 <0fe0d909-a01b-4f4f-9faa-c533b8925f25@arm.com> <awRDwxkrZjouy9b9@google.com>
Content-Language: en-US
From: John Garry <john.garry@arm.com>
In-Reply-To: <awRDwxkrZjouy9b9@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0516.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:3da::9) To PAWPR08MB8959.eurprd08.prod.outlook.com
 (2603:10a6:102:33f::15)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	PAWPR08MB8959:EE_|MI3PR08MB147672:EE_|MI3PEPF00008494:EE_|AS8PR08MB6310:EE_
X-MS-Office365-Filtering-Correlation-Id: bf39f02c-a05b-4bef-aaf4-08df4ad80bb2
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|23010399003|7416014|376014|1800799024|4143699003|261028144727099003|10067099003|261026121527099003|261021135927099003|261009223027099003|56012099006|11063799006|261021121427099003|261102123227099003|261022105027099003|261026140227099003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info-Original:
 IrfJRIacXhRx+zzuhQZhmpamSkGxk9ttVwwKvD/PhzWdn38x1786Rv54N+i/yAQFxE1zQPPbbaVJfQwVFnhE++EqHmKjvlxRXwgNmhBqCB4gvfguGkxZ/XVcsVWmPOcGAgErJUP62pkJmDE35dOWwoHt9Yn7gKj+5BPVYMfhFlERglJ+2afkjDyjTZzWYAkf07fKloGvaceWuP5cfv6b7Sd56rX9hG7GkqrWZtBYwttp5hjHDgQi8dEZQ0LKyqukC+hL5K+978u2LhksNwx7HtzEGVyYhpBtxIAJ8i72b9YA/gO/PregrizRf4JqwH7o3aYQi6Hoz+qFyL9+Bo6704HzH6k9Cpqv9CLtAgNHFsEbJd0QEZaSdSYCU0ZYnIjvds+wSWR/RBC72cfdy+hSZ27ANbtibfHzlUfIy6ZIeP1EsVe8lnd/gEoE2o+mTDUIEhYU8vJLyp57Bcs/YrWiVRPrwjE3qIx1cwGIx342v57vvToNOvGzUtAgRGtnvFRcNrxR6l3yk2mCNcS3W/zWzEcq0cP5EJcirKISqgWwINv0uwcIUvrlx7jluMbcaEwiJQqOp5Zbfbu7dQvmtib5gP+WVbKMMpaRvOHI8ICH+NB1n8roN579kW78QpydnUIbBO7t6qB6YfMYh6Lyt4v1fXIUs7t882sU+BJW2VP5ELg=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAWPR08MB8959.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(7416014)(376014)(1800799024)(4143699003)(261028144727099003)(10067099003)(261026121527099003)(261021135927099003)(261009223027099003)(56012099006)(11063799006)(261021121427099003)(261102123227099003)(261022105027099003)(261026140227099003)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 ZVXnYG4VCGa32OcZg15/uJomKuwyUbMIhEswmHMUEUkh9p8CxRlLNIM6ANAWX++H48hBhQpswpE1IBQ9sOjIYCHZ0Li7ugMol2P0RyphwgZfacKDlKBiYyPqynV6nk5L5aQmPf0IX1Ya4/GnyAWQJck+1CP0RpH1j26gl2Jbi9apwe2lqg/E23rACBLastzGQfZ8oGTkWjZdDH61RkYAh7IkBFEavNjCNT7wCG7tp/IPzB+hust7pEHeDz3va7VAKEaj2KlV4hnSDLkYUzKkQjA2H0FXNdk7p9XFkNyrsM8/Fjds3pVvf+7f1e1HIF70c2jHD9xu2B2+EE81/SdxcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MI3PR08MB147672
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 MI3PEPF00008494.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	133423be-c1e8-4abe-4b62-08df4ad7a97c
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|14060799003|376014|7416014|35042699022|23010399003|1800799024|82310400026|10067099003|56012099006|11063799006|261022105027099003|261028144727099003|261026121527099003|261026140227099003|261021121427099003|261021135927099003|261102123227099003|261009223027099003|4143699003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	D/j4ROPSh8FxHKg6GyZZBoEhJyKYRJg0skeCSB0k9CI7766px4p2p9KdurLOQcxqR1x6Tmb/PFBj/m0MteaLqQioaSZdHuqcERLFiIY6X4xv0nQ0L5+e/0UDcuHoqLSx6ShC+KpSLgzEU2t/4vIHEQenTgujRB/KTgHf6Z+mv1zVK/dmzRxzO+bl+HU7lmVAEUGvkkTFVX7KCkElGvLVQ0FhL1Qdwy8iST1SJyLi060m/N42SGv2kMjWrnfa76nsxmQw57qybyS7a/3cA8U/Id1489rrS4tC1QZBMAXniq+Q+DQv4Za8K1jEAM5HI4BPB38n+pnPdXzzOPjWXM6fUm7yMHqpeIN3UF4PyZtO7+zMzPLelgRZhxwYZ5XtEjXOhN50Cw7juKDkI2qQfBz0NXkm8WFeq7QOJxlz4kA5W0WLp2LTWlUlH3sxXsoi6N1EwI4aGGuHODu5VuVk+iTzBptTeNESv7sF2L9dyv4Ps9Ps3O/RCeswBpwPDq9xH+cXmrdzO7O24QmMsfKG42TvWX56uXv+0k8ltaREJ8QH3GOkHHNdwzcyhau4/BmApxaTw4Utl/JImN60sgD5FnXWWDWNXOMfvc9LQ46ttnMz214O9TPeo2J+cxla6g5JjLD+NzIc4vzc3ta0CjtZMtyNUuJyQq9fWRSxq6BMd9PF3fFUmsox2WkQPxXJND7SFBqcqlckZRXjPuhYsme6K47Mtw==
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(14060799003)(376014)(7416014)(35042699022)(23010399003)(1800799024)(82310400026)(10067099003)(56012099006)(11063799006)(261022105027099003)(261028144727099003)(261026121527099003)(261026140227099003)(261021121427099003)(261021135927099003)(261102123227099003)(261009223027099003)(4143699003)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	C0BVN4NM6NuS6NmvS9TwFWwz2yDs7dEZfageqFUv8hIVl6/XRLsXRvmv0mlBKsnE2u77E+y4tFZAwRaZAnwNSHTiRtsoMinYyYrjul+QLYZoWGMLjGsScUDfR1LmfgTvR0kflTEckk1vbDL3JRosA7zZv8TqGSZPrrWwncQ07Rg+hB+Yehc8Tz4hrb5h4Wa3hGBXUx/eNH5xacJon+HkUt3ZShqdFimHMVy80cOEBVmIzoSROWoMUwyUSAm7hf3WHITfLygZQ5ckJdBrG6AJqJJ575hXs+g+U2jy48w9uSgSa/f6ft18MJ5OgFr5CZlpM8EsVFdkxePuIfT848klw0RQG5eHU2d6E7kOf8miYW8Gmau/S0XOOfxELdN2jUMcNUFvUAyHQ9dVpBN9dt0BXVCiuobjK+/x+AKOK4T+MoGrjw1Kno8dEDsEiXFNEGdb
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 09:39:47.7787
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf39f02c-a05b-4bef-aaf4-08df4ad80bb2
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MI3PEPF00008494.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6310

On 11/23/26 13:46, Pranjal Shrivastava wrote:
>>>    		u64 old;
>>> +		/*
>>> +		 * If the SMMU is suspended/suspending, any new CMDs are elided.
>>> +		 * This loop is the Point of Commitment. If we haven't cmpxchg'd
>>> +		 * our new indices yet, we can safely bail. Once the indices are
>>> +		 * committed, we MUST write valid commands to those slots to
>>> +		 * avoid indefinite polling in the drain function.
>>> +		 */
>>> +		if (Q_STOP(llq.prod)) {
>> I know that there has already been other comments on this "stop" flag and
>> whether to use it in this way... but, if CONFIG_PM is unset, could Q_STOP()
>> ever return true?
>>
> No, the flag is only ever set from the suspend path. Since I'm moving
> the PM bits under CONFIG_PM in v12 anyway (per Will's comment), I'll
> make Q_STOP() evaluate to false at compile time when CONFIG_PM is unset,
> i.e. IS_ENABLED(CONFIG_PM) && (p & CMDQ_PROD_STOP_FLAG), so all of these
> checks (including the one in queue_inc_prod_n()) just compile away. Does
> that sound good?

That should be fine.

> 
>> And it would be nice to not add extra logic in this loop. It is very timing
>> sensitive, and adding extra checks can increase the chance that the cmpxchg
>> fails (bad for performance).
>>
> That's a fair concern. A couple of things here:
> 
>       - The check is on our local llq copy, which we've already loaded, so
>         it's a bit test + a (not-taken) branch, with no extra memory access
>         before the cmpxchg.
> 
>       - Per Will's suggestion, I'm making arm_smmu_cmdq_poll_until_not_full()
>         bail out on the STOP flag, which lets me drop the check at the top of
>         the loop and the extra READ_ONCE(), leaving a single unlikely() check
>         right before the cmpxchg.
> 
> It does need to stay in the loop though, since the cmpxchg is the only
> point where checking the flag and reserving the slots is atomic.. a
> check any earlier (e.g. in arm_smmu_get_cmdq()) could race with the
> suspend path setting it.

I just find it odd that we try to elide commands here (at the point of 
command submission). I would assume that any commands would not get this 
far - or even be submitted to the queue - if at the point of entering sleep.

Thanks,
John
