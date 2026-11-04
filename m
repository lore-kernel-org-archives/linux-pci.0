Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.208.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793827992;
	b=r0IlYhvG1S1zDP33SA+dDJMLjk8wMtcTFTeiRlzh+17HzqORQYgnUuiOMGM6I6VYXi2F
	 yw48ob4GHuGOQObEGa5lv1CGUtG1AVWPtRQQ/SDvxuudw9O7hGr6DD7t9QXJrUxB6H7pm
	 WFZrV0SFOlLhUI7im6HacJTROfWQM+YRt14auXJkj5BhLOd8f20GXwTkVDQehveZ5RT7i
	 ZcF+MJ1nWxTugUYjaRGT5x/XxUXp8XzX6NFgkfj8nVV4eqhJi8RHGTcn9dBIqoDOODWtZ
	 Lp3jk+jk5037Xj9AfNfiX873OekOjNXTXZuEDfdO1EeyUyGtT0PHOIGCA4wBD1Vy7yw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793827992;
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
	bh=z3d4nvRcvFNEOKESR3K7UWzlJ8ktE+p7y5zJfcTkRoE=;
	b=r5vLZ43K/DhOMOpCVu2+GRPVbtRGnF/wz1X5Mru/QPgly1XSNeiAYLOgarkSKd13Pgij
	 9qyzcGAL7r/i/pFOWG5XXZxwjtIuvfQ0Pht7F06GAaUEuwKpWb0QvXN8YGmB6d/GLXf/6
	 220NMugWNmAFgfXxvdxk4DxIXJ51yWdpduf7pywOmOTfQwowYCeMgC00Wm76OUbi8U1PQ
	 daqu4yLlbM1PIGEtGP7akBEbw2ewtCOU/I8I8wbfQg9AuHoOgRHeV35EREJ0PllLoZV2j
	 2wQxgpn6YNpAV/vJ8RXRZL323thE3IMf9lIRAr6QEDhqk6nm3cUkIBEDpc87i8k6Mfw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=l+ukF+vV;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.208.43
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011043.outbound.protection.outlook.com [40.107.208.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2BD606C902;
	Wed,  4 Nov 2026 21:33:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DC2BD606C902
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=l+ukF+vV
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZdP6UEwYIONZYKKonmUZIZK2xLOh+8E/9Hm98MjV/ZivYXhYgv8lWljO1bMFwe4Tw+PtVzvwAudv72vJ+2Lu28kPIprai0RNI00HRB7RXZ4jhX5mg/i1NLg/zvxyJpG6kVpK0gK7cP+X6+qHKYb94C3AkaGKfJnEPXi4oucSwVEZkNbXZSidQ/JdsxC9UmRb99s4zWqhQnEADXRFPxhi/9iNFxt0l615pY37Yk0y+xHFtF842r0Y8rBanYiiDEKMlY9DBbyzduGygxh3qWgb1ryaRx6HO19STJtf2M7UbE+TdlPrK6RPySbOY43vlWRN3TCiTcF6olo76tEIK8RD1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z3d4nvRcvFNEOKESR3K7UWzlJ8ktE+p7y5zJfcTkRoE=;
 b=antf2GDY4IoUshe+l1ZK9lG8+AG5ju18geUKQfynje1g7ZASxyFMqRauzoFCSFTZy1bVEiEnbvN4/yxoErY43c2eAVSuhnbm6W3gs8PlTrepp/M3Exm1Gj96XIutBrMwpN+E2midwiqs/0/lpKLgeUX9f83MiRWxn/Jo06FyTRmwCxRj1RGI5PAismRYTeC4qw9gJwfrPS8PJ9Rfmz10S64M1rF/AIEQQECMw4yuQoNqU2Y2PW0zJmQG3ChtsK9YybzvklcA1WSDFnS7okvNmhcrBPprgc01J5UzFAQn6632HacIbFu9OO1FHbSSnNHwNMiskh95vX6LM4B9BuXDhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z3d4nvRcvFNEOKESR3K7UWzlJ8ktE+p7y5zJfcTkRoE=;
 b=l+ukF+vVyIPMKk3iKxPVk1wkobsVVf+T9Uaw8ebWTRNd36lMEfsNNkwqzC4rFAlhVe7H+33BYCF2+O3fkCnaspACjjoi5B0NMm7yliTZqXeqAl/WyZFPYp0pRFZbtuwHajijGjURM12ArLv3sKiazpKxKLphnjdbnCWfS68nQAk=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH8PR12MB594730.namprd12.prod.outlook.com
 (2603:10b6:610:32e::18) by PH8PR12MB6748.namprd12.prod.outlook.com
 (2603:10b6:510:1c4::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Wed, 4 Nov 2026
 21:32:59 +0000
Received: from CH8PR12MB594730.namprd12.prod.outlook.com
 ([fe80::c219:e548:cc1f:b733]) by CH8PR12MB594730.namprd12.prod.outlook.com
 ([fe80::c219:e548:cc1f:b733%6]) with mapi id 15.21.0592.009; Wed, 4 Nov 2026
 21:32:57 +0000
Date: Wed, 4 Nov 2026 15:32:55 -0600
From: Wei Huang <wei.huang2@amd.com>
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
	corbet@lwn.net, rdunlap@infradead.org, fengchengwen@huawei.com
Subject: Re: [PATCH RFC 0/3] PCI/TPH: Expose CPU-to-Steering Tag mappings via
 debugfs
Message-ID: <auukh0rUCTC8M7fc@weiserver>
References: <20261001155551.4182899-1-wei.huang2@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261001155551.4182899-1-wei.huang2@amd.com>
X-ClientProxiedBy: CH0PR13CA0030.namprd13.prod.outlook.com
 (2603:10b6:610:b1::35) To CH8PR12MB594730.namprd12.prod.outlook.com
 (2603:10b6:610:32e::18)
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
X-MS-TrafficTypeDiagnostic: CH8PR12MB594730:EE_|PH8PR12MB6748:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b420df6-0512-4e89-1c56-08df3abb31a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|11063799006|56012099006|261021123027099003|261021121427099003|261009223027099003|261026121527099003|261102123227099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	GpKGp1WFRGxY4oO3uZWjoPtoFrYsL+k8ySQWuNql9ZGzX6naFEQ12D9R1nAt5IUyAor4+5mq66tIOp6GEbvBE2hbG88MQYmRPCjHF0E9EGcSiOWmeMHL5bb3+NQnEBZ1LsnfnHyid2NZ8p+gTnBm0VND45pfZ8bwbvnUMnPdwEGm/r9udcW0qX1JPULENm6Az6WwOfltHiiJ7VaoWWG9kIXiBoRUfH2s1c1BaszA0EMrAHt2kJUpD2UuDoDs+V+C4j0wI9i9HkGOWkxNvC77yyIgiJal0KihDYz4Vtuq7KxXpw94iDDMosHlPOTNQj3vGCBqrY1tdvorJz2xOLoS0XSCCkvIGmEhKo5exJj4bcgxqH1KiE1TFj0NSAb8CUoT2Yi8CFJPMq8TCRoR3bOWVKxJxbUishg1H2Xb9XOD9VsK6yU/SvrTds44SGL1IMO/5Ani9xcN5Md0pD514NBDZKQyhsi7KbZvgM/1ZhcGftkjUauvyBoM/WPSZvOACcZ9cBG3UsMW5qWM1VUaxhly3Sv+NUgT7OkOYVoRT7MeOAEh+TeiOw5NXFKn3kE9QelWFrvRN19wAVrnVURlmnycfZ2+HiM6s3I9nzNyL5M/I6ThkVSja2sjZbUKkw4fDIUtdie4y3u5SZWGb6QVA2TFtJUkl4W4nBP0hKvA7JoB7aw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH8PR12MB594730.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(11063799006)(56012099006)(261021123027099003)(261021121427099003)(261009223027099003)(261026121527099003)(261102123227099003)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WeFFLU2eudvrrxggI1azgt251fwslV9KY9AJk0ecA3siUczc/NbgGM99sEOx?=
 =?us-ascii?Q?j7MPFfIPBqrsENLVdHLXH/n4zl6V9yvSufea4WJx2Hu20LY1SpCH8kFu/LQq?=
 =?us-ascii?Q?GPoefIfgZ3lueQlTIncWXuhBHa6dMW8DZJxcBCnazEE12lUG3OEdsUczpMeu?=
 =?us-ascii?Q?NRnpIj9YuJt4HnPX4+MBpcB0UnFAigPLuYg5XR24QR4ACLOx84F2v6fw4eNR?=
 =?us-ascii?Q?39Pczjmk9LmM6/z7cmwJNPmR7hNhHlmSyRotKm4gRZBR1nUZSJ7+0tA0vMlW?=
 =?us-ascii?Q?epAlT7emTvwgdD13G4eINhszQ05nERVFLhJQbQcxS5BhwZwNsFCb7WyQc07A?=
 =?us-ascii?Q?NwSIEQ70QAAVflujZNcyt4bY2t+RxNAJhnOHhmXC45nDdwijNz/cXeZCIHBl?=
 =?us-ascii?Q?HK18LJxNHOV+f8kp6v0VW2C6uWP/4tiQPslirUiKRtXzSLeGWQ7XjiQlgQ6H?=
 =?us-ascii?Q?bSYrF0Ej+H+XRMS8femdjin7z5Nu1OCYYWNZ2LlNDWP8BT6sg6OMIU1kSn8j?=
 =?us-ascii?Q?KUlr7MKMZErenNLw9U1mfhNfS+vhsUBc7kcHaGDeapxYHQ0+gfSce4pDXGzM?=
 =?us-ascii?Q?RjCkMSJqhCKPRf7szvJnjjP4tJn20Ej4BmL/XXg7nzyFQ6bnc4jUX9/zG+3r?=
 =?us-ascii?Q?DgOqY3qIC3YiK066yC7ShyZiHKPzg5upHeAL83So0gCKy6F0eCd36reTy21h?=
 =?us-ascii?Q?XMAqyMD1taGUFHhu1OkuGE6pJSvXJN1u+HaHRDwjQYh666TJZ4tIBlTCUbxX?=
 =?us-ascii?Q?sHXqC1WUcpZapkUiZSppl+QR9zpxBFoS4bpALz60i5ljmH0w4wO4q0t449JV?=
 =?us-ascii?Q?KKrRGu1y7JZy5sCIh0moNRdRgUrWihSurHTfsgA87LtjnxWibPafklFYIhfZ?=
 =?us-ascii?Q?maPYsYvcCu9cgt6msBO82uFJl82Z55Q2q6hfgICFhDrFwvuw6MiwxUUaq1Ze?=
 =?us-ascii?Q?j/y6rPrK/FCd9z5xyOX0v3M3TTbxx5S0xKimvY8V6y/N1bDLLID68g6Tn/IF?=
 =?us-ascii?Q?/Sp98qqJJmFx+O4HfV0USCx8wr0NM5S8wE8E4tdUR7VnbvmdrBKLXLRUX/Of?=
 =?us-ascii?Q?vWHe/84+lOjakPURsLX+Og8hx9b35czR82/p65GZ60p5lvr2dPjdcJ6RUwDc?=
 =?us-ascii?Q?mdvuekHtjdohDFuHCvuJz0j51pi82Ua4yxL9CkBDEANXa0Rd0PBhKqg3JsTf?=
 =?us-ascii?Q?X7bKSd9LTftiVee3FfZ7cbo5z0/JDa/cnL80xKCCCtqjjN5kcxG3D/xlyg9y?=
 =?us-ascii?Q?eIv2aGUfsDZPYAaki1WyvjTpwrMUac7/M85XLuJGifV0Aczk/+fBduFAQdSF?=
 =?us-ascii?Q?33gfOY/fuuQ7yodwWdQZNLprebGmotvKjsmHZrzXX2ATJzbZspM5F+M2g6ZC?=
 =?us-ascii?Q?DLmj8CkB0fFppWc5HHxBLQomomxGixB9VutZEQzAh6tyysvlGQMqjfWR1cnA?=
 =?us-ascii?Q?qoSEBHggE+kks9FjQj9dVXX0nfOlNsPyOss3mytRiIP9Nqfye877t6TY1Nvy?=
 =?us-ascii?Q?8yECge5Edot+FT8n/Bb++u67U0IheHUIbOOI5w4pNAxikhvcTsa+fyAcg171?=
 =?us-ascii?Q?ocBCh4YjylEp21O8uSvoov9jJccYcHlm8i4FzHBth/xktJ5JzRJ1nGTpj9ue?=
 =?us-ascii?Q?JvL8/mrqxpQFTUpCQz+Yk9oTwzXTKpGY1lsU5UewPFQ8AnHXTiaxtBemh8Bk?=
 =?us-ascii?Q?/D2fze0TjA+arrm0RnESbOm+SKdgLLk313feasFUSnK4MWmb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b420df6-0512-4e89-1c56-08df3abb31a2
X-MS-Exchange-CrossTenant-AuthSource: CH8PR12MB594730.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 21:32:57.7025
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UTa5igkrLo9odsu96Wet3jxnfGUIH2FAlaeOKSlRV42UpAp8bXPXqIIjIYANgNO+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6748

Hi Bjorn,

Gentle ping on this patch series. Do you have any feedback, or would you be
comfortable to add this support into PCI TPH?

Thanks,
-Wei

On Thu, Oct 01, 2026 at 10:55:48AM -0500, Wei Huang wrote:
> Add reusable per-device PCI debugfs directories and use them to expose
> the firmware-provided CPU-to-Steering Tag mapping for each Root Port.
> Factor the ACPI _DSM query path for reuse and document the new read-only
> interface.
> 
> Wei Huang (3):
>   PCI/TPH: Factor out the ST _DSM evaluation
>   PCI: Add per-device debugfs directories
>   Expose the CPU/Steering Tag mapping via debugfs
> 
>  Documentation/PCI/tph.rst |  32 ++++++
>  drivers/pci/Makefile      |   1 +
>  drivers/pci/debugfs.c     |  60 ++++++++++++
>  drivers/pci/pci.h         |  12 +++
>  drivers/pci/remove.c      |   1 +
>  drivers/pci/tph.c         | 201 ++++++++++++++++++++++++++++++++++----
>  include/linux/pci.h       |   3 +
>  7 files changed, 290 insertions(+), 20 deletions(-)
>  create mode 100644 drivers/pci/debugfs.c
> 
> -- 
> 2.55.0
> 
