Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012005.outbound.protection.outlook.com [40.107.200.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2454B3515DC;
	Wed, 30 Sep 2026 18:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790793312; cv=fail; b=qPWb1/rpbcj4b7aW2sVNX34hG/1qW9pCWHQuXBUTjyjLfciKfHsisQwOJmUgF0ya5xkYDfnMPf4/8c3imh07ljAZMkqQItT9BQUY8gEiVtrvD6sONJ9GCzKUHlSFp2vifTyKsNCc57kcK/Oe5am3Kj1orKjuxn38VzgQ9aen0dI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790793312; c=relaxed/simple;
	bh=3FELcXpAOQAQG5WqRAseygPwAnkxbHAYd2ba7GX9EEI=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h52iRAQA05wllsncuP2ujrHZLbRTMUBmJR54IAZ4wY0R1chJGeQJIyfOKf2d1lNeLjMCrmVV6+YHBmO2Ju1p7yCWy06zH+apEPF6aWXkOQhgf+vtSv3loR3PpOSWa49vKpjkRhCTLfXJV4ePiBnaaCNZRGrm9ut+lPRt0ybfGcQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IJSsegQ/; arc=fail smtp.client-ip=40.107.200.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IJSsegQ/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tn7PxAo1Wlno+9w+dRsQRCGPbiIcPvEmcWRDGddg+yQdz3ksm4CUbZkiR5tCBqnSM6dBO4CLCnHV82XJQFZI6O5v/1LEZJUKBa1YTniZ0iOJq7XIJ7kMhP78wRyUKzlsuGDLNj8AZmUS7iM9F81zJT8NCxGv45GYHHwYH1NaqegcnyXpLsT0O0bHIY48yBoo/Fh9UxT63eSPyktYUyrKkt7EY1nAtrua7PixjR5bKyzzqSjg0tvCBYMh2vkNdYKtBgpcpmjGUTovkTcCkudLWtqYf6sEuXBP1ELTBR7F8LhduMjohkzVJuDhEOjidPQvhTcPW4NYVqdeXouCJ5d7Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SlRd1Bcy9vxTTkb5QgIwUNkzFq17T19uqVQCG9qaZYU=;
 b=WBXBtsW+1XTi+JMi/Ln0nMhtgUI1y6g85GUyzOb7qsAwxkpoJDfbgJ2RCW0Y5UeRPJ2CKYscGkawXKjsWZmygeZPGHhjoz7qTX0E60iyrI6KjiqdV7yQGX0TkWU3Gh52dbg4nT5l4n9e2vqWJxu1am/FKxh9gYJHT18rQ3T7/WEw6KDgzoNCmzqbkMUPjtLbolJQb/6lVgnqWYo5BNicqscnHpOSM/SOW7EEkklitRvFPFDwjWKp0qXswmo29gY5nAph7DLV3JIm6ziA+n1lyggDAXeJoun6UWbOwb36Bz/CSX6Jp4VfAndml9bIZdvIwlgRJey64lAnAMy8GiPTdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SlRd1Bcy9vxTTkb5QgIwUNkzFq17T19uqVQCG9qaZYU=;
 b=IJSsegQ/ESrp8WGVq0aU78n89n4TAIsybZMkEa6igvuiXUtKq4rRU5Qqsmt67ugpiW7d+7ldlLO48teuXzOrt5N2tMy9zGkHDopHzZaiqI1WrzGQ1Sz0MpZ5yHclgMSmbT84G3nDB2QA+ZUBsyZ+mZL1vT3IzBQGBrYicfGX+oi1/cS7p/Uyq7v6/HBImZ5Kgxm7mxXzpSfSgrzbTbwrR8MsrSvNvVrC3aM999y5IOgP0ANyAG2KqGUacYfntFpUUndalj+KvCSQu8twEKC8HhpjkEKjs+iNCV9r+dWQ3mXNkkWu48SdFc7YHTTmMKVDR+COPjJM2NoZja83R9GwGA==
Received: from SA9P223CA0011.NAMP223.PROD.OUTLOOK.COM (2603:10b6:806:26::16)
 by PH0PR12MB5646.namprd12.prod.outlook.com (2603:10b6:510:143::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Wed, 30 Sep
 2026 18:35:06 +0000
Received: from SA2PEPF00003F62.namprd04.prod.outlook.com
 (2603:10b6:806:26:cafe::32) by SA9P223CA0011.outlook.office365.com
 (2603:10b6:806:26::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.14 via Frontend Transport; Wed,
 30 Sep 2026 18:35:06 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.118.232) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SA2PEPF00003F62.mail.protection.outlook.com (10.167.248.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Wed, 30 Sep 2026 18:35:06 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 30 Sep
 2026 11:34:45 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 30 Sep 2026 11:34:45 -0700
Received: from nvidia.com (10.127.8.11) by mail.nvidia.com (10.126.190.182)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49 via Frontend
 Transport; Wed, 30 Sep 2026 11:34:43 -0700
Date: Wed, 30 Sep 2026 11:34:40 -0700
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
 Krummrich" <dakr@kernel.org>, <driver-core@lists.linux.dev>, Jason Gunthorpe
	<jgg@nvidia.com>
Subject: Re: [PATCH v11 10/16] iommu/arm-smmu-v3: Factor out
 arm_smmu_handle_gerror()
Message-ID: <ar1WQCud+B3nAWX6@nvidia.com>
References: <20260929034510.2023173-1-praan@google.com>
 <20260929034510.2023173-11-praan@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260929034510.2023173-11-praan@google.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F62:EE_|PH0PR12MB5646:EE_
X-MS-Office365-Filtering-Correlation-Id: e3fd57bb-6391-4b26-3000-08df1f218ccc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|23010399003|82310400026|7416014|36860700016|22082099003|56012099006|6133799003|10067099003|4143699003|5023799004|11063799006|260925021911599003|260925022911599003|260925021311599003|18002099003;
X-Microsoft-Antispam-Message-Info:
	fMfsAwTidc4ri2g30F2yb/pn1osjVuwj2HZMhcjdI6Fxs+z143u8rT7JE55GjC/QwTkIVE6KpQGlP9cTcuHn9sszj2/6kiUvYMGugOSE+RmVC3xIzgS+VhBSXNb0SGigap/tlP784yAog3JGqJGE8Aqn1dJMJNNczlEZatd50GaHkAxLtWUX5sXRDkvGDnW4nCY8Rlr7688Om2Faqh2knwcayLW0g95TC2KS2MctWFNAbzb9NIWJe1mPMp71fYIYvRrU33x46+QVRArSjO+NUX9OOtxHondbJbg/zU5uNjCQmGdjhhAMdsbKS6wvLRikjRVvpyEXpW5Z8nRUqiGPzPnrfNEC1T3IbEJvuooWCooFZQvxrrAFNpooYpK+KTfBhQQ1+5+meU3inmispeGqx756xka/VUxFLtBp8EEF8UeqkBHdiXqrOS3e1FCzQr3CDh7oeFQZCJxU9rnurlEMKUYVEjyYehAn6ItdWC/YIWNTJr9ZgCyJ/yeStuxjgGbZwnEAwfvwvj1/edPIhfrJxubrAOnUVkHC1pdACgmywB8Ngn1fB/UfFlphl+nFMb8Tp7bhga22l/6RjaoGrqEFXda+lr+T9/VAaHoH0aBsTA9Sm7ZWOXfbQG+dj43MRRw566kg5Q3G7AoQwQI2OmDZM5HRxNdeNBqgSibIvgfZi2xImN1z/Lq9URhKSi0ZaW3wg/DgMC57AdPnC3XNMX4WuQ==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(82310400026)(7416014)(36860700016)(22082099003)(56012099006)(6133799003)(10067099003)(4143699003)(5023799004)(11063799006)(260925021911599003)(260925022911599003)(260925021311599003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Tzlcnke9GIpEFY+P46rE/H1JhJClGmvbOCrClNDfdbT+Z2+LabV7PtV6s1hXuqcZbi2uk30Fs9xyD7OaDa1qaJZz4njd6kzPCcMTZ2yGpmd0C3fFdItskicZTM3tpDvYQpzlGX04QKyii1Z3edLl/KJXBEkUzcbrsy4/WavAgw8nzh9W8ksFkqGW9yr1o0S/8bazpJDcOmF91o1PPymNHnRQ4N1uWBugZyNhBYbgke7t7rxBNZVLW29tMXjNqyDC8zJUCNcsZZwB8EkztDm3tFxlGxQE9FcrvxDdOiBIPehbYYUIDxbbdfmB2nujo4c+aOisLcECoa28cj3I8p/DsfGzWPNmy5Cyho7JbD4KzPepuEXtcNfbj0TbaAaeMF0iTcyPK3Ss/0GKuTxCD/VVpIvnWo7Myy0JbwBn2LSaTf5D2hol9M+KIPkjwt3RDI+3
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 18:35:06.5044
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e3fd57bb-6391-4b26-3000-08df1f218ccc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F62.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5646

On Tue, Sep 29, 2026 at 03:45:04AM +0000, Pranjal Shrivastava wrote:
> The GERROR register's state might be lost when the SMMU is powered down
> during runtime suspend, requiring the suspend sequence to handle any
> pending errors before the hardware state is lost.
> 
> Refactor the gerror handling logic into a helper function. Subsequent
> patches will invoke it from the runtime suspend callback after disabling
> the SMMU, ensuring that any late-breaking gerrors are logged and ack'ed
> before the hardware state is lost.

CMDQV has a separate IRQ, so I think it likely needs a counterpart.

I have a similar patch in one of my series:
https://lore.kernel.org/linux-iommu/16ae24cc2a002802b990afa1a69fe4ceab1e0da2.1790188510.git.nicolinc@nvidia.com/

Mine only handles CMDQ error though..

Nicolin
