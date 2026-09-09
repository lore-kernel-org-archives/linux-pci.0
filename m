Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012026.outbound.protection.outlook.com [52.101.53.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A9E93A1693;
	Wed,  9 Sep 2026 19:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788981032; cv=fail; b=pMQ8TQml3lYVdEV90kebX+qKwcqoJ5ZT/pLHPESYz5IhFe9QOtQu7XB7CnEgNfMn4P5G3rhWXo5k+58rNXCwhjZHiznJLuO2qUAqDH15cQVT3AwwIzRxBRvCozWm4UZU41dvba5I9Im/KdsOVS+qvpF8CWKN/SEF8AF+dmXOt+w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788981032; c=relaxed/simple;
	bh=OLUoddHzZacaxXM8zKMit9wr6DysgBpSPLxzmmGyZRs=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lgcCMjr+nSr6Ih+NT8hvCxSat7uJJGq9TBB58z/CLUMc4ppdKZb+8ms8h9zx1CkU3tV5nopNPtvz+zogZ3UTKDtY/6r8GD/ltR3Qv2k6DA6CGHmdUU7QRxRVh6GtYtxfx3eo8mms7x20KZRQK1dDLTspIhhv2WuIv5O7gvbxFTk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Bkae94i6; arc=fail smtp.client-ip=52.101.53.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Bkae94i6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cl7MbPA09dql/Z5TGf5myO+Fy5xv3lClT99ar4X3yjMXdtQpdhWwXZeK4LTyQ57DrA/QDg4MJuf31ICpFZljX5mAV3wpxCml/CAH4EYZ3axN3zLx6DYlpP1UpW64+15zUZMrvMpyB3G4lPltgArMVU7Vg+YJPbA81yrBUOkRu7vqU7BnSSvD9DLqTdoI9gIh69RfDKnVVoc9fNm4LbeiB5oJNcehbPn/F3XIcnH2Rrp/yqHHbYigZBxiIyzmqtpDy54JzeG9LlAKD1D4IJumLGzOAQwgMz1HFHWcA7Vb831bVe9+HhSd8xrksQmZg/Y/vh5LvyQslhR5IfKc6oxiww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pcZnHwB1W3ZUEkbQQjayOkjiHiWUbiS/AtsmjzVtaMo=;
 b=ZbqIzqY2Jpm/Qepul23waihKmqwK+sSndljnqosaoSqKd1wqnuAbZ3auQpEnTIyxT0A9Pt5tnJvsoMG+R5ti6+KLsUSjF4VfyYXqYtfJ5lX/cpJGiee4cbGHTyAol0LZHT41SmpSkbKdklOs+/DgrwiR7qg+gNA1T5aYkBGIOCbSpX3VIIHU5075H41pO70MFAY2GdZaX5BNlTFK/JYnMcQEjmEdvbvvR4ge1xQTGLZ+lqHKHskPkv/BSgdAdCGIVqWOuwO72GEjOECYqo/RPH6tSiyHSEyAjrwch0l8ttuOtE+NCYJJxuMhwl8b+e3EKJj8yw3hxmEh/0Jm4fEUvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=oss.qualcomm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pcZnHwB1W3ZUEkbQQjayOkjiHiWUbiS/AtsmjzVtaMo=;
 b=Bkae94i6N2nfMIkbfZHgN9nDX4nFOh6Cy6z8VmPeojeNB8FT7AMRYbXKNXQDK+2Inw6kK6GiYoysdvveeo10Di28YR6hvYFm1Ya2K3my4qmRNVXBb7GCFnfd86m6WhI7GnBoeW++QYT6TBhijqsxxYxzXD8wYFhYzVKyMdYIwk+6euAcOTK3LjYpvW3LFGjx5O006Fpi4wjJLiXRFadZ3cSU3CsSP3ZV8g4AsLYbpUREL8C7egFqHFwR87Y5HLHEU3jx7f+MBEWIa/hwafIGT5Fdw7QazgNOiKM3lMGS6HezXo16oMe77/D22oYwfecV0SQXGDtJTPwgbBTbM1CACQ==
Received: from BN0PR08CA0021.namprd08.prod.outlook.com (2603:10b6:408:142::16)
 by SA0PR12MB4349.namprd12.prod.outlook.com (2603:10b6:806:98::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.8; Wed, 9 Sep 2026
 19:10:25 +0000
Received: from BN5PEPF00046989.namprd02.prod.outlook.com
 (2603:10b6:408:142:cafe::36) by BN0PR08CA0021.outlook.office365.com
 (2603:10b6:408:142::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.15 via Frontend Transport; Wed, 9
 Sep 2026 19:10:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN5PEPF00046989.mail.protection.outlook.com (10.167.245.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Wed, 9 Sep 2026 19:10:24 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 9 Sep
 2026 12:09:45 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 9 Sep
 2026 12:09:45 -0700
Received: from nvidia.com (10.127.8.13) by mail.nvidia.com (10.129.68.7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46 via Frontend
 Transport; Wed, 9 Sep 2026 12:09:41 -0700
Date: Wed, 9 Sep 2026 12:09:39 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
CC: <will@kernel.org>, <robin.murphy@arm.com>, <jgg@nvidia.com>,
	<joro@8bytes.org>, <bhelgaas@google.com>, <praan@google.com>,
	<kevin.tian@intel.com>, <kees@kernel.org>, <smostafa@google.com>,
	<baolu.lu@linux.intel.com>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <skaestle@nvidia.com>, <mmarrid@nvidia.com>,
	<skolothumtho@nvidia.com>, <bbiber@nvidia.com>, <harsha.v@oss.qualcomm.com>
Subject: Re: [PATCH v3 09/13] iommu/arm-smmu-v3: Support PRI Page Request in
 arm_smmu_handle_ppr()
Message-ID: <aqGu8wUxN7I/feAg@nvidia.com>
References: <cover.1788222485.git.nicolinc@nvidia.com>
 <0fe5f381aae307045e4cab97f8000c575f34a9ee.1788222486.git.nicolinc@nvidia.com>
 <178846311318.1308030.15663048615954357081.b4-review@b4>
 <apujyBWK+COCa3Ts@nvidia.com>
 <20260909110150.00007bac@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260909110150.00007bac@oss.qualcomm.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN5PEPF00046989:EE_|SA0PR12MB4349:EE_
X-MS-Office365-Filtering-Correlation-Id: 698ff90e-381c-42c2-36ef-08df0ea600d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|7416014|376014|82310400026|1800799024|4143699003|11063799006|10067099003|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	cAjkeDGubmnk5abvCQUpsLB85OoqyzFlXzudruYCu3YTXMemHa895CXC9uM0R2HuXhrUTB4EjR5gxCIZjbZ11uMnzJauhYTLEobrTmRmAY4ehwQxD40rhEacHbSq2p4KSdPc3DN7+ubBPrKsJekaRFWyzQoezyfYSrrgSxsV94TAZMa1F8N/kobcmPSzZ1nULh6dslZATQeWLKOs1N/4mhsPvk/dSEqze6ZRPctcP3HBTPB66ocq/PECY1LtH/OsL+GiwtuoRLwrQ3qxH73u1srsszgl0m6UHSrmNtO20UpBirgYrB3StFXq5LiZqnYdx+umDd7WJOfs70wwRcxTiSqLMDl11ifWwnFrovzwDVtuvPHCx6cvhmJ2NywNYaNAWgI5t6bXFZWv6iSYGP/4kBrEZPLj43dLMhZwH+HbG4iguMhr1UTWJP28CMtmKXNs7ORDP/7zCcMNvsJlEvxc8fbuC9ISxYNY1ZdMaHNsYTiFEmRDKmwX6duCP8jJQlWF7AvSIzcYXFPV5sUuSwQ2D2WaUprd8mSdtLPnid4S9KIUVQdbZoNnUH80laF/Er65zYwJRW+U2nBgv/6TIgpqiPseY7Fnmdb1OoF32kPKJlJRzLOOvOE0A8xUe/Q+2CzfGWIM8kAbj1ltibM8Usy2Io4p1+W4wVNXfogiCDKwfyMs6kVHDzG+6XdWeqhjgM30M3AkDCuy9KnJyP8bbP3OhA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(7416014)(376014)(82310400026)(1800799024)(4143699003)(11063799006)(10067099003)(22082099003)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	hZ5EPMFIJVZRnkpYADqpVcYJ4MgtHvRhIcv9ciJGnBzdl6cWmRTa1yNRIBs1mrIBB/LzdaybdWig8nET5CcoK7ovsX3/j9oS/zg/eitPNHmSVQEejfFd16if3FVwrVQ8F/tI2cHXBChl4FMsv/7wh5huXaZymSLzFAuKsB5TJisu1xZnvE7CPKjTFDN/C4SMeOphBCyuakhfrwQOo+/VgI606s2rjf0g/NaUMhIrmqSyZnKj/2uKGT0SYUIuUtLjJeZz7rwZmpEzmSg8WVB5vt2VuTnqK/AIOZZNc5+PEDtmX1K+WSC3EYu+AyyoWotERzv0ISUGLFT4zWOBGaG5uRq7jpGA7dQsh1LtKKJvKGj3v85M2Ss5z+DybdRg2D5BsWhT9VVj5sJLJfSZY/x6pa5ph8IsYOoeTNTSUEp5yk3DRXJhgitRXOsD32oynyq5
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2026 19:10:24.9520
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 698ff90e-381c-42c2-36ef-08df0ea600d7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN5PEPF00046989.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4349

On Wed, Sep 09, 2026 at 11:01:50AM -0700, Jonathan Cameron wrote:
> On Fri, 4 Sep 2026 22:08:24 -0700
> Nicolin Chen <nicolinc@nvidia.com> wrote:
> > On Thu, Sep 03, 2026 at 12:18:33PM -0700, Jonathan Cameron wrote:
> > > Kind of a general comment.  I'm guessing AI assisted heavily in these.
> > > Whilst I haven't found much that definitely doesn't belong in a patch
> > > description, they do end up rather more verbose than ideal.  Maybe
> > > poke it to be more terse in English language choices at least?  
> > 
> > Well, some of the paragraphs in the commit messages turned out to be
> > indeed verbose, compared to my original writings. One of the reasons
> > was to justify against Sashiko that often nitpicks on a corner case,
> > (which surprisingly works well).
> 
> *groan*  I understand that works and I guess this is the life we live in
> now, but I wish it didn't give me more to read! :)

I can try shrinking some of the writings. But, I do recall clearly
that some of the verbose notes and side were exclusively added for
that reason.

Nicolin
