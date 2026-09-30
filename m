Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011056.outbound.protection.outlook.com [52.101.57.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D07A33E022B;
	Wed, 30 Sep 2026 20:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790800474; cv=fail; b=sgE6rGhBAmpuaVfJ0AHqb3nuJ3EY5nQbtOUoPyCDYkYnn4JwwNm2HGBD/QYqPIXV4eLBxObCAwp5Y6IfI3xJ6bBby/SQKZ//cbc4TGxq2NQH78zbYU/EDsQTwV7aCeTPb3l5Ccmk8JbUVDuM4ovEDw83PsnCcVUG897RLIv11Ug=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790800474; c=relaxed/simple;
	bh=jk8XugXDYzSrd10EOAvp8w7nIx83+WuMYdIMRvN9VRk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mhhDJoFDASxtFncWMqb8FrBPY1y6+aaeaFC6ID0SLk3O+BNRZoE7nSDs4JUknNOy2Iu8KoZSnzByTagVFLxbHj50h+zmoCNAz1p8KHfIg+W6qLCZ8WSAkkTNVl+3hk9ZYy26dx8JfjMhGbXA6+WOV3kqrL6eZOWc9yXN9kVnSCE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ooG39dLR; arc=fail smtp.client-ip=52.101.57.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ooG39dLR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BFrpbJPmqkQptH0U7azF+TMC7eEskbZrUz8PYYFLq3C1N8hEzG9nJpLlvCXQ4hdGQkY1IsuQNa0l/qupQJvEfopxyGrOmh/aenpzvQun+5ieNiV42uKkjewVTn1BPE2A+H5YhuweC/uS5YEKergAxvTK48zhxLolFBUJbnsLN8oxJO9x0Pz3SstfqG1VCBDOJOjGa8ozVgyvOgBa7NLQmGPdIb2eEx82qk1gf1x55QA0KczpDXt3x2JtpsT/2FLmILME3xKK5Ic+HrRpHl8cxfeRSibB+6mwLulFdQiNXknWh3WQcksohrXHd+zKDoMPEu+veqMLgSRv6qj58FMoHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FUB+XiiXEW1USjTKzvjBma7tdra06QPEuPQYuHebLnU=;
 b=OBNiyK6cigOea9JkFzbHS9LsyYmz5CaEORyEVCTKNK1pLLVch9fEXg2rwc1nYAIFqSnziVRlaNajtU/Klm0S8tN0JK/owE+Un6rqKdMT463/6BxoplEQBjzBMX7FJR4xqDhCo+23wah/QplzFm5Mmt6VsQf6RTVYAbNanKPtVChCzXX9oRpIB6QthkWP3DmRCSB/Db6qykS5Tfcr6TwAWooNXBRuRbds0k4ApT6avrs6l7UUgRLDrYI7Ckua1KduQTZx8j1CviuwLj+aJj7mfHncL8sbNSlYClCWvjdsO8nO1LNdJ1gUSAof0kgENQDzHGg6itQvpkJpZkoB0k4DzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FUB+XiiXEW1USjTKzvjBma7tdra06QPEuPQYuHebLnU=;
 b=ooG39dLR/bEXqVoH63+qzc78QI/J2W4a0pmIcEddf7cMt7iY+kLbvZUFZ+2qkFVS5O60iizjR0oGZb7+EROeJgQ4Pu+0VrOrIyx4o+rcxKDwGZiscFdw9MUD2eGK+xHmlHB7CK/OLyOGT5GFP0CKD1o2bISnpM7S01GnkIdUWhwoQs/Z2/wPJvAEBKc4Poyq2FX0wApuJEjU301Ev31TU+mUeg5CdYFbAQWvoT6hQSfhFhVMeFW6W4ZSI0AsB7H0DmeeNSVvtaZjXDXcypH4p+4oSi6HHmQAVyHYm5tRJ4wM/cV6XZRjjYMAnuCVbdRbSkm5eXhbR3YSdwkZ7vU2ew==
Received: from BN0PR02CA0059.namprd02.prod.outlook.com (2603:10b6:408:e5::34)
 by IA0PR12MB8088.namprd12.prod.outlook.com (2603:10b6:208:409::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Wed, 30 Sep
 2026 20:34:28 +0000
Received: from BL02EPF0002992B.namprd02.prod.outlook.com
 (2603:10b6:408:e5:cafe::9) by BN0PR02CA0059.outlook.office365.com
 (2603:10b6:408:e5::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.15 via Frontend Transport; Wed,
 30 Sep 2026 20:34:28 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF0002992B.mail.protection.outlook.com (10.167.249.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Wed, 30 Sep 2026 20:34:28 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 30 Sep
 2026 13:34:02 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 30 Sep
 2026 13:34:02 -0700
Received: from nvidia.com (10.127.8.11) by mail.nvidia.com (10.129.68.8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49 via Frontend
 Transport; Wed, 30 Sep 2026 13:34:00 -0700
Date: Wed, 30 Sep 2026 13:33:58 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Pranjal Shrivastava <praan@google.com>
CC: <iommu@lists.linux.dev>, Will Deacon <will@kernel.org>, Joerg Roedel
	<joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe
	<jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>, Daniel Mentz
	<danielmentz@google.com>, Ashish Mhetre <amhetre@nvidia.com>,
	<linux-arm-kernel@lists.infradead.org>, Thomas Gleixner <tglx@kernel.org>,
	Radu Rendec <radu@rendec.net>, Bjorn Helgaas <bhelgaas@google.com>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, <rafael@kernel.org>, "Danilo
 Krummrich" <dakr@kernel.org>, <driver-core@lists.linux.dev>
Subject: Re: [PATCH v11 11/16] iommu/arm-smmu-v3: Add CMDQ_PROD_STOP_FLAG to
 gate CMDQ submissions
Message-ID: <ar1yNtr7Kp2OTcDd@nvidia.com>
References: <20260929034510.2023173-1-praan@google.com>
 <20260929034510.2023173-12-praan@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260929034510.2023173-12-praan@google.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0002992B:EE_|IA0PR12MB8088:EE_
X-MS-Office365-Filtering-Correlation-Id: 86b60a45-7e8a-45bc-4108-08df1f323978
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|1800799024|36860700016|376014|7416014|10067099003|56012099006|4143699003|6133799003|3023799007|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	ler7HQ+GTFMtmTmIris6AxGrYi2U8q3u7J0jkSkAa4Tf65PwxDkD42k1t55htTACfedXYQikO5uBSPDSG5Hj05a4AIalvLb/4Xc2aHfqMABQhDcp7J+VJUROTopg7YoeL0VAZ6EWKnzwKiRbloUkgR1t5g0VEn8WoVMCONTFmwgAZf2wEpqlRpUOB6WoXPu4CA4Hs2U7rtPQYXnvEFCqMxDkekxqqyW35tsSjjG5kVu6Y3E9URCFvgOR2St1sIciIgmX4hoyLv09z9HbRI77/Ht0LPAAxUDuudLd8pWEz6pcAmhuFLrRZp0r2VknfIw9Bgm6MK9ugih2UtHbQ/droxaxbygah3DV4N/3nu9u3sPOdgyeege4ceHhmR49CWE1WTSnKRyadHK+Q+CPuqawDM0FDhs2VX28P+BYKVOtVVQvA6TzOFYYT7yznpqF0LR2sLjAR2OZ6Hv7F2K7ALwGBP4gwtLgowahoXKoks7SU5H8/UHAhhB+r3M8Q6hI9nuzkKVmPHjES9avYfgK56RR9IRQuLlVe8ADacJ3Xv7EbdbK81NNQyw9maBVnIUWEgVzSdnDbawmKO/xIlhVbXYFXKGwLL+VwYdJwXrj2F5fW/rQAqW3wghKhM5qFjPUU+Fqy+xD2xRZkuVi1DQ31hcOqAwBW2509l++9moVFq7Tj3455hzlvs8MiRqdjf+l5Syi6FDwlHhwsjylH7Ut59CRwQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(1800799024)(36860700016)(376014)(7416014)(10067099003)(56012099006)(4143699003)(6133799003)(3023799007)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	xZ76xcwU+inpz4G/xHQdo3USWplLCsPcxXY1+azViTidbEqkQQ+IKMsSzZTyqeJymdMuGOnxAbkEKmVsqdD1L8p9R2hab/4jlCJ6jgDCYZj8tajz6Rzqnxv059pEWSCvhI9lMYDdUU8JPqtD+YLdI/UF3joS4ajf7kvpfTDnQ0Omfu+lENykwzHYl35pmoGvl79v0ckeUdmycH8GViRX/YUUS3mC2yZIMVdteYnoajaI9dx+/qPmTranraaPejqsOXMsVZAVZU5+ReuNKfNWV/0FNtlHKeOPRa83471Z9xy9C72tnni6fSVSQBOf48iAY2ei5nAyFue+deiyMtne3ttNIZSwkYd/FUh1tCQ9Cm8R3hVpZo4nXMvmvb828PIfF33PQ8cC7qnQdGu8Sw/8/mKm02hWVEW+NT8su4vOggtL4l9ioWreiuxr8UwX1Gaz
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 20:34:28.1127
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 86b60a45-7e8a-45bc-4108-08df1f323978
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0002992B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8088

On Tue, Sep 29, 2026 at 03:45:05AM +0000, Pranjal Shrivastava wrote:
> @@ -726,13 +727,42 @@ int __arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
>  	do {
>  		u64 old;
>  
> +		/*
> +		 * If the SMMU is suspended/suspending, any new CMDs are elided.
> +		 * This loop is the Point of Commitment. If we haven't cmpxchg'd
> +		 * our new indices yet, we can safely bail. Once the indices are
> +		 * committed, we MUST write valid commands to those slots to
> +		 * avoid indefinite polling in the drain function.
> +		 */
> +		if (Q_STOP(llq.prod)) {
> +			local_irq_restore(flags);
> +			return 0;
> +		}

Sashiko pointed out this:
"
Can this early return cause memory corruption by silently dropping ATC
invalidations?

When the SMMU suspends, Q_STOP(llq.prod) becomes true. If a driver or
background thread then calls dma_unmap() to free a buffer while a PCIe
endpoint (with ATS enabled) is suspended to a state like D0, the SMMU
driver will observe the stop flag here in __arm_smmu_cmdq_issue_cmdlist().

By bailing out and returning 0 (success) without actually submitting the
CMDQ_OP_ATC_INV command to the hardware, the IOMMU core is misled into
freeing the memory while the PCIe endpoint's Address Translation Cache
(ATC) retains the stale translation. When the PCI device resumes, or if
it issues a TLP while in D0, it could use the stale ATC entry to access
the now-freed memory, bypassing IOMMU protections.

Are we assuming endpoint drivers clear their own ATC or that a hardware
reset handles it? Client endpoint drivers typically lack an API to
manually clear the ATC, and SMMU hardware resets do not broadcast ATC
invalidations to endpoints.
"

We may get away from the TLB maintenance. But ATC can be the case
broken by the stop flag?

Nicolin
