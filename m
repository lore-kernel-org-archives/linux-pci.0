Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013028.outbound.protection.outlook.com [40.93.201.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 517DF4A0EF5;
	Thu,  1 Oct 2026 18:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790877844; cv=fail; b=Jf2hjJE6mIvUjYH2FaeOxi8kwpE0PHRMNRSswpmTR5aQRcucZwYjzIFPQn3OIqsEiELLtQ3Q0AeMHI7Ya8Lv3tW+X+LDdO5y6m/YoUn7ZIN/P11vz7bAKkPjeto6bgUSXSJh7AlRgWKe7aQTw/BoInm4jXHKCVLaqQp8cZqxcc8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790877844; c=relaxed/simple;
	bh=VqGTCKRuYElGPMelr7Hcniu8dxhZkgKSaYvWC/wOoog=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JSl0KxHAvHluJVAAjoLepdbzqAXPKJxGKiFDAVuZw6eTRXIsCbQJ9vhFwrKOpADtPwMFveOdPij1mIocoKTwlMn2/Ke01nQXNYiyFyrq26RS/YO8f+b4BlnwdWrUszK3ivpiE/jUY8gGFwfBgVp4MMbbeU61AkLvpxorNCCPmZg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=B1/pFQmp; arc=fail smtp.client-ip=40.93.201.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="B1/pFQmp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xy6da2qPodJIsDQqngwaR2iUoXx2910zW9htXnU5AtSjbQkBJGloDVbPwMupTsIj/SNyyMiWBWjXniPjtitL0DDUN9h8IWi5+h6yxhakPx9xvYchHbnQw/see7AH5rjQPtkLnul3ccaGjsEVyEbQYUL/fLyepM+vt3N5YCZeoeF3XxivA1Hd5IJpRDYUv0VQ1EgreRFHKMnRZY0HeRclziEvcWmQ8AysGW/gDZWNCnyOOHhLqtFznKr5oCtngxNqsCHamSloFg/PmUQaxFpWNWWOKbPFK9BoRbxD0XqfgpQ3s7ZM4oxMEEJ1+WQ6NeY28jDKhYo7XrMOFBxdy4HX7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4eZIu0ByKLmylD9kPONKLCE9vBYmRBQGjGZ2s2bJrus=;
 b=euRsKXMO0ToLWk4Jjp0pSduwXQ4TFpHPNHjeu8TV810ANucRaS0E9eRl3DHpOj2+hJ+2tvPe0WH/DoQAznB6tJ1yipMK+6oO95FfwNuGBLR+cd7UVqQ7GX9cM+QDU31kZPtjEL0SDKzOQr8iWRkiTBOE7HBEYyPC2yjmug1ZwKiTwSE9rb3ncAtN1lLmm+BBsL15wcl9zpMDq+x9rlj25yfIKF5punXpNErOHUxKT6ZaMEoKdPpI4Ll4FZW0UzXoFWRmQNw3gFvhD+wvG7ap1BgoWSfq7s0TbUNxeRhamIVF/dTuxYFT46OkCNAxHgVeetn3qurbxMoNzn8X1DKeNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4eZIu0ByKLmylD9kPONKLCE9vBYmRBQGjGZ2s2bJrus=;
 b=B1/pFQmpPID7YyqJCyTJFW1LX1bGYGWSPWcgcyrHfM8fXb2PVF6O/s7VoFNvoIXHm2KdKjH7EW6aAQqfAldyC/Auz4V5D1dPsHtdE/sIEXQeH2KZLhyp9q0g5SQyuAZi7o0UTA012qNiPdwzCfLAoTyN9iIwoHqUNli4SlNGQChoqTia3gQVaaHijGfaspmSAImdVpKMHKxfghxnBno5lMT0o/SAulb5zNonny2ATZw6IHaiFG2ln0B4XcUOQSFD4ku6YUFMidpa4YN5J/MP5tJgzxt0l4EJ3GB7iw1If0pwg+O5lAgffRgylbh1SYWSaVut81uzo97g85KwBJtwdg==
Received: from DS7P221CA0008.NAMP221.PROD.OUTLOOK.COM (2603:10b6:8:25b::6) by
 LV5PR12MB9804.namprd12.prod.outlook.com (2603:10b6:408:303::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.24; Thu, 1 Oct 2026 18:03:53 +0000
Received: from BN2PEPF0000A802.namprd02.prod.outlook.com
 (2603:10b6:8:25b:cafe::41) by DS7P221CA0008.outlook.office365.com
 (2603:10b6:8:25b::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.18 via Frontend Transport; Thu, 1
 Oct 2026 18:03:53 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF0000A802.mail.protection.outlook.com (10.167.245.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Thu, 1 Oct 2026 18:03:52 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 1 Oct
 2026 11:03:19 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 1 Oct
 2026 11:03:19 -0700
Received: from nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49 via Frontend
 Transport; Thu, 1 Oct 2026 11:03:17 -0700
Date: Thu, 1 Oct 2026 11:03:15 -0700
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
Message-ID: <ar6gY9grmdMZcN/M@nvidia.com>
References: <20260929034510.2023173-1-praan@google.com>
 <20260929034510.2023173-12-praan@google.com>
 <ar1yNtr7Kp2OTcDd@nvidia.com>
 <ar3yWUmi8E0k37Ml@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ar3yWUmi8E0k37Ml@google.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A802:EE_|LV5PR12MB9804:EE_
X-MS-Office365-Filtering-Correlation-Id: 23d0559a-662a-498c-2550-08df1fe65a7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|23010399003|7416014|376014|1800799024|36860700016|11063799006|10067099003|56012099006|6133799003|22082099003|4143699003|18002099003;
X-Microsoft-Antispam-Message-Info:
	bDxz9yFGwjoJn0RAmb3GE1jqkjl0Zyp+Q1PYxMrmRs+2ZrA1RCq8sc8UQO5OAYwSZxWUVZYz7h4caXz+ZuuVCmG91PylSZi7y0obkvBNeVWcQe+Ae9jopgG7P6IWXsq/LzIfmwAiOaUcPdKtIypT7BONjlSYQANnd2facUH/ZJDcOAs/mvrySivSjnq/SaflsJONLIDaLHpQBrlu1Eiz1YFXb3i1MzS0B7eIUuDP3UoBPKz8KewGWAaw6tL9/F9pEROZjw79LQi+O1Q1URJqImLyI0SKCaFqwStxSwMOWwKIX4L8aWqOdM87xf6EyKVSInvg8O5hGvB3bfD0mTNevMPNdVHjnm96sE5PpGG5C9HqdXdMv1sE8mgGWedTR7RgSVfC1NlF4ZG3Al4l2tAwBwx5MSmxwQ9KJ4iNk48agPKb1H0vZaZUL5CCXx8TLv/xGfq4q+Hcg2JoacPNb1Ppd5xvrpj+MlMUA01lLMMEUv5DZC4KlowuciAeR1+g6mw/9OkQopwYRi30OIzIBVvXyA9o2Y2TOGpvpGIFo8QBOztmPplER54v39qbNRIAN8eqcWI0e2LSNqo2F744j8cnV+Cx/qpU8Up+UCRAGLwqkPp2CceThz+zond8YBzjru6y5Zjwyn1VqnNIN7RpsYro7+UiRCT2CF/AJOhzG6lxbJf/R3Qg8fC91P3qhx/pTrbTSqv9GGh89NNpc3D2+wi+Sg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(23010399003)(7416014)(376014)(1800799024)(36860700016)(11063799006)(10067099003)(56012099006)(6133799003)(22082099003)(4143699003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	k2xrJW3QqDsnltYje1YGRGmX0cMLlc3eo8fJ2lHJYiTu5v3Ds/DVRmc1zHv0r/sU/oJCCEBj+3blKf4bkHUxnxLTpA7nueHEG725kmn82nxQu8Hq2SJfXXs168PpfMnRm5ViZ7F76if4jxhSFRFeoAEEtnr24j2ZQfdMrlt2w1sev+SBvdeep+UHeiwT0CEE0gMr2zZAQjT7nF8NO5EvwZkqrnVaZaOdugiqqpA1/YKykYN4kBzYYAtHxh3NGWn6dxroffyqydcjGur43l9/f6C0C+sQA3p3nrXmXCxT/vqML3RrHzRb+iInkK2iwJ4wVN0kB+G7+8SwWNHpvMZqlKzElGj6//LLrudZfhrE37YeiTg1p61vMBZfgR+IymlhQqz0JTx2hpGLVPRUPpMiWgB7fsDfXTsS3qOtIXzZqMtjuTJmEFpYl6NAMRqY11xV
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 18:03:52.9217
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 23d0559a-662a-498c-2550-08df1fe65a7e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF0000A802.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR12MB9804

On Thu, Oct 01, 2026 at 05:40:41AM +0000, Pranjal Shrivastava wrote:
> On Wed, Sep 30, 2026 at 01:33:58PM -0700, Nicolin Chen wrote:
> > We may get away from the TLB maintenance. But ATC can be the case
> > broken by the stop flag?
> > 
> 
> Not really, I guess Sashiko missed the comment in a later patch. This
> was discussed with Jason in v9 [1].
> 
> The key thing is that ATC_INVs can't be issued by the time we set this
> flag anyway.. if we're in the suspend callback, the PCIe EP is already
> suspended, so none of the ATC invalidation TLPs would be responded to.

Okay.

> I'd addressed this in the RPM patch with a comment right above this check:
> 
>          * Note that eliding ATC invalidations (CMDQ_OP_ATC_INV) is safe
>          * because client PCIe endpoints are guaranteed to be suspended
>          * (via device links) before the SMMU is suspended. With the PCIe
>          * links in a low-power state, no new TLPs can be transmitted.
>          * It is strictly the responsibility of the client/endpoint driver
>          * to quiesce DMA and ensure that the ATC state is cleared across
>          * power state transitions.
> 
> i.e. we only start eliding once *all* consumers are RPM suspended, so
> the "endpoint in D0" scenario can't happen.. and a suspended PCIe
> function shouldn't be issuing translated requests anyway.

Maybe move it to this PATCH-11?

> So we can't issue ATC_INVs during suspend (the EP is already down), nor
> during resume (the SMMU resumes *before* the EP is made active). The EP
> can't use its ATC while suspended, and if it loses power/resets on the
> way back to D0 (from D3cold, or D3hot with No_Soft_Reset=0), it comes 
> back with an empty ATC.. same assumption the PCI reset path makes today
> (pci_dev_reset_iommu_prepare()).

In that case, would the STOP flag be too late? It's only set in
the middle of the SMMU suspend. So, an ATC command (via doamin
invalidation) might be issued prior to the Point of Commitment,
which will be timed out due to the unresponding EP?

Nicolin
