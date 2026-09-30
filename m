Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012038.outbound.protection.outlook.com [52.101.48.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF313C10B9;
	Wed, 30 Sep 2026 19:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790794989; cv=fail; b=VcdrZfay4PUqRFjHe3wbb+zYw/eSOiF+Itz+C1VGhpXH7nvX1E0UzO260otm7vReY163Vn0g23fsJFc2oTvUf8/XppYMq59fCHPbKNP3NshTHd/z1hIMmSukMSHdznYT3YD3scfLfVkJsdyTx/0TvuCxlPZnFcmopGTcbSz3j3o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790794989; c=relaxed/simple;
	bh=rqm1rMaRCD2JwmG4Ri2LWsdd4th32vJGMPd0oAxl378=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EOa5IDPDeEgF0wnpH1qamcbY5FXxfavGbA16sKFInOyVL8GN89JMI34DfN6fDnUxuJVhKqccQa1cLoIF2Xpw1KtbzB3D7dbaSKyldQfwItiMnY9vY6ROKDpGmSo6LqMCnSk8Q+daApqnlm1O3+ccCjQE84I0tpMgyikpOS/uEQM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ATpPCKap; arc=fail smtp.client-ip=52.101.48.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ATpPCKap"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yz3F7CW9Zw4ugidMjOKpLVs98S9LdARWoG/503wApWnJn9q7hWwc/rjn+NHqQa1S4877w8vj1cQIBKjhAZIEa/FnFbPylA1RHguwF3194kpRxJHixtckFtLPyRK0lvnP/BCqY1pbIlCm8/Sc4CDNIBW+SIbVzp/4UVKCA8bwfkIhrppWw35mxnphcdbBUF6F8BDis0cR25S3/MZzsK798/0HPjJS9voHRLS7sc1Rs+gR6pKx3MPZ04rBk96RLcxng3fBNP7jMFa5EUG9J81cVFxOxbz+Z3PLkGHl9QRUc9pUJE1N4wPtytvSr+eTtUu2PrWBbxE2UPJPX3AkBxAE9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WE+8xu45w742WYnUoQLEOlKigni26XVAImfKl0CvHQE=;
 b=q78gkqTOC3xgnKmG7wetbVAQsM/8tAAXoOzV+2gGjuL3uCHVmHZuPYXElqieTDat42UiBpmq1OfaPDM/yFulDC5jkqPSxbEclIUTYvaKDUyZpZiPYd5vAjcr9cOzAPvFLBlDRlduHtiL1Yd14esFQJA7jL9aYsaCnBxlqUeYSzo+tFRn3IT/O9CUkG9NEfP+bXXmi7vm/3wmP//xu2i5sAL297yORERGvpmPcwNCINFiXQzew3HGWV+PdrZ3E+mzjkwr3MNZCQscuhlWigNk6WG5apGgL8vdDCwek+fcUt8Pq7aO8Xde4weJvhUMxukq66c1cpG096uDMiqPwh3Ytg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WE+8xu45w742WYnUoQLEOlKigni26XVAImfKl0CvHQE=;
 b=ATpPCKapnmQy7naDhd2NtOpMbaTh4nYEpjDik20YogzGqj+kGi6LOi1wTV4Zs1irQLfaHgfLhle1ZySGRK2lLCXhTFl6yDpsEuAiDtRKFZgbTTtQapc5DdK0IOcD8zppq6jzaRrWIIvkkkt/A7XEeaFaLqAGDM22ETDacMe9UpTtV5tHxmtLxhetwGoqGFS3/Y9IVwCVB3qhzv9/+Qv3F9VXtiV3S4D0icZJ1WCFL7kcUs4d595l/TyWSVpjo3CtM9ikq3ZvhdCoyXOukU6+Ct8lLVy57IFZElLALuavjH3QQXhdPQrkg9c57CrZd9ZaFzzaotnMsxFhTXvEIteeZw==
Received: from CH2PR12CA0014.namprd12.prod.outlook.com (2603:10b6:610:57::24)
 by PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Wed, 30 Sep
 2026 19:03:03 +0000
Received: from CH3PEPF0000000A.namprd04.prod.outlook.com
 (2603:10b6:610:57:cafe::55) by CH2PR12CA0014.outlook.office365.com
 (2603:10b6:610:57::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.15 via Frontend Transport; Wed,
 30 Sep 2026 19:03:03 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH3PEPF0000000A.mail.protection.outlook.com (10.167.244.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Wed, 30 Sep 2026 19:03:03 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 30 Sep
 2026 12:02:32 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 30 Sep
 2026 12:02:32 -0700
Received: from nvidia.com (10.127.8.11) by mail.nvidia.com (10.129.68.6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49 via Frontend
 Transport; Wed, 30 Sep 2026 12:02:30 -0700
Date: Wed, 30 Sep 2026 12:02:28 -0700
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
Subject: Re: [PATCH v11 12/16] iommu/tegra241-cmdqv: Add a helper to quiesce
 VCMDQs
Message-ID: <ar1cxFvuzIc2dpmi@nvidia.com>
References: <20260929034510.2023173-1-praan@google.com>
 <20260929034510.2023173-13-praan@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260929034510.2023173-13-praan@google.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000A:EE_|PH7PR12MB5997:EE_
X-MS-Office365-Filtering-Correlation-Id: 23a9c063-b919-4ec9-f70d-08df1f257459
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|23010399003|82310400026|1800799024|7416014|4143699003|10067099003|3023799007|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	8tUeghEPFAwiHNIWY/urcBmyWT67Gtl8pP2YNd6dZMO0+iL6lvAognHndGniNuxE7bXdt9MQB49qIsombj6rEUdtlUQAM5OYdPIWi04e2qWgBnhlIkzVlGWYgDU2Z3KWgdURn3Vf+x0NCMfFpuHRfKJND2aoShroY1LpOQX9QlQAYWjbCF4JoglzPgmI3vlxIXBZs+uk/0CpCwIi7UNenC3yt9J/lUza+qeEXoTm3OK9UDZQ3uNr/B7uI7+AkkkenFJ8DORAeGLp3EvExDS4+2URitkLkXvIkPMeDUwKyjUXQazPNKsGxzauXFJyvbSWMFruN7iaZ5pZ/INq750EONcPTmhwG5mMmHLAMZvRMAE4Woo2KRAB9lY1u6GxYNHYRtnVOk15DFdeqscL9h7GDZ7zIX6FO4kxCZLk28NFX8c7O0vIc+MNeRwV0SuVEfjQh5jfSar4/4TQ1picWHMtn5P+lzwY233QLSAHcf2T9XWr+mV0fVlcDSsy4HYPLLEkGRAlpKG1DBaXxKyHsT9CWL1rNzhM9JFkwJc5yNybcsvu+yq7rdTTzyg29qQrxCX8ro+TYHkjHjsNYg44w8h72vc+HgoQ3prYgSuvelDGDv5FbHghJBW5b7qsznha4JfXDekpwMe0C7GK0u2h3VBnhvPsZyDvY4epcqbTPNq0stUKBG40/WQWJPeWxIhaOA0ofSMvWgNOkFmhQhJ+Z3JfzQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(376014)(23010399003)(82310400026)(1800799024)(7416014)(4143699003)(10067099003)(3023799007)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	0c9z9t7wP+/qH+SsS6U7VXeCPz4IcxJ0p9zkSkhaKilkNJZM3Zg7aXKHrCw4n7Pmof+yExo4KX+OYIYUep3mFPFqTppH99yCrjN9qDj/Gvych3lOVylSe6EeAsfPsKllqVCpxiHn6QqAnp7SlUtiLJV1PfxpQM9ozY3+YKbSmX1+ZXNFMw/IJmU7B1g3KPdhBArd18B6qqUoigcFN4nODyux67ku8oIPViLr91K95b6SAaRvOVO9fxqqXtOGrMqkhaQZtHv+O/ETuNHR6EOhiXMzK1CRBPloKrVKGGjZF8EeJxPjDuBtReKD5vSOjAk85KzkVwO61iLBy0VdTKqZg/8HkWgLojUjtv3ad7cU7CKf+djDqX/SPvFokfqZUNfyaLKBMaTg5HpzUFmk646PcDQE1rt4MUKeT8Su0SIc6b+BgXGGcbdwst6yLHeoCpXl
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 19:03:03.4691
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 23a9c063-b919-4ec9-f70d-08df1f257459
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0000000A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5997

On Tue, Sep 29, 2026 at 03:45:06AM +0000, Pranjal Shrivastava wrote:
> The tegra241-cmdqv driver supports vCMDQs which need to be quiesced using
> the STOP_FLAG. The current driver implementation only uses VINTF0 for
> vCMDQs owned by the kernel which need to be stopped. Add a helper that
> sets the CMDQ_PROD_STOP_FLAG on these vCMDQs.
> 
> Consolidate this logic by renaming the implementation hook to
> quiesce_and_drain_queues and ensuring that the tegra241-cmdqv driver
> gates all active local virtual queues before starting the drain loop.
> Additionally, clear the STOP_FLAG in tegra241_vcmdq_hw_init() as a part
> of tegra241_cmdqv_hw_reset().

This whole suspend routine is missing the CMDQV flags.

vintf->enabled and vcmdq->enabled must be cleared when the system
does suspend, via tegra241_vintf_hw_deinit(vintf0).

So, instead of quiesce_and_drain_queues, perhaps we need a suspend
callback that:
 - set stop flags to all lvcmdqs
 - wait for all lvcmdqs being drained
 - hw_deinit vintf0 and its lvcmdqs

> @@ -566,7 +632,6 @@ static int tegra241_vcmdq_hw_init(struct tegra241_vcmdq *vcmdq)
>  
>  	/* Configure and enable VCMDQ */
>  	writeq_relaxed(vcmdq->cmdq.q.q_base, REG_VCMDQ_PAGE1(vcmdq, BASE));
> -
>  	/*
>  	 * HW Registers reset to 0 when power-cycled. Restore them from their
>  	 * SW copies to prevent executing stale/ghost commands after resume.

Meaningless line removal.

Nicolin
