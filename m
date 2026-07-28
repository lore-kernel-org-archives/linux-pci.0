Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011051.outbound.protection.outlook.com [40.93.194.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 220DE3AEB5F;
	Tue, 28 Jul 2026 22:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785277069; cv=fail; b=ufgqd24MXjIkBLSr3x/1Q0lGnpk0EqMOawi5nXmjPIki41SZfHKI7zofoTghQh1DNckaMQT1ugSLoul8OoLQYXZ9BMz0Sg7owFv3GCco3VRDDjZzC99WNBCv9dEhVT53wMsJZpxWLQQQp8HsBuh3O0sXUtDsMLJEt/WhSC863dI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785277069; c=relaxed/simple;
	bh=WZ3NNOZIRnVdQIC4/POGlJxofhRSuv6W0lCzgJw3Q/w=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YQvmwWRL+2pUpv9kmTl5qNTswQlk0ilJZsbxu8TgND2136s42h3pAtxqvsJ7GQ4b1khHywwbO6/GdvKoqusGRkbw7uCJO83cgq1EFAhj8pW9eGTztbQO/toH2IMF7EhsaUjpyRKU85cyRA9TFqZYQdqbDHa5a/uUuCoY2CTMRww=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uFA7GkCI; arc=fail smtp.client-ip=40.93.194.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uFA7GkCI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ejoanU68lurvSeYRDOpCUKObLv8KwGVT7IKv0ixtyffRxZukmOSy/AaVSQ2j6bBySXVLcvoeYYIhbY6vuV80NDrDOpUYcnbyNT/xLxI1SZNv4d3gLhaLz2ZsAW6H8goX+KbmFxhfwxd99iOuMR6zQkglvV6uB+X0tTGzlJFMNNv0vRRC0kJTDthZHYH2pbQ5pCxRujSAeDZxoXUe3s/M8E9NBkSwAiOCIKAnDE7IZoHPbs0ZDQ79s//uff09TYB1ubzQidTyz0sfFDQYxiGR/9nKaQ5jydZfPrimbnyJ404mnfMPuvSE8/DkZ7+3EBNRxFrVTuoKryGfkwj6RzXziQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hit4GzZWS3y+tbzR9/tf8FQud6luTTuIR6e8vWwpt9s=;
 b=X+gvYPS9yHMkel+dHxTfJPcdJJE8XQd2VlSKHLPFGVWaRmAT4PPNM2+f+u5Tw9ou5cp8+Wm2R57fdVYeuPdyidrSoJMeyAroD55cwSATAYIPDCWyNrbYkgllj8Z3BmyAqKwysCIrRyo9SIjtaw9kof0NkKqaMSs8kb7uEXOW6RuuwNEirscNfJgI2LNrUBvcDylDGAHEzGEQGxKJIINXfU/r7sbRplA32o40ZHzGLTwhjVHT4r993YSOkbHhS26QfN418XJRHEdguekmZIcvgS2gLhFbX/PTT4tH5AkmgeaImG+0qNSPmvViTQy+PChG91xGO+5LvFEZfyKWS59lMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hit4GzZWS3y+tbzR9/tf8FQud6luTTuIR6e8vWwpt9s=;
 b=uFA7GkCIOoTlpRS6RVamvXJFiahtoDtbvItn5FFLy+7DcLKUeKjGpQYdnyzjPIG1P2m6WLNDEeR0N2iQA2gRDj168F3vWHbpGmz4EDExdfK4V1EXbcV5O1xleRO3MJ6hnjHxs8SR8Y5f1h6Ti+d2oLsAP3U1ldsHWfvMWEKJRUniZUKkBrVXO+FWD2itJqEW4AwwPujIjqgey2U6VWa0EGOe4YtFzTbHz3gT6l4+D0SIOYwCxCVP96GDQjIguyUJMLilnE4fzN7nLofreTzUtjpjguRTmFHntJ8oF/n41g87JeG7RuSVuRp5xk/7bYFpHeeVZyz3HnOlUZayDaUV/Q==
Received: from SA9PR13CA0055.namprd13.prod.outlook.com (2603:10b6:806:22::30)
 by MN6PR12MB8565.namprd12.prod.outlook.com (2603:10b6:208:47d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Tue, 28 Jul
 2026 22:17:36 +0000
Received: from SA2PEPF00001509.namprd04.prod.outlook.com
 (2603:10b6:806:22:cafe::33) by SA9PR13CA0055.outlook.office365.com
 (2603:10b6:806:22::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.8 via Frontend Transport; Tue, 28
 Jul 2026 22:17:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF00001509.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Tue, 28 Jul 2026 22:17:35 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 28 Jul
 2026 15:17:16 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 28 Jul
 2026 15:17:15 -0700
Received: from nvidia.com (10.127.8.11) by mail.nvidia.com (10.129.68.9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 28 Jul 2026 15:17:11 -0700
Date: Tue, 28 Jul 2026 15:17:09 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Pranjal Shrivastava <praan@google.com>
CC: <will@kernel.org>, <robin.murphy@arm.com>, <jgg@nvidia.com>,
	<joro@8bytes.org>, <bhelgaas@google.com>, <kevin.tian@intel.com>,
	<kees@kernel.org>, <smostafa@google.com>, <baolu.lu@linux.intel.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<skaestle@nvidia.com>, <mmarrid@nvidia.com>, <skolothumtho@nvidia.com>,
	<bbiber@nvidia.com>
Subject: Re: [PATCH v2 03/11] iommu/arm-smmu-v3: Add
 arm_smmu_drain_queue_for_iopf() helper
Message-ID: <amkqZbPJs9qly4pH@nvidia.com>
References: <cover.1779944354.git.nicolinc@nvidia.com>
 <a62db13ab63916e9a62cddeec41a74a98cdf6a8f.1779944354.git.nicolinc@nvidia.com>
 <amkcQRVylEe_t-yP@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <amkcQRVylEe_t-yP@google.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001509:EE_|MN6PR12MB8565:EE_
X-MS-Office365-Filtering-Correlation-Id: 610209c6-d94b-42d8-6d10-08deecf60736
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|7416014|36860700016|82310400026|4143699003|10067099003|11063799006|56012099006|18002099003|22082099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	hrpPFWeGqspN01V+LOnsYayJNdrQIaHd8syZ726zpMURIJ1Tv3w4+X9ghEmSRHWW5/EvUtbg5Xs3ZbmEuF8ba3g2IJBEd6S441rsxyzln9YsZriEo7iwKCBZrlf+adDshiIKYVg+olEl/JZCsa5beF2QBlQ+K0VCiBYO1Ur47wwU/x4HS2wKMT0TFfawKOx889Ovwlx6Vvisx4K5O5ei11oTNFSaTrbvyA+Izocuo+LIh/SUD5LwA1xmZBHfqFVpqQP4oGHQgg3UDbPna69tyzIKQHCV9BYE79D0vxsTApe9mAwSR3i3cKoJB4YsgQL8fZ/64jSKls4eTW787Ahzdpq95Tm3Kl4UixGR4MzNKlzGukm0JDGomZY0XnGu1VOW/VR91Cfdtm+gZrmNf6MavW0+FjXWmCld8FrN4fYwFHfL7ATkOdtAQG6sf15OAKAKh5UWE3FEC8v8Bm1qEuH0c+PQNvkejkhlQMsvulOSwaFikllcBLSzHMimYTZ7a2IAkD55q9yDgyeW4cvMHdYePZuGY6mUGWqpo2izbkdqIFq8HzfcHFvCALfLSUF99OKQV5HGLVtIkC29S22ODK3bkgSx4cmkI+2Ptc62sECsbe7j6Uju/ZT9EmlFyBn0WFTSr/bfvBunR2MfHrX2IkRWb95PxURODcX+mqlxT1Fbdv67KlP6FQ1dYBr7uOhZCcY6p0uPWOWp6Ajf/Lt58+cvkQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(7416014)(36860700016)(82310400026)(4143699003)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	BqAvGzTkN2sH/jW4JhvIRQK7cwJM9H+cC/sN8ir77aCMOILrcww+onSqFsQSqZqlPrc1e+tYBuDBbgFmfTl4U32o2LLXZxKcJfLnPrxTJKB9skGk0OlK3uHSXkGsURvd294LWRTQip75UHuWEkB1RXFsE3iLGPEP5IaIi1Ez8OoDD5j9XeLGCn334m5CDGwZyotPkM/uFL+9ukF71yFehIUxCgMqyUcVR5eSU6WiwRxhoOnY5LLbvwxl0PGdMg3ucaTVSEaKfbUAvfjhbvF7EOiTneMO+f1kPACVJQTyrqkwSxNkt4I5PXOqAg0xWISRXUBvwajL9/Jh8LpK9M4X15Og9z9jKq1QP+5va1WfWgM5Nv29cRmhyJWRDtauxvaggmF15jowi3UvhrCh4wIhmhHuTjbYlmijpjQRdLn6C5WWwtlJkMmBJKICuJCHQMz7
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2026 22:17:35.5897
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 610209c6-d94b-42d8-6d10-08deecf60736
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001509.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8565

On Tue, Jul 28, 2026 at 09:16:49PM +0000, Pranjal Shrivastava wrote:
> The following is a unified drain_queue helper, that also attempts to
> address Sashiko's concerns. This applies on top of my runtime PM v9
> series [1], please see if it works for you:
> 
> Subject: [PATCH] iommu/arm-smmu-v3: Add a unified arm_smmu_drain_queue()  helper
> 
> Introduce a unified arm_smmu_drain_queue() helper to replace queue
> specific polling loops. The helper handles both snapshot-based cohort
> draining (for IOPF) and full queue draining (required for Runtime PM).
> 
> The Runtime PM explicitly gates the CMDQ (via CMDQ_PROD_STOP_FLAG) prior
> to draining, this allows a single, snapshot-based target to natively
> handle all drain scenarios.

[..] 
>  	queue_poll_init(smmu, &qp);
> +	qp.wfe = is_cmdq;

The callers of this drain() will be RPM and PRI, either of which
needs busy-waiting. So, I have added a different drain() helper.
I run Sashiko locally; it also gives a clean result.

Commit:
https://github.com/nicolinc/iommufd/commit/d10325ff40fd45c476bc98d484d8dd2cdc7fdf95

This will be in my pri-v3 series:
https://github.com/nicolinc/iommufd/commits/smmuv3_pri-v3

We have too many SMMUv3 under review now. So, I will post it once
some of them are merged.

Nicolin
