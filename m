Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.66
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793819060;
	b=yIFf6l/udEVWqdf2D9NjVr0dG8fALGQ86NsCCAsEr/zEYesJRBZGvVGzVDJx22SDDIwR
	 cS/J4Lcr41PqXjxR1ExtxubbdPc0cH6HNjRcGd/sJqRjZhuLhO/pffQockT1XvQGobElM
	 lhwdB19QF2E6T4LPvMMxItaupoKBGZJXnNd4Jk4HBSzJEEXt9Cb/U15ICLFnEhnK/IjF8
	 wL6QKXcnW2+I3Z+zvNVToay5HZ/4ttEw7yUNnyqZ6l5JYnYL/PCn1yKTB3wDPGVi4XrLy
	 OAHmiG+OLPUiYgM+ryU4unJGT1Xq8yVliNECkhSrzTrijrbbIHBIPmFmlBRsh+etwyg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793819060;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:Date:From:To:CC:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-NV-OnPremToCloud:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
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
	bh=iYrdklKNnLC0CaKMc2+j29XmaGNeAqOsHG98T+Cel6w=;
	b=4GBCnXO0V6SNuWg+ivBGlEDwklmFHZPTXd7QTT4NA/W8+jD2/FReRobGI3ZZP6OxV1Lm
	 tSMJ5KXnjBAXvIYRAB8kvA4otYwSH82pNC3RCI54vvxfzV510AkhdfZ5Vu77dfXTBxg6V
	 Wrll/LA1f96WB+DrTIfUmnTokS2uc9m26ORJmWDKtaq7eXEtiVYqQ2dRIL2UeQCQtwmdp
	 NqoRXVplb/wB6xktNlZJdwrDwf9Bw4a9MDT0kNAt3eWhUuwzaaMiWuxfHLpvnfAldSqNt
	 Sw4F8eHTiJbPWCaU9HAjy3WjPejo0ohBsm5kUDGu0fMYSeJM7P76i23nhPAwLn8wzCg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=uLUhRyEE;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.66
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010066.outbound.protection.outlook.com [40.93.198.66])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF74606A31B;
	Wed,  4 Nov 2026 19:04:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EAF74606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=uLUhRyEE
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p5IAAwFAb9DEv+LrieosoQYFTTOX+Kfb1r/5cMcJwp608npS4a0PKcZzPjy8ltJp4NV4cPSt1Q+0XAA1NMbL+WaUavD6sHvGpyca8nN320PISaVoXG4Tq83MFsygRl1xRWfDBpFMl6UuhHapYeQw2EOAjB5UFg2SkIj4Y/fPU4+5FOp2S0fZCAbVQ/DRZOUs+0X8K0C/Xfn0ox7SFAbunT1g5LDvLETVeGPDdd8UqDcR3MMry8//+jXNU7BLKaNTwrMJUByly7WgnUKIGfk4bzasrLhFEraA3R0LMUsZiLDAC55RWgd6LeqG8P/6SuQ7NTIH511gADU9lNRlw7iksw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iYrdklKNnLC0CaKMc2+j29XmaGNeAqOsHG98T+Cel6w=;
 b=ydGiWHy4B8QPI9y5Wgwz6ZjroePayqcEKQ/CkKQaz80xnt33kdIZ1n4YLkf7rHp19KWVJjYDpzgOeDqOGPXunZnZH9hH68oXjLuuJma8jID/vluTlve0i48CJ8YRYl/9lpR70GmhVWcr8Rtf8Hvv+N4Gw1kUjTytNA8F1pQvgPCI7OYMl60UO2dgDAL5IfEMj09nEuRiQ8FNJ4uK2kUO/e91BRyyDbx0MRdtS4Hc+DpSAyXI1OH7a6sCQVbAv5iJTgwHb9n8KQ/FdKe7+3fhNiJHqX/2p2BYrMHJ52MNkNcRJVpmgZ6V7zBS3zKweZQgHfP8R3AhEipZQOQQxJqQqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iYrdklKNnLC0CaKMc2+j29XmaGNeAqOsHG98T+Cel6w=;
 b=uLUhRyEE0IXGOTJEPmIPmJU1SRTk3WSy8sBsvDCx5m48LOnOeOEfm4u7amRaHA/kudJwAPvOoD8Os67NPBQjcbzPyO0FnpIiwyDVt5x8s8jC2NJpbokTB/vgRwuW2RPUAljn/QJRAF5QxMpgS1uKzICQsAYrj08hMlu8gPrg2hkRP1Vo453VL+Nd/IXPi/ZFzKYupnIqcPzenUdVsKINdeTvBMrArVcXqbUSSWn2/RmCh9xWhQnoH23rxyyMFQdavWeLtVU1n+oqlLfVqBw0U/QNXpoFrK0ppsKofATQoow/HNTpA3DtugVXOD9s6C/y0rM67b6/lmK2mR4FA+k6UQ==
Received: from CH2PR04CA0006.namprd04.prod.outlook.com (2603:10b6:610:52::16)
 by PH7PR12MB8124.namprd12.prod.outlook.com (2603:10b6:510:2ba::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Wed, 4 Nov
 2026 19:04:13 +0000
Received: from CH01EPF000BE94D.namprd02.prod.outlook.com
 (2603:10b6:610:52:cafe::a7) by CH2PR04CA0006.outlook.office365.com
 (2603:10b6:610:52::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Wed, 4
 Nov 2026 19:04:12 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH01EPF000BE94D.mail.protection.outlook.com (10.167.244.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Wed, 4 Nov 2026 19:04:12 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Wed, 4 Nov
 2026 11:03:49 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Wed, 4 Nov
 2026 11:03:49 -0800
Received: from nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56 via Frontend
 Transport; Wed, 4 Nov 2026 11:03:44 -0800
Date: Wed, 4 Nov 2026 11:03:41 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
CC: <iommu@lists.linux.dev>, Alex Williamson <alex@shazbot.org>, "Alexey
 Kardashevskiy" <aik@amd.com>, Bjorn Helgaas <bhelgaas@google.com>, "Catalin
 Marinas" <catalin.marinas@arm.com>, Jacob Pan
	<jacob.pan@linux.microsoft.com>, Jason Gunthorpe <jgg@ziepe.ca>, Joerg Roedel
	<joro@8bytes.org>, "Jonathan Cameron" <jic23@kernel.org>, Jonathan Hunter
	<jonathanh@nvidia.com>, "Kevin Tian" <kevin.tian@intel.com>, Krishna Reddy
	<vdumpa@nvidia.com>, Lukas Wunner <lukas@wunner.de>, Robin Murphy
	<robin.murphy@arm.com>, Samuel Ortiz <sameo@rivosinc.com>, Shameer Kolothum
	<shameerali.kolothum.thodi@huawei.com>, Steven Price <steven.price@arm.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, Suzuki K Poulose
	<suzuki.poulose@arm.com>, Thierry Reding <thierry.reding@kernel.org>, "Vasant
 Hegde" <vasant.hegde@amd.com>, Will Deacon <will@kernel.org>, Xu Yilun
	<yilun.xu@linux.intel.com>, <kvm@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-coco@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
	<skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v8 13/15] iommufd/viommu: Allow vIOMMUs without a parent
 HWPT
Message-ID: <auuBjRjQwXl7UvvO@nvidia.com>
References: <20261104161632.3547423-1-aneesh.kumar@kernel.org>
 <20261104161632.3547423-14-aneesh.kumar@kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261104161632.3547423-14-aneesh.kumar@kernel.org>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH01EPF000BE94D:EE_|PH7PR12MB8124:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b146ec5-1378-47df-7523-08df3aa669d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|7416014|36860700016|82310400026|18002099003|22082099003|4143699003|11063799006|56012099006|261021135927099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	r2Ua3Q+2Tif3KwEI/FOhVtNcbyiuz6thtfs9vwRLmbYE1ZLVIh49hRphKWUPCiKk0+wIbwaIW7ujQSwfUKmZsDL3Zp+JFNR1O8GKPgH4vFhCloYNFzWST35bcBcy2gBUHDNVW9LHgevNZxB8a2MOiSSPDkJiuOEpduQ2ufc8t5m3Vy70OMzXUhBiJH3r1HG4cQ3PqPO14T92h/YLi055Pf2d9d+jjtT9yTwgorZHkHX/fIQoMGmVtdbZNQVv6b7UpgpqOQKsc+RudqnQgiMs197FEVCnksljDTcEKqrpN2co4Yo0DTRx5uK/kzS5AxmpQmxmzAjud5Vwfkz5/tCkviw9RrkIjMH3X1P5u4lLTR7H150egE9PS7u07uiJSW+kS0hzLNSBfblIn4nOHXFpVhKw2rwiq37fn29Psw8r16VlNjd7hABTWaD0TWqrI2HrUw+CQXr+G4dPYnjoVC5TvOlE9d/By7WwBvCq8lXYPEYZp8c/CrlxboKcikAtdWKCcWG6rQjdd68ktM+s6iZeyTbgbm2Wvygs6yRHSQtDUycQ3QwYknJxB+UMHOLkLR9rIk6M0qx7eV9VZcK/iBDhMQB6leyKuE/GSEKrpoG9mKhbNig0hjGTgK7IwbaGl/9BUKzT8LdsneTdmH358gMWJXWVSiopdHQAiw2/4bvAjcI8PZfiuMV0SssMk2OTyN2Quagu+fIO0muRhXI2GFrIqA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(7416014)(36860700016)(82310400026)(18002099003)(22082099003)(4143699003)(11063799006)(56012099006)(261021135927099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	N0ltwa1yXlZ9KAYHSJXEsDWdLJuQ0Eax9EBMOGnjIVBBjrJXrOz+Ljhw+Y09Y/Uu/+U/K5y2B3RWHF3V3aoyqFtk9uuCBWcAsHX1XKqm8VwbA9gbPl32F9ZPSIW/5uDjhlB4zp88C4AE8wDiKD9td6O84uYcnPavBUuUfVdr7vIM8yEspk7+GTgJA+OlxsxW+8dD367hCt1SS+sUHO1yzf8DFF6KpQy/qOsOY3PxdIqOlpxgSRWZUVChwjAE8FE16vB+fHUvokZ6ykp0W/VmooN+wbqzVLMquEeB/cZpTHTorgFE17OVFmqxt0drnoguubtHnRN5wDuRDw5SWzKDW2Z1UZbjju+9LzmUXAdEBX+jcRi5lusRVMvQcP/mAHKdzWFOXLQYZZCUQXTT1hWHCBwVz6JX//rY4ZOhuEYXJrXB3aMT0yKDghz0ylyx/2Vv
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 19:04:12.2941
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b146ec5-1378-47df-7523-08df3aa669d0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH01EPF000BE94D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8124

On Wed, Nov 04, 2026 at 09:46:30PM +0530, Aneesh Kumar K.V (Arm) wrote:
> VIOMMU_ALLOC currently requires a nesting parent HWPT_PAGING even when
> the selected vIOMMU implementation has no use for one. This would force
> implementations such as the following Arm Realm vIOMMU to create an
> unused parent.

IIRC, MSI on ARM still goes through the NS pathway. So, it wouldn't
be "unused" if the device attaches to it (or its nested hwpts)?

By dropping the nesting parent from VIOMMU, it just simplifies the
attachment to an S1 paging hwpt, right?

Nicolin
